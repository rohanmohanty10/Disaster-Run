  

 

local Petal = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("Petal"));
local u1 = Petal("New");
Petal("Util");
local Debris = game:GetService("Debris");
local _ = Vector3.new;

return function(p2, p3) -- Line: 8
    -- upvalues: u1 (copy), Debris (copy)
    local v4 = u1("Explosion")({
        DestroyJointRadiusPercent = 0,
        BlastPressure = 0,
        Position = p2,
        Parent = workspace.Effects
    });

    if p3 then
        local v5 = p3:Clone();
        local v6 = u1("Part")({
            Transparency = 1,
            Size = Vector3.new(0.1, 0.1, 0.1),
            CanTouch = false,
            CanCollide = false,
            CanQuery = false,
            Anchored = true,
            Position = p2,
            Parent = workspace.Effects
        });
        v5.Parent = v6;
        v5:Resume();
        Debris:AddItem(v6, (p3.TimeLength or 2) + 0.1);
    end;

    Debris:AddItem(v4, 2);
end;