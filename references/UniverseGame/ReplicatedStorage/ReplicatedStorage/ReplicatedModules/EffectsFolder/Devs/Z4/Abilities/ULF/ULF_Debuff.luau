  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 2
    -- upvalues: TweenService (copy)
    local v3 = p2 or 3;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = p1 or 200;
    BlurEffect.Parent = game.Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(v3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(v3, BlurEffect.Destroy, BlurEffect);
end;