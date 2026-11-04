  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local script_NELNagiTapLift = require(script.NELNagiTapLift);
local script_SpaceShot = require(script.SpaceShot);
require(ReplicatedStorage2.AbilityBalancing);
require(ReplicatedStorage.Shared.Popup);

return function(p1, p2, p3) -- Line: 16
    -- upvalues: script_NELNagiTapLift (copy), ReplicatedStorage2 (copy), script_SpaceShot (copy)
    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if p3.Values.HasBall.Value then
        script_NELNagiTapLift(p1, p2, p3);

        return;
    end;

    if ReplicatedStorage2.Football.Value.Char.Value.Name == "GK" then
        return;
    end;

    script_SpaceShot(p1, p2, p3);
end;