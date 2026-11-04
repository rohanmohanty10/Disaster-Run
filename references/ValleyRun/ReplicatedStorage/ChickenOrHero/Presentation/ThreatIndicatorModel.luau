 

 

local v1 = {};

local function flat(p2) -- Line: 3
    return Vector3.new(p2.X, 0, p2.Z);
end;

function v1.sample(p3, p4, p5, p6, p7, p8) -- Line: 4
    if math.abs(p6.Y - p3.Y) > p8.MaxHeightDifference then
        return nil;
    end;

    local v9 = p6 - p3;
    local Vector3_new_ret = Vector3.new(v9.X, 0, v9.Z);
    local Magnitude = Vector3_new_ret.Magnitude;
    local Vector3_new_ret2 = Vector3.new(p5.X, 0, p5.Z);

    if Magnitude < 0.05 or (p8.MaxDistance <= Magnitude or Vector3_new_ret2.Magnitude < 0.01) then
        return nil;
    end;

    local Unit = Vector3_new_ret2.Unit;
    local Unit2 = Vector3_new_ret.Unit;
    local v10 = (Vector3.new(p4.X, 0, p4.Z) - Vector3.new(p7.X, 0, p7.Z)):Dot(Unit2);

    if p8.NearDistance < Magnitude and v10 < p8.MinClosingSpeed then
        return nil;
    end;

    local v11 = math.clamp(1 - (Magnitude - p8.NearDistance) / (p8.MaxDistance - p8.NearDistance), 0, 1) * 0.8 + 0.2;
    local v12 = Unit2:Dot(Unit:Cross(Vector3.new(0, 1, 0)));
    local v13 = Unit2:Dot(Unit);

    return {
        angle = math.atan2(v12, v13),
        strength = v11,
        distance = Magnitude
    };
end;

function v1.sector(p14, p15, p16) -- Line: 18
    local v17 = 0;

    for _, v in p15 do
        local math_sin_ret = math.sin(p14 - v.angle);
        local math_cos_ret = math.cos(p14 - v.angle);
        local math_atan2_ret = math.atan2(math_sin_ret, math_cos_ret);
        local math_abs_ret = math.abs(math_atan2_ret);

        if math_abs_ret < p16 then
            v17 = math.max(v17, v.strength * (1 - math_abs_ret / p16));
        end;
    end;

    return v17;
end;

return v1;