 
 

game:GetService("ReplicatedStorage");
game:GetService("Players");
local u1 = require(script.Parent.Parent.Shared.Util).MakeFuzzyFinder({ "LuckyStyleSpins", "LuckyZoneSpins", "StyleSpins", "ZoneSpins", "TrailColorSpins", "ZoneColorSpins", "Money", "Exp", "WheelSpins", "LevelSpins", "BonusLevelSpins" });
local u2 = {
    LuckyStyleSpins = "LuckySpins",
    LuckyZoneSpins = "ZoneLuckySpins",
    StyleSpins = "Spins"
};
local u7 = {
    Transform = function(p3) -- Line: 27, Name: Transform
        -- upvalues: u1 (copy)
        return u1(p3);
    end,

    Validate = function(p4) -- Line: 30, Name: Validate
        return #p4 > 0, "nothing found";
    end,

    Autocomplete = function(p5) -- Line: 33, Name: Autocomplete
        return p5, {
            IsPartial = #p5 > 1
        };
    end,

    Parse = function(p6) -- Line: 38, Name: Parse
        -- upvalues: u2 (copy)
        return u2[p6[1]] or p6[1];
    end
};

return function(p8) -- Line: 43
    -- upvalues: u7 (copy)
    p8:RegisterType("toGive", u7);
end;