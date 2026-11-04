 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local Util = require(script.Parent.Parent.Shared.Util);
local PlrStats = require(ReplicatedStorage.Shared.Tables.PlrStats);
local u1 = {};

local function Recurse(p2, p3) -- Line: 8
    -- upvalues: u1 (copy), Recurse (copy)
    for i, v in p2 do
        if typeof(v) == "table" then
            local v4;

            if p3 then
                v4 = `{p3} {i}` or i;
            else
                v4 = i;
            end;

            Recurse(v, v4);
        else
            local v5;

            if p3 then
                v5 = `{p3} {i}` or i;
            else
                v5 = i;
            end;

            table.insert(u1, v5);
        end;
    end;
end;

Recurse(PlrStats);
local u6 = Util.MakeFuzzyFinder(u1);
local u12 = {
    Transform = function(p7) -- Line: 23, Name: Transform
        return p7;
    end,

    Validate = function(p8) -- Line: 26, Name: Validate
        return true;
    end,

    Autocomplete = function(p9) -- Line: 29, Name: Autocomplete
        -- upvalues: u6 (copy)
        local v10 = u6(p9);

        return v10, {
            IsPartial = #v10 > 1
        };
    end,

    Parse = function(p11) -- Line: 36, Name: Parse
        return p11;
    end
};

return function(p13) -- Line: 41
    -- upvalues: u12 (copy)
    p13:RegisterType("dataIndex", u12);
end;