local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).Crocodile.Ult
--WhiteBeard Railgun — SERVER ability module (server-driven animations).
--Studio location: mirror the other characters, e.g.
--   ServerScriptService > Systems > Characters > WhiteBeard > <SkillSet> > WhiteBeardRailgun
--and call WhiteBeardRailgun.Start(player) from WhiteBeard.lua's ability dispatch
--(the same way Sanji.lua calls Ability1Projectile.Start(player)).
--
--The SERVER owns the whole timeline. AnimationService plays the animations on the
--character's Animator (replicates to everyone) and the "jump"/"release" markers fire
--server-side:
--   play Jump   -> "jump" marker   -> tell owner client to start flying + show charge orb
--   play Hold (looped) for FLIGHT_TIME
--   play Release-> "release" marker -> read the player's mouse, fire the projectile,
--                                       tell owner client to stop flying
--   on landing  -> play Land + tell owner client to restore its legs
--
--Animations must live under ServerStorage.Assets.Animations so AnimationService loads
--them. Set ANIM_PATH below to your Jump/Hold/Release/Land folder.

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ServerModules = ServerStorage.SBGModules

local StunHandler = require(ServerModules.StunHandler)
local HitboxHandler = require(ServerModules.HitboxHandler)
local DamageHandler = require(ServerModules.DamageHandler)
local RagdollHandler = require(ServerModules.RagdollHandler)
local NewKnockback = require(ServerModules.BodymoverService)
local iFramesService = require(ServerModules.iFramesService)
local StatesHandler = require(ServerModules.StatesHandler)
local ProjectileService = require(ServerModules.ProjectileService)
local DebreeService = require(ServerModules.DebreeService)

local AnimationService = require(ServerModules.AnimationService)
local Velocity = require(ReplicatedStorage.Modules.Velocity)
local SoundHandler = require(ReplicatedStorage.Modules.SoundHandler)


local RemotesContainer = ReplicatedStorage.Remotes
local ClientEffects = RemotesContainer.ClientEffects
local ReplicateEffects_Set = RemotesContainer.Replicate.Set

local Sounds = ReplicatedStorage.Assets.Sounds.Characters.Crocodile

--------------------------------------------------------------------------------
-- Tuning
--------------------------------------------------------------------------------
local FLIGHT_TIME = 3      -- seconds you fly before the auto-release  <-- change me
local PROJECTILE_SPEED = 200 -- studs/second
local MAX_DISTANCE = 400
local MAX_TIME = 4
local DETECTION_SIZE = 6

local EXPLOSION_RADIUS = 150
local EXPLOSION_DAMAGE = MoveConfig.Damage.Center
local EXPLOSION_MIN_DAMAGE = MoveConfig.Damage.Edge  -- at/near the edge
local RAGDOLL_TIME = 2.5
local COOLDOWN = 14
local DEBREE_RIM = 5 

local DEBREE_GRID = 5         -- wall piece size in the rim, in studs
local DEBREE_GROUND_GRID = 4

local PURPLE = Color3.fromRGB(148, 121, 255)
local EFFECT_NAME = "SunaPesado"

--CHANGE THIS to where your 4 animations live (must be under ServerStorage.Assets.Animations).
--Needs Animation children named: Jump, Hold, Release, Land.
local ANIM_PATH = { "Crocodile", "Railgun" }

--------------------------------------------------------------------------------
local Animations = ServerStorage.Assets.Animations


local function GetPlayerMousePosition(Player: Player): Vector3?
	local MouseValue = ReplicatedStorage.PlayerInfo.MousePositions:FindFirstChild(Player.Name .. "Mouse")
	if MouseValue and MouseValue:IsA("Vector3Value") then
		return MouseValue.Value
	end
	return nil
end


