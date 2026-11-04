 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v3 = game:GetService("Players")
if v2:IsClient() then
    v3.LocalPlayer.CharacterAdded:Wait()
end
local v4 = v1.Modules
local v5 = require(v4.DataStructures.Grids.RectGrid)
local v6 = require(v4.Data.OceanData)
local v7 = require(v4.DataStructures.Grids["2DPointGrid"])
local v8 = workspace:FindFirstChildOfClass("Terrain")
local u9 = v8:GetAttribute("SeaLevel")
local u10 = v8:GetAttribute("PlaneSize")
local v11 = v8:GetAttribute("OceanSize")
local _ = u10 / 2
local u12 = v1.Assets.ClientFX:WaitForChild("Wave4", 3)
local u13 = v5.new(100)
local v14 = v7.new(40)
local u15 = workspace:GetServerTimeNow()
local u16 = Instance.new("Model")
u16.Name = "OceanMeshes"
local v17 = Instance.new("Model")
local v18 = Instance.new("Humanoid")
v18.EvaluateStateMachine = false
v18.Parent = v17
v17.Name = "farPlaneMeshs"
v17.Parent = u16
warn("OCEAN MODULE REQUIRED")
local function u28(p19, p20, p21) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u28
    --]]
    if p20:IsA("Bone") then
        local v22 = p19.CFrame:Inverse() * p20.Parent.CFrame
        local v23 = v22 - v22.Position
        p20.Position = v23:Inverse() * (v23 * p20.Position * p21)
    end
    local v24 = next
    local v25, v26 = p20:GetChildren()
    for _, v27 in v24, v25, v26 do
        u28(p19, v27, p21)
    end
