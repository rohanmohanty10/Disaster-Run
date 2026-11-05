local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)
local SoundHandler = require(ReplicatedStorage.Modules.SoundHandler)
local GuraOrb = require(game:GetService("ReplicatedStorage").Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraOrb)
local GuraCrack = require(game:GetService("ReplicatedStorage").Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraCrack)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

local Essentials = Essentials
local Tween      = Essentials.Tween

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

local function secondCracks(cf: CFrame, scale: number)
	local fx = script["Gura Crack2"]:Clone()

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

	task.delay(0.95, function()
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

	local gura1 = model:FindFirstChild("Gura1")
	if not gura1 then
		warn("growCrack: missing Gura1")
		return
	end

	for i, ringName in RINGS do
		local ring = gura1:FindFirstChild(ringName)
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

local function kaboom(cf: CFrame, scale: number?)
	local s = scale or 1
	local fx = script.Kaboom:Clone()

	local startPart = fx:FindFirstChild("Start")
	local endPart = fx:FindFirstChild("End")
	if not (startPart and endPart) then
		warn("Kaboom: missing Start or End")
		fx:Destroy()
		return
	end

	local startMesh = startPart:FindFirstChildOfClass("SpecialMesh")
	local endMesh = endPart:FindFirstChildOfClass("SpecialMesh")
	local startDecal = startPart:FindFirstChildOfClass("Decal")

	local authored = startPart.CFrame.Rotation
	local relative = startPart.CFrame:ToObjectSpace(endPart.CFrame)
	-- Scale the separation between Start and End, keep its rotation.
	relative = CFrame.new(relative.Position * s) * relative.Rotation

	local goalSize = endPart.Size * s
	local goalScale = endMesh and endMesh.Scale * s
	local goalOffset = endMesh and endMesh.Offset * s

	for _, p in { startPart, endPart } do
		p.Anchored = true
		p.CanCollide = false
		p.CanQuery = false
		p.CanTouch = false
		p.CastShadow = false
	end

	endPart:Destroy()

	startPart.Size = startPart.Size * s
	if startMesh then
		startMesh.Scale = startMesh.Scale * s
		startMesh.Offset = startMesh.Offset * s
	end

	startPart.CFrame = CFrame.new(cf.Position) * authored
	fx.PrimaryPart = startPart
	fx.Parent = workspace.World.Visuals
	Debris:AddItem(fx, 1)

	local info = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

	TweenService:Create(startPart, info, {
		Size = goalSize,
		CFrame = startPart.CFrame * relative,
	}):Play()

	if startMesh and goalScale then
		TweenService:Create(startMesh, info, {
			Scale = goalScale,
			Offset = goalOffset,
		}):Play()
	end

	if startDecal then
		task.delay(0.15, function()
			if not startDecal.Parent then return end
			TweenService:Create(startDecal, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
				Transparency = 1,
			}):Play()
		end)
	end
end

local function kaboom2(cf: CFrame, scale: number?)
	local s = scale or 1
	local fx = script.Kaboom2:Clone()

	local startPart = fx:FindFirstChild("Start")
	local endPart = fx:FindFirstChild("End")
	if not (startPart and endPart) then
		warn("Kaboom2: missing Start or End")
		fx:Destroy()
		return
	end

	local authored = startPart.CFrame.Rotation
	local relative = startPart.CFrame:ToObjectSpace(endPart.CFrame)
	relative = CFrame.new(relative.Position * s) * relative.Rotation

	-- MeshParts: Size is the visual, there's no SpecialMesh to scale.
	local goalSize = endPart.Size * s

	for _, p in { startPart, endPart } do
		p.Anchored = true
		p.CanCollide = false
		p.CanQuery = false
		p.CanTouch = false
		p.CastShadow = false
	end

	endPart:Destroy()

	startPart.Size = startPart.Size * s
	startPart.CFrame = CFrame.new(cf.Position) * authored
	fx.PrimaryPart = startPart
	fx.Parent = workspace.World.Visuals
	Debris:AddItem(fx, 1)

	local info = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

	TweenService:Create(startPart, info, {
		Size = goalSize,
		CFrame = startPart.CFrame * relative,
	}):Play()

	task.delay(0.1, function()
		if not startPart.Parent then return end
		TweenService:Create(startPart, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
			Transparency = 1,
		}):Play()
	end)
end

