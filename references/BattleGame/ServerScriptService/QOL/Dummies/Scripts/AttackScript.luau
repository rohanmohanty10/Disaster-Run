--ServerScriptService/QOL/Dummies/Scripts/AttackScript
--
-- MODULESCRIPT. Driven by Dummies.server.luau via start(Dummy) -> cleanup.
--
-- This deliberately does NOT live inside the dummy. Anything a dummy-parented script
-- creates (threads, connections) is torn down when the dummy is destroyed -- including
-- the machinery that releases stuns it applied to PLAYERS. That's what made
-- ClearDummies leave the victim permanently stunned: StunHandler:Stun builds the
-- victim's release out of parts owned by the caller (the expiry timer and the folder's
-- Destroying connection), and the caller was about to be deleted.
--
-- Running from a persistent script fixes that at the source. The trade: this loop now
-- OUTLIVES the dummy, so the returned cleanup MUST be called on Destroying.

local RNS = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local RS = game:GetService("ReplicatedStorage")

local Modules = ServerStorage.SBGModules
local AnimationService = require(Modules.AnimationService)
local HitboxHandler = require(Modules.HitboxHandler)
local iFramesService = require(Modules.iFramesService)
local DamageHandler = require(Modules.DamageHandler)
local SoundsModule = require(Modules.SoundsModule)

local Animations = ServerStorage.Assets.Animations

local PUNCH_COOLDOWN = 1 -- was the task.wait(1) inside the Stopped handler
local RETRY_BACKOFF = 0.25 -- throttles retries when a punch can't start

local AttackScript = {}

function AttackScript.start(Character: Model)
	local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
	local Humanoid: Humanoid = Character:FindFirstChild("Humanoid")
	if not HumRP or not Humanoid then
		return nil
	end

	-- PunchCDS always comes off on a timer so a dummy stuck in an unplayable state
	-- can't re-run the whole punch setup every frame
	local function releaseGate(cooldown: number)
		Character:RemoveTag("Punching")
		task.delay(cooldown, function()
			Character:RemoveTag("PunchCDS")
		end)
	end

	local PunchConnection
	PunchConnection = RNS.Heartbeat:Connect(function()
		-- the dummy can now be destroyed out from under this loop
		if not Character.Parent or Humanoid.Health <= 0 then
			return
		end
		if
			Character:HasTag("Punching")
			or Character:HasTag("PunchCDS")
			or Character:HasTag("CantPunch")
			or Character:HasTag("Ragdolled")
		then
			return
		end

		Character:AddTag("Punching")
		Character:AddTag("PunchCDS")

		local PunchAnim: Animation = Animations.BlackBeard.M1s["1"]
		local PunchAnimTrack, Events = AnimationService:getAnimationTrack(Character, PunchAnim)

		-- getAnimationTrack returns nil if the character despawned mid-frame, and
		-- loadAnimations skips animations with a blank AnimationId outright
		if not PunchAnimTrack then
			releaseGate(RETRY_BACKOFF)
			return
		end

		local HitConnection = PunchAnimTrack:GetMarkerReachedSignal("hit"):Once(function()
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(1, 1, 1) * 7
			Hitbox.Offset = CFrame.new(0, 0, -Hitbox.Size.Z / 2)
			Hitbox.onTouch = function(EnemyCharacter: Model)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if
					EnemyCharacter == Character
					or EnemyHumanoid.Health <= 0
					or iFramesService:HasiFrame(EnemyCharacter, "M1")
					or EnemyCharacter:HasTag("Ragdolled")
				then
					return
				end

				local HitInfo = DamageHandler:TakeDamage(
					Character,
					EnemyHumanoid,
					4,
					1,
					Animations.Character.Damaged.Damaged0,
					true,
					true,
					false,
					false,
					true,
					"M1"
				)
				if HitInfo.Countered == true then
					return
				end

				if HitInfo.Blocked == true then
					local SFX: Sound

					if EnemyCharacter:HasTag("PerfectBlock") then
						SFX = RS.Assets.Sounds.Combat.Hits.PerfectBlocked
					else
						local BlockHits = RS.Assets.Sounds.Blocking.Hits:GetChildren()
						SFX = BlockHits[math.random(1, #BlockHits)]
					end

					SoundsModule:PlaySound(SFX, EnemyHumRP)
				else
					local Hits = RS.Assets.Sounds.Characters.Sanji.Hits:GetChildren()
					SoundsModule:PlaySound(Hits[math.random(1, #Hits)], HumRP)
				end
			end

			Hitbox:Once()
			Hitbox:Destroy()
		end)

		-- AnimationService disconnects everything in this table on the track's Stopped,
		-- so the marker cleans itself up on any punch that actually plays
		table.insert(Events, HitConnection)

		local Played = AnimationService:playAnimation(Character, PunchAnim)

		-- playAnimation returns nil (e.g. while Ragdolled) without playing; Stopped would
		-- then never fire, so the tags would stick AND the marker connection would sit in
		-- the Events table forever. Undo both here.
		if not Played then
			HitConnection:Disconnect()
			local index = table.find(Events, HitConnection)
			if index then
				table.remove(Events, index)
			end
			releaseGate(RETRY_BACKOFF)
			return
		end

		-- connected only once we know it's playing, so a failed start can't stack extra
		-- Stopped handlers on this cached track
		PunchAnimTrack.Stopped:Once(function()
			releaseGate(PUNCH_COOLDOWN)
		end)

		SoundsModule:PlaySound(RS.Assets.Sounds.Characters.Sanji.Swings["1"], HumRP)
	end)

	return function()
		PunchConnection:Disconnect()
		Character:RemoveTag("Punching")
		Character:RemoveTag("PunchCDS")
	end
end

return AttackScript
