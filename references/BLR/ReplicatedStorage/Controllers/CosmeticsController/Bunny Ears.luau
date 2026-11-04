  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: Essentials (copy), CollectionService (copy)
    local v4 = script:FindFirstChildWhichIsA("BasePart");

    for _, child in script.Item:GetChildren() do
        local v5 = child:Clone();
        v5.CFrame = p2[v4.Name].CFrame * v4.CFrame:ToObjectSpace(v5.CFrame);
        v5.Massless = true;
        v5.Anchored = false;
        v5.CanCollide = false;
        v5.Parent = p2;
        Essentials:Weld(p2[v4.Name], v5, v5);
        CollectionService:AddTag(v5, (`Cosmetic{p3}`));
    end;
end;

return v1;