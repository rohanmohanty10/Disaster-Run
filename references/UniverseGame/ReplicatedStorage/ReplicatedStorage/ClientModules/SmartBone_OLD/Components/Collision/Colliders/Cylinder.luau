  

 

local function SafeUnit(p1) -- Line: 2
    return p1.Magnitude == 0 and Vector3.new(0, 0, 0) or p1.Unit;
end;

local function solve(p2, p3, p4, p5) -- Line: 10
    local v6 = (p5 - p2):Dot(p3);
    local v7 = math.clamp(v6, -p4, p4);

    return p2 + p3 * v7, v7;
end;

local function ProjectOnPlane(p8, p9, p10) -- Line: 17
    return p10 - (p10 - p8):Dot(p9) * p9;
end;

local function ClosestPointFunc(p11, p12, p13) -- Line: 25
    local u14 = math.min(p12.Y, p12.Z) * 0.5;
    local v15 = p12.X * 0.5;
    local Position = p11.Position;
    local RightVector = p11.RightVector;
    local v16 = (p13 - Position):Dot(RightVector);
    local v17 = math.clamp(v16, -v15, v15);
    local v18 = Position + RightVector * v17;
    local v19 = p11.Position + -p11.RightVector * v15;
    local v20 = p11.Position + p11.RightVector * v15;
    local v21 = -p11.RightVector;
    local RightVector2 = p11.RightVector;
    local v22 = p13 - (p13 - v19):Dot(v21) * v21;
    local v23 = p13 - (p13 - v20):Dot(RightVector2) * RightVector2;

    local function GetFinalProj(p24, p25) -- Line: 39
        -- upvalues: u14 (copy)
        local v26 = p24 - p25;

        return p25 + (v26.Magnitude == 0 and Vector3.new(0, 0, 0) or v26.Unit) * math.min((p24 - p25).Magnitude, u14);
    end;

    local v27 = v22 - v19;
    local v28 = v19 + (v27.Magnitude == 0 and Vector3.new(0, 0, 0) or v27.Unit) * math.min((v22 - v19).Magnitude, u14);
    local v29 = v23 - v20;
    local v30 = v20 + (v29.Magnitude == 0 and Vector3.new(0, 0, 0) or v29.Unit) * math.min((v23 - v20).Magnitude, u14);
    local v31 = p13 - v18;
    local v32 = v31.Magnitude == 0 and Vector3.new(0, 0, 0) or v31.Unit;
    local v33 = (v18 - p13).Magnitude <= u14;
    local v34 = v18 + v32 * u14;
    local Magnitude = (v30 - p13).Magnitude;
    local Magnitude2 = (v28 - p13).Magnitude;
    local v35 = math.min(Magnitude, Magnitude2, (v34 - p13).Magnitude);

    if v17 == v15 or v35 == Magnitude then
        local v36 = p13 - v30;

        return (v36.Magnitude == 0 and Vector3.new(0, 0, 0) or v36.Unit):Dot(RightVector2) < 0, v30, RightVector2;
    end;

    if v17 ~= -v15 and v35 ~= Magnitude2 then
        return v33, v34, v32;
    end;

    local v37 = p13 - v28;

    return (v37.Magnitude == 0 and Vector3.new(0, 0, 0) or v37.Unit):Dot(v21) < 0, v28, v21;
end;

return function(p38, p39, p40, p41) -- Line: 70
    -- upvalues: ClosestPointFunc (copy)
    debug.profilebegin("Cylinder Testing");
    local v42, v43, v44 = ClosestPointFunc(p38, p39, p40);

    if v42 then
        return v42, v43, v44;
    end;

    local v45 = (v43 - p40).Magnitude < p41;
    debug.profileend();

    return v45, v43, v44;
end;