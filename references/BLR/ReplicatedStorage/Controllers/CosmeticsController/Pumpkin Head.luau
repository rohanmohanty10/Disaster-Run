  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 6
    -- upvalues: CollectionService (copy)
    local v4 = script.PumpkinHead:Clone();
    v4["Meshes/soccer game new (8)"].HeadWeld.Part1 = p2.Head;
    v4.Parent = p2;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
end;

return v1;