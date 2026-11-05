  

 

game:GetService("TweenService");
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = Random.new();

return function(p3) -- Line: 9
    -- upvalues: u2 (copy), u1 (copy)
    local v4 = p3.Origin or error("No origin data");
    local v5 = p3.StartRadius or 10;
    local v6 = p3.EndRadius or 50;
    local v7 = p3.RadiusIncrement or 3;
    local v8 = p3.Lifetime or 0.35;
    local v9 = p3.Interval or 0.035;
    local v10 = p3.SizeRange or NumberRange.new(5, 10);
    local u11 = (v10.Min + v10.Max) / 2;
    local v12 = p3.Rocks or 12;
    local v13 = p3.Height or NumberRange.new(5, 7);

    while v5 <= v6 do
        v5 = v5 + v7;
        local v14 = 360 / v12;
        local v15 = {};

        for i = 1, v12 do
            local v16 = u2:NextNumber(-v14 / 4, v14 / 4);
            local v17 = i * v14 + v16;
            local v18 = math.rad(v17);
            local v19 = math.cos(v18);
            local v20 = math.rad(v17);
            local v21 = math.sin(v20);
            local v22 = v4 + Vector3.new(v19, 0, v21) * v5;
            local v23 = workspace:Raycast(v22 + Vector3.new(0, 30, 0), Vector3.new(0, -60, 0), u1);
            local v24 = v8 + v8 * (v5 / v6) / 10;

            if v23 then
                table.insert(v15, { v23.Position, v23, v24 });
            end;
        end;

        for _, v in v15 do
            local v25 = v[1];
            local v26 = v[2];
            local v27 = v[3];
            local v28 = u2:NextNumber(v10.Min, v10.Max);
            local Part = Instance.new("Part");
            Part.Size = Vector3.new(1, 1, 1) * v28;
            Part.Position = v25 - Vector3.new(0, p3.YOffset or 7, 0);
            Part.Color = v26.Instance.Color;
            Part.Material = v26.Instance.Material;
            local v29 = u2:NextNumber(0, 360);
            local v30 = u2:NextNumber(0, 360);
            Part.Orientation = Vector3.new(v29, v30, u2:NextNumber(0, 360));
            Part.Anchored = false;
            Part.CanCollide = false;
            Part.CastShadow = false;
            Part.BottomSurface = Enum.SurfaceType.Smooth;
            Part.TopSurface = Enum.SurfaceType.Smooth;
            Part.Parent = workspace.Effects;
            local v31 = v26.Instance:FindFirstChildOfClass("Texture") or v26.Instance:FindFirstChildOfClass("Decal");

            if v31 then
                for _, v2 in { "Front", "Back", "Bottom", "Left", "Right", "Top" } do
                    local v32 = Instance.fromExisting(v31);
                    v32.Face = v2;
                    v32.Parent = Part;
                end;
            end;

            local Attachment = Instance.new("Attachment");
            Attachment.Parent = Part;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.MaxForce = (1 / 0);
            local v33 = u2:NextNumber(v13.Min, v13.Max);
            LinearVelocity.VectorVelocity = Vector3.new(0, v33, 0) * u11;
            LinearVelocity.Attachment0 = Attachment;
            LinearVelocity.Parent = Attachment;
            task.delay(v27 / 2.5, function() -- Line: 80
                -- upvalues: u2 (ref), u11 (copy), Part (copy)
                local BodyAngularVelocity = Instance.new("BodyAngularVelocity");
                BodyAngularVelocity.MaxTorque = Vector3.new(1000000, 1000000, 1000000);
                local v34 = u2:NextNumber(-u11, u11);
                local v35 = u2:NextNumber(-u11, u11);
                BodyAngularVelocity.AngularVelocity = Vector3.new(v34, v35, u2:NextNumber(-u11, u11)) / 3;
                BodyAngularVelocity.Parent = Part;
            end);
            task.delay(v27 / 2.5, LinearVelocity.Destroy, LinearVelocity);
            task.delay(v27 * 3.5, Part.Destroy, Part);
        end;

        task.wait(v9);
    end;
end;