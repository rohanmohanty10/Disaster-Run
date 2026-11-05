  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 9
    -- upvalues: TweenService (copy)
    local v2 = p1.In or 1;
    local v3 = p1.Out or 0.25;
    local v4 = p1.Time or 1;
    local v5 = p1.StartInfo or { Enum.EasingStyle.Exponential, Enum.EasingDirection.In };
    local v6 = p1.EndInfo or { Enum.EasingStyle.Linear, Enum.EasingDirection.In };
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = game.Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(v2, unpack(v5)), {
        Brightness = p1.Brightness or 1,
        Contrast = p1.Contrast or 0,
        Saturation = p1.Saturation or 0,
        TintColor = p1.TintColor or Color3.new(1, 1, 1)
    }):Play();
    task.wait(v4);
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(v3, unpack(v6)), {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.new(1, 1, 1)
    }):Play();
    task.wait(v3);
    ColorCorrectionEffect:Destroy();
end;