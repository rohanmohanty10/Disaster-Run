 

 

local u1 = {
    Scale = 2.5,
    Radius = 4,
    HitRadius = 5.525
};
local _, v2 = game.ReplicatedStorage:WaitForChild("Barrel"):GetBoundingBox();
local Radius = u1.Radius;
local v3 = v2.X * u1.Radius / math.max(v2.Y, v2.Z);
u1.HitRadius = math.max(Radius, v3) + 0.9;

function u1.bounce(p4) -- Line: 5
    local math_max_ret = math.max(0, p4);

    for _, v in { { 0.9, 9 }, { 0.65, 4 }, { 0.45, 1.5 } } do
        if math_max_ret < v[1] then
            local v5 = math_max_ret / v[1];

            return 4 * v[2] * v5 * (1 - v5);
        end;

        math_max_ret = math_max_ret - v[1];
    end;

    return 0;
end;

function u1.position(p6, p7, p8) -- Line: 16
    -- upvalues: u1 (copy)
    local math_max_ret = math.max(0, p8 - p7.born);
    local v9 = math.clamp(math_max_ret * p7.speed / p7.length, 0, 1) * (#p7.points - 1);
    local v10 = #p7.points - 1;
    local v11 = math.floor(v9) + 1;
    local math_min_ret = math.min(v10, v11);

    return p7.points[math_min_ret]:Lerp(p7.points[math_min_ret + 1], v9 - (math_min_ret - 1)) + Vector3.new(0, 1, 0) * (u1.Radius + u1.bounce(math_max_ret));
end;

function u1.contact(p12, p13, p14, p15, p16) -- Line: 23
    local v17 = p12 - p14;
    local v18 = p13 - p12 - (p15 - p14);
    local v19;

    if v18:Dot(v18) > 0.0001 then
        local v20 = -v17:Dot(v18) / v18:Dot(v18);
        v19 = math.clamp(v20, 0, 1) or 0;
    else
        v19 = 0;
    end;

    return (v17 + v18 * v19).Magnitude <= p16;
end;

return u1;