end
u28(u12, u12, u10 / u12.Size.X)
u12.Size = Vector3.new(u10, 0, u10)
local u29 = {}
local v75 = ({
    ["new"] = function(p30, p31) --[[ Name: new, Line 75 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u12
            [3] = u9
            [4] = u16
            [5] = u15
        --]]
        local v32 = u10
        local v33 = p31 / v32
        local v34 = math.ceil(v33) * v32 / u10
        local u35 = {}
        local v36 = {}
        for v37 = -v34 * 0.5, v34 * 0.5 do
            for v38 = -v34 * 0.5, v34 * 0.5 do
                local v39 = Instance.new("Model")
                local v40 = u12:Clone()
                local v41 = v37 * u10
                local v42 = v38 * u10
                v40.CFrame = CFrame.new(v41, u9, v42) * CFrame.Angles(0, 1.5707963267948966, 0)
                v40.Parent = v39
                v39.Parent = u16
                local v43 = {
                    ["Object"] = v40,
                    ["Vertices"] = {},
                    ["EdgeVertices"] = {},
                    ["X"] = v41,
                    ["Z"] = v42,
                    ["CFrame"] = v40.CFrame,
                    ["InverseCFrame"] = v40.CFrame:Inverse()
                }
                table.insert(u35, v43)
            end
        end
        for _, v44 in next, u35 do
            local v45 = v44.X
            local v46 = v44.Z
            local v47 = v44.Object.Size.X / 2
            local v48 = next
            local v49, v50 = v44.Object:GetChildren()
            for _, v51 in v48, v49, v50 do
                if v51:IsA("Bone") then
                    local v52 = v51.Position
                    local v53 = v52.X
                    local v54 = v52.Z
                    local v55 = false
                    local v56 = math.abs(v53) - v47
                    local v57
                    if math.abs(v56) < 1 then
                        v57 = true
                    else
                        local v58 = math.abs(v54) - v47
                        v57 = math.abs(v58) < 1 and true or v55
                    end
                    if v57 then
                        local v59 = v44.EdgeVertices
                        local v60 = {
                            v45 + v53,
                            v46 + v54,
                            v51,
                            v53,
                            v54
                        }
                        table.insert(v59, v60)
                    else
                        local v61 = {
                            v45 + v53,
                            v46 + v54,
                            v51,
                            u15,
                            0,
                            v53,
                            v54,
                            nil
                        }
                        table.insert(v36, v61)
                        local v62 = v44.Vertices
                        table.insert(v62, v61)
                    end
                end
            end
        end
        local v63 = {}
        for v64, v65 in next, p30 do
            local v66 = v65.Direction
            local v67 = v65.Steepness
            local v68 = v65.Length
            v63[v64] = {
                ["Direction"] = v66,
                ["XDir"] = v66.X,
                ["ZDir"] = v66.Y,
                ["Length"] = v68,
                ["Steepness"] = v67,
                ["k"] = 6.283185307179586 / v68
            }
        end
        local v69 = workspace.Terrain:GetAttribute("OceanTransparency")
        local function v72() --[[ Line: 177 ]]
            --[[
            Upvalues:
                [1] = u35
            --]]
            local v70 = workspace.Terrain:GetAttribute("OceanTransparency")
            for _, v71 in next, u35 do
                v71.Object.Transparency = v70
            end
        end
        local v73 = {
            ["Vertices"] = v36,
            ["WaveParams"] = v63,
            ["Planes"] = u35
        }
        for _, v74 in next, u35 do
            v74.Object.Transparency = v69
        end
        workspace.Terrain:GetAttributeChangedSignal("OceanTransparency"):Connect(v72)
        return v73, v34
    end
}).new
local v76 = {
    ["WaveA"] = {
        ["Direction"] = Vector2.new(1, 1),
        ["Steepness"] = 1,
        ["Length"] = 65
    },
    ["WaveB"] = {
        ["Direction"] = Vector2.new(1, 0.6),
        ["Steepness"] = 0.33,
        ["Length"] = 88
    }
}
local v77, v78 = v75(v76, v11)
local v79 = v77.WaveParams
u29.Vertices = v77.Vertices
local v80 = v79.WaveA
local v81 = v79.WaveB
local u82 = v80.XDir
local u83 = v80.ZDir
local u84 = v81.XDir
local u85 = v81.ZDir
local _ = v80.Direction.Unit
local _ = v81.Direction.Unit
local v86 = v80.Steepness
local v87 = v81.Steepness
local u88 = 6.283185307179586 / v80.Length
local u89 = 6.283185307179586 / v81.Length
local v90 = 9.8 / u88
local u91 = math.sqrt(v90)
local v92 = 9.8 / u89
local u93 = math.sqrt(v92)
local u94 = u91 * u15
local u95 = u93 * u15
local u96 = v86 / u88
local u97 = v87 / u89
local u98 = math.sin
local u99 = math.cos
local u100 = math.sqrt
local u101 = math.abs
local u102 = {}
local function u111(p103) --[[ Line: 244 ]]
    --[[
    Upvalues:
        [1] = u100
        [2] = u102
    --]]
    local v104 = p103.Direction.Unit
    local v105 = p103.Steepness
    local v106 = 6.283185307179586 / p103.Length
    local v107 = {
        v104.X,
        v104.Y,
        v106,
        u100(9.8 / v106),
        v105 / v106,
        -v104.X * v104.X * v105,
        -v104.X * v104.Y * v105,
        v104.X * v105,
        v104.Y * v105,
        -v104.Y * v104.Y * v105,
        v104,
        v105
    }
    local v108 = u102[p103] or v107
    u102[p103] = v108
    for v109, v110 in next, v107 do
        v108[v109] = v110
    end
    return v108
end
local u112 = u15
local function v117(p113) --[[ Line: 277 ]]
    --[[
    Upvalues:
        [1] = u111
    --]]
    p113.WaveUpdated = u111
    local v114 = {}
    for _, v115 in next, p113.Waves do
        local v116 = u111(v115)
        table.insert(v114, v116)
    end
    return v114
end
for _, v118 in next, v6 do
    local v119 = v118.P0.Position
    local v120 = Vector2.new(v119.X, v119.Z)
    local v121 = v118.P1.Position
    local v122 = Vector2.new(v121.X, v121.Z)
    u13:FillRect(Rect.new(v120, v122), (v117(v118)))
end
local u123 = v117(v6.DefaultRegionData)
local u124 = -u82 * u82 * v86
local u125 = -u84 * u84 * v87
local u126 = u82 * v86
local u127 = u84 * v87
local _ = -u82 * u83 * v86
local _ = -u84 * u85 * v87
local u128 = -u82 * u83 * v86
local u129 = -u84 * u85 * v87
local u130 = u83 * v86
local u131 = u85 * v87
local u132 = -u83 * u83 * v86
local u133 = -u85 * u85 * v87
local u134 = 9000000000
local _, v135 = next(v77.Vertices)
if v135 then
    local v136 = v135[1]
    local v137 = v135[2]
    v135 = Vector3.new(v136, 0, v137)
