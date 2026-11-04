  

local v1 = {};
local CollectionService = game:GetService("CollectionService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 6
    -- upvalues: Essentials (copy), CollectionService (copy)
    for _, child in script.Outfit:GetChildren() do
        local v4 = p2:FindFirstChild(child.Name);

        if v4 then
            local v5 = child:Clone();
            v5.Anchored = false;
            v5.Massless = true;
            v5.CanCollide = false;
            v5.CanQuery = false;
            v5.CanTouch = false;
            v5.CFrame = v4.CFrame * script.Rig[child.Name].CFrame:ToObjectSpace(v5.CFrame);
            Essentials:Weld(v4, v5, v5);
            v5.Parent = v4;
            CollectionService:AddTag(v5, (`Cosmetic{p3}`));
        end;
    end;
end;

return v1;