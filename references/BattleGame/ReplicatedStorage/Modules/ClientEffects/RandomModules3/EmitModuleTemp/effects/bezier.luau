 
  
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local v1 = require("../mod/tween")
local v2 = require("../mod/shape")
local v3 = require("../mod/utility")
local v4 = require("../obj/Bezier")
local v5 = require("../pkg/Promise")
require("../obj/ObjectCache")
local t = {
	Box = {
		Volume = v2.getPointWithinBox,
		Surface = v2.getPointOnBox
	},
	Cylinder = {
		Volume = function(p1, p2, p3, p4, p5) --[[ Volume | Line: 19 | Upvalues: v2 (copy) ]]
			return v2.getPointWithinCylinder(p1, 0, p5, p2, p3, p4)
		end,
		Surface = function(p1, p2, p3, p4, p5) --[[ Surface | Line: 23 | Upvalues: v2 (copy) ]]
			return v2.getPointWithinCylinder(p1, 1, p5, p2, p3, p4)
		end
	},
	Sphere = {
		Volume = function(p1, p2, p3, p4, p5) --[[ Volume | Line: 29 | Upvalues: v2 (copy) ]]
			return v2.getPointWithinSphere(p1, 0, p5, p2, p3, p4)
		end,
		Surface = function(p1, p2, p3, p4, p5) --[[ Surface | Line: 33 | Upvalues: v2 (copy) ]]
			return v2.getPointWithinSphere(p1, 1, p5, p2, p3, p4)
		end
	},
	Disc = {
		Volume = function(p1, p2, p3, p4, p5) --[[ Volume | Line: 39 | Upvalues: v2 (copy) ]]
			return v2.getPointWithinDisc(p1, 0, p5, p2, p3, p4)
		end,
		Surface = function(p1, p2, p3, p4, p5) --[[ Surface | Line: 43 | Upvalues: v2 (copy) ]]
			return v2.getPointWithinDisc(p1, 1, p5, p2, p3, p4)
		end
	}
}
local t2 = {}
local v6 = nil
function t2.init(p1) --[[ init | Line: 53 | Upvalues: v6 (ref) ]]
	v6 = p1
end
function t2.deinit() --[[ deinit | Line: 57 | Upvalues: v6 (ref) ]]
	v6 = nil
