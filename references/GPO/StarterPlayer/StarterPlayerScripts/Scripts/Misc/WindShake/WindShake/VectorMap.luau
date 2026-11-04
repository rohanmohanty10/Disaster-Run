 

local u1 = {}
u1.__index = u1
function u1.new(p2) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = u1
    return setmetatable({
        ["_voxelSize"] = p2 or 50,
        ["_voxels"] = {}
    }, v3)
end
function u1._debugDrawVoxel(p4, p5) --[[ Line: 13 ]]
    local v6 = Instance.new("Part")
    v6.Name = tostring(p5)
    v6.Anchored = true
    v6.CanCollide = false
    v6.Transparency = 1
    v6.Size = Vector3.new(1, 1, 1) * p4._voxelSize
    v6.Position = p5 * p4._voxelSize + Vector3.new(1, 1, 1) * (p4._voxelSize / 2)
    v6.Parent = workspace
    local v7 = Instance.new("SelectionBox")
    v7.Color3 = Color3.new(0, 0, 1)
    v7.Adornee = v6
    v7.Parent = v6
    task.delay(0.03333333333333333, v6.Destroy, v6)
end
function u1.AddObject(p8, p9, p10) --[[ Line: 31 ]]
    local v11 = p10.ClassName
    local v12 = p8._voxelSize
    local v13 = p9.X / v12
    local v14 = math.floor(v13)
    local v15 = p9.Y / v12
    local v16 = math.floor(v15)
    local v17 = p9.Z / v12
    local v18 = math.floor(v17)
    local v19 = Vector3.new(v14, v16, v18)
    local v20 = p8._voxels[v19]
    if v20 == nil then
        p8._voxels[v19] = {
            [v11] = { p10 }
        }
        return v19
    end
    if v20[v11] == nil then
        v20[v11] = { p10 }
        return v19
    end
    local v21 = v20[v11]
    table.insert(v21, p10)
    return v19
end
function u1.RemoveObject(p22, p23, p24) --[[ Line: 56 ]]
    local v25 = p22._voxels[p23]
    if v25 == nil then
        return
    end
    local v26 = p24.ClassName
    if v25[v26] == nil then
        return
    end
    local v27 = v25[v26]
    for v28, v29 in v27 do
        if v29 == p24 then
            local v30 = #v27
            v27[v28] = v27[v30]
            v27[v30] = nil
            break
        end
    end
    if #v27 == 0 then
        v25[v26] = nil
        if next(v25) == nil then
            p22._voxels[p23] = nil
        end
    end
end
function u1.GetVoxel(p31, p32) --[[ Line: 90 ]]
    return p31._voxels[p32]
end
function u1.ForEachObjectInRegion(p33, p34, p35, p36) --[[ Line: 94 ]]
    local v37 = p33._voxelSize
    local v38 = p35.X
    local v39 = p34.X
    local v40 = math.min(v38, v39)
    local v41 = p35.Y
    local v42 = p34.Y
    local v43 = math.min(v41, v42)
    local v44 = p35.Z
    local v45 = p34.Z
    local v46 = math.min(v44, v45)
    local v47 = p35.X
    local v48 = p34.X
    local v49 = math.max(v47, v48)
    local v50 = p35.Y
    local v51 = p34.Y
    local v52 = math.max(v50, v51)
    local v53 = p35.Z
    local v54 = p34.Z
    local v55 = math.max(v53, v54)
    local v56 = v40 / v37
    local v57 = math.floor(v56)
    local v58 = v49 / v37
    for v59 = v57, math.floor(v58) do
        local v60 = v46 / v37
        local v61 = math.floor(v60)
        local v62 = v55 / v37
        for v63 = v61, math.floor(v62) do
            local v64 = v43 / v37
            local v65 = math.floor(v64)
            local v66 = v52 / v37
            for v67 = v65, math.floor(v66) do
                local v68 = p33._voxels[Vector3.new(v59, v67, v63)]
                if v68 then
                    for v69, v70 in v68 do
                        for _, v71 in v70 do
                            p36(v69, v71)
                        end
                    end
                end
            end
        end
    end
