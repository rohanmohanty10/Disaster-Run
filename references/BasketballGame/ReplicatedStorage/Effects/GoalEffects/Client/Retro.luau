 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Debris (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local _, v3, _ = p2.CFrame:ToOrientation();
    local v4 = script.Map:Clone();
    v4.Parent = Debris;
    v4:PivotTo(CFrame.new(0, 4, -297.5) * CFrame.Angles(0, v3 + -1.5707963267948966, 0));
    local u5 = script.FakeAtmo:Clone();
    u5.Parent = Lighting;
    local u6 = script.FakeSky:Clone();
    u6.Parent = Lighting;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u7 = ColorCorrection:Clone();
    u7.Name = "CC";
    u7.Parent = Lighting;
    u7.Enabled = true;
    task.delay(3.85, function() -- Line: 34
        -- upvalues: u7 (copy), Lighting (ref), ColorCorrection (copy)
        u7:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 35;
    TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.7);
    u7.Brightness = 1;
    u7.Saturation = -1;
    u7.TintColor = Color3.fromRGB(226, 61, 255);
    TweenService:Create(u7, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
        TintColor = ColorCorrection.TintColor
    }):Play();
    TweenService:Create(u7, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Saturation = ColorCorrection.Saturation
    }):Play();
    task.delay(3, function() -- Line: 58
        -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u7 (copy), ColorCorrection (copy), u5 (copy), u6 (copy), ClockTime (copy)
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 35;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.7);
        u7.Brightness = 1;
        u7.Saturation = -1;
        u7.TintColor = Color3.fromRGB(226, 61, 255);
        TweenService:Create(u7, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u7, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        u5:Destroy();
        u6:Destroy();

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;
    end);
    VfxManager.DestroyEffect(v4, 3);
end;