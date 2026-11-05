local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).WhiteBeard[1]
--[[
	Tremor Punch New (server)
	Location: ServerScriptService.Systems.Characters.WhiteBeard.RegularSkillSet["Tremor Punch New"]
	(Your original "Tremor Punch" is left untouched.)

	What changed vs. "Tremor Punch"
	  - Fires the "GuraPunchNew" client effect instead of "WhiteBeardFirstAbility".
	  - Hit-stop (JJS / ABA style) on the "hit" marker:
	      * You can aim through the start-up; turning locks the moment the punch lands.
	      * The server asks your client which way it faces then (TremorPunchAim), turns your body there
	        for everyone, and runs the hitbox + damage along it, so they match the crack exactly.
	      * For FREEZE_TIME (0.3s): the punch animation is paused (server-played, so it replicates to everyone)
	        and the attacker's + victims' HumanoidRootParts are anchored so nobody can move.
	      * Clients get FreezeTime + Victims so they pause the victims' animations and time the glass break.
	      * When the freeze ends: everyone is unanchored, the punch resumes, THEN knockback + ragdoll are applied,
	        and "ice shattering" plays (was a flat 0.5s delay).
	  - The orb's Bind is removed when the freeze ends (was 0.2s after the hit), so the orb lasts until the shatter.
]]

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
local AnimationService = require(ServerModules.AnimationService)
local iFramesService = require(ServerModules.iFramesService)

local SoundHandler = require(ReplicatedModules.SoundHandler)
local Velocity = require(ReplicatedStorage.Modules.Velocity)
local DebreeService = require(ServerModules.DebreeService)

local Trove = require(ReplicatedModules.Trove)

local Sounds = ReplicatedStorage.Assets.Sounds

local NewAnimLocation = ServerStorage.Assets.Animations["WhiteBeard"]

local ReplicateEffects_Set = RemotesContainer.Replicate.Set

local EFFECT_NAME = "GuraPunchNew"
local FREEZE_TIME = 0.3 -- hit-stop length (JJS Uro ~0.3s, ABA Whitebeard ~0.35s)

-- The punch aims where the attacker's own screen faces when it lands. The server's copy of a
-- player's rotation lags behind their screen, so after a fast turn the hitbox and the destruction
-- went somewhere else than the crack. At the hit the server asks the attacker's client which way
-- it faces (its rotation is locked by then) and waits at most AIM_WAIT for the answer.
local AimRemote: RemoteEvent? = RemotesContainer.MoveSkills:FindFirstChild("TremorPunchAim")
local AIM_WAIT = 0.3 -- seconds; past this (a very high ping) the server's own facing is used

-- The flat direction the attacker's client faces, or nil if it didn't answer in time.
local function WaitForAim(Player: Player, Character: Model): Vector3?
	if not AimRemote then
		return nil
	end
	local Answer: Vector3? = nil
	local Connection = AimRemote.OnServerEvent:Connect(function(Sender: Player, Look: any)
		if Sender == Player and typeof(Look) == "Vector3" then
			Answer = Look
		end
	end)
	RemotesContainer.ClientEffects:FireClient(Player, EFFECT_NAME, { Attacker = Character, SkillType = "Aim" })
	local Deadline = os.clock() + AIM_WAIT
	while Answer == nil and os.clock() < Deadline do
		task.wait()
	end
	Connection:Disconnect()

	local Look = if Answer then Vector3.new(Answer.X, 0, Answer.Z) else Vector3.zero
	if Look.Magnitude < 1e-3 or Look.Magnitude ~= Look.Magnitude then
		return nil
	end
	return Look.Unit
end

