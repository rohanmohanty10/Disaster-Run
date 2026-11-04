 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: LocalPlayer (copy), DarkScreenEffect (copy), Lighting (copy), TweenService (copy), VfxManager (copy), SfxManager (copy), Essentials (copy), Knit (copy), CameraShaker (copy)
    local Character = p2.Character;
    local Other = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");

    if p2.Task == "Jump" then
        if LocalPlayer.Character == Other then
            DarkScreenEffect();
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Name = "CCAddon";
            ColorCorrectionEffect.Parent = Lighting;
            ColorCorrectionEffect.Enabled = true;
            task.delay(0.75, function() -- Line: 32
                -- upvalues: ColorCorrectionEffect (copy)
                ColorCorrectionEffect:Destroy();
            end);
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 5;
            TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.5);
            ColorCorrectionEffect.Brightness = 0.45;
            ColorCorrectionEffect.TintColor = p2.Color or Color3.fromRGB(255, 255, 255);
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                Brightness = 0
            }):Play();
        end;

        return;
    end;

    if p2.Task ~= "Activate" then
        if LocalPlayer.Character ~= Character then
            Knit.GetController("CameraController").CamShake:Shake(CameraShaker.Presets.Meteor);
            DarkScreenEffect();
        end;

        return;
    end;

    if Character:GetAttribute("Invis") then
        return;
    end;

    SfxManager:playSound({
        Sound = "ScaryShoot",
        Parent = HumanoidRootPart
    });
    local Torso = Character:FindFirstChild("Torso");

    if Torso then
        for _, descendant in Torso:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and (descendant:GetAttribute("ScaryEmit") and (descendant:GetAttribute("EmitCount") and descendant:GetAttribute("EmitCount") > 0)) then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end;

    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = p2.Color or Color3.fromRGB(255, 255, 255);
    Highlight.OutlineColor = p2.Color or Color3.fromRGB(255, 255, 255);
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineTransparency = 0;
    TweenService:Create(Highlight, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    VfxManager.DestroyEffect(Highlight, 0.25);
    local v3 = tick();

    repeat
        task.wait(0.05);
        local v4 = Essentials:CreateClone(Character, 0.1);
        VfxManager.DestroyEffect(v4, 0.1);
    until tick() - v3 > 0.25;
end;