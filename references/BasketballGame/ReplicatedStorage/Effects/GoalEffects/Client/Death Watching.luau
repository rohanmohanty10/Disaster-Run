 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), LocalPlayer (copy), Lighting (copy), Debris (copy), TweenService (copy), VfxManager (copy)
    if p2.Preview then
        return;
    end;

    SfxManager:playSound({
        Sound = "Death WatchingSFX",
        Parent = workspace
    });
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u3 = script.Vignette:Clone();
    u3.Parent = PlayerGui;
    u3.Enabled = true;
    local _ = u3.Vignette;
    local Vignette1 = u3.Vignette1;
    task.delay(4.766666666666667, function() -- Line: 25
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "CCAddon";
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Enabled = true;
    task.delay(5.016666666666667, function() -- Line: 34
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect:Destroy();
    end);
    local u4 = script.Model:Clone();
    u4.Parent = Debris;
    u4:PivotTo(p2.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    u4.Skeleton.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    task.delay(0.15, function() -- Line: 44
        -- upvalues: u4 (copy), Vignette1 (copy), TweenService (ref), u3 (copy), Lighting (ref), VfxManager (ref), ColorCorrectionEffect (copy)
        shared.vfx.emit(u4);
        Vignette1.ImageColor3 = Color3.fromRGB(67, 117, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        u3.Vignette2.ImageTransparency = 0;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.5);
        ColorCorrectionEffect.Brightness = 0.45;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(67, 117, 255);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
    end);
    task.delay(4.266666666666667, function() -- Line: 65
        -- upvalues: u4 (copy), Vignette1 (copy), TweenService (ref), u3 (copy), Lighting (ref), VfxManager (ref), ColorCorrectionEffect (copy)
        shared.vfx.emit(u4.Score);
        Vignette1.ImageColor3 = Color3.fromRGB(67, 117, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(u3.Vignette2, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.5);
        ColorCorrectionEffect.Brightness = 0.45;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(67, 117, 255);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
    end);
    VfxManager.DestroyEffect(u4.Skeleton, 4.266666666666667);
    VfxManager.DestroyEffect(u4, 8);
end;