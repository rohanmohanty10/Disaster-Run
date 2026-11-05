--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer

local RNG = Random.new()

local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)
local VoxelSerializer = require(ReplicatedStorage.Modules.VoxelSerializer)

return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType = argumentData.SkillType

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	local RightArm = attacker and attacker:FindFirstChild("Right Arm")

	if not hrp then
		return
	end

	local tbl_13_upvr = {}
	local activeTweens = {}
	local BoatTween_upvrGPO = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)

	local activeTweens = tbl_13_upvr

	function _G.tween(instance, tweenParams, goalTable, stepType, forceRestart)
		-- If forceRestart is true and a tween is already running on this instance, stop and destroy it
		if forceRestart ~= nil and activeTweens[instance] then
			local existingTween = activeTweens[instance][1]
			existingTween:Stop()
			existingTween:Destroy()
			activeTweens[instance] = nil
		end

		-- Early exit if instance is invalid
		if not instance or instance == nil or instance.Parent == nil then
			return
		end

		-- If a tween is already running on this instance, check if any goal properties overlap
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

				-- If properties overlap, stop the existing tween
				if hasOverlap then
					existingTween:Stop()
					existingTween:Destroy()
					activeTweens[instance] = nil
				end
			end
		end)

		-- Build tween info table for BoatTween
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

		-- Create and play the tween
		local tween = BoatTween_upvrGPO:Create(instance, tweenInfo)
		activeTweens[instance] = { tween, goalTable }
		tween:Play()

		-- Clean up when tween completes
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

			-- Clean up if instance is destroyed before tween completes
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

	local function applyFacingCFrame(sourceFolder, cloneFolder, facingCFrame)
		local rootPart = cloneFolder:FindFirstChildWhichIsA("BasePart", true)
		local rootCFrame = rootPart.CFrame
		for _, v in ipairs(cloneFolder:GetDescendants()) do
			if v:IsA("BasePart") then
				local relativeOffset = rootCFrame:ToObjectSpace(v.CFrame)
				v.CFrame = facingCFrame * relativeOffset
			end
		end
	end

	local function getFacingCFrame(torso, offset)
		local look = torso.CFrame.LookVector
		local flatLook = Vector3.new(look.X, 0, look.Z).Unit
		return CFrame.lookAt(torso.CFrame.Position, torso.CFrame.Position + flatLook) * (offset or CFrame.new())
	end

	local function fadeOutClone(clone)
		for _, v in ipairs(clone:GetDescendants()) do
			-- Stop emitters from emitting new particles
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
			-- Tween part transparency to invisible
			if v:IsA("BasePart") then
				TS:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Transparency = 1,
				}):Play()
			end
		end
	end

	local function GetRandomPointInFront(character, size)
		local hrp = character.HumanoidRootPart

		-- 1. Define how far in front the center of the box is
		-- If depth is 20, we should put the center 10 studs out so it starts at our feet
		local forwardOffset = size.Z / 2

		-- 2. Pick random offsets within the box dimensions
		local randomX = math.random(-size.X / 2, size.X / 2)
		local randomY = math.random(-size.Y / 2, size.Y / 2)
		local randomZ = math.random(-size.Z / 2, size.Z / 2)

		-- 3. Combine them into a relative CFrame
		local relativeCFrame = CFrame.new(randomX, randomY, -forwardOffset + randomZ)

		-- 4. Convert to World Position based on where the player is looking
		return (hrp.CFrame * relativeCFrame)
	end

	local function createDebree(debrisList, targetAttachment)
		for _, debrisData in debrisList do
			local piece = Instance.new("Part")
			piece.CanCollide = false
			piece.Massless = true

			local boxSize = Vector3.new(20, 5, 40)
			local spawnPos = GetRandomPointInFront(attacker, boxSize)

			--piece.Position = debrisData[1]
			piece.CFrame = spawnPos
			piece.Orientation = debrisData[2]
			piece.Color = debrisData[3]
			piece.Material = debrisData[4]
			piece.Size = debrisData[5]
			piece.CollisionGroup = "NoCol"

			--piece.Velocity = RNG:NextUnitVector() * RNG:NextInteger(60, 100)
			local direction = (targetAttachment.Position - piece.Position).Unit
			-- 2. Add a little bit of "up" so they don't just drag on the floor
			local upwardForce = Vector3.new(0, math.random(1, 10), 0)
			-- 3. Combine them and multiply by speed
			local speed = RNG:NextInteger(30, 60)
			piece.Velocity = (direction + upwardForce).Unit * speed
			piece.RotVelocity = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
			piece.Parent = workspace.World.Debris
			Debris:AddItem(piece, 1)

			if math.random(1, 10) == 1 then
				--FXController:DebreeSound(piece)
			end

			-- After 0.2s start pulling the piece toward the target attachment
			task.delay(0.1, function()
				local pieceAttachment = Instance.new("Attachment", piece)
				pieceAttachment.Name = "BlueGrab"
				local alignPos = Instance.new("AlignPosition", pieceAttachment)
				alignPos.Responsiveness = 0
				TS:Create(alignPos, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					Responsiveness = 100,
				}):Play()
				alignPos.Attachment0 = pieceAttachment

				-- If target is itself an attachment, pull toward it directly
				if targetAttachment.Parent:IsA("Attachment") then
					pieceAttachment = targetAttachment.Parent or pieceAttachment
				end
				alignPos.Attachment1 = pieceAttachment
			end)
		end
	end

	local function getScaledSequence(originalSequence, factor)
		local keypoints = originalSequence.Keypoints
		local newKeypoints = {}

		for _, v in ipairs(keypoints) do
			-- Standard properties: Time, Value, Envelope
			table.insert(newKeypoints, NumberSequenceKeypoint.new(v.Time, v.Value * factor, v.Envelope * factor))
		end

		-- Safety: Ensure at least 2 keypoints exist
		if #newKeypoints == 1 then
			local kp = newKeypoints[1]
			newKeypoints = {
				NumberSequenceKeypoint.new(0, kp.Value, kp.Envelope),
				NumberSequenceKeypoint.new(1, kp.Value, kp.Envelope),
			}
		end

		return NumberSequence.new(newKeypoints)
	end

	local function expandAttachmentVFX(bhPart, duration, targetScale)
		local emitterData = {}

		-- 1. Target emitters ONLY inside the Attachments
		for _, child in ipairs(bhPart:GetDescendants()) do
			if child:IsA("Attachment") then
				for _, emitter in ipairs(child:GetDescendants()) do
					if emitter:IsA("ParticleEmitter") then
						-- Store original sequence and immediately set size to near zero
						local original = emitter.Size
						emitter.Size = getScaledSequence(original, 0.05)

						table.insert(emitterData, {
							Instance = emitter,
							OriginalSize = original,
						})
					end
				end
			end
		end

		-- 2. Animate the growth from 0.05 to targetScale
		local startTime = os.clock()
		task.spawn(function()
			while os.clock() - startTime < duration do
				local elapsed = os.clock() - startTime
				local progress = math.min(elapsed / duration, 1)

				-- Cubic Out easing for an explosive expansion feel
				local easedProgress = 1 - math.pow(1 - progress, 3)
				local currentScale = 0.05 + ((targetScale - 0.05) * easedProgress)

				for _, data in ipairs(emitterData) do
					data.Instance.Size = getScaledSequence(data.OriginalSize, currentScale)
				end

				task.wait()
			end
		end)
	end

	local function shrinkAttachmentVFX(bhPart, duration, targetScale)
		local emitterData = {}

		for _, emitter in ipairs(bhPart:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				local original = emitter.Size
				-- Don't touch size yet — start from original
				table.insert(emitterData, {
					Instance = emitter,
					OriginalSize = original,
				})
			end
		end

		local startTime = os.clock()
		task.spawn(function()
			while os.clock() - startTime < duration do
				local elapsed = os.clock() - startTime
				local progress = math.min(elapsed / duration, 1)
				-- Cubic In easing — starts slow, accelerates into the shrink
				local easedProgress = progress * progress * progress
				local currentScale = 1 - ((1 - targetScale) * easedProgress)
				for _, data in ipairs(emitterData) do
					data.Instance.Size = getScaledSequence(data.OriginalSize, currentScale)
				end
				task.wait()
			end
			-- Ensure it lands exactly at targetScale
			for _, data in ipairs(emitterData) do
				data.Instance.Size = getScaledSequence(data.OriginalSize, targetScale)
			end
		end)
	end

	if skillType == "Rocks" then
		--warn("CreatingRocks")
		local debrisList = argumentData.debrisList
		local targetAttachment = argumentData.targetAttachment

		local duration = 1.5
		local start = os.clock()
		while os.clock() - start < duration do
			createDebree(debrisList, targetAttachment)
			task.wait(0.15)
		end
	end

	local TRANS_ATTR = "__TransFXOrig"
	if skillType == "Transparent" then
		for _, part in ipairs(attacker:GetDescendants()) do
			if part:IsA("BasePart") then
				-- save the original ONCE so a repeat "Transparent" can't overwrite
				-- it with 1 (which would make everything opaque on restore)
				if part:GetAttribute(TRANS_ATTR) == nil then
					part:SetAttribute(TRANS_ATTR, part.Transparency)
				end
				part.Transparency = 1
			end
		end
	end

	if skillType == "UnTransparent" then
		for _, part in ipairs(attacker:GetDescendants()) do
			if part:IsA("BasePart") then
				local orig = part:GetAttribute(TRANS_ATTR)
				if orig ~= nil then
					part.Transparency = orig -- back to its real value, not 0
					part:SetAttribute(TRANS_ATTR, nil) -- clear for next time
				end
			end
		end
	end
	-- Incorporating the main logic into LiberationTest2
	if skillType == "LiberationTest2" then
		local Torso = attacker:FindFirstChild("Torso")
		if not Torso then
			return
		end

		-- The center point where debris/beams gravitate (20 units above character)
		local collectionPoint = hrp.CFrame * CFrame.new(0, 20, 0)
		--local collectionPoint = Torso.CFrame * CFrame.new(0, 20, 0)

		local endTime = os.clock() + 7 -- Adjust duration as needed

		while os.clock() < endTime do
			if attacker:GetAttribute("LiberationVfxEnd") == false then
				break
			end

			-- 1. BEAM LOGIC
			local rootAttachment = Instance.new("Attachment")
			rootAttachment.Orientation =
				Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
			--rootAttachment.Parent = Torso
			rootAttachment.Parent = hrp

			local targetAttachment = Instance.new("Attachment")
			targetAttachment.Orientation =
				Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
			targetAttachment.Position = Vector3.new(math.random(-25, 25), math.random(10, 60), math.random(-25, 25))
			--targetAttachment.Parent = Torso

			targetAttachment.Parent = hrp

			local beam = script.beam:Clone()
			--beam.Parent = Torso
			beam.Parent = hrp

			beam.Attachment0 = rootAttachment
			beam.Attachment1 = targetAttachment

			local curveSize = math.random(5, 15)
			if math.random(1, 2) == 1 then
				curveSize = -curveSize
			end

			beam.CurveSize0 = curveSize
			beam.CurveSize1 = curveSize * -2
			beam.Width0 = math.random(10, 20)

			_G.tween(beam, { 0.75, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
				CurveSize0 = curveSize * -2,
				CurveSize1 = curveSize * 2,
				Width0 = 0,
			})

			_G.tween(targetAttachment, { 1, "Sine", Enum.EasingDirection.InOut, 0, false, 0 }, {
				Position = Vector3.new(),
			})

			GpDestroy({ rootAttachment, targetAttachment, beam }, 1)

			-- 2. ENVIRONMENTAL DEBRIS LOGIC
			-- Cast a ray to find environment parts to pull in
			local randomDir = collectionPoint
				* CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
				* CFrame.new(0, 0, 100)
			local ray = Ray.new(
				collectionPoint.Position,
				CFrame.new(collectionPoint.Position, randomDir.Position).LookVector
					* (collectionPoint.Position - randomDir.Position).Magnitude
			)

			-- Logic 100% same as original: uses whitelist for islands, env, and ships
			--local hitPart, hitPos = _G.raycastWhitelist(ray, {
			--	workspace.World.Map})

			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Include -- This makes it a "Whitelist"
			params.FilterDescendantsInstances = { workspace.World.Map }

			-- 2. Define your Ray variables
			local origin = collectionPoint.Position
			local direction = (randomDir.Position - collectionPoint.Position)

			-- 3. Perform the Raycast
			local raycastResult = workspace:Raycast(origin, direction, params)

			-- 4. Handle the result
			if raycastResult then
				local hitPart = raycastResult.Instance
				local hitPos = raycastResult.Position
				-- ... proceed with your debris logic
				if hitPart then
					local debrisPart = script.Part:Clone() -- Using source for the debris part reference
					--_G.matchMaterial(debrisPart, hitPart)
					debrisPart.Color = hitPart.Color
					debrisPart.Material = hitPart.Material
					debrisPart.MaterialVariant = hitPart.MaterialVariant
					debrisPart.Transparency = 1
					local scaleReduction = 0.5

					local baseSize = math.random(3, 6)
					debrisPart.Size = Vector3.new(
						baseSize / (math.random(90, 200) / 100),
						baseSize / (math.random(90, 200) / 100),
						baseSize / (math.random(90, 200) / 100)
					)

					debrisPart.CFrame = CFrame.new(hitPos)
						* CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
					debrisPart.Parent = workspace.World.Debris -- Standardized pathway for visual effects

					local travelDuration = 0.25 + (collectionPoint.Position - randomDir.Position).Magnitude / 250

					_G.tween(debrisPart, { travelDuration, "Sine", Enum.EasingDirection.Out, 0, false, 0 }, {
						CFrame = collectionPoint
							* CFrame.new(0, math.random(-15, 20), 0)
							* CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360)),
					})

					_G.tween(debrisPart, { travelDuration / 2, "Sine", Enum.EasingDirection.Out, 0, false, 0 }, {
						Transparency = 0,
					})

					-- Handle mesh scaling if the part has one
					--local mesh = debrisPart:FindFirstChildWhichIsA("SpecialMesh") or debrisPart:FindFirstChild("Mesh")
					--if mesh then
					--	_G.tween(mesh, {travelDuration, "Cubic", Enum.EasingDirection.InOut, 0, false, 0}, {
					--		Scale = Vector3.new()
					--	})
					--end
					local absorbTime = travelDuration * 0.35
					local swallowTarget = debrisPart.Size * 0.05
					local mesh = debrisPart:FindFirstChildWhichIsA("SpecialMesh") or debrisPart:FindFirstChild("Mesh")
					task.delay(travelDuration - absorbTime, function()
						if not debrisPart.Parent then
							return
						end
						_G.tween(debrisPart, { absorbTime, "Quad", Enum.EasingDirection.In, 0, false, 0 }, {
							Size = swallowTarget,
							Transparency = 1,
						})
						if mesh then
							_G.tween(mesh, { absorbTime, "Quad", Enum.EasingDirection.In, 0, false, 0 }, {
								Scale = Vector3.new(),
							})
						end
					end)

					GpDestroy(debrisPart, travelDuration)
				end
			end

			RunService.Heartbeat:Wait()
		end
	end

	if skillType == "DebrisOrb" then
		-- The center point where debris/beams gravitate (20 units above character)
		local collectionPoint = hrp.CFrame * CFrame.new(0, 40, 0)

		local endTime = os.clock() + 5 -- Adjust duration as needed

		while os.clock() < endTime do
			local randomDir = collectionPoint
				* CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
				* CFrame.new(0, 0, 140)
			local ray = Ray.new(
				collectionPoint.Position,
				CFrame.new(collectionPoint.Position, randomDir.Position).LookVector
					* (collectionPoint.Position - randomDir.Position).Magnitude
			)

			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Include -- This makes it a "Whitelist"
			params.FilterDescendantsInstances = { workspace.World.Map }

			-- 2. Define your Ray variables
			local origin = collectionPoint.Position
			local direction = (randomDir.Position - collectionPoint.Position)

			-- 3. Perform the Raycast
			local raycastResult = workspace:Raycast(origin, direction, params)

			-- 4. Handle the result
			if raycastResult then
				local hitPart = raycastResult.Instance
				local hitPos = raycastResult.Position
				-- ... proceed with your debris logic
				if hitPart then
					local debrisPart = script.Part:Clone() -- Using source for the debris part reference
					--_G.matchMaterial(debrisPart, hitPart)
					debrisPart.Transparency = 1
					local scaleReduction = 0.5

					local baseSize = math.random(4, 7)
					debrisPart.Size = Vector3.new(
						baseSize / (math.random(90, 200) / 100),
						baseSize / (math.random(90, 200) / 100),
						baseSize / (math.random(90, 200) / 100)
					)

					debrisPart.CFrame = CFrame.new(hitPos)
						* CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
					debrisPart.Parent = workspace.World.Debris -- Standardized pathway for visual effects

					local travelDuration = 0.25 + (collectionPoint.Position - randomDir.Position).Magnitude / 250

					_G.tween(debrisPart, { travelDuration, "Sine", Enum.EasingDirection.Out, 0, false, 0 }, {
						CFrame = collectionPoint
							* CFrame.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))
							* CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360)),
					})

					_G.tween(debrisPart, { travelDuration / 2, "Sine", Enum.EasingDirection.Out, 0, false, 0 }, {
						Transparency = 0,
					})

					-- Handle mesh scaling if the part has one
					local mesh = debrisPart:FindFirstChildWhichIsA("SpecialMesh") or debrisPart:FindFirstChild("Mesh")
					if mesh then
						_G.tween(mesh, { travelDuration, "Cubic", Enum.EasingDirection.InOut, 0, false, 0 }, {
							Scale = Vector3.new(),
						})
					end

					GpDestroy(debrisPart, travelDuration)
				end
			end

			RunService.Heartbeat:Wait()
		end
	end

	if skillType == "ColorCorrection" then
		local hitPosition = argumentData.HitPosition

		local TWEEN_BLUR_IN = {
			0.2,
			Enum.EasingStyle.Sine,
			Enum.EasingDirection.Out,
			0,
			true,
			0,
		}
		local TWEEN_CORRECTION_OUT = {
			0.25,
			Enum.EasingStyle.Sine,
			Enum.EasingDirection.Out,
			0,
			false,
			0,
		}

		if (workspace.CurrentCamera.CFrame.Position - hitPosition).Magnitude >= 200 then
			return
		end

		local colorCorrection = Instance.new("ColorCorrectionEffect")
		colorCorrection.Parent = workspace.CurrentCamera

		local blur = Instance.new("BlurEffect")
		blur.Name = "BLURFX"
		blur.Size = 0
		blur.Parent = workspace.CurrentCamera

		-- Immediately slam brightness/contrast/saturation and blur in
		coroutine.wrap(function()
			colorCorrection.Brightness = -0.2
			colorCorrection.Contrast = -2
			colorCorrection.Saturation = -1

			_G.tween(blur, TWEEN_BLUR_IN, { Size = 15 })
			task.wait(TWEEN_BLUR_IN[0.5])

			_G.tween(colorCorrection, TWEEN_CORRECTION_OUT, {
				Brightness = -0.1,
				Contrast = 0.2,
				Saturation = -0.8,
			})

			GpDestroy(blur, 1.5)
		end)()

		-- After a short delay, ease color correction back toward normal
		task.wait(0.75)
		_G.tween(colorCorrection, TWEEN_BLUR_IN, {
			Brightness = -0.1,
			Contrast = 1.3,
			Saturation = -1,
		})

		task.wait(0.5)
		_G.tween(colorCorrection, TWEEN_CORRECTION_OUT, {
			Brightness = 0,
			Contrast = 0,
			Saturation = 0,
		})

		GpDestroy(colorCorrection, 1)
	end

	if skillType == "darkBeam1" then
		local Liberation = script.BeamUp.Liberation:Clone()
		Liberation.Parent = workspace.World.Visuals
		Debris:AddItem(Liberation, 10)
		Liberation.CFrame = hrp.CFrame * CFrame.Angles(math.rad(-90), 0, math.rad(0))

		local TorsoFlame = script.BeamUp.TorsoFlame:Clone()
		TorsoFlame.Parent = workspace.World.Visuals
		Debris:AddItem(TorsoFlame, 10)
		TorsoFlame.CFrame = hrp.CFrame * CFrame.new(0, -15, 0)

		EffectUtilities.Emit(Liberation)
		EffectUtilities.Emit(TorsoFlame)

		task.delay(7, function()
			fadeOutClone(TorsoFlame)
			task.wait(2)
			fadeOutClone(Liberation)
		end)
	end

	if skillType == "bigBall" then
		local distance = 40
		local BlackHole1 = script.BlackHole1:Clone()
		BlackHole1.Parent = workspace.World.Visuals
		Debris:AddItem(BlackHole1, 11)
		BlackHole1.CFrame = hrp.CFrame * CFrame.new(0, distance, 0)

		local BlackHole2 = script.BlackHole2:Clone()
		BlackHole2.Parent = workspace.World.Visuals
		Debris:AddItem(BlackHole2, 11)
		BlackHole2.CFrame = hrp.CFrame * CFrame.new(0, distance, 0)

		local DustCollect = script.DustCollect:Clone()
		DustCollect.Parent = workspace.World.Visuals
		Debris:AddItem(DustCollect, 11)
		DustCollect.CFrame = hrp.CFrame * CFrame.new(0, distance, 0)

		local BlackHole3 = script.BlackHole3:Clone()
		BlackHole3.Parent = workspace.World.Visuals
		Debris:AddItem(BlackHole3, 11)
		BlackHole3.CFrame = hrp.CFrame * CFrame.new(0, distance, 0) * CFrame.Angles(0, math.rad(90), math.rad(90))

		EffectUtilities.Emit(BlackHole1)
		EffectUtilities.Emit(BlackHole2)
		EffectUtilities.Emit(BlackHole3)
		EffectUtilities.Emit(DustCollect)

		expandAttachmentVFX(BlackHole1, 4.5, 3)
		expandAttachmentVFX(BlackHole2, 4.5, 3)
		expandAttachmentVFX(BlackHole3, 4.5, 3)

		_G.LiberationOrbs = {
			BlackHole1 = BlackHole1,
			BlackHole2 = BlackHole2,
			BlackHole3 = BlackHole3,
			DustCollect = DustCollect,
		}

		--local SHRINK_DURATION = .5
		--local FINAL_VFX_SIZE = .3
		--local blockSize = 7

		---- Start the expansion logic for Attachments
		--task.delay(5.5, function()
		--	shrinkAttachmentVFX(BlackHole1, SHRINK_DURATION, FINAL_VFX_SIZE)
		--	shrinkAttachmentVFX(BlackHole2, SHRINK_DURATION, FINAL_VFX_SIZE)
		--	shrinkAttachmentVFX(BlackHole3, SHRINK_DURATION, FINAL_VFX_SIZE)
		--	shrinkAttachmentVFX(DustCollect, SHRINK_DURATION, FINAL_VFX_SIZE)
		--	local tween = TS:Create(BlackHole1, TweenInfo.new(SHRINK_DURATION, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
		--		Size = Vector3.new(blockSize, blockSize, blockSize)
		--	}):Play()
		--	local tween = TS:Create(BlackHole2, TweenInfo.new(SHRINK_DURATION, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
		--		Size = Vector3.new(blockSize, blockSize, blockSize)
		--	}):Play()
		--	local tween = TS:Create(BlackHole3, TweenInfo.new(SHRINK_DURATION, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
		--		Size = Vector3.new(blockSize, blockSize, blockSize)
		--	}):Play()
		--	local tween2 = TS:Create(DustCollect, TweenInfo.new(SHRINK_DURATION, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
		--		Size = Vector3.new(blockSize, blockSize, blockSize)
		--	})
		--	tween2:Play()
		--	tween2.Completed:Wait()
		--	fadeOutClone(BlackHole1)
		--	fadeOutClone(BlackHole2)
		--	fadeOutClone(BlackHole3)
		--	fadeOutClone(DustCollect)
		--	task.wait(.2)
		--	BlackHole1:Destroy()
		--	BlackHole2:Destroy()
		--	BlackHole3:Destroy()
		--	DustCollect:Destroy()
		--end)
	end

	if skillType == "shrinkOrb" then
		local orbs = _G.LiberationOrbs
		if not orbs then
			return
		end

		local SHRINK_DURATION = 0.5
		local FINAL_VFX_SIZE = 0.3
		local blockSize = 7

		shrinkAttachmentVFX(orbs.BlackHole1, SHRINK_DURATION, FINAL_VFX_SIZE)
		shrinkAttachmentVFX(orbs.BlackHole2, SHRINK_DURATION, FINAL_VFX_SIZE)
		shrinkAttachmentVFX(orbs.BlackHole3, SHRINK_DURATION, FINAL_VFX_SIZE)
		shrinkAttachmentVFX(orbs.DustCollect, SHRINK_DURATION, FINAL_VFX_SIZE)

		TS:Create(
			orbs.BlackHole1,
			TweenInfo.new(SHRINK_DURATION, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
			{ Size = Vector3.new(blockSize, blockSize, blockSize) }
		):Play()
		TS:Create(
			orbs.BlackHole2,
			TweenInfo.new(SHRINK_DURATION, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
			{ Size = Vector3.new(blockSize, blockSize, blockSize) }
		):Play()
		TS:Create(
			orbs.BlackHole3,
			TweenInfo.new(SHRINK_DURATION, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
			{ Size = Vector3.new(blockSize, blockSize, blockSize) }
		):Play()

		local finalTween = TS:Create(
			orbs.DustCollect,
			TweenInfo.new(SHRINK_DURATION, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
			{ Size = Vector3.new(blockSize, blockSize, blockSize) }
		)
		finalTween:Play()
		finalTween.Completed:Wait()

		fadeOutClone(orbs.BlackHole1)
		fadeOutClone(orbs.BlackHole2)
		fadeOutClone(orbs.BlackHole3)
		fadeOutClone(orbs.DustCollect)

		task.wait(0.2)
		orbs.BlackHole1:Destroy()
		orbs.BlackHole2:Destroy()
		orbs.BlackHole3:Destroy()
		orbs.DustCollect:Destroy()

		_G.LiberationOrbs = nil
	end

	local function driveEmitterRate(root, minSize, maxSize, minRate, maxRate)
		local emitters = {}
		for _, e in root:GetChildren() do
			if e:IsA("ParticleEmitter") then
				table.insert(emitters, e)
			end
		end
		if #emitters == 0 then
			return
		end

		local conn
		conn = RunService.Heartbeat:Connect(function()
			if not root.Parent then
				conn:Disconnect() -- Debris removed the hole; stop
				return
			end
			local s = math.max(root.Size.X, root.Size.Y, root.Size.Z)
			local alpha = math.clamp((s - minSize) / (maxSize - minSize), 0, 1)
			local rate = minRate + (maxRate - minRate) * alpha
			for _, e in emitters do
				e.Rate = rate
			end
		end)
	end

	if skillType == "start" then
		local Torso = attacker:FindFirstChild("Torso")
		local Arm = attacker:FindFirstChild("Right Arm")

		local hole = script.FloorBH.Hole:Clone()
		hole.CFrame = hrp.CFrame * CFrame.new(0, -4, 0)
		hole.Parent = workspace.World.Visuals

		local desiredSize = hole.Size * 5
		hole.Size = Vector3.new(0, 0, 0)
		hole.Transparency = 1

		local growInfo = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local growTween = TS:Create(hole, growInfo, { Size = desiredSize, Transparency = 0 })
		growTween:Play() --To make it bigger

		local baseAxis1 = math.max(hole.Size.X, hole.Size.Y, hole.Size.Z)
		driveEmitterRate(hole, baseAxis1, baseAxis1 * 3.5, 0, 100)

		local tweenInfo = TweenInfo.new(3.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		local holeGoals = { Size = Vector3.new(0, 0, 0), Transparency = 1 }
		local holeTween = TS:Create(hole, tweenInfo, holeGoals)
		task.delay(4.3, function()
			holeTween:Play() --To make it back to smaller
		end)

		EffectUtilities.Emit(hole)
		Debris:AddItem(hole, 10)

		local blackhole = script.FloorBH.blackhole:Clone()
		blackhole.Parent = workspace.World.Visuals
		Debris:AddItem(blackhole, 10)
		blackhole.CFrame = hrp.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, math.rad(90), math.rad(90))

		local GROW_DURATION = 3
		local FINAL_VFX_SIZE = 3.5 -- 4x larger than your original Studio size

		local baseAxis = math.max(blackhole.Size.X, blackhole.Size.Y, blackhole.Size.Z)
		driveEmitterRate(blackhole, baseAxis, baseAxis * FINAL_VFX_SIZE, 20, 100)

		-- Start the expansion logic for Attachments
		expandAttachmentVFX(blackhole, GROW_DURATION, FINAL_VFX_SIZE)

		-- Standard Emission
		EffectUtilities.Emit(blackhole)

		-- Part Tween (Visual floor hole)
		local growTween = TS:Create(blackhole, TweenInfo.new(GROW_DURATION, Enum.EasingStyle.Quad), {
			Size = blackhole.Size * FINAL_VFX_SIZE,
			Transparency = 1,
		})
		growTween:Play()

		local bHoleWweenInfo = TweenInfo.new(3.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		local bHoleGoals = { Size = Vector3.new(0, 0, 0), Transparency = 1 }
		local bHoleTween = TS:Create(blackhole, bHoleWweenInfo, bHoleGoals)
		task.delay(4, function()
			bHoleTween:Play() --To make it smaller
			shrinkAttachmentVFX(blackhole, 3.3, 0.1)

			task.wait(3.5) --Time for shrinkAttachment to end (3.3)
			fadeOutClone(blackhole)
			fadeOutClone(hole)
		end)
	end

	if skillType == "explode" then
		local Explosion = script.Explosion:Clone()
		Explosion.Parent = workspace.World.Visuals
		Debris:AddItem(Explosion, 5)
		for _, part in ipairs(Explosion:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CFrame = hrp.CFrame * CFrame.new(0, 50, 0)
			end
		end

		EffectUtilities.Emit(Explosion)
	end

	local SinkPool = { active = {}, count = 0, conn = nil, moveParts = {}, moveCFs = {} }

	local function absorbVoxelList(voxelList, targetAttachment)
		if not voxelList or not targetAttachment then
			return
		end

		local WAVE_TIME = 0.35 -- outer pieces of a batch start after inner ones
		local START_JITTER = 0.2 -- extra random delay so rings collapse raggedly
		local SINK_ACCEL = { 60, 120 } -- was {25, 60}: much harder downward drag
		local SINK_MAX = { 60, 100 } -- was {30, 55}: faster terminal sink speed
		local IN_SPEED = { 10, 45 } -- was {10, 45}: stronger slide toward the center
		local IN_DECAY = 0.4 -- was 1.2: the slide persists instead of dying early
		local TUMBLE = 3 -- max tumble rate, rad/s
		local HOP_CHANCE = 0.30 -- some pieces kick upward before sinking
		local HOP_SPEED = { 8, 14 }
		local FADE_DELAY = 1 -- NEW: pieces stay fully opaque this long after they start
		local FADE_DEPTH = 4 -- extra studs of sinking over which a piece then fades
		local MAX_LIFETIME = 4 -- hard safety cap per piece
		local POOL_MAX = 450 -- concurrent pieces across ALL batches

		local function rr(range)
			return range[1] + (range[2] - range[1]) * math.random()
		end

		local function sourceCFrame(vData)
			if vData.Piece ~= nil then
				return vData.Piece.CFrame
			end
			if vData.Part ~= nil then
				return (typeof(vData.Part) == "Instance" and vData.Part:IsA("BasePart")) and vData.Part.CFrame or nil
			end
			return vData.CFrame
		end

		local center0 = targetAttachment.WorldPosition
		local maxDist = 1
		for _, vData in voxelList do
			local cf = sourceCFrame(vData)
			local d = cf and (cf.Position - center0).Magnitude or 0
			if d > maxDist then
				maxDist = d
			end
		end

		local t0 = os.clock()
		for _, vData in voxelList do
			if SinkPool.count >= POOL_MAX then
				break
			end

			local piece
			if vData.Piece ~= nil then
				-- existing GlassFragment picked up nearby; sink the real part directly
				piece = vData.Piece
			elseif vData.Part ~= nil then
				local src = vData.Part
				if not (typeof(src) == "Instance" and src:IsA("BasePart")) then
					continue -- destroyed/not replicated (e.g. streamed out); skip
				end
				-- real-mesh mode: chairs/bushes keep their actual geometry
				piece = src:Clone()
				piece.Transparency = piece:GetAttribute("__OrigTrans")
					or 0
				CollectionService:RemoveTag(piece, "WindShake")
				for _, d in piece:GetDescendants() do
					if d:IsA("BasePart") or d:IsA("Bone") then
						CollectionService:RemoveTag(d, "WindShake")
					elseif d:IsA("Texture") or d:IsA("Decal") then
						local orig = d:GetAttribute("__OrigTrans")
						if orig ~= nil then
							d.Transparency = orig
						end
					end
				end
			else
				piece = Instance.new("Part")
				piece.CFrame, piece.Size, piece.Color, piece.Material =
					vData.CFrame, vData.Size, vData.Color, vData.Material
				piece.MaterialVariant = vData.MaterialVariant or ""
			end
			piece.Anchored = true -- stays anchored forever: kinematic only
			piece.CanCollide, piece.CanQuery, piece.CanTouch = false, false, false
			piece.Massless, piece.CastShadow = true, false
			piece.Parent = workspace.World.Debris

			local cf0 = piece.CFrame
			local dist = (cf0.Position - center0).Magnitude
			local spin = Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1)
			local startAt = t0 + (dist / maxDist) * WAVE_TIME + math.random() * START_JITTER

			SinkPool.active[piece] = {
				cf = cf0,
				att = targetAttachment,
				lastCenter = center0,
				groundY = cf0.Position.Y,
				startAt = startAt,
				dieAt = startAt + MAX_LIFETIME,
				-- variants: every piece rolls its own motion
				sinkV = if math.random() < HOP_CHANCE then -rr(HOP_SPEED) else 0, -- negative = brief upward hop
				sinkAccel = rr(SINK_ACCEL),
				sinkMax = rr(SINK_MAX),
				inSpeed = rr(IN_SPEED),
				spinAxis = spin.Magnitude > 1e-3 and spin.Unit or Vector3.yAxis,
				spinRate = (0.3 + math.random() * 0.7) * TUMBLE,
				fadeDepth = piece.Size.Y * 0.5 + FADE_DEPTH,
				baseTransparency = piece.Transparency, -- glass shards keep their glassiness
			}
			SinkPool.count += 1
		end

		-- one shared loop for the whole pool, started on demand
		if SinkPool.conn then
			return
		end
		SinkPool.conn = RunService.Heartbeat:Connect(function(dt)
			local now = os.clock()
			local moveParts, moveCFs = SinkPool.moveParts, SinkPool.moveCFs
			table.clear(moveParts)
			table.clear(moveCFs)

			local centers = {} -- one WorldPosition read per attachment per frame

			for piece, data in SinkPool.active do
				if not piece.Parent or now > data.dieAt then
					if piece.Parent then
						piece:Destroy()
					end
					SinkPool.active[piece] = nil
					SinkPool.count -= 1
					continue
				end
				if now < data.startAt then
					continue
				end

				local center = data.lastCenter
				local att = data.att
				if att.Parent then
					center = centers[att] or att.WorldPosition
					centers[att] = center
					data.lastCenter = center
				end

				local pos = data.cf.Position

				-- accelerating sink (starts negative for hop pieces)
				data.sinkV = math.min(data.sinkV + data.sinkAccel * dt, data.sinkMax)

				-- slide toward the hole's column, dying off over time
				local inVel = Vector3.zero
				if data.inSpeed > 0.5 then
					local toC = Vector3.new(center.X - pos.X, 0, center.Z - pos.Z)
					local dist = toC.Magnitude
					if dist > 1 then
						-- cap the step so fast pieces land on the column instead of jittering across it
						inVel = toC.Unit * math.min(data.inSpeed, dist / dt)
					end
					data.inSpeed *= math.max(0, 1 - IN_DECAY * dt)
				end

				data.cf = (data.cf + (inVel + Vector3.new(0, -data.sinkV, 0)) * dt)
					* CFrame.fromAxisAngle(data.spinAxis, data.spinRate * dt)

				-- fade with depth below the spawn surface; gone once fully under
				if not data.fadeArmed then
					if now - data.startAt >= FADE_DELAY then
						data.fadeArmed = true
						data.groundY = math.min(data.groundY, data.cf.Position.Y)
					end
				else
					local depth = data.groundY - data.cf.Position.Y
					local fade = math.clamp(depth / data.fadeDepth, 0, 1)
					if fade >= 1 then
						piece:Destroy()
						SinkPool.active[piece] = nil
						SinkPool.count -= 1
						continue
					end
					if math.abs((data.lastFade or 0) - fade) > 0.07 then
						data.lastFade = fade
						local base = data.baseTransparency or 0
						piece.Transparency = base + (1 - base) * fade
					end
				end

				local n = #moveParts + 1
				moveParts[n] = piece
				moveCFs[n] = data.cf
			end

			if #moveParts > 0 then
				workspace:BulkMoveTo(moveParts, moveCFs, Enum.BulkMoveMode.FireCFrameChanged)
			end
			if SinkPool.count == 0 then
				SinkPool.conn:Disconnect()
				SinkPool.conn = nil
			end
		end)
	end

	if skillType == "Voxels" then
		-- specials join as {Part = ...} wrappers → real meshes sink too
		local list = {}
		-- new path: binary buffer. fallback: raw table (legacy senders)
		if argumentData.voxelBuffer then
			for _, snap in VoxelSerializer.decode(argumentData.voxelBuffer) do
				table.insert(list, snap)
			end
		elseif argumentData.voxelList then
			for _, snap in argumentData.voxelList do
				table.insert(list, snap)
			end
		end
		if argumentData.specialParts then
			for _, part in argumentData.specialParts do
				if typeof(part) == "Instance" and part:IsA("BasePart") then
					table.insert(list, { Part = part })
				end
			end
		end
		if #list > 0 then
			absorbVoxelList(list, argumentData.targetAttachment)
		end

		-- Pick up the glass shards FractureGlass already scattered nearby. They are
		-- CLIENT-ONLY parts (RenderGlass builds them per-client in workspace.Terrain),
		-- so the server never saw them — grabbing them has to happen here. Small delay
		-- so this-absorb's shatter fragments have spawned before we scan.
		local targetAttachment = argumentData.targetAttachment
		if targetAttachment then
			if not targetAttachment.Parent then
				return
			end
			local center = targetAttachment.WorldPosition
			local params = OverlapParams.new()
			params.FilterType = Enum.RaycastFilterType.Include
			params.FilterDescendantsInstances = { workspace.Terrain }
			local glassList = {}
			for _, frag in workspace:GetPartBoundsInBox(CFrame.new(center), Vector3.new(60, 60, 60), params) do
				if frag.Name == "GlassFragment" then
					table.insert(glassList, { Piece = frag })
				end
			end
			if #glassList > 0 then
				absorbVoxelList(glassList, targetAttachment)
			end
		end
	end
end
