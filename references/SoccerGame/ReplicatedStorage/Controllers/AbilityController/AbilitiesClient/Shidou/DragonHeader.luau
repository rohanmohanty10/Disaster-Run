  

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
require(ReplicatedStorage.AbilityBalancing);

return function(u1, u2, p3, p4, u5) -- Line: 17, Name: DragonHeader
    -- upvalues: Debris (copy)
    if p3.Values.HasBall.Value == false then
        return;
    end;

    if game.Players.LocalPlayer.PlayerStats.Stamina.Value <= 20 then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("2", 60);
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.ShidouHeader.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ShidouHeader:Play();
    u1.Animations.Ball.ShidouHeader.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.ShidouHeader:Play();
    u1.AbilityService.Ability:Fire("DragonHeader");

    if p3.Values.HasBall.Value then
        u1.ABC:Connect(u1.AbilityService.Ability, function(p6) -- Line: 39
            -- upvalues: u1 (copy), u2 (copy), Debris (ref)
            u1.StatesController.States.Ability = false;
            u1.StatesController.OwnWalkState = false;
            p6.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.2, 0)) * 175;
            u1.BallController:DragBall(p6);
            local BodyGyro = Instance.new("BodyGyro");
            BodyGyro.Parent = u2.Character.HumanoidRootPart;
            BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
            Debris:AddItem(BodyGyro, 0.15);
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Parent = u2.Character.HumanoidRootPart;
            BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * (1 / 0);
            BodyVelocity.Velocity = (u2.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.5, 0)) * 60;
            Debris:AddItem(BodyVelocity, 0.15);
            u1.ABC:Clean();
        end);
    end;

    task.delay(1, function() -- Line: 63
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
    end);
    task.delay(3, function() -- Line: 68
        -- upvalues: u1 (copy), u5 (copy)
        if u1.RunId == u5 then
            u1.ABC:Clean();
        end;
    end);
end;