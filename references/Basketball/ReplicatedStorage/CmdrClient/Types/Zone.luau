 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local Util = require(script.Parent.Parent.Shared.Util);
local v1 = {};

for i in require(ReplicatedStorage.Shared.Tables.Zones).Zones do
    table.insert(v1, i);
end;

local u2 = Util.MakeFuzzyFinder(v1);
local u7 = {
    Transform = function(p3) -- Line: 15, Name: Transform
        -- upvalues: u2 (copy)
        return u2(p3);
    end,

    Validate = function(p4) -- Line: 18, Name: Validate
        return #p4 > 0, "Zone not found";
    end,

    Autocomplete = function(p5) -- Line: 21, Name: Autocomplete
        return p5, {
            IsPartial = #p5 > 1
        };
    end,

    Parse = function(p6) -- Line: 26, Name: Parse
        return p6[1];
    end
};

return function(p8) -- Line: 31
    -- upvalues: u7 (copy)
    p8:RegisterType("zone", u7);
end;