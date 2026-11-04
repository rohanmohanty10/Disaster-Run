 
 

local TweenService = game:GetService("TweenService");

local function getTweenData(p1, p2) -- Line: 10
    if typeof(p2) ~= "string" then
        return;
    end;

    local Attribute = p1:GetAttribute("Duration");

    if typeof(Attribute) ~= "number" then
        return;
    end;

    local Attribute2 = p1:GetAttribute(p2);

    if typeof(Attribute2) ~= "string" then
        return;
    end;

    local string_split_ret = string.split(Attribute2, ",");

    if typeof(string_split_ret[1]) == "string" and typeof(string_split_ret[2]) == "string" then
        return TweenInfo.new(Attribute, Enum.EasingStyle[string_split_ret[1]], Enum.EasingDirection[string_split_ret[2]]);
    end;

    if typeof(string_split_ret[1]) == "string" and typeof(string_split_ret[2]) ~= "string" then
        return TweenInfo.new(Attribute, Enum.EasingStyle[string_split_ret[1]], Enum.EasingDirection.In);
    end;

    if typeof(string_split_ret[1]) ~= "string" and typeof(string_split_ret[2]) == "string" then
        return TweenInfo.new(Attribute, Enum.EasingStyle.Linear, Enum.EasingDirection[string_split_ret[2]]);
    end;

    if typeof(string_split_ret[1]) ~= "string" and typeof(string_split_ret[2]) ~= "string" then
        return TweenInfo.new(Attribute, Enum.EasingStyle.Linear, Enum.EasingDirection.In);
    end;
end;

local TweenInfo_new_ret = TweenInfo.new(0);

return function(p3: userdata) -- Line: 38
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), getTweenData (copy)
    if not p3:FindFirstChild("End") then
        warn("Goal is not defined.");

        return;
    end;

    local u4 = p3:Clone();
    local v5 = tonumber(u4:GetAttribute("StartTransparency")) or 0;

    if typeof(v5) == "number" then
        if u4.Start:IsA("MeshPart") then
            TweenService:Create(u4.Start, TweenInfo_new_ret, {
                Transparency = v5
            }):Play();
            u4.Start.Transparency = v5;
        elseif u4.Start:IsA("BasePart") and u4.Start:FindFirstChild("Decal") then
            TweenService:Create(u4.Start.Decal, TweenInfo_new_ret, {
                Transparency = v5
            }):Play();
            u4.Start.Decal.Transparency = v5;
        end;
    end;

    u4.Parent = workspace.CurrentCamera;
    local v6 = tonumber(u4:GetAttribute("Duration")) or 0.1;
    local v7 = {};
    local v8 = getTweenData(u4, "Part_TweenParams");

    if typeof(v8) == "TweenInfo" then
        local v9 = TweenService:Create(u4.Start, v8, {
            Transparency = 1,
            CFrame = u4.End.CFrame,
            Size = u4.End.Size
        });
        table.insert(v7, v9);
    end;

    local v10 = getTweenData(u4, "Mesh_TweenParams");

    if typeof(v10) == "TweenInfo" and (u4.Start:FindFirstChild("Mesh") and u4.End:FindFirstChild("Mesh")) then
        local v11 = TweenService:Create(u4.Start.Mesh, v8, {
            Scale = u4.End.Mesh.Scale
        });
        table.insert(v7, v11);
    end;

    local v12 = getTweenData(u4, "Decal_TweenParams");

    if typeof(v12) == "TweenInfo" and u4.Start:FindFirstChild("Decal") then
        local v13 = TweenService:Create(u4.Start.Decal, v8, {
            Transparency = 1
        });
        table.insert(v7, v13);
    end;

    for _, v in pairs(v7) do
        v:Play();
    end;

    task.delay(v6, function() -- Line: 89
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;