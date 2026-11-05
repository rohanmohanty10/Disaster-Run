local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local LocalPlayer = Players.LocalPlayer

local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)
local SoundHandler = require(ReplicatedStorage.Modules.SoundHandler)
local GuraOrb = require(game:GetService("ReplicatedStorage").Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraOrb)
local GuraCrack = require(game:GetService("ReplicatedStorage").Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraCrack)

local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

local Essentials = Essentials
local Tween      = Essentials.Tween

local Assets = script.BlastClutch   -- repoint if your assets live elsewhere



-- Helper methods for double-sided decals.
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
				TweenService:Create(d, TweenInfo.new(time, Enum.EasingStyle.Sine), { Transparency = goal }):Play()
			else
				d.Transparency = goal
			end
		end
	end
end

local function secondCracks(cf: CFrame, scale: number, timeToShrink)
	local fx = script.Slam["Gura Crack2"]:Clone()

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

	--fx:ScaleTo(1.5 * scale)

	fx:PivotTo(cf * fx:GetPivot().Rotation)

	setDecals(o, 1)
	setDecals(o2, 0)
	
	local fullSize = o2.Size
	o2.Size = fullSize * 0.15

	fx.Parent = workspace.World.Visuals
	Debris:AddItem(fx, 2)

	TweenService:Create(o2, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Size = fullSize,
	}):Play()

	--task.delay(0.4, function()
	--	if not fx.Parent then return end
	--	-- Hard cut, no crossfade. That's what makes it read as an impact flash.
	--	setDecals(o, 1)
	--	setDecals(o2, 0)
	--	o2.Size = o2.Size * 1.5
	--end)

	task.delay(timeToShrink, function()
		if not fx.Parent then return end
		setDecals(o2, 1, 0.3)
		--setDecals(o, 1, .3)
	end)
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
			TweenService:Create(d, TweenInfo.new(0.2), {
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
			TweenService:Create(p, TweenInfo.new(LIFETIME, Enum.EasingStyle.Linear), {
				Size = p.Size * SHRINK_TO,
			}):Play()
		end)
	end

	Debris:AddItem(model, LIFETIME + (#parts * STAGGER) + 0.2)
end

local function growCrack(model: Model, total: number)
	local TOTAL = total or 0.2
	local RINGS = { "1", "2", "3" }
	local FADE_TIME = TOTAL * 0.5
	local stagger = (TOTAL - FADE_TIME) / (#RINGS - 1)

	--local gura1 = model:FindFirstChild("Gura1")
	--if not gura1 then
	--	warn("growCrack: missing Gura1")
	--	return
	--end

	for i, ringName in RINGS do
		local ring = model:FindFirstChild(ringName)
		if not ring then
			warn(`growCrack: missing ring "{ringName}"`)
			continue
		end

		local parts = {}
		for _, d in ring:GetDescendants() do
			if d:IsA("BasePart") then
				d.Transparency = 1
				table.insert(parts, d)
			end
		end

		task.delay((i - 1) * stagger, function()
			for _, p in parts do
				if p.Parent then
					TweenService:Create(p, TweenInfo.new(FADE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Transparency = 0,
					}):Play()
				end
			end
		end)
	end
end

local function shrinkCrack(model: Model, total: number?)
	local TOTAL = total or 0.7
	local FADE_TIME = TOTAL * 0.5

	local root = model:GetPivot().Position

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

	-- Farthest first: the fade retracts inward toward the impact point.
	table.sort(parts, function(a, b)
		return (a.Position - root).Magnitude > (b.Position - root).Magnitude
	end)

	local stagger = (TOTAL - FADE_TIME) / math.max(#parts - 1, 1)

	for _, d in model:GetDescendants() do
		if d:IsA("Highlight") then
			TweenService:Create(d, TweenInfo.new(FADE_TIME), {
				FillTransparency = 1,
				OutlineTransparency = 1,
			}):Play()
		end
	end

	for i, p in parts do
		--task.delay((i - 1) * stagger, function()
			if not p.Parent then return end
			TweenService:Create(p, TweenInfo.new(FADE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Transparency = 1,
			}):Play()
		--end)
	end

	Debris:AddItem(model, TOTAL + 0.2)
end

-- QuickFX: clone an asset and place it at a world CFrame.
local function quickFX(asset: Instance, cf: CFrame, scale: number?): Instance
	local fx = asset:Clone()

	for _, p in fx:GetDescendants() do
		if p:IsA("BasePart") then
			p.Anchored = true
			p.CanCollide = false
			p.CanQuery = false
			p.CanTouch = false
			p.CastShadow = false
		end
	end

	if scale and fx:IsA("Model") then
		fx:ScaleTo(scale)
	end

	if fx:IsA("Model") then
		fx:PivotTo(cf)
	elseif fx:IsA("BasePart") then
		fx.CFrame = cf
	end

	fx.Parent = workspace.World.Visuals
	return fx
end










return function(argumentData: any)
	local character: Model = argumentData.Character
	local skillType = argumentData.SkillType

	if not character or not character.PrimaryPart then
		return
	end

	if skillType == "Main" then
		if EffectUtilities.CheckRenderDistance(character.HumanoidRootPart.CFrame, 250) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		
		local Bind: StringValue? = argumentData.Bind

		-- Replication race: reference may not have resolved on this client.
		if not Bind or not Bind:IsDescendantOf(game) then
			return warn("No Bind")
		end

		local orb = GuraOrb.attach(character, character["Left Arm"], CFrame.new(0, -0.7, 0), { Scale = 1, FadeIn = 0 })
		local orb2 = GuraOrb.attach(character, character["Right Arm"], CFrame.new(0, -0.7, 0), { Scale = 1, FadeIn = 0 })

		
		local cleaned = false
		local bindConn: RBXScriptConnection?
		local charConn: RBXScriptConnection?

		local function fadeOutFX(fx: Model?)
			if not fx then return end
			EffectUtilities.ToggleVFX(fx, false)
			Debris:AddItem(fx, .75)   -- let in-flight particles finish
		end

		local function cleanup()
			if cleaned then return end
			cleaned = true
			if bindConn then bindConn:Disconnect() end
			if charConn then charConn:Disconnect() end
			
			--fadeOutFX(clone)
			--fadeOutFX(clone2)
			
			orb.stop(0)
			orb2.stop(0)
		end

		bindConn = Bind.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end)

		-- Attacker despawn / respawn safety net.
		charConn = character.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end)

		-- Bind may have been destroyed between the server fire and this connection.
		if not Bind.Parent then cleanup() end
		
		return
	elseif skillType == "Pre" then
		local hrp = character.HumanoidRootPart
	
		local pre = quickFX(
			script.BeforeSlam.PreVFX,
			hrp.CFrame * CFrame.new(0,-2.5,0), --* CFrame.Angles(-math.pi / 2, 0, 0),
			1
		)
		EffectUtilities.Emit(pre.Air)
		Debris:AddItem(pre, 4)
		
		
		local PreMeshes = script.BeforeSlam["PreMeshes"]:Clone()
		local authored = PreMeshes:GetPivot().Rotation
		local startCF = CFrame.new(hrp.Position + Vector3.new(0, 32, 0)) * authored

		PreMeshes:PivotTo(startCF)
		PreMeshes.Parent = workspace.World.Visuals
		Debris:AddItem(PreMeshes, 1.2)
		
		
		TweenService:Create(PreMeshes.Wind, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			CFrame = CFrame.new(hrp.Position) * authored,
		}):Play()

		task.delay(0.1, function()
			if not PreMeshes.Parent then return end
			TweenService:Create(PreMeshes.Wind, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
				Transparency = 1,
			}):Play()
		end)
		
		TweenService:Create(PreMeshes.Wind2, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			CFrame = CFrame.new(hrp.Position) * authored,
		}):Play()

		task.delay(0.1, function()
			if not PreMeshes.Parent then return end
			TweenService:Create(PreMeshes.Wind2, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
				Transparency = 1,
			}):Play()
		end)
		
		return
	end
	
	if skillType == "Slam" then
		local hrp = character.HumanoidRootPart
		local scale = argumentData.Scale or 1
		
		local rng = Random.new(argumentData.Seed)
		
		local IsMainPlayer = (LocalPlayer.Character == character)
		
		local rootCF = hrp.CFrame
		local ground = rootCF.Position - Vector3.new(0, hrp.Size.Y * 1.5, 0)
		local groundCF = CFrame.new(ground)

		local POP = TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local FAST = TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local SLOW = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		
		local function spawnMesh(asset, size, cfr, life)
			local m = asset:Clone()
			m.Anchored = true
			m.CanCollide = false
			m.CanQuery = false
			m.CanTouch = false
			m.CastShadow = false
			m.Size = size or m.Size
			m.CFrame = cfr
			m.Parent = workspace.World.Visuals
			Debris:AddItem(m, life)
			return m
		end

		local randomYaw = CFrame.Angles(0, math.rad(math.random(0, 360)), math.pi / 2)
		
		local Shockwave1 = spawnMesh(script.Slam.Slam.Shockwave1, Vector3.new(10, 1, 10) * scale,
			groundCF + Vector3.new(0, 3 * scale, 0), 0.15)
		TweenService:Create(Shockwave1, POP, {
			Size = Vector3.new(30, 5, 30) * scale,
			CFrame = groundCF + Vector3.new(0, 3 * scale, 0),
		}):Play()
		
		local Shockwave2 = spawnMesh(script.Slam.Slam.Shockwave2, Vector3.new(15, 15, 4) * scale, groundCF * script.Slam.Slam.Shockwave2:GetPivot().Rotation * CFrame.new(0, 2.5, 0), 0.15)
		TweenService:Create(Shockwave2, FAST, {
			Size = Vector3.new(40, 40, 9.04) * scale,
			CFrame = groundCF * script.Slam.Slam.Shockwave2:GetPivot().Rotation * CFrame.new(0, 2.5, 0 * scale),
			--Transparency = 1,
		}):Play()

		local ring2 = spawnMesh(script.Slam.Slam.Ring, Vector3.new(10, 2, 10) * scale,
			groundCF + Vector3.new(0, 10 * scale, 0), 0.15)
		ring2.Color = Color3.fromRGB(110, 153, 202)
		TweenService:Create(ring2, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
			Size = Vector3.new(60, 7, 60) * scale,
			CFrame = groundCF,
		}):Play()

		local Wind = spawnMesh(script.Slam.Slam.Wind, Vector3.new(10, 10, 5) * scale,
			groundCF * script.Slam.Slam.Wind.CFrame.Rotation + Vector3.new(0, 10 * scale, 0), 0.15)
		TweenService:Create(Wind, SLOW, {
			Size = Vector3.new(40, 40, 26) * scale,
			--CFrame = groundCF,
		}):Play()
		
		local container = Instance.new("Model")
		container.Parent = workspace.World.Visuals

		local highlight = Instance.new("Highlight")
		highlight.Enabled = false
		highlight.Parent  = container

		local bubble = script.Bubble:Clone()
		bubble.CFrame = groundCF
		bubble.Size   = Vector3.new(10, 10, 10)
		bubble.Parent = container

		TweenService:Create(bubble, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
			Size         = Vector3.new(80, 60, 80),
			Transparency = 1,
		}):Play()

		Essentials.Destroy(bubble, 0.2)

		Essentials.Destroy(container, 0.2)
		
		local sphere2 = spawnMesh(Assets.meshes.Sphere2, Vector3.new(10, 10, 10) * scale, groundCF, 0.2)
		sphere2.Color = Color3.new(0.54902, 1, 0.968627)
		TweenService:Create(sphere2, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
			Size = Vector3.new(70, 50, 70) * scale,
			Transparency = 1,
		}):Play()
		
		local GroundSlam = script.Slam.GroundSlam:Clone()
		GroundSlam.Transparency = 1
		GroundSlam:PivotTo(groundCF) -- * CFrame.new(0, 3, 0)
		GroundSlam.Parent = workspace.World.Visuals
		Debris:AddItem(GroundSlam, 4)
		EffectUtilities.Emit(GroundSlam)
		
		
		local HumRP = character:FindFirstChild("HumanoidRootPart")
		local look = HumRP.CFrame.LookVector * Vector3.new(1, 0, 1)
		local facing = CFrame.lookAt(HumRP.Position, HumRP.Position + look.Unit)
		local placement = facing * CFrame.new(0, -3, 0)

		local crack = GuraCrack.play(placement, { Orientation = "Ground", Scale = 1.8 * scale, BreakAfter = -1, Grow = 0.7, Seed = argumentData.Seed })
		secondCracks(placement, 1, 2)

		task.delay(2, function()
			crack.breakNow()


			local breakFX = script["BreakFx"]:Clone()
			breakFX.Transparency = 1
			breakFX:PivotTo(placement) -- * CFrame.new(0, 3, 0)
			breakFX.Parent = workspace.World.Visuals
			Debris:AddItem(breakFX, 4)
			EffectUtilities.Emit(breakFX)
		end)
		
		
		
		
		--if IsMainPlayer then
		--	require(ReplicatedStorage.Modules.ClientEffects.GlassShatterWB).Play({
		--		Color = Color3.fromRGB(245, 245, 250), -- cyan
		--		ImpactPosition = Vector2.new(0.5, 0.5),
		--		Depth = 3,
		--		HoldTime = .01,
		--		Distance = 4,
		--		Thickness = 0.01,
		--		FallAcceleration = 150
		--	})
		--end
	end
end