 

 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 90, function(p1) -- Line: 5
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p1.HumanoidRootPart.WaltzPreShoot);
        end },
    { 100, function(p2) -- Line: 10
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p2.HumanoidRootPart.WaltzFeintShoot);
        end }
};