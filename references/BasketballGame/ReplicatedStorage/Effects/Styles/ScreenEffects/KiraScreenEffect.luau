 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 10
    -- upvalues: LocalPlayer (copy), TweenService (copy), VfxManager (copy), Lighting (copy)
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local v2 = script.Vignette:Clone();
    v2.Parent = PlayerGui;
    v2.Enabled = true;
    local Vignette = v2.Vignette;
    local Vignette1 = v2.Vignette1;
    Vignette.ImageTransparency = 0;
    Vignette1.ImageTransparency = 0.5;
    Vignette1.ImageColor3 = Color3.fromRGB(255, 0, 0);
    TweenService:Create(Vignette, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play();
    VfxManager.DestroyEffect(v2, 0.5);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "CCAddon";
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Enabled = true;
    task.delay(0.5, function() -- Line: 31
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect:Destroy();
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 20;
    TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.5);
    ColorCorrectionEffect.TintColor = Color3.fromRGB(133, 33, 33);
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
end;