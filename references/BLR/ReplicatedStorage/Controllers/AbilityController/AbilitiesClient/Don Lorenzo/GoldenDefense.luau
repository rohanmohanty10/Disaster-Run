  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local GoldenDefense = require(ReplicatedStorage.AbilityBalancing).GoldenDefense;

return function(u1, p2, p3) -- Line: 16, Name: GoldenDefense
    -- upvalues: Popup (copy), GoldenDefense (copy), TweenService (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if p3.Values.HasBall.Value then
        Popup.Popup(p2, "Ball must be free");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Humanoid = p3:FindFirstChild("Humanoid");
    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");

    if not (Humanoid and HumanoidRootPart) then
        return;
    end;

    local v4 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);
    local Unit = Humanoid.MoveDirection.Unit;
    print(v4);

    if v4 == Vector3.new(0, 0, 0) then
        Unit = HumanoidRootPart.CFrame.LookVector;
        v4 = Vector3.new(0, 0, -1);
    end;

    local v5 = v4.X > 0.1 and "R" or (v4.X < -0.1 and "L" or 0);
    u1:AbilityCooldown("3", GoldenDefense.Cooldown);
    local GoldenDefenseNew = u1.Animations.Abilities.GoldenDefenseNew;
    local GoldenDefenseNew2 = u1.Animations.Abilities.GoldenDefenseNew;
    GoldenDefenseNew.Looped = false;
    GoldenDefenseNew.Priority = Enum.AnimationPriority.Action2;
    GoldenDefenseNew:Play();
    GoldenDefenseNew2.Looped = false;
    GoldenDefenseNew2.Priority = Enum.AnimationPriority.Action3;
    u1.AbilityService.Ability:Fire("GoldenDefense", v5 == 0 and "R" or v5);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(15000, 0, 15000);
    BodyVelocity.Velocity = Unit * GoldenDefense.MoveSpeedValue;
    BodyVelocity.Parent = p3.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.5), {
        Velocity = BodyVelocity.Velocity * 0.1
    }):Play();
    u1.ABC:Add(BodyVelocity);
    task.delay(0.5, BodyVelocity.Destroy, BodyVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.MaxTorque = Vector3.new(0, 1000000000, 0);
    BodyGyro.CFrame = CFrame.lookAlong(Vector3.new(0, 0, 0), HumanoidRootPart.CFrame.LookVector);
    BodyVelocity.Parent = p3.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.5), {
        Velocity = BodyVelocity.Velocity * 0.5
    }):Play();
    u1.ABC:Add(BodyVelocity);
    task.delay(0.5, BodyVelocity.Destroy, BodyVelocity);
    local u6 = false;
    task.delay(0.6, function() -- Line: 83
        -- upvalues: u6 (ref), GoldenDefenseNew (copy), u1 (copy)
        if not u6 then
            GoldenDefenseNew:Stop();
            u1.ABC:Clean();
            u1.StatesController.States.Ability = false;
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p7, p8) -- Line: 87
        -- upvalues: GoldenDefenseNew (copy), u6 (ref), GoldenDefenseNew2 (copy), u1 (copy)
        GoldenDefenseNew:Stop(0);
        u6 = true;
        GoldenDefenseNew2:Play();
        p7.AssemblyLinearVelocity = p8;
        u1.BallController:DragBall(p7);
    end);
    task.delay(2.3, function() -- Line: 95
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
            u1.StatesController.States.Ability = false;
        end;
    end);
end;