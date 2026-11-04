 
 

local u1 = {
    CRATER = 0.42,
    RIM = 0.71
};
local u2 = { 0.05, 0.25, 0.5, 0.75, 0.95 };
local u3 = { { 0.6, 0 }, { 1, -0.9 }, { 1, 0.9 }, { 1.7, -0.5 }, { 1.7, 0.5 } };

function u1.reach(p4, p5) -- Line: 69
    -- upvalues: u1 (copy)
    return math.max(p4 / 2, p5 * 0.03) / u1.CRATER;
end;

function u1.path(p6, p7, p8, p9, p10) -- Line: 73
    local v11 = p8:Cross(p7);
    local v12 = { p6, p6 + p7 * p9 };
    local v13 = p9 * 0.045;

    for i = 1, 4 do
        local _ = i;
        local v14 = {};

        for i2 = 1, #v12 - 1 do
            table.insert(v14, v12[i2]);
            local v15 = (v12[i2] + v12[i2 + 1]) / 2 + v11 * ((p10() * 2 - 1) * v13);
            table.insert(v14, v15);
            local _ = i2;
        end;

        table.insert(v14, v12[#v12]);
        v13 = v13 / 2;
        v12 = v14;
    end;

    local v16 = { 0 };

    for i = 2, #v12 do
        v16[i] = v16[i - 1] + (v12[i] - v12[i - 1]).Magnitude;
        local _ = i;
    end;

    return {
        points = v12,
        run = v16,
        length = v16[#v16],
        normal = p8
    };
end;

function u1.moved(p17, p18, p19) -- Line: 94
    local table_create_ret = table.create(#p17.points);

    for i, v in ipairs(p17.points) do
        if p19 then
            table_create_ret[i] = p18:PointToObjectSpace(v);
        else
            table_create_ret[i] = p18:PointToWorldSpace(v);
        end;
    end;

    local normal = p17.normal;
    local v20;

    if p19 then
        v20 = p18:VectorToObjectSpace(normal);
    else
        v20 = p18:VectorToWorldSpace(normal);
    end;

    return {
        points = table_create_ret,
        run = p17.run,
        length = p17.length,
        normal = v20
    };
end;

function u1.at(p21, p22) -- Line: 112
    local v23 = math.clamp(p22, 0, 1) * p21.length;
    local points = p21.points;
    local run = p21.run;
    local v24 = 2;

    while v24 < #points and run[v24] < v23 do
        v24 = v24 + 1;
    end;

    local v25 = points[v24 - 1];
    local v26 = (points[v24] - v25) / (run[v24] - run[v24 - 1]);

    return v25 + v26 * (v23 - run[v24 - 1]), v26;
end;

function u1.from(p27, p28) -- Line: 125
    local normal = p27.normal;
    local points = p27.points;
    local run = p27.run;
    local v29 = p28 - normal * (p28 - points[1]):Dot(normal);
    local v30 = (1 / 0);
    local v31 = 0;
    local v32 = nil;

    for i = 2, #points do
        local v33 = points[i - 1];
        local v34 = points[i] - v33;
        local Magnitude = v34.Magnitude;
        local v35 = (v29 - v33):Dot(v34) / (Magnitude * Magnitude);
        local math_clamp_ret = math.clamp(v35, 0, 1);
        local v36 = v29 - (v33 + v34 * math_clamp_ret);
        local Magnitude2 = v36.Magnitude;
        local v37;

        if Magnitude2 < v30 then
            v31 = (run[i - 1] + Magnitude * math_clamp_ret) / p27.length;

            if Magnitude2 > 0.0001 then
                v32 = v36 / Magnitude2;
                v30 = Magnitude2;
                v37 = i;
            else
                v32 = normal:Cross(v34 / Magnitude);
                v30 = Magnitude2;
                v37 = i;
            end;
        else
            v37 = i;
        end;
    end;

    return v30, v31, v32;
end;

function u1.leaf(p38) -- Line: 150
    local math_clamp_ret = math.clamp(p38 / 0.4, 0, 1);
    local math_clamp_ret2 = math.clamp((1 - p38) / 0.6, 0, 1);

    return math.sin(math_clamp_ret * 3.141592653589793 / 2) * 0.7 * math.sin(math_clamp_ret2 * 3.141592653589793 / 2) ^ 0.8 + 0.3;
end;

function u1.places(p39, p40, p41, p42, p43, u44) -- Line: 156
    -- upvalues: u1 (copy), u3 (copy)
    local normal = p40.normal;
    local u45 = {};

    local function add(p46) -- Line: 159
        -- upvalues: u44 (copy), u45 (copy)
        if u44(p46) then
            table.insert(u45, p46);
        end;
    end;

    local math_floor_ret = math.floor(p39 * 0.1);

    for i = 1, math_floor_ret do
        local v47 = 0.1 + p43() * 0.7;
        local v48, v49 = u1.at(p40, v47);
        local v50 = (p43() * 2 - 1) * p41 * u1.CRATER * u1.leaf(v47) * 0.8;
        local v51 = v48 + normal:Cross(v49) * v50;
        local v52;

        if u44(v51) then
            table.insert(u45, v51);
            v52 = i;
        else
            v52 = i;
        end;
    end;

    local math_ceil_ret = math.ceil(p41 * u1.CRATER / 5);
    local math_clamp_ret = math.clamp(math_ceil_ret, 1, 3);
    local v53 = {};

    for i = 1, math_clamp_ret do
        table.insert(v53, {
            weight = 1,
            offset = (i - 0.5) / math_clamp_ret * u1.CRATER
        });
        local _ = i;
    end;

    table.insert(v53, {
        weight = 0.75,
        offset = (u1.CRATER + u1.RIM) / 2
    });
    table.insert(v53, {
        weight = 0.5,
        offset = (u1.RIM + 1) / 2
    });
    table.insert(v53, {
        weight = 0.3,
        straight = true,
        offset = (1 + p42) / 2
    });
    local v54 = 0;

    for _, v in ipairs(v53) do
        v54 = v54 + v.weight * 2;
    end;

    local math_max_ret = math.max(p39 - math_floor_ret - #u3 * 2, #v53 * 4);

    for _, v in ipairs(v53) do
        local v55 = v;

        for i = -1, 1, 2 do
            local math_round_ret = math.round(math_max_ret * v55.weight / v54);
            local math_max_ret2 = math.max(2, math_round_ret);
            local v56 = p43();
            local v57 = i;

            for i2 = 1, math_max_ret2 do
                local v58 = (i2 - 1 + 0.1 + v56 * 0.8) / math_max_ret2;
                local v59, v60 = u1.at(p40, v58);
                local v61;

                if v55.straight then
                    v61 = p41;
                else
                    v61 = p41 * u1.leaf(v58);
                end;

                local v62 = v57 * v55.offset * v61 * (1 + (p43() - 0.5) * 0.3);
                local v63 = v59 + normal:Cross(v60) * v62;
                local v64;

                if u44(v63) then
                    table.insert(u45, v63);
                    v64 = i2;
                else
                    v64 = i2;
                end;
            end;
        end;
    end;

    for _, v in ipairs({ {
            share = 0,
            turned = -1
        }, {
            share = 1,
            turned = 1
        } }) do
        local v65, v66 = u1.at(p40, v.share);
        local v67 = v66 * v.turned;
        local v68 = normal:Cross(v67);
        local v69 = p41 * u1.leaf(v.share);
        local math_max_ret2 = math.max(v69, p41 * 0.5);

        for _, v2 in ipairs(u3) do
            local v70 = v2[2] + (p43() - 0.5) * 0.3;
            local v71 = v65 + (v67 * math.cos(v70) + v68 * math.sin(v70)) * (v2[1] * math_max_ret2);

            if u44(v71) then
                table.insert(u45, v71);
            end;
        end;
    end;

    return u45;
end;

function u1.bounds(p72) -- Line: 218
    local v73 = p72.points[1];
    local v74 = p72.points[1];

    for _, v in ipairs(p72.points) do
        local math_min_ret = math.min(v73.X, v.X);
        local math_min_ret2 = math.min(v73.Y, v.Y);
        local math_min_ret3 = math.min(v73.Z, v.Z);
        v73 = Vector3.new(math_min_ret, math_min_ret2, math_min_ret3);
        local math_max_ret = math.max(v74.X, v.X);
        local math_max_ret2 = math.max(v74.Y, v.Y);
        local math_max_ret3 = math.max(v74.Z, v.Z);
        v74 = Vector3.new(math_max_ret, math_max_ret2, math_max_ret3);
    end;

    return v73, v74;
end;

function u1.of(p75, p76, p77, p78, p79) -- Line: 227
    -- upvalues: u2 (copy), u1 (copy)
    if p75.shape ~= "Linear" then
        return nil;
    end;

    local v80 = p76:VectorToObjectSpace(p75.origin.LookVector);
    local v81 = v80 - p78 * v80:Dot(p78);
    local Magnitude = v81.Magnitude;

    if Magnitude < 0.3 then
        return nil;
    end;

    local v82 = v81 / Magnitude;
    local v83 = p76:PointToObjectSpace(p75.origin.Position);
    local v84 = v83 - p78 * (v83 - p77):Dot(p78);
    local v85 = (p75.range - p75.inner) * Magnitude;

    if v85 <= 0 then
        return nil;
    end;

    local v86 = v84 + v82 * (p75.inner * Magnitude);
    local v87 = {};

    for _, v in ipairs(u2) do
        table.insert(v87, v86 + v82 * (v85 * v) - p78 * 0.5);
    end;

    return {
        path = u1.path(v86, v82, p78, v85, p79),
        reach = u1.reach(p75.halfWidth * 2, v85),
        probes = v87
    };
end;

return u1;