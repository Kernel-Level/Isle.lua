
--[[
This is a very downgraded method that i was using i will update this method in 1-2 days so it actually works and its better

--]]

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "Krypton v2.1",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BlotusConfig"
})


local selectedItem = nil
local itemsList = {}  


local function PopulateItemsList()
    itemsList = {}
   
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("BasePart") or item:IsA("Model") then
  
            table.insert(itemsList, item.Name)
        end
    end
end

local function TeleportToItem()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if humanoidRootPart and selectedItem then
        -
        local item = workspace:FindFirstChild(selectedItem)
        if item then

            humanoidRootPart.CFrame = item:GetPrimaryPartCFrame()  -- Use PrimaryPart CFrame for models
            OrionLib:MakeNotification({
                Name = "Teleported!",
                Content = "You have been teleported to " .. selectedItem,
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        else
            OrionLib:MakeNotification({
                Name = "Item Not Found",
                Content = "The selected item does not exist.",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
end

PopulateItemsList()


local ItemTab = Window:MakeTab({
    Name = "Item Teleport",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})


ItemTab:AddDropdown({
    Name = "Select Item to TP",
    Options = itemsList,
    Default = nil,
    Callback = function(Value)
        selectedItem = Value
    end
})


ItemTab:AddButton({
    Name = "Teleport to Item",
    Callback = function()
        TeleportToItem()
    end
})


OrionLib:Init()
