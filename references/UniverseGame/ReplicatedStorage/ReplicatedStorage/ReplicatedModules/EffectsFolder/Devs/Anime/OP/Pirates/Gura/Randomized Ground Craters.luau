  

 

local TweenService = game:GetService("TweenService");
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = Random.new();

return function(p3) -- Line: 9
    -- upvalues: u2 (copy), u1 (copy), TweenService (copy)
    local v4 = p3.Origin or error("No origin data");
    local v5 = p3.Lifetime or 2;
    local v6 = p3.SizeMultiplier or 1;
    local v7 = {};

    for i = 1, p3.Power or 30 do
        for i2 = 0, math.ceil(i ^ 2 / 350) do
            local v8 = i / 6 * v6;
            local new = Vector2.new;
            local v9 = u2:NextNumber(0, 6.283185307179586);
            local v10 = math.cos(v9);
            local v11 = u2:NextNumber(0, 6.283185307179586);
            local v12 = new(v10, (math.sin(v11))) * i * (i2 % 2 == 0 and -1 or 1);
            local v13 = workspace:Raycast(v4.Position + v4.UpVector * 10 + (v4.LookVector * v12.X + v4.RightVector * v12.Y), v4.UpVector * -25, u1);

            if v13 then
                table.insert(v7, { v8, v13 });
            end;
        end;
    end;

    for _, v in v7 do
        local v14 = v[1];
        local v15 = v[2];
        local Part = Instance.new("Part");
        Part.Color = v15.Instance.Color;
        Part.Material = v15.Instance.Material;
        Part.Anchored = true;
        Part.CastShadow = false;
        Part.CanCollide = false;
        Part.CFrame = CFrame.new(0, -v14 / 3, 0) * CFrame.new(v15.Position, v4.Position + v4.UpVector * 40);
        Part.Anchored = true;
        local v16 = u2:NextNumber(0, v14 / 10) + 1;
        Part.Size = v14 * Vector3.new(v16, 1, 1);
        Part.BottomSurface = Enum.SurfaceType.Smooth;
        Part.TopSurface = Enum.SurfaceType.Smooth;
        Part.Parent = workspace;
        local v17 = v15.Instance:FindFirstChildOfClass("Texture") or v15.Instance:FindFirstChildOfClass("Decal");

        if v17 then
            for _, v2 in { "Front", "Back", "Bottom", "Left", "Right", "Top" } do
                local v18 = Instance.fromExisting(v17);
                v18.Face = v2;
                v18.Parent = Part;
            end;
        end;

        TweenService:Create(Part, TweenInfo.new(v5 * 0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In, 0, false, v5), {
            Size = Vector3.new(0, 0, 0),
            Position = Part.Position + Vector3.new(0, -Part.Size.Magnitude, 0)
        }):Play();
        task.delay(v5 * 1.5, Part.Destroy, Part);
    end;
end;