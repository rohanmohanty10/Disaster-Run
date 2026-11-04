  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: CollectionService (copy)
    local v4 = script.Body:Clone();
    v4.CanCollide = false;
    v4.Massless = true;
    v4.Anchored = false;
    v4.Transparency = 1;
    v4:PivotTo(p2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(v4:GetPivot()));
    v4.Parent = p2.HumanoidRootPart;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p2.HumanoidRootPart;
    WeldConstraint.Part1 = v4;
    WeldConstraint.Parent = v4;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
    local v5 = script.Floor:Clone();
    v5.CanCollide = false;
    v5.Massless = true;
    v5.Anchored = false;
    v5.Transparency = 1;
    v5:PivotTo(p2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(v5:GetPivot()));
    v5.Parent = p2.HumanoidRootPart;
    local WeldConstraint2 = Instance.new("WeldConstraint");
    WeldConstraint2.Part0 = p2.HumanoidRootPart;
    WeldConstraint2.Part1 = v5;
    WeldConstraint2.Parent = v5;
    CollectionService:AddTag(v5, (`Cosmetic{p3}`));
end;

return v1;