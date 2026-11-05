local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).BlackBeard[2]
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
local NewVelocity = require(ReplicatedStorage.Modules.Velocity)
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)
local DebreeService = require(ServerStorage.SBGModules.DebreeService)


local SoundHandler = require(ReplicatedModules.SoundHandler)
local Velocity = require(ReplicatedStorage.Modules.Velocity)
--local VoxelSerializer = require(ReplicatedModules.VoxelSerializer)


local Trove = require(ReplicatedModules.Trove)

local Sounds = ReplicatedStorage.Assets.Sounds

local NewAnimLocation = ServerStorage.Assets.Animations["BlackBeard"]

local MoveSounds = Sounds.Characters

return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local Animator: Animator = Humanoid.Animator

		--iFramesService:AddAlliFrames(Character)
		if Character:HasTag("Stunned") then
			return
		end
		if Player:GetAttribute("AbilityTwoCooldown") then
			return
		end

		Player:SetAttribute("AbilityTwoCooldown", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = 0.5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local Hit = false
		local grabHit = false
		local Finisher = false

		local Janitor = Trove.new()
		local Container = {}
		local Assets = {}
		local function MoveChar(Params)
			for _, v in pairs(Container) do
				v:Destroy()
			end

			local BodyVelocity = Janitor:Add(Instance.new("BodyVelocity"))

			table.insert(Assets, BodyVelocity)
			table.insert(Container, BodyVelocity)

			BodyVelocity.Name = "moveme"
			BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000, 0)
			BodyVelocity:SetAttribute("Speed", Params.speed or 100)
			BodyVelocity:SetAttribute("Fallout", Params.fallout or 0.95)
			BodyVelocity:SetAttribute("End", Params.endd or 5)
			BodyVelocity.Parent = HumRP

			Debris:AddItem(BodyVelocity, Params.deletiontime or 5)
		end

		local BodyVelocity = Janitor:Add(Instance.new("BodyVelocity"))
		BodyVelocity.Name = "moveme"
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000, 0)
		BodyVelocity:SetAttribute("Speed", 45)
		BodyVelocity:SetAttribute("Fallout", 0.92)
		BodyVelocity:SetAttribute("End", 2)

		local BlackholeMiddleSound
		--local UserAnimation = MoveAnims.BaldHero["Consecutive Punches"].User
		local StartAnimation: AnimationTrack = NewAnimLocation.BlackHole.User

		local UserTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local hitList = {}
		StartEvents["start"] = UserTrack:GetMarkerReachedSignal("start"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients(
				"BlackBeardSecondAbility",
				{ Attacker = Character, SkillType = "start" }
			)
			local startTime = os.clock()
			task.spawn(function()
				while os.clock() - startTime < 0.6 do
					if not UserTrack.IsPlaying then
						return
					end

					local Hitbox = HitboxHandler.new()
					Hitbox.Instance = HumRP
					Hitbox.Size = Vector3.new(27, 5, 27)
					Hitbox.Offset = CFrame.new(0, -2, 0)
					Hitbox.Visualize = false
					Hitbox.onTouch = function(EnemyCharacter)
						local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
						local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
						local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

						if EnemyCharacter == Character
							or iFramesService:HasiFrame(EnemyCharacter, 2)
							or hitList[EnemyCharacter]
							or EnemyHumanoid.Health <= 0
							or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
						then
							return
						end

						local HitInfo = DamageHandler:TakeDamage(
							Character,
							EnemyHumanoid,
							MoveConfig.Damage.Pull,
							2,
							nil,
							true,
							true,
							true,
							true,
							true,
							nil,
							13
						) -- Damage handler adds stun

						if HitInfo.Countered == true then
							return
						end

						if HitInfo.Blocked == true then
							return
						end

						if not hitList[EnemyCharacter] then
							hitList[EnemyCharacter] = true
							local VictimAnimation = NewAnimLocation.BlackHole.Victim

							local VictimTrack
							local VictimEvents = {}
							VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)

							VictimTrack.Stopped:Once(function()
								for _, v in VictimEvents do
									v:Disconnect()
								end
							end)

							AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
						end
					end

					task.delay(0.033, function()
						Hitbox:Once()
						Hitbox:Destroy()
					end)
					task.wait(0.1)
				end
			end)

			--local results = DestructionHandler.destroy(Vector3.new(40,20,40), HumRP.CFrame * CFrame.new(0, -3, 0), Enum.PartType.Ball, {
			--	MinimumSize = 4,
			--	TimeToReset = 20,
			--	Player = Player,
			--	VoxelDestroyChance = 1,
			--	FlingDestroyChance = 1,
			--	SkipCustomizations = true,
			--	CaptureSnapshots = true,   -- new
			--	AbsorbSpecials = true,
			--	Visualize = false,
			--	IgnoreFloor = true,
			--	NoGlassShatter = true,
			--	AbsorbFlings = true,
			--})



			local pullAnchor = Instance.new("Attachment")
			pullAnchor.Name = "BlackHoleAnchor"
			pullAnchor.Position = Vector3.new(0, -2.9, 0) 
			pullAnchor.Parent = HumRP
			Debris:AddItem(pullAnchor, 6)
			
			DebreeService.Absorb(HumRP.CFrame * CFrame.new(0, -3, 0), Vector3.new(40, 20, 40), {
				Shape = "Oval",
				Target = pullAnchor,
				Attacker = Player,
				GridSize = 3,
			})

			--local snapshots = results.voxelSnapshots
			--local specials  = results.specialParts

			
			--local VoxelAbsorber = require(ServerStorage.Modules.DestructionHandler.VoxelAbsorber)
			--local groundSpecials = VoxelAbsorber.captureGroundSpecials(HumRP.CFrame * CFrame.new(0, -3, 0), Vector3.new(40, 20, 40), {
			--	MaxPieces = 150,
			--})
			--for _, p in groundSpecials do
			--	table.insert(specials, p)
			--end

			--if #snapshots > 0 or #specials > 0 then
			--	RemotesContainer.ClientEffects:FireAllClients("BlackBeardSecondAbility", {
			--		Attacker = Character,
			--		SkillType = "Voxels",
			--		voxelBuffer = #snapshots > 0 and VoxelSerializer.encode(snapshots) or nil,
			--		specialParts = specials,
			--		targetAttachment = pullAnchor,
			--	})
			--end

			SoundHandler:AddSound(MoveSounds.Parent.Crater["Huge Crater Rocks Rumbling"], HumRP)
			SoundHandler:AddSound(MoveSounds.Parent.Crater.CraterImpact, HumRP)
		end)

		StartEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
			for enemyCharacter, _ in pairs(hitList) do
				local enemyHumRP = enemyCharacter:FindFirstChild("HumanoidRootPart")
				local enemyHumanoid = enemyCharacter:FindFirstChild("Humanoid")

				if enemyHumRP and enemyHumanoid then
					-- DO YOUR SPECIAL THING HERE
					-- Example: Pull them toward Blackbeard
					local spike = ReplicatedStorage.Modules.ClientEffects.CharacterSkillEffects.BlackBeard.RegularSkillsSet.BlackBeardSecondAbility.Spikes.Spike3:Clone()
					spike.Transparency = 1
					spike.CFrame = CFrame.new(enemyHumRP.CFrame.Position)
					spike.Parent = workspace.World.Visuals
					Debris:AddItem(spike, 1)

					RemotesContainer.ClientEffects:FireAllClients("BlackBeardSecondAbility", {
						Attacker = Character,
						SkillType = "shards",
						spawnPosition = spike.CFrame * CFrame.new(0, 6, 0),
						index = 1.5,
					})
					RemotesContainer.ClientEffects:FireAllClients(
						"BlackBeardSecondAbility",
						{ Attacker = Character, SkillType = "hit", Location = spike.CFrame * CFrame.new(0, 6, 0) }
					)
					SoundHandler:AddSound(MoveSounds.BlackBeard.Hole.Spike.spikeslam, HumRP)
					SoundHandler:AddSound(MoveSounds.BlackBeard.Hole.Spike["spike form final"], HumRP)
					task.delay(1, function()
						SoundHandler:AddSound(MoveSounds.BlackBeard.Hole.Spike["spike slam big"], HumRP)
					end)

					local Hitbox = HitboxHandler.new()
					Hitbox.Instance = spike
					Hitbox.Size = Vector3.new(5, 10, 5)
					Hitbox.Offset = CFrame.new(0, -2, 0)
					Hitbox.onTouch = function(EnemyCharacter)
						local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
						local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
						local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

						if EnemyCharacter == Character
							or iFramesService:HasiFrame(EnemyCharacter, 2)
							or EnemyHumanoid.Health <= 0
							or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
						then
							return
						end
						
						local HitInfo = DamageHandler:TakeDamage(
							Character,
							EnemyHumanoid,
							MoveConfig.Damage.Burst,
							nil,
							nil,
							false,
							true,
							true,
							true,
							true,
							nil,
							13
						)

						if HitInfo.Countered == true then
							return
						end

						if EnemyCharacter:HasTag("Ragdolled") then --Safety
							RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
						end

						--AnimationService:stopAll(EnemyCharacter)
						AnimationService:stopAnimation(EnemyCharacter, NewAnimLocation.BlackHole.Victim, 0.2)

						--local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
						--BodyAngularVelocity.MaxTorque = Vector3.new(50000, 50000, 50000)
						--BodyAngularVelocity.AngularVelocity =
						--	Vector3.new(math.random(2.5, 5), math.random(2.5, 5), math.random(2.5, 5))
						--BodyAngularVelocity.Parent = EnemyHumRP
						--Debris:AddItem(BodyAngularVelocity, 0.1)

						local VelocityObject = Velocity.new(EnemyCharacter)
						VelocityObject.Settings.RemoveTime = 0.2
						VelocityObject.Settings.MaxForce = Vector3.new(10000, 10000, 10000) --Force
						VelocityObject.Settings.Velocity = HumRP.CFrame.UpVector * 50 -- + Vector3.yAxis * 8.5 --KnockbackVelocity * 40 + Vector3.yAxis * 8.5
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

					--print("Performing special effect on: " .. enemyCharacter.Name)
				end
			end

			task.delay(0.9, function()
				SoundHandler:AddSound(MoveSounds.BlackBeard.Hole["Blackhole Close (Fixed)"], HumRP)

				if BlackholeMiddleSound then
					SoundHandler:StopSound(BlackholeMiddleSound, 1)
				end
			end)
		end)

		UserTrack.Stopped:Once(function()
			for _, v in StartEvents do
				v:Disconnect()
			end

			task.delay(1, function()
				if Stun then
					--print("Unstunned")
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end
			end)

			Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityTwoCooldown", false)
				end
			end)
		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		SoundHandler:AddSound(MoveSounds.BlackBeard.Hole.Hole, HumRP)
		BlackholeMiddleSound = SoundHandler:AddSound(MoveSounds.BlackBeard.Hole["Blackhole Sound Middle"], HumRP)

		RemotesContainer.ClientEffects:FireAllClients(
			"BlackBeardSecondAbility",
			{ Attacker = Character, SkillType = "bodyAura" }
		)
	end,
}
