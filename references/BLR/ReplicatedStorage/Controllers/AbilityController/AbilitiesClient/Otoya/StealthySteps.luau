  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, p2, p3) -- Line: 15, Name: StealthySteps
    -- upvalues: Popup (copy)
    if u1.AbilityOne > tick() then
        return;
    end;

    if p3.Values.HasBall.Value then
        Popup.Popup(p2, "Must not have the ball to use ability!");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("1", 45);
    local _ = p2.Character.HumanoidRootPart;
    local _ = p2.Character.Humanoid;
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.StatesController.SpeedBoost = 20;
    u1.ABC:Add(function() -- Line: 30
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        u1.StatesController.SpeedBoost = 0;
    end);
    u1.ABC:Connect(p3.Values.HasBall:GetPropertyChangedSignal("Value"), function() -- Line: 36
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end);
    u1.ABC:Add(task.delay(2.5, function() -- Line: 40
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.AbilityService.Ability:Fire("StealthySteps");
end;