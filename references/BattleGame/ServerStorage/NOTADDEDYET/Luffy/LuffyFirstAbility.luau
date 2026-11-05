--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)

local BBEffects = ReplicatedStorage.Assets.Effects.BlackBeard.RegularAbilities
local RNG = Random.new()

local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)


return function(argumentData: any)
    local attacker: Model = argumentData.Attacker
    local skillType = argumentData.SkillType

    local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

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
		if not instance or instance == nil or instance.Parent == nil then return end

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
		activeTweens[instance] = {tween, goalTable}
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
	
	

   

	if skillType == "start" then
		print("Start")
		local Torso = attacker:FindFirstChild("Torso")
		local Arm = attacker:FindFirstChild("Right Arm")

		local source = ReplicatedStorage.Assets.Effects.Luffy.Move1Rework
		local gatlingSound = source.GatlingLoop:Clone()
		gatlingSound.Parent = attacker.Head
		gatlingSound:Play()

		-- Clone spark attachments onto both arms
		local rightArmAttachment = source.Part.Attachment:Clone()
		--rightArmAttachment.Parent = attacker.RightLowerArm
		rightArmAttachment.Parent = attacker["Right Arm"]

		local leftArmAttachment = source.Part.Attachment:Clone()
		--leftArmAttachment.Parent = attacker.LeftLowerArm
		leftArmAttachment.Parent = attacker["Left Arm"]

		-- Track which arm to punch with, alternating each hit
		local useRightArm = true

		local endTime = os.clock() + 4
		repeat
			local rootCFrame = attacker.HumanoidRootPart.CFrame
			local randomX = RNG:NextNumber(-0.25, 0.25)
			local randomTilt = RNG:NextNumber(-0.675, 0.675)

			-- Clone the punch VFX model
			local punchVFX = source.BendyLimb:Clone()
			local punchPart = punchVFX.Punch
			local spurtPart = punchVFX.Spurt
			local linePart = punchVFX.Line

			-- Determine which arm to use and position/color accordingly
			local armColor
			if useRightArm then
				punchVFX:PivotTo(rootCFrame
					* CFrame.new(randomX, 1, -math.random(150, 225) / 100)
					* CFrame.Angles(randomX, randomX, randomTilt)
				)
				armColor = attacker["Right Arm"].Color
				spurtPart.CFrame = attacker["Right Arm"].CFrame * CFrame.Angles(randomTilt, randomTilt, 1.51)
				rightArmAttachment.Spark3:Emit(6)
				rightArmAttachment.ring:Emit(1)
			else
				punchVFX:PivotTo(rootCFrame
					* CFrame.new(randomX, -1, -math.random(150, 225) / 100)
					* CFrame.Angles(randomX, randomX, 3.14 + randomTilt)
				)
				armColor = attacker["Left Arm"].Color
				spurtPart.CFrame = attacker["Left Arm"].CFrame * CFrame.Angles(randomTilt, randomTilt, 1.51)
				leftArmAttachment.Spark3:Emit(6)
				leftArmAttachment.ring:Emit(1)
			end

			-- Override color to black if buso haki is active
			--if attacker:FindFirstChild("BusoMelee") then
			--	armColor = Color3.fromRGB(0, 0, 0)
			--end

			punchPart.Color = armColor
			spurtPart.Color = armColor
			linePart.Color = armColor

			-- Spawn VFX and play animation
			punchVFX.Parent = workspace.World.Debris
			punchVFX.AnimationController:LoadAnimation(punchVFX.Animation):Play(0)

			-- Tween spurt and line meshes outward then destroy
			_G.tween(spurtPart.Mesh, {0.1, "EntranceExpressive", Enum.EasingDirection.Out, 0, false, 0}, {
				Scale = Vector3.new(3, 0.1, 0.1),
				Offset = Vector3.new(-1.5, 0, 0),
			})
			_G.tween(linePart.Mesh, {0.1, "EntranceExpressive", Enum.EasingDirection.Out, 0, false, 0}, {
				Scale = Vector3.new(6, 1, 1),
				Offset = Vector3.new(5, 0, 0),
			})
			GpDestroy(linePart, 0.1)
			GpDestroy(punchVFX, 0.125)

			-- Spawn shockwave effect at a random position near the character
			local shockwaveCFrame = rootCFrame
				* CFrame.Angles(math.pi / 2, 0, 0)
				* CFrame.new(
					math.random(-200, 200) / 100,
					-math.random(100, 300) / 100,
					math.random(-200, 200) / 100
				)
			local shockwaveSize = math.random(500, 1000) / 100

			--_G.PlayEffect("Shockwave2", nil,
			--	shockwaveCFrame * CFrame.new(0, math.random(50, 150) / 100, 0),
			--	shockwaveCFrame,
			--	BrickColor.new("White"),
			--	Vector3.new(shockwaveSize, 0, shockwaveSize),
			--	Vector3.new(shockwaveSize / 4, 0.25, shockwaveSize / 4),
			--	math.random(50, 200) / 1000,
			--	0.8,
			--	Enum.EasingStyle.Quad,
			--	Color3.fromRGB(255, 255, 255),
			--	Enum.Material.Neon,
			--	"Rings"
			--)

			-- Raycast downward to check for ground and update ground smoke effect
			local currentCFrame = attacker.HumanoidRootPart.CFrame
			--local hitPart, hitPosition = _G.raycastWhitelist(
			--	Ray.new(currentCFrame.Position, currentCFrame.UpVector * -15),
			--	--{ workspace.Islands, workspace.Ships }
			--	{ workspace.World.Map }
			--)

			--if hitPart then
			--	-- Position ground effect at floor level and match floor color
			--	groundEffect.CFrame = currentCFrame
			--		* CFrame.new(0, -(currentCFrame.Position - hitPosition).Magnitude, 0)
			--		* CFrame.Angles(math.pi, 0, 0)

			--	local h, s, v = Color3.toHSV(hitPart.Color)
			--	groundEffect.Attachment.sm2.Color = ColorSequence.new(Color3.fromHSV(h, s, v - 0.1))
			--	groundEffect.Attachment.sm2.Enabled = true
			--else
			--	groundEffect.Attachment.sm2.Enabled = false
			--end

			-- Alternate arms each punch
			useRightArm = not useRightArm

			task.wait(0.02)
		until os.clock() >= endTime

		-- Cleanup
		gatlingSound:Destroy()
		GpDestroy(rightArmAttachment, 0.3)
		GpDestroy(leftArmAttachment, 0.3)		
	end
end