local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).WhiteBeard[3]
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

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
local NewVelocity = require(ReplicatedStorage.Modules.Velocity)
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)
local PerfectKnockback = require(ServerModules.PerfectKnockback)


local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
local Velocity = require(ReplicatedStorage.Modules.Velocity)

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



local VoxelSerializer = require(ReplicatedModules.VoxelSerializer)


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
		if Player:GetAttribute("AbilityThreeCooldown") then
			return
		end

		Player:SetAttribute("AbilityThreeCooldown", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = 0.5
		end
		
		local OrbBind = Instance.new("StringValue")
		OrbBind.Parent = Character
		OrbBind.Name = "StompOrb"

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)		
		local GrabHit = false
		local InitalHitEnemy = nil

		local Janitor = Trove.new()
	
		local StartAnimation: AnimationTrack = NewAnimLocation["Stomp"].Full
		local UserTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}
		local groundConnection
		local launchHandle
		
		local function knockUpward(EnemyCharacter, EnemyHumanoid)
			local root = EnemyCharacter:FindFirstChild("HumanoidRootPart")

			DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.KnockUp, nil, nil, false, false, true, true, true, nil, nil)
			local VelocityObject = Velocity.new(EnemyCharacter)
			VelocityObject.Settings.RemoveTime = 0.2
			VelocityObject.Settings.MaxForce = Vector3.new(100000, 100000, 100000)
			VelocityObject.Settings.Velocity = Vector3.yAxis * 60
			VelocityObject.Settings.Spin = Vector3.new(
				(math.random() - 0.5) * 2,
				(math.random() - 0.5) * 2,
				(math.random() - 0.5) * 2
			).Unit * 8
			VelocityObject:Fire()

			RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)
		end
		

		StartEvents["jump"] = UserTrack:GetMarkerReachedSignal("jump"):Once(function()
			--launchHandle = DestructionHandler.attach(HumRP, {
			--	Size = Vector3.new(8, 8, 8),
			--	Shape = Enum.PartType.Ball,
			--	MaxDuration = 7,
			--	Player = Player,
			--	MinimumSize = 4,
			--	VoxelDestroyChance = .5,
			--	FlingDestroyChance = .5,
			--	Phasing = true,
			--	ExtrapolateWithPing = true,
			--	Shake = true,
			--	VoxelVelocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
			--	IgnoreFloor = true,
			--})
			
			local TakeOff = DebreeGround(HumRP.Position, 8)
			if TakeOff then
				DebreeService.Destroy(CFrame.new(TakeOff), Vector3.new(9, 9, 9), {
					Shape = "Ball",
					Outward = true,
					Power = 20,
					Lift = 6,
					Bounce = 8,
					Attacker = Player,
				})
			end
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(7, 10, 7)
			Hitbox.Offset = CFrame.new(0, 0, -3)
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)

				if EnemyCharacter == Character
					or iFramesService:HasiFrame(EnemyCharacter, 2)
					or EnemyHumanoid.Health <= 0
					or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
				then
					return
				end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Landing, nil, nil, true, true, true, true, true, nil, nil)
				
				if HitInfo.Blocked == true then return end
				if HitInfo.Countered == true then return end
				
				if EnemyCharacter:HasTag("Ragdolled") then --Safety
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				end
				
				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 3 } })
	
				local VelocityObject = Velocity.new(EnemyCharacter)
				VelocityObject.Settings.RemoveTime = .1 --0.4
				VelocityObject.Settings.MaxForce = Vector3.new(100000, 100000, 100000) --Force
				VelocityObject.Settings.Velocity =  HumRP.CFrame.LookVector * 55 + Vector3.yAxis * 17.5 --HumRP.CFrame.LookVector * 80 --+ Vector3.yAxis * 17.5 --KnockbackVelocity * 40 + Vector3.yAxis * 8.5
				VelocityObject:Fire()
			
				RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)
				
				InitalHitEnemy = EnemyCharacter -- We only want to grab the enemy who got hit by the first knee.
			end
			
			Hitbox:Once()
			Hitbox:Destroy()
			
			shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 5, Last = 0.1 } })

			-- Trail
			local limbNames = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" }
			for i, v in Character:GetChildren() do
				if v:IsA("BasePart") then
					if table.find(limbNames, v.Name) then
						RemotesContainer.Replicate.Set:FireAllClients(
							"armTrailEffect",
							{ char = Character, lifeTime = 0.875, limbName = v.Name }
						)
					end
				end
			end
			
			RemotesContainer.ClientEffects:FireAllClients(
				"WhiteBeardJumpStomp",
				{ Character = Character, SkillType = "Jump", StartTime = workspace:GetServerTimeNow() }
			)
			
			RemotesContainer.ClientEffects:FireAllClients(
				"WhiteBeardJumpStomp",
				{ Character = Character, SkillType = "Orb", Bind = OrbBind }
			)
			
			--for RockValue = 1, 2 do
			--	local Position = {
			--		Seed = math.random(1, 10) + RockValue,
			--		start = HumRP.Position + Vector3.new(0, 0.1, 0),
			--		["end"] = Vector3.new(0, -5, 0),
			--		amount = 6 + RockValue / 2,
			--		nosound = true,
			--		nosmoke = true, --RockValue > 2,
			--		sizemult = 0.25 * RockValue, -- size of the actual rocks
			--		size = 0.5 * RockValue, -- size of crater
			--		nodebris = true
			--	}
			--	ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
			--end
			
			-- Sounds
			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Jump Stomp"]["Jump"], HumRP)
			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Jump Stomp"]["Jump1"], HumRP)
			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Jump Stomp"]["gura_lmb2_sfx"], HumRP)				
		end)
		
		StartEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
			if launchHandle then
				launchHandle.Stop()
				launchHandle = nil
			end			
			
			if OrbBind then 
				OrbBind:Destroy()
				OrbBind = nil
			end
			
			local rp = RaycastParams.new()
			rp.FilterType = Enum.RaycastFilterType.Exclude
			rp.FilterDescendantsInstances = { Character, workspace.World.Visuals }
			rp.IgnoreWater = true
			local hit = workspace:Raycast(HumRP.Position, Vector3.new(0, -10, 0), rp)
			local origin = hit and hit.Position or HumRP.Position
			local CFrameToUse = CFrame.new(origin)
			
			DebreeService.Destroy(CFrameToUse, Vector3.new(22, 22, 22), {
				Shape = "Ball",
				Outward = true,
				Power = 45,
				Lift = 12,
				Bounce = 15,
				Attacker = Player,
			})

			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(25, 25, 25)
			Hitbox.Offset = HumRP.CFrame:ToObjectSpace(CFrameToUse)
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyPlayer: Player = Players:GetPlayerFromCharacter(EnemyCharacter)

				if iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead or EnemyCharacter == Character then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Shockwave, nil, nil, false, true, false, true, false, nil, nil)
				if HitInfo.Countered == true then return end

				local isGrabTarget = (InitalHitEnemy ~= nil) and (EnemyCharacter == InitalHitEnemy)
				local grabDistance = (EnemyHumRP.Position - origin).Magnitude

				if not isGrabTarget or GrabHit or grabDistance > 10 or HitInfo.Blocked then
					knockUpward(EnemyCharacter, EnemyHumanoid)
					return
				end

				GrabHit = true
								
				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end

				--DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, ServerStorage.Assets.Animations.Sanji.Concasse.ConHit, false, false, false, true, false, nil, 13) -- Look into this more.

				CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")
				EnemyCharacter:AddTag("CantRotate")
				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
				local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, 0), -1)

				local ArmBind = Instance.new("StringValue")
				ArmBind.Parent = Character
				ArmBind.Name = "Punch"
				
				local UserAnimation, VictimAnimation
				local UserTrack
				local UserEvents = {}

				local VictimTrack
				local VictimEvents = {}

				UserAnimation = ServerStorage.Assets.Animations.WhiteBeard.NewGrabAnims.user
				VictimAnimation = ServerStorage.Assets.Animations.WhiteBeard.NewGrabAnims.victim
				UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
				VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
		
				local Ended = false
				local function EndFunction()
					if Ended then return end
					Ended = true

					for _,v in UserEvents do
						v:Disconnect()
					end

					for _,v in VictimEvents do
						v:Disconnect()
					end

					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end
					
					if ArmBind then 
						ArmBind:Destroy()
						ArmBind = nil
					end

					if VictimTrack and VictimTrack.IsPlaying then
						VictimTrack:Stop()
					end

					if Stun then
						StunHandler:Unstun(Character, Stun)
						Stun = nil
					end
					
					if EnemyStun then
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						EnemyStun = nil
					end

					iFramesService:RemoveAlliFrames(Character)
					CollisionsModule:SetCollisionGroup(Character, "Players")

					Player:SetAttribute("AbilityThreeCooldown", CooldownTime)
					task.delay(CooldownTime, function()
						if Player then
							Player:SetAttribute("AbilityThreeCooldown", false)
						end
					end)
					
					--warn("Removed cd from grab")
				end
				
				UserEvents["userDespawn"] = Character.AncestryChanged:Connect(function(_, p) if not p then EndFunction() end end)
				VictimEvents["enemyDespawn"] = EnemyCharacter.AncestryChanged:Connect(function(_, p) if not p then EndFunction() end end)
				
				UserEvents["swing1"] = UserTrack:GetMarkerReachedSignal("swing1"):Once(function()
					SoundHandler:AddSound(MoveSounds.WhiteBeard["Jump Stomp"].Punches.Whoosh["2"], Character.Torso)
				end)
				
				UserEvents["hit1"] = UserTrack:GetMarkerReachedSignal("hit1"):Once(function()
					DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Combo1, nil, nil, false, false, false, true, false, nil, nil)
					SoundHandler:AddSound(MoveSounds.WhiteBeard["Jump Stomp"].Punches.NewHits["2"], Character.Torso)
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", {Intensity = 4 }})
				end)
				
				UserEvents["swing2"] = UserTrack:GetMarkerReachedSignal("swing2"):Once(function()
					SoundHandler:AddSound(MoveSounds.WhiteBeard["Jump Stomp"].Punches.Whoosh["3"], Character.Torso)
				end)
				
				UserEvents["hit2"] = UserTrack:GetMarkerReachedSignal("hit2"):Once(function()
					DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Combo2, nil, nil, false, false, false, true, false, nil, nil)
					SoundHandler:AddSound(MoveSounds.WhiteBeard["Jump Stomp"].Punches.NewHits["3"], Character.Torso)
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 5 }})
				end)
				
				UserEvents["charge"] = UserTrack:GetMarkerReachedSignal("charge"):Once(function()
					task.delay(.2, function()
						RemotesContainer.ClientEffects:FireAllClients(
							"GuraPunchNew",
							{ Attacker = Character, SkillType = "StartUp", Bind = ArmBind }
						)
					end)
					SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Startup Sounds"]["GuraStart2"], HumRP, {FadeOut = 1})
				end)
				
				UserEvents["hit3"] = UserTrack:GetMarkerReachedSignal("hit3"):Once(function()
					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end
					
					if ArmBind then 
						ArmBind:Destroy()
						ArmBind = nil
					end

					AnimationService:stopAnimation(EnemyCharacter, VictimAnimation, .5)					
					DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.ComboFinal, nil, nil, false, false, true, true, true, nil, nil)

					local VelocityObject =  Velocity.new(EnemyCharacter);
					VelocityObject.Settings.RemoveTime = 0.2
					VelocityObject.Settings.MaxForce = Vector3.new(10000, 10000, 10000)
					VelocityObject.Settings.Velocity = HumRP.CFrame.UpVector * 50
					VelocityObject:Fire()

					RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)
					
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 7, Last = 0.2 } })
					
					local Position = {
						Seed = math.random(1, 1000) + 1,
						start = Character.HumanoidRootPart.Position + Vector3.new(0, 0.1, 0),
						["end"] = Vector3.new(0, -20, 0), -- end means raycast down.
						amount = 7,
						nosound = true,
						nosmoke = true,
						sizemult = 0.45 * 1,
						size = 0.85 * 1.4, -- actual crater size
						nodebris = true,
					}
					
					local UnderYou = DebreeGround(HumRP.Position, 8)
					if UnderYou then
						DebreeService.Destroy(CFrame.new(UnderYou), Vector3.new(12, 12, 12), {
							Shape = "Ball",
							Outward = true,
							Power = 25,
							Lift = 8,
							Bounce = 10,
							Attacker = Player,
						})
					end
					
					ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
					
					RemotesContainer.ClientEffects:FireAllClients("WhiteBeardStompSlam", {Character = Character, SkillType =  "Slam"})
					
					SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["3.3"], HumRP)
					SoundHandler:AddSound(MoveSounds.WhiteBeard["Jump Stomp"].Punches.NewHits["4"], HumRP)
					task.delay(.7, function()
						SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Jump Stomp"]["glass_shatter_04"], HumRP)
					end)
				end)
				
				UserTrack.Stopped:Once(EndFunction)

				VictimTrack.Stopped:Once(function()
					iFramesService:RemoveAlliFrames(EnemyCharacter)
					EnemyCharacter:RemoveTag("CantRotate")
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					if EnemyStun then
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						EnemyStun = nil
					end
				end)

				iFramesService:AddBaseiFrames(Character)
				iFramesService:AddBaseiFrames(EnemyCharacter)

				ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

				if EnemyCharacter:HasTag('Ragdolled') then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, nil, nil, false, true)
				end

				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)
				AnimationService:playAnimation(Character, UserAnimation)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
				
				Weld:Start(.5, Player)
			end
			
			Hitbox:Once()
			Hitbox:Destroy()
			
			shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 7, Last = 0.2 } })
			
			RemotesContainer.ClientEffects:FireAllClients(
				"WhiteBeardJumpStomp",
				{ Character = Character, SkillType = "JumpSlam", Seed = math.random(1, 2^5 - 1), CFrameToUse = CFrameToUse}
			)
			
			--[[
			local Position = {
				Seed = math.random(1, 1000) + 1,
				start = Character.HumanoidRootPart.Position + Vector3.new(0, 0.1, 0),
				["end"] = Vector3.new(0, -15, 0), -- end means raycast down.
				amount = 7,
				nosound = true,
				nosmoke = true,
				sizemult = 0.55 * 1,
				size = 0.85 * 1.7, -- actual crater size
				nodebris = true,
			}
			ReplicateEffects_Set:FireAllClients('Ground Crater', Position)

			local Position2 = {
				Seed = math.random(1, 1000) + 2,
				start = Character.HumanoidRootPart.Position + Vector3.new(0, 0.1, 0),
				["end"] = Vector3.new(0, -15, 0),
				amount = 6 + 2 / 2,
				nosound = true,
				nosmoke = true,
				sizemult = 0.55 * 2,
				size = 0.85 * 3,
				nodebris = true,
			}
			ReplicateEffects_Set:FireAllClients('Ground Crater', Position2)
			]]
						
			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["3"], HumRP, { FadeOut = 1 })
			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["3.1"], HumRP)
			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Jump Stomp"].Impact, HumRP)
			task.delay(.4, function()
				SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Jump Stomp"]["ice shattering"], HumRP)
			end)
		end)
		
		
		UserTrack.Stopped:Once(function()
			if launchHandle then
				launchHandle.Stop()
				launchHandle = nil
			end			

			if OrbBind then 
				OrbBind:Destroy()
				OrbBind = nil
			end
			
			for _, v in StartEvents do
				v:Disconnect()
			end
			
			if not GrabHit then
				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end

				Player:SetAttribute("AbilityThreeCooldown", CooldownTime)
				task.delay(CooldownTime, function()
					if Player then
						Player:SetAttribute("AbilityThreeCooldown", false)
					end
				end)
				
				--warn("Removed cd from normal jump")
			end
		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
	end,
}
