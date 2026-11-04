  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Shared.utils.countStyleMastery);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
require(ReplicatedStorage.Shared.AbilityUtils);
local _ = ClientGlobals.PlayerData;
local u1 = {
    AceShot = require(script.AceShot),
    DecoyStriker = require(script.DecoyStriker),
    LineClearance = require(script.LineClearance)
};
local u2 = {
    SendouStarClear = require(script.Awakening.SendouStarClear),
    SendouStarStrike = require(script.Awakening.SendouStarStrike)
};
local _ = Players.LocalPlayer;

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 27, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy), interface (copy), u2 (copy)
        local _, _, _, v5 = AbilityUtils.getCharacter();
        local v6 = v5 and v5:FindFirstChild("HasBall") and v5.HasBall.Value;
        local v7 = {
            {
                display = "Ace Shot",
                fn = u1.AceShot
            },
            {
                display = (v6 or interface.TikiTakaCharges) and "Decoy Striker" or "Line Clearance",
                fn = (v6 or interface.TikiTakaCharges) and u1.DecoyStriker or u1.LineClearance
            }
        };

        if p3 and not v6 then
            v7[2] = {
                display = "Star Clear",
                fn = u2.SendouStarClear
            };
        end;

        if p3 then
            v7[3] = {
                display = "Star Strike",
                fn = u2.SendouStarStrike
            };
        end;

        for _, v in v7 do
            v.legacyId = v.display;
        end;

        return v7;
    end
};