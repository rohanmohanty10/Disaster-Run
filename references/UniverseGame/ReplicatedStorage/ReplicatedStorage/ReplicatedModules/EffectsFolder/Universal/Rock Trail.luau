  

 

local TweenService = game:GetService("TweenService");
local u1 = Random.new();

return function(u2) -- Line: 5
    -- upvalues: u1 (copy), TweenService (copy)
    local Origin = u2.Origin;

    if typeof(Origin) == "Instance" and Origin:IsA("BasePart") then
        Origin = Origin.CFrame + Vector3.new(0, 2, 0);
    end;

    local LookVector = u2.LookVector;
    local Offset = u2.Offset;
    local Distance = u2.Distance;
    local v3 = u2.Amount or 10;
    local v4 = u2.Size or 3;
    local u5 = u2.Duration or 1;
    local u6 = u2.Easing or { Enum.EasingStyle.Exponential, Enum.EasingDirection.In };
    local v7 = u2.DurationOffset or 0.1;
    local SpawnDelay = u2.SpawnDelay;
    local v8 = u2.Down or false;

    for i = 1, v3 do
        local v9 = Origin + LookVector * (Distance / v3 * i);

        for i2 = 1, 2 do
            local v10;

            if i2 == 1 then
                v10 = -Offset or Offset;
            else
                v10 = Offset;
            end;

            local v11 = v9 * CFrame.new(v10, 0, 0);
            local v12 = RaycastParams.new();
            v12.FilterType = Enum.RaycastFilterType.Include;
            v12.FilterDescendantsInstances = { workspace.Map };
            local v13 = workspace:Raycast(v11.Position, Vector3.new(0, -10, 0), v12);

            if v13 then
                local Instance2 = v13.Instance;
                local v14 = u1:NextNumber(-360, 360);
                local v15;

                if typeof(v4) == "Vector2" then
                    v15 = u1:NextNumber(v4.X, v4.Y);
                else
                    v15 = v4;
                end;

                local Part = Instance.new("Part");
                Part.Parent = workspace.Effects;
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanTouch = false;
                Part.Material = v13.Material;
                Part.Color = Instance2.Color;
                Part.CFrame = CFrame.new(v13.Position) * CFrame.Angles(v14, v14, v14);
                Part.Size = Vector3.new(1, 1, 1) * v15;
                Part.BottomSurface = Enum.SurfaceType.Smooth;
                Part.TopSurface = Enum.SurfaceType.Smooth;

                for _, child in pairs(Instance2:GetChildren()) do
                    if child:IsA("Decal") or child:IsA("Texture") then
                        child:Clone().Parent = Part;
                    end;
                end;

                local u16 = {
                    Size = Vector3.new(0, 0, 0)
                };

                if v8 then
                    u16.Position = Part.Position + Vector3.new(0, -Part.Size.Magnitude, 0);
                end;

                task.delay(i * v7, function() -- Line: 72
                    -- upvalues: u2 (copy), u5 (copy), u6 (copy), TweenService (ref), Part (copy), u16 (copy)
                    local v17 = TweenService:Create(Part, u2.Info or TweenInfo.new(u5, table.unpack(u6)), u16);
                    v17:Play();
                    v17.Completed:Connect(function() -- Line: 76
                        -- upvalues: Part (ref)
                        task.defer(Part.Destroy, Part);
                    end);
                end);
            end;
        end;

        if SpawnDelay then
            task.wait(SpawnDelay);
        end;
    end;
end;