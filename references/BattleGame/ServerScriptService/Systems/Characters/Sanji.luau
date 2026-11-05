local Sanji = {}

Sanji.Name = "Sanji"

Sanji.IsAdmin = false

Sanji.Skills = {
	[1] = {
		Name = "Abyssal Pull", Cooldown = 25, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.Ability1).Start(player, skill.Cooldown)
		end,
	},

	[2] = {
		Name = "Blackhole", Cooldown = 20, Damage = 20, Holdable = false,
		Activate = function(player, skill, extra)
			require(script.RegularSkillSet.Ability2.ConcasseNew).Start(player, skill.Cooldown)
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
}


function Sanji.FirstAbilityMode(character,mode,timer)
	--warn("mode ability 1")
	--local Ability1 = require(script.ModeSkillSet.Ability1)

	--local player = game.Players:GetPlayerFromCharacter(character)

	--Ability1.Start(player)
end

function Sanji.SecondAbilityMode(character,mode,timer)
	local Ability2 = require(script.ModeSkillSet["Hell Memories"])

	local player = game.Players:GetPlayerFromCharacter(character)

	Ability2.Start(player)
	
end

function Sanji.ThirdAbilityMode(character,cooldown, damage,extra)
	
	local Ability3 = require(script.ModeSkillSet.Ability3)

	local player = game.Players:GetPlayerFromCharacter(character)

	if extra and extra.IsReleased then
		if Ability3.Release then
			Ability3.Release(player)
		end
	else
		Ability3.Start(player)
	end
end

function Sanji.FourthAbilityMode(character,mode,timer)
	local Ability4 = require(script.ModeSkillSet.Venison)

	local player = game.Players:GetPlayerFromCharacter(character)

	
	Ability4.Start(player)
end

return Sanji




