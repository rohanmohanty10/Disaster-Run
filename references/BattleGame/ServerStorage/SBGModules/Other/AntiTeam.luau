local AntiTeamModule = {}


local Players = game:GetService("Players")


--Variables

local VictimHitLog = setmetatable({}, { __mode = "k" })
local AntiTeamConfig = {
	Window = 1.2,
	MinAttackers = 2,
	RequireM1Only = true,
	MinTotalHits = 2,
	MinOtherShare = 0.25
}


--Functions

function GetTime()
	return os.clock()
end

function AntiTeamModule.LogDamager(DamagedCharacter: Model, DamagerCharacter: Model, Damage: number, Type: string)
	if AntiTeamConfig.RequireM1Only and Type ~= "M1" then
		return
	end
	
	local ServerTime = GetTime()
	
	
	local InContainer = VictimHitLog[DamagedCharacter]
	if not InContainer then
		InContainer = {}
		
		VictimHitLog[DamagedCharacter] = InContainer
	end
	
	
	local HasEntry = InContainer[DamagerCharacter]
	if HasEntry then
		HasEntry.last = ServerTime
		HasEntry.hits = (HasEntry.hits or 0) + 1
		HasEntry.dmg  = (HasEntry.dmg or 0) + (Damage or 0)
	else
		InContainer[DamagerCharacter] = {
			last = ServerTime,
			hits = 1, 
			dmg = (Damage or 0) 
		}
	end
	
	
	for Enemy, Info in pairs(InContainer) do
		if ServerTime - (Info.last or 0) > AntiTeamConfig.Window then
			InContainer[Enemy] = nil
		end
	end
end

function AntiTeamModule.CheckForAntiTeam(DamagedCharacter: Model)
	local InContainer = VictimHitLog[DamagedCharacter]
	if not InContainer then 
		return false
	end
	
	
	local ServerTime = GetTime()
	local Unique, TotalHits, LeaderHits = 0, 0, 0
	
	
	for _, Info in pairs(InContainer) do
		if ServerTime - (Info.last or 0) <= AntiTeamConfig.Window then
			Unique += 1
			TotalHits += (Info.hits or 0)
			
			if Info.hits and Info.hits > LeaderHits then
				LeaderHits = Info.hits
			end
		end
	end
	
	
	if Unique < AntiTeamConfig.MinAttackers then 
		return false 
	end
	if TotalHits < (AntiTeamConfig.MinTotalHits or 0) then
		return false
	end
	
	
	if AntiTeamConfig.MinOtherShare and AntiTeamConfig.MinOtherShare > 0 then
		local others = TotalHits - LeaderHits
		
		if TotalHits == 0 or (others / TotalHits) < AntiTeamConfig.MinOtherShare then
			return false
		end
	end
	
	return true
end

function AntiTeamModule.StartAntiTeam(DamagedCharacter: Model, DamagerCharacter: Model, IsMovesetBased: boolean)
	if DamagedCharacter:GetAttribute("OnAntiTeam") then return end
	
	
	if IsMovesetBased then
		local DamagedPlayer = Players:GetPlayerFromCharacter(DamagedCharacter)
		local CurrentMoveset = DamagedPlayer and DamagedPlayer:GetAttribute("Moveset")
		
		
		if CurrentMoveset == "Example1" or CurrentMoveset == "Example2" then
			local AntiTeam = script:FindFirstChild(CurrentMoveset)
			
			coroutine.wrap(function()
				local RequiredModule = require(AntiTeam)
				RequiredModule.Start(DamagedCharacter, DamagerCharacter)
			end)()
		end
	else
		local InContainer = VictimHitLog[DamagedCharacter] or {}
		local ServerTime = GetTime()
		local candidates = {}
		
		for Enemy, Info in pairs(InContainer) do
			if ServerTime - (Info.last or 0) <= AntiTeamConfig.Window then
				if Enemy and Enemy.Parent then
					table.insert(candidates, {
						char = Enemy,
						last = Info.last 
					})
				end
			end
		end
		
		
		table.sort(candidates, function(FirstEnemy, SecondEnemy)
			return (FirstEnemy.last or 0) > (SecondEnemy.last or 0)
		end)
		
		
		local DamagerCharacters = {}
		for i = 1, math.min(2, #candidates) do
			local FoundEnemies = candidates[i].char
			
			if FoundEnemies and FoundEnemies.Parent and FoundEnemies ~= DamagedCharacter then
				table.insert(DamagerCharacters, FoundEnemies)
			end
		end
		
		
		if #DamagerCharacters == 0 and DamagerCharacter and DamagerCharacter.Parent and DamagerCharacter ~= DamagedCharacter then
			table.insert(DamagerCharacters, DamagerCharacter)
		end
		
		
		local AntiTeam = script.Variants:FindFirstChild(math.random(1, #script.Variants:GetChildren()))
		
		coroutine.wrap(function()
			local RequiredModule = require(AntiTeam)
			RequiredModule.Start(DamagedCharacter, DamagerCharacters[1], DamagerCharacters[2])
		end)()
	end
end

return AntiTeamModule