 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");
local u1 = script:GetAttribute("Color").Keypoints[1].Value:Lerp(script:GetAttribute("Color").Keypoints[2].Value, 0.5);

local function EvaluateColorSequence(p2, p3) -- Line: 17
    local math_clamp_ret = math.clamp(p3, 0, 1);
    local Keypoints = p2.Keypoints;

    for i = 1, #Keypoints - 1 do
        local v4 = Keypoints[i];
        local v5 = Keypoints[i + 1];

        if v4.Time <= math_clamp_ret and math_clamp_ret <= v5.Time then
            return v4.Value:Lerp(v5.Value, (math_clamp_ret - v4.Time) / (v5.Time - v4.Time));
        end;

        local _ = i;
    end;

    return Keypoints[#Keypoints].Value;
end;

return function(p6, u7) -- Line: 35
    -- upvalues: Knit (copy), SfxManager (copy), Debris (copy), LocalPlayer (copy), ReplicatedStorage (copy), Lighting (copy), Essentials (copy), VfxManager (copy), TweenService (copy), u1 (copy), RunService (copy), EvaluateColorSequence (copy)
    local Controller = Knit.GetController("MovementController");
    SfxManager:playSound({
        Sound = "Ranked Crown",
        Parent = workspace
    });
    local u8 = script.Crown:Clone();
    u8.Parent = Debris;
    u8:PivotTo(u7.CFrame);
    local v9 = script.AtomicGoalEffect:Clone();
    v9.Parent = Debris;
    v9:PivotTo(u7.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    local v10 = script.Map:Clone();
    v10.Parent = Debris;
    v10:PivotTo(CFrame.new(0, 4, -297.5) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966));
    local Highlight = Instance.new("Highlight", u8);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = script:GetAttribute("Color").Keypoints[1].Value;
    Highlight.FillTransparency = 0.9;
    Highlight.OutlineColor = script:GetAttribute("Color").Keypoints[1].Value;
    Highlight.OutlineTransparency = 0;
    local NumberValue = Instance.new("NumberValue", u8);
    NumberValue.Changed:Connect(function() -- Line: 60
        -- upvalues: NumberValue (copy), u8 (copy), u7 (copy)
        if NumberValue.Value > 0 then
            u8:ScaleTo(NumberValue.Value);
            u8:PivotTo(u7.CFrame * CFrame.new(0, 0, -1.5 * NumberValue.Value));
        end;
    end);
    u8.Humanoid:LoadAnimation(script.Animation):Play();

    if LocalPlayer.Team ~= game.Teams.Visitor and LocalPlayer.Character ~= u7.Plr.Character then
        local EMPERORKNEELANIMATION = ReplicatedStorage.Assets.VFX.Emotes.EMPERORKNEELANIMATION;
        local Character = LocalPlayer.Character;

        if Character then
            local u11 = Character:FindFirstChild("Humanoid"):LoadAnimation(EMPERORKNEELANIMATION);
            u11:Play();
            Controller.States.Kneeling = true;
            task.delay(3, function() -- Line: 81
                -- upvalues: Controller (copy), u11 (copy)
                Controller.States.Kneeling = false;
                u11:Stop();
            end);
        end;
    end;

    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u12 = ColorCorrection:Clone();
    u12.Name = "CC";
    u12.Parent = Lighting;
    u12.Enabled = true;
    task.delay(4.85, function() -- Line: 97
        -- upvalues: u12 (copy), Lighting (ref), ColorCorrection (copy)
        u12:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local u13 = script.FakeAtmo:Clone();
    u13.Parent = Lighting;
    u13.Color = script:GetAttribute("Color").Keypoints[1].Value:Lerp(script:GetAttribute("Color").Keypoints[2].Value, 0.5);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    local v14 = script.Emit:Clone();
    v14.Parent = Debris;
    v14.CFrame = u8.Crown.CFrame;
    Essentials:Weld(v14, u8.Crown);
    VfxManager.Emit(v14);
    VfxManager.DestroyEffect(v14, 2);
    NumberValue.Value = 0;
    TweenService:Create(NumberValue, TweenInfo.new(0.5333333333333333), {
        Value = 1
    }):Play();
    task.delay(0.23333333333333334, function() -- Line: 123
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Enable(u8, true);
    end);
    task.delay(3.65, function() -- Line: 127
        -- upvalues: VfxManager (ref), u8 (copy), TweenService (ref), NumberValue (copy)
        VfxManager.Enable(u8, false);
        TweenService:Create(NumberValue, TweenInfo.new(0.85), {
            Value = 0
        }):Play();
    end);
    VfxManager.Emit(v9.Emit);
    VfxManager.Emit(v9.EmittingParts);
    VfxManager.Enable(v9.BeamParts, true);
    VfxManager.Enable(v9.AuraBG, true);
    VfxManager.DestroyEffect(u8, 3);
    VfxManager.DestroyEffect(v9, 3);
    VfxManager.DestroyEffect(v10, 3);

    for _, descendant in v10:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("SurfaceAppearance") then
            descendant.Color = u1;
        end;
    end;

    local u15 = tick();
    local u20 = RunService.Heartbeat:Connect(function(p16) -- Line: 150
        -- upvalues: u15 (copy), EvaluateColorSequence (ref), Highlight (copy), u8 (copy)
        local v17 = (tick() - u15) % 3;
        local v18;

        if v17 <= 1.5 then
            v18 = v17 / 1.5;
        else
            v18 = 1 - (v17 - 1.5) / 1.5;
        end;

        local v19 = EvaluateColorSequence(script:GetAttribute("Color"), v18);
        Highlight.FillColor = v19;
        Highlight.OutlineColor = v19;
        u8.Crown.Color = v19;
    end);
    task.delay(3, function() -- Line: 167
        -- upvalues: u20 (ref), Lighting (ref), TweenService (ref), VfxManager (ref), u12 (copy), u1 (ref), ColorCorrection (copy), u13 (copy), ClockTime (copy)
        u20:Disconnect();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u12.Brightness = 1;
        u12.Saturation = -1;
        u12.TintColor = u1;
        TweenService:Create(u12, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u12, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
        u13:Destroy();

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
    u12.Brightness = 1;
    u12.Saturation = -1;
    u12.TintColor = u1;
    TweenService:Create(u12, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
        TintColor = ColorCorrection.TintColor
    }):Play();
    TweenService:Create(u12, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Contrast = ColorCorrection.Contrast,
        Saturation = ColorCorrection.Saturation
    }):Play();
end;