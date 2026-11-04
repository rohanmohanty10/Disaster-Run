 

 

local Util = require(script.Parent.Parent.Shared.Util);
local Players = game:GetService("Players");

local function displayNamePairs(p1: table) -- Line: 14
    local v2 = {};

    for _, v in p1 do
        local Name = v.Name;
        local DisplayName = v.DisplayName;

        if DisplayName ~= "" and DisplayName ~= Name then
            Name = `{DisplayName}(@{Name})`;
        end;

        table.insert(v2, Name);
    end;

    return v2;
end;

local u11 = {
    Transform = function(p3: string) -- Line: 24, Name: resolve
        -- upvalues: Players (copy), Util (copy), displayNamePairs (copy)
        local Players2 = Players:GetPlayers();
        local v4 = Util.MakeFuzzyFinder(Players2)(p3);

        if #v4 > 0 then
            return v4;
        end;

        local v5 = {};

        for _, v in Util.MakeFuzzyFinder((displayNamePairs(Players2)))(p3) do
            local v6 = Players:FindFirstChild(string.match(v, "%(@(.+)%)$") or v);

            if v6 and v6:IsA("Player") then
                table.insert(v5, v6);
            end;
        end;

        return v5;
    end,

    Validate = function(p7: table) -- Line: 51, Name: Validate
        return #p7 > 0, "No player with that name could be found.";
    end,

    Autocomplete = function(p8: table) -- Line: 55, Name: Autocomplete
        -- upvalues: displayNamePairs (copy)
        return displayNamePairs(p8);
    end,

    Parse = function(p9: table) -- Line: 59, Name: Parse
        return p9[1];
    end,

    Default = function(p10: userdata) -- Line: 7, Name: displayNamePair
        local Name = p10.Name;
        local DisplayName = p10.DisplayName;

        if DisplayName == "" or DisplayName == Name then
            return Name;
        end;

        return `{DisplayName}(@{Name})`;
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p12) -- Line: 73
    -- upvalues: u11 (copy), Util (copy)
    p12:RegisterType("player", u11);
    p12:RegisterType("players", Util.MakeListableType(u11, {
        Prefixes = "% teamPlayers"
    }));
end;