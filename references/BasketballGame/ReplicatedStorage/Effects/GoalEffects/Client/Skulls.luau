 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
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
            v.CurveSize0 = v.CurveSize0 / 10;
            v.CurveSize1 = v.CurveSize1 / 10;
        end;
    end;
end;

return function(p6, p7) -- Line: 59
    -- upvalues: LocalPlayer (copy), SfxManager (copy), TweenService (copy), VfxManager (copy), Debris (copy), scaleDown (copy)
    local CFrame2 = p7.CFrame;
    local game_Lighting = game.Lighting;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

    if p7.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldCFrame = CFrame2;
        local v8 = SfxManager:playSound({
            Sound = "BBZ Purple Death Goal",
            Parent = Attachment
        });
        task.delay(v8.TimeLength, function() -- Line: 71
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
    else
        SfxManager:playSound({
            Sound = "BBZ Purple Death Goal",
            Parent = workspace
        });
    end;

    if not p7.Preview then
        local ExposureCompensation = game_Lighting.ExposureCompensation;
        local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
        local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
        local Bloom = game_Lighting:FindFirstChild("Bloom");
        local Intensity = Bloom.Intensity;
        local Size = Bloom.Size;
        local Threshold = Bloom.Threshold;
        local u9 = script.Vignette:Clone();
        u9.Parent = PlayerGui;
        u9.Enabled = true;
        local Vignette = u9.Vignette;
        local Vignette1 = u9.Vignette1;
        ColorCorrection.Brightness = 0.75;
        ColorCorrection.Contrast = 1.25;
        ColorCorrection.Saturation = -1;
        ColorCorrection.TintColor = Color3.fromRGB(87, 57, 255);
        local u10 = TweenService:Create(ColorCorrection, TweenInfo.new(0.085, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            Saturation = 0.3
        });
        u10:Play();
        local u11 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            TintColor = Color3_fromRGB_ret
        });
        u11:Play();
        local Bloom2 = game_Lighting.Bloom;
        Bloom2.Intensity = 1.5;
        Bloom2.Threshold = 1.65;
        local u12 = TweenService:Create(Bloom2, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            Intensity = Intensity,
            Threshold = Threshold
        });
        u12:Play();
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = game_Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(1.25, Enum.EasingStyle.Circular), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1.25);
        Vignette1.ImageColor3 = Color3.fromRGB(53, 35, 156);
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
        local u13 = TweenService:Create(game_Lighting, TweenInfo.new(0.833, Enum.EasingStyle.Linear), {
            ExposureCompensation = -0.5
        });
        u13:Play();
        local u14 = nil;
        u13.Completed:Connect(function() -- Line: 133
            -- upvalues: u13 (copy), u14 (ref), TweenService (ref), game_Lighting (copy), ExposureCompensation (copy)
            u13:Destroy();
            u14 = TweenService:Create(game_Lighting, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                ExposureCompensation = ExposureCompensation
            });
            u14:Play();
        end);
        task.delay(1.567, function() -- Line: 139
            -- upvalues: u9 (copy), u10 (copy), u11 (copy), u13 (copy), u12 (copy), u14 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), Bloom2 (copy), Intensity (copy), Size (copy), Threshold (copy), game_Lighting (copy), ExposureCompensation (copy)
            if u9 then
                u9:Destroy();
            end;

            if u10 then
                u10:Pause();
            end;

            if u11 then
                u11:Pause();
            end;

            if u13 then
                u13:Pause();
            end;

            if u12 then
                u12:Pause();
            end;

            if u14 then
                u14:Pause();
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

    local u15 = script.Skull:Clone();
    u15:PivotTo(p7.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    u15.Parent = Debris;

    if p7.Preview then
        scaleDown(u15:GetDescendants(), p7);
    end;

    task.delay(0.167, function() -- Line: 185
        -- upvalues: VfxManager (ref), u15 (copy)
        VfxManager.Emit(u15["Skullz Start"]);
        VfxManager.Emit(u15.Skullz.thing);
        VfxManager.Enable(u15.Skullz.enable, true);
    end);
    task.delay(1.567, function() -- Line: 191
        -- upvalues: VfxManager (ref), u15 (copy)
        VfxManager.Enable(u15, false);
        VfxManager.Emit(u15.Skullz);
        VfxManager.Emit(u15.VFX);
        VfxManager.DestroyEffect(u15, 3);
    end);
end;