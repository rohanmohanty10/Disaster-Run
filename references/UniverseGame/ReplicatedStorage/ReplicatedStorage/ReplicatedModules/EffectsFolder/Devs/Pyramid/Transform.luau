  

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");

return function() -- Line: 4
    -- upvalues: TweenService (copy), Debris (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game.Lighting);
    ColorCorrectionEffect.Brightness = 1;
    ColorCorrectionEffect.TintColor = Color3.new(0, 1, 0);
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1), {
        Brightness = 0,
        TintColor = Color3.new(1, 1, 1)
    }):Play();
    Debris:AddItem(ColorCorrectionEffect, 1.2);
end;