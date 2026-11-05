local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")


local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)

local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)
local GuraOrb = require(game:GetService("ReplicatedStorage").Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraOrb)
local GuraCrack = require(game:GetService("ReplicatedStorage").Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraCrack)
-- Per-character state so the "Slam" call can find and clean these up.
local activeSpins: { [Model]: Model } = {}


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

	fx:ScaleTo(1.5 * scale)
	fx:PivotTo(cf * CFrame.new(0, 0.35, 0) * fx:GetPivot().Rotation)

	setDecals(o, 0)
	setDecals(o2, 1)

	fx.Parent = workspace.World.Visuals
	Debris:AddItem(fx, 2)

	for _, d in fx:GetDescendants() do
		if d:IsA("ParticleEmitter") then
			d:Emit(d:GetAttribute("EmitCount") or 10)
		end
	end

	--task.delay(0.4, function()
	--	if not fx.Parent then return end
	--	-- Hard cut, no crossfade. That's what makes it read as an impact flash.
	--	setDecals(o, 1)
	--	setDecals(o2, 0)
	--	o2.Size = o2.Size * 1.5
	--end)

	task.delay(0.95, function()
		if not fx.Parent then return end
		--setDecals(o2, 1, 0.3)
		setDecals(o, 1, .3)
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

local function spin2(character: Model, variant: string?)
	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then
		return
	end

	local assets = script.spin2.Red
	if variant then
		assets = script.spin2[variant]
	end

	local meshTextures = require(script.spin2.MeshTextures)
	local effectsFolder = workspace.World.Visuals

	local intensity = assets.Intensitylines:Clone()
	intensity.Parent = effectsFolder
	intensity.Position = root.Position - Vector3.new(0, 2.5, 0)
	GpDestroy(intensity, 3)

	local intensityWeld = Instance.new("Weld")
	intensityWeld.Part0 = root
	intensityWeld.C0 = CFrame.new()
	intensityWeld.Part1 = intensity
	intensity.Anchored = false
	intensityWeld.Parent = intensity

	--task.wait(0.4)
	EffectUtilities.ToggleVFX(intensity, false)
	--task.wait(0.15)

	-- Spinning VFX.
	local spinning = assets.Spinning:Clone()
	spinning.Parent = effectsFolder
	spinning.Position = root.Position
	local spinningWeld = Instance.new("Weld")
	spinningWeld.Part0 = root
	--spinningWeld.C0 = CFrame.new(0, -character.PrimaryPart.Size.Y / 2, 0)
	spinningWeld.C0 = CFrame.new(0, 3.5, 0)

	spinningWeld.Part1 = spinning
	spinning.Anchored = false
	spinningWeld.Parent = spinning

	local main = assets.Main:Clone()
	main.Parent = effectsFolder
	main.Position = root.Position
	local mainWeld = Instance.new("Weld")
	mainWeld.Part0 = root
	--mainWeld.C0 = CFrame.Angles(-1.5707963267948966, 0, 0) 
	mainWeld.C0 = CFrame.new(0,3.5,0) * CFrame.Angles(-1.5707963267948966, 0, 0) 

	mainWeld.Part1 = main
	main.Anchored = false
	mainWeld.Parent = main

	local lastGust = 0
	while true do
		task.wait()

		-- Periodic wind gusts.
		if tick() - lastGust >= 0.25 then
			local gust = assets.SOFT_WIND:Clone()
			gust.Position = root.Position
			local gustWeld = Instance.new("Weld")
			gustWeld.Part0 = root
			gustWeld.C0 = CFrame.Angles(0, math.rad(math.random(0, 180)), 0)
			gustWeld.Part1 = gust
			gust.Anchored = false
			gustWeld.Parent = gust
			gust.Parent = effectsFolder

			TweenService:Create(gust.Mesh, TweenInfo.new(0.25), { Scale = Vector3.new(7, 3.5, 7) }):Play()
			TweenService:Create(gust.Decal, TweenInfo.new(0.2), { Transparency = 1 }):Play()

			task.spawn(function()
				for _, texture in meshTextures.SoftWind do
					gust.Decal.Texture = texture
					RunService.Heartbeat:Wait()
					task.wait(0.025)
				end
				gust:Destroy()
			end)

			lastGust = tick()
		end

		-- End the spin once the attribute is cleared.
		if character:GetAttribute("sweepspin") == nil then
			GpDestroy(main, 3)
			GpDestroy(spinning, 3)

			task.spawn(function()
				--task.wait(0.15)
				EffectUtilities.ToggleVFX(spinning, false)
				EffectUtilities.ToggleVFX(main, false)
				for _, beam in main:GetDescendants() do
					if beam:IsA("Beam") then
						_G.tween(beam, {
							0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0,
						}, {
							Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) }),
							TextureSpeed = 0.3,
						})
					end
				end
			end)

			--local groundHit = workspace:Raycast(root.Position, Vector3.new(0, -50, 0), guraRayParams)
			--task.wait(0.4)
			--if groundHit then
			--	for _, dust in script.spin2.Dust:GetChildren() do
			--		local emitter = dust:Clone()
			--		emitter.Parent = character["Right Leg"]
			--		local col = groundHit.Instance.Color
			--		emitter.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, col), ColorSequenceKeypoint.new(1, col) })
			--		task.delay(0.8, function()
			--			emitter.Enabled = false
			--			GpDestroy(emitter, 3)
			--		end)
			--	end
			--end

			break
		end
	end
