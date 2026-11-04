  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    Disruption = require(script.Disruption),
    VictoryPass = require(script.VictoryPass),
    Stoppage = require(script.Stoppage),
    MatchupVictory = require(script.Awakening.MatchupVictory)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 20, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy)
        local _, _, _, v4 = AbilityUtils.getCharacter();
        local v5 = {};

        if v4.HasBall.Value then
            v5[1] = {
                display = "Victory Pass",
                fn = u1.VictoryPass
            };
        else
            v5[1] = {
                display = "Stoppage",
                fn = u1.Stoppage
            };
        end;

        v5[2] = {
            display = "Disruption",
            fn = u1.Disruption
        };

        if p2 then
            v5[1] = {
                display = "Matchup Victory",
                fn = u1.MatchupVictory
            };
        end;

        for _, v in v5 do
            v.legacyId = v.display;
        end;

        return v5;
    end
};