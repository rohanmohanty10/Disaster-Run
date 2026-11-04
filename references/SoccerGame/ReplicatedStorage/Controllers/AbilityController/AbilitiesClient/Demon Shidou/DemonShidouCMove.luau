  

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
local script_DemonicDribble = require(script.DemonicDribble);
local script_DemonicShot = require(script.DemonicShot);

return function(p1, p2, p3, ...) -- Line: 19
    -- upvalues: Popup (copy), script_DemonicShot (copy), script_DemonicDribble (copy)
    if p1.AbilityOne > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if not p3.Values.HasBall.Value then
        return Popup.Popup(p2, "You need the ball to use this!");
    end;

    if p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if not p2.Character.IsRagdoll.Value then
        if p3:GetAttribute("DemonicDribble") then
            return script_DemonicShot(p1, p2, p3, ...);
        end;

        return script_DemonicDribble(p1, p2, p3, ...);
    end;
end;