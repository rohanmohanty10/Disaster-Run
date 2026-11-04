 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: ReplicatedStorage (copy), Debris (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local MapFolder = workspace:FindFirstChild("MapFolder");

    if MapFolder then
        MapFolder.Parent = ReplicatedStorage;
        task.delay(3, function() -- Line: 15
            -- upvalues: MapFolder (copy)
            if not workspace:FindFirstChild("MapFolder") then
                MapFolder.Parent = workspace;
            end;
        end);
    end;

    local v3 = script.Score:Clone();
    v3.Parent = Debris;
    v3:PivotTo(p2.CFrame);
    local v4 = script.Map:Clone();
    v4.Parent = Debris;
    v4:PivotTo(CFrame.new(0, 4, -297.5) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966));
    local u5 = script.FakeAtmo:Clone();
    u5.Parent = Lighting;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u6 = ColorCorrection:Clone();
    u6.Name = "CC";
    u6.Parent = Lighting;
    u6.Enabled = true;
    task.delay(3.85, function() -- Line: 41
        -- upvalues: u6 (copy), Lighting (ref), ColorCorrection (copy)
        u6:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    VfxManager.Emit(v3);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 35;
    TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.7);
    u6.Brightness = 1;
    u6.Saturation = -1;
    u6.TintColor = Color3.fromRGB(38, 20, 94);
    TweenService:Create(u6, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
        TintColor = ColorCorrection.TintColor
    }):Play();
    TweenService:Create(u6, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Saturation = ColorCorrection.Saturation
    }):Play();
    task.delay(3, function() -- Line: 67
        -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u6 (copy), ColorCorrection (copy), u5 (copy), ClockTime (copy)
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 35;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.7);
        u6.Brightness = 1;
        u6.Saturation = -1;
        u6.TintColor = Color3.fromRGB(38, 20, 94);
        TweenService:Create(u6, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u6, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        u5:Destroy();

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;
    end);
    VfxManager.DestroyEffect(v3, 3);
    VfxManager.DestroyEffect(v4, 3);
end;