--------------------------------------------------------------------------------
-- The explosion (shared by direct hit / wall hit / expiry).
--------------------------------------------------------------------------------
local function Explode(Player: Player, Character: Model, Position: Vector3)
	ClientEffects:FireAllClients(EFFECT_NAME, {
		SkillType = "reworkedImpact",
		Position = Position,
		Color = PURPLE,
		Attacker = Character,
	})
	
	SoundHandler:AddSound(Sounds.Pesado["implosion sfx"], Position)
	SoundHandler:AddSound(Sounds.Pesado["implosion2"], Position)
	
	task.delay(.9, function()
		local Hitbox = HitboxHandler.new()
		Hitbox.Instance = CFrame.new(Position)
		Hitbox.Size = Vector3.new(EXPLOSION_RADIUS, EXPLOSION_RADIUS, EXPLOSION_RADIUS)
		--Hitbox.Method = "Sphere"
		Hitbox.Ignore = { Character }
		Hitbox.Visualize = true
		Hitbox.onTouch = function(EnemyCharacter)
			local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
			local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)

			if iFramesService:HasiFrame(EnemyCharacter, 2) then return end
			
			local dist = (EnemyHumRP.Position - Position).Magnitude
			local alpha = math.clamp(dist / EXPLOSION_RADIUS, 0, 1)   -- 0 at center, 1 at edge
			local scaledDamage = EXPLOSION_DAMAGE + (EXPLOSION_MIN_DAMAGE - EXPLOSION_DAMAGE) * alpha
			DamageHandler:TakeDamage(Character, EnemyHumanoid, scaledDamage, nil, nil, false, false, false, true, true, nil, 15)

			if EnemyCharacter:HasTag("Ragdolled") then
				RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
			end

			local Away = (EnemyHumRP.Position - Position)
			Away = Away.Magnitude > 0.001 and Away.Unit or Character.HumanoidRootPart.CFrame.LookVector

			--NewKnockback:Knockback(EnemyCharacter, {
			--	KnockbackType = "Velocity",
			--	MaxForce = Vector3.new(math.huge, math.huge, math.huge),
			--	Velocity = Away * Vector3.new(45, 0, 45) + Vector3.new(0, 22, 0),
			--})
			
			local VelocityObject = Velocity.new(EnemyCharacter)
			VelocityObject.Settings.RemoveTime = 0.3
			VelocityObject.Settings.MaxForce = Vector3.new(200000, 200000, 200000)
			VelocityObject.Settings.Velocity = Away * 100 + Vector3.yAxis * 50
			VelocityObject.Settings.Spin = Vector3.new(
				(math.random() - 0.5) * 2,
				(math.random() - 0.5) * 2,
				(math.random() - 0.5) * 2
			).Unit * 8
			VelocityObject:Fire()
			
			RagdollHandler.ragdoll(EnemyHumanoid, RAGDOLL_TIME)
			
			if EnemyPlayer then
				ReplicateEffects_Set:FireClient(EnemyPlayer, "ShakeCamera", { Intensity = 8, Last = 0.1 })
			end
		end

		Hitbox:Once()
		Hitbox:Destroy()
		
		local BlastCFrame = CFrame.new(Position)
		local BlastSize = Vector3.one * EXPLOSION_RADIUS -- a sphere 150 across: as far out as the hitbox above reaches
		DebreeService.Erase(BlastCFrame, BlastSize, {
			Shape = "Ball",
			IncludeGround = true, -- the ground goes too: a crater down to the unbreakable map underneath
			GridSize = DEBREE_GRID,
			GroundGridSize = DEBREE_GROUND_GRID,
		})
		task.wait(.1)
		DebreeService.Destroy(BlastCFrame, BlastSize + Vector3.one * (2 * DEBREE_RIM), {
			Shape = "Ball",
			Hollow = BlastSize, -- only the rim outside the obliterated sphere breaks
			Outward = true,
			Power = 60,
			Lift = 20,
			Bounce = 0,
			GridSize = DEBREE_GRID,
			GroundGridSize = DEBREE_GROUND_GRID,
			-- no Attacker: you're up in the air, and a punch's "nothing below your feet breaks"
			-- rule would leave every wall lower than you standing
		})

		if Player then
			ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 10, Last = 0.35 })
		end
		
		SoundHandler:AddSound(Sounds.Pesado["ex2"], Position)
		SoundHandler:AddSound(Sounds.Pesado["Explosion"], Position)
		SoundHandler:AddSound(Sounds.Pesado["Explosion Sand"], Position)
		
		local Position1 = {
			Seed = math.random(1, 1000) + 2,
			start = Position + Vector3.new(0, 0.1, 0),
			["end"] = Vector3.new(0, -20, 0),
			amount = 10,
			nosound = true,
			nosmoke = true,
			sizemult = 0.55 * 3, -- actual individual rock size
			size = 0.85 * 5, -- crater size
			nodebris = true,
		}
		ReplicateEffects_Set:FireAllClients('Ground Crater', Position1)

		local Position2 = {
			Seed = math.random(1, 1000) + 2,
			start = Position + Vector3.new(0, 0.1, 0),
			["end"] = Vector3.new(0, -20, 0), -- raycast downwards. 
			amount = 15,
			nosound = true,
			nosmoke = true,
			sizemult = 0.55 * 6, -- actual individual rock size
			size = 0.85 * 13, -- crater size
			nodebris = true,
		}
		ReplicateEffects_Set:FireAllClients('Ground Crater', Position2)
	end)
