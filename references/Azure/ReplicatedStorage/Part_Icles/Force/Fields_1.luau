 
 

local u1 = {};
local u2 = {
    Front = CFrame.new(),
    Back = CFrame.Angles(0, 3.141592653589793, 0),
    Right = CFrame.Angles(0, -1.5707963267948966, 0),
    Left = CFrame.Angles(0, 1.5707963267948966, 0),
    Top = CFrame.Angles(1.5707963267948966, 0, 0),
    Bottom = CFrame.Angles(-1.5707963267948966, 0, 0)
};

function u1.orient(p3, p4) -- Line: 38
    -- upvalues: u2 (copy)
    return p3 * (u2[p4] or u2.Front);
end;

function u1.new(p5, p6, p7) -- Line: 43
    local v8 = {
        shape = p5,
        origin = p6,
        range = p7.Range,
        inner = p7.Inner,
        halfWidth = p7.Width / 2,
        halfHeight = p7.Height / 2,
        height = p7.Height
    };
    local math_clamp_ret = math.clamp(p7.Angle, 0, 360);
    local v9 = math.rad(math_clamp_ret) / 2;
    v8.cosHalfAngle = math.cos(v9);
    v8.lift = p7.Lift;
    v8.spin = p7.Spin;
    v8.pull = p7.Pull;

    return v8;
end;

local function lifted(p10, p11) -- Line: 60
    if p11 == 0 then
        return p10;
    end;

    local v12 = p10 + Vector3.new(0, 1, 0) * p11;
    local Magnitude = v12.Magnitude;

    if Magnitude < 0.0001 then
        return p10;
    end;

    return v12 / Magnitude;
end;

local function sampleRadial(p13, p14, p15, p16) -- Line: 72
    local v17 = p14 - p13.origin.Position;
    local Magnitude = v17.Magnitude;

    if p13.range < Magnitude or Magnitude < p13.inner then
        return nil;
    end;

    local v18;

    if Magnitude > 0.0001 then
        v18 = v17 / Magnitude;

        if p15 and v18:Dot(p13.origin.LookVector) < p13.cosHalfAngle then
            return nil;
        end;
    else
        v18 = Vector3.new(0, 1, 0);
    end;

    if p16 then
        v18 = -v18;
    end;

    local lift = p13.lift;

    if lift ~= 0 then
        local v19 = v18 + Vector3.new(0, 1, 0) * lift;
        local Magnitude2 = v19.Magnitude;

        if Magnitude2 >= 0.0001 then
            v18 = v19 / Magnitude2;
        end;
    end;

    return v18, Magnitude, Magnitude / p13.range;
end;

function u1.heading(p20, p21) -- Line: 93
    local LookVector = p20.origin.LookVector;

    if p21 then
        LookVector = -LookVector;
    end;

    local lift = p20.lift;

    if lift == 0 then
        return LookVector;
    end;

    local v22 = LookVector + Vector3.new(0, 1, 0) * lift;
    local Magnitude = v22.Magnitude;

    if Magnitude < 0.0001 then
        return LookVector;
    end;

    return v22 / Magnitude;
end;

local function sampleLinear(p23, p24, p25) -- Line: 101
    -- upvalues: u1 (copy)
    local v26 = p23.origin:PointToObjectSpace(p24);
    local v27 = -v26.Z;

    if p23.range < v27 or v27 < p23.inner then
        return nil;
    end;

    if math.abs(v26.X) > p23.halfWidth or math.abs(v26.Y) > p23.halfHeight then
        return nil;
    end;

    return u1.heading(p23, p25), v27, v27 / p23.range;
end;

u1.VORTEX_UNDER = 0.1;

local function sampleVortex(p28, p29, p30) -- Line: 120
    local LookVector = p28.origin.LookVector;
    local v31 = p29 - p28.origin.Position;
    local v32 = v31:Dot(LookVector);

    if v32 < -p28.height * 0.1 or p28.height < v32 then
        return nil;
    end;

    local v33 = v31 - LookVector * v32;
    local Magnitude = v33.Magnitude;

    if p28.range < Magnitude or Magnitude < p28.inner then
        return nil;
    end;

    local RightVector = p28.origin.RightVector;

    if Magnitude > 0.0001 then
        RightVector = v33 / Magnitude;
    end;

    local v34 = LookVector:Cross(RightVector) * p28.spin - RightVector * p28.pull + LookVector * p28.lift;

    if p30 then
        v34 = -v34;
    end;

    return v34, Magnitude, Magnitude / p28.range;
end;

function u1.sample(p35, p36, p37) -- Line: 144
    -- upvalues: sampleLinear (copy), sampleVortex (copy), sampleRadial (copy)
    if p35.range <= 0 then
        return nil;
    end;

    local shape = p35.shape;

    if shape == "Linear" then
        return sampleLinear(p35, p36, p37);
    end;

    if shape == "Vortex" then
        return sampleVortex(p35, p36, p37);
    end;

    return sampleRadial(p35, p36, shape == "Cone", p37);
end;

function u1.frontSpeed(p38, p39) -- Line: 159
    return (p39 <= 0 or p38 <= 0) and 0 or p38 / p39;
end;

function u1.kept(p40, p41) -- Line: 168
    local v42 = 1 - math.clamp(p40, 0, 1) * p41;

    return math.max(v42, 0);
end;

function u1.reachesAny(p43, p44, p45, p46) -- Line: 176
    -- upvalues: u1 (copy)
    for _, v in ipairs(p45) do
        if u1.sample(p43, p44:PointToWorldSpace(v), p46) then
            return true;
        end;
    end;

    return false;
end;

function u1.sizeShare(p47, p48) -- Line: 185
    return (p48 <= 0 or p47 <= 0) and 1 or math.clamp((4 / p47) ^ p48, 0.1, 1);
end;

function u1.throwSpeed(p49, p50) -- Line: 195
    local v51 = math.abs(p49) * math.max(p50, 10);

    return math.sqrt(v51);
end;

return u1;