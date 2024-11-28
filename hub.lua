-- This was a full script i do not recommend using this since modules can break & make stuff worse i recommend just using 1x1 modules


-- Initialize Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "Krypton shitty hub compiled",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "CustomHubConfig"
})

-- Tabs
local ExploitTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local EspTab = Window:MakeTab({
    Name = "ESP",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Variables
local speedValue = 50
local noclipEnabled = false
local godmodeEnabled = false
local isInvisible = false
local selectedPlayer = nil
local oldPosition = nil
local bodyVelocity = nil

-- Helper Functions

-- Speed CFrame Movement
local function SpeedCFrame()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    game:GetService("RunService").RenderStepped:Connect(function()
        if speedValue > 0 then
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * speedValue / 50
        end
    end)
end

-- Noclip with Lagback Prevention
local function NoclipToggle(value)
    noclipEnabled = value
    local character = game.Players.LocalPlayer.Character
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")

    if noclipEnabled then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = humanoidRootPart

        game:GetService("RunService").RenderStepped:Connect(function()
            if noclipEnabled then
                local direction = humanoidRootPart.CFrame.LookVector
                local newPosition = humanoidRootPart.Position + direction * speedValue / 50
                humanoidRootPart.CFrame = CFrame.new(newPosition, humanoidRootPart.Position + direction)
            end
        end)
    else
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end
end

-- Toggle Godmode (Set Health to 1,000,000)
local function GodmodeToggle(value)
    local character = game.Players.LocalPlayer.Character
    local humanoid = character:WaitForChild("Humanoid")
    if value then
        humanoid.Health = 1000000
        godmodeEnabled = true
    else
        godmodeEnabled = false
    end
end

-- Invisible Mode Toggle
local function InvisibleToggle(value)
    local character = game.Players.LocalPlayer.Character
    if value then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
        isInvisible = true
    else
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
        isInvisible = false
    end
end

-- Teleport to Crates
local function TeleportToCrates(crateLocations)
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(crateLocations)
end

-- ESP for Players
local function CreateESP(player)
    local esp = Instance.new("BillboardGui")
    esp.Adornee = player.Character.HumanoidRootPart
    esp.Size = UDim2.new(0, 200, 0, 50)
    esp.StudsOffset = Vector3.new(0, 2, 0)
    esp.Parent = player.Character

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.Text = player.Name
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.Parent = esp
end

-- Initialize Tabs

-- Player Tab - Speed
PlayerTab:AddSlider({
    Name = "Speed Adjust",
    Min = 0,
    Max = 200,
    Default = 50,
    Color = Color3.new(0, 1, 0),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(value)
        speedValue = value
        SpeedCFrame()
    end
})

-- Player Tab - Godmode
PlayerTab:AddToggle({
    Name = "Enable Godmode",
    Default = false,
    Callback = function(value)
        GodmodeToggle(value)
    end
})

-- Player Tab - Invisible Mode
PlayerTab:AddToggle({
    Name = "Enable Invisible Mode",
    Default = false,
    Callback = function(value)
        InvisibleToggle(value)
    end
})

-- Exploit Tab - Noclip
ExploitTab:AddToggle({
    Name = "Enable Noclip",
    Default = false,
    Callback = function(value)
        NoclipToggle(value)
    end
})

-- Exploit Tab - Teleport to Crates
local cratesLocations = {
    Vector3.new(10, 5, 10), -- Example crate locations
    Vector3.new(-20, 5, -20)
}
ExploitTab:AddDropdown({
    Name = "Teleport to Crates",
    Options = {"Crate 1", "Crate 2"},
    Default = nil,
    Callback = function(value)
        if value == "Crate 1" then
            TeleportToCrates(cratesLocations[1])
        elseif value == "Crate 2" then
            TeleportToCrates(cratesLocations[2])
        end
    end
})

-- ESP Tab - ESP Players
EspTab:AddToggle({
    Name = "Enable ESP",
    Default = false,
    Callback = function(value)
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if value then
                    CreateESP(player)
                end
            end
        end
    end
})

-- Final Initialization
OrionLib:Init()

