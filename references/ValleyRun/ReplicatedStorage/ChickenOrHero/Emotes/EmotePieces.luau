 

 

local u1 = {};
local Random_new_ret = Random.new();
u1.HIDE_TAG = "EmotePieceHidden";

local function looksOf(p2, p3) -- Line: 13
    -- upvalues: Random_new_ret (copy)
    local v4;

    if type(p2.Looks) == "string" then
        v4 = script.Parent.Assets:FindFirstChild(p2.Looks);
    else
        v4 = false;
    end;

    if v4 then
        local v5 = {};

        for _, child in v4:GetChildren() do
            if child:IsA("Model") and child.PrimaryPart then
                table.insert(v5, child);
            end;
        end;

        for i = #v5, 2, -1 do
            local v6 = Random_new_ret:NextInteger(1, i);
            local v7 = v5[i];
            v5[i] = v5[v6];
            v5[v6] = v7;
            local _ = i;
        end;

        if #v5 > 0 then
            return v5;
        end;

        return nil;
    end;

    local v8;

    if p3 then
        v8 = p3:FindFirstChild("Blade");
    else
        v8 = p3;
    end;

    if p3 then
        p3 = p3:FindFirstChild("Handle");
    end;

    if p3 then
        p3 = p3:FindFirstChild("BladeWeld");
    end;

    if v8 and (v8:IsA("BasePart") and (p3 and p3:IsA("JointInstance"))) then
        return nil, v8, p3;
    end;

    return nil;
end;

