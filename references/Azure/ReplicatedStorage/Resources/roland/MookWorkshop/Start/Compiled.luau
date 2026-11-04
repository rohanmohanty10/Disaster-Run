 

 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 20, function(p1, p2) -- Line: 5
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p2.Mook.Blade["Cylinder.022"].VFX);
        end }
};