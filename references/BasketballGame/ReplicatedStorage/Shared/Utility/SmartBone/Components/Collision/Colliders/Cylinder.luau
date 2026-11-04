 
 

local function SafeUnit(p1) -- Line: 2
    return p1.Magnitude == 0 and Vector3.new(0, 0, 0) or p1.Unit;
end;

local function solve(p2, p3, p4, p5) -- Line: 10
    local v6 = (p5 - p2):Dot(p3);
    local math_clamp_ret = math.clamp(v6, -p4, p4);

    return p2 + p3 * math_clamp_ret, math_clamp_ret;
end;

local function ProjectOnPlane(p7, p8, p9) -- Line: 17
    return p9 - (p9 - p7):Dot(p8) * p8;
end;

local function ClosestPointFunc(p10, p11, p12) -- Line: 25
    local u13 = math.min(p11.Y, p11.Z) * 0.5;
    local v14 = p11.X * 0.5;
    local Position = p10.Position;
    local RightVector = p10.RightVector;
    local v15 = (p12 - Position):Dot(RightVector);
    local math_clamp_ret = math.clamp(v15, -v14, v14);
    local v16 = Position + RightVector * math_clamp_ret;
    local v17 = p10.Position + -p10.RightVector * v14;
    local v18 = p10.Position + p10.RightVector * v14;
    local v19 = -p10.RightVector;
    local RightVector2 = p10.RightVector;
    local v20 = p12 - (p12 - v17):Dot(v19) * v19;
    local v21 = p12 - (p12 - v18):Dot(RightVector2) * RightVector2;

    local function GetFinalProj(p22, p23) -- Line: 39
        -- upvalues: u13 (copy)
        local v24 = p22 - p23;

        return p23 + (v24.Magnitude == 0 and Vector3.new(0, 0, 0) or v24.Unit) * math.min((p22 - p23).Magnitude, u13);
    end;

    local v25 = v20 - v17;
    local v26 = v17 + (v25.Magnitude == 0 and Vector3.new(0, 0, 0) or v25.Unit) * math.min((v20 - v17).Magnitude, u13);
    local v27 = v21 - v18;
    local v28 = v18 + (v27.Magnitude == 0 and Vector3.new(0, 0, 0) or v27.Unit) * math.min((v21 - v18).Magnitude, u13);
    local v29 = p12 - v16;
    local v30 = v29.Magnitude == 0 and Vector3.new(0, 0, 0) or v29.Unit;
    local v31 = (v16 - p12).Magnitude <= u13;
    local v32 = v16 + v30 * u13;
    local Magnitude = (v28 - p12).Magnitude;
    local Magnitude2 = (v26 - p12).Magnitude;
    local math_min_ret = math.min(Magnitude, Magnitude2, (v32 - p12).Magnitude);

    if math_clamp_ret == v14 or math_min_ret == Magnitude then
        local v33 = p12 - v28;

        return (v33.Magnitude == 0 and Vector3.new(0, 0, 0) or v33.Unit):Dot(RightVector2) < 0, v28, RightVector2;
    end;

    if math_clamp_ret ~= -v14 and math_min_ret ~= Magnitude2 then
        return v31, v32, v30;
    end;

    local v34 = p12 - v26;

    return (v34.Magnitude == 0 and Vector3.new(0, 0, 0) or v34.Unit):Dot(v19) < 0, v26, v19;
end;

return function(p35, p36, p37, p38) -- Line: 70
    -- upvalues: ClosestPointFunc (copy)
    debug.profilebegin("Cylinder Testing");
    local v39, v40, v41 = ClosestPointFunc(p35, p36, p37);

    if v39 then
        return v39, v40, v41;
    end;

    local v42 = (v40 - p37).Magnitude < p38;
    debug.profileend();

    return v42, v40, v41;
end;