function u1.build(p9, p10, p11, p12) -- Line: 39
    -- upvalues: looksOf (copy), u1 (copy)
    local v13 = {};
    local HumanoidRootPart = p9:FindFirstChild("HumanoidRootPart");
    local v14, v15, v16 = looksOf(p10, p11);

    if not (HumanoidRootPart and (v14 or v15)) then
        return v13;
    end;

    local v17 = {};

    for _, v in v14 or {} do
        v17[v.Name] = v;
    end;

    for i, v in p10.Pieces do
        local v18 = p10.PieceJoints and p10.PieceJoints[v];
        local v19;

        if v18 then
            v19 = p9:FindFirstChild(v18.Part0) or HumanoidRootPart;
        else
            v19 = HumanoidRootPart;
        end;

        local Part = Instance.new("Part");
        Part.Name = v;
        Part:SetAttribute("EmotePiece", true);
        Part.Size = Vector3.new(0.2, 0.2, 0.2);
        Part.Transparency = 1;
        local v20;

        if v18 and p9:FindFirstChild(v18.Part0) then
            v20 = p9[v18.Part0];
        else
            v20 = HumanoidRootPart;
        end;

        Part.CFrame = v20.CFrame * (v18 and v18.C0 or CFrame.identity);
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.Massless = true;

        if typeof(p10.HidePieces) == "CFrame" then
            Part:SetAttribute("PieceEmote", p10.Id);
            Part:AddTag(u1.HIDE_TAG);
        end;

        local v21, v22, v23;

        if v14 then
            v21 = (v17[v] or v14[(i - 1) % #v14 + 1]):Clone();
            v22 = CFrame.identity;
            v23 = v21.PrimaryPart.CFrame:ToObjectSpace(v21:GetPivot());
        else
            v21 = v15:Clone();
            v21.Name = "Blade";
            require(script.Parent.Parent.Weapons.KnifeVisibility).set(v21, true);
            v22 = v16.C0;
            v23 = v16.C1;

            if v18 and v18.Blade then
                local v24;

                if type(p10.Prop) == "string" then
                    v24 = p11.Parent and p11.Parent:FindFirstChild(p10.Prop);
                else
                    v24 = false;
                end;

                if v24 then
                    if v24 == p11 then
                        v24 = false;
                    else
                        v24 = v24:FindFirstChild("Handle");
                    end;
                end;

                if v24 then
                    v24 = v24:FindFirstChild("BladeWeld");
                end;

                if v24 and v24:IsA("JointInstance") then
                    v22 = v18.Blade * (v24.C0 * v24.C1:Inverse()):Inverse() * v16.C0;
                    v23 = v16.C1;
                else
                    local v25 = not v18.BladeLength and 1 or math.max(v15.Size.X, v15.Size.Y, v15.Size.Z) / v18.BladeLength;
                    v22 = v18.Blade.Rotation + v18.Blade.Position * v25;
                    v23 = CFrame.identity;
                end;
            end;
        end;

        for _, v2 in { v21, table.unpack(v21:GetDescendants()) } do
            if v2:IsA("BasePart") then
                v2.Anchored = false;
                v2.CanCollide = false;
                v2.CanTouch = false;
                v2.CanQuery = false;
                v2.Massless = true;
            end;
        end;

        local v26;

        if v14 then
            v26 = v21.PrimaryPart;
        else
            v26 = v21;
        end;

        if v14 then
            v21:PivotTo(Part.CFrame);
        else
            v21.CFrame = Part.CFrame * v22 * v23:Inverse();
        end;

        local Weld = Instance.new("Weld");
        Weld.Name = "PieceWeld";
        Weld.Part0 = Part;
        Weld.Part1 = v26;
        Weld.C0 = v22;
        Weld.C1 = v23;
        Weld.Parent = v26;
        v21.Parent = Part;
        local Motor6D = Instance.new("Motor6D");
        Motor6D.Name = v;
        Motor6D.Part0 = v19;
        Motor6D.Part1 = Part;
        Motor6D.C0 = v18 and v18.C0 or CFrame.identity;
        Motor6D.Parent = Part;
        Part.Parent = p12;
        table.insert(v13, Part);
    end;

    return v13;
end;

local u27 = setmetatable({}, {
    __mode = "k"
});

local function clipId(p28) -- Line: 132
    local string_match = string.match;
    local v29 = tostring(p28 or "");

    return tonumber(string_match(v29, "%d+$"));
end;

function u1.hold(p30, p31) -- Line: 135
    -- upvalues: u27 (copy)
    local v32 = p30:FindFirstChild(p30.Name);
    local v33;

    if p31 then
        v33 = p31.HidePieces;
    else
        v33 = p31;
    end;

    if not (v32 and (v32:IsA("Motor6D") and typeof(v33) == "CFrame")) then
        return;
    end;

    local v34 = v32.Part0 and v32.Part0.Parent;

    if v34 then
        v34 = v34:FindFirstChildOfClass("Humanoid");
    end;

    if v34 then
        v34 = v34:FindFirstChildOfClass("Animator");
    end;

    local string_match = string.match;
    local v35 = tostring(p31.Intro or "");
    local v36 = tonumber(string_match(v35, "%d+$"));
    local string_match2 = string.match;
    local v37 = tostring(p31.Animation or "");
    local v38 = tonumber(string_match2(v37, "%d+$"));
    local v39 = 0;
    local v40 = false;

    for _, v in not v34 and {} or v34:GetPlayingAnimationTracks() do
        local Animation = v.Animation;

        if Animation then
            local string_match3 = string.match;
            local v41 = tostring(v.Animation.AnimationId or "");
            Animation = tonumber(string_match3(v41, "%d+$"));
        end;

        if Animation and (Animation == v36 or Animation == v38) then
            v39 = v39 + v.WeightCurrent;
            v40 = v40 or v.IsPlaying;
        end;
    end;

    if v40 then
        if v39 >= 0.95 then
            u27[p30] = v32.Transform;

            return;
        end;
    else
        u27[p30] = nil;
    end;

    v32.Transform = u27[p30] or v33;
end;

function u1.clear(p42) -- Line: 162
    for _, v in p42 do
        v:Destroy();
    end;

    table.clear(p42);
end;

function u1.strip(p43) -- Line: 170
    for _, child in p43:GetChildren() do
        if child:GetAttribute("EmotePiece") == true then
            child:Destroy();
        end;
    end;
end;

return table.freeze(u1);