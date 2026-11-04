  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: CollectionService (copy), Essentials (copy)
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

    local v6 = script.Gras:Clone();
    v6.CFrame = p2.HumanoidRootPart.CFrame * script.Ref.CFrame:ToObjectSpace(v6.CFrame);
    Essentials:Weld(p2.HumanoidRootPart, v6, v6);
    v6.Parent = p2.HumanoidRootPart;
    CollectionService:AddTag(v6, (`Cosmetic{p3}`));
    local v7 = script.LEAFSFALLING:Clone();
    v7.CFrame = p2.HumanoidRootPart.CFrame * script.Ref.CFrame:ToObjectSpace(v7.CFrame);
    Essentials:Weld(p2.HumanoidRootPart, v7, v7);
    v7.Parent = p2.HumanoidRootPart;
    CollectionService:AddTag(v7, (`Cosmetic{p3}`));
end;

return v1;