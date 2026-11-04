  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 6
    -- upvalues: CollectionService (copy)
    for _, child in script:GetChildren() do
        local v4 = p2:FindFirstChild(child.Name);
        local v5 = child:Clone();
        v5:PivotTo(v4:GetPivot());
        v5.Parent = v4;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = v4;
        WeldConstraint.Part1 = v5;
        WeldConstraint.Parent = v5;
        CollectionService:AddTag(v5, (`Cosmetic{p3}`));
    end;
end;

return v1;