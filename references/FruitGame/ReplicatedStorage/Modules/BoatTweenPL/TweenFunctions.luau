 

local v1 = require(script.Bezier)
local function v9(p2) --[[ Line: 3 ]]
    local v3 = 1 - p2
    local v4 = v3 * 1.5707963267948966
    local v5 = math.sin(v4)
    local v6 = v3 * 3.141592653589793
    local v7 = math.sin(v6)
    local v8 = v3 * 3.141592653589793
    return 1 - (v5 + v7 * (math.cos(v8) + 1) / 2)
end
local v10 = v1(0.4, 0, 0.6, 1)
local v11 = v1(0.4, 0, 0.2, 1)
local v12 = v1(0.4, 0, 1, 1)
local v13 = v1(0, 0, 0.2, 1)
local v14 = v1(0.8, 0, 0.2, 1)
local v15 = v1(0.9, 0.1, 1, 0.2)
local v16 = v1(0.1, 0.9, 0.2, 1)
local v17 = v1(0.7, 0, 1, 0.5)
local v18 = v1(0.2, 0, 0.38, 0.9)
local v19 = v1(0.4, 0.14, 0.3, 1)
local v20 = v1(0, 0, 0.38, 0.9)
local v21 = v1(0, 0, 0.3, 1)
local v22 = v1(0.2, 0, 1, 0.9)
local v23 = v1(0.4, 0.14, 1, 1)
local v24 = v1(0.07, 0.95, 0, 1)
local function v26(p25) --[[ Line: 44 ]]
    return p25 * p25 * (3 - 2 * p25)
end
local function v28(p27) --[[ Line: 48 ]]
    return p27 * p27 * p27 * (p27 * (6 * p27 - 15) + 10)
end
local function v32(p29) --[[ Line: 52 ]]
    local v30 = p29 * 3.141592653589793
    local v31 = math.sin(v30) * 1.5707963267948966
    return math.sin(v31)
end
local function v37(p33) --[[ Line: 56 ]]
    local v34 = -6.9 * p33
    local v35 = -math.exp(v34)
    local v36 = -20.106192982974676 * p33
    return v35 * math.cos(v36) + 1
end
local function v42(p38) --[[ Line: 60 ]]
    local v39 = -7.5 * p38
    local v40 = -math.exp(v39)
    local v41 = -10.053096491487338 * p38
    return v40 * math.cos(v41) + 1
