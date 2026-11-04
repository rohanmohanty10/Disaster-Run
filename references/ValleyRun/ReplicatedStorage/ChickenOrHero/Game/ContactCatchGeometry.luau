 

 

local u1 = {};

local function flat(p2) -- Line: 3
    return Vector3.new(p2.X, 0, p2.Z);
end;

function u1.inReach(p3, p4, p5, p6) -- Line: 4
    local v7 = p5 - p3;
    local Vector3_new_ret = Vector3.new(v7.X, 0, v7.Z);
    local Vector3_new_ret2 = Vector3.new(p4.X, 0, p4.Z);
    local v8;

    if math.abs(v7.Y) <= p6.Height and (Vector3_new_ret.Magnitude <= p6.ReachDistance and (Vector3_new_ret.Magnitude > 0.01 and Vector3_new_ret2.Magnitude > 0.01)) then
        local v9 = Vector3_new_ret2.Unit:Dot(Vector3_new_ret.Unit);
        local math_rad_ret = math.rad(p6.ReachHalfAngle);
        v8 = math.cos(math_rad_ret) <= v9;
    else
        v8 = false;
    end;

    return v8;
end;

function u1.commitDistance(p10, p11, p12, p13) -- Line: 10
    local Vector3_new_ret = Vector3.new(p10.X, 0, p10.Z);
    local v14;

    if Vector3_new_ret.Magnitude > 0.01 then
        local v15 = p11 or Vector3.new(0, 0, 0);
        local v16 = p12 or Vector3.new(0, 0, 0);
        local v17 = (Vector3.new(v15.X, 0, v15.Z) - Vector3.new(v16.X, 0, v16.Z)):Dot(Vector3_new_ret.Unit);
        v14 = math.clamp(v17, 0, (p13.MaxObservedSpeed or 90) * 2);
    else
        v14 = 0;
    end;

    return math.min(p13.CommitDistance, (p13.CommitBaseDistance or p13.HandRadius) + v14 * (p13.CommitLeadTime or 0));
end;

function u1.steer(p18, p19, p20, p21, p22) -- Line: 18
    local Vector3_new_ret = Vector3.new(p18.X, 0, p18.Z);
    local Vector3_new_ret2 = Vector3.new(p19.X, 0, p19.Z);
    local Vector3_new_ret3 = Vector3.new(p20.X, 0, p20.Z);

    if Vector3_new_ret.Magnitude < 0.01 or (Vector3_new_ret2.Magnitude < 0.01 or Vector3_new_ret3.Magnitude < 0.01) then
        return p19;
    end;

    local Unit = Vector3_new_ret.Unit;
    local Unit2 = Vector3_new_ret2.Unit;
    local Unit3 = Vector3_new_ret3.Unit;
    local Y = Unit:Cross(Unit3).Y;
    local v23 = Unit:Dot(Unit3);
    local math_atan2_ret = math.atan2(Y, v23);
    local CFrame_fromAxisAngle = CFrame.fromAxisAngle;
    local v24 = -math.rad(p22.WindupAimLimit);
    local math_rad_ret = math.rad(p22.WindupAimLimit);
    local v25 = CFrame_fromAxisAngle(Vector3.new(0, 1, 0), (math.clamp(math_atan2_ret, v24, math_rad_ret))) * Unit;
    local Y2 = Unit2:Cross(v25).Y;
    local v26 = Unit2:Dot(v25);
    local math_atan2_ret2 = math.atan2(Y2, v26);
    local v27 = math.rad(p22.WindupAimRate) * math.clamp(p21, 0, p22.Windup);

    return CFrame.fromAxisAngle(Vector3.new(0, 1, 0), (math.clamp(math_atan2_ret2, -v27, v27))) * Unit2;
end;

function u1.canCommit(p28, p29, p30, p31, p32, p33) -- Line: 28
    -- upvalues: u1 (copy)
    local v34 = p30 - p28;
    local Vector3_new_ret = Vector3.new(v34.X, 0, v34.Z);
    local Vector3_new_ret2 = Vector3.new(p29.X, 0, p29.Z);
    local v35;

    if Vector3_new_ret.Magnitude > 0.01 and (Vector3_new_ret.Magnitude <= u1.commitDistance(Vector3_new_ret, p32, p33, p31) and (math.abs(p30.Y - p28.Y) <= p31.Height and Vector3_new_ret2.Magnitude > 0.01)) then
        local v36 = Vector3_new_ret2.Unit:Dot(Vector3_new_ret.Unit);
        local math_rad_ret = math.rad(p31.CommitHalfAngle);
        v35 = math.cos(math_rad_ret) <= v36;
    else
        v35 = false;
    end;

    return v35;
end;

local HitReplayMath = require(script.Parent.HitReplayMath);

function u1.contains(p37, p38, p39, p40) -- Line: 34
    -- upvalues: HitReplayMath (copy)
    return HitReplayMath.sweep(p37, p37, p39, p39, p38, HitReplayMath.bounds("Melee", p40));
end;

function u1.sweep(p41, p42, p43, p44, p45, p46) -- Line: 37
    -- upvalues: HitReplayMath (copy)
    return HitReplayMath.sweep(p41, p42, p43, p44, p45, HitReplayMath.bounds("Melee", p46));
end;

return u1;