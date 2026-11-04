 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Debris = workspace:FindFirstChild("Debris");
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 14
    -- upvalues: Lighting (copy), Debris (copy), VfxManager (copy), TweenService (copy)
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u3 = ColorCorrection:Clone();
    u3.Name = "CC";
    u3.Parent = Lighting;
    u3.Enabled = true;
    task.delay(0.555, function() -- Line: 23
        -- upvalues: u3 (copy), ColorCorrection (copy)
        u3:Destroy();
        ColorCorrection.Enabled = true;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u4 = Bloom:Clone();
    u4.Name = "B";
    u4.Parent = Lighting;
    u4.Enabled = true;
    task.delay(0.7, function() -- Line: 36
        -- upvalues: u4 (copy), Lighting (ref), Bloom (copy)
        u4:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local v5 = script.CurrentImpact:Clone();
    v5.CFrame = p2.CFrame;
    v5.Parent = Debris;
    VfxManager.Emit(v5);
    VfxManager.DestroyEffect(v5, 7);
    u3.Brightness = -0.15;
    u3.Contrast = 10;
    u3.Saturation = -1;
    task.wait(0.05);
    u3.Contrast = -10;
    task.wait(0.05);
    u3.Contrast = 10;
    task.wait(0.05);
    u3.Contrast = ColorCorrection.Contrast;
    TweenService:Create(u3, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Saturation = ColorCorrection.Saturation
    }):Play();
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 20;
    TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.7);
    u4.Intensity = 15;
    u4.Threshold = 0.5;
    TweenService:Create(u4, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
        Intensity = Bloom.Intensity,
        Threshold = Bloom.Threshold
    }):Play();
end;