--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/BlackBeard/RegularSkillsSet/SunaGrab
--[[
	Caster movement + ice spike VFX for the grab skill.

	The module name MUST match the string the server fires —
	ClientEffects.client.lua caches every effect module by module.Name.

	SkillTypes:
		Dash    — "dash" marker  : forward lunge, 170 -> 0 over 0.8s  (caster only)
		Drag    — on grab connect: horizontal haul, 90 -> 0 over 2.8s (caster only)
		Cancel  — interrupt / skill end, kills whatever is running
		Spike   — ice spike, no animation: placed, holds, sinks into the ground
		Spike2  — ice spike, reference port: welded to the caster, plays
		          GlacialCinderSpike, plants itself at 1.75

	Movement runs on the caster's client only. VFX runs on EVERY client, which is
	why the caster check is per-block rather than a single early return.

	Spike assets live under this module. Only `icespike` is required; `"5"` and
	`Handler2` light up automatically if you add them.

	Movement numbers come off the payload, so that tuning lives in the server module.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local VFX_Utility = require(ReplicatedStorage.Modules.ClientEffects.RandomModules.VFX_Utility)
local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local UtilityModule = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)


-- ===== Tuning ================================================================

-- VFX_Utility keeps a preconfigured LinearVelocity for moveBP_Forward. Reuse it
-- when it is there so the movers all come out of one place, build one otherwise.
local VELOCITY_TEMPLATE = ReplicatedStorage.Modules.ClientEffects.RandomModules.VFX_Utility:FindFirstChild("LinearVelocity")

-- Flattens a LookVector onto the XZ plane. Deliberately NOT normalised after —
-- the reference multiplies straight through and the slight shortening on a
-- pitched camera is part of how the dash feels.
local FLAT = Vector3.new(1, 0, 1)

-- Drag force is pinned to the horizontal plane so gravity keeps working normally.
local AXES_HORIZONTAL = Vector3.new(9999999, 0, 9999999)
local AXES_ALL = Vector3.new(9999999, 9999999, 9999999)

-- Ice spike placement. The reference welds the spike's root to the caster's at
-- this offset — about 2.26 studs down, pure translation, no rotation.
local SPIKE_OFFSET = CFrame.new(0.0454101562, -2.26071811, 0.00685089827)

-- "Spike" only (the no-animation variant).
local SPIKE_HOLD = 2      -- seconds standing before it sinks
local SPIKE_SINK_TIME = 1 -- how long the sink takes
local SPIKE_SINK_PAD = 2  -- extra studs past its own height so nothing pokes through

-- Where effects are parented. The reference uses workspace.Effects.
local VFX_PARENT = workspace.World.Visuals

-- One movement loop at a time on the local character.
local Active = nil

-- ===== Helpers ===============================================================





-- Ignore the caster and anything cosmetic, or the wall checks trip on the
-- skill's own debris and clamp the speed for no reason.
local function buildRayParams(Character: Model): RaycastParams
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.RespectCanCollide = true
	Params.IgnoreWater = true

	local Filter = { Character }

	local World = workspace:FindFirstChild("World")
	if World then
		for _, Name in { "Visuals", "Debris", "Voxel" } do
			local Folder = World:FindFirstChild(Name)
			if Folder then
				table.insert(Filter, Folder)
			end
		end
	end

	Params.FilterDescendantsInstances = Filter
	return Params
end

local function newLinearVelocity(HumRP: BasePart): LinearVelocity
	local Attachment = HumRP:FindFirstChild("RootAttachment")
	if not Attachment then
		Attachment = Instance.new("Attachment")
		Attachment.Name = "RootAttachment"
		Attachment.Parent = HumRP
	end

	local LinVel = VELOCITY_TEMPLATE and VELOCITY_TEMPLATE:Clone() or Instance.new("LinearVelocity")
	LinVel.Name = "GrabVelocity"
	-- World space: every direction below is built from world vectors, so the
	-- template's own RelativeTo is overridden here on purpose.
	LinVel.RelativeTo = Enum.ActuatorRelativeTo.World
	LinVel.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
	LinVel.VectorVelocity = Vector3.zero
	LinVel.Attachment0 = Attachment
	LinVel.Parent = HumRP

	return LinVel
end

local function clearVelocities(HumRP: BasePart)
	for _, Child in HumRP:GetChildren() do
		if Child:IsA("LinearVelocity") or Child:IsA("BodyVelocity") then
			Child:Destroy()
		end
	end
end

local function stopActive()
	if not Active then
		return
	end

	local Current = Active
	Active = nil

	if Current.Connection then
		Current.Connection:Disconnect()
		Current.Connection = nil
	end

	if Current.LinVel then
		Current.LinVel:Destroy()
		Current.LinVel = nil
	end
end

-- The reference bails its loops on the IsHeavyStun attribute. We do not have
-- that, and the caster is stunned by their own move so the Stunned tag is
-- useless here — the Ragdolled tag plus the explicit "Cancel" the server fires
-- on interrupt are the closest signals that survive the boundary.
local function isInterrupted(Character: Model, HumRP: BasePart): boolean
	if not Character.Parent then
		return true
	end
	if not HumRP.Parent then
		return true
	end
	if Character:HasTag("Ragdolled") then
		return true
	end

	local Humanoid = Character:FindFirstChild("Humanoid")
	if not Humanoid or Humanoid.Health <= 0 then
		return true
	end

	return false
end

-- ===== Spike helpers =========================================================

-- One spike at a time, shared by both spike variants.
local ActiveSpike = nil

-- Assets that do not exist yet return nil and every call site skips them, so
-- Spike2 runs with only icespike present and lights up as you add the rest.
local function getAsset(Name: string): Instance?
	return script:FindFirstChild(Name)
end

-- Stand-in for the reference's morefunctions.setuppart. Same option contract:
--   part0                the part to ride
--   C0                   offset from part0
--   debristime           lifetime
--   delaytimeforenabled  enable emitters after this delay (sustained effects)
--   emitpart             one-shot burst instead of sustained
--   lockedtopart         false = leave it in world space where it spawned
local function setuppart(Character: Model, Asset: Instance?, Options)
	if not Asset then
		return nil
	end

	Options = Options or {}

	local Clone = Asset:Clone()
	local Root = Clone:IsA("Model")
		and (Clone.PrimaryPart or Clone:FindFirstChildWhichIsA("BasePart", true))
		or Clone

	local Part0 = Options.part0
	local C0 = Options.C0 or CFrame.new()

	if Root and Part0 then
		if Clone:IsA("Model") then
			Clone:PivotTo(Part0.CFrame * C0)
		else
			Root.CFrame = Part0.CFrame * C0
		end

		-- lockedtopart == false means it stays where it spawned instead of
		-- riding the limb — that is how the reference leaves ground residue.
		if Options.lockedtopart ~= false then
			Root.Anchored = false

			local Weld = Instance.new("Weld")
			Weld.Name = "Offset"
			Weld.Part0 = Part0
			Weld.Part1 = Root
			Weld.C0 = C0
			Weld.Parent = Root
		end
	end

	Clone.Parent = VFX_PARENT

	if Options.emitpart then
		for _, Descendant in Clone:GetDescendants() do
			if Descendant:IsA("ParticleEmitter") then
				Descendant:Emit(Descendant:GetAttribute("EmitCount") or 10)
			end
		end
	else
		task.delay(Options.delaytimeforenabled or 0, function()
			if not Clone.Parent then
				return
			end

			for _, Descendant in Clone:GetDescendants() do
				if Descendant:IsA("ParticleEmitter") or Descendant:IsA("Trail") or Descendant:IsA("Beam") then
					Descendant.Enabled = true
				end
			end
		end)
	end

	if Options.debristime then
		Debris:AddItem(Clone, Options.debristime)
	end

	return Clone
end



-- ===== Flight VFX ============================================================

local FLIGHT_LEG_NAMES = { "Left Leg", "Right Leg" } -- R6

-- Keyed by character so several people can be flying at once and every client
-- tracks all of them, not just its own.
local ActiveFlight = {}

local function setEnabled(inst: Instance, on: boolean)
	for _, d in inst:GetDescendants() do
		if d:IsA("ParticleEmitter") or d:IsA("Beam") or d:IsA("Trail") then
			d.Enabled = on
		end
	end
end

-- Disable emitters, then destroy once the last live particle has expired, so
-- the trail dies off instead of popping out of existence mid-air.
local function fadeOutVFX(inst: Instance?, extra: number?)
	if not inst or not inst.Parent then
		return
	end

	setEnabled(inst, false)

	local longest = 0
	for _, d in inst:GetDescendants() do
		if d:IsA("ParticleEmitter") then
			longest = math.max(longest, d.Lifetime.Max)
		elseif d:IsA("Trail") then
			longest = math.max(longest, d.Lifetime)
		end
	end

	Debris:AddItem(inst, longest + (extra or 0.1))
end

local function setLegs(character: Model, transparent: boolean)
	local FLIGHT_TWEEN_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	local goal = transparent and 1 or 0
	for _, name in FLIGHT_LEG_NAMES do
		local leg = character:FindFirstChild(name)
		if leg then
			TweenService:Create(leg, FLIGHT_TWEEN_INFO, { Transparency = goal }):Play()
		end
	end

end

local function stopFlightVFX(character: Model)
	local record = ActiveFlight[character]
	if not record then
		return
	end

	ActiveFlight[character] = nil

	fadeOutVFX(record.VFX, 0.25)
	fadeOutVFX(record.VFX2, 0.25)
	setLegs(character, false)
end



-- v137 — scale every emitter's lifetime
local function scaleEmitterLifetime(fx: Instance, scale: number)
	for _, v in fx:GetDescendants() do
		if v:IsA("ParticleEmitter") then
			v.Lifetime = NumberRange.new(v.Lifetime.Min * scale, v.Lifetime.Max * scale)
		end
	end
end

-- v138 — clone, place, park, auto-clean
local function spawnFX(template: Instance, anchorCF: CFrame): Instance
	local clone = template:Clone()

	if clone:IsA("Model") then
		clone:PivotTo(anchorCF)
	elseif clone:IsA("BasePart") then
		clone.CFrame = anchorCF
	end

	clone.Parent = VFX_PARENT
	Debris:AddItem(clone, 30)

	return clone
end

-- v139 — the emit driver. Emitters fire from EmitDelay/EmitCount/EmitDuration
-- attributes; beams open to their authored Width attributes and shut after Duration.
local function playFX(fx: Instance, debrisTime: number?, opts)
	local tweenTime = (opts and opts.TweenTime) or 0.5

	for _, v in fx:GetDescendants() do
		if v:IsA("ParticleEmitter") then
			local attrs = v:GetAttributes()

			if attrs.EmitDelay then
				task.delay(attrs.EmitDelay, function()
					v:Emit(attrs.EmitCount or 1)
				end)
			else
				v:Emit(attrs.EmitCount or 1)
			end

			if attrs.EmitDuration then
				v.Enabled = true
				task.delay(attrs.EmitDuration, function()
					v.Enabled = false
				end)
			end
		end

		if v:IsA("Beam") then
			local attrs = v:GetAttributes()

			TweenService:Create(v, TweenInfo.new(tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Width0 = attrs.Width0,
				Width1 = attrs.Width1,
			}):Play()

			if attrs.Duration then
				task.delay(attrs.Duration, function()
					TweenService:Create(v, TweenInfo.new(tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						Width0 = 0,
						Width1 = 0,
					}):Play()
				end)
			end
		end
	end

	if debrisTime then
		Debris:AddItem(fx, debrisTime)
	end
end

local function flipbook(part: BasePart, textures: { string }, duration: number)
	if not part or not part:FindFirstChild("Decal") then
		return
	end

	task.spawn(function()
		for _, id in ipairs(textures) do
			if not part:FindFirstChild("Decal") then
				return
			end
			part.Decal.Texture = id
			task.wait(duration / #textures)
		end
	end)
end

local SHARD_FRAMES = {
	"rbxassetid://18628247694", "rbxassetid://18628247824", "rbxassetid://18628248192",
	"rbxassetid://18628248844", "rbxassetid://18628249510", "rbxassetid://18628250280",
	"rbxassetid://18628250961", "rbxassetid://18628251843", "rbxassetid://18628252635",
	"rbxassetid://18628253986", "rbxassetid://18628254567", "rbxassetid://18628255248",
	"rbxassetid://18628255857", "rbxassetid://18628256889", "rbxassetid://18628257569",
	"rbxassetid://18628258325",
}



-- Stand-in for shared.DestroyAllParticles. Disables emitters first so live
-- particles finish their lifetime instead of vanishing mid-air.
local function destroyAllParticles(List)
	for _, Clone in List do
		if typeof(Clone) == "Instance" and Clone.Parent then
			for _, Descendant in Clone:GetDescendants() do
				if Descendant:IsA("ParticleEmitter") or Descendant:IsA("Trail") or Descendant:IsA("Beam") then
					Descendant.Enabled = false
				end
			end

			Debris:AddItem(Clone, 2)
		end
	end

	table.clear(List)
end

-- The reference's cancel path is bind.AncestryChanged. Ours is the server's
-- explicit "Cancel", plus the Cancelled guard on every scheduled beat.
local function stopSpike()
	if not ActiveSpike then
		return
	end

	local Current = ActiveSpike
	ActiveSpike = nil
	Current.Cancelled = true

	if Current.Spawned then
		destroyAllParticles(Current.Spawned)
	end

	if Current.Model and Current.Model.Parent then
		Current.Model:Destroy()
	end
end

return function(argumentData: any)
	local Attacker: Model = argumentData.Attacker
	local skillType = argumentData.SkillType

	if not Attacker then
		return
	end

	local HumRP: BasePart = Attacker:FindFirstChild("HumanoidRootPart")
	if not HumRP then
		return
	end

	-- Movement is client-authoritative for the caster only, but the VFX blocks
	-- have to run everywhere or nobody except the caster sees the spike.
	local isCaster = Attacker == LocalPlayer.Character

	-- "dash" marker: the opening lunge.
	--
	-- Speed decays to zero but never drops below MinSpeed while the loop is
	-- alive, so the dash keeps travelling right up until it is cut rather than
	-- stalling out under the animation. Force axes are left unrestricted, so
	-- whatever vertical the camera aim produces is kept.
	if skillType == "Dash" and isCaster then
		stopActive()

		local Params = buildRayParams(Attacker)

		local LinVel = newLinearVelocity(HumRP)
		LinVel.ForceLimitsEnabled = false
		Debris:AddItem(LinVel, argumentData.Duration)

		local Speed = argumentData.Speed

		-- Shift-locked, the user steers the dash with the camera. Unlocked, the
		-- facing is frozen the frame the dash starts and re-applied every frame
		-- after, so the dash runs dead straight no matter where the mouse goes.
		local LockedLook: CFrame? = HumRP.CFrame

		local State = { LinVel = LinVel }
		Active = State

		State.Connection = RunService.RenderStepped:Connect(function(dt)
			if Active ~= State then
				return
			end

			if isInterrupted(Attacker, HumRP) then
				stopActive()
				return
			end

			local MouseLocked = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter

			if MouseLocked then
				LockedLook = nil
			else
				if not LockedLook then
					LockedLook = HumRP.CFrame
				end

				HumRP.CFrame = CFrame.new(
					HumRP.CFrame.Position,
					HumRP.CFrame.Position + LockedLook.LookVector * FLAT * 99999
				)
			end

			-- If the camera is clipped against something, fall back to the body's
			-- own facing — otherwise the dash aims into the wall the camera is
			-- pressed up against.
			local CameraBlocked = workspace:Raycast(HumRP.Position, Camera.CFrame.LookVector * argumentData.CameraProbe, Params)

			local Direction = Camera.CFrame.LookVector
			if CameraBlocked or not MouseLocked then
				Direction = HumRP.CFrame.LookVector * FLAT
			end

			-- Cut the speed near a wall so the user does not grind along it at
			-- full tilt.
			local Applied = Speed
			if workspace:Raycast(HumRP.Position, Direction * argumentData.WallCheck, Params) then
				Applied = math.min(Applied, argumentData.WallSpeed)
			end

			local Velocity = Direction * math.max(Applied, argumentData.MinSpeed)
			if VFX_Utility.isntNan(Velocity) then
				LinVel.VectorVelocity = Velocity
			end

			Speed = math.max(0, Speed - argumentData.Decay * dt)
		end)

		task.delay(argumentData.Duration, function()
			if Active == State then
				stopActive()
			end
		end)
	end

	-- Grab connected: haul the victim along.
	--
	-- Same loop shape as the dash with two differences — the force is clamped to
	-- the horizontal plane, and there is no minimum speed, so the drag bleeds
	-- out on its own instead of travelling until it is cut.
	if skillType == "Drag" and isCaster then
		stopActive()

		-- The dash mover is probably still on the root; it has to go or the two
		-- fight over VectorVelocity.
		clearVelocities(HumRP)

		local Params = buildRayParams(Attacker)

		local LinVel = newLinearVelocity(HumRP)
		LinVel.ForceLimitsEnabled = true
		LinVel.ForceLimitMode = Enum.ForceLimitMode.PerAxis
		LinVel.MaxAxesForce = AXES_HORIZONTAL
		Debris:AddItem(LinVel, argumentData.Duration)

		local Speed = argumentData.Speed

		local State = { LinVel = LinVel }
		Active = State

		State.Connection = RunService.RenderStepped:Connect(function(dt)
			if Active ~= State then
				return
			end

			if isInterrupted(Attacker, HumRP) then
				stopActive()
				return
			end

			local Direction = HumRP.CFrame.LookVector * FLAT

			-- Cut the speed near a wall so the user does not grind along it at
			-- full tilt.
			local Applied = Speed
			if workspace:Raycast(HumRP.Position, Direction * argumentData.WallCheck, Params) then
				Applied = math.min(Speed, argumentData.WallSpeed)
			end

			local Velocity = Direction * Applied
			if VFX_Utility.isntNan(Velocity) then
				LinVel.VectorVelocity = Velocity
			end

			Speed = math.max(0, Speed - argumentData.Decay * dt)
		end)

		task.delay(argumentData.Duration, function()
			if Active == State then
				stopActive()
			end
		end)
	end

	-- Interrupt, whiff, or the animation ending early.
	if skillType == "Cancel" then
		if isCaster then
			stopActive()
		end

		stopSpike()
	end

	

	
	-- Same as IceStomp, but the shards are MeshParts: no Decal child, no
	-- SpecialMesh child. Tint and flash go on the part, and the taper drives
	-- Size instead of Mesh.Scale.
	-- ===== IceStomp2 (MeshPart shards) ==========================================

	-- MeshParts have no Decal, and BasePart.Color is Color3uint8 — it clamps to
	-- 0-255, so the reference's overbright tints are not reachable here. These are
	-- real in-range colors; the flash leans on Neon instead of an out-of-range write.
	local SHARD_TINT = Color3.fromRGB(209, 192, 150)
	local SHARD_FLASH = Color3.fromRGB(159, 147, 100)
	local SHARD_FLASH_NEON = false

	-- MeshPart equivalent of the Decal flipbook. Off by default: SHARD_FRAMES are
	-- flat sprite frames drawn for a decal face, and stretching them over mesh UVs
	-- does not read the same way. Wire it up only if the mesh is UV'd for them.
	local function flipbookMesh(part: BasePart, textures: { string }, duration: number)
		if not part or not part:IsA("MeshPart") then
			return
		end

		task.spawn(function()
			for _, id in ipairs(textures) do
				if not part.Parent then
					return
				end
				part.TextureID = id
				task.wait(duration / #textures)
			end
		end)
	end
	
	
	-- Shard logic only. The asset needs nothing but an IceShards folder of
	-- group Models; Floor / Fx / beams / spin can all be deleted from it.
	if skillType == "IceStomp2" then
		local Template = getAsset("Spike3")
		if not Template then
			warn("SunaGrab: no Spike3 asset under this module")
			return
		end
		
		local CFrameToUse = argumentData.CFrameToUse

		-- Spun 180 so it faces back at the user. With this anchor the shards end up 3.4 to 26.3
		-- studs in front of the user, inside the server's Destroy box (anchor -3 put them 16-39 out).
		local anchorCF = CFrameToUse
			* CFrame.new(0, 1.5, 10)
			* CFrame.Angles(0, math.pi, 0)

		local fx = spawnFX(Template, anchorCF)
		if fx:IsA("Model") then
			fx:ScaleTo(1)
		end

		local shardsFolder = fx:FindFirstChild("Shards")
		if not shardsFolder then
			warn("SunaGrab: Spike3 has no IceShards folder")
			return
		end

		-- Shorter bursts, twice as dense. Scoped to the shards now that the rest
		-- of the rig is gone.
		--for _, v in shardsFolder:GetDescendants() do
		--	if v:IsA("ParticleEmitter") then
		--		--local dur = v:GetAttribute("EmitDuration")
		--		--if dur then
		--		--	v:SetAttribute("EmitDuration", dur * 0.3)
		--		--end
		--		v:Emit(v:GetAttribute("EmitCount") or 0)
		--		--v.Rate = v.Rate * 2
		--	end
		--end
		
		local SandFx = script.SandFx:Clone()
		SandFx.CFrame = shardsFolder:FindFirstChild("1"):GetPivot() * CFrame.new(0, -3, 0) --* SandFx:GetPivot().Rotation
		SandFx.Parent = workspace.World.Visuals

		UtilityModule.Debris(SandFx, 6)
		UtilityModule.Emit(SandFx)
		playFX(shardsFolder)

		
		local groups = {}

		-- Group by the container Model rather than by part name — these shards
		-- come out of Blender as Cube.001 / Cube.003 / etc, and the names repeat,
		-- so neither the name nor a numeric key works.
		for _, groupModel in shardsFolder:GetChildren() do
			if groupModel:IsA("Model") then
				local list = {}

				for _, v in groupModel:GetDescendants() do
					if v:IsA("BasePart") then
						-- bury it 25 down / 5 back with a little jitter, so the
						-- rise below reads as it punching up out of the ground
						v.CFrame = v.CFrame * (CFrame.new(0, -25, 5) * CFrame.Angles(
							math.rad(math.random(-2.5, 2.5)),
							math.rad(math.random(-2.5, 2.5)),
							math.rad(math.random(-2.5, 2.5))
							))

						-- was Decal.Color3; the part itself is the surface now
						v.Color = SHARD_TINT

						table.insert(list, v)
					end
				end

				if #list > 0 then
					table.insert(groups, list)
				end
			end
		end

		-- Rise: each group runs on its own thread, shards inside a group
		-- staggered a hair apart so they punch up as a ripple, not a wall.
		for _, group in groups do
			task.spawn(function()
				for _, shard in group do
					-- flipbookMesh(shard, SHARD_FRAMES, 0.256)

					TweenService:Create(shard, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
						CFrame = shard.CFrame * CFrame.new(0, 25, -5),
					}):Play()

					-- reverses, so it flashes and comes back. Color alone clamps
					-- to white, so Neon carries the overbright the Decal used to
					-- get for free.
					local baseMaterial = shard.Material

					if SHARD_FLASH_NEON then
						shard.Material = Enum.Material.Neon
					end

					TweenService:Create(shard, TweenInfo.new(0.0875, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {
						Color = SHARD_FLASH,
					}):Play()

					if SHARD_FLASH_NEON then
						task.delay(0.175, function()
							if shard.Parent then
								shard.Material = baseMaterial
							end
						end)
					end

					task.wait(0.000625)
				end

				task.wait(0.025)
			end)
		end

		-- 1.25s later everything sinks back down and thins out
		task.delay(1.5, function()
			--local sound = Instance.new("Sound")
			--sound.SoundId = "rbxassetid://110858831476675"
			--sound.Volume = 2
			--sound.Parent = argumentData.SoundParent or fx
			--sound:Play()
			--Debris:AddItem(sound, 4)

			task.spawn(function()
				for _, group in groups do
					for _, shard in group do
						--playFX(shard)

						TweenService:Create(shard, TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
							CFrame = shard.CFrame * CFrame.new(0, -12.5, 2.5),
						}):Play()

						-- was Mesh.Scale. X/Z collapse, Y is read now and written
						-- back untouched, so it thins into a needle at full height
						-- instead of shrinking to a point.
						local base = shard.Size
						TweenService:Create(shard, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
							Size = Vector3.new(0.001, base.Y, 0.001),
						}):Play()

						Debris:AddItem(shard, 0.6)
						task.wait(0.00025)
					end

					task.wait(0.025)
				end
			end)
		end)
	end
	
	if skillType == "EmitSpikeFX" then
		local CFrameToUse = argumentData.CFrameToUse
		
		local Spike = script.SpikeEmit:Clone()
		Spike.CFrame = CFrameToUse * CFrame.new(0,0,-10)
		Spike.Parent = workspace.World.Visuals
		
		--VFXFunctions.EmitDescendants(Spike)
		--VFXFunctions.TaskDebris(Spike, 8)
		
		
		local Ground = script.Ground:Clone()
		Ground.CFrame = CFrameToUse * CFrame.new(0,0,-7)
		Ground.Parent = workspace.World.Visuals

		--VFXFunctions.EmitDescendants(Ground)
		--VFXFunctions.TaskDebris(Ground, 8)
		
		--Final:SetPrimaryPartCFrame(CFrame.new(hrp.Position + hrp.CFrame.LookVector * -7.27847672 + Vector3.new(0.683349609375, -6.011728286743164, 0, 0), hrp.Position + hrp.CFrame.LookVector * -7.27847672 + Vector3.new(0.683349609375, -6.011728286743164, 0, 0) + hrp.CFrame.LookVector) * CFrame.new(0, 4, -15) * CFrame.Angles(-1.3962634015954636, 0, 0))

		UtilityModule.Debris(Spike, 6)
		UtilityModule.Emit(Spike)
		
		UtilityModule.Debris(Ground, 6)
		UtilityModule.Emit(Ground)
		
		
	end
	
	if skillType == "EnableArm" then

	end
	
	
	
	if skillType == "flight" then
		stopFlightVFX(Attacker)
		local root = Attacker:FindFirstChild("HumanoidRootPart")
		
		local flyVFX = script.Fly.Main:Clone()
		flyVFX.Anchored = false          -- must be unanchored for the weld to move it
		flyVFX.CanCollide = false
		flyVFX.CanQuery = false
		flyVFX.CanTouch = false
		flyVFX.CastShadow = false
		flyVFX.Massless = true           -- keeps it out of the root's mass/physics budget
		flyVFX.CFrame = root.CFrame * CFrame.new(0, -1, 0)  -- set BEFORE welding
		flyVFX.Parent = workspace.World.Visuals

		local flyWeld = Instance.new("WeldConstraint")
		flyWeld.Part0 = root
		flyWeld.Part1 = flyVFX
		flyWeld.Parent = flyVFX

		local cloudVFX = script.Fly.Cloud:Clone()
		cloudVFX.Anchored = false          -- must be unanchored for the weld to move it
		cloudVFX.CanCollide = false
		cloudVFX.CanQuery = false
		cloudVFX.CanTouch = false
		cloudVFX.CastShadow = false
		cloudVFX.Massless = true           -- keeps it out of the root's mass/physics budget
		cloudVFX.CFrame = root.CFrame * CFrame.new(0, -2.4, 0)  -- set BEFORE welding
		cloudVFX.Parent = workspace.World.Visuals

		local cloudWeld = Instance.new("WeldConstraint")
		cloudWeld.Part0 = root
		cloudWeld.Part1 = cloudVFX
		cloudWeld.Parent = cloudVFX

		setLegs(Attacker, true)

		ActiveFlight[Attacker] = { VFX = flyVFX, VFX2 = cloudVFX }

		-- Backstop in case flightEnd never arrives (interrupt, death, dropped remote).
		task.delay(argumentData.Duration or 10, function()
			local record = ActiveFlight[Attacker]
			if record and record.VFX == flyVFX then
				stopFlightVFX(Attacker)
			end
		end)
	end

	if skillType == "flightEnd" then
		stopFlightVFX(Attacker)
	end
	
end