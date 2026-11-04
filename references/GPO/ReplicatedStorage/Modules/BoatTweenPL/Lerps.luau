 

local _ = ipairs
local u1 = Color3.new()
local function v5(u2, u3) --[[ Line: 6 ]]
    return function(p4) --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        return u2:Lerp(u3, p4)
    end
end
local function u8(p6, p7) --[[ Line: 16 ]]
    return p6.Time < p7.Time
end
return setmetatable({
    ["boolean"] = function(u9, u10) --[[ Name: boolean, Line 21 ]]
        return function(p11) --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u10
            --]]
            if p11 < 0.5 then
                return u9
            else
                return u10
            end
        end
    end,
    ["number"] = function(u12, p13) --[[ Name: number, Line 31 ]]
        local u14 = p13 - u12
        return function(p15) --[[ Line: 33 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u14
            --]]
            return u12 + u14 * p15
        end
    end,
    ["CFrame"] = v5,
    ["Color3"] = function(p16, p17) --[[ Name: Color3, Line 39 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v18 = p16.R
        local v19 = p16.G
        local v20 = p16.B
        local v21 = v18 < 0.0404482362771076 and v18 / 12.92 or 0.87941546140213 * (v18 + 0.055) ^ 2.4
        local v22 = v19 < 0.0404482362771076 and v19 / 12.92 or 0.87941546140213 * (v19 + 0.055) ^ 2.4
        local v23 = v20 < 0.0404482362771076 and v20 / 12.92 or 0.87941546140213 * (v20 + 0.055) ^ 2.4
        local v24 = 0.2125862307855956 * v21 + 0.7151703037034108 * v22 + 0.0722004986433362 * v23
        local v25 = 3.6590806972265884 * v21 + 11.442689580057424 * v22 + 4.114991502426484 * v23
        local u26 = v24 > 0.008856451679035631 and 116 * v24 ^ 0.3333333333333333 - 16 or 903.296296296296 * v24
        local u27, u28
        if v25 > 1e-15 then
            u27 = u26 * (0.9257063972951867 * v21 - 0.8333736323779866 * v22 - 0.09209820666085898 * v23) / v25
            u28 = u26 * (9 * v24 / v25 - 0.46832)
        else
            u27 = -0.19783 * u26
            u28 = -0.46832 * u26
        end
        local v29 = p17.R
        local v30 = p17.G
        local v31 = p17.B
        local v32 = v29 < 0.0404482362771076 and v29 / 12.92 or 0.87941546140213 * (v29 + 0.055) ^ 2.4
        local v33 = v30 < 0.0404482362771076 and v30 / 12.92 or 0.87941546140213 * (v30 + 0.055) ^ 2.4
        local v34 = v31 < 0.0404482362771076 and v31 / 12.92 or 0.87941546140213 * (v31 + 0.055) ^ 2.4
        local v35 = 0.2125862307855956 * v32 + 0.7151703037034108 * v33 + 0.0722004986433362 * v34
        local v36 = 3.6590806972265884 * v32 + 11.442689580057424 * v33 + 4.114991502426484 * v34
        local u37 = v35 > 0.008856451679035631 and 116 * v35 ^ 0.3333333333333333 - 16 or 903.296296296296 * v35
        local u38, u39
        if v36 > 1e-15 then
            u38 = u37 * (0.9257063972951867 * v32 - 0.8333736323779866 * v33 - 0.09209820666085898 * v34) / v36
            u39 = u37 * (9 * v35 / v36 - 0.46832)
        else
            u38 = -0.19783 * u37
            u39 = -0.46832 * u37
        end
        return function(p40) --[[ Line: 74 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u37
                [3] = u1
                [4] = u27
                [5] = u38
                [6] = u28
                [7] = u39
            --]]
            local v41 = (1 - p40) * u26 + p40 * u37
            if v41 < 0.0197955 then
                return u1
            end
            local v42 = ((1 - p40) * u27 + p40 * u38) / v41 + 0.19783
            local v43 = ((1 - p40) * u28 + p40 * u39) / v41 + 0.46832
            local v44 = (v41 + 16) / 116
            local v45 = v44 > 0.20689655172413793 and v44 * v44 * v44 or 0.12841854934601665 * v44 - 0.01771290335807126
            local v46 = v45 * v42 / v43
            local v47 = v45 * ((3 - 0.75 * v42) / v43 - 5)
            local v48 = 7.2914074 * v46 - 1.537208 * v45 - 0.4986286 * v47
            local v49 = -2.180094 * v46 + 1.8757561 * v45 + 0.0415175 * v47
            local v50 = 0.1253477 * v46 - 0.2040211 * v45 + 1.0569959 * v47
            if v48 < 0 and (v48 < v49 and v48 < v50) then
                v49 = v49 - v48
                v50 = v50 - v48
                v48 = 0
            elseif v49 < 0 and v49 < v50 then
                v48 = v48 - v49
                v50 = v50 - v49
                v49 = 0
            elseif v50 < 0 then
                v48 = v48 - v50
                v49 = v49 - v50
                v50 = 0
            end
            local v51 = v48 < 0.0031306684425 and 12.92 * v48 or 1.055 * v48 ^ 0.4166666666666667 - 0.055
            local v52 = v49 < 0.0031306684425 and 12.92 * v49 or 1.055 * v49 ^ 0.4166666666666667 - 0.055
            local v53 = v50 < 0.0031306684425 and 12.92 * v50 or 1.055 * v50 ^ 0.4166666666666667 - 0.055
            return Color3.new(v51 > 1 and 1 or (v51 < 0 and 0 or v51), v52 > 1 and 1 or (v52 < 0 and 0 or v52), v53 > 1 and 1 or (v53 < 0 and 0 or v53))
        end
    end,
    ["NumberRange"] = function(p54, p55) --[[ Name: NumberRange, Line 112 ]]
        local u56 = p54.Min
        local u57 = p54.Max
        local u58 = p55.Min - u56
        local u59 = p55.Max - u57
        return function(p60) --[[ Line: 116 ]]
            --[[
            Upvalues:
                [1] = u56
                [2] = u58
                [3] = u57
                [4] = u59
            --]]
            return NumberRange.new(u56 + p60 * u58, u57 + p60 * u59)
        end
    end,
    ["NumberSequenceKeypoint"] = function(p61, p62) --[[ Name: NumberSequenceKeypoint, Line 121 ]]
        local u63 = p61.Time
        local u64 = p61.Value
        local u65 = p61.Envelope
        local u66 = p62.Time - u63
        local u67 = p62.Value - u64
        local u68 = p62.Envelope - u65
        return function(p69) --[[ Line: 125 ]]
            --[[
            Upvalues:
                [1] = u63
                [2] = u66
                [3] = u64
                [4] = u67
                [5] = u65
                [6] = u68
            --]]
            return NumberSequenceKeypoint.new(u63 + p69 * u66, u64 + p69 * u67, u65 + p69 * u68)
        end
    end,
    ["PhysicalProperties"] = function(p70, p71) --[[ Name: PhysicalProperties, Line 130 ]]
        local u72 = p70.Density
        local u73 = p70.Elasticity
        local u74 = p70.ElasticityWeight
        local u75 = p70.Friction
        local u76 = p70.FrictionWeight
        local u77 = p71.Density - u72
        local u78 = p71.Elasticity - u73
        local u79 = p71.ElasticityWeight - u74
        local u80 = p71.Friction - u75
        local u81 = p71.FrictionWeight - u76
        return function(p82) --[[ Line: 141 ]]
            --[[
            Upvalues:
                [1] = u72
                [2] = u77
                [3] = u73
                [4] = u78
                [5] = u74
                [6] = u79
                [7] = u75
                [8] = u80
                [9] = u76
                [10] = u81
            --]]
            return PhysicalProperties.new(u72 + p82 * u77, u73 + p82 * u78, u74 + p82 * u79, u75 + p82 * u80, u76 + p82 * u81)
        end
    end,
    ["Ray"] = function(p83, p84) --[[ Name: Ray, Line 150 ]]
        local v85 = p83.Origin
        local v86 = p83.Direction
        local v87 = p84.Origin
        local v88 = p84.Direction
        local u89 = v85.X
        local u90 = v85.Y
        local u91 = v85.Z
        local u92 = v86.X
        local u93 = v86.Y
        local u94 = v86.Z
        local u95 = v87.X - u89
        local u96 = v87.Y - u90
        local u97 = v87.Z - u91
        local u98 = v88.X - u92
        local u99 = v88.Y - u93
        local u100 = v88.Z - u94
        return function(p101) --[[ Line: 155 ]]
            --[[
            Upvalues:
                [1] = u89
                [2] = u95
                [3] = u90
                [4] = u96
                [5] = u91
                [6] = u97
                [7] = u92
                [8] = u98
                [9] = u93
                [10] = u99
                [11] = u94
                [12] = u100
            --]]
            local v102 = Ray.new
            local v103 = u89 + p101 * u95
            local v104 = u90 + p101 * u96
            local v105 = u91 + p101 * u97
            local v106 = Vector3.new(v103, v104, v105)
            local v107 = u92 + p101 * u98
            local v108 = u93 + p101 * u99
            local v109 = u94 + p101 * u100
            return v102(v106, (Vector3.new(v107, v108, v109)))
        end
    end,
    ["UDim"] = function(p110, p111) --[[ Name: UDim, Line 163 ]]
        local u112 = p110.Scale
        local u113 = p110.Offset
        local u114 = p111.Scale - u112
        local u115 = p111.Offset - u113
        return function(p116) --[[ Line: 167 ]]
            --[[
            Upvalues:
                [1] = u112
                [2] = u114
                [3] = u113
                [4] = u115
            --]]
            return UDim.new(u112 + p116 * u114, u113 + p116 * u115)
        end
    end,
    ["UDim2"] = v5,
    ["Vector2"] = v5,
    ["Vector3"] = v5,
    ["Rect"] = function(u117, u118) --[[ Name: Rect, Line 175 ]]
        return function(p119) --[[ Line: 176 ]]
            --[[
            Upvalues:
                [1] = u117
                [2] = u118
            --]]
            return Rect.new(u117.Min.X + p119 * (u118.Min.X - u117.Min.X), u117.Min.Y + p119 * (u118.Min.Y - u117.Min.Y), u117.Max.X + p119 * (u118.Max.X - u117.Max.X), u117.Max.Y + p119 * (u118.Max.Y - u117.Max.Y))
        end
    end,
    ["Region3"] = function(u120, u121) --[[ Name: Region3, Line 184 ]]
        return function(p122) --[[ Line: 185 ]]
            --[[
            Upvalues:
                [1] = u120
                [2] = u121
            --]]
            local v123 = u120.CFrame * (-u120.Size / 2)
            local v124 = v123 + p122 * (u121.CFrame * (-u121.Size / 2) - v123)
            local v125 = u120.CFrame * (u120.Size / 2)
            local v126 = v125 + p122 * (u121.CFrame * (u121.Size / 2) - v125)
            local v127 = v124.X
            local v128 = v126.X
            local v129 = v124.Y
            local v130 = v126.Y
            local v131 = v124.Z
            local v132 = v126.Z
            local v133 = Region3.new
            local v134 = v127 < v128 and v127 and v127 or v128
            local v135 = v129 < v130 and v129 and v129 or v130
            local v136 = v131 < v132 and v131 and v131 or v132
            local v137 = Vector3.new(v134, v135, v136)
            if v128 < v127 then
                v128 = v127 or v128
            end
            if v130 < v129 then
                v130 = v129 or v130
            end
            if v132 < v131 then
                v132 = v131 or v132
            end
            return v133(v137, (Vector3.new(v128, v130, v132)))
        end
    end,
    ["NumberSequence"] = function(u138, u139) --[[ Name: NumberSequence, Line 203 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        return function(p140) --[[ Line: 204 ]]
            --[[
            Upvalues:
                [1] = u138
                [2] = u139
                [3] = u8
            --]]
            local v141 = 0
            local v142 = {}
            local v143 = {}
            for _, v144 in u138.Keypoints do
                local v145 = nil
                local v146 = nil
                for _, v147 in u139.Keypoints do
                    if v147.Time == v144.Time then
                        v145 = v147
                        v146 = v145
                        local v148 = v145
                        v145 = v146
                        v148 = v146
                        break
                    end
                    if v147.Time < v144.Time and (v145 == nil or v147.Time > v145.Time) then
                        v145 = v147
                    elseif v147.Time > v144.Time and (v146 == nil or v147.Time < v146.Time) then
                        v146 = v147
                    end
                end
                local v149, v150
                if v146 == v145 then
                    v149 = v146.Value
                    v150 = v146.Envelope
                else
                    local v151 = (v144.Time - v145.Time) / (v146.Time - v145.Time)
                    v149 = (v146.Value - v145.Value) * v151 + v145.Value
                    v150 = (v146.Envelope - v145.Envelope) * v151 + v145.Envelope
                end
                local v152 = (v149 - v144.Value) * p140 + v144.Value
                local v153 = (v150 - v144.Envelope) * p140 + v144.Envelope
                local v154 = NumberSequenceKeypoint.new(v144.Time, v152, v153)
                v141 = v141 + 1
                v142[v141] = v154
                v143[v144.Time] = true
            end
            for _, v155 in u139.Keypoints do
                if not v143[v155.Time] then
                    local v156 = nil
                    local v157 = nil
                    for _, v158 in u138.Keypoints do
                        if v158.Time == v155.Time then
                            v156 = v158
                            v157 = v156
                            local v159 = v156
                            v156 = v157
                            v159 = v157
                            break
                        end
                        if v158.Time < v155.Time and (v156 == nil or v158.Time > v156.Time) then
                            v156 = v158
                        elseif v158.Time > v155.Time and (v157 == nil or v158.Time < v157.Time) then
                            v157 = v158
                        end
                    end
                    local v160, v161
                    if v157 == v156 then
                        v160 = v157.Value
                        v161 = v157.Envelope
                    else
                        local v162 = (v155.Time - v156.Time) / (v157.Time - v156.Time)
                        v160 = (v157.Value - v156.Value) * v162 + v156.Value
                        v161 = (v157.Envelope - v156.Envelope) * v162 + v156.Envelope
                    end
                    local v163 = (v155.Value - v160) * p140 + v160
                    local v164 = (v155.Envelope - v161) * p140 + v161
                    local v165 = NumberSequenceKeypoint.new(v155.Time, v163, v164)
                    v141 = v141 + 1
                    v142[v141] = v165
                end
            end
            table.sort(v142, u8)
            return NumberSequence.new(v142)
        end
    end
}, {
    ["__index"] = function(_, p166) --[[ Name: __index, Line 279 ]]
        error("No lerp function is defined for type " .. tostring(p166) .. ".", 4)
    end,
    ["__newindex"] = function(_, p167) --[[ Name: __newindex, Line 283 ]]
        error("No lerp function is defined for type " .. tostring(p167) .. ".", 4)
    end
})