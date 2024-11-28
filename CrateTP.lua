
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "CrateTP",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BlotusConfig"
})


local TP_Tab = Window:MakeTab({
    Name = "Teleport",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})


local function GetCrates()
    local crates = {}

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Crate" and obj:IsA("BasePart") then
            table.insert(crates, obj)
        end
    end
    return crates
end


local function TPToCrate(crate)
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    
    HumanoidRootPart.CFrame = crate.CFrame
end


local crateOptions = {}
local crates = GetCrates()


for _, crate in pairs(crates) do
    table.insert(crateOptions, crate.Name)
end


TP_Tab:AddDropdown({
    Name = "Select Crate to TP",
    Options = crateOptions,
    Default = crateOptions[1], 
    Callback = function(selectedCrateName)
        
        for _, crate in pairs(crates) do
            if crate.Name == selectedCrateName then
                TPToCrate(crate)
                break
            end
        end
    end
})

OrionLib:Init()
