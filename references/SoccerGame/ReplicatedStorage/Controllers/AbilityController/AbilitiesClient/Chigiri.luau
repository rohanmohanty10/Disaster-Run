  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
require(ReplicatedStorage.Shared.AbilityUtils);
local PlayerData = ClientGlobals.PlayerData;
local u1 = {
    Accelerate = require(script.Accelerate),
    Speedster = require(script.Speedster),
    Blast = require(script.Awakening.Blast)
};
local u2 = {
    NoBreakDribble = require(script.NEL.NoBreakDribble),
    ParkourShot = require(script.NEL.ParkourShot),
    PantherIllusion = require(script.NEL.PantherIllusion),
    HighSpeedSpeedster = require(script.NEL.HighSpeedSpeedster),
    MatchCutIn = require(script.NEL.Awakening.MatchCutIn),
    ["44PantherShot"] = require(script.NEL.Awakening["44PantherShot"])
};
local _ = Players.LocalPlayer;

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 33, Name: getKit
        -- upvalues: AbilityUtils (copy), PlayerData (copy), countStyleMastery (copy), u1 (copy), interface (copy), u2 (copy)
        local _, _, _, _ = AbilityUtils.getCharacter();
        local v5, v6;

        if p4 and PlayerData.Data then
            v5 = countStyleMastery(PlayerData.Data, "Chigiri");
            v6 = PlayerData.Data.DisabledMasteryLevels.Chigiri;
        else
            v5 = 0;
            v6 = {};
        end;

        local v7 = {
            {
                display = "Speedster",
                legacyFn = u1.Speedster
            },
            {
                display = "Accelerate",
                legacyFn = u1.Accelerate
            }
        };

        if p3 then
            v7[3] = {
                display = "Blast",
                legacyFn = u1.Blast
            };
        end;

        if p3 then
            if v5 >= 4 and (not v6[4] and p3) then
                v7[1] = {
                    display = "44° Red Panther Sniper",
                    fn = u2["44PantherShot"]
                };
                v7[2] = {
                    display = "Panther Illusion",
                    fn = u2.PantherIllusion
                };
                v7[3] = {
                    display = "Match Cut-In",
                    fn = u2.MatchCutIn
                };
            end;
        else
            if v5 >= 1 and not v6[1] then
                if interface.ParkourShot then
                    v7[1] = {
                        display = "Parkour Shot",
                        fn = u2.ParkourShot
                    };
                else
                    v7[1] = {
                        display = "High-Speed Speedster",
                        fn = u2.HighSpeedSpeedster
                    };
                end;
            end;

            if v5 >= 2 and not v6[2] then
                v7[2] = {
                    display = "Panther Illusion",
                    fn = u2.PantherIllusion
                };
            end;

            if v5 >= 3 and not (v6[3] or p3) then
                v7[3] = {
                    display = "No-Break Dribble",
                    fn = u2.NoBreakDribble
                };
            end;
        end;

        for _, v in v7 do
            v.legacyId = v.display;
        end;

        return v7;
    end
};