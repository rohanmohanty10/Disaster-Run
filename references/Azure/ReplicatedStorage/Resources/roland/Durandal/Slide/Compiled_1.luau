 
 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 30, function(p1) -- Line: 5
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p1.Slide);
            shared.vfx.emit(p1.dashf);
        end }
};