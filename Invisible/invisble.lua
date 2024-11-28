
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "[BLOTUS] EARLY BETA TEST",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BlotusConfig"
})


local ExploitTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Variables
local isInvisible = false  
local originalCharacter = nil  

-- Invisible Mode Function
local function ToggleInvisible()
    local player = game.Players.LocalPlayer
    local character = player.Character

    if character then
        if not isInvisible then
         
            originalCharacter = {}
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    originalCharacter[part] = part.Transparency
                    part.Transparency = 1  
                elseif part:IsA("Humanoid") then
                    originalCharacter[part] = true
                    part:Destroy() 
                end
            end
            isInvisible = true
        else
            for part, originalTransparency in pairs(originalCharacter) do
                if part and part.Parent then
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        part.Transparency = originalTransparency 
                    elseif part:IsA("Humanoid") then
                        local humanoid = Instance.new("Humanoid")
                        humanoid.Parent = part.Parent
                    end
                end
            end
            isInvisible = false
            originalCharacter = nil
        end
    end
end

ExploitTab:AddToggle({
    Name = "Enable Invisible Mode",
    Default = false,
    Callback = function(Value)
        ToggleInvisible()  
    end
})
OrionLib:Init()
