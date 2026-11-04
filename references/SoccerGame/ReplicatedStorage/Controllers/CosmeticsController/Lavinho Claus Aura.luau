  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: CollectionService (copy)
    for _, child in script:GetChildren() do
        local v4 = p2:FindFirstChild(child.Name);

        if v4 then
            local v5 = child:Clone();
            v5.CanCollide = false;
            v5.Massless = true;
            v5.Anchored = false;
            v5.Transparency = 1;
            v5:PivotTo(v4:GetPivot());
            v5.Parent = v4;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = v4;
            WeldConstraint.Part1 = v5;
            WeldConstraint.Parent = v5;
            CollectionService:AddTag(v5, (`Cosmetic{p3}`));
        end;
    end;

    local v6 = script.Wings:Clone();
    v6.CanCollide = false;
    v6.Massless = true;
    v6.Anchored = false;
    v6.Transparency = 1;
    v6:PivotTo(p2.Torso.CFrame * script.Torso.CFrame:ToObjectSpace(v6.CFrame));
    v6.Parent = p2.Torso;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p2.Torso;
    WeldConstraint.Part1 = v6;
    WeldConstraint.Parent = v6;
    CollectionService:AddTag(v6, (`Cosmetic{p3}`));
end;

return v1;