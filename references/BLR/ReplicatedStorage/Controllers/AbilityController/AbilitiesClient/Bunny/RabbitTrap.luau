  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Modules.getPlayerTarget);

return function(u1, u2, u3, ...) -- Line: 19
    -- upvalues: Popup (copy), AbilityBalancing (copy), ReplicatedStorage (copy), Essentials (copy), Players (copy), RunService (copy), AbilityUtils (copy)
    if u3.Values.HasBall.Value == false then
        Popup.Popup(u2, "You must have the ball");

        return;
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u3.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or u3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if u2.Character.IsRagdoll.Value then
        return;
    end;

    u1:AbilityCooldown("3", AbilityBalancing.RabbitTrap.Cooldown);
    local HumanoidRootPart = u3.HumanoidRootPart;
    u1.StatesController.States.Ability = true;
    u1.AbilityService.Ability:Fire("RabbitTrap", {
        State = "Start"
    });
    u1.Animations.Abilities.RabbitTrapStart.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.RabbitTrapStart:Play();
    task.wait(0.5);
    u1.Animations.Abilities.RabbitTrapLoop.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.RabbitTrapLoop.Looped = true;
    u1.Animations.Abilities.RabbitTrapLoop:Play();
    u1.Animations.Ball.RabbitTrapLoopBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.RabbitTrapLoopBall.Looped = true;
    u1.Animations.Ball.RabbitTrapLoopBall:Play();
    task.delay(AbilityBalancing.RabbitTrap.Duration, function() -- Line: 48
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;

        u1.Animations.Ball.RabbitTrapLoopBall:Stop();
        u1.Animations.Abilities.RabbitTrapLoop:Stop();
    end);
    local u4 = ReplicatedStorage.Assets.Misc.DiveHitbox:Clone();
    u4.Transparency = 1;
    u4.Parent = HumanoidRootPart.Parent;
    u4.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(u4, HumanoidRootPart);
    game.Debris:AddItem(u4, AbilityBalancing.RabbitTrap.Duration);
    u1.ABC:Add(function() -- Line: 62
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Connect(u4.Touched, function(p5) -- Line: 66
        -- upvalues: u2 (copy), Players (ref), u1 (copy), u4 (copy)
        if p5.Parent:FindFirstChild("Humanoid") and p5.Parent ~= u2.Character then
            local v6 = Players:FindFirstChild(p5.Parent.Name);

            if v6 and v6.Team == u2.Team then
                return;
            end;

            if p5.Parent.Values.Goalie.Value == true and p5.Parent.Values.IsInPenalty.Value == true then
                return;
            end;

            u1.AbilityService.Ability:Fire("RabbitTrap", {
                State = "Hit"
            });
            u4:Destroy();
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(u7, u8) -- Line: 81
        -- upvalues: u1 (copy), RunService (ref), ReplicatedStorage (ref), HumanoidRootPart (copy), AbilityUtils (ref), u3 (copy)
        if u7 then
            u7.AssemblyLinearVelocity = (game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.15, 0) + u8 / 2) * 180;
            task.delay(0.1, function() -- Line: 86
                -- upvalues: u1 (ref), RunService (ref), u7 (copy), u8 (copy)
                local u9 = -43;
                u1.ABC:Connect(RunService.Heartbeat, function(p10) -- Line: 89
                    -- upvalues: u9 (ref), u1 (ref), u7 (ref), u8 (ref)
                    u9 = u9 + 50 * p10;

                    if u9 >= -25 then
                        print("Ended");
                        u1.ABC:Clean();
                    end;

                    u7.AssemblyLinearVelocity = u7.AssemblyLinearVelocity:Lerp(u7.AssemblyLinearVelocity + u8 * u9, 8 * p10);
                end);
            end);
            u1.BallController:DragBall(ReplicatedStorage.Football.Value);
            task.wait(1);
            u1.ABC:Clean();

            return;
        end;

        u1.Animations.Ball.RabbitTrapLoopBall:Stop();
        u1.Animations.Abilities.RabbitTrapLoop:Stop();
        u1.Animations.Abilities.RabbitTrapShot.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.RabbitTrapShot:Play();
        AbilityUtils.FastDashTo(u3, HumanoidRootPart.Position + Vector3.new(0, 25, 0), 2, 0.66);
    end);
end;