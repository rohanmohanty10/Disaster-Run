 

 

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
                if pcall(function() -- Line: 36
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

return function(p13: userdata) -- Line: 57
    -- upvalues: TweenService (copy), getTweenData (copy)
    local End = p13.Parent:FindFirstChild("End");

    if not End then
        warn("Goal is not defined.");

        return;
    end;

    local v14 = p13:Clone();
    local v15 = tonumber(p13.Parent:GetAttribute("StartTransparency")) or 0;

    if v14:IsA("MeshPart") then
        v14.Transparency = v15;
    elseif v14:IsA("BasePart") and v14:FindFirstChildOfClass("Decal") then
        v14.Transparency = 1;
    end;

    v14.Parent = workspace.temp;
    local v16 = tonumber(p13.Parent:GetAttribute("Duration")) or 0.1;

    if v14:FindFirstChildOfClass("Decal") then
        TweenService:Create(v14, getTweenData(p13.Parent, v16, "Part", Enum.EasingStyle.Cubic), {
            Size = End.Size,
            CFrame = End.CFrame
        }):Play();
    else
        TweenService:Create(v14, getTweenData(p13.Parent, v16, "Part", Enum.EasingStyle.Cubic), {
            Transparency = 1,
            Size = End.Size,
            CFrame = End.CFrame
        }):Play();
    end;

    local v17 = v14:FindFirstChildOfClass("SpecialMesh");
    local v18 = End:FindFirstChildOfClass("SpecialMesh");

    if v17 and v18 then
        TweenService:Create(v17, getTweenData(p13.Parent, v16, "Mesh", Enum.EasingStyle.Sine), {
            Scale = v18.Scale
        }):Play();
    end;

    local v19 = v14:FindFirstChildOfClass("Decal");
    local v20 = End:FindFirstChildOfClass("Decal");

    if v19 and v20 then
        v19.Transparency = 0;
        TweenService:Create(v19, getTweenData(p13.Parent, v16, "Decal", Enum.EasingStyle.Cubic), {
            Transparency = v20.Transparency,
            Color3 = v20.Color3
        }):Play();
    end;

    task.delay(v16, v14.Destroy, v14);
end;