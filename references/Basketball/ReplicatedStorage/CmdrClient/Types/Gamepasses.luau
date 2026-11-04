 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local Util = require(script.Parent.Parent.Shared.Util);
local v1 = {};

for _, v in ReplicatedStorage.Assets:WaitForChild("GamepassNames"):GetAttributes() do
    table.insert(v1, v);
end;

local u2 = Util.MakeFuzzyFinder(v1);
local u7 = {
    Transform = function(p3) -- Line: 16, Name: Transform
        -- upvalues: u2 (copy)
        return u2(p3);
    end,

    Validate = function(p4) -- Line: 19, Name: Validate
        return #p4 > 0, "gamepass not found";
    end,

    Autocomplete = function(p5) -- Line: 22, Name: Autocomplete
        return p5, {
            IsPartial = #p5 > 1
        };
    end,

    Parse = function(p6) -- Line: 27, Name: Parse
        return p6[1];
    end
};

return function(p8) -- Line: 32
    -- upvalues: u7 (copy)
    p8:RegisterType("gamepasses", u7);
end;