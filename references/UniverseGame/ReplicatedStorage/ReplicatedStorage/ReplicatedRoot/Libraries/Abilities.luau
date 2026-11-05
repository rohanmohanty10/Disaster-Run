  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
game:GetService("RunService"):IsStudio();
local u1 = {
    Entries = {
        [84931] = {
            Name = "Mortal Man",
            IsLegacy = false,
            IsPublic = false,
            UseFlags = {
                IsTesting = true
            }
        },
        [505] = {
            Name = "Goku (Z)",
            IsLegacy = false,
            IsPublic = false,
            UseFlags = {
                IsTesting = false
            }
        },
        [506] = {
            Name = "Goku (Super)",
            IsLegacy = false,
            IsPublic = false,
            UseFlags = {
                IsTesting = false
            }
        },
        [12318] = {
            Name = "Chainsaw Hybrid",
            IsLegacy = false,
            IsPublic = true
        },
        [12789] = {
            Name = "The Strongest",
            IsLegacy = true,
            IsPublic = true,
            Flags = {
                NewGeneration = Core.Flags.IsTesting == true
            }
        }
    },
    Dictionary = {}
};

function u1.GetAbilityInfo(p2) -- Line: 69
    -- upvalues: u1 (copy)
    if typeof(p2) == "string" then
        return u1.Dictionary[p2];
    end;

    if typeof(p2) == "number" then
        return u1.Entries[p2];
    end;

    return nil;
end;

function u1.GetAbilityName(p3) -- Line: 78
    -- upvalues: u1 (copy)
    local v4 = typeof(p3) == "number" and u1.GetAbilityInfo(p3);

    if v4 then
        return v4.Name;
    end;

    return p3;
end;

function u1.GetAbilityId(p5) -- Line: 88
    -- upvalues: u1 (copy)
    local v6 = typeof(p5) == "string" and u1.GetAbilityInfo(p5);

    if v6 then
        return v6.Id;
    end;

    return p5;
end;

for i, v in pairs(Stands) do
    local v7 = u1.Entries[i];

    if not v7 then
        v7 = {};
        u1.Entries[i] = v7;
    end;

    if v7.Name == nil then
        v7.Name = v;
    end;

    if v7.IsLegacy == nil then
        v7.IsLegacy = true;
    end;

    if v7.Flags == nil then
        v7.Flags = {};
    end;
end;

for i, v in pairs(u1.Entries) do
    v.Id = i;
    u1.Dictionary[v.Name] = v;
end;

return u1;