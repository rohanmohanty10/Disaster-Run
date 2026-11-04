 
 

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
    local u8 = script.DarkFX:Clone();
    u8.Parent = workspace.Debris;
    u8:PivotTo(p7.CFrame);
    EmitAll(u8:GetDescendants());
    local u9 = u8.PlaceVFXInHere.RingMesh.Start:Clone();
    local End = u8.PlaceVFXInHere.RingMesh.End;
    u9.Transparency = 0;
    u9.Parent = workspace.Debris;
    TweenService:Create(u9, TweenInfo.new(0.755, Enum.EasingStyle.Quint), {
        CFrame = End.CFrame,
        Size = End.Size,
        Color = Color3.fromRGB(0, 0, 0)
    }):Play();
    task.delay(0.355, function() -- Line: 33
        -- upvalues: u9 (copy)
        u9:Destroy();
    end);
    task.delay(0.1, function() -- Line: 54
        -- upvalues: TweenService (ref), u9 (copy)
        TweenService:Create(u9, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
    end);
    local ColorCorrection = game.Lighting.ColorCorrection;
    ColorCorrection.Brightness = 0.25;
    ColorCorrection.Contrast = 1.25;
    ColorCorrection.Saturation = -1;
    ColorCorrection.TintColor = Color3.fromRGB(56, 28, 118);
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
    BlurEffect.Size = 6;
    BlurEffect.Parent = game.Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    task.delay(0.455, function() -- Line: 33
        -- upvalues: BlurEffect (copy)
        BlurEffect:Destroy();
    end);
    task.delay(2, function() -- Line: 74
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;