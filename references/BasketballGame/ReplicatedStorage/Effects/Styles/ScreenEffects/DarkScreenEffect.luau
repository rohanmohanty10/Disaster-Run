 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 10
    -- upvalues: LocalPlayer (copy), TweenService (copy), VfxManager (copy), Lighting (copy)
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local v1 = script.Vignette:Clone();
    v1.Parent = PlayerGui;
    v1.Enabled = true;
    local Vignette = v1.Vignette;
    local _ = v1.Vignette1;
    Vignette.ImageTransparency = 0;
    TweenService:Create(Vignette, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play();
    VfxManager.DestroyEffect(v1, 0.5);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "CCAddon";
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Enabled = true;
    task.delay(0.75, function() -- Line: 28
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect:Destroy();
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 5;
    TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.5);
    ColorCorrectionEffect.Brightness = 0.25;
    ColorCorrectionEffect.Contrast = 1.25;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(55, 55, 55);
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
        Brightness = 0,
        Contrast = 0
    }):Play();
end;