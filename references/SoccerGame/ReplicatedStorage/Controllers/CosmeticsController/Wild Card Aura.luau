  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
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
            v5.Parent = p2.HumanoidRootPart;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = v4;
            WeldConstraint.Part1 = v5;
            WeldConstraint.Parent = v5;
            CollectionService:AddTag(v5, (`Cosmetic{p3}`));
        end;
    end;

    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        local v6 = script.CardAura:Clone();

        for _, descendant in v6:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.CanTouch = false;
                descendant.CanQuery = false;
                descendant.Massless = true;
                descendant.Anchored = false;
            end;
        end;

        v6:PivotTo(HumanoidRootPart.CFrame * script.Aura.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
        v6.Parent = p2.HumanoidRootPart;
        local v7 = v6.PrimaryPart or v6:FindFirstChildWhichIsA("BasePart");

        if v7 then
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = HumanoidRootPart;
            WeldConstraint.Part1 = v7;
            WeldConstraint.Parent = v7;
        end;

        CollectionService:AddTag(v6, (`Cosmetic{p3}`));
        local v8 = v6:FindFirstChildWhichIsA("AnimationController");

        if v8 then
            local v9 = v8:FindFirstChildWhichIsA("Animator");

            if not v9 then
                v9 = Instance.new("Animator");
                v9.Parent = v8;
            end;

            local v10 = v9:LoadAnimation(script.CardAnim);
            v10.Looped = true;
            v10.Priority = Enum.AnimationPriority.Action4;
            v10:Play();
        end;
    end;
end;

return v1;