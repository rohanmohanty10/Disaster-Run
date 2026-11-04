  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage2.AbilityBalancing);
require(ReplicatedStorage.Shared.Popup);
local script_SkeletonTrap = require(script.SkeletonTrap);
local script_SkullShot = require(script.SkullShot);

return function(p1, p2, p3) -- Line: 18
    -- upvalues: script_SkullShot (copy), script_SkeletonTrap (copy)
    if p3:GetAttribute("SkeletonTrap") then
        script_SkullShot(p1, p2, p3);

        return;
    end;

    script_SkeletonTrap(p1, p2, p3);
end;