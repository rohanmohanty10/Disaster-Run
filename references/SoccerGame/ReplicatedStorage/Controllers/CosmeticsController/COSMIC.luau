  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.EmitModule);

function v1.SetupCosmetic(p2, p3) -- Line: 9
    -- upvalues: CollectionService (copy), Essentials (copy)
    local Descendants = script.COSMIC:GetDescendants();

    for _, v in pairs(Descendants) do
        if v:IsA("Highlight") then
            local v4 = v:Clone();
            v4.Name = "SHADOW";
            v4.Parent = p2;
            CollectionService:AddTag(v4, (`Cosmetic{p3}`));
        elseif v:IsA("MeshPart") then
            local v5 = v:Clone();
            v5.Name = "SHADOW";
            v5.Parent = p2[v.Parent.Name];
            v5.CFrame = p2[v.Parent.Name].CFrame;
            Essentials:Weld(v5, p2[v.Parent.Name]);
            CollectionService:AddTag(v5, (`Cosmetic{p3}`));
        end;
    end;
end;

return v1;