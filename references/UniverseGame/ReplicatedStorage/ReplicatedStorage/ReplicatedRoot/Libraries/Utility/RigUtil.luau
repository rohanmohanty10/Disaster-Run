  

 

local u3 = {
    GetPartFromMotorDescendants = function(p1, p2) -- Line: 3, Name: GetPartFromMotorDescendants
        for _, descendant in pairs(p1:GetDescendants()) do
            if descendant:IsA("Motor6D") then
                if descendant.Part0 and descendant.Part0.Name == p2 then
                    return descendant.Part0;
                end;

                if descendant.Part1 and descendant.Part1.Name == p2 then
                    return descendant.Part1;
                end;
            end;
        end;

        return nil;
    end
};

function u3.GetMotorTree(p4, p5) -- Line: 17
    -- upvalues: u3 (copy)
    if p4:IsA("Model") then
        p4 = p4:FindFirstChild("RootJoint", true);
    end;

    if not p4 then
        return {};
    end;

    local v6 = p5 or {};
    v6[p4] = true;
    local v7 = {
        Motor = p4,
        Connected = {}
    };

    for _, v in pairs(p4.Part1:GetJoints()) do
        if v:IsA("Motor6D") and not v6[v] then
            table.insert(v7.Connected, u3.GetMotorTree(v, v6));
            v6[v] = true;
        end;
    end;

    return v7;
end;

function u3.IterateMotorTree(p8, p9, ...) -- Line: 43
    -- upvalues: u3 (copy)
    p9(p8);

    for _, v in pairs(p8.Connected) do
        u3.IterateMotorTree(v, p9, ...);
    end;
end;

function u3.GenerateRig(p10) -- Line: 50
    local v11 = p10 or {};
    local Joints = v11.Joints;

    if not (Joints and next(Joints)) then
        return;
    end;

    local u12 = v11.JointName or "Pivot";
    local v13 = v11.WeldParts == nil and true or v11.WeldParts;
    local v14 = v11.Unanchor == nil and true or v11.Unanchor;
    local u15 = {};
    local u16 = {};
    local u17 = {};

    local function GetPivot(p18) -- Line: 66
        -- upvalues: u12 (copy)
        return p18:FindFirstChild(u12);
    end;

    local function CreateJoint(p19, p20) -- Line: 70
        -- upvalues: u12 (copy), u15 (copy), CreateJoint (copy), u17 (copy), u16 (copy)
        local v21 = p19:GetChildren();
        local v22 = p19:FindFirstChild(u12);

        if not v22 then
            return;
        end;

        u15[p19.Name] = v22;

        for _, v in pairs(v21) do
            if v:IsA("Model") then
                if v:FindFirstChild(u12) then
                    CreateJoint(v, v22);
                else
                    for _, descendant in pairs(v:GetDescendants()) do
                        table.insert(v21, descendant);
                    end;
                end;
            elseif v:IsA("BasePart") and not table.find(u17, v) then
                table.insert(u17, v);
            end;
        end;

        if not p20 then
            return;
        end;

        local v23 = nil;

        if p20:IsA("Model") then
            p20 = p20:FindFirstChild(u12);
        elseif not p20:IsA("BasePart") then
            p20 = v23;
        end;

        local Motor6D = Instance.new("Motor6D");
        Motor6D.Part0 = p20;
        Motor6D.Part1 = v22;
        Motor6D.C0 = p20.CFrame:ToObjectSpace(v22.CFrame);
        Motor6D.C1 = CFrame.identity;
        Motor6D.Name = p19.Name;
        Motor6D.Parent = p20;
        u16[Motor6D.Name] = Motor6D;
    end;

    for _, v in pairs(Joints) do
        CreateJoint(v.Target, v.Root);
    end;

    for _, v in pairs(u17) do
        if v13 then
            local v24 = v.Parent:FindFirstChild(u12);

            if v24 and v ~= v24 then
                local v25 = v:GetConnectedParts();

                if not table.find(v25, v24) then
                    local Weld = Instance.new("Weld");
                    Weld.Part0 = v24;
                    Weld.Part1 = v;
                    Weld.C0 = v24.CFrame:ToObjectSpace(v.CFrame);
                    Weld.Name = v.Name;
                    Weld.Parent = v;
                end;

                if v14 then
                    v.Anchored = false;
                end;
            end;
        elseif v14 then
            v.Anchored = false;
        end;
    end;

    for i, v in pairs(u15) do
        v.Name = i;
    end;

    if v14 then
        for _, v in pairs(u17) do
            v.Anchored = false;
        end;
    end;

    return {
        Pivots = u15,
        Motors = u16,
        Parts = u17
    };
