 

 

local u1 = {
    Max = 100,
    Step = 5,
    Boost = table.freeze({
        Common = 0,
        Rare = 0.25,
        Epic = 0.5,
        Legendary = 1,
        Mythical = 1.25
    })
};

local function boost(p2) -- Line: 12
    -- upvalues: u1 (copy)
    return u1.Boost[p2.Rarity] or 0;
end;

function u1.current() -- Line: 17
    -- upvalues: u1 (copy)
    local Attribute = workspace:GetAttribute("TrollLuck");
    local Attribute2 = workspace:GetAttribute("TrollLuckUntil");

    if type(Attribute) ~= "number" or (Attribute ~= Attribute or (type(Attribute2) ~= "number" or Attribute2 <= workspace:GetServerTimeNow())) then
        return 0;
    end;

    local math_floor_ret = math.floor(Attribute);

    return math.clamp(math_floor_ret, 0, u1.Max);
end;

function u1.weights(p3, p4) -- Line: 27
    -- upvalues: u1 (copy)
    local Entries = p3.Entries;
    local table_create_ret = table.create(#Entries);
    local v5 = type(p4) == "number" and p4 and p4 or 0;
    local v6 = math.clamp(v5, 0, u1.Max) / 100;
    local v7 = 0;
    local v8 = 0;
    local v9 = 0;

    for i, v in Entries do
        table_create_ret[i] = v.Weight;

        if (u1.Boost[v.Rarity] or 0) > 0 then
            v7 = v7 + v.Weight;
            v8 = v8 + v.Weight * (1 + (u1.Boost[v.Rarity] or 0) * v6);
        else
            v9 = v9 + v.Weight;
        end;
    end;

    if v6 <= 0 or (v9 <= 0 or v7 <= 0) then
        return table_create_ret;
    end;

    local v10 = v8 - v7;
    local math_min_ret = math.min(1, v9 * 0.5 / v10);
    local v11 = 10000 - (v7 + v10 * math_min_ret);
    local v12 = 0;
    local v13 = {};

    for i, v in Entries do
        local v14;

        if (u1.Boost[v.Rarity] or 0) > 0 then
            v14 = v.Weight * (1 + (u1.Boost[v.Rarity] or 0) * v6 * math_min_ret);
        else
            v14 = v.Weight * v11 / v9;
            table.insert(v13, i);
        end;

        table_create_ret[i] = math.floor(v14 + 0.5);
        v12 = v12 + table_create_ret[i];
    end;

    table.sort(v13, function(p15, p16) -- Line: 62
        -- upvalues: table_create_ret (copy)
        local v17;

        if table_create_ret[p15] > table_create_ret[p16] then
            v17 = true;
        elseif table_create_ret[p15] == table_create_ret[p16] then
            v17 = p15 < p16;
        else
            v17 = false;
        end;

        return v17;
    end);
    local v18 = 10000 - v12;
    local v19 = v18 > 0 and 1 or -1;
    local v20 = 0;

    while v18 ~= 0 do
        local v21 = v13[v20 % #v13 + 1];

        if v19 > 0 or table_create_ret[v21] > 0 then
            table_create_ret[v21] = table_create_ret[v21] + v19;
            v18 = v18 - v19;
        end;

        v20 = v20 + 1;
    end;

    return table_create_ret;
end;

function u1.remap(p22, p23, p24) -- Line: 80
    -- upvalues: u1 (copy)
    if type(p24) ~= "number" or p24 <= 0 then
        return p23;
    end;

    local v25 = u1.weights(p22, p24);
    local v26 = 0;
    local v27 = 0;

    for i, v in p22.Entries do
        local v28 = v25[i];

        if v28 > 0 and (p23 <= v26 + v28 and v.Weight > 0) then
            local math_floor_ret = math.floor((p23 - v26 - 1) / v28 * v.Weight);

            return v27 + math.clamp(math_floor_ret, 0, v.Weight - 1) + 1;
        end;

        v26 = v26 + v28;
        v27 = v27 + v.Weight;
    end;

    return p23;
end;

function u1.lucky(p29, p30, p31) -- Line: 100
    -- upvalues: u1 (copy)
    if type(p31) ~= "number" or p31 <= 0 then
        return p30;
    end;

    local table_create_ret = table.create(#p30);

    for i, v in p30 do
        table_create_ret[i] = u1.remap(p29, v, p31);
    end;

    return table_create_ret;
end;

function u1.best(p32) -- Line: 112
    local v33 = nil;
    local v34 = nil;

    for i, v in p32.Entries do
        if not v33 or v.Weight < v33.Weight then
            v34 = i;
            v33 = v;
        end;
    end;

    return v33, v34;
end;

function u1.watch(u35) -- Line: 123
    -- upvalues: u1 (copy)
    local u36 = u1.current();
    local u37 = 0;

    local function check() -- Line: 126
        -- upvalues: u37 (ref), u1 (ref), u36 (ref), u35 (copy), check (copy)
        u37 = u37 + 1;
        local u38 = u37;
        local v39 = u1.current();

        if v39 ~= u36 then
            u36 = v39;
            task.spawn(u35, v39);
        end;

        local Attribute = workspace:GetAttribute("TrollLuckUntil");

        if v39 > 0 and type(Attribute) == "number" then
            local task_delay = task.delay;
            local v40 = Attribute - workspace:GetServerTimeNow() + 0.05;
            task_delay(math.max(0.05, v40), function() -- Line: 136
                -- upvalues: u37 (ref), u38 (copy), check (ref)
                if u37 == u38 then
                    check();
                end;
            end);
        end;
    end;

    local v41 = { workspace:GetAttributeChangedSignal("TrollLuck"):Connect(check), workspace:GetAttributeChangedSignal("TrollLuckUntil"):Connect(check) };
    check();

    return v41;
end;

u1.Notice = "Luck boost is on! Rarer prizes are more likely right now.";

function u1.revealTag() -- Line: 154
    -- upvalues: u1 (copy)
    return u1.current() > 0 and "  ·  🍀 LUCK BOOSTED" or "";
end;

function u1.tag() -- Line: 159
    -- upvalues: u1 (copy)
    local v42 = u1.current();

    return v42 > 0 and " · 🍀 LUCK +" .. v42 .. "%" or "";
end;

return table.freeze(u1);