  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: Essentials (copy), CollectionService (copy)
    local v4 = script.RightSki:Clone();
    v4.CFrame = p2["Right Leg"].CFrame * script["Right Leg"].CFrame:ToObjectSpace(v4.CFrame);
    v4.Parent = p2;
    Essentials:Weld(p2["Right Leg"], v4, v4);
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
    local v5 = script.LeftSki:Clone();
    v5.CFrame = p2["Left Leg"].CFrame * script["Left Leg"].CFrame:ToObjectSpace(v5.CFrame);
    v5.Parent = p2;
    Essentials:Weld(p2["Left Leg"], v5, v5);
    CollectionService:AddTag(v5, (`Cosmetic{p3}`));
end;

return v1;