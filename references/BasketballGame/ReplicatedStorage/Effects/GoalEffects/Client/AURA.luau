 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local LightingController = require(ReplicatedStorage.Controllers.LightingController);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function scaleDown(p1, p2) -- Line: 16
    for _, v in p1 do
        if v:IsA("ParticleEmitter") then
            local v3 = v;
            local v4 = {};

            for _, v2 in v.Size.Keypoints do
                local v5;

                if v2.Envelope then
                    v5 = v2.Envelope / 15 or nil;
                else
                    v5 = nil;
                end;

                if v5 ~= v5 then
                    v5 = nil;
                end;

                table.insert(v4, NumberSequenceKeypoint.new(v2.Time, v2.Value / 15, v5));
            end;

            v3.Size = NumberSequence.new(v4);
            v3.Speed = NumberRange.new(v3.Speed.Min / 15, v3.Speed.Max / 15);
        elseif v:IsA("Attachment") then
            v.Position = v.Position / 15;

            if v.Position ~= v.Position then
                v.Position = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("BasePart") then
            v.Position = p2.CFrame.Position + (v.Position - p2.CFrame.Position) / 15;

            if v.Position ~= v.Position then
                v.Position = p2.CFrame.Position;
            end;

            v.Size = v.Size / 15;

            if v.Size ~= v.Size then
                v.Size = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("Beam") then
            v.Width0 = v.Width0 / 15;
            v.Width1 = v.Width1 / 15;
            v.CurveSize0 = v.CurveSize0 / 15;
            v.CurveSize1 = v.CurveSize1 / 15;
        end;
    end;
end;

return function(p6, p7) -- Line: 61
    -- upvalues: LocalPlayer (copy), VfxManager (copy), TweenService (copy), LightingController (copy), Debris (copy), scaleDown (copy), Essentials (copy)
    local CFrame = p7.CFrame;

    if not p7.Preview then
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
        local game_Lighting = game.Lighting;
        local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
        local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
        local Bloom = game_Lighting:FindFirstChild("Bloom");
        local ExposureCompensation = game_Lighting.ExposureCompensation;
        local _ = Atmosphere.Density;
        local _ = Atmosphere.Color;
        local _ = Atmosphere.Offset;
        local _ = Atmosphere.Haze;
        local _ = Atmosphere.Decay;
        local _ = Atmosphere.Glare;
        local Intensity = Bloom.Intensity;
        local _ = Bloom.Size;
        local Threshold = Bloom.Threshold;
        local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
        local ExposureCompensation2 = game_Lighting.ExposureCompensation;
        local u8 = script.Vignette:Clone();
        u8.Parent = PlayerGui;
        u8.Enabled = true;
        VfxManager.DestroyEffect(u8, 4);
        local Vignette = u8.Vignette;
        local Vignette1 = u8.Vignette1;
        Atmosphere.Color = Color3.fromRGB(255, 0, 0);
        task.delay(2.2, function() -- Line: 100
            -- upvalues: Atmosphere (copy), ColorCorrection (copy), TweenService (ref), Color3_fromRGB_ret (copy), Bloom (copy), Intensity (copy), Threshold (copy), game_Lighting (copy), VfxManager (ref), Vignette1 (ref), Vignette (ref), ExposureCompensation (ref), ExposureCompensation2 (copy), LightingController (ref), u8 (copy)
            Atmosphere.Color = Color3.fromRGB(0, 0, 0);
            ColorCorrection.Brightness = 0.75;
            ColorCorrection.Contrast = 1.25;
            ColorCorrection.Saturation = -1;
            ColorCorrection.TintColor = Color3.fromRGB(255, 33, 33);
            TweenService:Create(ColorCorrection, TweenInfo.new(0.085, Enum.EasingStyle.Sine), {
                Brightness = 0.05,
                Contrast = 0.3,
                Saturation = 0.1
            }):Play();
            TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                TintColor = Color3_fromRGB_ret
            }):Play();
            Bloom.Intensity = 1.5;
            Bloom.Threshold = 1.65;
            TweenService:Create(Bloom, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Intensity = Intensity,
                Threshold = Threshold
            }):Play();
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 13;
            BlurEffect.Parent = game_Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.755);
            Vignette1.ImageColor3 = Color3.fromRGB(255, 38, 38);
            Vignette1.ImageTransparency = 0;
            TweenService:Create(Vignette1, TweenInfo.new(2, Enum.EasingStyle.Sine), {
                ImageTransparency = 1,
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            Vignette.ImageTransparency = 0;
            TweenService:Create(Vignette, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                ImageTransparency = 1
            }):Play();
            ExposureCompensation = -0.75;
            local u9 = TweenService:Create(game_Lighting, TweenInfo.new(0.833, Enum.EasingStyle.Linear), {
                ExposureCompensation = -0.5
            });
            u9:Play();
            u9.Completed:Connect(function() -- Line: 128
                -- upvalues: u9 (copy), TweenService (ref), game_Lighting (ref), ExposureCompensation2 (ref)
                u9:Destroy();
                TweenService:Create(game_Lighting, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    ExposureCompensation = ExposureCompensation2
                }):Play();
            end);
            task.wait(2);
            LightingController:ResetLighting(0.001);

            if u8 then
                u8:Destroy();
            end;
        end);
    end;

    local v10 = script.HakiFX:Clone();
    local _ = v10.PrimaryPart;
    v10.Parent = Debris;

    if p7.Preview then
        scaleDown(v10:GetDescendants(), p7);
    end;

    v10:PivotTo(CFrame);
    VfxManager.DestroyEffect(v10, 6.5);
    VfxManager.Emit(v10);

    if p7.Player and p7.Player.Character then
        local Character = p7.Player.Character;
        v10.CharacterFX.CFrame = Character:FindFirstChild("HumanoidRootPart").CFrame;
        Essentials:Weld(v10.CharacterFX, Character:FindFirstChild("HumanoidRootPart"));
    end;

    task.wait(2.2);
    VfxManager.DestroyEffect(v10, 4);
    task.wait(2);
end;