  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    local v2 = ReplicatedStorage["Client Assets"]["The World"].KnifeThrow:Clone();
    v2.Parent = game.Workspace.Effects;
    local v3 = p1.CFrame * CFrame.new(0, 0, -5);
    local Angles = CFrame.Angles;
    local v4 = math.random(-360, 360);
    v2.CFrame = v3 * Angles(1.5707963267948966, math.rad(v4), 0);
    TweenService:Create(v2, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = v2.Size * 7,
        CFrame = v2.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
    }):Play();
    game.Debris:AddItem(v2, 1);

    for _ = 1, 14 do
        local v5 = ReplicatedStorage["Client Assets"]["The World"].WaterBeamIn:Clone();
        v5.Parent = game.Workspace.Effects;
        v5.Color = Color3.fromRGB(255, 255, 255);
        v5.Size = Vector3.new(v5.Size.X / 2, v5.Size.Y / 2, math.random(3, 12));
        local v6 = p1.CFrame * CFrame.new(0, 0, -5);
        local Angles2 = CFrame.Angles;
        local v7 = math.random(-360, 360);
        local v8 = math.rad(v7);
        local v9 = math.random(-360, 360);
        local v10 = math.rad(v9);
        local v11 = math.random(-360, 360);
        v5.CFrame = v6 * Angles2(v8, v10, (math.rad(v11)));
        TweenService:Create(v5, TweenInfo.new(0.3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Transparency = 1,
            CFrame = v5.CFrame * CFrame.new(0, 0, -math.random(10, 12))
        }):Play();
        game.Debris:AddItem(v5, 1);
    end;
end;