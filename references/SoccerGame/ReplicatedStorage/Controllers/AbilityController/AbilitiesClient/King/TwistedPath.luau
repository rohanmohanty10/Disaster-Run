  

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
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);

return function(u1, u2, u3) -- Line: 17
    -- upvalues: AbilityUtils (copy), Popup (copy)
    if u2.Character.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if not AbilityUtils.findNearestPlayer({
        distance = 100,
        team = "Enemy",
        includeGK = true
    }) then
        Popup.Popup(u2, "No enemy in range");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("1", 70);
    local _ = u1.Camera.Shiftlock;
    u1.Camera:SetShiftlock(false);
    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 40
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera:SetShiftlock(true);
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1.ABC:Add(task.delay(20, function() -- Line: 50
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.ABC:Connect(u1.AbilityService.Ability, function(p4) -- Line: 54
        -- upvalues: u1 (copy), u2 (copy)
        u1:AbilityCooldown("1", 40);
        local Character = u2.Character;
        local v5;

        if Character then
            v5 = Character:FindFirstChild("HumanoidRootPart");
        else
            v5 = Character;
        end;

        if not v5 then
            return;
        end;

        p4.AssemblyLinearVelocity = (Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.25, 0)) * 255;
        u1.BallController:DragBall(p4);
        u1.ABC:Clean();
    end);
    u1.AbilityService.Ability:Fire("TwistedPath");
end;