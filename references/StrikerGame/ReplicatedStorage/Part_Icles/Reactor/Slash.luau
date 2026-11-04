 

 

local Trajectory = require(script.Parent.Parent.Rocks.Trajectory);
local Fields = require(script.Parent.Parent.Force.Fields);
local Blade = require(script.Parent.Blade);
local v1 = {};

local function stoodAt(p2, p3) -- Line: 74
    return p2.crackFrame[p3] or p2.pieces[p3].rest;
end;

local function reachAlong(p4, p5, p6) -- Line: 79
    local v7 = p4.XVector:Dot(p6);
    local v8 = math.abs(v7) * p5.X;
    local v9 = p4.YVector:Dot(p6);
    local v10 = v8 + math.abs(v9) * p5.Y;
    local v11 = p4.ZVector:Dot(p6);

    return v10 + math.abs(v11) * p5.Z;
end;

local function overhang(p12, p13, p14) -- Line: 85
    -- upvalues: reachAlong (copy)
    local v15 = 0;
    local v16 = (-1 / 0);

    for _, v in ipairs(p13) do
        local v17 = p12.crackFrame[v] or p12.pieces[v].rest;
        local v18 = v17.Position:Dot(p14);
        v15 = v15 + v18;
        local v19 = v18 + reachAlong(v17, p12.pieces[v].halfExt, p14);
        v16 = math.max(v16, v19);
    end;

    return v16 - v15 / #p13;
end;

local function slid(p20, p21, p22, p23, p24) -- Line: 98
    local math_min_ret = math.min(p24 / p23, 1);

    return p20 * p24 + p21 * (0.5 * p24 * p24) + p22 * (math_min_ret * math_min_ret);
end;

local function clearFor(p25, p26, u27, u28, u29, u30, p31) -- Line: 106
    -- upvalues: reachAlong (copy)
    local v32 = p25.crackFrame[p26] or p25.pieces[p26].rest;
    local halfExt = p25.pieces[p26].halfExt;
    local Position = v32.Position;
    local math_min_ret = math.min(p31 / u30, 1);
    local v33 = u27 * p31 + u28 * (0.5 * p31 * p31) + u29 * (math_min_ret * math_min_ret);
    local Magnitude = v33.Magnitude;

    if Magnitude < 0.0001 then
        return p31;
    end;

    local v34 = v33 / Magnitude;
    local v35 = p25.castRay(Position, v34 * (Magnitude + reachAlong(v32, halfExt, v34)));

    if not v35 then
        return p31;
    end;

    local Normal = v35.Normal;
    local u36 = v35.Position:Dot(Normal) + reachAlong(v32, halfExt, Normal);

    local function clear(p37) -- Line: 122
        -- upvalues: Position (copy), u27 (copy), u28 (copy), u29 (copy), u30 (copy), Normal (copy), u36 (copy)
        local math_min_ret2 = math.min(p37 / u30, 1);

        return u36 <= (Position + (u27 * p37 + u28 * (0.5 * p37 * p37) + u29 * (math_min_ret2 * math_min_ret2))):Dot(Normal);
    end;

    local math_min_ret2 = math.min(p31 / u30, 1);

    if u36 <= (Position + (u27 * p31 + u28 * (0.5 * p31 * p31) + u29 * (math_min_ret2 * math_min_ret2))):Dot(Normal) then
        return p31;
    end;

    local v38 = 0;

    for i = 1, 16 do
        local v39 = (v38 + p31) / 2;
        local math_min_ret3 = math.min(v39 / u30, 1);
        local v40;

        if u36 <= (Position + (u27 * v39 + u28 * (0.5 * v39 * v39) + u29 * (math_min_ret3 * math_min_ret3))):Dot(Normal) then
            v38 = v39;
            v40 = i;
        else
            p31 = v39;
            v40 = i;
        end;
    end;

    return v38;
end;

local function launch(p41, p42, p43, p44) -- Line: 141
    p41.display.wake(p42);
    p41.awake = p41.awake + 1;
    p41.hidden = p41.hidden + 1;
    p41.path[p42] = p43;
    p41.pathStart[p42] = p41.clock;
    p41.pathBuilt[p42] = p44;
    p41.lastFrame[p42] = p41.crackFrame[p42] or p41.pieces[p42].rest;

    if not p44 then
        table.insert(p41.buildQueue, p42);
    end;

    p41.state[p42] = 1;
    table.insert(p41.flying, p42);
    p41.supportStale = true;
