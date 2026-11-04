 

 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 26, function(p1) -- Line: 5
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p1.HumanoidRootPart.WaltzCool);
        end },
    { 50, function(p2) -- Line: 10
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p2.HumanoidRootPart.WaltzHit);
        end },
    { 139, function(p3) -- Line: 15
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p3.HumanoidRootPart.WaltzShoot);
        end }
};