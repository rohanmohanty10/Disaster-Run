  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(script.TrapDance);
require(ReplicatedStorage2.AbilityBalancing);
require(ReplicatedStorage.Shared.Popup);

return function(p1, p2, p3) -- Line: 15
    if p3:GetAttribute("Trapped") then
        return;
    end;

    if p1.AbilityTwo > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p2.Character.IsRagdoll.Value then
    end;
end;