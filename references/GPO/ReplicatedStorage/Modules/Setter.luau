 

local u1 = {}
local function u18(p2, p3) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u18
    --]]
    local v4 = next
    local v5, v6 = p2:GetChildren()
    for _, v7 in v4, v5, v6 do
        if v7:IsA("BasePart") then
            local v8 = v7.CFrame
            local _, _, _, v9, v10, v11, v12, v13, v14, v15, v16, v17 = v8:components()
            v7.Size = v7.Size * p3
            v7.CFrame = CFrame.new(v8.p * p3) * CFrame.new(0, 0, 0, v9, v10, v11, v12, v13, v14, v15, v16, v17)
            u18(v7, p3)
        elseif v7.className == "SpecialMesh" and v7.MeshType == Enum.MeshType.FileMesh then
            v7.Scale = v7.Scale * p3
        elseif v7:IsA("Model") then
            u18(v7, p3)
        end
    end
end
local u19 = require(script.MainModule)
function scaleRecursive(p20, p21, p22)
    if p21:isA("Bone") then
        local v23 = p21.Parent.CFrame
        local v24 = p20.CFrame:Inverse() * v23
        local v25 = v24 - v24.Position
        local v26 = v25 * p21.Position * p22
        p21.Position = v25:inverse() * v26
    end
    local v27 = p21:GetChildren()
    for v28 = 1, #v27 do
        local v29 = v27[v28]
        scaleRecursive(p20, v29, p22)
    end
end
function scaleRecursive2(p30, p31, p32)
    if p31:isA("Weld") then
        local v33 = p31.Parent.CFrame
        local v34 = p30.CFrame:Inverse() * v33
        local v35 = v34 - v34.C0
        local v36 = v35 * p31.C0 * p32
        p31.C0 = v35:inverse() * v36
    end
    local v37 = p31:GetChildren()
    for v38 = 1, #v37 do
        local v39 = v37[v38]
        scaleRecursive(p30, v39, p32)
    end
end
local function u76(p40, p41, p42) --[[ Line: 58 ]]
    --[[
    Upvalues:
        [1] = u19
    --]]
    local v43 = p41.X
    local v44 = 0
    local v45 = 0
    local v46 = 0
    local v47 = p41.Y
    local v48 = 0
    local v49 = 0
    local v50 = 0
    local v51 = p41.Z
    local v52 = {}
    local v53 = {}
    local v54 = {}
    local v55 = p40:GetDescendants()
    table.insert(v55, p40)
    if p40.PrimaryPart ~= nil then
        v52[p40.PrimaryPart] = p40
    end
    p40:GetAttribute("bypassScale")
    for _, v56 in ipairs(v55) do
        if v56:IsA("Model") and v56.PrimaryPart ~= nil then
            v52[v56.PrimaryPart] = v56
        end
    end
    for _, v57 in ipairs(v55) do
        if v57:IsA("JointInstance") then
            v53[v57.Part1] = {
                ["Part0"] = v57.Part0,
                ["ClassName"] = v57.ClassName
            }
            v57:Destroy()
        end
    end
    for _, v58 in ipairs(v55) do
        if v58:IsA("BasePart") or v58:IsA("MeshPart") then
            local v59, v60, v61, v62, v63, v64, v65, v66, v67
            if v58:GetAttribute("bypassScale") then
                v59 = 0
                v60 = 1
                v61 = 1
                v62 = 0
                v63 = 0
                v64 = 0
                v65 = 1
                v66 = 0
                v67 = 0
            else
                v67 = v49
                v66 = v48
                v65 = v47
                v64 = v46
                v63 = v45
                v62 = v44
                v61 = v43
                v60 = v51
                v59 = v50
            end
            local v68 = u19.GlobalOrthogonalTransform(v61, v62, v63, v64, v65, v66, v67, v59, v60, v58, p42 or v58.Position, true)
            if v52[v58] then
                v52[v58].PrimaryPart = v68
            end
            v54[v58] = v68
            v68.Anchored = false
            v58:Destroy()
        end
    end
    for v69, v70 in pairs(v53) do
        local v71 = v70.Part0
        local v72 = v70.ClassName
        local v73 = v54[v71]
        local v74 = v54[v69]
        local v75 = Instance.new(v72)
        v75.Part0 = v73
        v75.Part1 = v74
        if v72 ~= "WeldConstraint" then
            v75.C0 = v75.Part0.CFrame:Inverse() * v75.Part1.CFrame
        end
        v75.Parent = v73
    end
    table.clear(v52)
    table.clear(v53)
    table.clear(v54)
    table.clear(v55)