return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

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

		local Janitor = Trove.new()

		local StartAnimation: AnimationTrack = NewAnimLocation["Tremor Punch"].User
		local UserTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		StartEvents["pre hit"] = UserTrack:GetMarkerReachedSignal("pre hit"):Once(function()
			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["Tremor1"], HumRP, { FadeOut = 1 })
		end)

		StartEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
			-- The punch lands: aim locks, and the hit-stop starts (attacker frozen, punch paused)
			Character:AddTag("CantRotate")
			local anchored = {}
			local function lock(part: BasePart?)
				if part and part.Parent and not part.Anchored then
					part.AssemblyLinearVelocity = Vector3.zero
					part.Anchored = true
					table.insert(anchored, part)
				end
			end
			lock(HumRP)

			local trackSpeed = UserTrack.Speed
			if UserTrack.IsPlaying then
				UserTrack:AdjustSpeed(0)
			end

			-- Aim where the attacker's own screen faces, and turn the body there for everyone, so the
			-- crack, the hitbox and the destruction all point the same way
			local Look = WaitForAim(Player, Character)
			if not HumRP.Parent then
				return
			end
			local CFrameToUse = HumRP.CFrame
			if Look then
				-- your body already faces this way on your screen; this turns it for everyone else
				CFrameToUse = CFrame.lookAlong(HumRP.Position, Look)
				HumRP.CFrame = CFrameToUse
			end

			local NEAR_DIST = 5
			local FAR_DIST = 45

			local NEAR_DAMAGE, FAR_DAMAGE = MoveConfig.Damage.Near, MoveConfig.Damage.Far
			local NEAR_FORCE, FAR_FORCE = 60, 30
			local NEAR_LIFT, FAR_LIFT = 35, 15
			local NEAR_RAGDOLL, FAR_RAGDOLL = 2, 1

			local Victims = {} -- characters, sent to clients for the freeze
			local PendingKnockback = {} -- applied when the freeze ends

			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(20, 20, 50)
			Hitbox.Offset = CFrame.new(0, 0, -20)
			Hitbox.Visualize = true
			Hitbox.Ignore = { Character }
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if
					iFramesService:HasiFrame(EnemyCharacter, 2)
					or EnemyHumanoid.Health <= 0
					or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
				then
					return
				end

				local flat = (EnemyHumRP.Position - HumRP.Position) * Vector3.new(1, 0, 1)
				local dist = flat.Magnitude

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
					force *= 2
					upwardForce *= 2
					ragdollDuration *= 2
					hardRagdoll = true
				end

				if HitInfo.Countered == true then
					return
				end

				table.insert(Victims, EnemyCharacter)
				table.insert(PendingKnockback, {
					Character = EnemyCharacter,
					Humanoid = EnemyHumanoid,
					Velocity = CFrameToUse.LookVector * force + Vector3.new(0, upwardForce, 0),
					Ragdoll = ragdollDuration,
					Hard = hardRagdoll,
				})
			end

			Hitbox:Once()
			Hitbox:Destroy()

			-- Hit-stop: lock the victims in place too
			for _, enemy in Victims do
				lock(enemy:FindFirstChild("HumanoidRootPart"))
			end

			RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
				Attacker = Character,
				SkillType = "Hit",
				CFrameToUse = CFrameToUse,
				Seed = math.random(1, 2 ^ 5 - 1),
				FreezeTime = FREEZE_TIME,
				Victims = Victims,
			})


			task.delay(.1, function()
				SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"]["Tremor2"], HumRP)
			end)

			-- Freeze ends: release, resume, then launch.
			task.delay(FREEZE_TIME, function()
				for _, part in anchored do
					if part.Parent then
						part.Anchored = false
					end
				end

				if UserTrack.IsPlaying and UserTrack.Speed == 0 then
					UserTrack:AdjustSpeed(trackSpeed ~= 0 and trackSpeed or 1)
				end

				if Bind then
					Bind:Destroy()
					Bind = nil
				end

				for _, kb in PendingKnockback do
					local enemy = kb.Character
					if not enemy.Parent or kb.Humanoid.Health <= 0 then
						continue
					end

					if enemy:HasTag("Ragdolled") then -- Safety
						RagdollHandler.cancelRagdoll(kb.Humanoid, nil, false, nil, nil, true)
					end

					local VelocityObject = Velocity.new(enemy)
					VelocityObject.Settings.RemoveTime = 0.2
					VelocityObject.Settings.MaxForce = Vector3.new(100000, 100000, 100000)
					VelocityObject.Settings.Velocity = kb.Velocity
					VelocityObject:Fire()

					RagdollHandler.ragdoll(kb.Humanoid, kb.Ragdoll, kb.Hard, nil, nil, nil, true)
				end
				SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Tremor Punch"]["ice shattering"], HumRP)
				shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 9, Last = 0.4 } })
				local PunchCFrame = CFrameToUse * CFrame.new(0, 2, -22)
				local PunchSize = Vector3.new(16, 16, 40) -- the box everything inside is erased from
				local PUNCH_RIM = 4 -- studs of broken rubble around it on each side
				DebreeService.Erase(PunchCFrame, PunchSize, {
					Shape = "Box",
					GridSize = 4,
					--GroundGridSize = 4,
				})
				
				task.wait(.1)
				
				DebreeService.Destroy(PunchCFrame, PunchSize + Vector3.one * (2 * PUNCH_RIM), {
					Shape = "Box",
					Hollow = PunchSize, -- only the rim outside the erased box breaks
					Direction = CFrameToUse.LookVector, -- rim pieces fly the way you punched
					Power = 45,
					Lift = 4,
					GridSize = 3,        -- wall pieces for this move, in studs
					--GroundGridSize = 2,  -- floor pieces for this move, in studs
					KeepGround = true,
					Attacker = Player,
				})

				--DebreeService.Destroy(CFrameToUse * CFrame.new(0, 2, -22), Vector3.new(16, 16, 40), {
				--	Shape = "Box",
				--	Direction = CFrameToUse.LookVector,
				--	GridSize = 4,        -- wall pieces for this move, in studs
				--	GroundGridSize = 4,  -- floor pieces for this move, in studs
				--	Power = 45,
				--	Lift = 4,
				--	Attacker = Player,
				--})
			end)
		end)

		UserTrack.Stopped:Once(function()
			Character:RemoveTag("CantRotate")
			if Bind then
				Bind:Destroy()
				Bind = nil
			end

			for _, v in StartEvents do
				v:Disconnect()
			end

			task.delay(0.2, function()
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

		RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, { Attacker = Character, SkillType = "StartUp", Bind = Bind })

		SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Startup Sounds"]["GuraStart"], HumRP)
		SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Tremor Punch"]["gura_lmb2_sfx"], HumRP)
	end,
}
