  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1, p2) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    local v3 = ReplicatedStorage["Client Assets"]["The World"].DonutImpact1:Clone();
    v3.Parent = workspace.Effects;
    local CFrame2 = p1.Torso.CFrame;
    local Angles = CFrame.Angles;
    local v4 = math.random(-360, 360);
    local v5 = math.rad(v4);
    local v6 = math.random(-360, 360);
    local v7 = math.rad(v6);
    local v8 = math.random(-360, 360);
    v3.CFrame = CFrame2 * Angles(v5, v7, (math.rad(v8)));
    TweenService:Create(v3, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = v3.Size * 2
    }):Play();
    game.Debris:AddItem(v3, 1);
    local v9 = ReplicatedStorage["Client Assets"]["The World"].DonutImpact2:Clone();
    v9.Parent = workspace.Effects;
    local CFrame3 = p1.Torso.CFrame;
    local Angles2 = CFrame.Angles;
    local v10 = math.random(-360, 360);
    local v11 = math.rad(v10);
    local v12 = math.random(-360, 360);
    local v13 = math.rad(v12);
    local v14 = math.random(-360, 360);
    v9.CFrame = CFrame3 * Angles2(v11, v13, (math.rad(v14)));
    TweenService:Create(v9, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = v9.Size * 2
    }):Play();
    game.Debris:AddItem(v9, 1);

    for _ = 1, 14 do
        local u15 = ReplicatedStorage["Client Assets"]["The World"].WaterBeamIn:Clone();
        u15.Parent = workspace.Effects;
        u15.Color = Color3.fromRGB(255, 255, 255);
        u15.Size = Vector3.new(u15.Size.X, u15.Size.Y, math.random(3, 8));
        local CFrame4 = p1.Torso.CFrame;
        local Angles3 = CFrame.Angles;
        local v16 = math.random(-360, 360);
        local v17 = math.rad(v16);
        local v18 = math.random(-360, 360);
        local v19 = math.rad(v18);
        local v20 = math.random(-360, 360);
        u15.CFrame = CFrame4 * Angles3(v17, v19, (math.rad(v20)));
        TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            CFrame = u15.CFrame * CFrame.new(0, 0, -math.random(6, 12))
        }):Play();
        coroutine.wrap(function() -- Line: 28
            -- upvalues: TweenService (ref), u15 (copy)
            wait(0.25);
            TweenService:Create(u15, TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end)();
        game.Debris:AddItem(u15, 1);
    end;

    local Part = Instance.new("Part");
    Part.Anchored = false;
    Part.Size = p1.Torso.Size;
    Part.CanCollide = false;
    Part.Color = Color3.fromRGB(255, 255, 255);
    Part.Material = Enum.Material.Neon;
    Part.CFrame = p1.Torso.CFrame;
    Part.Parent = workspace.Effects;
    local Weld = Instance.new("Weld");
    Weld.Parent = p1.Torso;
    Weld.Part0 = p1.Torso;
    Weld.Part1 = Part;
    TweenService:Create(Weld.Part1, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Weld.Part1.Size * 3
    }):Play();
    coroutine.wrap(function() -- Line: 49
        -- upvalues: Weld (copy), Part (copy)
        wait(1);
        Weld:Destroy();
        Part:Destroy();
    end)();
end;