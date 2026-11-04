 

 

return {
    { 6, function(p1, p2) -- Line: 3
            local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
            Part_Icles:Activate();
            Part_Icles:AbsoluteEmit(p1.MENACINGSTOMPART);
        end },
    { 63, function(p3, p4) -- Line: 12
            local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
            Part_Icles:Activate();

            for _, v in { p4.Head["111"], p4.Head["222"] } do
                Part_Icles:AbsoluteEmit(v);
            end;
        end },
    { 65, function(p5, p6) -- Line: 27
            local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
            Part_Icles:Activate();
            Part_Icles:AbsoluteEmit(p5.JUMPPART);
        end },
    { 155, function(p7, p8) -- Line: 36
            local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
            Part_Icles:Activate();
            Part_Icles:AbsoluteEmit(p7.MENACINGSTOMPART2);
        end },
    { 295, function(p9, p10) -- Line: 45
            local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
            Part_Icles:Activate();
            Part_Icles:AbsoluteEmit(p9.kickPart);
        end }
};