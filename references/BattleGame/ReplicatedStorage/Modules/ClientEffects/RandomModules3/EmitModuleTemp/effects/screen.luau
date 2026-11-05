 
  
local RunService = game:GetService("RunService")
local v1 = require("../mod/utility")
return {
	emit = function(p1, p2) --[[ emit | Line: 7 | Upvalues: v1 (copy), RunService (copy) ]]
		if not p1:GetAttribute("Enabled") then
			return
		end
		local v12 = v1.getAttribute(p1, "PartScale", Vector3.new(1, 1, 1))
		local v2 = v1.getAttribute(p1, "PartDistance", 1.5)
		local v3 = v1.getAttribute(p1, "OffsetPosition", Vector3.new(0, 0, 0))
		local v4 = v1.getAttribute(p1, "OffsetRotation", Vector3.new(0, 0, 0)) * v1.DEG_TO_RAD
		local v5 = p1.CFrame
		local Size = p1.Size
		local CollisionGroup = p1.CollisionGroup
		p1.CollisionGroup = "ForgeMouseIgnore"
		table.insert(p2, function() --[[ Line: 24 | Upvalues: p1 (copy), Size (copy), v5 (copy), CollisionGroup (copy) ]]
			p1.Size = Size
			p1.CFrame = v5
			p1.CollisionGroup = if CollisionGroup == "" then "Default" else CollisionGroup or "Default"
		end)
		local function frame() --[[ frame | Line: 31 | Upvalues: v2 (copy), p1 (copy), v12 (copy), v3 (copy), v4 (copy) ]]
			local CurrentCamera = workspace.CurrentCamera
			local v32 = math.tan((math.rad(CurrentCamera.FieldOfView / 2))) * v2 * 2
			local v5 = CurrentCamera.CFrame * CFrame.new(0, 0, -v2)
			p1.Size = Vector3.new(CurrentCamera.ViewportSize.X / CurrentCamera.ViewportSize.Y * v32, v32, p1.Size.Z) * v12
			p1.CFrame = v5 * CFrame.new(v3) * CFrame.fromOrientation(v4.x, v4.y, v4.z)
		end
		if RunService:IsRunning() then
			local v6 = v1.getRanomId()
			RunService:BindToRenderStep(v6, v1.RENDER_PRIORITY + p2.depth, frame)
			local function f7() --[[ Line: 51 | Upvalues: RunService (ref), v6 (copy) ]]
				RunService:UnbindFromRenderStep(v6)
			end
			table.insert(p2, f7)
		else
			table.insert(p2, RunService.RenderStepped:Connect(frame))
		end
	end
}