end;

function u3.WeldModel(p26, p27) -- Line: 160
    -- upvalues: u3 (copy)
    local v28 = p27 or {};
    v28.Pivot = p26:FindFirstChild("Pivot") or (v28.LastPivot or p26.PrimaryPart);

    for _, child in pairs(p26:GetChildren()) do
        if child:IsA("BasePart") and v28.Pivot ~= nil then
            local v29 = child:GetConnectedParts();

            if not table.find(v29, v28.Pivot) then
                local Weld = Instance.new("Weld");
                Weld.Part0 = v28.Pivot;
                Weld.Part1 = child;
                Weld.C0 = v28.Pivot.CFrame:ToObjectSpace(child.CFrame);
                Weld.Name = child.Name;
                Weld.Parent = child;
            end;
        elseif child:IsA("Model") then
            u3.WeldModel(child, v28);
        end;
    end;
end;

function u3.WeldPart(p30) -- Line: 181
    local v31 = p30 or {};
    local v32 = v31.Type or "Weld";
    local Part0 = v31.Part0;
    local Part1 = v31.Part1;
    local C0 = v31.C0;
    local C1 = v31.C1;
    local v33 = v31.Parent or (Part0 or Part1);
    local v34 = Instance.new(v32);
    v34.Part0 = Part0;
    v34.Part1 = Part1;

    if v32 ~= "WeldConstraint" then
        v34.C0 = C0;
        v34.C1 = C1;
    end;

    v34.Parent = v33;

    return v34;
end;

