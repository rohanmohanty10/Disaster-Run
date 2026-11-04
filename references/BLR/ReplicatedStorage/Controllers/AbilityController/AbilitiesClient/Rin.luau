  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local u1 = {
    CurveShot = require(script.CurveShot),
    FakeShot = require(script.FakeShot),
    OppositeDirection = require(script.OppositeDirection),
    DribbleZone = require(script.DribbleZone),
    DestroyersDribble = require(script.Awakening.DestroyersDribble),
    CurvedFlow = require(script.Awakening.CurvedFlow),
    KillShot = require(script.Awakening.KillShot),
    TwoStepsBehind = require(script.Awakening.TwoStepsBehind),
    CenterOfGravity = require(script.Awakening.CenterOfGravity)
};
local u2 = {
    DestroyerCurveShot = require(script.NEL.DestroyerCurveShot),
    DestroyerCenterOfGravity = require(script.NEL.DestroyerCenterOfGravity),
    DestroyerDirection = require(script.NEL.DestroyerDirection),
    PredatorStrike = require(script.NEL.PredatorStrike),
    OcclusionBreak = require(script.NEL.OcclusionBreak),
    DestroyerMode = require(script.NEL.DestroyerMode),
    NoFear = require(script.NEL.Awakening.NoFear),
    EgoStoppage = require(script.NEL.Awakening.EgoStoppage)
};

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 44, Name: getKit
        -- upvalues: AbilityUtils (copy), PlayerData (copy), countStyleMastery (copy), interface (copy), u1 (copy), u2 (copy), AbilityBalancing (copy)
        local _, _, _, v5 = AbilityUtils.getCharacter();
        local v6, v7;

        if p4 and PlayerData.Data then
            v6 = countStyleMastery(PlayerData.Data, "Rin");
            v7 = PlayerData.Data.DisabledMasteryLevels.Rin;
        else
            v6 = 0;
            v7 = {};
        end;

        local v8 = {};

        if interface.FakeShot then
            v8[1] = {
                display = "Fake Shot",
                legacyFn = u1.FakeShot
            };
        else
            v8[1] = {
                display = "Curve Shot",
                fn = u1.CurveShot
            };
        end;

        v8[2] = {
            display = "Opposite Direction",
            fn = u1.OppositeDirection
        };
        v8[3] = {
            display = "Dribble Zone",
            fn = u1.DribbleZone
        };

        if p3 then
            v8[1] = {
                display = "Kill Shot",
                fn = u1.KillShot
            };

            if interface.RinTwoStepsBehindUsed then
                v8[2] = {
                    display = "Opposite Direction",
                    fn = u1.OppositeDirection
                };
            else
                v8[2] = {
                    display = "Two Steps Behind",
                    fn = u1.TwoStepsBehind
                };
            end;
        end;

        if not p3 then
            if v6 >= 1 and not v7[1] then
                if v5.HasBall.Value then
                    v8[1] = {
                        display = "Annihilate",
                        legacyFn = u2.DestroyerCurveShot
                    };
                else
                    v8[1] = {
                        display = "Center Of Gravity",
                        legacyFn = u2.DestroyerCenterOfGravity
                    };
                end;
            end;

            if v6 >= 2 and not v7[2] then
                v8[2] = {
                    display = "Occlusion Break",
                    legacyFn = u2.OcclusionBreak
                };
            end;

            if v6 >= 3 and not (v7[3] or p3) then
                v8[3] = {
                    display = "Destroyer Mode",
                    fn = u2.DestroyerMode
                };
            end;
        end;

        if v6 >= 4 and (not v7[4] and p3) then
            v8[3] = {
                display = "Ego Stoppage",
                fn = u2.EgoStoppage
            };
        end;

        if p4 then
            if p3 then
                if (interface.RinCenterOfGravityUses or 0) < AbilityBalancing.CenterOfGravity.MaxUsesPerAwakening then
                    v8[3] = {
                        display = "Center Of Gravity",
                        fn = u1.CenterOfGravity
                    };
                end;
            else
                interface.RinCenterOfGravityUses = nil;
                interface.RinCenterOfGravityPending = nil;
            end;
        end;

        for _, v in v8 do
            v.legacyId = v.display;
        end;

        return v8;
    end
};