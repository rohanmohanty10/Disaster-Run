  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Shared.utils.countStyleMastery);
require(ReplicatedStorage.Controllers.AbilityController.interface);
require(ReplicatedStorage.Shared.AbilityUtils);
local _ = ClientGlobals.PlayerData;
local u1 = {
    ScorpionKick = require(script.Scorpion),
    InstinctsReaction = require(script.InstinctsReaction),
    DivingHeader = require(script.DivingHeader)
};
local u2 = {
    SuperReflexes = require(script.Awakening.SuperReflexes)
};
local LocalPlayer = Players.LocalPlayer;

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 26, Name: getKit
        -- upvalues: AbilityUtils (copy), LocalPlayer (copy), u1 (copy), u2 (copy)
        local _, _, _, _ = AbilityUtils.getCharacter();
        local v5 = {};

        if LocalPlayer.Character.Values.Goalie.Value and LocalPlayer.Character.Values.Diving.Value then
            v5[1] = {
                display = "Instincts Reaction",
                legacyFn = u1.InstinctsReaction
            };
        else
            v5[1] = {
                display = "Scorpion Kick",
                legacyFn = u1.ScorpionKick
            };
        end;

        if LocalPlayer.Character.Values.IsInPenalty.Value and LocalPlayer.Character.Values.Goalie.Value then
            v5[2] = {
                display = "Fast Reactions",
                legacyFn = u1.DivingHeader
            };
        else
            v5[2] = {
                display = "Diving Header",
                legacyFn = u1.DivingHeader
            };
        end;

        if p3 then
            v5[3] = {
                display = "Super Reflexes",
                fn = u2.SuperReflexes
            };
        end;

        for _, v in v5 do
            v.legacyId = v.display;
        end;

        return v5;
    end
};