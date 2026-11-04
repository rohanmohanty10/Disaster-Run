  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Modules.getPlayerTarget);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
require(ReplicatedStorage2.Shared.Spring);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

local function ClampMagnitude(p1, p2) -- Line: 29
    return p1.Magnitude == 0 and Vector3.new(0, 0, 0) or p1.Unit * math.min(p1.Magnitude, p2);
end;

return function() -- Line: 34
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy), TweenService (copy), RunService (copy)
    local _ = AbilityBalancing.DemonicRush;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local ABC = interface.ABC;
    local Character, _, _, _ = AbilityUtils.getCharacter();
    StatesController.States.Ability = true;
    interface:AbilityCooldown(2, 1.7);
    interface.DragonHeader = true;
    task.delay(1.7, function() -- Line: 57
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
    task.delay(3, function() -- Line: 61
    end);
    local Track = AnimationController:GetTrack("Abilities", "DemonicRush");
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();

    for _, child in pairs(Character.HumanoidRootPart:GetChildren()) do
        if child:IsA("BodyVelocity") or child:IsA("BodyGyro") then
            child:Destroy();
        end;
    end;

    interface.AbilityService.Ability:Fire("DemonicRush");

    for _, child in pairs(Character.HumanoidRootPart:GetChildren()) do
        if child:IsA("BodyVelocity") or child:IsA("BodyGyro") then
            child:Destroy();
        end;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = Character.HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000);
    BodyVelocity.Velocity = Character.HumanoidRootPart.CFrame.LookVector * AbilityBalancing.DemonicRush.Speed;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 1;
    task.delay(0.6, function() -- Line: 91
        -- upvalues: TweenService (ref), NumberValue (copy)
        TweenService:Create(NumberValue, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0.2
        }):Play();
    end);
    task.delay(1, function() -- Line: 95
        -- upvalues: TweenService (ref), NumberValue (copy)
        TweenService:Create(NumberValue, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 1.1
        }):Play();
    end);
    task.delay(1.3, function() -- Line: 99
        -- upvalues: TweenService (ref), NumberValue (copy)
        TweenService:Create(NumberValue, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0.4
        }):Play();
    end);
    local u3 = nil;
    u3 = RunService.Heartbeat:Connect(function() -- Line: 103
        -- upvalues: Character (copy), BodyVelocity (copy), AbilityBalancing (ref), NumberValue (copy), u3 (ref), ABC (copy)
        if Character and (Character:FindFirstChild("HumanoidRootPart") and BodyVelocity) then
            BodyVelocity.Velocity = Character.HumanoidRootPart.CFrame.LookVector * AbilityBalancing.DemonicRush.Speed * NumberValue.Value;

            return;
        end;

        u3:Disconnect();
        NumberValue:Destroy();
        ABC:Clean();
    end);
    ABC:Add(BodyVelocity);
    ABC:Add(function() -- Line: 120
        -- upvalues: StatesController (ref), interface (ref)
        StatesController.States.Ability = false;
        task.delay(3, function() -- Line: 123
            -- upvalues: interface (ref)
            if interface.DragonHeader then
                interface.DragonHeader = false;
                interface:AbilityCooldown(2, 45);
            end;
        end);
    end);
end;