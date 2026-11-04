  

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
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local script_PhantomDribble = require(script.PhantomDribble);
local script_PhantomStep = require(script.PhantomStep);

return function(p1, p2, p3) -- Line: 20
    -- upvalues: AbilityUtils (copy), script_PhantomDribble (copy), script_PhantomStep (copy)
    if AbilityUtils.rules.grounded(p2) and AbilityUtils.rules.slotReady(2) then
        if p3.Values.HasBall.Value then
            return script_PhantomDribble(p1, p2, p3);
        end;

        return script_PhantomStep(p1, p2, p3);
    end;
end;