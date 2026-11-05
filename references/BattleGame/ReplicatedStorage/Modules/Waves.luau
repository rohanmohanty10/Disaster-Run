--!native
--!optimize 2

local u1 = {}
game:GetService("ReplicatedStorage")
local function u28(p2, p3, p4) -- name: solveWave
	local v5 = p2.k
	local v6 = p2.amp
	local v7 = p2.dir
	local v8 = v5 * (vector.dot(p3, v7) - p2.c * (p4 * p2.speed))
	local v9 = math.sin(v8)
	local v10 = math.cos(v8)
	local v11 = p2.steepness * v9
	local v12 = p2.steepness * v10
	local v13 = vector.create(v11, v12, v11)
	local v14 = p2.dir.x
	local v15 = p2.dir.z
	local v16 = v14 * v6 * v10
	local v17 = v6 * v9
	local v18 = v15 * v6 * v10
	local v19 = vector.create(v16, v17, v18)
	local v20 = v14 * v14
	local v21 = v14 * v15
	local v22 = vector.create(v20, v14, v21) * v13
	local v23 = v14 * v15
	local v24 = v15 * v15
	local v25 = vector.create(v23, v15, v24) * v13
	local v26 = v14 * v10
	local v27 = v15 * v10
	return v19, v22, v25, vector.create(v26, v11, v27)
end
function newWave(p29, p30, p31, p32) -- name: newWave
	local v33 = 6.283185307179586 / p31
	local v34 = 9.8 / v33
	local v35 = math.sqrt(v34)
	local v36 = v33 * p30
	local v37 = p29.X
	local v38 = p29.Y
	local v39 = vector.create(v37, 0, v38)
	return {
		["dir"] = vector.normalize(v39) * 0.98,
		["k"] = v33,
		["c"] = v35,
		["speed"] = p32,
		["amp"] = p30,
		["steepness"] = v36
	}
end
local u40 = { newWave(Vector2.new(-0.594, -0.803), 0.45, 18.23, 1.323), newWave(Vector2.new(0.62, -0.34), 0.5, 33.2, 0.987), newWave(Vector2.new(-0.9, 0.11), 2, 99.1, 0.421) }
local u41 = #u40
u1.waves = u40
function u1.getWaveAt(p42, p43) -- name: getWaveAt
	-- upvalues: (copy) u40, (copy) u28, (copy) u41
	local v44 = p42.X
	local v45 = p42.Z
	local v46 = vector.create(v44, 0, v45)
	local v47 = Vector3.new(0, 0, 0)
	local v48 = Vector3.new(0, 0, 0)
	local v49 = Vector3.new(0, 0, 0)
	local v50 = Vector3.new(0, 1, 0)
	for _, v51 in u40 do
		local v52, v53, v54, v55 = u28(v51, v46, p43)
		v47 = v47 + v52
		v48 = v48 + v53
		v49 = v49 + v54
		v50 = v50 + v55
	end
	local v56 = v48 / u41
	local v57 = v49 / u41
	local v58 = v50 / u41
	local v59 = 1 - v56.x
	local v60 = v56.y
	local v61 = -v56.z
	local v62 = vector.create(v59, v60, v61)
	local v63 = vector.normalize(v62)
	local v64 = v63 + (Vector3.new(1, 0, 0) - v63) * 0.19999999999999996
	local v65 = -v57.x
	local v66 = v57.y
	local v67 = 1 - v57.z
	local v68 = vector.create(v65, v66, v67)
	local v69 = vector.normalize(v68)
	local v70 = v69 + (Vector3.new(0, 1, 0) - v69) * 0.19999999999999996
	local v71 = -v58.x
	local v72 = v58.y
	local v73 = -v58.z
	local v74 = vector.create(v71, v72, v73)
	local v75 = vector.normalize(v74)
	local v76 = v75 + (Vector3.new(0, 0, 1) - v75) * 0.19999999999999996
	return CFrame.fromMatrix(v47, v64, v70, v76)
end
function u1.getWaveHeightAt(p77, p78) -- name: getWaveHeightAt
	-- upvalues: (copy) u1
	return u1.getWaveAt(p77, p78).Y
end
function u1.batchWaveAt(p79, ...) -- name: batchWaveAt
	-- upvalues: (copy) u1
	local v80 = {}
	for _, v81 in { ... } do
		local v82 = u1.getWaveAt
		table.insert(v80, v82(v81, p79))
	end
	return unpack(v80)
end
function u1.batchWaveHeightAt(p83, ...) -- name: batchWaveHeightAt
	-- upvalues: (copy) u1
	local v84 = {}
	for _, v85 in { ... } do
		local v86 = u1.getWaveHeightAt
		table.insert(v84, v86(v85, p83))
	end
	return unpack(v84)
end
function u1.sampleWaveHeightAt(p87, ...) -- name: sampleWaveHeightAt
	-- upvalues: (copy) u1
	local v88 = { ... }
	local v89 = 0
	for _, v90 in v88 do
		v89 = v89 + u1.getWaveHeightAt(v90, p87)
	end
	return v89 / #v88
end
function u1.getWaveHeightAround(p91, p92, p93) -- name: getWaveHeightAround
	-- upvalues: (copy) u1
	local v94 = p93 or 2
	assert(v94)
	return u1.sampleWaveHeightAt(p92, p91 + Vector3.new(1, 0, 0) * v94, p91 + Vector3.new(0, 0, 1) * v94, p91 + Vector3.new(1, 0, 0) * -v94, p91 + Vector3.new(0, 0, 1) * -v94)
end
return u1