end;

local function slideOff(p45, p46, p47, p48, p49, p50, p51) -- Line: 159
    -- upvalues: Trajectory (copy), launch (copy), overhang (copy), clearFor (copy)
    local v52 = p45:_rolled(p46[1]);
    local v53 = v52 * (p49 - 0.08 * p50);
    local v54 = p47.kerf / math.max(p50, 0.0001);
    local v55 = Vector3.new(0, 1, 0) * -v54;
    local v56 = 2 * v54 / math.max(v52, 0.0001);
    local math_sqrt_ret = math.sqrt(v56);
    local v57;

    if p48 == nil then
        v57 = false;
    else
        v57 = v53 > 1;
    end;

    if not v57 and p51 <= 0 then
        for _, v in ipairs(p46) do
            p45:_rolled(v);
            local v58 = p45.crackFrame[v] or p45.pieces[v].rest;
            local v59 = Trajectory.slide(v58.Position, Vector3.new(0, 0, 0), v58.Rotation, Vector3.new(0, 0, 0), math_sqrt_ret, v55, math_sqrt_ret);
            launch(p45, v, Trajectory.settled(v59, Vector3.new(0, 1, 0)), true);
        end;

        return;
    end;

    local v60 = p47.heading * p51;
    local v61 = 4;
    local v62;

    if v57 then
        v62 = p48 * v53;
        local v63 = overhang(p45, p46, p48);
        local v64 = v60:Dot(p48);
        local v65 = (-v64 + math.sqrt(v64 * v64 + 2 * v53 * v63)) / v53;
        v61 = math.min(v61, v65);
    else
        v62 = Vector3.new(0, 0, 0);
    end;

    if p51 > 0 then
        local v66 = overhang(p45, p46, p47.heading) / p51;
        v61 = math.min(v61, v66);
    end;

    for _, v in ipairs(p46) do
        p45:_rolled(v);
        local v67 = p45.crackFrame[v] or p45.pieces[v].rest;
        local v68 = clearFor(p45, v, v60, v62, v55, math_sqrt_ret, v61);
        local v69 = Trajectory.slide(v67.Position, v60, v67.Rotation, v62, v68, v55, math_sqrt_ret);
        local Position = v67.Position;
        local math_min_ret = math.min(v68 / math_sqrt_ret, 1);
        local v70 = v60 + v62 * v68;
        local Vector3_new_ret = Vector3.new(v70.X, 0, v70.Z);
        local v71 = Vector3_new_ret.Magnitude <= 0.0001 and Vector3.new(0, 0, 0) or (Vector3.new(0, 1, 0)):Cross(Vector3_new_ret.Unit) * (p45.settings.rollTumble() * 0.5);
        launch(p45, v, Trajectory.led(v69, Trajectory.ballistic(Position + (v60 * v68 + v62 * (0.5 * v68 * v68) + v55 * (math_min_ret * math_min_ret)), v70, v67.Rotation, v71)), false);
    end;
end;

local function release(p72, p73, p74) -- Line: 207
    -- upvalues: Fields (copy), Blade (copy), slideOff (copy)
    local slash = p73.slash;
    local sides = p73.sides;

    if #sides[1] == 0 or #sides[-1] == 0 then
        return;
    end;

    local v75 = p72:_rolled(p73.first);
    local v76 = p74.pushAlong <= 0.05 and 0 or Fields.throwSpeed(p74.pushAlong, v75);
    local v77 = p74.pushApart <= 0.05 and 0 or Fields.throwSpeed(p74.pushApart, v75);
    local v78, v79, v80, v81 = Blade.slope(slash);

    if v78 == 0 then
        if v76 > 0 or v77 > 0 then
            for i = -1, 1, 2 do
                local v82 = i;

                for _, v in ipairs(sides[i]) do
                    p72:_push(v, slash.heading * v76 + slash.normal * (v82 * v77));
                end;
            end;
        end;

        return;
    end;

    local v83 = sides[v78];

    if v77 > 0 then
        for _, v in ipairs(v83) do
            p72:_push(v, slash.heading * v76 + slash.normal * (v78 * v77));
        end;

        return;
    end;

    slideOff(p72, v83, slash, v79, v80, v81, v76);
