local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)

local SoundHandler = require(ReplicatedModules.SoundHandler)
local Velocity = require(ReplicatedStorage.Modules.Velocity)


local Trove = require(ReplicatedModules.Trove)

local Sounds = ReplicatedStorage.Assets.Sounds

local NewAnimLocation = ServerStorage.Assets.Animations["WhiteBeard"]

local MoveSounds = Sounds.Characters

local ReplicateEffects_Set = RemotesContainer.Replicate.Set

return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local Animator: Animator = Humanoid.Animator

		if Character:HasTag("Stunned") then
			return
		end
		if Player:GetAttribute("AbilityOneCooldown") then
			return
		end

		Player:SetAttribute("AbilityOneCooldown", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = 0.5
		end
		
		local Bind = Instance.new("StringValue")
		Bind.Parent = Character
		Bind.Name = "Tremor"

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local Hit = false
		local grabHit = false
		local Finisher = false

		local Janitor = Trove.new()
		local Container = {}
	
		local StartAnimation: AnimationTrack = NewAnimLocation["Tremor Punch"].User
		local UserTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}
		StartEvents["pre hit"] = UserTrack:GetMarkerReachedSignal("pre hit"):Once(function()
			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["Tremor1"], HumRP, { FadeOut = 1 })
		end)

		StartEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
			local CFrameToUse = HumRP.CFrame

			task.delay(.2, function()
				if Bind then
					Bind:Destroy()
					Bind = nil
				end
			end)
			
			--local results = DestructionHandler.destroy(Vector3.new(20,30,50), CFrameToUse * CFrame.new(0, 0, -20), Enum.PartType.Block, {
			--	MinimumSize = 5,
			--	TimeToReset = 20,
			--	Player = Player,
			--	VoxelDestroyChance = .7,
			--	FlingDestroyChance = 1,
			--	Visualize = false,
			--	IgnoreFloor = true,
			--	--VoxelVelocity = function(voxel, hitPos)
			--	--	local outward = voxel.Position - hitPos
			--	--	outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
			--	--	return outward * math.random(40, 70) + Vector3.new(0, 20, 0)
			--	--end,
			--	VoxelVelocity = HumRP.CFrame.LookVector * math.random(40, 70) + Vector3.new(0, 25, 0),
			--})
			
			local NEAR_DIST = 5
			local FAR_DIST = 45

			local NEAR_DAMAGE, FAR_DAMAGE = 20, 5
			local NEAR_FORCE, FAR_FORCE = 60, 30
			local NEAR_LIFT, FAR_LIFT = 35, 15
			local NEAR_RAGDOLL, FAR_RAGDOLL = 2, 1


			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(20, 20, 50)
			Hitbox.Offset = CFrame.new(0, 0, -20)
			Hitbox.Visualize = true
			Hitbox.Ignore = {Character}
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

				if iFramesService:HasiFrame(EnemyCharacter, 2)
					or EnemyHumanoid.Health <= 0
					or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
				then
					return
				end
				
				local flat = (EnemyHumRP.Position - HumRP.Position) * Vector3.new(1, 0, 1)
				local dist = flat.Magnitude

				-- 0 at point blank, 1 at max range.
				local t = math.clamp((dist - NEAR_DIST) / (FAR_DIST - NEAR_DIST), 0, 1)

				local damage = NEAR_DAMAGE + (FAR_DAMAGE - NEAR_DAMAGE) * t
				local force = NEAR_FORCE + (FAR_FORCE - NEAR_FORCE) * t
				local upwardForce = NEAR_LIFT + (FAR_LIFT - NEAR_LIFT) * t
				local ragdollDuration = NEAR_RAGDOLL + (FAR_RAGDOLL - NEAR_RAGDOLL) * t
				local hardRagdoll = false


				local HitInfo = DamageHandler:TakeDamage(
					Character,
					EnemyHumanoid,
					damage,
					nil,
					nil,
					false,
					true,
					true,
					true,
					true,
					nil,
					20
				)
				
				if HitInfo.Finisher == true then
					warn("Finisher branch")
					force *= 2
					upwardForce *= 2
					ragdollDuration *= 2
					hardRagdoll = true
				end

				if HitInfo.Countered == true then
					return
				end

				if EnemyCharacter:HasTag("Ragdolled") then --Safety
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				end
				
				--local dir = flat.Magnitude > 0.01 and flat.Unit or (HumRP.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit

				
				local VelocityObject = Velocity.new(EnemyCharacter)
				VelocityObject.Settings.RemoveTime = 0.2
				VelocityObject.Settings.MaxForce = Vector3.new(100000, 100000, 100000) --Force
				VelocityObject.Settings.Velocity = HumRP.CFrame.LookVector * force + Vector3.new(0, upwardForce, 0)
				--VelocityObject.Settings.Spin = Vector3.new(
				--	(math.random() - 0.5) * 2,
				--	(math.random() - 0.5) * 2,
				--	(math.random() - 0.5) * 2
				--).Unit * 8
				VelocityObject:Fire()

				RagdollHandler.ragdoll(EnemyHumanoid, ragdollDuration, hardRagdoll, nil, nil, nil, true)
			end
			
			Hitbox:Once()
			Hitbox:Destroy()
			
			RemotesContainer.ClientEffects:FireAllClients(
				"WhiteBeardFirstAbility",
				{ Attacker = Character, SkillType = "Hit", CFrameToUse = CFrameToUse, Seed = math.random(1, 2^5 - 1)}
			)

			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["Tremor2"], HumRP)

			shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 9, Last = 0.4 } })
			task.delay(.5, function()
				SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Tremor Punch"]["ice shattering"], HumRP)
			end)
		end)

		UserTrack.Stopped:Once(function()
			if Bind then 
				Bind:Destroy()
				Bind = nil
			end
			
			for _, v in StartEvents do
				v:Disconnect()
			end
			--task.delay(1, function()

			task.delay(.2, function()
				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end
			end)

			Player:SetAttribute("AbilityOneCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityOneCooldown", false)
				end
			end)
		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)

		RemotesContainer.ClientEffects:FireAllClients(
			"WhiteBeardFirstAbility",
			{ Attacker = Character, SkillType = "StartUp", Bind = Bind }
		)
		
		SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Startup Sounds"]["GuraStart"], HumRP)
		SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Tremor Punch"]["gura_lmb2_sfx"], HumRP)
	end,
}
