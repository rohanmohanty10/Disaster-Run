  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local v1 = {};
local France = ReplicatedStorage.Assets.Misc.ShopTeamAuras.France;

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: France (copy), CollectionService (copy)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Attribute = France:GetAttribute("ReferenceCFrame");
    local Effects = France:FindFirstChild("Effects");

    if typeof(Attribute) ~= "CFrame" or not Effects then
        return;
    end;

    local v4 = Effects:Clone();

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("JointInstance") or (descendant:IsA("WeldConstraint") or descendant:IsA("RigidConstraint")) then
            descendant:Destroy();
        end;
    end;

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Massless = true;
            descendant.CastShadow = false;
            descendant:PivotTo(HumanoidRootPart.CFrame * Attribute:ToObjectSpace(descendant.CFrame));
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = HumanoidRootPart;
            WeldConstraint.Part1 = descendant;
            WeldConstraint.Parent = descendant;
        end;
    end;

    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
    v4.Parent = HumanoidRootPart;
end;

return v1;