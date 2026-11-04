  

local CollectionService = game:GetService("CollectionService");

return {
    SetupCosmetic = function(p1, p2) -- Line: 5, Name: SetupCosmetic
        -- upvalues: CollectionService (copy)
        local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        local CFrame = script.HumanoidRootPart.CFrame;
        local v3 = script.Aura:Clone();

        for _, descendant in v3:GetDescendants() do
            if descendant:IsA("JointInstance") or (descendant:IsA("WeldConstraint") or descendant:IsA("RigidConstraint")) then
                descendant:Destroy();
            end;
        end;

        for _, descendant in v3:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = false;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.Massless = true;
                descendant.CastShadow = false;
                descendant:PivotTo(HumanoidRootPart.CFrame * CFrame:ToObjectSpace(descendant.CFrame));
                local WeldConstraint = Instance.new("WeldConstraint");
                WeldConstraint.Part0 = HumanoidRootPart;
                WeldConstraint.Part1 = descendant;
                WeldConstraint.Parent = descendant;
            end;
        end;

        CollectionService:AddTag(v3, (`Cosmetic{p2}`));
        v3.Parent = HumanoidRootPart;
    end
};