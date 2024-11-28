

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "Krypton v2.1",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BlotusConfig"
})


local ExploitTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Variable for godmode
local godmodeEnabled = false
local customHealthValue = 1000000  -- Set health to 1 million

-- Godmode Function
local function GodMode()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character:FindFirstChild("Humanoid")
        humanoid.Health = customHealthValue  
        humanoid.MaxHealth = customHealthValue  
        humanoid.HealthChanged:Connect(function()
            humanoid.Health = customHealthValue  -- Maintain health
        end)
    end
end

ExploitTab:AddToggle({
    Name = "Enable Godmode",
    Default = false,
    Callback = function(Value)
        if Value then
            GodMode()
        end
    end
})

OrionLib:Init()
