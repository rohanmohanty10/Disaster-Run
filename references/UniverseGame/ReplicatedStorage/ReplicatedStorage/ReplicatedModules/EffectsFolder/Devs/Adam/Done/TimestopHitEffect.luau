  

 

return function(p1, p2, p3) -- Line: 1
    local v4 = game.ReplicatedStorage["Client Assets"]["Star Platinum: The World"].TimestopBarrageHitEffect:Clone();
    local SpikeMesh = v4.SpikeMesh;
    local v5 = CFrame.new(p2.Torso.CFrame.Position, p1.Torso.CFrame.Position) * CFrame.new(0, 0, -3);
    local Angles = CFrame.Angles;
    local v6 = math.random(0, 360);
    SpikeMesh.CFrame = v5 * Angles(1.5707963267948966, math.rad(v6), 0) * CFrame.new(math.random(0.1, 1), math.random(0.1, 1), math.random(0.1, 1));
    v4.Parent = workspace.Effects;
    game:GetService("TweenService"):Create(v4.SpikeMesh, TweenInfo.new(0.5 / p3), {
        Transparency = 1,
        Size = Vector3.new(6.325, 0.909, 8.461) * math.random(2, 5)
    }):Play();
    game:GetService("TweenService"):Create(v4.WaveMesh, TweenInfo.new(0.5 / p3), {
        Transparency = 1,
        Size = Vector3.new(5.63, 0.733, 5.417) * math.random(1.5, 2)
    }):Play();
    game:GetService("Debris"):AddItem(v4, 1 / p3);
end;