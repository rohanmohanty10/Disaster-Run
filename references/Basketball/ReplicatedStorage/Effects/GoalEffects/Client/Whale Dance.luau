 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 10
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Lighting (copy), TweenService (copy)
    SfxManager:playSound({
        Sound = "WhaleDanceSFX",
        Parent = workspace
    });
    local u3 = script.Model:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    u3.Whale1.AnimationController.Animator:LoadAnimation(script["1"]):Play();
    u3.Whale2.AnimationController.Animator:LoadAnimation(script["2"]):Play();
    VfxManager.BetterEmit(u3.First);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u4 = ColorCorrection:Clone();
    u4.Name = "CC";
    u4.Parent = Lighting;
    u4.Enabled = true;
    task.delay(1.75, function() -- Line: 30
        -- upvalues: u4 (copy), Lighting (ref), ColorCorrection (copy)
        u4:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u5 = Bloom:Clone();
    u5.Name = "B";
    u5.Parent = Lighting;
    u5.Enabled = true;
    u5.Intensity = 2;
    u5.Threshold = 0.5;
    task.delay(2, function() -- Line: 47
        -- upvalues: u5 (copy), Lighting (ref), Bloom (copy)
        u5:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 35;
    TweenService:Create(BlurEffect, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.6);
    u5.Intensity = 15;
    u5.Threshold = 0.5;
    TweenService:Create(u5, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
        Intensity = Bloom.Intensity,
        Threshold = Bloom.Threshold
    }):Play();
    u4.Brightness = 0.45;
    u4.TintColor = Color3.fromRGB(181, 249, 255);
    TweenService:Create(u4, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        TintColor = ColorCorrection.TintColor
    }):Play();
    task.delay(1.3, function() -- Line: 67
        -- upvalues: VfxManager (ref), u3 (copy), Lighting (ref), TweenService (ref), u5 (copy), Bloom (copy), u4 (copy), ColorCorrection (copy)
        VfxManager.Emit(u3.Second);
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 35;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.6);
        u5.Intensity = 15;
        u5.Threshold = 0.5;
        TweenService:Create(u5, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u4.Brightness = 0.45;
        u4.TintColor = Color3.fromRGB(181, 249, 255);
        TweenService:Create(u4, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(1.95, function() -- Line: 84
        -- upvalues: u3 (copy)
        u3.Whale1:Destroy();
        u3.Whale2:Destroy();
    end);
    VfxManager.DestroyEffect(u3, 8);
end;