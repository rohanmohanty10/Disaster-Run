  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    BackspinAcceleratingShot = require(script.BackspinAcceleratingShot),
    TwisterPass = require(script.TwisterPass)
};
local u2 = {
    Borderline = require(script.Awakening.Borderline)
};

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 20, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy), u2 (copy)
        local _, _, _, _ = AbilityUtils.getCharacter();
        local v5 = {
            {
                display = "Backspin Accelerating Shot",
                fn = u1.BackspinAcceleratingShot
            },
            {
                display = "Twister Pass",
                fn = u1.TwisterPass
            }
        };

        if p3 then
            v5[3] = {
                display = "Borderline",
                fn = u2.Borderline
            };
        end;

        for _, v in v5 do
            v.legacyId = v.display;
        end;

        return v5;
    end
};