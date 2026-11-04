  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("Teams");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local LionSteal = require(ReplicatedStorage2.AbilityBalancing).LionSteal;
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);

return function(u1, p2, p3) -- Line: 17, Name: LionSteal
    -- upvalues: AbilityUtils (copy), LionSteal (copy), ReplicatedStorage2 (copy), Players (copy)
    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    if AbilityUtils.rules.enemyTarget(LionSteal.ActivationRangePlayer, true) then
        u1.StatesController.States.Ability = true;
        u1.StatesController.OwnWalkState = true;
        u1.ABC:Add(function() -- Line: 33
            -- upvalues: u1 (copy)
            u1.StatesController.States.Ability = false;
            u1.StatesController.OwnWalkState = false;
        end);
        u1.AbilityService.Ability:Fire("LionSteal", {
            State = "Start"
        });
        u1:AbilityCooldown("1", LionSteal.Cooldown);
        local HumanoidRootPart = p3.HumanoidRootPart;
        local TravelDistance = LionSteal.TravelDistance;
        u1.Animations.Abilities.LionSteal.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.LionSteal:Play();
        local v4 = tick() + 0.3;
        local v5 = nil;
        local v6 = nil;
        local v7 = false;
        local v8 = nil;

        while tick() < v4 do
            task.wait();
            local v9;

            if ReplicatedStorage2.Football.Value.IFrame.Value > tick() or v5 then
                v9 = v8;
            else
                local Value = ReplicatedStorage2.Football.Value;

                if Value.Parent == workspace and Value.Position.Y < 12 then
                    if not workspace:FindFirstChild("Football") then
                        return;
                    end;

                    if Value.OnPlayer.Value then
                        print("Ball on player");

                        return;
                    end;

                    v6 = (Value.Position - p3.HumanoidRootPart.Position).Magnitude;

                    if TravelDistance < v6 then
                        v9 = v8;
                    else
                        v5 = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Value.Position.X, HumanoidRootPart.Position.Y, Value.Position.Z)));
                        v9 = v8;
                        v7 = true;
                    end;
                else
                    for _, v in Players:GetPlayers() do
                        if v ~= p2 and (v.Character and v.Character.Values.HasBall.Value) then
                            v6 = (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

                            if v6 <= TravelDistance then
                                v5 = CFrame.new(HumanoidRootPart.Position, v.Character.HumanoidRootPart.Position);
                                v8 = v.Character;
                                local v10;

                                if v then
                                    v10 = v.PlayerStats.InAwakening.Value or false;
                                else
                                    v10 = false;
                                end;

                                if not (v10 or (v.Character.Values.Dribbling.Value or v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value)) then
                                    v7 = true;
                                end;
                            end;
                        end;
                    end;

                    if v5 then
                        v9 = v8;
                    else
                        v9 = workspace:FindFirstChild("PassRig");

                        if v9 and v9:GetAttribute("IsTrainingDummy") then
                            local Values = v9:FindFirstChild("Values");

                            if Values then
                                Values = Values:FindFirstChild("HasBall");
                            end;

                            if Values and Values.Value then
                                local HumanoidRootPart2 = v9:FindFirstChild("HumanoidRootPart");

                                if HumanoidRootPart2 then
                                    v6 = (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude;

                                    if v6 <= TravelDistance then
                                        v5 = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart2.Position);
                                        v7 = true;
                                    else
                                        v9 = v8;
                                    end;
                                else
                                    v9 = v8;
                                end;
                            else
                                v9 = v8;
                            end;
                        else
                            v9 = v8;
                        end;
                    end;
                end;
            end;

            v8 = v9;
        end;

        local Position = ((v5 or HumanoidRootPart.CFrame) * CFrame.new(0, 0, -TravelDistance)).Position;

        if v6 then
            if v7 then
                v7 = v6 / 60 * 1;
            end;
        else
            v7 = v6;
        end;

        u1.AbilityService.Ability:Fire("LionSteal", {
            State = "Dash",
            Pos = Position,
            enemy = v8,
            InRange = v7
        });
        AbilityUtils.FastDashTo(p3, Position, -2, 1);
        task.wait(1);
        u1.ABC:Clean();

        return true;
    end;
end;