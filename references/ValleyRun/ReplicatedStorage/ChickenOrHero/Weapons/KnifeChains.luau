 

 

local KnifeVisibility = require(script.Parent.KnifeVisibility);
local u3 = {
    of = function(p1) -- Line: 18, Name: of
        local v2 = nil;

        for _, child in p1:GetChildren() do
            if child:IsA("Model") and type(child:GetAttribute("Arm")) == "string" then
                v2 = v2 or {};
                table.insert(v2, child);
            end;
        end;

        return v2;
    end
};

function u3.has(p4) -- Line: 29
    -- upvalues: u3 (copy)
    return u3.of(p4) ~= nil;
end;

function u3.holds(p5, p6) -- Line: 35
    -- upvalues: u3 (copy)
    for _, v in u3.of(p5) or {} do
        if v:GetAttribute("Arm") == p6 then
            return true;
        end;
    end;

    return false;
end;

local function rest(p7, p8) -- Line: 45
    for _, child in p7:GetChildren() do
        if child:IsA("Motor6D") and child.Part1 == p8 then
            return child.C0 * child.C1:Inverse();
        end;
    end;

    return CFrame.new(p8.Name == "Left Arm" and -1.5 or 1.5, 0, 0);
end;

function u3.attach(p9, p10) -- Line: 57
    -- upvalues: u3 (copy), rest (copy)
    local v11 = u3.of(p9);
    local Torso = p10:FindFirstChild("Torso");

    if not (v11 and Torso) then
        return nil;
    end;

    local v12 = {
        pieces = {},
        torso = Torso
    };

    for _, v in v11 do
        local v13 = v:FindFirstChild(v:GetAttribute("Root") or "RootPart");
        local v14 = p10:FindFirstChild(v:GetAttribute("Arm"));
        local Attribute = v:GetAttribute("GripC0");
        local Attribute2 = v:GetAttribute("GripC1");

        if v13 and (v13:IsA("BasePart") and (v14 and (v14:IsA("BasePart") and (typeof(Attribute) == "CFrame" and typeof(Attribute2) == "CFrame")))) then
            local ChainStow = v13:FindFirstChild("ChainStow");

            if ChainStow then
                ChainStow:Destroy();
            end;

            local ChainGrip = v13:FindFirstChild("ChainGrip");

            if not (ChainGrip and ChainGrip:IsA("Motor6D")) then
                if ChainGrip then
                    ChainGrip:Destroy();
                end;

                ChainGrip = Instance.new("Motor6D");
                ChainGrip.Name = "ChainGrip";
            end;

            local v15 = rest(Torso, v14) * Attribute;
            ChainGrip.Part0 = Torso;
            ChainGrip.Part1 = v13;
            ChainGrip.C0 = v15;
            ChainGrip.C1 = Attribute2;
            v13.CFrame = Torso.CFrame * v15 * Attribute2:Inverse();
            ChainGrip.Parent = v13;
            table.insert(v12.pieces, {
                held = false,
                chain = v,
                root = v13,
                joint = ChainGrip,
                arm = v14,
                grip = Attribute,
                away = v15
            });
        end;
    end;

    if #v12.pieces > 0 then
        return v12;
    end;

    return nil;
end;

function u3.hold(p16, p17, p18) -- Line: 105
    local v19 = false;

    for _, v in p16.pieces do
        local v20;

        if p17 == true then
            v20 = p18 == nil and true or v.arm.Name == p18;
        else
            v20 = false;
        end;

        if v.held ~= v20 then
            v.held = v20;
            local v21;

            if v20 then
                v21 = v.arm;
            else
                v21 = p16.torso;
            end;

            v.joint.Part0 = v21;
            local v22;

            if v20 then
                v22 = v.grip;
            else
                v22 = v.away;
            end;

            v.joint.C0 = v22;
            v.joint.Transform = CFrame.identity;
            v19 = true;
        end;
    end;

    return v19;
end;

