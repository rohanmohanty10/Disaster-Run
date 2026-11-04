 

 

local EmoteCatalog = require(script.Parent.EmoteCatalog);
local v1 = {};

local function template(p2) -- Line: 20
    -- upvalues: EmoteCatalog (copy)
    local v3 = EmoteCatalog.get(p2);
    local v4;

    if v3 then
        if type(v3.VFX) == "string" then
            v4 = script.Parent.Assets:FindFirstChild("VFX");
        else
            v4 = false;
        end;
    else
        v4 = v3;
    end;

    if v4 then
        v4 = v4:FindFirstChild(v3.VFX);
    end;

    return v3, v4;
end;

function v1.has(p5) -- Line: 26
    -- upvalues: EmoteCatalog (copy)
    local v6 = EmoteCatalog.get(p5);
    local v7;

    if v6 then
        if type(v6.VFX) == "string" then
            v7 = script.Parent.Assets:FindFirstChild("VFX");
        else
            v7 = false;
        end;
    else
        v7 = v6;
    end;

    if v7 then
        v7 = v7:FindFirstChild(v6.VFX);
    end;

    return v7 ~= nil;
end;

local function collect(p8, p9, p10) -- Line: 32
    for _, v in { p9, table.unpack(p9:GetDescendants()) } do
        local Attribute = v:GetAttribute("EmitAt");

        if type(Attribute) == "number" then
            local Attribute2 = v:GetAttribute("EmitIn");

            if Attribute2 ~= "Intro" and Attribute2 ~= "Loop" then
                Attribute2 = p8.defaultPhase;
            end;

            table.insert(p8.groups, {
                inst = v,
                at = Attribute,
                phase = Attribute2
            });

            if p10 and (p10.phase == Attribute2 and (Attribute <= p10.t and p10.t - Attribute <= 1)) then
                table.insert(p8.due, v);
            end;
        end;
    end;
end;

local function track(p11, p12) -- Line: 48
    table.insert(p11, p12);

    return p12;
end;

local function scaled(p13, p14) -- Line: 55
    return CFrame.new(p13.Position * p14) * p13.Rotation;
end;

local function fit(p15, p16) -- Line: 58
    local scale = p15.scale;

    if scale == 1 then
        return;
    end;

    for _, v in { p16, table.unpack(p16:GetDescendants()) } do
        if v:IsA("Attachment") and not v:IsA("Bone") then
            local CFrame2 = v.CFrame;
            v.CFrame = CFrame.new(CFrame2.Position * scale) * CFrame2.Rotation;
        elseif v:IsA("BasePart") then
            v.Size = v.Size * scale;
        end;
    end;
end;

function v1.mount(p17, p18) -- Line: 73
    -- upvalues: EmoteCatalog (copy), fit (copy), collect (copy)
    local v19 = EmoteCatalog.get(p18);
    local v20;

    if v19 then
        if type(v19.VFX) == "string" then
            v20 = script.Parent.Assets:FindFirstChild("VFX");
        else
            v20 = false;
        end;
    else
        v20 = v19;
    end;

    if v20 then
        v20 = v20:FindFirstChild(v19.VFX);
    end;

    if not v20 then
        return nil;
    end;

    local v21 = {
        chain = nil,
        character = p17,
        id = p18,
        folder = v20,
        loopId = EmoteCatalog.assetId(p18),
        introId = EmoteCatalog.introId(p18),
        defaultPhase = EmoteCatalog.introId(p18) and "Intro" or "Loop",
        mounted = {},
        groups = {},
        due = {},
        last = {},
        pieces = {},
        scale = not p17:IsA("Model") and 1 or p17:GetScale()
    };
    local Torso = p17:FindFirstChild("Torso");
    local Torso2 = v20:FindFirstChild("Torso");

    if Torso and Torso2 then
        for _, child in Torso2:GetChildren() do
            local mounted = v21.mounted;
            local v22 = child:Clone();
            table.insert(mounted, v22);
            fit(v21, v22);
            v22.Parent = Torso;
            collect(v21, v22);
        end;
    end;

    local HumanoidRootPart = p17:FindFirstChild("HumanoidRootPart");
    local Root = v20:FindFirstChild("Root");

    if HumanoidRootPart and Root then
        for _, child in Root:GetChildren() do
            if child:IsA("BasePart") then
                local Attribute = child:GetAttribute("RootOffset");

                if typeof(Attribute) ~= "CFrame" then
                    Attribute = CFrame.identity;
                end;

                local v23 = CFrame.new(Attribute.Position * v21.scale) * Attribute.Rotation;
                local mounted = v21.mounted;
                local v24 = child:Clone();
                table.insert(mounted, v24);
                fit(v21, v24);
                v24.Name = "EmoteVFX_" .. child.Name;
                v24.CFrame = HumanoidRootPart.CFrame * v23;
                local Weld = Instance.new("Weld");
                Weld.Part0 = HumanoidRootPart;
                Weld.Part1 = v24;
                Weld.C0 = v23;
                Weld.Parent = v24;
                v24.Parent = p17;
                collect(v21, v24);
            end;
        end;
    end;

    return v21;
