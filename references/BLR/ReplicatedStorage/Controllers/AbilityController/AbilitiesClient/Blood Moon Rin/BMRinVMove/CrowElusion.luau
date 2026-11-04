  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Popup);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(p1, p2, p3, p4) -- Line: 23
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), StatesController (copy), AnimationController (copy), TweenService (copy), RunService (copy)
    local CrowElusion = AbilityBalancing.CrowElusion;
    p1:AbilityCooldown(2, CrowElusion.Cooldown);
    local ABC = p1.ABC;
    local _, u5, _, _ = AbilityUtils.getCharacter();
    StatesController.States.Ability = true;
    p1.AbilityService.Ability:Fire("CrowElusion");
    local Track = AnimationController:GetTrack("Abilities", "CrowElusion");
    Track.Looped = true;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = u5;
    BodyVelocity.MaxForce = Vector3.new(inf, 0, inf);
    local Vector3Value = Instance.new("Vector3Value");
    Vector3Value.Parent = BodyVelocity;
    Vector3Value.Value = Vector3.new(0, 0, 0);
    ABC:Add(function() -- Line: 48
        -- upvalues: StatesController (ref), Track (copy)
        StatesController.States.Ability = false;
        Track:Stop();
    end);
    local TravelDistance = CrowElusion.TravelDistance;
    local CFrame_new_ret = CFrame.new(u5.Position, p4.HumanoidRootPart.Position);
    local LookVector = CFrame_new_ret.LookVector;
    local v6 = TweenService:Create(Vector3Value, TweenInfo.new(0.2), {
        Value = (LookVector + CFrame_new_ret.RightVector / 2) * TravelDistance
    });
    v6:Play();
    ABC:Add(v6);
    ABC:Add(Vector3Value);
    ABC:Add(BodyVelocity);
    ABC:Connect(RunService.Heartbeat, function() -- Line: 63
        -- upvalues: BodyVelocity (copy), Vector3Value (copy)
        BodyVelocity.Velocity = Vector3Value.Value;
    end);
    ABC:Add(task.delay(0.4, function() -- Line: 67
        -- upvalues: LookVector (ref), u5 (copy), TweenService (ref), Vector3Value (copy), CFrame_new_ret (copy), TravelDistance (copy), ABC (copy)
        LookVector = u5.CFrame.LookVector;
        local v7 = TweenService:Create(Vector3Value, TweenInfo.new(0.4), {
            Value = (LookVector + -(CFrame_new_ret.RightVector / 2)) * TravelDistance
        });
        v7:Play();
        ABC:Add(v7);
    end));
    task.delay(0.8, function() -- Line: 74
        -- upvalues: Track (copy), ABC (copy)
        Track:Stop();
        ABC:Clean();
    end);
end;