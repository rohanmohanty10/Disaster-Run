 

local u1 = require(script.Parent:WaitForChild("InstanceHandler"))
local u2 = require(script.Parent:WaitForChild("Modes"))
game:GetService("TweenService")
local u3 = game:GetService("PhysicsService")
local u4 = RaycastParams.new()
local u5 = Random.new()
u1.new(Instance.new("Part"), 250, "DebrisCache")
u4.FilterType = Enum.RaycastFilterType.Whitelist
u4.IgnoreWater = true
local function u11(p6, p7) --[[ Line: 44 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v8 = u1.getInstance(p6 or "Part") or Instance.new(p6)
    for v9, v10 in next, p7 do
        if v9 ~= "Parent" or v9 ~= "ObjectName" then
            v8[v9] = v10
        end
    end
    return v8
end
local function u15(p12, p13) --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    u4.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
    local v14 = workspace:Raycast(p12.Position, p13, u4)
    if v14 then
        return v14.Instance, v14.Position, v14.Material, v14.Normal
    else
        return false
    end
end
local function u29(p16, p17, p18) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u11
    --]]
    local v19, v20, v21, _ = u15(p16, -p16.UpVector * p17)
    if v19 then
        local v22 = u11
        local v23 = "Part"
        local v24 = {
            ["Anchored"] = true,
            ["CanCollide"] = false,
            ["Material"] = v21,
            ["Size"] = p18,
            ["Color"] = v19.Color,
            ["Reflectance"] = v19.Reflectance,
            ["Transparency"] = v19.Transparency
        }
        local v25
        if typeof(v20) == "Vector3" then
            v25 = CFrame.new(v20)
        else
            v25 = v20
        end
        v24.CFrame = v25
        local v26 = v22(v23, v24)
        for _, v27 in ipairs(v26:GetChildren()) do
            v27:Destroy()
        end
        for _, v28 in ipairs(v19:GetChildren()) do
            if v28:IsA("Texture") then
                v28:Clone().Parent = v26
            end
        end
        return v26, v20
    end