end

local function smashMeshes(cf: CFrame)
	local fx = script.Smash:Clone()

	local folder = fx:FindFirstChild("mesh")
	if not folder then
		warn("Smash: missing 'mesh' folder")
		fx:Destroy()
		return
	end

	fx.Parent = workspace.World.Visuals
	Debris:AddItem(fx, 2)

	---------------------------------------------------------------- mesh1
	local mesh1 = folder:FindFirstChild("mesh1")
	if mesh1 then
		mesh1.Anchored = true
		mesh1.CanCollide = false
		mesh1.CanQuery = false
		mesh1.CanTouch = false
		mesh1.CastShadow = false
		mesh1.Transparency = 1   -- SpecialMesh carries the visual, not the part

		-- Authored lying flat; -pi/2 about X is baked into the source CFrame.
		mesh1.CFrame = cf * CFrame.Angles(-math.pi / 2, 0, 0)

		local m1 = mesh1:FindFirstChildOfClass("SpecialMesh")
		m1.Scale = Vector3.new(0.4, 30, 0.4)
		m1.Offset = Vector3.new(0, 0, 0)

		TweenService:Create(m1, TweenInfo.new(0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Scale = Vector3.new(14, 46, 14),
			Offset = Vector3.new(0, -6, 0),
		}):Play()

		local d1 = mesh1:FindFirstChildOfClass("Decal")
		d1.Transparency = 0
		task.delay(0.15, function()
			if not d1.Parent then return end
			TweenService:Create(d1, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
				Transparency = 1,
			}):Play()
		end)
	end

	---------------------------------------------------------------- wind
	local wind = folder:FindFirstChild("wind")
	if wind then
		wind.Anchored = true
		wind.CanCollide = false
		wind.CanQuery = false
		wind.CanTouch = false
		wind.CastShadow = false
		wind.Transparency = 1

		wind.CFrame = cf * CFrame.new(0, 20, 0) * CFrame.Angles(-math.pi, 0, 0)

		local mw = wind:FindFirstChildOfClass("SpecialMesh")
		mw.Scale = Vector3.new(5, 15, 5)
		mw.Offset = Vector3.new(0, 0, 0)

		TweenService:Create(mw, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Scale = Vector3.new(15, 30, 15),
			Offset = Vector3.new(0, 0, 0),
		}):Play()

		TweenService:Create(wind, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
			CFrame = wind.CFrame * CFrame.Angles(0, math.rad(-120), 0),
		}):Play()

		local dw = wind:FindFirstChildOfClass("Decal")
		dw.Transparency = 0
		task.delay(0.1, function()
			if not dw.Parent then return end
			TweenService:Create(dw, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
				Transparency = 1,
			}):Play()
		end)
	end

	EffectUtilities.Emit(fx)
end

local SPIN_STEP = math.rad(-120)

-- Chained CFrame tweens, one leg at a time. Runs until the part is gone.
-- `track` re-centres on the character each leg; the source uses it for the
-- white layer only, so the vortex follows the player horizontally.
local function spinForever(part: BasePart, legTime: number, track: BasePart?)
	task.spawn(function()
		while part.Parent do
			local goal
			if track and track.Parent then
				local rx, ry, rz = part.CFrame:ToOrientation()
				goal = CFrame.new(track.Position.X, part.Position.Y, track.Position.Z)
					* CFrame.Angles(rx, ry, rz)
					* CFrame.Angles(0, SPIN_STEP, 0)
			else
				goal = part.CFrame * CFrame.Angles(0, SPIN_STEP, 0)
			end

			local tw = TweenService:Create(part, TweenInfo.new(legTime, Enum.EasingStyle.Linear), {
				CFrame = goal,
			})
			tw:Play()
			tw.Completed:Wait()
		end
	end)
