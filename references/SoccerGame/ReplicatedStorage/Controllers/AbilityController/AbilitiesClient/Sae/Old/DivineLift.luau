  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, u3) -- Line: 18, Name: HeelFlick
    -- upvalues: Debris (copy), AbilityBalancing (copy), AbilityUtils (copy)
    u3:SetAttribute("DivineLift", nil);
    u1:AbilityCooldown("2", 40);
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.DivineLift.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.DivineLift:Play();
    u1.Animations.Ball.DivineLiftBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.DivineLiftBall:Play();
    u1.AbilityService.Ability:Fire("DivineLift");
    u1.ABC:Connect(u1.AbilityService.Ability, function(p4) -- Line: 35
        -- upvalues: u1 (copy), u3 (copy), Debris (ref), AbilityBalancing (ref), AbilityUtils (ref)
        u1.ABC:Clean();
        print("Fired");
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        p4.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.75, 0)) * 65;
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Parent = u3.HumanoidRootPart;
        BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
        Debris:AddItem(BodyGyro, 0.45);
        local LookVector = u3.HumanoidRootPart.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        AbilityUtils.FastDashTo(u3, u3.HumanoidRootPart.Position + Unit * AbilityBalancing.DivineLift.TravelDistance, -2, 0.45);
        u1.Animations:StopAnims();
        u1.Animations.Abilities.Steal.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.Steal:Play();
        u1.BallController:DragBall(p4);
    end);
    task.delay(2, function() -- Line: 62
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        warn("SET OWN WALK STATE TO FALSE");
    end);
end;