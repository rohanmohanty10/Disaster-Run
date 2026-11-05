  

 

local v1 = {};
local CollectionService = game:GetService("CollectionService");
local u2 = true;
local v3 = { game.Workspace:WaitForChild("Map") };

function v1.Toggle(p4, p5) -- Line: 17
    -- upvalues: u2 (ref), CollectionService (copy)
    u2 = p5;

    if u2 then
        for _, v in pairs(CollectionService:GetTagged("_Lights")) do
            local _OriginalEnabled = v:FindFirstChild("_OriginalEnabled");

            if _OriginalEnabled then
                v.Shadows = _OriginalEnabled.Value;
                _OriginalEnabled:Destroy();
            end;
        end;

        return;
    end;

    for _, v in pairs(CollectionService:GetTagged("_Lights")) do
        if not v:FindFirstChild("_OriginalEnabled") then
            local BoolValue = Instance.new("BoolValue");
            BoolValue.Name = "_OriginalEnabled";
            BoolValue.Value = v.Shadows;
            BoolValue.Parent = v;
            v.Shadows = false;
        end;
    end;
end;

CollectionService:GetInstanceAddedSignal("_Lights"):Connect(function(p6) -- Line: 42
    -- upvalues: u2 (ref)
    if not u2 and (p6:IsA("Light") and not p6:FindFirstChild("_OriginalEnabled")) then
        local BoolValue = Instance.new("BoolValue");
        BoolValue.Name = "_OriginalEnabled";
        BoolValue.Value = p6.Shadows;
        BoolValue.Parent = p6;
        p6.Shadows = false;
    end;
end);

local function AddToCollection(p7) -- Line: 11
    -- upvalues: CollectionService (copy)
    if p7:IsA("Light") then
        CollectionService:AddTag(p7, "_Lights");
    end;
end;

for _, v in pairs(v3) do
    for _, v2 in ipairs(v:QueryDescendants("Light")) do
        if v2:IsA("Light") then
            CollectionService:AddTag(v2, "_Lights");
        end;
    end;

    v.DescendantAdded:Connect(AddToCollection);
end;

return v1;