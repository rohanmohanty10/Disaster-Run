 

local u1 = ipairs
local u2 = Color3.new()
local function v6(u3, u4) --[[ Line: 6 ]]
    return function(p5) --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
        --]]
        return u3:Lerp(u4, p5)
    end
end
local function u9(p7, p8) --[[ Line: 16 ]]
    return p7.Time < p8.Time
end
local function u48(p10, p11) --[[ Line: 20 ]]
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
    return function(p34) --[[ Line: 55 ]]
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
        return Color3.new(v45 > 1 and 1 or (v45 < 0 and 0 or v45), v46 > 1 and 1 or (v46 < 0 and 0 or v46), v47 > 1 and 1 or (v47 < 0 and 0 or v47))
    end
end
return setmetatable({
    ["boolean"] = function(u49, u50) --[[ Name: boolean, Line 94 ]]
        return function(p51) --[[ Line: 95 ]]
            --[[
            Upvalues:
                [1] = u49
                [2] = u50
            --]]
            if p51 < 0.5 then
                return u49
            else
                return u50
            end
        end
    end,
    ["number"] = function(u52, p53) --[[ Name: number, Line 104 ]]
        local u54 = p53 - u52
        return function(p55) --[[ Line: 106 ]]
            --[[
            Upvalues:
                [1] = u52
                [2] = u54
            --]]
            return u52 + u54 * p55
        end
    end,
    ["CFrame"] = v6,
    ["Color3"] = u48,
    ["NumberRange"] = function(p56, p57) --[[ Name: NumberRange, Line 114 ]]
        local u58 = p56.Min
        local u59 = p56.Max
        local u60 = p57.Min - u58
        local u61 = p57.Max - u59
        return function(p62) --[[ Line: 118 ]]
            --[[
            Upvalues:
                [1] = u58
                [2] = u60
                [3] = u59
                [4] = u61
            --]]
            return NumberRange.new(u58 + p62 * u60, u59 + p62 * u61)
        end
    end,
    ["NumberSequenceKeypoint"] = function(p63, p64) --[[ Name: NumberSequenceKeypoint, Line 123 ]]
        local u65 = p63.Time
        local u66 = p63.Value
        local u67 = p63.Envelope
        local u68 = p64.Time - u65
        local u69 = p64.Value - u66
        local u70 = p64.Envelope - u67
        return function(p71) --[[ Line: 127 ]]
            --[[
            Upvalues:
                [1] = u65
                [2] = u68
                [3] = u66
                [4] = u69
                [5] = u67
                [6] = u70
            --]]
            return NumberSequenceKeypoint.new(u65 + p71 * u68, u66 + p71 * u69, u67 + p71 * u70)
        end
    end,
    ["PhysicalProperties"] = function(p72, p73) --[[ Name: PhysicalProperties, Line 132 ]]
        local u74 = p72.Density
        local u75 = p72.Elasticity
        local u76 = p72.ElasticityWeight
        local u77 = p72.Friction
        local u78 = p72.FrictionWeight
        local u79 = p73.Density - u74
        local u80 = p73.Elasticity - u75
        local u81 = p73.ElasticityWeight - u76
        local u82 = p73.Friction - u77
        local u83 = p73.FrictionWeight - u78
        return function(p84) --[[ Line: 143 ]]
            --[[
            Upvalues:
                [1] = u74
                [2] = u79
                [3] = u75
                [4] = u80
                [5] = u76
                [6] = u81
                [7] = u77
                [8] = u82
                [9] = u78
                [10] = u83
            --]]
            return PhysicalProperties.new(u74 + p84 * u79, u75 + p84 * u80, u76 + p84 * u81, u77 + p84 * u82, u78 + p84 * u83)
        end
    end,
    ["Ray"] = function(p85, p86) --[[ Name: Ray, Line 152 ]]
        local v87 = p85.Origin
        local v88 = p85.Direction
        local v89 = p86.Origin
        local v90 = p86.Direction
        local u91 = v87.X
        local u92 = v87.Y
        local u93 = v87.Z
        local u94 = v88.X
        local u95 = v88.Y
        local u96 = v88.Z
        local u97 = v89.X - u91
        local u98 = v89.Y - u92
        local u99 = v89.Z - u93
        local u100 = v90.X - u94
        local u101 = v90.Y - u95
        local u102 = v90.Z - u96
        return function(p103) --[[ Line: 157 ]]
            --[[
            Upvalues:
                [1] = u91
                [2] = u97
                [3] = u92
                [4] = u98
                [5] = u93
                [6] = u99
                [7] = u94
                [8] = u100
                [9] = u95
                [10] = u101
                [11] = u96
                [12] = u102
            --]]
            local v104 = Ray.new
            local v105 = u91 + p103 * u97
            local v106 = u92 + p103 * u98
            local v107 = u93 + p103 * u99
            local v108 = Vector3.new(v105, v106, v107)
            local v109 = u94 + p103 * u100
            local v110 = u95 + p103 * u101
            local v111 = u96 + p103 * u102
            return v104(v108, (Vector3.new(v109, v110, v111)))
        end
    end,
    ["UDim"] = function(p112, p113) --[[ Name: UDim, Line 165 ]]
        local u114 = p112.Scale
        local u115 = p112.Offset
        local u116 = p113.Scale - u114
        local u117 = p113.Offset - u115
        return function(p118) --[[ Line: 169 ]]
            --[[
            Upvalues:
                [1] = u114
                [2] = u116
                [3] = u115
                [4] = u117
            --]]
            return UDim.new(u114 + p118 * u116, u115 + p118 * u117)
        end
    end,
    ["UDim2"] = v6,
    ["Vector2"] = v6,
    ["Vector3"] = v6,
    ["Rect"] = function(u119, u120) --[[ Name: Rect, Line 177 ]]
        return function(p121) --[[ Line: 178 ]]
            --[[
            Upvalues:
                [1] = u119
                [2] = u120
            --]]
            return Rect.new(u119.Min.X + p121 * (u120.Min.X - u119.Min.X), u119.Min.Y + p121 * (u120.Min.Y - u119.Min.Y), u119.Max.X + p121 * (u120.Max.X - u119.Max.X), u119.Max.Y + p121 * (u120.Max.Y - u119.Max.Y))
        end
    end,
    ["Region3"] = function(u122, u123) --[[ Name: Region3, Line 186 ]]
        return function(p124) --[[ Line: 187 ]]
            --[[
            Upvalues:
                [1] = u122
                [2] = u123
            --]]
            local v125 = u122.CFrame * (-u122.Size / 2)
            local v126 = v125 + p124 * (u123.CFrame * (-u123.Size / 2) - v125)
            local v127 = u122.CFrame * (u122.Size / 2)
            local v128 = v127 + p124 * (u123.CFrame * (u123.Size / 2) - v127)
            local v129 = v126.X
            local v130 = v128.X
            local v131 = v126.Y
            local v132 = v128.Y
            local v133 = v126.Z
            local v134 = v128.Z
            local v135 = Region3.new
            local v136 = v129 < v130 and v129 and v129 or v130
            local v137 = v131 < v132 and v131 and v131 or v132
            local v138 = v133 < v134 and v133 and v133 or v134
            local v139 = Vector3.new(v136, v137, v138)
            if v130 < v129 then
                v130 = v129 or v130
            end
            if v132 < v131 then
                v132 = v131 or v132
            end
            if v134 < v133 then
                v134 = v133 or v134
            end
            return v135(v139, (Vector3.new(v130, v132, v134)))
        end
    end,
    ["NumberSequence"] = function(u140, u141) --[[ Name: NumberSequence, Line 205 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        return function(p142) --[[ Line: 206 ]]
            --[[
            Upvalues:
                [1] = u140
                [2] = u141
                [3] = u9
            --]]
            local v143 = 0
            local v144 = {}
            local v145 = {}
            for _, v146 in u140.Keypoints do
                local v147 = nil
                local v148 = nil
                for _, v149 in u141.Keypoints do
                    if v149.Time == v146.Time then
                        v147 = v149
                        v148 = v147
                        local v150 = v147
                        v147 = v148
                        v150 = v148
                        break
                    end
                    if v149.Time < v146.Time and (v147 == nil or v149.Time > v147.Time) then
                        v147 = v149
                    elseif v149.Time > v146.Time and (v148 == nil or v149.Time < v148.Time) then
                        v148 = v149
                    end
                end
                local v151, v152
                if v148 == v147 then
                    v151 = v148.Value
                    v152 = v148.Envelope
                else
                    local v153 = (v146.Time - v147.Time) / (v148.Time - v147.Time)
                    v151 = (v148.Value - v147.Value) * v153 + v147.Value
                    v152 = (v148.Envelope - v147.Envelope) * v153 + v147.Envelope
                end
                local v154 = (v151 - v146.Value) * p142 + v146.Value
                local v155 = (v152 - v146.Envelope) * p142 + v146.Envelope
                local v156 = NumberSequenceKeypoint.new(v146.Time, v154, v155)
                v143 = v143 + 1
                v144[v143] = v156
                v145[v146.Time] = true
            end
            for _, v157 in u141.Keypoints do
                if not v145[v157.Time] then
                    local v158 = nil
                    local v159 = nil
                    for _, v160 in u140.Keypoints do
                        if v160.Time == v157.Time then
                            v158 = v160
                            v159 = v158
                            local v161 = v158
                            v158 = v159
                            v161 = v159
                            break
                        end
                        if v160.Time < v157.Time and (v158 == nil or v160.Time > v158.Time) then
                            v158 = v160
                        elseif v160.Time > v157.Time and (v159 == nil or v160.Time < v159.Time) then
                            v159 = v160
                        end
                    end
                    local v162, v163
                    if v159 == v158 then
                        v162 = v159.Value
                        v163 = v159.Envelope
                    else
                        local v164 = (v157.Time - v158.Time) / (v159.Time - v158.Time)
                        v162 = (v159.Value - v158.Value) * v164 + v158.Value
                        v163 = (v159.Envelope - v158.Envelope) * v164 + v158.Envelope
                    end
                    local v165 = (v157.Value - v162) * p142 + v162
                    local v166 = (v157.Envelope - v163) * p142 + v163
                    local v167 = NumberSequenceKeypoint.new(v157.Time, v165, v166)
                    v143 = v143 + 1
                    v144[v143] = v167
                end
            end
            table.sort(v144, u9)
            return NumberSequence.new(v144)
        end
    end,
    ["ColorSequence"] = function(u168, u169) --[[ Name: ColorSequence, Line 281 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u48
            [3] = u9
        --]]
        return function(p170) --[[ Line: 282 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u168
                [3] = u169
                [4] = u48
                [5] = u9
            --]]
            local v171 = 0
            local v172 = {}
            local v173 = {}
            for _, v174 in u1(u168.Keypoints) do
                local v175 = nil
                local v176 = nil
                for _, v177 in u1(u169.Keypoints) do
                    if v177.Time == v174.Time then
                        v175 = v177
                        v176 = v175
                        local v178 = v175
                        v175 = v176
                        v178 = v176
                        break
                    end
                    if v177.Time < v174.Time and (v175 == nil or v177.Time > v175.Time) then
                        v175 = v177
                    elseif v177.Time > v174.Time and (v176 == nil or v177.Time < v176.Time) then
                        v176 = v177
                    end
                end
                local v179
                if v176 == v175 then
                    v179 = v176.Value
                else
                    v179 = u48(v175.Value, v176.Value)((v174.Time - v175.Time) / (v176.Time - v175.Time))
                end
                v171 = v171 + 1
                v172[v171] = ColorSequenceKeypoint.new(v174.Time, u48(v174.Value, v179)(p170))
                v173[v174.Time] = true
            end
            for _, v180 in u1(u169.Keypoints) do
                if not v173[v180.Time] then
                    local v181 = nil
                    local v182 = nil
                    for _, v183 in u1(u168.Keypoints) do
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
                    local v185
                    if v182 == v181 then
                        v185 = v182.Value
                    else
                        v185 = u48(v181.Value, v182.Value)((v180.Time - v181.Time) / (v182.Time - v181.Time))
                    end
                    v171 = v171 + 1
                    v172[v171] = ColorSequenceKeypoint.new(v180.Time, u48(v180.Value, v185)(p170))
                end
            end
            table.sort(v172, u9)
            return ColorSequence.new(v172)
        end
    end
}, {
    ["__index"] = function(_, p186) --[[ Name: __index, Line 345 ]]
        error("No lerp function is defined for type " .. tostring(p186) .. ".", 4)
    end,
    ["__newindex"] = function(_, p187) --[[ Name: __newindex, Line 349 ]]
        error("No lerp function is defined for type " .. tostring(p187) .. ".", 4)
    end
})