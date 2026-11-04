  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    ChopDribble = require(script.MiroChopDribble),
    KnuckleBall = require(script.KnuckleBall),
    SkyLeap = require(script.SkyLeap),
    SkyLeapOnBall = require(script.SkyLeapOnBall),
    MiracleBicycle = require(script.MiracleBicycle)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 19, Name: getKit
        -- upvalues: AbilityUtils (copy), interface (copy), u1 (copy)
        local Character, _, _, _ = AbilityUtils.getCharacter();
        local v4 = {};

        if interface.KnuckleBall then
            v4[1] = {
                display = "Knuckle Ball",
                fn = u1.KnuckleBall
            };
        else
            v4[1] = {
                display = "Chop Dribble",
                fn = u1.ChopDribble
            };
        end;

        if Character.Values.HasBall.Value then
            v4[2] = {
                display = "Sky Leap",
                fn = u1.SkyLeapOnBall
            };
        else
            v4[2] = {
                display = "Sky Leap",
                fn = u1.SkyLeap
            };
        end;

        v4[3] = {
            display = "Miracle Bicycle",
            fn = u1.MiracleBicycle
        };

        if p2 then
            v4[1] = {
                display = "Raven Awaken",
                fn = u1.RavenAwaken
            };
        end;

        for _, v in v4 do
            v.legacyId = v.display;
        end;

        return v4;
    end
};