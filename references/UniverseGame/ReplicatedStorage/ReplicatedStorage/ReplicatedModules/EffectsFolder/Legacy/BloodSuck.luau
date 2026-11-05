  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");

return function(p2) -- Line: 3
    -- upvalues: u1 (copy), TweenService (copy)
    wait(1);

    for _ = 1, 3 do
        local u3 = u1["The World"].BloodHit:Clone();
        u3.Parent = p2.Torso;
        coroutine.wrap(function() -- Line: 9
            -- upvalues: u3 (copy)
            wait(0.5);
            u3.Enabled = false;
            wait(1);
            u3:Destroy();
        end)();

        for _, child in ipairs(p2:GetChildren()) do
            if child:IsA("BasePart") and (child.Name ~= "HumanoidRootPart" and child.Transparency ~= 1) then
                local Part = Instance.new("Part");
                Part.Parent = game.Workspace.Effects;
                Part.Transparency = 0.45;
                Part.CFrame = child.CFrame;
                Part.Size = child.Size + child.Size * 0.05;
                Part.Anchored = false;
                Part.CanCollide = false;
                Part.Name = "Effect";
                Part.BrickColor = BrickColor.new("Really red");
                Part.Material = Enum.Material.Neon;
                pcall(function() -- Line: 29
                    -- upvalues: Part (copy)
                    Part.face:Destroy();
                end);
                pcall(function() -- Line: 33
                    -- upvalues: child (copy), Part (copy)
                    child.Mesh:Clone().Parent = Part;
                end);
                local Weld = Instance.new("Weld");
                Weld.Parent = child;
                Weld.Part0 = child;
                Weld.Part1 = Part;
                coroutine.wrap(function() -- Line: 42
                    -- upvalues: TweenService (ref), Part (copy), Weld (copy)
                    TweenService:Create(Part, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                    wait(0.5);
                    Weld:Destroy();
                    Part:Destroy();
                end)();
            end;
        end;

        local v4 = u1["The World"].DonutImpact1:Clone();
        v4.Parent = game.Workspace;
        v4.Color = Color3.fromRGB(144, 0, 2);
        local CFrame2 = p2.Torso.CFrame;
        local Angles = CFrame.Angles;
        local v5 = math.random(-360, 360);
        local v6 = math.rad(v5);
        local v7 = math.random(-360, 360);
        local v8 = math.rad(v7);
        local v9 = math.random(-360, 360);
        v4.CFrame = CFrame2 * Angles(v6, v8, (math.rad(v9)));
        TweenService:Create(v4, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = v4.Size * 2
        }):Play();
        game.Debris:AddItem(v4, 1);
        local v10 = u1["The World"].DonutImpact2:Clone();
        v10.Parent = game.Workspace;
        v10.Color = Color3.fromRGB(144, 0, 2);
        local CFrame3 = p2.Torso.CFrame;
        local Angles2 = CFrame.Angles;
        local v11 = math.random(-360, 360);
        local v12 = math.rad(v11);
        local v13 = math.random(-360, 360);
        local v14 = math.rad(v13);
        local v15 = math.random(-360, 360);
        v10.CFrame = CFrame3 * Angles2(v12, v14, (math.rad(v15)));
        TweenService:Create(v10, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = v10.Size * 2
        }):Play();
        game.Debris:AddItem(v10, 1);

        for _ = 1, 14 do
            local u16 = u1["The World"].WaterBeamIn:Clone();
            u16.Parent = game.Workspace.Effects;
            u16.Color = Color3.fromRGB(144, 0, 2);
            u16.Size = Vector3.new(u16.Size.X, u16.Size.Y, math.random(3, 8));
            local CFrame4 = p2.Torso.CFrame;
            local Angles3 = CFrame.Angles;
            local v17 = math.random(-360, 360);
            local v18 = math.rad(v17);
            local v19 = math.random(-360, 360);
            local v20 = math.rad(v19);
            local v21 = math.random(-360, 360);
            u16.CFrame = CFrame4 * Angles3(v18, v20, (math.rad(v21)));
            TweenService:Create(u16, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                CFrame = u16.CFrame * CFrame.new(0, 0, -math.random(6, 12))
            }):Play();
            coroutine.wrap(function() -- Line: 76
                -- upvalues: TweenService (ref), u16 (copy)
                wait(0.25);
                TweenService:Create(u16, TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end)();
            game.Debris:AddItem(u16, 1);
        end;

        wait(1);
    end;
end;