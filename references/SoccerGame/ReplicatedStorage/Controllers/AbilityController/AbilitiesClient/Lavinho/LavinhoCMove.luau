  

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
require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Modules.getPlayerTarget);
local script_RisingDance = require(script.RisingDance);
local script_ButterflyDribble = require(script.ButterflyDribble);

return function(p1, p2, p3, ...) -- Line: 21
    -- upvalues: Popup (copy), script_ButterflyDribble (copy), script_RisingDance (copy)
    if p1.AbilityOne > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if not p2.Character.Values.HasBall.Value then
        return;
    end;

    if p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if p2.Character.Values.HasBall.Value then
        if p2.PlayerStats.InAwakening.Value then
            Popup.Popup(p2, "Keep the ball for 10 seconds for this move to evolve!");
        end;

        if p3:GetAttribute("ButterflyDribble") then
            return script_ButterflyDribble(p1, p2, p3);
        end;

        return script_RisingDance(p1, p2, p3, ...);
    end;

    Popup.Popup(p2, "Must have ball");
end;