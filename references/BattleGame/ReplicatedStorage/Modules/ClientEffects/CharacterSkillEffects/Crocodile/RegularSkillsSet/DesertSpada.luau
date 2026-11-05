-- DesertSpada (client effects) — handles the "DesertSpada" move fired from the server.
-- "Dash"     : dash locomotion (Velocity.Dash), owner-driven.
-- "SpadaVFX" : ground-crack line — stab burst -> traveling crack trails with windup
--              lines -> synced burst (rocks/sand/wisps) + booms. Ported 1:1 from the
--              reference tremor-crack VFX.
--
-- Required children of this ModuleScript (see the reference asset):
--   Part  (BasePart)  — rock template
--   stab  (BasePart)  — with an Attachment holding the stab burst emitters
--   trail (BasePart)  — with BlockMesh "Mesh" + emitters: GroundDust, WindupLines,
--                       WindupEndEmit, Rocks, Wisps, Wisps2, Sand, SandBurst, BurstLines
--   start (Sound), booms (Sound)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local Debris            = game:GetService("Debris")
local Players           = game:GetService("Players")

local LocalPlayer  = Players.LocalPlayer
local Velocity     = require(ReplicatedStorage.Modules.Velocity2)
local Transparent = require(ReplicatedStorage.Modules.ClientEffects.Transparent)

local RENDER_DISTANCE = 700
local RNG = Random.new()

local UtilityModule = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)

local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)

-- ===== Tuning ================================================================

-- How far the crack travels, in studs (reference: 50 probes x 4.5 studs = 225).
local CRACK_DISTANCE = 90
-- Studs between terrain probes. Smaller = crack hugs bumpy terrain better,
-- at the cost of more raycasts. Doesn't change total distance.
local PROBE_STEP = 4.5
-- Seconds after the crack finishes traveling before the windup lines pop
-- (the cue that the burst is coming).
local BURST_DELAY = 0.05
-- Seconds after that pop before the main sand/rocks eruption fires.
-- Total time from crack-finished to sand = BURST_DELAY + SAND_DELAY.
local SAND_DELAY = 0.1
-- Seconds the crack takes to travel the whole line, on every frame rate. Keep the server's
-- ERUPTION_DELAY at about CRACK_TIME + BURST_DELAY + SAND_DELAY (0.48).
local CRACK_TIME = 0.33
local RIPPLE_TIME = 0.15
-- How the crack follows the ground. Must match the server, so the crack, the hitbox and the
-- destruction follow the same ground.
local STEP_LIMIT = 8 -- most it may step UP between probes (studs), so it never climbs walls
local DROP_LIMIT = 40 -- most it may drop between probes (studs), so it runs off ledges

