  

 

local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function() -- Line: 2
    -- upvalues: EffectsHandler (copy)
    EffectsHandler.CallEffect("AttachCamera", "Detach");
end;