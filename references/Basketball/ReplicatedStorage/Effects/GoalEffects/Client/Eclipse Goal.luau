 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 13
    -- upvalues: Debris (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    if not p2.Preview then
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
        task.delay(4.1, function() -- Line: 31
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

        task.spawn(function() -- Line: 43
            -- upvalues: VfxManager (ref), u3 (copy), Lighting (ref), TweenService (ref), u5 (copy), ColorCorrection (copy)
            VfxManager.Emit(u3);
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 12;
            TweenService:Create(BlurEffect, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.35);
            TweenService:Create(u5, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
                Brightness = -0.15,
                Saturation = -1
            }):Play();
            task.wait(0.082);
            TweenService:Create(u5, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
                Brightness = 0.4
            }):Play();
            task.wait(0.067);
            TweenService:Create(u5, TweenInfo.new(0.055, Enum.EasingStyle.Sine), {
                Brightness = 0.05,
                Saturation = 5,
                TintColor = Color3.fromRGB(120, 0, 0)
            }):Play();
            task.wait(0.055);
            local BlurEffect2 = Instance.new("BlurEffect", Lighting);
            BlurEffect2.Size = 20;
            TweenService:Create(BlurEffect2, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect2, 0.7);
            TweenService:Create(u5, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Brightness = ColorCorrection.Brightness,
                Saturation = ColorCorrection.Saturation,
                TintColor = ColorCorrection.TintColor
            }):Play();
        end);
        task.delay(3, function() -- Line: 71
            -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u5 (copy), ColorCorrection (copy), ClockTime (copy)
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 12;
            TweenService:Create(BlurEffect, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.35);
            TweenService:Create(u5, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
                Brightness = -0.15,
                Saturation = -1
            }):Play();
            task.wait(0.082);
            TweenService:Create(u5, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
                Brightness = 0.4
            }):Play();
            task.wait(0.067);
            TweenService:Create(u5, TweenInfo.new(0.055, Enum.EasingStyle.Sine), {
                Brightness = 0.05,
                Saturation = 5,
                TintColor = Color3.fromRGB(120, 0, 0)
            }):Play();
            task.wait(0.055);
            local BlurEffect2 = Instance.new("BlurEffect", Lighting);
            BlurEffect2.Size = 20;
            TweenService:Create(BlurEffect2, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect2, 0.7);
            TweenService:Create(u5, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Brightness = ColorCorrection.Brightness,
                Saturation = ColorCorrection.Saturation,
                TintColor = ColorCorrection.TintColor
            }):Play();

            if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
                Lighting.ClockTime = ClockTime;
            end;
        end);
        VfxManager.DestroyEffect(u3, 3.204);
        VfxManager.DestroyEffect(v4, 3.204);
    end;
end;