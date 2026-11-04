  

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
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, p2, p3) -- Line: 17, Name: NELDash
    -- upvalues: Popup (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if not u1.NELDashes then
        u1.NELDashes = 0;
    end;

    local Humanoid = p3:FindFirstChild("Humanoid");
    local workspace_CurrentCamera = workspace.CurrentCamera;
    u1.NELDashes = u1.NELDashes + 1;
    Popup.Popup(p2, (`{2 - u1.NELDashes} Dash{2 - u1.NELDashes == 1 and "" or "es"} Left!`));

    if u1.NELDashes < 2 then
        u1:AbilityCooldown("3", 2);
    else
        u1.NELDashes = nil;
        u1:AbilityCooldown("3", 25);
    end;

    if Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.RightVector) <= 0.95 and (Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.RightVector) >= -0.95 and (Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.LookVector) >= -0.35 or Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.RightVector) <= -0.95)) then
        local _ = Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.LookVector) > 0.35 and Humanoid.MoveDirection:Dot(workspace_CurrentCamera.CFrame.RightVector) > -0.95;
    end;

    local MoveDirection = Humanoid.MoveDirection;
    u1.Animations.Abilities.NELDash.Priority = Enum.AnimationPriority.Action3;
    u1.Animations.Abilities.NELDash:Play();
    u1.AbilityService.Ability:Fire("NELDash", {
        MoveDirection = MoveDirection
    });
    task.delay(0.6, function() -- Line: 60
        -- upvalues: u1 (copy)
        u1.Animations.Abilities.NELDash:Stop();
    end);
end;