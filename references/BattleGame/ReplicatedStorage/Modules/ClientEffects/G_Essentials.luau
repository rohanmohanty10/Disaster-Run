-- Essentials.lua → ReplicatedStorage/Modules/Essentials  (this is your `Ess` / _G.Ess)
-- General effect/util helpers: tweening, cleanup, debug rays, particle/beam toggles, hitboxes.

local TweenService = game:GetService("TweenService")

--local RotatedRegion3 = require(game.ReplicatedStorage.Modules.RotatedRegion3)

-- Shared raycast filter: only world geometry (Islands + Env), ignore water.
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.World.Map }
raycastParams.IgnoreWater = true

local BoatTween = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)

-- Live tween per instance, so two tweens on the same property don't fight:
--   [instance] = { tween, goal }
local activeTweens = {}


local Essentials = {}

Essentials.RaycastParams = raycastParams
--Essentials.Mouse = require(script.Mouse)

-- Draws a debug line (a thin part) between two points/parts, parented to workspace.Effects.
--   from / to : Vector3 or a part (its .Position is used)
--   color     : optional, defaults to white
function Essentials.DrawRay(from, to, color)
	local fromPos = typeof(from) == "Vector3" and from or from.Position
	local toPos   = typeof(to)   == "Vector3" and to   or to.Position
	local length = (toPos - fromPos).Magnitude

	local part = Instance.new("Part")
	part.Anchored = true
	part.Color = color or Color3.fromRGB(255, 255, 255)
	part.Locked = true
	part.CanCollide = false
	part.Size = Vector3.new(0.5, 0.5, length)
	part.CFrame = CFrame.new(fromPos, toPos) * CFrame.new(0, 0, -length / 2)
	part.Parent = workspace.Effects
end

-- Toggles .Enabled on every Beam in `container` (an instance, or an array of instances).
function Essentials.BeamToggle(container)
	local items = typeof(container) == "table" and container or container:GetChildren()
	for _, inst in items do
		if inst:IsA("Beam") then
			inst.Enabled = not inst.Enabled
		end
	end
end

-- Creates, plays, and auto-cleans a tween. Returns the Tween and its TweenInfo.
--   instance / tweenInfo (TweenInfo) / goals (property table)
function Essentials.Tween(instance, tweenInfo, goals)
	local tween = TweenService:Create(instance, tweenInfo, goals)
	tween:Play()
	-- Destroy a hair after it finishes (1.05x the duration).
	task.delay(tweenInfo.Time * 1.05, function()
		if tween then
			tween:Destroy()
		end
	end)
	return tween, tweenInfo
end

-- After `delay` seconds, destroys instance(s) / disconnects connection(s).
--   target : an Instance, an RBXScriptConnection, or an array of either
function Essentials.Destroy(target, delay)
	local items = typeof(target) == "table" and target or { target }
	for _, item in items do
		task.delay(delay, function()
			if typeof(item) == "Instance" then
				item:Destroy()
			elseif typeof(item) == "RBXScriptConnection" then
				item:Disconnect()
			end
		end)
	end
end

-- Returns |a / b|.
function Essentials.GetTime(a, b)
	return math.abs(a / b)
end

-- Bursts or toggles ParticleEmitters that are DIRECT CHILDREN of `container`.
-- (Simpler than _G.Emit — no graphics-quality scaling.)
--   burst      : true  -> one-shot Emit(EmitCount) on each emitter
--                false -> toggle .Enabled (bursting if it was off), then back after enableTime
--   enableTime : (burst=false) seconds before toggling back
function Essentials.Emit(container, burst, enableTime)
	if burst then
		for _, child in container:GetChildren() do
			if child:IsA("ParticleEmitter") then
				child:Emit(child:GetAttribute("EmitCount"))
			end
		end
	else
		for _, child in container:GetChildren() do
			if child:IsA("ParticleEmitter") then
				if not child.Enabled then
					child:Emit(child:GetAttribute("EmitCount"))
				end
				child.Enabled = not child.Enabled
				if enableTime then
					task.delay(enableTime, function()
						child.Enabled = not child.Enabled
					end)
				end
			end
		end
	end
end

