  

 

local PathShortcuts = require(game:GetService("ReplicatedStorage").ReplicatedModules.PathShortcuts);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local u1 = {
    Traits = {}
};

for _, descendant in script.AbilityTraits:GetDescendants() do
    if descendant:IsA("ModuleScript") then
        local TraitRarity = require(descendant).TraitRarity;

        for i, v in require(descendant) do
            if i ~= TraitRarity and type(v) == "table" then
                if not v.Rarity then
                    v.Rarity = TraitRarity;
                end;

                u1.Traits[i] = v;
            end;
        end;
    end;
end;

function u1.GetTraitFromPlayer(p2) -- Line: 30
    if workspace:GetAttribute("DisableTraits") then
        return {};
    end;

    local Ability = p2.Data.Ability;

    return {
        Trait = Ability:GetAttribute("Trait"),
        Hexed = Ability:GetAttribute("HexedTrait")
    };
end;

function u1.GetTraitsByRarity() -- Line: 39
    -- upvalues: u1 (copy)
    local v3 = {};

    for i, v in u1.Traits do
        if not v3[v.Rarity] then
            v3[v.Rarity] = {};
        end;

        table.insert(v3[v.Rarity], i);
    end;

    return v3;
end;

function u1.GetTraitData(p4) -- Line: 50
    -- upvalues: u1 (copy)
    return u1.Traits[p4];
end;

function u1.CallTrait(p5, ...) -- Line: 54
    -- upvalues: u1 (copy), TableUtil (copy)
    if type(p5) ~= "table" then
        return;
    end;

    local Hexed = p5.Hexed;
    local v6 = u1.GetTraitData(p5.Trait);

    if type(v6) == "table" then
        local v7 = TableUtil.Copy(v6, true);

        return (Hexed and v7.HexedCallback or v7.TraitCallback)(v7, ...);
    end;
end;

function u1.CallTraitWithCheck(p8, p9, ...) -- Line: 67
    -- upvalues: u1 (copy), TableUtil (copy)
    if type(p8) ~= "table" then
        return;
    end;

    local Hexed = p8.Hexed;
    local v10 = u1.GetTraitData(p8.Trait);

    if type(v10) ~= "table" then
        return;
    end;

    if p9(v10) then
        local v11 = TableUtil.Copy(v10, true);

        return (Hexed and v11.HexedCallback or v11.TraitCallback)(v11, ...);
    end;
end;

function u1.CallTraitWithMetadata(u12, p13) -- Line: 81
    -- upvalues: u1 (copy)
    local u14 = p13 or {};

    return (u14.Parser or function(...) -- Line: 83
        return ...;
    end)((function(...) -- Line: 85, Name: Callback
        -- upvalues: u14 (ref), u1 (ref), u12 (copy)
        if u14.CheckCallback then
            return u1.CallTraitWithCheck(u12, u14.CheckCallback, ...);
        end;

        return u1.CallTrait(u12, ...);
    end)(unpack(u14.Args or {})));
end;

function u1.IsTraitType(u15) -- Line: 95
    return function(p16) -- Line: 96
        -- upvalues: u15 (copy)
        local v17 = p16.TraitTypes and table.find(p16.TraitTypes, u15);

        return v17;
    end;
end;

return u1;