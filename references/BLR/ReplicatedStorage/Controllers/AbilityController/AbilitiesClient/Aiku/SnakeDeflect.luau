  

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
require(ReplicatedStorage.Controllers.BallController);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 27, Name: SnakeInterception
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), AnimationController (copy), StatesController (copy), TweenService (copy)
    local NELSnakeInterception = AbilityBalancing.NELSnakeInterception;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    local Humanoid = Character:FindFirstChild("Humanoid");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not (Humanoid and HumanoidRootPart) then
        return;
    end;

    print("Here");
    local u2 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);
    local v3 = u2.X > 0.1 and u1.CFrame.RightVector or -u1.CFrame.RightVector;
    local u4 = u2.X > 0.1 and "Right" or "Left";
    interface:AbilityCooldown(2, NELSnakeInterception.Cooldown);
    local Track = AnimationController:GetTrack("Abilities", "SnakeDeflect" .. u4);
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    AnimationController:GetTrack("Abilities", "SnakeInterception");
    StatesController.States.Ability = true;
    interface.AbilityService.Ability:Fire("SnakeDeflect", u4);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(15000, 15000, 15000);
    BodyVelocity.Velocity = Vector3.new(0, 50, 0) + v3 * 75;
    BodyVelocity.Parent = Character.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.3), {
        Velocity = BodyVelocity.Velocity * 0.1
    }):Play();
    ABC:Add(BodyVelocity);
    task.delay(0.3, BodyVelocity.Destroy, BodyVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.MaxTorque = Vector3.new(0, 1000000000, 0);
    BodyGyro.CFrame = CFrame.lookAlong(Vector3.new(0, 0, 0), HumanoidRootPart.CFrame.LookVector);
    BodyVelocity.Parent = Character.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.3), {
        Velocity = BodyVelocity.Velocity * 0.5
    }):Play();
    ABC:Add(BodyVelocity);
    task.delay(0.3, BodyVelocity.Destroy, BodyVelocity);
    local u5 = false;
    ABC:Connect(interface.AbilityService.Ability, function(p6, p7) -- Line: 85
        -- upvalues: u5 (ref), AnimationController (ref), u4 (copy), u2 (copy), u1 (copy), Character (copy), TweenService (ref), ABC (copy)
        print("here");
        u5 = true;
        local Track2 = AnimationController:GetTrack("Abilities", "SnakeDeflect" .. u4 .. "Hit");
        Track2.Looped = false;
        Track2.Priority = Enum.AnimationPriority.Action3;
        Track2:Play();
        local BodyVelocity2 = Instance.new("BodyVelocity");
        BodyVelocity2.MaxForce = Vector3.new(15000, 15000, 15000);
        BodyVelocity2.Velocity = (u2 == "Right" and u1.CFrame.RightVector or -u1.CFrame.RightVector) * 90;
        BodyVelocity2.Parent = Character.PrimaryPart;
        TweenService:Create(BodyVelocity2, TweenInfo.new(0.5), {
            Velocity = BodyVelocity2.Velocity * 0.1
        }):Play();
        ABC:Add(BodyVelocity2);
        task.delay(0.5, BodyVelocity2.Destroy, BodyVelocity2);
    end);
    task.delay(1, function() -- Line: 103
        -- upvalues: ABC (copy), StatesController (ref)
        if ABC then
            ABC:Clean();
            StatesController.States.Ability = false;
        end;
    end);
end;