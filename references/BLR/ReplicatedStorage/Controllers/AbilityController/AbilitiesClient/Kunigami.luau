  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Shared.utils.countStyleMastery);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
require(ReplicatedStorage.Shared.AbilityUtils);
local _ = ClientGlobals.PlayerData;
local u1 = {
    PowerShot = require(script.PowerShot),
    CrushingHeader = require(script.CrushingHeader),
    BodyBlock = require(script.BodyBlock),
    FallenHero = require(script.Awakening.FallenHero)
};
local u2 = {
    DarkHorse = require(script.Awakening.DarkHorse),
    JokerShot = require(script.Awakening.JokerShot)
};
local _ = Players.LocalPlayer;

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 31, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy), u2 (copy), interface (copy)
        local Character, _, _, _ = AbilityUtils.getCharacter();
        local v5 = {
            [2] = {
                display = "Body Block",
                legacyFn = u1.BodyBlock
            }
        };

        if Character.Values.HasBall.Value then
            v5[1] = {
                display = "Power Shot",
                legacyFn = u1.PowerShot
            };
        else
            v5[1] = {
                display = "Crushing Header",
                legacyFn = u1.CrushingHeader
            };
        end;

        if p3 then
            v5[1] = {
                display = "Joker Shot",
                fn = u2.JokerShot
            };

            if interface.DarkHorseUsed then
                v5[2] = {
                    display = "Body Block",
                    legacyFn = u1.BodyBlock
                };
            else
                v5[2] = {
                    display = "Dark Horse",
                    fn = u2.DarkHorse
                };
            end;

            v5[3] = {
                display = "Fallen Hero",
                legacyFn = u1.FallenHero
            };
        end;

        for _, v in v5 do
            v.legacyId = v.display;
        end;

        return v5;
    end
};