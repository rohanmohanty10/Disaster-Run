  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    local v3 = ReplicatedStorage["Client Assets"].DragonSage.LDashEffect:Clone();
    v3.Parent = game.Workspace.Effects;
    v3.Ball.Position = p1;
    v3.Dash.CFrame = CFrame.new(p1, p2) * CFrame.new(0, 0, -4.5);
    TweenService:Create(v3.Ball, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = v3.Ball.Size + Vector3.new(0.5, 0.5, 0.5)
    }):Play();
    TweenService:Create(v3.Dash, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = v3.Dash.Size + Vector3.new(0.5, 0.5, 0.5)
    }):Play();
    game.Debris:AddItem(v3, 1);
    wait(0.15);
    TweenService:Create(v3.Ball, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = v3.Ball.Size - Vector3.new(0.5, 0.5, 0.5)
    }):Play();
    TweenService:Create(v3.Dash, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = v3.Dash.Size - Vector3.new(0.5, 0.5, 0.5)
    }):Play();
    wait(0.15);
    TweenService:Create(v3.Ball, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = v3.Ball.Size + Vector3.new(0.5, 0.5, 0.5)
    }):Play();
    TweenService:Create(v3.Dash, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = v3.Dash.Size + Vector3.new(0.5, 0.5, 0.5)
    }):Play();
end;