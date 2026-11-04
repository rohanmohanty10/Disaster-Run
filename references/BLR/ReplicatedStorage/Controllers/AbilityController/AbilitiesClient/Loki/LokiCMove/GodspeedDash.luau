  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);

return function(u1, p2, u3) -- Line: 16
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy)
    if p2.Character.Values.HasBall.Value or (p2.Character.Values.Dribbling.Value or p2.Character.Values.Sliding.Value) then
        return;
    end;

    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.StatesController.SpeedBoost = 10;
    u1.ABC:Add(function() -- Line: 24
        -- upvalues: u1 (copy)
        u1.StatesController.OwnWalkState = false;
        u1.StatesController.States.Ability = false;
        u1.StatesController.SpeedBoost = 0;
    end);
    u1.ABC:Add(task.delay(3, function() -- Line: 29
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.Animations:StopAnims();
    u1.Animations.Abilities.GodspeedDash.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.GodspeedDash:Play();
    u1.AbilityService.Ability:Fire("GodspeedDash", {
        Type = "Start",
        StartCF = u3.HumanoidRootPart.CFrame
    });

    for _, descendant in u3.HumanoidRootPart:GetDescendants() do
        if descendant:IsA("BodyVelocity") then
            descendant:Destroy();
        end;
    end;

    u1.ABC:Connect(u1.AbilityService.Ability, function(p4, p5, p6) -- Line: 44
        -- upvalues: u1 (copy), u3 (copy)
        if p4 == "Kick" then
            u1.ABC:Clean();
            p5.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.2, 0)) * 120;
            u1.BallController:DragBall(p5);
        end;
    end);

    if not u1.GearShift then
        task.wait(0.2);
    end;

    u1.AbilityService.Ability:Fire("GodspeedDash", {
        Type = "Dash",
        StartCF = u3.HumanoidRootPart.CFrame
    });
    local HumanoidRootPart = u3.HumanoidRootPart;
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    AbilityUtils.FastDashTo(u3, HumanoidRootPart.Position + Unit * AbilityBalancing.GodspeedDash.Range, -2, 0.2);
    task.wait(0.25);
    u1.ABC:Clean();
end;