 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 13
    -- upvalues: Debris (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local u3 = script.Score:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    local v4 = script.Map:Clone();
    v4.Parent = Debris;
    v4:PivotTo(CFrame.new(0, 4, -297.5) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966));
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u5 = ColorCorrection:Clone();
    u5.Name = "CC";
    u5.Parent = Lighting;
    u5.Enabled = true;
    task.delay(4.1, function() -- Line: 30
        -- upvalues: u5 (copy), Lighting (ref), ColorCorrection (copy)
        u5:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    task.spawn(function() -- Line: 42
        -- upvalues: VfxManager (ref), u3 (copy), u5 (copy), ColorCorrection (copy), TweenService (ref), Lighting (ref)
        VfxManager.Emit(u3);
        u5.Brightness = -0.15;
        u5.Contrast = 10;
        u5.Saturation = -1;
        u5.TintColor = Color3.fromRGB(157, 146, 255);
        task.wait(0.05);
        u5.Contrast = -10;
        task.wait(0.05);
        u5.Contrast = 10;
        task.wait(0.05);
        u5.Contrast = ColorCorrection.Contrast;
        TweenService:Create(u5, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        TweenService:Create(u5, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(3, function() -- Line: 71
        -- upvalues: u5 (copy), ColorCorrection (copy), TweenService (ref), Lighting (ref), VfxManager (ref), ClockTime (copy)
        u5.Brightness = -0.15;
        u5.Contrast = 10;
        u5.Saturation = -1;
        u5.TintColor = Color3.fromRGB(157, 146, 255);
        task.wait(0.05);
        u5.Contrast = -10;
        task.wait(0.05);
        u5.Contrast = 10;
        task.wait(0.05);
        u5.Contrast = ColorCorrection.Contrast;
        TweenService:Create(u5, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;
    end);
    VfxManager.DestroyEffect(u3, 3.15);
    VfxManager.DestroyEffect(v4, 3.15);
end;