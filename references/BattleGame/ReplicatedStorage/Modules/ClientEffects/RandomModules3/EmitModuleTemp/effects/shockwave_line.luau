 
  
local CollectionService = game:GetService("CollectionService")
local v1 = require("../mod/tween")
local v2 = require("../mod/logger")
local v3 = require("../mod/utility")
local v4 = require("../obj/Bezier")
local v5 = require("../pkg/Promise")
require("../obj/ObjectCache")
local v6 = Random.new()
local t = {}
local v7 = nil
function t.init(p1) --[[ init | Line: 17 | Upvalues: v7 (ref) ]]
	v7 = p1
end
function t.deinit() --[[ deinit | Line: 21 | Upvalues: v7 (ref) ]]
	v7 = nil
end
function t.emit(p1, p2, p3) --[[ emit | Line: 25 | Upvalues: v7 (ref), v3 (copy), CollectionService (copy), v1 (copy), v2 (copy), v4 (copy), v6 (copy), v5 (copy) ]]
	if not v7 then
		return
	end
	local v12 = v3.getAttribute(p1, "RayDirection", Vector3.new(0, -50, 0))
	local v22 = v3.getAttribute(p1, "RayCollisionGroup", "Default")
	local v32 = v3.getAttribute(p1, "FilterTag", "")
	local v42 = v3.getAttribute(p1, "FilterType", "Exclude")
	local v52 = v3.getAttribute(p1, "IgnoreWater", true)
	local v62 = v3.getAttribute(p1, "IgnoreCanCollide", false)
	local v72 = RaycastParams.new()
	v72.CollisionGroup = v22
	v72.IgnoreWater = v52
	v72.RespectCanCollide = not v62
	v72.FilterType = Enum.RaycastFilterType[v42]
	v72.FilterDescendantsInstances = CollectionService:GetTagged(v32)
	if v42 == "Exclude" then
		v72:AddToFilter({ workspace.Terrain })
	end
	local v8 = v3.getAttribute(p2, "EmitDelay", 0)
	local v9 = v3.getAttribute(p2, "Rate_Start", 30)
	local v10 = v3.getAttribute(p2, "Rate_End", 30)
	local v11 = v3.getAttribute(p2, "FixedAmount", 0)
	local v122 = v3.getAttribute(p2, "Scale_Start", 1)
	local v13 = v3.getAttribute(p2, "Scale_End", 1)
	local v14 = v3.getAttribute(p2, "Duration", 1)
	local v15 = v3.getAttribute(p2, "Direction", Vector3.new(0, 0, -1))
	local v16 = v3.getAttribute(p2, "Length", 50)
	local v17 = v3.getRangeAttribute(p2, "Rotation", NumberRange.new(-180, 180))
	local v18 = v3.getAttribute(p2, "PartOffset", Vector3.new(0, 0, 0), true)
	local v19 = v3.getAttribute(p2, "BaseOffset", v18)
	local v20 = v3.getAttribute(p2, "Offset_Start", v18)
	local v21 = v3.getAttribute(p2, "Offset_End", v18)
	local v222 = v3.getAttribute(p2, "Offset_Start_Duration", 0.5)
	local v23 = v3.getAttribute(p2, "Offset_End_Duration", 0.5)
	local v24 = v3.getRangeAttribute(p2, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)))
	local v25 = v3.getAttribute(p2, "SizeScaleStart", Vector3.new(0, 0, 0))
	local v26 = v3.getAttribute(p2, "SizeScaleEnd", Vector3.new(0, 0, 0))
	local v27 = v3.getAttribute(p2, "MinSize", Vector3.new(2, 1, 2))
	local v28 = v3.getAttribute(p2, "MaxSize", Vector3.new(3, 2, 3))
	local v29 = v3.getAttribute(p2, "Size_Curve", v3.default_bezier, true)
	local v30 = v3.getAttribute(p2, "Size_Duration", 0.5, true)
	local v31 = v3.getAttribute(p2, "Size_Start_Curve", v29)
	local v322 = v3.getAttribute(p2, "Size_End_Curve", v29)
	local v33 = v3.getAttribute(p2, "Size_Start_Duration", v30)
	local v34 = v3.getAttribute(p2, "Size_End_Duration", v30)
	local v35 = v3.getAttribute(p2, "Transparency_Duration", 0.5)
	local v36 = v3.getAttribute(p2, "Transparency_Start", 0)
	local v37 = v3.getAttribute(p2, "Transparency_End", 0)
	local v38 = v3.getAttribute(p2, "SyncPosition", false)
	local v39 = math.max(v14, 0.001)
	if v11 > 0 then
		local v40 = v11 / v39
		v10 = v40
		v9 = v40
	end
	local Unit = v15.Unit
	if Unit ~= Unit then
		Unit = Vector3.new(-0, -0, -1)
	end
	task.wait(v8)
	local t = {}
	local WorldCFrame = p1.WorldCFrame
	local v41 = 0
	local v422 = 0
	local v43 = v9
	local v44 = v122
	if v122 ~= v13 then
		local v45 = v3.getAttribute(p2, "Scale_Curve", v3.default_bezier)
		local function f46(p1, p2) --[[ Line: 132 | Upvalues: v44 (ref), v3 (ref), v122 (copy), v13 (copy) ]]
			v44 = v3.lerp(v122, v13, p1)
			return p2
		end
		table.insert(p3, v1.fromParams(v45, v39, f46))
	end
	if v9 ~= v10 then
		local v47 = v3.getAttribute(p2, "Rate_Curve", v3.default_bezier)
		local function f48(p1, p2) --[[ Line: 146 | Upvalues: v43 (ref), v3 (ref), v9 (ref), v10 (ref) ]]
			v43 = v3.lerp(v9, v10, p1)
			return p2
		end
		table.insert(p3, v1.fromParams(v47, v39, f48))
	end
	local v49 = v3.getAttribute(p2, "Path_Curve", v3.linear_bezier)
	local v50, v51 = pcall(function() --[[ Line: 156 | Upvalues: v3 (ref), v49 (copy) ]]
		return v3.deserializePath(v49)
	end)
	if not v50 then
		v2.error((("failed to decode bezier path data with error: %*"):format(v51)))
	end
	local v522 = v4.new(v51, 0)
	local fromParams = v1.fromParams
	local linear_bezier = v3.linear_bezier
	local function f53(p12, p22) --[[ Line: 168 | Upvalues: v41 (ref), v43 (ref), v39 (ref), v422 (ref), v522 (copy), v38 (copy), WorldCFrame (ref), p1 (copy), Unit (ref), v16 (copy), v12 (copy), v72 (copy), v6 (ref), v27 (copy), v28 (copy), v3 (ref), v7 (ref), p2 (copy), p3 (copy), v36 (copy), v17 (copy), v20 (copy), v19 (copy), v1 (ref), v222 (copy), v44 (ref), v25 (copy), v31 (copy), v33 (copy), t (copy), v24 (copy), v26 (copy), v322 (copy), v34 (copy), v21 (copy), v23 (copy), v37 (copy), v35 (copy) ]]
		v41 = v41 + p22
		local v13 = 1 / v43
		local v2 = v39 * v43
		if v41 < v13 or v2 <= v422 then
			return p22
		end
		local v32
		for i = 1, v41 // v13 do
			if not (v2 <= v422) then
				v422 = v422 + 1
				local v5 = 1 - v522:getEase((math.clamp(v422 / v2, 0, 1))).y
				if v38 then
					WorldCFrame = p1.WorldCFrame
				end
				local v62 = workspace:Raycast(WorldCFrame.Position + WorldCFrame:VectorToWorldSpace(Unit) * v16 * v5, p1.WorldCFrame:VectorToWorldSpace(v12), v72)
				if not v62 then
					v41 = 0
					return p22
				end
				local v73 = v6:NextNumber(v27.X, v28.X)
				local v8 = v6:NextNumber(v27.Y, v28.Y)
				local v9 = v6:NextNumber(v27.Z, v28.Z)
				local v10 = v3.getRanomId()
				local v11 = v7:get(v10)
				local v122 = v11._getReal()
				v3.copyProperties(p2, v122, v3.COPY_PART_PROPERTIES)
				v3.copyProperties(p2, v122, v3.COPY_EXTENDED_PART_PROPERTIES)
				if #p2:GetChildren() ~= 0 then
					local v132 = p2:Clone()
					for v14, v15 in v132:GetChildren() do
						v15.Parent = v122
					end
					v132:Destroy()
				end
				local v162 = p3
				local function f17() --[[ Line: 229 | Upvalues: v7 (ref), v10 (copy) ]]
					if not v7 then
						return
					end
					v7:free(v10)
				end
				table.insert(v162, f17)
				v11.Color = v62.Instance.Color
				v11.Material = v62.Material
				v11.Transparency = v62.Instance.Transparency
				if v11.Transparency == 0 then
					v11.Transparency = v36
				end
				v11.Size = Vector3.new(0, 0, 0)
				local v18 = v6:NextNumber(v17.Min, v17.Max)
				local Unit_2 = p1.WorldCFrame:VectorToWorldSpace((Vector3.new(-math.cos(v18), 0, -math.sin(v18)))):Cross(v62.Normal).Unit
				local v212 = CFrame.fromMatrix(v62.Position, Unit_2, v62.Normal) * CFrame.fromOrientation(-math.atan(v8 / v9), 0, 0)
				v11.CFrame = CFrame.new(v20) * v212
				local v22 = nil
				local v232 = Vector3.new(0, 0, 0)
				if v20 == v19 then
					v32 = nil
				else
					v32 = v1.fromParams(v3.getAttribute(p2, "Offset_Start_Curve", v3.default_bezier), v222, function(p1, p2) --[[ Line: 267 | Upvalues: v232 (ref), v20 (ref), v19 (ref), v11 (copy), v212 (copy) ]]
						v232 = v20:Lerp(v19, p1)
						v11.CFrame = CFrame.new(v232) * v212
						return p2
					end)
					table.insert(p3, v32)
				end
				local v252 = Vector3.new(v73, v8, v9) * v44
				if v252 * v25 == v252 then
					v11.Size = v252 * v25
				else
					v22 = v1.fromParams(v31, v33, function(p1, p2) --[[ Line: 280 | Upvalues: v11 (copy), v252 (copy), v25 (ref) ]]
						v11.Size = (v252 * v25):Lerp(v252, p1)
						return p2
					end)
					table.insert(p3, v22)
				end
				if shared.vfx and #v11:GetChildren() ~= 0 then
					local Finished = shared.vfx.emit(v122).Finished
					table.insert(t, Finished)
				end
				task.delay(v6:NextNumber(v24.Min, v24.Max), function() --[[ Line: 295 | Upvalues: v22 (ref), v32 (ref), v11 (copy), v252 (copy), v26 (ref), p3 (ref), v1 (ref), v322 (ref), v34 (ref), v232 (ref), v21 (ref), v3 (ref), p2 (ref), v23 (ref), v212 (copy), v37 (ref), v35 (ref) ]]
					if v22 then
						v22:Disconnect()
					end
					if v32 then
						v32:Disconnect()
					end
					local Size = v11.Size
					local Transparency = v11.Transparency
					if Size ~= v252 * v26 then
						local function f4(p1, p2) --[[ Line: 310 | Upvalues: v11 (ref), Size (copy), v252 (ref), v26 (ref) ]]
							v11.Size = Size:Lerp(v252 * v26, p1)
							return p2
						end
						table.insert(p3, v1.fromParams(v322, v34, f4))
					end
					if v232 ~= v21 then
						local function f8(p1, p2) --[[ Line: 323 | Upvalues: v11 (ref), v232 (ref), v21 (ref), v212 (ref) ]]
							v11.CFrame = CFrame.new(v232:Lerp(v21, p1)) * v212
							return p2
						end
						table.insert(p3, v1.fromParams(v3.getAttribute(p2, "Offset_End_Curve", v3.default_bezier), v23, f8))
					end
					if Transparency == v37 then
						v11.Transparency = Transparency
					else
						local v10 = v3.getAttribute(p2, "Transparency_Curve", v3.default_bezier)
						local function f12(p1, p2) --[[ Line: 337 | Upvalues: v11 (ref), v3 (ref), Transparency (copy), v37 (ref) ]]
							v11.Transparency = v3.lerp(Transparency, v37, p1)
							return p2
						end
						table.insert(p3, v1.fromParams(v10, v35, f12))
					end
				end)
			end
		end
		v41 = v41 % v13
		return p22
	end
	local v54 = v3.RENDER_PRIORITY + p3.depth
	table.insert(p3, fromParams(linear_bezier, v39, f53, nil, nil, true, v54))
	task.wait(v24.Max + v39 + math.max(v34, v23))
	v5.all(t):await()
end
return t