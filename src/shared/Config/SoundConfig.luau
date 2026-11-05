--!strict
-- Skill sounds. Paste your uploaded sound ids ("rbxassetid://123") into the slots;
-- empty slots simply don't play. Sounds play in 3D at the strike, so Runners hear where it lands.
--   Telegraph: when the ground warning appears (wind-up, crackle, rumble)
--   Impact:    when the strike lands (thunder clap, meteor crash)
-- Skills without their own entry fall back to their element's sounds (Elements below).

local SoundConfig = {}

SoundConfig.Volume = 0.8
SoundConfig.MaxDistance = 400 -- studs; quieter with distance, silent past this

SoundConfig.Skills = {
	-- Thunder God
	["Lightning Dragon"] = { Telegraph = "", Impact = "" },
	["Lightning Wrath"] = { Telegraph = "", Impact = "" },
	["Raigo"] = { Telegraph = "", Impact = "" },
	-- Gravity Lord
	["Meteor Strike"] = { Telegraph = "", Impact = "" },
	["Gravity Dominance"] = { Telegraph = "", Impact = "" },
	["Meteor Fury"] = { Telegraph = "", Impact = "" },
	-- King of Curses (Shrine of Calamity has no impact: its Telegraph slot plays as the domain opens)
	["Dismantle"] = { Telegraph = "", Impact = "" },
	["Cleave"] = { Telegraph = "", Impact = "" },
	["Flame Arrow"] = { Telegraph = "", Impact = "" },
	["World Slash"] = { Telegraph = "", Impact = "" },
	["Shrine of Calamity"] = { Telegraph = "", Impact = "" },
} :: { [string]: { Telegraph: string, Impact: string } }

-- Fallbacks for every other kit, by element (Behavior.Vfx in Kits.luau).
SoundConfig.Elements = {
	Boulder = { Telegraph = "", Impact = "" },
	Wind = { Telegraph = "", Impact = "" },
	Fire = { Telegraph = "", Impact = "" },
	Ice = { Telegraph = "", Impact = "" },
	Water = { Telegraph = "", Impact = "" },
	Sand = { Telegraph = "", Impact = "" },
	Shadow = { Telegraph = "", Impact = "" },
	Magma = { Telegraph = "", Impact = "" },
	Lightning = { Telegraph = "", Impact = "" },
	Meteor = { Telegraph = "", Impact = "" },
	Gravity = { Telegraph = "", Impact = "" },
	Light = { Telegraph = "", Impact = "" },
	Quake = { Telegraph = "", Impact = "" },
	BlackFlame = { Telegraph = "", Impact = "" },
	Spirit = { Telegraph = "", Impact = "" },
	Slash = { Telegraph = "", Impact = "" },
} :: { [string]: { Telegraph: string, Impact: string } }

return SoundConfig
