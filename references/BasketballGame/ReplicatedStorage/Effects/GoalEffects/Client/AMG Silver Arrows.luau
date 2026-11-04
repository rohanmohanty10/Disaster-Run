 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: Knit (copy), Debris (copy), LocalPlayer (copy), ReplicatedStorage (copy), VfxManager (copy), TweenService (copy), SfxManager (copy), Lighting (copy)
    local Controller = Knit.GetController("MovementController");
    local v3 = script.AtomicGoalEffect:Clone();
    v3.Parent = Debris;
    v3:PivotTo(p2.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    local v4 = script.Map:Clone();
    v4.Parent = Debris;
    v4:PivotTo(CFrame.new(0, 4, -297.5) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966));

    if LocalPlayer.Team ~= game.Teams.Visitor and LocalPlayer.Character ~= p2.Plr.Character then
        local EMPERORKNEELANIMATION = ReplicatedStorage.Assets.VFX.Emotes.EMPERORKNEELANIMATION;
        local Character = LocalPlayer.Character;

        if Character then
            local u5 = Character:FindFirstChild("Humanoid"):LoadAnimation(EMPERORKNEELANIMATION);
            u5:Play();
            Controller.States.Kneeling = true;
            task.delay(3, function() -- Line: 36
                -- upvalues: Controller (copy), u5 (copy)
                Controller.States.Kneeling = false;
                u5:Stop();
            end);
        end;
    end;

    local u6 = script.Model:Clone();
    u6.Parent = Debris;
    u6:PivotTo(p2.CFrame * CFrame.fromOrientation(0, 1.5707963267948966, 0));
    u6.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = u6["Meshes/1_Circle.001 (3)"];
    task.delay(0.5166666666666667, function() -- Line: 55
        -- upvalues: VfxManager (ref), u6 (copy)
        VfxManager.Emit(u6.Land);
    end);
    task.delay(1.15, function() -- Line: 59
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 0,
            FillColor = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.1);
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(1.3166666666666667, function() -- Line: 65
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 0,
            FillColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.wait(0.1);
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(1.4833333333333334, function() -- Line: 71
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 0,
            FillColor = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.1);
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(1.65, function() -- Line: 77
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 0,
            FillColor = Color3.fromRGB(0, 161, 156)
        }):Play();
        task.wait(0.1);
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(1.8166666666666667, function() -- Line: 83
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 0,
            FillColor = Color3.fromRGB(0, 161, 156)
        }):Play();
        task.wait(0.1);
        TweenService:Create(Highlight, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(1.9666666666666666, function() -- Line: 89
        -- upvalues: SfxManager (ref)
        SfxManager:playSound({
            Sound = "Target Hit",
            Parent = workspace
        });
    end);
    task.delay(2.1333333333333333, function() -- Line: 93
        -- upvalues: u6 (copy), VfxManager (ref), TweenService (ref)
        u6["Meshes/1_Circle.001 (3)"].Transparency = 1;
        VfxManager.Emit(u6.Explosion);
        VfxManager.Emit(u6.Slam);
        u6.Light.PointLight.Enabled = true;
        TweenService:Create(u6.Light.PointLight, TweenInfo.new(1), {
            Range = 0
        }):Play();
    end);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u7 = ColorCorrection:Clone();
    u7.Name = "CC";
    u7.Parent = Lighting;
    u7.Enabled = true;
    task.delay(4.85, function() -- Line: 111
        -- upvalues: u7 (copy), ColorCorrection (copy)
        u7:Destroy();
        ColorCorrection.Enabled = true;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u8 = Bloom:Clone();
    u8.Name = "B";
    u8.Parent = Lighting;
    u8.Enabled = true;
    task.delay(0.7, function() -- Line: 124
        -- upvalues: u8 (copy), Lighting (ref), Bloom (copy)
        u8:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local u9 = script.FakeAtmo:Clone();
    u9.Parent = Lighting;
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    VfxManager.Emit(v3.Emit);
    VfxManager.Emit(v3.EmittingParts);
    VfxManager.Enable(v3.BeamParts, true);
    VfxManager.Enable(v3.AuraBG, true);
    VfxManager.DestroyEffect(v3, 3);
    VfxManager.DestroyEffect(v4, 3);
    VfxManager.DestroyEffect(u6, 6);
    task.delay(3, function() -- Line: 148
        -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u7 (copy), ColorCorrection (copy), u9 (copy), ClockTime (copy)
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u7.Brightness = 1;
        u7.Saturation = -1;
        u7.TintColor = Color3.fromRGB(0, 161, 156);
        TweenService:Create(u7, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u7, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
        u9:Destroy();

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;
    end);
    u7.Brightness = -0.15;
    u7.Contrast = 10;
    u7.Saturation = -1;
    task.wait(0.05);
    u7.Contrast = -10;
    task.wait(0.05);
    u7.Contrast = 10;
    task.wait(0.05);
    u7.Contrast = 0.5;
    TweenService:Create(u7, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Saturation = ColorCorrection.Saturation
    }):Play();
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 20;
    TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.7);
    u8.Intensity = 15;
    u8.Threshold = 0.5;
    TweenService:Create(u8, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
        Intensity = Bloom.Intensity,
        Threshold = Bloom.Threshold
    }):Play();
end;