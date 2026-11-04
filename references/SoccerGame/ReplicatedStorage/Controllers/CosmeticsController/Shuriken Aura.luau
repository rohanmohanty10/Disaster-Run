  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);

local function setPartPhysics(p2) -- Line: 8
    p2.CanCollide = false;
    p2.CanQuery = false;
    p2.CanTouch = false;
    p2.Massless = true;
    p2.Anchored = false;
end;

local function weldPartToHRP(p3, p4) -- Line: 16
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p4;
    WeldConstraint.Part1 = p3;
    WeldConstraint.Parent = p3;
end;

function v1.SetupCosmetic(p5, p6) -- Line: 23
    -- upvalues: CollectionService (copy)
    local HumanoidRootPart = p5:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    for _, child in script.Aura:GetChildren() do
        local v7 = child:Clone();
        v7.Transparency = 1;
        local v8 = script.HumanoidRootPart.CFrame:ToObjectSpace(v7.CFrame);
        v7:PivotTo(HumanoidRootPart.CFrame * v8);
        v7.CanCollide = false;
        v7.CanQuery = false;
        v7.CanTouch = false;
        v7.Massless = true;
        v7.Anchored = false;
        v7.Parent = HumanoidRootPart;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = HumanoidRootPart;
        WeldConstraint.Part1 = v7;
        WeldConstraint.Parent = v7;
        CollectionService:AddTag(v7, (`Cosmetic{p6}`));
    end;

    local Shurikens = script:FindFirstChild("Shurikens");

    if not Shurikens then
        return;
    end;

    for _, child in Shurikens:GetChildren() do
        if child:IsA("Model") then
            local v9 = child:Clone();
            local v10 = script.HumanoidRootPart.CFrame:ToObjectSpace(child:GetPivot());
            v9:PivotTo(HumanoidRootPart.CFrame * v10);
            v9.Parent = HumanoidRootPart;
            CollectionService:AddTag(v9, (`Cosmetic{p6}`));

            for _, child2 in v9:GetChildren() do
                if child2:IsA("BasePart") then
                    child2.CanCollide = false;
                    child2.CanQuery = false;
                    child2.CanTouch = false;
                    child2.Massless = true;
                    child2.Anchored = false;
                    local WeldConstraint = Instance.new("WeldConstraint");
                    WeldConstraint.Part0 = HumanoidRootPart;
                    WeldConstraint.Part1 = child2;
                    WeldConstraint.Parent = child2;
                end;
            end;

            local Attribute = v9:GetAttribute("AnimationId");

            if Attribute then
                local v11 = v9:FindFirstChildWhichIsA("AnimationController");

                if v11 then
                    local v12 = v11:FindFirstChildWhichIsA("Animator");

                    if not v12 then
                        v12 = Instance.new("Animator");
                        v12.Parent = v11;
                    end;

                    local Animation = Instance.new("Animation");
                    Animation.AnimationId = Attribute;
                    local v13 = v12:LoadAnimation(Animation);
                    v13.Looped = true;
                    v13.Priority = Enum.AnimationPriority.Action4;
                    v13:Play();
                end;
            end;
        end;
    end;
end;

return v1;