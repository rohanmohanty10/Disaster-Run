 
 

local Sites = require(script.Parent.Sites);
local u1 = {};
local u2 = { -1, 1 };

local function jointsOf(p3, p4) -- Line: 88
    local math_ceil_ret = math.ceil(p3 / p4);
    local math_clamp_ret = math.clamp(math_ceil_ret, 1, 96);

    return math_clamp_ret, p3 / math_clamp_ret;
end;

local function straysOf(p5, p6, p7) -- Line: 94
    local v8 = {};

    for i = 0, math.ceil(p5 / 4) + 1 do
        v8[i] = p7() * 2 - 1;
        local _ = i;
    end;

    local table_create_ret = table.create(p5 + 1);

    for i = 0, p5 do
        local v9 = i / 4;
        local math_floor_ret = math.floor(v9);
        local v10 = v8[math_floor_ret] + (v8[math_floor_ret + 1] - v8[math_floor_ret]) * (v9 - math_floor_ret);
        table_create_ret[i + 1] = (0.65 * (p7() * 2 - 1) + 0.35 * v10) * p6;
        local _ = i;
    end;

    return table_create_ret;
end;

function u1.of(p11, p12) -- Line: 109
    if p11.shape ~= "Linear" then
        return nil;
    end;

    local v13 = p11.range - p11.inner;

    if v13 <= 0 then
        return nil;
    end;

    local origin = p11.origin;
    local v14 = p11.halfWidth * 2;
    local v15 = p11.halfHeight * 2;
    local RightVector = origin.RightVector;
    local UpVector = origin.UpVector;
    local v16 = true;
    local v17, v18;

    if v15 < v14 then
        RightVector = origin.UpVector;
        UpVector = origin.RightVector;
        v17 = math.max(v15, 0.1);
        v18 = math.max(v14, v17);
        v16 = false;
    else
        v18 = math.max(v14, 0.1);
        v17 = math.max(v15, v18);
    end;

    local v19 = {
        frame = origin * CFrame.new(0, 0, -(p11.inner + p11.range) / 2),
        size = Vector3.new(v18, v17, v13),
        origin = origin.Position,
        heading = origin.LookVector,
        normal = RightVector,
        across = UpVector,
        kerf = math.min(v18, v17),
        thinIsWidth = v16
    };

    if p12 and (p12.noise or 0) > 0.01 then
        local math_max_ret = math.max(p12.noiseScale or 0, 0.5);
        local math_ceil_ret = math.ceil(v13 / math_max_ret);
        local v20 = v13 / math.clamp(math_ceil_ret, 1, 96);
        local math_max_ret2 = math.max(v18, v17);
        local math_ceil_ret2 = math.ceil(math_max_ret2 / math_max_ret);
        local v21 = math_max_ret2 / math.clamp(math_ceil_ret2, 1, 96);
        v19.key = p12;
        v19.noise = p12.noise;
        v19.grain = math_max_ret;
        v19.flat = v19.size;
        v19.ribbons = {};
        local noise = p12.noise;
        local v22 = math.max(v20, v21) * 0.9;
        v19.stray = math.min(noise, v22);

        if v19.thinIsWidth then
            v19.size = v19.size + Vector3.new(2 * v19.stray, 0, 0);

            return v19;
        end;

        v19.size = v19.size + Vector3.new(0, 2 * v19.stray, 0);
    end;

    return v19;
end;

function u1.ribbon(p23, p24) -- Line: 162
    -- upvalues: straysOf (copy), Sites (copy)
    if not p23.noise then
        return nil;
    end;

    local v25 = p23.ribbons[p24];

    if v25 then
        return v25;
    end;

    local flat = p23.flat;
    local X = flat.X;
    local v26, v27, v28;

    if p23.thinIsWidth then
        X = flat.Y;
        v26 = Vector3.new(0, 1, 0);
        v27 = "Y";
        v28 = Vector3.new(1, 0, 0);
    else
        v26 = Vector3.new(1, 0, 0);
        v27 = "X";
        v28 = Vector3.new(0, 1, 0);
    end;

    local Z = flat.Z;
    local v29, v30;

    if p24 then
        v29 = flat.Z;
        v30 = Vector3.new(0, 0, 1);
    else
        v30 = v26;
        v29 = X;
        X = Z;
        v26 = Vector3.new(0, 0, 1);
        v27 = "Z";
    end;

    local math_ceil_ret = math.ceil(v29 / p23.grain);
    local math_clamp_ret = math.clamp(math_ceil_ret, 1, 96);
    local v31 = v29 / math_clamp_ret;
    local math_min_ret = math.min(p23.noise, 0.9 * v31);
    local v32 = straysOf(math_clamp_ret, math_min_ret, Sites.sequence(Sites.seedAt(p23.origin)));
    local v33 = v28:Cross(v26);
    local table_create_ret = table.create(math_clamp_ret + 1);

    for i = 0, math_clamp_ret do
        table_create_ret[i + 1] = CFrame.fromMatrix(v30 * (-v29 / 2 + i * v31) + v28 * v32[i + 1], v28, v26, v33);
        local _ = i;
    end;

    local v34 = {
        key = p23.key,
        lengthwise = p24
    };
    local v35 = p23.kerf * 1.25;
    local math_min_ret2 = math.min(X, 8);
    v34.tool = Vector3.new(v35, math_min_ret2, 0.05);
    v34.frames = table_create_ret;
    v34.straight = v27;
    v34.length = X;
    v34.stray = math_min_ret;
    v34.joints = math_clamp_ret;
    v34.step = v31;
    v34.flat = flat;
    p23.ribbons[p24] = v34;

    return v34;
