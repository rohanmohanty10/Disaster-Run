--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Luffy/LuffyBazooka
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- everything lives under this ModuleScript
local AttachStretch = require(script.AttachStretch)

-- R6: one part per arm
local LimbMap = {
	Right = { "Right Arm" },
	Left  = { "Left Arm"  },
}

local function setLimbVisible(char, key, transparency)
	for _, limbName in LimbMap[key] do
		local limb = char:FindFirstChild(limbName)
		if limb then limb.Transparency = transparency end
	end
end

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

	----------------------------------------------------------------
	if skillType == "prep" then
		-- spawn the gum arms via the R6 AttachStretch, then stretch back
		AttachStretch(attacker, "RightArm")
		AttachStretch(attacker, "LeftArm")

		local GumRight = attacker:WaitForChild("GumRight", 5)
		local GumLeft  = attacker:WaitForChild("GumLeft", 5)
		if not GumRight or not GumLeft then return end

		setLimbVisible(attacker, "Left", 1)
		setLimbVisible(attacker, "Right", 1)
		GumRight.Transparency = 0
		GumLeft.Transparency = 0

		-- stretch the arm bones back (windup)
		_G.tween(GumRight.Extend, {0.5, "EntranceExpressive", Enum.EasingDirection.Out, 0, false, 0}, { Position = Vector3.new(0, -15, 0) })
		_G.tween(GumLeft.Extend2, {0.5, "EntranceExpressive", Enum.EasingDirection.Out, 0, false, 0}, { Position = Vector3.new(0, -15, 0) })

		--_G.PlaySound(hrp, script.BazookaStart)

		----------------------------------------------------------------
	elseif skillType == "start" then
		local GumRight = attacker:WaitForChild("GumRight", 5)
		local GumLeft  = attacker:WaitForChild("GumLeft", 5)
		if not GumRight or not GumLeft then return end

		-- pull/charge to loaded position
		_G.tween(GumRight.Extend, {0.45, "UWPAccelerate", Enum.EasingDirection.In, 0, false, 0}, { Position = Vector3.new(-0.013, -0.575, 0.006) })
		_G.tween(GumLeft.Extend2, {0.45, "UWPAccelerate", Enum.EasingDirection.In, 0, false, 0}, { Position = Vector3.new(-0.011, -0.574, 0.006) })

		----------------------------------------------------------------
	elseif skillType == "shoot" then
		local GumRight = attacker:WaitForChild("GumRight", 5)
		local GumLeft  = attacker:WaitForChild("GumLeft", 5)
		if not GumRight or not GumLeft then return end

		-- thrust forward
		_G.tween(GumRight.Extend, {0.25, "EntranceExpressive", Enum.EasingDirection.Out, 0, false, 0}, { Position = Vector3.new(0, -40, 0) })
		_G.tween(GumLeft.Extend2, {0.25, "EntranceExpressive", Enum.EasingDirection.Out, 0, false, 0}, { Position = Vector3.new(0, -40, 0) })

		----------------------------------------------------------------
	elseif skillType == "end" then
		local GumRight = attacker:WaitForChild("GumRight", 5)
		local GumLeft  = attacker:WaitForChild("GumLeft", 5)
		if not GumRight or not GumLeft then return end

		local target = hrp.CFrame * CFrame.new(-1, 0, -1) * CFrame.Angles(-1.51, 0, 0)

		-- retract toward the body
		_G.tween(GumRight.Extend, {0.285, "UWPAccelerate", Enum.EasingDirection.In, 0, false, 0}, { WorldCFrame = target })
		_G.tween(GumLeft.Extend2, {0.285, "UWPAccelerate", Enum.EasingDirection.In, 0, false, 0}, { WorldCFrame = target })

		----------------------------------------------------------------
	elseif skillType == "reset" then
		local GumRight = attacker:FindFirstChild("GumRight")
		local GumLeft  = attacker:FindFirstChild("GumLeft")
		setLimbVisible(attacker, "Left", 0)
		setLimbVisible(attacker, "Right", 0)
		if GumRight then GumRight:Destroy() end
		if GumLeft  then GumLeft:Destroy()  end
	end
end