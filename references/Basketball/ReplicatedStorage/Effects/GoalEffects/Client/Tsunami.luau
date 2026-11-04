 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 15
    -- upvalues: LocalPlayer (copy), VfxManager (copy), TweenService (copy), Debris (copy)
    local CFrame2 = p2.CFrame;
    local game_Lighting = game.Lighting;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u3 = script.Vignette:Clone();
    u3.Parent = PlayerGui;
    u3.Enabled = true;
    VfxManager.DestroyEffect(u3, 4);
    local Vignette = u3.Vignette;
    local Vignette1 = u3.Vignette1;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local Intensity = Bloom.Intensity;
    local Threshold = Bloom.Threshold;
    Bloom.Threshold = 1.45;
    Bloom.Intensity = 1;
    local u4 = TweenService:Create(game_Lighting.Bloom, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Threshold = Threshold,
        Intensity = Intensity
    });
    u4:Play();
    game_Lighting.ColorCorrection.Brightness = 0.75;
    game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(56, 159, 255);
    local u5 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
        Brightness = -0.015,
        TintColor = Color3_fromRGB_ret
    });
    u5:Play();
    Vignette1.ImageColor3 = Color3.fromRGB(30, 83, 255);
    Vignette1.ImageTransparency = 0;
    TweenService:Create(Vignette1, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
        ImageTransparency = 1,
        ImageColor3 = Color3.fromRGB(0, 0, 0)
    }):Play();
    Vignette.ImageTransparency = 0;
    TweenService:Create(Vignette, TweenInfo.new(1.35, Enum.EasingStyle.Sine), {
        ImageTransparency = 1
    }):Play();
    local BlurEffect = Instance.new("BlurEffect", game_Lighting);
    BlurEffect.Size = 20;
    TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.455);
    local v6 = script.FX:Clone();
    local TSUNAMI = v6.TSUNAMI;
    local PrimaryPart = TSUNAMI.PrimaryPart;
    v6:PivotTo(CFrame2 * CFrame.Angles(0, -1.5707963267948966, 0));
    v6.Parent = Debris;
    VfxManager.DestroyEffect(v6, 6);
    VfxManager.Emit(v6.ImpactEmit);
    VfxManager.Enable(TSUNAMI, true);
    TweenService:Create(PrimaryPart, TweenInfo.new(0.155, Enum.EasingStyle.Back), {
        CFrame = PrimaryPart.CFrame * CFrame.new(0, 25, 0)
    }):Play();
    task.wait(0.155);
    TweenService:Create(PrimaryPart, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
        CFrame = PrimaryPart.CFrame * CFrame.new(-300, 0, 0)
    }):Play();
    task.wait(0.855);
    VfxManager.Emit(v6.TsunamiCrash);
    VfxManager.Enable(TSUNAMI, false);
    task.delay(1, function() -- Line: 89
        -- upvalues: u3 (copy), u5 (ref), u4 (copy), ColorCorrection (copy), Bloom (copy), Intensity (copy), Threshold (copy)
        if u3 then
            u3:Destroy();
        end;

        if u5 then
            u5:Pause();
        end;

        if u4 then
            u4:Pause();
        end;

        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        Bloom.Intensity = Intensity;
        Bloom.Threshold = Threshold;
    end);
end;