 
  
local v1 = require("./utility")
local t = {
	getSurfaceCFrame = function(p1, p2, p3) --[[ getSurfaceCFrame | Line: 7 ]]
		local v3 = CFrame.lookAt(Vector3.new(0, 0, 0), p2, if math.abs((p2:Dot(Vector3.new(0, 1, 0)))) > 0.99 then Vector3.new(0, 0, 1) else Vector3.new(0, 1, 0))
		return p1 * CFrame.new(p3) * v3
	end
}
function t.getPointWithinBox(p1, p2, p3, p4) --[[ getPointWithinBox | Line: 13 | Upvalues: t (copy) ]]
	debug.profilebegin("getPointWithinBox")
	local v1 = Random.new(p1)
	local v4 = Vector3.new(v1:NextNumber(-1, 1), v1:NextNumber(-1, 1), v1:NextNumber(-1, 1)) * (p3 / 2)
	local v5 = t.getSurfaceCFrame(p2, Vector3.FromNormalId(p4), v4)
	debug.profileend()
	return v5
end
function t.getPointOnBox(p1, p2, p3, p4) --[[ getPointOnBox | Line: 34 | Upvalues: t (copy) ]]
	debug.profilebegin("getPointOnBox")
	local v1 = Random.new(p1)
	local v2 = Vector3.FromNormalId(p4)
	local v3 = p3 / 2
	local v4 = Vector3.new(1, 1, 1) - v2:Abs()
	local v8 = t.getSurfaceCFrame(p2, v2, Vector3.new(v1:NextNumber(-1, 1), v1:NextNumber(-1, 1), v1:NextNumber(-1, 1)) * v3 * v4 + v2 * v3)
	debug.profileend()
	return v8
end
function t.getPointWithinCylinder(p1, p2, p3, p4, p5, p6) --[[ getPointWithinCylinder | Line: 58 | Upvalues: v1 (copy) ]]
	debug.profilebegin("getPointWithinCylinder")
	local v12 = Random.new(p1)
	local v3 = math.sqrt((v12:NextNumber(p2, 1)))
	local v4 = v12:NextNumber(0, 6.283185307179586)
	if p6 == Enum.NormalId.Left or p6 == Enum.NormalId.Right then
		p4 = p4 * CFrame.fromOrientation(0, 1.5707963267948966 * (if p6 == Enum.NormalId.Right then -1 else 1), 0)
		p5 = Vector3.new(p5.Z, p5.Y, p5.X)
	elseif p6 == Enum.NormalId.Front or p6 == Enum.NormalId.Back then
		p4 = p4 * CFrame.fromOrientation(0, math.pi, 0)
	end
	local v9 = 1 - v12:NextNumber() ^ v1.lerp(0.5, 1, (math.sqrt(p3)))
	local v10 = v1.lerp(1, p3, v9)
	local v13 = Vector3.new(v9 * 2 - 1, v3 * math.sin(v4) * v10, v3 * math.cos(v4) * v10) * p5 / 2
	local v16 = Vector3.new(0, math.sin(v4) * v10, math.cos(v4) * v10) * p5 / 2
	local v19 = Vector3.new(0, math.cos(v4) * v10, -math.sin(v4) * v10) * p5 / 2
	local v21 = p4 * CFrame.new(v13) * CFrame.lookAt(Vector3.new(0, 0, 0), v16, v19.Magnitude > 0.001 and v19.Unit or p4.UpVector)
	debug.profileend()
	return v21
end
function t.getPointWithinSphere(p1, p2, p3, p4, p5, p6) --[[ getPointWithinSphere | Line: 108 | Upvalues: t (copy) ]]
	debug.profilebegin("getPointWithinSphere")
	local v1 = Random.new(p1)
	local v2 = v1:NextNumber() * 2 * math.pi
	local v4 = math.acos(2 * v1:NextNumber() - 1) * p3
	local v5 = v1:NextNumber(p2, 1) ^ 0.3333333333333333
	local v6 = math.sin(v2)
	local v7 = math.cos(v2)
	local v8 = math.sin(v4)
	local v9 = math.cos(v4)
	local v10 = Vector3.FromNormalId(p6)
	if p6 == Enum.NormalId.Left or p6 == Enum.NormalId.Right then
		p5 = Vector3.new(p5.Z, p5.Y, p5.X)
	elseif p6 == Enum.NormalId.Top or p6 == Enum.NormalId.Bottom then
		p5 = Vector3.new(p5.X, p5.Z, p5.Y)
	end
	local v13 = p5 / 2
	local v14 = t.getSurfaceCFrame(p4, v10, Vector3.new(0, 0, 0))
	local v15 = Vector3.new(v5 * v8 * v7, v5 * v8 * v6, v5 * v9) * v13
	local v16 = Vector3.new(-v8 * v6, v8 * v7, 0) * v13
	local v17 = if v16.Magnitude > 0.001 then v16.Unit else Vector3.new(1, 0, 0)
	local v18 = v14 * CFrame.Angles(0, math.pi, 0) * CFrame.new(v15) * CFrame.lookAt(Vector3.new(0, 0, 0), v15, v17)
	debug.profileend()
	return v18
end
function t.getPointWithinDisc(p1, p2, p3, p4, p5, p6) --[[ getPointWithinDisc | Line: 160 | Upvalues: v1 (copy), t (copy) ]]
	debug.profilebegin("getPointWithinDisc")
	local v12 = Random.new(p1)
	local v2 = Vector3.FromNormalId(p6)
	local v3 = Vector3.new(1, 1, 1) - v2:Abs() * p2
	local v4 = p5 / 2
	local v5 = v12:NextNumber(p2, 1)
	local v6 = v1.lerp(1, 0.5, p3 ^ 4)
	local v7 = v12:NextNumber(1 - p3, 1) ^ v6
	local v8 = v12:NextNumber(0, 6.283185307179586)
	local v11 = Vector3.new(v5 * 2 - 1, v7 * math.sin(v8), v7 * math.cos(v8))
	if p6 == Enum.NormalId.Bottom or p6 == Enum.NormalId.Top then
		v11 = Vector3.new(v11.Z, v11.X, v11.Y)
	elseif p6 == Enum.NormalId.Front or p6 == Enum.NormalId.Back then
		v11 = Vector3.new(v11.Y, v11.Z, v11.X)
	end
	local v14 = t.getSurfaceCFrame(p4, v2, v11 * (v4 * v3) + v2 * p2 * v4)
	debug.profileend()
	return v14
end
return t