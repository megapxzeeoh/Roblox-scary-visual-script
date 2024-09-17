-- Roblox Script to play loud music, change sky to a specific asset, and show random images from GitHub
-- The script is visible only to the person who executed it

local player = game.Players.LocalPlayer  -- Get the local player

-- Function to stop and distort all other sounds in the game
local function stopAndDistortSounds()
    for _, object in pairs(game.Workspace:GetDescendants()) do
        if object:IsA("Sound") then
            -- Distort sound by modifying playback properties
            object.Volume = 0.1  -- Lowering volume of existing sounds to avoid interference
            object.Pitch = 2.0   -- Distorting the pitch
            object:Play()
        end
    end
end

-- Function to set sky to a specific asset
local function setSky()
    -- Get the Lighting service
    local lighting = game:GetService("Lighting")

    -- Remove any existing Sky instances
    for _, obj in pairs(lighting:GetChildren()) do
        if obj:IsA("Sky") then
            obj:Destroy()
        end
    end

    -- Create a new Sky instance and set it to the scary sky asset
    local sky = Instance.new("Sky")
    sky.SkyboxBk = "rbxassetid://8808550143"
    sky.SkyboxDn = "rbxassetid://8808550143"
    sky.SkyboxFt = "rbxassetid://8808550143"
    sky.SkyboxLf = "rbxassetid://8808550143"
    sky.SkyboxRt = "rbxassetid://8808550143"
    sky.SkyboxUp = "rbxassetid://8808550143"
    sky.Parent = lighting

    -- Set the ambient and outdoor ambient lighting to dark
    lighting.Ambient = Color3.fromRGB(0, 0, 0)
    lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    lighting.Brightness = 0
    lighting.FogColor = Color3.fromRGB(0, 0, 0)
    lighting.FogEnd = 0
    lighting.FogStart = 0
end

-- Function to play and loop the music very loudly
local function playLoudMusic()
    -- Create a new Sound instance
    local sound = Instance.new("Sound")

    -- Set the Sound ID to the ID of the desired track
    sound.SoundId = "rbxassetid://1835337424"

    -- Set the volume level to maximum (10.0)
    sound.Volume = 10.0  -- Set volume to maximum, Roblox allows up to 10.0

    -- Set the playback to loop
    sound.Looped = true

    -- Set the parent of the sound to the player's character so only they hear it
    sound.Parent = player.Character

    -- Play the sound
    sound:Play()
end

-- Function to show a random image from GitHub every 5 seconds
local function showRandomImage()
    local imageUrls = {
        "https://raw.githubusercontent.com/megapxzeeoh/Roblox-scary-visual-script/main/xsmall_scary_49bada248c.png",
        "https://raw.githubusercontent.com/megapxzeeoh/Roblox-scary-visual-script/main/xsmall_scary_01aae23e3d.png",
        "https://raw.githubusercontent.com/megapxzeeoh/Roblox-scary-visual-script/main/xsmall_scary_5273bdd278.png",
        "https://raw.githubusercontent.com/megapxzeeoh/Roblox-scary-visual-script/main/xsmall_scary_74c1039b59.png"
    }

    local currentBillboardGui  -- Variable to hold the current displayed image

    local function displayImage()
        -- Remove the previous image if it exists
        if currentBillboardGui then
            currentBillboardGui:Destroy()
        end

        -- Pick a random image URL
        local imageUrl = imageUrls[math.random(#imageUrls)]

        -- Create a new BillboardGui instance
        currentBillboardGui = Instance.new("BillboardGui")
        currentBillboardGui.Size = UDim2.new(4, 0, 4, 0)
        currentBillboardGui.Adornee = player.Character:FindFirstChild("Head")
        currentBillboardGui.Parent = player.Character

        -- Create a new ImageLabel instance
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Size = UDim2.new(1, 0, 1, 0)
        imageLabel.Image = imageUrl
        imageLabel.BackgroundTransparency = 1
        imageLabel.Parent = currentBillboardGui

        -- The image will display for 5 seconds before being replaced
    end

    -- Loop the image display function every 5 seconds
    while true do
        displayImage()
        wait(5)
    end
end

-- Call the functions to set up the environment, play music, and show images
stopAndDistortSounds()
setSky()
playLoudMusic()
showRandomImage()
