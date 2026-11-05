 
  
local v1 = require("../mod/tween")
local v2 = require("../mod/utility")
return {
	emit = function(p1, p2) --[[ emit | Line: 6 | Upvalues: v2 (copy), v1 (copy) ]]
		local v12 = v2.getAttribute(p1, "SpinRotation", Vector3.new(0, 0, 0), true) * v2.DEG_TO_RAD
		local v22 = v2.getAttribute(p1, "Scale_Start", 1, true)
		local v3 = v2.getAttribute(p1, "Scale_End", 1, true)
		if v12 == Vector3.new(0, 0, 0) and (v22 == 1 and v3 == 1) then
			return
		end
		local v4 = v2.getAttribute(p1, "EmitDelay", 0)
		local v5 = v2.getAttribute(p1, "SyncPosition", false)
		local v6 = v2.getAttribute(p1, "SpinDuration", 0.5)
		local v7 = v2.getAttribute(p1, "SpinSpeed_Duration", 0.1)
		local v8 = v2.getAttribute(p1, "SpinSpeed_Start", 0)
		local v9 = v2.getAttribute(p1, "SpinSpeed_End", 1)
		local v10 = v8
		task.wait(v4)
		local v11
		if v8 == v9 then
			v11 = nil
		else
			v11 = v1.fromParams(v2.getAttribute(p1, "SpinSpeed_Curve", v2.default_bezier), v7, function(p1, p2) --[[ Line: 36 | Upvalues: v10 (ref), v2 (ref), v8 (copy), v9 (copy) ]]
				v10 = v2.lerp(v8, v9, p1)
				return p2
			end)
			table.insert(p2, v11)
		end
		local v122 = p1:GetPivot()
		local v13 = p1:GetScale()
		if v22 == v3 then
			p1:ScaleTo(v22)
		else
			local v14 = v2.getAttribute(p1, "Scale_Curve", v2.default_bezier)
			local function f15(p12, p2) --[[ Line: 54 | Upvalues: p1 (copy), v2 (ref), v22 (copy), v3 (copy) ]]
				p1:ScaleTo(v2.lerp(v22, v3, p12))
				return p2
			end
			table.insert(p2, v1.fromParams(v14, v6, f15))
		end
		local v16 = p1:FindFirstAncestorOfClass("Attachment") or p1:FindFirstAncestorWhichIsA("BasePart")
		table.insert(p2, function() --[[ Line: 66 | Upvalues: p1 (copy), v16 (copy), v122 (copy), v13 (copy) ]]
			p1:PivotTo(v16 and (v16:IsA("Attachment") and v16.WorldCFrame or v16.CFrame) or v122)
			p1:ScaleTo(v13)
		end)
		local v17 = v12 * v6
		v1.timer(v6, function(p12, p2) --[[ Line: 73 | Upvalues: v6 (copy), v17 (ref), v16 (copy), v5 (copy), v122 (copy), p1 (copy), v10 (ref), v11 (ref) ]]
			local v2 = v17 * math.clamp(p2 / v6, 0, 1)
			local v3 = if v16 and v5 then v16:IsA("Attachment") and v16.WorldCFrame or v16.CFrame else v122
			p1:PivotTo(v3 * CFrame.fromOrientation(v2.x, v2.y, v2.z))
			if v10 > 0 or p2 > 0 and v11.Connected then
				return p12 * v10
			else
				return nil
			end
		end, v11, p2, v2.RENDER_PRIORITY + p2.depth)
	end
}