end;

local function axesOf(p36) -- Line: 207
    return { p36.XVector, p36.YVector, p36.ZVector };
end;

local function reach(p37, p38, p39) -- Line: 212
    local v40 = p37[1]:Dot(p39);
    local v41 = math.abs(v40) * p38.X;
    local v42 = p37[2]:Dot(p39);
    local v43 = v41 + math.abs(v42) * p38.Y;
    local v44 = p37[3]:Dot(p39);

    return v43 + math.abs(v44) * p38.Z;
end;

function u1.touches(p45, p46, p47) -- Line: 218
    -- upvalues: reach (copy)
    local frame = p45.frame;
    local u48 = { frame.XVector, frame.YVector, frame.ZVector };
    local u49 = { p46.XVector, p46.YVector, p46.ZVector };
    local u50 = p45.size / 2;
    local u51 = p47 / 2;
    local u52 = p46.Position - p45.frame.Position;

    local function separates(p53) -- Line: 224
        -- upvalues: u52 (copy), reach (ref), u48 (copy), u50 (copy), u49 (copy), u51 (copy)
        local Magnitude = p53.Magnitude;

        if Magnitude < 1e-6 then
            return false;
        end;

        local v54 = p53 / Magnitude;
        local v55 = u52:Dot(v54);

        return math.abs(v55) > reach(u48, u50, v54) + reach(u49, u51, v54);
    end;

    for i = 1, 3 do
        local v56 = u48[i];
        local Magnitude = v56.Magnitude;
        local v57;

        if Magnitude < 1e-6 then
            v57 = false;
        else
            local v58 = v56 / Magnitude;
            local v59 = u52:Dot(v58);
            v57 = math.abs(v59) > reach(u48, u50, v58) + reach(u49, u51, v58);
        end;

        if v57 then
            return false;
        end;

        local v60 = u49[i];
        local Magnitude2 = v60.Magnitude;
        local v61;

        if Magnitude2 < 1e-6 then
            v61 = false;
        else
            local v62 = v60 / Magnitude2;
            local v63 = u52:Dot(v62);
            v61 = math.abs(v63) > reach(u48, u50, v62) + reach(u49, u51, v62);
        end;

        if v61 then
            return false;
        end;

        local _ = i;
    end;

    for _, v in ipairs(u48) do
        local v64 = v;

        for _, v2 in ipairs(u49) do
            local v65 = v64:Cross(v2);
            local Magnitude = v65.Magnitude;
            local v66;

            if Magnitude < 1e-6 then
                v66 = false;
            else
                local v67 = v65 / Magnitude;
                local v68 = u52:Dot(v67);
                v66 = math.abs(v68) > reach(u48, u50, v67) + reach(u49, u51, v67);
            end;

            if v66 then
                return false;
            end;
        end;
    end;

    return true;
end;

function u1.ribbonFor(p69, p70, p71, p72) -- Line: 247
    -- upvalues: u2 (copy), u1 (copy)
    if not p69.noise then
        return nil, nil;
    end;

    local frame = p69.frame;
    local v73 = p71 / 2;
    local v74 = (1 / 0);
    local v75 = (-1 / 0);
    local v76 = (1 / 0);
    local v77 = (-1 / 0);

    for _, v in ipairs(u2) do
        local v78 = v;

        for _, v2 in ipairs(u2) do
            local v79 = v2;

            for _, v3 in ipairs(u2) do
                local v80 = frame:PointToObjectSpace(p70:PointToWorldSpace((Vector3.new(v78 * v73.X, v79 * v73.Y, v3 * v73.Z))));
                local X = v80.X;

                if p69.thinIsWidth then
                    X = v80.Y;
                end;

                v74 = math.min(v74, v80.Z);
                v75 = math.max(v75, v80.Z);
                v76 = math.min(v76, X);
                v77 = math.max(v77, X);
            end;
        end;
    end;

    local flat = p69.flat;
    local X = flat.X;

    if p69.thinIsWidth then
        X = flat.Y;
    end;

    local v81 = math.min(v75, flat.Z / 2) - math.max(v74, -flat.Z / 2);
    local v82 = math.min(v77, X / 2) - math.max(v76, -X / 2);

    return u1.ribbon(p69, v82 <= v81), p72 * frame;
end;

function u1.side(p83, p84) -- Line: 280
    return (p84 - p83.origin):Dot(p83.normal) >= 0 and 1 or -1;
end;

function u1.slope(p85) -- Line: 287
    local normal = p85.normal;
    local v86 = normal:Dot(Vector3.new(0, 1, 0));
    local math_abs_ret = math.abs(v86);
    local math_max_ret = math.max(1 - math_abs_ret * math_abs_ret, 0);
    local math_sqrt_ret = math.sqrt(math_max_ret);

    if math_abs_ret < 0.05 then
        return 0, nil, math_sqrt_ret, math_abs_ret;
    end;

    local v87 = v86 < 0 and -1 or 1;

    if math_sqrt_ret < 0.02 then
        return v87, nil, math_sqrt_ret, math_abs_ret;
    end;

    return v87, (Vector3.new(-0, -1, -0) + normal * v86).Unit, math_sqrt_ret, math_abs_ret;
end;

function u1.inPart(p88, p89) -- Line: 307
    return p89:ToObjectSpace(p88.frame);
end;

return u1;