  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    ExplosiveAcceleration = require(script.ZantetsuExplosiveAcceleration),
    JetCounter = require(script.JetCounter),
    MotorCar = require(script.MotorCar),
    LeftFootedCurve = require(script.LeftFootedCurve),
    TerritoryShot = require(script.TerritoryShot)
};
local u2 = {
    LocalExpressBulletTrain = require(script.Awakening.ZantetsuLocalExpressBulletTrain)
};

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 23, Name: getKit
        -- upvalues: AbilityUtils (copy), interface (copy), u1 (copy), u2 (copy)
        local Character, _, _, v5 = AbilityUtils.getCharacter();
        local v6 = {};

        if Character.Values.HasBall.Value then
            if interface.MotorCar then
                v6[1] = {
                    display = "Maglev: Motor Car",
                    fn = u1.MotorCar
                };
            else
                v6[1] = {
                    display = "Jet Counter",
                    fn = u1.JetCounter
                };
            end;
        else
            v6[1] = {
                display = "Explosive Acceleration",
                fn = u1.ExplosiveAcceleration
            };
        end;

        if interface.MotorCar or interface.LeftFootedCurve then
            v6[2] = {
                display = "Left-Footed Curve",
                fn = u1.LeftFootedCurve
            };
        else
            v6[2] = {
                display = "Territory Shot",
                fn = u1.TerritoryShot
            };
        end;

        if p3 and (v5.HasBall.Value and AbilityUtils.checks.grounded() or interface.ZantetsuBulletTrainActive) then
            local v7 = interface.ZantetsuBulletTrainCharges or 0;
            v6[3] = {
                display = v7 >= 2 and "Best I Can Do Right Now Shot" or "Local Express Bullet Train (" .. tostring(2 - v7) .. ")",
                fn = u2.LocalExpressBulletTrain
            };
        end;

        for _, v in v6 do
            v.legacyId = v.display;
        end;

        if v6[3] then
            v6[3].legacyId = "ZantetsuLocalExpressBulletTrain";
        end;

        return v6;
    end
};