  

 

return function(p1, p2, p3, p4, p5, p6, p7) -- Line: 1
    local u8 = p1:Clone();
    u8.Parent = p5;
    u8.CFrame = p2;
    local u9 = u8:FindFirstChildWhichIsA("Decal");
    u9.Color3 = p6;
    u9.Transparency = p7;

    if not u9 then
        warn("No Decal found inside the cloned mesh");
        u8:Destroy();

        return nil;
    end;

    local v10 = p3:GetChildren();
    table.sort(v10, function(p11, p12) -- Line: 28
        return (tonumber(p11.Name) or (1 / 0)) < (tonumber(p12.Name) or (1 / 0));
    end);
    local u13 = {};

    for _, v in ipairs(v10) do
        if v:IsA("Decal") or v:IsA("Texture") then
            table.insert(u13, v.Texture);
        end;
    end;

    if #u13 == 0 then
        warn("No Decals/Textures found in folder");
        u8:Destroy();

        return nil;
    end;

    local u14 = 1 / p4;
    task.spawn(function() -- Line: 50
        -- upvalues: u13 (copy), u8 (copy), u9 (copy), u14 (copy)
        for _, v in ipairs(u13) do
            if not u8.Parent then
                break;
            end;

            u9.Texture = v;
            task.wait(u14);
        end;

        if u8.Parent then
            u8:Destroy();
        end;
    end);

    return u8;
end;