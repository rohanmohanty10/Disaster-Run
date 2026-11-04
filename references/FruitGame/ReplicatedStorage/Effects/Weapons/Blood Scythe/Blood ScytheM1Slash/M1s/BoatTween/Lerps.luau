 

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
return setmetatable({
    ["boolean"] = function(u10, u11) --[[ Name: boolean, Line 21 ]]
        return function(p12) --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u11
            --]]
            if p12 < 0.5 then
                return u10
            else
                return u11
            end
        end
    end,
    ["number"] = function(u13, p14) --[[ Name: number, Line 31 ]]
        local u15 = p14 - u13
        return function(p16) --[[ Line: 33 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u15
            --]]
            return u13 + u15 * p16
        end
    end,
    ["CFrame"] = v6,
    ["Color3"] = function(p17, p18) --[[ Name: Color3, Line 39 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v19 = p17.R
        local v20 = p17.G
        local v21 = p17.B
        local v22 = v19 < 0.0404482362771076 and v19 / 12.92 or 0.87941546140213 * (v19 + 0.055) ^ 2.4
        local v23 = v20 < 0.0404482362771076 and v20 / 12.92 or 0.87941546140213 * (v20 + 0.055) ^ 2.4
        local v24 = v21 < 0.0404482362771076 and v21 / 12.92 or 0.87941546140213 * (v21 + 0.055) ^ 2.4
        local v25 = 0.2125862307855956 * v22 + 0.7151703037034108 * v23 + 0.0722004986433362 * v24
        local v26 = 3.6590806972265884 * v22 + 11.442689580057424 * v23 + 4.114991502426484 * v24
        local u27 = v25 > 0.008856451679035631 and 116 * v25 ^ 0.3333333333333333 - 16 or 903.296296296296 * v25
        local u28, u29
        if v26 > 1e-15 then
            u28 = u27 * (0.9257063972951867 * v22 - 0.8333736323779866 * v23 - 0.09209820666085898 * v24) / v26
            u29 = u27 * (9 * v25 / v26 - 0.46832)
        else
            u28 = -0.19783 * u27
            u29 = -0.46832 * u27
        end
        local v30 = p18.R
        local v31 = p18.G
        local v32 = p18.B
        local v33 = v30 < 0.0404482362771076 and v30 / 12.92 or 0.87941546140213 * (v30 + 0.055) ^ 2.4
        local v34 = v31 < 0.0404482362771076 and v31 / 12.92 or 0.87941546140213 * (v31 + 0.055) ^ 2.4
        local v35 = v32 < 0.0404482362771076 and v32 / 12.92 or 0.87941546140213 * (v32 + 0.055) ^ 2.4
        local v36 = 0.2125862307855956 * v33 + 0.7151703037034108 * v34 + 0.0722004986433362 * v35
        local v37 = 3.6590806972265884 * v33 + 11.442689580057424 * v34 + 4.114991502426484 * v35
        local u38 = v36 > 0.008856451679035631 and 116 * v36 ^ 0.3333333333333333 - 16 or 903.296296296296 * v36
        local u39, u40
        if v37 > 1e-15 then
            u39 = u38 * (0.9257063972951867 * v33 - 0.8333736323779866 * v34 - 0.09209820666085898 * v35) / v37
            u40 = u38 * (9 * v36 / v37 - 0.46832)
        else
            u39 = -0.19783 * u38
            u40 = -0.46832 * u38
        end
        return function(p41) --[[ Line: 74 ]]
            --[[
            Upvalues:
                [1] = u27
                [2] = u38
                [3] = u2
                [4] = u28
                [5] = u39
                [6] = u29
                [7] = u40
            --]]
            local v42 = (1 - p41) * u27 + p41 * u38
            if v42 < 0.0197955 then
                return u2
            end
            local v43 = ((1 - p41) * u28 + p41 * u39) / v42 + 0.19783
            local v44 = ((1 - p41) * u29 + p41 * u40) / v42 + 0.46832
            local v45 = (v42 + 16) / 116
            local v46 = v45 > 0.20689655172413793 and v45 * v45 * v45 or 0.12841854934601665 * v45 - 0.01771290335807126
            local v47 = v46 * v43 / v44
            local v48 = v46 * ((3 - 0.75 * v43) / v44 - 5)
            local v49 = 7.2914074 * v47 - 1.537208 * v46 - 0.4986286 * v48
            local v50 = -2.180094 * v47 + 1.8757561 * v46 + 0.0415175 * v48
            local v51 = 0.1253477 * v47 - 0.2040211 * v46 + 1.0569959 * v48
            if v49 < 0 and (v49 < v50 and v49 < v51) then
                v50 = v50 - v49
                v51 = v51 - v49
                v49 = 0
            elseif v50 < 0 and v50 < v51 then
                v49 = v49 - v50
                v51 = v51 - v50
                v50 = 0
            elseif v51 < 0 then
                v49 = v49 - v51
                v50 = v50 - v51
                v51 = 0
            end
            local v52 = v49 < 0.0031306684425 and 12.92 * v49 or 1.055 * v49 ^ 0.4166666666666667 - 0.055
            local v53 = v50 < 0.0031306684425 and 12.92 * v50 or 1.055 * v50 ^ 0.4166666666666667 - 0.055
            local v54 = v51 < 0.0031306684425 and 12.92 * v51 or 1.055 * v51 ^ 0.4166666666666667 - 0.055
            return Color3.new(v52 > 1 and 1 or (v52 < 0 and 0 or v52), v53 > 1 and 1 or (v53 < 0 and 0 or v53), v54 > 1 and 1 or (v54 < 0 and 0 or v54))
        end
    end,
    ["NumberRange"] = function(p55, p56) --[[ Name: NumberRange, Line 112 ]]
        local u57 = p55.Min
        local u58 = p55.Max
        local u59 = p56.Min - u57
        local u60 = p56.Max - u58
        return function(p61) --[[ Line: 116 ]]
            --[[
            Upvalues:
                [1] = u57
                [2] = u59
                [3] = u58
                [4] = u60
            --]]
            return NumberRange.new(u57 + p61 * u59, u58 + p61 * u60)
        end
    end,
    ["NumberSequenceKeypoint"] = function(p62, p63) --[[ Name: NumberSequenceKeypoint, Line 121 ]]
        local u64 = p62.Time
        local u65 = p62.Value
        local u66 = p62.Envelope
        local u67 = p63.Time - u64
        local u68 = p63.Value - u65
        local u69 = p63.Envelope - u66
        return function(p70) --[[ Line: 125 ]]
            --[[
            Upvalues:
                [1] = u64
                [2] = u67
                [3] = u65
                [4] = u68
                [5] = u66
                [6] = u69
            --]]
            return NumberSequenceKeypoint.new(u64 + p70 * u67, u65 + p70 * u68, u66 + p70 * u69)
        end
    end,
    ["PhysicalProperties"] = function(p71, p72) --[[ Name: PhysicalProperties, Line 130 ]]
        local u73 = p71.Density
        local u74 = p71.Elasticity
        local u75 = p71.ElasticityWeight
        local u76 = p71.Friction
        local u77 = p71.FrictionWeight
        local u78 = p72.Density - u73
        local u79 = p72.Elasticity - u74
        local u80 = p72.ElasticityWeight - u75
        local u81 = p72.Friction - u76
        local u82 = p72.FrictionWeight - u77
        return function(p83) --[[ Line: 141 ]]
            --[[
            Upvalues:
                [1] = u73
                [2] = u78
                [3] = u74
                [4] = u79
                [5] = u75
                [6] = u80
                [7] = u76
                [8] = u81
                [9] = u77
                [10] = u82
            --]]
            return PhysicalProperties.new(u73 + p83 * u78, u74 + p83 * u79, u75 + p83 * u80, u76 + p83 * u81, u77 + p83 * u82)
        end
    end,
    ["Ray"] = function(p84, p85) --[[ Name: Ray, Line 150 ]]
        local v86 = p84.Origin
        local v87 = p84.Direction
        local v88 = p85.Origin
        local v89 = p85.Direction
        local u90 = v86.X
        local u91 = v86.Y
        local u92 = v86.Z
        local u93 = v87.X
        local u94 = v87.Y
        local u95 = v87.Z
        local u96 = v88.X - u90
        local u97 = v88.Y - u91
        local u98 = v88.Z - u92
        local u99 = v89.X - u93
        local u100 = v89.Y - u94
        local u101 = v89.Z - u95
        return function(p102) --[[ Line: 155 ]]
            --[[
            Upvalues:
                [1] = u90
                [2] = u96
                [3] = u91
                [4] = u97
                [5] = u92
                [6] = u98
                [7] = u93
                [8] = u99
                [9] = u94
                [10] = u100
                [11] = u95
                [12] = u101
            --]]
            local v103 = Ray.new
            local v104 = u90 + p102 * u96
            local v105 = u91 + p102 * u97
            local v106 = u92 + p102 * u98
            local v107 = Vector3.new(v104, v105, v106)
            local v108 = u93 + p102 * u99
            local v109 = u94 + p102 * u100
            local v110 = u95 + p102 * u101
            return v103(v107, (Vector3.new(v108, v109, v110)))
        end
    end,
    ["UDim"] = function(p111, p112) --[[ Name: UDim, Line 163 ]]
        local u113 = p111.Scale
        local u114 = p111.Offset
        local u115 = p112.Scale - u113
        local u116 = p112.Offset - u114
        return function(p117) --[[ Line: 167 ]]
            --[[
            Upvalues:
                [1] = u113
                [2] = u115
                [3] = u114
                [4] = u116
            --]]
            return UDim.new(u113 + p117 * u115, u114 + p117 * u116)
        end
    end,
    ["UDim2"] = v6,
    ["Vector2"] = v6,
    ["Vector3"] = v6,
    ["Rect"] = function(u118, u119) --[[ Name: Rect, Line 175 ]]
        return function(p120) --[[ Line: 176 ]]
            --[[
            Upvalues:
                [1] = u118
                [2] = u119
            --]]
            return Rect.new(u118.Min.X + p120 * (u119.Min.X - u118.Min.X), u118.Min.Y + p120 * (u119.Min.Y - u118.Min.Y), u118.Max.X + p120 * (u119.Max.X - u118.Max.X), u118.Max.Y + p120 * (u119.Max.Y - u118.Max.Y))
        end
    end,
    ["Region3"] = function(u121, u122) --[[ Name: Region3, Line 184 ]]
        return function(p123) --[[ Line: 185 ]]
            --[[
            Upvalues:
                [1] = u121
                [2] = u122
            --]]
            local v124 = u121.CFrame * (-u121.Size / 2)
            local v125 = v124 + p123 * (u122.CFrame * (-u122.Size / 2) - v124)
            local v126 = u121.CFrame * (u121.Size / 2)
            local v127 = v126 + p123 * (u122.CFrame * (u122.Size / 2) - v126)
            local v128 = v125.X
            local v129 = v127.X
            local v130 = v125.Y
            local v131 = v127.Y
            local v132 = v125.Z
            local v133 = v127.Z
            local v134 = Region3.new
            local v135 = v128 < v129 and v128 and v128 or v129
            local v136 = v130 < v131 and v130 and v130 or v131
            local v137 = v132 < v133 and v132 and v132 or v133
            local v138 = Vector3.new(v135, v136, v137)
            if v129 < v128 then
                v129 = v128 or v129
            end
            if v131 < v130 then
                v131 = v130 or v131
            end
            if v133 < v132 then
                v133 = v132 or v133
            end
            return v134(v138, (Vector3.new(v129, v131, v133)))
        end
    end,
    ["NumberSequence"] = function(u139, u140) --[[ Name: NumberSequence, Line 203 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u9
        --]]
        return function(p141) --[[ Line: 204 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u139
                [3] = u140
                [4] = u9
            --]]
            local v142 = 0
            local v143 = {}
            local v144 = {}
            for _, v145 in u1(u139.Keypoints) do
                local v146 = nil
                local v147 = nil
                for _, v148 in u1(u140.Keypoints) do
                    if v148.Time == v145.Time then
                        v146 = v148
                        v147 = v146
                        local v149 = v146
                        v146 = v147
                        v149 = v147
                        break
                    end
                    if v148.Time < v145.Time and (v146 == nil or v148.Time > v146.Time) then
                        v146 = v148
                    elseif v148.Time > v145.Time and (v147 == nil or v148.Time < v147.Time) then
                        v147 = v148
                    end
                end
                local v150, v151
                if v147 == v146 then
                    v150 = v147.Value
                    v151 = v147.Envelope
                else
                    local v152 = (v145.Time - v146.Time) / (v147.Time - v146.Time)
                    v150 = (v147.Value - v146.Value) * v152 + v146.Value
                    v151 = (v147.Envelope - v146.Envelope) * v152 + v146.Envelope
                end
                local v153 = (v150 - v145.Value) * p141 + v145.Value
                local v154 = (v151 - v145.Envelope) * p141 + v145.Envelope
                local v155 = NumberSequenceKeypoint.new(v145.Time, v153, v154)
                v142 = v142 + 1
                v143[v142] = v155
                v144[v145.Time] = true
            end
            for _, v156 in u1(u140.Keypoints) do
                if not v144[v156.Time] then
                    local v157 = nil
                    local v158 = nil
                    for _, v159 in u1(u139.Keypoints) do
                        if v159.Time == v156.Time then
                            v157 = v159
                            v158 = v157
                            local v160 = v157
                            v157 = v158
                            v160 = v158
                            break
                        end
                        if v159.Time < v156.Time and (v157 == nil or v159.Time > v157.Time) then
                            v157 = v159
                        elseif v159.Time > v156.Time and (v158 == nil or v159.Time < v158.Time) then
                            v158 = v159
                        end
                    end
                    local v161, v162
                    if v158 == v157 then
                        v161 = v158.Value
                        v162 = v158.Envelope
                    else
                        local v163 = (v156.Time - v157.Time) / (v158.Time - v157.Time)
                        v161 = (v158.Value - v157.Value) * v163 + v157.Value
                        v162 = (v158.Envelope - v157.Envelope) * v163 + v157.Envelope
                    end
                    local v164 = (v156.Value - v161) * p141 + v161
                    local v165 = (v156.Envelope - v162) * p141 + v162
                    local v166 = NumberSequenceKeypoint.new(v156.Time, v164, v165)
                    v142 = v142 + 1
                    v143[v142] = v166
                end
            end
            table.sort(v143, u9)
            return NumberSequence.new(v143)
        end
    end
}, {
    ["__index"] = function(_, p167) --[[ Name: __index, Line 279 ]]
        error("No lerp function is defined for type " .. tostring(p167) .. ".", 4)
    end,
    ["__newindex"] = function(_, p168) --[[ Name: __newindex, Line 283 ]]
        error("No lerp function is defined for type " .. tostring(p168) .. ".", 4)
    end
})