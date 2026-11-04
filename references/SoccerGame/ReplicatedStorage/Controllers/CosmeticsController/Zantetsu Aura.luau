  

local CollectionService = game:GetService("CollectionService");

return {
    SetupCosmetic = function(p1: userdata, p2: any) -- Line: 5, Name: SetupCosmetic
        -- upvalues: CollectionService (copy)
        local Torso = p1:FindFirstChild("Torso");
        local Torso2 = script:FindFirstChild("Torso");

        if not (Torso and (Torso:IsA("BasePart") and (Torso2 and Torso2:IsA("BasePart")))) then
            return;
        end;

        local v3 = Torso2:Clone();
        local Attribute = Torso2:GetAttribute("Offset");
        local CFrame2 = Torso.CFrame;

        if typeof(Attribute) ~= "CFrame" then
            Attribute = CFrame.identity;
        end;

        v3.CFrame = CFrame2 * Attribute;
        v3.CanCollide = false;
        v3.CanTouch = false;
        v3.CanQuery = false;
        v3.CastShadow = false;
        v3.Massless = true;
        v3.Anchored = false;
        v3.Transparency = 1;

        for _, descendant in v3:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = descendant:GetAttribute("EnableOnEquip") == true;
            end;
        end;

        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = Torso;
        WeldConstraint.Part1 = v3;
        WeldConstraint.Parent = v3;
        CollectionService:AddTag(v3, (`Cosmetic{p2}`));
        v3.Parent = Torso;
    end
};