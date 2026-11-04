  

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
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, p3) -- Line: 14, Name: ContrarianDefense
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy)
    if u1.ABC then
        u1.ABC:Clean();
    end;

    p3:FindFirstChild("Humanoid");
    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");
    u1.StatesController.States.Ability = true;
    u1.ABC:Add(function() -- Line: 21
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.Animations.Abilities.ContrarianDefense.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ContrarianDefense:Play();
    local _ = HumanoidRootPart.CFrame.LookVector;
    u1:AbilityCooldown("3", AbilityBalancing.ContrarianDefense.Cooldown);
    u1.AbilityService.Ability:Fire("ContrarianDefense");
    local v4 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -AbilityBalancing.ContrarianDefense.TravelDistance);
    AbilityUtils.FastDashTo(p3, v4.Position, -2, 0.6);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5, p6) -- Line: 38
        -- upvalues: u1 (copy)
        p5.AssemblyLinearVelocity = p6;
        u1.BallController:DragBall(p5);
    end);
    task.delay(1.4, function() -- Line: 43
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;