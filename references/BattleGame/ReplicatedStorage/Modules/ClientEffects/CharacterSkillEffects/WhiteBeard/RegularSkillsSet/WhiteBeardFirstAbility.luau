local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer

local RNG = Random.new()
local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)
local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)


return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType = argumentData.SkillType
	
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

		-- Every non-primary part must be bound to prim, or it falls to the floor.
		-- WeldConstraint captures relative position at assignment, so this runs
		-- after PivotTo and before the Size tween.
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

		-- Geometry implodes; attachments and emitters on it keep firing.
		TS:Create(prim, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
			Size = Vector3.new(0, 0, 0),
		}):Play()

		EffectUtilities.Emit(fx)
		return fx
	end
	
	
	if skillType == "StartUp" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 200) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		
		local Bind: StringValue? = argumentData.Bind

		-- Replication race: reference may not have resolved on this client.
		if not Bind or not Bind:IsDescendantOf(game) then
			return
		end

		local clone = script["Original Ball"]:Clone()

		for _, partName in { "Force", "Neon" } do
			local weld = Instance.new("Weld")
			weld.Part0 = attacker["Left Arm"]
			weld.Part1 = clone[partName]
			weld.C0 = CFrame.new(0, -.7, 0)
			weld.Parent = clone
			
			local part = clone[partName]
			part.Transparency = 1
			TS:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Transparency = 0 }):Play()
		end

		clone.Parent = workspace.World.Visuals
		
		local bolFX = bol(attacker["Left Arm"], 0.1, CFrame.new(0, -0.7, 0))
		
		local cleaned = false
		local bindConn: RBXScriptConnection?
		local charConn: RBXScriptConnection?
		
		task.delay(0.55, function()
			--if cleaned then return end
			local b2 = bol(attacker["Left Arm"], 0.5, CFrame.new(0, -0.7, 0))
			if b2 then
				Debris:AddItem(b2, 2)
			end
		end)
		
		local function fadeOutFX(fx: Model?)
			if not fx then return end
			EffectUtilities.ToggleVFX(fx, false)
			Debris:AddItem(fx, 2)   -- let in-flight particles finish
		end

		local function cleanup()
			if cleaned then return end
			cleaned = true
			if bindConn then bindConn:Disconnect() end
			if charConn then charConn:Disconnect() end
			
			TS:Create(clone.Neon, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Transparency = 1 }):Play()
			TS:Create(clone.Force, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Transparency = 1 }):Play()
			clone.Neon.Trail.Enabled = false
			clone.Neon.WindTrail.Enabled = false
			fadeOutFX(clone)
			
			fadeOutFX(bolFX)
		end

		bindConn = Bind.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end)

		charConn = attacker.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end)

		if not Bind.Parent then cleanup() end
		
		return
	end

	local function shatterAndDestroy(model: Instance, origin: Vector3?)
		local LIFETIME = 0.55
		local SHRINK_TO = 0.25
		local STAGGER = 0.008
		local SPIN = 12              -- rad/s angular velocity
		local KICK = 14              -- outward burst, studs/s

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

		-- Radial order so the break propagates outward, not in Blender's export order.
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
			p.Massless = false           -- needs mass for gravity to act

			local out = (p.Position - root)
			out = out.Magnitude > 0.01 and out.Unit or Vector3.yAxis

			local vel = out * KICK * (0.5 + math.random()) + Vector3.new(0, 5, 0)
			local spin = Vector3.new(
				math.random() - 0.5,
				math.random() - 0.5,
				math.random() - 0.5
			).Unit * SPIN

			task.delay((i - 1) * STAGGER, function()
				if not p.Parent then return end
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
	
	local function windBurst(cf: CFrame, scale: number)
		-- Your own cone/vortex mesh, authored with its axis along local Y.
		local wind = script.Wind2:Clone()
		wind.Anchored = true
		wind.CanCollide = false
		wind.CanQuery = false
		wind.CanTouch = false
		wind.CastShadow = false

		-- Lay the cone on its side; random roll so repeat casts differ.
		wind.CFrame = cf * CFrame.Angles(math.pi / 2, math.rad(math.random(0, 360)), 0)
		wind.Size = Vector3.new(55, 35, 55) * scale
		wind.Transparency = 0.4

		wind.Parent = workspace.World.Visuals
		Debris:AddItem(wind, 2)

		TS:Create(wind, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Size = Vector3.new(44, 70, 44) * scale,
			Transparency = 1,
			CFrame = wind.CFrame
				* CFrame.new(0, -15 * scale, 0)
				* CFrame.Angles(0, math.rad(180), 0),
			--Color = Color3.fromRGB(248, 248, 248),
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
		-- Snapshot first: cloning into the same parent while iterating would loop forever.
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

	local function secondTry(cf: CFrame, scale: number)
		local fx = script.SecondTry:Clone()

		local o = fx:FindFirstChild("o")
		local o2 = fx:FindFirstChild("o2")
		if not (o and o2) then
			warn("SecondTry: missing 'o' or 'o2'")
			fx:Destroy()
			return
		end

		if not (o:FindFirstChildOfClass("Decal") and o2:FindFirstChildOfClass("Decal")) then
			warn("SecondTry: missing decals")
			fx:Destroy()
			return
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

		--for _, d in fx:GetDescendants() do
		--	if d:IsA("ParticleEmitter") then
		--		d:Emit(d:GetAttribute("EmitCount") or 10)
		--	end
		--end
		EffectUtilities.Emit(fx)

		--task.delay(0.4, function()
		--	if not fx.Parent then return end
		--	-- Hard cut, no crossfade. That's what makes it read as an impact flash.
		--	setDecals(o, 1)
		--	setDecals(o2, 0)
		--	o2.Size = o2.Size * 1.5
		--end)

		task.delay(0.95, function()
			if not fx.Parent then return end
			setDecals(o2, 1, 0.3)
		end)
	end
	
	local ROCK_COLOR = Color3.new(0.65098, 1, 0.94902)

	local rockParams = RaycastParams.new()
	rockParams.FilterType = Enum.RaycastFilterType.Include
	rockParams.FilterDescendantsInstances = {
		workspace.World.Map.Destroyable.Map,
		workspace.World.Map["Indestructible Map"],
	}

	local function rockBurst(cf: CFrame, scale: number, count: number?)
		local hit = workspace:Raycast(cf.Position + Vector3.yAxis * 2, Vector3.new(0, -8, 0), rockParams)
		if not hit then return end

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
				* CFrame.new(
					(math.random() - 0.5) * 30 * scale,
					0,
					-(math.random() * 5 + 5) * scale
				)
				* CFrame.Angles(math.random() * 6.28, math.random() * 6.28, math.random() * 6.28)

			rock.Parent = workspace.World.Visuals

			-- Impulse scaled by mass so big and small chunks travel alike.
			local mass = rock:GetMass()
			rock:ApplyImpulse((
				cf.LookVector * (math.random() * 100 + 10)
					+ Vector3.new(0, math.random() * 50 + 50, 0)
				) * mass * scale)

			Debris:AddItem(rock, 3)
		end
	end
	
	
	
	if skillType == "Hit" then
		local HumRP = attacker:FindFirstChild("HumanoidRootPart")
		if not HumRP then return end
		
		local rng = Random.new(argumentData.Seed)
		
		local IsMainPlayer = (LocalPlayer.Character == attacker)
		
		local CFrameToUse = argumentData.CFrameToUse --predetermined so they are always the same and match destruction. And is basically hrp cframe passed through.

		local clone = script["Gura Crack"]:Clone()
		local authored = clone:GetPivot().Rotation

		local look = CFrameToUse.LookVector * Vector3.new(1, 0, 1)
		local facing = CFrame.lookAt(CFrameToUse.Position, CFrameToUse.Position + look.Unit)
		local placement = facing * CFrame.new(0, 0, -4)
		
		local spin = CFrame.Angles(0, math.rad(rng:NextNumber(0, 360)), 0)
		-- physical crack model
		clone:PivotTo(placement * authored * spin)
		clone.Parent = workspace.World.Visuals
		secondTry(placement, 1)
		
		task.delay(1, function()
			if not clone.Parent then return end

			shatterAndDestroy(clone, placement.Position)

			local breakFX = script["BreakFx"]:Clone()
			breakFX:PivotTo(placement * breakFX:GetPivot().Rotation)
			breakFX.Parent = workspace.World.Visuals
			Debris:AddItem(breakFX, 4)
			EffectUtilities.Emit(breakFX)
		end)
				
		rockBurst(placement, 1, 10)
		
		task.spawn(function() -- The outer
			RockHandler.RockLines(placement, {Angle = math.rad(140), NoSmoke = true, TimeTilNextRock = 0.015, HoldTime = 4})
		end)
		
		task.spawn(function()		-- The inner
			RockHandler.RockLines(placement, {RandomJitter = 0.95, SizeIndex = 0.1, Angle = math.rad(70), Amount = 20, TimeTilNextRock = 0.015, HoldTime = 3, NoSmoke = true}) 
		end)
		
		--if IsMainPlayer then
		--	require(ReplicatedStorage.Modules.ClientEffects.GlassShatterWB).Play({
		--		Color = Color3.fromRGB(245, 245, 250), -- cyan
		--		ImpactPosition = Vector2.new(0.5, 0.5),
		--		Depth = 3.5,
		--		HoldTime = .01,
		--		Distance = 4,
		--		Thickness = 0.01,
		--		FallAcceleration = 150
		--	})
		--end
		
		if EffectUtilities.CheckRenderDistance(CFrameToUse, 300) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
			
		windBurst(placement * CFrame.new(0, 0, -10), .7)

		-- Fx
		local FxClone = script.HitFx:Clone()
		FxClone.CFrame = placement  --* authored
		FxClone.Parent = workspace.World.Visuals
		EffectUtilities.Emit(FxClone)
		Debris:AddItem(FxClone, 4)
		
		-- Middle particles
		local HitParticlesClone = script.HitParticles:Clone()
		HitParticlesClone:PivotTo(placement * CFrame.new(0, 0, -15))
		HitParticlesClone.Parent = workspace.World.Visuals
		EffectUtilities.Emit(HitParticlesClone)
		Debris:AddItem(HitParticlesClone, 4)
		
		-- Smoke particles
		local Smoke = script.Smoke:Clone()
		Smoke:PivotTo(placement * CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(180), 0))
		Smoke.Parent = workspace.World.Visuals
		EffectUtilities.Emit(Smoke)
		Debris:AddItem(Smoke, 4)
		
		-- Ground Smoke
		local GroundSmoke = script.GroundSmoke:Clone()
		GroundSmoke:PivotTo(placement * CFrame.Angles(0, math.rad(180), 0) * CFrame.new(0, -2.7, GroundSmoke.Size.Z / 2))
		GroundSmoke.Parent = workspace.World.Visuals
		EffectUtilities.Emit(GroundSmoke)
		Debris:AddItem(GroundSmoke, 4)
		
		 -- Pressure Fx
		local PressureFxClone = script["PressureFx"]:Clone()
		PressureFxClone.CFrame = CFrameToUse * CFrame.Angles(0, math.rad(-90), 0) * CFrame.new(-PressureFxClone.Size.X, -3, 0)
		PressureFxClone.Parent = workspace.World.Visuals
		EffectUtilities.Emit(PressureFxClone)
		Debris:AddItem(PressureFxClone, 2)	
					
		return
	end
end