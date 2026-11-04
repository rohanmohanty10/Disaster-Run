  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);

return function(u1, p2, u3) -- Line: 17, Name: NELDash
    -- upvalues: AbilityUtils (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    print("Offensive dash");
    u1.StatesController.States.Ability = true;
    u1.StatesController.States.OwnWalkState = true;
    local Humanoid = u3:FindFirstChild("Humanoid");
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v4 = u3:GetAttribute("RageBar") or 0;
    u1:AbilityCooldown("3", 25);

    if Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.RightVector) <= 0.95 and (Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.RightVector) >= -0.95 and (Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.LookVector) >= -0.35 or Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.RightVector) <= -0.95)) then
        local _ = Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.LookVector) > 0.35 and Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.RightVector) > -0.95;
    end;

    local MoveDirection = Humanoid.MoveDirection;

    if MoveDirection.Magnitude <= 0.1 then
        MoveDirection = u3.HumanoidRootPart.CFrame.LookVector;
    end;

    u1.Animations.Abilities.NELDash.Priority = Enum.AnimationPriority.Action3;
    u1.Animations.Abilities.NELDash:Play();
    u1.AbilityService.Ability:Fire("NELDash", {
        MoveDirection = MoveDirection
    });
    task.spawn(function() -- Line: 59
        -- upvalues: u3 (copy)
        local BodyVelocity = u3.HumanoidRootPart:WaitForChild("BodyVelocity", 1);

        if BodyVelocity then
            BodyVelocity:Destroy();
        end;
    end);
    local v5 = v4 >= 0.5 and 75 or 50;

    if u3.Values.HasBall.Value then
        v5 = v5 * 0.95 or v5;
    end;

    AbilityUtils.FastDashTo(u3, u3.HumanoidRootPart.Position + MoveDirection * v5, 2, 0.4);
    task.delay(0.7, function() -- Line: 74
        -- upvalues: u1 (copy)
        u1.Animations.Abilities.NELDash:Stop();
        u1.StatesController.States.OwnWalkState = false;
        u1.StatesController.States.Ability = false;
    end);
end;