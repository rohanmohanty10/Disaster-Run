 

local u1 = ipairs
local u2 = Color3.new()
local function v6(u3, u4) --[[ Line: 5 ]]
    return function(p5) --[[ Line: 6 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
        --]]
        return u3:Lerp(u4, p5)
    end
end
local function u9(p7, p8) --[[ Line: 15 ]]
    return p7.Time < p8.Time
end
local function u51(p10, p11) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v12 = p10.R
    local v13 = p10.G
    local v14 = p10.B
    local v15 = v12 < 0.0404482362771076 and v12 / 12.92 or 0.87941546140213 * (v12 + 0.055) ^ 2.4
    local v16 = v13 < 0.0404482362771076 and v13 / 12.92 or 0.87941546140213 * (v13 + 0.055) ^ 2.4
    local v17 = v14 < 0.0404482362771076 and v14 / 12.92 or 0.87941546140213 * (v14 + 0.055) ^ 2.4
    local v18 = 0.2125862307855956 * v15 + 0.7151703037034108 * v16 + 0.0722004986433362 * v17
    local v19 = 3.6590806972265884 * v15 + 11.442689580057424 * v16 + 4.114991502426484 * v17
    local u20 = v18 > 0.008856451679035631 and 116 * v18 ^ 0.3333333333333333 - 16 or 903.296296296296 * v18
    local u21, u22
    if v19 > 1e-15 then
        u21 = u20 * (0.9257063972951867 * v15 - 0.8333736323779866 * v16 - 0.09209820666085898 * v17) / v19
        u22 = u20 * (9 * v18 / v19 - 0.46832)
    else
        u21 = -0.19783 * u20
        u22 = -0.46832 * u20
    end
    local v23 = p11.R
    local v24 = p11.G
    local v25 = p11.B
    local v26 = v23 < 0.0404482362771076 and v23 / 12.92 or 0.87941546140213 * (v23 + 0.055) ^ 2.4
    local v27 = v24 < 0.0404482362771076 and v24 / 12.92 or 0.87941546140213 * (v24 + 0.055) ^ 2.4
    local v28 = v25 < 0.0404482362771076 and v25 / 12.92 or 0.87941546140213 * (v25 + 0.055) ^ 2.4
    local v29 = 0.2125862307855956 * v26 + 0.7151703037034108 * v27 + 0.0722004986433362 * v28
    local v30 = 3.6590806972265884 * v26 + 11.442689580057424 * v27 + 4.114991502426484 * v28
    local u31 = v29 > 0.008856451679035631 and 116 * v29 ^ 0.3333333333333333 - 16 or 903.296296296296 * v29
    local u32, u33
    if v30 > 1e-15 then
        u32 = u31 * (0.9257063972951867 * v26 - 0.8333736323779866 * v27 - 0.09209820666085898 * v28) / v30
        u33 = u31 * (9 * v29 / v30 - 0.46832)
    else
        u32 = -0.19783 * u31
        u33 = -0.46832 * u31
    end
    return function(p34) --[[ Line: 54 ]]
        --[[
        Upvalues:
            [1] = u20
            [2] = u31
            [3] = u2
            [4] = u21
            [5] = u32
            [6] = u22
            [7] = u33
        --]]
        local v35 = (1 - p34) * u20 + p34 * u31
        if v35 < 0.0197955 then
            return u2
        end
        local v36 = ((1 - p34) * u21 + p34 * u32) / v35 + 0.19783
        local v37 = ((1 - p34) * u22 + p34 * u33) / v35 + 0.46832
        local v38 = (v35 + 16) / 116
        local v39 = v38 > 0.20689655172413793 and v38 * v38 * v38 or 0.12841854934601665 * v38 - 0.01771290335807126
        local v40 = v39 * v36 / v37
        local v41 = v39 * ((3 - 0.75 * v36) / v37 - 5)
        local v42 = 7.2914074 * v40 - 1.537208 * v39 - 0.4986286 * v41
        local v43 = -2.180094 * v40 + 1.8757561 * v39 + 0.0415175 * v41
        local v44 = 0.1253477 * v40 - 0.2040211 * v39 + 1.0569959 * v41
        if v42 < 0 and (v42 < v43 and v42 < v44) then
            v43 = v43 - v42
            v44 = v44 - v42
            v42 = 0
        elseif v43 < 0 and v43 < v44 then
            v42 = v42 - v43
            v44 = v44 - v43
            v43 = 0
        elseif v44 < 0 then
            v42 = v42 - v44
            v43 = v43 - v44
            v44 = 0
        end
        local v45 = v42 < 0.0031306684425 and 12.92 * v42 or 1.055 * v42 ^ 0.4166666666666667 - 0.055
        local v46 = v43 < 0.0031306684425 and 12.92 * v43 or 1.055 * v43 ^ 0.4166666666666667 - 0.055
        local v47 = v44 < 0.0031306684425 and 12.92 * v44 or 1.055 * v44 ^ 0.4166666666666667 - 0.055
        local v48 = v45 > 1 and 1 or (v45 < 0 and 0 or v45)
        local v49 = v46 > 1 and 1 or (v46 < 0 and 0 or v46)
        local v50 = v47 > 1 and 1 or (v47 < 0 and 0 or v47)
        return Color3.new(v48, v49, v50)
    end
