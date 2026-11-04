 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function scaleDown(p1, p2) -- Line: 14
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
        end;
    end;
end;

return function(p6, p7) -- Line: 56
    -- upvalues: LocalPlayer (copy), TweenService (copy), VfxManager (copy), Debris (copy), scaleDown (copy)
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

    if not p7.Preview then
        local game_Lighting = game.Lighting;
        local ExposureCompensation = game_Lighting.ExposureCompensation;
        local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
        local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
        local Bloom = game_Lighting:FindFirstChild("Bloom");
        local Intensity = Bloom.Intensity;
        local Size = Bloom.Size;
        local Threshold = Bloom.Threshold;
        local u8 = script.Vignette:Clone();
        u8.Parent = PlayerGui;
        u8.Enabled = true;
        local Vignette = u8.Vignette;
        local Vignette1 = u8.Vignette1;
        ColorCorrection.Brightness = 0.75;
        ColorCorrection.Contrast = 1.25;
        ColorCorrection.Saturation = -1;
        ColorCorrection.TintColor = Color3.fromRGB(46, 84, 255);
        local u9 = TweenService:Create(ColorCorrection, TweenInfo.new(0.085, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            Saturation = 0.3
        });
        u9:Play();
        local u10 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            TintColor = Color3_fromRGB_ret
        });
        u10:Play();
        local Bloom2 = game_Lighting.Bloom;
        Bloom2.Intensity = 1.5;
        Bloom2.Threshold = 1.65;
        local u11 = TweenService:Create(Bloom2, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            Intensity = Intensity,
            Threshold = Threshold
        });
        u11:Play();
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 13;
        BlurEffect.Parent = game_Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        Vignette1.ImageColor3 = Color3.fromRGB(28, 70, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(2, Enum.EasingStyle.Sine), {
            ImageTransparency = 1,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        Vignette.ImageTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
        game_Lighting.ExposureCompensation = -0.75;
        local u12 = TweenService:Create(game_Lighting, TweenInfo.new(0.833, Enum.EasingStyle.Linear), {
            ExposureCompensation = -0.5
        });
        u12:Play();
        local u13 = nil;
        u12.Completed:Connect(function() -- Line: 116
            -- upvalues: u12 (copy), u13 (ref), TweenService (ref), game_Lighting (copy), ExposureCompensation (copy)
            u12:Destroy();
            u13 = TweenService:Create(game_Lighting, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                ExposureCompensation = ExposureCompensation
            });
            u13:Play();
        end);
        task.delay(4, function() -- Line: 122
            -- upvalues: u8 (copy), u9 (copy), u10 (copy), u12 (copy), u11 (copy), u13 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), Bloom2 (copy), Intensity (copy), Size (copy), Threshold (copy), game_Lighting (copy), ExposureCompensation (copy)
            if u8 then
                u8:Destroy();
            end;

            if u9 then
                u9:Pause();
            end;

            if u10 then
                u10:Pause();
            end;

            if u12 then
                u12:Pause();
            end;

            if u11 then
                u11:Pause();
            end;

            if u13 then
                u13:Pause();
            end;

            ColorCorrection.TintColor = Color3_fromRGB_ret;
            ColorCorrection.Contrast = 0.2;
            ColorCorrection.Saturation = 0.3;
            ColorCorrection.Brightness = -0.015;
            Bloom2.Intensity = Intensity;
            Bloom2.Size = Size;
            Bloom2.Threshold = Threshold;
            game_Lighting.ExposureCompensation = ExposureCompensation;
        end);
    end;

    local u14 = script["Rain/sTRIKE"]:Clone();
    local _ = u14.PrimaryPart;
    u14.Parent = Debris;

    if p7.Preview then
        scaleDown(u14:GetDescendants(), p7);
    end;

    u14:PivotTo(p7.CFrame);
    VfxManager.DestroyEffect(u14, 8);
    VfxManager.Emit(u14.PlaceVFXInHere.Emit);
    VfxManager.Enable(u14.PlaceVFXInHere.Enabling, true);
    task.delay(4, function() -- Line: 179
        -- upvalues: u14 (copy), VfxManager (ref)
        if u14.Parent then
            VfxManager.Enable(u14.PlaceVFXInHere.Enabling, false);
        end;
    end);
    local PointLight = u14.PlaceVFXInHere.Emit.Impact.SpotLight.PointLight;
    u14.PlaceVFXInHere.Emit.Impact.SpotLight.PointLight.Enabled = true;
    TweenService:Create(PointLight, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
        Brightness = 0,
        Range = 60
    }):Play();
end;