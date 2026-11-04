 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, u2) -- Line: 14
    -- upvalues: Knit (copy), SfxManager (copy), Debris (copy), LocalPlayer (copy), ReplicatedStorage (copy), Lighting (copy), Essentials (copy), VfxManager (copy), TweenService (copy)
    local Controller = Knit.GetController("MovementController");
    SfxManager:playSound({
        Sound = "Ranked Crown",
        Parent = workspace
    });
    local u3 = script.Crown:Clone();
    u3.Parent = Debris;
    u3:PivotTo(u2.CFrame);
    local v4 = script.AtomicGoalEffect:Clone();
    v4.Parent = Debris;
    v4:PivotTo(u2.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    local v5 = script.Map:Clone();
    v5.Parent = Debris;
    v5:PivotTo(CFrame.new(0, 4, -297.5) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966));
    local Highlight = Instance.new("Highlight", u3);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(255, 125, 166);
    Highlight.FillTransparency = 0.9;
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0.5;
    local NumberValue = Instance.new("NumberValue", u3);
    NumberValue.Changed:Connect(function() -- Line: 39
        -- upvalues: NumberValue (copy), u3 (copy), u2 (copy)
        if NumberValue.Value > 0 then
            u3:ScaleTo(NumberValue.Value);
            u3:PivotTo(u2.CFrame * CFrame.new(0, 0, -1.5 * NumberValue.Value));
        end;
    end);
    u3.Humanoid:LoadAnimation(script.Animation):Play();

    if LocalPlayer.Team ~= game.Teams.Visitor and LocalPlayer.Character ~= u2.Plr.Character then
        local EMPERORKNEELANIMATION = ReplicatedStorage.Assets.VFX.Emotes.EMPERORKNEELANIMATION;
        local Character = LocalPlayer.Character;

        if Character then
            local u6 = Character:FindFirstChild("Humanoid"):LoadAnimation(EMPERORKNEELANIMATION);
            u6:Play();
            Controller.States.Kneeling = true;
            task.delay(3, function() -- Line: 60
                -- upvalues: Controller (copy), u6 (copy)
                Controller.States.Kneeling = false;
                u6:Stop();
            end);
        end;
    end;

    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u7 = ColorCorrection:Clone();
    u7.Name = "CC";
    u7.Parent = Lighting;
    u7.Enabled = true;
    task.delay(4.85, function() -- Line: 76
        -- upvalues: u7 (copy), Lighting (ref), ColorCorrection (copy)
        u7:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local u8 = script.FakeAtmo:Clone();
    u8.Parent = Lighting;
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    local v9 = script.Emit:Clone();
    v9.Parent = Debris;
    v9.CFrame = u3.Crown.CFrame;
    Essentials:Weld(v9, u3.Crown);
    VfxManager.Emit(v9);
    VfxManager.DestroyEffect(v9, 2);
    NumberValue.Value = 0;
    TweenService:Create(NumberValue, TweenInfo.new(0.5333333333333333), {
        Value = 1
    }):Play();
    task.delay(0.23333333333333334, function() -- Line: 101
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3, true);
    end);
    task.delay(3.65, function() -- Line: 105
        -- upvalues: VfxManager (ref), u3 (copy), TweenService (ref), NumberValue (copy)
        VfxManager.Enable(u3, false);
        TweenService:Create(NumberValue, TweenInfo.new(0.85), {
            Value = 0
        }):Play();
    end);
    VfxManager.Emit(v4.Emit);
    VfxManager.Emit(v4.EmittingParts);
    VfxManager.Enable(v4.BeamParts, true);
    VfxManager.Enable(v4.AuraBG, true);
    VfxManager.DestroyEffect(u3, 3);
    VfxManager.DestroyEffect(v4, 3);
    VfxManager.DestroyEffect(v5, 3);
    task.delay(3, function() -- Line: 119
        -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u7 (copy), ColorCorrection (copy), u8 (copy), ClockTime (copy)
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u7.Brightness = 1;
        u7.Saturation = -1;
        u7.TintColor = Color3.fromRGB(255, 125, 166);
        TweenService:Create(u7, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u7, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
        u8:Destroy();

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 35;
    TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.7);
    u7.Brightness = 1;
    u7.Saturation = -1;
    u7.TintColor = Color3.fromRGB(255, 125, 166);
    TweenService:Create(u7, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
        TintColor = ColorCorrection.TintColor
    }):Play();
    TweenService:Create(u7, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Contrast = ColorCorrection.Contrast,
        Saturation = ColorCorrection.Saturation
    }):Play();
end;