  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: AssetHandler (copy), TweenService (copy), EffectsHandler (copy)
    local v2 = p1 or {};
    local TargetCharacter = v2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local v3 = { v2.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };

    if not table.find(v3, game.Players.LocalPlayer) then
        return;
    end;

    local v4 = AssetHandler.CloneAsset("Wasted/Sound", {
        AbilityName = "KillEffects"
    });
    v4.Parent = workspace;
    v4:Play();
    task.delay(7, v4.Destroy, v4);
    local v5 = AssetHandler.CloneAsset("Wasted/ColorCorrection", {
        AbilityName = "KillEffects"
    });
    v5.Parent = game.Lighting;
    local v6 = AssetHandler.CloneAsset("Wasted/Bloom", {
        AbilityName = "KillEffects"
    });
    v6.Parent = game.Lighting;
    TweenService:Create(v6, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = 0,
        Threshold = 1,
        Intensity = 0
    }):Play();
    TweenService:Create(v5, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    local CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = CurrentCamera.FieldOfView;
    CurrentCamera.FieldOfView = CurrentCamera.FieldOfView * 1.2;
    TweenService:Create(CurrentCamera, TweenInfo.new(0.3), {
        FieldOfView = FieldOfView
    }):Play();
    EffectsHandler.Wait(1.5);
    CurrentCamera.FieldOfView = CurrentCamera.FieldOfView * 1.2;
    TweenService:Create(CurrentCamera, TweenInfo.new(0.1), {
        FieldOfView = FieldOfView
    }):Play();
    local v7 = AssetHandler.CloneAsset("Wasted/ScreenGui", {
        AbilityName = "KillEffects"
    });
    v7.Parent = game.Players.LocalPlayer.PlayerGui;

    for _, child in v7.Frame:GetChildren() do
        TweenService:Create(child, TweenInfo.new(0.3), child:IsA("Frame") and {
            BackgroundTransparency = 0
        } or {
            ImageTransparency = 0
        }):Play();
    end;

    TargetCharacter.AncestryChanged:Wait();

    for _, child in v7.Frame:GetChildren() do
        TweenService:Create(child, TweenInfo.new(0.3), child:IsA("Frame") and {
            BackgroundTransparency = 1
        } or {
            ImageTransparency = 1
        }):Play();
    end;

    task.delay(1, v7.Destroy, v7);
end;