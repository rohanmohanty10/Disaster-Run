  

 

return function(p1, p2, p3) -- Line: 1
    local v4 = { game.ReplicatedStorage["Client Assets"].swtwn.Balls.mp, game.ReplicatedStorage["Client Assets"].swtwn.Balls.straightball1 };
    local v5 = { Color3.fromRGB(180, 128, 255) };
    local u6 = v4[math.random(1, #v4)]:Clone();
    u6.Parent = workspace.Effects;
    u6.CFrame = CFrame.new(p2.Position, p1.HumanoidRootPart.Position) * CFrame.Angles(math.random(-90, 90), math.random(-90, 90), 0);
    u6.Transparency = 0;
    u6.Color = v5[math.random(1, #v5)];
    u6.Size = Vector3.new(0.05, 3, 0.05);
    local v7 = game:GetService("TweenService"):Create(u6, TweenInfo.new(0.5), {
        Transparency = 1,
        CFrame = u6.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360)),
        Size = p3
    });
    v7:Play();
    v7.Completed:connect(function() -- Line: 23
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;