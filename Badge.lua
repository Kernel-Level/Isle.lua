-- This was tested on awp.gg 100% sUNC
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "Krypton V2.1",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BlotusConfig"
})

local BadgeService = game:GetService("BadgeService")


local badgeID = 2127561122 

local function AwardBadge()
    local player = game.Players.LocalPlayer
    -- Check if the player has already earned the badge
    if not BadgeService:UserHasBadge(player.UserId, badgeID) then
        -- Award the badge
        BadgeService:AwardBadge(player.UserId, badgeID)
        OrionLib:MakeNotification({
            Name = "Badge Awarded",
            Content = "You have successfully earned the badge!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    else
        OrionLib:MakeNotification({
            Name = "Badge Already Awarded",
            Content = "You have already earned this badge.",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
end

Window:MakeTab({
    Name = "Badge Actions",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Window.Tabs[1]:AddButton({
    Name = "Award Badge",
    Callback = function()
        AwardBadge()
    end
})

OrionLib:Init()

