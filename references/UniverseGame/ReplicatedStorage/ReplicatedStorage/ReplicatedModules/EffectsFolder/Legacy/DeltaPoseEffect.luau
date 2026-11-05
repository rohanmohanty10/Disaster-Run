  

 

local LocalPlayer = game.Players.LocalPlayer;

return function(u1, u2, u3, u4) -- Line: 2
    -- upvalues: LocalPlayer (copy)
    if LocalPlayer.Settings.ExtraProps.Value ~= true then
        return;
    end;

    if u2:FindFirstChild("DeltaAV") == nil then
        Instance.new("Folder", u2).Name = "DeltaAV";
    end;

    if workspace.CurrentCamera:FindFirstChild("DeltaB") == nil then
        Instance.new("ColorCorrectionEffect", workspace.CurrentCamera).Name = "DeltaB";
    end;

    if workspace.CurrentCamera:FindFirstChild("DeltaBl") == nil then
        Instance.new("BloomEffect", workspace.CurrentCamera).Name = "DeltaBl";
    end;

    workspace.CurrentCamera.DeltaBl.Threshold = 0.8;
    workspace.CurrentCamera.DeltaBl.Size = 50;

    if workspace.CurrentCamera:FindFirstChild("DeltaB") == nil and workspace.CurrentCamera:FindFirstChild("DeltaBl") == nil then
        Instance.new("ColorCorrectionEffect", workspace.CurrentCamera).Name = "DeltaB";
        Instance.new("BloomEffect", workspace.CurrentCamera).Name = "DeltaBl";
    end;

    local DeltaAV = u2.DeltaAV;
    local u5 = {};
    local u6 = 1;
    local u7 = 0;
    local u8 = false;

    for i = 1, 360, 4 do
        u5[i] = { 0, Instance.new("Part", DeltaAV) };
    end;

    local v20 = game:GetService("RunService").RenderStepped:Connect(function(p9) -- Line: 22
        -- upvalues: u1 (copy), u6 (ref), u7 (ref), u2 (copy), u8 (ref), u4 (copy), u3 (copy), u5 (copy)
        local v10 = u1.PlaybackLoudness / 2;
        u6 = u6 + (1 + v10 / 360 - u6) * math.clamp(p9 * 10, 0, 1);
        local v11 = math.clamp(u6 - 1.5, 0, 1) * 8;
        local v12 = math.clamp(v11 - 1.35, 0, 1) * 8;

        if u7 < v12 then
            u7 = v12;
        else
            u7 = u7 + (0 - u7) * math.clamp(p9 * 20, 0, 1);
        end;

        local v13 = 25 / (workspace.CurrentCamera.CFrame.p - u2.CFrame.p).Magnitude;

        if u7 > 0.5 and not u8 then
            u8 = true;
            local Part = Instance.new("Part", workspace);
            game:GetService("Debris"):AddItem(Part, 0.5);
            Part.Anchored = true;
            Part.CastShadow = false;
            Part.CanCollide = false;
            Part.Transparency = 0.5;
            Part.Material = Enum.Material.ForceField;
            Part.Color = u4 or Color3.fromRGB(255, 213, 0);
            Part.Shape = 0;
            Part.CFrame = CFrame.new(u2.CFrame.p);
            Part.Size = Vector3.new(u6 * 12, u6 * 12, u6 * 12);
            game:GetService("TweenService"):Create(Part, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
                Transparency = 1,
                Size = Part.Size * 4
            }):Play();
        elseif u7 <= 0.5 and u8 then
            u8 = false;
        end;

        workspace.CurrentCamera.FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value + v11 * 3.5 * v13;
        workspace.CurrentCamera.DeltaB.Contrast = u7 * (v13 / 60);
        workspace.CurrentCamera.DeltaB.Brightness = u7 * (v13 / 60);
        workspace.CurrentCamera.DeltaBl.Intensity = 0.1 + u7 * (v13 / 95);
        workspace.CurrentCamera.DeltaB.TintColor = Color3.new(1, 1, 1):Lerp(u3 or Color3.fromRGB(165, 0, 75), (math.clamp(u7 * (v13 / 15), 0, 1)));

        for i, _ in pairs(u5) do
            local v14 = u5[i];
            v14[1] = v14[1] + (0 - u5[i][1]) * math.clamp(p9 * 5, 0, 1);
            local v15 = CFrame.Angles(0, math.rad(i), 0) * CFrame.new(0, 0, u6 * -6);
            local v16 = CFrame.Angles(0, math.rad(v10), 0) * CFrame.new(0, 0, u6 * -6);
            local v17 = CFrame.Angles(0, math.rad(v10 + 180), 0) * CFrame.new(0, 0, u6 * -6);
            local v18 = u5[i];
            v18[1] = v18[1] + (10 / ((v15.p - v16.p).Magnitude * 8 + 1) + 10 / ((v15.p - v17.p).Magnitude * 8 + 1) - u5[i][1]) * math.clamp(p9 * 10, 0, 1);
            local v19 = u5[i][2];
            v19.Name = "DeltaParts";
            v19.Anchored = true;
            v19.CanCollide = false;
            math.random(1, 2);

            if u5[i][1] * 2 > 0.8 then
                v19.Color = u3 or Color3.fromRGB(165, 0, 75);
            else
                v19.Color = u4 or Color3.fromRGB(213, 115, 61);
            end;

            v19.Material = Enum.Material.Neon;
            v19.Size = Vector3.new(0.1, 2 * u5[i][1], 0.1);
            v19.CFrame = CFrame.new(u2.CFrame.p) * v15;
        end;
    end);

    repeat
        wait();
    until LocalPlayer.Settings.ExtraProps.Value ~= true or (u2 == nil or (u1 == nil or (u2.Parent == nil or (not u2.Parent.Parent or (u1.Parent == nil or not (u1.Playing and (workspace.CurrentCamera:FindFirstChild("DeltaB") and (workspace.CurrentCamera:FindFirstChild("DeltaBl") and u2:FindFirstChild("DeltaAV")))))))));

    v20:Disconnect();
    u2.DeltaAV:Destroy();

    for _, child in pairs(workspace.CurrentCamera:GetChildren()) do
        if child.Name:find("Delta") then
            child:Destroy();
        end;
    end;
end;