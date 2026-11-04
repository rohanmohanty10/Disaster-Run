  

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
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, p3) -- Line: 17
    -- upvalues: ReplicatedStorage (copy), AbilityBalancing (copy), Popup (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if (ReplicatedStorage.Football.Value.Position - p2.Character.HumanoidRootPart.Position).Magnitude > AbilityBalancing.HareInTheAir.ActivationRangeBall then
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

    if p3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u1.ABC:Add(function() -- Line: 41
        -- upvalues: u1 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Add(task.delay(15, function() -- Line: 47
        -- upvalues: u1 (copy), AbilityBalancing (ref)
        u1:AbilityCooldown("3", AbilityBalancing.HareInTheAir.Cooldown);
        u1.ABC:Clean();
    end));
    local u4 = game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.2, 0);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5) -- Line: 53
        -- upvalues: u1 (copy), AbilityBalancing (ref), u4 (copy), ReplicatedStorage (ref)
        u1:AbilityCooldown("3", AbilityBalancing.HareInTheAir.Cooldown);
        p5.AssemblyLinearVelocity = u4 * AbilityBalancing.HareInTheAir.ShotPower;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u1.ABC:Clean();
    end);
    u1.AbilityService.Ability:Fire("HareInTheAir");
end;