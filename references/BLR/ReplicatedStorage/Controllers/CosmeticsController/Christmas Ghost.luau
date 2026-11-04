  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: CollectionService (copy)
    for _, child in script["Christmas Ghost Aura"]:GetChildren() do
        local v4 = p2:FindFirstChild(child.Name);

        if v4 then
            local v5 = child:Clone();
            v5.CanCollide = false;
            v5.CanTouch = false;
            v5.CanQuery = false;
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

    local v6 = script.Aura:Clone();
    v6.CanCollide = false;
    v6.Massless = true;
    v6.CanTouch = false;
    v6.CanQuery = false;
    v6.Anchored = false;
    v6.Transparency = 1;
    v6:PivotTo(p2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
    v6.Parent = p2.HumanoidRootPart;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p2.HumanoidRootPart;
    WeldConstraint.Part1 = v6;
    WeldConstraint.Parent = v6;
    CollectionService:AddTag(v6, (`Cosmetic{p3}`));
    local v7 = script.Torso2:Clone();
    v7.CanCollide = false;
    v7.Massless = true;
    v7.Anchored = false;
    v7.Transparency = 1;
    v7:PivotTo(p2.Torso.CFrame * script.Torso.CFrame:ToObjectSpace(v7:GetPivot()));
    v7.Parent = p2.Torso;
    local WeldConstraint2 = Instance.new("WeldConstraint");
    WeldConstraint2.Part0 = p2.Torso;
    WeldConstraint2.Part1 = v7;
    WeldConstraint2.Parent = v7;
    CollectionService:AddTag(v7, (`Cosmetic{p3}`));
    local v8 = script.Torso:Clone();
    v8.CanCollide = false;
    v8.Massless = true;
    v8.Anchored = false;
    v8.Transparency = 1;
    v8:PivotTo(p2.Torso.CFrame * script.Torso.CFrame:ToObjectSpace(v8:GetPivot()));
    v8.Parent = p2.Torso;
    local WeldConstraint3 = Instance.new("WeldConstraint");
    WeldConstraint3.Part0 = p2.Torso;
    WeldConstraint3.Part1 = v8;
    WeldConstraint3.Parent = v8;
    CollectionService:AddTag(v8, (`Cosmetic{p3}`));
end;

return v1;