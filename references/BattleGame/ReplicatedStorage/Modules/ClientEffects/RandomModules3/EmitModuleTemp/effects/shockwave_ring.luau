 
  
local CollectionService = game:GetService("CollectionService")
local v1 = require("../mod/tween")
local v2 = require("../mod/utility")
local v3 = require("../pkg/Promise")
require("../obj/ObjectCache")
local v4 = Random.new()
local t = {}
local v5 = nil
function t.init(p1) --[[ init | Line: 15 | Upvalues: v5 (ref) ]]
	v5 = p1
end
function t.deinit() --[[ deinit | Line: 19 | Upvalues: v5 (ref) ]]
	v5 = nil
end
function t.emit(p1, p2, p3) --[[ emit | Line: 23 | Upvalues: v5 (ref), v2 (copy), CollectionService (copy), v4 (copy), v1 (copy), v3 (copy) ]]
	if not v5 then
		return
	end
	local v12 = v2.getAttribute(p1, "RayDirection", Vector3.new(0, -50, 0))
	local v22 = v2.getAttribute(p1, "RayCollisionGroup", "Default")
	local v32 = v2.getAttribute(p1, "FilterTag", "")
	local v42 = v2.getAttribute(p1, "FilterType", "Exclude")
	local v52 = v2.getAttribute(p1, "IgnoreWater", true)
	local v6 = v2.getAttribute(p1, "IgnoreCanCollide", false)
	local v7 = RaycastParams.new()
	v7.CollisionGroup = v22
	v7.IgnoreWater = v52
	v7.RespectCanCollide = not v6
	v7.FilterType = Enum.RaycastFilterType[v42]
	v7.FilterDescendantsInstances = CollectionService:GetTagged(v32)
	if v42 == "Exclude" then
		v7:AddToFilter({ workspace.Terrain })
	end
	local v8 = v2.getAttribute(p2, "EmitDelay", 0)
	local v9 = v2.getAttribute(p2, "Radius", 5)
	local v10 = v2.getAttribute(p2, "Segments", 7)
	local v11 = v2.getRangeAttribute(p2, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)))
	local v122 = v2.getAttribute(p2, "PartOffset", Vector3.new(0, 0, 0), true)
	local v13 = v2.getAttribute(p2, "BaseOffset", v122)
	local v14 = v2.getAttribute(p2, "Offset_Start", v122)
	local v15 = v2.getAttribute(p2, "Offset_End", v122)
	local v16 = v2.getAttribute(p2, "Offset_Start_Duration", 0.5)
	local v17 = v2.getAttribute(p2, "Offset_End_Duration", 0.5)
	local v18 = v2.getAttribute(p2, "SizeScaleStart", Vector3.new(0, 0, 0))
	local v19 = v2.getAttribute(p2, "SizeScaleEnd", Vector3.new(0, 0, 0))
	local v20 = v2.getAttribute(p2, "MinSize", Vector3.new(2, 1, 2))
	local v21 = v2.getAttribute(p2, "MaxSize", Vector3.new(3, 2, 3))
	local v222 = v2.getAttribute(p2, "Size_Curve", v2.default_bezier, true)
	local v23 = v2.getAttribute(p2, "Size_Duration", 0.5, true)
	local v24 = v2.getAttribute(p2, "Size_Start_Curve", v222)
	local v25 = v2.getAttribute(p2, "Size_End_Curve", v222)
	local v26 = v2.getAttribute(p2, "Size_Start_Duration", v23)
	local v27 = v2.getAttribute(p2, "Size_End_Duration", v23)
	local v28 = v2.getAttribute(p2, "Transparency_Duration", 0.5)
	local v29 = v2.getAttribute(p2, "Transparency_Start", 0)
	local v30 = v2.getAttribute(p2, "Transparency_End", 0)
	task.wait(v8)
	local t = {}
	local v31
	for i = 0, v10 - 1 do
		local v322 = i / v10 * math.pi * 2
		local v35 = workspace:Raycast((p1.WorldCFrame * CFrame.new(v9 * math.cos(v322), 0, v9 * math.sin(v322))).Position, p1.WorldCFrame:VectorToWorldSpace(v12), v7)
		if v35 then
			local v36 = v4:NextNumber(v20.X, v21.X)
			local v37 = v4:NextNumber(v20.Y, v21.Y)
			local v38 = v4:NextNumber(v20.Z, v21.Z)
			local v39 = v2.getRanomId()
			local v40 = v5:get(v39)
			local v41 = v40._getReal()
			v2.copyProperties(p2, v41, v2.COPY_PART_PROPERTIES)
			v2.copyProperties(p2, v41, v2.COPY_EXTENDED_PART_PROPERTIES)
			if #p2:GetChildren() ~= 0 then
				local v422 = p2:Clone()
				for v43, v44 in v422:GetChildren() do
					v44.Parent = v41
				end
				v422:Destroy()
			end
			local function f45() --[[ Line: 128 | Upvalues: v5 (ref), v39 (copy) ]]
				if not v5 then
					return
				end
				v5:free(v39)
			end
			table.insert(p3, f45)
			v40.Color = v35.Instance.Color
			v40.Material = v35.Material
			v40.Transparency = v35.Instance.Transparency
			if v40.Transparency == 0 then
				v40.Transparency = v29
			end
			v40.Size = Vector3.new(0, 0, 0)
			local Unit = p1.WorldCFrame:VectorToWorldSpace((Vector3.new(-math.cos(v322), 0, -math.sin(v322)))):Cross(v35.Normal).Unit
			local v48 = CFrame.fromMatrix(v35.Position, Unit, v35.Normal) * CFrame.fromOrientation(-math.atan(v37 / v38), 0, 0)
			v40.CFrame = CFrame.new(v14) * v48
			local v49 = nil
			local v50 = Vector3.new(0, 0, 0)
			if v14 == v13 then
				v31 = nil
			else
				v31 = v1.fromParams(v2.getAttribute(p2, "Offset_Start_Curve", v2.default_bezier), v16, function(p1, p2) --[[ Line: 164 | Upvalues: v50 (ref), v14 (copy), v13 (copy), v40 (copy), v48 (copy) ]]
					v50 = v14:Lerp(v13, p1)
					v40.CFrame = CFrame.new(v50) * v48
					return p2
				end)
				table.insert(p3, v49)
			end
			local v51 = Vector3.new(v36, v37, v38)
			if v51 * v18 == v51 then
				v40.Size = v51 * v18
			else
				v49 = v1.fromParams(v24, v26, function(p1, p2) --[[ Line: 177 | Upvalues: v40 (copy), v51 (copy), v18 (copy) ]]
					v40.Size = (v51 * v18):Lerp(v51, p1)
					return p2
				end)
				table.insert(p3, v49)
			end
			if shared.vfx and #v40:GetChildren() ~= 0 then
				local Finished = shared.vfx.emit(v40).Finished
				table.insert(t, Finished)
			end
			task.delay(v4:NextNumber(v11.Min, v11.Max), function() --[[ Line: 192 | Upvalues: v49 (ref), v31 (ref), v40 (copy), v51 (copy), v19 (copy), p3 (copy), v1 (ref), v25 (copy), v27 (copy), v50 (ref), v15 (copy), v2 (ref), p2 (copy), v17 (copy), v48 (copy), v30 (copy), v28 (copy) ]]
				if v49 then
					v49:Disconnect()
				end
				if v31 then
					v31:Disconnect()
				end
				local Size = v40.Size
				local Transparency = v40.Transparency
				if Size ~= v51 * v19 then
					local function f4(p1, p2) --[[ Line: 207 | Upvalues: v40 (ref), Size (copy), v51 (ref), v19 (ref) ]]
						v40.Size = Size:Lerp(v51 * v19, p1)
						return p2
					end
					table.insert(p3, v1.fromParams(v25, v27, f4))
				end
				if v50 ~= v15 then
					local function f8(p1, p2) --[[ Line: 220 | Upvalues: v40 (ref), v50 (ref), v15 (ref), v48 (ref) ]]
						v40.CFrame = CFrame.new(v50:Lerp(v15, p1)) * v48
						return p2
					end
					table.insert(p3, v1.fromParams(v2.getAttribute(p2, "Offset_End_Curve", v2.default_bezier), v17, f8))
				end
				if Transparency == v30 then
					v40.Transparency = Transparency
				else
					local v10 = v2.getAttribute(p2, "Transparency_Curve", v2.default_bezier)
					local function f12(p1, p2) --[[ Line: 234 | Upvalues: v40 (ref), v2 (ref), Transparency (copy), v30 (ref) ]]
						v40.Transparency = v2.lerp(Transparency, v30, p1)
						return p2
					end
					table.insert(p3, v1.fromParams(v10, v28, f12))
				end
			end)
		end
	end
	task.wait(v11.Max + math.max(v27, v17))
	v3.all(t):await()
end
return t