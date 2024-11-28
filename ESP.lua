
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "ESP",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BlotusConfig"
})


local playersESP = {} 

local function CreatePlayerESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    
    local box = Instance.new("BillboardGui")
    box.Parent = player.Character.HumanoidRootPart
    box.Adornee = player.Character.HumanoidRootPart
    box.Size = UDim2.new(0, 100, 0, 100)
    box.StudsOffset = Vector3.new(0, 3, 0)  
    
    local frame = Instance.new("Frame")
    frame.Parent = box
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(1, 0, 0) 
    frame.BackgroundTransparency = 0.5
    
  
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = box
    nameLabel.Size = UDim2.new(1, 0, 0, 20)
    nameLabel.Position = UDim2.new(0, 0, 0, -20)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)  
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextSize = 14
    

    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Parent = box
    distanceLabel.Size = UDim2.new(1, 0, 0, 20)
    distanceLabel.Position = UDim2.new(0, 0, 0, 20)  
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.new(1, 1, 1)  
    distanceLabel.TextStrokeTransparency = 0.5
    distanceLabel.TextSize = 12
    
  
    playersESP[player] = {
        box = box,
        nameLabel = nameLabel,
        distanceLabel = distanceLabel,
    }
end


local function RemovePlayerESP(player)
    if playersESP[player] then
        playersESP[player].box:Destroy()
        playersESP[player] = nil
    end
end


local function UpdateESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                
                if not playersESP[player] then
                    CreatePlayerESP(player)
                end

                
                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                playersESP[player].distanceLabel.Text = string.format("Distance: %.2f studs", distance)
            else
               
                RemovePlayerESP(player)
            end
        end
    end
end


game:GetService("RunService").RenderStepped:Connect(function()
    UpdateESP()
end)


OrionLib:Init()
