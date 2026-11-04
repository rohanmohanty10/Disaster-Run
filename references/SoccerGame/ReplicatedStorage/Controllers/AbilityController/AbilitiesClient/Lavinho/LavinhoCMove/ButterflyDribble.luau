  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Popup);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local ButterflyDribble = require(ReplicatedStorage.AbilityBalancing).ButterflyDribble;
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Modules.getPlayerTarget);

return function(u1, p2, p3) -- Line: 16, Name: ButterflyDribble
    -- upvalues: ButterflyDribble (copy), AbilityUtils (copy)
    local HumanoidRootPart = p2.Character.HumanoidRootPart;
    local _ = p3.Humanoid.MoveDirection.Unit;
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.ABC:Add(function() -- Line: 23
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
    end);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.ButterflyDribble.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ButterflyDribble:Play();
    u1.Animations.Ball.ButterflyDribbleBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.ButterflyDribbleBall:Play();
    task.wait(0.7);
    local LookVector = (HumanoidRootPart.CFrame * CFrame.Angles(0, 0.7853981633974483, 0)).LookVector;
    local TravelDistance = ButterflyDribble.TravelDistance;
    local v4 = HumanoidRootPart.Position + LookVector * TravelDistance;
    u1.AbilityService.Ability:Fire("ButterflyDribble");
    AbilityUtils.FastDashTo(p3, v4, 2, 0.95);
    task.wait(0.95);
    local LookVector2 = (HumanoidRootPart.CFrame * CFrame.Angles(0, -0.7853981633974483, 0)).LookVector;
    AbilityUtils.FastDashTo(p3, HumanoidRootPart.Position + LookVector2 * TravelDistance, 2, 0.55);
    task.wait(0.55);
    u1.ABC:Clean();
end;