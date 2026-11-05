  

 

local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1, p2) -- Line: 2
    -- upvalues: EffectsHandler (copy)
    EffectsHandler.CallEffect("Anshen_GrappleHit1", p1, p2, 2);
end;