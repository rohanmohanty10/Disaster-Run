 

 

local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");

return {
    [0] = function(u1) -- Line: 7
        task.spawn(function() -- Line: 8
            -- upvalues: u1 (copy)
            for _, descendant in pairs(u1.BachiraVFX.Flare:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(u1.Character:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end);
    end,

    [0.02] = function(p2) -- Line: 23
        -- upvalues: Lighting (copy), Debris (copy)
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Name = "AnimationSaturation";
        ColorCorrectionEffect.Saturation = 0.2;
        ColorCorrectionEffect.Parent = Lighting;
        Debris:AddItem(ColorCorrectionEffect, 9);
        task.delay(9, function() -- Line: 40
            -- upvalues: ColorCorrectionEffect (copy)
            pcall(game.Destroy, ColorCorrectionEffect);
        end);
    end,

    [3] = function(p3) -- Line: 44
        for _, descendant in pairs(p3.Character:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [2.43] = function(p4) -- Line: 51
        for _, descendant in pairs(p4.BachiraVFX.Grass3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 50);
            end;
        end;

        for _, descendant in pairs(p4.BachiraVFX.Grass4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 50);
            end;
        end;
    end,

    [1.07] = function(p5) -- Line: 68
        for _, descendant in pairs(p5.BachiraVFX.VFX1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 50);
            end;
        end;
    end,

    [2.32] = function(p6) -- Line: 77
        -- upvalues: Lighting (copy), Debris (copy), TweenService (copy)
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 0;
        BlurEffect.Parent = Lighting;
        Debris:AddItem(BlurEffect, 3);
        local v7 = TweenService:Create(BlurEffect, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = 12
        });
        local v8 = TweenService:Create(BlurEffect, TweenInfo.new(0.35), {
            Size = 0
        });
        v7:Play();
        task.wait(0.18);
        v8:Play();
        v8.Completed:Wait();
        pcall(game.Destroy, BlurEffect);
    end,

    [0.3] = function(p9) -- Line: 106
        -- upvalues: Lighting (copy), Debris (copy), TweenService (copy)
        local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
        local BloomEffect = Instance.new("BloomEffect");
        BloomEffect.Enabled = true;
        BloomEffect.Intensity = 0;
        BloomEffect.Size = 24;
        BloomEffect.Threshold = 2;
        BloomEffect.Parent = Lighting;
        Debris:AddItem(BloomEffect, 3);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Brightness = 0;
        ColorCorrectionEffect.TintColor = Color3_fromRGB_ret;
        ColorCorrectionEffect.Parent = Lighting;
        Debris:AddItem(ColorCorrectionEffect, 3);
        local v10 = TweenService:Create(BloomEffect, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Intensity = 0.8
        });
        local v11 = TweenService:Create(BloomEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Intensity = 0
        });
        local v12 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Brightness = 0.2
        });
        local v13 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Brightness = 0
        });
        v10:Play();
        v12:Play();
        task.wait(0.2);
        v11:Play();
        v13:Play();
        v11.Completed:Connect(function() -- Line: 166
            -- upvalues: BloomEffect (copy), ColorCorrectionEffect (copy)
            pcall(game.Destroy, BloomEffect);
            pcall(game.Destroy, ColorCorrectionEffect);
        end);
    end,

    [4.17] = function(p14) -- Line: 171
    end,

    [5.95] = function(p15) -- Line: 194
        for _, descendant in pairs(p15.BachiraVFX.eye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 50);
            end;
        end;
    end,

    [1.3] = function(p16) -- Line: 203
        for _, descendant in pairs(p16.BachiraVFX.Flare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(p16.Character:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.5] = function(p17) -- Line: 216
        -- upvalues: Lighting (copy), Debris (copy), TweenService (copy)
        local BloomEffect = Instance.new("BloomEffect");
        BloomEffect.Intensity = 0;
        BloomEffect.Size = 32;
        BloomEffect.Threshold = 1.5;
        BloomEffect.Parent = Lighting;
        Debris:AddItem(BloomEffect, 3);
        local SunRaysEffect = Instance.new("SunRaysEffect");
        SunRaysEffect.Intensity = 0;
        SunRaysEffect.Spread = 1;
        SunRaysEffect.Parent = Lighting;
        Debris:AddItem(SunRaysEffect, 3);
        local v18 = TweenService:Create(BloomEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            Intensity = 1.5
        });
        local v19 = TweenService:Create(SunRaysEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            Intensity = 0.05
        });
        v18:Play();
        v19:Play();
        task.delay(3, function() -- Line: 258
            -- upvalues: TweenService (ref), BloomEffect (copy), SunRaysEffect (copy)
            local v20 = TweenService:Create(BloomEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                Intensity = 0
            });
            local v21 = TweenService:Create(SunRaysEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                Intensity = 0
            });
            v20:Play();
            v21:Play();
            v20.Completed:Connect(function() -- Line: 275
                -- upvalues: BloomEffect (ref), SunRaysEffect (ref)
                pcall(game.Destroy, BloomEffect);
                pcall(game.Destroy, SunRaysEffect);
            end);
        end);
    end,

    [4.15] = function(u22) -- Line: 281
        -- upvalues: Lighting (copy), RunService (copy)
        task.spawn(function() -- Line: 282
            -- upvalues: u22 (copy)
            for _, descendant in pairs(u22.BachiraVFX.VFX3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 50);
                end;
            end;
        end);
        task.spawn(function() -- Line: 291
            -- upvalues: Lighting (ref), RunService (ref)
            local u23 = {
                MaxBrightness = 0.6,
                MaxContrast = 0.2,
                MaxSaturation = 0.5,
                FadeTime = 0.15,
                WaitAfterFade = 0.05,
                Color = Color3.fromRGB(255, 255, 150)
            };
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Name = "YellowFlash";
            ColorCorrectionEffect.TintColor = u23.Color;
            ColorCorrectionEffect.Brightness = u23.MaxBrightness;
            ColorCorrectionEffect.Contrast = u23.MaxContrast;
            ColorCorrectionEffect.Saturation = u23.MaxSaturation;
            ColorCorrectionEffect.Parent = Lighting;
            local u24 = tick();
            local FadeTime = u23.FadeTime;
            local u25 = nil;
            u25 = RunService.RenderStepped:Connect(function() -- Line: 317
                -- upvalues: u24 (copy), FadeTime (copy), ColorCorrectionEffect (copy), u23 (copy), u25 (ref)
                local v26 = 1 - (tick() - u24) / FadeTime;
                local math_clamp_ret = math.clamp(v26, 0, 1);
                ColorCorrectionEffect.Brightness = u23.MaxBrightness * math_clamp_ret;
                ColorCorrectionEffect.Contrast = u23.MaxContrast * math_clamp_ret;
                ColorCorrectionEffect.Saturation = u23.MaxSaturation * math_clamp_ret;

                if math_clamp_ret <= 0 then
                    u25:Disconnect();
                    ColorCorrectionEffect.Brightness = 0;
                    ColorCorrectionEffect.Contrast = 0;
                    ColorCorrectionEffect.Saturation = 0;
                    task.delay(u23.WaitAfterFade, function() -- Line: 333
                        -- upvalues: ColorCorrectionEffect (ref)
                        pcall(ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
                    end);
                end;
            end);
        end);
    end,

    [0.33] = function(p27) -- Line: 340
        for _, descendant in pairs(p27.BachiraVFX.Grass:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 50);
            end;
        end;

        for _, descendant in pairs(p27.BachiraVFX.Grass2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 50);
            end;
        end;

        for _, descendant in pairs(p27.BachiraVFX.VFX:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 5);
            end;
        end;
    end,

    [2.42] = function(p28) -- Line: 365
        for _, descendant in pairs(p28.BachiraVFX.VFX2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 50);
            end;
        end;
    end,

    [0.28] = function(p29) -- Line: 374
        -- upvalues: Lighting (copy), Debris (copy), TweenService (copy)
        local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect");
        DepthOfFieldEffect.FarIntensity = 0;
        DepthOfFieldEffect.FocusDistance = 5;
        DepthOfFieldEffect.InFocusRadius = 10;
        DepthOfFieldEffect.NearIntensity = 0;
        DepthOfFieldEffect.Parent = Lighting;
        Debris:AddItem(DepthOfFieldEffect, 3);
        local v30 = TweenService:Create(DepthOfFieldEffect, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
            FarIntensity = 0.25
        });
        local v31 = TweenService:Create(DepthOfFieldEffect, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
            FarIntensity = 0
        });
        v30:Play();
        task.wait(0.8999999999999999);
        v31:Play();
        v31.Completed:Connect(function() -- Line: 408
            -- upvalues: DepthOfFieldEffect (copy)
            pcall(game.Destroy, DepthOfFieldEffect);
        end);
    end
};