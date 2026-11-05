local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).Zoro[3]
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
--local WeaponsHandler = require(ServerModules.WeaponsHandler)
local CollisionsModule = require(ServerModules.CollisionsModule)
local SoundsModule = require(ServerModules.SoundsModule)
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)
local DebreeService = require(ServerModules.DebreeService)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


local NewAnimLocation = ServerStorage.Assets.Animations.Zoro.Moveset.RegularMoveSet.OniGiri


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
		if Player:GetAttribute("AbilityThreeCooldown") then return end
		if Character:GetAttribute("ZoroThirdAbility") then return end

		Player:SetAttribute("AbilityThreeCooldown", true)
		Character:SetAttribute("ZoroThirdAbility", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		--local initialAnim = NewAnimLocation.Miss
		local initialAnim = NewAnimLocation.MissNew

		local StartAnimation = initialAnim
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local Assets = {}
		local Container = {}
		
		local Hit = {}
		local BodyVelocity
		
		local function executeTeleport(HumRP, character)
			
			local origin      = HumRP.CFrame
			local lookDir     = origin.LookVector
			local dashDist    = getDashDistance(origin)                 -- CHANGED
			local destination = origin.Position + lookDir * dashDist    -- CHANGED

			local trailOrigin = origin * CFrame.new(-0.073, -1.637, 0.128)
			local flatDest    = Vector3.new(destination.X, origin.Position.Y, destination.Z)
			local dashCFrame  = CFrame.new(trailOrigin.Position, flatDest)
			
			-- cut through whatever is in the dash's path; pieces fly the way Zoro dashed
			DebreeService.Destroy(origin * CFrame.new(0, 1, -dashDist / 2), Vector3.new(10, 10, dashDist + 6), {
				Shape = "Box",
				Direction = lookDir,
				Power = 30,
				Lift = 0,
				Attacker = Player,
				KeepGround = true,
			})
			
			-- Move forward DASH_DISTANCE, keep exact same rotation
			HumRP.CFrame = CFrame.new(destination) * (origin - origin.Position)

			--RemotesContainer.ClientEffects:FireAllClients("ZoroOniGiri", {
			--	Attacker    = Character,
			--	SkillType   = "teleport",
			--	Origin      = origin.Position,
			--	DashCFrame  = dashCFrame,
			--	Destination = destination,
			--})

			BodyVelocity = Instance.new("BodyVelocity")
			BodyVelocity.Name = "moveme"
			BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
			BodyVelocity.Velocity = lookDir * 60  -- actually needs a velocity set or it does nothing
			BodyVelocity:SetAttribute("Speed", 10)
			BodyVelocity:SetAttribute("Fallout", .97)
			BodyVelocity:SetAttribute("End", 4)
			BodyVelocity.Parent = HumRP

			task.delay(0.35, function()
				if BodyVelocity then
					BodyVelocity:Destroy()
					BodyVelocity = nil
				end
			end)

			return origin.Position, destination
		end
		
		StartEvents["hit"] = StartTrack:GetMarkerReachedSignal("hit"):Once(function()
			SoundHandler:AddSound(MoveSounds.Zoro.Moves.OniGiri.Hit, HumRP)
			SoundHandler:AddSound(MoveSounds.Zoro.Moves.OniGiri.Woosh, HumRP)

			local origin      = HumRP.CFrame
			local lookDir     = origin.LookVector
			local dashDist    = getDashDistance(origin)                 -- CHANGED
			local destination = origin.Position + lookDir * dashDist    -- CHANGED

			local dashVector   = destination - origin.Position
			local dashLength   = dashVector.Magnitude
			local dashMidpoint = origin.Position + dashVector * 0.5
			local hitboxCFrame = CFrame.new(dashMidpoint, destination)
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(10, 8, dashLength)
			--Hitbox.Offset = CFrame.new(0, (Hitbox.Size.Y / 2) - 3, -5)
			--Hitbox.Offset =  CFrame.new(0, 0, 0)
			Hitbox.Offset   = hitboxCFrame:ToObjectSpace(origin) -- offset relative to HumRP
			--Hitbox.Offset = CFrame.new(0, 0, -(dashLength / 2))

			Hitbox.Ignore = { Character }
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if Hit[EnemyCharacter] or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if EnemyCharacter:GetAttribute("Ragdolled") then
					warn("Enemy was ragdolled. Exited early")
					return
				end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Hit, nil, nil, false, true, true, true, false, nil)
				--removed finisher
				--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)

				if HitInfo.Countered == true then return end --Simple and easy

				local Finisher = HitInfo.Finisher == true
				Hit[EnemyCharacter] = true


				--if EnemyCharacter:HasTag("Ragdolled") then
				--	RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				--end

				--AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)


				EnemyCharacter:AddTag("CantRotate")

				--local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -7) * CFrame.Angles(0, math.pi, 0), 10)	
				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

				--local UserAnimation = NewAnimLocation.User

				--local UserTrack
				--local UserEvents = {}

				--local VictimTrack
				--local VictimEvents = {}


				--if Finisher then
					

				--else
					--UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
					--RemotesContainer.ClientEffects:FireAllClients("ZoroOniGiri", {
					--	Attacker  = Character,
					--	SkillType = "hit",            -- client plays hit sound/effect
					--})
					
					local Ended = false
					
					for enemyCharacter, data in pairs(Hit) do
						local enemyHumRP = enemyCharacter:FindFirstChild("HumanoidRootPart")
						local enemyHumanoid = enemyCharacter:FindFirstChild("Humanoid")

						local enemyPlayer = game.Players:GetPlayerFromCharacter(enemyCharacter)

						if enemyHumRP and enemyHumanoid then
							RagdollHandler.ragdoll(enemyHumanoid, 1.5)
							NewKnockback:Knockback(enemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * Vector3.new(20, 0 ,30)})
						end
						--DamageHandler:TakeDamage(Character, enemyHumanoid, 15, nil, nil, false, true, true, true, false, nil, nil)
					end
					if HitInfo.Finisher == true then
						DamageHandler:TakeDamage(Character, EnemyHumanoid, EnemyHumanoid.Health, nil, nil, false, false, false, true, true, nil, nil)

					end
					
					--local function EndFunction()
					--	task.spawn(function()
					--		if Ended then return end
					--		Ended = true


					--		for _,v in UserEvents do
					--			v:Disconnect()
					--		end


					--		StunHandler:Unstun(Character, Stun)
					--	end)
					--end

					

					--UserTrack.Stopped:Once(EndFunction)



					--ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

					--AnimationService:stopAll(Character)
					--AnimationService:playAnimation(Character, UserAnimation)
					
					
				--end

			end
			
			
			Hitbox:Start()
			task.delay(0.1, function()
				Hitbox:Destroy()
			end)
			SoundHandler:AddSound(MoveSounds.Zoro.Moves.OniGiri.Dash, HumRP)
			executeTeleport(HumRP, Character)

		end)

		

		StartTrack.Stopped:Once(function()
			
			Character:RemoveTag("CantRotate")

			for _,v in StartEvents do
				v:Disconnect()
			end


			--if Hit then return end

			StunHandler:Unstun(Character, Stun)
			
			Character:SetAttribute("ZoroThirdAbility", nil)

			Player:SetAttribute("AbilityThreeCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityThreeCooldown", false)
				end
			end)
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		
		SoundHandler:AddSound(MoveSounds.Zoro.Moves.OniGiri.Shing, HumRP)

		Character:AddTag("CantRotate")

		
		task.delay(0.5, function()
			RemotesContainer.ClientEffects:FireAllClients("ZoroOniGiri", {
				Attacker  = Character,
				SkillType = "OniGiri", 
				attackerLook = HumRP.CFrame.LookVector  -- add this
			})
		
			RemotesContainer.ClientEffects:FireAllClients("ZoroOniGiri", {
				Attacker  = Character,
				SkillType = "Lines", 
				attackerCFrame = HumRP.CFrame * CFrame.new(0, 0, -20),
			})
		end)
		--temp
		--RemotesContainer.ClientEffects:FireAllClients("ZoroOniGiri", {Attacker = Character, SkillType =  "start",})
	end
}