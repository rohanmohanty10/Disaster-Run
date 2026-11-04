  

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

return function(u1, p2, p3, p4) -- Line: 16
    -- upvalues: ReplicatedStorage (copy), Popup (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if (ReplicatedStorage.Football.Value.Position - p2.Character.HumanoidRootPart.Position).Magnitude > 75 then
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

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if ReplicatedStorage.GameValues.Scored.Value then
        return;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u1.ABC:Add(function() -- Line: 33
        -- upvalues: u1 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Add(task.delay(8.8, function() -- Line: 39
        -- upvalues: u1 (copy)
        u1:AbilityCooldown("3", 80);
        u1.ABC:Clean();
    end));
    u1.AbilityService.Ability:Fire("ButterflyIntercept");
end;