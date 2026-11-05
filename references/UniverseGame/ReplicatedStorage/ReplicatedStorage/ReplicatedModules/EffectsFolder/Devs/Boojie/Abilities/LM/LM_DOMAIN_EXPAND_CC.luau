  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 9
    -- upvalues: TweenService (copy)
    local v2 = p1.In or 0.5;
    local v3 = p1.Out or 0.25;
    local v4 = p1.Time or 1;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = game.Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(v2, Enum.EasingStyle.Linear), {
        Brightness = 1,
        Contrast = 10,
        Saturation = -1
    }):Play();
    task.wait(v4);
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(v3, Enum.EasingStyle.Linear), {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0
    }):Play();
    task.wait(v3);
    ColorCorrectionEffect:Destroy();
end;