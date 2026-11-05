  

 

if game:GetService("RunService"):IsClient() then
    return function() -- Line: 1
    end;
end;

local PathShortcuts = require(game.ServerScriptService.ServerLibrary.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2) -- Line: 6
    -- upvalues: ParticleHandler (copy)
    if not p1 then
        return;
    end;

    local v3 = p1:FindFirstChild("Torso") and p1.Torso:FindFirstChild("Birthmark");

    if v3 then
        ParticleHandler.EnableAllParticles(v3, p2);
    end;
end;