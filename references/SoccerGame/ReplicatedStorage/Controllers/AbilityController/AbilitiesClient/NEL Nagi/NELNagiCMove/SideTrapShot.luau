  

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
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);

return function(u1, p2, u3) -- Line: 18
    -- upvalues: ReplicatedStorage (copy), AbilityBalancing (copy), AbilityUtils (copy)
    if u1.AbilityOne > tick() then
        return;
    end;

    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    if not u3.Values.HasBall.Value then
        return;
    end;

    u1.InAbility = true;
    u1:AbilityCooldown("1", p2.PlayerStats.Flow.Value == "Singularity" and p2.PlayerStats.InFlow.Value and 32 or 40);
    u1.Animations:StopAnims();
    local v4 = u3.HumanoidRootPart.CFrame:VectorToObjectSpace(u3.Humanoid.MoveDirection).X < 0 and "Left" or "Right";
    local u5;

    if v4 == "Right" then
        u5 = u3.HumanoidRootPart.CFrame.RightVector;
    else
        u5 = -u3.HumanoidRootPart.CFrame.RightVector;
    end;

    local v6 = v4 == "Left" and u1.Animations.Abilities.SideTrapShotLeft or u1.Animations.Abilities.SideTrapShotRight;
    v6.Priority = Enum.AnimationPriority.Action4;
    v6:Play();
    v6:AdjustSpeed(1.5);
    local v7 = v4 == "Left" and u1.Animations.Ball.SideTrapShotBallLeft or u1.Animations.Ball.SideTrapShotBallLeft;
    v7.Priority = Enum.AnimationPriority.Action4;
    v7:Play();
    v7:AdjustSpeed(1.5);
    u1.AbilityService.Ability:Fire("SideTrapShot", "start");
    task.delay(0.13333333333333333, function() -- Line: 58
        -- upvalues: u5 (ref), u3 (copy), AbilityBalancing (ref), AbilityUtils (ref), u1 (copy)
        local Unit = Vector3.new(u5.X, 0, u5.Z).Unit;
        AbilityUtils.FastDashTo(u3, u3.HumanoidRootPart.Position + Unit * AbilityBalancing.SideTrapShot.DashDistance, -2, 0.35);
        u1.AbilityService.Ability:Fire("SideTrapShot", "dash");
    end);
    task.delay(0.7999999999999999, function() -- Line: 69
        -- upvalues: u1 (copy)
        u1.AbilityService.Ability:Fire("SideTrapShot", "shoot");
    end);
    u1.ABC:Add(u1.AbilityService.Ability:Connect(function(p8) -- Line: 73
        -- upvalues: AbilityBalancing (ref), u1 (copy)
        p8.AssemblyLinearVelocity = workspace.CurrentCamera.CFrame.LookVector * AbilityBalancing.SideTrapShot.ShotPower + Vector3.new(0, AbilityBalancing.SideTrapShot.ShotHeight, 0);
        u1.BallController:DragBall(p8);

        if u1.ABC then
            u1.ABC:Clean();
        end;
    end));
    u1.ABC:Add(function() -- Line: 79
        -- upvalues: u1 (copy)
        print("Cleaned");
        u1.InAbility = false;
    end);
end;