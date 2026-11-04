  

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
local script_TikiTaka = require(script.TikiTaka);
local script_ButterflyIntercept = require(script.ButterflyIntercept);

return function(p1, p2, p3, ...) -- Line: 21
    -- upvalues: script_TikiTaka (copy), script_ButterflyIntercept (copy)
    if p1.AbilityThree > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if not p2.Character.IsRagdoll.Value then
        if p3.Values.HasBall.Value or p1.TikiTakaCharges and p1.TikiTakaCharges ~= 0 then
            return script_TikiTaka(p1, p2, p3);
        end;

        return script_ButterflyIntercept(p1, p2, p3);
    end;
end;