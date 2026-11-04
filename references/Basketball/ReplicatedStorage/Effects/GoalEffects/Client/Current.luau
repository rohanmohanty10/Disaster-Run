 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function scaleDown(p1, p2) -- Line: 15
    for _, v in p1 do
        if v:IsA("ParticleEmitter") then
            local v3 = v;
            local v4 = {};

            for _, v2 in v.Size.Keypoints do
                local v5;

                if v2.Envelope then
                    v5 = v2.Envelope / 10 or nil;
                else
                    v5 = nil;
                end;

                if v5 ~= v5 then
                    v5 = nil;
                end;

                table.insert(v4, NumberSequenceKeypoint.new(v2.Time, v2.Value / 10, v5));
            end;

            v3.Size = NumberSequence.new(v4);
            v3.Speed = NumberRange.new(v3.Speed.Min / 10, v3.Speed.Max / 10);
        elseif v:IsA("Attachment") then
            v.Position = v.Position / 10;

            if v.Position ~= v.Position then
                v.Position = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("BasePart") then
            v.Position = p2.CFrame.Position + (v.Position - p2.CFrame.Position) / 10;

            if v.Position ~= v.Position then
                v.Position = p2.CFrame.Position;
            end;

            v.Size = v.Size / 10;

            if v.Size ~= v.Size then
                v.Size = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("Beam") then
            v.Width0 = v.Width0 / 10;
            v.Width1 = v.Width1 / 10;
        end;
    end;
end;

return function(p6, p7) -- Line: 57
    -- upvalues: LocalPlayer (copy), VfxManager (copy), TweenService (copy), Debris (copy), scaleDown (copy)
    local CFrame = p7.CFrame;

    if not p7.Preview then
        local game_Lighting = game.Lighting;
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
        local u8 = script.Vignette:Clone();
        u8.Parent = PlayerGui;
        u8.Enabled = true;
        VfxManager.DestroyEffect(u8, 4);
        local Vignette = u8.Vignette;
        local Vignette1 = u8.Vignette1;
        local ExposureCompensation = game_Lighting.ExposureCompensation;
        local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
        Color3.fromRGB(255, 255, 255);
        local Bloom = game_Lighting:FindFirstChild("Bloom");
        local Intensity = Bloom.Intensity;
        local Threshold = Bloom.Threshold;
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        local u9 = TweenService:Create(game_Lighting, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            ExposureCompensation = -0.5
        });
        u9:Play();
        local u10 = nil;
        u9.Completed:Connect(function() -- Line: 100
            -- upvalues: u9 (copy), u10 (ref), TweenService (ref), game_Lighting (copy), ExposureCompensation (copy)
            u9:Destroy();
            u10 = TweenService:Create(game_Lighting, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                ExposureCompensation = ExposureCompensation
            });
            u10:Play();
        end);
        Bloom.Intensity = 1.5;
        Bloom.Threshold = 1.65;
        local u11 = TweenService:Create(Bloom, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            Intensity = Intensity,
            Threshold = Threshold
        });
        u11:Play();
        ColorCorrection.Brightness = 0.75;
        ColorCorrection.Contrast = 1.25;
        ColorCorrection.Saturation = -1;
        local u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.085, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            Saturation = 0.3
        });
        u12:Play();
        Vignette1.ImageColor3 = Color3.fromRGB(255, 255, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(2, Enum.EasingStyle.Sine), {
            ImageTransparency = 1,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        Vignette.ImageTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
        task.delay(2.25, function() -- Line: 127
            -- upvalues: u8 (copy), u12 (ref), u9 (copy), u11 (ref), u10 (ref), ColorCorrection (copy), Bloom (copy), Intensity (copy), Threshold (copy), game_Lighting (copy), ExposureCompensation (copy)
            if u8 then
                u8:Destroy();
            end;

            if u12 then
                u12:Pause();
            end;

            if u9 then
                u9:Pause();
            end;

            if u11 then
                u11:Pause();
            end;

            if u10 then
                u10:Pause();
            end;

            ColorCorrection.Contrast = 0.2;
            ColorCorrection.Saturation = 0.3;
            ColorCorrection.Brightness = -0.015;
            Bloom.Intensity = Intensity;
            Bloom.Threshold = Threshold;
            game_Lighting.ExposureCompensation = ExposureCompensation;
        end);
    end;

    local v13 = script.CurrentImpact:Clone();
    v13.CFrame = CFrame;
    v13.Parent = Debris;

    if p7.Preview then
        scaleDown(v13:GetDescendants(), p7);
    end;

    VfxManager.Emit(v13);
    VfxManager.DestroyEffect(v13, 7);
end;