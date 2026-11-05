 

 

local v1 = {};
local u2 = 0;
local u3 = 1;
function v1.Damping(p4) --[[ Line: 2 ]]
    -- upvalues: u2 (copy), u3 (copy)
    return math.clamp(p4, u2, u3);
end;
function v1.AnchorDepth(p5) --[[ Line: 7 ]]
    return math.floor(p5);
end;
local u6 = 0;
local u7 = 1;
function v1.Stiffness(p8) --[[ Line: 2 ]]
    -- upvalues: u6 (copy), u7 (copy)
    return math.clamp(p8, u6, u7);
end;
local u9 = 0;
local u10 = 1;
function v1.Inertia(p11) --[[ Line: 2 ]]
    -- upvalues: u9 (copy), u10 (copy)
    return math.clamp(p11, u9, u10);
end;
local u12 = 0;
local u13 = 1;
function v1.Elasticity(p14) --[[ Line: 2 ]]
    -- upvalues: u12 (copy), u13 (copy)
    return math.clamp(p14, u12, u13);
end;
local u15 = 0;
local u16 = 1;
function v1.BlendWeight(p17) --[[ Line: 2 ]]
    -- upvalues: u15 (copy), u16 (copy)
    return math.clamp(p17, u15, u16);
end;
local u18 = 0;
local u19 = 165;
function v1.UpdateRate(p20) --[[ Line: 2 ]]
    -- upvalues: u18 (copy), u19 (copy)
    return math.clamp(p20, u18, u19);
end;
local u21 = 0;
local u22 = 10;
function v1.WindStrength(p23) --[[ Line: 2 ]]
    -- upvalues: u21 (copy), u22 (copy)
    return math.clamp(p23, u21, u22);
end;
local u24 = Vector3.new(0, -0.01, 0);
function v1.Gravity(p25) --[[ Line: 12 ]]
    -- upvalues: u24 (copy)
    return p25 + u24;
end;
return v1;