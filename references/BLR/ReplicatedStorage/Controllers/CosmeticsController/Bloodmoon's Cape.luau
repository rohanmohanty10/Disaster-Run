  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 6
    -- upvalues: CollectionService (copy)
    local Torso = p2.Torso;
    local v4 = script.HumanoidRootPart.CFrame:ToObjectSpace(script.BloodmoonCape.CFrame);
    local v5 = script.BloodmoonCape:Clone();
    v5:PivotTo(Torso:GetPivot() * v4);
    v5.Parent = p2;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = Torso;
    WeldConstraint.Part1 = v5;
    WeldConstraint.Parent = v5;
    CollectionService:AddTag(v5, (`Cosmetic{p3}`));
end;

return v1;