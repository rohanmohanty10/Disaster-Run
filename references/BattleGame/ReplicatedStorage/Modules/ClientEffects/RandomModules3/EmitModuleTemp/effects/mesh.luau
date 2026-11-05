 
  
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local v1 = require("../mod/tween")
local v2 = require("../mod/utility")
local v3 = require("../mod/color/Oklab")
local v4 = require("../pkg/Promise")
local v5 = Random.new()
return {
	emit = function(p1, p2, p3, p4, p5) --[[ emit | Line: 14 | Upvalues: v2 (copy), v5 (copy), v1 (copy), RunService (copy), v3 (copy), CollectionService (copy), v4 (copy) ]]
		local Start = p1:FindFirstChild("Start")
		local End = p1:FindFirstChild("End")
		if not Start or (not End or (not Start:IsA("BasePart") or (not End:IsA("BasePart") or p1:GetAttribute("Enabled") and not p5))) then
			return
		end
		local v12 = v2.getAttribute(p1, "Duration", 1, true)
		local v22 = v2.getRangeAttribute(p1, "EffectDuration", NumberRange.new(v12, v12), NumberRange.new(0, (1 / 0)))
		local v32 = v5:NextNumber(v22.Min, v22.Max)
		local v42 = v2.getAttribute(p1, "EmitDelay", 0)
		local v52 = v2.getAttribute(p1, "EmitDuration", 0, true)
		local v6 = v2.getAttribute(p1, "Flipbook", false, true)
		local v7 = v2.getAttribute(p1, "FlipbookFadeOffset", 0, true)
		local v8 = if v6 or not Start:FindFirstChildOfClass("Decal") then "Mesh_" else "Decal_"
		local v9 = p1:GetAttribute("StartTransparency")
		if v9 ~= nil then
			p1:SetAttribute(v8 .. "StartTransparency", v9)
			p1:SetAttribute("StartTransparency", nil)
		end
		local v10 = p1:GetAttribute("EndTransparency")
		if v10 ~= nil then
			p1:SetAttribute(v8 .. "EndTransparency", v10)
			p1:SetAttribute("EndTransparency", nil)
		end
		local v11 = if p1:GetAttribute("Enabled") == nil then false else p1:HasTag(v2.ENABLED_VFX_TAG) and (if v32 > 0 then true else false)
		local v122 = v2.getAttribute(p1, "Decal_StartTransparency", 0, true)
		local v13 = v2.getAttribute(p1, "Decal_EndTransparency", 1, true)
		local v14 = 0
		if if Start then Start:FindFirstChildOfClass("Decal") else Start then
			v14 = 1
		end
		local v16 = v2.getAttribute(p1, "Mesh_StartTransparency", v14, true)
		local v17 = v2.getAttribute(p1, "Mesh_EndTransparency", v14, true)
		local v18 = v2.getAttribute(p1, "SyncPosition", false)
		local v19 = v2.getAttribute(p1, "Speed_Start", 1)
		local v20 = v2.getAttribute(p1, "Speed_End", 1)
		local v21 = v2.getAttribute(p1, "Part_Transparency_Start", v16)
		local v222 = v2.getAttribute(p1, "Part_Transparency_End", v17)
		local v23 = v2.getAttribute(p1, "SpreadAngle", Vector3.new(0, 0, 0))
		local v24 = v2.getRangeAttribute(p1, "Part_RotSpeed_Start", NumberRange.new(0, 0))
		local v25 = v2.getRangeAttribute(p1, "Part_RotSpeed_End", NumberRange.new(0, 0))
		local v26 = v2.getAttribute(p1, "RotAroundOrigin", false)
		local v27 = v2.getAttribute(p1, "MinInitRot", Vector3.new(0, 0, 0))
		local v28 = v2.getAttribute(p1, "MaxInitRot", Vector3.new(0, 0, 0))
		local v29 = v5:NextNumber(v24.Min, v24.Max)
		local v30 = v5:NextNumber(v25.Min, v25.Max)
		local v34 = vector.create(v5:NextNumber(v27.x, v28.x), v5:NextNumber(v27.y, v28.y), v5:NextNumber(v27.z, v28.z)) * v2.DEG_TO_RAD
		task.wait(v42)
		local v35 = p1:GetAttribute("SpeedOverride")
		local function f37() --[[ Line: 125 | Upvalues: v35 (ref), p1 (copy) ]]
			v35 = p1:GetAttribute("SpeedOverride")
		end
		table.insert(p3, p1:GetAttributeChangedSignal("SpeedOverride"):Connect(f37))
		if v11 and not p5 then
			p1:SetAttribute("Enabled", true)
			if v19 ~= v20 then
				p1:SetAttribute("SpeedTweening", true)
				local v38 = v2.getAttribute(p1, "Speed_Curve", v2.default_bezier)
				local v39 = v2.getAttribute(p1, "Speed_Duration", 0.1)
				local function f40(p12, p2) --[[ Line: 141 | Upvalues: p1 (copy), v2 (ref), v19 (copy), v20 (copy) ]]
					p1:SetAttribute("SpeedOverride", v2.lerp(v19, v20, p12))
					return p2
				end
				table.insert(p3, v1.fromParams(v38, v39, f40, nil, function() --[[ Line: 146 | Upvalues: p1 (copy) ]]
					p1:SetAttribute("SpeedTweening", nil)
				end))
			end
			task.wait(v52)
			p1:SetAttribute("Enabled", false)
			p1:SetAttribute("SpeedOverride", nil)
		else
			local v41 = p1:FindFirstAncestorOfClass("Attachment") or Start
			local v422 = typeof(p2) == "table" and p2._getReal() or p2
			local function getOrigin() --[[ getOrigin | Line: 164 | Upvalues: v41 (copy) ]]
				return v41:IsA("Attachment") and v41.WorldCFrame or v41.CFrame
			end
			local v43 = v41:IsA("Attachment") and v41.WorldCFrame or v41.CFrame
			local v44 = Start.CFrame:ToObjectSpace(End.CFrame)
			local v45 = v19
			local v46 = v29
			local v47 = CFrame.fromOrientation(v34.x, v34.y, v34.z)
			local identity = CFrame.identity
			local v51 = CFrame.fromOrientation(math.rad((v5:NextNumber(-v23.x, v23.x))), math.rad((v5:NextNumber(-v23.y, v23.y))), 0)
			local function updatePos(p1) --[[ updatePos | Line: 183 | Upvalues: v18 (copy), v41 (copy), v43 (copy), v34 (copy), v46 (ref), v47 (ref), v26 (copy), v51 (copy), identity (ref), p2 (copy) ]]
				local v1 = v18 and (v41:IsA("Attachment") and v41.WorldCFrame or v41.CFrame) or v43
				local v2 = v34:Sign() * v46 * p1
				v47 = v47 * CFrame.fromOrientation(v2.x, v2.y, v2.z)
				p2.CFrame = (if v26 then v1 * v51 * v47 * identity else v1 * v51 * identity * v47) * v47
			end
			updatePos(0)
			local v522 = v2.getRanomId()
			RunService:BindToRenderStep(v522, v2.RENDER_PRIORITY + p3.depth, updatePos)
			local function f53() --[[ Line: 209 | Upvalues: RunService (ref), v522 (copy) ]]
				RunService:UnbindFromRenderStep(v522)
			end
			table.insert(p3, f53)
			local t = {}
			local EmitOnFinish = p2:FindFirstChild("EmitOnFinish")
			if EmitOnFinish then
				EmitOnFinish.Parent = nil
				table.insert(p3, EmitOnFinish)
			end
			if shared.vfx and #p2:GetChildren() ~= 0 then
				local Finished = shared.vfx.emit(p2).Finished
				table.insert(t, Finished)
			end
			local v54
			if v19 == v20 or v35 then
				v54 = nil
			else
				v54 = v1.fromParams(v2.getAttribute(p1, "Speed_Curve", v2.default_bezier), v2.getAttribute(p1, "Speed_Duration", 0.1), function(p1, p2) --[[ Line: 234 | Upvalues: v45 (ref), v2 (ref), v19 (copy), v20 (copy) ]]
					v45 = v2.lerp(v19, v20, p1)
					return p2
				end)
				table.insert(p3, v54)
			end
			if v44 ~= CFrame.identity then
				local function f56(p1, p2) --[[ Line: 249 | Upvalues: identity (ref), v44 (copy), v35 (ref), v45 (ref) ]]
					identity = CFrame.identity:Lerp(v44, p1)
					return p2 * (v35 or v45)
				end
				table.insert(p3, v1.fromParams(v2.getAttribute(p1, "Part_CFrame_Curve", v2.default_bezier), v32, f56, v54))
			end
			if v29 ~= v30 then
				local v57 = v2.getAttribute(p1, "Part_RotSpeed_Curve", v2.default_bezier)
				local function f58(p1, p2) --[[ Line: 264 | Upvalues: v46 (ref), v2 (ref), v29 (copy), v30 (copy), v35 (ref), v45 (ref) ]]
					v46 = v2.lerp(v29, v30, p1)
					return p2 * (v35 or v45)
				end
				table.insert(p3, v1.fromParams(v57, v32, f58, v54))
			end
			if v21 == v222 then
				p2.Transparency = v21
			else
				local v59 = v2.getAttribute(p1, "Part_Transparency_Curve", v2.default_bezier)
				local function f60(p1, p22) --[[ Line: 279 | Upvalues: p2 (copy), v2 (ref), v21 (copy), v222 (copy), v35 (ref), v45 (ref) ]]
					p2.Transparency = v2.lerp(v21, v222, p1)
					return p22 * (v35 or v45)
				end
				table.insert(p3, v1.fromParams(v59, v32, f60, v54))
			end
			local v61 = Start.Size * p4
			local v62 = End.Size * p4
			if v61 == v62 then
				p2.Size = v61
			else
				table.insert(p3, v1.fromParams(v2.getAttribute(p1, "Part_Size_Curve", v2.default_bezier), v32, function(p1, p22) --[[ Line: 298 | Upvalues: p2 (copy), v61 (copy), v62 (copy), v35 (ref), v45 (ref) ]]
					p2.Size = v61:Lerp(v62, p1)
					return p22 * (v35 or v45)
				end, v54))
			end
			local SpecialMesh = Start:FindFirstChildOfClass("SpecialMesh")
			local SpecialMesh_2 = End:FindFirstChildOfClass("SpecialMesh")
			local SpecialMesh_3 = p2:FindFirstChildOfClass("SpecialMesh")
			if SpecialMesh_3 and (SpecialMesh and SpecialMesh_2) then
				local v64 = SpecialMesh.Scale * p4
				local v65 = SpecialMesh_2.Scale * p4
				if v64 ~= v65 then
					local v66 = v2.getAttribute(p1, "Mesh_Scale_Curve", v2.default_bezier)
					local function f67(p1, p2) --[[ Line: 324 | Upvalues: SpecialMesh_3 (copy), v2 (ref), v64 (copy), v65 (copy), v35 (ref), v45 (ref) ]]
						SpecialMesh_3.Scale = v2.lerp(v64, v65, p1)
						return p2 * (v35 or v45)
					end
					table.insert(p3, v1.fromParams(v66, v32, f67, v54))
				end
			elseif SpecialMesh_3 then
				SpecialMesh_3.Parent = nil
				table.insert(p3, function() --[[ Line: 335 | Upvalues: SpecialMesh_3 (copy), v422 (copy) ]]
					SpecialMesh_3.Parent = v422
				end)
			end
			local v68, v69, v70 = v2.getMeshDecals(p1, p2)
			local v71 = 0
			if v6 then
				table.sort(v68, function(p1, p2) --[[ Line: 346 ]]
					local v1 = p1.Name:match("%d+") or 0
					local v2 = p2.Name:match("%d+") or 0
					return tonumber(v1) < tonumber(v2)
				end)
				local Decal = Instance.new("Decal")
				Decal.Parent = v422
				table.insert(p3, Decal)
				if v7 > 0 and v122 ~= v13 then
					local default_bezier = v2.default_bezier
					local function f72(p1, p2) --[[ Line: 362 | Upvalues: Decal (copy), v2 (ref), v122 (copy), v13 (copy), v35 (ref), v45 (ref) ]]
						Decal.Transparency = v2.lerp(v122, v13, p1)
						return p2 * (v35 or v45)
					end
					table.insert(p3, v1.fromParams(default_bezier, v32 + v7, f72, v54))
				end
				local default_bezier = v2.default_bezier
				local function f73(p1, p2) --[[ Line: 372 | Upvalues: v68 (copy), Decal (copy), v7 (copy), v2 (ref), v122 (copy), v13 (copy), v35 (ref), v45 (ref) ]]
					local v3 = v68[math.max(math.round(#v68 * p1), 1)]
					Decal.Texture = v3.Texture
					Decal.Color3 = v3.Color3
					Decal.ZIndex = v3.ZIndex
					if v7 == 0 then
						Decal.Transparency = v2.lerp(v122, v13, p1)
						Decal.ZIndex = v3.ZIndex
					end
					return p2 * (v35 or v45)
				end
				table.insert(p3, v1.fromParams(default_bezier, v32, f73, v54))
			else
				for v74, v75 in v68 do
					local v76 = v70[v75]
					local v77 = v2.getAttribute(v75, "Transparency_Start", v122)
					local v78 = v2.getAttribute(v75, "Transparency_End", v13)
					if v77 == v78 then
						v75.Transparency = v77
					else
						local v79 = v2.getAttribute(v75, "Transparency_Curve", v2.default_bezier)
						local function f80(p1, p2) --[[ Line: 403 | Upvalues: v75 (copy), v2 (ref), v77 (copy), v78 (copy), v35 (ref), v45 (ref) ]]
							v75.Transparency = v2.lerp(v77, v78, p1)
							return p2 * (v35 or v45)
						end
						table.insert(p3, v1.fromParams(v79, v32, f80, v54))
					end
					if v75.Color3 ~= v76.Color3 then
						local v81 = v3.fromSRGB(v75.Color3)
						local v82 = v3.fromSRGB(v76.Color3)
						local function f84(p1, p2) --[[ Line: 423 | Upvalues: v75 (copy), v3 (ref), v81 (copy), v82 (copy), v35 (ref), v45 (ref) ]]
							v75.Color3 = v3.toSRGB(v81:Lerp(v82, p1), true)
							return p2 * (v35 or v45)
						end
						table.insert(p3, v1.fromParams(v2.getAttribute(v75, "Color_Curve", v2.default_bezier), v32, f84, v54))
					end
					local v85 = v69[v75]
					if v85 then
						local v86 = v2.getAttribute(v75, "Flipbook_Change_Duration", v32)
						if v2.getAttribute(v75, "SyncDuration", false) then
							v86 = v32
						end
						if v71 < v86 then
							v71 = v86
						end
						local v87 = false
						if RunService:IsStudio() then
							for v88, v89 in CollectionService:GetTags(v75) do
								if v89:match("^_local_flipbook_") then
									v87 = true
									break
								end
							end
						end
						local v90 = #v85
						local v91 = table.create(v90)
						local v92 = if v87 then "rbxtemp://" else "rbxassetid://"
						for i = 1, v90 do
							v91[i] = v92 .. tostring(v85[i])
						end
						table.insert(p3, v1.fromParams(v2.getAttribute(v75, "Flipbook_Change_Curve", v2.linear_bezier), v86, function(p1, p2) --[[ Line: 469 | Upvalues: v90 (copy), v75 (copy), v91 (copy), v35 (ref), v45 (ref) ]]
							v75.Texture = v91[math.max(math.round(v90 * p1), 1)]
							return p2 * (v35 or v45)
						end, v54))
					end
				end
			end
			v1.timer(math.max(v32, v71) + v7, function(p12, p2) --[[ Line: 482 | Upvalues: v35 (ref), v45 (ref), v54 (ref), p1 (copy) ]]
				local v1 = v35 or v45
				v45 = v1
				if not (v1 > 0) then
					if not (p2 > 0) then
						return nil
					end
					if not (if v54 then v54.Connected else p1:GetAttribute("SpeedTweening")) then
						return nil
					end
				end
				return p12 * v1
			end, v54, p3)
			v4.all(t):await()
			local v95 = EmitOnFinish and EmitOnFinish:GetChildren()
			if not v95 or #v95 == 0 then
				return
			end
			for v96, v97 in v95 do
				v97.Parent = v422
			end
			shared.vfx.emit(table.unpack(v95)).Finished:await()
		end
	end
}