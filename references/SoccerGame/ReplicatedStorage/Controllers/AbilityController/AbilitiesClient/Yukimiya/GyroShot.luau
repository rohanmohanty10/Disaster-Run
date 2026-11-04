  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);

return function(u1, p2, p3) -- Line: 18, Name: GyroShot
    -- upvalues: Popup (copy), interface (copy), AbilityBalancing (copy), RunService (copy), ReplicatedStorage (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if not p3.Values.HasBall.Value then
        Popup.Popup(p2, "You must have the ball!");

        return;
    end;

    if p3.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or p3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if p2.Character.Values.Stunned.Value then
        return;
    end;

    interface.GyroShot = false;
    u1:AbilityCooldown("3", 50);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Ball.GyroShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.GyroShot:Play();
    u1.Animations.Abilities.GyroShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.GyroShot:Play();
    u1.AbilityService.Ability:Fire("GyroShot");
    local ShotPower = AbilityBalancing.GyroShot.ShotPower;
    u1.ABC:Connect(u1.AbilityService.Ability, function(u4, u5) -- Line: 46
        -- upvalues: u1 (copy), ShotPower (copy), RunService (ref), ReplicatedStorage (ref)
        u1.StatesController.States.Ability = false;
        u4.AssemblyLinearVelocity = (game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.2, 0) + u5 / 4) * ShotPower;
        task.delay(0.1, function() -- Line: 53
            -- upvalues: u1 (ref), RunService (ref), u4 (copy), u5 (copy)
            local u6 = -43;
            u1.ABC:Connect(RunService.Heartbeat, function(p7) -- Line: 56
                -- upvalues: u6 (ref), u1 (ref), u4 (ref), u5 (ref)
                u6 = u6 + 50 * p7;

                if u6 >= -30 then
                    print("Ended");
                    u1.ABC:Clean();
                end;

                u4.AssemblyLinearVelocity = u4.AssemblyLinearVelocity:Lerp(u4.AssemblyLinearVelocity + u5 * u6, 8 * p7);
            end);
        end);
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    task.delay(2.5, function() -- Line: 68
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;

        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;