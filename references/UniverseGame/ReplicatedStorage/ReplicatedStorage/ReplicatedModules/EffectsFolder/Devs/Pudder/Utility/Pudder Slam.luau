  

 

local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

local function GenerateUnitCircle(p2) -- Line: 4
    local Total = p2.Total;
    local Radius = p2.Radius;
    local v3 = {};

    for i = 1, Total do
        local v4 = 6.283185307179586 / Total * i;
        local v5 = {
            X = Radius * math.cos(v4),
            Z = Radius * math.sin(v4)
        };
        table.insert(v3, v5);
    end;

    return v3;
end;

return function(p6) -- Line: 22
    -- upvalues: u1 (copy), TweenService (copy), GenerateUnitCircle (copy)
    local Origin = p6.Origin;
    local v7 = p6.DownwardsCheck or -50;
    local v8 = RaycastParams.new();
    v8.IgnoreWater = true;
    v8.FilterType = Enum.RaycastFilterType.Whitelist;
    v8.FilterDescendantsInstances = { workspace.Map };
    v8.CollisionGroup = "Map";
    local v9 = workspace:Raycast(Origin.Position, Vector3.new(0, v7, 0), v8);

    if not v9 then
        return;
    end;

    for _, child in pairs(u1.SOL_R.Slam:GetChildren()) do
        local u10 = child:Clone();
        u10.Parent = workspace.Effects;
        u10.Position = v9.Position;
        u10.CanCollide = false;
        u10.CastShadow = false;
        u10.Size = Vector3.new(1, 1, 1);

        for _, _ in pairs(child:GetChildren()) do
            TweenService:Create(u10, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end;

        local v11 = TweenService:Create(u10, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = Vector3.new(35, 1, 35),
            Transparency = 1
        });
        v11:Play();
        v11.Completed:Connect(function() -- Line: 64
            -- upvalues: u10 (copy)
            u10:Destroy();
        end);
    end;

    local v12 = GenerateUnitCircle({
        Total = 9,
        Radius = 10
    });

    for i, v in pairs(v12) do
        local v13 = workspace:Raycast(v9.Position + Vector3.new(v.X, 1, v.Z), Vector3.new(0, v7, 0), v8);

        if v13 then
            local v14 = Random.new():NextNumber(0.5, 1.5) / 2;
            local u15 = u1.SOL_R.Rock:Clone();
            u15.Parent = workspace.Effects;
            local v16 = CFrame.lookAt(v13.Position, v9.Position + Vector3.new(0, 5, 0));
            local Angles = CFrame.Angles;
            local v17 = Random.new():NextNumber(-25, 25);
            local v18 = math.rad(v17);
            local v19 = Random.new():NextNumber(-25, 25);
            u15.CFrame = v16 * Angles(v18, math.rad(v19), 0);
            u15.Material = v13.Material;
            u15.Color = v13.Instance.Color;
            local v20 = TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = Vector3.new(8 + v14, 2 + v14, 2 + v14)
            });
            v20:Play();
            v20.Completed:Connect(function() -- Line: 95
                -- upvalues: i (copy), TweenService (ref), u15 (copy)
                task.wait(5 + i * 0.1);
                local v21 = TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    Position = u15.Position + Vector3.new(0, -2, 0)
                });
                v21:Play();
                v21.Completed:Connect(function() -- Line: 104
                    -- upvalues: u15 (ref)
                    u15:Destroy();
                end);
            end);
        end;
    end;
end;