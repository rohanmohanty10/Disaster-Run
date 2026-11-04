 

 

local v1 = {};
local u2 = {
    DashLeft = true,
    DashRight = true,
    DashBack = true
};

function v1.isName(p3) -- Line: 4
    -- upvalues: u2 (copy)
    return u2[p3] == true;
end;

local function unit(p4) -- Line: 5
    if typeof(p4) ~= "Vector3" or (p4.X ~= p4.X or (p4.Y ~= p4.Y or (p4.Z ~= p4.Z or (math.abs(p4.X) > 1000000 or (math.abs(p4.Y) > 1000000 or math.abs(p4.Z) > 1000000))))) then
        return;
    end;

    local Vector3_new_ret = Vector3.new(p4.X, 0, p4.Z);

    if Vector3_new_ret.Magnitude >= 0.001 then
        return Vector3_new_ret.Unit;
    end;
end;

function v1.select(p5, p6) -- Line: 12
    -- upvalues: unit (copy)
    local v7 = unit(p5);
    local v8 = unit(p6);

    if not (v7 and v8) then
        return;
    end;

    local v9 = v7:Dot(v8);

    if v9 <= 0.0001 then
        if v9 <= -0.7071067811865476 then
            return "DashBack", -v8;
        end;

        if v7:Cross(v8).Y > 0 then
            return "DashLeft", v8:Cross(Vector3.new(0, 1, 0));
        end;

        return "DashRight", (Vector3.new(0, 1, 0)):Cross(v8);
    end;
end;

function v1.timing(p10, p11, p12) -- Line: 21
    if p10 > 0 then
        local v13 = p11.Duration + math.min(p11.RecoveryDuration or 0, p12.RecoveryTail);
        local v14 = p10 / math.max(0.05, v13);
        local math_clamp_ret = math.clamp(v14, p12.MinPlaybackRate, p12.MaxPlaybackRate);

        return p10 / math_clamp_ret, math_clamp_ret;
    end;
end;

function v1.yaw(p15, p16) -- Line: 27
    local Y = p15:Cross(p16).Y;
    local v17 = p15:Dot(p16);

    return math.atan2(Y, v17);
end;

return v1;