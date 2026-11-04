  

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
local script_ReaperTurn = require(script.ReaperTurn);
local script_ScytheSlam = require(script.ScytheSlam);

return function(p1, p2, p3, ...) -- Line: 19
    -- upvalues: script_ReaperTurn (copy), script_ScytheSlam (copy)
    if p1.AbilityTwo > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if p3.Values.HasBall.Value then
        script_ReaperTurn(p1, p2, p3);
    else
        script_ScytheSlam(p1, p2, p3);
    end;

    print("Reaper Sae Move V");
end;