  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local DemonicOverheadKick = require(ReplicatedStorage.AbilityBalancing).DemonicOverheadKick;

return function(u1, p2, u3) -- Line: 16, Name: DemonicOverheadKick
    -- upvalues: DemonicOverheadKick (copy), AbilityUtils (copy), ReplicatedStorage (copy)
    if u1.ABC then
        u1.ABC:Clean();
    end;

    local HumanoidRootPart = u3.HumanoidRootPart;
    u1:AbilityCooldown("2", DemonicOverheadKick.Cooldown);
    u1.AbilityService.Ability:Fire("DemonicOverheadKick");
    u1.Animations:StopAnims();
    u1.StatesController.States.Ability = true;
    u1.Animations.Abilities.DemonicOverheadKick.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.DemonicOverheadKick:Play();
    u1.Animations.Ball.DemonicOverheadKickBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.DemonicOverheadKickBall:Play();
    task.wait(0.28);
    AbilityUtils.FastDashTo(u3, HumanoidRootPart.Position + Vector3.new(0, 10, 0), 2, DemonicOverheadKick.MoveSpeedDuration);
    u1.ABC:Add(function() -- Line: 41
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    task.delay(1.2, function() -- Line: 45
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function() -- Line: 49
        -- upvalues: u1 (copy), DemonicOverheadKick (ref), ReplicatedStorage (ref), u3 (copy)
        u1.ABC:Clean();
        local v4 = game.Workspace.CurrentCamera.CFrame.LookVector + DemonicOverheadKick.ShotTiltVector;
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        ReplicatedStorage.Football.Value.AssemblyLinearVelocity = v4 * DemonicOverheadKick.ShotPower;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u3.HumanoidRootPart.Anchored = false;
    end);
end;