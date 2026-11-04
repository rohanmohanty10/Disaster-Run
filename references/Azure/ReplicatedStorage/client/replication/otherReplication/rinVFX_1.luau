 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local StarterGui = game:GetService("StarterGui");
local u1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local Brightness = Lighting.Brightness;
local ClockTime = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local ExposureCompensation = Lighting.ExposureCompensation;
local Threshold = Lighting.Bloom.Threshold;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
local MeshEmitter = require(script.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local Util = require(ReplicatedStorage.util.Util);
local trove = require(ReplicatedStorage.forum.trove);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(script.Parent.Parent.TekrinnDialogue);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);

function u1.characterImage(p2) -- Line: 52
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p2);
end;

Util.OnFoundInstance(ReplicatedStorage.Resources, "rin", function() -- Line: 55
    -- upvalues: ReplicatedStorage (copy), Util (copy)
    local ImpactFrameOvertime1 = ReplicatedStorage.Resources.rin:WaitForChild("ImpactFrameOvertime1", 5);

    if ImpactFrameOvertime1 then
        Util.Preload(ImpactFrameOvertime1, true);
    end;
end);
local u3 = { "Layer 1", "Layer 2", "Layer 3", "Layer 4", "Chase" };
local u4 = nil;

local function get_current_song_level(p5) -- Line: 73
    -- upvalues: u3 (copy)
    local v6 = p5 / 100;
    local v7 = 0;

    for i = 1, #u3 do
        local v8;

        if i / #u3 < v6 then
            v7 = v7 + 1;
            v8 = i;
        else
            v8 = i;
        end;
    end;

    return math.clamp(v7 + 1, 1, #u3);
end;

local function BeginLayers() -- Line: 86
    -- upvalues: u4 (ref), LocalPlayer (copy), vfxUtil (copy), u3 (copy), TweenService (copy), trove (copy), ReplicatedStorage (copy)
    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    local u9 = LocalPlayer and LocalPlayer.Character;

    if u9 then
        local rin2 = vfxUtil.getResources().rin2;
        local Attribute = u9:GetAttribute("RinRage");

        if rin2:FindFirstChild("DestroyerSongs") then
            local u10 = rin2:FindFirstChild("DestroyerSongs"):Clone();
            u10.Parent = workspace.Effects;
            local v11 = Attribute / 100;
            local v12 = 0;

            for i = 1, #u3 do
                local v13;

                if i / #u3 < v11 then
                    v12 = v12 + 1;
                    v13 = i;
                else
                    v13 = i;
                end;
            end;

            local math_clamp_ret = math.clamp(v12 + 1, 1, #u3);
            print(math_clamp_ret);
            local u14 = {};
            local u15 = nil;

            for _, child in u10:GetChildren() do
                child.Volume = 0;
                child:Play();

                if child.Name == u3[math_clamp_ret] then
                    local v16 = TweenService:Create(child, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                        Volume = 1
                    });
                    v16:Play();
                    table.insert(u14, v16);
                    u15 = child;
                end;
            end;

            u4 = trove.new();
            u4:AttachToInstance(u9);
            u4:Add(u9:GetAttributeChangedSignal("RinRage"):Connect(function() -- Line: 121
                -- upvalues: u9 (copy), math_clamp_ret (ref), u3 (ref), u14 (ref), u10 (copy), TweenService (ref), u15 (ref), u4 (ref)
                local Attribute2 = u9:GetAttribute("RinRage");

                if Attribute2 then
                    local v17 = Attribute2 / 100;
                    local v18 = 0;

                    for i = 1, #u3 do
                        local v19;

                        if i / #u3 < v17 then
                            v18 = v18 + 1;
                            v19 = i;
                        else
                            v19 = i;
                        end;
                    end;

                    if math_clamp_ret ~= math.clamp(v18 + 1, 1, #u3) then
                        for _, v in u14 do
                            v:Cancel();
                        end;

                        u14 = {};

                        for _, child in u10:GetChildren() do
                            local v20 = Attribute2 / 100;
                            local v21 = child;
                            local v22 = 0;

                            for i = 1, #u3 do
                                local v23;

                                if i / #u3 < v20 then
                                    v22 = v22 + 1;
                                    v23 = i;
                                else
                                    v23 = i;
                                end;
                            end;

                            if child.Name == u3[math.clamp(v22 + 1, 1, #u3)] then
                                local v24 = TweenService:Create(v21, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                                    Volume = 1
                                });
                                v24:Play();
                                local table_find_ret = table.find(u3, v21.Name);

                                if u15 then
                                    v21.TimePosition = u15.TimePosition + (table_find_ret > 3 and 0.1 or 0.005);
                                end;

                                table.insert(u14, v24);
                            end;

                            if v21.Name == u3[math_clamp_ret] then
                                local v25 = TweenService:Create(v21, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                                    Volume = 0
                                });
                                v25:Play();
                                table.insert(u14, v25);
                                u15 = v21;
                            end;
                        end;

                        local v26 = Attribute2 / 100;
                        local v27 = 0;

                        for i = 1, #u3 do
                            local v28;

                            if i / #u3 < v26 then
                                v27 = v27 + 1;
                                v28 = i;
                            else
                                v28 = i;
                            end;
                        end;

                        math_clamp_ret = math.clamp(v27 + 1, 1, #u3);
                        print(math_clamp_ret);
                    end;
                else
                    u4:Destroy();
                end;
            end));
            u4:Add((ReplicatedStorage.workspace.disabled.Changed:Connect(function(p29) -- Line: 156
                -- upvalues: u10 (copy)
                for _, child in u10:GetChildren() do
                    if p29 then
                        child:Pause();
                        print("pause");
                    else
                        child:Resume();
                        print("resume");
                    end;
                end;
            end)));
            u4:Add(function() -- Line: 171
                -- upvalues: u10 (copy), TweenService (ref), u14 (ref)
                for _, child in u10:GetChildren() do
                    TweenService:Create(child, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                        Volume = 0
                    }):Play();
                end;

                task.delay(1, game.Destroy, u10);

                for _, v in u14 do
                    v:Cancel();
                end;

                u14 = {};
            end);
        end;
    end;
end;

function u1.rinOvertime(u30) -- Line: 186
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), PlayerGui (copy), MeshEmitter (copy), Util (copy), workspace_CurrentCamera (copy), mainreplication (copy), LocalPlayer (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy), RunService (copy), TekrinnDialogue (copy), Brightness (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy), Density (copy), Color (copy)
    local v31 = u30.HumanoidRootPart or u30.PrimaryPart;
    u30:FindFirstChild("Ball");
    local _ = u30.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local u32 = ReplicatedStorage.Resources.vb:Clone();
    u32.Parent = PlayerGui;
    local u33 = ReplicatedStorage.Resources.glowscreen:Clone();
    u33.Parent = PlayerGui;
    u33.ImageLabel2.ImageTransparency = 0;
    u33.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 3;
    Lighting.ClockTime = 5;
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    local v34 = { MeshEmitter.StartMeshEmitter(v31, ReplicatedStorage.Resources.rin["crashout MeshEmitter"], nil).rinawkcc };

    for _, v in ipairs(v34) do
        if not Util.isepilepsysafe() then
            v.Parent = workspace_CurrentCamera;
        end;

        task.delay(30, function() -- Line: 213
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    local u35 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u35.Parent = Lighting;
    u35.FarIntensity = 1;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1, 1, true);
    local u36 = Util.Preload({
        ReplicatedStorage.Resources.rin.ImpactFrameOvertime1,
        ReplicatedStorage.Resources.rin.ImpactFrameOvertime2,
        ReplicatedStorage.Resources.rin.ImpactFrame,
        ReplicatedStorage.Resources.rin.ImpactFrameCrash
    });
    Util.EpilepsySafeGif(ReplicatedStorage.Resources.rin.ImpactFrameOvertime1, 30);
    local u37 = ReplicatedStorage.Resources.rin.overtimeVFX:Clone();
    u37:PivotTo(v31.CFrame);
    u37.Parent = u30;

    if Util.canshiftcolor(LocalPlayer, u30) then
        vfxUtil.LeanTowardsColor(u37, u30:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u30:GetAttribute("CustomAlpha") or 0.985);
    end;

    if u30:GetAttribute("RinNoPlay") then
        soundUtil:play(ReplicatedStorage.Resources.rin.rinawake_2, SoundService, {
            Character = u30
        });
    else
        soundUtil:play(ReplicatedStorage.Resources.rin.rinawake_1, SoundService, {
            Character = u30
        });
    end;

    mainreplication.cutsceneCamRigWithLetterBox(v31, ReplicatedStorage.Resources.rin.overtimeAwkCam, ReplicatedStorage.Resources.rin.overtimeFOV);
    local u38 = ReplicatedStorage.Resources.rin.overtimeCamEff:Clone();
    u38.Parent = u37;
    local u39 = nil;
    u39 = RunService.PreRender:connect(function() -- Line: 251
        -- upvalues: u38 (copy), u39 (ref)
        if u38:IsDescendantOf(game) then
            u38.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u39:Disconnect();
    end);
    local u40 = ReplicatedStorage.Resources.rin.overtimeEyeEffect:Clone();
    u40.Weld.Part0 = u30.Head;
    u40.Parent = u37;
    task.delay(8.233, function() -- Line: 260
        -- upvalues: TekrinnDialogue (ref), u30 (copy)
        TekrinnDialogue.Speak(u30, {
            {
                Text = "It makes me wanna puke.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 3);
    end);
    task.delay(16.833, function() -- Line: 286
        -- upvalues: u30 (copy), TekrinnDialogue (ref)
        if u30:GetAttribute("RinNoPlay") then
            TekrinnDialogue.Speak(u30, {
                {
                    Text = "I\'ll MANGO you!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 4
                    }
                }
            }, 3);

            return;
        end;

        TekrinnDialogue.Speak(u30, {
            {
                Text = "I\'ll mangle you!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 4
                }
            }
        }, 3);
    end);
    task.spawn(function() -- Line: 338
        -- upvalues: u38 (copy), u37 (copy)
        for _, descendant in pairs(u38.glitchwhiteparticles:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u37.rinawkdotsbackground2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u37.rinawkdotsbackground:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u38:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.016666666666666666, function() -- Line: 368
        -- upvalues: u40 (copy)
        for _, descendant in pairs(u40:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.03333333333333333, function() -- Line: 376
        -- upvalues: u40 (copy)
        for _, descendant in pairs(u40:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end);
    task.delay(0.05, function() -- Line: 384
        -- upvalues: u37 (copy)
        for _, descendant in pairs(u37.rinawknewlight:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.45, function() -- Line: 391
        -- upvalues: u38 (copy)
        for _, descendant in pairs(u38.glitchwhiteparticles:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(5.616666666666666, function() -- Line: 400
        -- upvalues: u40 (copy)
        for _, descendant in pairs(u40:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.383333333333334, function() -- Line: 407
        -- upvalues: u38 (copy)
        for _, descendant in pairs(u38.glitchwhiteparticles:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(23.316666666666666, function() -- Line: 416
        -- upvalues: u40 (copy)
        for _, descendant in pairs(u40:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.TextureSpeed = 0;
            end;
        end;

        for _, descendant in pairs(u40:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0;
            end;
        end;
    end);
    task.delay(23.783333333333335, function() -- Line: 429
        -- upvalues: u37 (copy)
        for _, descendant in pairs(u37.rinawknewlight:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(23.867, function() -- Line: 436
        -- upvalues: u40 (copy)
        for _, descendant in pairs(u40:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    local u41 = nil;
    task.delay(23.9, function() -- Line: 445
        -- upvalues: u41 (ref), ReplicatedStorage (ref), PlayerGui (ref), RunService (ref)
        u41 = ReplicatedStorage.Resources.rin.ImpactFrameOvertime2:Clone();
        u41.Enabled = true;
        u41.Parent = PlayerGui;
        u41.ScreenInsets = Enum.ScreenInsets.None;
        local u42 = #u41:GetChildren();
        local u43 = 0;
        local u44 = nil;

        for _, child in ipairs(u41:GetChildren()) do
            child.Visible = false;
        end;

        u44 = RunService.PreRender:Connect(function(p45) -- Line: 464, Name: UpdateWarper
            -- upvalues: u43 (ref), u42 (copy), u44 (ref), u41 (ref)
            u43 = u43 + p45;
            local v46 = u43 // 0.03333333333333333 + 1;

            if u42 < v46 then
                u44:Disconnect();

                return;
            end;

            if not u41:FindFirstChild(v46) then
                return;
            end;

            u41[v46].ZIndex = v46;
            u41[v46].Visible = true;
        end);
    end);
    task.delay(25.667, function() -- Line: 490
        -- upvalues: u36 (copy), u35 (copy), Lighting (ref), Brightness (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref), Atmosphere (copy), Density (ref), Color (ref), u32 (copy), u33 (copy), u37 (copy), u41 (ref), mainreplication (ref)
        u36:Destroy();
        u35:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u32:Destroy();
        u33:Destroy();
        u37:Destroy();

        if u41 then
            u41:Destroy();
        end;

        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(-1, 1.5);
    end);
end;

function u1.crashShotRin(u47, u48) -- Line: 529
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), PlayerGui (copy), mainreplication (copy), vfxUtil (copy), Util (copy), LocalPlayer (copy), soundUtil (copy), SoundService (copy), animationUtil (copy), RunService (copy), TekrinnDialogue (copy), TweenService (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), Density (copy), Color (copy)
    local v49 = u47.HumanoidRootPart or u47.PrimaryPart;
    local Ball = u47:FindFirstChild("Ball");
    local _ = u47.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local u50 = ReplicatedStorage.Resources.vb:Clone();
    u50.Parent = PlayerGui;
    local u51 = ReplicatedStorage.Resources.glowscreen:Clone();
    u51.Parent = PlayerGui;
    u51.ImageLabel2.ImageTransparency = 0;
    u51.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 2;
    Lighting.Ambient = Color3.fromRGB(189, 222, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 2.627;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.55;
    ColorCorrectionEffect.Saturation = -0.4;
    local u52 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u52.Parent = Lighting;
    u52.FarIntensity = 1;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1, 1, true);
    local u53 = ReplicatedStorage.Resources.rin.crashShotEffect:Clone();
    u53:PivotTo(v49.CFrame);
    u53.Parent = u47;
    vfxUtil.highlight(u53.shadow, {
        Name = "saehighlight1",
        Enabled = true,
        FillTransparency = 0.600000024,
        OutlineTransparency = 1,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        Adornee = u53.shadow,
        FillColor = Color3.new(0.011764707, 0, 0),
        OutlineColor = Color3.new(1, 1, 1)
    });

    if Util.canshiftcolor(LocalPlayer, u47) then
        vfxUtil.LeanTowardsColor(u53, u47:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u47:GetAttribute("CustomAlpha") or 0.985);
    end;

    local v54 = soundUtil:play(ReplicatedStorage.Resources.rin.no_voice_rin_3, SoundService, {
        Character = u47
    });
    animationUtil:loadAnimation(u53.shadow, ReplicatedStorage.Resources.rin.curveshotSae):Play(0);
    mainreplication.cutscene(v49, nil, 21.467, ReplicatedStorage.Resources.rin.crashShotFOV);
    local u55 = ReplicatedStorage.Resources.rin.crashShotCamEffect:Clone();
    u55.Parent = u53;
    local u56 = nil;
    u56 = RunService.PreRender:connect(function() -- Line: 590
        -- upvalues: u55 (copy), u56 (ref)
        if u55:IsDescendantOf(game) then
            u55.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u56:Disconnect();
    end);
    local u57 = ReplicatedStorage.Resources.rin.crashShotBall:Clone();
    u57.Weld.Part0 = Ball;
    u57.Parent = u53;

    for _, descendant in pairs(u53:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local u58 = Util.Preload(ReplicatedStorage.Resources.rin.ImpactFrameCrash);

    if v54.Name == "Dub" then
        task.delay(0.127, function() -- Line: 610
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "Screw the",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = " \"revenge\"",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(114, 255, 203)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                },
                {
                    Text = ".",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
        task.delay(2, function() -- Line: 679
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "Screw the",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = " \"rivals\"",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(114, 255, 203)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                },
                {
                    Text = ".",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
        task.delay(4.104, function() -- Line: 748
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "Screw the",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = " \"brothers\"",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(114, 255, 203)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                },
                {
                    Text = "...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
        task.delay(6.517, function() -- Line: 817
            -- upvalues: TekrinnDialogue (ref)
            TekrinnDialogue.Speak("???", {
                {
                    Text = "Lukewarm...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(39, 17, 29)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 4, "rbxassetid://73703021595801", Color3.fromRGB(34, 14, 33));
        end);
        task.delay(8.576, function() -- Line: 843
            -- upvalues: TekrinnDialogue (ref), u47 (copy), u48 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = `{u48.Name}?`,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 60, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 3);
        end);
        task.delay(10.185, function() -- Line: 869
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "It makes me wanna puke.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 3);
        end);
        task.delay(12.668, function() -- Line: 895
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "I\'ll mangle you!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(15.341, function() -- Line: 921
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "Destroy!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(16.481, function() -- Line: 947
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "Kill!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 1);
        end);
    else
        task.delay(0.167, function() -- Line: 973
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "Screw that",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = " \"revenge\"",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(114, 255, 203)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                },
                {
                    Text = ".",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
        task.delay(2.3, function() -- Line: 1042
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "Screw that",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = " \"rivals\"",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(114, 255, 203)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                },
                {
                    Text = ".",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
        task.delay(3.983, function() -- Line: 1111
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "Screw that",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = " \"brothers\"",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(114, 255, 203)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                },
                {
                    Text = ".",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 228)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
        task.delay(6.517, function() -- Line: 1180
            -- upvalues: TekrinnDialogue (ref)
            TekrinnDialogue.Speak("???", {
                {
                    Text = "Half Baked.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(39, 17, 29)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 4, "rbxassetid://73703021595801", Color3.fromRGB(34, 14, 33));
        end);
        task.delay(8.733, function() -- Line: 1206
            -- upvalues: TekrinnDialogue (ref), u47 (copy), u48 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = `{u48.Name}?`,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 60, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 3);
        end);
        task.delay(11.2, function() -- Line: 1232
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "It makes me wanna puke.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 3);
        end);
        task.delay(13.1, function() -- Line: 1258
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "I\'ll mangle you!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(15.433, function() -- Line: 1284
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "Kill!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(16.65, function() -- Line: 1310
            -- upvalues: TekrinnDialogue (ref), u47 (copy)
            TekrinnDialogue.Speak(u47, {
                {
                    Text = "Kill!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 1);
        end);
    end;

    task.spawn(function() -- Line: 1337
        -- upvalues: u53 (copy), u55 (copy)
        for _, descendant in pairs(u53.saeshadowvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u53.shadow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u53.saeshadowvfx:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u55.lineeffects1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u55.windeffectrincrash:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.05, function() -- Line: 1367
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.shadow.Head.eyesend1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u53.shadow.Head.eyesend2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.1, function() -- Line: 1381
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.saeshadowvfx.saeshadowsnow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(0.5, function() -- Line: 1389
        -- upvalues: u53 (copy)
        local saehighlight1 = u53.shadow:FindFirstChild("saehighlight1");

        if saehighlight1 and saehighlight1:IsA("Highlight") then
            saehighlight1.Adornee = u53.shadow;
            saehighlight1.Enabled = true;
        end;
    end);
    task.delay(0.833, function() -- Line: 1396
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            Brightness = -1
        }):Play();
    end);
    task.delay(1.25, function() -- Line: 1399
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.saeshadowvfx.saeshadowsnow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.45;
            end;
        end;
    end);
    task.delay(1.2666666666666666, function() -- Line: 1407
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.glitchparticles2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u55.glitchparticles:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.3, function() -- Line: 1421
        -- upvalues: u53 (copy), TweenService (ref), ColorCorrectionEffect (copy)
        u53.rincrashshotdomain.Transparency = 0;
        local v59 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            Brightness = -0.15
        });
        v59:Play();
        v59.Completed:Wait();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 154, 154);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.85, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(1.35, function() -- Line: 1432
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.saeshadowspawnemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.45, function() -- Line: 1440
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.lineeffects1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u55.windeffectrincrash:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(1.8333333333333333, function() -- Line: 1453
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.glitchparticles2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u55.glitchparticles:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2.65, function() -- Line: 1467
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.167, function() -- Line: 1475
        -- upvalues: u55 (copy), TweenService (ref), ColorCorrectionEffect (copy)
        for _, descendant in pairs(u55:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v60 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.233, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 82, 82)
        });
        v60:Play();
        v60.Completed:Wait();
        ColorCorrectionEffect.Saturation = -1;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        task.wait(0.016);
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 82, 82);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.134, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(4.417, function() -- Line: 1495
        -- upvalues: u53 (copy)
        u53.rincrashshotdomain.Transparency = 1;
    end);
    task.delay(4.7, function() -- Line: 1498
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.saeshadowvfx.saeshadowsnow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(5.583333333333333, function() -- Line: 1506
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.saeshadowvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u53.saeshadowvfx:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(5.966666666666667, function() -- Line: 1519
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.lineeffects1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(5.983333333333333, function() -- Line: 1527
        -- upvalues: u53 (copy)
        local saehighlight1 = u53.shadow:FindFirstChild("saehighlight1");

        if saehighlight1 and saehighlight1:IsA("Highlight") then
            saehighlight1.Adornee = u53.shadow;
            saehighlight1.Enabled = false;
        end;
    end);
    task.delay(6, function() -- Line: 1534
        -- upvalues: u53 (copy)
        local saehighlight2 = u53.shadow:FindFirstChild("saehighlight2");

        if saehighlight2 and saehighlight2:IsA("Highlight") then
            saehighlight2.Adornee = u53.shadow;
            saehighlight2.Enabled = true;
        end;
    end);
    task.delay(6.0167, function() -- Line: 1541
        -- upvalues: u55 (copy), u53 (copy), ColorCorrectionEffect (copy)
        for _, descendant in pairs(u55.windeffectrincrash:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u53.rincrashshotdomain.Transparency = 0;
        ColorCorrectionEffect.Saturation = -0.4;
    end);
    task.delay(6.057, function() -- Line: 1551
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect.Brightness = -0.15;
    end);
    task.delay(6.15, function() -- Line: 1554
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.saeshadowhead:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u53.shadow.Head.eyesend1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u53.shadow.Head.eyesend2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.283333333333333, function() -- Line: 1574
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.saeshadowhead:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(7.616666666666666, function() -- Line: 1582
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.saeshadowvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u53.shadow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u53.saeshadowvfx:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(7.633, function() -- Line: 1601
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        local v61 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.084, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(143, 175, 255)
        });
        v61:Play();
        v61.Completed:Wait();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(8.117, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(7.666666666666667, function() -- Line: 1608
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.saeshadowremovedemitstart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(7.683333333333334, function() -- Line: 1616
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.windeffectrincrash:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(7.75, function() -- Line: 1623
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.isagimetavisionspecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.1, function() -- Line: 1631
        -- upvalues: u57 (copy)
        for _, descendant in pairs(u57.rincrashshotflare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.116666666666667, function() -- Line: 1639
        -- upvalues: u53 (copy), TweenService (ref)
        local shadow = u53.shadow;

        local function tweenTransparency(p62, p63) -- Line: 1643
            -- upvalues: TweenService (ref)
            TweenService:Create(p62, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = p63
            }):Play();
        end;

        if shadow then
            for _, descendant in pairs(shadow:GetDescendants()) do
                if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
                    tweenTransparency(descendant, 1);
                elseif descendant:IsA("Decal") and descendant.Face == Enum.NormalId.Front then
                    tweenTransparency(descendant, 1);
                end;
            end;
        end;
    end);
    task.delay(8.466666666666667, function() -- Line: 1659
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.isagimetavision:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u53.isagimetavision:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.483333333333333, function() -- Line: 1672
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.saeshadowremovedemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.5, function() -- Line: 1680
        -- upvalues: u53 (copy)
        local saehighlight2 = u53.shadow:FindFirstChild("saehighlight2");

        if saehighlight2 and saehighlight2:IsA("Highlight") then
            saehighlight2.Adornee = workspace.shadow;
            saehighlight2.Enabled = false;
        end;
    end);
    task.delay(8.55, function() -- Line: 1687
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.Brightness = 2;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(8.516666666666667, function() -- Line: 1692
        -- upvalues: u53 (copy)
        local saehighlight1 = u53.shadow:FindFirstChild("saehighlight1");

        if saehighlight1 and saehighlight1:IsA("Highlight") then
            saehighlight1.Adornee = u53.shadow;
            saehighlight1.Enabled = true;
        end;

        for _, descendant in pairs(u53.isagistartbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.533333333333333, function() -- Line: 1704
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.lineeffects1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(8.55, function() -- Line: 1712
        -- upvalues: u55 (copy), u53 (copy)
        for _, descendant in pairs(u55.lineeffects2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        u53.rincrashshotdomain.Transparency = 1;

        for _, descendant in pairs(u53.isagimetavision.isagimetavisiontunnel:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Transparency = 0;
            end;
        end;
    end);
    task.delay(8.566666666666666, function() -- Line: 1728
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.windeffectrincrash:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.75, function() -- Line: 1735
        -- upvalues: u53 (copy)
        u53.isagimetavisionspecs:Destroy();
    end);
    task.delay(11.05, function() -- Line: 1738
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        local v64 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Brightness = 2
        });
        v64:Play();
        v64.Completed:Wait();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(11.566666666666666, function() -- Line: 1745
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.isagimetavision:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(11.95, function() -- Line: 1753
        -- upvalues: u53 (copy)
        local saehighlight1 = u53.shadow:FindFirstChild("saehighlight1");

        if saehighlight1 and saehighlight1:IsA("Highlight") then
            saehighlight1.Adornee = u53.shadow;
            saehighlight1.Enabled = false;
        end;

        for _, descendant in pairs(u53.isagistartbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u53.isagimetavision:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(11.966666666666667, function() -- Line: 1770
        -- upvalues: u53 (copy), TweenService (ref)
        local shadow = u53.shadow;

        local function v67(p65, p66) -- Line: 1774
            -- upvalues: TweenService (ref)
            TweenService:Create(p65, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = p66
            }):Play();
        end;

        if shadow then
            for _, descendant in pairs(shadow:GetDescendants()) do
                if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
                    v67(descendant, 0);
                elseif descendant:IsA("Decal") and descendant.Face == Enum.NormalId.Front then
                    v67(descendant, 0);
                end;
            end;
        end;
    end);
    task.delay(11.983333333333333, function() -- Line: 1790
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.lineeffects1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(12, function() -- Line: 1798
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.lineeffects2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(12.05, function() -- Line: 1806
        -- upvalues: u53 (copy)
        u53.isagimetavision:Destroy();
    end);
    task.delay(12.083333333333334, function() -- Line: 1809
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashshotstomp3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(12.117, function() -- Line: 1817
        -- upvalues: u53 (copy)
        u53.rincrashshotdomain.Transparency = 0;
    end);
    task.delay(12.2, function() -- Line: 1820
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashshotstomp1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(12.233333333333333, function() -- Line: 1828
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.isagirincrashshotstomp1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(12.3, function() -- Line: 1836
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.isagirincrashshotstomp2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(12.45, function() -- Line: 1844
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashshotstomp2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(12.533333333333333, function() -- Line: 1852
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.isagirincrashshotstomp3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(12.7, function() -- Line: 1860
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        local v68 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.683, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(114, 255, 218)
        });
        v68:Play();
        v68.Completed:Wait();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(13.6, function() -- Line: 1867
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashstartcurveshotemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(13.8, function() -- Line: 1875
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashcurveshotbeamstayimpact:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(13.867, function() -- Line: 1882
        -- upvalues: u55 (copy), u53 (copy)
        for _, descendant in pairs(u55.windeffectrincrash:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        u53.rincrashshotdomain.Transparency = 1;
    end);
    task.delay(13.883333333333333, function() -- Line: 1890
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.lineeffects1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(13.9, function() -- Line: 1898
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.lineeffects1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(13.916666666666666, function() -- Line: 1906
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.windeffectrincrash:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(13.983333333333333, function() -- Line: 1913
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashcurveshotemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(14.116666666666667, function() -- Line: 1921
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashcurveshotemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end);
    task.delay(16.666666666666668, function() -- Line: 1929
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashcurveshotemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(16.833333333333332, function() -- Line: 1937
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashcurveshotbeamstayimpact:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(17.1, function() -- Line: 1944
        -- upvalues: u55 (copy), TweenService (ref), ColorCorrectionEffect (copy)
        for _, descendant in pairs(u55.lineeffects1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.117, Enum.EasingStyle.Linear), {
            Saturation = -1,
            Contrast = -2
        }):Play();
    end);
    task.delay(17.116666666666667, function() -- Line: 1953
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.windeffectrincrash:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(17.133333333333333, function() -- Line: 1960
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.lineeffects2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(17.2, function() -- Line: 1968
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.rin.ImpactFrameCrash, 20);
    end);
    task.delay(18.137, function() -- Line: 1971
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        for i = 1, 27 do
            if ColorCorrectionEffect.Contrast == -5 and math.random(1, 3) == 1 then
                ColorCorrectionEffect.Contrast = 5;
            else
                ColorCorrectionEffect.Contrast = -5;
            end;

            task.wait(0.016);
            local _ = i;
        end;

        ColorCorrectionEffect.Contrast = 0.4;
        ColorCorrectionEffect.Saturation = -0.4;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(201, 255, 241);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(18.483333333333334, function() -- Line: 1988
        -- upvalues: u55 (copy), u53 (copy)
        for _, descendant in pairs(u55.lineeffects2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u53.rinendcrashsotenabledball:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(18.516666666666666, function() -- Line: 2002
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.lineeffects1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(18.533333333333335, function() -- Line: 2010
        -- upvalues: u55 (copy)
        for _, descendant in pairs(u55.windeffectrincrash:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(18.7, function() -- Line: 2017
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rinendcrashshotemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(18.716666666666665, function() -- Line: 2025
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashshotballendtrail:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(18.733333333333334, function() -- Line: 2032
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashshotfullimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(18.833333333333332, function() -- Line: 2040
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rinendcrashshotemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end);
    task.delay(21.4, function() -- Line: 2048
        -- upvalues: u57 (copy)
        for _, descendant in pairs(u57.rincrashshotflare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(21.416666666666668, function() -- Line: 2056
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rincrashshotballendtrail:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u53.rinendcrashsotenabledball:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(21.433333333333334, function() -- Line: 2069
        -- upvalues: u53 (copy)
        for _, descendant in pairs(u53.rinendcrashshotemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(21.467, function() -- Line: 2077
        -- upvalues: u58 (copy), u52 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Atmosphere (copy), Density (ref), Color (ref), u50 (copy), u51 (copy), ColorCorrectionEffect (copy), u53 (copy), mainreplication (ref)
        u58:Destroy();
        u52:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u50:Destroy();
        u51:Destroy();

        if ColorCorrectionEffect then
            ColorCorrectionEffect:Destroy();
        end;

        u53:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1, true);
    end);
end;

function u1.rinobliteratestartup(u69, p70) -- Line: 2114
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), KatUtil (copy), Players (copy), mainreplication (copy), u1 (copy), Lighting (copy), TweenService (copy), RunService (copy)
    local Ball = u69:FindFirstChild("Ball");
    local u71 = u69.HumanoidRootPart or u69.PrimaryPart;
    local u72 = {};

    for _, descendant in ipairs(u69:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v73 = descendant;

            for _, child in ipairs(ReplicatedStorage.Resources.rin.rinaura:GetChildren()) do
                local v74 = child:Clone();
                v74.Parent = v73;

                if Util.canshiftcolor(LocalPlayer, u69) then
                    vfxUtil.LeanTowardsColor(v74, u69:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u69:GetAttribute("CustomAlpha") or 0.985);
                end;

                table.insert(u72, v74);
            end;
        end;
    end;

    task.delay(0.18333333333333332, function() -- Line: 2134
        -- upvalues: ReplicatedStorage (ref), u69 (copy), Util (ref), LocalPlayer (ref), vfxUtil (ref), KatUtil (ref), u71 (copy), Ball (copy), u72 (copy), Players (ref), mainreplication (ref)
        local v75 = ReplicatedStorage.Resources.rin.smoke:Clone();
        v75.Parent = u69.Ball;

        if Util.canshiftcolor(LocalPlayer, u69) then
            vfxUtil.LeanTowardsColor(v75, u69:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u69:GetAttribute("CustomAlpha") or 0.985);
        end;

        KatUtil.forge_emit(v75);
        vfxUtil.disposal(v75, 3);
        local v76 = ReplicatedStorage.Resources.rin.ObliterateVFX:Clone();
        v76.Weld.Part0 = u71;
        v76.Parent = u69;

        if Util.canshiftcolor(LocalPlayer, u69) then
            vfxUtil.LeanTowardsColor(v76, u69:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u69:GetAttribute("CustomAlpha") or 0.985);
        end;

        KatUtil.forge_emit(v76["Cold spark clash"]);
        KatUtil.forge_emit(v76.Slam9);
        vfxUtil.disposal(v76, 5);

        if not Ball then
            return;
        end;

        for _, child in ipairs(ReplicatedStorage.Resources.rin.rinaura:GetChildren()) do
            local v77 = child:Clone();
            v77.Parent = Ball;

            if Util.canshiftcolor(LocalPlayer, u69) then
                vfxUtil.LeanTowardsColor(v77, u69:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u69:GetAttribute("CustomAlpha") or 0.985);
            end;

            table.insert(u72, v77);
        end;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u69) then
            mainreplication.cameraShake(15, 0.5, 4);
        end;
    end);
    task.delay(0.7333333333333333, function() -- Line: 2180
        -- upvalues: u69 (copy), KatUtil (ref), u72 (copy), u1 (ref), Players (ref), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), mainreplication (ref), u71 (copy), RunService (ref)
        local ObliterateVFX = u69.ObliterateVFX;
        KatUtil.forge_emit(ObliterateVFX.Bigahh);
        KatUtil.forge_emit(ObliterateVFX.Run);
        KatUtil.forge_emit(ObliterateVFX["air meshg fr"]);

        for _, v in u72 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;

        u1.characterImage({
            Speed = 0.3,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            ImageTransparency = 0.65,
            Count = 16,
            Whitelist = { u69 },
            Color = Color3.fromRGB(71, 218, 118),
            Color2 = Color3.fromRGB(0, 0, 0)
        });

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u69) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 15;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v78 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v78.Parent = Lighting;
            v78.TintColor = Color3.fromRGB(92, 255, 220);
            v78.Brightness = 0.4;
            v78.Contrast = 1;
            v78.Saturation = -0.4;
            TweenService:Create(v78, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v78, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v78.Destroy, v78);
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(10, 1.5, 6);
            u71.CFrame:VectorToObjectSpace(u69.Humanoid.MoveDirection);
            local u79, u80 = mainreplication.bodyVelocity(u71, 120, 0.55, nil, nil, true);
            local u81 = nil;
            u81 = RunService.RenderStepped:Connect(function(p82) -- Line: 2251
                -- upvalues: u79 (copy), u81 (ref), u71 (ref), u80 (copy)
                if u79 and u79:IsDescendantOf(game) then
                    u79.Velocity = u71.CFrame.LookVector * u80.Value;

                    return;
                end;

                u81:Disconnect();
            end);
            task.delay(15, u81.Disconnect, u81);
        end;
    end);
end;

function u1.rinobliterate(u83, p84) -- Line: 2265
    -- upvalues: KatUtil (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Players (copy), mainreplication (copy), Lighting (copy), TweenService (copy)
    local Ball = u83:FindFirstChild("Ball");
    local u85 = u83.HumanoidRootPart or u83.PrimaryPart;
    local u86 = {};
    KatUtil.destroy_all_velocities(u83);
    task.delay(0.11666666666666667, function() -- Line: 2272
        -- upvalues: ReplicatedStorage (ref), u85 (copy), u83 (copy), Util (ref), LocalPlayer (ref), vfxUtil (ref), KatUtil (ref), Ball (copy), Players (ref), mainreplication (ref)
        local v87 = ReplicatedStorage.Resources.rin.ObliterateLandVFX:Clone();
        v87.Weld.Part0 = u85;
        v87.Parent = u83;

        if Util.canshiftcolor(LocalPlayer, u83) then
            vfxUtil.LeanTowardsColor(v87, u83:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u83:GetAttribute("CustomAlpha") or 0.985);
        end;

        KatUtil.forge_emit(v87.Attachment);
        KatUtil.forge_emit(v87.Dash);
        vfxUtil.disposal(v87, 5);

        if not Ball then
            return;
        end;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u83) then
            mainreplication.cameraShake(15, 1.5, 6);
            mainreplication.fov(true, 60, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        end;
    end);
    task.delay(0.5333333333333333, function() -- Line: 2295
        -- upvalues: ReplicatedStorage (ref), u83 (copy), Util (ref), LocalPlayer (ref), vfxUtil (ref), KatUtil (ref), u86 (copy), Players (ref), Lighting (ref), TweenService (ref)
        local v88 = ReplicatedStorage.Resources.rin.obliteratekick:Clone();
        v88.Parent = u83.Ball;

        if Util.canshiftcolor(LocalPlayer, u83) then
            vfxUtil.LeanTowardsColor(v88, u83:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u83:GetAttribute("CustomAlpha") or 0.985);
        end;

        KatUtil.forge_emit(v88);
        vfxUtil.disposal(v88, 3);
        KatUtil.forge_emit(u83.ObliterateVFX["air meshg fr"]);

        for _, v in u86 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u83) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 5;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        end;
    end);
end;

function u1.rinobliterateshot(p89, p90) -- Line: 2329
    -- upvalues: KatUtil (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy)
    local Ball = p89:FindFirstChild("Ball");
    local v91 = p89.HumanoidRootPart or p89.PrimaryPart;
    KatUtil.destroy_all_velocities(p89);
    local v92 = ReplicatedStorage.Resources.rin.obliteratekick:Clone();
    v92.Parent = Ball;

    if Util.canshiftcolor(LocalPlayer, p89) then
        vfxUtil.LeanTowardsColor(v92, p89:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p89:GetAttribute("CustomAlpha") or 0.985);
    end;

    KatUtil.forge_emit(v92);
    vfxUtil.disposal(v92, 3);
    local v93 = ReplicatedStorage.Resources.rin.ObliterateLandVFX:Clone();
    v93.Weld.Part0 = v91;
    v93.Parent = p89;

    if Util.canshiftcolor(LocalPlayer, p89) then
        vfxUtil.LeanTowardsColor(v93, p89:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p89:GetAttribute("CustomAlpha") or 0.985);
    end;

    vfxUtil.disposal(v93, 5);
    KatUtil.forge_emit(v93["air meshg fr"]);
end;

function u1.rincurveshotkill(u94) -- Line: 2360
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), RunService (copy), workspace_CurrentCamera (copy), TekrinnDialogue (copy)
    local v95 = u94.HumanoidRootPart or u94.PrimaryPart;
    local Ball = u94:FindFirstChild("Ball");
    local _ = u94.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local v96 = not (shared.allvfxcheck and shared.allvfxcheck());
    local u97 = ReplicatedStorage.Resources.rin.killvfx:Clone();
    u97:PivotTo(v95.CFrame);
    local v98;

    if v96 then
        v98 = u94;
    else
        v98 = workspace.Effects or u94;
    end;

    u97.Parent = v98;

    if Util.canshiftcolor(LocalPlayer, u94) then
        vfxUtil.LeanTowardsColor(u97, u94:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u94:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u97:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local v99 = Util.Preload(ReplicatedStorage.Resources.rin.ImpactFrame);
    local u100 = ReplicatedStorage.Resources.Blur:Clone();
    u100.Size = 0;
    u100.Parent = Lighting;
    local u101 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    TweenService:Create(u101, TweenInfo.new(0.417, Enum.EasingStyle.Linear), {
        Brightness = 0,
        Contrast = 0.3,
        Saturation = -0.2,
        TintColor = Color3.fromRGB(207, 218, 255)
    }):Play();

    if not Util.isepilepsysafe() then
        u101.Parent = Lighting;
    end;

    local v102 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v102.Parent = Lighting;
    v102.FarIntensity = 0;
    TweenService:Create(v102, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local v103 = soundUtil:play(ReplicatedStorage.Resources.rin["rin ult curveshot_1 (1)"], SoundService, {
        Character = u94
    });
    mainreplication.cutsceneBlender(v95, ReplicatedStorage.Resources.rin.killCam, ReplicatedStorage.Resources.rin.killFOV);
    local u104 = ReplicatedStorage.Resources.rin.CamPart2:Clone();
    u104.Parent = u97;
    local u105 = nil;
    u105 = RunService.PreRender:connect(function() -- Line: 2416
        -- upvalues: u104 (copy), u105 (ref), workspace_CurrentCamera (ref)
        if not u104:IsDescendantOf(game) then
            u105:Disconnect();
        end;

        u104.CFrame = workspace_CurrentCamera.CFrame;
    end);
    local u106 = v103.Name == "Dub";
    task.delay(u106 and 0.84 or 0.95, function() -- Line: 2429
        -- upvalues: TekrinnDialogue (ref), u94 (copy), u106 (copy)
        TekrinnDialogue.Speak(u94, {
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Text = u106 and "Die." or "Kill.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 7,
                    Lifetime = 1
                }
            }
        }, 1);
    end);
    local u107 = {};
    task.delay(0.15, function() -- Line: 2457
        -- upvalues: u100 (copy), u101 (copy), TweenService (ref)
        u100.Size = 26;
        u101.Brightness = 1;
        u101.Saturation = -0.55;
        task.wait(0.017);
        u101.Contrast = -5;
        u101.Saturation = -1;
        u100.Size = 56;
        TweenService:Create(u100, TweenInfo.new(0.433, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        TweenService:Create(u101, TweenInfo.new(0.133, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 0.2,
            Saturation = -0.1
        }):Play();
    end);
    task.delay(0.183, function() -- Line: 2473
        -- upvalues: u97 (copy), u94 (copy), ReplicatedStorage (ref), u107 (copy)
        for _, descendant in pairs(u97.awkrinfootsteppart1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u97.awkringrassstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u97.rinawkbg:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, child in ipairs(u94:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v108 = child;

                for _, child2 in ipairs(ReplicatedStorage.Resources.rin.ultaura:GetChildren()) do
                    local v109 = child2:Clone();
                    v109.Parent = v108;
                    table.insert(u107, v109);
                end;
            end;
        end;
    end);
    task.delay(0.583, function() -- Line: 2512
        -- upvalues: u97 (copy), u104 (copy)
        for _, descendant in pairs(u97.awkrinfootsteppart1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u104.rinawkcurveshot:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    local u110 = nil;
    task.delay(0.8, function() -- Line: 2530
        -- upvalues: u100 (copy), u101 (copy), TweenService (ref)
        u100.Size = 26;
        u101.Brightness = 0;
        u101.Contrast = 0.2;
        u101.Saturation = -0.55;
        u101.TintColor = Color3.fromRGB(28, 113, 71);
        task.wait(0.017);
        u101.TintColor = Color3.fromRGB(143, 255, 195);
        u101.Contrast = -2;
        u101.Saturation = -1;
        u100.Size = 56;
        TweenService:Create(u100, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        local v111 = TweenService:Create(u101, TweenInfo.new(0.9, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 1,
            Saturation = -1,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        v111:Play();
        v111.Completed:Wait();
        v111:Destroy();
        local v112 = TweenService:Create(u101, TweenInfo.new(0.416, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 0.2,
            Saturation = -0.1,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        v112:Play();
        v112.Completed:Wait();
        v112:Destroy();
        TweenService:Create(u101, TweenInfo.new(0.416, Enum.EasingStyle.Linear), {
            Brightness = -0.1,
            Contrast = 1,
            Saturation = -0.5,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(0.817, function() -- Line: 2561
        -- upvalues: u110 (ref), ReplicatedStorage (ref), u94 (copy), u97 (copy), u107 (copy), u104 (copy)
        u110 = ReplicatedStorage.Resources.rin.eye:Clone();
        u110.Weld.Part0 = u94.Head;
        u110.Parent = u97;

        for _, v in u107 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u104.rinawkcurveshot:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    local u113 = nil;
    task.delay(1.717, function() -- Line: 2582
        -- upvalues: u107 (copy), u97 (copy), Ball (copy), u113 (ref), ReplicatedStorage (ref)
        for _, v in u107 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u97.rinflashstepscurveshotawk:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u97.rincurveawkstars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        if Ball then
            u113 = ReplicatedStorage.Resources.rin.balleffect:Clone();
            u113.Weld.Part0 = Ball;
            u113.Parent = u97;
        end;
    end);
    task.delay(1.833, function() -- Line: 2613
        -- upvalues: u97 (copy)
        for _, descendant in pairs(u97.awkrinfootsteppart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u97.capart2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.9, function() -- Line: 2628
        -- upvalues: u104 (copy), u97 (copy)
        for _, descendant in pairs(u104.camerafierce:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u97.rincurvelegawkstars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.45, function() -- Line: 2644
        -- upvalues: u97 (copy)
        for _, descendant in pairs(u97.rincurvelegawkstars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.567, function() -- Line: 2653
        -- upvalues: u97 (copy)
        for _, descendant in pairs(u97.capartXD:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.617, function() -- Line: 2662
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.rin.ImpactFrame, 30);
    end);
    task.delay(3.867, function() -- Line: 2666
        -- upvalues: u104 (copy)
        for _, descendant in pairs(u104.camerafierce:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.867, function() -- Line: 2675
        -- upvalues: u104 (copy)
        for _, descendant in pairs(u104.camerafierce:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.967, function() -- Line: 2684
        -- upvalues: u97 (copy)
        for _, descendant in pairs(u97.rinawkballflahssteps:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.983, function() -- Line: 2693
        -- upvalues: u97 (copy), u101 (copy)
        for _, descendant in pairs(u97.rinawkballflahssteps:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        u101.Saturation = -1;

        for i = 1, 18 do
            u101.Contrast = u101.Contrast == 15 and -15 or 15;
            task.wait(0.017);
            local _ = i;
        end;

        u101.Contrast = 0.2;
        u101.Saturation = -0.1;
    end);
    task.delay(4.033, function() -- Line: 2712
        -- upvalues: u97 (copy)
        for _, descendant in pairs(u97.rinawkcurveshotemitpartthing:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.083, function() -- Line: 2721
        -- upvalues: u97 (copy)
        for _, descendant in pairs(u97.rinawkbg:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u97.awkrinfootsteppart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.7, function() -- Line: 2735
        -- upvalues: u101 (copy), u113 (ref)
        task.spawn(function() -- Line: 2736
            -- upvalues: u101 (ref)
            u101.Saturation = -1;

            for i = 1, 7 do
                u101.Contrast = u101.Contrast == 15 and -15 or 15;
                task.wait(0.017);
                local _ = i;
            end;

            u101.Contrast = 0.2;
            u101.Saturation = -0.1;
        end);

        if not u113 then
            return;
        end;

        for _, descendant in pairs(u113:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.767, function() -- Line: 2760
        -- upvalues: u97 (copy)
        for _, descendant in pairs(u97.rinawkballflahssteps:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.85, function() -- Line: 2769
        -- upvalues: u113 (ref), u97 (copy), u107 (copy)
        for _, descendant in pairs(u113:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u97.rinawkcurveshotendemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, v in u107 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
                task.delay(3, v.Destroy, v);
            end;
        end;
    end);
    task.delay(4.967, function() -- Line: 2791
        -- upvalues: u97 (copy)
        for _, descendant in pairs(u97.rinflashstepscurveshotawk:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u97.rincurveawkstars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.wait(6.133);
    v99:Destroy();

    if u104 then
        u104:Destroy();
    end;

    u100:Destroy();
    u97:Destroy();
    u101:Destroy();
    v102:Destroy();
    mainreplication.sceneEnabled(false);
    mainreplication.ultFlash(nil, 1.5);
    mainreplication.fov(false, 15);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.rinshootcurve(p114) -- Line: 2828
    -- upvalues: Lighting (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), PlayerGui (copy), Debris (copy), TweenService (copy)
    local u115 = p114.HumanoidRootPart or p114.PrimaryPart;
    p114:FindFirstChild("Ball");
    local _ = p114.Torso;
    local _ = Lighting.Atmosphere;
    soundUtil:play(ReplicatedStorage.Resources.rin.curvershoot, SoundService);
    mainreplication.sceneEnabled(true);
    local v116 = ReplicatedStorage.Resources.rin.rincurveAllEffect:Clone();
    v116:PivotTo(u115.CFrame);
    v116.Parent = p114;

    if Util.canshiftcolor(LocalPlayer, p114) then
        vfxUtil.LeanTowardsColor(v116, p114:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p114:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u117 = ReplicatedStorage.Resources.rin.Vignette:Clone();
    u117.Parent = PlayerGui;
    u117.Vignette.ImageTransparency = 1;
    local u118 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    u118.Saturation = -0.325;
    u118.Contrast = 0.2;
    u118.Brightness = 0;
    u118.TintColor = Color3.fromRGB(0, 85, 127);
    u118.Enabled = false;
    u118.Parent = Lighting;
    local u119, u120 = mainreplication.cutsceneCamRigWithLetterBox(u115, ReplicatedStorage.Resources.rin.RinShootingCamera, ReplicatedStorage.Resources.rin.RinShootingFOV, nil, CFrame.new(0, -3, -1) * CFrame.Angles(0, -3.141592653589793, 0));
    task.spawn(function() -- Line: 2861
        -- upvalues: ReplicatedStorage (ref), u119 (copy), Debris (ref)
        local v121 = ReplicatedStorage.Resources.mvpAssets.SaeGlory.CameraEffects:Clone();
        v121.Parent = u119;
        v121.Join.Part0 = u119.camera;
        Debris:AddItem(v121, 13);
    end);
    task.delay(13, function() -- Line: 2868
        -- upvalues: u119 (copy), u120 (copy), u118 (copy), u117 (copy), mainreplication (ref)
        if u119 then
            u120();
        end;

        u118:Destroy();
        u117:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(nil, 1.5);
        mainreplication.fov(false, 15);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
    task.delay(0.3333333333333333, function() -- Line: 2883
        -- upvalues: u118 (copy), u117 (copy), TweenService (ref), mainreplication (ref), u119 (copy), ReplicatedStorage (ref)
        u118.Enabled = true;
        u117.Vignette.ImageTransparency = 0.7;
        TweenService:Create(u117.Vignette, TweenInfo.new(53), {
            ImageTransparency = 0.5
        }):Play();
        mainreplication.EmitAttachmentIn({
            Parent = u119.camera,
            Effect = ReplicatedStorage.Resources.rin.EyeFlash1,
            Offset = CFrame.new(
                0.137444377,
                -0.0527880192,
                -1.12808061,
                0.999998868,
                4.14147756e-8,
                -1.0604915e-7,
                -2.65135967e-8,
                0.999996305,
                -2.84862665e-7,
                1.06049143e-7,
                2.84861727e-7,
                0.999998868
            )
        });
    end);
    task.delay(9.266666666666667, function() -- Line: 2898
        -- upvalues: u118 (copy), mainreplication (ref), u119 (copy), ReplicatedStorage (ref)
        u118.Enabled = false;
        mainreplication.EmitAttachmentIn({
            Parent = u119.camera,
            Effect = ReplicatedStorage.Resources.rin.EyeFlash2,
            Offset = CFrame.new(
                0.140872478,
                -0.0618712902,
                -1.12809038,
                0.999998868,
                2.32830644e-8,
                -9.85985551e-8,
                -8.38192715e-9,
                0.999996305,
                -2.84862665e-7,
                9.8598548e-8,
                2.84861727e-7,
                0.999998868
            )
        });
    end);
    task.delay(10.116666666666667, function() -- Line: 2908
        -- upvalues: mainreplication (ref), u115 (copy), ReplicatedStorage (ref)
        mainreplication.EmitAttachmentIn({
            Parent = u115,
            Effect = ReplicatedStorage.Resources.rin.Balltap,
            Offset = CFrame.new(0.150000006, -1.15046751, 3.30000019, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        });
        mainreplication.EmitAttachmentIn({
            Parent = u115,
            Effect = ReplicatedStorage.Resources.rin.JumpEmit,
            Offset = CFrame.new(0.054995656, -2.95909333, 8.62339592, -1, 0, -8.74227766e-8, 0, 1, 0, 8.74227766e-8, 0, -1)
        });
        mainreplication.EmitAttachmentIn({
            Parent = u115,
            Effect = ReplicatedStorage.Resources.rin.ShotTest,
            Offset = CFrame.new(
                -0.684117913,
                -0.942655325,
                4.85366631,
                0.861281276,
                0.494577169,
                0.116568215,
                0.104528472,
                0.0520492233,
                -0.993158996,
                -0.497261047,
                0.867573857,
                -0.00686837686
            )
        });
    end);
    task.delay(11.1, function() -- Line: 2929
        -- upvalues: mainreplication (ref), u115 (copy), ReplicatedStorage (ref)
        mainreplication.EmitAttachmentIn({
            Parent = u115,
            Effect = ReplicatedStorage.Resources.rin.Balltap,
            Offset = CFrame.new(0.150000006, -1.15046751, 3.30000019, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        });
        mainreplication.EmitAttachmentIn({
            Parent = u115,
            Effect = ReplicatedStorage.Resources.rin.JumpEmit,
            Offset = CFrame.new(0.054995656, -2.95909333, 8.62339592, -1, 0, -8.74227766e-8, 0, 1, 0, 8.74227766e-8, 0, -1)
        });
        mainreplication.EmitAttachmentIn({
            Parent = u115,
            Effect = ReplicatedStorage.Resources.rin.ShotTest2,
            Offset = CFrame.new(
                -2.29516983,
                0.00873088837,
                6.41620302,
                0.704045653,
                0.69839263,
                -0.128714845,
                0.106375143,
                -0.28291744,
                -0.953227222,
                -0.702142477,
                0.657423437,
                -0.273478419
            )
        });
    end);
end;

function u1.rinawk(u122) -- Line: 2951
    -- upvalues: Lighting (copy), mainreplication (copy), Util (copy), ReplicatedStorage (copy), PlayerGui (copy), LocalPlayer (copy), vfxUtil (copy), animationUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Players (copy), RunService (copy), workspace_CurrentCamera (copy), TekrinnDialogue (copy), ClockTime (copy), Brightness (copy), Ambient (copy), Threshold (copy)
    local v123 = u122.HumanoidRootPart or u122.PrimaryPart;
    u122:FindFirstChild("Ball");
    local _ = u122.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local v124 = Util.Preload(ReplicatedStorage.Resources.rin.ImpactFrame2);
    local v125 = ReplicatedStorage.Resources.uibox:Clone();
    v125.Parent = PlayerGui;
    local v126 = ReplicatedStorage.Resources.glowscreen:Clone();
    v126.Parent = PlayerGui;
    v126.ImageLabel2.ImageTransparency = 0;
    v126.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    local u127 = ReplicatedStorage.Resources.rin.allawkEffect:Clone();
    u127:PivotTo(v123.CFrame);
    u127.Parent = u122;

    if Util.canshiftcolor(LocalPlayer, u122) then
        vfxUtil.LeanTowardsColor(u127, u122:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u122:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u128 = {};

    for _, descendant in ipairs(workspace.map.map:GetDescendants()) do
        if descendant:IsA("BasePart") then
            u128[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;

    for _, descendant in ipairs(u127:GetDescendants()) do
        if descendant:IsA("AnimationController") or descendant:IsA("Humanoid") then
            local Parent = descendant.Parent;
            local Name = Parent.Name;

            if ReplicatedStorage.Resources.rin.allawkanim:FindFirstChild(Name) then
                local v129 = animationUtil:loadAnimation(Parent, ReplicatedStorage.Resources.rin.allawkanim[Name]);
                v129:Play();
                v129.Stopped:Once(function() -- Line: 2995
                    -- upvalues: Parent (copy)
                    Parent:Destroy();
                end);
            end;
        end;
    end;

    for _, descendant in ipairs(u127:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("PointLight")) then
            descendant.Enabled = false;
        end;
    end;

    for _, descendant in pairs(u127.groundstuff:GetDescendants()) do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    local u130 = ReplicatedStorage.Resources.rin.demonhandui:Clone();
    u130.Parent = PlayerGui;
    u130.CanvasGroup.GroupTransparency = 1;
    TweenService:Create(u130.CanvasGroup, TweenInfo.new(0.3), {
        GroupTransparency = 0
    }):Play();
    animationUtil:loadAnimation(u130.CanvasGroup.ViewportFrame.WorldModel["RinDemon Hand"], ReplicatedStorage.Resources.rin.allawkanim.handyaya):Play();
    Lighting.Brightness = 0;
    Lighting.Ambient = Color3.fromRGB(153, 153, 153);
    Lighting.Bloom.Threshold = 0.38;
    local u131 = ReplicatedStorage.Resources.Blur:Clone();
    u131.Size = 0;
    u131.Parent = Lighting;
    local u132 = ReplicatedStorage.Resources.rin.DepthOfFieldtest:Clone();
    u132.Parent = Lighting;
    u132.Enabled = false;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    local v133 = soundUtil:play(ReplicatedStorage.Resources.rin.awkso, SoundService, {
        Character = u122
    });
    mainreplication.cutscene(v123, nil, 23.15, ReplicatedStorage.Resources.rin.awkFOV);
    local u134 = ReplicatedStorage.Resources.rin.Cameffya:Clone();
    u134.Parent = u127;
    task.spawn(function() -- Line: 3042
        -- upvalues: Players (ref), u122 (copy), u127 (copy)
        local HumanoidDescriptionFromUserId = Players:GetHumanoidDescriptionFromUserId(Players:GetPlayerFromCharacter(u122).userId);
        u127.babyRig.Humanoid:ApplyDescriptionReset(HumanoidDescriptionFromUserId);
    end);
    local u135 = nil;
    u135 = RunService.PreRender:connect(function() -- Line: 3048
        -- upvalues: u134 (copy), u135 (ref), workspace_CurrentCamera (ref)
        if not u134:IsDescendantOf(game) then
            u135:Disconnect();
        end;

        u134.CFrame = workspace_CurrentCamera.CFrame;
    end);
    task.delay(0.617, function() -- Line: 3056
        -- upvalues: TweenService (ref), u130 (copy), u131 (copy), ColorCorrectionEffect (copy), Lighting (ref), u127 (copy)
        TweenService:Create(u130.CanvasGroup, TweenInfo.new(0.3), {
            GroupTransparency = 1
        }):Play();
        task.delay(0.3, u130.Destroy, u130);
        u131.Size = 19;
        TweenService:Create(u131, TweenInfo.new(2.2, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 204, 204);
        ColorCorrectionEffect.Brightness = -1;
        Lighting.ClockTime = 0;
        Lighting.Brightness = 0;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();

        for _, descendant in pairs(u127.redbackgroundthingy:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u127.alldemonhand:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.01;
                descendant:Emit(8);
            end;
        end;

        for _, descendant in ipairs(u127.aurahand:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.833, function() -- Line: 3091
        -- upvalues: u132 (copy), ColorCorrectionEffect (copy), u127 (copy), u134 (copy)
        u132.Enabled = true;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 196, 196);
        u127.pointlight.Attachment.SpotLight.Enabled = true;

        for _, descendant in ipairs(u134:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u127.redbackgroundthingy:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u127.RinShadowsPart1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        u127.aurahand:Destroy();
        u127.alldemonhand:Destroy();
    end);
    task.delay(4.283, function() -- Line: 3120
        -- upvalues: u132 (copy), u127 (copy), ReplicatedStorage (ref), u122 (copy)
        u132.Enabled = false;

        for _, descendant in ipairs(u127.redbackgroundthingy:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u127.redbackgroundthingy2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u127.RinShadowsPart1:Destroy();
        u127.pointlight.Attachment.SpotLight.Enabled = false;

        for _, descendant in pairs(u127.rinshadowarm1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        local v136 = ReplicatedStorage.Resources.rin.lineya:Clone();
        v136.Parent = u122["Left Leg"];
        v136.Enabled = true;
        task.delay(2.5, v136.Destroy, v136);
    end);
    task.delay(7.033, function() -- Line: 3153
        -- upvalues: u127 (copy), ColorCorrectionEffect (copy), TweenService (ref)
        for _, descendant in pairs(u127.rinhandshatter.catch:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u127.grabaura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 142, 142);
        ColorCorrectionEffect.Brightness = 0.1;
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.Saturation = 0;
        local v137 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.834, Enum.EasingStyle.Linear), {
            Brightness = -0.5
        });
        v137:Play();
        v137.Completed:Wait();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        ColorCorrectionEffect.Brightness = 0.3;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.616, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(7.867, function() -- Line: 3184
        -- upvalues: u131 (copy), TweenService (ref), u127 (copy)
        u131.Size = 56;
        TweenService:Create(u131, TweenInfo.new(0.7, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();

        for _, descendant in pairs(u127.grabaura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u127.rinhandshatter.explosion:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u127.rinhandpoof.kapoof.PointLight.Enabled = true;
        u127.rinhandpoof.kapoof.PointLight.Brightness = 4;
        TweenService:Create(u127.rinhandpoof.kapoof.PointLight, TweenInfo.new(0.666, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(8.433, function() -- Line: 3212
        -- upvalues: u127 (copy)
        for _, descendant in pairs(u127.LeftLeg2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.433, function() -- Line: 3221
        -- upvalues: u127 (copy)
        for _, descendant in pairs(u127.LeftLeg2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.6, function() -- Line: 3230
        -- upvalues: ReplicatedStorage (ref), u122 (copy), ColorCorrectionEffect (copy), TweenService (ref)
        local v138 = ReplicatedStorage.Resources.rin.lineya:Clone();
        v138.Parent = u122["Left Leg"];
        v138.Enabled = true;
        task.delay(0.7, v138.Destroy, v138);
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        ColorCorrectionEffect.Brightness = 0.3;
        local v139 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.683, Enum.EasingStyle.Linear), {
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 189, 189)
        });
        v139:Play();
        v139.Completed:Wait();
        ColorCorrectionEffect.Brightness = 0.433;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.433, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(9.3, function() -- Line: 3249
        -- upvalues: u131 (copy), TweenService (ref), u127 (copy)
        u131.Size = 56;
        TweenService:Create(u131, TweenInfo.new(0.317, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();

        for _, descendant in pairs(u127.rinlegshatter:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u127.LeftLeg2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        u127.rinlegshatter.PointLight.Enabled = true;
        TweenService:Create(u127.rinlegshatter.PointLight, TweenInfo.new(0.666, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(9.767, function() -- Line: 3271
        -- upvalues: u134 (copy)
        for _, descendant in pairs(u134.rinleft:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.917, function() -- Line: 3280
        -- upvalues: u127 (copy), ColorCorrectionEffect (copy), u131 (copy), TweenService (ref)
        for _, descendant in pairs(u127.rinfinalflames:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 237, 237);
        ColorCorrectionEffect.Brightness = 0;
        u131.Size = 56;
        TweenService:Create(u131, TweenInfo.new(0.683, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = 0
        }):Play();
    end);
    task.delay(10.25, function() -- Line: 3295
        -- upvalues: u134 (copy)
        for _, descendant in pairs(u134.rinleft:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(11.45, function() -- Line: 3304
        -- upvalues: u127 (copy), u131 (copy), TweenService (ref)
        for _, descendant in ipairs(u127.redbackgroundthingy2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u127.redbackgroundthingy3:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u131.Size = 56;
        TweenService:Create(u131, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = 0
        }):Play();
    end);
    task.delay(13.35, function() -- Line: 3321
        -- upvalues: u127 (copy)
        for _, descendant in ipairs(u127.redbackgroundthingy3:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u127.rinfinalflames:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        local BLUEFIRE = u127.BLUEFIRE;

        for _, descendant in pairs(BLUEFIRE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                descendant:Emit(1);
            end;
        end;

        BLUEFIRE.Attachment.PointLight.Enabled = true;
    end);
    local u140 = ReplicatedStorage.Resources.rin.ImpactFrame2:Clone();
    u140.Parent = PlayerGui;
    u140.ScreenInsets = Enum.ScreenInsets.None;
    u140.Frame.BackgroundTransparency = 1;
    local CanvasGroup = u140.Frame.CanvasGroup;
    CanvasGroup.GroupTransparency = 1;
    task.delay(13.933, function() -- Line: 3363
        -- upvalues: TweenService (ref), CanvasGroup (copy), u140 (copy), RunService (ref)
        TweenService:Create(CanvasGroup, TweenInfo.new(1), {
            GroupTransparency = 0
        }):Play();
        TweenService:Create(u140.Frame, TweenInfo.new(1), {
            BackgroundTransparency = 0
        }):Play();

        for _, child in ipairs(CanvasGroup:GetChildren()) do
            child.Visible = false;
        end;

        local u141 = #u140.Frame.CanvasGroup:GetChildren();
        local u142 = 0;
        local u143 = nil;
        u143 = RunService.PreRender:Connect(function(p144) -- Line: 3378, Name: UpdateWarper
            -- upvalues: u142 (ref), u141 (copy), TweenService (ref), CanvasGroup (ref), u143 (ref), u140 (ref)
            u142 = u142 + p144;
            local v145 = u142 // 0.041666666666666664 + 1;

            if u141 >= v145 then
                u140.Frame.CanvasGroup[v145].Visible = true;

                return;
            end;

            TweenService:Create(CanvasGroup, TweenInfo.new(1), {
                GroupTransparency = 1
            }):Play();
            u143:Disconnect();
        end);
        task.delay(6.117, function() -- Line: 3402
            -- upvalues: u143 (ref), TweenService (ref), u140 (ref)
            if u143 then
                u143:Disconnect();
            end;

            TweenService:Create(u140.Frame, TweenInfo.new(0.5), {
                BackgroundTransparency = 1
            }):Play();
            task.delay(0.5, u140.Destroy, u140);
        end);
    end);
    task.delay(20.05, function() -- Line: 3413
        -- upvalues: u128 (copy)
        for i, v in u128 do
            i.Transparency = v;
        end;

        table.clear(u128);
    end);
    task.delay(20.217, function() -- Line: 3420
        -- upvalues: mainreplication (ref), u122 (copy), ReplicatedStorage (ref)
        mainreplication.Emit(u122.Head, ReplicatedStorage.Resources.rin.oxygen, 3);
    end);
    task.delay(20.685, function() -- Line: 3424
        -- upvalues: mainreplication (ref), u122 (copy), ReplicatedStorage (ref)
        mainreplication.Emit(u122.Head, ReplicatedStorage.Resources.rin.oxygen, 3);
    end);
    task.delay(21.533, function() -- Line: 3428
        -- upvalues: mainreplication (ref), u122 (copy), ReplicatedStorage (ref)
        mainreplication.Emit(u122.Head, ReplicatedStorage.Resources.rin.oxygen, 3);
    end);
    task.delay(22.583, function() -- Line: 3432
        -- upvalues: mainreplication (ref), u122 (copy), ReplicatedStorage (ref)
        mainreplication.Emit(u122.Head, ReplicatedStorage.Resources.rin.oxygen, 3);
    end);
    task.delay(20.05, function() -- Line: 3436
        -- upvalues: u127 (copy), ColorCorrectionEffect (copy)
        u127.RoomReal:Destroy();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        ColorCorrectionEffect.Brightness = -0.05;
        ColorCorrectionEffect.Contrast = -0.15;
        ColorCorrectionEffect.Saturation = -0.75;
    end);

    if v133.Name == "Dub" then
        task.delay(1.55, function() -- Line: 3448
            -- upvalues: TekrinnDialogue (ref), u122 (copy)
            TekrinnDialogue.Speak(u122, {
                {
                    Text = "I\'m so sick of these convenient labels...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 94, 140)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 6
                    }
                }
            }, 6);
        end);
        task.delay(4.974, function() -- Line: 3474
            -- upvalues: TekrinnDialogue (ref), u122 (copy)
            TekrinnDialogue.Speak(u122, {
                {
                    Text = "They have no place in my life.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 94, 140)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 6
                    }
                }
            }, 6);
        end);
        task.delay(9.208, function() -- Line: 3500
            -- upvalues: TekrinnDialogue (ref), u122 (copy)
            TekrinnDialogue.Speak(u122, {
                {
                    Text = "I am...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(13, 26, 38)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                }
            }, 4);
        end);
        task.delay(11.033, function() -- Line: 3526
            -- upvalues: TekrinnDialogue (ref), u122 (copy)
            TekrinnDialogue.Speak(u122, {
                {
                    Text = "ME!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(13, 26, 38)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 8,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(17.376, function() -- Line: 3552
            -- upvalues: TekrinnDialogue (ref), u122 (copy)
            TekrinnDialogue.Speak(u122, {
                {
                    Text = "I\'m the",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 2
                    }
                },
                {
                    Text = " egoist",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 8,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(20.523, function() -- Line: 3600
            -- upvalues: TekrinnDialogue (ref), u122 (copy)
            task.delay(2, TekrinnDialogue.Speak(u122, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Text = `{u122.Name}!`,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 10,
                        Lifetime = 2
                    }
                }
            }, 2));
        end);
    else
        task.delay(1.55, function() -- Line: 3627
            -- upvalues: TekrinnDialogue (ref), u122 (copy)
            TekrinnDialogue.Speak(u122, {
                {
                    Text = "Stop violating my life with your easy, cheap values.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 94, 140)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 6
                    }
                }
            }, 6);
        end);
        task.delay(9.317, function() -- Line: 3653
            -- upvalues: TekrinnDialogue (ref), u122 (copy)
            TekrinnDialogue.Speak(u122, {
                {
                    Text = "I am...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(13, 26, 38)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(11.217, function() -- Line: 3679
            -- upvalues: TekrinnDialogue (ref), u122 (copy)
            TekrinnDialogue.Speak(u122, {
                {
                    Text = "ME!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(13, 26, 38)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 8,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(17.567, function() -- Line: 3705
            -- upvalues: TekrinnDialogue (ref), u122 (copy)
            TekrinnDialogue.Speak(u122, {
                {
                    Text = "I\'m an",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 2
                    }
                },
                {
                    Text = " egoist",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 8,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(20.883, function() -- Line: 3753
            -- upvalues: TekrinnDialogue (ref), u122 (copy)
            task.delay(2, TekrinnDialogue.Speak(u122, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Text = `{u122.Name}!`,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 10,
                        Lifetime = 2
                    }
                }
            }, 2));
        end);
    end;

    task.wait(23.15);
    v124:Destroy();
    v125:Destroy();
    v126:Destroy();
    Lighting.ClockTime = ClockTime;
    Lighting.Brightness = Brightness;
    Lighting.Ambient = Ambient;
    Lighting.Bloom.Threshold = Threshold;

    if u134 then
        u134:Destroy();
    end;

    u131:Destroy();
    u127:Destroy();
    ColorCorrectionEffect:Destroy();
    u132:Destroy();
    mainreplication.sceneEnabled(false);
    mainreplication.ultFlash(nil, 1.5);
    mainreplication.fov(false, 15);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.rinCornerShotConcept(p146) -- Line: 3810
    -- upvalues: vfxUtil (copy), mainreplication (copy), trove (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local rin = vfxUtil.getResources().rin;
    local CornerShot = rin.CornerShot;
    local Root = vfxUtil.getRoot(p146);
    local Ball = p146:FindFirstChild("Ball");
    mainreplication.sceneEnabled(true);
    local u147 = trove.new();
    u147:AttachToInstance(p146);
    u147:Add(function() -- Line: 3821
        -- upvalues: mainreplication (ref), Ball (copy)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 2);
        Ball.Size = Vector3.new(1.95, 1.95, 1.95);
        Ball.Transparency = 0;
    end);
    u147:Add(task.delay(5.917, function() -- Line: 3827
        -- upvalues: u147 (copy)
        u147:Destroy();
    end));
    local u148 = u147:Clone(CornerShot.Sphere);
    u148.CFrame = Root.CFrame;
    u148.Parent = workspace.Effects;
    u147:Add(mainreplication.kuronaCam(Root, CornerShot.Cam, CornerShot.FOV, function() -- Line: 3835
        -- upvalues: u148 (copy), Root (copy)
        u148.CFrame = Root.CFrame;
    end));
    local v149 = u147:Construct(CornerShot.rintrail);
    v149.Weld.Part0 = Ball;
    v149.Parent = Ball;
    local u150 = u147:Construct(CornerShot.hota);
    u150.Weld.Part0 = Root;
    u150.Parent = workspace.Effects;
    local v151 = u147:Construct(vfxUtil.getMoonEffects);
    local v152 = u147:Construct(MoonPropertyAnimator);
    v152:LoadAndConvertSave(CornerShot.Moon, {
        ["Screen Cover"] = v151["Screen Cover"],
        Sphere = u148
    });
    v152:PlayAll();
    task.defer(function() -- Line: 3856
        -- upvalues: Ball (copy)
        Ball.Size = Vector3.new(1.5, 1.5, 1.5);
        Ball.Transparency = 1;

        for _, descendant in Ball:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
                descendant:Emit(descendant.Rate);
            elseif descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u147:Add(task.delay(3.85, function() -- Line: 3869
        -- upvalues: Ball (copy), soundUtil (ref), rin (copy), u150 (copy)
        Ball.Transparency = 0;
        soundUtil:play(rin["curveshot shooted"], soundUtil);

        for _, descendant in Ball:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
                descendant:Clear();
                descendant:Emit(descendant.Rate);
            elseif descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in u150:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end));
    u147:Add(task.delay(4.716666666666667, function() -- Line: 3888
        -- upvalues: soundUtil (ref), rin (copy), Ball (copy), u150 (copy)
        soundUtil:play(rin["curveshot shooted"], soundUtil);
        soundUtil:play(rin.dcsound, soundUtil);

        for _, descendant in Ball:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            elseif descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in u150:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end));
    local u153 = soundUtil:play(rin.curvershoot, soundUtil);
    task.delay(2.85, function() -- Line: 3906
        -- upvalues: u153 (copy)
        task.wait(1);
        u153:Destroy();
    end);
end;

local u154 = nil;

function u1.finalmatchRin(p155, p156) -- Line: 3914
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), StarterGui (copy), Lighting (copy), MoonPropertyAnimator (copy), u154 (ref), soundUtil (copy)
    local RinMatchupVictory = vfxUtil.getResources().rin.RinMatchupVictory;
    local Root = vfxUtil.getRoot(p155);
    local u157 = trove.new();
    u157:AttachToInstance(p155);
    u157:Add(function() -- Line: 3920
        -- upvalues: mainreplication (ref), StarterGui (ref)
        mainreplication.sceneEnabled(false);
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
    end);
    u157:Add(task.delay(8.35, function() -- Line: 3925
        -- upvalues: mainreplication (ref), u157 (copy)
        mainreplication.ultFlash(nil, 1.5);
        mainreplication.fov(false, 15);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        u157:Destroy();
    end));
    local v158 = u157:Clone(RinMatchupVictory.VFX);
    v158:PivotTo(Root.CFrame);
    v158.Parent = workspace.Effects;
    u157:Add(mainreplication.kuronaCam(Root, RinMatchupVictory.Cam, RinMatchupVictory.FOV));
    local v159 = {};

    for _, child in RinMatchupVictory.Lighting:GetChildren() do
        local v160 = u157:Clone(child);
        v160.Parent = Lighting;
        v159[child.Name] = v160;
    end;

    local v161 = u157:Construct(MoonPropertyAnimator);
    v161:LoadAndConvertSave(RinMatchupVictory.Moon, v159);
    v161:PlayAll();

    if not u154 then
        u154 = require(RinMatchupVictory.Compiled);
    end;

    for _, v in u154 do
        u157:Add(task.delay(v[1] / 60, v[2], v158));
    end;

    soundUtil:play(RinMatchupVictory.SFX, soundUtil);
end;

function u1.rin_trivela(p162) -- Line: 3957
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), trove (copy), MoonPropertyAnimator (copy)
    local Trivela = vfxUtil.getResources().rin.Trivela;
    local Root = vfxUtil.getRoot(p162);
    mainreplication.sceneEnabled(true);
    soundUtil:play(Trivela.Sound, "default");
    vfxUtil.cutscene_ball(true);
    local u163 = trove.new();
    u163:AttachToInstance(p162);
    u163:Add(function() -- Line: 3968
        -- upvalues: mainreplication (ref), vfxUtil (ref)
        mainreplication.ultFlash();
        mainreplication.sceneEnabled(false);
        vfxUtil.cutscene_ball(false);
    end);
    u163:Add(task.delay(7.833, function() -- Line: 3974
        -- upvalues: u163 (copy)
        u163:Destroy();
    end));
    local v164 = u163:Clone(Trivela.VFX);
    v164:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p162, v164.TuffCharacterRig2, true);
    v164.Parent = workspace.Effects;
    local v165 = u163:Add(vfxUtil.highlight(p162, {
        Name = "Highlight",
        Enabled = true,
        FillTransparency = 2,
        OutlineTransparency = 0.00999999978,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        FillColor = Color3.new(1, 0, 0),
        OutlineColor = Color3.new(1, 1, 1)
    }));
    local _, v166 = mainreplication.cutsceneCamRigWithLetterBox(Root, Trivela.CamAnimation, Trivela.FOV, p162, Trivela["CamRigWithLetterBox "].RootPart.Weld.C0, Trivela["CamRigWithLetterBox "]);
    u163:Add(v166);
    local v167 = {
        Vignette = u163:Add(vfxUtil.getMoonEffects()).Vignette,
        Highlight = v165,
        Workspace = v164
    };
    vfxUtil.contain_lighting(u163, v167, Trivela.Lighting);
    local v168 = u163:Construct(MoonPropertyAnimator);
    v168:LoadAndConvertSave(Trivela.Moon, v167);
    v168:SetOriginalRoot(Trivela.VFX:GetPivot());
    v168:SetRoot(Root);
    v168:PlayAll();
    vfxUtil.execute_compiled(Trivela.Compiled, u163, v164);
end;

local u169 = {};

function u1.rin2DestructiveImpulses(u170: any, p171: boolean) -- Line: 4015
    -- upvalues: u169 (copy), vfxUtil (copy)
    if not u170 then
        return;
    end;

    if not p171 then
        local v172 = u169[u170];

        if v172 then
            v172:Destroy();
            u169[u170] = nil;
        end;

        return;
    end;

    if u169[u170] then
        return;
    end;

    local rin2 = vfxUtil.getResources().rin2;
    local Head = u170:FindFirstChild("Head");

    if not Head then
        warn("bro how u no got luh head 😅🙂");

        return;
    end;

    local v173 = vfxUtil.character_trove(u170);
    local u174 = v173:Clone(rin2.eye_new);
    local v175 = u174:FindFirstChildOfClass("Weld");

    if v175 and v175:IsA("Weld") then
        v175.Part0 = Head;
    end;

    v173:Add(task.delay(0.2, function() -- Line: 4048
        -- upvalues: u174 (copy)
        if u174:FindFirstChild("oxygen") then
            shared.vfx.emit(u174:FindFirstChild("oxygen"));
        end;
    end));
    u174.Parent = workspace.Effects;
    u169[u170] = u174;
    v173:Add(function() -- Line: 4057
        -- upvalues: u169 (ref), u170 (copy), u174 (copy)
        if u169[u170] == u174 then
            u169[u170] = nil;
        end;
    end);
end;

function u1.rin2DestructiveImpulsesActivate(p176, p177) -- Line: 4064
    -- upvalues: vfxUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), LocalPlayer (copy), SoundService (copy), BeginLayers (copy), mainreplication (copy)
    local v178 = p177 or 1;
    local Root = vfxUtil.getRoot(p176);
    local rin2 = vfxUtil.getResources().rin2;
    local u179 = vfxUtil.character_trove(p176);
    local v180 = u179:Add(Instance.new("Highlight"));
    local v181 = u179:Add(rin2.DestructiveImpulses.Effects.ColorCorrection:Clone());
    v181.Parent = Lighting;
    local v182 = u179:Construct(MoonPropertyAnimator);
    v182:LoadAndConvertSave(rin2.DestructiveImpulses.Effects.Moon, {
        Highlight = v180,
        ColorCorrection = v181
    });
    v182:SetRoot(Root);
    v182:SetFPS(60 * v178);
    v182:PlayAll();
    v180.Parent = p176;

    if rin2:FindFirstChild("DestructiveImpulses") then
        local StartCrackle = rin2:FindFirstChild("DestructiveImpulses").Sounds.StartCrackle;

        if p176 == LocalPlayer.Character or not Root then
            Root = SoundService;
        end;

        soundUtil:play(StartCrackle, Root);
    end;

    if p176 == LocalPlayer.Character then
        task.spawn(BeginLayers);
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(10, 2, 6);
    end;

    u179:Add(task.delay(1 * v178, function() -- Line: 4097
        -- upvalues: u179 (copy)
        u179:Destroy();
    end));
end;

function u1.rin2DestructiveImpulsesDeactivate(p183) -- Line: 4103
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), u4 (ref), soundUtil (copy), SoundService (copy)
    local Root = vfxUtil.getRoot(p183);
    local rin2 = vfxUtil.getResources().rin2;

    if p183 == LocalPlayer.Character and u4 then
        u4:Destroy();
        u4 = nil;
    end;

    if rin2:FindFirstChild("DestructiveImpulses") then
        local EndCrackle = rin2:FindFirstChild("DestructiveImpulses").Sounds.EndCrackle;

        if p183 == LocalPlayer.Character or not Root then
            Root = SoundService;
        end;

        soundUtil:play(EndCrackle, Root);
    end;
end;

function u1.occlusionBreak_rin2(u184) -- Line: 4121
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), RunService (copy), actionUtil (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(u184);
    local v185 = vfxUtil.getResources().rin2:FindFirstChild("Occlusion Break");

    if v185 then
        soundUtil:play(v185.BaseSound, Root);
        local u186 = 45;
        local u187 = vfxUtil.character_trove(u184);
        local u188 = v185:FindFirstChild("Aura"):Clone();
        mainreplication.destroyVelocity(u184);
        local u189 = u187:Add(Instance.new("BodyVelocity"));
        u189.Parent = Root;
        u189.MaxForce = Vector3.new(100000, 0, 100000);
        u189.P = 13500;
        u189.Name = "RinVelocity";
        local CFrame_identity = CFrame.identity;
        local u190 = CFrame_identity;
        local u191 = nil;
        u187:Add(task.delay(2.5, function() -- Line: 4147
            -- upvalues: u191 (ref)
            u191 = tick();
        end));
        u187:Add(RunService.PreRender:Connect(function(p192) -- Line: 4151
            -- upvalues: u191 (ref), u186 (ref), u190 (ref), CFrame_identity (ref), Root (copy), u189 (copy)
            if u191 then
                local v193 = (tick() - u191) / 0.6000000000000001;
                local math_clamp_ret = math.clamp(v193, 0, 1);
                u186 = math.lerp(45, 0, math_clamp_ret);
            end;

            u190 = u190:Lerp(CFrame_identity, p192 * 5);
            u189.Velocity = (Root.CFrame * u190).LookVector * u186;
        end));
        u187:Add(task.delay(0.01, function() -- Line: 4164
            -- upvalues: CFrame_identity (ref)
            CFrame_identity = CFrame.fromEulerAnglesYXZ(0, -0.7853981633974483, 0);
        end));
        u187:Add(task.delay(0.5, function() -- Line: 4168
            -- upvalues: CFrame_identity (ref)
            CFrame_identity = CFrame.identity;
        end));
        u187:Add(task.delay(0.87, function() -- Line: 4172
            -- upvalues: CFrame_identity (ref)
            CFrame_identity = CFrame.fromEulerAnglesYXZ(0, 0.39269908169872414, 0);
        end));
        u187:Add(task.delay(1.5, function() -- Line: 4175
            -- upvalues: CFrame_identity (ref)
            CFrame_identity = CFrame.identity;
        end));
        u188.Parent = workspace.Effects;
        u188:PivotTo(u184:GetPivot());
        vfxUtil.setupAura(u184, u188, true);
        u187:Add(function() -- Line: 4191
            -- upvalues: u188 (copy)
            for _, descendant in u188:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(1, game.Destroy, u188);
        end);
        u187:Add(task.delay(0.015, function() -- Line: 4200
            -- upvalues: actionUtil (ref), u184 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), mainreplication (ref)
            if actionUtil.simulatesCharacter(u184) then
                local BlurEffect = Instance.new("BlurEffect");
                BlurEffect.Size = 25;
                BlurEffect.Parent = Lighting;
                TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = 0
                }):Play();
                task.delay(0.533, BlurEffect.Destroy, BlurEffect);
                local v194 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                v194.Parent = Lighting;
                v194.TintColor = Color3.fromRGB(71, 218, 181);
                v194.Brightness = 0.4;
                v194.Contrast = 1;
                v194.Saturation = -0.4;
                TweenService:Create(v194, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Saturation = 0
                }):Play();
                TweenService:Create(v194, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Contrast = 0,
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                task.delay(2, v194.Destroy, v194);
                mainreplication.fov(false, 100);
                mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                mainreplication.cameraShake(10, 1.5, 6);
            end;
        end));
        u187:Add(task.delay(2.42, function() -- Line: 4244
            -- upvalues: actionUtil (ref), u184 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref)
            if actionUtil.simulatesCharacter(u184) then
                local BlurEffect = Instance.new("BlurEffect");
                BlurEffect.Size = 6;
                BlurEffect.Parent = Lighting;
                TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = 0
                }):Play();
                task.delay(0.533, BlurEffect.Destroy, BlurEffect);
                local v195 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                v195.Parent = Lighting;
                v195.TintColor = Color3.fromRGB(71, 218, 181);
                v195.Brightness = 0.4;
                v195.Contrast = 1;
                v195.Saturation = -0.4;
                TweenService:Create(v195, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Saturation = 0
                }):Play();
                TweenService:Create(v195, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Contrast = 0,
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                task.delay(2, v195.Destroy, v195);
            end;
        end));
        local v196 = u187:Add(Instance.new("Highlight"));
        v196.DepthMode = Enum.HighlightDepthMode.Occluded;
        v196.FillTransparency = 0.5;
        v196.OutlineTransparency = 0;
        v196.FillColor = Color3.fromRGB(34, 162, 141);
        v196.OutlineColor = Color3.fromRGB(29, 147, 114);
        v196.Parent = u184;
        local v197 = u187:Construct(MoonPropertyAnimator);
        v197:LoadAndConvertSave(v185.Moon, {
            Highlight = v196
        });
        v197:SetRoot(Root);
        v197:SetFPS(60);
        v197:PlayAll();
        vfxUtil.execute_compiled(v185.Compiled, u187, u188);
        u187:Add(task.delay(3.08, function() -- Line: 4297
            -- upvalues: u187 (copy)
            u187:Destroy();
        end));
    end;
end;

function u1.occlusionBreak_rin2_destroyer(u198) -- Line: 4303
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), RunService (copy), TweenService (copy), actionUtil (copy), Lighting (copy), ReplicatedStorage (copy)
    local Root = vfxUtil.getRoot(u198);
    local v199 = vfxUtil.getResources().rin2:FindFirstChild("Occlusion Break");

    if v199 then
        soundUtil:play(v199.BaseSound, Root);
        local u200 = vfxUtil.character_trove(u198);
        local u201 = v199:FindFirstChild("Aura"):Clone();
        mainreplication.destroyVelocity(u198);
        local u202, u203 = mainreplication.bodyVelocity(Root, 125, 3.13, nil, nil, true);
        u200:Add(u202);
        local CFrame_identity = CFrame.identity;
        local u204 = nil;
        u204 = RunService.RenderStepped:Connect(function(p205) -- Line: 4324
            -- upvalues: u202 (copy), u204 (ref), Root (copy), CFrame_identity (ref), u203 (copy)
            if u202 and u202:IsDescendantOf(game) then
                u202.Velocity = (Root.CFrame * CFrame_identity).LookVector * u203.Value;

                return;
            end;

            u204:Disconnect();
        end);
        u200:Add(u204);
        u200:Add(task.spawn(function() -- Line: 4335
            -- upvalues: CFrame_identity (ref), TweenService (ref), u203 (copy)
            CFrame_identity = CFrame.fromEulerAnglesYXZ(0, 0.6283185307179586, 0);
            TweenService:Create(u203, TweenInfo.new(0.67, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Value = 0
            }):Play();
        end));
        u200:Add(task.delay(0.725, function() -- Line: 4340
            -- upvalues: u203 (copy), CFrame_identity (ref), TweenService (ref)
            u203.Value = 125;
            CFrame_identity = CFrame.fromEulerAnglesYXZ(0, -1.2566370614359172, 0);
            TweenService:Create(u203, TweenInfo.new(0.5750000000000001, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Value = 0
            }):Play();
        end));
        u200:Add(task.delay(1.3, function() -- Line: 4346
            -- upvalues: u203 (copy), CFrame_identity (ref), TweenService (ref)
            u203.Value = 125;
            CFrame_identity = CFrame.identity;
            TweenService:Create(u203, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Value = 0
            }):Play();
        end));
        u201.Parent = workspace.Effects;
        u201:PivotTo(u198:GetPivot());
        vfxUtil.setupAura(u198, u201, true);

        for _, descendant in u201.HumanoidRootPart.EnableForDestroy:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                descendant.Enabled = true;
            end;
        end;

        u200:Add(function() -- Line: 4370
            -- upvalues: u201 (copy)
            for _, descendant in u201:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(1, game.Destroy, u201);
        end);
        u200:Add(task.delay(0.005, function() -- Line: 4379
            -- upvalues: actionUtil (ref), u198 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), mainreplication (ref)
            if actionUtil.simulatesCharacter(u198) then
                local BlurEffect = Instance.new("BlurEffect");
                BlurEffect.Size = 25;
                BlurEffect.Parent = Lighting;
                TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = 0
                }):Play();
                task.delay(0.533, BlurEffect.Destroy, BlurEffect);
                local v206 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                v206.Parent = Lighting;
                v206.TintColor = Color3.fromRGB(71, 218, 181);
                v206.Brightness = 0.4;
                v206.Contrast = 1;
                v206.Saturation = -0.4;
                TweenService:Create(v206, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Saturation = 0
                }):Play();
                TweenService:Create(v206, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Contrast = 0,
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                task.delay(2, v206.Destroy, v206);
                mainreplication.fov(false, 100);
                mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                mainreplication.cameraShake(10, 1.5, 6);
            end;
        end));
        u200:Add(task.delay(2.1, function() -- Line: 4422
            -- upvalues: u200 (copy)
            u200:Destroy();
        end));
    end;
end;

return u1;