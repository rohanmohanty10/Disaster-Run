-- Starts the 1v1 / 2v2 match when this server is the Arena place. Does nothing in Demon Fruits.
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlaceRole = require(ReplicatedStorage:WaitForChild("Ranked"):WaitForChild("PlaceRole"))
if not PlaceRole.IsArena() then
	return
end

require(script.Parent:WaitForChild("ArenaMatch")).Start()
