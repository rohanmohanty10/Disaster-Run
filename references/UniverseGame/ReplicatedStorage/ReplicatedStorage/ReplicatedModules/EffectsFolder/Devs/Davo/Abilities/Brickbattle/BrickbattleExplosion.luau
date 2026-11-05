  

 

local Petal = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("Petal"));
local u1 = Petal("New");
Petal("Util");
local Debris = game:GetService("Debris");

return function(p2) -- Line: 6
    -- upvalues: u1 (copy), Debris (copy)
    Debris:AddItem(u1("Explosion")({
        DestroyJointRadiusPercent = 0,
        BlastPressure = 0,
        Position = p2,
        Parent = workspace.Effects
    }), 2);
end;