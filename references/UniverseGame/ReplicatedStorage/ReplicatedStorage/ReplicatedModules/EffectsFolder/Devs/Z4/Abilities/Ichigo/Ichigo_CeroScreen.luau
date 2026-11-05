  

 

local _ = game.Players.LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local LocalPlayer = Players.LocalPlayer;
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 14
    -- upvalues: LocalPlayer (copy), Lighting (copy), TweenService (copy)
    local v2 = p1 or {};
    local v3 = v2.Color or Color3.fromRGB(255, 0, 0);
    local v4 = v2.Time or 1;
    local u5 = v2.TweenTime or 1;
    local Settings = LocalPlayer:FindFirstChild("Settings");

    if Settings and Settings.ImpactFrame.Value then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Parent = Lighting;
        ColorCorrectionEffect.TintColor = v3 or Color3.fromRGB(255, 0, 0);
        ColorCorrectionEffect.Contrast = 0.5;
        ColorCorrectionEffect.Saturation = -1;
        task.delay(v4, function() -- Line: 30
            -- upvalues: TweenService (ref), ColorCorrectionEffect (copy), u5 (copy)
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(u5), {
                Contrast = 0,
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(u5 + 1, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
        end);
    end;
end;