 
 

game:GetService("ReplicatedStorage");
game:GetService("Players");
local u1 = require(script.Parent.Parent.Shared.Util).MakeFuzzyFinder({ "LuckySpins", "ZoneLuckySpins", "Spins", "ZoneSpins", "TrailColorSpins" });
local u6 = {
    Transform = function(p2) -- Line: 15, Name: Transform
        -- upvalues: u1 (copy)
        return u1(p2);
    end,

    Validate = function(p3) -- Line: 18, Name: Validate
        return #p3 > 0, "spin type not found";
    end,

    Autocomplete = function(p4) -- Line: 21, Name: Autocomplete
        return p4, {
            IsPartial = #p4 > 1
        };
    end,

    Parse = function(p5) -- Line: 26, Name: Parse
        return p5[1];
    end
};

return function(p7) -- Line: 31
    -- upvalues: u6 (copy)
    p7:RegisterType("spins", u6);
end;