 

 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");

return function(p1: string, p2: number, p3: number, p4: number, p5, p6: number) -- Line: 12
    -- upvalues: Lighting (copy), TweenService (copy), Debris (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Brightness = p2;
    ColorCorrectionEffect.Saturation = p3;
    ColorCorrectionEffect.Contrast = p4;
    ColorCorrectionEffect.TintColor = p5 or Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;

    if p1 == "emit" then
        local v7 = p6 or 0.2;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(v7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = 0,
            Saturation = 0,
            Contrast = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        Debris:AddItem(ColorCorrectionEffect, v7);

        return;
    end;

    if p1 == "instant" then
        task.delay(p6 or 0.1, function() -- Line: 42
            -- upvalues: ColorCorrectionEffect (copy)
            if ColorCorrectionEffect and ColorCorrectionEffect.Parent then
                ColorCorrectionEffect:Destroy();
            end;
        end);

        return;
    end;

    warn("[CCEffect] Unknown mode:", p1);
    ColorCorrectionEffect:Destroy();
end;