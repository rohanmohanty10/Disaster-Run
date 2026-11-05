  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    for _ = 1, 550 do
        for i = 1, 2 do
            local Part = Instance.new("Part");
            Part.Parent = game.Workspace;
            Part.Transparency = 0.15;
            Part.Material = Enum.Material.Neon;
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.BrickColor = BrickColor.new("Really black");
            Part.CastShadow = false;
            Part.Size = Vector3.new(1.4, 1.1, 1.4);
            local v2 = p1["Right Arm"].CFrame * CFrame.new(0, -0.3, 0);
            local Angles = CFrame.Angles;
            local v3 = math.random(-40, 40);
            local v4 = math.rad(v3);
            local v5 = math.random(-40, 40);
            local v6 = math.rad(v5);
            local v7 = math.random(-40, 40);
            Part.CFrame = v2 * Angles(v4, v6, (math.rad(v7)));

            if i == 2 then
                local v8 = p1["Left Arm"].CFrame * CFrame.new(0, -0.3, 0);
                local Angles2 = CFrame.Angles;
                local v9 = math.random(-40, 40);
                local v10 = math.rad(v9);
                local v11 = math.random(-40, 40);
                local v12 = math.rad(v11);
                local v13 = math.random(-40, 40);
                Part.CFrame = v8 * Angles2(v10, v12, (math.rad(v13)));
            end;

            coroutine.wrap(function() -- Line: 19
                -- upvalues: TweenService (ref), Part (copy)
                TweenService:Create(Part, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1,
                    Size = Vector3.new(0, 0, 0)
                }):Play();
                wait(1);
                Part:Destroy();
            end)();
        end;

        game:GetService("RunService").Heartbeat:Wait();
    end;
end;