end
function u1.ScaleModel(_, p77, p78, p79) --[[ Line: 124 ]]
    --[[
    Upvalues:
        [1] = u76
    --]]
    local v80 = nil
    local v81
    if p77.PrimaryPart == nil then
        v81 = p77:GetModelCFrame()
        v80 = script.Part:Clone()
        v80.CFrame = v81
        p77.PrimaryPart = v80
    else
        v81 = p77.PrimaryPart.CFrame
    end
    p77:SetPrimaryPartCFrame(CFrame.new(-1, 0, -1))
    if p79 == true then
        scaleRecursive(p77.PrimaryPart, p77, p78)
    end
    u76(p77, p78, Vector3.new(1, 0, 0))
    if v80 then
        v80:Destroy()
    end
    p77.WorldPivot = p77:GetModelCFrame()
    p77:PivotTo(v81)
end
function u1.ScaleToCharacter(_, p82, p83) --[[ Line: 152 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v84 = u1
    local v85 = p82.Humanoid.BodyWidthScale.Value
    local v86 = p82.Humanoid.BodyHeightScale.Value
    local v87 = p82.Humanoid.BodyDepthScale.Value
    v84:ScaleModel(p83, (Vector3.new(v85, v86, v87)))
end
function u1.ScaleSize(_, u88, p89, p90, p91) --[[ Line: 156 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v92 = u88:Clone()
    v92.Name = u88.Name
    local v93
    if p90 == nil and p89.Humanoid:IsA("Humanoid") then
        local v94 = p89.Humanoid.BodyWidthScale.Value
        local v95 = p89.Humanoid.BodyHeightScale.Value
        local v96 = p89.Humanoid.BodyDepthScale.Value
        v93 = Vector3.new(v94, v95, v96)
    else
        v93 = p89.Humanoid:IsA("Humanoid") == false and p90 == nil and Vector3.new(1, 1, 1) or p90
    end
    local v97 = {}
    for _, v98 in v92:GetChildren() do
        if p89:FindFirstChild(v98.Name) and v98:IsA("Model") then
            local v99 = v98:FindFirstChild("Middle")
            if v99 == nil then
                v99 = v98.PrimaryPart
            end
            local v100 = v98:GetChildren()
            for v101 = 1, #v100 do
                if v100[v101]:IsA("BasePart") and (v100[v101]:FindFirstChildWhichIsA("Motor6D") == nil and (v100[v101]:GetAttribute("bypassScale") and not v99:GetAttribute("bypassScale"))) then
                    local v102 = v99.CFrame:ToObjectSpace(v100[v101].CFrame)
                    v97[v100[v101]:GetAttribute("UniqueID") or v98.Name .. "_" .. v101] = v102
                end
            end
        end
    end
    if v93 ~= Vector3.new(1, 1, 1) then
        u1:ScaleModel(v92, v93)
    end
    for _, v103 in v92:GetChildren() do
        if p89:FindFirstChild(v103.Name) then
            if v103:IsA("Model") then
                local v104 = v103:FindFirstChild("Middle")
                if v104 == nil then
                    v104 = v103.PrimaryPart
                end
                local v105 = v103:GetChildren()
                for v106 = 1, #v105 do
                    if v105[v106]:IsA("BasePart") and v105[v106]:FindFirstChildWhichIsA("Motor6D") == nil then
                        local v107 = v105[v106]:GetAttribute("UniqueID") or v103.Name .. "_" .. v106
                        if v97[v107] then
                            local v108 = v97[v107]
                            local v109 = v108.Position
                            local v110 = CFrame.new(v109) * (v108 - v108.Position)
                            v105[v106].CFrame = v104.CFrame * v110
                        end
                        local v111 = Instance.new("Weld")
                        v111.Part0 = v104
                        v111.Part1 = v105[v106]
                        local v112 = v105[v106]:GetAttribute("bypassScale") and Vector3.new(1, 1, 1) or v93
                        local v113 = CFrame.new(v104.Position)
                        local v114 = v104.CFrame:inverse() * v113
                        local v115 = v105[v106].CFrame:inverse() * v113
                        v111.C0 = v114
                        v111.C1 = v115
                        v111.Name = v105[v106].Name .. "Weld"
                        v111.Parent = v104
                        scaleRecursive(v105[v106], v105[v106], v112)
                    end
                    if p91 == nil then
                        local v116 = Instance.new("Weld")
                        v116.Part0 = p89:FindFirstChild(v103.Name)
                        v116.Part1 = v104
                        v116.C0 = CFrame.new(0, 0, 0)
                        v116.Name = v116.Part1.Name .. " Weld"
                        v116.Parent = v116.Part1
                        v104.Transparency = 1
                    end
                end
            end
        elseif v103:IsA("BasePart") then
            local v117 = v103:GetAttribute("OrgBodyPartName")
            if v117 then
                local v118 = Instance.new("Weld")
                v118.Part0 = p89:FindFirstChild(v117)
                v118.Part1 = v103
                v118.Name = v117 .. " Weld"
                v118.Parent = v103
            end
        end
    end
    table.clear(v97)
    local v119 = v92:GetDescendants()
    for v120 = 1, #v119 do
        if v119[v120]:IsA("BasePart") then
            v119[v120].Anchored = false
            v119[v120].Massless = true
            v119[v120].CanCollide = false
            v119[v120].CanQuery = false
        end
    end
    pcall(function() --[[ Line: 272 ]]
        --[[
        Upvalues:
            [1] = u88
        --]]
        _G.destroy(u88, 3)
    end)
    v92.Parent = p89
    return v92
end
function u1.ScaleSize2(_, u121, p122, p123, u124) --[[ Line: 280 ]]
    --[[
    Upvalues:
        [1] = u76
    --]]
    u121.Name = u121.Name
    u121.Parent = p122
    pcall(function() --[[ Line: 284 ]]
        --[[
        Upvalues:
            [1] = u124
            [2] = u121
        --]]
        if u124 == nil then
            _G.destroy(u121, 3)
        end
    end)
    u76(u121, p123, u121:GetModelCFrame().Position)
    for _, v125 in u121:GetChildren() do
        local v126 = v125:GetChildren()
        local v127 = v125
        for v128 = 1, #v126 do
            if v126[v128]:IsA("BasePart") then
                local v129 = Instance.new("Weld")
                v129.Part0 = v125.Middle
                v129.Part1 = v126[v128]
                local v130 = CFrame.new(v125.Middle.Position)
                local v131 = v125.Middle.CFrame:inverse() * v130
                local v132 = v126[v128].CFrame:inverse() * v130
                v129.C0 = v131
                v129.C1 = v132
                v129.Parent = v125.Middle
            elseif v126[v128]:IsA("Bone") then
                v126[v128].Position = v126[v128].Position * p123
            end
            if u124 == nil then
                local v133 = Instance.new("Weld")
                v133.Part0 = p122:FindFirstChild(v127.Name)
                if v125:FindFirstChild("Middle") then
                    v133.Part1 = v125.Middle
                elseif v125:IsA("Model") and v125.PrimaryPart ~= nil then
                    v133.Part1 = v125.PrimaryPart
                end
                v133.C0 = CFrame.new(0, 0, 0)
                v133.Parent = v133.Part1
                if v125:FindFirstChild("Middle") then
                    v125.Middle.Transparency = 1
                end
            end
        end
    end
    local v134 = u121:GetDescendants()
    for v135 = 1, #v134 do
        if v134[v135]:IsA("BasePart") then
            v134[v135].Anchored = false
        end
    end
    return u121
end
return u1