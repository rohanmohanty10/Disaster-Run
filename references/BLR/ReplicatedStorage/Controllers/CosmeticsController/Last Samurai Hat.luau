  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 6
    -- upvalues: CollectionService (copy)
    local v4 = script.Hat:Clone();
    v4.Parent = p2.Head;
    local v5 = v4:GetAttribute("Offset") or Vector3.new(0, 0, 0);
    v4:PivotTo(p2.Head:GetPivot() + v5);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p2.Head;
    WeldConstraint.Part1 = v4;
    WeldConstraint.Parent = v4;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
end;

return v1;