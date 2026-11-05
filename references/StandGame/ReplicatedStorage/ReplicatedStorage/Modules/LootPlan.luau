 

 

local v1 = {};
local u2 = {};
u2.__index = u2;
function u2.new(p3) --[[ Line: 12 ]]
    -- upvalues: u2 (copy)
    local v4 = setmetatable({}, u2);
    v4.Randomizer = Random.new(p3 or tick());
    v4.Loot = {};
    v4.TotalChance = 0;
    return v4;
end;
function u2.AddLoot(p5, p6, p7) --[[ Line: 20 ]]
    p5.TotalChance = p5.TotalChance + p7;
    local v8 = {
        name = p6,
        chance = p7
    };
    p5.Loot[p6] = v8;
    return v8;
end;
function u2.GetLootChance(p9, p10) --[[ Line: 30 ]]
    local v11 = p9.Loot[p10];
    if v11 then
        return v11.chance;
    end;
    error("Loot with name \'" .. tostring(p10) .. "\' does not exist");
end;
function u2.GetTrueLootChance(p12, p13) --[[ Line: 39 ]]
    return p12.Loot[p13] / p12.TotalChance * 100;
end;
function u2.RemoveLoot(p14, p15) --[[ Line: 43 ]]
    p14.TotalChance = p14.TotalChance - p14.Loot[p15].chance;
    p14.Loot[p15] = nil;
end;
function u2.ChangeLootChance(p16, p17, p18) --[[ Line: 48 ]]
    p16:RemoveLoot(p17);
    return p16:AddLoot(p17, p18);
end;
function u2.GetRandomLoot(p19) --[[ Line: 53 ]]
    local v20 = p19.Randomizer:NextNumber();
    local v21 = 0;
    for v22, v23 in pairs(p19.Loot) do
        if v20 < (v23.chance + v21) / p19.TotalChance then
            return v22;
        end;
        v21 = v21 + v23.chance;
    end;
end;
local u24 = {};
u24.__index = u24;
function u24.new(p25) --[[ Line: 69 ]]
    -- upvalues: u24 (copy)
    local v26 = setmetatable({}, u24);
    v26.Randomizer = Random.new(p25 or tick());
    v26.Loot = {};
    return v26;
end;
function u24.AddLoot(p27, p28, p29) --[[ Line: 76 ]]
    local v30 = {
        name = p28,
        chance = p29
    };
    p27.Loot[p28] = v30;
    return v30;
end;
function u24.GetLootChance(p31, p32) --[[ Line: 85 ]]
    local v33 = p31.Loot[p32];
    if v33 then
        return v33.chance;
    end;
    error("Loot with name \'" .. tostring(p32) .. "\' does not exist");
end;
function u24.RemoveLoot(p34, p35) --[[ Line: 94 ]]
    p34.Loot[p35] = nil;
end;
function u24.ChangeLootChance(p36, p37, p38) --[[ Line: 98 ]]
    p36.Loot[p37].chance = p38;
end;
function u24.GetRandomLoot(p39, p40) --[[ Line: 102 ]]
    local v41 = {};
    for _ = 1, p40 or 1 do
        for v42, v43 in pairs(p39.Loot) do
            if p39.Randomizer:NextNumber() < v43.chance / 100 then
                v41[v42] = v41[v42] and (v41[v42] + 1 or 1) or 1;
            end;
        end;
    end;
    return v41;
end;
function v1.new(p44, p45) --[[ Line: 117 ]]
    -- upvalues: u2 (copy), u24 (copy)
    if not p44 or p44 == "single" then
        return u2.new(p45);
    end;
    if p44 == "multi" then
        return u24.new(p45);
    end;
end;
return v1;