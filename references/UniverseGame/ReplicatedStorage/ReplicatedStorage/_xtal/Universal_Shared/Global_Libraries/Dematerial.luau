  

 

local v1 = {};
local CollectionService = game:GetService("CollectionService");
local u2 = false;
local v3 = { game.Workspace:WaitForChild("Map") };

function v1.Toggle(p4, p5) -- Line: 20
    -- upvalues: u2 (ref), CollectionService (copy)
    u2 = p5;

    if u2 then
        for _, v in pairs(CollectionService:GetTagged("_PartMaterials")) do
            if not v:GetAttribute("_OriginalMaterial") then
                v:SetAttribute("_OriginalMaterial", v.Material.Name);
            end;

            v.Material = Enum.Material.SmoothPlastic;
        end;

        return;
    end;

    for _, v in pairs(CollectionService:GetTagged("_PartMaterials")) do
        local v6 = v:GetAttribute("_OriginalMaterial");

        if v6 then
            v.Material = Enum.Material[v6];
        end;
    end;
end;

CollectionService:GetInstanceAddedSignal("_PartMaterials"):Connect(function(p7) -- Line: 39
    -- upvalues: u2 (ref)
    if u2 then
        if not p7:GetAttribute("_OriginalMaterial") then
            p7:SetAttribute("_OriginalMaterial", p7.Material.Name);
        end;

        p7.Material = Enum.Material.SmoothPlastic;
    end;
end);

local function AddToCollection(p8) -- Line: 11
    -- upvalues: CollectionService (copy)
    if p8:IsA("BasePart") then
        local Material = p8.Material;

        if Material ~= Enum.Material.Neon and Material ~= Enum.Material.ForceField then
            CollectionService:AddTag(p8, "_PartMaterials");
        end;
    end;
end;

for _, v in pairs(v3) do
    for _, v2 in ipairs(v:QueryDescendants("BasePart")) do
        if v2:IsA("BasePart") then
            local Material = v2.Material;

            if Material ~= Enum.Material.Neon and Material ~= Enum.Material.ForceField then
                CollectionService:AddTag(v2, "_PartMaterials");
            end;
        end;
    end;

    v.DescendantAdded:Connect(AddToCollection);
end;

return v1;