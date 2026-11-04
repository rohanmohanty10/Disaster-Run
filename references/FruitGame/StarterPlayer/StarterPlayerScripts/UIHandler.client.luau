 

local v1 = game:GetService("ReplicatedStorage")
local v2 = v1:WaitForChild("Modules"):WaitForChild("Client")
local v3 = require(v2:WaitForChild("UIController"))
local v4 = v1:WaitForChild("Stats" .. game.Players.LocalPlayer.Name)
v4:WaitForChild("Stats")
v4:WaitForChild("Quest")
v3:Initialize()