 

 

local RankedConfig = require(script.Parent.RankedConfig);
local GearCatalog = require(script.Parent.Parent.Gear.GearCatalog);
local Loadout = RankedConfig.Loadout;
local u1 = {};

local function level(p2, p3) -- Line: 9
    return (type(p2) ~= "number" or (p2 ~= p2 or (p2 % 1 ~= 0 or (p2 < 0 or p2 > p3)))) and 0 or p2;
end;

function u1.ability(p4, p5) -- Line: 14
    -- upvalues: GearCatalog (copy), Loadout (copy)
    local v6 = GearCatalog.get(p4);
    local v7;

    if Loadout.Abilities[p4] == nil or (v6 == nil or v6.Kind ~= "Ability") then
        v7 = false;
    else
        v7 = v6.UseRole == p5;
    end;

    return v7;
end;

function u1.item(p8) -- Line: 19
    -- upvalues: GearCatalog (copy), Loadout (copy)
    local v9 = GearCatalog.get(p8);
    local v10;

    if Loadout.Items[p8] == nil or v9 == nil then
        v10 = false;
    else
        v10 = v9.Kind == "Item";
    end;

    return v10;
end;

function u1.clean(p11) -- Line: 25
    -- upvalues: u1 (copy), Loadout (copy)
    local v12 = type(p11) ~= "table" and {} or p11;
    local v13 = {
        Runner = not u1.ability(v12.Runner, "Runner") and "" or v12.Runner,
        Catcher = not u1.ability(v12.Catcher, "Catcher") and "" or v12.Catcher,
        Item = not u1.item(v12.Item) and "" or v12.Item
    };
    local Uses = v12.Uses;
    local MaxUses = Loadout.MaxUses;
    v13.Uses = (type(Uses) ~= "number" or (Uses ~= Uses or (Uses % 1 ~= 0 or (Uses < 0 or Uses > MaxUses)))) and 0 or Uses;

    if v13.Item == "" or (v13.Uses == 0 or v13.Runner == "SoulReap" and v13.Item == "RescueKit") then
        v13.Item = "";
        v13.Uses = 0;
    end;

    return v13;
end;

function u1.cost(p14) -- Line: 40
    -- upvalues: Loadout (copy)
    return (Loadout.Abilities[p14.Runner] or 0) + (Loadout.Abilities[p14.Catcher] or 0) + (Loadout.Items[p14.Item] or 0) * p14.Uses;
end;

function u1.fits(p15) -- Line: 46
    -- upvalues: u1 (copy), RankedConfig (copy)
    return u1.cost(p15) <= RankedConfig.Credits;
end;

function u1.resolve(p16) -- Line: 52
    -- upvalues: u1 (copy), Loadout (copy)
    if type(p16) == "table" then
        local v17 = u1.clean(p16);

        if u1.fits(v17) then
            return v17;
        end;
    end;

    local v18 = u1.clean(Loadout.Default);

    if u1.fits(v18) then
        return v18;
    end;

    return u1.clean(nil);
end;

return table.freeze(u1);