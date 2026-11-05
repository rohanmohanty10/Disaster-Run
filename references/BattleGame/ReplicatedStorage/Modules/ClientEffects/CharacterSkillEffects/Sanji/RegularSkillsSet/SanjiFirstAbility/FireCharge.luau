--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/FireCharge
-- Charge-up convergence VFX: streaks spawn around the character and curve inward,
-- converging on a target part. Returns a function you call to play it.
--   play(originPart, isFire, minDistance, maxDistance, duration) -> chargeAttachment

local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local GpDestroy = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)

-- Sets up the _G.tween / _G.destroy helpers used below
--require(game:GetService("ReplicatedStorage").Modules.EffectsUtil)


local rng = Random.new()

-- "Main" is the visible streak color, "Side" is the dark outline pass.
local NORMAL_COLORS = {
	Main = Color3.fromRGB(255, 255, 255),
	Side = Color3.new(0, 0, 0),
}
local FIRE_COLORS = {
	Main = Color3.fromRGB(255, 54, 28),
	--Side = Color3.new(0, 0, 0),
	Side = Color3.fromRGB(166, 42, 0),

}

local function lerp(a, b, t)
	return a + (b - a) * t
end
local table1 = {}
local activeTweens = {}
local BoatTween_upvrGPO = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)

local activeTweens = table1
local function GPTween(instance, tweenParams, goalTable, stepType, forceRestart)

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

-- Quadratic Bezier: moves a point from startPos -> endPos, bent toward controlPos.
local function quadBezier(t, startPos, controlPos, endPos)
	return (1 - t) ^ 2 * startPos
		+ 2 * (1 - t) * t * controlPos
		+ t ^ 2 * endPos
end

-- Spawns trail parts that curve inward and converge on `originPart`, for `duration` seconds.
local function spawnTrails(duration, originPart, color, minDistance, maxDistance, emitter)
	local loopStart = os.clock()
	while os.clock() - loopStart < duration do
		task.spawn(function()
			local trailPart = script.TrailPart:Clone()
			trailPart.Parent = workspace.World.Visuals

			-- Randomize the look slightly so the streaks aren't identical
			local trail = trailPart.Trail
			trail.Lifetime = trail.Lifetime + math.random(-100, 100) / 750
			trail.Color = color

			-- Random trail thickness via the two endpoint attachments
			local halfWidth = math.random(200, 600) / 1000
			trailPart.Attachment1.Position = Vector3.new(0,  halfWidth, 0)
			trailPart.Attachment2.Position = Vector3.new(0, -halfWidth, 0)

			-- Random start point in a spherical shell around the origin:
			-- rotate the origin CFrame randomly on all 3 axes, then push out a random distance.
			local randomRotation = CFrame.Angles(
				math.rad(math.random(0, 360)),
				math.rad(math.random(0, 360)),
				math.rad(math.random(0, 360))
			)
			local startPos = (originPart.CFrame
				* randomRotation
				* CFrame.new(0, 0, rng:NextNumber(minDistance, maxDistance))
			).Position

			-- Control point: midpoint between start and origin, jittered, so the path curves.
			local midPoint = lerp(startPos, originPart.Position, 0.5)
			local controlPos = midPoint + Vector3.new(
				math.random(-5, 5),
				math.random(-5, 5),
				math.random(-5, 5)
			)

			local startTime = tick()
			local travelTime = 0.3 + math.random(-100, 100) / 2000
			local endTime   = startTime + travelTime

			-- Fade the trail width to nothing halfway through its life
			task.delay(travelTime / 2, function()
				GPTween(trail, { rng:NextNumber(0.1, 0.2), "Sine", Enum.EasingDirection.Out }, {
					WidthScale = NumberSequence.new(0),
				})
			end)

			local emitted = false
			while tick() < endTime do
				local target = originPart.Position          -- read live so it tracks a moving part
				local alpha  = (tick() - startTime) / travelTime

				trailPart.CFrame = CFrame.new(quadBezier(alpha, startPos, controlPos, target))

				-- Near the end of the path, fire the impact burst once
				if alpha > 0.95 and not emitted then
					--emitted = true
					--if emitter then
					--	emitter.ParticleEmitter:Emit(1)
					--	emitter.lines:Emit(2)
					--	emitter.lines2:Emit(2)
					--end
				end

				RunService.RenderStepped:Wait()
			end

			task.wait(1)
			trailPart:Destroy()
		end)

		-- Stagger based on progress through the duration (accelerates over time)
		local progress = TweenService:GetValue((os.clock() - loopStart) / duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		task.wait(lerp(0.13333333333333333, 0.016666666666666666, progress))
	end
end

-- Play the charge effect on `originPart`.
-- isFire toggles the red "Mera" palette + Mera charge particles.
-- duration = how long streaks keep spawning, in seconds (default 1).
return function(originPart, isFire, minDistance, maxDistance, duration)
	duration = duration or 1
	local palette = isFire and FIRE_COLORS or NORMAL_COLORS

	-- Glowing charge particle attachment in the center
	--local chargeAttachment = isFire
	--	and script.MeraChargeParticles.Attachment:Clone()
	--	or  script.ChargeParticles.Attachment:Clone()
	
	local chargeAttachment = script.MeraChargeParticles.Attachment:Clone()
	chargeAttachment.Parent = originPart

	-- Main colored pass
	task.spawn(function()
		spawnTrails(duration, originPart, ColorSequence.new(palette.Main), minDistance, maxDistance)
	end)

	-- Dark outline pass (this one also drives the impact emitter)
	task.spawn(function()
		spawnTrails(duration, originPart, ColorSequence.new(palette.Side), minDistance, maxDistance, chargeAttachment)
		GpDestroy(chargeAttachment, 1) -- center glow lingers 1s after streaks stop; lower to cut sooner
	end)

	return chargeAttachment
end