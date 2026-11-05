  

 

local v1 = {};
local CollectionService = game:GetService("CollectionService");
local u2 = false;
local v3 = { game.Workspace:WaitForChild("Map") };

function v1.Toggle(p4, p5) -- Line: 17
    -- upvalues: u2 (ref), CollectionService (copy)
    u2 = p5;

    if u2 then
        for _, v in pairs(CollectionService:GetTagged("_Textures")) do
            if not v:FindFirstChild("_OriginalPart") then
                local ObjectValue = Instance.new("ObjectValue");
                ObjectValue.Value = v.Parent;
                ObjectValue.Name = "_OriginalPart";
                ObjectValue.Parent = v;
                v.Parent = game.ReplicatedStorage.ReplicatedAssets;
            end;
        end;

        return;
    end;

    for _, v in pairs(CollectionService:GetTagged("_Textures")) do
        local _OriginalPart = v:FindFirstChild("_OriginalPart");

        if _OriginalPart then
            v.Parent = _OriginalPart.Value;
            _OriginalPart:Destroy();
        end;
    end;
end;

CollectionService:GetInstanceAddedSignal("_Textures"):Connect(function(p6) -- Line: 42
    -- upvalues: u2 (ref)
    if u2 and (p6:IsA("Texture") and not p6:FindFirstChild("_OriginalPart")) then
        local ObjectValue = Instance.new("ObjectValue");
        ObjectValue.Value = p6.Parent;
        ObjectValue.Name = "_OriginalPart";
        ObjectValue.Parent = p6;
        p6.Parent = nil;
    end;
end);

local function AddToCollection(p7) -- Line: 11
    -- upvalues: CollectionService (copy)
    if p7:IsA("Texture") then
        CollectionService:AddTag(p7, "_Textures");
    end;
end;

for _, v in pairs(v3) do
    for _, v2 in ipairs(v:QueryDescendants("Texture")) do
        if v2:IsA("Texture") then
            CollectionService:AddTag(v2, "_Textures");
        end;
    end;

    v.DescendantAdded:Connect(AddToCollection);
end;

return v1;