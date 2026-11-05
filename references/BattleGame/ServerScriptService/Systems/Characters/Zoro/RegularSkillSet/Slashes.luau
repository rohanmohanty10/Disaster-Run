local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).Zoro[2]
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


--local NewAnimLocation = ServerStorage.Assets.Animations.Sanji
local NewAnimLocation = ServerStorage.Assets.Animations.Zoro.Moveset.RegularMoveSet.Slashes


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set
local Animations = ServerStorage.Assets.Animations


local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

local sound1 = nil
local sound2 = nil
return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local Animator: Animator = Humanoid.Animator

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityTwoCooldown") then return end
		if Character:GetAttribute("ZoroSecondAbility") then return end
		
		Player:SetAttribute("AbilityTwoCooldown", true)
		Character:SetAttribute("ZoroSecondAbility", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end
		
		local Bind = Instance.new("StringValue");
		Bind.Parent = Character
		Bind.Name = "Barrage"
		--Bind:SetAttribute("Delay", 0.0001)
		Bind:SetAttribute("Delay", 0.0001)

		Bind:SetAttribute("Times", 1)


		--local Stun = StunHandler:Stun(Character, nil, true, 5, 0)
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local Hit = false
		local Finisher = false


		--local UserAnimation = MoveAnims.BaldHero["Consecutive Punches"].User
		local UserAnimation = NewAnimLocation.Miss

		local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
		local UserEvents = {}


		local HitTimes = {.100,  .150,  .250,  .334,  .400,  .445,  .500, .565,  .600,  .625,  .645,  .675,  .700,  .800, .900,  .1000,  1.1,  1.20,  1.30 }


		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.Name = "moveme"
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		BodyVelocity:SetAttribute("Speed", 60)
		BodyVelocity:SetAttribute("Fallout", .98)
		BodyVelocity:SetAttribute("End", 5)
		
		UserEvents["start"] = UserTrack:GetMarkerReachedSignal("start"):Once(function()	
			print("started")
			--BodyVelocity.Parent = HumRP	
		end)
		UserEvents["speedup"] = UserTrack:GetMarkerReachedSignal("speedup"):Once(function()	
			UserTrack:AdjustSpeed(1.75)
		end)
		UserEvents["slow"] = UserTrack:GetMarkerReachedSignal("slow"):Once(function()	
			UserTrack:AdjustSpeed(1)
			SoundHandler:StopSound(sound1, .2)
			--SoundHandler:AddSound(MoveSounds.Zoro.Moves.OniGiri.Shing, HumRP)


		end)

		UserEvents["barrage"] = UserTrack:GetMarkerReachedSignal("barrage"):Once(function()
			if BodyVelocity then
				BodyVelocity:Destroy()
				BodyVelocity = nil
			end
			
			sound1 = SoundHandler:AddSound(MoveSounds.Zoro.Moves.Slashes.Slashes2, HumRP)

			--UserTrack:AdjustSpeed(1.5)
			
			--RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {Char = Character, SkillType =  "newBarrage",  Bind = Bind})
			RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {Char = Character, SkillType =  "barrage",  Bind = Bind})
			
			local size = Vector3.new(1,1,1) * 24
			-- the barrage only breaks things on a few of its slashes (first, middle, last), not every one
			local CutOn = { [1] = true, [math.ceil(#HitTimes / 2)] = true, [#HitTimes] = true }
			for Index, delayTime in ipairs(HitTimes) do
				task.delay(delayTime, function()
					if not UserTrack.IsPlaying then return end

					local Hitbox = HitboxHandler.new()
					Hitbox.Instance = HumRP
					Hitbox.Size = size
					Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2 -1)
					Hitbox.Visualize = false
					Hitbox.onTouch = function(EnemyCharacter)
						local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
						local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
						local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

						if Finisher == true or EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

						--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0.75, 0.75, Animations.Combat.Hits[tostring(math.random(1, 1))], true, true, true, true, false, nil, 13)
						local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.BarrageHit, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, false, nil, 5)

						if HitInfo.Countered == true then
							return
						end

						if HitInfo.Blocked == true then
							return
						end
						
						Finisher = HitInfo.Finisher == true

						if Finisher  then
							Finisher = true
							EnemyCharacter:AddTag("CantRotate")
							local FinisherVictimStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
							
							if Bind then
								Bind:Destroy()
								Bind = nil
							end
							task.delay(.5, function()
								SoundHandler:StopSound(sound2, .2)
								SoundHandler:StopSound(sound1, .2)
								task.delay(.5, function()
									sound1 = nil
									sound2 = nil

								end)
							end)
							task.delay(0, function()
								local speedup = SoundHandler:AddSound(MoveSounds.Zoro.Moves.Slashes.Finisher, HumRP)
								speedup.PlaybackSpeed = 1.35
								
							end)
							task.delay(2.5, function()
								SoundHandler:AddSound(MoveSounds.Zoro.Moves.Slashes.katanaswirl2, HumRP)
								SoundHandler:AddSound(MoveSounds.Zoro.Moves.Tatsumaki.Sword.Skill2, HumRP)

								task.wait(.4)
								SoundHandler:AddSound(MoveSounds.Zoro.Moves.Slashes.explodeslash, HumRP)

							end)
							
							local UserFinisherAnimation = NewAnimLocation.Finisher

							local UserFinisherTrack = AnimationService:getAnimationTrack(Character, UserFinisherAnimation)
							local UserFinisherEvents = {}
							local frozen = false
							local DashDoneRemote = RemotesContainer.MoveSkills.ZoroSlashFinisherDash
							local DASH_TIMEOUT = 1.25 

							local dashConn

							UserFinisherEvents["dash"] = UserFinisherTrack:GetMarkerReachedSignal("dash"):Once(function()
								UserFinisherTrack:AdjustSpeed(.8) -- freeze the pose while the client closes the gap

								RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {
									Char = Character, SkillType = "FinisherDash", Enemy = EnemyCharacter,
								})

								local resumed = false
								local function resume()
									if resumed then return end
									resumed = true
									if dashConn then dashConn:Disconnect() dashConn = nil end
									UserFinisherTrack:AdjustSpeed(1) -- now the "start" marker can fire -> barrage
								end

								dashConn = DashDoneRemote.OnServerEvent:Connect(function(firingPlayer)
									if firingPlayer ~= Player then return end -- ignore everyone else's signals
									resume()
								end)

								task.delay(DASH_TIMEOUT, resume) -- fallback if the client never reports
							end)
							UserFinisherEvents["start"] = UserFinisherTrack:GetMarkerReachedSignal("start"):Once(function()
								UserFinisherTrack:AdjustSpeed(1)

								RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {Char = Character, SkillType =  "FinisherBarrage",  Enemy = EnemyCharacter})
								task.spawn(function()
									local StartTime = tick()
									local LoopTimes = 0
									local LastTime = 0
									while tick() - StartTime < 1 do
										if frozen then break end
										DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.FinisherTick, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, false, nil, 5)
										task.wait(.1)
									end
									--RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {Char = Character, SkillType =  "FinisherBarrageEnd",  Enemy = EnemyCharacter})

									
								end)

							end)
							
							UserFinisherEvents["slashfreeze"] = UserFinisherTrack:GetMarkerReachedSignal("slashfreeze"):Once(function()
								frozen = true  -- stop the barrage loop from overriding the pose

								local TempVic = NewAnimLocation.DamageFreeze
								local TempVicAnim = AnimationService:getAnimationTrack(EnemyCharacter, TempVic)

								AnimationService:stopAll(EnemyCharacter)
								AnimationService:playAnimation(EnemyCharacter, TempVic)
								TempVicAnim:AdjustSpeed(0)

								RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {Char = Character, SkillType = "FinisherFreeze", Enemy = EnemyCharacter})
							end)
							UserFinisherEvents["end"] = UserFinisherTrack:GetMarkerReachedSignal("end"):Once(function()
								

								-- spawn the corpse FIRST and let every client finish cloning
								RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {
									Char = Character, SkillType = "FinisherDismember", Enemy = EnemyCharacter,
								})

								task.wait(0.1) -- let clients clone the body before it gets killed/despawned

								DamageHandler:TakeDamage(Character, EnemyHumanoid, EnemyHumanoid.Health, nil, nil, false, false, true, true, true, nil, nil)

								RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {
									Char = Character, SkillType = "FinisherBarrageEnd", Enemy = EnemyCharacter,
								})
							end)
							
							UserFinisherTrack.Stopped:Once(function()
								if dashConn then dashConn:Disconnect() dashConn = nil end

								for _, c in UserFinisherEvents do
									c:Disconnect()
								end
								
								EnemyCharacter:RemoveTag("CantRotate")
								if FinisherVictimStun then
									StunHandler:Unstun(EnemyCharacter, FinisherVictimStun)
									FinisherVictimStun = nil
								end

								if Stun then
									StunHandler:Unstun(Character, Stun)
									Stun = nil
								end
								Character:SetAttribute("ZoroSecondAbility", nil)

								Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
								task.delay(CooldownTime, function()
									if Player then
										Player:SetAttribute("AbilityTwoCooldown", false)
									end
								end)
							end)

							AnimationService:stopAll(Character)
							AnimationService:stopAll(EnemyCharacter)
							AnimationService:playAnimation(Character, UserFinisherAnimation)
							
						else
							if EnemyPlayer then
								ReplicateEffects_Set:FireClient(EnemyPlayer, "ShakeCamera", { Intensity = 0.75, Last = .1 })
							end

							Hit = true

							task.delay(0.1,function()
								if not Hit then
									StunHandler:Stun(Character, nil, true, 5, 0)
								end
							end)
							
						end
						
						
					end

					task.delay(.033,function()
						Hitbox:Once()
						Hitbox:Destroy()

						if Hit then
							ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 0.75, Last = .1 })
						end
					end)
				end)
				
				task.delay(delayTime * 2, function()
					if not UserTrack.IsPlaying then return end

					if CutOn[Index] then
						DebreeService.Destroy(HumRP.CFrame * CFrame.new(0, 0, -size.Z / 2 - 1), Vector3.new(17, 17, 17), {
							Shape = "Box",
							Direction = HumRP.CFrame.LookVector,
							Power = 12,
							Attacker = Player,
							KeepGround = true,
						})
					end
				end)
			end
		end)
		UserEvents["finalslash"] = UserTrack:GetMarkerReachedSignal("finalslash"):Once(function()			
			--BV.Parent = HumRP
			SoundHandler:AddSound(MoveSounds.Zoro.Moves.OniGiri.Shing, HumRP)

			if Bind then
				Bind:Destroy()
				Bind = nil
			end
			task.wait(.15)
			--SoundHandler:StopSound(sound1, .2)

			SoundHandler:StopSound(sound2, .2)
			task.delay(.2, function()
				sound1 = nil
				sound2 = nil

			end)

			
		end)
		
		
		
		--UserEvents["end"] = UserTrack:GetMarkerReachedSignal("end"):Once(function()
		--	--print("Slashend")
		--	if Bind then
		--		Bind:Destroy()
		--		Bind = nil
		--	end


		--	UserTrack:AdjustSpeed(1)
		--	local Hitbox = HitboxHandler.new()
		--	Hitbox.Instance = HumRP
		--	Hitbox.Size = Vector3.new(1,1,1) * 16
		--	Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
		--	Hitbox.Visualize = true
		--	Hitbox.onTouch = function(EnemyCharacter)
		--		local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
		--		local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
		--		local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

		--		if Finisher == true or EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

		--		--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0.75, 0.75, Animations.Combat.Hits[tostring(math.random(1, 1))], true, true, true, true, false, nil, 13)
		--		local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1.5, nil, nil, false, EnemyCharacter:HasTag('DEATH') and true or false, true, true, false, nil, 3)

		--		Finisher = HitInfo.Finisher == true


				
		--		if Finisher  then
		--			Finisher = true
					
		--		else
		--			if EnemyPlayer then
		--				ReplicateEffects_Set:FireClient(EnemyPlayer, "ShakeCamera", { Intensity = 0.75, Last = .1 })
		--			end


		--			if
		--				EnemyCharacter:HasTag('Ragdolled') then
		--				Hit = true

		--				if Finisher then
		--					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, nil, nil, false, true)
		--				end
		--			else
		--				Hit = true

		--				task.delay(0.1,function()

		--					if not Hit then
		--						StunHandler:Stun(Character, nil, true, 5, 0)
		--					end
		--				end)
		--			end
					
		--		end


				
		--	end
		--	Hitbox:Once()
			
		--end)

		UserTrack.Stopped:Once(function()
			
			
			if Bind then
				Bind:Destroy()
				Bind = nil
			end

			for _,v in UserEvents do
				v:Disconnect()
			end

			-- if the finisher took over, keep the stun alive — it carries through the finisher
			if Finisher then return end

			if Stun then
				StunHandler:Unstun(Character, Stun)
				Stun = nil
			end
			
			Character:SetAttribute("ZoroSecondAbility", nil)

			Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityTwoCooldown", false)
				end
			end)
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)
		--UserTrack:AdjustSpeed(1.2)
		RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {Char = Character, SkillType =  "move"})
		sound2 = SoundHandler:AddSound(MoveSounds.Zoro.Moves.Slashes.Slashes3, HumRP)


	end
}