 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");
local _ = workspace.CurrentCamera;

return function(p1, p2) -- Line: 16
    -- upvalues: Knit (copy), Debris (copy), VfxManager (copy), SfxManager (copy), CameraShaker (copy), Lighting (copy), TweenService (copy)
    local Controller = Knit.GetController("CameraController");

    if not p2.Player.Character then
        return;
    end;

    local u3 = script.VFX:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    VfxManager.DestroyEffect(u3, 3);

    if p2.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p2.CFrame.Position;
        SfxManager:playSound({
            Sound = "Za Warudo Goal",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 75
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
        u3:PivotTo(u3.PrimaryPart.CFrame * CFrame.new(0, -3.5, 0) * CFrame.Angles(0, 1.5707963267948966, 0));
        u3:ScaleTo(0.1);
        u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    else
        SfxManager:playSound({
            Sound = "ArrowsSFX",
            Parent = workspace
        });
        Controller.CamShake:Shake(CameraShaker.Presets.Explosion);
        u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
        local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
        ColorCorrection.Enabled = false;
        local u4 = ColorCorrection:Clone();
        u4.Name = "CC";
        u4.Parent = Lighting;
        u4.Enabled = true;
        task.delay(3.6, function() -- Line: 43
            -- upvalues: u4 (copy), Lighting (ref), ColorCorrection (copy)
            u4:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.6);
        u4.Brightness = 1;
        u4.TintColor = Color3.fromRGB(146, 51, 255);
        TweenService:Create(u4, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        task.delay(3, function() -- Line: 59
            -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u4 (copy), ColorCorrection (copy)
            local BlurEffect2 = Instance.new("BlurEffect", Lighting);
            BlurEffect2.Size = 15;
            TweenService:Create(BlurEffect2, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect2, 0.6);
            u4.Brightness = 1;
            u4.TintColor = Color3.fromRGB(146, 51, 255);
            TweenService:Create(u4, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
                Brightness = ColorCorrection.Brightness,
                TintColor = ColorCorrection.TintColor
            }):Play();
        end);
    end;

    task.delay(0.2, function() -- Line: 85
        -- upvalues: u3 (copy)
        shared.vfx.emit(u3.pioche2["Wind/Shockwaves"]);
    end);
    task.delay(0.26666666666666666, function() -- Line: 89
        -- upvalues: u3 (copy)
        shared.vfx.emit(u3.pioche6["Wind/Shockwaves"]);
    end);
    task.delay(0.38333333333333336, function() -- Line: 93
        -- upvalues: u3 (copy)
        shared.vfx.emit(u3.pioche4["Wind/Shockwaves"]);
    end);
    task.delay(0.45, function() -- Line: 97
        -- upvalues: u3 (copy)
        shared.vfx.emit(u3.pioche1["Wind/Shockwaves"]);
    end);
    task.delay(0.5333333333333333, function() -- Line: 101
        -- upvalues: u3 (copy)
        shared.vfx.emit(u3.pioche3["Wind/Shockwaves"]);
    end);
    task.delay(0.6666666666666666, function() -- Line: 105
        -- upvalues: u3 (copy)
        shared.vfx.emit(u3.pioche5["Wind/Shockwaves"]);
    end);
end;