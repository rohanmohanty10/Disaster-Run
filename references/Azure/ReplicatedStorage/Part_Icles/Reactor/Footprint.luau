 

 

local Sites = require(script.Parent.Sites);
local Fissure = require(script.Parent.Fissure);
local Blade = require(script.Parent.Blade);
local Carve = require(script.Parent.Carve);
local Layers = require(script.Parent.Layers);
local u1 = {
    PATCH_REACH = 1.3
};
local u2 = { -1, 1 };

function u1.ofBlade(p3, p4, p5, p6) -- Line: 67
    -- upvalues: Blade (copy), u1 (copy), u2 (copy)
    local size = p3.size;

    if not (p4 and Blade.touches(p4, p3.frame, size)) then
        return nil;
    end;

    local v7 = p5 == "Band" and (p6 and p6 < 2 * u1.bladePieces(p5)) and "Halves" or p5;
    local axis = p3.face.axis;
    local side = p3.face.side;
    local uAxis = p3.uAxis;
    local vAxis = p3.vAxis;
    local v8 = Blade.inPart(p4, p3.frame);
    local v9 = p4.size / 2;
    local v10 = (-1 / 0);
    local v11 = (-1 / 0);
    local v12 = (-1 / 0);
    local v13 = (1 / 0);
    local v14 = (1 / 0);

    for _, v in ipairs(u2) do
        local v15 = v;

        for _, v2 in ipairs(u2) do
            local v16 = v2;

            for _, v3 in ipairs(u2) do
                local v17 = v8:PointToWorldSpace((Vector3.new(v15 * v9.X, v16 * v9.Y, v3 * v9.Z)));
                v14 = math.min(v14, v17[uAxis]);
                v11 = math.max(v11, v17[uAxis]);
                v13 = math.min(v13, v17[vAxis]);
                v10 = math.max(v10, v17[vAxis]);
                v12 = math.max(v12, size[axis] / 2 - v17[axis] * side);
            end;
        end;
    end;

    return v12 >= 0.05 and {
        reach = 0,
        minU = v14 - 2,
        minV = v13 - 2,
        maxU = v11 + 2,
        maxV = v10 + 2,
        area = (v11 - v14 + 4) * (v10 - v13 + 4),
        blade = p4,
        mode = v7,
        under = {
            minU = v14,
            minV = v13,
            maxU = v11,
            maxV = v10
        }
    } or nil;
end;

function u1.of(p18, p19, p20, p21, p22) -- Line: 107
    -- upvalues: Sites (copy), Fissure (copy), u1 (copy)
    local size = p18.size;
    local axis = p18.face.axis;
    local side = p18.face.side;
    local uAxis = p18.uAxis;
    local vAxis = p18.vAxis;
    local v23 = Sites.alongFace(axis, 0, 0, side);
    local v24 = Fissure.of(p19, p18.frame, v23 * (size[axis] / 2), v23, Sites.sequence(p22));

    if not v24 then
        local v25 = p20[uAxis];
        local v26 = p20[vAxis];
        local v27 = p21 * u1.PATCH_REACH;

        return {
            minU = v25 - v27,
            minV = v26 - v27,
            maxU = v25 + v27,
            maxV = v26 + v27,
            area = 4 * v27 * v27,
            reach = p21,
            probes = Sites.probes(size, axis, side, v25, v26, p21),
            u = v25,
            v = v26,
            half = v27
        };
    end;

    local v28, v29 = Fissure.bounds(v24.path);
    local v30 = v24.reach * 2.2;
    local v31 = v28[uAxis] - v30;
    local v32 = v29[uAxis] + v30;
    local v33 = v28[vAxis] - v30;
    local v34 = v29[vAxis] + v30;
    v24.seed = p22;

    return {
        minU = v31,
        minV = v33,
        maxU = v32,
        maxV = v34,
        area = (v32 - v31) * (v34 - v33),
        reach = v24.reach,
        probes = v24.probes,
        line = v24,
        uAxis = uAxis,
        vAxis = vAxis
    };
end;

local function awayFrom(p35, p36, p37) -- Line: 141
    local math_max_ret = math.max(p35.minU - p36, 0, p36 - p35.maxU);
    local math_max_ret2 = math.max(p35.minV - p37, 0, p37 - p35.maxV);

    return math.sqrt(math_max_ret * math_max_ret + math_max_ret2 * math_max_ret2);
end;

