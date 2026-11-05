  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

local function SetScale(p2, p3) -- Line: 17
    for _, descendant in p2:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.TimeScale = p3;
        end;
    end;
end;

local function Bezier(p4, p5, p6, p7) -- Line: 25
    return (1 - p4) ^ 2 * p5 + 2 * (1 - p4) * p4 * p6 + p4 ^ 2 * p7;
end;

local function GetRand(p8, p9) -- Line: 29
    -- upvalues: u1 (copy)
    return (math.random(1, 2) == 1 and -1 or 1) * u1:NextNumber(p8, p9);
end;

return function(p10) -- Line: 33
    -- upvalues: Players (copy), AssetHandler (copy), EffectsHandler (copy), SetScale (copy), ParticleHandler (copy), RunService (copy), TweenService (copy), u1 (copy)
    local v11 = p10 or {};
    local Characters = v11.Characters;
    local Attacker = Characters.Attacker;
    local Victim = Characters.Victim;
    local u12 = Players:GetPlayerFromCharacter(Victim);
    local u13 = Players:GetPlayerFromCharacter(Attacker);

    if not v11.TargetCFrame then
        CFrame.new();
    end;

    local HumanoidRootPart = Attacker.HumanoidRootPart;

    local function CanContinue() -- Line: 47
        -- upvalues: Attacker (copy), Victim (copy)
        local v14 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

        return v14;
    end;

    local u15 = AssetHandler.GetAbilityData(Attacker);
    local u16 = { 2, 3, 4 };
    local v17 = { { 43, 53 }, { 116, 131 }, { 155, 183 }, { 219, 454 }, { 462, 670 } };
    local v18 = { 219, 240, 253, 269, 284, 295, 307, 321, 332, 340, 355, 366, 381, 386, 399, 406, 411, 421, 431, 443, 454 };

    for i, v in { 3, 15, 23, 31, 58, 69, 86, 94, 116, 146, 155, 183, 462, 671 } do
        task.delay(v / 60, function() -- Line: 65
            -- upvalues: Attacker (copy), Victim (copy), u16 (copy), i (copy), EffectsHandler (ref), u13 (copy), HumanoidRootPart (copy), SetScale (ref)
            local v19 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

            if not v19 then
                return;
            end;

            local v20 = table.find(u16, i);
            local v21 = EffectsHandler.CallEffect("Emit Particle V3", {
                Player = u13,
                Origin = HumanoidRootPart,
                Path = "Particles/Fluorescence/Hits/" .. tostring(i)
            });

            if v20 then
                local Particle = v21.Particle;
                task.delay(0.03333333333333333, SetScale, Particle, 0);
                task.delay(0.08333333333333333, SetScale, Particle, 1);
            end;
        end);
    end;

    for i, v in v17 do
        task.delay(v[1] / 60, function() -- Line: 84
            -- upvalues: Attacker (copy), Victim (copy), EffectsHandler (ref), v (copy), u13 (copy), HumanoidRootPart (copy), i (copy)
            local v22 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

            if not v22 then
                return;
            end;

            EffectsHandler.CallEffect("Emit Particle V3", {
                EnableDuration = (v[2] - v[1]) / 60,
                Player = u13,
                Origin = HumanoidRootPart,
                Path = "Particles/Fluorescence/Enabled/" .. tostring(i)
            });
        end);
    end;

    local u23 = AssetHandler.CloneAsset("Particles/Fluorescence/Pierce", u15);
    u23.Anchored = false;
    u23.Parent = Attacker;
    ParticleHandler.AttachTo(u23, {
        Part = Attacker.Torso
    });
    local u24 = ParticleHandler.GenerateEmitInfo(u23);
    task.delay(v18[#v18] / 60, function() -- Line: 105
        -- upvalues: ParticleHandler (ref), u23 (copy)
        ParticleHandler.DestroyEmit(u23);
    end);

    for _, v in v18 do
        task.delay(v / 60, function() -- Line: 111
            -- upvalues: Attacker (copy), Victim (copy), ParticleHandler (ref), u23 (copy), u24 (copy)
            local v25 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

            if not v25 then
                return;
            end;

            ParticleHandler.Emit(u23, u24);
        end);
    end;

    task.delay(2.566666666666667, function() -- Line: 124
        -- upvalues: Attacker (copy), Victim (copy), AssetHandler (ref), u15 (copy), RunService (ref), ParticleHandler (ref), TweenService (ref)
        local v26 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

        if not v26 then
            return;
        end;

        local u27 = os.clock();
        local u28 = CFrame.new(Attacker.Torso.Position);

        for i = 1, 2 do
            local u29 = (i - 1) * 3.141592653589793;
            local u30 = 0;
            local u31 = 10;

            local function GetCFrame() -- Line: 143
                -- upvalues: u28 (copy), u29 (ref), u31 (ref), u30 (ref)
                return u28 * CFrame.new(math.cos(u29) * u31, u30, -math.sin(u29) * u31);
            end;

            local u32 = AssetHandler.CloneAsset("Particles/Fluorescence/Trail", u15);
            u32.CFrame = u28 * CFrame.new(math.cos(u29) * u31, u30, -math.sin(u29) * u31);
            u32.Parent = workspace.Effects;
            local u33 = nil;
            u33 = RunService.RenderStepped:Connect(function(p34) -- Line: 152
                -- upvalues: u27 (copy), u33 (ref), ParticleHandler (ref), u32 (copy), u29 (ref), u30 (ref), u31 (ref), u28 (copy)
                if os.clock() - u27 >= 0.4166666666666667 then
                    u33:Disconnect();
                    u33 = nil;
                    ParticleHandler.EnableAllParticles(u32, false);
                    ParticleHandler.DestroyEmit(u32);

                    return;
                end;

                local v35 = (os.clock() - u27) / 0.4166666666666667;
                u29 = u29 + 28.274333882308138 * p34;
                u30 = math.lerp(0, 15, v35);
                u31 = math.lerp(10, 0, v35);
                u32.CFrame = u28 * CFrame.new(math.cos(u29) * u31, u30, -math.sin(u29) * u31);
            end);
        end;

        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.FillTransparency = 0;
        Highlight.OutlineTransparency = 1;
        Highlight.FillColor = Color3.fromRGB(0, 0, 0);
        Highlight.Parent = Attacker;
        local v36 = TweenService:Create(Highlight, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, 0.2), {
            FillTransparency = 1
        });
        v36:Play();
        v36.Completed:Connect(function() -- Line: 184
            -- upvalues: Highlight (copy)
            Highlight:Destroy();
        end);
    end);
    task.delay(3.05, function() -- Line: 189
        -- upvalues: Attacker (copy), Victim (copy), TweenService (ref)
        local v37 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

        if not v37 then
            return;
        end;

        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.FillTransparency = -0.8;
        Highlight.OutlineTransparency = 1;
        Highlight.FillColor = Color3.fromRGB(174, 59, 223);
        Highlight.Parent = Attacker;
        local v38 = TweenService:Create(Highlight, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FillTransparency = 1
        });
        v38:Play();
        v38.Completed:Connect(function() -- Line: 203
            -- upvalues: Highlight (copy)
            Highlight:Destroy();
        end);
    end);
    task.delay(3.1166666666666667, function() -- Line: 208
        -- upvalues: Attacker (copy), Victim (copy), u1 (ref), AssetHandler (ref), u15 (copy), ParticleHandler (ref), RunService (ref)
        local v39 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

        if not v39 then
            return;
        end;

        os.clock();

        for _ = 1, 8 do
            local u40 = 0;
            local u41 = 0;
            local u42 = CFrame.new(Attacker.Torso.Position);
            local u43 = CFrame.new(Victim.Torso.Position) * CFrame.new(0, 2.5, 0);
            local u44 = CFrame.new((u42.Position + u43.Position) / 2) * CFrame.new((math.random(1, 2) == 1 and -1 or 1) * u1:NextNumber(8.5, 15), u1:NextNumber(4, 9), (math.random(1, 2) == 1 and -1 or 1) * u1:NextNumber(10, 15));

            local function _() -- Line: 225
                -- upvalues: u40 (ref), u42 (copy), u44 (copy), u43 (copy)
                local v45 = game.TweenService:GetValue(u40, Enum.EasingStyle.Cubic, Enum.EasingDirection.In);

                return CFrame.new((1 - v45) ^ 2 * u42.Position + 2 * (1 - v45) * v45 * u44.Position + v45 ^ 2 * u43.Position);
            end;

            local u46 = AssetHandler.CloneAsset("Particles/Fluorescence/Trail", u15);
            local v47 = game.TweenService:GetValue(u40, Enum.EasingStyle.Cubic, Enum.EasingDirection.In);
            u46.CFrame = CFrame.new((1 - v47) ^ 2 * u42.Position + 2 * (1 - v47) * v47 * u44.Position + v47 ^ 2 * u43.Position);
            u46.Parent = workspace.Effects;
            ParticleHandler.ScaleLifetime(u46, u1:NextNumber(1.3, 1.5));
            local u48 = nil;
            u48 = RunService.RenderStepped:Connect(function(p49) -- Line: 237
                -- upvalues: u40 (ref), u48 (ref), ParticleHandler (ref), u46 (copy), u41 (ref), u42 (copy), u44 (copy), u43 (copy)
                if u40 >= 1 then
                    u48:Disconnect();
                    u48 = nil;
                    ParticleHandler.EnableAllParticles(u46, false);
                    ParticleHandler.DestroyEmit(u46);

                    return;
                end;

                u41 = u41 + p49;
                u40 = u41 / 0.43333333333333335;
                local v50 = game.TweenService:GetValue(u40, Enum.EasingStyle.Cubic, Enum.EasingDirection.In);
                u46.CFrame = CFrame.new((1 - v50) ^ 2 * u42.Position + 2 * (1 - v50) * v50 * u44.Position + v50 ^ 2 * u43.Position);
            end);
        end;
    end);
    task.delay(3.35, function() -- Line: 256
        -- upvalues: Attacker (copy), Victim (copy), ParticleHandler (ref)
        local v51 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

        if not v51 then
            return;
        end;

        local Stand = Attacker.Stand;
        ParticleHandler.Emit(Stand, ParticleHandler.GenerateEmitInfo(Stand));
    end);
    task.delay(7.716666666666667, function() -- Line: 263
        -- upvalues: Attacker (copy), Victim (copy), AssetHandler (ref), u15 (copy), HumanoidRootPart (copy), EffectsHandler (ref)
        local v52 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

        if not v52 then
            return;
        end;

        local v53 = require(script["Sphere Mesh Flipbook"]);
        local v54 = AssetHandler.GetAsset("Particles/Fluorescence/FlipbookMesh", u15);
        local v55 = CFrame.new(
            2.32440186,
            5.76543808,
            -45.341671,
            0.416489184,
            0.0311932787,
            0.908605814,
            -0.0476777218,
            0.998788476,
            -0.0124366991,
            -0.907889903,
            -0.0381420851,
            0.417471409
        );
        local v56 = HumanoidRootPart.CFrame * v55;
        local v57 = os.clock();
        local v58 = 0;

        while os.clock() - v57 <= 3.433333333333333 do
            v58 = v58 + task.wait();

            if v58 >= 0.16 then
                v58 = 0;

                for _, child in v54:GetChildren() do
                    for _, descendant in child:GetDescendants() do
                        if descendant.Name == "Start" then
                            EffectsHandler.CallEffect("JSMeshEmit", descendant, false, v53, nil, v56);
                        end;
                    end;
                end;
            end;
        end;
    end);
    task.delay(11.2, function() -- Line: 295
        -- upvalues: Attacker (copy), Victim (copy), HumanoidRootPart (copy), AssetHandler (ref), u15 (copy), ParticleHandler (ref), EffectsHandler (ref), Players (ref), u13 (copy), u12 (copy), TweenService (ref)
        local v59 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

        if not v59 then
            return;
        end;

        local v60 = CFrame.new(1.721, -3.038, -43.049);
        local u61 = HumanoidRootPart.CFrame * v60;
        local u62 = AssetHandler.CloneAsset("Particles/Fluorescence/Tornado", u15);
        u62.Parent = workspace.Effects;
        u62:PivotTo(u61 * CFrame.new(0, 0, 0));
        ParticleHandler.EnableVFX(u62, true, { "ParticleEmitter", "Beam", "PointLight" });
        task.delay(2.35, function() -- Line: 307
            -- upvalues: ParticleHandler (ref), u62 (copy)
            ParticleHandler.EnableVFX(u62, false, { "ParticleEmitter", "Beam", "PointLight" });
            ParticleHandler.DestroyEmit(u62);
        end);
        task.spawn(function() -- Line: 312
            -- upvalues: EffectsHandler (ref), u62 (copy)
            EffectsHandler.CallEffect("Mesh Emit", {
                Effect = "Butterfly Tornado",
                Origin = u62.Part.CFrame * CFrame.new(0, 32, 0)
            });
        end);
        task.spawn(function() -- Line: 320
            -- upvalues: Players (ref), u61 (copy), u13 (ref), u12 (ref), TweenService (ref)
            local Magnitude = (Players.LocalPlayer.Character.HumanoidRootPart.Position - u61.Position).Magnitude;

            if Magnitude <= 85 then
                local v63 = (Players.LocalPlayer == u13 or Players.LocalPlayer == u12) and 1 or 1 - Magnitude / 85;
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Brightness = 0.1 * v63;
                ColorCorrectionEffect.Contrast = 0.2 * v63;
                ColorCorrectionEffect.Saturation = 0.5 * v63;
                ColorCorrectionEffect.TintColor = Color3.fromRGB(238, 225, 255);
                ColorCorrectionEffect.Parent = game.Lighting;
                local v64 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    Contrast = 0,
                    Saturation = 0,
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                });
                v64:Play();
                v64.Completed:Connect(function() -- Line: 344
                    -- upvalues: ColorCorrectionEffect (copy)
                    ColorCorrectionEffect:Destroy();
                end);
            end;
        end);
    end);

    if Players.LocalPlayer == u13 or Players.LocalPlayer == u12 then
        if Players.LocalPlayer.Settings.CutsceneCamera.Value then
            for _, v in { { 154, 203 }, { 615, 672 } } do
                task.delay(v[1] / 60, function() -- Line: 361
                    -- upvalues: Attacker (copy), Victim (copy), v (copy)
                    local v65 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

                    if not v65 then
                        return;
                    end;

                    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                    ColorCorrectionEffect.Brightness = 0.05;
                    ColorCorrectionEffect.Saturation = 0.3;
                    ColorCorrectionEffect.Contrast = 0.3;
                    ColorCorrectionEffect.TintColor = Color3.fromRGB(229, 206, 255);
                    ColorCorrectionEffect.Parent = game.Lighting;
                    task.delay((v[2] - v[1]) / 60, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
                end);
            end;

            task.delay(10.25, function() -- Line: 375
                -- upvalues: Attacker (copy), Victim (copy), AssetHandler (ref), u15 (copy), HumanoidRootPart (copy), EffectsHandler (ref)
                local v66 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

                if not v66 then
                    return;
                end;

                local v67 = AssetHandler.CloneAsset("Particles/Fluorescence/Background", u15);
                v67.CFrame = HumanoidRootPart.CFrame;
                v67.Parent = workspace.Effects;

                for _, descendant in v67:GetDescendants() do
                    if descendant:IsA("Beam") or (descendant:IsA("PointLight") or descendant:IsA("ParticleEmitter")) then
                        descendant.Enabled = true;
                    end;
                end;

                EffectsHandler.CallEffect("FadeBeams", v67, {
                    FadeIn = true
                });
                task.delay(0.9333333333333333, v67.Destroy, v67);
            end);
        end;

        if Players.LocalPlayer.Settings.ImpactFrame.Value then
            task.delay(3.4833333333333334, function() -- Line: 397
                -- upvalues: Attacker (copy), Victim (copy)
                local v68 = Attacker and (Attacker:IsDescendantOf(game) and Victim) and Victim:IsDescendantOf(game);

                if not v68 then
                    return;
                end;

                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Brightness = -1;
                ColorCorrectionEffect.Parent = game.Lighting;
                local Highlight = Instance.new("Highlight");
                Highlight.OutlineTransparency = 1;
                Highlight.FillTransparency = -0.1;
                Highlight.FillColor = Color3.fromRGB(85, 14, 185);
                Highlight.Parent = Attacker;
                task.delay(0.255, function() -- Line: 414
                    -- upvalues: ColorCorrectionEffect (copy), Highlight (copy)
                    ColorCorrectionEffect:Destroy();
                    Highlight:Destroy();
                end);

                for i = 1, 3 do
                    task.delay(i * 0.085, function() -- Line: 421
                        -- upvalues: ColorCorrectionEffect (copy)
                        local v69 = ColorCorrectionEffect;
                        v69.Brightness = v69.Brightness * -1;
                    end);
                end;
            end);
            task.delay(7.7, function() -- Line: 427
                -- upvalues: Attacker (copy)
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
                ColorCorrectionEffect.Brightness = 0;
                ColorCorrectionEffect.Contrast = 10;
                ColorCorrectionEffect.Saturation = -1;
                ColorCorrectionEffect.Parent = game.Lighting;
                local Highlight = Instance.new("Highlight");
                Highlight.OutlineTransparency = 1;
                Highlight.FillTransparency = -0.1;
                Highlight.FillColor = Color3.fromRGB(85, 14, 185);
                Highlight.Parent = Attacker;
                task.delay(0.2, function() -- Line: 445
                    -- upvalues: ColorCorrectionEffect (copy), Highlight (copy)
                    ColorCorrectionEffect:Destroy();
                    Highlight:Destroy();
                end);

                for i = 1, 4 do
                    task.delay(i * 0.05, function() -- Line: 451
                        -- upvalues: i (copy), ColorCorrectionEffect (copy)
                        if i % 2 == 0 then
                            ColorCorrectionEffect.Contrast = 10;
                            ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);

                            return;
                        end;

                        ColorCorrectionEffect.Contrast = 0;
                        ColorCorrectionEffect.TintColor = Color3.fromRGB(0, 0, 0);
                    end);
                end;
            end);
        end;
    end;
end;