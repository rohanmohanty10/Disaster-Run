  

 

local TweenService = game:GetService("TweenService");

local function getTweenData(p1, p2, p3, p4) -- Line: 10
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
                if not pcall(function() -- Line: 38
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

return function(p13, p14) -- Line: 62
    -- upvalues: TweenService (copy), getTweenData (copy)
    local End = p13.Parent:FindFirstChild("End");

    if not End then
        warn("Goal is not defined.");

        return;
    end;

    local v15 = p13:Clone();
    local v16 = tonumber(p13.Parent:GetAttribute("StartTransparency")) or 0;

    if v15.Material == Enum.Material.Glass and v16 >= 1 then
        local Highlight = Instance.new("Highlight");
        Highlight.Enabled = false;
        Highlight.Parent = v15;
        print(Highlight);
    end;

    if v15:IsA("MeshPart") then
        v15.Transparency = v16;
    elseif v15:IsA("BasePart") and v15:FindFirstChildOfClass("Decal") then
        v15.Transparency = 1;
    end;

    v15.Parent = workspace.Effects;
    local v17 = tonumber(p13.Parent:GetAttribute("Duration")) or 0.1;

    if v15:FindFirstChildOfClass("Decal") then
        TweenService:Create(v15, getTweenData(p13.Parent, v17, "Part", Enum.EasingStyle.Cubic), {
            Size = End.Size,
            CFrame = End.CFrame
        }):Play();
    else
        TweenService:Create(v15, getTweenData(p13.Parent, v17, "Part", Enum.EasingStyle.Cubic), {
            Size = End.Size,
            CFrame = End.CFrame,
            Color = End.Color
        }):Play();

        if p14 == true then
            TweenService:Create(v15, getTweenData(p13.Parent, v17, "Part", Enum.EasingStyle.Cubic), {
                Transparency = 1
            }):Play();
        else
            v15.Transparency = 0;
        end;
    end;

    local v18 = v15:FindFirstChildOfClass("SpecialMesh");
    local v19 = End:FindFirstChildOfClass("SpecialMesh");

    if v18 and v19 then
        TweenService:Create(v18, getTweenData(p13.Parent, v17, "Mesh", Enum.EasingStyle.Sine), {
            Scale = v19.Scale
        }):Play();
    end;

    local v20 = v15:FindFirstChildOfClass("Decal");
    local v21 = End:FindFirstChildOfClass("Decal");

    if v20 and v21 then
        v20.Transparency = v16;
        TweenService:Create(v20, getTweenData(p13.Parent, v17, "Decal", Enum.EasingStyle.Cubic), {
            Color3 = v21.Color3
        }):Play();

        if p14 == true then
            TweenService:Create(v20, getTweenData(p13.Parent, v17, "Decal", Enum.EasingStyle.Cubic), {
                Transparency = 1
            }):Play();
        else
            v20.Transparency = 0;
        end;
    end;

    task.delay(v17, v15.Destroy, v15);
end;