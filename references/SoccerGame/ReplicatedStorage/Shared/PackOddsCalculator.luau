  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PacksConfig = require(ReplicatedStorage.Shared.Configs.PacksConfig);
local ItemRarities = require(ReplicatedStorage.Shared.ItemRarities);
local ItemRobuxRarities = require(ReplicatedStorage.Shared.ItemRobuxRarities);
local Emotes = require(ReplicatedStorage.Shared.Emotes.Emotes);
local u1 = {};

local function sourceFor(p2) -- Line: 10
    -- upvalues: Emotes (copy), ReplicatedStorage (copy)
    if p2.SourceIsEmotesModule then
        return Emotes;
    end;

    local Inventory = ReplicatedStorage.Shared:FindFirstChild("Inventory");

    if Inventory then
        Inventory = Inventory:FindFirstChild(p2.InventoryKey);
    end;

    if Inventory then
        return require(Inventory);
    end;

    return nil;
end;

local function rarityOf(p3, p4, p5) -- Line: 22
    local v6 = p4[p5];

    if not p3.SourceIsEmotesModule then
        return v6;
    end;

    return v6 and v6.meta and v6.meta.rarity;
end;

function u1.BuildPool(p7) -- Line: 30
    -- upvalues: Emotes (copy), ReplicatedStorage (copy)
    local v8;

    if p7.SourceIsEmotesModule then
        v8 = Emotes;
    else
        local Inventory = ReplicatedStorage.Shared:FindFirstChild("Inventory");

        if Inventory then
            Inventory = Inventory:FindFirstChild(p7.InventoryKey);
        end;

        if Inventory then
            v8 = require(Inventory);
        else
            v8 = nil;
        end;
    end;

    if not v8 then
        return {};
    end;

    local v9 = {};

    if p7.Includes then
        for i, v in p7.Includes do
            local v10, v11;

            if type(i) == "number" then
                v10 = v;
                v11 = 1;
            else
                v11 = type(v) == "number" and v and v or 1;
                v10 = i;
            end;

            if v8[v10] then
                local v12 = {
                    Name = v10,
                    Weight = v11
                };
                local v13 = v8[v10];
                local v14;

                if p7.SourceIsEmotesModule and v13 then
                    v14 = v13.meta and v13.meta.rarity;
                else
                    v14 = v13;
                end;

                v12.Rarity = v14;
                table.insert(v9, v12);
            end;
        end;

        return v9;
    end;

    local v15 = {};

    for _, v in p7.Excludes or {} do
        v15[v] = true;
    end;

    for i in v8 do
        if not v15[i] then
            local v16 = {
                Weight = 1,
                Name = i
            };
            local v17 = v8[i];
            local v18;

            if p7.SourceIsEmotesModule and v17 then
                v18 = v17.meta and v17.meta.rarity;
            else
                v18 = v17;
            end;

            v16.Rarity = v18;
            table.insert(v9, v16);
        end;
    end;

    return v9;
end;

function u1.RarityDistribution(p19) -- Line: 63
    -- upvalues: ItemRobuxRarities (copy), ItemRarities (copy)
    local v20 = {};

    for i, v in pairs(p19 and ItemRobuxRarities or ItemRarities) do
        table.insert(v20, { i, v.Odds });
    end;

    table.sort(v20, function(p21, p22) -- Line: 69
        return p21[2] < p22[2];
    end);
    local v23 = 0;

    for _, v in v20 do
        v23 = v23 + v[2];
    end;

    if v23 <= 0 then
        return {};
    end;

    local v24 = 0;
    local v25 = {};

    for _, v in v20 do
        local v26 = math.max(v[2] - v24, 0) / v23;

        if v26 > 0 then
            v25[v[1]] = (v25[v[1]] or 0) + v26;
        end;

        v24 = math.max(v24, v[2]);
    end;

    local v27 = p19 and "Epic" or "Rare";
    local v28 = math.max(v23 - v24, 0) / v23;

    if v28 > 0 then
        v25[v27] = (v25[v27] or 0) + v28;
    end;

    if p19 and v25.Rare then
        v25.Epic = (v25.Epic or 0) + v25.Rare;
        v25.Rare = nil;
    end;

    return v25;
end;

function u1.ItemDistribution(p29, p30) -- Line: 100
    -- upvalues: u1 (copy)
    local v31 = {};

    for i, v in u1.RarityDistribution(p30) do
        local v32 = v;
        local v33 = i;
        local v34 = {};

        for _, v2 in p29 do
            if v2.Rarity == v33 then
                table.insert(v34, v2);
            end;
        end;

        local v35;

        if #v34 > 0 then
            v35 = v34 or p29;
        else
            v35 = p29;
        end;

        local v36 = 0;

        for _, v2 in v35 do
            v36 = v36 + v2.Weight;
        end;

        if v36 > 0 then
            for _, v2 in v35 do
                v31[v2.Name] = (v31[v2.Name] or 0) + v32 * (v2.Weight / v36);
            end;
        end;
    end;

    return v31;
end;

function u1.ForPack(p37, p38) -- Line: 123
    -- upvalues: PacksConfig (copy), u1 (copy)
    local v39 = PacksConfig[p37];

    if not v39 then
        return nil;
    end;

    local v40 = u1.BuildPool(v39);

    return {
        Pool = v40,
        PerItem = u1.ItemDistribution(v40, p38),
        RarityDist = u1.RarityDistribution(p38)
    };
end;

return u1;