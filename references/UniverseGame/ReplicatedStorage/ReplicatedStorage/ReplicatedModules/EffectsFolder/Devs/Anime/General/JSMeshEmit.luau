  

 

local TweenService = game:GetService("TweenService");

local function getTweenData(p1, p2, p3, p4) -- Line: 12
    local v5 = p1:GetAttribute(p3 .. "_TweenParams");
    local v6 = {
        { "TweenStyle", p4 },
        { "TweenDirection", Enum.EasingDirection.Out }
    };
    local u7 = {};

    if typeof(v5) == "string" then
        local v8 = { v5:match("(%a+),(%a+)") };

        for i = 1, 2 do
            local u9 = v8[i];
            local v10 = v6[i];
            local u11 = v10[1];
            local v12 = v10[2];

            if u9 then
                if not pcall(function() -- Line: 45
                    -- upvalues: u7 (copy), u11 (copy), u9 (copy)
                    u7[u11] = Enum[u11][u9];
                end) then
                    u7[u11] = v12;
                end;
            else
                u7[u11] = v12;
            end;
        end;
    else
        for _, v in v6 do
            u7[v[1]] = v[2];
        end;
    end;

    return TweenInfo.new(p2, u7.TweenStyle, u7.TweenDirection);
end;

local function MeshEmit(p13, p14, u15, u16, p17) -- Line: 72
    -- upvalues: MeshEmit (copy), TweenService (copy), getTweenData (copy)
    if p13:IsA("Model") then
        for _, child in p13:GetChildren() do
            MeshEmit(child, p14, u15, u16, p17);
        end;

        return;
    end;

    if not p13:IsA("BasePart") or p13.Name ~= "Start" then
        return;
    end;

    local End = p13.Parent:FindFirstChild("End");

    if not End then
        warn("Goal is not defined.");

        return;
    end;

    local v18 = p13:Clone();
    local v19 = p13.Parent:GetPivot();
    local _ = v19:Inverse() * p13.CFrame;
    local _ = v19:Inverse() * End.CFrame;
    local v20 = p13.Parent:GetPivot();
    local v21 = v20:ToObjectSpace(p13.CFrame);
    local v22 = v20:ToObjectSpace(End.CFrame);
    v18.CFrame = p17 * v21;
    local v23 = p17 * v22;
    local v24 = tonumber(p13.Parent:GetAttribute("StartTransparency")) or 0;

    if v18.Material == Enum.Material.Glass and v24 >= 1 then
        local Highlight = Instance.new("Highlight");
        Highlight.Enabled = false;
        Highlight.Parent = v18;
    end;

    if v18:IsA("MeshPart") then
        v18.Transparency = v24;
    elseif v18:IsA("BasePart") and v18:FindFirstChildOfClass("Decal") then
        v18.Transparency = 1;
    end;

    v18.Parent = workspace.Effects;
    local v25 = tonumber(p13.Parent:GetAttribute("Duration")) or 0.1;

    if v18:FindFirstChildOfClass("Decal") then
        TweenService:Create(v18, getTweenData(p13.Parent, v25, "Part", Enum.EasingStyle.Cubic), {
            Size = End.Size,
            CFrame = v23
        }):Play();
    else
        TweenService:Create(v18, getTweenData(p13.Parent, v25, "Part", Enum.EasingStyle.Cubic), {
            Size = End.Size,
            CFrame = v23,
            Color = End.Color
        }):Play();

        if p14 then
            TweenService:Create(v18, getTweenData(p13.Parent, v25, "Part", Enum.EasingStyle.Cubic), {
                Transparency = 1
            }):Play();
        else
            p13.Parent:GetAttribute("StartTransparency");
        end;
    end;

    local v26 = v18:FindFirstChildOfClass("SpecialMesh");
    local v27 = End:FindFirstChildOfClass("SpecialMesh");

    if v26 and v27 then
        TweenService:Create(v26, getTweenData(p13.Parent, v25, "Mesh", Enum.EasingStyle.Sine), {
            Scale = v27.Scale
        }):Play();
    end;

    local v28 = v18:FindFirstChildOfClass("Decal");
    local v29 = End:FindFirstChildOfClass("Decal");

    if v28 and v29 then
        v28.Transparency = v24;
        TweenService:Create(v28, getTweenData(p13.Parent, v25, "Decal", Enum.EasingStyle.Cubic), {
            Color3 = v29.Color3
        }):Play();

        if p14 then
            TweenService:Create(v28, getTweenData(p13.Parent, v25, "Decal", Enum.EasingStyle.Cubic), {
                Transparency = 1
            }):Play();
        else
            p13.Parent:GetAttribute("StartTransparency");
        end;

        if u15 then
            for _, descendant in ipairs(v18:GetDescendants()) do
                if descendant:IsA("Decal") then
                    task.spawn(function() -- Line: 182
                        -- upvalues: u15 (copy), descendant (copy), u16 (copy)
                        for i = 1, #u15 do
                            descendant.Texture = u15[i];
                            task.wait(u16);
                        end;
                    end);
                end;
            end;
        end;
    end;

    task.delay(v25, v18.Destroy, v18);
end;

return MeshEmit;