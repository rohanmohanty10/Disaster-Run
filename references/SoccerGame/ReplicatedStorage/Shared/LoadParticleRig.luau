  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Trove = require(ReplicatedStorage.Shared.Trove);
local u1 = {
    Torso = true,
    Head = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    HumanoidRootPart = true
};

local function getInstancePath(p2: userdata) -- Line: 37
    local v3 = {};

    while p2 do
        table.insert(v3, p2.Name);
        p2 = p2.Parent;
    end;

    return v3;
end;

return function(p4: userdata, p5: userdata) -- Line: 51, Name: LoadParticleRig
    -- upvalues: Trove (copy), u1 (copy)
    local v6 = Trove.new();
    local Folder = Instance.new("Folder");
    Folder.Parent = p4;
    v6:Add(Folder);
    v6:AttachToInstance(Folder);
    local v7 = {};
    local v8 = {};
    local v9 = {};
    local v10 = {};

    for i in u1 do
        v8[i] = p5:FindFirstChild(i);
        v9[i] = p4:FindFirstChild(i);

        for _, child in v8[i]:GetChildren() do
            if child:IsA("Attachment") then
                v10[child.Name] = child;
            end;
        end;

        for _, child in p4:FindFirstChild(i):GetChildren() do
            if child:IsA("Attachment") then
                v7[child.Name] = child;
            end;
        end;
    end;

    local Descendants = p5:GetDescendants();

    for _, v in Descendants do
        if v:IsA("WeldConstraint") and (v.Part0 and v.Part1) then
            local v11 = v.Part0.CFrame:ToObjectSpace(v.Part1.CFrame);
            v.Part0 = v9[v.Part0.Name] or v.Part0;
            v.Part1 = v9[v.Part1.Name] or v.Part1;
            v.Enabled = false;
            v.Part1.CFrame = v.Part0.CFrame:ToWorldSpace(v11);
            v.Enabled = true;
        elseif v:IsA("Weld") and (v.Part0 and v.Part1) then
            local v12 = v9[v.Part0.Name] or v.Part0;
            local v13 = v9[v.Part1.Name] or v.Part1;
            v.Part0 = v12;
            v.Part1 = v13;

            if v12:IsDescendantOf(p4) then
                v.Parent = v12;
                v6:Add(v);
            end;
        elseif v:IsA("RigidConstraint") or (v:IsA("Trail") or v:IsA("Beam")) then
            local Attachment0 = v.Attachment0;
            local Attachment1 = v.Attachment1;

            if Attachment0 and (v10[Attachment0.Name] and (v8[Attachment0.Parent.Name] and v7[Attachment0.Name])) then
                v.Attachment0 = v7[Attachment0.Name];
            end;

            if Attachment1 and (v10[Attachment1.Name] and (v8[Attachment1.Parent.Name] and v7[Attachment1.Name])) then
                v.Attachment1 = v7[Attachment1.Name];
            end;
        end;

        if v:HasTag("RigVFX") then
            local v14 = v;
            local v15 = v14;
            local v16 = v14;
            v14 = v15;
            v16 = v15;
            local v17 = {};

            while v15 do
                table.insert(v17, v15.Name);
                v15 = v15.Parent;
            end;

            local v18 = p4;

            for i = #v17 - 1, 2, -1 do
                p4 = p4:FindFirstChild(v17[i]);
                local _ = i;
            end;

            if p4 then
                v14.Parent = p4;
            else
                warn(`invalid instance path for {v14}`, v17);
            end;

            v6:Add(v14);
            p4 = v18;
        end;
    end;

    return v6, Descendants;
end;