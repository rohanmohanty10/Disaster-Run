 

 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 22, function(p1) -- Line: 5
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p1.Kick);
        end }
};