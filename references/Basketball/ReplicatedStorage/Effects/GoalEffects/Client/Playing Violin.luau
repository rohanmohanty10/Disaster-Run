 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

local function CloneCharacter(p1, p2, p3) -- Line: 11
    -- upvalues: Debris (copy)
    local Archivable = p1.Archivable;
    p1.Archivable = true;
    local v4 = p1:Clone();
    v4.Parent = p2 or Debris;
    v4.HumanoidRootPart.Anchored = true;
    v4.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v4.HumanoidRootPart.CFrame = p3 or p1.HumanoidRootPart.CFrame;

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
        elseif descendant:IsA("Highlight") or (descendant:IsA("Weld") or descendant:IsA("WeldConstraint")) and not descendant:FindFirstAncestorWhichIsA("Accessory") then
            descendant:Destroy();
        end;
    end;

    p1.Archivable = Archivable;

    return v4;
end;

return function(p5, p6) -- Line: 35
    -- upvalues: SfxManager (copy), CloneCharacter (copy), Debris (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local Character = p6.Player.Character;

    if not Character then
        return;
    end;

    local u7 = SfxManager:playSound({
        Sound = "PlayingViolinSFX",
        Parent = workspace
    });
    local _, v8, _ = p6.CFrame:ToOrientation();
    local u9 = CloneCharacter(Character, Debris, CFrame.new(p6.CFrame.Position.X, 24, p6.CFrame.Position.Z) * CFrame.fromOrientation(0, v8 + 1.5707963267948966, 0) * CFrame.new(0, 0, -20));
    u9.Humanoid:LoadAnimation(script.Animation):Play();
    local v10 = script.Violin:Clone();
    v10.Parent = u9;
    v10.Handle.Part0 = u9.HumanoidRootPart;
    local v11 = script.ViolinStick:Clone();
    v11.Parent = u9;
    v11.Handle.Part0 = u9.HumanoidRootPart;
    local v12 = script.Aura:Clone();
    v12.Parent = u9;
    v12:PivotTo(u9.HumanoidRootPart.CFrame * CFrame.new(-1.912, 1.424, -0.718));
    local u13 = script.Disappear:Clone();
    u13.Parent = u9;
    u13:PivotTo(u9.HumanoidRootPart.CFrame * CFrame.new(-2.01, 0.482, 0.458));
    u9:ScaleTo(5);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(2.355, function() -- Line: 74
        -- upvalues: u14 (copy), Lighting (ref), ColorCorrection (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u15 = Bloom:Clone();
    u15.Name = "B";
    u15.Parent = Lighting;
    u15.Enabled = true;
    u15.Intensity = 2;
    u15.Threshold = 0.5;
    task.delay(2.5999999999999996, function() -- Line: 91
        -- upvalues: u15 (copy), Lighting (ref), Bloom (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 20;
    TweenService:Create(BlurEffect, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.6);
    u15.Intensity = 15;
    u15.Threshold = 0.5;
    TweenService:Create(u15, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
        Intensity = Bloom.Intensity,
        Threshold = Bloom.Threshold
    }):Play();
    u14.Brightness = 1;
    u14.TintColor = Color3.fromRGB(56, 255, 64);
    TweenService:Create(u14, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        TintColor = ColorCorrection.TintColor
    }):Play();
    task.delay(1.65, function() -- Line: 111
        -- upvalues: u13 (copy), Debris (ref), VfxManager (ref)
        u13.Parent = Debris;
        VfxManager.Emit(u13);
        VfxManager.DestroyEffect(u13, 2);
    end);
    task.delay(1.9, function() -- Line: 117
        -- upvalues: u9 (copy), TweenService (ref), u7 (copy), VfxManager (ref), Lighting (ref), u15 (copy), Bloom (copy), u14 (copy), ColorCorrection (copy)
        u9:Destroy();
        TweenService:Create(u7, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Volume = 0
        }):Play();
        VfxManager.DestroyEffect(u7, 0.25);
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 20;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.6);
        u15.Intensity = 15;
        u15.Threshold = 0.5;
        TweenService:Create(u15, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u14.Brightness = 1;
        u14.TintColor = Color3.fromRGB(56, 255, 64);
        TweenService:Create(u14, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
end;