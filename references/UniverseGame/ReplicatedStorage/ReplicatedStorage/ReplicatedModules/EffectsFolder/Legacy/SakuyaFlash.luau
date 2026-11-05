  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Enabled = true;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Saturation = -4;
    ColorCorrectionEffect.Contrast = 1;
    ColorCorrectionEffect.Brightness = -0.25;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
        Contrast = 0,
        Saturation = 0,
        Brightness = 0
    }):Play();
    ColorCorrectionEffect.Parent = game.Lighting;
    task.wait(0.5);
    ColorCorrectionEffect:Destroy();
end;