end

-- White layer: three Wind parts directly under `beam`.
-- Beams open one at a time, each closing 0.85s after its own open.
local function whiteLayer(container: Instance, track: BasePart)
	local beams = {}

	for _, wind in container:GetChildren() do
		if not wind:IsA("BasePart") then continue end

		for _, b in wind:GetDescendants() do
			if b:IsA("Beam") then
				b:SetAttribute("wd0", b.Width0)
				b:SetAttribute("wd1", b.Width1)
				b.Width0 = 0
				b.Width1 = 0
				table.insert(beams, b)
			end
		end

		spinForever(wind, 0.15, track)
	end

	task.spawn(function()
		for _, b in beams do
			task.wait(0.05)
			if not b.Parent then continue end

			TweenService:Create(b, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				Width0 = b:GetAttribute("wd0"),
				Width1 = b:GetAttribute("wd1"),
			}):Play()

			task.delay(0.85, function()
				if not b.Parent then return end
				TweenService:Create(b, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
					Width0 = 0,
					Width1 = 0,
				}):Play()
			end)
		end
	end)
end

-- Blue layer: three Wind parts inside the `blue` folder.
-- Spins 1.5x faster, doesn't track the player, and its beams run a
-- four-stage sequence: open, bow out, collapse down, whip outward.
local function blueLayer(blueFolder: Instance, track: BasePart, scale: number)
	for _, part in blueFolder:GetChildren() do
		if part:IsA("BasePart") then
			spinForever(part, 0.1, track)
		end
	end

	for _, b in blueFolder:GetDescendants() do
		if not b:IsA("Beam") then continue end
		local a0, a1 = b.Attachment0, b.Attachment1
		if not (a0 and a1) then continue end

		local w0, w1 = b.Width0, b.Width1
		b.Width0 = 0
		b.Width1 = 0

		-- Stage 1: open.
		TweenService:Create(b, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			Width0 = w0,
			Width1 = w1,
		}):Play()

		-- Stage 2: bow outward while it spins.
		task.delay(0.25, function()
			if not b.Parent then return end
			TweenService:Create(a1, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
				Position = a1.Position * 1.15,
			}):Play()
			TweenService:Create(b, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				CurveSize0 = b.CurveSize0 * 1.15,
				CurveSize1 = b.CurveSize1 * 1.15,
			}):Play()
		end)

		-- Stage 3: thin out to nothing in place. No collapse, no whip.
		task.delay(0.85, function()
			if not b.Parent then return end
			TweenService:Create(b, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				Width0 = 0,
				Width1 = 0,
			}):Play()
		end)
	end
end

local function spinFX(character: Model)
	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return end


	local fx = script.Spin:Clone()
	local s = fx:GetScale()
	fx:ScaleTo(s)
	fx:PivotTo(root.CFrame * CFrame.new(0, -.5, 0))
	fx.Parent = workspace.World.Visuals
	Debris:AddItem(fx, 3.5)
	print(script.Spin:GetScale())

	local beamFolder = fx:FindFirstChild("beam")
	if not beamFolder then
		warn("Spin: missing 'beam' folder")
		return
	end

	local threeWind = beamFolder:FindFirstChild("threeWind")
	if threeWind then
		whiteLayer(threeWind, root)
	else
		warn("Spin: missing 'threeWind'")
	end

	local blue = beamFolder:FindFirstChild("blue")
	if blue then
		blueLayer(blue, root, s)
	else
		warn("Spin: missing 'blue'")
	end
	
	return threeWind, blue
end

local activeTweens = {}
local BoatTweenG = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)

