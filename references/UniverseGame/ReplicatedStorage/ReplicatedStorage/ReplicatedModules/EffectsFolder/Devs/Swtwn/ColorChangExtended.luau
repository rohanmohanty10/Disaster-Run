  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2, p3, p4) -- Line: 2
    -- upvalues: TweenService (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "TSEffect";
    game.Debris:AddItem(ColorCorrectionEffect, p4);
    ColorCorrectionEffect.Parent = game.Lighting;
    TweenService:Create(game.Lighting.TSEffect, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Brightness = p2,
        TintColor = p1,
        Saturation = p3
    }):Play();
end;