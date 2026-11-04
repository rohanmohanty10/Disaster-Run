  

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
require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Modules.getPlayerTarget);
local script_ButterflyCounter = require(script.ButterflyCounter);

return function(p1, p2, p3, ...) -- Line: 20
    -- upvalues: script_ButterflyCounter (copy)
    if p1.AbilityThree > tick() then
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

    if not p2.Character.IsRagdoll.Value then
        return script_ButterflyCounter(p1, p2, p3, ...);
    end;
end;