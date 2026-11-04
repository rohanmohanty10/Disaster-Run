  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 6
    -- upvalues: CollectionService (copy)
    local v4 = script.WingsLoop:Clone();
    v4.Parent = p2;
    v4.Wings.WingWeld.Part0 = p2:FindFirstChild("Torso");
    v4.Wings.WingWeld.Part1 = v4.Wings;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
    v4.AnimationController.Animator:LoadAnimation(script.FlapAnim):Play();
end;

return v1;