end
for _, v138 in next, v77.Vertices do
    local v139 = v138[1]
    local v140 = v138[2]
    local v141 = (Vector3.new(v139, 0, v140) - v135).Magnitude
    if v141 < u134 and v141 > 0.08 then
        u134 = v141
    end
end
local function u148(p142, p143, p144) --[[ Line: 420 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u123
        [3] = u9
        [4] = u96
        [5] = u88
        [6] = u82
        [7] = u83
        [8] = u94
        [9] = u98
        [10] = u97
        [11] = u89
        [12] = u84
        [13] = u85
        [14] = u95
        [15] = u112
    --]]
    local v145 = p144 or (u13:GetPointData(p142, p143) or u123)
    if not v145 or v145 == "nil" then
        return u9 + u96 * u98(u88 * (u82 * p142 + u83 * p143 - u94)) + u97 * u98(u89 * (u84 * p142 + u85 * p143 - u95))
    end
    local v146 = u9
    for _, v147 in next, v145 do
        v146 = v146 + v147[5] * u98(v147[3] * (v147[1] * p142 + v147[2] * p143 - v147[4] * u112))
    end
    return v146, v145
end
local function u163(p149, p150, p151, p152, p153, p154, p155, p156, p157, p158, p159) --[[ Line: 438 ]]
    local v160 = (p154 - p157) * (p149 - p155) + (p155 - p152) * (p151 - p157)
    local v161 = ((p154 - p157) * (p158 - p155) + (p155 - p152) * (p159 - p157)) / v160
    local v162 = ((p157 - p151) * (p158 - p155) + (p149 - p155) * (p159 - p157)) / v160
    return v161 * p150 + v162 * p153 + (1 - v161 - v162) * p156
end
local u164 = u134 ^ 2
v2.Heartbeat:Connect(function() --[[ Line: 502 ]]
    --[[
    Upvalues:
        [1] = u112
        [2] = u29
        [3] = u94
        [4] = u91
        [5] = u95
        [6] = u93
    --]]
    debug.profilebegin("Wave update [Main Module]")
    u112 = workspace:GetServerTimeNow()
    u29.Time = u112
    u94 = u91 * u112
    u95 = u93 * u112
    debug.profileend()
end)
function u29.NormalLookup(p165, p166) --[[ Line: 472 ]]
    --[[
    Upvalues:
        [1] = u134
        [2] = u164
        [3] = u148
    --]]
    local v167 = p165 - p165 % u134
    local v168 = p166 - p166 % u134
    local v169 = u134 * (p165 - v167) + u134 * (p166 - v168) - u164 < 0
    local v170 = v169 and v167 and v167 or v167 + u134
    local v171 = v168 + u134
    local v172
    if v169 then
        v172 = v167 + u134 or v167
    else
        v172 = v167
    end
    local v173 = v169 and v168 and v168 or v168 + u134
    local v174 = v167 + (v169 and 0 or u134)
    local v175 = u148(v174, v168)
    local v176 = u148(v170, v171)
    local v177 = u148(v172, v173)
    local v178 = -((v176 - v175) * (v173 - v171) - (v171 - v168) * (v177 - v176))
    local v179 = -((v171 - v168) * (v172 - v170) - (v170 - v174) * (v173 - v171))
    local v180 = -((v170 - v174) * (v177 - v176) - (v176 - v175) * (v172 - v170))
    local v181 = Vector3.new(v178, v179, v180).Unit
    local v182 = (v171 - v173) * (p165 - v172) + (v172 - v170) * (p166 - v173)
    local v183 = (v171 - v173) * (v174 - v172) + (v172 - v170) * (v168 - v173)
    local v184 = (v173 - v168) * (p165 - v172) + (v174 - v172) * (p166 - v173)
    return v182 / v183 * v175 + v184 / v183 * v176 + (1 - v182 / v183 - v184 / v183) * v177, v181
