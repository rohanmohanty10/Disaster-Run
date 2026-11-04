 

 

local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");

return {
    [0] = function(p1) -- Line: 4
        -- upvalues: TweenService (copy)
        for _, descendant in p1.Models.CameraRig.VFX.CamFX1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in p1.Models.Metavision.VFX.EyeShine:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        p1.ColorCorrection.Brightness = -0.1;
        p1.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255);
        p1.ColorCorrection.Contrast = 0.2;
        p1.ColorCorrection.Saturation = 0.2;
        TweenService:Create(p1.Blur, TweenInfo.new(2.783, Enum.EasingStyle.Linear), {
            Size = 1.5
        }):Play();
        TweenService:Create(p1.ColorCorrection, TweenInfo.new(2.867, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = -0.1,
            Saturation = -0.1,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end,

    [2.8] = function(p2) -- Line: 22
        -- upvalues: TweenService (copy), Lighting (copy)
        for _, descendant in p2.Effects.EyeScene:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in p2.Models.Metavision.VFX.EyeScene:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in p2.Models.CameraRig.VFX.CamFX3:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in p2.Models.CameraRig.VFX.CamFX2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        p2.Atmosphere.Density = 0.6;
        p2.Atmosphere.Offset = 0.25;
        p2.Atmosphere.Color = Color3.new();
        p2.Atmosphere.Decay = Color3.fromRGB(106, 112, 125);
        p2.Atmosphere.Glare = 0;
        p2.Atmosphere.Haze = 4;
        p2.Blur.Size = 24;
        TweenService:Create(p2.Blur, TweenInfo.new(1.3330000000000002, Enum.EasingStyle.Linear), {
            Size = 1.5
        }):Play();
        TweenService:Create(Lighting, TweenInfo.new(0.2330000000000001, Enum.EasingStyle.Linear), {
            ClockTime = 24
        }):Play();
    end,

    [3.033] = function(p3) -- Line: 53
        -- upvalues: TweenService (copy), Lighting (copy)
        TweenService:Create(Lighting, TweenInfo.new(1.6999999999999997, Enum.EasingStyle.Linear), {
            ClockTime = 0
        }):Play();
    end,

    [4.133] = function(p4) -- Line: 56
        -- upvalues: TweenService (copy)
        TweenService:Create(p4.Blur, TweenInfo.new(0.5339999999999998, Enum.EasingStyle.Linear), {
            Size = 24
        }):Play();
    end,

    [5.2] = function(p5) -- Line: 59
        -- upvalues: TweenService (copy)
        TweenService:Create(p5.Blur, TweenInfo.new(0.5330000000000004, Enum.EasingStyle.Linear), {
            Size = 1.5
        }):Play();
    end,

    [4.75] = function(p6) -- Line: 62
        -- upvalues: Lighting (copy), TweenService (copy)
        Lighting.ClockTime = 14.5;
        p6.Atmosphere.Density = 0.3;
        p6.Atmosphere.Offset = 0.25;
        p6.Atmosphere.Color = Color3.fromRGB(199, 199, 199);
        p6.Atmosphere.Decay = Color3.fromRGB(106, 112, 125);
        p6.Atmosphere.Glare = 0;
        p6.Atmosphere.Haze = 0;
        TweenService:Create(p6.Blur, TweenInfo.new(1.3330000000000002, Enum.EasingStyle.Linear), {
            Size = 1.5
        }):Play();
    end,

    [4.766666666666667] = function(p7) -- Line: 72
        for _, descendant in p7.Effects.Step1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in p7.Effects.windbem:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in p7.Effects.EyeScene:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in p7.Models.CameraRig.VFX.CamFX3:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
                descendant:Clear();
            end;
        end;

        for _, descendant in p7.Models.Metavision.VFX.EyeShine:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [5.033] = function(p8) -- Line: 100
        -- upvalues: TweenService (copy)
        TweenService:Create(p8.Depth, TweenInfo.new(0.6839999999999993), {
            InFocusRadius = 20
        }):Play();
    end,

    [5.717] = function(p9) -- Line: 103
        -- upvalues: TweenService (copy)
        TweenService:Create(p9.Depth, TweenInfo.new(1.1160000000000005), {
            InFocusRadius = 10
        }):Play();
    end,

    [5.733] = function(p10) -- Line: 106
        -- upvalues: TweenService (copy)
        TweenService:Create(p10.Atmosphere, TweenInfo.new(2.7670000000000003, Enum.EasingStyle.Linear), {
            Density = 0.4
        }):Play();
    end,

    [8.65] = function(p11) -- Line: 109
        -- upvalues: TweenService (copy)
        TweenService:Create(p11.Depth, TweenInfo.new(1.799999999999999), {
            InFocusRadius = 5,
            FarIntensity = 1,
            NearIntensity = 1
        }):Play();
    end,

    [10.35] = function(p12) -- Line: 112
        -- upvalues: TweenService (copy)
        TweenService:Create(p12.Atmosphere, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Density = 1
        }):Play();
    end,

    [10.45] = function(p13) -- Line: 115
        -- upvalues: TweenService (copy)
        TweenService:Create(p13.Depth, TweenInfo.new(0.1670000000000016), {
            InFocusRadius = 2
        }):Play();
        TweenService:Create(p13.Depth, TweenInfo.new(0.28300000000000125), {
            NearIntensity = 0.7
        }):Play();
    end,

    [5.266666666666667] = function(p14) -- Line: 119
        for _, descendant in p14.Effects.Step2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [5.616666666666666] = function(p15) -- Line: 126
        for _, descendant in p15.Effects.Step3:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [6.113] = function(p16) -- Line: 133
        -- upvalues: TweenService (copy)
        TweenService:Create(p16.Blur, TweenInfo.new(0.3039999999999994, Enum.EasingStyle.Linear), {
            Size = 6
        }):Play();
    end,

    [6.366666666666666] = function(p17) -- Line: 136
        for _, descendant in p17.Effects.Step4:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in p17.Effects.windbem:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [6.417] = function(p18) -- Line: 149
        -- upvalues: TweenService (copy)
        TweenService:Create(p18.Blur, TweenInfo.new(0.4660000000000002, Enum.EasingStyle.Linear), {
            Size = 2
        }):Play();
    end,

    [6.883333333333334] = function(p19) -- Line: 152
        -- upvalues: TweenService (copy)
        for _, descendant in p19.Models.Guns.VFX.Shine1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        TweenService:Create(p19.Blur, TweenInfo.new(0.08399999999999963, Enum.EasingStyle.Linear), {
            Size = 5
        }):Play();
    end,

    [6.967] = function(p20) -- Line: 160
        -- upvalues: TweenService (copy)
        TweenService:Create(p20.Blur, TweenInfo.new(0.4500000000000002, Enum.EasingStyle.Linear), {
            Size = 2
        }):Play();
    end,

    [7.017] = function(p21) -- Line: 163
        -- upvalues: TweenService (copy)
        TweenService:Create(p21.ColorCorrection, TweenInfo.new(1.3159999999999998, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end,

    [7.283] = function(p22) -- Line: 166
        -- upvalues: TweenService (copy)
        TweenService:Create(p22.Atmosphere, TweenInfo.new(1.2169999999999996, Enum.EasingStyle.Linear), {
            Haze = 3
        }):Play();
    end,

    [7.65] = function(p23) -- Line: 169
        -- upvalues: TweenService (copy)
        TweenService:Create(p23.Atmosphere, TweenInfo.new(0.8499999999999996, Enum.EasingStyle.Linear), {
            Color = Color3.new()
        }):Play();
    end,

    [7.466666666666667] = function(p24) -- Line: 172
        for _, descendant in p24.Models.Guns.VFX.Shine2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [8.45] = function(p25) -- Line: 179
        for _, descendant in p25.Models.Metavision.VFX.eye1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [8.5] = function(p26) -- Line: 186
        -- upvalues: TweenService (copy)
        p26.Atmosphere.Density = 0.4;
        p26.Atmosphere.Offset = 0;
        p26.Atmosphere.Color = Color3.new();
        p26.Atmosphere.Decay = Color3.fromRGB(106, 112, 125);
        p26.Atmosphere.Glare = 0;
        p26.Atmosphere.Haze = 3;
        TweenService:Create(p26.Atmosphere, TweenInfo.new(0.9169999999999998, Enum.EasingStyle.Linear), {
            Density = 0.9
        }):Play();
    end,

    [8.183] = function(p27) -- Line: 195
        -- upvalues: TweenService (copy)
        TweenService:Create(p27.Blur, TweenInfo.new(0.08399999999999963, Enum.EasingStyle.Linear), {
            Size = 5
        }):Play();
    end,

    [8.267] = function(p28) -- Line: 198
        -- upvalues: TweenService (copy)
        TweenService:Create(p28.Blur, TweenInfo.new(0.16600000000000037, Enum.EasingStyle.Linear), {
            Size = 3.857
        }):Play();
    end,

    [8.45] = function(p29) -- Line: 201
        -- upvalues: TweenService (copy)
        p29.Blur = 24;
        TweenService:Create(p29.Blur, TweenInfo.new(0.15000000000000036, Enum.EasingStyle.Linear), {
            Size = 0.5
        }):Play();
    end,

    [8.333] = function(p30) -- Line: 205
        -- upvalues: TweenService (copy)
        TweenService:Create(p30.ColorCorrection, TweenInfo.new(0.33399999999999963, Enum.EasingStyle.Linear), {
            Brightness = 0.2
        }):Play();
    end,

    [8.663] = function(p31) -- Line: 208
        -- upvalues: TweenService (copy)
        p31.Blur = 24;
        TweenService:Create(p31.Blur, TweenInfo.new(0.9670000000000005, Enum.EasingStyle.Linear), {
            Size = 0.5
        }):Play();
    end,

    [8.667] = function(p32) -- Line: 212
        -- upvalues: TweenService (copy)
        TweenService:Create(p32.ColorCorrection, TweenInfo.new(2.3499999999999996, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(165, 193, 255)
        }):Play();
        TweenService:Create(p32.ColorCorrection, TweenInfo.new(0.40000000000000036, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end,

    [9.067] = function(p33) -- Line: 216
        -- upvalues: TweenService (copy)
        TweenService:Create(p33.ColorCorrection, TweenInfo.new(1.516, Enum.EasingStyle.Linear), {
            Brightness = 0.1
        }):Play();
    end,

    [9.717] = function(p34) -- Line: 219
        -- upvalues: TweenService (copy)
        p34.Blur = 10;
        TweenService:Create(p34.Blur, TweenInfo.new(0.8499999999999996, Enum.EasingStyle.Linear), {
            Size = 2.5
        }):Play();
    end,

    [0.85] = function(p35) -- Line: 223
        for _, descendant in p35.Models.CameraRig.VFX.CamFX1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in p35.Models.Metavision.VFX.EyeShine:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in p35.Models.CameraRig.VFX.CamFX2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [8.633333333333333] = function(p36) -- Line: 240
        for _, descendant in p36.Effects.Impact:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in p36.Models.Guns.VFX.Shine3:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in p36.Models.Guns.VFX.Shine4:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in p36.Models.FakeHead.Head.main:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [10.533333333333333] = function(p37) -- Line: 262
        for _, descendant in p37.Models.CameraRig.VFX.CamFX4:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [10.583] = function(p38) -- Line: 269
        -- upvalues: TweenService (copy)
        p38.Blur.Size = 24;
        TweenService:Create(p38.Blur, TweenInfo.new(0.7999999999999989, Enum.EasingStyle.Linear), {
            Size = 2.5
        }):Play();
    end,

    [11.15] = function(p39) -- Line: 273
        for _, descendant in p39.Models.FakeHead.Head.breath:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [12.583] = function(p40) -- Line: 280
        -- upvalues: TweenService (copy)
        p40.Blur.Size = 6;
        TweenService:Create(p40.Blur, TweenInfo.new(0.7669999999999995, Enum.EasingStyle.Linear), {
            Size = 5
        }):Play();
    end,

    [13.95] = function(p41) -- Line: 284
        -- upvalues: TweenService (copy)
        TweenService:Create(p41.ColorCorrection, TweenInfo.new(15.233, Enum.EasingStyle.Linear), {
            Brightness = -1
        }):Play();
    end,

    [14.95] = function(p42) -- Line: 287
        for _, descendant in p42.Models.Metavision.VFX.eye1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in p42.Models.CameraRig.VFX.CamFX4:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in p42.Models.FakeHead:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end
};