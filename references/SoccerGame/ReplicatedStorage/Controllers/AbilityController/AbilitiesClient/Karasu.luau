  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    RavenDribble = require(script.RavenDribble),
    CrowDeflect = require(script.CrowDeflect),
    ShadowBreak = require(script.ShadowBreak),
    RavenAwaken = require(script.Awakening.RavenAwaken),
    CrowClearance = require(script.Awakening.CrowClearance)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 22, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy)
        local Character, _, _, _ = AbilityUtils.getCharacter();
        local v4 = {};

        if Character.Values.HasBall.Value then
            v4[1] = {
                display = "Raven Dribble",
                legacyFn = u1.RavenDribble
            };
        else
            v4[1] = {
                display = "Crow Deflect",
                legacyFn = u1.CrowDeflect
            };
        end;

        v4[2] = {
            display = "Shadow Break",
            legacyFn = u1.ShadowBreak
        };

        if p2 then
            v4[1] = {
                display = "Raven Awaken",
                fn = u1.RavenAwaken
            };
            v4[3] = {
                display = "Crow Clearance",
                legacyFn = u1.CrowClearance
            };
        end;

        for _, v in v4 do
            v.legacyId = v.display;
        end;

        return v4;
    end
};