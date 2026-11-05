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
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


--local NewAnimLocation = ServerStorage.Assets.Animations.Sanji
local NewAnimLocation = ServerStorage.Assets.Animations.Sanji


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set
local Animations = ServerStorage.Assets.Animations


local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true


return {
	Start = function(Player: Player)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local Animator: Animator = Humanoid.Animator


		if Character:HasTag("Stunned") then return end
		if Character:HasTag("Ragdolled") then return end
		if Player:GetAttribute("ModeAbilityFourCooldown") then return end

		Player:SetAttribute("ModeAbilityFourCooldown", true)

		local CooldownTime = 12
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local Hit = false
		local enemyData = {}

		local destructionHandle
		local destructionHandle2

		local Finisher = false
		local WentDown = false

		-- landing listener; hoisted so an interrupted move can disconnect it
		local groundConnection

		-- Tear down a grabbed enemy's hold (align/attachments/stun/collision/tag).
		-- Used by the interrupt cleanup in UserTrack.Stopped; the normal "up" path
		-- fades AlignPos out smoothly instead of destroying it instantly.
		local function releaseEnemy(EnemyCharacter, data)
			if data.AlignPos and data.AlignPos.Parent then data.AlignPos:Destroy() end
			if data.AttackerAttachment and data.AttackerAttachment.Parent then data.AttackerAttachment:Destroy() end
			if data.EnemyAttachment and data.EnemyAttachment.Parent then data.EnemyAttachment:Destroy() end

			local enemyHumRP = data.HumRP
			if enemyHumRP and enemyHumRP.Parent then
				pcall(function()
					enemyHumRP:SetNetworkOwner(data.Player or nil)
				end)
				--enemyHumRP.AssemblyLinearVelocity = Vector3.zero
				--enemyHumRP.AssemblyAngularVelocity = Vector3.zero
			end

			--if data.EnemyStun then StunHandler:Unstun(EnemyCharacter, data.EnemyStun) end
			if EnemyCharacter and EnemyCharacter.Parent then
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
				EnemyCharacter:RemoveTag("CantRotate")
			end
		end

		local UserAnimation = NewAnimLocation.Mode.Vension.Miss

		local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
		local UserEvents = {}

		local loopSound1
		local loopSound2
		local loopFire
		local loopFire2
		local loopWind
		local loopKickSound

		UserEvents["jump"] = UserTrack:GetMarkerReachedSignal("jump"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("SanjiSpectre", {
				Attacker  = Character,
				SkillType = "jump",            
			})
			SoundHandler:AddSound(Sounds.Characters.Sanji.Venison.Jump, HumRP)
			SoundHandler:AddSound(Sounds.Characters.Sanji.Venison.Jump2, HumRP)
		end)

		local Hitbox = HitboxHandler.new()
		UserEvents["spinstart"] = UserTrack:GetMarkerReachedSignal("spinstart"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("SanjiSpectre", {
				Attacker  = Character,
				SkillType = "FlameBarrage",            
			})
			RemotesContainer.ClientEffects:FireAllClients("SanjiSpectre", {
				Attacker  = Character,
				SkillType = "spinstart",            
			})
			RemotesContainer.ClientEffects:FireAllClients("SanjiSpectre", {
				Attacker  = Character,
				SkillType = "spinEffects",            
			})

			loopSound1 = SoundHandler:AddSound(MoveSounds.Sanji.Venison.G.Loop1, HumRP)
			loopSound2 = SoundHandler:AddSound(MoveSounds.Sanji.Venison.G.Loop3, HumRP)
			loopFire = SoundHandler:AddSound(MoveSounds.Sanji.Venison.FlameLoop, HumRP)
			loopFire2 = SoundHandler:AddSound(MoveSounds.Sanji.Venison["Burning Fire"], HumRP)
			loopWind = SoundHandler:AddSound(MoveSounds.Sanji.Venison.SpinSoundLoop, HumRP)
			loopKickSound = SoundHandler:AddSound(MoveSounds.Sanji.Venison["Kick barrage"], HumRP)

			task.spawn(function()
				local startTime = os.clock()
				while os.clock() - startTime < 0.835 do
					ReplicateEffects_Set:FireAllClients('RockTrail', {
						Part     = HumRP,
						Settings = { "Side", 0.835, 0.5, 1, 0.05 },
						Offset   = Vector3.new(3, 0, 0)
					})
					ReplicateEffects_Set:FireAllClients('RockTrail', {
						Part     = HumRP,
						Settings = { "Side", 0.835, 0.5, 1, 0.05 },
						Offset   = Vector3.new(-3, 0, 0)
					})
					task.wait(0.2)
				end
			end)

			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(15, 15, 20)
			Hitbox.Offset = CFrame.new(0, 0, -18)
			Hitbox.Ignore = { Character }
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if enemyData[EnemyCharacter] then return end
				if iFramesService:HasiFrame(EnemyCharacter, 2) then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1.5, nil, nil, false, EnemyCharacter:HasTag('DEATH') and true or false, true, true, true, nil, 15)

				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				end

				EnemyCharacter:AddTag("CantRotate")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")
				--iFramesService:AddAlliFrames(EnemyCharacter)

				--local enemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
				RagdollHandler.ragdoll(EnemyHumanoid, 5, false, Character, nil, nil, false, {Cosmetic = true})

				-- attachment on attacker HumRP
				local AttackerAttachment = Instance.new("Attachment")
				--AttackerAttachment.Position = Vector3.new(0, -10, -8)
				AttackerAttachment.Position = Vector3.new(0, -10, -8)

				AttackerAttachment.Parent = HumRP

				-- attachment on enemy
				local EnemyAttachment = Instance.new("Attachment")
				EnemyAttachment.Parent = EnemyHumRP

				-- AlignPosition to pull enemy to attacker attachment
				local AlignPos = Instance.new("AlignPosition")
				AlignPos.Mode = Enum.PositionAlignmentMode.TwoAttachment
				AlignPos.Attachment0 = EnemyAttachment
				AlignPos.Attachment1 = AttackerAttachment
				AlignPos.MaxForce = 40000
				AlignPos.Responsiveness = 15  --was 15
				AlignPos.MaxVelocity = 60
				AlignPos.Parent = EnemyHumRP

				--pcall(function() EnemyHumRP:SetNetworkOwner(nil) end)
				pcall(function() EnemyHumRP:SetNetworkOwner(Player) end)


				enemyData[EnemyCharacter] = {
					--EnemyStun          = enemyStun,
					Player             = EnemyPlayer,
					Humanoid           = EnemyHumanoid,
					HumRP              = EnemyHumRP,
					AttackerAttachment = AttackerAttachment,
					EnemyAttachment    = EnemyAttachment,
					AlignPos           = AlignPos,
				}

				Hit = true

			end

			Hitbox:Start()

			task.wait(.2)
			--destructionHandle = DestructionHandler.attach(HumRP, {
			--	Size = Vector3.new(20, 20, 20),
			--	Shape = Enum.PartType.Ball,
			--	MaxDuration = 7,
			--	Player = Player,
			--	MinimumSize = 5,
			--	VoxelDestroyChance = .8,
			--	FlingDestroyChance = .8,
			--	Phasing = true,
			--	ExtrapolateWithPing = true,
			--	Shake = true,

			--	VoxelVelocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
			--})
		end)

		local Tag = os.clock() + Player.UserId

		local Bind = Instance.new("Accessory")
		Bind.Name = "SpectreDrop" .. Tag
		Bind.Parent = Character

		UserEvents["up"] = UserTrack:GetMarkerReachedSignal("up"):Once(function()
			if Hitbox then 
				Hitbox:Destroy()
				Hitbox = nil
			end
			SoundHandler:StopSound(loopSound1, .5)
			SoundHandler:StopSound(loopSound2, .5)
			SoundHandler:StopSound(loopFire, .5)
			SoundHandler:StopSound(loopFire2, .5)
			SoundHandler:StopSound(loopWind, .5)
			SoundHandler:StopSound(loopKickSound, .5)

			SoundHandler:AddSound(Sounds.Characters.Sanji.Venison["spinning kick barrage sfx"], HumRP)

			for EnemyCharacter, data in enemyData do
				local enemyHumRP = data.HumRP
				local enemyPlayer = data.Player
				local enemyHumanoid = data.Humanoid

				-- fade out the pull force smoothly instead of instant destroy
				if data.AlignPos and data.AlignPos.Parent then
					TweenService:Create(data.AlignPos, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						MaxForce = 0,
						MaxVelocity = 0,
					}):Play()
				end

				task.delay(0.1, function()
					if enemyHumRP and enemyHumRP.Parent then
						--pcall(function() enemyHumRP:SetNetworkOwner(nil) end)
						pcall(function()
							if data.Player then
								enemyHumRP:SetNetworkOwner(data.Player)
							else
								enemyHumRP:SetNetworkOwner(nil)
							end
						end)
						if enemyPlayer then
							--warn("cleared from player from if branch in venison")
							ReplicateEffects_Set:FireClient(data.Player, "zeroVelocities", { Char = EnemyCharacter} )
						else
							enemyHumRP.AssemblyLinearVelocity = Vector3.zero
							enemyHumRP.AssemblyAngularVelocity = Vector3.zero
						end
					end

					if data.AlignPos and data.AlignPos.Parent then data.AlignPos:Destroy() end
					if data.AttackerAttachment and data.AttackerAttachment.Parent then data.AttackerAttachment:Destroy() end
					if data.EnemyAttachment and data.EnemyAttachment.Parent then data.EnemyAttachment:Destroy() end
					
					if EnemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(enemyHumanoid, nil, false, nil, false, true)
					end
					
					RagdollHandler.ragdoll(enemyHumanoid, 2, false, nil, nil, nil, false)
					--RagdollHandler.cancelRagdoll(data.Humanoid, nil, false, nil, nil, true)
					--if data.EnemyStun then
					--	StunHandler:Unstun(EnemyCharacter, data.EnemyStun)
					--	data.EnemyStun = nil
					--end
					--iFramesService:RemoveAlliFrames(EnemyCharacter)
					--CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					--EnemyCharacter:RemoveTag("CantRotate")
				end)
			end
			enemyData = {}
			--for EnemyCharacter, data in enemyData do
			--	local enemyHumRP = data.HumRP

			--	-- destroy immediately, no delay
			--	if data.AlignPos and data.AlignPos.Parent then data.AlignPos:Destroy() end
			--	if data.AttackerAttachment and data.AttackerAttachment.Parent then data.AttackerAttachment:Destroy() end
			--	if data.EnemyAttachment and data.EnemyAttachment.Parent then data.EnemyAttachment:Destroy() end

			--	if enemyHumRP and enemyHumRP.Parent then
			--		pcall(function() enemyHumRP:SetNetworkOwner(nil) end)
			--		enemyHumRP.AssemblyLinearVelocity = Vector3.zero
			--		enemyHumRP.AssemblyAngularVelocity = Vector3.zero
			--	end

			--	StunHandler:Unstun(EnemyCharacter, data.EnemyStun)
			--	iFramesService:RemoveAlliFrames(EnemyCharacter)
			--	CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
			--	EnemyCharacter:RemoveTag("CantRotate")
			--end
			--enemyData = {}


			RemotesContainer.ClientEffects:FireAllClients("SanjiSpectre", {
				Attacker  = Character,
				SkillType = "FlameBarrageStop",            
			})
			RemotesContainer.ClientEffects:FireAllClients("SanjiSpectre", {
				Attacker  = Character,
				SkillType = "up",            
				Char      = Character, 
				BindName  = Bind.Name 
			})

			if destructionHandle then
				destructionHandle:Stop()
				destructionHandle = nil
			end

			--destructionHandle2 = DestructionHandler.attach(HumRP, {
			--	Size = Vector3.new(5, 5, 5),
			--	Shape = Enum.PartType.Ball,
			--	MaxDuration = 2,
			--	Player = Player,
			--	MinimumSize = 4,
			--	VoxelDestroyChance = .7,
			--	FlingDestroyChance = 1,
			--	Phasing = true,
			--	ExtrapolateWithPing = true,
			--	Shake = true,

			--	VoxelVelocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
			--})
		end)

		UserEvents["down"] = UserTrack:GetMarkerReachedSignal("down"):Once(function()
			WentDown = true


			local GoalPos = HumRP.Position - Vector3.new(0, 50, 0)
			local GroundRay = workspace:Raycast(HumRP.Position, Vector3.new(0, -100, 0), MapRayParams)
			if GroundRay then
				GoalPos = GroundRay.Position + Vector3.new(0, 3, 0)
			end

			task.wait(0.25)


			RemotesContainer.ClientEffects:FireAllClients("SanjiSpectre", {
				Attacker  = Character,
				SkillType = "down",    

				GoalCF = CFrame.lookAlong(GoalPos, HumRP.CFrame.LookVector)
			})

			--ReplicateEffects_Set:FireClient(Player, "whirlwinddrop", { Stage = "down", Char = Character, GoalCF = CFrame.lookAlong(GoalPos, HumRP.CFrame.LookVector) })	
			groundConnection = RemotesContainer.MoveSkills.SpectreDropLanded.OnServerEvent:Connect(function(firingPlayer, instance, position, normal)
				if firingPlayer ~= Player then return end
				groundConnection:Disconnect()
				groundConnection = nil
				local Hitbox = HitboxHandler.new()
				Hitbox.Instance = CFrame.lookAlong(GoalPos, HumRP.CFrame.LookVector)
				Hitbox.Size = Vector3.new(50, 20, 50)
				Hitbox.Ignore = { Character }
				Hitbox.onTouch = function(EnemyCharacter)
					local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
					local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
					--EnemyHumRP.AssemblyLinearVelocity = Vector3.zero
					--EnemyHumRP.AssemblyAngularVelocity = Vector3.zero

					if iFramesService:HasiFrame(EnemyCharacter, 2) then return end


					local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 12, nil, nil, false, false, false, true, true, nil, 13)

					--if ragdoll
					if EnemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
					end
					RagdollHandler.ragdoll(EnemyHumanoid, 2, false, Character, nil, nil, false)

					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(1, 100000, 1), Velocity = HumRP.CFrame.UpVector * 75, ApplyAngular = true })

					RemotesContainer.RagdollSound.Sound:FireAllClients("RagdollLandWatch", { Target = EnemyCharacter })
				end

				Hitbox:Once()
				Hitbox:Destroy()

				if destructionHandle2 then
					destructionHandle2:Stop()
					destructionHandle2 = nil
				end

				local EndAnimation = NewAnimLocation.Mode.Vension.EndSlam
				local EndTrack = AnimationService:getAnimationTrack(Character, EndAnimation)

				EndTrack.Stopped:Once(function()
					if Stun then
						StunHandler:Unstun(Character, Stun)
						Stun = nil
					end
				end)
				AnimationService:stopAll(Character)
				AnimationService:playAnimation(Character, EndAnimation)

				for RockValue = 1, 3 do
					local Position = {
						Seed = math.random(1, 8) + RockValue, 
						start = HumRP.Position + Vector3.new(0, 0.10000000149011612, 0, 0), 
						["end"] = Vector3.new(0, -80, 0), 
						amount = 6 + RockValue / 2, 
						nosound = true, 
						nosmoke = true
					}

					local minusValue = false
					if RockValue <= 2 then
						minusValue = {
							minus = 0
						}
					end

					Position.stronger = minusValue
					Position.sizemult = 0.55 * RockValue
					Position.size = 0.85 * RockValue

					ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
				end

				RemotesContainer.ClientEffects:FireAllClients("SanjiSpectre", {
					Attacker  = Character,
					SkillType = "explosion",            

				})
				RemotesContainer.ClientEffects:FireAllClients("SanjiSpectre", {
					Attacker  = Character,
					SkillType = "GroundVFX",
					Position = HumRP.CFrame,
				})
				SoundHandler:AddSound(Sounds.Characters.Sanji.Venison.DiveBombExplosion, HumRP)
				local TempFlame = SoundHandler:AddSound(Sounds.Characters.Sanji.Venison.FlameLoop, HumRP)
				task.delay(.5, function()
					SoundHandler:StopSound(TempFlame, 1)
				end)
				ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 15, Last = .5 })

				--local results = DestructionHandler.destroy(
				--	Vector3.new(55, 35, 55),
				--	CFrame.new(position),
				--	Enum.PartType.Ball,
				--	{
				--		MinimumSize = 5,
				--		TimeToReset = 60,
				--		Player = Player,
				--		VoxelDestroyChance = .8,
				--		FlingDestroyChance = 1,
				--		VoxelVelocity = function(voxel, hitPos)
				--			local outward = voxel.Position - hitPos
				--			outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
				--			return outward * math.random(40, 80) + Vector3.new(0, 20, 0)
				--		end,
				--	}
				--)
			end)

		end)



		UserTrack.Stopped:Once(function()
			for _,v in UserEvents do
				v:Disconnect()
			end
			
			if Hitbox then
				Hitbox:Destroy()
				Hitbox = nil
			end
			-- disconnect the landing listener if we never landed (avoids a leaked
			-- connection when the move is cut short mid-air)
			if groundConnection then
				groundConnection:Disconnect()
				groundConnection = nil
			end

			-- release any still-grabbed enemies. The "up" marker normally already
			-- cleared enemyData; this only does work when the move was interrupted
			-- after a grab but before "up", which would otherwise leave them
			-- pulled/welded/stunned indefinitely.
			for EnemyCharacter, data in enemyData do
				releaseEnemy(EnemyCharacter, data)
			end
			
			enemyData = {}

			if Bind then
				Bind:Destroy()
				Bind = nil
			end

			if Stun then
				StunHandler:Unstun(Character, Stun)
				Stun = nil
			end

			if destructionHandle then
				destructionHandle:Stop()
				destructionHandle = nil
			end
			if destructionHandle2 then
				destructionHandle2:Stop()
				destructionHandle2 = nil
			end

			Player:SetAttribute("ModeAbilityFourCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("ModeAbilityFourCooldown", false)
				end
			end)

		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)
	end
}