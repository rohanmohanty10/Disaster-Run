  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: CollectionService (copy)
    local v4 = script.Torso.Attachment:Clone();
    v4.Parent = p2.Torso;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
end;

return v1;