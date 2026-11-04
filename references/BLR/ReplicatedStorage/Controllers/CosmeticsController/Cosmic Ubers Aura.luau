  

local v1 = {};
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 5
    -- upvalues: CollectionService (copy)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local CFrame = script.Reference.CFrame;
    local v4 = script.Effects:Clone();

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint") then
            descendant:Destroy();
        end;
    end;

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CFrame = HumanoidRootPart.CFrame * CFrame:ToObjectSpace(descendant.CFrame);
            descendant.Transparency = 1;
            descendant.Anchored = false;
            descendant.Massless = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.CastShadow = false;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = HumanoidRootPart;
            WeldConstraint.Part1 = descendant;
            WeldConstraint.Parent = descendant;
        end;
    end;

    v4.Name = "Cosmic Ubers Aura";
    v4.Parent = HumanoidRootPart;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
    local Highlight = script:FindFirstChild("Highlight");

    if Highlight then
        local v5 = Highlight:Clone();
        v5.Adornee = p2;
        v5.Parent = p2;
        CollectionService:AddTag(v5, (`Cosmetic{p3}`));
    end;
end;

return v1;