end
return setmetatable({
    ["Linear"] = function(p43) --[[ Name: Linear, Line 10 ]]
        return p43
    end,
    ["OutSmooth"] = v26,
    ["InSmooth"] = v26,
    ["InOutSmooth"] = v26,
    ["OutSmoother"] = v28,
    ["InSmoother"] = v28,
    ["InOutSmoother"] = v28,
    ["OutRidiculousWiggle"] = v32,
    ["InRidiculousWiggle"] = v32,
    ["InOutRidiculousWiggle"] = v32,
    ["OutRevBack"] = v9,
    ["InRevBack"] = v9,
    ["InOutRevBack"] = v9,
    ["OutSpring"] = v37,
    ["InSpring"] = v37,
    ["InOutSpring"] = v37,
    ["OutSoftSpring"] = v42,
    ["InSoftSpring"] = v42,
    ["InOutSoftSpring"] = v42,
    ["InSharp"] = v10,
    ["InOutSharp"] = v10,
    ["OutSharp"] = v10,
    ["InAcceleration"] = v12,
    ["InOutAcceleration"] = v12,
    ["OutAcceleration"] = v12,
    ["InStandard"] = v11,
    ["InOutStandard"] = v11,
    ["OutStandard"] = v11,
    ["InDeceleration"] = v13,
    ["InOutDeceleration"] = v13,
    ["OutDeceleration"] = v13,
    ["InFabricStandard"] = v14,
    ["InOutFabricStandard"] = v14,
    ["OutFabricStandard"] = v14,
    ["InFabricAccelerate"] = v15,
    ["InOutFabricAccelerate"] = v15,
    ["OutFabricAccelerate"] = v15,
    ["InFabricDecelerate"] = v16,
    ["InOutFabricDecelerate"] = v16,
    ["OutFabricDecelerate"] = v16,
    ["InUWPAccelerate"] = v17,
    ["InOutUWPAccelerate"] = v17,
    ["OutUWPAccelerate"] = v17,
    ["InStandardProductive"] = v18,
    ["OutStandardProductive"] = v18,
    ["InOutStandardProductive"] = v18,
    ["InStandardExpressive"] = v19,
    ["OutStandardExpressive"] = v19,
    ["InOutStandardExpressive"] = v19,
    ["InEntranceProductive"] = v20,
    ["OutEntranceProductive"] = v20,
    ["InOutEntranceProductive"] = v20,
    ["InEntranceExpressive"] = v21,
    ["OutEntranceExpressive"] = v21,
    ["InOutEntranceExpressive"] = v21,
    ["InExitProductive"] = v22,
    ["OutExitProductive"] = v22,
    ["InOutExitProductive"] = v22,
    ["InExitExpressive"] = v23,
    ["OutExitExpressive"] = v23,
    ["InOutExitExpressive"] = v23,
    ["OutMozillaCurve"] = v24,
    ["InMozillaCurve"] = v24,
    ["InOutMozillaCurve"] = v24,
    ["InQuad"] = function(p44) --[[ Name: InQuad, Line 171 ]]
        return p44 * p44
    end,
    ["OutQuad"] = function(p45) --[[ Name: OutQuad, Line 175 ]]
        return p45 * (2 - p45)
    end,
    ["InOutQuad"] = function(p46) --[[ Name: InOutQuad, Line 179 ]]
        return p46 < 0.5 and 2 * p46 * p46 or 2 * (2 - p46) * p46 - 1
    end,
    ["InCubic"] = function(p47) --[[ Name: InCubic, Line 183 ]]
        return p47 * p47 * p47
    end,
    ["OutCubic"] = function(p48) --[[ Name: OutCubic, Line 187 ]]
        return 1 - (1 - p48) * (1 - p48) * (1 - p48)
    end,
    ["InOutCubic"] = function(p49) --[[ Name: InOutCubic, Line 191 ]]
        return p49 < 0.5 and 4 * p49 * p49 * p49 or 1 + 4 * (p49 - 1) * (p49 - 1) * (p49 - 1)
    end,
    ["InQuart"] = function(p50) --[[ Name: InQuart, Line 195 ]]
        return p50 * p50 * p50 * p50
    end,
    ["OutQuart"] = function(p51) --[[ Name: OutQuart, Line 199 ]]
        local v52 = p51 - 1
        return 1 - v52 * v52 * v52 * v52
    end,
    ["InOutQuart"] = function(p53) --[[ Name: InOutQuart, Line 204 ]]
        if p53 < 0.5 then
            local v54 = p53 * p53
            return 8 * v54 * v54
        else
            local v55 = p53 - 1
            return 1 - 8 * v55 * v55 * v55 * v55
        end
    end,
    ["InQuint"] = function(p56) --[[ Name: InQuint, Line 214 ]]
        return p56 * p56 * p56 * p56 * p56
    end,
    ["OutQuint"] = function(p57) --[[ Name: OutQuint, Line 218 ]]
        local v58 = p57 - 1
        return v58 * v58 * v58 * v58 * v58 + 1
    end,
    ["InOutQuint"] = function(p59) --[[ Name: InOutQuint, Line 223 ]]
        if p59 < 0.5 then
            return 16 * p59 * p59 * p59 * p59 * p59
        end
        local v60 = p59 - 1
        return 16 * v60 * v60 * v60 * v60 * v60 + 1
    end,
    ["InBack"] = function(p61) --[[ Name: InBack, Line 232 ]]
        return p61 * p61 * (3 * p61 - 2)
    end,
    ["OutBack"] = function(p62) --[[ Name: OutBack, Line 236 ]]
        return (p62 - 1) * (p62 - 1) * (p62 * 2 + p62 - 1) + 1
    end,
    ["InOutBack"] = function(p63) --[[ Name: InOutBack, Line 240 ]]
        return p63 < 0.5 and 2 * p63 * p63 * (6 * p63 - 2) or 1 + 2 * (p63 - 1) * (p63 - 1) * (6 * p63 - 2 - 2)
    end,
    ["InSine"] = function(p64) --[[ Name: InSine, Line 244 ]]
        local v65 = p64 * 1.5707963267948966
        return 1 - math.cos(v65)
    end,
    ["OutSine"] = function(p66) --[[ Name: OutSine, Line 248 ]]
        local v67 = p66 * 1.5707963267948966
        return math.sin(v67)
    end,
    ["InOutSine"] = function(p68) --[[ Name: InOutSine, Line 252 ]]
        local v69 = 3.141592653589793 * p68
        return (1 - math.cos(v69)) / 2
    end,
    ["OutBounce"] = function(p70) --[[ Name: OutBounce, Line 64 ]]
        return p70 < 0.36363636363636365 and 7.5625 * p70 * p70 or p70 < 0.7272727272727273 and 3 + p70 * (11 * p70 - 12) * 0.6875 or (p70 < 0.9090909090909091 and 6 + p70 * (11 * p70 - 18) * 0.6875 or 7.875 + p70 * (11 * p70 - 21) * 0.6875)
    end,
    ["InBounce"] = function(p71) --[[ Name: InBounce, Line 71 ]]
        if p71 > 0.6363636363636364 then
            local v72 = p71 - 1
            return 1 - v72 * v72 * 7.5625
        elseif p71 > 0.2727272727272727 then
            return (11 * p71 - 7) * (11 * p71 - 3) / -16
        elseif p71 > 0.09090909090909091 then
            return (11 * (4 - 11 * p71) * p71 - 3) / 16
        else
            return p71 * (11 * p71 - 1) * -0.6875
        end
    end,
    ["InOutBounce"] = function(p73) --[[ Name: InOutBounce, Line 259 ]]
        if p73 < 0.5 then
            local v74 = 2 * p73
            local v75
            if v74 > 0.6363636363636364 then
                local v76 = v74 - 1
                v75 = 1 - v76 * v76 * 7.5625
            elseif v74 > 0.2727272727272727 then
                v75 = (11 * v74 - 7) * (11 * v74 - 3) / -16
            elseif v74 > 0.09090909090909091 then
                v75 = (11 * (4 - 11 * v74) * v74 - 3) / 16
            else
                v75 = v74 * (11 * v74 - 1) * -0.6875
            end
            v78 = v75 / 2
            if v78 then
                ::l10::
                return v78
            end
        end
        local v77 = 2 * p73 - 1
        local v78 = (v77 < 0.36363636363636365 and 7.5625 * v77 * v77 or v77 < 0.7272727272727273 and 3 + v77 * (11 * v77 - 12) * 0.6875 or (v77 < 0.9090909090909091 and 6 + v77 * (11 * v77 - 18) * 0.6875 or 7.875 + v77 * (11 * v77 - 21) * 0.6875)) / 2 + 0.5
        goto l10
    end,
    ["InElastic"] = function(p79) --[[ Name: InElastic, Line 263 ]]
        local v80 = (p79 * 0.9638073641881153 - 1) * 8
        local v81 = math.exp(v80) * p79 * 0.9638073641881153
        local v82 = 4 * p79 * 0.9638073641881153
        return v81 * math.sin(v82) * 1.8752275007428716
    end,
    ["OutElastic"] = function(p83) --[[ Name: OutElastic, Line 269 ]]
        local v84 = 8 * (0.9638073641881153 - 0.9638073641881153 * p83 - 1)
        local v85 = math.exp(v84) * 0.9638073641881153 * (p83 - 1)
        local v86 = 3.855229456752461 * (1 - p83)
        return 1 + v85 * math.sin(v86) * 1.8752275007428716
    end,
    ["InOutElastic"] = function(p87) --[[ Name: InOutElastic, Line 276 ]]
        if p87 < 0.5 then
            local v88 = 8 * (1.9276147283762306 * p87 - 1)
            local v89 = math.exp(v88) * 0.9638073641881153 * p87
            local v90 = 7.710458913504922 * p87
            v94 = v89 * math.sin(v90) * 1.8752275007428716
            if v94 then
                ::l3::
                return v94
            end
        end
        local v91 = 8 * (0.9638073641881153 * (2 - 2 * p87) - 1)
        local v92 = math.exp(v91) * 0.9638073641881153 * (p87 - 1)
        local v93 = 3.855229456752461 * (2 - 2 * p87)
        local v94 = 1 + v92 * math.sin(v93) * 1.8752275007428716
        goto l3
    end,
    ["InExponential"] = function(p95) --[[ Name: InExponential, Line 281 ]]
        local v96 = p95 * p95
        local v97 = 4 * (p95 - 1)
        return v96 * math.exp(v97)
    end,
    ["OutExponential"] = function(p98) --[[ Name: OutExponential, Line 285 ]]
        local v99 = (1 - p98) * (1 - p98)
        local v100 = 4 * p98
        return 1 - v99 / math.exp(v100)
    end,
    ["InOutExponential"] = function(p101) --[[ Name: InOutExponential, Line 289 ]]
        if p101 < 0.5 then
            local v102 = 2 * p101 * p101
            local v103 = 4 * (2 * p101 - 1)
            v106 = v102 * math.exp(v103)
            if v106 then
                ::l3::
                return v106
            end
        end
        local v104 = 2 * (p101 - 1) * (p101 - 1)
        local v105 = 4 * (1 - 2 * p101)
        local v106 = 1 - v104 * math.exp(v105)
        goto l3
    end,
    ["InCircular"] = function(p107) --[[ Name: InCircular, Line 293 ]]
        local v108 = 1 - p107 * p107
        return -(math.sqrt(v108) - 1)
    end,
    ["OutCircular"] = function(p109) --[[ Name: OutCircular, Line 297 ]]
        local v110 = p109 - 1
        local v111 = 1 - v110 * v110
        return math.sqrt(v111)
    end,
    ["InOutCircular"] = function(p112) --[[ Name: InOutCircular, Line 302 ]]
        local v113 = p112 * 2
        if v113 < 1 then
            local v114 = 1 - v113 * v113
            return -(math.sqrt(v114) - 1) / 2
        end
        local v115 = v113 - 2
        local v116 = 1 - v115 * v115
        return (math.sqrt(v116) - 1) / 2
    end
}, {
    ["__index"] = function(_, p117) --[[ Name: __index, Line 312 ]]
        error(tostring(p117) .. " is not a valid easing style.", 2)
    end
})