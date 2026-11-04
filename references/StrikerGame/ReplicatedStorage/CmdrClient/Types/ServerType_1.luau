 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.wiki);
local Util = require(script.Parent.Parent.Shared.Util);
local u1 = { "5v5", "6v6", "11v11" };
local u7 = {
    Transform = function(p2) -- Line: 11, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 17, Name: Validate
        return #p3 > 0;
    end,

    Autocomplete = function(p4) -- Line: 21, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 25, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 29, Name: Default
        return p6;
    end
};

return function(p8) -- Line: 36
    -- upvalues: u7 (copy), Util (copy)
    p8:RegisterType("servertype", u7);
    p8:RegisterType("servertypes", Util.MakeListableType(u7));
end;