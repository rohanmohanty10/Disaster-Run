  

 

local u1 = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("debrisSlamFunction");

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    u1(p2, p3, p4);
end;