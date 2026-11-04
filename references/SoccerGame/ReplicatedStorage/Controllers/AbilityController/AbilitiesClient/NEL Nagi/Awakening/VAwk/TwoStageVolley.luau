  

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
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, u2, u3) -- Line: 17
    -- upvalues: AbilityBalancing (copy)
    if u2.Character.Values.HasBall.Value == true then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 29
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1.ABC:Add(task.delay(20, function() -- Line: 36
        -- upvalues: u1 (copy)
        u1:AbilityCooldown("2", 40);
        u1.ABC:Clean();
    end));
    local u4 = game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.13, 0);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5) -- Line: 42
        -- upvalues: u1 (copy), u2 (copy), u4 (copy), AbilityBalancing (ref)
        u1:AbilityCooldown("2", 40);
        local Character = u2.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        p5.AssemblyLinearVelocity = u4 * AbilityBalancing.TwoStageVolley.ShotPower;
        u1.BallController:DragBall(p5);
        u1.ABC:Clean();
    end);
    u1.AbilityService.Ability:Fire("TwoStageVolley");
end;