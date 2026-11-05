  

 

local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local SoundGroups = require(ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));

return function(p1) -- Line: 15
    -- upvalues: SoundGroups (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), EffectsHandler (copy)
    p1.Distance = p1.Distance or 75;
    local u2 = script.Part:Clone();
    u2.CollisionGroup = "NoCollision";
    u2.Parent = workspace.Effects;

    if p1.Origin then
        u2.Position = p1.Origin;
    else
        u2.CFrame = p1.Attachment.CFrame * (p1.Offset or CFrame.identity);
        u2.Anchored = false;
        u2.Weld.Part1 = p1.Attachment;
        p1.Origin = u2.Position;
    end;

    local SFX = u2.SFX;
    SoundGroups:AssignSoundTag(SFX);
    SFX.Volume = p1.Volume or SFX.Volume;
    SFX.RollOffMaxDistance = p1.Distance + 15;
    SFX:Play();
    u2.Effect.Particle:Emit(1);
    local v3 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if v3 and (p1.Origin - v3.Position).Magnitude <= p1.Distance then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Brightness = 0;
        ColorCorrectionEffect.Saturation = 0;
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.Parent = Lighting;
        local v4 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.175, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Brightness = -0.125,
            Saturation = -0.35
        });
        local u5 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.425, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0.475), {
            Brightness = 0,
            Saturation = 0
        });
        v4:Play();
        v4.Completed:Once(function() -- Line: 56
            -- upvalues: u5 (copy)
            u5:Play();
        end);
        u5.Completed:Once(function() -- Line: 59
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect:Destroy();
        end);
    end;

    task.spawn(function() -- Line: 64
        -- upvalues: EffectsHandler (ref), u2 (copy)
        EffectsHandler.Wait(2);
        u2:Destroy();
    end);
end;