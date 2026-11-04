  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: Essentials (copy), CollectionService (copy)
    for _, child in script.Item:GetChildren() do
        local v4 = child:Clone();
        v4.CFrame = p2.Head.CFrame * script.Head.CFrame:ToObjectSpace(v4.CFrame);
        v4.Parent = p2;
        Essentials:Weld(p2.Head, v4, v4);
        CollectionService:AddTag(v4, (`Cosmetic{p3}`));
    end;
end;

return v1;