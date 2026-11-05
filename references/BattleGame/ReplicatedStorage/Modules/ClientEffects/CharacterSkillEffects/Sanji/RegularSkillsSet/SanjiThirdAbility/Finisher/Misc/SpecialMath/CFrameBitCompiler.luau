 
local v1 = {}
local u2 = math.rad
local u3 = math.deg
local u4 = math.round
local u5 = CFrame.fromOrientation
local u6 = CFrame.new
local u7 = Vector3.new
local u8 = buffer.create
local u9 = buffer.writef32
local u10 = buffer.writei16
local u11 = buffer.readf32
local u12 = buffer.readi16
function v1.compressCFrame(p13)
	-- upvalues: (copy) u8, (copy) u9, (copy) u3, (copy) u4, (copy) u10
	local v14 = p13.Position
	local v15 = u8(18)
	u9(v15, 0, v14.X)
	u9(v15, 4, v14.Y)
	u9(v15, 8, v14.Z)
	local v16, v17, v18 = p13:ToOrientation()
	local v19 = u3(v16)
	local v20 = u3(v17)
	local v21 = u3(v18)
	u10(v15, 12, (u4(v19 * 100)))
	u10(v15, 14, (u4(v20 * 100)))
	u10(v15, 16, (u4(v21 * 100)))
	return v15
end
function v1.decompressCFrame(p22)
	-- upvalues: (copy) u11, (copy) u7, (copy) u6, (copy) u5, (copy) u12, (copy) u2
	return u6((u7(u11(p22, 0), u11(p22, 4), (u11(p22, 8))))) * u5(u2(u12(p22, 12) / 100), u2(u12(p22, 14) / 100), (u2(u12(p22, 16) / 100)))
end
return v1