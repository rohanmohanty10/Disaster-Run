  

local script_Parent = script.Parent;
local useTagged = require(script_Parent.useTagged);
local useAttribute = require(script_Parent.useAttribute);

local function useBoolean(p1: userdata, p2: string) -- Line: 10
    -- upvalues: useAttribute (copy)
    return useAttribute(p1, p2, function(p3) -- Line: 11
        return p3 and true or false;
    end);
end;

return function() -- Line: 16, Name: useFeatures
    -- upvalues: useTagged (copy), useAttribute (copy)
    local v4 = useTagged("RelicsFeatures")[1];
    local v5 = useTagged("RelicsUGCSkin")[1];
    local v6 = useTagged("RelicsEmote")[1];
    local v7 = useTagged("RelicsAura")[1];
    local v9 = useAttribute(v4, "Emotes", function(p8) -- Line: 11
        return p8 and true or false;
    end);
    local v11 = useAttribute(v4, "Auras", function(p10) -- Line: 11
        return p10 and true or false;
    end);
    local v13 = useAttribute(v4, "Skins", function(p12) -- Line: 11
        return p12 and true or false;
    end);

    if not v7 then
        v11 = false;
    end;

    if not v5 then
        v13 = false;
    end;

    if not v6 then
        v9 = false;
    end;

    return {
        StartActive = useAttribute(v4, "StartActive", function(p14) -- Line: 11
            return p14 and true or false;
        end),
        Spectrogram = useAttribute(v4, "Spectrogram", function(p15) -- Line: 11
            return p15 and true or false;
        end),
        Favorites = useAttribute(v4, "Favorites", function(p16) -- Line: 11
            return p16 and true or false;
        end),
        Demo = useAttribute(v4, "Demo", function(p17) -- Line: 11
            return p17 and true or false;
        end),
        Emotes = v9,
        Skins = v13,
        Auras = v11
    };
end;