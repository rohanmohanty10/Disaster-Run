--!strict
-- One SoundGroup for every game sound this client plays (skills, impacts, stands), so effects
-- like Infinite Void can mute the world (GAME_PLAN.md Section 2B: "distorting their camera and
-- audio"). UI clicks stay outside it so menus never go silent.

local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local Audio = {}

local group: SoundGroup? = nil

function Audio.Group(): SoundGroup
	if not group then
		local g = Instance.new("SoundGroup")
		g.Name = "GameAudio"
		g.Volume = 1
		g.Parent = SoundService
		group = g
	end
	return group :: SoundGroup
end

-- Fades the game audio to `volume` (0-1).
function Audio.FadeTo(volume: number, seconds: number?)
	TweenService:Create(Audio.Group(), TweenInfo.new(seconds or 0.3), { Volume = volume }):Play()
end

return Audio
