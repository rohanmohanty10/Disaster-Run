  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);

return function(u1, p2, p3) -- Line: 18
    -- upvalues: AbilityBalancing (copy), TweenService (copy), RunService (copy)
    if p3.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("2", AbilityBalancing.OcclusionBreak.Cooldown);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.OcclusionBreak1.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.OcclusionBreak1:Play();
    u1.ABC:Add(function() -- Line: 38
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v4 = HumanoidRootPart:FindFirstChildWhichIsA("BodyVelocity");

    if v4 then
        v4:Destroy();
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Parent = HumanoidRootPart;
    BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
    local Vector3Value = Instance.new("Vector3Value");
    Vector3Value.Parent = BodyVelocity;
    Vector3Value.Value = Vector3.new(0, 0, 0);
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    TweenService:Create(Vector3Value, TweenInfo.new(0.45), {
        Value = (LookVector + -HumanoidRootPart.CFrame.RightVector) * 55
    }):Play();
    task.delay(0.45, function() -- Line: 67
        -- upvalues: LookVector (ref), HumanoidRootPart (copy), TweenService (ref), Vector3Value (copy)
        LookVector = HumanoidRootPart.CFrame.LookVector;
        TweenService:Create(Vector3Value, TweenInfo.new(0.35), {
            Value = (LookVector + HumanoidRootPart.CFrame.RightVector) * 75
        }):Play();
        task.wait(0.5);
        LookVector = HumanoidRootPart.CFrame.LookVector;
        TweenService:Create(Vector3Value, TweenInfo.new(0.3), {
            Value = (LookVector + -HumanoidRootPart.CFrame.RightVector) * 45
        }):Play();
    end);
    local u5 = RunService.RenderStepped:Connect(function() -- Line: 76
        -- upvalues: BodyVelocity (copy), Vector3Value (copy)
        BodyVelocity.Velocity = Vector3Value.Value;
    end);
    task.delay(1.5, function() -- Line: 80
        -- upvalues: u5 (ref), BodyVelocity (copy), BodyGyro (copy), u1 (copy)
        u5:Disconnect();
        BodyVelocity:Destroy();
        BodyGyro:Destroy();
        u1.ABC:Clean();
    end);
    u1.AbilityService.Ability:Fire("OcclusionBreak");
end;