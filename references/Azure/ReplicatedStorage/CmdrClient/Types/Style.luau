 

 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local wiki = require(ReplicatedStorage.wiki);
local Util = require(script.Parent.Parent.Shared.Util);
local u1 = {};

for i in pairs(wiki.styles) do
    u1[#u1 + 1] = i;
end;

local u7 = {
    Transform = function(p2) -- Line: 16, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 22, Name: Validate
        return #p3 > 0;
    end,

    Autocomplete = function(p4) -- Line: 26, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 30, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 34, Name: Default
        return p6;
    end
};

return function(p8) -- Line: 41
    -- upvalues: u7 (copy), Util (copy)
    p8:RegisterType("style", u7);
    p8:RegisterType("styles", Util.MakeListableType(u7));
end;