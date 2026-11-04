  

local v1 = {};
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 5
    -- upvalues: CollectionService (copy)
    local Torso = p2:FindFirstChild("Torso");

    if not Torso then
        return;
    end;

    local v4 = script.Aura:Clone();
    v4.CanCollide = false;
    v4.Massless = true;
    v4.Anchored = false;
    v4.Transparency = 1;
    v4:PivotTo(Torso.CFrame * CFrame.new(0.0359, -2.975, 0.0298));
    v4.Parent = Torso;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = Torso;
    WeldConstraint.Part1 = v4;
    WeldConstraint.Parent = v4;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
end;

return v1;