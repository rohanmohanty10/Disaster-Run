local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).Crocodile[1]
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")


local ServerModules = ServerStorage.SBGModules

local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer = ReplicatedStorage.Remotes


local StunHandler = require(ServerModules.StunHandler)
local HitboxHandler = require(ServerModules.HitboxHandler)
local DamageHandler = require(ServerModules.DamageHandler)
local RagdollHandler = require(ServerModules.RagdollHandler)
local NewKnockback = require(ServerModules.BodymoverService)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService = require(ServerModules.iFramesService)
local CollisionsModule = require(ServerModules.CollisionsModule)
local SoundsModule = require(ServerModules.SoundsModule)
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local DebreeService = require(ServerModules.DebreeService)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local Velocity = require(ReplicatedModules.Velocity)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


local NewAnimLocation = ServerStorage.Assets.Animations.Crocodile["Slash Dash"]


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true



local DASH_DISTANCE = 40

local FADE_DELAY    = 0.135
local FADE_DURATION = 0.35
local BV_DURATION   = 0.19
local BV_DECEL_TIME = 0.16


local IndestructibleParams = RaycastParams.new()
IndestructibleParams.FilterType = Enum.RaycastFilterType.Include
IndestructibleParams.FilterDescendantsInstances = { workspace.World.Map["Indestructible Map"] }
IndestructibleParams.RespectCanCollide = true

local WALL_BUFFER = 5 -- stop this far in front of the wall so the character doesn't clip into it

local function getDashDistance(originCF: CFrame): number
	local result = workspace:Raycast(
		originCF.Position,
		originCF.LookVector * DASH_DISTANCE,
		IndestructibleParams
	)
	if result then
		return math.max(result.Distance - WALL_BUFFER, 0)
	end
	return DASH_DISTANCE
end



return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Janitor = Trove.new()
		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityOneCooldown") then return end
		if Character:GetAttribute("ZoroThirdAbility") then return end

		Player:SetAttribute("AbilityOneCooldown", true)
		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local StartAnimation = NewAnimLocation.User
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		
		local Hit = {}
		
		local HitBoxSize = Vector3.new(20, 8, 10)
		
		local Hitbox = HitboxHandler.new()
		Hitbox.Instance = HumRP
		Hitbox.Size = HitBoxSize
		Hitbox.Offset   = CFrame.new(0, 0, -4)
		Hitbox.Ignore = { Character }
		Hitbox.Visualize = false
		
		StartEvents["size2"] = StartTrack:GetMarkerReachedSignal("size2"):Once(function()
			SoundHandler:AddSound(MoveSounds.Crocodile.DashSlash["Long slash wind"], HumRP)
		end)


		StartEvents["size3"] = StartTrack:GetMarkerReachedSignal("size3"):Once(function()
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if Hit[EnemyCharacter] or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if EnemyCharacter:GetAttribute("Ragdolled") then
					warn("Enemy was ragdolled. Exited early")
					return
				end
				Hit[EnemyCharacter] = true
				
				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Hit, nil, nil, false, true, true, true, true, nil, nil)
				if HitInfo.Countered == true then return end --Simple and easy

				local Finisher = HitInfo.Finisher == true

				local VelocityObject = Velocity.new(EnemyCharacter)
				VelocityObject.Settings.RemoveTime = 0.2
				VelocityObject.Settings.MaxForce = Vector3.new(100000, 100000, 100000) --Force
				VelocityObject.Settings.Velocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, 10, 0)
				VelocityObject:Fire()

				RagdollHandler.ragdoll(EnemyHumanoid, 1, false, nil, nil, nil, true)
				
				RemotesContainer.ClientEffects:FireAllClients("SunaDashSlash", {
					Attacker  = Character,
					SkillType = "HitEnemy", 
					Enemy = EnemyCharacter
				})
				SoundHandler:AddSound(MoveSounds.Crocodile.DashSlash["Slash Hit"], EnemyHumRP)
			end
			Hitbox:Start()
			
			task.delay(.1, function()
				SoundHandler:AddSound(MoveSounds.Crocodile.DashSlash["Sand"], HumRP)
			end)
		end)
		
		StartEvents["size4"] = StartTrack:GetMarkerReachedSignal("size4"):Once(function()
			local CFrameToUse = HumRP.CFrame * CFrame.new(0, 0, -5)

			RemotesContainer.ClientEffects:FireAllClients("SunaDashSlash", {
				Attacker  = Character,
				SkillType = "Semi Circle", 
				CFrameToUse = CFrameToUse,
			})
			
			-- KeepGround: the Semi Circle crater's rocks sit right here, and breaking the floor under
			-- them made the crater a race against the floor's removal reaching each client, so it often
			-- didn't appear. Walls and props in front still break, down to their base.
			DebreeService.Destroy(CFrameToUse * CFrame.new(0, 0, -7), Vector3.new(15, 8, 10), {
				Shape = "Box",
				Direction = CFrameToUse.LookVector,
				Power = 20,
				Lift = 0,
				Attacker = Player,
				KeepGround = true,
			})
		end)
		
		StartEvents["size5"] = StartTrack:GetMarkerReachedSignal("size5"):Once(function()
			if Hitbox then
				Hitbox:Destroy()
			end
		end)
		

		StartTrack.Stopped:Once(function()		
			Character:RemoveTag("CantRotate")

			for _,v in StartEvents do
				v:Disconnect()
			end

			StunHandler:Unstun(Character, Stun)
			
			Character:SetAttribute("ZoroThirdAbility", nil)

			Player:SetAttribute("AbilityOneCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityOneCooldown", false)
				end
			end)
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		
		
			
		local VelocityObject = Velocity.new(Character)
		VelocityObject.Settings.Duration = .9
		VelocityObject.Settings.RemoveTime = .9
		VelocityObject.Settings.MaxForce = Vector3.new(1, 0, 1) * 80000
		VelocityObject.Settings.Controllable = true
		VelocityObject.Settings.Z = 70           -- forward lunge speed
		VelocityObject:Fire()
		
		RemotesContainer.ClientEffects:FireAllClients("SunaDashSlash", {
			Attacker  = Character,
			SkillType = "StartSlash", 
			StartTime = workspace:GetServerTimeNow(),   -- server clock at anim start
		})
		
		SoundHandler:AddSound(MoveSounds.Crocodile.DashSlash.Woosh, HumRP)
		SoundHandler:AddSound(MoveSounds.Crocodile.DashSlash.Sand, HumRP)
	end
}