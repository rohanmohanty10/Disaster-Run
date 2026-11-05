  

 

local Stands = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("Stands"));

local function GetNames() -- Line: 3
    -- upvalues: Stands (copy)
    local v1 = {};

    for _, v in pairs(Stands) do
        table.insert(v1, v);
    end;

    return v1;
end;

return function(p2) -- Line: 11
    -- upvalues: Stands (copy)
    local v3 = {};

    for _, v in pairs(Stands) do
        table.insert(v3, v);
    end;

    p2:RegisterType("abilityname", p2.Cmdr.Util.MakeEnumType("AbilityName", v3));
end;