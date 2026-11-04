  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local ZombieDash = require(ReplicatedStorage.AbilityBalancing).ZombieDash;
local ZombieDashOff = require(ReplicatedStorage.AbilityBalancing).ZombieDashOff;

return function(u1, p2, u3) -- Line: 18, Name: ZombieDash
    -- upvalues: ZombieDash (copy), Debris (copy), TweenService (copy), ZombieDashOff (copy)
    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        return;
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("1", ZombieDash.Cooldown);
    local _ = u1.BallController.Closest;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.UndeadWalk.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.UndeadWalk:Play();
    u1.Animations.Ball.ZombieDashBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.ZombieDashBall:Play();
    u1.AbilityService.Ability:Fire("ZombieDash");

    for _, descendant in u3.HumanoidRootPart:GetDescendants() do
        if descendant:IsA("BodyMover") then
            descendant:Destroy();
        end;
    end;

    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    local u4 = false;
    u1.ABC:Connect(u3.Values.HasBall:GetPropertyChangedSignal("Value"), function() -- Line: 52
        -- upvalues: u3 (copy), u1 (copy)
        print("Hit");

        if u3.Values.HasBall.Value then
            u1.Animations.Abilities.UndeadWalk:Stop();
            u1.Animations.Abilities.UndeadWalkHit.Priority = Enum.AnimationPriority.Action4;
            u1.Animations.Abilities.UndeadWalkHit:Play();
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5, p6) -- Line: 62
        -- upvalues: u3 (copy), ZombieDash (ref), u1 (copy), Debris (ref), TweenService (ref), ZombieDashOff (ref)
        if p6 then
            p5.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + ZombieDash.ShotTiltVector) * ZombieDash.ShotPower;
            u1.BallController:DragBall(p5);
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Parent = u3.HumanoidRootPart;
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        Debris:AddItem(BodyVelocity, ZombieDash.MoveSpeedDuration);
        TweenService:Create(BodyVelocity, TweenInfo.new(0.6), {
            MaxForce = Vector3.new(1000, 0, 1000)
        }):Play();
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Parent = u3.HumanoidRootPart;
        BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
        Debris:AddItem(BodyGyro, 0.45);

        if p6 then
            BodyVelocity.Velocity = u3.HumanoidRootPart.CFrame.LookVector * ZombieDash.MoveSpeedValue;
        else
            BodyVelocity.Velocity = u3.HumanoidRootPart.CFrame.LookVector * ZombieDashOff.MoveSpeedValue;
        end;

        task.delay(0.6, function() -- Line: 91
            -- upvalues: u1 (ref)
            u1.StatesController.States.Ability = false;
            u1.StatesController.OwnWalkState = false;
            u1.ABC:Clean();
        end);
    end);
    task.delay(2, function() -- Line: 100
        -- upvalues: u4 (ref), u1 (copy)
        if not u4 then
            u1.ABC:Clean();
        end;
    end);
    u1.ABC:Add(function() -- Line: 106
        -- upvalues: u4 (ref), u1 (copy)
        u4 = true;
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
    end);
end;