function u3.SwapRig(p35) -- Line: 210
    -- upvalues: u3 (copy)
    local v36 = p35 or {};
    local Rig = v36.Rig;
    local TargetRig = v36.TargetRig;
    local CleanRig = v36.CleanRig;
    local _ = v36.UngroupRig;
    local v37 = {};

    for _, descendant in pairs(Rig:GetDescendants()) do
        if descendant:IsA("Motor6D") then
            local Part0 = descendant.Part0;
            local v38, v39, v40;

            if v36.Joints == nil then
                if Part0 ~= nil then
                    v38 = u3.GetPartFromMotorDescendants(TargetRig, Part0.Name);
                    v39 = descendant.C0;
                    v40 = descendant.C1;

                    if v38 ~= nil then
                        descendant.Part0 = v38;
                        descendant.C0 = v39;
                        descendant.C1 = v40;

                        if descendant.Parent == Part0 then
                            descendant.Parent = v38;
                            table.insert(v37, descendant);
                        end;
                    end;
                end;
            elseif v36.Filter ~= "Exclude" or not v36.Joints[descendant.Name] then
                if v36.Filter ~= "Include" and v36.Filter ~= nil or v36.Joints[descendant.Name] then
                    if Part0 ~= nil then
                        v38 = u3.GetPartFromMotorDescendants(TargetRig, Part0.Name);
                        v39 = descendant.C0;
                        v40 = descendant.C1;

                        if v38 ~= nil then
                            descendant.Part0 = v38;
                            descendant.C0 = v39;
                            descendant.C1 = v40;

                            if descendant.Parent == Part0 then
                                descendant.Parent = v38;
                                table.insert(v37, descendant);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if CleanRig == true then
        local v41 = TargetRig:FindFirstChild("RootJoint", true) or TargetRig:FindFirstChildWhichIsA("Motor6D");
        local v42;

        if v41 then
            v42 = v41.Part0 or v41.Part1;
        else
            v42 = v41;
        end;

        local Parent = Rig.Parent;
        Rig.Parent = v41.Parent;

        if v42 then
            v42 = v42:GetConnectedParts(true);
        end;

        Rig.Parent = Parent;

        for _, descendant in pairs(Rig:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if not table.find(v42, descendant) then
                    descendant:Destroy();
                end;

                if descendant.Parent ~= nil and (descendant.Parent ~= Rig and (descendant:GetChildren() == 0 and (descendant.Parent:IsA("Model") or descendant.Parent:IsA("Folder")))) then
                    descendant.Parent:Destroy();
                end;
            end;

            if descendant:IsA("Accessory") then
                local Handle = descendant:FindFirstChild("Handle");

                if Handle and not table.find(v42, Handle) or Handle == nil then
                    descendant:Destroy();
                end;
            end;

            if descendant:IsA("Humanoid") or (descendant:IsA("BodyColors") or (descendant:IsA("Clothing") or descendant:IsA("CharacterMesh"))) then
                descendant:Destroy();
            end;
        end;
    end;

    return v37;
end;

function u3.BindRig(p43) -- Line: 288
    local u44 = p43 or {};
    u44.Cleanup = u44.Cleanup or {};
    local Rig = u44.Rig;
    local TargetRig = u44.TargetRig;

    local function Iterate(p45, p46) -- Line: 295
        -- upvalues: TargetRig (copy), u44 (copy), Iterate (copy)
        local v47 = nil;
        local v48 = nil;

        for _, descendant in pairs(TargetRig:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Name == p45.Name then
                v48 = descendant;
                break;
            end;
        end;

        if p45:IsA("Model") then
            v47 = p45:FindFirstChild("Pivot");
        elseif p45:IsA("BasePart") then
            if p46 then
                v47 = p45;
            end;
        end;

        if v47 and v48 then
            if u44.Callback then
                u44.Callback(u44, v47, v48);
            end;

            local Weld = Instance.new("Weld");
            Weld.Name = "BindWeld";
            Weld.Part0 = v48;
            Weld.Part1 = v47;
            Weld.Parent = v48;
            table.insert(u44.Cleanup, Weld);
        end;

        for _, child in pairs(p45:GetChildren()) do
            Iterate(child, false);
        end;
    end;

    if Rig:IsA("Model") then
        if Rig:FindFirstChild("Pivot") then
            Iterate(Rig, true);
        else
            for _, child in pairs(Rig:GetChildren()) do
                Iterate(child, true);
            end;
        end;
    elseif Rig:IsA("BasePart") then
        Iterate(Rig, false);
    end;

    return u44.Cleanup;
end;

u3.BodyParts = { "HumanoidRootPart", "Head", "Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg", "UpperTorso", "LowerTorso", "RightUpperArm", "RightLowerArm", "RightHand", "RightUpperLeg", "RightLowerLeg", "RightFoot", "LeftUpperArm", "LeftLowerArm", "LeftHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot" };

function u3.SetBodyTransparency(p49, p50) -- Line: 370
    -- upvalues: u3 (copy)
    if typeof(p50) == "number" then
        for _, child in pairs(p49:GetChildren()) do
            if child:IsA("BasePart") and table.find(u3.BodyParts, child.Name) then
                child.Transparency = p50;
            end;
        end;

        return;
    end;

    if typeof(p50) == "table" then
        for _, child in pairs(p49:GetChildren()) do
            if child:IsA("BasePart") and table.find(u3.BodyParts, child.Name) then
                child.Transparency = p50[child.Name] or (p50.Default or child.Transparency);
            end;
        end;
    end;
end;

function u3.SetAccessoryVisible(p51, p52) -- Line: 386
    for _, child in pairs(p51:GetChildren()) do
        if child:IsA("Accessory") or child:IsA("Hat") then
            for _, descendant in pairs(child:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    if not descendant:GetAttribute("OriginalTransparency") then
                        descendant:SetAttribute("OriginalTransparency", descendant.Transparency);
                    end;

                    descendant.Transparency = p52 == true and descendant:GetAttribute("OriginalTransparency") or (typeof(p52) == "number" and (descendant:GetAttribute("OriginalTransparency") * (1 - p52) or 1) or 1);
                end;
            end;
        end;
    end;
end;

function u3.SetFaceVisible(p53, p54) -- Line: 403
    local Head = p53:FindFirstChild("Head");

    if Head then
        local face = Head:FindFirstChild("face");

        if face and not face:GetAttribute("OriginalTransparency") then
            face:SetAttribute("OriginalTransparency", face.Transparency);
        end;

        face.Transparency = p54 == true and face:GetAttribute("OriginalTransparency") or (typeof(p54) == "number" and (face:GetAttribute("OriginalTransparency") * (1 - p54) or 1) or 1);
    end;
end;

function u3.RemoveAccessories(p55) -- Line: 418
    for _, child in pairs(p55:GetChildren()) do
        if child:IsA("Accessory") or child:IsA("Hat") then
            child:Destroy();
        end;
    end;
end;

function u3.RemoveFace(p56) -- Line: 426
    local Head = p56:FindFirstChild("Head");
    local v57 = Head and Head:FindFirstChild("face");

    if v57 then
        v57:Destroy();
    end;
end;

function u3.EditAccessories(p58, p59) -- Line: 436
    for _, child in pairs(p58:GetChildren()) do
        if child:IsA("Accessory") or child:IsA("Hat") then
            local v60 = child:IsA("Accessory") and child.AccessoryType or Enum.AccessoryType.Unknown;
            local v61 = nil;

            if typeof(p59) == "table" then
                if p59[v60.Name] == nil then
                    v61 = p59.Default == nil and true or p59.Default;
                else
                    v61 = p59[v60.Name];
                end;
            elseif typeof(p59) == "boolean" or typeof(p59) == "number" then
                v61 = p59;
            end;

            if typeof(v61) == "number" then
                if child:FindFirstChild("Handle") then
                    if not child.Handle:GetAttribute("OriginalTransparency") then
                        child.Handle:SetAttribute("OriginalTransparency", v61);
                    end;

                    child.Handle.Transparency = v61;
                end;
            elseif v61 == false then
                child:Destroy();
            end;
        end;
    end;
end;

function u3.EditClothing(p62, p63) -- Line: 465
    for _, child in pairs(p62:GetChildren()) do
        if child:IsA("Shirt") then
            local v64 = nil;

            if typeof(p63) == "table" then
                if p63.Shirt == nil then
                    v64 = p63.Default;
                else
                    v64 = p63.Shirt;
                end;
            elseif typeof(p63) == "boolean" then
                v64 = p63;
            end;

            if v64 == false then
                child:Destroy();
            end;
        elseif child:IsA("Pants") then
            local v65 = nil;

            if typeof(p63) == "table" then
                if p63.Pants == nil then
                    v65 = p63.Default;
                else
                    v65 = p63.Pants;
                end;
            elseif typeof(p63) == "boolean" then
                v65 = p63;
            end;

            if v65 == false then
                child:Destroy();
            end;
        elseif child:IsA("ShirtGraphic") then
            local v66 = nil;

            if typeof(p63) == "table" then
                if p63.TShirt == nil then
                    v66 = p63.Default;
                else
                    v66 = p63.TShirt;
                end;
            elseif typeof(p63) == "boolean" then
                v66 = p63;
            end;

            if v66 == false then
                child:Destroy();
            end;
        end;
    end;
end;

function u3.SetPhysics(p67, p68) -- Line: 501
    local v69;

    if typeof(p68) == "boolean" then
        v69 = {};
        local _ = p68 == false;
        v69.Anchored = false;
        local _ = p68 == false;
        v69.CanCollide = false;
        local _ = p68 == false;
        v69.Massless = false;
    else
        v69 = p68;
    end;

    local v70 = v69 or {};

    for _, descendant in pairs(p67:GetDescendants()) do
        if descendant:IsA("BasePart") then
            if v70.Anchored ~= nil then
                descendant.Anchored = v70.Anchored;
            end;

            if v70.CanCollide ~= nil then
                descendant.CanCollide = v70.CanCollide;
            end;

            if v70.Massless ~= nil then
                descendant.Massless = v70.Massless;
            end;
        end;
    end;
end;

return u3;