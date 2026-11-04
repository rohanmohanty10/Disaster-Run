  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    IllusionCross = require(script.IllusionCross),
    MirrorShield = require(script.MirrorShield),
    MagicianMirage = require(script.MagicianMirage),
    FlexibleSpell = require(script.FlexibleSpell),
    WeaponDisabler = require(script.WeaponDisabler),
    SpellChange = require(script.SpellChange),
    ANewSpell = require(script.Awakening.ANewSpell)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 26, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy), interface (copy)
        local Character, _, _, v4 = AbilityUtils.getCharacter();
        local v5 = {};

        if Character.Values.HasBall.Value then
            v5[1] = {
                display = "Illusion Cross",
                fn = u1.IllusionCross
            };
        else
            v5[1] = {
                display = "Mirror Shield",
                fn = u1.MirrorShield
            };
        end;

        if interface.FlexibleSpell then
            v5[2] = {
                display = "Flexible Spell",
                fn = u1.FlexibleSpell
            };
        elseif v4.HasBall.Value then
            v5[2] = {
                display = "Magician Mirage",
                fn = u1.MagicianMirage
            };
        else
            v5[2] = {
                display = "Weapon Disabler",
                legacyFn = u1.WeaponDisabler
            };
        end;

        v5[3] = {
            display = "Spell Change",
            fn = u1.SpellChange
        };

        if p2 then
            v5[3] = {
                display = "A New Spell",
                fn = u1.ANewSpell
            };
        end;

        for _, v in v5 do
            v.legacyId = v.display;
        end;

        return v5;
    end
};