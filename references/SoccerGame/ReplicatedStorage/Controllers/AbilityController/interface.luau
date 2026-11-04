  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LegacyFunctions = require(ReplicatedStorage.Controllers.AbilityController.LegacyFunctions);
local v3 = {
    AutoCharacterRotateToCamera = function(p1, p2) -- Line: 8
        -- upvalues: LegacyFunctions (copy)
        LegacyFunctions.AutoCharacterRotateToCamera(p2);
    end,

    AbilityOne = -1,
    AbilityTwo = -1,
    AbilityThree = -1,
    AbilityUsed = -1,
    UngroupedAbilities = {},
    OverwriteText = {
        ["1"] = "",
        ["2"] = "",
        ["3"] = ""
    },
    ABC = require(ReplicatedStorage.Shared.Trove).new()
};
v3.AbilityTrove = v3.ABC;

return v3;