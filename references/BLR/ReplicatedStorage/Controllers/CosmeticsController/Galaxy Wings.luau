  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: CollectionService (copy)
    local v4 = script.Wings:Clone();
    v4:PivotTo(p2.Torso.CFrame * script.Torso.CFrame:ToObjectSpace(v4:GetPivot()));
    v4.Parent = p2.Torso;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p2.Torso;
    WeldConstraint.Part1 = v4;
    WeldConstraint.Parent = v4;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
end;

return v1;