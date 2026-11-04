 

 

local SpectateConfig = require(script.Parent.SpectateConfig);
local SpectateGeometry = require(script.Parent.SpectateGeometry);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 4
    -- upvalues: SpectateGeometry (copy), SpectateConfig (copy), u1 (copy)
    local v4, v5 = SpectateGeometry.angles(p2);
    local v6 = {
        velocity = Vector3.new(0, 0, 0),
        area = p3,
        position = SpectateGeometry.clamp(p2.Position, p3),
        yaw = v4,
        pitch = v5,
        yawGoal = v4,
        pitchGoal = v5,
        distance = SpectateConfig.OrbitDistance,
        distanceGoal = SpectateConfig.OrbitDistance
    };

    return setmetatable(v6, u1);
end;

function u1.look(p7, p8) -- Line: 9
    -- upvalues: SpectateConfig (copy)
    p7.yawGoal = p7.yawGoal - p8.X;
    p7.pitchGoal = math.clamp(p7.pitchGoal - p8.Y, SpectateConfig.MinPitch, SpectateConfig.MaxPitch);
end;

function u1.zoom(p9, p10) -- Line: 12
    -- upvalues: SpectateConfig (copy)
    p9.distanceGoal = math.clamp(p9.distanceGoal + p10, SpectateConfig.MinDistance, SpectateConfig.MaxDistance);
end;

function u1.resetPosition(p11, p12) -- Line: 13
    -- upvalues: SpectateGeometry (copy)
    p11.position = SpectateGeometry.clamp(p12.Position, p11.area);
    p11.velocity = Vector3.new(0, 0, 0);
    local v13, v14 = SpectateGeometry.angles(p12);
    p11.yaw = v13;
    p11.pitch = v14;
    p11.yawGoal = p11.yaw;
    p11.pitchGoal = p11.pitch;
end;

function u1.cast(p15, p16, p17, p18) -- Line: 17
    -- upvalues: SpectateConfig (copy)
    if p17.Magnitude >= 0.001 then
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.RespectCanCollide = true;
        local table_clone_ret = table.clone(p18);

        for i = 1, 12 do
            RaycastParams_new_ret.FilterDescendantsInstances = table_clone_ret;
            local v19 = workspace:Spherecast(p16, SpectateConfig.CameraRadius, p17, RaycastParams_new_ret);

            if not v19 then
                return;
            end;

            if not v19.Instance:IsA("BasePart") or v19.Instance.Transparency < 0.95 then
                return v19;
            end;

            table.insert(table_clone_ret, v19.Instance);
            local _ = i;
        end;

        return nil;
    end;
end;

function u1.travel(p20, p21, p22, p23, p24) -- Line: 31
    -- upvalues: SpectateGeometry (copy)
    local v25 = p22 - p21;
    local v26 = p20:cast(p21, v25, p23);

    if not v26 then
        return SpectateGeometry.clamp(p22, p20.area);
    end;

    local v27 = p21 + v25.Unit * math.max(0, v26.Distance - 0.08);

    if p24 then
        local v28 = p22 - v27;
        local v29 = v28 - v26.Normal * v28:Dot(v26.Normal);
        local v30 = p20:cast(v27, v29, p23);

        if v30 then
            v29 = v29.Unit * math.max(0, v30.Distance - 0.08) or v29;
        end;

        v27 = v27 + v29;
    end;

    return SpectateGeometry.clamp(v27, p20.area);
end;

function u1.step(p31, p32, p33, p34, p35, p36, p37) -- Line: 43
    -- upvalues: SpectateGeometry (copy), SpectateConfig (copy)
    local math_clamp_ret = math.clamp(p36, 0, 0.1);
    local v38 = SpectateGeometry.alpha(SpectateConfig.LookSmoothness, math_clamp_ret);
    p31.yaw = p31.yaw + (p31.yawGoal - p31.yaw) * v38;
    p31.pitch = p31.pitch + (p31.pitchGoal - p31.pitch) * v38;
    p31.distance = p31.distance + (p31.distanceGoal - p31.distance) * v38;
    local CFrame_fromOrientation_ret = CFrame.fromOrientation(p31.pitch, p31.yaw, 0);
    local v39;

    if p32 == "Free" then
        local v40 = CFrame_fromOrientation_ret:VectorToWorldSpace((Vector3.new(p34.X, 0, p34.Z))) + Vector3.new(0, 1, 0) * p34.Y;

        if v40.Magnitude > 1 then
            v40 = v40.Unit;
        end;

        local v41 = v40 * (p35 and SpectateConfig.FastSpeed or SpectateConfig.Speed) * math.clamp(p31.speedScale or 1, 0.25, 2);
        p31.velocity = p31.velocity:Lerp(v41, SpectateGeometry.alpha(SpectateConfig.Acceleration, math_clamp_ret));
        p31.position = p31:travel(p31.position, SpectateGeometry.clamp(p31.position + p31.velocity * math_clamp_ret, p31.area), p37, true);
        v39 = p31.position + CFrame_fromOrientation_ret.LookVector * 15;
    else
        p31.velocity = Vector3.new(0, 0, 0);

        if (typeof(p33) ~= "Vector3" or not p33) and p33 then
            p33 = p33.Position;
        end;

        local v42 = p33 and p33 + Vector3.new(0, 1.5, 0) or (p31.focus or p31.area.cf.Position);

        if p31.focus and (v42 - p31.focus).Magnitude <= 50 then
            p31.focus = p31.focus:Lerp(v42, SpectateGeometry.alpha(SpectateConfig.FollowSmoothness, math_clamp_ret));
        else
            p31.focus = v42;
        end;

        v39 = p31.focus;
        local v43 = SpectateGeometry.clamp(v39, p31.area);
        local v44 = p31:travel(v43, SpectateGeometry.clamp(v39 - CFrame_fromOrientation_ret.LookVector * p31.distance, p31.area), p37, false);
        p31.position = p31:travel(v43, p31.position:Lerp(v44, SpectateGeometry.alpha(SpectateConfig.FollowSmoothness, math_clamp_ret)), p37, false);

        if (v39 - p31.position).Magnitude > 0.01 then
            CFrame_fromOrientation_ret = CFrame.lookAt(p31.position, v39).Rotation;
        end;
    end;

    return CFrame.new(p31.position) * CFrame_fromOrientation_ret, CFrame.new(v39);
end;

return u1;