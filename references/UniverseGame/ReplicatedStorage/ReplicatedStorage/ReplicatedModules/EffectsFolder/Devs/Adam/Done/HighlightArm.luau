  

 

return function(p1) -- Line: 1
    local u2 = p1:Clone();
    u2.Parent = workspace;
    u2.Trail:Destroy();
    u2.Mesh:Destroy();
    u2.Color = Color3.fromRGB(255, 255, 255);
    u2.Material = Enum.Material.Neon;
    local Weld = Instance.new("Weld");
    Weld.Parent = p1;
    Weld.Part0 = p1;
    Weld.Part1 = u2;
    game:GetService("TweenService"):Create(Weld.Part1, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Weld.Part1.Size + Vector3.new(0.75, 1, 0.75)
    }):Play();
    coroutine.wrap(function() -- Line: 13
        -- upvalues: u2 (copy)
        wait(1);
        u2:Destroy();
    end)();
end;