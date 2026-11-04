  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local BearClaw = require(ReplicatedStorage.AbilityBalancing).BearClaw;

return function(u1, u2, u3) -- Line: 19, Name: BearClaw
    -- upvalues: Popup (copy), ReplicatedStorage (copy), BearClaw (copy), RunService (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if u3.Values.HasBall.Value then
        return;
    end;

    if u2.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if u2.Character:FindFirstChild("DiveHitbox") then
        return;
    end;

    if not u3.Values.IsInPenalty.Value then
        return Popup.Popup(u2, "Must be inside of your own goal box!");
    end;

    if not u3.Values.Goalie.Value then
        return Popup.Popup(u2, "Must be the goalkeeper!");
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if not ReplicatedStorage.Football.Value then
        return;
    end;

    u1:AbilityCooldown("3", BearClaw.Cooldown);
    u1.AbilityService.Ability:Fire("BearClaw");
    local u4 = false;
    local u5 = nil;
    u5 = u2.Character.Values.IsInPenalty:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 50
        -- upvalues: u2 (copy), u1 (copy), u5 (ref)
        if not u2.Character.Values.IsInPenalty.Value then
            u1.ABC:Clean();

            if u5 then
                u5:Disconnect();
            end;
        end;
    end);
    task.delay(7, function() -- Line: 58
        -- upvalues: u4 (ref), u1 (copy), u5 (ref)
        if u4 then
            return;
        end;

        u1.ABC:Clean();

        if u5 then
            u5:Disconnect();
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p6, u7, p8, p9) -- Line: 67
        -- upvalues: u4 (ref), u5 (ref), u1 (copy), u3 (copy), u2 (copy), RunService (ref)
        if p6 ~= "AbilityStart" then
            if p6 == "Shot" then
                u1.ABC:Clean();

                if p8 == u2 or not p8 then
                    u7.AssemblyLinearVelocity = p9 or (u2.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.25, 0)) * 190;
                    u1.BallController:DragBall(u7);

                    return;
                end;

                if p8 and (p8 ~= u2 and (p8.Team == u2.Team and p8.Character)) then
                    local Character = p8.Character;
                    local Vector3_new_ret = Vector3.new(Character.HumanoidRootPart.AssemblyLinearVelocity.X, 0, Character.HumanoidRootPart.AssemblyLinearVelocity.Z);
                    local u10 = (Character.HumanoidRootPart.Position + Vector3_new_ret - u3.HumanoidRootPart.Position).Unit + Vector3.new(0, 0.05, 0);
                    local math_clamp_ret = math.clamp((Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
                    u7.AssemblyLinearVelocity = u10 * math_clamp_ret;
                    u1.BallController:DragBall(u7);
                    local u11 = tick();
                    local u12 = nil;
                    task.delay(0.4, function() -- Line: 131
                        -- upvalues: u12 (ref)
                        if u12 then
                            u12:Disconnect();
                        end;
                    end);
                    u12 = RunService.Heartbeat:Connect(function(p13) -- Line: 135
                        -- upvalues: u11 (copy), u12 (ref), u7 (copy), Vector3_new_ret (ref), Character (copy), u10 (ref), math_clamp_ret (ref), u3 (ref)
                        if tick() > u11 + 0.4 then
                            if u12 then
                                u12:Disconnect();
                            end;

                            return;
                        end;

                        if u7.OnPlayer.Value then
                            if u12 then
                                u12:Disconnect();
                            end;

                            return;
                        end;

                        if u7 == nil then
                            if u12 then
                                u12:Disconnect();
                            end;

                            return;
                        end;

                        Vector3_new_ret = Vector3.new(Character.HumanoidRootPart.AssemblyLinearVelocity.X, 0, Character.HumanoidRootPart.AssemblyLinearVelocity.Z);

                        if tick() > u11 + 0.15 then
                            u10 = u10:Lerp((Character.HumanoidRootPart.Position - u7.Position).Unit + Vector3.new(0, 0.1, 0), 6.5 * p13);
                        else
                            u10 = u10:Lerp((Character.HumanoidRootPart.Position - u7.Position).Unit + Vector3.new(0, 0.25, 0), 6.5 * p13);
                        end;

                        math_clamp_ret = (Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 3.5;
                        math_clamp_ret = math.clamp(math_clamp_ret, 0, 220);

                        if math_clamp_ret <= 7 then
                            if u12 then
                                u12:Disconnect();
                            end;

                            return;
                        end;

                        u7.AssemblyLinearVelocity = u7.AssemblyLinearVelocity:Lerp(u10 * math_clamp_ret, 6.5 * p13);
                    end);
                end;
            end;

            return;
        end;

        u4 = true;

        if u5 then
            u5:Disconnect();
        end;

        local Shiftlock = u1.Camera.Shiftlock;
        u1.Camera:SetShiftlock(false);
        u1.Camera.Cutscene = true;
        u1.InAbility = true;
        u1.StatesController.States.Ability = true;
        u3.HumanoidRootPart.Anchored = true;
        local _ = u2.Character.Values.Diving.Value;
        u1.Animations:StopAnims();
        u1.Animations.Ball.BearClawBall.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Ball.BearClawBall:Play();
        u1.Animations.Abilities.BearClaw.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.BearClaw:Play();
        task.delay(5.683333396911621, function() -- Line: 96
            -- upvalues: u1 (ref), u3 (ref), Shiftlock (copy)
            u1.StatesController.States.Ability = false;
            u1.InAbility = false;
            u1.Camera.Cutscene = false;
            u1.Animations.Abilities.BearClaw:Stop(0);
            u3.HumanoidRootPart.Anchored = false;
            u1.Camera:SetShiftlock(Shiftlock);
        end);
    end);
end;