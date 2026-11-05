-- SunaTornado (client effects) — the sand-tornado visual for the Suna
-- "Desert Tornado" move, fired from the server on the "throw" marker.
--   "Spawn" : spawn the tornado locked onto the server's Root anchor (X/Z only, so
--             it travels straight and never climbs). Sheds sand clouds (Mesh1/Mesh2)
--             and ripped-up rocks as it drifts; self-ends when the Root is destroyed.
--
-- Required children of this ModuleScript:
--   Mesh1, Mesh2        — sand-cloud chunks (BaseParts)
--   TatsumakiCenter     — tornado body (BasePart)
--   Outer               — outer ring (BasePart)
--   FloatingRocks       — debris rock template (Attachments "Left"/"Right" + Trail)
--   SFX.Normal          — looping twister sounds
--   Tornado (optional)  — detailed model (Twist/Glow/decals) spun like the reference

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UtilityModule = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local Velocity     = require(game.ReplicatedStorage.Modules.Velocity2)

local RNG = Random.new()
local TornadoVFX = require(script.TornadoVFX)
-- the tornado's funnel spins rubble around this client's anchor (Debree "Funnel" absorbs)
local DebreeController = require(ReplicatedStorage.Modules.Debree.DebreeController)
-- ===== Tuning ================================================================
local RENDER_DISTANCE = 400
local ROT_SPEED = 220 -- how fast the Outer ring visually spins (deg/sec)
local MODEL_SPIN = 500 -- how fast the Tornado model spins (deg/sec, matches reference)
local MODEL_HEIGHT = 0 -- studs to lift the Tornado model relative to the base
local ROCK_RATE = 0.15 -- seconds between shed rocks
local MESH_RATE = 0.15 -- seconds between sand-cloud puffs
local ROCK_LIFETIME_MIN, ROCK_LIFETIME_MAX = 0.65, 0.85
--local SAND_COLOR = Color3.fromRGB(207, 178, 122) -- tornado + dust tint (was ground color)

local SAND_COLOR = Color3.fromRGB(186, 154, 117) -- tornado + dust tint (was ground color)

-- ===== Where things live / helpers ==========================================
local function getVisualsFolder(): Instance
	local world = workspace:FindFirstChild("World")
	local visuals = world and world:FindFirstChild("Visuals")
	return visuals or workspace
end

-- Rock rays hit this game's world geometry (was Islands/Ships/Env).
local RockRayParams = RaycastParams.new()
RockRayParams.FilterType = Enum.RaycastFilterType.Include
do
	local world = workspace:FindFirstChild("World")
	local map = world and world:FindFirstChild("Map")
	RockRayParams.FilterDescendantsInstances = { map or workspace }
end
RockRayParams.IgnoreWater = true

local function matchMaterial(part: BasePart, source: BasePart)
	part.Color = source.Color
	part.Material = source.Material
	part.MaterialVariant = source.MaterialVariant
end

local function toggle(root: Instance, enabled: boolean)
	for _, d in root:GetDescendants() do
		if d:IsA("ParticleEmitter") or d:IsA("Trail") then
			d.Enabled = enabled
		end
	end
end

-- Transparency fade (reference used _G.tween @ 0.45s Quad).
local function fadeTransparency(inst: Instance, target: number, direction: Enum.EasingDirection)
	TweenService:Create(inst, TweenInfo.new(0.45, Enum.EasingStyle.Quad, direction), { Transparency = target }):Play()
end

-- ===== Live state + object pools ============================================
local activeCount = 0
local loopConn: RBXScriptConnection? = nil

local meshes = {}
local rocks = {}
local tornados = {}

local meshPool = {} -- [index] = { reusable meshes }
local rockPool = {} -- { reusable rocks }

local startLoop -- forward declaration

-- Local anchors driving each cast's tornado, by the server's tornado Id (see "NewTornado")
local tornadoAnchors = setmetatable({}, { __mode = "v" })






-- up near your other tuning constants
local HEIGHT_OFFSET = 0 -- studs to lift the tornado off the ground
-- ===== Spawn the tornado, locked to the server anchor ========================


