  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
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
local Devour = require(ReplicatedStorage.AbilityBalancing).Devour;

return function(u1, p2, u3) -- Line: 16, Name: Devour
    -- upvalues: Popup (copy), ReplicatedStorage (copy), Players (copy), Devour (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if p2.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if u3.Values.HasBall.Value then
        Popup.Popup(p2, "Ball must be on a team-mate!");

        return;
    end;

    if ReplicatedStorage.Football.Value.OnPlayer.Value == false then
        Popup.Popup(p2, "Ball must be on a team-mate!");

        return;
    end;

    local v4 = Players:FindFirstChild(ReplicatedStorage.Football.Value.Char.Value.Name);

    if not v4 then
        return;
    end;

    if v4.Team ~= p2.Team then
        Popup.Popup(p2, "Ball must be on a team-mate!");

        return;
    end;

    if (ReplicatedStorage.Football.Value.Position - u3.HumanoidRootPart.Position).Magnitude >= Devour.ActivationRangeBall then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("3", Devour.Cooldown);
    u1.Animations:StopAnims();
    u1.Animations.Ball.Devour.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.Devour:Play();
    u1.Animations.Abilities.Devour.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.Devour:Play();
    u1.AbilityService.Ability:Fire("Devour", v4.Character);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5) -- Line: 44
        -- upvalues: u1 (copy), u3 (copy), Devour (ref)
        u1.ABC:Clean();
        u1.StatesController.States.Ability = false;
        p5.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + Devour.ShotTiltVector) * Devour.ShotPower;
        u1.BallController:DragBall(p5);
    end);
    task.delay(10, function() -- Line: 54
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;