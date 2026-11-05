--Replicated Storage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityThree
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Assets = ReplicatedStorage:WaitForChild("Assets")
local Effects = Assets:WaitForChild("Effects")

local GroundRocks = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler:WaitForChild("GroundRocks"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)

local activeFX = {}

--For sanji ability 3
return function(argumentData: any) --Got this from default in server script services.
	local attacker:Model = argumentData.Attacker --The character btw.
	local humanoid: Humanoid = attacker:FindFirstChild("Humanoid")

	local skillType = argumentData.SkillType

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	
	
	local function playTween(instance, time, style, direction, props)
		local tween = TweenService:Create(instance, TweenInfo.new(time, style, direction), props)
		tween:Play()
		return tween
	end



	if skillType == "startup" then
		local Torso = attacker:FindFirstChild("Torso")
		local LeftLeg = attacker:FindFirstChild("Left Leg")
		local startUp = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.ThirdAbility:WaitForChild("StartUp") --Folder which has all parts and effects

		local clone = startUp:Clone()

		-- Hardcode a consistent root part instead of FindFirstChildWhichIsA
		local rootPart = clone:FindFirstChild("Hit", true)
		local rootCFrame = rootPart.CFrame

		clone.Parent = workspace.World.Visuals

		local look = Torso.CFrame.LookVector
		local flatLook = Vector3.new(look.X, 0, look.Z).Unit
		local facingCFrame = CFrame.lookAt(Torso.CFrame.Position, Torso.CFrame.Position + flatLook)* CFrame.new(-.5, -1.5, -.7)

		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("BasePart") then
				local relativeOffset = rootCFrame:ToObjectSpace(v.CFrame)
				v.CFrame = facingCFrame * relativeOffset
			end
		end

		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount"))
			end
		end

		local trailModel = clone:FindFirstChild("line blur trail")
		local weld = trailModel:FindFirstChild("Weld")
		weld.C1 = CFrame.new(0, 0, -.3) -- positive Z = behind the leg
		weld.Part0 = LeftLeg

		task.delay(.5, function()
			trailModel.Attachment0.Trail.Enabled = false
		end)

		game:GetService("Debris"):AddItem(clone, 2)
	end

	if skillType == "jump" then
		local Torso = attacker:FindFirstChild("Torso")
		local jump = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.ThirdAbility:WaitForChild("Jump") --Folder which has all parts and effects

		local clone = jump:Clone()

		-- Hardcode a consistent root part instead of FindFirstChildWhichIsA
		local rootPart = clone:FindFirstChild("UpperPunchImpact", true)
		local rootCFrame = rootPart.CFrame

		clone.Parent = workspace.World.Visuals

		local look = Torso.CFrame.LookVector
		local flatLook = Vector3.new(look.X, 0, look.Z).Unit
		local facingCFrame = CFrame.lookAt(Torso.CFrame.Position, Torso.CFrame.Position + flatLook) * CFrame.new(0, 0, 2)

		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("BasePart") then
				local relativeOffset = rootCFrame:ToObjectSpace(v.CFrame)
				v.CFrame = facingCFrame * relativeOffset
			end
		end


		-- Emit all particle emitters
		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount"))
			end
		end

		-- Handle trail
		local trailModel = clone:FindFirstChild("line blur trail")
		if trailModel then
			trailModel.Parent = Torso
			local trail = trailModel:FindFirstChildWhichIsA("Trail")
			local attachments = {}
			for _, v in ipairs(trailModel:GetChildren()) do
				if v:IsA("Attachment") then
					table.insert(attachments, v)
				end
			end
			if trail and #attachments >= 2 then
				trail.Attachment0 = attachments[1]
				trail.Attachment1 = attachments[2]
				trail.Enabled = true
				task.delay(1, function()
					trail.Enabled = false
					game:GetService("Debris"):AddItem(trailModel, trail.Lifetime)
				end)
			end
		end

		Debris:AddItem(clone, 7)
	end

	if(skillType == "spin") then
		-- Spin VFX
		local Torso = attacker:FindFirstChild("Torso") or attacker:FindFirstChild("HumanoidRootPart")
		local spin = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.ThirdAbility:WaitForChild("Spin")

		-- Clone the folder and parent to Torso so it follows automatically
		local clone = spin:Clone()
		clone.Parent = Torso

		-- Weld every BasePart to the Torso so it follows exactly
		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CFrame = Torso.CFrame -- center on torso
				v.Anchored = false

				local weld = Instance.new("WeldConstraint")
				weld.Part0 = Torso
				weld.Part1 = v
				weld.Parent = v
			end
		end

		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = true
			end
		end

		task.delay(.5, function()
			for _, v in ipairs(clone:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v.Enabled = false
				end
			end
		end)


		-- Cleanup after 1.5 seconds
		game:GetService("Debris"):AddItem(clone, .5)
	end

	if(skillType == "hit") then
		local Torso = attacker:FindFirstChild("Torso") or attacker:FindFirstChild("HumanoidRootPart")
		local PunchImpact2 = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.ThirdAbility.OpponentGroundSlam.PunchImpact2
		local kick = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.ThirdAbility.Kick

		-- Build flat facing CFrame from Torso's LookVector
		local look = Torso.CFrame.LookVector
		local flatLook = Vector3.new(look.X, 0, look.Z).Unit
		local facingCFrame = CFrame.lookAt(Torso.CFrame.Position, Torso.CFrame.Position + flatLook)

		-- Clone PunchImpact2 — faces relative to character direction
		local clone = PunchImpact2:Clone()
		clone.CFrame = facingCFrame * CFrame.new(0, 0, -3) * CFrame.Angles(math.rad(-75), 0, 0)
		clone.Parent = workspace.World.Visuals


		-- Clone Kick — faces relative to character direction
		local clone3 = kick:Clone()
		clone3.Parent = workspace.World.Visuals

		local rootPart = kick:FindFirstChildWhichIsA("BasePart")
		local rootCFrame = rootPart.CFrame

		for _, v in ipairs(kick:GetDescendants()) do
			if v:IsA("BasePart") then
				local clonedPart = clone3:FindFirstChild(v.Name, true)
				if clonedPart then
					local relativeOffset = rootCFrame:ToObjectSpace(v.CFrame)
					clonedPart.CFrame = (facingCFrame * CFrame.new(0, -1.5, -1.9)) * relativeOffset
				end
			end
		end

		task.delay(.05, function()
			for _, v in ipairs(clone:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end
		end)

		for _, v in ipairs(clone3:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount"))
			end
		end

		game:GetService("Debris"):AddItem(clone3, 7)
		game:GetService("Debris"):AddItem(clone, 7)
	end
	
	if(skillType == "hitground") then
		local EnemyTorso = argumentData.Target:FindFirstChild("Torso") or attacker:FindFirstChild("HumanoidRootPart")

		local miniSlam = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.ThirdAbility.OpponentGroundSlam.MiniSlam
		
		local clone2 = miniSlam:Clone()
		clone2.CFrame = CFrame.new(EnemyTorso.CFrame.X, 0, EnemyTorso.CFrame.Z) --* CFrame.new(0, 0, -2.5)
		clone2.Parent = workspace.World.Visuals
		
		for _, v in ipairs(clone2:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount"))
			end
		end
		
		game:GetService("Debris"):AddItem(clone2, 7)

	end
	
	--==========================================================
	--  MODULES YOU MUST ADD
	--  Put this near your other requires at the TOP of the module
	--  (next to GroundRocks). Point the path at YOUR copy.
	--==========================================================
	-- Misc (ManyMisc) must provide:
	--   ExtraVisual:newFoV() / newBlur()
	--   SpecialMath:rollOffValue() / lerp()
	--   EasyEmitter:EnableEmitters() / EnableTrails()
	--   :Destroy()
	local Misc = require(script.Finisher.Misc) -- <-- fix path to your copy
	-- NOTE: CameraShaker is NOT needed — the camera shake was removed.


	if(skillType == "FinisherSpinTrash") then
		print("FinisherClient")

		--======================================================
		--  CHEAP VARIABLES (define these so the VFX/blur run)
		--======================================================
		
		local localPlayer    = game:GetService("Players").LocalPlayer
		local viewers        = { localPlayer }                 -- who sees the close-up FX
		local character      = attacker
		local rootPart       = hrp
		local camera         = workspace.CurrentCamera
		local Lighting       = game:GetService("Lighting")
		--local playerSettings = localPlayer:WaitForChild("PlayerSettings") -- needs a "FastMode" attr (or hardcode the checks to false)
		local moveEnded      = false                           -- flip true from a cancel remote to interrupt
		--local fovMod         = Misc.ExtraVisual:newFoV()       -- persistent FoV modifier reset at the end
		local visualPack = script.Finisher

		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { attacker, workspace.World.Visuals }

		-- STILL TO WIRE (your call — left untouched on purpose):
		--   * Debris(x, t)  -> in your file `Debris` is the SERVICE; change these to Debris:AddItem(x, t)
		--   * castTrack.TimePosition (loop condition) -> pass your anim track, or use `spinTime <= 1.5`
		--   * visualPack / visualEffects -> your Sanji effect folders
		--   * workspace.Effects -> your visuals folder (e.g. workspace.World.Visuals)
		--======================================================

		--local intensity = table.find(viewers, localPlayer) and 1 or Misc.SpecialMath:rollOffValue((localPlayer.Character.Head.CFrame.Position - character.Torso.Position).Magnitude, 25, 75)

		--local fov = Misc.ExtraVisual:newFoV()
		--playTween(fov, 0.075, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, { Value = 10 * intensity })
		--Debris(fov, 1.075)
		--local blur = Misc.ExtraVisual:newBlur()
		--playTween(blur, 0.075, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, { Value = 6 * intensity })
		--Debris(blur, 0.575)
		--task.delay(0.075, function()
		--	playTween(fov, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, { Value = 0 })
		--	playTween(blur, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, { Value = 0 })
		--end)

		-- Sustained FoV + color grade (CAMERA SHAKE REMOVED).
		local spinFinished = false
		print("FinisherClient")
		--task.spawn(function()
		--	local startTick = tick()
		--	local distRange = NumberRange.new(75, 100)

		--	--local fovSustain = Misc.ExtraVisual:newFoV()
		--	local colorGrade = Instance.new("ColorCorrectionEffect")
		--	colorGrade.Parent = Lighting

		--	local gradeActive = {
		--		Contrast = 1, Saturation = 0, Brightness = -0.1, TintColor = Color3.fromRGB(255, 235, 228),
		--	}
		--	local gradeNeutral = {
		--		Contrast = 0, Saturation = 0, Brightness = 0, TintColor = Color3.fromRGB(255, 255, 255),
		--	}

		--	-- Helper: current distance-based scale (0..1).
		--	local function distScale()
		--		return Misc.SpecialMath:rollOffValue(
		--			(localPlayer.Character.Head.CFrame.Position - rootPart.Position).Magnitude, distRange.Min, distRange.Max)
		--	end

		--	-- FoV target follows the caster's horizontal speed.
		--	local fovTarget = 10

		--	-- Phase 1: ramp in over 0.5s.
		--	while tick() - startTick < 0.5 and not (spinFinished or moveEnded) do
		--		local dt = task.wait()
		--		local speedFov = -10 + (rootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude * 0.1
		--		fovTarget = Misc.SpecialMath:lerp(fovTarget, speedFov, math.clamp(dt * 5, 0, 1))
		--		local ramp = TweenService:GetValue(math.clamp((tick() - startTick) / 0.5, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
		--		local scale = distScale()
		--		fovSustain.Value = Misc.SpecialMath:lerp(0, fovTarget, math.clamp(scale, 0, ramp))
		--		for prop, value in gradeActive do
		--			colorGrade[prop] = Misc.SpecialMath:lerp(gradeNeutral[prop], value, math.clamp(scale, 0, ramp))
		--		end
		--	end

		--	-- Phase 2: hold until the spin loop finishes.
		--	while not (spinFinished or moveEnded) do
		--		local dt = task.wait()
		--		local speedFov = -10 + (rootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude * 0.1
		--		fovTarget = Misc.SpecialMath:lerp(fovTarget, speedFov, math.clamp(dt * 5, 0, 1))
		--		local scale = distScale()
		--		fovSustain.Value = Misc.SpecialMath:lerp(0, fovTarget, scale)
		--		for prop, value in gradeActive do
		--			colorGrade[prop] = Misc.SpecialMath:lerp(gradeNeutral[prop], value, scale)
		--		end
		--	end

		--	-- Phase 3: ramp out over 0.1s.
		--	local outTick = tick()
		--	while tick() - outTick < 0.1 and not moveEnded do
		--		local dt = task.wait()
		--		local speedFov = -10 + (rootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude * 0.1
		--		fovTarget = Misc.SpecialMath:lerp(fovTarget, speedFov, math.clamp(dt * 5, 0, 1))
		--		local ramp = 1 - TweenService:GetValue(math.clamp((tick() - outTick) / 0.1, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		--		local scale = distScale()
		--		fovSustain.Value = Misc.SpecialMath:lerp(0, fovTarget, math.clamp(scale, 0, ramp))
		--		for prop, value in gradeActive do
		--			colorGrade[prop] = Misc.SpecialMath:lerp(gradeNeutral[prop], value, math.clamp(scale, 0, ramp))
		--		end
		--	end

		--	playTween(colorGrade, 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, gradeNeutral)
		--	playTween(fovSustain, 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, { Value = 0 })
		--	task.delay(0.05, function()
		--		Misc:Destroy({ fovSustain, colorGrade })
		--	end)
		--end)

		-- Spinning drill trail that follows the torso.
		-- Spinning drill trail welded to the torso (follows exactly).
		local Torso = character:FindFirstChild("Torso")
		local spinActive = true
		local drillTrail = visualPack.Trail:Clone()
		drillTrail.Anchored = false
		drillTrail.CFrame = Torso.CFrame
		local trailWeld = Instance.new("WeldConstraint")
		trailWeld.Part0 = Torso
		trailWeld.Part1 = drillTrail
		trailWeld.Parent = drillTrail
		drillTrail.Parent = workspace.World.Visuals

		task.delay(1.6, function()
			drillTrail:Destroy()
		end)
		--task.spawn(function()
		--	local torso = character:FindFirstChild("Torso")
		--	local lastPos = drillTrail.Position
		--	local elapsed = 0
		--	while not moveEnded and torso and spinActive and drillTrail.Parent and elapsed <= 5 do
		--		local dt = task.wait()
		--		local torsoPos = character.Torso.Position
		--		local delta = torsoPos - lastPos
		--		local goalCFrame = CFrame.new(torsoPos + delta + rootPart.CFrame.LookVector * 1, torsoPos)
		--			* CFrame.Angles(0, 0, math.rad(elapsed * 250))
		--		local alpha = (elapsed == 0) and 1 or math.clamp(dt * 32, 0, 1)
		--		drillTrail.CFrame = drillTrail.CFrame:Lerp(goalCFrame, alpha)
		--		elapsed = elapsed + dt
		--		lastPos = torsoPos
		--	end
		--	--Misc.EasyEmitter:EnableEmitters(drillTrail, false)
		--	--VFXFunctions.DisableDescendants(drillTrail)
		--	--Misc.EasyEmitter:EnableTrails(drillTrail, false)
		--	--VFXFunctions.DisableTrails(drillTrail)

		--	task.delay(3, game.Destroy, drillTrail)
		--end)

		-- Brief contrast "pop" for nearby viewers.
		--task.spawn(function()
		--	if table.find(viewers, localPlayer)
		--		or (camera.CFrame.Position - character.Torso.Position).Magnitude <= 35 then
		--		local grade = Instance.new("ColorCorrectionEffect")
		--		grade.Parent = Lighting
		--		grade.TintColor = Color3.fromRGB(227, 94, 22)
		--		grade.Saturation = -1
		--		grade.Contrast = -5
		--		task.wait(0.05)
		--		grade.Contrast = 5
		--		task.wait(0.05)
		--		grade:Destroy()
		--	end
		--end)

		-- Continuous limb afterimages for the duration of the spin.
		task.spawn(function()
			local limbs = {
				character:WaitForChild("Left Arm", 3),
				character:WaitForChild("Right Arm", 3),
				character:WaitForChild("Left Leg", 3),
				character:WaitForChild("Right Leg", 3),
				character:WaitForChild("Torso", 3),
				character:WaitForChild("Head", 3),
			}
			while not moveEnded and spinActive do
				local ghostModel = Instance.new("Model")
				ghostModel.Parent = workspace.World.Visuals
				for _, limb in limbs do
					--local template = (limb.Name == "Head" and visualEffects.Limbs.Head)
					--	or (limb.Name == "Torso" and visualEffects.Limbs.Torso)
					--	or visualEffects.Limbs.Limb
					
					local template = (limb.Name == "Head" and visualPack.Limbs.Head)
						or (limb.Name == "Torso" and visualPack.Limbs.Torso)
						or visualPack.Limbs.Limb

					local glass = template:Clone()
					glass.Parent = ghostModel
					glass.Size = limb.Size * (limb.Name == "Head" and 1.1 or 0.9) + Vector3.new(0.02, 0.02, 0.02)
					glass.CFrame = limb.CFrame
					glass.Color = Color3.fromRGB(227, 94, 22)
					glass.Material = Enum.Material.Glass
					playTween(glass, 0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.In, { Transparency = 1 })

					local neon = template:Clone()
					neon.Parent = ghostModel
					neon.Size = limb.Size * (limb.Name == "Head" and 1.1 or 0.9) + Vector3.new(0.05, 0.05, 0.05)
					neon.CFrame = limb.CFrame
					neon.Color = glass.Color
					neon.Material = Enum.Material.Neon
					playTween(neon, 0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, { Transparency = 1, Color = Color3.fromRGB() })

					--Debris(ghostModel, 0.45)
					Debris:AddItem(ghostModel, 0.45)

					--if not playerSettings:GetAttribute("FastMode") then
						task.spawn(function()
							local t = 0
							local dt = 1 / 60
							while t <= 0.35 do
								local ease = Misc.SpecialMath:lerp(12, 0,
									TweenService:GetValue(math.clamp(t / 0.35, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
								glass.CFrame = limb.CFrame.Rotation + glass.Position:Lerp(limb.Position, dt * ease)
								neon.CFrame = glass.CFrame
								dt = task.wait()
								t = t + dt
							end
						end)
					--end
				end
				task.wait((1 / 12))-- * (playerSettings:GetAttribute("FastMode") and 3 or 1))
			end
		end)

		-- Ground-kick shockwave VFX loop (body spin removed).
		local lastKickPos = character.Torso.Position
		local kickTimer = 0
		local spinTime = 0
		while not moveEnded
			--and (castTrack.TimePosition <= 3.6 or spinTime <= 0.5)
			and (spinTime <= 0.5)
			and not workspace:Raycast(rootPart.Position, Vector3.new(0, -5, 0), raycastParams) do

			if kickTimer >= 0.1 then
				local kick = visualPack.Kick:Clone()
				kick:PivotTo(CFrame.new(lastKickPos, character.Torso.Position).Rotation
					* CFrame.new(0, -0.5, -6)
					* CFrame.Angles(0, 0, math.rad(-90))
					* CFrame.Angles(0, math.rad(-90), 0)
					+ character.Torso.Position)
				kick.Parent = workspace.World.Visuals

				-- Shockwave mesh.
				local sw = kick.Shockwave
				local swBase = sw.CFrame
				sw.CFrame = swBase * CFrame.new(5, 0, 0)
				sw.Size = Vector3.new(7, 2, 2)
				sw.Transparency = 1
				playTween(sw, 0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, {
					Size = Vector3.new(12, 12, 12), Transparency = 0.75, CFrame = swBase * CFrame.new(3, 0, 0),
				})
				task.delay(0.1, function()
					playTween(sw, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
						Size = Vector3.new(5, 30, 30), Transparency = 1, CFrame = swBase * CFrame.new(-3, 0, 0),
					})
				end)

				-- Light flash.
				--local light = kick.Light
				--local lightBase = light.CFrame
				--Misc.ExtraVisual:handleSpecialMeshOver(light, light.Mesh)
				--light.CFrame = lightBase * CFrame.new(8, 0, 0)
				--light.Size = Vector3.new(2, 1, 1)
				--light.Transparency = 1
				--playTween(light.Decal, 0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, { Transparency = 0.9 })
				--playTween(light, 0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, {
				--	Size = Vector3.new(4, 3, 3), CFrame = lightBase * CFrame.new(6, 0, 0),
				--})
				--task.delay(0.1, function()
				--	playTween(light.Decal, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, { Transparency = 1 })
				--	playTween(light, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
				--		Size = Vector3.new(3, 4, 4), CFrame = lightBase * CFrame.new(-4, 0, 0),
				--	})
				--end)

				-- Gradient light flash.
				--local gLight = kick.GradientLight
				--local gLightBase = gLight.CFrame
				--Misc.ExtraVisual:handleSpecialMeshOver(gLight, gLight.Mesh)
				--gLight.CFrame = gLightBase * CFrame.new(8, 0, 0)
				--gLight.Size = Vector3.new(2, 1, 1)
				--gLight.Transparency = 1
				--playTween(gLight.Decal, 0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, { Transparency = 0.95 })
				--playTween(gLight, 0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, {
				--	Size = Vector3.new(4, 4, 4), CFrame = gLightBase * CFrame.new(6, 0, 0),
				--})
				--task.delay(0.1, function()
				--	playTween(gLight.Decal, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, { Transparency = 1 })
				--	playTween(gLight, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
				--		Size = Vector3.new(2.5, 5, 5), CFrame = gLightBase * CFrame.new(-4, 0, 0),
				--	})
				--end)

				--Debris(kick, 0.5)
				Debris:AddItem(kick, 0.5)

				lastKickPos = character.Torso.Position
				kickTimer = 0
			end

			-- (body-spin line removed here)

			local dt = task.wait()
			spinTime = spinTime + dt
			kickTimer = kickTimer + dt
		end

		-- End the spin VFX: stop afterimages and reset FoV.
		spinFinished = true
		spinActive = false
		if moveEnded then
			return
		end
		--playTween(fovMod, 0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, { Value = 0 })
	end
	
	if (skillType == "FinisherSpin") then
		
	end
	
	
end