-- ===== Dispatcher ============================================================
return function(argumentData: any)
	
	
	if argumentData.SkillType == "NewTornado" then
		-- The server's Root is made the same frame this fires, so with StreamingEnabled it usually
		-- hasn't reached this client yet (it arrives as nil). Instead, drive a local anchor along the
		-- same straight path the server tweens the Root along, caught up to server time.
		local start = argumentData.Start
		local destination = argumentData.Destination
		if typeof(start) ~= "CFrame" or typeof(destination) ~= "CFrame" then
			return
		end
		local camera = workspace.CurrentCamera
		if camera and (camera.CFrame.Position - start.Position).Magnitude > RENDER_DISTANCE then
			return
		end

		local duration = argumentData.Duration or 2.5
		local startTime = argumentData.StartTime or workspace:GetServerTimeNow()
		local elapsed = math.clamp(workspace:GetServerTimeNow() - startTime, 0, duration)
		local anchor = Instance.new("Part")
		anchor.Name = "SunaTornadoAnchor"
		anchor.Anchored = true
		anchor.CanCollide = false
		anchor.CanQuery = false
		anchor.CanTouch = false
		anchor.Transparency = 1
		anchor.Size = Vector3.one
		anchor.CFrame = start:Lerp(destination, elapsed / duration)
		anchor.Parent = getVisualsFolder()
		TweenService:Create(anchor, TweenInfo.new(duration - elapsed, Enum.EasingStyle.Linear), { CFrame = destination }):Play()
		-- Dissipate normally ends it (0.3 s after the server's end); this only catches a lost Dissipate
		Debris:AddItem(anchor, duration - elapsed + 1)
		if argumentData.Id then
			tornadoAnchors[argumentData.Id] = anchor
			DebreeController.SetTarget(argumentData.Id, anchor)
		end

		TornadoVFX.Spawn({
			Anchor = anchor,
			Asset = script.NewTornado3,
			Parent = getVisualsFolder(),
		})
	end
	if argumentData.SkillType == "Dissipate" then
		-- Unregistering flings out everything the funnel is still spinning, in sync with the
		-- server throwing the victims
		if argumentData.Id then
			DebreeController.SetTarget(argumentData.Id, nil)
		end
		-- The server destroys its Root 0.3 s after this; destroying the anchor ends TornadoVFX
		local anchor = argumentData.Id and tornadoAnchors[argumentData.Id]
		if anchor then
			tornadoAnchors[argumentData.Id] = nil
			task.delay(0.3, function()
				anchor:Destroy()
			end)
		end
	end
	if argumentData.SkillType == "SablesHoldold" then
		local arm = argumentData.Attacker and argumentData.Attacker:FindFirstChild("Right Arm")
		if not arm then
			return
		end
		--print("[SablesHold] arm =", arm:GetFullName(), " attacker =", argumentData.Attacker)
		local Sables = script.SablesHold:Clone()
		Sables.Anchored = true
		--Sables.CanCollide = false
		--Sables.Massless = true
		Sables.CFrame = arm.CFrame * CFrame.new(0, -0.9, 0) -- R6 arm is 1x2x1, so -1 is the hand end
		Sables.Parent = workspace.World.Visuals

		--local weld = Instance.new("WeldConstraint")
		--weld.Part0, weld.Part1 = Sables, arm
		--weld.Parent = Sables

		--UtilityModule.Debris(Sables, 6)
		----UtilityModule.ToggleVFX(Sables, true)
		--task.delay(1.5, function()
		--	UtilityModule.ToggleVFX(Sables, false)
		--end)
	end
	if argumentData.SkillType == "SablesHold" then
		local arm = argumentData.Attacker and argumentData.Attacker:FindFirstChild("Right Arm")
		if not arm then
			return
		end

		local OFFSET = CFrame.new(0, -0.9, 0)

		local Sables = script.SablesHold:Clone()
		Sables.Anchored = true
		Sables.CanCollide = false
		Sables.CanQuery = false
		Sables.CFrame = arm.CFrame * OFFSET
		Sables.Parent = workspace.World.Visuals

		local conn
		conn = RunService.RenderStepped:Connect(function()
			if not (Sables.Parent and arm.Parent) then
				conn:Disconnect()
				return
			end
			Sables.CFrame = arm.CFrame * OFFSET
		end)

		UtilityModule.Debris(Sables, 1)
		task.delay(1.2, function()
			if conn then
				conn:Disconnect()
			end
		end)
	end
	if argumentData.SkillType == "Jump" then
		Velocity.Dash(argumentData.Attacker.HumanoidRootPart, argumentData.Attacker.Humanoid, {
			Distance = -10, Duration = 0.35, Style = "Sine",
			VelocityReplication = true,
		})
		
		--Velocity.Jump(argumentData.Attacker.HumanoidRootPart, {
		--	Height = 12,        -- Studs lifted upwards
		--	Duration = 0.3,     -- Time until gravity fully takes back over
		--	Style = "Quad",
		--	Easing = "Out",
		--})
		
		local Jump = script.Jump:Clone()
		Jump.CFrame = argumentData.Attacker.HumanoidRootPart.CFrame * CFrame.new(0,-3,0)
		Jump.Parent = workspace.World.Visuals
		UtilityModule.Debris(Jump, 2)

		UtilityModule.Emit(Jump)
	end
	
	if argumentData.SkillType == "Rocks" then
		shared.flyingdebris({
			position = argumentData.TornadoCFrame.Position, --Position,
			Seed = math.random(1, 1000000),

			chunk = {
				amount = 2,
				sizeRange = { 0.8, 1.2 },
				spread = { -12, 12 },
				upward = { 8, 18 },
				speedMult = 2,
				
				spin = true,
				spinTorque = 400000,
				spinVelocity = Vector3.new(
					math.random(-25, 25),
					math.random(-25, 25),
					math.random(-25, 25)
				),
			},

			small = {
				amountRange = { 4, 7 },
				sizeRange = { 0.4, 0.7 },
				spread = { -20, 20 },
				upward = { 20, 27 },
				lifetime = 4,
				speedMult = 2,
				
				spin = true,
				spinTorque = 200000,
				spinVelocity = Vector3.new(
					math.random(-40, 40),
					math.random(-40, 40),
					math.random(-40, 40)
				),
			},
		})
	end
	
	if argumentData.SkillType == "HitEnemy" then
		local EnemyCharacter = argumentData.Enemy or argumentData.Victim
		if not EnemyCharacter then return end

		local Torso = EnemyCharacter:FindFirstChild("Torso")
		if not Torso then return end

		local main = script.Hit:Clone()   
		main.Parent = Torso

		UtilityModule.Emit(main)
		Debris:AddItem(main, 2)
	end
end