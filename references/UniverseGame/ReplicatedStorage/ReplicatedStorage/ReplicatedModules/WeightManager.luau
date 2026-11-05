  

 

local u1 = {};

local function ShallowCopy(p2) -- Line: 14
    local v3 = {};

    for i, v in pairs(p2) do
        v3[i] = v;
    end;

    return v3;
end;

function u1.ShuffleArray(p4, p5) -- Line: 22
    local v6 = p5 or Random.new();

    for i = 1, #p4 - 1 do
        local v7 = v6:NextInteger(i, #p4);
        local v8 = p4[i];
        p4[i] = p4[v7];
        p4[v7] = v8;
    end;

    return p4;
end;

function u1.GetTotalWeight(p9) -- Line: 32
    local v10 = 0;

    for _, v in p9 do
        v10 = v10 + v;
    end;

    return v10;
end;

function u1.GetRandomItemFromTable(p11, p12) -- Line: 40
    -- upvalues: u1 (copy)
    local v13 = p12 or Random.new();
    local v14 = {};

    for i, _ in p11 do
        table.insert(v14, i);
    end;

    local v15 = u1.ShuffleArray(v14, v13);
    local v16 = v13:NextInteger(1, (u1.GetTotalWeight(p11)));

    for _, v in ipairs(v15) do
        local v17 = p11[v];

        if v16 <= v17 then
            return v, v17;
        end;

        v16 = v16 - (v17 or 0);
    end;
end;

function u1.ShuffleDictionary(p18, p19) -- Line: 3
    for i = #p18, 1, -1 do
        local v20 = p19:NextInteger(1, i);
        local v21 = p18[i];
        p18[i] = p18[v20];
        p18[v20] = v21;
    end;

    return p18;
end;

return u1;