end

--------------------------------------------------------------------------------
-- Spawn the projectile toward the player's mouse.
--------------------------------------------------------------------------------
local function FireProjectile(Player: Player, Character: Model)
	local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
	if not HumRP then return end
	
	local RightArm = Character:FindFirstChild("Right Arm")
	
	local Origin = (HumRP.CFrame * CFrame.new(0, 1.5, -2)).Position

	local AimPosition = GetPlayerMousePosition(Player)
	local Direction
	if AimPosition and (AimPosition - Origin).Magnitude > 3 then
		Direction = (AimPosition - Origin).Unit
	else
		Direction = HumRP.CFrame.LookVector
	end

	--ClientEffects:FireAllClients(EFFECT_NAME, { SkillType = "muzzle", Attacker = Character, Color = PURPLE })
	ClientEffects:FireAllClients(EFFECT_NAME, { SkillType = "throw", Attacker = Character, Direction = Direction })
	ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 10})
	SoundHandler:AddSound(Sounds.Pesado.throw, RightArm)
	SoundHandler:AddSound(Sounds.Pesado.throw2, RightArm)
	SoundHandler:AddSound(Sounds.Pesado.throw3, RightArm)

	local Shot = ProjectileService.new(EFFECT_NAME, Character, Origin, Direction * PROJECTILE_SPEED, {
		MaxDistance = MAX_DISTANCE,
		DetectionSize = DETECTION_SIZE,
		MaxTime = MAX_TIME,
	})

	local Exploded = false
	local function Detonate(Position: Vector3)
		if Exploded then return end
		Exploded = true
		Explode(Player, Character, Position)
	end

	Shot.onHit = function()
		local Position = Shot.Position
		Shot:Destroy()
		Detonate(Position)
	end
	Shot.onMapHit = function(Raycast: RaycastResult)
		Detonate(Raycast.Position)
	end
	Shot.onExpire = function()
		Detonate(Shot.Position)
	end

	Shot:Start()
end

