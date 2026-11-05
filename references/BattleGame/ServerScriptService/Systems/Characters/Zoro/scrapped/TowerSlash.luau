-- WithdrawSlash (server) — Nanami "Withdraw", single unblocked outcome.
-- Backstep windup -> forward lunge -> heavy slash -> uppercut knockback.
-- Dashes + VFX run on clients via RemotesContainer.ClientEffects ("Withdraw").

local ServerStorage     = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService    = game:GetService("Players")

local ServerModules     = ServerStorage.SBGModules
local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer  = ReplicatedStorage.Remotes

local StunHandler      = require(ServerModules.StunHandler)
local HitboxHandler    = require(ServerModules.HitboxHandler)
local DamageHandler    = require(ServerModules.DamageHandler)
local RagdollHandler   = require(ServerModules.RagdollHandler)
local NewKnockback     = require(ServerModules.BodymoverService)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService   = require(ServerModules.iFramesService)
local CollisionsModule = require(ServerModules.CollisionsModule)
local Trove            = require(ReplicatedModules.Trove)

local ClientEffects        = RemotesContainer.ClientEffects
local ReplicateEffects_Set = RemotesContainer.Replicate.Set

-- ===== CONFIG (fill with your assets) =====================================
local MOVE_NAME     = "TowerSlash"
local AnimFolder    = ServerStorage.Assets.Animations.Zoro.Moveset.RegularMoveSet.TowerSlash -- TODO: your folder
local WITHDRAW_ANIM = AnimFolder.Miss   -- one track, markers below
-- Required markers: "dashback" (~0.15s), "vfx", "dashforward" (pre-swing), "hit"

local IFRAME_TIME   = .3
local HITBOX_SIZE   = Vector3.new(10, 7.5, 10)
local HITBOX_OFFSET = CFrame.new(0, 0, -5)
local DAMAGE        = 10
-- ==========================================================================

return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		if not Character then return end
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Janitor = Trove.new()
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local Hit = {}

		-- startup i-frames
		iFramesService:AddAlliFrames(Character)
		task.delay(IFRAME_TIME, function()
			iFramesService:RemoveAlliFrames(Character)
		end)

		local StartTrack = AnimationService:getAnimationTrack(Character, WITHDRAW_ANIM)
		local StartEvents = {}

		local function fx(skillType, extra)
			local data = extra or {}
			data.Attacker  = Character
			data.SkillType = skillType
			ClientEffects:FireAllClients(MOVE_NAME, data)
			--RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {Char = Character, SkillType =  "barrage",  Bind = Bind})

		end

		-- backstep dash (Distance -20, Duration 0.3, Sine)
		StartEvents["dashback"] = StartTrack:GetMarkerReachedSignal("dashback"):Once(function()
			print("Dashbackserver")
			ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
			fx("dashback")
		end)

		-- slash vfx (cosmetic)
		StartEvents["vfx"] = StartTrack:GetMarkerReachedSignal("vfx"):Once(function()
			fx("vfx")
		end)

		-- forward lunge (Distance 25, Duration 0.6, Quad, LockDirection)
		StartEvents["dashforward"] = StartTrack:GetMarkerReachedSignal("dashforward"):Once(function()
			StartTrack:AdjustSpeed(1)
			ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
			--Character:AddTag("CantRotate")
			fx("dashforward")
		end)

		-- the strike
		StartEvents["hit"] = StartTrack:GetMarkerReachedSignal("hit"):Once(function()
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance  = HumRP
			Hitbox.Size      = HITBOX_SIZE
			Hitbox.Offset    = HITBOX_OFFSET
			Hitbox.Ignore    = { Character }
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChildOfClass("Humanoid")
				local EnemyHumRP: BasePart    = EnemyCharacter:FindFirstChild("HumanoidRootPart")
				if not (EnemyHumanoid and EnemyHumRP) then return end
				if Hit[EnemyCharacter] or iFramesService:HasiFrame(EnemyCharacter, 2) then return end
				if EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if EnemyCharacter:GetAttribute("Ragdolled") then return end

				local HitInfo = DamageHandler:TakeDamage(
					Character, EnemyHumanoid, DAMAGE,
					nil, nil, false, true, true, true, false, nil, nil
				)
				if HitInfo.Countered then return end
				Hit[EnemyCharacter] = true

				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
				EnemyCharacter:AddTag("CantRotate")
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)

				-- Uppercut knockback (+ short ragdoll; delete next line for Nanami-exact)
				NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(1, 100000, 1), Velocity = HumRP.CFrame.UpVector * 75 })
				task.delay(0.05, function() RagdollHandler.ragdoll(EnemyHumanoid, 2) end)

				fx("hit", { Position = EnemyHumRP.Position })
				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 3, Last = 0.75 } })

				local p = EnemyHumRP.Position
				ReplicateEffects_Set:FireAllClients("Ground Crater", {
					Seed = math.random(1, 2e9), start = p + Vector3.new(0, 0.1, 0),
					["end"] = Vector3.new(0, -14, 0), amount = 5, sizemult = 1.55, size = 1.4, nosound = true,
				})

				task.delay(2, function()
					StunHandler:Unstun(EnemyCharacter, EnemyStun)
					EnemyCharacter:RemoveTag("CantRotate")
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
				end)
			end
			Hitbox:Once()   -- swap to :Start() (+ destroy after a beat) for cleave
		end)

		StartTrack.Stopped:Once(function()
			for _, v in StartEvents do v:Disconnect() end
			--Character:RemoveTag("CantRotate")
			iFramesService:RemoveAlliFrames(Character)
			StunHandler:Unstun(Character, Stun)
			fx("cleanup")
			Janitor:Destroy()
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, WITHDRAW_ANIM)
		StartTrack:AdjustSpeed(2)

	end,
}