end
function u29.HeightLookup(p185, p186) --[[ Line: 450 ]]
    --[[
    Upvalues:
        [1] = u134
        [2] = u101
        [3] = u148
        [4] = u164
        [5] = u163
    --]]
    local v187 = p185 - p185 % u134
    local v188 = p186 - p186 % u134
    local v189
    if u101(p185 - (p185 + u134 - (p185 + u134) % u134)) < v187 - p185 then
        v189 = p185 + u134 - (p185 + u134) % u134 or v187
    else
        v189 = v187
    end
    if u101(p185 - v189) < 0.01 then
        local v190
        if u101(p186 - (p186 + u134 - (p186 + u134) % u134)) < v188 - p186 then
            v190 = p186 + u134 - (p186 + u134) % u134 or v188
        else
            v190 = v188
        end
        if u101(p186 - v190) < 0.01 then
            return u148(v187, v188)
        end
    end
    local v191 = u134 * (p185 - v187) + u134 * (p186 - v188) - u164 < 0
    local v192 = v191 and v187 and v187 or v187 + u134
    local v193 = v188 + u134
    local v194
    if v191 then
        v194 = v187 + u134 or v187
    else
        v194 = v187
    end
    local v195 = v191 and v188 and v188 or v188 + u134
    local v196 = v187 + (v191 and 0 or u134)
    return u163(v196, u148(v196, v188), v188, v192, u148(v192, v193), v193, v194, u148(v194, v195), v195, p185, p186)
end
u29.OceanHeightLookup = u148
function u29.OceanNormalLookup(p197, p198, p199) --[[ Line: 333 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u123
        [3] = u88
        [4] = u82
        [5] = u83
        [6] = u94
        [7] = u89
        [8] = u84
        [9] = u85
        [10] = u95
        [11] = u98
        [12] = u99
        [13] = u124
        [14] = u125
        [15] = u126
        [16] = u127
        [17] = u128
        [18] = u129
        [19] = u130
        [20] = u131
        [21] = u132
        [22] = u133
        [23] = u9
        [24] = u96
        [25] = u97
        [26] = u112
    --]]
    local v200 = p199 or (u13:GetPointData(p197, p198) or u123)
    if v200 and v200 ~= "nil" then
        local v201 = u9
        local v202 = Vector3.new(0, 0, 0)
        local v203 = Vector3.new(0, 0, 0)
        for _, v204 in next, v200 do
            local v205 = v204[3] * (v204[1] * p197 + v204[2] * p198 - v204[4] * u112)
            local v206 = v204[11]
            local v207 = v204[12]
            local v208 = u98(v205)
            local v209 = u99(v205)
            local v210 = -v206.X * v206.X * v207 * v208
            local v211 = v206.X * v207 * v209
            local v212 = -v206.X * -v206.Y * v207 * v208
            v202 = v202 + Vector3.new(v210, v211, v212)
            local v213 = -v206.X * v206.Y * v207 * v208
            local v214 = v206.Y * v207 * v209
            local v215 = -v206.Y * v206.Y * v207 * v208
            v203 = v203 + Vector3.new(v213, v214, v215)
            v201 = v201 + v204[5] * v208
        end
        return v201, v203, v202
    end
    local v216 = u88 * (u82 * p197 + u83 * p198 - u94)
    local v217 = u89 * (u84 * p197 + u85 * p198 - u95)
    local v218 = u98(v216)
    local v219 = u99(v216)
    local v220 = u98(v217)
    local v221 = u99(v217)
    local v222 = 0 + u124 * v218 + u125 * v220
    local v223 = u126 * v219 + u127 * v221
    local v224 = u128 * v218 + u129 * v220
    local v225 = u128 * v218 + u129 * v220
    local v226 = u130 * v219 + u131 * v221
    local v227 = 0 + u132 * v218 + u133 * v220
    return u9 + u96 * u98(u88 * (u82 * p197 + u83 * p198 - u94)) + u97 * u98(u89 * (u84 * p197 + u85 * p198 - u95)), Vector3.new(v225, v226, v227), Vector3.new(v222, v223, v224)
end
u29.Params = v77
u29.VertexSpacing = u134
u29.PlaneSize = u10
u29.SeaLevel = u9
u29.PlaneParams = v77
u29.NumPlaneRows = v78
u29.SteepKA = u96
u29.WaveAk = u88
u29.WaveAXDir = u82
u29.WaveAZDir = u83
u29.ctA = u94
u29.SteepKB = u97
u29.WaveBk = u89
u29.WaveBXDir = u84
u29.WaveBZDir = u85
u29.ctB = u95
u29.WaveAc = u91
u29.WaveBc = u93
u29.DefaultRegionData = u123
u29.VertexGrid = v14
u29.OceanGrid = u13
u29.NoRender = false
u29.NoOceanRegion = false
u29.OceanMeshes = u16
if v2:IsClient() then
    u16.Parent = workspace.Ocean
else
    u16:ClearAllChildren()
    u29.NoRender = true
end
return u29