  

 

local TraitHandler = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("PVEPackage"):WaitForChild("TraitHandler"));

local function GetTraits() -- Line: 3
    -- upvalues: TraitHandler (copy)
    local v1 = {};

    for i, _ in TraitHandler.Traits do
        if i ~= "TraitRarity" then
            table.insert(v1, i);
        end;
    end;

    return v1;
end;

return function(p2) -- Line: 15
    -- upvalues: GetTraits (copy)
    local v3 = GetTraits();
    table.insert(v3, "None");
    p2:RegisterType("trait", p2.Cmdr.Util.MakeEnumType("Trait", v3));
end;