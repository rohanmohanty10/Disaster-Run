 

 

local u1 = {};
local u2 = { Vector3.new(-1, -1, -1), Vector3.new(-1, -1, 1), Vector3.new(-1, 1, -1), Vector3.new(-1, 1, 1), Vector3.new(1, -1, -1), Vector3.new(1, -1, 1), Vector3.new(1, 1, -1), Vector3.new(1, 1, 1) };

local function look(p3) -- Line: 16
    return p3:IsA("DataModelMesh") or (p3:IsA("Decal") or p3:IsA("SurfaceAppearance"));
end;

function u1.new(p4) -- Line: 21
    -- upvalues: u2 (copy)
    local v5 = p4:Clone();
    local v6 = {};

    for _, descendant in v5:GetDescendants() do
        if descendant:IsDescendantOf(v5) then
            if descendant:IsA("BasePart") then
                if descendant.Transparency < 1 then
                    table.insert(v6, descendant);
                else
                    descendant:Destroy();
                end;
            elseif not (descendant:IsA("DataModelMesh") or (descendant:IsA("Decal") or descendant:IsA("SurfaceAppearance"))) then
                descendant:Destroy();
            end;
        end;
    end;

    v5.Anchored = true;
    v5.CanCollide = false;
    v5.CanTouch = false;
    v5.CanQuery = false;
    v5.Transparency = 0;
    local v7 = -v5.Size / 2;
    local v8 = v5.Size / 2;

    for _, v in v6 do
        local v9 = v5.CFrame:ToObjectSpace(v.CFrame);
        v.Anchored = false;
        v.CanCollide = false;
        v.CanTouch = false;
        v.CanQuery = false;
        v.Massless = true;
        v.CastShadow = false;
        local Weld = Instance.new("Weld");
        Weld.Name = "IconWeld";
        Weld.Part0 = v5;
        Weld.Part1 = v;
        Weld.C0 = v9;
        Weld.Parent = v;
        local v10 = v.Size / 2;

        for _, v2 in u2 do
            local v11 = v9 * (v10 * v2);
            v7 = v7:Min(v11);
            v8 = v8:Max(v11);
        end;
    end;

    return v5, v6, v8 - v7, (v7 + v8) / 2;
end;

function u1.box(p12) -- Line: 61
    -- upvalues: u2 (copy)
    local v13 = -p12.Size / 2;
    local v14 = p12.Size / 2;

    for _, descendant in p12:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Transparency < 1 then
            local v15 = p12.CFrame:ToObjectSpace(descendant.CFrame);
            local v16 = descendant.Size / 2;

            for _, v in u2 do
                local v17 = v15 * (v16 * v);
                v13 = v13:Min(v17);
                v14 = v14:Max(v17);
            end;
        end;
    end;

    return v14 - v13, (v13 + v14) / 2;
end;

local u18 = nil;

function u1.twinSource(p19) -- Line: 81
    -- upvalues: u18 (ref)
    if not p19 then
        return nil;
    end;

    u18 = u18 or require(script.Parent.CombineConfig);

    if p19:GetAttribute("IsDualWield") ~= true and not (u18.DualWield and u18.DualWield[p19.Name]) then
        return nil;
    end;

    local v20 = p19:GetAttribute("LeftBladeFrom") or u18.LeftBlades and u18.LeftBlades[p19.Name];
    local Models = script.Parent:FindFirstChild("Models");

    if type(v20) == "string" and Models then
        p19 = Models:FindFirstChild(v20) or p19;
    end;

    return p19;
end;

local function crossing(p21, p22) -- Line: 95
    local Attribute = p21:GetAttribute("IconCross");

    if typeof(Attribute) == "Vector3" then
        return Attribute;
    end;

    return p22;
end;

function u1.cross(p23, p24, p25, p26, p27) -- Line: 106
    -- upvalues: u1 (copy)
    local v28 = u1.twinSource(p24);
    local v29;

    if v28 then
        v29 = v28:FindFirstChild("Blade");
    else
        v29 = v28;
    end;

    local v30 = p27 or p23:FindFirstChildWhichIsA("BasePart");
    local Blade = p24:FindFirstChild("Blade");

    if not (v29 and (v29:IsA("BasePart") and (v30 and (Blade and Blade:IsA("BasePart"))))) then
        return nil;
    end;

    local _, v31 = u1.box(Blade);
    local CFrame2 = v30.CFrame;
    local Attribute = Blade:GetAttribute("IconCross");

    if typeof(Attribute) == "Vector3" then
        v31 = Attribute;
    end;

    local v32, v33, v34, v35 = u1.new(v29);
    local Rotation = p25(v32, v28).Rotation;
    local v36 = CFrame.new(CFrame2 * v31) * CFrame.fromAxisAngle(p26, 3.141592653589793);
    local CFrame_new = CFrame.new;
    local Attribute2 = v29:GetAttribute("IconCross");

    if typeof(Attribute2) == "Vector3" then
        v35 = Attribute2;
    end;

    v32.CFrame = v36 * CFrame_new(-Rotation:VectorToWorldSpace(v35)) * Rotation;
    v32.Name = "LeftBlade";

    if p27 then
        v32.Anchored = false;
        v32.Massless = true;
        local Weld = Instance.new("Weld");
        Weld.Name = "IconWeld";
        Weld.Part0 = p27;
        Weld.Part1 = v32;
        Weld.C0 = p27.CFrame:ToObjectSpace(v32.CFrame);
        Weld.Parent = v32;
        v32.Parent = p27;
    else
        for _, v in v33 do
            v.Anchored = true;
            v.CFrame = v32.CFrame * v.IconWeld.C0;
        end;

        v32.Parent = p23;
    end;

    return v32, v34;
end;

return table.freeze(u1);