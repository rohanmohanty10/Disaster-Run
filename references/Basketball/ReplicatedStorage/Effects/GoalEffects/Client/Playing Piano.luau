 
 

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
        Sound = "PlayingPianoSFX",
        Parent = workspace
    });
    local _, v8, _ = p6.CFrame:ToOrientation();
    local u9 = CloneCharacter(Character, Debris, CFrame.new(p6.CFrame.Position.X, 24, p6.CFrame.Position.Z) * CFrame.fromOrientation(0, v8 + 1.5707963267948966, 0) * CFrame.new(0, 0, -20));
    u9.Humanoid:LoadAnimation(script.Animation):Play();
    local v10 = script.Piano:Clone();
    v10.Parent = u9;
    v10.Handle.Part0 = u9.HumanoidRootPart;
    local v11 = script.Aura:Clone();
    v11.Parent = u9;
    v11:PivotTo(u9.HumanoidRootPart.CFrame + Vector3.new(0, -3, 0));
    u9:ScaleTo(5);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u12 = ColorCorrection:Clone();
    u12.Name = "CC";
    u12.Parent = Lighting;
    u12.Enabled = true;
    task.delay(4.221666666666667, function() -- Line: 66
        -- upvalues: u12 (copy), Lighting (ref), ColorCorrection (copy)
        u12:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u13 = Bloom:Clone();
    u13.Name = "B";
    u13.Parent = Lighting;
    u13.Enabled = true;
    u13.Intensity = 2;
    u13.Threshold = 0.5;
    task.delay(4.466666666666667, function() -- Line: 83
        -- upvalues: u13 (copy), Lighting (ref), Bloom (copy)
        u13:Destroy();

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
    u13.Intensity = 15;
    u13.Threshold = 0.5;
    TweenService:Create(u13, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
        Intensity = Bloom.Intensity,
        Threshold = Bloom.Threshold
    }):Play();
    u12.Brightness = 1;
    u12.TintColor = Color3.fromRGB(79, 135, 255);
    TweenService:Create(u12, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        TintColor = ColorCorrection.TintColor
    }):Play();
    task.delay(3.8333333333333335, function() -- Line: 103
        -- upvalues: u9 (copy), TweenService (ref), u7 (copy), VfxManager (ref), Lighting (ref), u13 (copy), Bloom (copy), u12 (copy), ColorCorrection (copy)
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
        u13.Intensity = 15;
        u13.Threshold = 0.5;
        TweenService:Create(u13, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u12.Brightness = 1;
        u12.TintColor = Color3.fromRGB(79, 135, 255);
        TweenService:Create(u12, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
end;