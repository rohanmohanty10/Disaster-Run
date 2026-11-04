  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: Essentials (copy), CollectionService (copy)
    for _, child in script["LED Lights"]:GetChildren() do
        local v4 = p2:FindFirstChild(child.Name);
        local v5 = child:Clone();
        v5.Parent = v4;
        local v6 = child;

        for _, child2 in v5:GetChildren() do
            child2.CFrame = v4.CFrame * script.Rig[v6.Name].CFrame:ToObjectSpace(child2.CFrame);
            Essentials:Weld(v4, child2, child2);
        end;

        CollectionService:AddTag(v5, (`Cosmetic{p3}`));
    end;
end;

return v1;