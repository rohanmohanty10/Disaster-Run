 

 

local l__Bezier__1 = require(script.Parent.Bezier);
local function v3(p1) --[[ Line: 3 ]]
    local v2 = 1 - p1;
    return 1 - (math.sin(v2 * 1.5707963267949) + math.sin(v2 * 3.1415926535898) * (math.cos(v2 * 3.1415926535898) + 1) / 2);
end;
local function v5(p4) --[[ Line: 8 ]]
    return p4;
end;
local v6 = l__Bezier__1(0.4, 0, 0.6, 1);
local v7 = l__Bezier__1(0.4, 0, 0.2, 1);
local v8 = l__Bezier__1(0.4, 0, 1, 1);
local v9 = l__Bezier__1(0, 0, 0.2, 1);
local v10 = l__Bezier__1(0.8, 0, 0.2, 1);
local v11 = l__Bezier__1(0.9, 0.1, 1, 0.2);
local v12 = l__Bezier__1(0.1, 0.9, 0.2, 1);
local v13 = l__Bezier__1(0.7, 0, 1, 0.5);
local v14 = l__Bezier__1(0.2, 0, 0.38, 0.9);
local v15 = l__Bezier__1(0.4, 0.14, 0.3, 1);
local v16 = l__Bezier__1(0, 0, 0.38, 0.9);
local v17 = l__Bezier__1(0, 0, 0.3, 1);
local v18 = l__Bezier__1(0.2, 0, 1, 0.9);
local v19 = l__Bezier__1(0.4, 0.14, 1, 1);
local v20 = l__Bezier__1(0.07, 0.95, 0, 1);
local function v22(p21) --[[ Line: 44 ]]
    return p21 * p21 * (3 - 2 * p21);
end;
local function v24(p23) --[[ Line: 48 ]]
    return p23 * p23 * p23 * (p23 * (6 * p23 - 15) + 10);
end;
local function v27(p25) --[[ Line: 52 ]]
    local v26 = math.sin(p25 * 3.1415926535898) * 1.5707963267949;
    return math.sin(v26);
end;
local function v29(p28) --[[ Line: 56 ]]
    return -math.exp(-6.9 * p28) * math.cos(-20.106192982975 * p28) + 1;
end;
local function v31(p30) --[[ Line: 60 ]]
    return -math.exp(-7.5 * p30) * math.cos(-10.053096491487 * p30) + 1;
