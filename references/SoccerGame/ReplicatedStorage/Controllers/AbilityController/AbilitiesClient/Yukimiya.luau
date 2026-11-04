  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Shared.utils.countStyleMastery);
require(ReplicatedStorage.Controllers.AbilityController.interface);
require(ReplicatedStorage.Shared.AbilityUtils);
local _ = ClientGlobals.PlayerData;
local u1 = {
    LaBoba = require(script.LaBoba),
    StreetSweep = require(script.StreetSweep),
    GyroShot = require(script.GyroShot),
    StreetDribbling = require(script.StreetDribbling),
    GoalInTime = require(script.GoalInTime)
};
local _ = Players.LocalPlayer;

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 24, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy)
        local _, _, _, _ = AbilityUtils.getCharacter();
        local v4 = {
            {
                display = "LaBoba",
                legacyFn = u1.LaBoba
            },
            {
                display = "Street Sweep",
                legacyFn = u1.StreetSweep
            },
            {
                display = "Gyro Shot",
                legacyFn = u1.GyroShot
            }
        };

        if p2 then
            v4[1] = {
                display = "Street Dribbling",
                legacyFn = u1.StreetDribbling
            };
            v4[2] = {
                display = "Goal In Time",
                legacyFn = u1.GoalInTime
            };
            v4[3] = {
                display = "Gyro Shot",
                legacyFn = u1.GyroShot
            };
        end;

        for _, v in v4 do
            v.legacyId = v.display;
        end;

        return v4;
    end
};