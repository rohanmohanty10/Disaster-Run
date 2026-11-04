  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    GodspeedFreeze = require(script.GodspeedFreeze),
    FrostShot = require(script.FrostShot),
    FrostAcceleration = require(script.FrostAcceleration),
    FrostCounter = require(script.FrostCounter),
    TheTunnel = require(script.Awakening.TheTunnel),
    SledDefense = require(script.Awakening.SledDefense)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 22, Name: getKit
        -- upvalues: AbilityUtils (copy), interface (copy), u1 (copy)
        local _, _, _, _ = AbilityUtils.getCharacter();
        local v4 = {};

        if interface and interface.FrostShot then
            v4[1] = {
                display = "Frost Shot",
                fn = u1.FrostShot
            };
        else
            v4[1] = {
                display = "Frost Acceleration",
                fn = u1.FrostAcceleration
            };
        end;

        v4[2] = {
            display = "Godspeed Freeze",
            fn = u1.GodspeedFreeze
        };
        v4[3] = {
            display = "Frost Counter",
            fn = u1.FrostCounter
        };

        if p2 then
            v4[1] = {
                display = "The Tunnel",
                fn = u1.TheTunnel
            };
            v4[3] = {
                display = "Sled Defense",
                fn = u1.SledDefense
            };
        end;

        for _, v in v4 do
            v.legacyId = v.display;
        end;

        return v4;
    end
};