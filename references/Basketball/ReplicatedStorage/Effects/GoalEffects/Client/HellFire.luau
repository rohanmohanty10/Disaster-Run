 
 

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

return function(p4, p5) -- Line: 32
    -- upvalues: TweenService (copy)
    local u6 = script.FireFX:Clone();
    u6.Parent = workspace.Debris;
    u6:PivotTo(p5.CFrame);
    print(p5.CFrame);
    local VFXObjects = u6.VFXObjects;
    local _ = VFXObjects.Emit.Impact.Light.PointLight;
    EmitAll(VFXObjects.Emit:GetDescendants());
    EnableVFX(VFXObjects.Enabling, true);
    TweenService:Create(VFXObjects.Emit.Impact.Light.PointLight, TweenInfo.new(1, Enum.EasingStyle.Quad), {
        Brightness = 0,
        Range = 60
    }):Play();

    for _, descendant in VFXObjects.Enabling:GetDescendants() do
        if descendant.ClassName == "Attachment" and descendant.Name == "A1" then
            TweenService:Create(descendant, TweenInfo.new(0.155, Enum.EasingStyle.Sine), {
                WorldPosition = descendant.WorldPosition + Vector3.new(0, 40, 0)
            }):Play();
        end;
    end;

    task.delay(1, function() -- Line: 56
        -- upvalues: VFXObjects (copy), TweenService (ref), u6 (copy)
        EnableVFX(VFXObjects.Enabling, false);

        for _, descendant in VFXObjects.Enabling:GetDescendants() do
            if descendant.ClassName == "Attachment" and descendant.Name == "A1" then
                TweenService:Create(descendant, TweenInfo.new(0.255, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    WorldPosition = descendant.WorldPosition + Vector3.new(0, -40, 0)
                }):Play();
            end;
        end;

        task.wait(3);
        u6:Destroy();
    end);
    local ColorCorrection = game.Lighting.ColorCorrection;
    ColorCorrection.TintColor = Color3.fromRGB(255, 119, 28);
    ColorCorrection.Brightness = 0.3;
    TweenService:Create(ColorCorrection, TweenInfo.new(1.65, Enum.EasingStyle.Sine), {
        Brightness = -0.015,
        Contrast = 0.2,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    local Bloom = game.Lighting.Bloom;
    Bloom.Intensity = 2;
    Bloom.Size = 40;
    TweenService:Create(Bloom, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
        Intensity = 0.25,
        Size = 24,
        Threshold = 2
    }):Play();
end;