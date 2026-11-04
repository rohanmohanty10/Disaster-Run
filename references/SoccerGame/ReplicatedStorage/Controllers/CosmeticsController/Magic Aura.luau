  

local v1 = {};
game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 6
    -- upvalues: CollectionService (copy)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local CFrame = script.HumanoidRootPart.CFrame;

    for _, child in script.Aura:GetChildren() do
        if child:IsA("BasePart") then
            local v4 = child:Clone();
            v4:PivotTo(HumanoidRootPart.CFrame * CFrame:ToObjectSpace(child.CFrame));

            for _, descendant in v4:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Anchored = false;
                    descendant.CanCollide = false;
                    descendant.CanQuery = false;
                    descendant.CanTouch = false;
                    descendant.Massless = true;
                    descendant.Transparency = 1;
                    local WeldConstraint = Instance.new("WeldConstraint");
                    WeldConstraint.Part0 = HumanoidRootPart;
                    WeldConstraint.Part1 = descendant;
                    WeldConstraint.Parent = descendant;
                end;
            end;

            v4.Anchored = false;
            v4.CanCollide = false;
            v4.CanQuery = false;
            v4.CanTouch = false;
            v4.Massless = true;
            v4.Transparency = 1;
            v4.Parent = HumanoidRootPart;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = HumanoidRootPart;
            WeldConstraint.Part1 = v4;
            WeldConstraint.Parent = v4;
            CollectionService:AddTag(v4, (`Cosmetic{p3}`));
        elseif child:IsA("Highlight") then
            local v5 = child:Clone();
            v5.Parent = p2;
            v5.Enabled = true;
            CollectionService:AddTag(v5, (`Cosmetic{p3}`));
        end;
    end;
end;

return v1;