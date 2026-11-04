  

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

return function(u1, p2, p3) -- Line: 16, Name: LethalTouch
    if p3.Values.HasBall.Value == false then
        return;
    end;

    if p2.PlayerStats.Stamina.Value <= 10 then
        return;
    end;

    if p3.Humanoid:GetState() ~= Enum.HumanoidStateType.Running then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("2", 65);
    u1.AbilityUsed = tick() + 1;
    u1.StatesController.NoJump = true;
    u1.StatesController.NoShoot = true;
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.LethalTouch.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.LethalTouch:Play();
    u1.Animations.Ball.LethalTouch.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.LethalTouch:Play();
    local v4;

    if (p3.HumanoidRootPart.CFrame:VectorToObjectSpace(p3.Humanoid.MoveDirection).X < 0 and "Left" or "Right") == "Right" then
        v4 = p3.HumanoidRootPart.CFrame.RightVector;
    else
        v4 = -p3.HumanoidRootPart.CFrame.RightVector;
    end;

    u1.AbilityService.Ability:Fire("LethalTouch", v4);
    task.delay(0.7, function() -- Line: 52
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    task.delay(0.2, function() -- Line: 56
        -- upvalues: u1 (copy)
        u1.StatesController.NoJump = false;
        u1.StatesController.NoShoot = false;
    end);
end;