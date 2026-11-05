local Config = require(game:GetService("ServerScriptService").CharacterConfig).Zoro

local Zoro = {}

Zoro.Name = "Zoro"

Zoro.IsAdmin = false

Zoro.Skills = {
	[1] = {
		Name = Config[1].Name, Cooldown = Config[1].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet["Yashka CrowNew"]).Start(player, skill.Cooldown)
		end,
	},

	[2] = {
		Name = Config[2].Name, Cooldown = Config[2].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.Slashes).Start(player, skill.Cooldown)
		end,
	},

	[3] = {
		Name = Config[3].Name, Cooldown = Config[3].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.OniGiri).Start(player, skill.Cooldown)
		end,
	},

	[4] = {
		Name = Config[4].Name, Cooldown = Config[4].Cooldown, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.TowerClimbCounter).Start(player, skill.Cooldown)
		end,
	},

	["Mode Skill"] = {
		Name = Config.Ult.Name, Cooldown = 1, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.ModeSkillSet.TatsumakiNew).Start(player, skill.Cooldown)
		end,
	},
}

return Zoro




