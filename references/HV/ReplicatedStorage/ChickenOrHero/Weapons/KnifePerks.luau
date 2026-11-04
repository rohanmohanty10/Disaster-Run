 

 

local FantasySkinCatalog = require(script.Parent.FantasySkinCatalog);
local u1 = {};
local table_freeze_ret = table.freeze({
    Key = "None",
    SpeedBonus = 0,
    CooldownReduction = 0,
    DashCooldownReduction = 0
});
local u2 = {
    Epic = table.freeze({
        Key = "Epic",
        SpeedBonus = 0.35,
        CooldownReduction = 0.35,
        DashCooldownReduction = 0.1
    }),
    Legendary = table.freeze({
        Key = "Legendary",
        SpeedBonus = 0.85,
        CooldownReduction = 0.85,
        DashCooldownReduction = 0.3
    }),
    Mythical = table.freeze({
        Key = "Mythical",
        SpeedBonus = 1,
        CooldownReduction = 1.25,
        DashCooldownReduction = 0.4
    })
};

function u1.forSkin(p3) -- Line: 24
    -- upvalues: FantasySkinCatalog (copy), u2 (copy), table_freeze_ret (copy)
    local v4;

    if type(p3) == "string" then
        v4 = FantasySkinCatalog.Skins[p3];
    else
        v4 = false;
    end;

    return v4 and u2[v4.Rarity] or table_freeze_ret;
end;

local u5 = nil;

local function noAbilities(p6) -- Line: 33
    -- upvalues: u5 (ref)
    if not u5 then
        local Game = script.Parent.Parent:FindFirstChild("Game");
        local v7;

        if Game then
            v7 = Game:FindFirstChild("AbilityRule");
        else
            v7 = Game;
        end;

        if not (v7 and Game:FindFirstChild("Session")) then
            return false;
        end;

        u5 = require(v7);
    end;

    return u5.blocked(p6);
end;

local u8 = nil;

local function ranked() -- Line: 46
    -- upvalues: u8 (ref)
    if not u8 then
        local Game = script.Parent.Parent:FindFirstChild("Game");

        if Game then
            Game = Game:FindFirstChild("Session");
        end;

        u8 = Game;

        if not u8 then
            return false;
        end;
    end;

    return u8:GetAttribute("Ranked") == true;
end;

function u1.get(p9) -- Line: 56
    -- upvalues: noAbilities (copy), u8 (ref), table_freeze_ret (copy), u1 (copy)
    if not noAbilities(p9) then
        local v10;

        if u8 then
            v10 = u8:GetAttribute("Ranked") == true;
        else
            local Game = script.Parent.Parent:FindFirstChild("Game");

            if Game then
                Game = Game:FindFirstChild("Session");
            end;

            u8 = Game;

            if u8 then
                v10 = u8:GetAttribute("Ranked") == true;
            else
                v10 = false;
            end;
        end;

        if not v10 then
            local forSkin = u1.forSkin;

            if p9 then
                p9 = p9:GetAttribute("EquippedKnife");
            end;

            return forSkin(p9);
        end;
    end;

    return table_freeze_ret;
end;

function u1.cooldown(p11, p12) -- Line: 62
    -- upvalues: u1 (copy)
    local v13 = p11 - u1.get(p12).CooldownReduction;

    return math.max(0, v13);
end;

return table.freeze(u1);