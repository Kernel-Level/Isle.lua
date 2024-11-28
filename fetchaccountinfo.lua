local Players = game:GetService("Players")
local player = Players.LocalPlayer
print("Player ID:", player.UserId)
print("Player Name:", player.Name)
local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
print("Avatar URL:", avatarUrl)
