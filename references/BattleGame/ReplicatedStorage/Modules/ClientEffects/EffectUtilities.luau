local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--local LocalConfigFolder = LocalPlayer:FindFirstChild("Configuration") or LocalPlayer:WaitForChild("Configuration", 10)

local Utility = {
	Tween = function(instance, tweenInfo, properties)
		local tween = TweenService:Create(instance, tweenInfo, properties)
		tween:Play()
		task.delay(tweenInfo.Time, function()
			tween:Destroy()
		end)
		return tween
	end,

	Debris = function(instance, duration)
		task.delay(duration, function()
			instance:Destroy()
		end)
	end,

	FrameToTime = function(frameCount, fps)
		return frameCount / (fps or 60)
	end
}

local RayParams = RaycastParams.new()
RayParams.FilterType = Enum.RaycastFilterType.Include
RayParams.FilterDescendantsInstances = {
	workspace.World.Map,
}

local function numberAttr(inst, name, default)
	local v = inst:GetAttribute(name)
	if v == nil then
		return default
	end
	if typeof(v) ~= "number" then
		warn(("[Utility.Emit] %s.%s is %s, not a number — skipping"):format(
			inst:GetFullName(), name, typeof(v)))
		return nil
	end
	return v
end

local function enableFor(instance, duration)
	instance.Enabled = true
	task.delay(duration, function()
		if instance.Parent then
			instance.Enabled = false
		end
	end)
end

Utility.EmitOneParticle = function(descendant)
	if descendant:IsA("ParticleEmitter") then
		local emitCount    = numberAttr(descendant, "EmitCount", 0)
		local emitDelay    = numberAttr(descendant, "EmitDelay", 0)
		local emitDuration = numberAttr(descendant, "EmitDuration", 0)

		if emitCount == nil or emitDelay == nil or emitDuration == nil then
			return
		end

		task.delay(emitDelay, function()
			if not descendant.Parent then return end

			if emitCount > 0 then
				descendant:Emit(emitCount)
			end

			if emitDuration > 0 then
				enableFor(descendant, emitDuration)
			else
				descendant.Enabled = false
			end
		end)

	elseif descendant:IsA("Trail") or descendant:IsA("Beam") then
		local emitDelay    = descendant:GetAttribute("EmitDelay") or 0
		local emitDuration = descendant:GetAttribute("EmitDuration") or 0

		task.delay(emitDelay, function()
			if not descendant.Parent then return end

			if emitDuration > 0 then
				enableFor(descendant, emitDuration)
			else
				descendant.Enabled = false
			end
		end)
	end
end

Utility.Emit = function(container)
	task.spawn(function()
		for _, descendant in container:GetDescendants() do
			if descendant:IsA("ParticleEmitter") then
				local emitCount    = numberAttr(descendant, "EmitCount", 0)
				local emitDelay    = numberAttr(descendant, "EmitDelay", 0)
				local emitDuration = numberAttr(descendant, "EmitDuration", 0)

				-- any wrong-typed attribute → skip this emitter (already warned)
				if emitCount == nil or emitDelay == nil or emitDuration == nil then
					continue
				end

				task.delay(emitDelay, function()
					if not descendant.Parent then return end

					if emitCount > 0 then
						descendant:Emit(emitCount)
					end

					if emitDuration > 0 then
						enableFor(descendant, emitDuration)
					else
						descendant.Enabled = false
					end
				end)

			elseif descendant:IsA("Trail") or descendant:IsA("Beam") then
				local emitDelay    = descendant:GetAttribute("EmitDelay") or 0
				local emitDuration = descendant:GetAttribute("EmitDuration") or 0

				task.delay(emitDelay, function()
					if not descendant.Parent then return end

					if emitDuration > 0 then
						enableFor(descendant, emitDuration)
					else
						descendant.Enabled = false
					end
				end)
			end
		end
	end)
end

Utility.ToggleVFX = function(container, state)
	for _, vfx in container:GetDescendants() do
		if vfx:IsA("ParticleEmitter") or vfx:IsA("Trail") then
			vfx.Enabled = state
		end
	end
end

Utility.Highlight = function(model, options)
	local existingHighlight = model:FindFirstChildWhichIsA("Highlight")
	if existingHighlight then
		existingHighlight:Destroy()
	end

	local highlight = Instance.new("Highlight")
	highlight.Parent = model
	highlight.FillColor = options.FillColor or Color3.fromRGB(255, 255, 255)
	highlight.OutlineColor = options.OutlineColor or Color3.fromRGB(255, 255, 255)
	highlight.FillTransparency = options.FillTransparency or 0
	highlight.OutlineTransparency = options.OutlineTransparency or 0
	highlight.DepthMode = options.HighlightDepthMode or Enum.HighlightDepthMode.Occluded
	return highlight
end

Utility.vfxTween = function(effectModel, tweenInfo)
	local startPart = effectModel:FindFirstChild("Start")
	local endPart = effectModel:FindFirstChild("End")

	Utility.Tween(startPart, tweenInfo, {
		Size = endPart.Size,
		CFrame = endPart.CFrame,
		Color = endPart.Color,
		Transparency = endPart.Transparency
	})

	endPart.Transparency = 1

	for _, child in pairs(startPart:GetChildren()) do
		if child:IsA("SpecialMesh") then
			local mesh = endPart:FindFirstChild("Mesh")
			if mesh then
				Utility.Tween(child, tweenInfo, {
					Scale = mesh.Scale
				})
			end
		elseif child:IsA("Decal") and endPart:FindFirstChildWhichIsA("Decal") then
			local decal = endPart.Decal
			Utility.Tween(child, tweenInfo, {
				Transparency = decal.Transparency,
				Color3 = decal.Color3
			})
		end
	end

	if endPart:FindFirstChild("Decal") then
		endPart.Decal.Transparency = 1
	end

	task.delay(tweenInfo.Time, function()
		endPart.Transparency = 1
		startPart.Transparency = 1
		local highlight = startPart:FindFirstChildWhichIsA("Highlight")
		if highlight then
			highlight:Destroy()
		end
	end)
end

local function FastModeOn(): boolean
	local Folder = LocalPlayer:FindFirstChild("Configuration")
	local Value: any = Folder and Folder:FindFirstChild("Fast Mode")
	return Value ~= nil and Value.Value == true
end
Utility.CheckRenderDistance = function(targetLocation, override)
	local cam = workspace.CurrentCamera
	if not cam then return false end

	local limit = override
	if not limit then
		if UserInputService.TouchEnabled then
			limit = 600
		elseif FastModeOn() then
			limit = 400
		else
			limit = 1024
		end
	end

	local pos = (typeof(targetLocation) == "CFrame") and targetLocation.Position or targetLocation
	return (pos - cam.CFrame.Position).Magnitude <= limit
end

return Utility