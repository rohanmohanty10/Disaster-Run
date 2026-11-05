local Luffy = {}

function Luffy.FirstAbility(character:Model, cooldown, damage, extra)
	local RegularSkill1 = require(script.RegularSkillSet.Ability1)
	--local RegularSkill1 = require(script.RegularSkillSet.Ability1)
	local player = game.Players:GetPlayerFromCharacter(character)

	RegularSkill1.Start(player)


end

function Luffy.SecondAbility(character:Model, cooldown, damage, extra)
	
	local RegularSkill2 = require(script.RegularSkillSet.Bazooka)
	--local RegularSkill1 = require(script.RegularSkillSet.Ability1)
	local player = game.Players:GetPlayerFromCharacter(character)

	RegularSkill2.Start(player)
end

function Luffy.ThirdAbility(character:Model, cooldown, damage, extra)
	local ThirdAbility = require(script.RegularSkillSet.Ability3)
	ThirdAbility.Skill(character, cooldown, damage, extra) --The extra is if the player is in the air or not. 
end

function Luffy.FourthAbility(character:Model, cooldown, damage, extra)
	
	
end

function Luffy.Mode(character, mode, timer)
	

end

function Luffy.FirstAbilityMode(character,mode,timer)
	
	local Ability1 = require(script.ModeSkillSet.Ability1)

	local player = game.Players:GetPlayerFromCharacter(character)

	Ability1.Start(player)


end

function Luffy.SecondAbilityMode(character,mode,timer)
	local ModeSkill2 = require(script.ModeSkillSet.Ability2)
	--local ModeSkill2 = require(script.ModeSkillSet.Ability2V2)
	ModeSkill2.Skill(character)
	
end
function Luffy.ThirdAbilityMode(character,mode,timer)
	--local Ability3 = require(script.ModeSkillSet.Ability3)
	--Ability3.Skill(character)
	local Ability3 = require(script.ModeSkillSet.HammerHeel)
	local player = game.Players:GetPlayerFromCharacter(character)

	Ability3.Start(player)
	
end

function Luffy.FourthAbilityMode(character,mode,timer)
	--print("ModeAbility4")
	--print("Test")
	local Ability4 = require(script.ModeSkillSet.Ability4)

	local player = game.Players:GetPlayerFromCharacter(character)

	Ability4.Start(player)
	
end

return Luffy




