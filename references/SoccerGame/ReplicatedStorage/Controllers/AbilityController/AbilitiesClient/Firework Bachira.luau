  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    FlashyShot = require(script.FlashyShot),
    ExplosiveDribbling = require(script.ExplosiveDribbling),
    RocketPass = require(script.RocketPass),
    IllusiveFireworks = require(script.IllusiveFireworks),
    FireworkRain = require(script.Awakening.FireworkRain),
    ExplosiveMonster = require(script.Awakening.ExplosiveMonster)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 21, Name: getKit
        -- upvalues: AbilityUtils (copy), interface (copy), u1 (copy)
        local _, _, _, _ = AbilityUtils.getCharacter();
        local v4 = {};

        if interface.FlashyShot then
            v4[1] = {
                display = "Flashy Shot",
                fn = u1.FlashyShot
            };
        else
            v4[1] = {
                display = "Explosive Dribbling",
                fn = u1.ExplosiveDribbling
            };
        end;

        v4[2] = {
            display = "Rocket Pass",
            fn = u1.RocketPass
        };
        v4[3] = {
            display = "Illusive Fireworks",
            fn = u1.IllusiveFireworks
        };

        if p2 then
            v4[1] = {
                display = "Explosive Monster",
                fn = u1.ExplosiveMonster
            };
            v4[3] = {
                display = "Firework Rain",
                fn = u1.FireworkRain
            };
        end;

        for _, v in v4 do
            v.legacyId = v.display;
        end;

        return v4;
    end
};