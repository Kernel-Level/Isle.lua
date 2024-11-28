local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "TELEPORT TO PLAYER",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BlotusConfig"
})

n
local TP_Tab = Window:MakeTab({
    Name = "Teleport",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})


local function TPToPlayerSmooth(player)
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetCFrame = player.Character.HumanoidRootPart.CFrame
        local distance = (targetCFrame.Position - HumanoidRootPart.Position).Magnitude
        local time = distance / 50 
        

        local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
        local goal = {CFrame = targetCFrame}
        local tween = game:GetService("TweenService"):Create(HumanoidRootPart, tweenInfo, goal)
        
        tween:Play()
    end
end


local function CreatePlayerDropdown()
    local playerOptions = {}
    

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(playerOptions, player.Name)
        end
    end

    TP_Tab:AddDropdown({
        Name = "Select Player to TP",
        Options = playerOptions,
        Default = playerOptions[1],  
        Callback = function(selectedPlayerName)
            
            local targetPlayer = game.Players:FindFirstChild(selectedPlayerName)
            if targetPlayer then
                TPToPlayerSmooth(targetPlayer)  
            end
        end
    })
end


CreatePlayerDropdown()

OrionLib:Init()
