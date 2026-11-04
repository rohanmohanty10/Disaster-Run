  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: Essentials (copy), CollectionService (copy)
    for _, child in script.Outfit:GetChildren() do
        local v4 = p2:FindFirstChild(child.Name);
        local v5 = child:Clone();
        v5.CFrame = v4.CFrame * script.Rig[child.Name].CFrame:ToObjectSpace(v5.CFrame);
        v5.Massless = true;
        v5.CanCollide = false;
        v5.CanTouch = false;
        v5.CanQuery = false;
        Essentials:Weld(v4, v5, v5);
        v5.Parent = v4;
        CollectionService:AddTag(v5, (`Cosmetic{p3}`));
    end;
end;

return v1;