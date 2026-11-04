  

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
local Feast = require(ReplicatedStorage.AbilityBalancing).Feast;
require(ReplicatedStorage.Shared.AbilityUtils);

return function(u1, u2, u3) -- Line: 18
    -- upvalues: ReplicatedStorage (copy), Feast (copy), Popup (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.AbilityUsed + 4 > tick() then
        print("Skill used recently");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Value = ReplicatedStorage.Football.Value;

    if (u3.HumanoidRootPart.Position - Value.Position).Magnitude > Feast.ActivationRangeBall then
        Popup.Popup(u2, "Ball Too Far");

        return;
    end;

    if Value.OnPlayer.Value and Value.Char.Value.Values.Goalie.Value then
        Popup.Popup(u2, "Goalie has ball");

        return;
    end;

    u1:AbilityCooldown("3", Feast.Cooldown);
    u1.Camera:SetShiftlock(false);
    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 53
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera:SetShiftlock(true);
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1.ABC:Add(task.delay(20, function() -- Line: 63
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    local LookVector = workspace.CurrentCamera.CFrame.LookVector;
    u1.ABC:Connect(u1.AbilityService.Ability, function(p4) -- Line: 69
        -- upvalues: u1 (copy), Feast (ref), u2 (copy), LookVector (copy)
        u1:AbilityCooldown("3", Feast.Cooldown);
        local Character = u2.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        p4.AssemblyLinearVelocity = (LookVector + Feast.ShotTiltVector) * Feast.ShotPower;
        u1.BallController:DragBall(p4);
        u1.ABC:Clean();
    end);
    u1.AbilityService.Ability:Fire("Feast");
end;