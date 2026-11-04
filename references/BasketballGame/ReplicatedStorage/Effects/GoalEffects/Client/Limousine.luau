 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Lighting (copy), TweenService (copy)
    if p2.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p2.CFrame.Position;
        SfxManager:playSound({
            Sound = "LowriderSFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 135
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
        local v3 = script.Lowrider:Clone();
        v3.Parent = Debris;
        v3:PivotTo(p2.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
        v3:ScaleTo(0.1);
        VfxManager.DestroyEffect(v3, 8);
        local Explode = v3.Explode;
        Explode.Parent = Debris;
        v3:PivotTo(p2.CFrame * CFrame.new(0, -3.5, 0));
        Explode.Parent = v3;
        v3.Lowrider.AnimationController:LoadAnimation(script.Animation):Play();
        v3.Lowrider.lowrider.Transparency = 0;
        VfxManager.Emit(v3.Explode);
        VfxManager.Emit(v3.Teleport.Spawn);
        VfxManager.Enable(v3.Teleport.Enable, true);
        task.wait(0.6);
        VfxManager.Emit(v3.GroundHit1);
        task.wait(0.11666666666666667);
        VfxManager.Enable(v3.Teleport.Enable, false);
        VfxManager.Enable(v3.Lowrider, true);
        task.wait(0.38333333333333336);
        VfxManager.Emit(v3.GroundHit2);
        task.wait(0.6666666666666666);
        VfxManager.Emit(v3.GroundHit3);
        task.wait(0.25);
        VfxManager.Enable(v3.Teleport.Teleport, true);
        task.wait(0.2);

        for _, descendant in pairs(v3.Lowrider:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        task.wait(0.23333333333333334);
        v3.Lowrider.lowrider.Transparency = 1;
        VfxManager.Emit(v3.Teleport.Teleport);
        VfxManager.Enable(v3.Teleport.Teleport, false);

        return;
    end;

    SfxManager:playSound({
        Sound = "LowriderSFX",
        Parent = workspace
    });
    local v4 = script.Lowrider:Clone();
    v4.Parent = Debris;
    v4:PivotTo(p2.CFrame);
    VfxManager.DestroyEffect(v4, 8);
    v4.Lowrider.AnimationController:LoadAnimation(script.Animation):Play();
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u5 = ColorCorrection:Clone();
    u5.Name = "CC";
    u5.Parent = Lighting;
    u5.Enabled = true;
    task.delay(4.7135, function() -- Line: 33
        -- upvalues: u5 (copy), Lighting (ref), ColorCorrection (copy)
        u5:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u6 = Bloom:Clone();
    u6.Name = "B";
    u6.Parent = Lighting;
    u6.Enabled = true;
    task.delay(3.9325, function() -- Line: 48
        -- upvalues: u6 (copy), Lighting (ref), Bloom (copy)
        u6:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    v4.Lowrider.lowrider.Transparency = 0;
    VfxManager.Emit(v4.Explode);
    VfxManager.Emit(v4.Teleport.Spawn);
    VfxManager.Enable(v4.Teleport.Enable, true);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 20;
    TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.755);
    u5.Brightness = 0.45;
    TweenService:Create(u5, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Saturation = -1,
        Brightness = ColorCorrection.Brightness
    }):Play();
    task.wait(0.6);
    VfxManager.Emit(v4.GroundHit1);
    u5.Brightness = 0.35;
    TweenService:Create(u5, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
        Saturation = ColorCorrection.Saturation
    }):Play();
    TweenService:Create(u5, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness
    }):Play();
    task.wait(0.11666666666666667);
    VfxManager.Enable(v4.Teleport.Enable, false);
    VfxManager.Enable(v4.Lowrider, true);
    task.wait(0.38333333333333336);
    VfxManager.Emit(v4.GroundHit2);
    task.wait(0.6666666666666666);
    VfxManager.Emit(v4.GroundHit3);
    task.wait(0.25);
    VfxManager.Enable(v4.Teleport.Teleport, true);
    task.wait(0.2);

    for _, descendant in pairs(v4.Lowrider:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    task.wait(0.23333333333333334);
    v4.Lowrider.lowrider.Transparency = 1;
    VfxManager.Emit(v4.Teleport.Teleport);
    VfxManager.Enable(v4.Teleport.Teleport, false);
    u6.Intensity = 2;
    u6.Threshold = 0.5;
    local BlurEffect2 = Instance.new("BlurEffect", Lighting);
    BlurEffect2.Size = 12;
    VfxManager.DestroyEffect(BlurEffect2, 1.2825);
    task.spawn(function() -- Line: 116
        -- upvalues: TweenService (ref), u5 (copy), u6 (copy), BlurEffect2 (copy), ColorCorrection (copy)
        TweenService:Create(u5, TweenInfo.new(0.1005), {
            Brightness = 0.2
        }):Play();
        TweenService:Create(u6, TweenInfo.new(3.75, Enum.EasingStyle.Back), {
            Intensity = 0.25,
            Threshold = 2
        }):Play();
        TweenService:Create(BlurEffect2, TweenInfo.new(1.2825, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.wait(0.1005);
        TweenService:Create(u5, TweenInfo.new(0.0825, Enum.EasingStyle.Sine), {
            Brightness = -0.5,
            Saturation = -1
        }):Play();
        task.wait(0.0825);
        TweenService:Create(u5, TweenInfo.new(0.8505, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
end;