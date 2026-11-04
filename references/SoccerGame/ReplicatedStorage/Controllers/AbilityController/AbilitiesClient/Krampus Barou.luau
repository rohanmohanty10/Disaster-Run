  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    BlizzardFangShot = require(script.BlizzardFangShot),
    CrashSteal = require(script.CrashSteal),
    KrampusChopDribble = require(script.KrampusChopDribble),
    PredatorKrampus = require(script.PredatorKrampus),
    KrampusGreed = require(script.Awakening.KrampusGreed),
    KrampusStrike = require(script.Awakening.KrampusStrike)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 21, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy)
        local _, _, _, v4 = AbilityUtils.getCharacter();
        local v5 = {};

        if v4.HasBall.Value then
            v5[1] = {
                display = "Blizzard Fang Shot",
                fn = u1.BlizzardFangShot
            };
        else
            v5[1] = {
                display = "Crash Steal",
                fn = u1.CrashSteal
            };
        end;

        v5[2] = {
            display = "Krampus Chop Dribble",
            fn = u1.KrampusChopDribble
        };
        v5[3] = {
            display = "Predator Krampus",
            fn = u1.PredatorKrampus
        };

        if p2 then
            v5[1] = {
                display = "Krampus Strike",
                fn = u1.KrampusStrike
            };
            v5[2] = {
                display = "Krampus Greed",
                fn = u1.KrampusGreed
            };
        end;

        for _, v in v5 do
            v.legacyId = v.display;
        end;

        return v5;
    end
};