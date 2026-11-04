  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = {
    StealthySteps = require(script.StealthySteps),
    Dynamo = require(script.Dynamo),
    SneakyVolley = require(script.SneakyVolley)
};
local u2 = {
    ShinobiStrike = require(script.Awakening.ShinobiStrike)
};

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 22, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy), LocalPlayer (copy), u2 (copy)
        local Character, _, _, _ = AbilityUtils.getCharacter();
        local v5 = {
            {
                display = "Stealthy Steps",
                legacyFn = u1.StealthySteps
            }
        };

        if ((LocalPlayer.Team.Name == "Away" and workspace.PenaltyArea.Home or workspace.PenaltyArea.Away).Position - Character.HumanoidRootPart.Position).Magnitude > 100 then
            v5[2] = {
                display = "Dynamo",
                fn = u1.Dynamo
            };
        else
            v5[2] = {
                display = "Sneaky Volley",
                fn = u1.SneakyVolley
            };
        end;

        if p3 then
            v5[1] = {
                display = "Shinobi Strike",
                fn = u2.ShinobiStrike
            };
        end;

        for _, v in v5 do
            v.legacyId = v.display;
        end;

        return v5;
    end
};