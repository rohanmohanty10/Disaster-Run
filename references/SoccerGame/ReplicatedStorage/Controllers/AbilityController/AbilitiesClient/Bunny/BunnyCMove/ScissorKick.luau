  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Popup);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.SoundManager);

return function(u1, p2, u3) -- Line: 15, Name: ScissorKick
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), ReplicatedStorage (copy)
    if u1.ABC then
        u1.ABC:Clean();
    end;

    local HumanoidRootPart = u3.HumanoidRootPart;
    u1:AbilityCooldown("1", AbilityBalancing.ScissorKick.Cooldown);
    u1.AbilityService.Ability:Fire("ScissorKick");
    u1.Animations:StopAnims();
    u1.StatesController.States.Ability = true;
    u1.Animations.Abilities.ScissorKick.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ScissorKick:Play();
    u1.Animations.Ball.ScissorKickBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.ScissorKickBall:Play();
    AbilityUtils.FastDashTo(u3, HumanoidRootPart.Position + Vector3.new(0, 25, 0), 2, 0.733);
    u1.ABC:Add(function() -- Line: 38
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    task.delay(1.5, function() -- Line: 42
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function() -- Line: 46
        -- upvalues: u1 (copy), ReplicatedStorage (ref), AbilityBalancing (ref), u3 (copy)
        u1.ABC:Clean();
        local LookVector = game.Workspace.CurrentCamera.CFrame.LookVector;
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        ReplicatedStorage.Football.Value.AssemblyLinearVelocity = LookVector * AbilityBalancing.ScissorKick.ShotPower;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u3.HumanoidRootPart.Anchored = false;
    end);
end;