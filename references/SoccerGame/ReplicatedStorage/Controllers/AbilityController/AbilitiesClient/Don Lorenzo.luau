  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Shared.utils.countStyleMastery);
require(ReplicatedStorage.Controllers.AbilityController.interface);
require(ReplicatedStorage.Shared.AbilityUtils);
local _ = ClientGlobals.PlayerData;
local u1 = {
    ZombieDribble = require(script.ZombieDribble),
    UndeadWalk = require(script.UndeadWalk),
    ZombieSteal = require(script.ZombieSteal),
    GoldenDefense = require(script.GoldenDefense),
    UndeadStepPass = require(script.UndeadStepPass)
};
local u2 = {
    DeathOfStriker = require(script.DeathOfStriker),
    YoMichael = require(script.YoMichael),
    UndeadMode = require(script.UndeadMode)
};
local _ = Players.LocalPlayer;

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 30, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy), u2 (copy)
        local _, _, v5, v6 = AbilityUtils.getCharacter();
        local v7 = v6 and v6:FindFirstChild("HasBall") and v6.HasBall.Value;
        local Attribute = v5:GetAttribute("ZombieDash");
        local v8 = {
            {
                display = v7 and not Attribute and "Zombie Dribble" or "Undead Walk",
                legacyFn = v7 and not Attribute and u1.ZombieDribble or u1.UndeadWalk
            },
            {
                display = v7 and "Undead Step-Pass" or "Zombie Steal",
                fn = v7 and u1.UndeadStepPass or u1.ZombieSteal
            },
            {
                display = "Golden Defense",
                legacyFn = u1.GoldenDefense
            }
        };

        for _, v in v8 do
            v.legacyId = v.display;
        end;

        if p3 then
            v8[1] = {
                display = "Death of a Striker",
                legacyId = "DeathOfStriker",
                cutscene = true,
                legacyFn = u2.DeathOfStriker
            };
            v8[2] = {
                display = "Yo, Michael",
                legacyId = "YoMichael",
                cutscene = true,
                legacyFn = u2.YoMichael
            };
            v8[3] = {
                display = "Undead Mode",
                legacyId = "UndeadMode",
                legacyFn = u2.UndeadMode
            };
        end;

        return v8;
    end
};