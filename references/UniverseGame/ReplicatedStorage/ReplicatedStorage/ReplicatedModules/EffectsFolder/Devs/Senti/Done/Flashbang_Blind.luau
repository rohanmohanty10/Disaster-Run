  

 

local u1 = {};

for _, child in pairs(script:GetChildren()) do
    if child:IsA("ModuleScript") then
        u1[child.Name] = require(child);
    end;
end;

return function(p2) -- Line: 8
    -- upvalues: u1 (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = game.Lighting;
    ColorCorrectionEffect.Brightness = 1;
    ColorCorrectionEffect.Contrast = 2;
    ColorCorrectionEffect.Saturation = 0.7;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Parent = game.Lighting;
    BlurEffect.Size = 24;
    u1.CameraMatrix:ManipulateMatrix({
        Type = "Sporadic",
        Duration = 20,
        Intensity = 0.85,
        Victim = p2
    });
    u1.TweenSystem:CreateTween({ ColorCorrectionEffect, BlurEffect }, {
        TweenInfo.new(3.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
        {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0
        },
        TweenInfo.new(3.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
        {
            Size = 0
        }
    });
end;