--------------------------------------------------------------------------------
return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local Animator: Animator = Humanoid.Animator

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityThreeCooldown") then return end

		Player:SetAttribute("AbilityThreeCooldown", true)
		local RELEASE_SHOOT_DELAY = 0.35
		local CooldownTime = COOLDOWN
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 16, 0, true)
		Character:AddTag("NoHeadFollow")

		--StatesHandler.SkillText(Player, "RAILGUN [USED]")

		local NewAnimLocation = ServerStorage.Assets.Animations["Crocodile"]
		local RailgunAnims = NewAnimLocation.Railgun -- Jump, Loop, Release

		local JumpTrack = AnimationService:getAnimationTrack(Character, RailgunAnims.Jump)
		local LoopTrack = AnimationService:getAnimationTrack(Character, RailgunAnims.Loop)
		local ReleaseTrack = AnimationService:getAnimationTrack(Character, RailgunAnims.Release)

		-- Outrank walk/run (which sit at Action), and the loop has to actually loop.
		JumpTrack.Priority = Enum.AnimationPriority.Action4
		ReleaseTrack.Priority = Enum.AnimationPriority.Action4
		LoopTrack.Priority = Enum.AnimationPriority.Action4
		--LoopTrack.Looping = true
		local windLoop
		local sandFlyLoop
		
		local Events = {}
		local finished = false
		local released = false

		local function finish()
			if finished then return end
			finished = true

			Character:SetAttribute("railgunfly", nil)
			for _, connection in Events do
				connection:Disconnect()
			end
			if Stun then
				StunHandler:Unstun(Character, Stun)
				Stun = nil
			end
			Character:RemoveTag("NoHeadFollow")

			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityThreeCooldown", false)
				end
			end)
			
			if windLoop then
				SoundHandler:StopSound(windLoop, 1)
			end
			if sandFlyLoop then
				SoundHandler:StopSound(sandFlyLoop, 1)
			end
		end

		-- Fire the shot + stop flying. Runs from the "release" marker OR the timer.
		local function doRelease()
			if released or finished then return end
			released = true

			Character:SetAttribute("railgunfly", nil) -- ends the client flight -> you fall
			FireProjectile(Player, Character)
			RemotesContainer.ClientEffects:FireClient(Player, EFFECT_NAME, { SkillType = "flightEnd" })
			--RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, { SkillType = "chargeEnd", Attacker = Character })
			
			if windLoop then
				SoundHandler:StopSound(windLoop, 1)
			end
			if sandFlyLoop then
				SoundHandler:StopSound(sandFlyLoop, 1)
			end
			task.delay(0.6, finish)
		end

		-- JUMP keyframe: start flying, show the orb, play the loop.
		Events["jump"] = JumpTrack:GetMarkerReachedSignal("jump"):Once(function()
			if finished then return end

			Character:SetAttribute("railgunfly", true)
			RemotesContainer.ClientEffects:FireClient(Player, EFFECT_NAME, { SkillType = "flightStart", Duration = FLIGHT_TIME })
			RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, { SkillType = "newCharge", Attacker = Character })
			ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 3})


			AnimationService:stopAnimation(Character, RailgunAnims.Jump, 0.15)
			LoopTrack:Play(0.15)

			-- Fly for FLIGHT_TIME, then play the release anim and fire.
			task.delay(FLIGHT_TIME, function()
				if finished or not Character.Parent then return end
				LoopTrack:Stop(0.1)
				AnimationService:playAnimation(Character, RailgunAnims.Release)
				task.delay(RELEASE_SHOOT_DELAY, doRelease) -- timer fallback if the "release" marker never fires
			end)
			
			SoundHandler:AddSound(Sounds.Pesado.Jump, HumRP)
			SoundHandler:AddSound(Sounds.Pesado.JumpSand, HumRP)
			SoundHandler:AddSound(Sounds.Pesado["static lightning"], Character:FindFirstChild("Right Arm"))
			windLoop = SoundHandler:AddSound(Sounds.Pesado["Wind Loop"], HumRP)
			sandFlyLoop = SoundHandler:AddSound(Sounds.Pesado["Sand Fly"], HumRP)
			
			local RightArm = Character:FindFirstChild("Right Arm")
			task.delay(.4, function()
				SoundHandler:AddSound(Sounds.Pesado["Lightning Charge1"], RightArm)
				task.wait(.75)
				SoundHandler:AddSound(Sounds.Pesado["Lightning Charge2"], RightArm)
				task.wait(.75)
				SoundHandler:AddSound(Sounds.Pesado["Lightning Charge3"], RightArm)
			end)
		end)

		-- RELEASE keyframe (fires at the exact frame if the marker exists).
		Events["release"] = ReleaseTrack:GetMarkerReachedSignal("release"):Once(doRelease)

		-- Clean up if the character despawns mid-move.
		Events["removed"] = Character.AncestryChanged:Connect(function(_, parent)
			if not parent then
				finish()
			end
		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, RailgunAnims.Jump)
	end,
}