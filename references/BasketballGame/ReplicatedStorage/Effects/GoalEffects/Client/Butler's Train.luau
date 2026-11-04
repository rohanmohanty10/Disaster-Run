 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: ReplicatedStorage (copy), Debris (copy), SfxManager (copy), TweenService (copy), Lighting (copy), VfxManager (copy)
    local MapFolder = workspace:FindFirstChild("MapFolder");

    if MapFolder then
        MapFolder.Parent = ReplicatedStorage;
        task.delay(4, function() -- Line: 15
            -- upvalues: MapFolder (copy)
            if not workspace:FindFirstChild("MapFolder") then
                MapFolder.Parent = workspace;
            end;
        end);
    end;

    local _, v3, _ = p2.CFrame:ToOrientation();
    local v4 = script.Score:Clone();
    v4.Parent = Debris;
    v4:PivotTo(p2.CFrame);
    local v5 = script.Map:Clone();
    v5.Parent = Debris;
    v5:PivotTo(CFrame.new(0, 4, -297.5) * CFrame.Angles(0, v3 + 1.5707963267948966, 1.5707963267948966));
    SfxManager:playSound({
        Sound = "Butler\'s TrainSFX",
        Parent = workspace
    });
    local Train = v5.Train;
    Train.Parent = Debris;
    local PrimaryPart = Train.PrimaryPart;
    PrimaryPart.CFrame = PrimaryPart.CFrame * CFrame.new(500, 0, 0);
    TweenService:Create(Train.PrimaryPart, TweenInfo.new(3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        CFrame = Train.PrimaryPart.CFrame * CFrame.new(-500, 0, 0)
    }):Play();
    Train.Character.Humanoid:LoadAnimation(script.Animation):Play();
    task.delay(3, function() -- Line: 41
        -- upvalues: TweenService (ref), Train (copy)
        TweenService:Create(Train.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            CFrame = Train.PrimaryPart.CFrame * CFrame.new(-500, 0, 0)
        }):Play();
    end);
    local u6 = script.FakeAtmo:Clone();
    u6.Parent = Lighting;
    local u7 = script.FakeSky:Clone();
    u7.Parent = Lighting;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u8 = ColorCorrection:Clone();
    u8.Name = "CC";
    u8.Parent = Lighting;
    u8.Enabled = true;
    task.delay(4.85, function() -- Line: 59
        -- upvalues: u8 (copy), Lighting (ref), ColorCorrection (copy)
        u8:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 14 then
        Lighting.ClockTime = 14;
    end;

    VfxManager.Emit(v4);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 35;
    TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.7);
    u8.Brightness = 1;
    u8.Saturation = -1;
    u8.TintColor = Color3.fromRGB(207, 223, 240);
    TweenService:Create(u8, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
        TintColor = ColorCorrection.TintColor
    }):Play();
    TweenService:Create(u8, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Saturation = ColorCorrection.Saturation
    }):Play();
    task.delay(4, function() -- Line: 85
        -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u8 (copy), ColorCorrection (copy), u6 (copy), u7 (copy), ClockTime (copy)
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 35;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.7);
        u8.Brightness = 1;
        u8.Saturation = -1;
        u8.TintColor = Color3.fromRGB(207, 223, 240);
        TweenService:Create(u8, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u8, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        u6:Destroy();
        u7:Destroy();

        if Lighting.ClockTime ~= ClockTime then
            Lighting.ClockTime = ClockTime;
        end;
    end);
    VfxManager.DestroyEffect(v4, 4);
    VfxManager.DestroyEffect(v5, 4);
    VfxManager.DestroyEffect(Train, 4);
end;