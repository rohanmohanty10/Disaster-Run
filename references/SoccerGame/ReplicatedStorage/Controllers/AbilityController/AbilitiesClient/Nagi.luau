  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local PlayerData = ClientGlobals.PlayerData;
local _ = game:GetService("Players").LocalPlayer;
local u1 = {
    Trap = require(script.AirDribble),
    Dash = require(script.AirDash),
    IAmNagi = require(script.IAmNagi)
};
local u2 = {
    NelTrap = require(script.NEL.Trap),
    BreakdanceShot = require(script.NEL.BreakdanceShot),
    ZeroResetTurn = require(script.NEL.ZeroResetTurn),
    DirectHeelLift = require(script.NEL.DirectHeelLift),
    EffortlessMiracle = require(script.NEL.Awakening.EffortlessMiracle),
    TwoStageVolley = require(script.NEL.Awakening.TwoStageVolley),
    FiveStageVolley = require(script.NEL.Awakening.FiveStageVolley)
};

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 29, Name: getKit
        -- upvalues: AbilityUtils (copy), PlayerData (copy), countStyleMastery (copy), interface (copy), u1 (copy), u2 (copy)
        local Character, _, _, _ = AbilityUtils.getCharacter();
        local v5, v6;

        if p4 and PlayerData.Data then
            v5 = countStyleMastery(PlayerData.Data, "Nagi");
            v6 = PlayerData.Data.DisabledMasteryLevels.Nagi;
        else
            v5 = 0;
            v6 = {};
        end;

        local v7 = {};

        if interface.__trapped then
            v7[1] = {
                display = "Trap Shot",
                legacyFn = u1.Trap
            };
        else
            v7[1] = {
                display = "Trap",
                legacyFn = u1.Trap
            };
        end;

        v7[2] = {
            display = "Dash",
            fn = u1.Dash
        };

        if p3 then
            v7[3] = {
                display = "I Am Nagi",
                legacyFn = u1.IAmNagi
            };
        end;

        if v5 >= 1 and not (v6[1] or p3) then
            if interface.TrapShot then
                v7[1] = {
                    display = "Breakdance Shot",
                    fn = u2.BreakdanceShot
                };
            else
                v7[1] = {
                    display = "Skull Trap",
                    fn = u2.NelTrap
                };
            end;
        end;

        if v5 >= 2 and not (v6[2] or p3) then
            v7[2] = {
                display = "Zero Reset Turn",
                legacyFn = u2.ZeroResetTurn
            };
        end;

        if v5 >= 3 and not (v6[3] or p3) then
            v7[3] = {
                display = "Direct Heel Lift",
                legacyFn = u2.DirectHeelLift
            };
        end;

        if not p3 then
            interface.UsedEffortless = false;
        end;

        if v5 >= 4 and (not v6[4] and p3) then
            if interface.TrapShot then
                v7[1] = {
                    display = "Breakdance Shot",
                    fn = u2.BreakdanceShot
                };
            else
                v7[1] = {
                    display = "Skull Trap",
                    fn = u2.NelTrap
                };
            end;

            if interface.UsedEffortless then
                v7[2] = {
                    display = "Zero Reset Turn",
                    legacyFn = u2.ZeroResetTurn
                };
            else
                v7[2] = {
                    display = "Effortless Miracle",
                    fn = u2.EffortlessMiracle
                };
            end;

            if Character.Values.HasBall.Value then
                v7[3] = {
                    display = "Five Stage Volley",
                    fn = u2.FiveStageVolley
                };
            else
                v7[3] = {
                    display = "Two Stage Volley",
                    fn = u2.TwoStageVolley
                };
            end;
        end;

        for _, v in v7 do
            v.legacyId = v.display;
        end;

        return v7;
    end
};