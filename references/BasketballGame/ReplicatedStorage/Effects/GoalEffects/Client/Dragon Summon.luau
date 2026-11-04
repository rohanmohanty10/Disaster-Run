 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 13
    -- upvalues: Debris (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    if p2.Preview then
        local u3 = script.Dragon:Clone();
        u3.Parent = Debris;
        u3:PivotTo(p2.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
        u3:ScaleTo(0.1);
        u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
        task.spawn(function() -- Line: 116
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.Emit(u3.Score);

            for _, descendant in pairs(u3.Nurbspath1:GetDescendants()) do
                if descendant:IsA("Attachment") and descendant.Name ~= "Breath" then
                    VfxManager.Enable(descendant, true);
                end;
            end;
        end);
        task.delay(1.25, function() -- Line: 126
            -- upvalues: u3 (copy), VfxManager (ref)
            local Breath = u3.Nurbspath1:FindFirstChild("Breath", true);

            if Breath then
                VfxManager.Enable(Breath, true);
            end;
        end);
        task.delay(1.8833333333333333, function() -- Line: 133
            -- upvalues: u3 (copy), VfxManager (ref)
            local Breath = u3.Nurbspath1:FindFirstChild("Breath", true);

            if Breath then
                VfxManager.Enable(Breath, true);
            end;
        end);
        task.delay(2.7333333333333334, function() -- Line: 140
            -- upvalues: u3 (copy), VfxManager (ref)
            u3.Nurbspath1.Transparency = 1;
            VfxManager.Enable(u3.Nurbspath1, false);
        end);
        VfxManager.DestroyEffect(u3, 8);

        return;
    end;

    local u4 = script.Dragon:Clone();
    u4.Parent = Debris;
    u4:PivotTo(p2.CFrame);
    u4.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u5 = ColorCorrection:Clone();
    u5.Name = "CC";
    u5.Parent = Lighting;
    u5.Enabled = true;
    task.delay(0.85, function() -- Line: 31
        -- upvalues: u5 (copy), Lighting (ref), ColorCorrection (copy)
        u5:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u6 = Bloom:Clone();
    u6.Name = "B";
    u6.Parent = Lighting;
    u6.Enabled = true;
    task.delay(0.85, function() -- Line: 46
        -- upvalues: u6 (copy), Lighting (ref), Bloom (copy)
        u6:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 53
        -- upvalues: VfxManager (ref), u4 (copy), Lighting (ref), TweenService (ref), u6 (copy), Bloom (copy), u5 (copy), ColorCorrection (copy)
        VfxManager.Emit(u4.Score);

        for _, descendant in pairs(u4.Nurbspath1:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name ~= "Breath" then
                VfxManager.Enable(descendant, true);
            end;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u6.Intensity = 15;
        u6.Threshold = 0.5;
        TweenService:Create(u6, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u5.Brightness = 1;
        u5.Saturation = -1;
        u5.TintColor = Color3.fromRGB(255, 45, 20);
        TweenService:Create(u5, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u5, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(1.25, function() -- Line: 79
        -- upvalues: u4 (copy), VfxManager (ref)
        local Breath = u4.Nurbspath1:FindFirstChild("Breath", true);

        if Breath then
            VfxManager.Enable(Breath, true);
        end;
    end);
    task.delay(1.8833333333333333, function() -- Line: 86
        -- upvalues: u4 (copy), VfxManager (ref)
        local Breath = u4.Nurbspath1:FindFirstChild("Breath", true);

        if Breath then
            VfxManager.Enable(Breath, true);
        end;
    end);
    task.delay(2.7333333333333334, function() -- Line: 93
        -- upvalues: u4 (copy), VfxManager (ref)
        u4.Nurbspath1.Transparency = 1;
        VfxManager.Enable(u4.Nurbspath1, false);
    end);
    VfxManager.DestroyEffect(u4, 8);
end;