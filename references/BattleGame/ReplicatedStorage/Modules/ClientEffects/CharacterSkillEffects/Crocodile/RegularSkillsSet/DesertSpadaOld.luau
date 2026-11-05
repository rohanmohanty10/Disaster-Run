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
local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local Velocity     = require(ReplicatedStorage.Modules.Velocity2)
local Transparent = require(ReplicatedStorage.Modules.ClientEffects.Transparent)

local RENDER_DISTANCE = 350
local RNG = Random.new()

local UtilityModule = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)

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
local SAND_DELAY = 0.05

-- ===== Helpers (stand-ins for the reference's _G utilities) ==================

local function getVisualsFolder(): Instance
	local world = workspace:FindFirstChild("World")
	local visuals = world and world:FindFirstChild("Visuals")
	return visuals or workspace
end

-- Map folders the crack rays should pass straight through (relative to World.Map).
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

-- Reference whitelist was { Islands, Ships, Env }; this game's world geometry
-- lives under workspace.World.Map. Hits inside IGNORED_MAP_PATHS folders are
-- skipped by re-casting from just past them.
local function raycastWhitelist(origin: Vector3, direction: Vector3): (BasePart?, Vector3, Vector3)
	local world = workspace:FindFirstChild("World")
	local map = world and world:FindFirstChild("Map")

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = { map or workspace }
	params.IgnoreWater = true

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

-- Ground debris rock: grows out of the floor, matches its material, sinks back
-- in after 4s. 1:1 port of the reference rock spawner.
local function spawnDebrisRock(cframe: CFrame, size: number, rayHeight: Vector3, instantSize: boolean?)
	local origin = cframe.Position
	local hitPart, hitPos, hitNormal =
		raycastWhitelist(origin + Vector3.new(0, rayHeight.Y, 0), Vector3.new(0, -(rayHeight.Y * 2), 0))
	if not (hitPart and hitPart.CanCollide) then
		return
	end

	local rock: BasePart = script.Part:Clone()
	rock.Color = hitPart.Color
	rock.Material = hitPart.Material
	rock.MaterialVariant = hitPart.MaterialVariant

	local rockCFrame = CFrame.new(hitPos, hitPos + hitNormal)
		* CFrame.Angles(
			math.rad(RNG:NextInteger(-360, 360)),
			math.rad(RNG:NextInteger(-360, 360)),
			math.rad(RNG:NextInteger(-360, 360))
		)
	local finalSize = Vector3.new(size, size, size) * RNG:NextInteger(90, 110) / 100

	rock.Size = finalSize / 4
	rock.CFrame = rockCFrame
	rock.Parent = getVisualsFolder()

	if instantSize then
		rock.Size = finalSize
	else
		tween(rock, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { Size = finalSize })
	end

	task.delay(4, function()
		if rock.Parent ~= nil then
			tween(rock, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				CFrame = CFrame.new(rockCFrame.Position)
					* CFrame.new(0, -rock.Size.X, 0)
					* CFrame.Angles(
						math.rad(RNG:NextInteger(-360, 360)),
						math.rad(RNG:NextInteger(-360, 360)),
						math.rad(RNG:NextInteger(-360, 360))
					),
			})
		end
	end)
	Debris:AddItem(rock, 4.5)

	return rock, rockCFrame
end

-- ===== The crack effect itself (reference: v1.start) =========================

local function spadaCrack(originCFrame: CFrame)
	local camera = workspace.CurrentCamera
	if camera and (camera.CFrame.Position - originCFrame.Position).Magnitude > RENDER_DISTANCE then
		return
	end

	playSoundAt(originCFrame, script:FindFirstChild("start"))

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
		VFXFunctions.EmitDescendants(stab.Attachment)
		Debris:AddItem(stab, 3)

		-- Ring of rocks around the stab (reference: PlayEffect "GroundRocks2").
		for i = 1, 8 do
			local angle = (i / 8) * math.pi * 2
			spawnDebrisRock(
				stab.CFrame * CFrame.new(math.cos(angle) * 4, 0, math.sin(angle) * 4),
				1.25,
				Vector3.new(0, 5, 0)
			)
		end

		originCFrame = stab.CFrame
		local lastCFrame = stab.CFrame

		local burstFired = false
		local trails = {}

		-- March forward in PROBE_STEP-stud steps, laying crack segments that
		-- conform to the terrain (each probe raycasts 100 studs down from +50).
		for segment = 1, math.ceil(CRACK_DISTANCE / PROBE_STEP) do
			local probe = originCFrame * CFrame.new(0, 0, (segment - 1) * -PROBE_STEP) * CFrame.new(0, 50, 0)
			local hitPart, hitPos = raycastWhitelist(probe.Position, probe.UpVector * -100)

			if hitPart and (lastCFrame.Position - hitPos).Magnitude > 5 then
				local target = CFrame.new(hitPos)
				local length = (lastCFrame.Position - target.Position).Magnitude

				local trail: BasePart = script.trail:Clone()
				trail.CFrame = CFrame.new(lastCFrame.Position, target.Position)
					* CFrame.Angles(math.pi / 2, 0, 0)
					* CFrame.new(0, -length / 2, 0)
				trail.Mesh.Scale = Vector3.new(1, 1, 1)
				trail.Size = Vector3.new(1, length, 0.05)
				trail.Parent = visuals
				VFXFunctions.EmitDescendants(trail.GroundDust)

				-- Rocks flanking the crack, spread along the segment.
				local segmentTop = trail.CFrame * CFrame.new(0, length / 2, 0)
				task.spawn(function()
					local current = segmentTop
					for _ = 1, 5 do
						local side = 1
						for _ = 1, 2 do
							spawnDebrisRock(current * CFrame.new(side, 0, 0), 1.5, Vector3.new(0, 5, 0))
							side = -side
						end
						current = current * CFrame.new(0, -(length / 5), 0)
					end
				end)

				lastCFrame = CFrame.new(hitPos)

				-- Windup lines stay on until the global cue, then the segment bursts.
				task.spawn(function()
					repeat
						RunService.Heartbeat:Wait()
					until burstFired

					trail.WindupLines.Enabled = false
					trail.WindupEndEmit:Emit(5)
					task.wait(SAND_DELAY)
					trail.Rocks.Color = ColorSequence.new(hitPart.Color)
					trail.Rocks:Emit(5)
					VFXFunctions.EmitDescendants(trail.Wisps)
					VFXFunctions.EmitDescendants(trail.Wisps2)
					trail.Sand.Enabled = true
					trail.SandBurst.Enabled = true
					trail.BurstLines.Enabled = true
					shakeNear(trail.Position, 75, 1.5, 0.4)
					task.wait(0.5)
					setChildrenEnabled(trail, false)
				end)

				table.insert(trails, trail)
			end

			-- Paces how fast the crack travels (reference: sBeat frame yield).
			RunService.Heartbeat:Wait()
		end

		task.wait(BURST_DELAY)
		burstFired = true

		task.spawn(function()
			task.wait(SAND_DELAY)
			playSoundAt(originCFrame, script:FindFirstChild("booms"))
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
		spadaCrack(hrp.CFrame)
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
		local TPVFX = script.TP:Clone()
		TPVFX.Parent = workspace.World.Visuals
		TPVFX.CFrame = hrp.CFrame * CFrame.new(0,-3,0)

		VFXFunctions.EmitDescendants(TPVFX)
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
		Transparent({ Character = attacker, State = false, TweenTime = 0.15 })

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