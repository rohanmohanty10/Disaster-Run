  

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
local script_DemonHeader = require(script.DemonHeader);
local script_Bloodlust = require(script.Bloodlust);

return function(p1, p2, p3, ...) -- Line: 19
    -- upvalues: script_DemonHeader (copy), script_Bloodlust (copy)
    if p1.AbilityThree > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if p3.Values.HasBall.Value then
        script_DemonHeader(p1, p2, p3);

        return;
    end;

    script_Bloodlust(p1, p2, p3);
end;