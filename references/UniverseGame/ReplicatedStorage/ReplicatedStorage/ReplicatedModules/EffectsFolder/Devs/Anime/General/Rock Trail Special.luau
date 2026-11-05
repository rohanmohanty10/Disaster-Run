  

 

local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local FXHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);
local u2 = Random.new();
local TweenService = game:GetService("TweenService");

return function(p3) -- Line: 12
    -- upvalues: FXHandler (copy), u1 (copy), u2 (copy), TweenService (copy)
    local Origin = p3.Origin;
    local Distance = p3.Distance;
    local v4 = p3.DelayTime or 0.01;
    local v5 = p3.Lifetime or 2;
    local v6 = p3.RockOffset or 3;
    local v7 = p3.GapPerRock or 8;
    local v8 = FXHandler.ScaleQuality(math.random(math.ceil(Distance), (math.ceil(Distance * 1.25))));

    for i = 2, v8 do
        for i2 = 1, 2 do
            local v9 = Origin * CFrame.new((i2 == 1 and -1 or 1) * (i * v7 / v8 + v6), 0, 0) * CFrame.new(0, 0, -((i - 2) / v8) * Distance);
            local v10 = workspace:Raycast(v9.Position + Vector3.new(0, 10, 0), Vector3.new(0, -25, 0), u1);

            if v10 then
                local v11 = i / v8;
                local v12 = Vector3.new(1, 1, 1) * (v11 * Distance / 6);
                local v13 = Vector3.new(v12.X * 1.3, v12.Y / 1.4, v12.Z * 1.3) * u2:NextNumber(1, 1.5);
                local Part = Instance.new("Part");
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanTouch = false;
                Part.Material = v10.Material;
                Part.Color = v10.Instance.Color;
                local v14 = CFrame.lookAt(v10.Position - Vector3.new(0, 0.5, 0), Origin.Position);
                local Angles = CFrame.Angles;
                local v15 = u2:NextNumber(-25, 25);
                local v16 = math.rad(v15);
                local v17 = u2:NextNumber(-25, 25);
                Part.CFrame = v14 * Angles(v16, 0, (math.rad(v17)));
                Part.CFrame = Part.CFrame * CFrame.new(u2:NextNumber(v11 * -3, v11 * 3), u2:NextNumber(v11 * -0.5, v11 * 1.5), u2:NextNumber(v11 * -1.5, v11 * 1.5));
                Part.Size = v13 * 0.25;
                Part.BottomSurface = Enum.SurfaceType.Smooth;
                Part.TopSurface = Enum.SurfaceType.Smooth;
                Part.Parent = workspace.Effects;

                for _, child in pairs(v10.Instance:GetChildren()) do
                    if child:IsA("Decal") or child:IsA("Texture") then
                        child:Clone().Parent = Part;
                    end;
                end;

                TweenService:Create(Part, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = v13
                }):Play();
                task.delay(v5 + v4 * i, function() -- Line: 62
                    -- upvalues: TweenService (ref), Part (copy)
                    local v18 = TweenService:Create(Part, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = Vector3.new(0, 0, 0),
                        Position = Part.CFrame.Position - Vector3.new(0, Part.Size.Y + 2, 0)
                    });
                    v18:Play();
                    v18.Completed:Connect(function() -- Line: 72
                        -- upvalues: Part (ref)
                        Part:Destroy();
                    end);
                end);
            end;
        end;
    end;
end;