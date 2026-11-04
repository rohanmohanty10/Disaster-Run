 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local _ = game.Players.LocalPlayer;

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3: table)
    local v4 = 0;

    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 24
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;

            local v5 = (v:GetAttribute("EmitDelay") or 0) + v.Lifetime.Max;
            v4 = math.max(v4, v5);
        end;
    end;

    return v4;
end;

local function Destroy_Effect(u6: userdata, p7: number) -- Line: 38
    task.delay(p7, function() -- Line: 39
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;

return function(p8, p9) -- Line: 44
    -- upvalues: TweenService (copy)
    local u10 = script.SLASH:Clone();
    u10.Parent = workspace.Debris;
    u10.CFrame = p9.CFrame;

    if p9.Preview then
        for _, descendant in u10:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local v11 = descendant;
                local v12 = {};

                for _, v in descendant.Size.Keypoints do
                    local v13;

                    if v.Envelope then
                        v13 = v.Envelope / 10 or nil;
                    else
                        v13 = nil;
                    end;

                    if v13 ~= v13 then
                        v13 = nil;
                    end;

                    table.insert(v12, NumberSequenceKeypoint.new(v.Time, v.Value / 10, v13));
                end;

                v11.Size = NumberSequence.new(v12);
                v11.Speed = NumberRange.new(v11.Speed.Min / 10, v11.Speed.Max / 10);
            elseif descendant:IsA("Attachment") then
                descendant.Position = descendant.Position / 10;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = Vector3.new(0, 0, 0);
                end;
            elseif descendant:IsA("BasePart") then
                descendant.Position = p9.CFrame.Position + (descendant.Position - p9.CFrame.Position) / 10;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = p9.CFrame.Position;
                end;

                descendant.Size = descendant.Size / 10;

                if descendant.Size ~= descendant.Size then
                    descendant.Size = Vector3.new(0, 0, 0);
                end;
            end;
        end;
    end;

    local v14 = EmitAll(u10:GetDescendants());
    task.delay(v14, function() -- Line: 39
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);

    for _, descendant in u10:GetDescendants() do
        if descendant:IsA("Beam") and descendant.Name == "ImpactBeam" then
            descendant.Enabled = true;
            TweenService:Create(descendant, TweenInfo.new(0.755), {
                TextureLength = 0.1,
                Width0 = 0,
                Width1 = 0
            }):Play();
        end;
    end;

    if p9.Preview then
        return;
    end;

    local PointLight = u10.Core.Lights.PointLight;
    PointLight.Enabled = true;
    PointLight.Brightness = 10;
    PointLight.Range = 25;
    TweenService:Create(PointLight, TweenInfo.new(0.755, Enum.EasingStyle.Quint), {
        Brightness = 0,
        Range = 60
    }):Play();
    local ColorCorrection = game.Lighting.ColorCorrection;
    ColorCorrection.Brightness = 0.25;
    ColorCorrection.Contrast = 2;
    ColorCorrection.Saturation = -1;
    ColorCorrection.TintColor = Color3.fromRGB(255, 0, 0);
    TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
        Brightness = -0.015,
        Contrast = 0.2,
        Saturation = 0.3,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    local Bloom = game.Lighting.Bloom;
    Bloom.Intensity = 5;
    TweenService:Create(Bloom, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Intensity = 0.25
    }):Play();
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 10;
    BlurEffect.Parent = game.Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    task.delay(0.455, function() -- Line: 39
        -- upvalues: BlurEffect (copy)
        BlurEffect:Destroy();
    end);
    game.Lighting.ExposureCompensation = 1;
    local u15 = TweenService:Create(game.Lighting, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
        ExposureCompensation = -0.5
    });
    u15:Play();
    u15.Completed:Connect(function() -- Line: 131
        -- upvalues: u15 (copy), TweenService (ref)
        u15:Destroy();
        TweenService:Create(game.Lighting, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ExposureCompensation = 0
        }):Play();
    end);
end;