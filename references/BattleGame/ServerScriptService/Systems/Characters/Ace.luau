local Ace = {}

Ace.Name = "Ace"

Ace.Skills = {
	[1] = {
		Name = "Abyssal Pull", Cooldown = 25, Holdable = true,
		Activate = function(player, skill, extra)
			local Ability1 = require(script.RegularSkillSet.Ability1)

			if extra and extra.IsReleased then
				if Ability1.Release then
					Ability1.Release(player)
				end
			else
				Ability1.Start(player)
			end
		end,
	},

	[2] = {
		Name = "Blackhole", Cooldown = 20, Damage = 20, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.Ability2).Start(player, skill.Cooldown)
		end,
	},

	[3] = {
		Name = "Dark Vortex", Cooldown = 20, Damage = 20, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.Ability3).Start(player, skill.Cooldown)
		end,
	},

	[4] = {
		Name = "Devour ", Cooldown = 20, Damage = 20, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.Ability4).Start(player, skill.Cooldown)
		end,
	},

	["Mode Skill"] = {
		Name = "Liberation ", Cooldown = 1, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.ModeSkillSet.Liberation).Start(player, skill.Cooldown)
		end,
	},
}

return Ace




