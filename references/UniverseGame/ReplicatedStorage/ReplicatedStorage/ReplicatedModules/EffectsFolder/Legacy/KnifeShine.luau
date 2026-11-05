  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    local v2 = ReplicatedStorage["Client Assets"]["The World"].Shine:Clone();
    v2.Parent = p1;
    TweenService:Create(v2.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 0
    }):Play();
    TweenService:Create(v2, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(2, 0, 2, 0)
    }):Play();
    TweenService:Create(v2.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Rotation = -50
    }):Play();
    wait(0.4);
    TweenService:Create(v2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play();
    TweenService:Create(v2.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Rotation = 36
    }):Play();
    game.Debris:AddItem(v2, 1);
end;