  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 5
    -- upvalues: ParticleHandler (copy)
    local AbilityModel = p1.AbilityModel;
    local v2 = p1.Value or false;

    if not (AbilityModel and AbilityModel.Parent) then
        return;
    end;

    local Sword = AbilityModel:FindFirstChild("Sword");

    if not Sword then
        return;
    end;

    local Aura = Sword:FindFirstChild("Aura");

    if not Aura then
        return;
    end;

    ParticleHandler.EnableParticle(Aura, v2);
end;