 
 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");

return function(p1: number, p2: number, p3: number, p4, p5: number) -- Line: 5
    -- upvalues: Lighting (copy), TweenService (copy), Debris (copy)
    local v6 = p5 or 0.2;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Brightness = p1;
    ColorCorrectionEffect.Saturation = p2;
    ColorCorrectionEffect.Contrast = p3;
    ColorCorrectionEffect.TintColor = p4 or Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(v6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Brightness = 0,
        Saturation = 0,
        Contrast = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    Debris:AddItem(ColorCorrectionEffect, v6);
end;