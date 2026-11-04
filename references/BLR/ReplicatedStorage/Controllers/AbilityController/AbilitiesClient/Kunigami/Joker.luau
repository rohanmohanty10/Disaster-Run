  

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

return function(u1, p2, u3) -- Line: 16, Name: Joker
    -- upvalues: ReplicatedStorage (copy), Popup (copy)
    local Value = ReplicatedStorage.Football.Value;

    if not Value then
        return;
    end;

    if Value.OnPlayer.Value then
        return;
    end;

    if p2.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if (ReplicatedStorage.Football.Value.Position - p2.Character.HumanoidRootPart.Position).Magnitude > 50 then
        Popup.Popup(p2, "Ball must be closer!");

        return;
    end;

    if p2.Character.Values.HasBall.Value then
        Popup.Popup(p2, "Ball must be in air!");

        return;
    end;

    if ReplicatedStorage.Football.Value.Position.Y < 12 then
        Popup.Popup(p2, "Ball must be in air!");

        return;
    end;

    if u1.AbilityOne > tick() then
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
    u1:AbilityCooldown("1", 70);
    task.delay(5, function() -- Line: 43
        -- upvalues: u1 (copy), u3 (copy)
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    task.wait(0.1);
    u1.AbilityService.Ability:Fire("Joker");
    u1.Animations:StopAnims();
    u1.Animations.Ball.Joker.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.Joker:Play();
    u1.Animations.Abilities.Joker.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.Joker:Play();
    u1.ABC:Connect(u1.AbilityService.Ability, function() -- Line: 62
        -- upvalues: u1 (copy), ReplicatedStorage (ref), u3 (copy), Shiftlock (copy)
        u1.ABC:Clean();
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        ReplicatedStorage.Football.Value.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.225, 0)) * 235;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u3.HumanoidRootPart.Anchored = false;
        u1.Camera:SetShiftlock(Shiftlock);
    end);
end;