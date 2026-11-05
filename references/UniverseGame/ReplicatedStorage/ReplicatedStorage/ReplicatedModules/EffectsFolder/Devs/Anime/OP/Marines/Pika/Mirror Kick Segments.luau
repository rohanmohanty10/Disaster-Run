  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2, p3, p4, p5, p6) -- Line: 3
    -- upvalues: TweenService (copy)
    local _ = p5.SidewaysOffset;
    local v7 = p5.IntervalTime / p6;
    local HumanoidRootPart = p1.HumanoidRootPart;
    local v8 = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + p2.LookVector) * CFrame.new(0, -0.25, -1);
    local v9 = { v8 };

    for i = 1, p4 do
        v9[i + 1] = v8:Lerp(p3, i / p4) * CFrame.new(p4 <= i and 0 or (i % 2 == 0 and -15 or 15), 0, 0);
    end;

    local v10 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true);

    for i = 1, p4 do
        local Part = Instance.new("Part");
        Part.Color = Color3.new(0.992157, 1, 0.45098);
        Part.Material = Enum.Material.Neon;
        Part.Transparency = 1;
        Part.Size = Vector3.new(1.5, 1.5, 0.2);
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CastShadow = false;
        Part.CFrame = v9[i + 1] * CFrame.Angles(0, 1.5707963267948966, 0);
        Part.Parent = workspace.Effects;
        task.delay(1 / p6, Part.Destroy, Part);
        TweenService:Create(Part, v10, {
            Size = Vector3.new(1, 1, 0.2),
            Transparency = 0
        }):Play();
        local v11 = Part:Clone();
        v11.Size = Vector3.new(0.1, 0.1, (v9[i + 1].Position - v9[i].Position).Magnitude);
        v11.CFrame = CFrame.new(v9[i]:Lerp(v9[i + 1], 0.5).Position, v9[i + 1].Position);
        v11.Parent = workspace.Effects;
        task.delay(1 / p6, v11.Destroy, v11);
        TweenService:Create(v11, v10, {
            Transparency = 0,
            Size = Vector3.new(0.35, 0.35, v11.Size.Z)
        }):Play();
        task.wait(v7);
    end;
end;