 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local Util = require(script.Parent.Parent.Shared.Util);
local u7 = {
    Transform = function(p1) -- Line: 7, Name: Transform
        -- upvalues: ReplicatedStorage (copy), Util (copy)
        local v2 = {};

        for _, child in ReplicatedStorage.Assets.Maps:GetChildren() do
            local v3 = {
                Name = child:GetAttribute("DisplayName"),
                Index = tonumber(child.Name)
            };
            table.insert(v2, v3);
        end;

        return Util.MakeFuzzyFinder(v2)(p1);
    end,

    Validate = function(p4) -- Line: 17, Name: Validate
        return #p4 > 0, "Map not found or already loaded";
    end,

    Autocomplete = function(p5) -- Line: 20, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p5);
    end,

    Parse = function(p6) -- Line: 23, Name: Parse
        return p6[1].Index;
    end
};

return function(p8) -- Line: 28
    -- upvalues: u7 (copy)
    p8:RegisterType("map", u7);
end;