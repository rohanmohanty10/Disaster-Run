  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Modules.getPlayerTarget);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local BallController = require(ReplicatedStorage.Controllers.BallController);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 27, Name: SnakeInterception
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy), TweenService (copy), BallController (copy)
    local NELSnakeInterception = AbilityBalancing.NELSnakeInterception;

    if not (AbilityUtils.rules.offball() and AbilityUtils.rules.slotReady(1)) then
        return;
    end;

    local Character, _, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    local Humanoid = Character:FindFirstChild("Humanoid");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not (Humanoid and HumanoidRootPart) then
        return;
    end;

    StatesController.States.Ability = true;
    HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);
    local Unit = (HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 3, 0)).Unit;
    interface:AbilityCooldown(1, NELSnakeInterception.Cooldown);
    local Track = AnimationController:GetTrack("Abilities", "NELSnakeInterception");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    AnimationController:GetTrack("Abilities", "SnakeInterception");
    interface.AbilityService.Ability:Fire("NELSnakeInterception");
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(15000, 15000, 15000);
    BodyVelocity.Velocity = Unit * NELSnakeInterception.MoveSpeedValue;
    BodyVelocity.Parent = Character.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.5), {
        Velocity = BodyVelocity.Velocity * 0.1
    }):Play();
    ABC:Add(BodyVelocity);
    task.delay(0.5, BodyVelocity.Destroy, BodyVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.MaxTorque = Vector3.new(0, 1000000000, 0);
    BodyGyro.CFrame = CFrame.lookAlong(Vector3.new(0, 0, 0), HumanoidRootPart.CFrame.LookVector);
    BodyVelocity.Parent = Character.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.5), {
        Velocity = BodyVelocity.Velocity * 0.5
    }):Play();
    ABC:Add(BodyVelocity);
    task.delay(0.5, BodyVelocity.Destroy, BodyVelocity);
    local u1 = false;
    ABC:Connect(interface.AbilityService.Ability, function(p2, p3) -- Line: 85
        -- upvalues: u1 (ref), BallController (ref)
        print("here");
        u1 = true;
        p2.AssemblyLinearVelocity = p3;
        BallController:DragBall(p2);
    end);
    task.delay(1, function() -- Line: 94
        -- upvalues: ABC (copy), StatesController (ref)
        if ABC then
            ABC:Clean();
            StatesController.States.Ability = false;
        end;
    end);
end;