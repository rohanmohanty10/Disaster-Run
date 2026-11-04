  

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
local MaliciaAir = require(ReplicatedStorage.AbilityBalancing).MaliciaAir;

return function(u1, p2, p3) -- Line: 16, Name: AirMove
    -- upvalues: Popup (copy), MaliciaAir (copy), TweenService (copy)
    if u1.AbilityOne > tick() then
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

    if v4 == Vector3.new(0, 0, 0) then
        Popup.Popup(p2, "Must be moving!");

        return;
    end;

    local _ = (v4.X > 0.1 and "R" or (v4.X < -0.1 and "L" or 0)) == 0;
    u1:AbilityCooldown("1", 30);
    u1.AbilityService.Ability:Fire("Malicia", {
        Type = "Air"
    });
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(1000000000, 0, 1000000000);
    BodyVelocity.Velocity = Humanoid.MoveDirection.Unit * MaliciaAir.MoveSpeedValue;
    BodyVelocity.Parent = p3.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.5), {
        Velocity = BodyVelocity.Velocity * 0.1
    }):Play();
    u1.ABC:Add(BodyVelocity);
    task.delay(MaliciaAir.MoveSpeedDuration, BodyVelocity.Destroy, BodyVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.MaxTorque = Vector3.new(0, 1000000000, 0);
    BodyGyro.CFrame = CFrame.lookAlong(Vector3.new(0, 0, 0), HumanoidRootPart.CFrame.LookVector);
    BodyVelocity.Parent = p3.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.5), {
        Velocity = BodyVelocity.Velocity * 0.5
    }):Play();
    u1.ABC:Add(BodyVelocity);
    task.delay(MaliciaAir.MoveSpeedDuration, BodyVelocity.Destroy, BodyVelocity);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5, p6) -- Line: 64
        -- upvalues: u1 (copy)
        u1.Animations:StopAnims();
        u1.Animations.Abilities.IgaguriAirMalicia.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.IgaguriAirMalicia:Play();
        p5.AssemblyLinearVelocity = p6;
        u1.BallController:DragBall(p5);
    end);
    task.delay(2.3, function() -- Line: 73
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
            u1.StatesController.States.Ability = false;
        end;
    end);
end;