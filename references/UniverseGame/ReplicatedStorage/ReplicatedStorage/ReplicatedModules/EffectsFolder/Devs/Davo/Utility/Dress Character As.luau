  

 

local Players = game:GetService("Players");
local u1 = { "Shirt", "ShirtGraphic", "Pants", "BodyColors", "CharacterMesh", "Accessory" };

return function(p2, p3, p4, p5) -- Line: 11
    -- upvalues: u1 (copy), Players (copy)
    local v6 = p2:FindFirstChildOfClass("Humanoid");

    if v6 then
        v6:RemoveAccessories();
    end;

    for _, child in p2:GetChildren() do
        if table.find(u1, child.ClassName) then
            child:Destroy();
        end;
    end;

    local v7 = not p5 and (p4 and Players:GetHumanoidDescriptionFromOutfitId(p3) or Players:GetHumanoidDescriptionFromUserId(p3));
    local v8 = p5 or Players:CreateHumanoidModelFromDescription(v7, Enum.HumanoidRigType.R6);

    if p2 then
        for _, child in v8:GetChildren() do
            if table.find(u1, child.ClassName) then
                Instance.fromExisting(child).Parent = p2;
            elseif child:IsA("Accessory") then
                local v9 = child:FindFirstChild("Handle") or child:FindFirstChildWhichIsA("BasePart");
                local v10 = v9:FindFirstChild("AccessoryWeld") or v9:FindFirstChildOfClass("Weld");

                if v10 then
                    local v11 = p2:FindFirstChild(v10.Part1.Name);
                    v10.Enabled = false;
                    v10.Part1 = v11;
                    child.Parent = p2;
                    v10.Enabled = true;
                else
                    local v12 = v9:FindFirstChildOfClass("Attachment");
                    local v13 = p2:FindFirstChild(v12.Name, true);
                    v9.CFrame = v13.WorldCFrame * v12.CFrame:Inverse();
                    child.Parent = p2;
                    local WeldConstraint = Instance.new("WeldConstraint");
                    WeldConstraint.Parent = v9;
                    WeldConstraint.Part0 = v9;
                    WeldConstraint.Part1 = v13.Parent;
                end;
            end;
        end;

        local v14 = p2:FindFirstChild("Head") and (p2.Head:FindFirstChild("face") or p2.Head:FindFirstChildOfClass("Decal"));
        local v15 = v14 and v8:FindFirstChild("Head") and (v8.Head:FindFirstChild("face") or v8.Head:FindFirstChildOfClass("Decal"));

        if v14 and v15 then
            v14.Texture = v15.Texture;
        end;
    end;

    if not p5 then
        v7:Destroy();
        v8:Destroy();
    end;
end;