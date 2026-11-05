  

 

return function(p1, p2) -- Line: 1
    local v3 = game.ReplicatedStorage["Client Assets"]["The World"].KnifeThrow:Clone();
    v3.Parent = game.Workspace.Effects;
    local v4 = p1.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5);
    local Angles = CFrame.Angles;
    local v5 = math.random(-360, 360);
    v3.CFrame = v4 * Angles(1.5707963267948966, math.rad(v5), 0);
    game:GetService("TweenService"):Create(v3, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = v3.Size * 7,
        CFrame = v3.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
    }):Play();
    game.Debris:AddItem(v3, 1);

    for _ = 1, 14 do
        local v6 = game.ReplicatedStorage["Client Assets"]["The World"].WaterBeamIn:Clone();
        v6.Parent = game.Workspace.Effects;
        v6.Color = Color3.fromRGB(127, 127, 127);
        v6.Size = Vector3.new(v6.Size.X / 2, v6.Size.Y / 2, math.random(5, 12));
        local v7 = p1.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5);
        local Angles2 = CFrame.Angles;
        local v8 = math.random(-360, 360);
        local v9 = math.rad(v8);
        local v10 = math.random(-360, 360);
        local v11 = math.rad(v10);
        local v12 = math.random(-360, 360);
        v6.CFrame = v7 * Angles2(v9, v11, (math.rad(v12)));
        game:GetService("TweenService"):Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Transparency = 1,
            CFrame = v6.CFrame * CFrame.new(0, 0, -math.random(10, 12))
        }):Play();
        game.Debris:AddItem(v6, 1);
    end;
end;