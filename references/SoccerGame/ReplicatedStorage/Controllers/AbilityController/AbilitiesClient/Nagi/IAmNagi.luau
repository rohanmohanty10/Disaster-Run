  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, p2, u3) -- Line: 16, Name: IAmNagi
    -- upvalues: ReplicatedStorage (copy), Trove (copy)
    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    if p2.Character.Values.HasBall.Value == false then
        return;
    end;

    if p2.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        return;
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Shiftlock = u1.Camera.Shiftlock;
    u1.Camera:SetShiftlock(false);
    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    task.delay(10, function() -- Line: 33
        -- upvalues: u1 (copy), u3 (copy)
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1:AbilityCooldown("3", 70);
    task.wait(0.1);
    u1.AbilityService.Ability:Fire("IAmNagi");
    u1.Animations:StopAnims();
    u1.Animations.Ball.IAmNagi.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.IAmNagi:Play();
    u1.Animations.Abilities.IAmNagi.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.IAmNagi:Play();
    local u4 = Trove.new();
    local LookVector = game.Workspace.CurrentCamera.CFrame.LookVector;
    u4:Connect(u1.AbilityService.Ability, function() -- Line: 59
        -- upvalues: u1 (copy), u4 (copy), ReplicatedStorage (ref), LookVector (copy), u3 (copy), Shiftlock (copy)
        u1.ABC:Clean();
        u4:Clean();
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        ReplicatedStorage.Football.Value.AssemblyLinearVelocity = (LookVector + Vector3.new(0, 0.2, 0)) * 161.5;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u3.HumanoidRootPart.Anchored = false;
        u1.Camera:SetShiftlock(Shiftlock);
    end);
end;