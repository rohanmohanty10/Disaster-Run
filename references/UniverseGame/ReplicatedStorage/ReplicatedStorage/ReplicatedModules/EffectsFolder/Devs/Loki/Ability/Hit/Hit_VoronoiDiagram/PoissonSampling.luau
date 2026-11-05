  

 

local v1 = {};
local floor = math.floor;

local function GetGridRange(p2, p3, p4) -- Line: 7
    -- upvalues: floor (copy)
    local v5 = p4 or 1;
    local v6 = floor((p2.x - v5) * 1.4142135623730951 + 1);
    local v7 = math.max(1, v6);
    local v8 = floor((p2.y - v5) * 1.4142135623730951 + 1);
    local v9 = math.max(1, v8);
    local x = p3.x;
    local v10 = floor((p2.x + v5) * 1.4142135623730951 + 1);
    local v11 = math.min(x, v10);
    local y = p3.y;
    local v12 = floor((p2.y + v5) * 1.4142135623730951 + 1);

    return v7, v9, v11, math.min(y, v12);
end;

function v1.PoissonSampling(p13, p14, p15, p16) -- Line: 17
    -- upvalues: floor (copy), GetGridRange (copy)
    local _ = p15 or 10;
    local v17 = {};
    local v18 = {};
    local v19 = 1.4142135623730951 / p14;
    local v20 = p13 * v19;
    local v21 = Vector2.new(math.ceil(v20.x), (math.ceil(v20.y)));
    local v22 = Vector2.new(math.random() * p13.x, math.random() * p13.y);
    v17[1] = v22;
    local v23 = floor(v22.x * v19 + 1);
    local v24 = floor(v22.y * v19 + 1);

    if not v18[v23] then
        v18[v23] = {};
    end;

    v18[v23][v24] = 1;
    local v25 = 1;
    v25 = v25 + 1;

    if v25 > #v17 then
        return v17;
    end;

    local v26 = v17[v25];
    local v27, v28, v29, v30 = GetGridRange(v26 / p14, v21, 3);
    local v31, v32;

    while true do
        local v33;
        local v34 = v34 + v33;
        local v35;

        if not (v33 > 0 and v34 <= v35 or v33 <= 0 and v34 >= v35) then
            break;
        end;

        if v31 then
            for i = v28, v30 do
                if v18[v34] and (v18[v34][i] and (v17[v18[v34][i]] - v32).magnitude < p14) then
                    v31 = false;
                    break;
                end;
            end;

            continue;
        end;

        break;
    end;

    if not v31 then
        break;
    end;

    table.insert(v17, v32);
    local v36;

    if not v18[v36] then
        v18[v36] = {};
    end;

    local v37;
    v18[v36][v37] = #v17;

    if #v17 ~= (p16 or 10000) then
        break;
    end;

    v25 = v25 + 1;

    if v25 > #v17 then
        return v17;
    end;

    v26 = v17[v25];
    v27, v28, v29, v30 = GetGridRange(v26 / p14, v21, 3);

    if v25 > #v17 then
        return v17;
    end;

    v26 = v17[v25];
    v27, v28, v29, v30 = GetGridRange(v26 / p14, v21, 3);
end;

return v1;