end
local function u32(p30, p31) --[[ Line: 90 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    return u5:NextNumber(p30, p31)
end
local function u41(p33, p34, p35, _) --[[ Line: 95 ]]
    local v36 = {}
    for v37 = 1, p35 + 1 do
        local v38 = v37 * (6.283185307179586 / p35)
        local v39 = math.cos(v38) * p34
        local v40 = math.sin(v38) * p34
        v36[v37] = p33 * Vector3.new(v39, 0, v40)
    end
    return v36
end
return {
    ["Crater"] = function(p42, p43) --[[ Line: 109 ]]
        --[[
        Upvalues:
            [1] = u41
            [2] = u5
            [3] = u29
            [4] = u32
            [5] = u2
            [6] = u1
        --]]
        local v44 = p43.BlockSize or { 2, 3.5 }
        local v45 = p43.PartCount or 10
        local v46 = p43.Radius or 8
        local v47 = p43.Range or 5
        local v48 = p43.Angle or { 45, 65 }
        local v49 = p43.Height or { 0, 0 }
        local v50 = p43.Tilt or { 0, 0 }
        local v51 = p43.PartOffset or { 0, 0 }
        local u52 = p43.FlourishTypes or {}
        local v53 = p43.IterateSpeed or {}
        local v54 = p43.CircleComplete or 1
        local v55 = u41(p42, v46, v45)
        local v56 = #v55 * v54 + 0.5
        local u57 = {}
        local v58 = 1
        for v59 = 1, math.floor(v56) do
            if v55[v59 + 1] ~= nil then
                local v60 = v55[v59]
                local v61 = (v60 - v55[v59 + 1]).Magnitude
                local v62 = u5:NextNumber(v44[1], v44[2])
                local v63 = v61 + 0.5
                local v64 = Vector3.new(v63, v62, v62)
                local v65 = u29
                if typeof(v60) == "Vector3" then
                    v60 = CFrame.new(v60)
                end
                local u66, _ = v65(v60, v47, v64)
                if u66 then
                    local v67 = CFrame.lookAt
                    local v68 = u66.Position
                    local v69 = p42.X
                    local v70 = p42.Z
                    local v71 = v67(v68, (Vector3.new(v69, 0, v70))) * CFrame.new(0, u5:NextNumber(v49[1], v49[2]), u32(v51[1], v51[2]))
                    local v72 = CFrame.fromEulerAnglesXYZ
                    local v73 = u5:NextNumber(v48[1], v48[2])
                    local v74 = math.rad(v73)
                    local v75 = u5:NextNumber(v50[1], v50[2])
                    local v76 = {
                        ["CFrame"] = v71 * v72(v74, math.rad(v75), 0)
                    }
                    local v77 = CFrame.lookAt
                    local v78 = u66.Position
                    local v79 = p42.X
                    local v80 = p42.Z
                    u66.CFrame = v77(v78, (Vector3.new(v79, 0, v80)))
                    task.spawn(function() --[[ Line: 141 ]]
                        --[[
                        Upvalues:
                            [1] = u57
                            [2] = u66
                        --]]
                        u57[#u57 + 1] = u66
                    end)
                    u2[u52.Entrance or "Enlarge"](u66, u52.EntranceSpeed or 0.3, v76)
                    if v53.Entrance then
                        if v53.EntranceDivision == "Iterate" then
                            if v53.Entrance == "Stepped" then
                                task.wait()
                            else
                                task.wait(v53.Entrance)
                            end
                        else
                            local v81 = #v55 * v54 + 0.5
                            local v82 = (math.floor(v81) - 1) * (v58 / (v53.EntranceDivision or 3))
                            if math.floor(v82) == v59 then
                                local v83 = #v55 * v54 + 0.5
                                if v59 ~= math.floor(v83) - 1 then
                                    if v53.Entrance == "Stepped" then
                                        task.wait()
                                    else
                                        task.wait(v53.Entrance)
                                    end
                                    v58 = v58 + 1
                                end
                            end
                        end
                    end
                end
            end
        end
        task.wait(p43.HoldTime or 5)
        local v84 = 1
        for u85 = 1, #u57 do
            u2[u52.Exit or "Shrink"](u57[u85], u52.ExitSpeed or 0.3)
            if v53.Exit then
                if v53.ExitDivision == "Iterate" then
                    if v53.Exit == "Stepped" then
                        task.wait()
                    else
                        task.wait(v53.Exit)
                    end
                else
                    local v86 = #u57 * (v84 / (v53.ExitDivision or 2))
                    if math.floor(v86) == u85 and u85 ~= #u57 then
                        if v53.Exit == "Stepped" then
                            task.wait()
                        else
                            task.wait(v53.Exit)
                        end
                        v84 = v84 + 1
                    end
                end
            end
            task.spawn(function() --[[ Line: 186 ]]
                --[[
                Upvalues:
                    [1] = u52
                    [2] = u1
                    [3] = u57
                    [4] = u85
                --]]
                task.wait((u52.ExitSpeed or 0.3) + 0.15)
                u1.returnInstance("Part", u57[u85])
            end)
        end
    end,
    ["ChunkCrater"] = function(p87, p88) --[[ Line: 193 ]]
        --[[
        Upvalues:
            [1] = u41
            [2] = u5
            [3] = u29
            [4] = u11
            [5] = u32
            [6] = u2
            [7] = u1
        --]]
        local v89 = p88.BlockSize or { 2, 3.5 }
        local v90 = p88.PartCount or 10
        local v91 = p88.Radius or 8
        local v92 = p88.Range or 5
        local v93 = p88.Angle or { 45, 65 }
        local v94 = p88.Height or { 0, 0 }
        local v95 = p88.Tilt or { 0, 0 }
        local v96 = p88.PartOffset or { 0, 0 }
        local u97 = p88.FlourishTypes or {}
        local v98 = p88.IterateSpeed or {}
        local v99 = p88.CircleComplete or 1
        local v100 = u41(p87, v91, v90)
        local v101 = #v100 * v99 + 0.5
        local u102 = {}
        local v103 = 1
        local u104 = {}
        for v105 = 1, math.floor(v101) do
            if v100[v105 + 1] ~= nil then
                local v106 = v100[v105]
                local v107 = (v106 - v100[v105 + 1]).Magnitude
                local v108 = u5:NextNumber(v89[1], v89[2])
                local v109 = v107 + 0.5
                local v110 = Vector3.new(v109, v108, v108)
                local v111 = u29
                if typeof(v106) == "Vector3" then
                    v106 = CFrame.new(v106)
                end
                local v112 = v107 + 0.55
                local v113 = v108 + 0.05
                local u114, v115 = v111(v106, v92, (Vector3.new(v112, 0.5, v113)))
                if u114 then
                    local v116 = u11
                    local v117 = "Part"
                    local v118 = {
                        ["Anchored"] = true,
                        ["CanCollide"] = false,
                        ["Material"] = Enum.Material.Slate,
                        ["Size"] = v110,
                        ["Color"] = Color3.fromRGB(90, 76, 66)
                    }
                    if typeof(v115) == "Vector3" then
                        v115 = CFrame.new(v115)
                    end
                    v118.CFrame = v115
                    local u119 = v116(v117, v118)
                    local v120 = CFrame.lookAt
                    local v121 = u119.Position
                    local v122 = p87.X
                    local v123 = p87.Z
                    u119.CFrame = v120(v121, (Vector3.new(v122, 0, v123)))
                    u114.CFrame = u119.CFrame
                    local v124 = CFrame.lookAt
                    local v125 = u119.Position
                    local v126 = p87.X
                    local v127 = p87.Z
                    local v128 = v124(v125, (Vector3.new(v126, 0, v127))) * CFrame.new(0, u5:NextNumber(v94[1], v94[2]), u32(v96[1], v96[2]))
                    local v129 = CFrame.fromEulerAnglesXYZ
                    local v130 = u5:NextNumber(v93[1], v93[2])
                    local v131 = math.rad(v130)
                    local v132 = u5:NextNumber(v95[1], v95[2])
                    local v133 = v128 * v129(v131, math.rad(v132), 0)
                    task.spawn(function() --[[ Line: 238 ]]
                        --[[
                        Upvalues:
                            [1] = u104
                            [2] = u114
                            [3] = u102
                            [4] = u119
                        --]]
                        u104[#u104 + 1] = u114
                        u102[#u102 + 1] = u119
                    end)
                    u2[u97.Entrance or "Enlarge"](u119, u97.EntranceSpeed or 0.3, {
                        ["CFrame"] = v133
                    })
                    u2[u97.Entrance or "Enlarge"](u114, u97.EntranceSpeed or 0.3, {
                        ["CFrame"] = v133 * CFrame.new(0, v108 / 2 + 0.15, 0)
                    })
                    if v98.Entrance then
                        if v98.EntranceDivision == "Iterate" then
                            if v98.Entrance == "Stepped" then
                                task.wait()
                            else
                                task.wait(v98.Entrance)
                            end
                        else
                            local v134 = #v100 * v99 + 0.5
                            local v135 = (math.floor(v134) - 1) * (v103 / (v98.EntranceDivision or 3))
                            if math.floor(v135) == v105 then
                                local v136 = #v100 * v99 + 0.5
                                if v105 ~= math.floor(v136) - 1 then
                                    if v98.Entrance == "Stepped" then
                                        task.wait()
                                    else
                                        task.wait(v98.Entrance)
                                    end
                                    v103 = v103 + 1
                                end
                            end
                        end
                    end
                end
            end
        end
        task.wait(p88.HoldTime or 5)
        local v137 = 1
        for u138 = 1, #u104 do
            u2[u97.Exit or "Shrink"](u104[u138], u97.ExitSpeed or 0.3)
            u2[u97.Exit or "Shrink"](u102[u138], u97.ExitSpeed or 0.3)
            if v98.Exit then
                local v139 = #u104 * (v137 / (v98.ExitDivision or 2))
                if math.floor(v139) == u138 and u138 ~= #u104 then
                    if v98.Exit == "Stepped" then
                        task.wait()
                    else
                        task.wait(v98.Exit)
                    end
                    v137 = v137 + 1
                end
            end
            task.spawn(function() --[[ Line: 282 ]]
                --[[
                Upvalues:
                    [1] = u97
                    [2] = u1
                    [3] = u104
                    [4] = u138
                    [5] = u102
                --]]
                task.wait((u97.ExitSpeed or 0.3) + 0.15)
                u1.returnInstance("Part", u104[u138])
                u1.returnInstance("Part", u102[u138])
            end)
        end
    end,
    ["Orbit"] = function(p140, p141) --[[ Line: 290 ]]
        --[[
        Upvalues:
            [1] = u41
            [2] = u5
            [3] = u29
            [4] = u32
            [5] = u2
            [6] = u1
        --]]
        local v142 = p141.BlockSize or { 2, 3.5 }
        local v143 = p141.PartCount or 10
        local v144 = p141.Radius or 8
        local v145 = p141.Range or 5
        local v146 = p141.Angle or { 45, 65 }
        local v147 = p141.Height or { 0, 0 }
        local v148 = p141.Tilt or { 0, 0 }
        local v149 = p141.PartOffset or { 0, 0 }
        local u150 = p141.FlourishTypes or {}
        local v151 = p141.IterateSpeed or {}
        local v152 = p141.CircleComplete or 1
        local v153 = u41(p140, v144, v143)
        local v154 = #v153 * v152 + 0.5
        local u155 = {}
        local v156 = 1
        for v157 = 1, math.floor(v154) - 1 do
            local v158 = v153[v157]
            local v159 = u5:NextNumber(v142[1], v142[2])
            local v160 = u29
            if typeof(v158) == "Vector3" then
                v158 = CFrame.new(v158)
            end
            local u161, _ = v160(v158, v145, (Vector3.new(v159, v159, v159)))
            if u161 then
                local v162 = CFrame.lookAt
                local v163 = u161.Position
                local v164 = p140.X
                local v165 = p140.Z
                local v166 = v162(v163, (Vector3.new(v164, 0, v165))) * CFrame.new(0, u5:NextNumber(v147[1], v147[2]), u32(v149[1], v149[2]))
                local v167 = CFrame.fromEulerAnglesXYZ
                local v168 = u5:NextNumber(v146[1], v146[2])
                local v169 = math.rad(v168)
                local v170 = u5:NextNumber(v148[1], v148[2])
                local v171 = {
                    ["CFrame"] = v166 * v167(v169, math.rad(v170), 0)
                }
                local v172 = CFrame.lookAt
                local v173 = u161.Position
                local v174 = p140.X
                local v175 = p140.Z
                u161.CFrame = v172(v173, (Vector3.new(v174, 0, v175)))
                task.spawn(function() --[[ Line: 316 ]]
                    --[[
                    Upvalues:
                        [1] = u155
                        [2] = u161
                    --]]
                    u155[#u155 + 1] = u161
                end)
                u2[u150.Entrance or "Enlarge"](u161, u150.EntranceSpeed or 0.3, v171)
                if v151.Entrance then
                    if v151.EntranceDivision == "Iterate" then
                        if v151.Entrance == "Stepped" then
                            task.wait()
                        else
                            task.wait(v151.Entrance)
                        end
                    else
                        local v176 = #v153 * v152 + 0.5
                        local v177 = (math.floor(v176) - 1) * (v156 / (v151.EntranceDivision or 3))
                        if math.floor(v177) == v157 then
                            local v178 = #v153 * v152 + 0.5
                            if v157 ~= math.floor(v178) - 1 then
                                if v151.Entrance == "Stepped" then
                                    task.wait()
                                else
                                    task.wait(v151.Entrance)
                                end
                                v156 = v156 + 1
                            end
                        end
                    end
                end
            end
        end
        task.wait(p141.HoldTime or 5)
        local v179 = 1
        for u180 = 1, #u155 do
            u2[u150.Exit or "Shrink"](u155[u180], u150.ExitSpeed or 0.3)
            if v151.Exit then
                if v151.ExitDivision == "Iterate" then
                    if v151.Exit == "Stepped" then
                        task.wait()
                    else
                        task.wait(v151.Exit)
                    end
                else
                    local v181 = #u155 * (v179 / (v151.ExitDivision or 2))
                    if math.floor(v181) == u180 and u180 ~= #u155 then
                        if v151.Exit == "Stepped" then
                            task.wait()
                        else
                            task.wait(v151.Exit)
                        end
                        v179 = v179 + 1
                    end
                end
            end
            task.spawn(function() --[[ Line: 362 ]]
                --[[
                Upvalues:
                    [1] = u150
                    [2] = u1
                    [3] = u155
                    [4] = u180
                --]]
                task.wait((u150.ExitSpeed or 0.3) + 0.15)
                u1.returnInstance("Part", u155[u180])
            end)
        end
    end,
    ["Path"] = function(p182, p183) --[[ Line: 369 ]]
        --[[
        Upvalues:
            [1] = u29
            [2] = u5
            [3] = u2
            [4] = u1
        --]]
        local v184 = p183.BlockSize or { 1.5, 2 }
        local v185 = p183.Distance or 15
        local v186 = p183.StepSize or v184[1]
        local v187 = p183.Width or { 1, 3 }
        local v188 = p183.Range or 5
        local v189 = p183.Angle or { -1000, 1000 }
        local v190 = p183.Height or { 0, 0 }
        local v191 = p183.Tilt or { -1000, 1000 }
        local v192 = p183.RightCurve and (-p183.RightCurve or 0) or 0
        local v193 = p183.LeftCurve or 0
        local v194 = p183.RightOffset or 0
        local v195 = p183.LeftOffset or 0
        local u196 = p183.FlourishTypes or {}
        local v197 = p183.IterateSpeed or {}
        local v198 = p182 * CFrame.new(v187[1], 0, 0)
        local v199 = p182 * CFrame.new(v187[2], 0, -v185)
        local v200 = p182 * CFrame.new(-v187[1], 0, 0)
        local v201 = p182 * CFrame.new(-v187[2], 0, -v185)
        local v202 = (v198.Position + v199.Position) / 2
        local v203 = (v200.Position + v201.Position) / 2
        local u204 = {}
        local v205 = 1
        local u206 = {}
        for v207 = 0, v185, v186 do
            local v208 = v187[1]
            local v209 = v187[2]
            local v210 = v207 / v185
            local _ = v208 + (v209 - v208) * v210
            local v211 = v184[1]
            local v212 = v184[2]
            local v213 = v207 / v185
            local v214 = v211 + (v212 - v211) * v213
            local v215 = u29
            local v216 = v207 / v185
            local v217 = v198.Position
            local v218 = (CFrame.lookAt(v202, v198.Position) * CFrame.new(v192, 0, v194)).Position
            local v219 = v199.Position
            local v220 = (1 - v216) ^ 2 * v217 + 2 * (1 - v216) * v216 * v218 + v216 ^ 2 * v219
            if typeof(v220) == "Vector3" then
                v220 = CFrame.new(v220)
            end
            local u221 = v215(v220, v188, (Vector3.new(v214, v214, v214)))
            local v222 = u29
            local v223 = v207 / v185
            local v224 = v200.Position
            local v225 = (CFrame.lookAt(v203, v200.Position) * CFrame.new(v193, 0, v195)).Position
            local v226 = v201.Position
            local v227 = (1 - v223) ^ 2 * v224 + 2 * (1 - v223) * v223 * v225 + v223 ^ 2 * v226
            if typeof(v227) == "Vector3" then
                v227 = CFrame.new(v227)
            end
            local u228 = v222(v227, v188, (Vector3.new(v214, v214, v214)))
            if u221 then
                local v229 = u5:NextNumber(v189[1], v189[2])
                local v230 = u5:NextNumber(v191[1], v191[2])
                local v231 = u221.CFrame * CFrame.new(0, u5:NextNumber(v190[1], v190[2]), 0) * CFrame.fromEulerAnglesXYZ(math.rad(v229), math.rad(v230), 0)
                local v232 = math.rad(v229)
                local v233 = math.rad(v230)
                u221.Orientation = Vector3.new(v232, v233, 0)
                u2[u196.Entrance or "Enlarge"](u221, u196.EntranceSpeed or 0.3, {
                    ["CFrame"] = v231
                })
            end
            if u228 then
                local v234 = u5:NextNumber(v189[1], v189[2])
                local v235 = u5:NextNumber(v191[1], v191[2])
                local v236 = u228.CFrame * CFrame.new(0, u5:NextNumber(v190[1], v190[2]), 0) * CFrame.fromEulerAnglesXYZ(math.rad(v234), math.rad(v235), 0)
                local v237 = math.rad(v234)
                local v238 = math.rad(v235)
                u228.Orientation = Vector3.new(v237, v238, 0)
                u2[u196.Entrance or "Enlarge"](u228, u196.EntranceSpeed or 0.3, {
                    ["CFrame"] = v236
                })
            end
            task.spawn(function() --[[ Line: 420 ]]
                --[[
                Upvalues:
                    [1] = u204
                    [2] = u221
                    [3] = u206
                    [4] = u228
                --]]
                u204[#u204 + 1] = u221
                u206[#u206 + 1] = u228
            end)
            if v197.Entrance then
                if v197.EntranceDivision == "Iterate" then
                    if v197.EntranceSpeed then
                        task.wait(v197.EntranceSpeed)
                    else
                        task.wait()
                    end
                else
                    local v239 = v185 * (v205 / (v197.EntranceDivision or 3))
                    if math.floor(v239) == v207 and v207 ~= v185 - 1 then
                        if v197.EntranceSpeed then
                            task.wait(v197.EntranceSpeed)
                        else
                            task.wait()
                        end
                        v205 = v205 + 1
                    end
                end
            end
        end
        task.wait(p183.HoldTime or 5)
        local v240 = 1
        for u241 = 1, #u204 do
            u2[u196.Exit or "Shrink"](u204[u241], u196.ExitSpeed or 0.3)
            u2[u196.Exit or "Shrink"](u206[u241], u196.ExitSpeed or 0.3)
            if v197.Exit then
                if v197.ExitDivision == "Iterate" then
                    if v197.Exit == "Stepped" then
                        task.wait()
                    else
                        task.wait(v197.Exit)
                    end
                else
                    local v242 = #u204 * (v240 / (v197.ExitDivision or 2))
                    if math.floor(v242) == u241 and u241 ~= #u204 then
                        if v197.Exit == "Stepped" then
                            task.wait()
                        else
                            task.wait(v197.Exit)
                        end
                        v240 = v240 + 1
                    end
                end
            end
            task.spawn(function() --[[ Line: 467 ]]
                --[[
                Upvalues:
                    [1] = u196
                    [2] = u1
                    [3] = u204
                    [4] = u241
                    [5] = u206
                --]]
                task.wait((u196.ExitSpeed or 0.3) + 0.15)
                u1.returnInstance("Part", u204[u241])
                u1.returnInstance("Part", u206[u241])
            end)
        end
    end,
    ["Break"] = function(p243, p244) --[[ Line: 475 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u32
            [3] = u29
            [4] = u3
            [5] = u2
            [6] = u1
        --]]
        local v245 = p244.BlockSize or { 0.25, 0.5 }
        local v246 = p244.PartCount or 10
        local v247 = p244.Radius or 8
        local v248 = p244.Width or { -8, 8 }
        local v249 = p244.Range or 5
        local v250 = p244.Angle or { 45, 65 }
        local v251 = p244.Height or { 0, 0 }
        local u252 = p244.FlourishTypes or {}
        local v253 = p244.IterateSpeed or {}
        local u254 = {}
        local v255 = 1
        for v256 = 1, v246 do
            local v257 = u5:NextNumber(v245[1], v245[2])
            local v258 = u5:NextNumber(v245[1], v245[2])
            local v259 = u32
            local v260 = v245[1]
            local v261 = v245[2]
            local v262 = Vector3.new(v257, v258, v259(v260, v261))
            local v263, _ = u29(p243 * CFrame.new(u5:NextNumber(-v247, v247), 0, u32(-v247, v247)), v249, v262)
            if v263 then
                u3:SetPartCollisionGroup(v263, "Blocks")
                v263.CFrame = v263.CFrame * CFrame.new(0, v263.Size.Y / 2, 0)
                v263.Anchored = false
                v263.CanCollide = true
                u254[#u254 + 1] = v263
                u2[u252.Entrance or "Enlarge"](v263, u252.EntranceSpeed or 0.3, {
                    ["CFrame"] = v263.CFrame
                })
                local v264 = Instance.new("BodyVelocity", v263)
                v264.MaxForce = Vector3.new(inf, inf, inf)
                v264.P = 100000
                local v265 = u5:NextNumber(v248[1], v248[2])
                local v266 = u5:NextNumber(v251[1], v251[2])
                local v267 = u32
                local v268 = v248[1]
                local v269 = v248[2]
                v264.Velocity = Vector3.new(v265, v266, v267(v268, v269))
                local v270 = Instance.new("BodyAngularVelocity", v263)
                local v271 = u5:NextNumber(-v250[1], v250[2])
                local v272 = u5:NextNumber(-v250[1], v250[2])
                local v273 = u32
                local v274 = -v250[1]
                local v275 = v250[2]
                v270.AngularVelocity = Vector3.new(v271, v272, v273(v274, v275))
                v270.MaxTorque = Vector3.new(inf, inf, inf)
                v270.P = 100000
                game:GetService("Debris"):AddItem(v264, 0.25)
                game:GetService("Debris"):AddItem(v270, 0.1)
                if v253.Entrance then
                    if v253.EntranceDivision == "Iterate" then
                        if v253.Entrance == "Stepped" then
                            task.wait()
                        else
                            task.wait(v253.Entrance)
                        end
                    else
                        local v276 = v246 * (v255 / (v253.EntranceDivision or 3)) + 0.5
                        if math.floor(v276) == v256 and v256 ~= v246 then
                            if v253.Entrance == "Stepped" then
                                task.wait()
                            else
                                task.wait(v253.Entrance)
                            end
                            v255 = v255 + 1
                        end
                    end
                end
            end
        end
        task.wait(p244.HoldTime or 5)
        local v277 = 1
        for u278 = 1, #u254 do
            u2[u252.Exit or "Shrink"](u254[u278], u252.ExitSpeed or 0.3)
            if v253.Exit then
                if v253.ExitDivision == "Iterate" then
                    if v253.Exit == "Stepped" then
                        task.wait()
                    else
                        task.wait(v253.Exit)
                    end
                else
                    local v279 = #u254 * (v277 / (v253.ExitDivision or 2))
                    if math.floor(v279) == u278 and u278 ~= #u254 then
                        if v253.Exit == "Stepped" then
                            task.wait()
                        else
                            task.wait(v253.Exit)
                        end
                        v277 = v277 + 1
                    end
                end
            end
            task.spawn(function() --[[ Line: 553 ]]
                --[[
                Upvalues:
                    [1] = u252
                    [2] = u1
                    [3] = u254
                    [4] = u278
                --]]
                task.wait((u252.ExitSpeed or 0.3) + 0.15)
                u1.returnInstance("Part", u254[u278])
            end)
        end
    end
}