end
function u1.ForEachObjectInView(p72, p73, p74, p75) --[[ Line: 117 ]]
    local v76 = p72._voxelSize
    local v77 = p73.CFrame
    local u78 = v77.Position
    local v79 = v77.RightVector
    local v80 = v77.UpVector
    local u81 = p74 / 2
    local v82 = (p73.FieldOfView + 5) / 2
    local v83 = math.rad(v82)
    local u84 = math.tan(v83) * p74
    local u85 = u84 * (p73.ViewportSize.X / p73.ViewportSize.Y)
    local v86 = v77 * CFrame.new(0, 0, -p74)
    local v87 = -u85
    local v88 = v86 * Vector3.new(v87, u84, 0)
    local v89 = v86 * Vector3.new(u85, u84, 0)
    local v90 = -u85
    local v91 = -u84
    local v92 = v86 * Vector3.new(v90, v91, 0)
    local v93 = -u84
    local v94 = v86 * Vector3.new(u85, v93, 0)
    local u95 = (v77 * CFrame.new(0, 0, -u81)):Inverse()
    local u96 = v80:Cross(v94 - u78).Unit
    local u97 = v80:Cross(v92 - u78).Unit
    local u98 = v79:Cross(u78 - v89).Unit
    local u99 = v79:Cross(u78 - v94).Unit
    local v100 = u78:Min(v88):Min(v89):Min(v92):Min(v94)
    local v101 = u78:Max(v88):Max(v89):Max(v92):Max(v94)
    local v102 = v100.X / v76
    local v103 = math.floor(v102)
    local v104 = v100.Y / v76
    local v105 = math.floor(v104)
    local v106 = v100.Z / v76
    local v107 = math.floor(v106)
    local v108 = Vector3.new(v103, v105, v107)
    local v109 = v101.X / v76
    local v110 = math.floor(v109)
    local v111 = v101.Y / v76
    local v112 = math.floor(v111)
    local v113 = v101.Z / v76
    local v114 = math.floor(v113)
    local v115 = Vector3.new(v110, v112, v114)
    local function v119(p116) --[[ Line: 155 ]]
        --[[
        Upvalues:
            [1] = u95
            [2] = u85
            [3] = u84
            [4] = u81
            [5] = u78
            [6] = u96
            [7] = u97
            [8] = u98
            [9] = u99
        --]]
        local v117 = u95 * p116
        if u85 < v117.X or (v117.X < -u85 or (u84 < v117.Y or (v117.Y < -u84 or (u81 < v117.Z or v117.Z < -u81)))) then
            return false
        end
        local v118 = p116 - u78
        return u96:Dot(v118) >= 0 and (u97:Dot(v118) <= 0 and (u98:Dot(v118) >= 0 and u99:Dot(v118) <= 0))
    end
    for v120 = v108.X, v115.X do
        local v121 = v120 * v76
        local v122 = v121 + v76
        local v123 = v86.X
        local v124 = math.clamp(v123, v121, v122)
        for v125 = v108.Y, v115.Y do
            local v126 = v125 * v76
            local v127 = v126 + v76
            local v128 = v86.Y
            local v129 = math.clamp(v128, v126, v127)
            for v144 = v108.Z, v115.Z do
                local v131 = v144 * v76
                local v132 = v131 + v76
                local v133 = v86.Z
                local v134 = math.clamp(v133, v131, v132)
                if v119((Vector3.new(v124, v129, v134))) then
                    local v135 = v108.Z - 1
                    local v136 = v115.Z
                    local v137 = v144
                    while v144 <= v136 do
                        local v138 = (v144 + v136) / 2
                        local v139 = math.floor(v138)
                        local v140 = v86.Z
                        local v141 = v139 * v76
                        local v142 = v139 * v76 + v76
                        local v143 = math.clamp(v140, v141, v142)
                        if v119((Vector3.new(v124, v129, v143))) then
                            local v144 = v139 + 1
                        else
                            v136 = v139 - 1
                            v139 = v135
                        end
                        v135 = v139
                    end
                    for v145 = v137, v135 do
                        local v146 = p72._voxels[Vector3.new(v120, v125, v145)]
                        if v146 then
                            for v147, v148 in v146 do
                                for _, v149 in v148 do
                                    p75(v147, v149)
                                end
                            end
                        end
                    end
                    break
                end
            end
        end
    end
end
function u1.ClearAll(p150) --[[ Line: 238 ]]
    p150._voxels = {}
end
return u1