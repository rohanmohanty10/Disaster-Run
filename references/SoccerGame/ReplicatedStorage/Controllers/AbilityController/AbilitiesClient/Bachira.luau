  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
require(ReplicatedStorage.Shared.AbilityUtils);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local PlayerData = ClientGlobals.PlayerData;
local u1 = {
    BeeFlick = require(script.BeeFlick),
    MonsterShot = require(script.MonsterShot),
    MonsterTrance = require(script.MonsterTrance),
    ScissorKick = require(script.Scissors.ScissorKicks),
    ScissorShot = require(script.Scissors.ScissorShot)
};
local u2 = {
    BeeFreestyle = require(script.NEL.Awakening.BeeFreestyle),
    GingaMonster = require(script.NEL.Awakening.GingaMonster),
    Roulette = require(script.NEL.Roulette.RouletteMove),
    StingerShot = require(script.NEL.Roulette.StingerShot),
    ButterflyLift = require(script.NEL.NELBachiraVMove.ButterflyLift),
    ButterflyRoulette = require(script.NEL.NELBachiraVMove.ButterflyRoulette),
    HeelCenter = require(script.NEL.HeelCenter)
};

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 33, Name: getKit
        -- upvalues: PlayerData (copy), countStyleMastery (copy), u1 (copy), interface (copy), u2 (copy)
        local v5, v6;

        if p4 and PlayerData.Data then
            v5 = countStyleMastery(PlayerData.Data, "Bachira");
            v6 = PlayerData.Data.DisabledMasteryLevels.Bachira;
        else
            v5 = 0;
            v6 = {};
        end;

        local v7 = {
            {
                display = "Bee Flick",
                fn = u1.BeeFlick
            },
            {
                display = "Monster Shot",
                fn = u1.MonsterShot
            }
        };

        if p3 then
            if interface and not interface.ScissorShot then
                v7[2] = {
                    display = "Scissor Kicks",
                    fn = u1.ScissorKick
                };
            else
                v7[2] = {
                    display = "Scissor Shot",
                    fn = u1.ScissorShot
                };
            end;

            v7[3] = {
                display = "Monster Trance",
                fn = u1.MonsterTrance
            };
        end;

        if v5 >= 3 and not v6[3] then
            if interface.NELBachiraLift then
                v7[1] = {
                    display = "Stinger Shot",
                    fn = u2.StingerShot
                };
            else
                v7[1] = {
                    display = "Roulette",
                    fn = u2.Roulette
                };
            end;
        end;

        if v5 >= 2 and not v6[2] then
            if interface.ButterflyLift then
                v7[2] = {
                    display = "Butterfly Lift",
                    fn = u2.ButterflyLift
                };
            else
                v7[2] = {
                    display = "The Butterfly",
                    fn = u2.ButterflyRoulette
                };
            end;
        end;

        if v5 >= 1 and not (v6[1] or p3) then
            v7[3] = {
                display = "Heel Center",
                fn = u2.HeelCenter
            };
        end;

        if game:GetService("RunService"):IsStudio() then
            v7[3] = {
                display = "Heel Center",
                fn = u2.HeelCenter
            };
        end;

        if v5 >= 4 and (not v6[4] and p3) then
            v7[2] = {
                display = "Bee Freestyle",
                fn = u2.BeeFreestyle
            };
            v7[3] = {
                display = "Ginga Monster",
                fn = u2.GingaMonster
            };
        end;

        for _, v in v7 do
            v.legacyId = v.display;
        end;

        return v7;
    end
};