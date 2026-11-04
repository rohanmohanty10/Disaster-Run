 

 

local TweenService = game:GetService("TweenService");

local function getTweenData(p1: userdata, p2: number, p3: string, p4: any) -- Line: 10
    local Attribute = p1:GetAttribute(p3 .. "_TweenParams");
    local v5 = {
        { "TweenStyle", p4 },
        { "TweenDirection", Enum.EasingDirection.Out }
    };
    local u6 = {};

    if typeof(Attribute) == "string" then
        local v7 = { Attribute:match("(%a+),(%a+)") };

        for i = 1, 2 do
            local u8 = v7[i];
            local v9 = v5[i];
            local u10 = v9[1];
            local v11 = v9[2];
            local v12;

            if u8 then
                if pcall(function() -- Line: 38
                    -- upvalues: u6 (copy), u10 (copy), u8 (copy)
                    u6[u10] = Enum[u10][u8];
                end) then
                    v12 = i;
                else
                    u6[u10] = v11;
                    v12 = i;
                end;
            else
                u6[u10] = v11;
                v12 = i;
            end;
        end;
    else
        for _, v in v5 do
            u6[v[1]] = v[2];
        end;
    end;

    return TweenInfo.new(p2, u6.TweenStyle, u6.TweenDirection);
end;

return function(p13: userdata, p14: any) -- Line: 62
    -- upvalues: TweenService (copy), getTweenData (copy)
    local End = p13.Parent:FindFirstChild("End");

    if not End then
        warn("Goal is not defined.");

        return;
    end;

    local v15 = p13:Clone();
    local v16 = tonumber(p13.Parent:GetAttribute("StartTransparency")) or 0;

    if v15:IsA("MeshPart") then
        v15.Transparency = v16;
    elseif v15:IsA("BasePart") and v15:FindFirstChildOfClass("Decal") then
        v15.Transparency = 1;
    end;

    v15.Parent = workspace.CurrentCamera;
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