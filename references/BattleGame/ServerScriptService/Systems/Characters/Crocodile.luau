local Config = require(game:GetService("ServerScriptService").CharacterConfig).Crocodile

local Crocodile = {}

Crocodile.Name = "Crocodile"

Crocodile.IsAdmin = false

Crocodile.Skills = {
	[1] = {
		Name = Config[1].Name, Cooldown = Config[1].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.Slash).Start(player, skill.Cooldown)
		end,
	},

	[2] = {
		Name = Config[2].Name, Cooldown = Config[2].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.DesertSpadaServer).Start(player, skill.Cooldown)
		end,
	},

	[3] = {
		Name = Config[3].Name, Cooldown = Config[3].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.SunaGrab).Start(player, skill.Cooldown)
		end,
	},

	[4] = {
		Name = Config[4].Name, Cooldown = Config[4].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.SablesServer).Start(player, skill.Cooldown)
		end,
	},

	["Mode Skill"] = {
		Name = Config.Ult.Name, Cooldown = 1, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.SunaPseado).Start(player, skill.Cooldown)
		end,
	},
}

return Crocodile




