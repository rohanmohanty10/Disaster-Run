  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local script_DeathDance = require(script.DeathDance);
require(ReplicatedStorage2.AbilityBalancing);
require(ReplicatedStorage.Shared.Popup);

return function(p1, p2, p3) -- Line: 20
    -- upvalues: script_DeathDance (copy)
    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if p3.Values.HasBall.Value then
        if not p1.UsedDeathDance then
            script_DeathDance(p1, p2, p3);

            return;
        end;

        if p1.TrapShot then
        end;
    end;
end;