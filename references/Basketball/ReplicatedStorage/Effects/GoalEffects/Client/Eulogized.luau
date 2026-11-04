 
 

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
    local _, v4, _ = p2.CFrame:ToOrientation();
    local v5 = script.Map:Clone();
    v5.Parent = Debris;
    v5:PivotTo(CFrame.new(0, 4, -297.5) * CFrame.Angles(0, v4 + -1.5707963267948966, 1.5707963267948966));
    local u6 = script.FakeAtmo:Clone();
    u6.Parent = Lighting;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u7 = ColorCorrection:Clone();
    u7.Name = "CC";
    u7.Parent = Lighting;
    u7.Enabled = true;
    task.delay(3.85, function() -- Line: 45
        -- upvalues: u7 (copy), Lighting (ref), ColorCorrection (copy)
        u7:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 14 then
        Lighting.ClockTime = 14;
    end;

    VfxManager.Emit(v3);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 35;
    TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.7);
    u7.Brightness = 1;
    u7.Saturation = -1;
    u7.TintColor = Color3.fromRGB(242, 180, 81);
    TweenService:Create(u7, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
        TintColor = ColorCorrection.TintColor
    }):Play();
    TweenService:Create(u7, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Saturation = ColorCorrection.Saturation
    }):Play();
    task.delay(3, function() -- Line: 71
        -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u7 (copy), ColorCorrection (copy), u6 (copy), ClockTime (copy)
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 35;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.7);
        u7.Brightness = 1;
        u7.Saturation = -1;
        u7.TintColor = Color3.fromRGB(242, 180, 81);
        TweenService:Create(u7, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u7, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        u6:Destroy();

        if ClockTime ~= 14 then
            Lighting.ClockTime = ClockTime;
        end;
    end);
    VfxManager.DestroyEffect(v3, 3);
    VfxManager.DestroyEffect(v5, 3);
end;