function u3.rescale(p23, u24) -- Line: 122
    -- upvalues: rest (copy)
    local function scaled(p25) -- Line: 123
        -- upvalues: u24 (copy)
        return CFrame.new(p25.Position * u24) * p25.Rotation;
    end;

    for _, v in p23.pieces do
        v.c0 = v.c0 or v.grip;
        v.c1 = v.c1 or v.joint.C1;
        local c0 = v.c0;
        v.grip = CFrame.new(c0.Position * u24) * c0.Rotation;
        v.away = rest(p23.torso, v.arm) * v.grip;
        local c1 = v.c1;
        v.joint.C1 = CFrame.new(c1.Position * u24) * c1.Rotation;
        local v26;

        if v.held then
            v26 = v.grip;
        else
            v26 = v.away;
        end;

        v.joint.C0 = v26;
    end;
end;

function u3.show(p27, p28) -- Line: 137
    -- upvalues: KnifeVisibility (copy)
    local v29 = p28 == true;

    if p27.shown == v29 then
        return;
    end;

    p27.shown = v29;

    for _, v in p27.pieces do
        KnifeVisibility.set(v.chain, v29);
    end;
end;

function u3.followers(p30, p31) -- Line: 154
    local v32 = {};

    for _, descendant in (p31 or p30):GetDescendants() do
        if (descendant:IsA("Motor6D") or descendant:IsA("Weld")) and (descendant.Part0 and (descendant.Part1 and descendant.Enabled)) then
            v32[descendant.Part1] = descendant;
        end;
    end;

    local v33 = nil;

    for _, descendant in p30:GetDescendants() do
        if descendant:IsA("RigidConstraint") and (descendant.Attachment0 and descendant.Attachment1) then
            local Attachment1 = descendant.Attachment1;
            local Attachment0 = descendant.Attachment0;

            if Attachment1:IsA("Bone") then
                local v34 = Attachment0;
                Attachment0 = Attachment1;
                Attachment1 = v34;
            end;

            local Parent = Attachment1.Parent;

            if Attachment0:IsA("Bone") and (Parent and Parent:IsA("BasePart")) then
                Parent.Anchored = true;
                descendant.Enabled = false;
                local v35 = Attachment0;
                local v36 = {};

                while Attachment0 and Attachment0:IsA("Bone") do
                    table.insert(v36, 1, Attachment0);
                    Attachment0 = Attachment0.Parent;
                end;

                if Attachment0 and Attachment0:IsA("BasePart") then
                    v33 = v33 or {};
                    table.insert(v33, {
                        part = Parent,
                        own = Attachment1,
                        bone = v35,
                        bones = v36,
                        holder = Attachment0,
                        joints = v32
                    });
                end;
            end;
        end;
    end;

    return v33;
end;

local function posed(p37, p38, p39) -- Line: 190
    -- upvalues: posed (copy)
    local v40 = p38[p37];

    if not (v40 and (not p37.Anchored and p39 <= 8)) then
        return p37.CFrame;
    end;

    local v41;

    if v40:IsA("Motor6D") then
        v41 = v40.Transform;
    else
        v41 = CFrame.identity;
    end;

    return posed(v40.Part0, p38, p39 + 1) * v40.C0 * v41 * v40.C1:Inverse();
end;

function u3.place(p42) -- Line: 201
    -- upvalues: posed (copy)
    for _, v in p42 do
        if v.part.Parent and v.bone.Parent then
            local v43 = posed(v.holder, v.joints, 0);
            local v44 = v;

            for _, v2 in v.bones do
                v43 = v43 * (v2.CFrame * v2.Transform);
            end;

            v44.part.CFrame = v43 * v44.own.CFrame:Inverse();
        end;
    end;
end;

function u3.healthy(p45, p46, p47) -- Line: 214
    if p45.torso.Parent ~= p47 then
        return false;
    end;

    for _, v in p45.pieces do
        local joint = v.joint;

        if v.chain.Parent ~= p46 or (v.root.Parent ~= v.chain or (v.arm.Parent ~= p47 or (joint.Parent ~= v.root or joint.Part1 ~= v.root))) then
            return false;
        end;

        local v48;

        if v.held then
            v48 = v.arm;
        else
            v48 = p45.torso;
        end;

        if joint.Part0 ~= v48 then
            return false;
        end;
    end;

    return true;
end;

return table.freeze(u3);