function u1.reaches(p38, p39) -- Line: 147
    local under = p38.under;

    if under then
        local v40;

        if p39.minU < under.maxU and (p39.maxU > under.minU and p39.minV < under.maxV) then
            v40 = p39.maxV > under.minV;
        else
            v40 = false;
        end;

        return v40;
    end;

    local line = p38.line;

    if line then
        for _, v in ipairs(line.path.points) do
            local v41 = v[p38.uAxis];
            local v42 = v[p38.vAxis];
            local math_max_ret = math.max(p39.minU - v41, 0, v41 - p39.maxU);
            local math_max_ret2 = math.max(p39.minV - v42, 0, v42 - p39.maxV);

            if math.sqrt(math_max_ret * math_max_ret + math_max_ret2 * math_max_ret2) <= line.reach then
                return true;
            end;
        end;

        return false;
    end;

    local u = p38.u;
    local v = p38.v;
    local math_max_ret = math.max(p39.minU - u, 0, u - p39.maxU);
    local math_max_ret2 = math.max(p39.minV - v, 0, v - p39.maxV);

    return math.sqrt(math_max_ret * math_max_ret + math_max_ret2 * math_max_ret2) <= p38.reach;
end;

function u1.job(p43, p44, p45, p46, p47, p48, p49) -- Line: 164
    -- upvalues: Sites (copy), Layers (copy), Blade (copy), Fissure (copy)
    local v50 = p44.maxU - p44.minU;
    local v51 = p44.maxV - p44.minV;
    local axis = p43.face.axis;
    local v52 = Sites.alongFace(axis, (p44.minU + p44.maxU) / 2, (p44.minV + p44.maxV) / 2, 0);
    local v53 = Sites.alongFace(axis, v50, v51, p43.size[axis]);
    local v54;

    if p43.layers then
        v54 = Layers.inPatch(p43, v52, v53);
    else
        v54 = nil;
    end;

    local blade = p45.blade;

    if blade then
        local v55 = p43.frame * CFrame.new(v52.X, v52.Y, v52.Z);
        local v56, v57 = Blade.ribbonFor(blade, p43.frame, p43.size, v55:Inverse());

        return {
            count = 2,
            always = true,
            stands = true,
            size = v53,
            frame = v55,
            layers = v54,
            face = p43.face,
            seed = p47,
            bladeFrame = Blade.inPart(blade, v55),
            bladeSize = blade.size,
            ribbon = v56,
            ribbonFrame = v57,
            slash = {
                origin = v55:PointToObjectSpace(blade.origin),
                normal = v55:VectorToObjectSpace(blade.normal),
                heading = v55:VectorToObjectSpace(blade.heading),
                kerf = blade.kerf
            },
            mode = p45.mode
        };
    end;

    local math_floor_ret = math.floor(p49 * v50 * v51 / p45.area + 0.5);
    local math_max_ret = math.max(math_floor_ret, 2);
    local v58 = {
        size = v53,
        frame = p43.frame * CFrame.new(v52.X, v52.Y, v52.Z),
        hit = p46 - v52,
        reach = p45.reach,
        count = Sites.count(v53, math_max_ret),
        seed = p47,
        face = p43.face,
        layers = v54
    };
    local line = p45.line;

    if line then
        v58.count = Sites.count(v53, p49);
        v58.line = {
            path = Fissure.moved(line.path, CFrame.new(v52.X, v52.Y, v52.Z), true),
            reach = line.reach,
            seed = line.seed
        };

        return v58;
    end;

    local v59 = 2 * p45.half;
    local v60 = false;

    for _, v in ipairs(v54 or {}) do
        v60 = v60 or v.skin ~= nil;
    end;

    if p48 and not (v60 or (math.abs(v50 - v59) >= 0.001 or math.abs(v51 - v59) >= 0.001)) then
        v58.whole = true;
        v58.variant = math.floor(p47 / 4) % 3;
        v58.hit = Sites.alongFace(axis, 0, 0, p43.face.side * p43.size[axis] / 2);
    end;

    return v58;
end;

function u1.bladePieces(p61) -- Line: 236
    -- upvalues: Carve (copy)
    return p61 ~= "Band" and 1 or 1 + Carve.MOST_BITS;
end;

function u1.pieces(p62, p63) -- Line: 243
    -- upvalues: u1 (copy), Sites (copy)
    if p62.blade then
        local v64 = 0;

        for _, v in ipairs(p63) do
            if v.layers then
                v64 = v64 + #v.layers;
            else
                v64 = v64 + 1;
            end;
        end;

        return v64 * u1.bladePieces(p62.mode);
    end;

    local v65 = 0;

    for _, v in ipairs(p63) do
        if p62.line then
            v65 = math.max(v65, v.count);
        else
            v65 = v65 + v.count;
        end;
    end;

    return v65 * Sites.LAYERS + #p63;
end;

return u1;