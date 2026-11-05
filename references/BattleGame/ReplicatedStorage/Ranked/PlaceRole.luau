-- Which place is this server? Demon Fruits is republished as the Arena, so the same code
-- runs in both and every arena-only behaviour is switched on by PlaceRole.IsArena().
--
-- Studio testing: set the attribute StudioTestArena = true on ReplicatedStorage.Ranked to make
-- a Demon Fruits playtest behave like the Arena (StudioTestRanked, StudioTestTeamSize and
-- StudioTestSolo pick the test match). It does nothing outside Studio. Set it back to false
-- before you test the main game.
local RunService = game:GetService("RunService")

local Ranked = script.Parent
local Config = require(Ranked.Config)

local PlaceRole = {}

function PlaceRole.IsStudioTestArena(): boolean
	return RunService:IsStudio() and Ranked:GetAttribute("StudioTestArena") == true
end

function PlaceRole.IsArena(): boolean
	if PlaceRole.IsStudioTestArena() then
		return true
	end
	return Config.PlaceIds.Arena ~= 0 and game.PlaceId == Config.PlaceIds.Arena
end

function PlaceRole.IsLobby(): boolean
	return game.PlaceId == Config.PlaceIds.Lobby
end

function PlaceRole.IsMain(): boolean
	return not PlaceRole.IsArena() and not PlaceRole.IsLobby()
end

return PlaceRole
