 

 

local u1 = {
    MAX_BLOCKS = 240
};
local u2 = { "X", "Y", "Z" };

local function planes(p3, p4, p5) -- Line: 36
    local table_create_ret = table.create(p4 + 1);
    local v6 = p3 / p4;
    table_create_ret[1] = -p3 / 2;

    for i = 1, p4 - 1 do
        table_create_ret[i + 1] = -p3 / 2 + v6 * (i + (p5() * 2 - 1) * 0.22);
        local _ = i;
    end;

    table_create_ret[p4 + 1] = p3 / 2;

    return table_create_ret;
end;

local function cubeEdge(p7, p8) -- Line: 49
    -- upvalues: u2 (copy)
    local v9 = {
        X = true,
        Y = true,
        Z = true
    };
    local v10 = 0;

    for i = 1, #u2 do
        local _ = i;
        local v11 = 1;
        local v12 = 0;

        for _, v in ipairs(u2) do
            if v9[v] then
                v11 = v11 * p7[v];
                v12 = v12 + 1;
            end;
        end;

        if v12 == 0 then
            break;
        end;

        v10 = (v11 / p8) ^ (1 / v12);
        local v13 = false;

        for _, v in ipairs(u2) do
            if v9[v] and p7[v] < v10 * 0.75 then
                v9[v] = false;
                v13 = true;
            end;
        end;

        if not v13 then
            break;
        end;
    end;

    return v10, v9;
end;

local function choices(p14, p15, p16) -- Line: 80
    if not p16 then
        return { 1 };
    end;

    local math_round_ret = math.round(p14 / p15);
    local math_max_ret = math.max(math_round_ret, 1);
    local v17 = {};

    for i = math.max(math_max_ret - 1, 1), math_max_ret + 1 do
        table.insert(v17, i);
        local _ = i;
    end;

    return v17;
end;

function u1.grid(p18, p19) -- Line: 92
    -- upvalues: u1 (copy), cubeEdge (copy), choices (copy), u2 (copy)
    local math_floor_ret = math.floor(p19);
    local math_clamp_ret = math.clamp(math_floor_ret, 1, u1.MAX_BLOCKS);
    local v20, v21 = cubeEdge(p18, math_clamp_ret);
    local v22 = (1 / 0);
    local v23 = 1;
    local v24 = 1;
    local v25 = 1;

    for _, v in ipairs((choices(p18.X, v20, v21.X))) do
        local v26 = v;

        for _, v2 in ipairs((choices(p18.Y, v20, v21.Y))) do
            local v27 = v2;

            for _, v3 in ipairs((choices(p18.Z, v20, v21.Z))) do
                local v28 = v26 * v27 * v3;

                if v28 <= u1.MAX_BLOCKS then
                    local v29 = v3;
                    local v30 = {
                        X = v26,
                        Y = v27,
                        Z = v3
                    };
                    local v31 = 0;
                    local v32 = (1 / 0);

                    for _, v4 in ipairs(u2) do
                        if v21[v4] then
                            local v33 = p18[v4] / v30[v4];
                            v31 = math.max(v31, v33);
                            v32 = math.min(v32, v33);
                        end;
                    end;

                    local v34 = math.abs(v28 - math_clamp_ret) / math_clamp_ret + (v31 <= 0 and 0 or v31 / v32 - 1) * 0.25;

                    if v34 < v22 then
                        v25 = v29;
                        v24 = v27;
                        v23 = v26;
                        v22 = v34;
                    end;
                end;
            end;
        end;
    end;

    return v23, v24, v25;
end;

function u1.cut(p35, p36, p37) -- Line: 128
    -- upvalues: u1 (copy), planes (copy)
    local v38, v39, v40 = u1.grid(p35, p36);
    local v41 = planes(p35.X, v38, p37);
    local v42 = planes(p35.Y, v39, p37);
    local v43 = planes(p35.Z, v40, p37);
    local table_create_ret = table.create(v38 * v39 * v40);

    for i = 1, v38 do
        local v44 = i;

        for i2 = 1, v39 do
            local v45 = i2;

            for i3 = 1, v40 do
                local v46 = {
                    offset = Vector3.new((v41[v44] + v41[v44 + 1]) / 2, (v42[v45] + v42[v45 + 1]) / 2, (v43[i3] + v43[i3 + 1]) / 2),
                    size = Vector3.new(v41[v44 + 1] - v41[v44], v42[v45 + 1] - v42[v45], v43[i3 + 1] - v43[i3])
                };
                table.insert(table_create_ret, v46);
                local _ = i3;
            end;
        end;
    end;

    return table_create_ret;
end;

function u1.centres(p47, p48) -- Line: 147
    -- upvalues: u1 (copy)
    local v49, v50, v51 = u1.grid(p47, p48);
    local table_create_ret = table.create(v49 * v50 * v51);

    for i = 1, v49 do
        local v52 = i;

        for i2 = 1, v50 do
            local v53 = i2;

            for i3 = 1, v51 do
                local Vector3_new_ret = Vector3.new(((v52 - 0.5) / v49 - 0.5) * p47.X, ((v53 - 0.5) / v50 - 0.5) * p47.Y, ((i3 - 0.5) / v51 - 0.5) * p47.Z);
                table.insert(table_create_ret, Vector3_new_ret);
                local _ = i3;
            end;
        end;
    end;

    return table_create_ret;
end;

return u1;