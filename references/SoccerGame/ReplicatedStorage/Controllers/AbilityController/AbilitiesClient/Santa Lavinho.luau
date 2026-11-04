  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    PresentStrike = require(script.PresentStrike),
    WrappedDribble = require(script.WrappedDribble),
    SleighRide = require(script.SleighRide),
    ChristmasStampede = require(script.ChristmasStampede),
    ClauseClashShot = require(script.Awakening.ClauseClashShot),
    YetiDefense = require(script.Awakening.YetiDefense)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 23, Name: getKit
        -- upvalues: AbilityUtils (copy), interface (copy), u1 (copy)
        local _, _, _, _ = AbilityUtils.getCharacter();
        local v4 = {};

        if interface.PresentStrike then
            v4[1] = {
                display = "Present Strike",
                fn = u1.PresentStrike
            };
        else
            v4[1] = {
                display = "Wrapped Dribble",
                fn = u1.WrappedDribble
            };
        end;

        v4[2] = {
            display = "Sleigh Ride",
            fn = u1.SleighRide
        };
        v4[3] = {
            display = "Christmas Stampede",
            fn = u1.ChristmasStampede
        };

        if p2 then
            v4[1] = {
                display = "Claus Clash Shot",
                fn = u1.ClauseClashShot
            };
            v4[3] = {
                display = "Yeti Defense",
                fn = u1.YetiDefense
            };
        end;

        for _, v in v4 do
            v.legacyId = v.display;
        end;

        return v4;
    end
};