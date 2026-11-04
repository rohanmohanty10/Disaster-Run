 

local u1 = game:GetService("RunService")
local u2 = game:GetService("HttpService")
require(script:WaitForChild("Curves"))
local u3 = require(script:WaitForChild("Draw"))
local u4 = {
    ["Stack"] = {}
}
u4.__index = u4
function u4.Initalize(u5) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1.Heartbeat:Connect(function(p6) --[[ Line: 16 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        u5:Step(p6)
    end)
end
function u4.new(u7) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local v8 = {
        ["Life"] = 0,
        ["Lifetime"] = u7.Lifetime,
        ["Properties"] = u7
    }
    local v9 = u4
    local u10 = setmetatable(v8, v9)
    local u11 = Color3.new()
    local u12 = 0
    local u13 = 0
    local u79 = {
        ["Colors"] = function(_, _, u14) --[[ Line: 41 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u11
            --]]
            local function v27(p15, p16, p17) --[[ Line: 61 ]]
                local v18 = Color3.new
                local v19 = p15.R
                local v20 = p16.R
                local v21 = v19 * (1 - p17) + v20 * p17
                local v22 = p15.G
                local v23 = p16.G
                local v24 = v22 * (1 - p17) + v23 * p17
                local v25 = p15.B
                local v26 = p16.B
                return v18(v21, v24, v25 * (1 - p17) + v26 * p17)
            end
            local v34 = (function() --[[ Name: ClosestAlpha, Line 42 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u14
                --]]
                local v28 = nil
                local v29 = nil
                for v30, v31 in u7.Colors do
                    if v28 then
                        local v32 = u14 - v31.Time
                        if math.abs(v32) < v28 then
                            goto l4
                        end
                    else
                        ::l4::
                        local v33 = u14 - v31.Time
                        v28 = math.abs(v33)
                        if v30 > 1 and (u14 > v31.Time and v30 + 1 <= #u7.Colors) then
                            v29 = v30 + 1
                        else
                            v29 = v30
                        end
                    end
                end
                return v29
            end)()
            if v34 then
                local v35 = v34 == 1
                local v36 = v35 and v34 and v34 or v34 - 1
                if v35 then
                    v34 = v34 + 1 or v34
                end
                local v37 = u7.Colors[v36]
                local v38 = u7.Colors[v34]
                local v39 = v37.Time - v38.Time
                local v40 = (u14 - v37.Time) / v39
                local v41 = math.abs(v40)
                u11 = v27(v37.Value, v38.Value, v41)
            end
        end,
        ["Sizes"] = function(_, _, u42) --[[ Line: 93 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u13
            --]]
            local v49 = (function() --[[ Name: ClosestAlpha, Line 94 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u42
                --]]
                local v43 = nil
                local v44 = nil
                for v45, v46 in u7.Sizes do
                    if v43 then
                        local v47 = u42 - v46.Time
                        if math.abs(v47) < v43 then
                            goto l4
                        end
                    else
                        ::l4::
                        local v48 = u42 - v46.Time
                        v43 = math.abs(v48)
                        if v45 > 1 and (u42 > v46.Time and v45 + 1 <= #u7.Sizes) then
                            v44 = v45 + 1
                        else
                            v44 = v45
                        end
                    end
                end
                return v44
            end)()
            if v49 then
                local v50 = v49 == 1
                local v51 = v50 and v49 and v49 or v49 - 1
                if v50 then
                    v49 = v49 + 1 or v49
                end
                local v52 = u7.Sizes[v51]
                local v53 = u7.Sizes[v49]
                local v54 = v53.Size - v52.Size
                local v55 = v53.Time - v52.Time
                local v56 = (u42 - v52.Time) / v55
                local v57 = math.abs(v56)
                u13 = v52.Size + v54 * v57
            end
        end,
        ["Transparency"] = function(_, _, u58) --[[ Line: 135 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u12
            --]]
            local v65 = (function() --[[ Name: ClosestAlpha, Line 136 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u58
                --]]
                local v59 = nil
                local v60 = nil
                for v61, v62 in u7.Transparencies do
                    if v59 then
                        local v63 = u58 - v62.Time
                        if math.abs(v63) < v59 then
                            goto l4
                        end
                    else
                        ::l4::
                        local v64 = u58 - v62.Time
                        v59 = math.abs(v64)
                        if v61 > 1 and (u58 > v62.Time and v61 + 1 <= #u7.Transparencies) then
                            v60 = v61 + 1
                        else
                            v60 = v61
                        end
                    end
                end
                return v60
            end)()
            if v65 then
                local v66 = v65 == 1
                local v67 = v66 and v65 and v65 or v65 - 1
                if v66 then
                    v65 = v65 + 1 or v65
                end
                local v68 = u7.Transparencies[v67]
                local v69 = u7.Transparencies[v65]
                local v70 = v69.Transparency - v68.Transparency
                local v71 = v69.Time - v68.Time
                local v72 = (u58 - v68.Time) / v71
                local v73 = math.abs(v72)
                u12 = v68.Transparency + v70 * v73
            end
        end,
        ["Points"] = function(p74, p75, _) --[[ Line: 177 ]]
            for _, v76 in p74.Properties.Points do
                local v77 = v76.LastLockedPos and v76.LockToPart.Position - v76.LastLockedPos or Vector3.new()
                local v78 = v76.Position + v77
                v76.Velocity = v76.Velocity:Lerp(Vector3.new(), v76.Drag * p75) + v76.Acceleration * p75
                v76.Position = v78 + v76.Velocity * p75
                if v76.LockToPart then
                    v76.LastLockedPos = v76.LockToPart.Position
                end
            end
        end
    }
    local v80 = u10.Properties.DrawType
    if v80 == "Singular" then
        local v81 = u10.Properties.ArcSize
        u10.SegmentHandler = u10:DrawSingularSegments(v81.Min, v81.Max, u12, u11, u13)
    elseif v80 == "Multiple" then
        u10.SegmentHandler = u10:DrawMultipleSegments(u12, u11, u13)
    end
    local u82 = u2:GenerateGUID(false)
    u4.Stack[u82] = function(p83) --[[ Line: 204 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u79
            [3] = u12
            [4] = u11
            [5] = u13
            [6] = u4
            [7] = u82
        --]]
        u10.Life = u10.Life + p83
        if u10.Life <= u10.Lifetime then
            local v84 = u10.Life / u10.Lifetime
            for _, v85 in u79 do
                u10:Thread(v85, u10, p83, v84)
            end
            u10:UpdateSegments(p83, u12, u11, u13)
        else
            u10:WipeSegments()
            u4.Stack[u82] = nil
        end
    end
    return u10
end
function u4.DrawSingularSegments(u86, u87, u88, p89, p90, p91) --[[ Line: 226 ]]
    local u92 = Random.new()
    local function u167(p93, p94, p95, p96, p97) --[[ Line: 229 ]]
        --[[
        Upvalues:
            [1] = u92
            [2] = u87
            [3] = u88
            [4] = u86
        --]]
        local v98 = p94 - p93
        local v99 = v98.Magnitude
        local v100 = v98.Unit
        local v101 = p93 + 0.25 * v99 * v100
        local v102 = p93 + 0.5 * v99 * v100
        local v103 = p93 + 0.75 * v99 * v100
        local v104 = (p93 - v101).Magnitude
        local v105 = (v101 - v102).Magnitude
        local v106 = (v102 - v103).Magnitude
        local v107 = u92:NextNumber(u87, u88)
        local v108 = u86.Properties.ChangesSegmentOffset
        if v108 then
            local v109 = u86.Properties.OffsetChangePercent.Bounds
            v108 = u86.Properties.OffsetChangePercent.EqualOrBelow >= u92:NextNumber(unpack(v109))
        end
        if not p95 or (not p96 or (not p97 or v108)) then
            local v110 = u92
            local v111 = -v107
            local v112 = -v107 * v104
            local v113 = math.max(v111, v112)
            local v114 = v107 * v104
            local v115 = v110:NextNumber(v113, (math.min(v107, v114)))
            local v116 = u92
            local v117 = -v107
            local v118 = -v107 * v104
            local v119 = math.max(v117, v118)
            local v120 = v107 * v104
            local v121 = v116:NextNumber(v119, (math.min(v107, v120)))
            local v122 = u92
            local v123 = -v107
            local v124 = -v107 * v104
            local v125 = math.max(v123, v124)
            local v126 = v107 * v104
            local v127 = math.min(v107, v126)
            p95 = Vector3.new(v115, v121, v122:NextNumber(v125, v127))
            local v128 = u92
            local v129 = -v107
            local v130 = -v107 * v105
            local v131 = math.max(v129, v130)
            local v132 = v107 * v105
            local v133 = v128:NextNumber(v131, (math.min(v107, v132)))
            local v134 = u92
            local v135 = -v107
            local v136 = -v107 * v105
            local v137 = math.max(v135, v136)
            local v138 = v107 * v105
            local v139 = v134:NextNumber(v137, (math.min(v107, v138)))
            local v140 = u92
            local v141 = -v107
            local v142 = -v107 * v105
            local v143 = math.max(v141, v142)
            local v144 = v107 * v105
            local v145 = math.min(v107, v144)
            p96 = Vector3.new(v133, v139, v140:NextNumber(v143, v145))
            local v146 = u92
            local v147 = -v107
            local v148 = -v107 * v106
            local v149 = math.max(v147, v148)
            local v150 = v107 * v106
            local v151 = v146:NextNumber(v149, (math.min(v107, v150)))
            local v152 = u92
            local v153 = -v107
            local v154 = -v107 * v106
            local v155 = math.max(v153, v154)
            local v156 = v107 * v106
            local v157 = v152:NextNumber(v155, (math.min(v107, v156)))
            local v158 = u92
            local v159 = -v107
            local v160 = -v107 * v106
            local v161 = math.max(v159, v160)
            local v162 = v107 * v106
            local v163 = math.min(v107, v162)
            p97 = Vector3.new(v151, v157, v158:NextNumber(v161, v163))
        end
        local v164 = v101 + p95
        local v165 = v102 + p96
        local v166 = v103 + p97
        return {
            {
                ["Distance"] = (v164 - p93).Magnitude,
                ["Direction"] = CFrame.new(p93, v164)
            },
            {
                ["Distance"] = (v165 - v164).Magnitude,
                ["Direction"] = CFrame.new(v164, v165)
            },
            {
                ["Distance"] = (v166 - v165).Magnitude,
                ["Direction"] = CFrame.new(v165, v166)
            },
            {
                ["Distance"] = (p94 - v166).Magnitude,
                ["Direction"] = CFrame.new(v166, p94)
            }
        }, { p95, p96, p97 }
    end
    local v168, u169 = u167(u86.Properties.Points.Start.Position, u86.Properties.Points.End.Position)
    local u170 = {}
    for v171, v172 in v168 do
        local v173 = Instance.new("Part")
        v173.Anchored = true
        v173.CanCollide = false
        v173.CastShadow = false
        v173.Color = p90
        v173.Transparency = p89
        v173.Material = Enum.Material.Neon
        v173.Size = Vector3.new(0.2, 0.2, 0.2)
        local v174 = Instance.new("SpecialMesh")
        v174.Name = "Mesh"
        v174.MeshType = Enum.MeshType.Brick
        v174.Scale = Vector3.new(0.2, 0.2, 1)
        v174.Offset = Vector3.new(0, 0, 0)
        v174.VertexColor = Vector3.new(1, 1, 1)
        v174.Parent = v173
        local v175 = v172.Distance / 1
        v174.Scale = Vector3.new(p91, p91, v175) * 5
        v173.CFrame = v172.Direction * CFrame.new(0, 0, -0.5 * v172.Distance)
        v173.Parent = workspace.CurrentCamera
        table.insert(u170, v171, {
            ["Instance"] = v173,
            ["Mesh"] = v174
        })
    end
    local u176 = u169
    return {
        ["Update"] = function(_, p177, p178, p179, p180, p181, p182) --[[ Name: Update, Line 341 ]]
            --[[
            Upvalues:
                [1] = u167
                [2] = u169
                [3] = u176
                [4] = u170
            --]]
            local v183 = u169
            local v184, v185 = u167(p178, p179, unpack(v183))
            local v186 = false
            for v187, v188 in v185 do
                if u169[v187] ~= v188 then
                    v186 = true
                end
            end
            if v186 then
                u176 = v185
                local v189 = u176
                v184 = u167(p178, p179, unpack(v189))
            end
            for v190, v191 in u176 do
                local v192 = u169
                local v193 = u169[v190]
                local v194 = p177 * 10
                v192[v190] = v193:Lerp(v191, (math.min(v194, 1)))
            end
            for v195, v196 in v184 do
                local v197 = u170[v195]
                local v198 = v197.Mesh
                local v199 = v196.Distance / 1
                v198.Scale = Vector3.new(p182, p182, v199) * 5
                v197.Instance.Color = p181
                v197.Instance.Transparency = p180
                v197.Instance.CFrame = v196.Direction * CFrame.new(0, 0, -0.5 * v196.Distance)
            end
        end,
        ["Destroy"] = function(_) --[[ Name: Destroy, Line 374 ]]
            --[[
            Upvalues:
                [1] = u170
            --]]
            for _, v200 in u170 do
                v200.Instance:Destroy()
            end
        end
    }
end
function u4.DrawMultipleSegments(p201, p202, p203, p204) --[[ Line: 384 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v205 = p201.Properties.Points.Start.Position
    local v206 = p201.Properties.Points.End.Position
    local u207 = u3.new(v205, v206, {
        ["color"] = p203,
        ["thickness"] = p204,
        ["transparency"] = p202,
        ["seed"] = p201.Properties.Seed,
        ["bends"] = p201.Properties.Bends,
        ["fork_bends"] = p201.Properties.Fork_Bends,
        ["fork_chance"] = p201.Properties.Fork_Chance,
        ["max_depth"] = p201.Properties.Max_Depth
    })
    u207:Draw(workspace.CurrentCamera)
    return {
        ["Update"] = function(_, _, p208, p209, p210, p211, p212) --[[ Name: Update, Line 403 ]]
            --[[
            Upvalues:
                [1] = u207
            --]]
            u207:Update(p208, p209, p210, p211, p212)
        end,
        ["Destroy"] = function(_) --[[ Name: Destroy, Line 407 ]]
            --[[
            Upvalues:
                [1] = u207
            --]]
            u207:Destroy()
        end
    }
end
function u4.UpdateSegments(p213, p214, p215, p216, p217) --[[ Line: 415 ]]
    if p213.SegmentHandler then
        local v218 = p213.Properties.Points.Start.Position
        local v219 = p213.Properties.Points.End.Position
        p213.SegmentHandler:Update(p214, v218, v219, p215, p216, p217)
    end
end
function u4.WipeSegments(p220) --[[ Line: 424 ]]
    if p220.SegmentHandler then
        p220.SegmentHandler:Destroy()
        p220.SegmentHandler = nil
    end
end
function u4.Thread(_, u221, ...) --[[ Line: 431 ]]
    local u222 = table.pack(...)
    return coroutine.resume(coroutine.create(function() --[[ Line: 434 ]]
        --[[
        Upvalues:
            [1] = u221
            [2] = u222
        --]]
        local v223 = u222
        u221(table.unpack(v223))
    end))
end
function u4.Step(p224, p225) --[[ Line: 439 ]]
    for _, v226 in p224.Stack do
        p224:Thread(v226, p225)
    end
end
u4:Initalize()
return u4