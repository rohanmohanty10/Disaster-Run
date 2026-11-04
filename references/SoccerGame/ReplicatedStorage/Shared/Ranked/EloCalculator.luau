  

local v1 = {};

local function round(p2) -- Line: 10
    return p2 >= 0 and math.floor(p2 + 0.5) or math.ceil(p2 - 0.5);
end;

function calculate(p3, p4)
    local v5 = 0;
    local v6 = 0;
    local v7 = 0;
    local v8 = 0;

    for _, v in pairs(p3) do
        v5 = v5 + v;
        v6 = v6 + 1;
    end;

    for _, v in pairs(p4) do
        v7 = v7 + v;
        v8 = v8 + 1;
    end;

    local v9 = v5 / v6;
    local v10 = v7 / v8;
    local v11 = 1 / (10 ^ ((v10 - v9) / 400) + 1);
    local v12 = 1 - v11;
    local v13 = {};

    for i, v in pairs(p3) do
        local v14 = 32 * (0.75 * (1 - 1 / (1 + 10 ^ ((v10 - v) / 400))) + (1 - v11) * 0.25);
        v13[i] = v + (v14 >= 0 and math.floor(v14 + 0.5) or math.ceil(v14 - 0.5));
    end;

    for i, v in pairs(p4) do
        local v15 = 32 * (0.75 * (0 - 1 / (1 + 10 ^ ((v9 - v) / 400))) + (0 - v12) * 0.25);
        v13[i] = v + (v15 >= 0 and math.floor(v15 + 0.5) or math.ceil(v15 - 0.5));
    end;

    return v13;
end;

function v1.CalculateElo(p16: table, p17: table) -- Line: 57
    return calculate(p16, p17, 32);
end;

function v1.CalculateMMR(p18: table, p19: table) -- Line: 61
    return calculate(p18, p19, 32);
end;

return v1;