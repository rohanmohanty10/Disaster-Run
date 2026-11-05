  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = EffectsHandler.GetEffect("lerpPosition");
local u2 = EffectsHandler.GetEffect("Lerp");

return function(p3, p4) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), u1 (copy), u2 (copy)
    if typeof(p3) ~= "Instance" then
        return;
    end;

    local CFrame2 = p3.CFrame;
    local v5 = ReplicatedStorage["Client Assets"].Universal.DashShockwave:Clone();
    task.delay(p4, v5.Destroy, v5);
    v5.Parent = workspace.Effects;
    local Left0 = v5.Left0;
    local Left = v5.Left;
    local Right0 = v5.Right0;
    local Right = v5.Right;

    for _, child in pairs(v5:GetChildren()) do
        child.Size = Vector3.new(0.1, 0.2, 2.5);
    end;

    local v6 = tick();

    while true do
        local v7 = task.wait() * 60;
        local v8 = p3.CFrame:ToWorldSpace(CFrame.new(0, 0, -2.5));
        local magnitude = (CFrame2.Position - v8.Position).magnitude;
        local v9 = p3.Size.X / 2;
        local v10 = CFrame.new(u1(v8.Position, CFrame2.Position, 0.4), v8.Position);
        local v11 = CFrame.new(u1(v8:ToWorldSpace(CFrame.new(-v9, 0, -2)), CFrame2:ToWorldSpace(CFrame.new(-magnitude / 7, 0, 0)), 0.5), v8:ToWorldSpace(CFrame.new(-v9, 0, -2)).Position);
        local v12 = CFrame.new(u1(v8:ToWorldSpace(CFrame.new(v9, 0, -2)), CFrame2:ToWorldSpace(CFrame.new(magnitude / 7, 0, 0)), 0.5), v8:ToWorldSpace(CFrame.new(v9, 0, -2)).Position);

        if v6 + p4 * 0.25 >= tick() then
            Left.Size = Vector3.new(magnitude, magnitude / 2, 0.05) * v7;
            Right.Size = Vector3.new(magnitude, magnitude / 2, 0.05) * v7;
        else
            local v13 = (tick() - v6) / p4;
            local v14 = u2(Right.Size.Y * 0.8, Left.Size.Y, v13);
            Left.Size = Vector3.new(magnitude, v14, Right.Size.Z) * v7;
            local v15 = u2(Right.Size.Y * 0.8, Right.Size.Y, v13);
            Right.Size = Vector3.new(magnitude, v15, Right.Size.Z) * v7;
            Left.Transparency = u2(0, 1.1, v13) * v7;
            Right.Transparency = u2(0, 1.1, v13) * v7;
        end;

        Left.CFrame = v11:ToWorldSpace(CFrame.new(0, -(p3.Size.Y + 1) + Left.Size.Y / 3, 0)) * CFrame.Angles(0, 1.5707963267948966, 0);
        Right.CFrame = v12:ToWorldSpace(CFrame.new(0, -(p3.Size.Y + 1) + Right.Size.Y / 3, 0)) * CFrame.Angles(0, 1.5707963267948966, 0);

        if v6 + p4 * 0.15 >= tick() then
            Left0.Size = Vector3.new(magnitude, magnitude / 4, 2.5 + magnitude / 5) * v7;
            Right0.Size = Vector3.new(magnitude, magnitude / 4, 2.5 + magnitude / 5) * v7;
        else
            local v16 = (tick() - v6) / (p4 * 0.75);
            local v17 = u2(Left0.Size.Y * 1.2, Left0.Size.Y, v16);
            Left0.Size = Vector3.new(magnitude, v17, Left0.Size.Z) * v7;
            local v18 = u2(Right0.Size.Y * 1.2, Right0.Size.Y, v16);
            Right0.Size = Vector3.new(magnitude, v18, Right0.Size.Z) * v7;
            Left0.Transparency = u2(0, 1.1, v16) * v7;
            Right0.Transparency = u2(0, 1.1, v16) * v7;
        end;

        Left0.CFrame = v10:ToWorldSpace(CFrame.new(-(p3.Size.X + magnitude / 10), -(p3.Size.Y + 1) + Left0.Size.Y / 3, 0)) * CFrame.Angles(0, 1.5707963267948966, 0);
        Right0.CFrame = v10:ToWorldSpace(CFrame.new(p3.Size.X + magnitude / 10, -(p3.Size.Y + 1) + Right0.Size.Y / 3, 0)) * CFrame.Angles(0, 1.5707963267948966, 0);

        if v6 + p4 <= tick() then
            return;
        end;
    end;
end;