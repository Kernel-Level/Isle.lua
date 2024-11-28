-- Ive decided to downgrade the version

-- Use N to noclip
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local noclipEnabled = false
local speed = 16
local bodyVelocity = nil
local oldPosition = humanoidRootPart.Position


local function toggleNoclip(value)
    noclipEnabled = value
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
                local newPosition = humanoidRootPart.Position + direction * speed / 50
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

-- Toggle Noclip using a keybind (For example, toggle on 'N')
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.N then
        toggleNoclip(not noclipEnabled)
    end
end)


toggleNoclip(false)

