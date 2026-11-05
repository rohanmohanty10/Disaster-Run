local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).WhiteBeard[4]
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
--local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
local Velocity = require(ReplicatedModules.Velocity)

local DebreeService = require(ServerModules.DebreeService)
-- Debree: the ground under a point (the map and rubble only), or nil
local DebreeGroundRay = RaycastParams.new()
DebreeGroundRay.FilterType = Enum.RaycastFilterType.Include
DebreeGroundRay.FilterDescendantsInstances = { workspace.World.Map, DebreeService.GetBodiesFolder() }
DebreeGroundRay.RespectCanCollide = true
local function DebreeGround(Position: Vector3, Depth: number): Vector3?
	local Hit = workspace:Raycast(Position, Vector3.new(0, -Depth, 0), DebreeGroundRay)
	return Hit and Hit.Position
end


local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


--local NewAnimLocation = ServerStorage.Assets.Animations.Sanji
local NewAnimLocation = ServerStorage.Assets.Animations["WhiteBeard"]


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set
local Animations = ReplicatedStorage.Assets.Animations


local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local Animator: Animator = Humanoid.Animator

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityFourCooldown") then return end

		Player:SetAttribute("AbilityFourCooldown", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		
		local StompOrbBind = Instance.new("StringValue")
		StompOrbBind.Parent = Character
		StompOrbBind.Name = "Stomp Orb" 
		
		local IslandShakingBind = Instance.new("StringValue")
		IslandShakingBind.Parent = Character
		IslandShakingBind.Name = "Air Pull"

		local Hit = false
		local grabHit = false
		local Finisher = false
		local EnemyCharacter = nil
		
		local finished = false
		local function finish()
			if finished then return end
			finished = true

			if Stun then
				StunHandler:Unstun(Character, Stun)
				Stun = nil
			end
			
			if IslandShakingBind then 
				IslandShakingBind:Destroy()
			end

			Character:SetAttribute("HoldingBlastClutch", nil)

			Player:SetAttribute("AbilityFourCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player and Player.Parent then
					Player:SetAttribute("AbilityFourCooldown", false)
				end
			end)
		end
		
		task.delay(10, finish)
		
		local function playIslandShaking()
			local IslandShaking = NewAnimLocation["Leg Stomp"]["AirPull"]
			local IslandShakingTrack = AnimationService:getAnimationTrack(Character, IslandShaking)
			local IslandShakingEvents = {}
			
			local windSound
			local slamdSound
			
			IslandShakingEvents["charge"] = IslandShakingTrack:GetMarkerReachedSignal("charge"):Once(function()
				RemotesContainer.ClientEffects:FireAllClients("WhiteBeardBlastClutch", {
					Character = Character, SkillType = "Main", Bind = IslandShakingBind, 
				})
				SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Startup Sounds"].GuraStart, HumRP)
			end)
			
			IslandShakingEvents["charge ready"] = IslandShakingTrack:GetMarkerReachedSignal("charge ready"):Once(function()
				--RemotesContainer.ClientEffects:FireAllClients("WhiteBeardBlastClutch", {
				--	Character = Character, SkillType = "Ground", Scale = 1,
				--})
				--slamdSound = SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Air Pull"]["Gura slam (better quality)"], HumRP)
			end)
			
			IslandShakingEvents["sound"] = IslandShakingTrack:GetMarkerReachedSignal("sound"):Once(function()
				if windSound then
					SoundHandler:StopSound(windSound, 1)
				end
			end)
			
			IslandShakingEvents["pre"] = IslandShakingTrack:GetMarkerReachedSignal("pre"):Once(function()
				RemotesContainer.ClientEffects:FireAllClients("WhiteBeardBlastClutch", {
					Character = Character, SkillType = "Pre", Scale = 1,
				})
				--SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["4"], HumRP)
				SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["4"], HumRP, {FadeOut = 1})
				SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["4.1"], HumRP)
				SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["4.2"], HumRP)
				
				--task.delay(2, function()
				--	if slamdSound then
				--		SoundHandler:StopSound(slamdSound, 1)
				--	end
				--end)
				
			end)

			IslandShakingEvents["slam"] = IslandShakingTrack:GetMarkerReachedSignal("slam"):Once(function()
				if IslandShakingBind then 
					IslandShakingBind:Destroy()
				end
				
				local Hitbox = HitboxHandler.new()
				Hitbox.Instance = HumRP
				Hitbox.Size = Vector3.new(40, 60, 40) --8, 12, 8
				Hitbox.Offset = CFrame.new(0, (Hitbox.Size.Y / 2) - 3, 0)
				Hitbox.Ignore = { Character }
				Hitbox.Visualize = false
				Hitbox.onTouch = function(EnemyCharacter)
					local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
					local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
					local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

					if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

					local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Stomp, nil, nil, false, true, true, true, true, nil, nil)
					if HitInfo.Countered == true then return end 

					grabHit = true
					local Finisher = HitInfo.Finisher == true


					if EnemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
					end


					shared.fireTo(ReplicateEffects_Set, { EnemyPlayer }, { "ShakeCamera", { Intensity = 5 } })

					local VelocityObject = Velocity.new(EnemyCharacter)
					VelocityObject.Settings.RemoveTime = 0.3
					VelocityObject.Settings.MaxForce = Vector3.new(200000, 200000, 200000)
					VelocityObject.Settings.Velocity = Vector3.yAxis * 80
					VelocityObject.Settings.Spin = Vector3.new(
						(math.random() - 0.5) * 2,
						(math.random() - 0.5) * 2,
						(math.random() - 0.5) * 2
					).Unit * 8
					VelocityObject:Fire()

					RagdollHandler.ragdoll(EnemyHumanoid, 3, nil, nil, nil, nil, true)		
					
					RemotesContainer.RagdollSound.Sound:FireAllClients("RagdollLandWatch", { Target = EnemyCharacter })

				end

				Hitbox:Once()
				Hitbox:Destroy()
				
				RemotesContainer.ClientEffects:FireAllClients("WhiteBeardBlastClutch", {
					Character = Character, SkillType = "Slam", Scale = 1, Seed = math.random(1, 2^5 - 1),
				})

				shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 8, Last = 0.3 } })		
				
				local SlamGround = DebreeGround(HumRP.Position, 10)
				if SlamGround then
					DebreeService.Destroy(CFrame.new(SlamGround), Vector3.new(30, 30, 30), {
						Shape = "Ball",
						Outward = true,
						Power = 50,
						Lift = 20,
						Bounce = 20,
						GridSize = 3,        -- wall pieces for this move, in studs
						GroundGridSize = 3,  -- floor pieces for this move, in studs
						Attacker = Player,
					})
				end
				
				--local Position2 = {
				--	Seed = math.random(1, 1000) + 2,
				--	start = Character.HumanoidRootPart.Position + Vector3.new(0, 0.1, 0),
				--	["end"] = Vector3.new(0, -20, 0),
				--	amount = 10,
				--	nosound = true,
				--	nosmoke = true,
				--	sizemult = 0.55 * 3, -- actual individual rock size
				--	size = 0.85 * 5, -- crater size
				--	nodebris = true,
				--}
				--ReplicateEffects_Set:FireAllClients('Ground Crater', Position2)
			end)

			IslandShakingEvents["recover"] = IslandShakingTrack:GetMarkerReachedSignal("recover"):Once(function()
				-- Endlag over; free the caster while the animation plays out.
				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end
			end)

			IslandShakingTrack.Stopped:Once(function()
				for _, conn in IslandShakingEvents do
					conn:Disconnect()
				end
			
				table.clear(IslandShakingEvents)
				finish()
			end)
			
			AnimationService:stopAll(Character)
			AnimationService:playAnimation(Character, IslandShaking)
			
			windSound = SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Air Pull"].gura_island_shaker_sfx, HumRP)
		end
		

		local Janitor = Trove.new()
	
		local CurrentIndex = 0
		
		local StartAnimation = NewAnimLocation["Leg Stomp"].Start		

		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}
		
		StartEvents["grab"] = StartTrack:GetMarkerReachedSignal("grab"):Once(function()
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(10, 10, 10) --8, 12, 8
			Hitbox.Offset = CFrame.new(0, (Hitbox.Size.Y / 2) - 3, -5)
			Hitbox.Ignore = { Character }
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				--if Hit == true or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if grabHit == true or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				grabHit = true


				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Grab, nil, nil, false, true, true, true, true, nil, nil)
				if HitInfo.Countered == true then return end 


				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end

				
				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 5 } })
				
				local VelocityObject = Velocity.new(EnemyCharacter)
				VelocityObject.Settings.RemoveTime = 0.3
				VelocityObject.Settings.MaxForce = Vector3.new(200000, 200000, 200000)
				VelocityObject.Settings.Velocity = Vector3.yAxis * 80
				VelocityObject.Settings.Spin = Vector3.new(
					(math.random() - 0.5) * 2,
					(math.random() - 0.5) * 2,
					(math.random() - 0.5) * 2
				).Unit * 8
				VelocityObject:Fire()
		
				RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)		
			end

			Hitbox:Once()
			Hitbox:Destroy()
			
			RemotesContainer.ClientEffects:FireAllClients("WhiteBeardStompSlam", {Character = Character, SkillType =  "Slam"})
			shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 4 } })

			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["LegStomp"], HumRP, {FadeOut = 1})
			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["LegStomp2"], HumRP)
			task.delay(.7, function()
				SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Leg Slam"]["Frame Freeze Shatter"], HumRP)
			end)
			
			local Stomp = DebreeGround((HumRP.CFrame * CFrame.new(0, 0, -2.5)).Position, 8)
			if Stomp then
				DebreeService.Destroy(CFrame.new(Stomp), Vector3.new(10, 10, 10), {
					Shape = "Ball",
					Outward = true,
					Power = 25,
					Lift = 8,
					Bounce = 10,
					Attacker = Player,
					GridSize = 3,        -- wall pieces for this move, in studs
					GroundGridSize = 3,  -- floor pieces for this move, in studs
				})
			end

			--for RockValue = 1, 1 do
			--	local Position = {
			--		Seed = math.random(1, 10) + RockValue,
			--		start =  (Character.HumanoidRootPart.CFrame * CFrame.new(.1, .1, -2.12)).Position, --HumRP.Position + Vector3.new(0, 0.1, 0),
			--		["end"] = Vector3.new(0, -5, 0),
			--		amount = 6 + RockValue / 2,
			--		nosound = true,
			--		nosmoke = true,
			--		sizemult = 0.35 * RockValue, -- size of the actual rocks
			--		size = 0.5 * RockValue, -- size of the crater
			--		nodebris = true
			--	}
			--	ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
			--end
		end)

		StartEvents["fissure"] = StartTrack:GetMarkerReachedSignal("fissure"):Once(function()		
			if StompOrbBind then
				StompOrbBind:Destroy()
				StompOrbBind = nil
			end
			
			if grabHit == true then return end
			
			--local Position = {
			--	Seed = math.random(1, 10) + 1,
			--	start =  (Character.HumanoidRootPart.CFrame * CFrame.new(.25, .1, -2.12)).Position, --HumRP.Position + Vector3.new(0, 0.1, 0),
			--	["end"] = Vector3.new(0, -5, 0),
			--	amount = 6 + 1 / 2,
			--	nosound = true,
			--	nosmoke = true,
			--	sizemult = 0.35 * 1, -- size of the actual rocks
			--	size = 0.5 * 1, -- size of the crater
			--	nodebris = true
			--}
			--ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
			local CFrameToUse = HumRP.CFrame 
			local Range = 11 --12.5
			
			local FISSURE_CRATER_STEPS = {
				[1] = { amount = 5, sizemult = 0.25, size = 0.3},
				[2] = { amount = 7, sizemult = 0.6, size = 0.6 },
				[3] = { amount = 7, sizemult = 0.8, size = 0.7 },
				[4] = { amount = 7, sizemult = 1,  size = .8 },
			}
			
			--local StartLookVector = Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector
			--local Offset = CFrame.lookAlong(Character:FindFirstChild("HumanoidRootPart").Position, StartLookVector) * CFrame.new(0.5, 0, -(5 * Range))
			--local crater = FISSURE_CRATER_STEPS[4]
			--ReplicateEffects_Set:FireAllClients('Ground Crater', {
			--	Seed = math.random(1, 10) + 5,
			--	start = Offset.Position + Vector3.new(0, 0.1, 0),
			--	["end"] = Vector3.new(0, -5, 0),
			--	amount = crater.amount,
			--	sizemult = crater.sizemult,
			--	size = crater.size,
			--	nosound = true,
			--	nosmoke = true,
			--	nodebris = true,
			--})
			local EXTRA_REACH = { 3.5, 4.5, 6.6, 11 }
			local FISSURE_DAMAGE   = MoveConfig.Damage.Fissure   -- per Index; far end hits hardest
			local FISSURE_KB_UP    = { 25, 32, 42, 55 } -- upward launch grows with distance
			local FISSURE_KB_FWD   = { 10, 14, 20, 30 } -- outward-along-fissure launch grows too
			local CAMERA_SHAKE     = { 1, 1.5, 2, 2.5 }  -- camera shake grows with distance
	
			for Index = 1, 4 do
				CurrentIndex = Index
				local StartLookVector = Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector
				local Offset = CFrame.lookAlong(Character:FindFirstChild("HumanoidRootPart").Position, StartLookVector) * CFrame.new(0.5, 0, -(Index * Range))
				if Index == 4 then
					Offset = CFrame.lookAlong(Character:FindFirstChild("HumanoidRootPart").Position, StartLookVector) * CFrame.new(0.5, 0, -(Index * Range) -11)
				end
				if Index == 3 then
					Offset = CFrame.lookAlong(Character:FindFirstChild("HumanoidRootPart").Position, StartLookVector) * CFrame.new(0.5, 0, -(Index * Range) -6.6)
				end
				if Index == 2 then
					Offset = CFrame.lookAlong(Character:FindFirstChild("HumanoidRootPart").Position, StartLookVector) * CFrame.new(0.5, 0, -(Index * Range) -4.5)
				end
				if Index == 1 then
					Offset = CFrame.lookAlong(Character:FindFirstChild("HumanoidRootPart").Position, StartLookVector) * CFrame.new(0.5, 0, -(Index * Range) -3.5)
				end
				
				local reach = (Index * Range) + EXTRA_REACH[Index]
				local hitboxOffset = CFrame.new(0.5, 0, -reach)
				local worldCF = CFrame.lookAlong(HumRP.Position, HumRP.CFrame.LookVector) * hitboxOffset

				
				local Hitbox = HitboxHandler.new()
				Hitbox.Instance = HumRP
				Hitbox.Size = Vector3.new(10, 10, 10) --8, 12, 8
				Hitbox.Offset = hitboxOffset
				Hitbox.Ignore = { Character }
				Hitbox.Visualize = false
				Hitbox.onTouch = function(EnemyCharacter)
					local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
					local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
					local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

					if iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

					local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, FISSURE_DAMAGE[Index], nil, nil, true, true, true, true, true, nil, nil)
					if HitInfo.Blocked == true then return end
					if HitInfo.Countered == true then return end

					if EnemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
					end

					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 5 } })
					
					local fwd = HumRP.CFrame.LookVector * Vector3.new(1, 0, 1)
					fwd = fwd.Magnitude > 0.01 and fwd.Unit or HumRP.CFrame.LookVector

					local VelocityObject = Velocity.new(EnemyCharacter)
					VelocityObject.Settings.RemoveTime = 0.3
					VelocityObject.Settings.MaxForce = Vector3.new(200000, 200000, 200000)
					VelocityObject.Settings.Velocity = fwd * FISSURE_KB_FWD[Index] + Vector3.yAxis * FISSURE_KB_UP[Index]
					VelocityObject.Settings.Spin = Vector3.new(
						(math.random() - 0.5) * 2,
						(math.random() - 0.5) * 2,
						(math.random() - 0.5) * 2
					).Unit * 8
					VelocityObject:Fire()

					RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)				
				end

				Hitbox:Once()
				Hitbox:Destroy()
				
				--DestructionHandler.destroy(Vector3.new(10,15,10), Offset, Enum.PartType.Block, {
				--	MinimumSize = 4,
				--	TimeToReset = 20,
				--	Player = Player,
				--	VoxelDestroyChance = .7,
				--	FlingDestroyChance = .5,
				--	Visualize = false,
				--	IgnoreFloor = true,
				--	VoxelVelocity = function(voxel, hitPos)
				--		local outward = voxel.Position - hitPos
				--		outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
				--		return outward * math.random(40, 70) + Vector3.new(0, 20, 0)
				--	end,
				--})
				
				local FissureFlat = Vector3.new(StartLookVector.X, 0, StartLookVector.Z)
				local Crack = DebreeGround(worldCF.Position + Vector3.new(0, 5, 0), 30)
				if Crack and FissureFlat.Magnitude > 1e-3 then
					DebreeService.Destroy(CFrame.lookAlong(Crack, FissureFlat), Vector3.new(8, 8, 12), {
						Shape = "Box",
						Direction = Vector3.new(0, -1, 0),
						Bounce = 34 + Index * 4, -- 38 to 50 studs/s: the floor jumps about 4 to 6.5 studs (JJS's Turbulence)
						Attacker = Player,
						GridSize = 3,        -- wall pieces for this move, in studs
						GroundGridSize = 3,  -- floor pieces for this move, in studs
					})
				end
				
				RemotesContainer.ClientEffects:FireAllClients("WhiteBeardStompSlam", {Character = Character, SkillType =  "Fissure", CFrameToUse = CFrameToUse, Index = Index, Offset = Offset})
				SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Leg Slam"].Fissure1, Offset)
				--SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Leg Slam"].Fissure2, Offset)
				--SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Leg Slam"].Fissure3, Offset)
				
				shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = CAMERA_SHAKE[Index] } })

				task.wait(0.15)
			end
		end)
		
		StartEvents["optionalFollowup"] = StartTrack:GetMarkerReachedSignal("optionalFollowup"):Once(function()	
			if grabHit then
				playIslandShaking()
			end
		end)
		
		StartTrack.Stopped:Once(function()
			for _, conn in StartEvents do
				conn:Disconnect()
			end
			
			table.clear(StartEvents)

			if not grabHit then
				finish()
			end
		end)


		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		
		task.delay(.2, function()
			if StompOrbBind then
				RemotesContainer.ClientEffects:FireAllClients("WhiteBeardStompSlam", {Character = Character, SkillType =  "Orb", Bind = StompOrbBind})
			end
		end)
		
		--SoundHandler:AddSound(MoveSounds.WhiteBeard["Leg Slam"].gura_lmb2_sfx, HumRP)
		SoundHandler:AddSound(MoveSounds.WhiteBeard["Leg Slam"].GuraStart, HumRP)
		SoundHandler:AddSound(MoveSounds.WhiteBeard["Leg Slam"].whoosh, HumRP)
	end
}