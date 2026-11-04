 

 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 67, function(p1, p2) -- Line: 5
            -- upvalues: Part_Icles (copy)
            p1.Feint.Highlight:FindFirstChild("Adornee").Value = p2;
            Part_Icles:AbsoluteEmit(p1.Feint);
        end }
};