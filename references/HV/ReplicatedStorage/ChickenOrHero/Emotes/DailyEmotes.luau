 

 

local RunService = game:GetService("RunService");
local EmoteCatalog = require(script.Parent.EmoteCatalog);
local script_Parent = script.Parent;
local u1 = {};
local CandyCorn = require(script.Parent.Parent.Game.CandyCorn);
u1.HalloweenChance = 0.6;
u1.Cards = { "Coins", "Gems", "Robux" };
u1.GraceSeconds = 60;
local u2 = {
    Coins = {},
    Gems = {},
    Robux = {}
};

for _, v in EmoteCatalog.Entries do
    local v3 = EmoteCatalog.card(v.Id);

    if v3 then
        table.insert(u2[v3], v.Id);
    end;
end;

u1.Pools = u2;
local u4 = {
    Coins = {},
    Gems = {},
    Robux = {}
};

for i, v in u2 do
    local v5 = i;

    for _, v2 in v do
        local v6 = EmoteCatalog.get(v2);

        if v6 and v6.Halloween then
            table.insert(u4[v5], v2);
        end;
    end;
end;

local function hash(p7) -- Line: 43
    local v8 = 5381;

    for i = 1, #p7 do
        local v9 = bit32.lshift(v8, 5) + v8;
        v8 = bit32.bxor(v9, string.byte(p7, i));
        local _ = i;
    end;

    return v8;
end;

local function shuffled(p10, p11) -- Line: 52
    -- upvalues: u2 (copy)
    local table_clone_ret = table.clone(u2[p10]);
    local Random_new = Random.new;
    local v12 = p10 .. ":" .. p11;
    local v13 = 5381;

    for i = 1, #v12 do
        local v14 = bit32.lshift(v13, 5) + v13;
        v13 = bit32.bxor(v14, string.byte(v12, i));
        local _ = i;
    end;

    local v15 = Random_new(v13);

    for i = #table_clone_ret, 2, -1 do
        local v16 = v15:NextInteger(1, i);
        local v17 = table_clone_ret[i];
        table_clone_ret[i] = table_clone_ret[v16];
        table_clone_ret[v16] = v17;
        local _ = i;
    end;

    return table_clone_ret;
end;

function u1.now() -- Line: 63
    -- upvalues: RunService (copy), script_Parent (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local math_floor_ret = math.floor(ServerTimeNow);

    if RunService:IsStudio() then
        local Attribute = script_Parent:GetAttribute("StudioDayOffset");

        if type(Attribute) == "number" and (Attribute == Attribute and Attribute % 1 == 0) then
            math_floor_ret = math_floor_ret + Attribute * 86400;
        end;
    end;

    return math_floor_ret;
end;

function u1.day(p18) -- Line: 74
    return p18 // 86400;
end;

function u1.secondsLeft(p19) -- Line: 79
    return 86400 - p19 % 86400;
end;

local function basePick(p20, p21) -- Line: 84
    -- upvalues: u2 (copy), shuffled (copy)
    local v22 = u2[p20];
    local v23 = v22 and #v22 or 0;

    if v23 == 0 then
        return nil;
    end;

    if v23 == 1 then
        return v22[1];
    end;

    if v23 == 2 then
        local v24 = 5381;

        for i = 1, #p20 do
            local v25 = bit32.lshift(v24, 5) + v24;
            v24 = bit32.bxor(v25, string.byte(p20, i));
            local _ = i;
        end;

        return v22[(p21 + v24) % 2 + 1];
    end;

    local v26 = p21 // v23;
    local v27 = shuffled(p20, v26);

    if v27[1] == shuffled(p20, v26 - 1)[v23] then
        local v28 = v27[1];
        v27[1] = v27[2];
        v27[2] = v28;
    end;

    return v27[p21 % v23 + 1];
end;

local function halloweenPick(p29, p30) -- Line: 106
    -- upvalues: u4 (copy), CandyCorn (copy), u1 (copy)
    local v31 = u4[p29];

    if not (v31 and (#v31 ~= 0 and CandyCorn.active(p30 * 86400 + 43200))) then
        return nil;
    end;

    local Random_new = Random.new;
    local v32 = p29 .. ":halloween:" .. p30;
    local v33 = 5381;

    for i = 1, #v32 do
        local v34 = bit32.lshift(v33, 5) + v33;
        v33 = bit32.bxor(v34, string.byte(v32, i));
        local _ = i;
    end;

    local v35 = Random_new(v33);

    if v35:NextNumber() >= u1.HalloweenChance then
        return nil;
    end;

    return v31[v35:NextInteger(1, #v31)];
end;

local u36 = {};
local u37 = 0;

function u1.pick(p38, p39, p40) -- Line: 121
    -- upvalues: u36 (copy), u1 (copy), halloweenPick (copy), basePick (copy), u4 (copy), u2 (copy), u37 (ref)
    local v41 = p38 .. ":" .. p39;

    if u36[v41] ~= nil then
        return u36[v41] or nil;
    end;

    local v42 = p40 or 0;
    local v43;

    if v42 < 7 then
        v43 = u1.pick(p38, p39 - 1, v42 + 1);
    else
        v43 = halloweenPick(p38, p39 - 1) or basePick(p38, p39 - 1);
    end;

    local v44 = {};
    local v45 = halloweenPick(p38, p39);

    if v45 then
        local v46 = u4[p38];
        local table_find_ret = table.find(v46, v45);

        for i = 0, #v46 - 1 do
            table.insert(v44, v46[(table_find_ret + i - 1) % #v46 + 1]);
            local _ = i;
        end;
    end;

    local v47 = basePick(p38, p39);
    table.insert(v44, v47);
    local v48 = u2[p38];
    local v49;

    if v47 then
        v49 = table.find(v48, v47);
    else
        v49 = v47;
    end;

    if v49 and #v48 > 1 then
        table.insert(v44, v48[v49 % #v48 + 1]);
    end;

    for _, v in v44 do
        if v ~= v43 then
            v47 = v;
            break;
        end;
    end;

    if v42 == 0 then
        if u37 > 256 then
            table.clear(u36);
            u37 = 0;
        end;

        u36[v41] = v47 or false;
        u37 = u37 + 1;
    end;

    return v47;
end;

function u1.picks(p50) -- Line: 165
    -- upvalues: u1 (copy)
    local v51 = {};

    for _, v in u1.Cards do
        v51[v] = u1.pick(v, p50);
    end;

    return v51;
end;

function u1.card(p52, p53) -- Line: 175
    -- upvalues: u1 (copy)
    local v54 = u1.day(p53);
    local v55 = p53 % 86400 < u1.GraceSeconds;

    for _, v in u1.Cards do
        if u1.pick(v, v54) == p52 or v55 and u1.pick(v, v54 - 1) == p52 then
            return v;
        end;
    end;

    return nil;
end;

return u1;