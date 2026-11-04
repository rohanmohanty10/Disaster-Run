 

 

local u10 = {
    new = function(p1, p2, p3) -- Line: 10, Name: new
        return {
            vel = Vector3.new(0, 0, 0),
            cur = 0,
            speed = 0,
            free = 0,
            pos = p1,
            floor = p2,
            box = p3
        };
    end,

    homing = function(p4, p5, p6) -- Line: 16, Name: homing
        local v7 = 1 - math.clamp(p4 / p6.NearRange, 0, 1);

        return (p6.Homing + p6.NearHoming * v7 * v7) * math.max(1, p5 / p6.StartSpeed);
    end,

    blockRange = function(p8, p9) -- Line: 22, Name: blockRange
        return math.min(p9.BlockRangeMax, p9.BlockRange + p8 * p9.BlockRangePerSpeed);
    end
};

function u10.step(p11, p12, p13, p14, p15) -- Line: 27
    -- upvalues: u10 (copy)
    local math_clamp_ret = math.clamp(p12, 0, 0.5);
    local v16 = p15 or 0;

    while math_clamp_ret > 1e-6 do
        local math_min_ret = math.min(0.008333333333333333, math_clamp_ret);
        math_clamp_ret = math_clamp_ret - math_min_ret;
        v16 = v16 + math_min_ret;
        p11.cur = p11.cur + (p11.speed - p11.cur) * math.min(1, p14.SpeedResponse * math_min_ret);
        local vel = p11.vel;

        if p13 then
            local v17 = p13 - p11.pos;
            local math_clamp_ret2 = math.clamp((v17.Magnitude - p14.ArcFrom) / (p14.ArcFull - p14.ArcFrom), 0, 1);

            if math_clamp_ret2 > 0 then
                v17 = v17 + Vector3.new(0, 1, 0) * (p14.ArcHeight * math_clamp_ret2);
            end;

            local Magnitude = v17.Magnitude;

            if Magnitude > 0.001 then
                local v18 = u10.homing(Magnitude, p11.cur, p14);

                if v16 < p11.free then
                    v18 = v18 * p14.CurveHoming;
                end;

                vel = vel + (v17 / Magnitude * p11.cur - vel) * math.min(1, v18 * math_min_ret);
            end;
        end;

        local v19 = vel - Vector3.new(0, 1, 0) * (p14.Gravity * math_min_ret);
        local Magnitude = v19.Magnitude;

        if Magnitude > 0.001 then
            v19 = v19 * ((Magnitude + (p11.cur - Magnitude) * math.min(1, p14.PaceResponse * math_min_ret)) / Magnitude);
        end;

        local v20 = p11.pos + v19 * math_min_ret;
        local v21 = p11.floor + p14.Radius;

        if v20.Y < v21 then
            v20 = Vector3.new(v20.X, v21, v20.Z);

            if v19.Y < 0 then
                v19 = Vector3.new(v19.X * p14.FloorFriction, -v19.Y * p14.FloorBounce, v19.Z * p14.FloorFriction);
            end;
        end;

        local v22 = p11.floor + p14.Ceiling;

        if v22 < v20.Y then
            v20 = Vector3.new(v20.X, v22, v20.Z);

            if v19.Y > 0 then
                v19 = Vector3.new(v19.X, -v19.Y * p14.WallBounce, v19.Z);
            end;
        end;

        local box = p11.box;

        if box then
            local v23 = box.cf:PointToObjectSpace(v20);
            local v24 = box.hx - p14.Radius;
            local v25 = box.hz - p14.Radius;

            if v24 < math.abs(v23.X) or v25 < math.abs(v23.Z) then
                local v26 = box.cf:VectorToObjectSpace(v19);
                local X = v23.X;
                local Z = v23.Z;
                local X2 = v26.X;
                local Z2 = v26.Z;

                if v24 < math.abs(X) then
                    X = math.sign(X) * v24;

                    if X2 * X > 0 then
                        X2 = -X2 * p14.WallBounce;
                    end;
                end;

                if v25 < math.abs(Z) then
                    Z = math.sign(Z) * v25;

                    if Z2 * Z > 0 then
                        Z2 = -Z2 * p14.WallBounce;
                    end;
                end;

                v20 = box.cf:PointToWorldSpace((Vector3.new(X, v23.Y, Z)));
                v19 = box.cf:VectorToWorldSpace((Vector3.new(X2, v26.Y, Z2)));
            end;
        end;

        p11.pos = v20;
        p11.vel = v19;
    end;

    return p11;
end;

function u10.launch(p27, p28, p29, p30, p31) -- Line: 103
    local v32 = p28 - p27;
    local v33 = v32.Magnitude <= 0.001 and Vector3.new(0, 0, 1) or v32.Unit;
    local X = p29.X;
    local math_clamp_ret = math.clamp(p29.Y, p31.LookDownMax, p31.LookUpMax);
    local Vector3_new_ret = Vector3.new(X, math_clamp_ret, p29.Z);

    if Vector3_new_ret.Magnitude > 0.001 then
        v33 = v33 * (1 - p31.LookBlend) + Vector3_new_ret.Unit * p31.LookBlend;
    end;

    local LaunchUp = p31.LaunchUp;
    local v34 = p31.StartSpeed * 1.5 / math.max(p30, 1);
    local v35 = v33 + Vector3.new(0, 1, 0) * (LaunchUp * math.clamp(v34, p31.LaunchUpMinScale, 1));

    return (v35.Magnitude <= 0.001 and Vector3.new(0, 0, 1) or v35.Unit) * p30;
end;

function u10.knock(p36, p37, p38, p39, p40) -- Line: 116
    local Vector3_new_ret = Vector3.new(p36.X - p37.X, 0, p36.Z - p37.Z);

    if Vector3_new_ret.Magnitude < 0.001 then
        Vector3_new_ret = Vector3.new(-p38.X, 0, -p38.Z);
    end;

    return ((Vector3_new_ret.Magnitude < 0.001 and Vector3.new(1, 0, 0) or Vector3_new_ret).Unit + Vector3.new(0, 0.7, 0)).Unit * (p39 * p40.HitKnock);
end;

return table.freeze(u10);