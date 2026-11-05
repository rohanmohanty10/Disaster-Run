  

 

local u1 = {};

function u1.__index(p2, p3) -- Line: 3
    -- upvalues: u1 (copy)
    if rawget(p2, p3) or rawget(u1, p3) then
        return rawget(p2, p3) or rawget(u1, p3);
    end;

    if p3:lower() == "magnitude" then
        return math.sqrt(p2.X * p2.X + p2.Y * p2.Y + p2.Z * p2.Z + p2.W * p2.W);
    end;
end;

local _ = math.sqrt;
local cos = math.cos;
local sin = math.sin;
local _ = math;

function u1.new(p4, p5, p6, p7) -- Line: 12
    -- upvalues: u1 (copy)
    return setmetatable({
        X = p4,
        Y = p5,
        Z = p6,
        W = p7
    }, u1);
end;

function u1.__add(p8, p9) -- Line: 16
    -- upvalues: u1 (copy)
    return u1.new(p8.X + p9.X, p8.Y + p9.Y, p8.Z + p9.Z, p8.W + p9.W);
end;

function u1.__sub(p10, p11) -- Line: 20
    -- upvalues: u1 (copy)
    return u1.new(p10.X - p11.X, p10.Y - p11.Y, p10.Z - p11.Z, p10.W - p11.W);
end;

function u1.__eq(p12, p13) -- Line: 24
    local v14;

    if p12.X == p13.X and (p12.Y == p13.Y and p12.Z == p13.Z) then
        v14 = p12.W == p13.W;
    else
        v14 = false;
    end;

    return v14;
end;

function u1.Rotate_XW_YZ(p15, p16) -- Line: 28
    -- upvalues: cos (copy), sin (copy), u1 (copy)
    local v17 = cos(p16);
    local v18 = sin(p16);

    return u1.new(v17 * p15.X - v18 * p15.W, v18 * p15.Z + v17 * p15.Y, v17 * p15.Z - v18 * p15.Y, v18 * p15.X + v17 * p15.W);
end;

function u1.Rotate_XY(p19, p20) -- Line: 38
    -- upvalues: cos (copy), sin (copy), u1 (copy)
    local v21 = cos(p20);
    local v22 = sin(p20);

    return u1.new(v21 * p19.X - v22 * p19.Y, v22 * p19.X + v21 * p19.Y, p19.Z, p19.W);
end;

function u1.Rotate_ZW(p23, p24) -- Line: 48
    -- upvalues: cos (copy), sin (copy), u1 (copy)
    local v25 = cos(p24);
    local v26 = sin(p24);

    return u1.new(p23.X, p23.Y, v25 * p23.Z - v26 * p23.W, v26 * p23.Z + v25 * p23.W);
end;

function u1.Rotate_WZ(p27, p28) -- Line: 58
    -- upvalues: cos (copy), sin (copy), u1 (copy)
    local v29 = cos(p28);
    local v30 = sin(p28);

    return u1.new(p27.X, p27.Y, v30 * p27.W + v29 * p27.Z, v29 * p27.W - v30 * p27.Z);
end;

function u1.Rotate_WZ_Y(p31, p32, p33) -- Line: 68
    -- upvalues: cos (copy), sin (copy), u1 (copy)
    local v34 = cos(p32);
    local v35 = sin(p32);
    local v36 = v34 * p31.W - v35 * p31.Z;
    local v37 = v35 * p31.W + v34 * p31.Z;
    local v38 = cos(p33);
    local v39 = sin(p33);

    return u1.new(v38 * p31.X - v39 * v37, p31.Y, v39 * p31.X + v38 * v37, v36);
end;

function u1.project3D(p40, p41) -- Line: 81
    local v42 = p41 or 1;
    local v43 = v42 == p40.W and 1 or (1 / (v42 - p40.W) or 1);

    return Vector3.new(p40.X * v43, p40.Y * v43, p40.Z * v43);
end;

return u1;