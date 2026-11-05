  

 

local TweenService = game:GetService("TweenService");

return function(u1, u2) -- Line: 3
    -- upvalues: TweenService (copy)
    local v3 = TweenService:Create(u1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 0,
        Size = u2
    });
    v3:Play();
    v3.Completed:Connect(function() -- Line: 10
        -- upvalues: TweenService (ref), u1 (copy), u2 (copy)
        TweenService:Create(u1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, (1 / 0), true), {
            Size = u2 - Vector3.new(1, 0, 1)
        }):Play();
    end);

    if u1:FindFirstChild("RotateWeld") then
        local RotateWeld = u1:WaitForChild("RotateWeld", 5);

        repeat
            local v4 = task.wait();
            RotateWeld.C1 = RotateWeld.C1 * CFrame.Angles(0, math.rad(v4) * -100, 0);
        until not RotateWeld:IsDescendantOf(game);
    end;
end;