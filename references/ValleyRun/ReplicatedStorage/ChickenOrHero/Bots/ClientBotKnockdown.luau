 

 

local u1 = {
    Fall = 0.45,
    Rise = 0.22
};
local u2 = {
    ["Left Shoulder"] = CFrame.Angles(-0.9599310885968813, 0, 0),
    ["Right Shoulder"] = CFrame.Angles(-0.9599310885968813, 0, 0),
    ["Left Hip"] = CFrame.Angles(-0.24434609527920614, 0, 0),
    ["Right Hip"] = CFrame.Angles(-0.24434609527920614, 0, 0)
};
u1.Limbs = u2;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;
pcall(function() -- Line: 24
    -- upvalues: RaycastParams_new_ret (copy)
    RaycastParams_new_ret.CollisionGroup = "CoHRunner";
end);

local function smooth(p3) -- Line: 28
    local math_clamp_ret = math.clamp(p3, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

function u1.ground(p4) -- Line: 32
    -- upvalues: RaycastParams_new_ret (copy)
    local v5 = workspace:Raycast(p4 + Vector3.new(0, 2, 0), Vector3.new(-0, -24, -0), RaycastParams_new_ret);

    return v5 and v5.Position.Y or p4.Y - 3;
end;

local u6 = {};

function u1.onDown(p7) -- Line: 38
    -- upvalues: u6 (copy)
    table.insert(u6, p7);
end;

function u1.begin(p8, p9, p10, p11, p12) -- Line: 42
    -- upvalues: u6 (copy), u1 (copy)
    for _, v in u6 do
        task.spawn(v, p10);
    end;

    local v13 = typeof(p12) == "Vector3" and (Vector3.new(p12.X, 0, p12.Z) or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0);

    if v13.Magnitude < 0.1 then
        local v14 = -math.sin(p11);
        local v15 = -math.cos(p11);
        v13 = Vector3.new(v14, 0, v15);
    end;

    local Unit = v13.Unit;
    p8.axis = Unit:Cross(Vector3.new(0, 1, 0));
    local v16 = (math.atan2(-Unit.X, -Unit.Z) - p11 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;

    if math.abs(v16) > 1.5707963267948966 then
        v16 = v16 - math.sign(v16) * 3.141592653589793;
    end;

    p8.yaw = p11;
    p8.spin = v16;
    p8.facing = p11;
    local axis = p8.axis;
    p8.yaw0 = p11;
    p8.turnedAxis = axis;
    p8.down = true;
    p8.started = p9;
    p8.ended = nil;
    p8.angle = 0;
    p8.ground = u1.ground(p10);
    local Z = p10.Z;
    p8.groundX = p10.X;
    p8.groundZ = Z;
    p8.stand = math.clamp(p10.Y - p8.ground, 0.55, 3.5);
    p8.cframe = nil;
    p8.liftAt = nil;
end;

function u1.lift(p17, p18, p19, p20) -- Line: 75
    if not (p17.down and (type(p18) == "number" and (not p17.started or p18 >= p17.started - 1))) then
        return;
    end;

    p17.liftAt = p18;
    p17.liftHeight = type(p19) == "number" and p19 and p19 or 3.5;
    p17.liftTime = (type(p20) ~= "number" or (p20 <= 0 or not p20)) and 0.5 or p20;
    p17.cframe = nil;
end;

local function lifted(p21, p22) -- Line: 84
    -- upvalues: u1 (copy)
    if not p21.liftAt then
        return 0;
    end;

    local math_clamp_ret = math.clamp((p22 - p21.liftAt) / p21.liftTime, 0, 1);
    local v23 = p21.liftHeight * (1 - (1 - math_clamp_ret) ^ 3);

    if p21.ended then
        local math_clamp_ret2 = math.clamp((p22 - p21.ended) / u1.Rise, 0, 1);
        v23 = v23 * (1 - math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2));
    end;

    return v23;
end;

function u1.finish(p24, p25) -- Line: 95
    if p24.down and not p24.ended then
        p24.ended = p25;
        p24.from = p24.angle;
        p24.cframe = nil;
    end;
end;

function u1.frame(p26, p27, p28, p29) -- Line: 104
    -- upvalues: u1 (copy)
    if not p26.down then
        return nil;
    end;

    local v30 = p28.X - p26.groundX;
    local v31 = p28.Z - p26.groundZ;

    if v30 * v30 + v31 * v31 > 2.25 then
        p26.ground = u1.ground(p28);
        local Z = p28.Z;
        p26.groundX = p28.X;
        p26.groundZ = Z;
    end;

    local v32, v33;

    if p26.ended then
        local v34 = (p27 - p26.ended) / u1.Rise;

        if v34 >= 1 then
            p26.down = false;
            p26.cframe = nil;
            p26.liftAt = nil;

            return nil;
        end;

        local from = p26.from;
        local math_clamp_ret = math.clamp(v34, 0, 1);
        v32 = from * (1 - math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret));
        local v35 = type(p29) == "number" and ((p29 - p26.facing + 3.141592653589793) % 6.283185307179586 - 3.141592653589793 or 0) or 0;
        local facing = p26.facing;
        local math_clamp_ret2 = math.clamp(v34, 0, 1);
        v33 = facing + v35 * (math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2));
    else
        local math_min_ret = math.min((p27 - p26.started) / u1.Fall, 1);
        v32 = 1.5707963267948966 * math_min_ret * math_min_ret;

        if math_min_ret >= 1 and (p26.cframe and not (p26.liftAt or (p26.angle ~= v32 or (p26.lastX ~= p28.X or (p26.lastZ ~= p28.Z or p26.lastYaw ~= p29))))) then
            return p26.cframe, 1;
        end;

        local v36 = (type(p29) ~= "number" or not p26.yaw0) and 0 or (p29 - p26.yaw0 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
        local v37;

        if v36 == 0 then
            v37 = p26.axis;
        else
            v37 = CFrame.Angles(0, v36, 0):VectorToWorldSpace(p26.axis);
        end;

        p26.turnedAxis = v37;
        local yaw = p26.yaw;
        local spin = p26.spin;
        local math_clamp_ret = math.clamp(math_min_ret, 0, 1);
        v33 = yaw + spin * (math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret)) + v36;
        p26.facing = v33;
    end;

    p26.angle = v32;
    local Z = p28.Z;
    p26.lastX = p28.X;
    p26.lastZ = Z;
    p26.lastYaw = p29;
    local v38 = p26.stand * math.cos(v32);
    local math_max_ret = math.max(0.55, v38);
    local v39;

    if p26.liftAt then
        local math_clamp_ret = math.clamp((p27 - p26.liftAt) / p26.liftTime, 0, 1);
        v39 = p26.liftHeight * (1 - (1 - math_clamp_ret) ^ 3);

        if p26.ended then
            local math_clamp_ret2 = math.clamp((p27 - p26.ended) / u1.Rise, 0, 1);
            v39 = v39 * (1 - math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2));
        end;
    else
        v39 = 0;
    end;

    local v40 = CFrame.fromAxisAngle(p26.turnedAxis or p26.axis, v32) * CFrame.Angles(0, v33, 0) + Vector3.new(p28.X, p26.ground + (math_max_ret + v39), p28.Z);
    p26.cframe = v40;

    return v40, v32 / 1.5707963267948966;
end;

function u1.limbs(p41, p42) -- Line: 155
    -- upvalues: u2 (copy)
    for i, v in u2 do
        local v43 = p41[i];

        if v43 and v43.Parent then
            v43.Transform = p42 >= 1 and v and v or CFrame.identity:Lerp(v, p42);
        end;
    end;
end;

return u1;