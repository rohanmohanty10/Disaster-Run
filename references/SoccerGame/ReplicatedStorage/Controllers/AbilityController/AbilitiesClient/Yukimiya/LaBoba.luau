  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);

local function Lerp(p1, p2, p3) -- Line: 16
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 20
    local v8 = p4 + (p5 - p4) * p7;

    return v8 + (p5 + (p6 - p5) * p7 - v8) * p7;
end;

return function(u9, p10, p11) -- Line: 28
    -- upvalues: Popup (copy), AbilityBalancing (copy), AbilityUtils (copy)
    if u9.AbilityOne > tick() then
        return;
    end;

    if u9.AbilityUsed > tick() then
        return;
    end;

    if not p11.Values.HasBall.Value then
        Popup.Popup(p10, "You must have the ball!");

        return;
    end;

    if p11.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or p11.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if p10.Character.IsRagdoll.Value then
        return;
    end;

    if p10.Character.Values.Stunned.Value then
        return;
    end;

    u9.StatesController.States.Ability = true;
    u9.StatesController.OwnWalkState = true;
    u9.Animations.Abilities.LaBoba.Priority = Enum.AnimationPriority.Action4;
    u9.Animations.Abilities.LaBoba:Play();
    u9.Animations.Ball.LaBobaBall.Priority = Enum.AnimationPriority.Action4;
    u9.Animations.Ball.LaBobaBall:Play();
    u9:AbilityCooldown("1", 30);
    local HumanoidRootPart = p11.HumanoidRootPart;
    u9.AbilityService.Ability:Fire("LaBoba");
    task.wait(0.1);
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local TravelDistance = AbilityBalancing.LaBoba.TravelDistance;
    AbilityUtils.FastDashTo(p11, HumanoidRootPart.Position + LookVector * -AbilityBalancing.LaBoba.FeintDistance, 2, 0.3);
    task.wait(0.44999999999999996);
    AbilityUtils.FastDashTo(p11, HumanoidRootPart.Position + LookVector * TravelDistance, 2, 0.45);
    task.wait(0.45);
    u9.ABC:Add(function() -- Line: 72
        -- upvalues: u9 (copy)
        u9.StatesController.OwnWalkState = false;
        u9.StatesController.States.Ability = false;
    end);
    u9.ABC:Clean();
end;