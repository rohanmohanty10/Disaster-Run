  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: CollectionService (copy)
    local Torso = p2.Torso;
    local CFrame = script.Torso.CFrame;

    local function attachPart(p4: userdata, p5: boolean) -- Line: 14
        -- upvalues: Torso (copy), CFrame (copy)
        p4.CanCollide = false;
        p4.Massless = true;
        p4.Anchored = false;
        p4.CanTouch = false;
        p4.CanQuery = false;

        if p5 then
            p4.Transparency = 1;
        end;

        p4:PivotTo(Torso.CFrame * CFrame:ToObjectSpace(p4.CFrame));
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = Torso;
        WeldConstraint.Part1 = p4;
        WeldConstraint.Parent = p4;
    end;

    for _, child in script.Aura:GetChildren() do
        if child:IsA("BasePart") then
            local v6 = child:Clone();
            v6.Parent = Torso;
            v6.CanCollide = false;
            v6.Massless = true;
            v6.Anchored = false;
            v6.CanTouch = false;
            v6.CanQuery = false;
            v6.Transparency = 1;
            v6:PivotTo(Torso.CFrame * CFrame:ToObjectSpace(v6.CFrame));
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = Torso;
            WeldConstraint.Part1 = v6;
            WeldConstraint.Parent = v6;
            CollectionService:AddTag(v6, (`Cosmetic{p3}`));
        elseif child:IsA("Model") then
            local v7 = child:Clone();
            v7.Parent = Torso;

            for _, descendant in v7:GetDescendants() do
                if descendant:IsA("WeldConstraint") or (descendant:IsA("Weld") or (descendant:IsA("ManualWeld") or (descendant:IsA("Motor6D") or descendant:IsA("Snap")))) then
                    descendant:Destroy();
                end;
            end;

            for _, descendant in v7:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.CanCollide = false;
                    descendant.Massless = true;
                    descendant.Anchored = false;
                    descendant.CanTouch = false;
                    descendant.CanQuery = false;
                    descendant:PivotTo(Torso.CFrame * CFrame:ToObjectSpace(descendant.CFrame));
                    local WeldConstraint = Instance.new("WeldConstraint");
                    WeldConstraint.Part0 = Torso;
                    WeldConstraint.Part1 = descendant;
                    WeldConstraint.Parent = descendant;
                end;
            end;

            CollectionService:AddTag(v7, (`Cosmetic{p3}`));
        end;
    end;
end;

return v1;