  

 

local function quadBezier(p1, p2, p3, p4) -- Line: 1
    return (1 - p4) ^ 2 * p1 + 2 * (1 - p4) * p4 * p2 + p4 ^ 2 * p3;
end;

return function(p5) -- Line: 5
    local Part = Instance.new("Part");
    Part.Color = p5.Color;
    Part.CFrame = p5.CFrame;
    Part.Size = p5.Size / 3;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Parent = p5;
    local v6 = math.random(5, 30) / 10;
    local v7 = math.random(-50, 50) / 100;
    math.random();
    local Position = Part.Position;
    local Position2 = (Part.CFrame * CFrame.new(v6 * 2, v7 * 6, -4)).Position;
    local u8 = (Part.CFrame * CFrame.new(v6 * 2, v7 * 6, -4)).Position - Vector3.new(0, 10, 0);
    local u9 = nil;
    local u10 = 0;
    u9 = game["Run Service"].RenderStepped:Connect(function(p11) -- Line: 23
        -- upvalues: u10 (ref), u9 (ref), Position (copy), Position2 (copy), u8 (copy), Part (copy)
        u10 = u10 + p11 * 1;

        if u10 > 1 then
            u9:Disconnect();
            u10 = 1;
        end;

        local v12 = game:GetService("TweenService"):GetValue(u10, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        local v13 = game:GetService("TweenService"):GetValue(u10 + p11 * 1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        Part.CFrame = CFrame.new((1 - v12) ^ 2 * Position + 2 * (1 - v12) * v12 * Position2 + v12 ^ 2 * u8, (1 - v13) ^ 2 * Position + 2 * (1 - v13) * v13 * Position2 + v13 ^ 2 * u8) * CFrame.Angles(1.5707963267948966, 0, 0);
    end);
    game:GetService("Debris"):AddItem(Part, 3);
end;