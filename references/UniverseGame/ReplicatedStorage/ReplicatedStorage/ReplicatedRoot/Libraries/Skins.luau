  

 

local Abilities = require(script.Parent.Abilities);
local Skins = require(game.ReplicatedStorage.ReplicatedModules.Skins);
local u1 = {
    Entries = {},
    Dictionary = {}
};

function u1.GetAbilitySkinInfo(p2) -- Line: 25
    -- upvalues: u1 (copy)
    if typeof(p2) == "string" then
        return u1.Dictionary[p2];
    end;

    if typeof(p2) == "number" then
        return u1.Entries[p2];
    end;

    return nil;
end;

function u1.GetAbilitySkinsById(p3) -- Line: 34
    -- upvalues: u1 (copy)
    local v4 = u1.GetAbilitySkinInfo(p3);

    return not v4 and {} or v4.Entries;
end;

function u1.GetAbilitySkinsByName(p5) -- Line: 42
    -- upvalues: u1 (copy)
    local v6 = u1.GetAbilitySkinInfo(p5);

    return not v6 and {} or v6.Dictionary;
end;

function u1.GetSkinInfo(p7, p8) -- Line: 50
    -- upvalues: u1 (copy)
    local v9 = u1.GetAbilitySkinInfo(p7);

    if v9 then
        if typeof(p8) == "string" then
            return v9.Dictionary[p8];
        end;

        if typeof(p8) == "number" then
            return v9.Entries[p8];
        end;
    end;

    return nil;
end;

function u1.GetSkinName(p10, p11) -- Line: 62
    -- upvalues: u1 (copy)
    local v12 = typeof(p11) == "number" and u1.GetSkinInfo(p10, p11);

    if v12 then
        return v12.Name;
    end;

    return p11;
end;

function u1.GetSkinId(p13, p14) -- Line: 72
    -- upvalues: u1 (copy)
    local v15 = typeof(p14) == "string" and u1.GetSkinInfo(p13, p14);

    if v15 then
        return v15.Id;
    end;

    return p14;
end;

for i, v in pairs(Skins.Skins) do
    local v16 = tonumber(i);

    if v16 ~= nil then
        local v17 = Abilities.GetAbilityInfo(v16);

        if v17 ~= nil then
            local v18 = u1.Entries[v16];

            if not v18 then
                v18 = {};
                u1.Entries[v16] = v18;
            end;

            if not v18.Name then
                v18.Name = v17.Name;
            end;

            if not v18.Entries then
                v18.Entries = {};
            end;

            if not v18.Dictionary then
                v18.Dictionary = {};
            end;

            for i2, v2 in pairs(v) do
                local v19 = tonumber(i2);

                if v19 ~= nil then
                    local v20 = v18.Entries[v19];

                    if not v20 then
                        v20 = {};
                        v18.Entries[v19] = v20;
                    end;

                    if v20.Name == nil then
                        v20.Name = v2;
                    end;
                end;
            end;
        end;
    end;
end;

for i, v in pairs(u1.Entries) do
    v.Id = i;
    u1.Dictionary[v.Name] = v;

    for i2, v2 in pairs(v.Entries) do
        v2.Id = i2;
        v.Dictionary[v2.Name] = v2;
    end;
end;

return u1;