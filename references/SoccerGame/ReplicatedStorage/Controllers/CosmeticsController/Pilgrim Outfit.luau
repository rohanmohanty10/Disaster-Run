  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 6
    -- upvalues: CollectionService (copy)
    for _, child in script:GetChildren() do
        local v4 = p2:FindFirstChild(child.Name);
        local v5 = child:Clone();
        local v6 = v5:GetAttribute("Offset") or Vector3.new(0, 0, 0);
        v5:PivotTo(v4:GetPivot() + v6);
        v5.Parent = v4;
        local Weld = Instance.new("Weld");
        Weld.Part0 = v4;
        Weld.Part1 = v5;
        Weld.C1 = CFrame.new(-v6);
        Weld.Parent = v5;
        CollectionService:AddTag(v5, (`Cosmetic{p3}`));
    end;
end;

return v1;