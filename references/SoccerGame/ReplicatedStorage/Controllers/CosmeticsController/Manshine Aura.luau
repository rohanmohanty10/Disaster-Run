  

local v1 = {};
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 5
    -- upvalues: CollectionService (copy)
    for _, child in script.Aura:GetChildren() do
        local v4 = p2:FindFirstChild(child.Name);

        if v4 then
            local v5 = child:Clone();
            v5.CanCollide = false;
            v5.CanTouch = false;
            v5.CanQuery = false;
            v5.Massless = true;
            v5.Anchored = false;
            v5.Transparency = 1;
            v5:PivotTo(v4.CFrame);
            v5.Parent = v4;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = v4;
            WeldConstraint.Part1 = v5;
            WeldConstraint.Parent = v5;
            CollectionService:AddTag(v5, (`Cosmetic{p3}`));
        end;
    end;
end;

return v1;