function _G.tween(instance, tweenParams, goalTable, stepType, forceRestart)
	-- If forceRestart is set and a tween is already running on this instance, stop and destroy it.
	if forceRestart ~= nil and activeTweens[instance] then
		local existingTween = activeTweens[instance][1]
		existingTween:Stop()
		existingTween:Destroy()
		activeTweens[instance] = nil
	end

	if not instance or instance == nil or instance.Parent == nil then
		return
	end

	-- If a tween is already running and any goal properties overlap, stop it.
	pcall(function()
		if activeTweens[instance] then
			local existingTween = activeTweens[instance][1]
			local existingGoal = activeTweens[instance][2]
			local hasOverlap = false

			for property, _ in goalTable do
				if existingGoal[property] then
					hasOverlap = true
				end
			end

			if hasOverlap then
				existingTween:Stop()
				existingTween:Destroy()
				activeTweens[instance] = nil
			end
		end
	end)

	local tweenInfo = {
		Time = tweenParams[1],
		EasingStyle = string.gsub(tostring(tweenParams[2]), "Enum.EasingStyle.", ""),
		EasingDirection = string.gsub(tostring(tweenParams[3]), "Enum.EasingDirection.", ""),
		RepeatCount = tweenParams[4],
		Reverses = tweenParams[5],
		DelayTime = tweenParams[6],
		StepType = stepType,
		CustomEventStepFreq = goalTable.CustomEventStepFreq or nil,
		Goal = goalTable,
	}

	local tween = BoatTweenG:Create(instance, tweenInfo)
	activeTweens[instance] = { tween, goalTable }
	tween:Play()

	if tween ~= nil and tween.Completed ~= nil then
		local completedConnection
		completedConnection = tween.Completed:Connect(function()
			completedConnection:Disconnect()
			completedConnection = nil

			pcall(function()
				tween:Destroy()
			end)

			activeTweens[instance] = nil
			table.clear(goalTable)
		end)

		instance.Destroying:Once(function()
			if completedConnection then
				completedConnection:Disconnect()
				completedConnection = nil
			end

			pcall(function()
				tween:Destroy()
			end)

			activeTweens[instance] = nil
			table.clear(goalTable)
		end)
	else
		activeTweens[instance] = nil
	end

	return tween
end