-- Returns the unique parent models of all parts inside a rotated-region hitbox,
-- or nil if nothing was hit.
--   cframe / size : passed to RotatedRegion3.new
--   whitelist     : instances to test against
function Essentials.CreateHitbox(cframe, size, whitelist)
	local region = RotatedRegion3.new(cframe, size)
	local hits = {}
	for _, part in region:FindPartsInRegion3WithWhiteList(whitelist, 5000) do
		if not table.find(hits, part.Parent) then
			table.insert(hits, part.Parent)
		end
	end
	return hits[1] and hits or nil
end

-- Raycasts against Islands + Env using the module's shared RaycastParams.
function Essentials.Raycast(origin, direction)
	return workspace:Raycast(origin, direction, raycastParams)
end

-- Raycast against a whitelist (Include filter). Accepts a Ray, or anything with .Origin/.Direction.
-- Returns (hitPart, hitPosition, hitNormal) with safe fallbacks when nothing is hit:
--   hitPosition -> the ray's end point,  hitNormal -> (0, 1, 0).
function Essentials.raycastWhitelist(ray, whitelist, respectCanCollide)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = whitelist
	if respectCanCollide == true then
		params.RespectCanCollide = true
	end

	local result = workspace:Raycast(ray.Origin, ray.Direction, params)

	local part     = result and result.Instance
	local position = result and result.Position or (ray.Origin + ray.Direction)
	local normal   = result and result.Normal
	if normal == nil or normal == Vector3.zero then
		normal = Vector3.new(0, 1, 0)
	end
	return part, position, normal
end

-- Raycast ignoring a list of instances (legacy API — still works, but deprecated).
function Essentials.raycastIgnoreList(ray, ignoreList)
	if typeof(ray) ~= "Ray" then
		ray = Ray.new(ray.Origin, ray.Direction)
	end
	return workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
end

function Essentials.BoatTween(instance, info, goal, stepType, forceRestart)
	-- Force-restart: drop whatever is currently tweening this instance.
	if forceRestart ~= nil and activeTweens[instance] then
		local old = activeTweens[instance][1]
		old:Stop()
		old:Destroy()
		activeTweens[instance] = nil
	end

	-- Otherwise, only cancel the existing tween if the new goal shares a property with it.
	pcall(function()
		local existing = activeTweens[instance]
		if existing then
			local oldTween, oldGoal = existing[1], existing[2]
			local conflict = false
			for property in goal do
				if oldGoal[property] then
					conflict = true
				end
			end
			if conflict then
				oldTween:Stop()
				oldTween:Destroy()
				activeTweens[instance] = nil
			end
		end
	end)

	-- BoatTween wants string easing names; accept strings or Enums.
	local easingStyle = info[2]
	if typeof(easingStyle) ~= "string" then
		easingStyle = string.gsub(tostring(easingStyle), "Enum.EasingStyle.", "")
	end
	local easingDirection = string.gsub(tostring(info[3]), "Enum.EasingDirection.", "")

	local tween = BoatTween:Create(instance, {
		Time                = info[1],
		EasingStyle         = easingStyle,
		EasingDirection     = easingDirection,
		RepeatCount         = info[4],
		Reverses            = info[5],
		DelayTime           = info[6],
		StepType            = stepType or "Heartbeat",
		CustomEventStepFreq = goal.CustomEventStepFreq,
		Goal                = goal,
	})

	activeTweens[instance] = { tween, goal }
	tween:Play()

	-- Auto-cleanup on completion, or if the instance is destroyed mid-tween.
	if tween and tween.Completed then
		local completedConn
		completedConn = tween.Completed:Connect(function()
			if completedConn then completedConn:Disconnect(); completedConn = nil end
			pcall(function() tween:Destroy() end)
			activeTweens[instance] = nil
			table.clear(goal)
		end)

		instance.Destroying:Once(function()
			if completedConn then completedConn:Disconnect(); completedConn = nil end
			pcall(function() tween:Destroy() end)
			activeTweens[instance] = nil
			table.clear(goal)
		end)
	else
		activeTweens[instance] = nil
	end

	return tween
end


Essentials.Visualize = Essentials.DrawRay -- alias

return Essentials