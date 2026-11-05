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

local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)
local GuraOrb = require(game:GetService("ReplicatedStorage").Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraOrb)
local GuraCrack = require(game:GetService("ReplicatedStorage").Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraCrack)
local Essentials = Essentials
local Tween      = Essentials.Tween



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

return function(argumentData: any)
	local character: Model = argumentData.Character
	local skillType = argumentData.SkillType

	if not character or not character.PrimaryPart then
		return
	end

	local IsMainPlayer = (LocalPlayer.Character == character)
	
	if skillType == "Orb" then	
		if EffectUtilities.CheckRenderDistance(character.HumanoidRootPart.CFrame, 300) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		
		local Bind: StringValue? = argumentData.Bind

		if not Bind or not Bind:IsDescendantOf(game) then
			return
		end
		
		local function fadeOutFX(fx: Model?)
			if not fx then return end
			EffectUtilities.ToggleVFX(fx, false)
			Debris:AddItem(fx, 2)   -- let in-flight particles finish
		end
		
		local root = character:FindFirstChild("Right Leg")
		if not root then
			return
		end
		local orb = GuraOrb.attach(character, root, CFrame.new(0, -0.8, 0), { Scale = 1, FadeIn = 0.5 })
		
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

		charConn = character.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end)

		if not Bind.Parent then cleanup() end
		
		return
			
	elseif skillType == "JumpSlam" then
		local HumRP = character:FindFirstChild("HumanoidRootPart")
		local rng = Random.new(argumentData.Seed)
		local CFrameToUse = argumentData.CFrameToUse
		
		-- Where the server stomped: CFrameToUse is the ground point under Whitebeard (position
		-- only), the same spot its Destroy and hitbox use, so the effects line up with them for
		-- everyone. The facing still comes from this client's view of him. Falls back to the root
		-- (about 3 studs above the ground) if it's missing.
		local ground = if typeof(CFrameToUse) == "CFrame" then CFrameToUse.Position else HumRP.Position - Vector3.new(0, 3, 0)
		local look = HumRP.CFrame.LookVector * Vector3.new(1, 0, 1)
		local facing = CFrame.lookAt(ground, ground + look.Unit)
		local placement = facing * CFrame.new(.25, 0, -2.12)

		local crack = GuraCrack.play(placement, { Orientation = "Ground", Scale = 1, BreakAfter = -1, Grow = 0.4, Seed = argumentData.Seed })

		task.delay(.9, function()
			crack.breakNow()

			local breakFX = script["BreakFx"]:Clone()
			breakFX.Transparency = 1
			breakFX:PivotTo(placement) -- * CFrame.new(0, 3, 0)
			breakFX.Parent = workspace.World.Visuals
			Debris:AddItem(breakFX, 4)
			EffectUtilities.Emit(breakFX)			
		end)
		
		if EffectUtilities.CheckRenderDistance(character.HumanoidRootPart.CFrame, 300) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		
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
		
		local Position = (placement * CFrame.new(0, 0.36, 0)).Position -- just above the ground, like before (root -2.64)
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
				amount = 4,
				sizeRange = { 1.2, 2 },
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
		
	elseif skillType == "Jump" then
		if not IsMainPlayer then return end --only for the user of the skill. No one else.
		
		local timeBetween = math.max(workspace:GetServerTimeNow() - (argumentData.StartTime or 0), 0)
		local hrp = character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end

		local moveParams = RaycastParams.new()
		moveParams.IgnoreWater = true
		moveParams.FilterType = Enum.RaycastFilterType.Exclude
		moveParams.FilterDescendantsInstances = {
			character,
			workspace.World.Visuals,
		}
		local duration = math.max(2 - timeBetween, 0)
		
		shared.clearVelocities(hrp)
		
		local mover = Instance.new("LinearVelocity")
		mover.ForceLimitMode = Enum.ForceLimitMode.PerAxis
		mover.MaxAxesForce = Vector3.new(100000, 100000, 100000)
		mover.Attachment0 = hrp.RootAttachment
		mover.Parent = hrp
		Debris:AddItem(mover, duration)

		local forwardSpeed, forwardDecay, minForward, upSpeed = 100, 125, 0, 60

		local AIR_DIST  = 5
		local LAND_DIST = 3.5
		local leftGround = false

		local conn
		local landingFired = false
		local function cleanup(landed)
			if conn then conn:Disconnect() conn = nil end
			if mover then mover:Destroy() mover = nil end
		end

		conn = RunService.RenderStepped:Connect(function(dt)
			if not mover or not mover.Parent then
				cleanup()
				return
			end
			
			if character:HasTag("Ragdolled") then --HasTag Knockbacked
				cleanup()
				return
			end
			
			--if not mover or not mover:IsDescendantOf(workspace) then -- character:GetAttribute("IsHeavyStun") == true or
			--	cleanup()
			--	return
			--end
			
			-- Landing detection (down-ray only)
			local groundHit = workspace:Raycast(hrp.Position, Vector3.new(0, -AIR_DIST, 0), moveParams)
			if not groundHit then
				leftGround = true
			elseif leftGround and groundHit.Distance <= LAND_DIST then
				cleanup(true)
				return
			end

			local flatLook = hrp.CFrame.LookVector * Vector3.new(1, 0, 1)
			local velocity = flatLook * math.max(forwardSpeed, minForward)

			if upSpeed > 0 then
				velocity = velocity + Vector3.new(0, upSpeed, 0)
				mover.MaxAxesForce = Vector3.new(100000, 100000, 100000) -- driving upward
			else
				mover.MaxAxesForce = Vector3.new(100000, 0, 100000)       -- thrust done -> gravity takes over
			end

			if velocity.X == velocity.X and velocity.Y == velocity.Y and velocity.Z == velocity.Z then
				mover.VectorVelocity = velocity
			end

			forwardSpeed = math.max(minForward, forwardSpeed - forwardDecay * dt)
			upSpeed = math.max(0, upSpeed - 170 * dt)
		end)
		task.delay(duration, cleanup)
		
		return
	end
end