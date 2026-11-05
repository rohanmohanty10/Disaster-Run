  

 

local ToolItems = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("ItemData"):WaitForChild("Items"):WaitForChild("ToolItems"));
local u1 = { "Bravery", "Integrity", "Justice", "Kindness", "Patience", "Perserverance", "Needle", "LegacyArrow", "Candy", "Broken Watch", "Astral Key", "Fightsabre", "MeroFruit", "Tarot Card", "Transmitter", "Tome 1", "Tome 2", "Tome 3", "Used Arrow", "xSoul", "BASS CANNON", "Awakening", "Abruptum", "HomeRunBat", "Push", "LoveLoveDeluxe", "Globus", "Dristini Summoning", "Raijin", "SixthSense", "Stinger", "Tactical Vest", "Baroque Works Contractor Den Den", "Health Potion", "Meter Potion", "Shield Potion", "Rage Potion", "TradingSign" };

local function GetNames() -- Line: 46
    -- upvalues: ToolItems (copy), u1 (copy)
    local v2 = {};

    for _, v in ToolItems do
        if v and v.Name then
            table.insert(v2, v.Name);
        end;
    end;

    for _, v in u1 do
        if not table.find(v2, v) then
            table.insert(v2, v);
        end;
    end;

    table.sort(v2);

    return v2;
end;

return function(p3) -- Line: 61
    -- upvalues: GetNames (copy)
    local v4 = GetNames();
    p3:RegisterType("itemname", p3.Cmdr.Util.MakeEnumType("ItemName", v4));
end;