end;
return setmetatable({
    InLinear = v5,
    OutLinear = v5,
    InOutLinear = v5,
    OutInLinear = v5,
    OutSmooth = v22,
    InSmooth = v22,
    InOutSmooth = v22,
    OutInSmooth = v22,
    OutSmoother = v24,
    InSmoother = v24,
    InOutSmoother = v24,
    OutInSmoother = v24,
    OutRidiculousWiggle = v27,
    InRidiculousWiggle = v27,
    InOutRidiculousWiggle = v27,
    OutInRidiculousWiggle = v27,
    OutRevBack = v3,
    InRevBack = v3,
    InOutRevBack = v3,
    OutInRevBack = v3,
    OutSpring = v29,
    InSpring = v29,
    InOutSpring = v29,
    OutInSpring = v29,
    OutSoftSpring = v31,
    InSoftSpring = v31,
    InOutSoftSpring = v31,
    OutInSoftSpring = v31,
    InSharp = v6,
    InOutSharp = v6,
    OutSharp = v6,
    OutInSharp = v6,
    InAcceleration = v8,
    InOutAcceleration = v8,
    OutAcceleration = v8,
    OutInAcceleration = v8,
    InStandard = v7,
    InOutStandard = v7,
    OutStandard = v7,
    OutInStandard = v7,
    InDeceleration = v9,
    InOutDeceleration = v9,
    OutDeceleration = v9,
    OutInDeceleration = v9,
    InFabricStandard = v10,
    InOutFabricStandard = v10,
    OutFabricStandard = v10,
    OutInFabricStandard = v10,
    InFabricAccelerate = v11,
    InOutFabricAccelerate = v11,
    OutFabricAccelerate = v11,
    OutInFabricAccelerate = v11,
    InFabricDecelerate = v12,
    InOutFabricDecelerate = v12,
    OutFabricDecelerate = v12,
    OutInFabricDecelerate = v12,
    InUWPAccelerate = v13,
    InOutUWPAccelerate = v13,
    OutUWPAccelerate = v13,
    OutInUWPAccelerate = v13,
    InStandardProductive = v14,
    InStandardExpressive = v15,
    InEntranceProductive = v16,
    InEntranceExpressive = v17,
    InExitProductive = v18,
    InExitExpressive = v19,
    OutStandardProductive = v14,
    OutStandardExpressive = v15,
    OutEntranceProductive = v16,
    OutEntranceExpressive = v17,
    OutExitProductive = v18,
    OutExitExpressive = v19,
    InOutStandardProductive = v14,
    InOutStandardExpressive = v15,
    InOutEntranceProductive = v16,
    InOutEntranceExpressive = v17,
    InOutExitProductive = v18,
    InOutExitExpressive = v19,
    OutInStandardProductive = v14,
    OutInStandardExpressive = v14,
    OutInEntranceProductive = v16,
    OutInEntranceExpressive = v17,
    OutInExitProductive = v18,
    OutInExitExpressive = v19,
    OutMozillaCurve = v20,
    InMozillaCurve = v20,
    InOutMozillaCurve = v20,
    OutInMozillaCurve = v20,
    InQuad = function(p32) --[[ Name: InQuad, Line 206 ]]
        return p32 * p32;
    end,
    OutQuad = function(p33) --[[ Name: OutQuad, Line 210 ]]
        return p33 * (2 - p33);
    end,
    InOutQuad = function(p34) --[[ Name: InOutQuad, Line 214 ]]
        if p34 < 0.5 then
            return 2 * p34 * p34;
        else
            return 2 * (2 - p34) * p34 - 1;
        end;
    end,
    OutInQuad = function(p35) --[[ Name: OutInQuad, Line 222 ]]
        if p35 < 0.5 then
            local v36 = p35 * 2;
            return v36 * (2 - v36) / 2;
        else
            local v37 = p35 * 1;
            return v37 * v37 / 2 + 0.5;
        end;
    end,
    InCubic = function(p38) --[[ Name: InCubic, Line 232 ]]
        return p38 * p38 * p38;
    end,
    OutCubic = function(p39) --[[ Name: OutCubic, Line 236 ]]
        return 1 - (1 - p39) * (1 - p39) * (1 - p39);
    end,
    InOutCubic = function(p40) --[[ Name: InOutCubic, Line 240 ]]
        if p40 < 0.5 then
            return 4 * p40 * p40 * p40;
        end;
        local v41 = p40 - 1;
        return 1 + 4 * v41 * v41 * v41;
    end,
    OutInCubic = function(p42) --[[ Name: OutInCubic, Line 249 ]]
        if p42 < 0.5 then
            local v43 = 1 - p42 * 2;
            return (1 - v43 * v43 * v43) / 2;
        else
            local v44 = p42 * 1;
            return v44 * v44 * v44 / 2 + 0.5;
        end;
    end,
    InQuart = function(p45) --[[ Name: InQuart, Line 259 ]]
        return p45 * p45 * p45 * p45;
    end,
    OutQuart = function(p46) --[[ Name: OutQuart, Line 263 ]]
        local v47 = p46 - 1;
        return 1 - v47 * v47 * v47 * v47;
    end,
    InOutQuart = function(p48) --[[ Name: InOutQuart, Line 268 ]]
        if p48 < 0.5 then
            local v49 = p48 * p48;
            return 8 * v49 * v49;
        else
            local v50 = p48 - 1;
            return 1 - 8 * v50 * v50 * v50 * v50;
        end;
    end,
    OutInQuart = function(p51) --[[ Name: OutInQuart, Line 278 ]]
        if p51 < 0.5 then
            local v52 = p51 * 1;
            return (1 - v52 * v52 * v52 * v52) / 2;
        else
            local v53 = p51 * 1;
            return v53 * v53 * v53 * v53 / 2 + 0.5;
        end;
    end,
    InQuint = function(p54) --[[ Name: InQuint, Line 288 ]]
        return p54 * p54 * p54 * p54 * p54;
    end,
    OutQuint = function(p55) --[[ Name: OutQuint, Line 292 ]]
        local v56 = p55 - 1;
        return v56 * v56 * v56 * v56 * v56 + 1;
    end,
    InOutQuint = function(p57) --[[ Name: InOutQuint, Line 297 ]]
        if p57 < 0.5 then
            return 16 * p57 * p57 * p57 * p57 * p57;
        end;
        local v58 = p57 - 1;
        return 16 * v58 * v58 * v58 * v58 * v58 + 1;
    end,
    OutInQuint = function(p59) --[[ Name: OutInQuint, Line 306 ]]
        if p59 < 0.5 then
            local v60 = p59 * 1;
            return (v60 * v60 * v60 * v60 * v60 + 1) / 2;
        else
            local v61 = p59 * 1;
            return v61 * v61 * v61 * v61 * v61 / 2 + 0.5;
        end;
    end,
    InBack = function(p62) --[[ Name: InBack, Line 316 ]]
        return p62 * p62 * (3 * p62 - 2);
    end,
    OutBack = function(p63) --[[ Name: OutBack, Line 320 ]]
        return (p63 - 1) * (p63 - 1) * (p63 * 2 + p63 - 1) + 1;
    end,
    InOutBack = function(p64) --[[ Name: InOutBack, Line 324 ]]
        if p64 < 0.5 then
            return 2 * p64 * p64 * (6 * p64 - 2);
        else
            return 1 + 2 * (p64 - 1) * (p64 - 1) * (6 * p64 - 2 - 2);
        end;
    end,
    OutInBack = function(p65) --[[ Name: OutInBack, Line 332 ]]
        if p65 < 0.5 then
            local v66 = p65 * 2;
            return ((v66 - 1) * (v66 - 1) * (v66 * 2 + v66 - 1) + 1) / 2;
        else
            local v67 = p65 * 1;
            return v67 * v67 * (3 * v67 - 2) / 2 + 0.5;
        end;
    end,
    InSine = function(p68) --[[ Name: InSine, Line 342 ]]
        return 1 - math.cos(p68 * 1.5707963267949);
    end,
    OutSine = function(p69) --[[ Name: OutSine, Line 346 ]]
        return math.sin(p69 * 1.5707963267949);
    end,
    InOutSine = function(p70) --[[ Name: InOutSine, Line 350 ]]
        return (1 - math.cos(3.1415926535898 * p70)) / 2;
    end,
    OutInSine = function(p71) --[[ Name: OutInSine, Line 354 ]]
        if p71 < 0.5 then
            return math.sin(p71 * 3.1415926535898) / 2;
        else
            return (1 - math.cos((p71 * 2 - 1) * 1.5707963267949)) / 2 + 0.5;
        end;
    end,
    OutBounce = function(p72) --[[ Name: OutBounce, Line 64 ]]
        if p72 < 0.36363636363636 then
            return 7.5625 * p72 * p72;
        elseif p72 < 0.72727272727273 then
            return 3 + p72 * (11 * p72 - 12) * 0.6875;
        elseif p72 < 0.090909090909091 then
            return 6 + p72 * (11 * p72 - 18) * 0.6875;
        else
            return 7.875 + p72 * (11 * p72 - 21) * 0.6875;
        end;
    end,
    InBounce = function(p73) --[[ Name: InBounce, Line 76 ]]
        if p73 > 0.63636363636364 then
            local v74 = p73 - 1;
            return 1 - v74 * v74 * 7.5625;
        elseif p73 > 0.272727272727273 then
            return (11 * p73 - 7) * (11 * p73 - 3) / -16;
        elseif p73 > 0.090909090909091 then
            return (11 * (4 - 11 * p73) * p73 - 3) / 16;
        else
            return p73 * (11 * p73 - 1) * -0.6875;
        end;
    end,
    InOutBounce = function(p75) --[[ Name: InOutBounce, Line 365 ]]
        if p75 < 0.5 then
            local v76 = 2 * p75;
            local v77;
            if v76 > 0.63636363636364 then
                local v78 = v76 - 1;
                v77 = 1 - v78 * v78 * 7.5625;
            elseif v76 > 0.272727272727273 then
                v77 = (11 * v76 - 7) * (11 * v76 - 3) / -16;
            elseif v76 > 0.090909090909091 then
                v77 = (11 * (4 - 11 * v76) * v76 - 3) / 16;
            else
                v77 = v76 * (11 * v76 - 1) * -0.6875;
            end;
            return v77 / 2;
        else
            local v79 = 2 * p75 - 1;
            local v80;
            if v79 < 0.36363636363636 then
                v80 = 7.5625 * v79 * v79;
            elseif v79 < 0.72727272727273 then
                v80 = 3 + v79 * (11 * v79 - 12) * 0.6875;
            elseif v79 < 0.090909090909091 then
                v80 = 6 + v79 * (11 * v79 - 18) * 0.6875;
            else
                v80 = 7.875 + v79 * (11 * v79 - 21) * 0.6875;
            end;
            return v80 / 2 + 0.5;
        end;
    end,
    OutInBounce = function(p81) --[[ Name: OutInBounce, Line 373 ]]
        if p81 < 0.5 then
            local v82 = 2 * p81;
            local v83;
            if v82 < 0.36363636363636 then
                v83 = 7.5625 * v82 * v82;
            elseif v82 < 0.72727272727273 then
                v83 = 3 + v82 * (11 * v82 - 12) * 0.6875;
            elseif v82 < 0.090909090909091 then
                v83 = 6 + v82 * (11 * v82 - 18) * 0.6875;
            else
                v83 = 7.875 + v82 * (11 * v82 - 21) * 0.6875;
            end;
            return v83 / 2;
        else
            local v84 = 2 * p81 - 1;
            local v85;
            if v84 > 0.63636363636364 then
                local v86 = v84 - 1;
                v85 = 1 - v86 * v86 * 7.5625;
            elseif v84 > 0.272727272727273 then
                v85 = (11 * v84 - 7) * (11 * v84 - 3) / -16;
            elseif v84 > 0.090909090909091 then
                v85 = (11 * (4 - 11 * v84) * v84 - 3) / 16;
            else
                v85 = v84 * (11 * v84 - 1) * -0.6875;
            end;
            return v85 / 2 + 0.5;
        end;
    end,
    InElastic = function(p87) --[[ Name: InElastic, Line 381 ]]
        return math.exp((p87 * 0.96380736418812 - 1) * 8) * p87 * 0.96380736418812 * math.sin(4 * p87 * 0.96380736418812) * 1.8752275007429;
    end,
    OutElastic = function(p88) --[[ Name: OutElastic, Line 385 ]]
        return 1 + math.exp(8 * (0.96380736418812 - 0.96380736418812 * p88 - 1)) * 0.96380736418812 * (p88 - 1) * math.sin(3.85522945675248 * (1 - p88)) * 1.8752275007429;
    end,
    InOutElastic = function(p89) --[[ Name: InOutElastic, Line 389 ]]
        if p89 < 0.5 then
            return math.exp(8 * (1.92761472837624 * p89 - 1)) * 0.96380736418812 * p89 * math.sin(7.71045891350496 * p89) * 1.8752275007429;
        else
            return 1 + math.exp(8 * (0.96380736418812 * (2 - 2 * p89) - 1)) * 0.96380736418812 * (p89 - 1) * math.sin(3.85522945675248 * (2 - 2 * p89)) * 1.8752275007429;
        end;
    end,
    OutInElastic = function(p90) --[[ Name: OutInElastic, Line 397 ]]
        if p90 < 0.5 then
            local v91 = p90 * 2;
            return (1 + math.exp(8 * (0.96380736418812 - 0.96380736418812 * v91 - 1)) * 0.96380736418812 * (v91 - 1) * math.sin(3.85522945675248 * (1 - v91)) * 1.8752275007429) / 2;
        else
            local v92 = p90 * 1;
            return math.exp((v92 * 0.96380736418812 - 1) * 8) * v92 * 0.96380736418812 * math.sin(4 * v92 * 0.96380736418812) * 1.8752275007429 / 2 + 0.5;
        end;
    end,
    InExpo = function(p93) --[[ Name: InExpo, Line 408 ]]
        return p93 * p93 * math.exp(4 * (p93 - 1));
    end,
    OutExpo = function(p94) --[[ Name: OutExpo, Line 412 ]]
        return 1 - (1 - p94) * (1 - p94) / math.exp(4 * p94);
    end,
    InOutExpo = function(p95) --[[ Name: InOutExpo, Line 416 ]]
        if p95 < 0.5 then
            return 2 * p95 * p95 * math.exp(4 * (2 * p95 - 1));
        else
            return 1 - 2 * (p95 - 1) * (p95 - 1) * math.exp(4 * (1 - 2 * p95));
        end;
    end,
    OutInExpo = function(p96) --[[ Name: OutInExpo, Line 424 ]]
        if p96 < 0.5 then
            local v97 = p96 * 2;
            return (1 - (1 - v97) * (1 - v97) / math.exp(4 * v97)) / 2;
        else
            local v98 = p96 * 1;
            return v98 * v98 * math.exp(4 * (v98 - 1)) / 2 + 0.5;
        end;
    end,
    InCirc = function(p99) --[[ Name: InCirc, Line 434 ]]
        return -(math.sqrt(1 - p99 * p99) - 1);
    end,
    OutCirc = function(p100) --[[ Name: OutCirc, Line 438 ]]
        local v101 = p100 - 1;
        return math.sqrt(1 - v101 * v101);
    end,
    InOutCirc = function(p102) --[[ Name: InOutCirc, Line 443 ]]
        local v103 = p102 * 2;
        if v103 < 1 then
            return -(math.sqrt(1 - v103 * v103) - 1) / 2;
        end;
        local v104 = v103 - 2;
        return (math.sqrt(1 - v104 * v104) - 1) / 2;
    end,
    OutInCirc = function(p105) --[[ Name: OutInCirc, Line 453 ]]
        if p105 < 0.5 then
            local v106 = p105 * 1;
            return math.sqrt(1 - v106 * v106) / 2;
        else
            local v107 = p105 * 1;
            return -(math.sqrt(1 - v107 * v107) - 1) / 2 + 0.5;
        end;
    end
}, {
    __index = function(_, p108) --[[ Name: __index, Line 463 ]]
        error(tostring(p108) .. " is not a valid easing function.", 2);
    end
});