end
function t2.emit(p1, p2, p3, p4) --[[ emit | Line: 61 | Upvalues: v6 (ref), v3 (copy), t (copy), v1 (copy), v4 (copy), CollectionService (copy), v5 (copy), HttpService (copy) ]]
	local Points = p1:FindFirstChild("Points")
	if not (Points and (Points:IsA("Attachment") and v6)) then
		return
	end
	local v12 = v3.getAttribute(p1, "EmitDelay", 0)
	local v2 = v3.getAttribute(p1, "EmitCount", 1)
	local v32 = v3.getAttribute(p1, "EmitDuration", 0)
	local v42 = v3.getAttribute(p1, "DestroyDelay", 0)
	local v52 = v3.getRangeAttribute(p1, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)))
	local v62 = v3.getEnumAttribute(p1, "ShapeFace", "Outward", { "InAndOut", "Inward", "Outward" })
	local v7 = v3.getAttribute(p1, "SpreadAngle", Vector3.new(0, 0, 0))
	local v8 = v3.getAttribute(p1, "SyncPosition", false)
	local v9 = v3.getAttribute(p1, "MirrorPaths", true)
	local v10 = v3.getAttribute(p1, "MirrorRotation", Vector3.new(0, 0, 180))
	local v11 = v3.getAttribute(p1, "FacePath", false)
	local v122 = v3.getAttribute(p1, "ArcSpace", false)
	local v13 = v3.getAttribute(p1, "ShapePartial", 1)
	local v14 = v3.getEnumAttribute(p1, "Shape", "Box", { "Box", "Cylinder", "Sphere", "Disc" })
	local v15 = v3.getEnumAttribute(p1, "ShapeStyle", "Volume", { "Volume", "Surface" })
	local v16 = Enum.NormalId[v3.getEnumAttribute(p1, "EmissionDirection", "Top", { "Top", "Bottom", "Left", "Right", "Front", "Back" })]
	local v17 = v3.getAttribute(p1, "ProjectileEnabled", false)
	local v18 = v3.getAttribute(p1, "MatchEndDirection", false)
	local v19 = v3.getAttribute(p1, "ProjectileSpeed", 30)
	local v20 = v3.getRangeAttribute(p1, "ProjectileLifetime", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)))
	local v21 = v3.getAttribute(p1, "HitboxEnabled", false)
	local v22 = v3.getAttribute(p1, "HitboxCollisionGroup", "Default")
	local v23 = v3.getAttribute(p1, "HitboxFilterTag", "")
	local v24 = v3.getAttribute(p1, "HitboxFilterType", "Exclude")
	local v25 = v3.getAttribute(p1, "HitboxIgnoreCanCollide", false)
	local v26 = v3.getRangeAttribute(p1, "RotSpeed_Start", NumberRange.new(0, 0))
	local v27 = v3.getRangeAttribute(p1, "RotSpeed_End", NumberRange.new(0, 0))
	local v28 = v3.getAttribute(p1, "MinInitRot", Vector3.new(0, 0, 0))
	local v29 = v3.getAttribute(p1, "MaxInitRot", Vector3.new(0, 0, 0))
	local v30 = v3.getAttribute(p1, "Speed_Start", 1)
	local v31 = v3.getAttribute(p1, "Speed_End", 1)
	local v322 = t[v14] and t[v14][v15]
	if not v322 then
		return
	end
	local t2 = {}
	task.wait(v12)
	if (if v32 > 0 then true else false) and not p4 then
		p1:SetAttribute("Enabled", true)
		if v30 ~= v31 then
			p1:SetAttribute("SpeedTweening", true)
			local v34 = v3.getAttribute(p1, "Speed_Curve", v3.default_bezier)
			local v35 = v3.getAttribute(p1, "Speed_Duration", 0.1)
			local function f36(p12, p2) --[[ Line: 144 | Upvalues: p1 (copy), v3 (ref), v30 (copy), v31 (copy) ]]
				p1:SetAttribute("SpeedOverride", v3.lerp(v30, v31, p12))
				return p2
			end
			table.insert(p3, v1.fromParams(v34, v35, f36, nil, function() --[[ Line: 149 | Upvalues: p1 (copy) ]]
				p1:SetAttribute("SpeedTweening", nil)
			end))
		end
		task.wait(v32)
		p1:SetAttribute("Enabled", false)
		p1:SetAttribute("SpeedOverride", nil)
	else
		if not (v2 > 0) then
			return
		end
		local v37 = nil
		local v38 = nil
		local v39 = p1.Parent
		if not v39 then
			return
		end
		if not (v39:IsA("BasePart") or v39:IsA("Attachment")) then
			v39 = p1
		end
		if v39:IsA("BasePart") then
			v37 = v39.Size
			v38 = v39.CFrame
		elseif v39:IsA("Attachment") then
			v38 = v39.WorldCFrame
			v37 = Vector3.new(0, 0, 0)
		end
		if not v38 then
			return
		end
		local End = p1:FindFirstChild("End")
		local v40 = End and End:FindFirstChild("T1")
		if End and not End:IsA("Attachment") then
			End = nil
		end
		if v40 and not v40:IsA("Attachment") then
			v40 = nil
		end
		local v41 = v3.getBezierPoints(Points)
		local v422 = Random.new()
		local v43 = not End and v4.new(v41)
		local v44 = OverlapParams.new()
		v44.MaxParts = 1
		v44.FilterType = Enum.RaycastFilterType[v24]
		v44.CollisionGroup = v22
		v44.RespectCanCollide = not v25
		v44:AddToFilter(CollectionService:GetTagged(v23))
		if v24 == "Exclude" then
			v44:AddToFilter({ workspace.Terrain, v39, Points:FindFirstAncestorOfClass("Part") })
		end
		for i = 1, v2 do
			local v45 = v422:NextNumber(v26.Min, v26.Max)
			local v46 = v422:NextNumber(v27.Min, v27.Max)
			local v49 = vector.create(v422:NextNumber(v28.x, v29.x), v422:NextNumber(v28.y, v29.y), v422:NextNumber(v28.z, v29.z))
			local v50 = v422:NextNumber(v52.Min, v52.Max)
			local v51 = v17 and v422:NextNumber(v20.Min, v20.Max)
			local function f53(p12) --[[ Line: 231 | Upvalues: v39 (ref), v38 (ref), v16 (copy), v322 (copy), v37 (ref), v13 (copy), v422 (copy), v7 (copy), v62 (copy), End (ref), v9 (copy), v10 (copy), v3 (ref), v43 (copy), v41 (copy), v40 (ref), v4 (ref), v122 (copy), HttpService (ref), v6 (ref), p2 (copy), p3 (copy), t2 (copy), v21 (copy), v44 (copy), v30 (copy), v45 (copy), v49 (copy), v31 (copy), p1 (copy), v1 (ref), v46 (copy), v50 (copy), v11 (copy), v8 (copy), v17 (copy), v51 (copy), v18 (copy), v19 (copy) ]]
				local v12 = if v39:IsA("Attachment") then v38 * CFrame.new(Vector3.new(0, 0, 0), Vector3.FromNormalId(v16)).Rotation else v322(nil, v38, v37, v16, v13)
				local v2 = Vector3.FromNormalId(v16)
				local v32 = v2:Cross(v38.LookVector)
				if v32.Magnitude < 0.001 then
					v32 = v2:Cross(v38.UpVector)
				end
				local v63 = CFrame.fromAxisAngle(v2, (math.rad((v422:NextNumber(-v7.x, v7.x)))))
				local v82 = v12 * (v63 * CFrame.fromAxisAngle(v32, (math.rad((v422:NextNumber(-v7.y, v7.y))))))
				if v62 == "Inward" or v62 == "InAndOut" and v422:NextInteger(0, 1) == 1 then
					v82 = v82 * CFrame.fromOrientation(0, math.pi, 0)
				end
				if End and (v9 and (v82.Position - End.WorldPosition).Unit:Dot(v82.RightVector) >= 0) then
					local v92 = v10 * v3.DEG_TO_RAD
					v82 = v82 * CFrame.fromOrientation(v92.x, v92.y, v92.z)
				end
				local v102 = v43
				if End then
					local t = {}
					for v112, v123 in v41 do
						table.insert(t, if v112 == #v41 - 1 then v40 and v40.WorldPosition or End.WorldPosition elseif v112 == #v41 then End.WorldPosition else v82 * (v123 - v41[1]))
					end
					v102 = v4.new(t)
				end
				local function getPos(p1) --[[ getPos | Line: 275 | Upvalues: v122 (ref), v102 (ref), End (ref), v82 (ref), v41 (ref) ]]
					local v1 = v122 and v102:getPositionArcSpace(p1) or v102:getPosition(p1)
					if End then
						return v1
					else
						return v82 * (v1 - v41[1])
					end
				end
				local v14 = HttpService:GenerateGUID(false)
				if not v6 then
					p12()
					return
				end
				local v15 = v6:get(v14)
				local v162 = CFrame.new
				local v172 = v122 and v102:getPositionArcSpace(0) or v102:getPosition(0)
				local v182 = if End then v172 else v82 * (v172 - v41[1])
				v15.CFrame = v162(v182)
				local v192 = v15._getReal()
				v3.copyProperties(p2, v192, v3.COPY_PART_PROPERTIES)
				v3.copyProperties(p2, v192, v3.COPY_EXTENDED_PART_PROPERTIES)
				local v20 = p2:Clone()
				for v212, v22 in v20:GetChildren() do
					v22.Parent = v192
				end
				v20:Destroy()
				local EmitOnFinish = v192:FindFirstChild("EmitOnFinish")
				if EmitOnFinish then
					EmitOnFinish.Parent = nil
					table.insert(p3, EmitOnFinish)
				end
				if shared.vfx and #v192:GetChildren() ~= 0 then
					local Finished = shared.vfx.emit(v192).Finished
					table.insert(t2, Finished)
				end
				local v25 = p3
				local function f26() --[[ Line: 322 | Upvalues: v6 (ref), v14 (copy) ]]
					if not v6 then
						return
					end
					v6:free(v14)
				end
				table.insert(v25, f26)
				local v27 = Vector3.new(0, 0, 0)
				local v28 = Vector3.new(0, 0, 0)
				local v29 = false
				local function onFinish() --[[ onFinish | Line: 333 | Upvalues: v29 (ref), EmitOnFinish (copy), v192 (copy), p12 (copy) ]]
					if v29 then
						return
					end
					v29 = true
					local v1 = EmitOnFinish and EmitOnFinish:GetChildren()
					if not v1 or #v1 == 0 then
						p12()
						return
					end
					for v2, v3 in v1 do
						v3.Parent = v192
					end
					shared.vfx.emit(table.unpack(v1)).Finished:finally(function() --[[ Line: 349 | Upvalues: p12 (ref) ]]
						p12()
					end)
				end
				local function shapecast() --[[ shapecast | Line: 357 | Upvalues: v21 (ref), v192 (copy), v44 (ref) ]]
					if v21 then
						return workspace:GetPartsInPart(v192, v44)[1] and true or false
					end
				end
				local function getOriginCFrame() --[[ getOriginCFrame | Line: 371 | Upvalues: v38 (ref), v39 (ref) ]]
					local v1 = v38
					if v39:IsA("BasePart") then
						return v39.CFrame
					end
					if v39:IsA("Attachment") then
						v1 = v39.WorldCFrame
					end
					return v1
				end
				local v302 = false
				local identity = CFrame.identity
				local v312 = v30
				local v323 = v45
				local v33 = CFrame.fromOrientation(v49.x, v49.y, v49.z)
				local v34
				if v30 == v31 or p1:GetAttribute("SpeedOverride") then
					v34 = nil
				else
					v34 = v1.fromParams(v3.getAttribute(p1, "Speed_Curve", v3.default_bezier), v3.getAttribute(p1, "Speed_Duration", 0.1), function(p1, p2) --[[ Line: 397 | Upvalues: v312 (ref), v3 (ref), v30 (ref), v31 (ref) ]]
						v312 = v3.lerp(v30, v31, p1)
						return p2
					end)
					table.insert(p3, v34)
				end
				if v45 ~= v46 then
					local v372 = v3.getAttribute(p1, "RotSpeed_Curve", v3.default_bezier)
					local function f39(p12, p2) --[[ Line: 412 | Upvalues: v323 (ref), v3 (ref), v45 (ref), v46 (ref), p1 (ref), v312 (ref) ]]
						v323 = v3.lerp(v45, v46, p12)
						return p2 * (p1:GetAttribute("SpeedOverride") or v312)
					end
					table.insert(p3, v1.fromParams(v372, v50, f39, v34))
				end
				local v402 = p3
				local fromParams = v1.fromParams
				local v412 = v3.getAttribute(p1, "Easing_Curve", v3.linear_bezier)
				local v42 = v50
				local function f43(p12, p2, p3) --[[ Line: 426 | Upvalues: v122 (ref), v102 (ref), End (ref), v82 (ref), v41 (ref), v11 (ref), v50 (ref), identity (ref), v49 (ref), v323 (ref), v3 (ref), v33 (ref), v8 (ref), v15 (copy), v38 (ref), v39 (ref), v28 (ref), v27 (ref), v21 (ref), v192 (copy), v44 (ref), onFinish (copy), v302 (ref), p1 (ref), v312 (ref), v34 (ref), v17 (ref), v51 (ref) ]]
					local v1 = v122 and v102:getPositionArcSpace(p12) or v102:getPosition(p12)
					local v2 = if End then v1 else v82 * (v1 - v41[1])
					local v32 = CFrame.new(v2)
					if v11 then
						local v5 = math.clamp((p3 + 1 / 60) / v50, 0, 1)
						local v6 = v122 and v102:getPositionArcSpace(v5) or v102:getPosition(v5)
						local v7 = if End then v6 else v82 * (v6 - v41[1])
						v32 = if v2 == v7 then v32 * identity.Rotation else CFrame.lookAt(v2, v7)
					end
					local v9 = v49:Sign() * v323 * v3.DEG_TO_RAD * p2
					v33 = v33 * CFrame.fromOrientation(v9.x, v9.y, v9.z)
					identity = v32
					local v10 = v32 * v33
					if v8 then
						local v12 = v38
						if v39:IsA("BasePart") then
							v12 = v39.CFrame
						elseif v39:IsA("Attachment") then
							v12 = v39.WorldCFrame
						end
						v15.CFrame = v12 * v38:ToObjectSpace(v10)
					else
						v15.CFrame = v10
					end
					v28 = (v2 - v27) / p2
					v27 = v2
					if if v21 then if workspace:GetPartsInPart(v192, v44)[1] then true else false else nil then
						onFinish()
						v302 = true
						return nil
					end
					local v14 = p1:GetAttribute("SpeedOverride") or v312
					v312 = v14
					if v14 == 0 and (if v34 then not v34.Connected else not p1:GetAttribute("SpeedTweening")) then
						return nil
					end
					if not (v17 and p12 * v50 < v51) and v17 then
						onFinish()
						return nil
					end
					return p2 * v14
				end
				local v442 = v34
				local function f45(p12) --[[ Line: 486 | Upvalues: v17 (ref), v302 (ref), onFinish (copy), v18 (ref), End (ref), v28 (ref), v19 (ref), v192 (copy), v38 (ref), v39 (ref), v1 (ref), v51 (ref), v8 (ref), v15 (copy), v21 (ref), v44 (ref), p1 (ref), v312 (ref), v34 (ref), p3 (ref), v3 (ref) ]]
					if v17 and not v302 then
						local v12 = if v18 and End then End.WorldCFrame.LookVector else v28.Unit
						if v12 ~= v12 then
							v12 = Vector3.new(0, 0, 0)
						end
						v28 = v12 * v19
						local Position = v192.Position
						local v2 = v38
						if v39:IsA("BasePart") then
							v2 = v39.CFrame
						elseif v39:IsA("Attachment") then
							v2 = v39.WorldCFrame
						end
						local v32 = v2
						v1.timer(v51, function(p12, p2) --[[ Line: 506 | Upvalues: v8 (ref), v15 (ref), v38 (ref), v39 (ref), v32 (copy), Position (copy), v28 (ref), v192 (ref), v21 (ref), v44 (ref), onFinish (ref), v302 (ref), p1 (ref), v312 (ref), v34 (ref) ]]
							if v8 then
								local v2 = v38
								if v39:IsA("BasePart") then
									v2 = v39.CFrame
								elseif v39:IsA("Attachment") then
									v2 = v39.WorldCFrame
								end
								v15.CFrame = v2 * v32:ToObjectSpace(CFrame.new(Position + v28 * p2))
							else
								v15.CFrame = CFrame.new(Position + v28 * p2) * v192.CFrame.Rotation
							end
							if if v21 then if workspace:GetPartsInPart(v192, v44)[1] then true else false else nil then
								onFinish()
								v302 = true
								return nil
							end
							local v4 = p1:GetAttribute("SpeedOverride") or v312
							v312 = v4
							if not (v4 > 0) then
								if not (p2 > 0) then
									return nil
								end
								if not (if v34 then v34.Connected else p1:GetAttribute("SpeedTweening")) then
									return nil
								end
							end
							return p12 * v4
						end, v34, p3, v3.RENDER_PRIORITY + p3.depth)
						if v302 then
							return
						end
					elseif not p12 then
						return
					end
					onFinish()
				end
				local v462 = v3.RENDER_PRIORITY + p3.depth
				table.insert(v402, fromParams(v412, v42, f43, v442, f45, true, v462))
			end
			table.insert(t2, v5.new(f53))
		end
		v5.all(t2):await()
		task.wait(v42)
	end
end
return t2