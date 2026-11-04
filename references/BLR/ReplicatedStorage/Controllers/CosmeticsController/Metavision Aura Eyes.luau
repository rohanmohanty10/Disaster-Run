  

local v1 = {};
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 5
    -- upvalues: CollectionService (copy)
    local Head = p2:FindFirstChild("Head");

    if not Head then
        return;
    end;

    local v4 = script.Effect:Clone();
    v4.Anchored = false;
    v4.Massless = true;
    v4.CanCollide = false;
    v4.CanTouch = false;
    v4.CanQuery = false;
    v4.CastShadow = false;
    v4.Transparency = 1;
    v4.CFrame = Head.CFrame * script.Reference.CFrame:ToObjectSpace(v4.CFrame);
    v4.Parent = Head;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = Head;
    WeldConstraint.Part1 = v4;
    WeldConstraint.Parent = v4;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
end;

return v1;