end
return setmetatable({
    ["boolean"] = function(u52, u53) --[[ Name: boolean, Line 93 ]]
        return function(p54) --[[ Line: 94 ]]
            --[[
            Upvalues:
                [1] = u52
                [2] = u53
            --]]
            if p54 < 0.5 then
                return u52
            else
                return u53
            end
        end
    end,
    ["number"] = function(u55, p56) --[[ Name: number, Line 103 ]]
        local u57 = p56 - u55
        return function(p58) --[[ Line: 105 ]]
            --[[
            Upvalues:
                [1] = u55
                [2] = u57
            --]]
            return u55 + u57 * p58
        end
    end,
    ["string"] = function(p59, u60) --[[ Name: string, Line 110 ]]
        local v61 = false
        local v62, v63, v64, v65 = string.match(p59, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$")
        local v66, v67, v68, v69 = string.match(u60, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$")
        local u70, u71
        if v62 and v66 then
            u70 = 3600 * (tonumber(v63) or 0) + 60 * (tonumber(v64) or 0) + (tonumber(v65) or 0)
            local v72 = 3600 * (tonumber(v67) or 0) + 60 * (tonumber(v68) or 0) + (tonumber(v69) or 0)
            if v62 == "-" then
                u70 = -u70
            end
            local v73 = 43200
            if v66 == "-" or not v72 then
                v72 = -v72
            end
            u71 = (v73 + v72 - u70) % 86400 - 43200
        else
            v61 = true
            u70 = nil
            u71 = nil
        end
        if not v61 then
            return function(p74) --[[ Line: 136 ]]
                --[[
                Upvalues:
                    [1] = u70
                    [2] = u71
                --]]
                local v75 = (u70 + u71 * p74) % 86400
                local v76 = math.abs(v75)
                return string.format(v75 < 0 and "-%.2u:%.2u:%.2u" or "%.2u:%.2u:%.2u", (v76 - v76 % 3600) / 3600, (v76 % 3600 - v76 % 60) / 60, v76 % 60)
            end
        end
        local u77 = #u60
        return function(p78) --[[ Line: 131 ]]
            --[[
            Upvalues:
                [1] = u77
                [2] = u60
            --]]
            local v79 = 1 + u77 * p78
            local v80 = u60
            local v81 = v79 < u77 and v79 and v79 or u77
            return string.sub(v80, 1, v81)
        end
    end,
    ["CFrame"] = v6,
    ["Color3"] = u51,
    ["NumberRange"] = function(p82, p83) --[[ Name: NumberRange, Line 151 ]]
        local u84 = p82.Min
        local u85 = p82.Max
        local u86 = p83.Min - u84
        local u87 = p83.Max - u85
        return function(p88) --[[ Line: 155 ]]
            --[[
            Upvalues:
                [1] = u84
                [2] = u86
                [3] = u85
                [4] = u87
            --]]
            return NumberRange.new(u84 + p88 * u86, u85 + p88 * u87)
        end
    end,
    ["NumberSequenceKeypoint"] = function(p89, p90) --[[ Name: NumberSequenceKeypoint, Line 160 ]]
        local u91 = p89.Time
        local u92 = p89.Value
        local u93 = p89.Envelope
        local u94 = p90.Time - u91
        local u95 = p90.Value - u92
        local u96 = p90.Envelope - u93
        return function(p97) --[[ Line: 164 ]]
            --[[
            Upvalues:
                [1] = u91
                [2] = u94
                [3] = u92
                [4] = u95
                [5] = u93
                [6] = u96
            --]]
            return NumberSequenceKeypoint.new(u91 + p97 * u94, u92 + p97 * u95, u93 + p97 * u96)
        end
    end,
    ["PhysicalProperties"] = function(p98, p99) --[[ Name: PhysicalProperties, Line 169 ]]
        local u100 = p98.Density
        local u101 = p98.Elasticity
        local u102 = p98.ElasticityWeight
        local u103 = p98.Friction
        local u104 = p98.FrictionWeight
        local u105 = p99.Density - u100
        local u106 = p99.Elasticity - u101
        local u107 = p99.ElasticityWeight - u102
        local u108 = p99.Friction - u103
        local u109 = p99.FrictionWeight - u104
        return function(p110) --[[ Line: 180 ]]
            --[[
            Upvalues:
                [1] = u100
                [2] = u105
                [3] = u101
                [4] = u106
                [5] = u102
                [6] = u107
                [7] = u103
                [8] = u108
                [9] = u104
                [10] = u109
            --]]
            return PhysicalProperties.new(u100 + p110 * u105, u101 + p110 * u106, u102 + p110 * u107, u103 + p110 * u108, u104 + p110 * u109)
        end
    end,
    ["Ray"] = function(p111, p112) --[[ Name: Ray, Line 189 ]]
        local v113 = p111.Origin
        local v114 = p111.Direction
        local v115 = p112.Origin
        local v116 = p112.Direction
        local u117 = v113.X
        local u118 = v113.Y
        local u119 = v113.Z
        local u120 = v114.X
        local u121 = v114.Y
        local u122 = v114.Z
        local u123 = v115.X - u117
        local u124 = v115.Y - u118
        local u125 = v115.Z - u119
        local u126 = v116.X - u120
        local u127 = v116.Y - u121
        local u128 = v116.Z - u122
        return function(p129) --[[ Line: 194 ]]
            --[[
            Upvalues:
                [1] = u117
                [2] = u123
                [3] = u118
                [4] = u124
                [5] = u119
                [6] = u125
                [7] = u120
                [8] = u126
                [9] = u121
                [10] = u127
                [11] = u122
                [12] = u128
            --]]
            local v130 = Ray.new
            local v131 = u117 + p129 * u123
            local v132 = u118 + p129 * u124
            local v133 = u119 + p129 * u125
            local v134 = Vector3.new(v131, v132, v133)
            local v135 = u120 + p129 * u126
            local v136 = u121 + p129 * u127
            local v137 = u122 + p129 * u128
            return v130(v134, (Vector3.new(v135, v136, v137)))
        end
    end,
    ["UDim"] = function(p138, p139) --[[ Name: UDim, Line 202 ]]
        local u140 = p138.Scale
        local u141 = p138.Offset
        local u142 = p139.Scale - u140
        local u143 = p139.Offset - u141
        return function(p144) --[[ Line: 206 ]]
            --[[
            Upvalues:
                [1] = u140
                [2] = u142
                [3] = u141
                [4] = u143
            --]]
            return UDim.new(u140 + p144 * u142, u141 + p144 * u143)
        end
    end,
    ["UDim2"] = v6,
    ["Vector2"] = v6,
    ["Vector3"] = v6,
    ["Rect"] = function(u145, u146) --[[ Name: Rect, Line 214 ]]
        return function(p147) --[[ Line: 215 ]]
            --[[
            Upvalues:
                [1] = u145
                [2] = u146
            --]]
            return Rect.new(u145.Min.X + p147 * (u146.Min.X - u145.Min.X), u145.Min.Y + p147 * (u146.Min.Y - u145.Min.Y), u145.Max.X + p147 * (u146.Max.X - u145.Max.X), u145.Max.Y + p147 * (u146.Max.Y - u145.Max.Y))
        end
    end,
    ["Region3"] = function(u148, u149) --[[ Name: Region3, Line 223 ]]
        return function(p150) --[[ Line: 224 ]]
            --[[
            Upvalues:
                [1] = u148
                [2] = u149
            --]]
            local v151 = u148.CFrame * (-u148.Size / 2)
            local v152 = v151 + p150 * (u149.CFrame * (-u149.Size / 2) - v151)
            local v153 = u148.CFrame * (u148.Size / 2)
            local v154 = v153 + p150 * (u149.CFrame * (u149.Size / 2) - v153)
            local v155 = v152.X
            local v156 = v154.X
            local v157 = v152.Y
            local v158 = v154.Y
            local v159 = v152.Z
            local v160 = v154.Z
            local v161 = Region3.new
            local v162 = v155 < v156 and v155 and v155 or v156
            local v163 = v157 < v158 and v157 and v157 or v158
            local v164 = v159 < v160 and v159 and v159 or v160
            local v165 = Vector3.new(v162, v163, v164)
            if v156 < v155 then
                v156 = v155 or v156
            end
            if v158 < v157 then
                v158 = v157 or v158
            end
            if v160 < v159 then
                v160 = v159 or v160
            end
            return v161(v165, (Vector3.new(v156, v158, v160)))
        end
    end,
    ["NumberSequence"] = function(u166, u167) --[[ Name: NumberSequence, Line 242 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u9
        --]]
        return function(p168) --[[ Line: 243 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u166
                [3] = u167
                [4] = u9
            --]]
            local v169 = 0
            local v170 = {}
            local v171 = {}
            for _, v172 in u1(u166.Keypoints) do
                local v173 = nil
                local v174 = nil
                for _, v175 in u1(u167.Keypoints) do
                    if v175.Time == v172.Time then
                        v173 = v175
                        v174 = v173
                        local v176 = v173
                        v173 = v174
                        v176 = v174
                        break
                    end
                    if v175.Time < v172.Time and (v173 == nil or v175.Time > v173.Time) then
                        v173 = v175
                    elseif v175.Time > v172.Time and (v174 == nil or v175.Time < v174.Time) then
                        v174 = v175
                    end
                end
                local v177, v178
                if v174 == v173 then
                    v177 = v174.Value
                    v178 = v174.Envelope
                else
                    local v179 = (v172.Time - v173.Time) / (v174.Time - v173.Time)
                    v177 = (v174.Value - v173.Value) * v179 + v173.Value
                    v178 = (v174.Envelope - v173.Envelope) * v179 + v173.Envelope
                end
                v169 = v169 + 1
                v170[v169] = NumberSequenceKeypoint.new(v172.Time, (v177 - v172.Value) * p168 + v172.Value, (v178 - v172.Envelope) * p168 + v172.Envelope)
                v171[v172.Time] = true
            end
            for _, v180 in u1(u167.Keypoints) do
                if not v171[v180.Time] then
                    local v181 = nil
                    local v182 = nil
                    for _, v183 in u1(u166.Keypoints) do
                        if v183.Time == v180.Time then
                            v181 = v183
                            v182 = v181
                            local v184 = v181
                            v181 = v182
                            v184 = v182
                            break
                        end
                        if v183.Time < v180.Time and (v181 == nil or v183.Time > v181.Time) then
                            v181 = v183
                        elseif v183.Time > v180.Time and (v182 == nil or v183.Time < v182.Time) then
                            v182 = v183
                        end
                    end
                    local v185, v186
                    if v182 == v181 then
                        v185 = v182.Value
                        v186 = v182.Envelope
                    else
                        local v187 = (v180.Time - v181.Time) / (v182.Time - v181.Time)
                        v185 = (v182.Value - v181.Value) * v187 + v181.Value
                        v186 = (v182.Envelope - v181.Envelope) * v187 + v181.Envelope
                    end
                    v169 = v169 + 1
                    v170[v169] = NumberSequenceKeypoint.new(v180.Time, (v180.Value - v185) * p168 + v185, (v180.Envelope - v186) * p168 + v186)
                end
            end
            table.sort(v170, u9)
            return NumberSequence.new(v170)
        end
    end,
    ["ColorSequence"] = function(u188, u189) --[[ Name: ColorSequence, Line 310 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u51
            [3] = u9
        --]]
        return function(p190) --[[ Line: 311 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u188
                [3] = u189
                [4] = u51
                [5] = u9
            --]]
            local v191 = 0
            local v192 = {}
            local v193 = {}
            for _, v194 in u1(u188.Keypoints) do
                local v195 = nil
                local v196 = nil
                for _, v197 in u1(u189.Keypoints) do
                    if v197.Time == v194.Time then
                        v195 = v197
                        v196 = v195
                        local v198 = v195
                        v195 = v196
                        v198 = v196
                        break
                    end
                    if v197.Time < v194.Time and (v195 == nil or v197.Time > v195.Time) then
                        v195 = v197
                    elseif v197.Time > v194.Time and (v196 == nil or v197.Time < v196.Time) then
                        v196 = v197
                    end
                end
                local v199
                if v196 == v195 then
                    v199 = v196.Value
                else
                    v199 = u51(v195.Value, v196.Value)((v194.Time - v195.Time) / (v196.Time - v195.Time))
                end
                v191 = v191 + 1
                v192[v191] = ColorSequenceKeypoint.new(v194.Time, u51(v194.Value, v199)(p190))
                v193[v194.Time] = true
            end
            for _, v200 in u1(u189.Keypoints) do
                if not v193[v200.Time] then
                    local v201 = nil
                    local v202 = nil
                    for _, v203 in u1(u188.Keypoints) do
                        if v203.Time == v200.Time then
                            v201 = v203
                            v202 = v201
                            local v204 = v201
                            v201 = v202
                            v204 = v202
                            break
                        end
                        if v203.Time < v200.Time and (v201 == nil or v203.Time > v201.Time) then
                            v201 = v203
                        elseif v203.Time > v200.Time and (v202 == nil or v203.Time < v202.Time) then
                            v202 = v203
                        end
                    end
                    local v205
                    if v202 == v201 then
                        v205 = v202.Value
                    else
                        v205 = u51(v201.Value, v202.Value)((v200.Time - v201.Time) / (v202.Time - v201.Time))
                    end
                    v191 = v191 + 1
                    v192[v191] = ColorSequenceKeypoint.new(v200.Time, u51(v200.Value, v205)(p190))
                end
            end
            table.sort(v192, u9)
            return ColorSequence.new(v192)
        end
    end
}, {
    ["__index"] = function(_, p206) --[[ Name: __index, Line 374 ]]
        error("No lerp function is defined for type " .. tostring(p206) .. ".", 4)
    end,
    ["__newindex"] = function(_, p207) --[[ Name: __newindex, Line 378 ]]
        error("No lerp function is defined for type " .. tostring(p207) .. ".", 4)
    end
})