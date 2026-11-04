  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: CollectionService (copy)
    local v4 = script.SurfAura:Clone();
    v4.Parent = p2.HumanoidRootPart;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
    v4.HRPWeld.Part0 = p2.Torso;
end;

return v1;