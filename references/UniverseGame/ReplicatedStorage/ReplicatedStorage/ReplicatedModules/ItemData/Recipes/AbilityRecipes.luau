  

 

local RosterInfo = require(game:GetService("ReplicatedStorage").ReplicatedModules.PVEPackage.RosterInfo);
local Stands = require(game:GetService("ReplicatedStorage").ReplicatedModules.Stands);
local v1 = {};

local function GetStandId(p2) -- Line: 8
    -- upvalues: Stands (copy)
    for i, v in Stands do
        if v == p2 then
            return i;
        end;
    end;
end;

local function StringTable(p3) -- Line: 14
    -- upvalues: StringTable (copy)
    local v4 = "{\n";

    for i, v in p3 do
        local v5;

        if type(v) == "table" then
            v5 = StringTable(v);
        else
            v5 = tostring(v) .. ";";
        end;

        v4 = v4 .. `\n["{i}"] = {v5}`;
    end;

    return v4 .. "\n};";
end;

local v6, v7, v8;
v6, v7, v8 = v1, nil, nil;

while true do
    local v9, v10 = v6(v7, v8);

    if v9 == nil then
        break;
    end;

    v8 = v9;

    for i, v in Stands do
        if v == v9 then
            break;
        end;
    end;

    local v11 = `ABILITY_{i}`;
    local v12 = RosterInfo.RarityCache[v9];

    if RosterInfo.RewardInfo[v12] and not v10.Input.Shards then
        v10.Input.Shards = {
            [v11] = RosterInfo.RewardInfo[v12]
        };
    end;

    v10.Output = {
        Items = {
            [v11] = 1
        }
    };
end;