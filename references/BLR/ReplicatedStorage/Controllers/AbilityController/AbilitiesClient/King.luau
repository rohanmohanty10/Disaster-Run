  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local getPlayerTarget = require(ReplicatedStorage.Modules.getPlayerTarget);
local PlayerData = ClientGlobals.PlayerData;
local LocalPlayer = Players.LocalPlayer;
local script_SnuffyRebellionReceiver = require(script.SnuffyRebellionReceiver);
local u1 = {
    ChopFeint = require(script.ChopFeint),
    LionSteal = require(script.LionSteal),
    PredatorShot = require(script.PredatorShot),
    ChopDribble = require(script.DribbleV2),
    ChopFeast = require(script.ChopFeast),
    TwistedPath = require(script.TwistedPath),
    Feast = require(script.Feast)
};
local u2 = {
    LionShot = require(script.NEL.LionShot),
    StealthKillShot = require(script.NEL.StealthKillShot),
    StealthKill = require(script.NEL.StealthKill),
    ChopFeint = require(script.NEL.NELChopFeint),
    TyrantHeelFlick = require(script.NEL.TyrantHeelFlick),
    TyrantTwistedPath = require(script.NEL.TyrantTwistedPath),
    PredatorEye = require(script.NEL.PredatorEye),
    DoubleNutmeg = require(script.NEL.DoubleNutmeg)
};

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 39, Name: getKit
        -- upvalues: AbilityUtils (copy), PlayerData (copy), countStyleMastery (copy), interface (copy), u1 (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy), u2 (copy), script_SnuffyRebellionReceiver (copy)
        local Character, _, _, _ = AbilityUtils.getCharacter();
        local v5, v6;

        if p4 and PlayerData.Data then
            v5 = countStyleMastery(PlayerData.Data, "King");
            v6 = PlayerData.Data.DisabledMasteryLevels.King or {};
        else
            v5 = 0;
            v6 = {};
        end;

        local v7 = {};

        if not p3 then
            interface.DoubleNutmegUsed = false;
        end;

        if Character.Values.HasBall.Value then
            v7[1] = {
                display = "Chop Feint",
                legacyFn = u1.ChopFeint
            };
        else
            v7[1] = {
                display = "Lion Steal",
                legacyFn = u1.LionSteal
            };
        end;

        if Character.Values.HasBall.Value then
            if interface.KingsDribbleShot then
                v7[2] = {
                    display = "PredatorShot",
                    legacyFn = u1.PredatorShot
                };
            else
                v7[2] = {
                    display = "Chop Dribble",
                    legacyFn = u1.ChopDribble
                };
            end;
        else
            v7[2] = {
                display = "Chop Feast",
                legacyFn = u1.ChopFeast
            };
        end;

        if v5 >= 1 and not v6[1] then
            if getPlayerTarget(false, function(p8, p9) -- Line: 72
                -- upvalues: Character (copy), Players (ref), LocalPlayer (ref)
                if p8:GetAttribute("IsTrainingDummy") then
                    return (p8.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude < 10;
                end;

                local PlayerFromCharacter = Players:GetPlayerFromCharacter(p8);

                if not PlayerFromCharacter then
                    return false;
                end;

                if PlayerFromCharacter.Team == LocalPlayer.Team then
                    return false;
                end;

                local Values = p8.Values;
                local _ = Values.HasBall.Value;

                if Values.IsInPenalty.Value then
                    local _ = Values.Goalie.Value;
                end;

                if Values.InCutscene.Value then
                    return false;
                end;

                if (p8.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude < 10 then
                    return true;
                end;
            end) then
                v7[1] = {
                    display = "Stealth Kill Shot",
                    legacyFn = u2.StealthKillShot
                };
            else
                v7[1] = {
                    display = "Lion Shot",
                    fn = u2.LionShot
                };
            end;
        end;

        if v5 >= 2 and not v6[2] then
            v7[2] = {
                display = "Chop Feint",
                fn = u2.ChopFeint
            };
        end;

        if v5 >= 3 and not v6[3] then
            if Character.Values.HasBall.Value then
                if interface.TyrantHeelFlick then
                    v7[3] = {
                        display = "Tyrant Heel Flick",
                        legacyFn = u2.TyrantHeelFlick
                    };
                else
                    v7[3] = {
                        display = "Tyrant Twisted Path",
                        fn = u2.TyrantTwistedPath
                    };
                end;
            else
                v7[3] = {
                    display = "Predator Eye",
                    fn = u2.PredatorEye
                };
            end;
        end;

        if v5 >= 4 and (not v6[4] and p3) then
            v7[1] = {
                display = "Stealth Kill",
                fn = u2.StealthKill
            };

            if not interface.DoubleNutmegUsed then
                v7[3] = {
                    display = "Double Nutmeg",
                    fn = u2.DoubleNutmeg
                };
            end;
        elseif p3 then
            v7[1] = {
                display = "Twisted Path",
                legacyFn = u1.TwistedPath
            };
            v7[3] = {
                display = "Feast",
                legacyFn = u1.Feast
            };
        end;

        if p4 and (LocalPlayer:GetAttribute("CRRequest") == "SnuffyRebellion" and Character.Values.HasBall.Value) then
            v7[1] = {
                display = "Rebellion",
                fn = script_SnuffyRebellionReceiver
            };
        end;

        for _, v in v7 do
            v.legacyId = v.display;
        end;

        return v7;
    end
};