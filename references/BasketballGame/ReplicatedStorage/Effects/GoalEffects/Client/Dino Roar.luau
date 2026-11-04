 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: SfxManager (copy), Debris (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    if p2.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p2.CFrame.Position;
        SfxManager:playSound({
            Sound = "DinoRoarSFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 93
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
        local u3 = script.Dinosaur:Clone();
        u3.Parent = Debris;
        u3:PivotTo(p2.CFrame * CFrame.Angles(0, -1.5707963267948966, 3.141592653589793));
        u3:ScaleTo(0.1);
        local dino = u3.dino;
        dino.CFrame = dino.CFrame * CFrame.new(0, -3, 0);
        u3.AnimationController:LoadAnimation(script.Animation):Play();
        u3.dino.Transparency = 0;
        VfxManager.Emit(u3.Score);
        VfxManager.Enable(u3.dino.Bone, true);
        VfxManager.Enable(u3.dino.Bone["Bone.001"]["Bone.002"]["Bone.003"]["Bone.004"].End, false);
        task.delay(1, function() -- Line: 113
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.Enable(u3.dino.Bone["Bone.001"]["Bone.002"]["Bone.003"]["Bone.004"].End, true);
        end);
        task.delay(5.733333333333333, function() -- Line: 117
            -- upvalues: VfxManager (ref), u3 (copy), TweenService (ref)
            VfxManager.Enable(u3.dino.Bone["Bone.001"]["Bone.002"]["Bone.003"]["Bone.004"].End, false);
            TweenService:Create(u3.dino, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end);
        task.delay(5.966666666666667, function() -- Line: 123
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.Enable(u3.dino.Bone, false);
        end);
        VfxManager.DestroyEffect(u3, 10);
        task.wait(4);

        return;
    end;

    SfxManager:playSound({
        Sound = "DinoRoarSFX",
        Parent = workspace
    });
    local u4 = script.Dinosaur:Clone();
    u4.Parent = Debris;
    u4:PivotTo(p2.CFrame * CFrame.Angles(0, 0, 3.141592653589793));
    u4.AnimationController:LoadAnimation(script.Animation):Play();
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u5 = ColorCorrection:Clone();
    u5.Name = "CC";
    u5.Parent = Lighting;
    u5.Enabled = true;
    task.delay(0.8, function() -- Line: 31
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
    task.delay(0.8, function() -- Line: 46
        -- upvalues: u6 (copy), Lighting (ref), Bloom (copy)
        u6:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    u4.dino.Transparency = 0;
    VfxManager.Emit(u4.Score);
    VfxManager.Enable(u4.dino.Bone, true);
    VfxManager.Enable(u4.dino.Bone["Bone.001"]["Bone.002"]["Bone.003"]["Bone.004"].End, false);
    task.delay(1, function() -- Line: 59
        -- upvalues: VfxManager (ref), u4 (copy)
        VfxManager.Enable(u4.dino.Bone["Bone.001"]["Bone.002"]["Bone.003"]["Bone.004"].End, true);
    end);
    task.delay(5.733333333333333, function() -- Line: 63
        -- upvalues: VfxManager (ref), u4 (copy), TweenService (ref)
        VfxManager.Enable(u4.dino.Bone["Bone.001"]["Bone.002"]["Bone.003"]["Bone.004"].End, false);
        TweenService:Create(u4.dino, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end);
    task.delay(5.966666666666667, function() -- Line: 69
        -- upvalues: VfxManager (ref), u4 (copy)
        VfxManager.Enable(u4.dino.Bone, false);
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 25;
    TweenService:Create(BlurEffect, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.8);
    u6.Intensity = 25;
    u6.Threshold = 0.5;
    TweenService:Create(u6, TweenInfo.new(0.8, Enum.EasingStyle.Back), {
        Intensity = Bloom.Intensity,
        Threshold = Bloom.Threshold
    }):Play();
    u5.TintColor = Color3.fromRGB(229, 73, 41);
    u5.Brightness = 1;
    TweenService:Create(u5, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        TintColor = ColorCorrection.TintColor
    }):Play();
    VfxManager.DestroyEffect(u4, 10);
end;