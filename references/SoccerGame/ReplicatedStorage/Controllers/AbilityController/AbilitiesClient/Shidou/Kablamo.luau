  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.AbilityUtils);

return function(u1, p2, p3) -- Line: 18
    -- upvalues: ReplicatedStorage (copy), AbilityBalancing (copy)
    if u1.AbilityOne > tick() then
        return;
    end;

    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    if not p3.Values.HasBall.Value then
        return;
    end;

    local State = p3.Humanoid:GetState();

    if State == Enum.HumanoidStateType.Freefall or State == Enum.HumanoidStateType.Jumping then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.StatesController.States.Ability = true;
    u1.ABC:Add(function() -- Line: 31
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1:AbilityCooldown("1", 50);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.ShidouKablamo.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ShidouKablamo:Play();
    u1.Animations.Ball.KablamoBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.KablamoBall:Play();
    u1.AbilityService.Ability:Fire("Kablamo", "start");
    u1.StatesController.SpeedMultiplier = 0.5;
    u1.ABC:Add(task.delay(2, function() -- Line: 48
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    task.delay(0.67, function() -- Line: 52
        -- upvalues: u1 (copy)
        u1.AbilityService.Ability:Fire("Kablamo", "shoot");
        u1.StatesController.SpeedMultiplier = 1;
    end);
    u1.ABC:Add(u1.AbilityService.Ability:Connect(function(p4) -- Line: 57
        -- upvalues: AbilityBalancing (ref), u1 (copy)
        p4.AssemblyLinearVelocity = workspace.CurrentCamera.CFrame.LookVector * AbilityBalancing.Kablamo.ShotPower + Vector3.new(0, AbilityBalancing.Kablamo.ShotHeight, 0);
        u1.BallController:DragBall(p4);

        if u1.ABC then
            u1.ABC:Clean();
        end;
    end));
end;