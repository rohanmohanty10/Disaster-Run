  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local ZombieDribble = require(ReplicatedStorage.AbilityBalancing).ZombieDribble;

return function(u1, p2, p3) -- Line: 15, Name: ZombieDribble
    -- upvalues: ZombieDribble (copy), TweenService (copy), RunService (copy)
    if u1.AbilityOne > tick() then
        return;
    end;

    u1:AbilityCooldown("1", ZombieDribble.Cooldown);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.ZombieDribbleNew.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ZombieDribbleNew:Play();
    u1.Animations.Ball.ZombieDribbleBallNew.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.ZombieDribbleBallNew:Play();
    task.delay(0.9, function() -- Line: 29
        task.wait(0.2);
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
    BodyVelocity.MaxForce = Vector3.new(inf, 0, inf);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Parent = HumanoidRootPart;
    BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
    local Vector3Value = Instance.new("Vector3Value");
    Vector3Value.Parent = BodyVelocity;
    Vector3Value.Value = Vector3.new(0, 0, 0);
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    TweenService:Create(Vector3Value, TweenInfo.new(0.2), {
        Value = (LookVector + HumanoidRootPart.CFrame.RightVector) * 47
    }):Play();
    task.delay(0.3, function() -- Line: 67
        -- upvalues: LookVector (ref), HumanoidRootPart (copy), TweenService (ref), Vector3Value (copy)
        LookVector = HumanoidRootPart.CFrame.LookVector;
        TweenService:Create(Vector3Value, TweenInfo.new(0.2), {
            Value = (LookVector + -HumanoidRootPart.CFrame.RightVector) * 47
        }):Play();
        task.wait(0.5);
        LookVector = HumanoidRootPart.CFrame.LookVector;
        TweenService:Create(Vector3Value, TweenInfo.new(0.2), {
            Value = (LookVector + HumanoidRootPart.CFrame.RightVector) * 47
        }):Play();
        task.wait(0.5);
        LookVector = HumanoidRootPart.CFrame.LookVector;
        TweenService:Create(Vector3Value, TweenInfo.new(0.2), {
            Value = (LookVector + HumanoidRootPart.CFrame.RightVector:Lerp(-HumanoidRootPart.CFrame.LookVector, 0.6)) * 47
        }):Play();
    end);
    local u5 = RunService.RenderStepped:Connect(function() -- Line: 79
        -- upvalues: BodyVelocity (copy), Vector3Value (copy)
        BodyVelocity.Velocity = Vector3Value.Value;
    end);
    task.delay(2, function() -- Line: 83
        -- upvalues: u5 (ref), BodyVelocity (copy), BodyGyro (copy), u1 (copy)
        u5:Disconnect();
        BodyVelocity:Destroy();
        BodyGyro:Destroy();
        u1.StatesController.States.Ability = false;
        u1.Animations.Abilities.ZombieDribbleNew:Stop();
        u1.Animations.Ball.ZombieDribbleBallNew:Stop();
    end);
    u1.AbilityService.Ability:Fire("ZombieDribble");
end;