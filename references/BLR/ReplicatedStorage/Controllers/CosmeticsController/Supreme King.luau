  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: CollectionService (copy)
    for _, child in script.Aura:GetChildren() do
        if child:IsA("BasePart") then
            local v4 = child:Clone();
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
        end;
    end;
end;

return v1;