-- ===== Helpers (stand-ins for the reference's _G utilities) ==================

local function getVisualsFolder(): Instance
	local world = workspace:FindFirstChild("World")
	local visuals = world and world:FindFirstChild("Visuals")
	return visuals or workspace
end

local IGNORED_MAP_PATHS = {
	{ "Destroyable", "Trees" },
	{ "Destroyables", "Trees" },
}

local function getIgnoredFolders(map: Instance): { Instance }
	local ignored = {}
	for _, path in IGNORED_MAP_PATHS do
		local node: Instance? = map
		for _, name in path do
			node = node and node:FindFirstChild(name)
		end
		if node then
			table.insert(ignored, node)
		end
	end
	return ignored
end

local function raycastWhitelist(origin: Vector3, direction: Vector3): (BasePart?, Vector3, Vector3)
	local world = workspace:FindFirstChild("World")
	local map = world and world:FindFirstChild("Map")

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	-- plus Debree's pieces (World.Voxel): where the floor was already broken, its part is gone from
	-- the map and these stand in for it, so the crack still has ground to run on
	local voxel = world and world:FindFirstChild("Voxel")
	params.FilterDescendantsInstances = if voxel then { map or workspace, voxel } else { map or workspace }
	params.IgnoreWater = true
	params.RespectCanCollide = true -- only what you can stand on (the server's segments probe the same way)

	local ignored = map and getIgnoredFolders(map) or {}
	local endPoint = origin + direction
	local castFrom = origin

	for _ = 1, 6 do
		local result = workspace:Raycast(castFrom, endPoint - castFrom, params)
		if not result then
			break
		end

		local hitIgnored = false
		for _, folder in ignored do
			if result.Instance:IsDescendantOf(folder) then
				hitIgnored = true
				break
			end
		end
		if not hitIgnored then
			return result.Instance, result.Position, result.Normal
		end

		castFrom = result.Position + direction.Unit * 0.1
	end
	return nil, origin + direction, Vector3.yAxis
end

local function tween(instance: Instance, tweenInfo: TweenInfo, goals: { [string]: any })
	local t = TweenService:Create(instance, tweenInfo, goals)
	t:Play()
	task.delay(tweenInfo.Time * 1.05, function()
		t:Destroy()
	end)
	return t
end

local function playSoundAt(cframe: CFrame, soundTemplate: Sound?)
	if not soundTemplate then
		return
	end
	local attachment = Instance.new("Attachment")
	attachment.WorldCFrame = cframe
	attachment.Parent = workspace.Terrain

	local sound = soundTemplate:Clone()
	sound.PlayOnRemove = false
	sound.Parent = attachment
	sound:Play()

	Debris:AddItem(attachment, math.max(sound.TimeLength, 1) + 5)
end

local function setChildrenEnabled(parent: Instance, enabled: boolean)
	for _, child in parent:GetChildren() do
		pcall(function()
			(child :: any).Enabled = enabled
		end)
	end
end

-- Distance-falloff camera shake (reference: _G.shakenear).
local function shakeNear(position: Vector3, range: number, intensity: number, duration: number)
	local camera = workspace.CurrentCamera
	if not camera then
		return
	end
	local distance = (camera.CFrame.Position - position).Magnitude
	if distance > range then
		return
	end
	local falloff = 1 - distance / range

	task.spawn(function()
		local elapsed = 0
		while elapsed < duration do
			elapsed += RunService.RenderStepped:Wait()
			local magnitude = intensity * falloff * (1 - elapsed / duration)
			camera.CFrame *= CFrame.Angles(
				math.rad((RNG:NextNumber() - 0.5) * magnitude),
				math.rad((RNG:NextNumber() - 0.5) * magnitude),
				0
			)
		end
	end)
end

local function spadaCrack(originCFrame: CFrame)
	local camera = workspace.CurrentCamera
	if camera and (camera.CFrame.Position - originCFrame.Position).Magnitude > RENDER_DISTANCE then
		return
	end

	playSoundAt(originCFrame, script:FindFirstChild("start"))
	playSoundAt(originCFrame, script:FindFirstChild("start2"))
	playSoundAt(originCFrame, script:FindFirstChild("fissure"))
	playSoundAt(originCFrame, script:FindFirstChild("fissure2"))

	task.spawn(function()
		local visuals = getVisualsFolder()

		-- Snap the origin down onto the floor, keeping the facing direction.
		local floorPart, floorPos = raycastWhitelist(originCFrame.Position, Vector3.new(0, -10, 0))
		if floorPart then
			originCFrame = CFrame.new(originCFrame.X, floorPos.Y, originCFrame.Z) * originCFrame.Rotation
		end

		-- Initial ground stab burst.
		local stab: BasePart = script.stab:Clone()
		stab.CFrame = originCFrame * CFrame.new(0, 0, -2.5)
		stab.Parent = visuals
		UtilityModule.Emit(stab.Attachment)
		Debris:AddItem(stab, 3)

		-- Ring of rocks around the stab (reference: PlayEffect "GroundRocks2").
		for i = 1, 5 do
			local angle = (i / 5) * math.pi * 2
			
			
			--RockHandler.RegularRockLines(stab.CFrame * CFrame.new(math.cos(angle) * 4, 0, math.sin(angle) * 4), {
			--	Amount = 1,
			--	Spacing = 1.4,
			--	SideSpacing = 0.9,
			--	Angle = 0,
			--	RandomJitter = 0,
			--	Size = 1.5,
			--	SizeIndex = 0,
			--	ExposeLevel = -0.2,
				
			--	TweenDelay = 5,
			--	SinkRocks = true,
			--})
		end
		
		local Direction = Vector3.yAxis * -5
		coroutine.wrap(RockHandler.Crater)(stab.CFrame.Position, Direction, {
			Amount = 7,
			Distance = 3,

			LookAt = {
				Min = -10,
				Max = -10
			},

			Exposure = {
				Min = 1,
				Max = 1,
			},

			BaseZ = 2.5,
			SizeMultiplier = 1,
			CraterSmoke = false,
			CastShadow = false

		})

		originCFrame = stab.CFrame
		local lastCFrame = stab.CFrame

		local burstFired = false
		local crackStart = os.clock()
		local segmentCount = math.ceil(CRACK_DISTANCE / PROBE_STEP)

		local trails = {}

		-- March forward in PROBE_STEP-stud steps, laying crack segments that
		-- follow the ground (each probe looks STEP_LIMIT up and down from the last ground point).
		for segment = 1, segmentCount do
			-- Follow the ground from just above it, exactly like the server's segments: a ray that
			-- starts inside a wall doesn't hit that wall, and it starts only STEP_LIMIT above the last
			-- ground, so the crack runs along the ground through walls instead of climbing onto them.
			-- It reaches DROP_LIMIT down, so the crack runs off ledges onto the ground below.
			local flat = originCFrame * CFrame.new(0, 0, (segment - 1) * -PROBE_STEP)
			local hitPart, hitPos = raycastWhitelist(
				Vector3.new(flat.X, lastCFrame.Y + STEP_LIMIT, flat.Z),
				Vector3.new(0, -(STEP_LIMIT + DROP_LIMIT), 0)
			)

			if hitPart and (lastCFrame.Position - hitPos).Magnitude > 5 then
				local target = CFrame.new(hitPos)
				local length = (lastCFrame.Position - target.Position).Magnitude

				--local trail: BasePart = script.trail:Clone()
				local trail: BasePart = script.Spada:Clone()

				trail.CFrame = CFrame.new(lastCFrame.Position, target.Position)
					* CFrame.new(0, 0, -length / 2)
				trail.Mesh.Scale = Vector3.new(1, 1, 1)
				trail.Size = Vector3.new(1, 0.05, length)
				trail.Parent = visuals
				--VFXFunctions.EmitDescendants(trail.GroundDust)
				for i = 1, 8 do
					--VFXFunctions.EmitDescendants(trail["PreSpada" .. i])
					UtilityModule.EmitOneParticle(trail["PreSpada" .. i])
				end

				-- Rocks flanking the crack, spread along the segment.
				local segmentTop = trail.CFrame * CFrame.new(0,  0, length / 2)
				task.spawn(function()
					local current = segmentTop
					for _ = 1, 5 do
						local side = 1
						RockHandler.RegularRockLines(current, {
							Amount = 1,
							Spacing = 1.4,
							SideSpacing = 0.9,
							Angle = 0,
							RandomJitter = 0,
							Size = 1.2,
							SizeIndex = 0,
							ExposeLevel = -0.2,
							TweenDelay = 3,
							SinkRocks = true,
						})
						current = current * CFrame.new(0, 0, -(length / 5))
					end
				end)

				lastCFrame = CFrame.new(hitPos)

				-- Windup lines stay on until the global cue, then the segment bursts.
				task.spawn(function()
					repeat
						RunService.Heartbeat:Wait()
					until burstFired
					
					-- erupt in a ripple down the line, matching the server's destruction
					task.wait(RIPPLE_TIME * (segment - 1) / segmentCount)

					for i = 1, 8 do
						trail["PreSpada" .. i].Enabled = false
					end

					task.wait(SAND_DELAY)
					
					for i = 1, 21 do
						UtilityModule.EmitOneParticle(trail["Spada0" .. i])
					end
					
					shakeNear(trail.Position, 75, 1.5, 0.4)
					task.wait(0.5)
					setChildrenEnabled(trail, false)
				end)

				table.insert(trails, trail)
			end

			-- Paces how fast the crack travels (reference: sBeat frame yield).
			local due = crackStart + CRACK_TIME * segment / segmentCount
			while os.clock() < due do
				RunService.Heartbeat:Wait()
			end
		end

		task.wait(BURST_DELAY)
		burstFired = true

		task.spawn(function()
			playSoundAt(originCFrame, script:FindFirstChild("up wind"))
			task.wait(SAND_DELAY)
			playSoundAt(originCFrame, script:FindFirstChild("booms"))
			
			--task.wait(.1)
			playSoundAt(originCFrame, script:FindFirstChild("boom2"))
		end)

		task.wait(2)
		for _, trail in trails do
			Debris:AddItem(trail, 5)
		end
	end)
end

-- ===== Dispatcher =============================================================

return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType       = argumentData.SkillType
	local character       = attacker
	local isLocalPlayer   = LocalPlayer.Character == attacker

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- ===== Dash locomotion (only the owner drives it; replicates to others) =====
	if skillType == "Dash" and isLocalPlayer then
		Velocity.Dash(hrp, character.Humanoid, {
			Distance = -17, Duration = 0.35, Style = "Sine",
			VelocityReplication = true,
		})
	end

	-- ===== Ground-crack VFX =====
	if skillType == "SpadaVFX" then
		-- the server's grounded origin, so every client draws the crack where the hitbox is
		spadaCrack(if typeof(argumentData.Origin) == "CFrame" then argumentData.Origin else hrp.CFrame)
	end
	if skillType == "Rise" then
		local victim = argumentData.Victim
		local victimHrp = victim and victim:FindFirstChild("HumanoidRootPart")
		if victimHrp then
			TweenService:Create(
				victimHrp,
				TweenInfo.new(argumentData.RiseTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ CFrame = argumentData.TargetCFrame }
			):Play()
		end
	end
	
	if skillType == "Vanish" then
		Transparent({ Character = attacker, State = true, TweenTime = 0.15 })
		local TPVFX = script.reworkedTP:Clone()
		TPVFX.Parent = workspace.World.Visuals
		TPVFX.CFrame = hrp.CFrame * CFrame.new(0,-3,0)
		
		UtilityModule.Emit(TPVFX)
		Debris:AddItem(TPVFX, 3)
		
	end
	--if skillType == "TP" then
	--	Transparent({ Character = attacker, State = false, TweenTime = 0.15 })
	--	local TPVFX = script.TPAfter:Clone()
	--	TPVFX.Parent = workspace.World.Visuals
	--	TPVFX.CFrame = hrp.CFrame * CFrame.new(0,-3,0)

	--	VFXFunctions.EmitDescendants(TPVFX)
	--	Debris:AddItem(TPVFX, 3)
	--end
	if skillType == "TP" then
		local TPVFX = script.reworkedTP:Clone()
		TPVFX.Parent = workspace.World.Visuals
		TPVFX.CFrame = hrp.CFrame * CFrame.new(0,-2,0)

		UtilityModule.Emit(TPVFX)
		Debris:AddItem(TPVFX, 3)
		Transparent({ Character = attacker, State = false, TweenTime = 0.25 })

		if isLocalPlayer then
			local camera = workspace.CurrentCamera
			local humanoid = character:FindFirstChildOfClass("Humanoid")

			-- stop the humanoid's auto-balance fighting the pitch
			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Physics)
			end

			pcall(function() RunService:UnbindFromRenderStep("SpadaAim") end)
			RunService:BindToRenderStep("SpadaAim", Enum.RenderPriority.Camera.Value + 1, function()
				local gyro = hrp:FindFirstChild("SpadaGyro")
				if not gyro then
					RunService:UnbindFromRenderStep("SpadaAim")
					if humanoid then
						humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) -- re-enable balance
					end
					return
				end
				gyro.CFrame = CFrame.lookAlong(hrp.Position, camera.CFrame.LookVector)
			end)
		end
	end
	
	
	if skillType == "TPCancel" then
		Transparent({ Character = attacker, State = false })
	end
	
	if skillType == "Punch" then
		
		local Final = script.FinalHit:Clone()
		local Start = Final.sphere.Start

		for _, v28774 in pairs({
			Start
			}) do
			local IsNotDistortion = tostring(v28774.Parent) ~= "Distortion"

			local RedHighlight = Instance.new("Highlight")
			RedHighlight.FillColor = Color3.fromRGB(255, 219, 156)
			RedHighlight.FillTransparency = 1
			RedHighlight.OutlineTransparency = 1
			RedHighlight.OutlineColor = Color3.fromRGB(0, 0, 0)
			RedHighlight.DepthMode = IsNotDistortion and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
		end

		Final:SetPrimaryPartCFrame(CFrame.new(hrp.Position + hrp.CFrame.LookVector * -7.27847672 + Vector3.new(0.683349609375, -6.011728286743164, 0, 0), hrp.Position + hrp.CFrame.LookVector * -7.27847672 + Vector3.new(0.683349609375, -6.011728286743164, 0, 0) + hrp.CFrame.LookVector) * CFrame.new(0, 4, -15) * CFrame.Angles(-1.3962634015954636, 0, 0))
		Final.Parent = workspace.World.Visuals

		UtilityModule.Debris(Final, 2)
		UtilityModule.Emit(Final)
		UtilityModule.vfxTween(Final.R1, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
		UtilityModule.vfxTween(Final.R2, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
		UtilityModule.vfxTween(Final.sphere, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
		UtilityModule.vfxTween(Final.Shockwave, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out))
		UtilityModule.vfxTween(Final.Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
		UtilityModule.vfxTween(Final.Wind1, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
		UtilityModule.vfxTween(Final.Wind2, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
		UtilityModule.vfxTween(Final.WindDecal2, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
	end
end