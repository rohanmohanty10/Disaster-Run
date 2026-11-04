  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: Essentials (copy), CollectionService (copy)
    local v4 = script["Wreath Chain"]:Clone();
    v4.CFrame = p2.Torso.CFrame * script.Torso.CFrame:ToObjectSpace(v4.CFrame);
    v4.Parent = p2;
    Essentials:Weld(p2.Torso, v4, v4);
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
end;

return v1;