  

 

local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 4
    -- upvalues: Lighting (copy), TweenService (copy)
    local v2 = p1 or {};
    local v3 = v2.Duration or 0.1;
    local v4 = v2.Easing or { Enum.EasingStyle.Quad, Enum.EasingDirection.Out };
    local CanTween = v2.CanTween;
    local TweensToProperties = v2.TweensToProperties;
    local v5 = v2.Brightness or 5;
    local v6 = v2.Saturation or -1;
    local v7 = v2.Contrast or 2;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Brightness = TweensToProperties and 0 or v5;
    ColorCorrectionEffect.Saturation = TweensToProperties and 0 or v6;
    ColorCorrectionEffect.Contrast = TweensToProperties and 0 or v7;

    if CanTween then
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(v3, table.unpack(v4)), {
            Brightness = TweensToProperties and v5 and v5 or 0,
            Contrast = TweensToProperties and v7 and v7 or 0,
            Saturation = TweensToProperties and v6 and v6 or 0
        }):Play();
    end;

    task.delay(v3, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
end;