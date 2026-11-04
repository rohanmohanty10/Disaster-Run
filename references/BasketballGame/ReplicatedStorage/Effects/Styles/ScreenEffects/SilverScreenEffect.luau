 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 10
    -- upvalues: Lighting (copy), TweenService (copy), VfxManager (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "CCAddon";
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Enabled = true;
    task.delay(0.45, function() -- Line: 16
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect:Destroy();
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 5;
    TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.5);
    ColorCorrectionEffect.Brightness = 0.45;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(47, 255, 116);
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
        Brightness = 0
    }):Play();
end;