  

 

local u1 = {};
u1.__index = u1;

local function Recursive(p2, p3, p4) -- Line: 4
    -- upvalues: Recursive (copy)
    for _, child in pairs(p2:GetChildren()) do
        local v5 = p3(child);

        if v5 ~= false then
            if v5 == true then
                table.insert(p4, child);
            end;

            Recursive(child, p3, p4);
        end;
    end;

    return p4;
end;

function u1.new(p6, p7, p8) -- Line: 17
    -- upvalues: u1 (copy), Recursive (copy)
    local v9 = setmetatable({}, u1);
    v9._Parts = p7;
    v9.Parts = {};

    if p8 == true or p8 == nil then
        v9.Morph = Instance.new("Model");
        v9.Morph.Name = "MorphContainer";
    end;

    for _, v in pairs(v9._Parts) do
        if v.Type == "Weld" then
            local v10 = p6:FindFirstChild(v.Part);

            if v10 then
                v.Model.PrimaryPart = v.Pivot or v.Model.PrimaryPart or (v.Model:FindFirstChild("Pivot") or v.Model:FindFirstChild("Middle"));

                if v.Model.PrimaryPart then
                    local v11 = v.Model:Clone();
                    v11:SetPrimaryPartCFrame(v10.CFrame);
                    local Weld = Instance.new("Weld");
                    Weld.Name = "MainWeld";
                    Weld.Part1 = v10;
                    Weld.Part0 = v11.PrimaryPart;

                    if v.Offset then
                        Weld.C0 = v.Offset.C0 or CFrame.new(0, 0, 0);
                        Weld.C1 = v.Offset.C1 or CFrame.new(0, 0, 0);
                    end;

                    Weld.Parent = v11.PrimaryPart;
                    local v12 = {};
                    Recursive(v11, function(p13) -- Line: 45
                        if p13:IsA("BasePart") and p13.Parent then
                            return (p13.Parent:IsA("BasePart") or (p13.Parent:IsA("Model") or p13.Parent:IsA("Folder"))) and true or false;
                        end;
                    end, v12);

                    for _, v2 in pairs(v12) do
                        v2.Anchored = false;
                        v2.CanCollide = false;
                        v2.Massless = true;
                    end;

                    if not v.DisableWelding then
                        local Folder = Instance.new("Folder");
                        Folder.Name = "Welds";
                        Folder.Parent = v11.PrimaryPart;

                        for _, v2 in pairs(v12) do
                            if v2 ~= v11.PrimaryPart then
                                local Weld2 = Instance.new("Weld");
                                Weld2.Name = v2.Name;
                                Weld2.Part0 = v11.PrimaryPart;
                                Weld2.Part1 = v2;
                                local v14 = CFrame.new(v11.PrimaryPart.Position);
                                Weld2.C0 = v11.PrimaryPart.CFrame:ToObjectSpace(v14);
                                Weld2.C1 = v2.CFrame:ToObjectSpace(v14);
                                Weld2.Parent = Folder;
                            end;
                        end;
                    end;

                    if v9.DeleteSnaps == nil or v9.DeleteSnaps == true then
                        for _, descendant in pairs(v11:GetDescendants()) do
                            if descendant:IsA("Snap") then
                                descendant:Destroy();
                            end;
                        end;
                    end;

                    if v.Ungroup then
                        for _, child in pairs(v11:GetChildren()) do
                            child.Parent = v9.Morph or v9.Character;
                            table.insert(v9.Parts, child);
                        end;
                    else
                        v11.Parent = v9.Morph or v9.Character;
                        table.insert(v9.Parts, v11);
                    end;
                end;
            end;
        end;

        if v.Type == "Reweld" then
            local v15 = p6:FindFirstChild(v.Part);

            if v15 then
                v.Model.PrimaryPart = v.Pivot or v.Model.PrimaryPart or (v.Model:FindFirstChild("Pivot") or v.Model:FindFirstChild("Middle"));

                if v.Model.PrimaryPart then
                    local v16 = v.Model:Clone();
                    v16:SetPrimaryPartCFrame(v15.CFrame);
                    local v17 = {};
                    Recursive(v16, function(p18) -- Line: 105
                        if p18:IsA("BasePart") and p18.Parent then
                            return (p18.Parent:IsA("BasePart") or (p18.Parent:IsA("Model") or p18.Parent:IsA("Folder"))) and true or false;
                        end;
                    end, v17);

                    for _, v2 in pairs(v17) do
                        v2.Anchored = false;
                        v2.CanCollide = false;
                        v2.Massless = true;
                    end;

                    if not v.DisableWelding then
                        local Folder = Instance.new("Folder");
                        Folder.Name = "Welds";
                        Folder.Parent = v16.PrimaryPart;

                        for _, v2 in pairs(v17) do
                            if v2 ~= v16.PrimaryPart then
                                local Weld = Instance.new("Weld");
                                Weld.Name = v2.Name;
                                Weld.Part0 = v16.PrimaryPart;
                                Weld.Part1 = v2;
                                local v19 = CFrame.new(v16.PrimaryPart.Position);
                                Weld.C0 = v16.PrimaryPart.CFrame:ToObjectSpace(v19);
                                Weld.C1 = v2.CFrame:ToObjectSpace(v19);
                                Weld.Parent = Folder;
                            end;
                        end;
                    end;

                    if v9.DeleteSnaps == nil or v9.DeleteSnaps == true then
                        for _, descendant in pairs(v16:GetDescendants()) do
                            if descendant:IsA("Snap") then
                                descendant:Destroy();
                            end;
                        end;
                    end;

                    for _, child in pairs(v16.PrimaryPart:GetChildren()) do
                        child.Parent = v15;

                        if child:IsA("JointInstance") then
                            local C0 = child.C0;
                            local C1 = child.C1;

                            if child.Part0 == v16.PrimaryPart then
                                child.Part0 = v15;
                                child.C0 = C0;
                                child.C1 = C1;
                            end;

                            if child.Part1 == v16.PrimaryPart then
                                child.Part1 = v15;
                                child.C0 = C0;
                                child.C1 = C1;
                            end;
                        end;
                    end;

                    v16.PrimaryPart:Destroy();

                    if v.Ungroup then
                        for _, child in pairs(v16:GetChildren()) do
                            child.Parent = p6;
                            table.insert(v9.Parts, child);
                        end;
                    else
                        v16.Parent = p6;
                        table.insert(v9.Parts, v16);
                    end;
                end;
            end;
        end;
    end;

    return v9;
end;

function u1.Destroy(p20) -- Line: 179
    if p20.Morph then
        p20.Morph:Destroy();
    end;

    for _, v in pairs(p20.Parts) do
        v:Destroy();
    end;

    setmetatable(p20, nil);
end;

return u1;