end;

local function rightChain(p25) -- Line: 126
    local EquippedDagger = p25:FindFirstChild("EquippedDagger");

    for _, v in not EquippedDagger and {} or EquippedDagger:GetChildren() do
        if v:IsA("Model") and v:GetAttribute("Arm") == "Right Arm" then
            return v;
        end;
    end;

    return nil;
end;

local function mountLate(p26, p27) -- Line: 137
    -- upvalues: fit (copy), collect (copy), rightChain (copy)
    local character = p26.character;
    local Pieces = p26.folder:FindFirstChild("Pieces");
    local EquippedDagger = character:FindFirstChild("EquippedDagger");

    if Pieces and EquippedDagger then
        for _, child in EquippedDagger:GetChildren() do
            if child:GetAttribute("EmotePiece") == true and not p26.pieces[child] then
                local v28 = Pieces:FindFirstChild(child.Name);

                if v28 then
                    p26.pieces[child] = true;
                    local Attribute = v28:GetAttribute("HolderSize");

                    if typeof(Attribute) == "Vector3" and child:IsA("BasePart") then
                        child.Size = Attribute * p26.scale;
                    end;

                    local v29 = child;

                    for _, child2 in v28:GetChildren() do
                        local mounted = p26.mounted;
                        local v30 = child2:Clone();
                        table.insert(mounted, v30);
                        fit(p26, v30);
                        v30.Parent = v29;
                        collect(p26, v30, p27);
                    end;
                end;
            end;
        end;
    end;

    local Bones = p26.folder:FindFirstChild("Bones");
    local v31;

    if Bones then
        v31 = rightChain(character);
    else
        v31 = Bones;
    end;

    if v31 and v31 ~= p26.chain then
        p26.chain = v31;
        local v32 = Bones:Clone();

        for _, child in v32:GetChildren() do
            local v33 = v31:FindFirstChild(child.Name, true);

            if v33 and v33:IsA("Bone") then
                for _, child2 in child:GetChildren() do
                    table.insert(p26.mounted, child2);
                    fit(p26, child2);
                    child2.Parent = v33;
                    collect(p26, child2, p27);
                end;
            end;
        end;

        v32:Destroy();
    end;
end;

local function clip(p34) -- Line: 183
    local v35 = p34.character:FindFirstChildOfClass("Humanoid");

    if v35 then
        v35 = v35:FindFirstChildOfClass("Animator");
    end;

    if not v35 then
        return nil;
    end;

    local v36 = nil;

    for _, v in v35:GetPlayingAnimationTracks() do
        local v37 = v.Animation and v.Animation.AnimationId;

        if v37 == p34.loopId and v.WeightTarget > 0 then
            return {
                phase = "Loop",
                t = v.TimePosition
            };
        end;

        if p34.introId and (v37 == p34.introId and v.WeightTarget > 0) then
            v36 = v;
        end;
    end;

    return v36 and {
        phase = "Intro",
        t = v36.TimePosition
    } or nil;
end;

function v1.update(p38, p39) -- Line: 203
    -- upvalues: clip (copy), mountLate (copy)
    local v40 = clip(p38);
    mountLate(p38, v40);

    for _, v in p38.due do
        p39(v, p38.scale);
    end;

    table.clear(p38.due);

    if not v40 then
        return;
    end;

    local v41 = p38.last[v40.phase];

    if v41 == nil then
        v41 = math.max(-0.01, v40.t - 0.25);
    end;

    local v42 = v40.t < v41;

    for _, v in p38.groups do
        if v.phase == v40.phase and v.inst.Parent and (v42 and (v41 < v.at or v.at <= v40.t) or not (v42 or (v41 >= v.at or v.at > v40.t))) then
            p39(v.inst, p38.scale);
        end;
    end;

    p38.last[v40.phase] = v40.t;
end;

function v1.unmount(p43) -- Line: 228
    for _, v in p43.mounted do
        v:Destroy();
    end;

    table.clear(p43.mounted);
    table.clear(p43.groups);
    table.clear(p43.due);
    table.clear(p43.pieces);
    p43.chain = nil;
end;

return table.freeze(v1);