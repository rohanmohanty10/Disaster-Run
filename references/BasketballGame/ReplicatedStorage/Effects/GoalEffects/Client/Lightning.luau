 
 

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
    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 22
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;

local function Destroy_Effect(u4: userdata, p5: number) -- Line: 32
    task.delay(p5, function() -- Line: 33
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;

return function(p6, p7) -- Line: 38
    -- upvalues: TweenService (copy)
    local u8 = script.LightningVFX:Clone();
    u8.Parent = workspace.Debris;
    u8:PivotTo(p7.CFrame);
    EmitAll(u8:GetDescendants());
    local PointLight = u8.PlaceVFXInHere.VFX.Lights.PointLight;
    PointLight.Enabled = true;
    PointLight.Brightness = 5;
    PointLight.Range = 45;
    EmitAll(u8.PlaceVFXInHere.VFX:GetDescendants());
    TweenService:Create(PointLight, TweenInfo.new(1.455, Enum.EasingStyle.Quad), {
        Brightness = 0,
        Range = 60
    }):Play();
    local ColorCorrection = game.Lighting.ColorCorrection;
    ColorCorrection.Brightness = 0.25;
    ColorCorrection.Contrast = 1.25;
    ColorCorrection.Saturation = -1;
    ColorCorrection.TintColor = Color3.fromRGB(255, 160, 43);
    TweenService:Create(ColorCorrection, TweenInfo.new(0.255, Enum.EasingStyle.Quint), {
        Brightness = -0.015,
        Contrast = 0.2,
        Saturation = 0.3,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    local Bloom = game.Lighting.Bloom;
    Bloom.Intensity = 1.5;
    Bloom.Threshold = 1.65;
    TweenService:Create(Bloom, TweenInfo.new(1.33, Enum.EasingStyle.Linear), {
        Intensity = 0.25,
        Threshold = 2
    }):Play();
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 8;
    BlurEffect.Parent = game.Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    task.delay(0.755, function() -- Line: 33
        -- upvalues: BlurEffect (copy)
        BlurEffect:Destroy();
    end);
    game.Lighting.ExposureCompensation = -0.75;
    local u9 = TweenService:Create(game.Lighting, TweenInfo.new(0.833, Enum.EasingStyle.Linear), {
        ExposureCompensation = -0.5
    });
    u9:Play();
    u9.Completed:Connect(function() -- Line: 72
        -- upvalues: u9 (copy), TweenService (ref)
        u9:Destroy();
        TweenService:Create(game.Lighting, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            ExposureCompensation = 0
        }):Play();
    end);
    task.delay(2, function() -- Line: 33
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;