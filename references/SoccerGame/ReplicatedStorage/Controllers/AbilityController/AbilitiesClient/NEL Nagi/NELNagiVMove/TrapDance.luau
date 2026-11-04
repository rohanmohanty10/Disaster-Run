  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);

return function(u1, u2, u3, p4) -- Line: 16
    -- upvalues: AbilityBalancing (copy), Popup (copy), RunService (copy), AbilityUtils (copy), ReplicatedStorage (copy)
    local HumanoidRootPart = u3.HumanoidRootPart;
    u1.StatesController.States.Ability = true;

    if p4 == "Volley" then
        u1.ABC:Add(function() -- Line: 21
            -- upvalues: u1 (copy)
            u1.StatesController.States.Ability = false;
        end);
        u3:SetAttribute("TrapVolley", nil);
        u1.Animations.Abilities.TrapDanceShot.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.TrapDanceShot:Play();
        u1.Animations.Ball.TrapDanceShotBall.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Ball.TrapDanceShotBall:Play();
        u1.AbilityService.Ability:Fire("TrapDance", {
            Type = "Volley"
        });
        u1.ABC:Add(u1.AbilityService.Ability:Connect(function(p5) -- Line: 35
            -- upvalues: AbilityBalancing (ref), u1 (copy)
            p5.AssemblyLinearVelocity = workspace.CurrentCamera.CFrame.LookVector * AbilityBalancing.TrapDance.ShotPower + AbilityBalancing.TrapDance.ShotTiltVector;
            u1.BallController:DragBall(p5);

            if u1.ABC then
                u1.ABC:Clean();
            end;
        end));
        task.delay(1.5, function() -- Line: 41
            -- upvalues: u1 (copy)
            u1.ABC:Clean();
        end);

        return;
    end;

    local Football = workspace:FindFirstChild("Football");

    if not Football then
        Popup.Popup(u2, "Ball must be loose");

        return;
    end;

    local os_clock_ret = os.clock();
    u1.Animations.Abilities.TrapDance.Priority = Enum.AnimationPriority.Action3;
    u1.Animations.Abilities.TrapDance:Play();
    local u6 = nil;
    u6 = RunService.Heartbeat:Connect(function() -- Line: 55
        -- upvalues: u3 (copy), u6 (ref), u1 (copy)
        if u3.Values.HasBall.Value then
            u6:Disconnect();
            u1.Animations.Ball.TrapDanceBall.Priority = Enum.AnimationPriority.Action3;
            u1.Animations.Ball.TrapDanceBall.TimePosition = u1.Animations.Abilities.TrapDance.TimePosition;
            u1.Animations.Ball.TrapDanceBall:Play();
        end;
    end);
    u1.ABC:Add(function() -- Line: 64
        -- upvalues: u6 (ref), u1 (copy)
        u6:Disconnect();
        u1.StatesController.States.Ability = false;
    end);
    task.delay(2.5, function() -- Line: 69
        -- upvalues: u1 (copy)
        print("Cleaning");

        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
    u1.AbilityService.Ability:Fire("TrapDance", {
        Type = "Steal"
    });
    AbilityUtils.FastDashTo(u3, Football.Position + Vector3.new(0, 2, 0), 2, 0.55);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p7, p8) -- Line: 79
        -- upvalues: os_clock_ret (copy), u3 (copy), AbilityBalancing (ref), HumanoidRootPart (copy), AbilityUtils (ref), u2 (copy), u1 (copy), Football (ref), RunService (ref), ReplicatedStorage (ref)
        print(p7);

        if p7 == "Success" then
            local v9 = 0.8 - (os.clock() - os_clock_ret);
            u3:SetAttribute("TrapVolley", true);
            task.wait(v9);
            local CFrame = HumanoidRootPart.CFrame;
            AbilityUtils.FastDashTo(u3, CFrame.Position + CFrame.LookVector * AbilityBalancing.TrapDance.TravelDistance, 2, 0.6);
            local v10 = u2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("2");

            if v10 then
                local UIScale = v10:FindFirstChild("UIScale");
                UIScale.Scale = 1.25;
                v10.ImageColor3 = Color3.fromRGB(26, 255, 53);
                u1.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Scale = 1
                });
                u1.UITween1:Play();
                u1.UITween2 = game:GetService("TweenService"):Create(v10, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageColor3 = Color3.fromRGB(255, 255, 255)
                });
                u1.UITween2:Play();
                task.wait(0.35);
                u1.StatesController.States.Ability = false;
                task.wait(0.65);
                u1.UITween2 = nil;
                u1.UITween1 = nil;
                u1:AbilityCooldown("2", 40);

                if u3:GetAttribute("TrapVolley") then
                    u3:SetAttribute("TrapVolley", nil);

                    if not u3.Values.HasBall.Value or (u3.Values.Dribbling.Value or (u2.Character.IsRagdoll.Value or u1.StatesController.States.Ability)) then
                        return;
                    end;

                    local Closest = u1.BallController.Closest;
                    u1.StatesController.States.Ability = true;
                    u1.Animations.Abilities.TrapDancePass.Priority = Enum.AnimationPriority.Action4;
                    u1.Animations.Abilities.TrapDancePass:Play();
                    u1.Animations.Ball.TrapDancePassBall.Priority = Enum.AnimationPriority.Action4;
                    u1.Animations.Ball.TrapDancePassBall:Play();
                    task.wait(0.4);
                    u1.AbilityService.Ability:Fire("TrapDance", {
                        Type = "BackPass",
                        target = Closest
                    });
                    task.wait(0.2);
                    u1.StatesController.States.Ability = false;
                end;
            end;
        elseif p7 == "BackPass" then
            Football = p8;
            local Closest = u1.BallController.Closest;

            if Closest then
                local Vector3_new_ret = Vector3.new(Closest.HumanoidRootPart.AssemblyLinearVelocity.X, 0, Closest.HumanoidRootPart.AssemblyLinearVelocity.Z);
                local u11 = (Closest.HumanoidRootPart.Position + Vector3_new_ret - u3.HumanoidRootPart.Position).Unit + Vector3.new(0, 0.05, 0);
                Football.AssemblyLinearVelocity = u11 * math.clamp((Closest.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
                u1.BallController:DragBall(Football);
                local u12 = tick();
                local v13 = workspace:GetRealPhysicsFPS() / 60;
                local math_clamp_ret = math.clamp(v13, 1, 4);
                print("Here");
                u1.ABC:Connect(RunService.Heartbeat, function(p14) -- Line: 168
                    -- upvalues: u12 (copy), math_clamp_ret (ref), u1 (ref), Football (ref), u11 (ref), Closest (copy), u3 (ref)
                    if tick() > u12 + 0.4 * math_clamp_ret then
                        u1.ABC:Clean();
                        print("ended");

                        return;
                    end;

                    if Football.OnPlayer.Value or not Football then
                        u1.ABC:Clean();
                        print("ended");

                        return;
                    end;

                    local v15 = 1 - math.exp(-6.5 * p14);
                    local v16 = tick() > u12 + 0.15 * math_clamp_ret and Vector3.new(0, 0.1, 0) or Vector3.new(0, 0.25, 0);
                    u11 = u11:Lerp((Closest.HumanoidRootPart.Position - Football.Position).Unit + v16, v15);
                    local math_clamp_ret2 = math.clamp((Closest.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 3.5, 0, 220);

                    if math_clamp_ret2 > 7 then
                        Football.AssemblyLinearVelocity = Football.AssemblyLinearVelocity:Lerp(u11 * math_clamp_ret2, v15);

                        return;
                    end;

                    u1.ABC:Clean();
                    print("ended");
                end);

                return;
            end;

            local Shiftlock = u1.Camera.Shiftlock;
            print("Received");
            u1.StatesController.States.Ability = false;
            u1.InAbility = false;
            u1.Camera.Cutscene = false;
            ReplicatedStorage.Football.Value.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.18, 0)) * -120;
            u1.BallController:DragBall(ReplicatedStorage.Football.Value);
            u3.HumanoidRootPart.Anchored = false;
            u1.Camera:SetShiftlock(Shiftlock);
            u1.ABC:Clean();
        end;
    end);
end;