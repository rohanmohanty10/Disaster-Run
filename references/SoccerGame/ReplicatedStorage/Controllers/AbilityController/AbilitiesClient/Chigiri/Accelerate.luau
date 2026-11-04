  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(p1, p2, p3) -- Line: 15, Name: Accelerate
    -- upvalues: AbilityBalancing (copy)
    if p1.AbilityTwo > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    p1:AbilityCooldown("2", AbilityBalancing.Accelerate.Cooldown);
    p1.AbilityService.Ability:Fire("Accelerate");
end;