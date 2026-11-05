  

 

local u1 = Random.new();

return function(p2, p3, p4) -- Line: 2
    -- upvalues: u1 (copy)
    local v5;

    if typeof(p2) == "CFrame" then
        v5 = p2.Position;
        p3 = p2.LookVector * p3;
    else
        v5 = p2;
    end;

    local v6 = RaycastParams.new();
    v6.FilterType = Enum.RaycastFilterType.Whitelist;
    v6.FilterDescendantsInstances = { game.Workspace.Map };
    local v7 = workspace:Raycast(v5, p3, v6);

    if not v7 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Massless = true;
    Part.Size = Vector3.new(p4 or 2.5, 0.001, p4 or 2.5);
    Part.Transparency = 1;
    local Decal = Instance.new("Decal");

    if v7.Instance.Material == Enum.Material.Grass then
        Decal.Texture = "rbxassetid://8283737680";
    else
        Decal.Texture = "rbxassetid://8269464285";
    end;

    Decal.Face = Enum.NormalId.Top;
    Decal.Parent = Part;
    local v8 = CFrame.lookAt(v7.Position, v7.Position - v7.Normal);
    local Angles = CFrame.Angles;
    local v9 = u1:NextNumber(-360, 360);
    Part.CFrame = v8 * Angles(1.5707963267948966, math.rad(v9), 0);
    Part.Parent = game.Workspace.Effects;
    task.wait(2.5);
    local v10 = game:GetService("TweenService"):Create(Decal, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Transparency = 1
    });
    v10:Play();
    v10.Completed:Wait();
    Part:Destroy();
end;