  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 2
    -- upvalues: TweenService (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Contrast = 0.6;
    ColorCorrectionEffect.Saturation = 0.8;
    ColorCorrectionEffect.Name = "Exhaustion Color Correction";
    ColorCorrectionEffect.Parent = game.Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0.6,
        Saturation = -0.2,
        Brightness = -0.2
    }):Play();
    task.delay(p1, function() -- Line: 15
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0,
            Saturation = 0
        }):Play();
        task.wait(0.35);
        ColorCorrectionEffect:Destroy();
    end);
end;