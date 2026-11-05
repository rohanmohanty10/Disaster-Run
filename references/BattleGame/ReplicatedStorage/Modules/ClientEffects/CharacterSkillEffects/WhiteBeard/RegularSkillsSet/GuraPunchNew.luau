--[[
	GuraPunchNew (client effect module)
	Location: ReplicatedStorage.Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.RegularSkillsSet.GuraPunchNew

	What changed vs. your previous version
	  StartUp
	    - The arm orb is now GuraBall_Animated (Inside = neon core, Outside = force field) instead of "Original Ball".
	      Same arm spot as before: Left Arm, C0 = (0, -0.7, 0).
	    - From GPO GuraBall: looping boil animation, x1.25 size pulse, big->small particle flare, grow + fade on the way out.
	    - From GPO BallTrail: per-frame neon cylinder trail that follows the ball and tapers off.
	    - Bol bursts and Bind-based cleanup are unchanged.
	  Hit
	    - Hit-stop: the server sends FreezeTime (0.3s) + Victims. Victims' animations pause here on every client
	      (the server pauses the attacker's punch animation itself), the orb pauses too, and the impact particles hold still.
	    - Impact (t = 0): Gura Crack (Gura1, Gura2, Gura3 + guraglass1) + crack flash + HitFx appear.
	    - Freeze end (t = FreezeTime): Gura1/2/3 break with your shatterAndDestroy, guraglass1 does a JJS-style fake break
	      (flash, vanish, generated shards fly out), and BreakFx / rocks / wind / smoke / pressure play.
	    - No more hard-coded 1 second: everything is timed off FreezeTime, so nothing lingers after people can move.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)
local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)

local GuraOrb = require(ReplicatedStorage.Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraOrb)

local RNG = Random.new()

---------------------------------------------------------------------------------------------------
-- Tunables
---------------------------------------------------------------------------------------------------
local ORB_ARM = "Left Arm"
local ORB_OFFSET = CFrame.new(0, -0.7, 0) -- same spot as the old orb

local DEFAULT_FREEZE = 0.3

local GLASS = {
	SHARDS = 22, -- JJS spawns 20
	LIFE = 0.6, -- shrink-to-nothing time
	FLASH = 0.12,
}

---------------------------------------------------------------------------------------------------
-- Freeze helpers
---------------------------------------------------------------------------------------------------
local function freezeAnimations(characters: { Model }, duration: number)
	local paused = {}
	for _, char in characters do
		if typeof(char) ~= "Instance" or not char.Parent then
			continue
		end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local animator = hum and hum:FindFirstChildOfClass("Animator")
		if not animator then
			continue
		end
		for _, track in animator:GetPlayingAnimationTracks() do
			local speed = track.Speed
			if speed ~= 0 then
				table.insert(paused, { track, speed })
				track:AdjustSpeed(0)
			end
		end
	end

	task.delay(duration, function()
		for _, entry in paused do
			local track, speed = entry[1], entry[2]
			if track.IsPlaying and track.Speed == 0 then
				track:AdjustSpeed(speed)
			end
		end
	end)
end

local function freezeParticles(container: Instance?, duration: number)
	if not container then
		return
	end
	local list = {}
	local function grab(e: Instance)
		if e:IsA("ParticleEmitter") then
			table.insert(list, { e, e.TimeScale })
			e.TimeScale = 0
		end
	end
	grab(container)
	for _, d in container:GetDescendants() do
		grab(d)
	end
	task.delay(duration, function()
		for _, entry in list do
			if entry[1].Parent then
				entry[1].TimeScale = entry[2]
			end
		end
	end)
end

---------------------------------------------------------------------------------------------------
-- Effect
---------------------------------------------------------------------------------------------------
return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType = argumentData.SkillType


	if skillType == "Aim" then
		-- Tremor Punch's server asks which way you face as the punch lands (your rotation is
		-- locked by then), so the hitbox and the destruction go where the crack goes
		local Root = attacker:FindFirstChild("HumanoidRootPart")
		local AimRemote = ReplicatedStorage.Remotes.MoveSkills:FindFirstChild("TremorPunchAim")
		if Root and AimRemote and attacker == Players.LocalPlayer.Character then
			AimRemote:FireServer(Root.CFrame.LookVector)
		end
		return
	end

	local function bol(part: BasePart, scale: number, c0: CFrame): Model?
		local fx = script.Bol:Clone()

		local prim = fx.PrimaryPart
		if not prim then
			warn("Bol: no PrimaryPart")
			fx:Destroy()
			return nil
		end

		for _, p in fx:GetDescendants() do
			if p:IsA("BasePart") then
				p.Anchored = false
				p.CanCollide = false
				p.CanQuery = false
				p.CanTouch = false
				p.CastShadow = false
			end
		end

		fx:ScaleTo(scale)
		fx:PivotTo(part.CFrame * c0)

		for _, p in fx:GetDescendants() do
			if p:IsA("BasePart") and p ~= prim then
				local wc = Instance.new("WeldConstraint")
				wc.Part0 = prim
				wc.Part1 = p
				wc.Parent = p
			end
		end

		local weld = Instance.new("Weld")
		weld.Part0 = part
		weld.Part1 = prim
		weld.C0 = c0
		weld.Parent = prim

		fx.Parent = workspace.World.Visuals

		TS:Create(prim, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
			Size = Vector3.new(0, 0, 0),
		}):Play()

		EffectUtilities.Emit(fx)
		return fx
	end

	if skillType == "StartUp" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 200) == false then
			return
		end

		local Bind: StringValue? = argumentData.Bind
		if not Bind or not Bind:IsDescendantOf(game) then
			return
		end

		local arm = attacker:FindFirstChild(ORB_ARM)
		if not arm then
			return
		end

		local orb = GuraOrb.attach(attacker, arm, ORB_OFFSET, { Scale = 1, FadeIn = 0.5 })
		local bolFX = bol(arm, 0.1, ORB_OFFSET)

		task.delay(0.55, function()
			if not arm.Parent then
				return
			end
			local b2 = bol(arm, 0.5, ORB_OFFSET)
			if b2 then
				Debris:AddItem(b2, 2)
			end
		end)

		local cleaned = false
		local bindConn: RBXScriptConnection?
		local charConn: RBXScriptConnection?

		local function cleanup()
			if cleaned then
				return
			end
			cleaned = true
			if bindConn then
				bindConn:Disconnect()
			end
			if charConn then
				charConn:Disconnect()
			end

			orb.stop()

			if bolFX then
				EffectUtilities.ToggleVFX(bolFX, false)
				Debris:AddItem(bolFX, 2)
			end
		end

		bindConn = Bind.AncestryChanged:Connect(function(_, parent)
			if not parent then
				cleanup()
			end
		end)

		charConn = attacker.AncestryChanged:Connect(function(_, parent)
			if not parent then
				cleanup()
			end
		end)

		if not Bind.Parent then
			cleanup()
		end

		return
	end

	local function shatterAndDestroy(model: Instance, origin: Vector3?)
		local LIFETIME = 0.55
		local SHRINK_TO = 0.25
		local STAGGER = 0.008
		local SPIN = 12
		local KICK = 14

		local root = origin or model:GetPivot().Position

		local parts = {}
		for _, d in model:GetDescendants() do
			if d:IsA("BasePart") and not d:GetAttribute("NoShatter") then
				table.insert(parts, d)
			end
		end
		if #parts == 0 then
			model:Destroy()
			return
		end

		table.sort(parts, function(a, b)
			return (a.Position - root).Magnitude < (b.Position - root).Magnitude
		end)

		for _, d in model:GetDescendants() do
			if d:IsA("Highlight") then
				TS:Create(d, TweenInfo.new(0.2), {
					FillTransparency = 1,
					OutlineTransparency = 1,
				}):Play()
			end
		end

		for i, p in parts do
			p.CanCollide = false
			p.CanQuery = false
			p.CanTouch = false
			p.CastShadow = false
			p.Massless = false

			local out = (p.Position - root)
			out = out.Magnitude > 0.01 and out.Unit or Vector3.yAxis

			local vel = out * KICK * (0.5 + math.random()) + Vector3.new(0, 5, 0)
			local spin = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5).Unit * SPIN

			task.delay((i - 1) * STAGGER, function()
				if not p.Parent then
					return
				end
				p.Anchored = false
				p.AssemblyLinearVelocity = vel
				p.AssemblyAngularVelocity = spin
				TS:Create(p, TweenInfo.new(LIFETIME, Enum.EasingStyle.Linear), {
					Size = p.Size * SHRINK_TO,
				}):Play()
			end)
		end

		Debris:AddItem(model, LIFETIME + (#parts * STAGGER) + 0.2)
	end

	-- JJS-style fake break for a single-mesh glass panel:
	-- flash, remove the panel, and fling generated flat shards from where it was.
	local function fakeGlassBreak(glassModel: Instance, placement: CFrame)
		local srcPart = glassModel:FindFirstChildWhichIsA("BasePart", true)
		if not srcPart then
			glassModel:Destroy()
			return
		end

		local srcHL = srcPart:FindFirstChildWhichIsA("Highlight") or glassModel:FindFirstChildWhichIsA("Highlight", true)
		local hlTemplate = srcHL and srcHL:Clone()

		if srcHL then
			srcHL.FillColor = Color3.new(1, 1, 1)
			srcHL.FillTransparency = 0.2
			TS:Create(srcHL, TweenInfo.new(GLASS.FLASH), { FillTransparency = 1, OutlineTransparency = 1 }):Play()
		end
		task.delay(GLASS.FLASH, function()
			if glassModel.Parent then
				glassModel:Destroy()
			end
		end)

		local cf, size = srcPart.CFrame, srcPart.Size
		local origin = placement.Position
		local forward = placement.LookVector

		local shards = Instance.new("Model")
		shards.Name = "GuraGlassShards"
		if hlTemplate then
			hlTemplate.Adornee = nil
			hlTemplate.Parent = shards
		end
		shards.Parent = workspace.World.Visuals

		local shrinkInfo = TweenInfo.new(GLASS.LIFE, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
		for _ = 1, GLASS.SHARDS do
			local r = math.sqrt(RNG:NextNumber()) * 0.9
			local a = RNG:NextNumber(0, math.pi * 2)
			-- the panel is thin along its local Z, so shards are scattered across its local X/Y
			local localPos = Vector3.new(math.cos(a) * r * size.X / 2, math.sin(a) * r * size.Y / 2, 0)

			local p = Instance.new("Part")
			p.Size = Vector3.new(RNG:NextNumber(1.2, 4.5), RNG:NextNumber(1.2, 4.5), 0.15)
			p.CFrame = cf * CFrame.new(localPos) * CFrame.Angles(0, 0, RNG:NextNumber(0, math.pi * 2))
			p.Material = srcPart.Material
			p.Color = srcPart.Color
			p.Transparency = hlTemplate and srcPart.Transparency or 0.4
			p.Anchored = false
			p.CanCollide = false
			p.CanQuery = false
			p.CanTouch = false
			p.CastShadow = false
			p.Parent = shards

			local out = p.Position - origin
			out = out.Magnitude > 0.01 and out.Unit or Vector3.yAxis
			p.AssemblyLinearVelocity = out * RNG:NextNumber(18, 40)
				+ forward * RNG:NextNumber(10, 28)
				+ Vector3.new(0, RNG:NextNumber(4, 12), 0)
			p.AssemblyAngularVelocity = Vector3.new(RNG:NextNumber(-12, 12), RNG:NextNumber(-12, 12), RNG:NextNumber(-12, 12))

			TS:Create(p, shrinkInfo, { Size = Vector3.zero }):Play()
		end

		Debris:AddItem(shards, GLASS.LIFE + 0.1)
	end

	local function windBurst(cf: CFrame, scale: number)
		local wind = script.Wind2:Clone()
		wind.Anchored = true
		wind.CanCollide = false
		wind.CanQuery = false
		wind.CanTouch = false
		wind.CastShadow = false

		wind.CFrame = cf * CFrame.Angles(math.pi / 2, math.rad(math.random(0, 360)), 0)
		wind.Size = Vector3.new(55, 35, 55) * scale
		wind.Transparency = 0.4

		wind.Parent = workspace.World.Visuals
		Debris:AddItem(wind, 2)

		TS:Create(wind, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Size = Vector3.new(44, 70, 44) * scale,
			Transparency = 1,
			CFrame = wind.CFrame * CFrame.new(0, -15 * scale, 0) * CFrame.Angles(0, math.rad(180), 0),
		}):Play()
	end

	local OPPOSITE_FACE = {
		[Enum.NormalId.Front] = Enum.NormalId.Back,
		[Enum.NormalId.Back] = Enum.NormalId.Front,
		[Enum.NormalId.Top] = Enum.NormalId.Bottom,
		[Enum.NormalId.Bottom] = Enum.NormalId.Top,
		[Enum.NormalId.Left] = Enum.NormalId.Right,
		[Enum.NormalId.Right] = Enum.NormalId.Left,
	}

	local function mirrorDecals(part: BasePart)
		local existing = {}
		local taken = {}
		for _, d in part:GetChildren() do
			if d:IsA("Decal") then
				table.insert(existing, d)
				taken[d.Face] = true
			end
		end

		for _, d in existing do
			local back = OPPOSITE_FACE[d.Face]
			if back and not taken[back] then
				local copy = d:Clone()
				copy.Face = back
				copy.Parent = part
				taken[back] = true
			end
		end
	end

	local function setDecals(part: BasePart, goal: number, time: number?)
		for _, d in part:GetChildren() do
			if d:IsA("Decal") then
				if time then
					TS:Create(d, TweenInfo.new(time, Enum.EasingStyle.Sine), { Transparency = goal }):Play()
				else
					d.Transparency = goal
				end
			end
		end
	end

	-- holdTime: how long the crack flash stays up (the freeze); it fades right after.
	local function secondTry(cf: CFrame, scale: number, holdTime: number): Model?
		local fx = script.SecondTry:Clone()

		local o = fx:FindFirstChild("o")
		local o2 = fx:FindFirstChild("o2")
		if not (o and o2) then
			warn("SecondTry: missing 'o' or 'o2'")
			fx:Destroy()
			return nil
		end

		if not (o:FindFirstChildOfClass("Decal") and o2:FindFirstChildOfClass("Decal")) then
			warn("SecondTry: missing decals")
			fx:Destroy()
			return nil
		end

		for _, p in fx:GetDescendants() do
			if p:IsA("BasePart") then
				p.Anchored = true
				p.CanCollide = false
				p.CanQuery = false
				p.CanTouch = false
				p.CastShadow = false
				p.Transparency = 1
				mirrorDecals(p)
			end
		end

		fx:ScaleTo(1.5 * scale)
		fx:PivotTo(cf * CFrame.new(0, 0.35, 0))

		setDecals(o, 1)
		setDecals(o2, 0)

		fx.Parent = workspace.World.Visuals
		Debris:AddItem(fx, 2)

		EffectUtilities.Emit(fx)

		task.delay(holdTime + 0.05, function()
			if not fx.Parent then
				return
			end
			setDecals(o2, 1, 0.25)
		end)

		return fx
	end

	local rockParams = RaycastParams.new()
	rockParams.FilterType = Enum.RaycastFilterType.Include
	rockParams.FilterDescendantsInstances = {
		workspace.World.Map.Destroyable.Map,
		workspace.World.Map["Indestructible Map"],
	}

	local function rockBurst(cf: CFrame, scale: number, count: number?)
		local hit = workspace:Raycast(cf.Position + Vector3.yAxis * 2, Vector3.new(0, -8, 0), rockParams)
		if not hit then
			return
		end

		for _ = 1, count or math.random(20, 24) do
			local rock = Instance.new("Part")
			local w = math.random() * 5.5 + 0.5
			rock.Size = Vector3.new(w, math.random() * 4.5 + 0.5, w) * scale
			rock.CanCollide = false
			rock.CanQuery = false
			rock.CanTouch = false
			rock.CastShadow = false

			rock.Material = hit.Instance.Material
			rock.MaterialVariant = hit.Instance.MaterialVariant
			rock.Color = hit.Instance.Color

			rock.CFrame = cf
				* CFrame.new((math.random() - 0.5) * 30 * scale, 0, -(math.random() * 5 + 5) * scale)
				* CFrame.Angles(math.random() * 6.28, math.random() * 6.28, math.random() * 6.28)

			rock.Parent = workspace.World.Visuals

			local mass = rock:GetMass()
			rock:ApplyImpulse(
				(cf.LookVector * (math.random() * 100 + 10) + Vector3.new(0, math.random() * 50 + 50, 0)) * mass * scale
			)

			Debris:AddItem(rock, 3)
		end
	end

	if skillType == "Hit" then
		local HumRP = attacker:FindFirstChild("HumanoidRootPart")
		if not HumRP then
			return
		end

		local rng = Random.new(argumentData.Seed)
		local freezeTime: number = argumentData.FreezeTime or DEFAULT_FREEZE
		local victims: { Model } = argumentData.Victims or {}
		--local CFrameToUse = argumentData.CFrameToUse
		--local CFrameToUse = HumRP.CFrame
		local CFrameToUse = argumentData.CFrameToUse -- the server sends where the attacker aimed
		-- Hit-stop: victims' animations + the orb pause on this client.
		-- (The attacker's punch animation is paused by the server, which replicates to everyone.)
		freezeAnimations(victims, freezeTime)
		GuraOrb.freeze(attacker, freezeTime)
	
		-- Impact (t = 0): crack + flash appear
		local clone = script["Gura Crack"]:Clone()
		local authored = clone:GetPivot().Rotation

		local look = CFrameToUse.LookVector * Vector3.new(1, 0, 1)
		local facing = CFrame.lookAt(CFrameToUse.Position, CFrameToUse.Position + look.Unit)
		local placement = facing * CFrame.new(0, 0, -4)

		local spin = CFrame.Angles(0, math.rad(rng:NextNumber(0, 360)), 0)
		clone:PivotTo(placement * authored * spin)

		-- guraglass1 is one mesh, so it's excluded from shatterAndDestroy and gets the fake break instead
		local glass = clone:FindFirstChild("guraglass1")
		if glass then
			for _, d in glass:GetDescendants() do
				if d:IsA("BasePart") then
					d:SetAttribute("NoShatter", true)
				end
			end
		end

		clone.Parent = workspace.World.Visuals

		local flash = secondTry(placement, 1, freezeTime)
		freezeParticles(flash, freezeTime)

		local nearby = EffectUtilities.CheckRenderDistance(CFrameToUse, 300)

		if nearby then
			local FxClone = script.HitFx:Clone()
			FxClone.CFrame = placement
			FxClone.Parent = workspace.World.Visuals
			EffectUtilities.Emit(FxClone)
			freezeParticles(FxClone, freezeTime)
			Debris:AddItem(FxClone, 4)
		end

		-- Freeze ends: everything breaks and the explosion plays
		task.delay(freezeTime, function()
			if clone.Parent then
				if glass and glass.Parent then
					fakeGlassBreak(glass, placement)
				end
				shatterAndDestroy(clone, placement.Position)
			end

			local breakFX = script["BreakFx"]:Clone()
			breakFX:PivotTo(placement * breakFX:GetPivot().Rotation)
			breakFX.Parent = workspace.World.Visuals
			Debris:AddItem(breakFX, 4)
			EffectUtilities.Emit(breakFX)

			--rockBurst(placement, 1, 10)

			task.spawn(function()
				RockHandler.RockLines(placement, { Angle = math.rad(140), NoSmoke = true, TimeTilNextRock = 0.015, HoldTime = 4 })
			end)
			task.spawn(function()
				RockHandler.RockLines(placement, {
					RandomJitter = 0.95,
					SizeIndex = 0.1,
					Angle = math.rad(70),
					Amount = 20,
					TimeTilNextRock = 0.015,
					HoldTime = 3,
					NoSmoke = true,
				})
			end)

			if not nearby then
				return
			end

			windBurst(placement * CFrame.new(0, 0, -10), 0.7)

			local HitParticlesClone = script.HitParticles:Clone()
			HitParticlesClone:PivotTo(placement * CFrame.new(0, 0, -15))
			HitParticlesClone.Parent = workspace.World.Visuals
			EffectUtilities.Emit(HitParticlesClone)
			Debris:AddItem(HitParticlesClone, 4)

			local Smoke = script.Smoke:Clone()
			Smoke:PivotTo(placement * CFrame.Angles(0, math.rad(180), 0))
			Smoke.Parent = workspace.World.Visuals
			EffectUtilities.Emit(Smoke)
			Debris:AddItem(Smoke, 4)

			local GroundSmoke = script.GroundSmoke:Clone()
			GroundSmoke:PivotTo(placement * CFrame.Angles(0, math.rad(180), 0) * CFrame.new(0, -2.7, GroundSmoke.Size.Z / 2))
			GroundSmoke.Parent = workspace.World.Visuals
			EffectUtilities.Emit(GroundSmoke)
			Debris:AddItem(GroundSmoke, 4)

			local PressureFxClone = script["PressureFx"]:Clone()
			PressureFxClone.CFrame = CFrameToUse * CFrame.Angles(0, math.rad(-90), 0) * CFrame.new(-PressureFxClone.Size.X, -3, 0)
			PressureFxClone.Parent = workspace.World.Visuals
			EffectUtilities.Emit(PressureFxClone)
			Debris:AddItem(PressureFxClone, 2)
		end)

		return
	end
end