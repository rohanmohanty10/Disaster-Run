  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
require(ReplicatedStorage.Controllers.AbilityController.interface);
local AikuSelfishCaptainRules = require(ReplicatedStorage.Shared.AikuSelfishCaptainRules);
local PlayerData = ClientGlobals.PlayerData;
local LocalPlayer = game.Players.LocalPlayer;
local u1 = {
    ForcedDefense = require(script.ForcedDefense),
    TotalClearance = require(script.TotalClearance),
    SnakeInterception = require(script.SnakeInterception),
    SnakeVision = require(script.SnakeVision)
};
local u2 = {
    NELSnakeInterception = require(script.NELSnakeInterception),
    SnakeDeflect = require(script.SnakeDeflect),
    SerpentineRadar = require(script.SerpentineRadar)
};
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local u3 = {
    AikuSelfishCaptainReceiver = require(script.Awakening.AikuSelfishCaptainReceiver),
    SerpentWall = require(script.Awakening.SerpentWall),
    Aiku100Clearance = require(script.Awakening["100%Clearance"]),
    AikuVenomClearance = require(script.Awakening.AikuVenomClearance),
    AikuCrushingBloom = require(script.Awakening.AikuCrushingBloom)
};

return {
    meta = {},

    getKit = function(p4: boolean, p5: boolean) -- Line: 37, Name: getKit
        -- upvalues: PlayerData (copy), countStyleMastery (copy), AbilityUtils (copy), u1 (copy), LocalPlayer (copy), u2 (copy), ReplicatedStorage (copy), u3 (copy), AbilityBalancing (copy), AikuSelfishCaptainRules (copy)
        local v6, v7;

        if p5 and PlayerData.Data then
            v6 = countStyleMastery(PlayerData.Data, "Aiku");
            v7 = PlayerData.Data.DisabledMasteryLevels.Aiku;
        else
            v6 = 0;
            v7 = {};
        end;

        local Character, _, _, v8 = AbilityUtils.getCharacter();
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if Humanoid and HumanoidRootPart then
            local v9 = {
                [3] = {
                    display = "Snake Vision",
                    legacyFn = u1.SnakeVision
                },
                [1] = {
                    display = "Forced Defense",
                    legacyFn = u1.ForcedDefense
                }
            };
            HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);

            if Humanoid and Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid and Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                v9[2] = {
                    display = "Snake Interception",
                    legacyFn = u1.SnakeInterception
                };
            else
                v9[2] = {
                    display = "Total Clearance",
                    legacyFn = u1.TotalClearance
                };
            end;

            if v6 >= 1 and not (v7 and v7[1]) then
                if AbilityUtils.rules.grounded(LocalPlayer, false) then
                    v9[1] = {
                        display = "Forced Defense",
                        legacyFn = u1.ForcedDefense
                    };
                else
                    v9[1] = {
                        display = "Serpent Interception",
                        fn = u2.NELSnakeInterception
                    };
                end;
            end;

            if v6 >= 2 and not (v7 and v7[2]) then
                local X = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection).X;

                if math.abs(X) > 0.5 then
                    v9[2] = {
                        display = "Snake Deflect",
                        fn = u2.SnakeDeflect
                    };
                else
                    v9[2] = {
                        display = "Total Clearance",
                        legacyFn = u1.TotalClearance
                    };
                end;
            end;

            if v6 >= 3 and not (v7 and v7[3]) then
                v9[3] = {
                    display = "Serpentine Radar",
                    legacyFn = u2.SerpentineRadar
                };
            end;

            local v10;

            if v6 >= 4 then
                local v11;

                if v7 then
                    v11 = v7[4];
                else
                    v11 = v7;
                end;

                v10 = not v11;
            else
                v10 = false;
            end;

            if p4 and (v8 and not v8.HasBall.Value) then
                local State = Humanoid:GetState();
                local Value = ReplicatedStorage.Football.Value;

                if (State == Enum.HumanoidStateType.Jumping and true or State == Enum.HumanoidStateType.Freefall) and not (v8.Stunned.Value or (v8.Sliding.Value or (Character.IsRagdoll.Value or (not Value or (Value.Anchored or (Value.OnPlayer.Value or not AbilityUtils.rules.airBall(LocalPlayer, 50, nil, false))))))) then
                    v9[1] = {
                        display = "Serpent Wall",
                        cutscene = true,
                        legacyFn = u3.SerpentWall
                    };
                end;

                if not v10 and (AbilityUtils.rules.grounded(LocalPlayer, false) and AbilityUtils.rules.enemyTarget(25, true, false)) then
                    v9[2] = {
                        display = "100% Clearance",
                        cutscene = true,
                        legacyFn = u3.Aiku100Clearance
                    };
                end;
            end;

            if p4 and (v6 >= 4 and not (v7 and v7[4])) and (v8 and (not v8.HasBall.Value and AbilityUtils.rules.grounded(LocalPlayer, false))) then
                if AbilityUtils.findAikuAwakeningTarget(LocalPlayer, AbilityBalancing.AikuVenomClearance.EnemyRange) then
                    v9[2] = {
                        display = "Venom Clearance",
                        fn = u3.AikuVenomClearance
                    };
                end;

                if AbilityUtils.findAikuAwakeningTarget(LocalPlayer, AbilityBalancing.AikuCrushingBloom.EnemyRange) then
                    v9[3] = {
                        display = "Crushing Bloom",
                        fn = u3.AikuCrushingBloom
                    };
                end;
            end;

            if p4 and (v6 >= 4 and not (v7 and v7[4])) and (AikuSelfishCaptainRules.context(LocalPlayer, PlayerData.Data) and AbilityUtils.rules.canAct(LocalPlayer, false)) then
                v9[3] = {
                    display = "Selfish Captain",
                    legacyFn = u3.AikuSelfishCaptainReceiver
                };
            end;

            for _, v in v9 do
                v.legacyId = v.display;
            end;

            return v9;
        end;
    end
};