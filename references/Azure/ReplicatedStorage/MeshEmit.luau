 

 

local TweenService = game:GetService("TweenService");

local function getTweenData(p1: userdata, p2: number, p3: string, p4: any) -- Line: 12
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
                if pcall(function() -- Line: 45
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

return function(p13: userdata, p14: boolean, p15: any, u16: any, u17: any) -- Line: 72
    -- upvalues: TweenService (copy), getTweenData (copy)
    local End = p13.Parent:FindFirstChild("End");

    if not End then
        warn("Goal is not defined.");

        return;
    end;

    local v18 = p13:Clone();
    local v19 = tonumber(p13.Parent:GetAttribute("StartTransparency")) or 0;

    if v18:IsA("MeshPart") then
        v18.Transparency = v19;
    elseif v18:IsA("BasePart") and v18:FindFirstChildOfClass("Decal") then
        v18.Transparency = 1;
    end;

    v18.Parent = workspace.CurrentCamera;
    local v20 = tonumber(p13.Parent:GetAttribute("Duration")) or 0.1;

    if v18:FindFirstChildOfClass("Decal") then
        TweenService:Create(v18, getTweenData(p13.Parent, v20, "Part", Enum.EasingStyle.Cubic), {
            Size = End.Size,
            CFrame = End.CFrame
        }):Play();
    else
        TweenService:Create(v18, getTweenData(p13.Parent, v20, "Part", Enum.EasingStyle.Cubic), {
            Size = End.Size,
            CFrame = End.CFrame,
            Color = End.Color
        }):Play();

        if p14 then
            TweenService:Create(v18, getTweenData(p13.Parent, v20, "Part", Enum.EasingStyle.Cubic), {
                Transparency = 1
            }):Play();
        else
            p13.Parent:GetAttribute("StartTransparency");
        end;
    end;

    local v21 = v18:FindFirstChildOfClass("SpecialMesh");
    local v22 = End:FindFirstChildOfClass("SpecialMesh");

    if v21 and v22 then
        TweenService:Create(v21, getTweenData(p13.Parent, v20, "Mesh", Enum.EasingStyle.Sine), {
            Scale = v22.Scale
        }):Play();
    end;

    local v23 = v18:FindFirstChildOfClass("Decal");
    local v24 = End:FindFirstChildOfClass("Decal");

    if v23 and v24 then
        v23.Transparency = v19;
        TweenService:Create(v23, getTweenData(p13.Parent, v20, "Decal", Enum.EasingStyle.Cubic), {
            Color3 = v24.Color3
        }):Play();

        if p14 then
            TweenService:Create(v23, getTweenData(p13.Parent, v20, "Decal", Enum.EasingStyle.Cubic), {
                Transparency = 1
            }):Play();
        else
            p13.Parent:GetAttribute("StartTransparency");
        end;

        if p15 then
            for _, descendant in ipairs(v18:GetDescendants()) do
                if descendant:IsA("Decal") then
                    task.spawn(function() -- Line: 139
                        -- upvalues: u16 (copy), descendant (copy), u17 (copy)
                        for i = 1, #u16 do
                            descendant.Texture = u16[i];
                            task.wait(u17);
                            local _ = i;
                        end;
                    end);
                end;
            end;
        end;
    end;

    task.delay(v20, v18.Destroy, v18);
end;