return function(argumentData: any)
	local character: Model = argumentData.Character
	local skillType = argumentData.SkillType

	if not character or not character.PrimaryPart then
		return
	end
	
	if skillType == "Orb" then	
		
		if EffectUtilities.CheckRenderDistance(character.HumanoidRootPart.CFrame, 300) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end		
		
		local Bind: StringValue? = argumentData.Bind

		-- Replication race: reference may not have resolved on this client.
		if not Bind or not Bind:IsDescendantOf(game) then
			return
		end
		
		local root = character:FindFirstChild("Right Leg")
		if not root then
			return
		end
		local orb = GuraOrb.attach(character, root, CFrame.new(0, -0.8, 0), { Scale = 1, FadeIn = 0.25 })
		
		local function scaleLifetime(model: Instance, mul: number)
			for _, d in model:GetDescendants() do
				if d:IsA("ParticleEmitter") then
					local lt = d.Lifetime
					d.Lifetime = NumberRange.new(lt.Min * mul, lt.Max * mul)
				end
			end
		end
		
		local function setEmitters(model: Instance, on: boolean)
			for _, d in model:GetDescendants() do
				if d:IsA("ParticleEmitter") then
					d.Enabled = on
				end
			end
		end
		
		local function fadeOutFX(fx: Model?)
			if not fx then return end
			setEmitters(fx, false)
			Debris:AddItem(fx, 2)   -- let in-flight particles finish
		end
				
		--local linesCF = character.HumanoidRootPart.CFrame * CFrame.new(0, -character.HumanoidRootPart.Size.Y * 1.5, 0)
		--local smol = speedLinesSmol(linesCF, 1)
		
		local cleaned = false
		local bindConn: RBXScriptConnection?
		local charConn: RBXScriptConnection?

		local function cleanup()
			if cleaned then return end
			cleaned = true
			if bindConn then bindConn:Disconnect() end
			if charConn then charConn:Disconnect() end

			orb.stop()
		end
		
		bindConn = Bind.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end)

		-- Attacker despawn / respawn safety net.
		charConn = character.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end)

		if not Bind.Parent then cleanup() end
		
		return
	elseif skillType == "Slam" then
		if EffectUtilities.CheckRenderDistance(character.HumanoidRootPart.CFrame, 300) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end		
		
		local HumRP = character:FindFirstChild("HumanoidRootPart")
		local look = HumRP.CFrame.LookVector * Vector3.new(1, 0, 1)
		local facing = CFrame.lookAt(HumRP.Position, HumRP.Position + look.Unit)
		local placement = facing * CFrame.new(.25, -3, -2.12)

		local crack = GuraCrack.play(placement, { Orientation = "Ground", Scale = 0.4, BreakAfter = -1, Grow = 0.6 })
		secondCracks(placement, 1)

		task.delay(1, function()
			crack.breakNow()

			local breakFX = script["BreakFx"]:Clone()
			breakFX.Transparency = 1
			breakFX:PivotTo(placement) -- * CFrame.new(0, 3, 0)
			breakFX.Parent = workspace.World.Visuals
			Debris:AddItem(breakFX, 4)
			EffectUtilities.Emit(breakFX)			
		end)
		
		task.spawn(function()
			local container = Instance.new("Model")
			container.Parent = workspace.World.Visuals

			local highlight = Instance.new("Highlight")
			highlight.Enabled = false
			highlight.Parent  = container

			local bubble = script.Bubble:Clone()
			bubble.CFrame = placement
			bubble.Size   = Vector3.new(5, 5, 5)
			bubble.Parent = container

			TweenService:Create(bubble, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
				Size         = Vector3.new(15, 15, 15),
				Transparency = 1,
			}):Play()

			Essentials.Destroy(bubble, 0.25)

			Essentials.Destroy(container, 0.35)
		end)
		
		local Position = (character.HumanoidRootPart.CFrame * CFrame.new(.25, -2.64, -2.12)).Position
		local Direction = Vector3.yAxis * -5
		
		local Good = script.HitFx:Clone()
		Good:PivotTo(placement)
		Good.Parent = workspace.World.Visuals
		EffectUtilities.Emit(Good)
		Debris:AddItem(Good, 4)
		
		shared.flyingdebris({
			position = Position,
			Seed = math.random(1, 1000000),

			chunk = {
				amount = 2,
				sizeRange = { 0.6, 1.2 },
				spread = { -12, 12 },
				upward = { 8, 18 },
				speedMult = 1.5,
			},

			small = {
				amountRange = { 4, 6 },
				sizeRange = { 0.4, 0.7 },
				spread = { -20, 20 },
				upward = { 10, 30 },
				lifetime = 2,
			},
		})
		
		return
	elseif skillType == "Fissure" then
		local CFrameOffset = argumentData.Offset
		local Index = argumentData.Index or 1
		
		-- Per-index escalation. Index 1 is closest to the caster, 4 is furthest.
		local FISSURE_STEPS = {
			[1] = {
				CraterAmount = 8,
				CraterDistance = 4.5,
				RockSize = 1,
				RockCount = 3,
				RockVelocity = 35,
				BubbleStart = 3,
				BubbleEnd = 10,
				KaboomScale = .3,
				Kaboom2Scale = .8,
			},
			[2] = {
				CraterAmount = 9,
				CraterDistance = 5,
				RockSize = 1.1,
				RockCount = 5,
				RockVelocity = 40,
				BubbleStart = 5,
				BubbleEnd = 13,
				KaboomScale = .5,
				Kaboom2Scale = 1,
			},
			[3] = {
				CraterAmount = 10,
				CraterDistance = 5.5,
				RockSize = 1.2,
				RockCount = 7,
				RockVelocity = 45,
				BubbleStart = 7,
				BubbleEnd = 15,
				KaboomScale = 1,
				Kaboom2Scale = 1.2,
			},
			[4] = {
				CraterAmount = 12,
				CraterDistance = 7,
				RockSize = 1.3,
				RockCount = 10,
				RockVelocity = 52,
				BubbleStart = 8,
				BubbleEnd = 17,
				KaboomScale = 1.5,
				Kaboom2Scale = 1.5,
			},
		}
		local step = FISSURE_STEPS[Index] or FISSURE_STEPS[1]

		local Direction = Vector3.yAxis * -10
		local Map = workspace.World.Map.Destroyable:WaitForChild("Map", 20):WaitForChild("Floor")
		local Map2 = workspace.World.Map.Destroyable
		local VisualParams = RaycastParams.new()
		VisualParams.FilterType = Enum.RaycastFilterType.Include
		VisualParams.FilterDescendantsInstances = {
			Map,
			workspace.World.Map["Indestructible Map"].IndestructableFloor,
			Map2
		}
		
		local BlueExplosion: BasePart = script.Explosions["BlueExplosion"..Index]:Clone()
		BlueExplosion.Position = (CFrameOffset * CFrame.new(0, -3, 0)).Position
		BlueExplosion.Parent = workspace.World.Visuals
		Debris:AddItem(BlueExplosion, 2)
		local explosion = BlueExplosion:FindFirstChild("Explosion")
		local ground = BlueExplosion:FindFirstChild("Ground")


		local Raycast = workspace:Raycast(CFrameOffset.Position, Direction, VisualParams)
		--if not Raycast then return end
		local newCFrame = CFrameOffset * CFrame.new(0, -3, 0)

		
		if Raycast then		
			explosion.WorldPosition = Raycast.Position
			ground.WorldPosition = Raycast.Position + Vector3.new(0, 0.2, 0)
			EffectUtilities.Emit(explosion)
			EffectUtilities.Emit(ground)
			
			newCFrame = CFrame.new(Raycast.Position + Vector3.new(0, 0.1, 0))
			
			--task.spawn(RockHandler.Crater, Raycast.Position, Direction, {
			--	Amount = step.CraterAmount,
			--	Distance = step.CraterDistance,
			--	SizeMultiplier = step.RockSize,
			--	LookAt = { Min = -5, Max = 5 },
			--	Exposure = { Min = 0.5, Max = 0.7 },
			--	CraterSmoke = false
			--})

			shared.flyingdebris({
				position = Raycast.Position, --Position,
				Seed = math.random(1, 1000000),

				chunk = {
					amount = 3,
					sizeRange = { 0.8, 1.2 },
					spread = { -12, 12 },
					upward = { 8, 18 },
					speedMult = 1.5,
				},

				small = {
					amountRange = { 2, 3 },
					sizeRange = { 0.4, 0.7 },
					spread = { -20, 20 },
					upward = { 10, 20 },
					lifetime = 2,
				},
			})
		else
			EffectUtilities.Emit(explosion)			
		end
		
		kaboom(newCFrame, step.KaboomScale)
		kaboom2(newCFrame * CFrame.new(0, 10, 0), step.Kaboom2Scale)
		--task.spawn(RockHandler.Rockst, Raycast.Position, Direction, {
		--	Size = { 0.75, 1.5 },
		--	Count = step.RockCount,
		--	Velocity = step.RockVelocity,
		--})

		local container = Instance.new("Model")
		container.Parent = workspace.World.Visuals

		local highlight = Instance.new("Highlight")
		highlight.Enabled = false
		highlight.Parent = container

		local bubble = script.Bubble:Clone()
		bubble.CFrame = newCFrame
		bubble.Size = Vector3.one * step.BubbleStart
		bubble.Parent = container

		TweenService:Create(bubble, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
			Size = Vector3.one * step.BubbleEnd,
			Transparency = 1,
		}):Play()

		Essentials.Destroy(bubble, 0.25)
		Essentials.Destroy(container, 0.35)
		
		return
	end
end