end;

local function throwLoose(p84, p85, p86) -- Line: 246
    -- upvalues: Fields (copy)
    local cut = p85.cut;

    for i, v in ipairs(p84.pieces) do
        local slash = v.slash;
        local v87 = p84.state[i];

        if slash and (slash.by == p85 and (v.side and (v87 == 2 or v87 == 1))) and not p86[i] then
            p86[i] = true;
            local v88 = p84:_rolled(i);
            local v89 = Vector3.new(0, 0, 0);

            if cut.pushAlong > 0.05 then
                v89 = v89 + slash.heading * Fields.throwSpeed(cut.pushAlong, v88);
            end;

            if cut.pushApart > 0.05 then
                v89 = v89 + slash.normal * (v.side * Fields.throwSpeed(cut.pushApart, v88));
            end;

            if v89.Magnitude > 0.0001 then
                p84:_push(i, v89);
                p84:_takeTime(p85);
            end;
        end;
    end;
end;

local function letGo(p90, p91, p92) -- Line: 270
    -- upvalues: throwLoose (copy), release (copy)
    throwLoose(p90, p91, p92);
    local v93 = {};
    local v94 = {};

    for i, v in ipairs(p90.pieces) do
        local slash = v.slash;

        if slash and (slash.by == p91 and (p90.state[i] == 0 and not p90.pendingPush[i])) then
            local v95 = v93[slash];

            if not v95 then
                v95 = {
                    slash = slash,
                    sides = {
                        [1] = {},
                        [-1] = {}
                    },
                    first = i
                };
                v93[slash] = v95;
                table.insert(v94, v95);
            end;

            if v.side then
                p90.crackFrame[i] = p90.crackFrame[i] or p90.pieces[i].rest;
                p92[i] = true;

                if not v.fixed then
                    table.insert(v95.sides[v.side], i);
                end;
            end;
        end;
    end;

    for _, v in ipairs(v94) do
        p90.display.wake(v.first);
        p90.hidden = p90.hidden + 1;
        release(p90, v, p91.cut);
    end;

    if #v94 > 0 then
        p90:_takeTime(p91);
    end;
end;

local function throwBits(p96, p97, p98) -- Line: 304
    -- upvalues: Fields (copy)
    local field = p97.field;
    local strength = p97.strength;
    local v99 = Fields.heading(field, strength < 0);
    local Position = field.origin.Position;
    local LookVector = field.origin.LookVector;
    local random = p96.settings.random;

    for i, v in ipairs(p96.pieces) do
        local slash = v.slash;
        local v100 = p96.state[i];

        if v.bit and (slash.by == p97 and not (p98[i] or v100 ~= 0 and (v100 ~= 2 and v100 ~= 1))) and not p96.pendingPush[i] then
            local v101 = (p96:_position(i) - Position):Dot(LookVector);
            local math_clamp_ret = math.clamp(v101, field.inner, field.range);

            if math_clamp_ret <= p97.front then
                p98[i] = true;
                local v102 = 1 + p97.variation * (random() * 2 - 1);
                local v103 = strength * Fields.kept(p97.falloff, math_clamp_ret / field.range) * v102;
                local v104 = Fields.throwSpeed(v103, p96:_rolled(i));
                local v105 = slash.normal * ((random() * 2 - 1) * 0.35 * v104);
                p96:_push(i, v99 * v104 + v105);
            end;
        end;
    end;
end;

function v1.kick(p106, p107, p108) -- Line: 328
    -- upvalues: letGo (copy), throwBits (copy)
    if not p107.cut then
        return;
    end;

    local slashed = p106.slashed;

    if not slashed then
        slashed = setmetatable({}, {
            __mode = "k"
        });
        p106.slashed = slashed;
    end;

    if not slashed[p107] then
        slashed[p107] = true;
        letGo(p106, p107, p108);
    end;

    throwBits(p106, p107, p108);
end;

return v1;