 
  
local RunService = game:GetService("RunService")
local v1 = require("../mod/tween")
local v2 = require("../mod/utility")
local v3 = require("../pkg/Shake")
local t = {}
local identity = CFrame.identity
local function updateCamera() --[[ updateCamera | Line: 11 | Upvalues: t (ref), RunService (copy), identity (ref) ]]
	if #t == 0 then
		return
	end
	local CurrentCamera = workspace.CurrentCamera
	if not RunService:IsRunning() then
		CurrentCamera.CFrame = CurrentCamera.CFrame * identity:Inverse()
		local v1 = CurrentCamera.CFrame
		local v2, v3 = v1:ToOrientation()
		CurrentCamera.CFrame = CFrame.new(v1.Position) * CFrame.fromOrientation(v2, v3, 0)
	end
	local identity_2 = CFrame.identity
	local sum = Vector3.new(0, 0, 0)
	local t2 = {}
	for v4, v5 in t do
		if not v5.done then
			sum = sum + v5.pos
			identity_2 = identity_2 * CFrame.Angles(v5.rot.x, v5.rot.y, v5.rot.z)
			table.insert(t2, v5)
		end
	end
	t = t2
	local v6 = CFrame.new(sum) * identity_2
	if not RunService:IsRunning() then
		identity = v6
	end
	CurrentCamera.CFrame = CurrentCamera.CFrame * v6
end
local t2 = {}
local v4 = nil
local v5 = nil
function t2.init() --[[ init | Line: 61 | Upvalues: v4 (ref), RunService (copy), v5 (ref), updateCamera (copy) ]]
	if v4 then
		return
	end
	if not RunService:IsRunning() then
		RunService:BindToRenderStep("forge_updateCameraShake", Enum.RenderPriority.Last.Value + 1, updateCamera)
		return
	end
	v4 = RunService.Heartbeat:Connect(function() --[[ Line: 67 | Upvalues: v5 (ref) ]]
		if v5 then
			workspace.CurrentCamera.CFrame = v5
		end
	end)
	RunService:BindToRenderStep("forge_updateCameraShake", Enum.RenderPriority.Last.Value + 1, updateCamera)
end
function t2.deinit() --[[ deinit | Line: 79 | Upvalues: v4 (ref), RunService (copy) ]]
	if not v4 then
		RunService:UnbindFromRenderStep("forge_updateCameraShake")
		return
	end
	v4:Disconnect()
	v4 = nil
	RunService:UnbindFromRenderStep("forge_updateCameraShake")
end
function t2.emit(p1, p2) --[[ emit | Line: 88 | Upvalues: v2 (copy), v3 (copy), v1 (copy), RunService (copy), t (ref), v5 (ref) ]]
	local v12 = v2.getAttribute(p1, "EmitDelay", 0)
	local v22 = v2.getAttribute(p1, "EmitDuration", 0)
	local v32 = v2.getAttribute(p1, "Falloff", 30)
	local v4 = v2.getAttribute(p1, "Amplitude", 2.5)
	local v52 = v2.getAttribute(p1, "Frequency", 0.2)
	local v6 = v2.getAttribute(p1, "FadeInTime", 0.3)
	local v7 = v2.getAttribute(p1, "FadeOutTime", 2)
	local v8 = v2.getAttribute(p1, "SustainTime", 1)
	local v9 = v2.getAttribute(p1, "PositionInfluence", Vector3.new(1, 1, 1))
	local v10 = v2.getAttribute(p1, "RotationInfluence", Vector3.new(0.2, 0.2, 0.2))
	local v11 = v2.getAttribute(p1, "Speed_Start", 1)
	local v122 = v2.getAttribute(p1, "Speed_End", 1)
	local v13 = if v22 > 0 then true else false
	local v14 = v3.new()
	v14.Sustain = v13
	v14.Amplitude = v4
	v14.Frequency = v52
	v14.FadeInTime = v6
	v14.FadeOutTime = v7
	v14.SustainTime = v8
	v14.PositionInfluence = v9
	v14.RotationInfluence = v10
	local v15 = 1
	local v16 = 0
	function v14.TimeFunction() --[[ Line: 123 | Upvalues: v16 (ref) ]]
		return v16
	end
	if v11 ~= v122 then
		speedTween = v1.fromParams(v2.getAttribute(p1, "Speed_Curve", v2.default_bezier), v2.getAttribute(p1, "Speed_Duration", 0.1), function(p1, p2) --[[ Line: 131 | Upvalues: v15 (ref), v2 (ref), v11 (copy), v122 (copy) ]]
			v15 = v2.lerp(v11, v122, p1)
			return p2
		end)
		table.insert(p2, speedTween)
	end
	local function f18(p1) --[[ Line: 142 | Upvalues: v16 (ref), v15 (ref) ]]
		v16 = v16 + p1 * v15
	end
	table.insert(p2, RunService.RenderStepped:Connect(f18))
	local t2 = {
		done = false,
		pos = Vector3.new(0, 0, 0),
		rot = Vector3.new(0, 0, 0)
	}
	task.wait(v12)
	table.insert(t, t2)
	local v20 = coroutine.running()
	v14:BindToRenderStep(v3.NextRenderName(), v2.RENDER_PRIORITY + p2.depth, function(p12, p2, p3) --[[ Line: 159 | Upvalues: v5 (ref), p1 (copy), v32 (copy), t2 (copy), v20 (copy) ]]
		local CurrentCamera = workspace.CurrentCamera
		v5 = CurrentCamera.CFrame
		local v1 = p1:FindFirstAncestorOfClass("Attachment") or p1:FindFirstAncestorWhichIsA("BasePart")
		if v1 then
			local v4 = 1 - math.clamp((CurrentCamera.CFrame.Position - (v1:IsA("Attachment") and v1.WorldPosition or v1.Position)).Magnitude / v32, 0, 1)
			p12 = p12 * v4
			p2 = p2 * v4
		end
		t2.pos = p12
		t2.rot = p2
		t2.done = p3
		if not p3 then
			return
		end
		v5 = nil
		task.spawn(v20)
	end)
	v14:Start()
	if v13 then
		task.wait(v22)
		v14:StopSustain()
	end
	if t2.done then
		return
	end
	coroutine.yield()
end
return t2