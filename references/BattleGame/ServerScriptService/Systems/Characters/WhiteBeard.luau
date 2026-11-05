local Config = require(game:GetService("ServerScriptService").CharacterConfig).WhiteBeard

local WhiteBeard = {}

WhiteBeard.Name = "WhiteBeard"

WhiteBeard.IsAdmin = false

WhiteBeard.Skills = {
	[1] = {
		Name = Config[1].Name, Cooldown = Config[1].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			--require(script.RegularSkillSet["Tremor Punch"]).Start(player, skill.Cooldown)
			require(script.RegularSkillSet["Tremor Punch New"]).Start(player, skill.Cooldown)
		end,
	},

	[2] = {
		Name = Config[2].Name, Cooldown = Config[2].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.Sweep).Start(player, skill.Cooldown)
		end,
	},

	[3] = {
		Name = Config[3].Name, Cooldown = Config[3].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.JumpStomp).Start(player, skill.Cooldown)
		end,
	},

	[4] = {
		Name = Config[4].Name, Cooldown = Config[4].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.LegStomp).Start(player, skill.Cooldown)
		end,
	},

	["Mode Skill"] = {
		Name = Config.Ult.Name, Cooldown = 1, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.Tsunami).Start(player, skill.Cooldown)
		end,
	},
}

return WhiteBeard




