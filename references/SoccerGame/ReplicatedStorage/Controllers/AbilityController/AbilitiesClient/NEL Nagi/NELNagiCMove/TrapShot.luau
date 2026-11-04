  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.AbilityUtils);

return function(u1, p2, p3) -- Line: 18
    -- upvalues: ReplicatedStorage (copy), Trove (copy), AbilityBalancing (copy)
    if u1.AbilityOne > tick() then
        return;
    end;

    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    if not p3.Values.HasBall.Value then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.InAbility = true;
    u1:AbilityCooldown("1", p2.PlayerStats.Flow.Value == "Singularity" and p2.PlayerStats.InFlow.Value and 32 or 40);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.TrapShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.TrapShot:Play();
    u1.Animations.Ball.TrapShotBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.TrapShotBall:Play();
    u1.AbilityService.Ability:Fire("TrapShot", "start");
    task.delay(0.75, function() -- Line: 41
        -- upvalues: u1 (copy)
        u1.AbilityService.Ability:Fire("TrapShot", "shoot");
    end);
    local u4 = Trove.new();
    u4:Add(u1.AbilityService.Ability:Connect(function(p5) -- Line: 46
        -- upvalues: AbilityBalancing (ref), u1 (copy), u4 (copy)
        p5.AssemblyLinearVelocity = workspace.CurrentCamera.CFrame.LookVector * AbilityBalancing.TrapShot.ShotPower + Vector3.new(0, AbilityBalancing.TrapShot.ShotHeight, 0);
        u1.BallController:DragBall(p5);

        if u1.ABC then
            u1.ABC:Clean();
        end;

        if u4 then
            u4:Clean();
        end;
    end));
    u1.ABC:Add(function() -- Line: 53
        -- upvalues: u1 (copy)
        warn("Yo");
        u1.InAbility = false;
    end);
end;