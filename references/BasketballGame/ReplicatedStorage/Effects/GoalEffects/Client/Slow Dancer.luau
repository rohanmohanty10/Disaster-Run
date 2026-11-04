 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: Debris (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    if p2.Preview then
        local u3 = script.Model:Clone();
        u3.Parent = Debris;
        u3:PivotTo(p2.CFrame);
        u3:ScaleTo(0.2);
        u3.Horse.AnimationController.Animator:LoadAnimation(script.Animation):Play();
        VfxManager.BetterEmit(u3.Score);
        VfxManager.Enable(u3.Aura, true);
        task.delay(1.8833333333333333, function() -- Line: 62
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.BetterEmit(u3.Wormhole);
            VfxManager.Enable(u3.Aura, false);
        end);
        VfxManager.DestroyEffect(u3.Horse, 2.033333333333333);
        VfxManager.DestroyEffect(u3, 8);

        return;
    end;

    local u4 = script.Model:Clone();
    u4.Parent = Debris;
    u4:PivotTo(p2.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    u4.Horse.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u5 = ColorCorrection:Clone();
    u5.Name = "CC";
    u5.Parent = Lighting;
    u5.Enabled = true;
    task.delay(0.855, function() -- Line: 28
        -- upvalues: u5 (copy), Lighting (ref), ColorCorrection (copy)
        u5:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    u5.Brightness = 1;
    u5.Contrast = 2;
    u5.TintColor = Color3.fromRGB(0, 0, 0);
    TweenService:Create(u5, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Contrast = ColorCorrection.Contrast
    }):Play();
    TweenService:Create(u5, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
        TintColor = ColorCorrection.TintColor
    }):Play();
    VfxManager.BetterEmit(u4.Score);
    VfxManager.Enable(u4.Aura, true);
    task.delay(1.8833333333333333, function() -- Line: 44
        -- upvalues: VfxManager (ref), u4 (copy)
        VfxManager.BetterEmit(u4.Wormhole);
        VfxManager.Enable(u4.Aura, false);
    end);
    VfxManager.DestroyEffect(u4.Horse, 2.033333333333333);
    VfxManager.DestroyEffect(u4, 8);
end;