return function(argumentData: any)
	local character: Model = argumentData.Char -- server fires { Char = Character, ... }
	local skillType = argumentData.SkillType

	if not character or not character.PrimaryPart then
		return
	end

	if skillType == "spin" then
		if EffectUtilities.CheckRenderDistance(character.HumanoidRootPart.CFrame, 400) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		local Bind: StringValue? = argumentData.Bind

		if not Bind or not Bind:IsDescendantOf(game) then
			return
		end
		
		local cleaned = false
		local charConn: RBXScriptConnection?
		local bindConn: RBXScriptConnection?
		
		local threeWind, blue = spinFX(character)
		
		local Ground = script.GroundLong:Clone()
		Ground.Parent = workspace.World.Visuals
		EffectUtilities.Emit(Ground)
		EffectUtilities.ToggleVFX(Ground, true)
		
		task.delay(1, function()
			if Ground and Ground.Parent then
				EffectUtilities.ToggleVFX(Ground, false)
			end
		end)
		Debris:AddItem(Ground, 4)
		
		local weld = Instance.new("Weld")
		weld.Part0 = character:FindFirstChild("HumanoidRootPart")
		weld.Part1 = Ground
		weld.C0 = CFrame.new(0, -2.7, 0)
		weld.Parent = Ground
		
		task.spawn(function()
			spin2(character, argumentData.Variant)
		end)
		
		local function setBeams(model: Instance, on: boolean)
			for _, d in model:GetDescendants() do
				if d:IsA("Beam") then
					d.Enabled = on
				end
			end
		end
		
		local function cleanup()
			if cleaned then return end
			cleaned = true
			if charConn then charConn:Disconnect() end
			if bindConn then bindConn:Disconnect() end
			
			local spinModel = activeSpins[character]
			if spinModel and spinModel.Parent then
				spinModel:Destroy()
			end
			activeSpins[character] = nil
			
			setBeams(threeWind, false)
			setBeams(blue, false)
			
			if Ground and Ground.Parent then
				EffectUtilities.ToggleVFX(Ground, false)
			end
		end	
				
		charConn = character.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end)

		bindConn = Bind.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end)

		task.delay(1.5, function()
			cleanup()
		end)
		
		return
	elseif skillType == "Orb" then	
		if EffectUtilities.CheckRenderDistance(character.HumanoidRootPart.CFrame, 400) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		
		local Bind: StringValue? = argumentData.Bind		
		
		local root = character.Bisento.blade2
		
		local orb = GuraOrb.attach(character, root, CFrame.new(0, 1, 0), { Scale = 1.4, FadeIn = 0.25 })
		
		local startup = script.Folder.startup:Clone()
		startup.Parent = workspace.World.Visuals
		
		local weld = Instance.new("Weld")
		weld.Part0 = root
		weld.Part1 = startup
		weld.C0 = CFrame.new(0, 1, 0)
		weld.Parent = startup
		
		EffectUtilities.Emit(startup)
		Debris:AddItem(startup, 4)
		
		local startup2 = script.Folder.startup2:Clone()
		startup2.Parent = workspace.World.Visuals

		local weld2 = Instance.new("Weld")
		weld2.Part0 = root
		weld2.Part1 = startup2
		weld2.C0 = CFrame.new(0, 1, 0)
		weld2.Parent = startup2

		EffectUtilities.Emit(startup2)
		Debris:AddItem(startup2, 4)
		
		local function fadeOutFX(fx: Model?)
			if not fx then return end
			EffectUtilities.ToggleVFX(fx, false)
			Debris:AddItem(fx, 2)  
		end
				
		local linesCF = character.HumanoidRootPart.CFrame * CFrame.new(0, -character.HumanoidRootPart.Size.Y * 1.5, 0)

		local cleaned = false
		local bindConn: RBXScriptConnection?
		local charConn: RBXScriptConnection?
		
		local function cleanup()
			if cleaned then return end
			cleaned = true
			if bindConn then bindConn:Disconnect() end
			if charConn then charConn:Disconnect() end
			
			orb.stop()
			--fadeOutFX(smol)
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
	elseif skillType == "Slam" then
		local CFrameToUse = argumentData.CFrameToUse
		
		local rng = Random.new(argumentData.Seed)

		local spinModel = activeSpins[character]
		if spinModel and spinModel.Parent then
			spinModel:Destroy()
		end
		
		activeSpins[character] = nil
		
		if EffectUtilities.CheckRenderDistance(character.HumanoidRootPart.CFrame, 300) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		
		local HumRP = character:FindFirstChild("HumanoidRootPart")
		
		
		local look = CFrameToUse.LookVector * Vector3.new(1, 0, 1)
		local placement = CFrame.lookAt(
			CFrameToUse.Position,
			CFrameToUse.Position + look.Unit
		) * CFrame.new(0, -3, 0)

		local crack = GuraCrack.play(placement, { Orientation = "Ground", Scale = 0.7, BreakAfter = -1, Seed = argumentData.Seed })

		secondCracks(placement, 1) -- Also cracks.

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
				Size         = Vector3.new(30, 30, 30),
				Transparency = 1,
			}):Play()

			Essentials.Destroy(bubble, 0.25)

			Essentials.Destroy(container, 0.35)
		end)
		
		local Good = script.GroundHit:Clone()
		Good:PivotTo(placement)
		Good.Parent = workspace.World.Visuals
		EffectUtilities.Emit(Good)
		Debris:AddItem(Good, 4)
		
		--[[
		local Map = workspace.World.Map.Destroyable:WaitForChild("Map", 20):WaitForChild("Floor")
		local Map2 = workspace.World.Map.Destroyable
		local VisualParams = RaycastParams.new()
		VisualParams.FilterType = Enum.RaycastFilterType.Include
		VisualParams.FilterDescendantsInstances = {
			Map,
			workspace.World.Map["Indestructible Map"].IndestructableFloor,
			Map2
		}

		local Direction = Vector3.yAxis * -10
		local Raycast = workspace:Raycast(CFrameToUse.Position, Direction, VisualParams)

		if Raycast then		
			coroutine.wrap(RockHandler.Crater)(Raycast.Position, Direction, {
				Amount = 16,
				Distance = 11,

				LookAt = {
					Min = -10,
					Max = -10
				},

				Exposure = {
					Min = 1,
					Max = 1.4
				},

				BaseZ = 2.7,
				SizeMultiplier = 1.6,
				CraterSmoke = false,
			})

			coroutine.wrap(RockHandler.Crater)(Raycast.Position, Direction, {
				Amount = 24,
				Distance = 14,

				LookAt = {
					Min = 14,
					Max = -14
				},

				Exposure = {
					Min = 1,
					Max = 1.4
				},
				BaseZ = 2.7,
				SizeMultiplier = 1.4,
				CraterSmoke = false,
			})
		end	
		]]

		return
	end
end