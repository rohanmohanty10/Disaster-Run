  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    OneTwo = require(script.OneTwo),
    SharkSteal = require(script.SharkSteal),
    BaitDribble = require(script.BaitDribble),
    PlanetHotline = require(script.Awakening.PlanetHotline)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 20, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy)
        local _, _, _, v4 = AbilityUtils.getCharacter();
        local v5 = {
            {
                display = "OneTwo",
                legacyFn = u1.OneTwo
            }
        };

        if v4.HasBall.Value then
            v5[2] = {
                display = "Bait Dribble",
                fn = u1.BaitDribble
            };
        else
            v5[2] = {
                display = "Shark Steal",
                legacyFn = u1.SharkSteal
            };
        end;

        if p2 then
            v5[1] = {
                display = "Planet Hotline",
                fn = u1.PlanetHotline
            };
        end;

        for _, v in v5 do
            v.legacyId = v.display;
        end;

        return v5;
    end
};