  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 2
    -- upvalues: TweenService (copy)
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = p1;
    BlurEffect.Parent = game.Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(p2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = 0
    });
    game.Debris:AddItem(BlurEffect, p2);
end;