  

 

local u1 = game.ReplicatedStorage["Client Assets"];

return function(p2, p3) -- Line: 3
    -- upvalues: u1 (copy)
    local u4 = u1.Dawn.strongpunch:Clone();
    u4.Color = p2.Color;
    u4.CFrame = p3 * p2.Angle;
    u4.Size = p2.StartSize;
    u4.Parent = workspace.Effects;
    local u5 = p2.RotSpeed or 10;
    local u6 = nil;
    wrap(function() -- Line: 12
        -- upvalues: u6 (ref), u4 (copy), u5 (copy)
        while not u6 do
            local v7 = u4;
            v7.CFrame = v7.CFrame * CFrame.Angles(0, 0, rad(u5 + u5 * wait()));
        end;
    end)();
    local v8 = ts:Create(u4, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        Transparency = 1,
        Size = p2.FinalSize
    });
    u6 = tweendeb(v8, u4);
end;