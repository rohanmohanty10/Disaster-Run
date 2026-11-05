  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    local u3 = ReplicatedStorage["Client Assets"]["The World"].TSHitEffect1:Clone();
    u3.Parent = game.Workspace;
    u3.CFrame = p2.HumanoidRootPart.CFrame * CFrame.new(math.random(-2, 2) * 0.75, math.random(-2, 2) * 0.75, -5.5) * CFrame.Angles(1.5707963267948966, 0, 0);
    local u4 = ReplicatedStorage["Client Assets"]["The World"].BigCircleDonut:Clone();
    u4.Parent = game.Workspace;
    local CFrame2 = p1.Torso.CFrame;
    local Angles = CFrame.Angles;
    local v5 = math.random(-360, 360);
    local v6 = math.rad(v5);
    local v7 = math.random(-360, 360);
    local v8 = math.rad(v7);
    local v9 = math.random(-360, 360);
    u4.CFrame = CFrame2 * Angles(v6, v8, (math.rad(v9)));
    local v10 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v11 = {
        Transparency = 1
    };
    local CFrame3 = u3.CFrame;
    local Angles2 = CFrame.Angles;
    local v12 = math.random(-360, 360);
    v11.CFrame = CFrame3 * Angles2(0, math.rad(v12), 0);
    v11.Size = u3.Size * math.random(3, 4);
    TweenService:Create(u3, v10, v11):Play();
    TweenService:Create(u4, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = u4.Size * math.random(6, 9),
        CFrame = u4.CFrame * CFrame.new(0, 0, 2)
    }):Play();
    coroutine.wrap(function() -- Line: 16
        -- upvalues: u3 (copy), u4 (copy)
        wait(2);
        u3:Destroy();
        u4:Destroy();
    end)();
end;