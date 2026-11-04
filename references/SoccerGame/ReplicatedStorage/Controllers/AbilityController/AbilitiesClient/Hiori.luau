  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    LinkPass = require(script.LinkPass),
    BelowZeroPass = require(script.BelowZeroPass),
    AbsoluteZeroDefense = require(script.AbsoluteZeroDefense),
    ColdLogicTurn = require(script.ColdLogicTurn)
};
local u2 = {
    HardFreezeCounter = require(script.Awakening.HardFreezeCounter),
    PermaFrostDefense = require(script.Awakening.PermaFrostDefense)
};

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 23, Name: getKit
        -- upvalues: AbilityUtils (copy), interface (copy), u1 (copy), u2 (copy)
        local Character, _, _, _ = AbilityUtils.getCharacter();
        local v5 = {};

        if interface.LinkPass then
            v5[1] = {
                display = "Link Pass",
                fn = u1.LinkPass
            };
        else
            v5[1] = {
                display = "Cold Logic Turn",
                fn = u1.ColdLogicTurn
            };
        end;

        if Character.Values.HasBall.Value then
            v5[2] = {
                display = "Below Zero Pass",
                fn = u1.BelowZeroPass
            };
        else
            v5[2] = {
                display = "Absolute Zero Defense",
                fn = u1.AbsoluteZeroDefense
            };
        end;

        if p3 then
            v5[1] = {
                display = "Permafrost Defense",
                fn = u2.PermaFrostDefense
            };
            v5[3] = {
                display = "Hard Freeze Counter-Attack",
                fn = u2.HardFreezeCounter
            };
        end;

        for _, v in v5 do
            v.legacyId = v.display;
        end;

        return v5;
    end
};