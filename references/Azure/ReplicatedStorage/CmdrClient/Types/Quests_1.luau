 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.wiki);
require(ReplicatedStorage.emoteWiki);
local Util = require(script.Parent.Parent.Shared.Util);
local u1 = { "Kaiser\'s Ego", "Rin\'s Hatred", "Isagi\'s Rebirth", "Kunigami\'s Biggest Fan", "Aiku\'s Path To Blooming", "The King\'s Reign", "Don Lorenzo\'s Greed", "british aiku quest 1", "british aiku quest 2", "evil naruhaya footwork quest" };
local u7 = {
    Transform = function(p2) -- Line: 23, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 29, Name: Validate
        return #p3 > 0;
    end,

    Autocomplete = function(p4) -- Line: 33, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 37, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 41, Name: Default
        return p6;
    end
};

return function(p8) -- Line: 48
    -- upvalues: u7 (copy), Util (copy)
    p8:RegisterType("quest", u7);
    p8:RegisterType("quests", Util.MakeListableType(u7));
end;