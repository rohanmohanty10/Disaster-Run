 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

local function CloneCharacter(p1, p2, p3) -- Line: 13
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

return function(p5, p6) -- Line: 37
    -- upvalues: Debris (copy), SfxManager (copy), CloneCharacter (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local Character = p6.Player.Character;

    if not Character then
        return;
    end;

    local u7 = script.Throne:Clone();
    u7.Parent = Debris;
    u7:PivotTo(p6.CFrame);

    if p6.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p6.CFrame.Position;
        SfxManager:playSound({
            Sound = "ThroneSFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 164
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
        u7:PivotTo(u7.PrimaryPart.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
        u7:ScaleTo(0.2);
        local PrimaryPart = u7.Throne.PrimaryPart;
        PrimaryPart.CFrame = PrimaryPart.CFrame * CFrame.new(0, -2.15, 0);
        local PrimaryPart2 = u7.Crown.PrimaryPart;
        PrimaryPart2.CFrame = PrimaryPart2.CFrame * CFrame.new(0, -2.15, 0);
        u7.Throne.AnimationController.Animator:LoadAnimation(script.ThroneAnimation):Play();
        u7.Crown.AnimationController.Animator:LoadAnimation(script.CrownAnimation):Play();
        task.spawn(function() -- Line: 177
            -- upvalues: VfxManager (ref), u7 (copy)
            VfxManager.Emit(u7.Score);
        end);
        task.delay(0.3, function() -- Line: 181
            -- upvalues: VfxManager (ref), u7 (copy)
            VfxManager.Enable(u7.VFX, true);
        end);
        task.delay(3.283333333333333, function() -- Line: 185
            -- upvalues: VfxManager (ref), u7 (copy), TweenService (ref)
            VfxManager.Enable(u7.VFX, false);
            TweenService:Create(u7.Throne.PrimaryPart, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            TweenService:Create(u7.Crown.PrimaryPart, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end);
        VfxManager.DestroyEffect(u7, 6);
        task.wait(6);

        return;
    end;

    SfxManager:playSound({
        Sound = "ThroneSFX",
        Parent = workspace
    });
    local v8 = CloneCharacter(Character, u7, u7.PlayerPos.CFrame);
    v8:ScaleTo(2.5);
    local Model = Instance.new("Model", v8.Parent);

    for _, child in pairs(v8:GetChildren()) do
        child.Parent = Model;
    end;

    v8:Destroy();
    Model.Humanoid:LoadAnimation(script.CharacterAnimation):Play();
    u7.Throne.AnimationController.Animator:LoadAnimation(script.ThroneAnimation):Play();
    u7.Crown.AnimationController.Animator:LoadAnimation(script.CrownAnimation):Play();
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u9 = ColorCorrection:Clone();
    u9.Name = "CC";
    u9.Parent = Lighting;
    u9.Enabled = true;
    task.delay(3.9833333333333334, function() -- Line: 70
        -- upvalues: u9 (copy), Lighting (ref), ColorCorrection (copy)
        u9:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u10 = Bloom:Clone();
    u10.Name = "B";
    u10.Parent = Lighting;
    u10.Enabled = true;
    u10.Intensity = 2;
    u10.Threshold = 0.5;
    task.delay(3.9833333333333334, function() -- Line: 87
        -- upvalues: u10 (copy), Lighting (ref), Bloom (copy)
        u10:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    task.spawn(function() -- Line: 100
        -- upvalues: VfxManager (ref), u7 (copy), Lighting (ref), TweenService (ref), u10 (copy), Bloom (copy), u9 (copy), ColorCorrection (copy)
        VfxManager.Emit(u7.Score);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u10.Intensity = 15;
        u10.Threshold = 0.5;
        TweenService:Create(u10, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u9.Brightness = 0.6;
        TweenService:Create(u9, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Brightness = 0.05,
            Saturation = 1
        }):Play();
        task.wait(0.35);
        TweenService:Create(u9, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(0.3, function() -- Line: 120
        -- upvalues: VfxManager (ref), u7 (copy)
        VfxManager.Enable(u7.VFX, true);
    end);
    task.delay(3.283333333333333, function() -- Line: 124
        -- upvalues: VfxManager (ref), u7 (copy), Model (copy), TweenService (ref), Lighting (ref), u10 (copy), Bloom (copy), u9 (copy), ClockTime (copy), ColorCorrection (copy)
        VfxManager.Enable(u7.VFX, false);
        VfxManager.Enable(Model, false);

        for _, descendant in pairs(Model:GetDescendants()) do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;

        TweenService:Create(u7.Throne.PrimaryPart, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(u7.Crown.PrimaryPart, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u10.Intensity = 15;
        u10.Threshold = 0.5;
        TweenService:Create(u10, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u9.Brightness = 0.6;
        TweenService:Create(u9, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Brightness = 0.05,
            Saturation = 1
        }):Play();

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;

        task.wait(0.35);
        TweenService:Create(u9, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    VfxManager.DestroyEffect(u7, 6);
end;