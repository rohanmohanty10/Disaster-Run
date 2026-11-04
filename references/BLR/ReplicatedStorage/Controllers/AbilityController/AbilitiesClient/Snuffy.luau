  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local u1 = {
    DefenseOnBall = require(script.SnuffyRationalDefenseOnBall),
    DefenseOffBall = require(script.SnuffyRationalDefenseOffBall),
    Interception = require(script.SnuffyRationalInterception),
    Dribbling = require(script.SnuffyPhoenixDribbling),
    Core = require(script.SnuffyWorldClassCore),
    Vision = require(script.TacticalVision)
};
local u2 = {
    Defense = require(script.Awakening.SnuffyRationalPerfectDefense),
    Phoenix = require(script.Awakening.SnuffyPhoenixIntercept)
};

return {
    meta = {},

    getKit = function(p3, p4) -- Line: 17, Name: getKit
        -- upvalues: Players (copy), AbilityUtils (copy), u1 (copy), u2 (copy)
        local Character = Players.LocalPlayer.Character;
        local v5;

        if Character then
            v5 = Character:FindFirstChild("Values");
        else
            v5 = Character;
        end;

        local v6 = v5 and v5:FindFirstChild("HasBall") and v5.HasBall.Value;

        if Character then
            Character = not AbilityUtils.rules.grounded(Players.LocalPlayer, false);
        end;

        local v7 = {
            {
                display = "Rational Defense",
                fn = v6 and u1.DefenseOnBall or u1.DefenseOffBall
            },
            {
                display = v6 and "Phoenix Dribbling" or "World-Class Core",
                fn = v6 and u1.Dribbling or u1.Core
            },
            {
                display = "Tactical Vision",
                legacyFn = u1.Vision
            }
        };

        if Character and not v6 then
            v7[1] = {
                display = "Rational Interception",
                fn = u1.Interception
            };
        end;

        if p3 then
            v7[1] = {
                display = "Rational Perfect Defense",
                fn = u2.Defense
            };
            v7[2] = {
                display = "Phoenix Intercept",
                fn = u2.Phoenix
            };
        end;

        for _, v in v7 do
            v.legacyId = v.display;
        end;

        return v7;
    end
};