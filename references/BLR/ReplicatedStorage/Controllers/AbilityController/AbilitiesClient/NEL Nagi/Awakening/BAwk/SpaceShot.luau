  

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

return function(u1, u2, u3) -- Line: 17
    -- upvalues: ReplicatedStorage (copy), Popup (copy), AbilityBalancing (copy)
    if u2.Character.Values.HasBall.Value == true then
        return;
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Value = ReplicatedStorage.Football.Value;

    if ReplicatedStorage.GameValues.CutsceneShot.Value then
        return;
    end;

    if Value.OnPlayer.Value then
        Popup.Popup(u2, "Ball must be loose!");

        return;
    end;

    if (Value.Position - u3.HumanoidRootPart.Position).Magnitude >= 80 then
        Popup.Popup(u2, "Ball too far!");

        return;
    end;

    if Value.Position.Y < 14 then
        Popup.Popup(u2, "Ball not in the air!");

        return;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 51
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1.ABC:Add(task.delay(20, function() -- Line: 58
        -- upvalues: u1 (copy)
        u1:AbilityCooldown("3", 80);
        u1.ABC:Clean();
    end));
    local u4 = game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.13, 0);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5) -- Line: 65
        -- upvalues: u1 (copy), u2 (copy), u4 (copy), AbilityBalancing (ref)
        if p5 == false then
            u1.ABC:Clean();

            return;
        end;

        u1:AbilityCooldown("3", 80);
        local Character = u2.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        p5.AssemblyLinearVelocity = u4 * AbilityBalancing.SpaceShot.ShotPower;
        u1.BallController:DragBall(p5);
        u1.ABC:Clean();
    end);
    u1.AbilityService.Ability:Fire("SpaceShot");
end;