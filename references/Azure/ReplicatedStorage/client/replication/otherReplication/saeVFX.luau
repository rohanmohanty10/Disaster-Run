 

 

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContentProvider = game:GetService("ContentProvider");
local Debris = game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("ServerStorage");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local trove = require(ReplicatedStorage.forum.trove);
local Util = require(ReplicatedStorage.util.Util);
local v1 = {};
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
local OutdoorAmbient = Lighting.OutdoorAmbient;
local Threshold = Lighting.Bloom.Threshold;
local EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale;
local EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale;
local GeographicLatitude = Lighting.GeographicLatitude;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
local MeshEmitter = require(script.Parent.Parent.MeshEmitter);
require(ReplicatedStorage2.util.raycast);
local animationUtil = require(ReplicatedStorage2.util.animationUtil);
local soundUtil = require(ReplicatedStorage2.util.soundUtil);
require(ReplicatedStorage2.util.actionUtil);
local MoonPropertyAnimator = require(ReplicatedStorage2.util.MoonPropertyAnimator);
local camerasreplication = require(script.Parent.camerasreplication);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(script.Parent.Parent.TekrinnDialogue);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
require(ReplicatedStorage.allTypes.rig);
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);

function v1.characterImage(p2) -- Line: 57
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p2);
end;

function v1.sae_overtime_v2(u3: any, p4: boolean, p5: userdata) -- Line: 59
    -- upvalues: vfxUtil (copy), KatUtil (copy), MoonPropertyAnimator (copy), mainreplication (copy), Lighting (copy), Ambient (copy), OutdoorAmbient (copy), ClockTime (copy), GeographicLatitude (copy), soundUtil (copy), SoundService (copy), Util (copy), TekrinnDialogue (copy)
    local NEWOT = vfxUtil.getResources().sae.NEWOT;
    local _track = KatUtil.get_track(u3, NEWOT.Animation);

    if not _track then
        return;
    end;

    local Root = vfxUtil.getRoot(u3);
    local u6 = _track.add(vfxUtil.createVFX(NEWOT.saeotcamenabled, "default", Root));
    local v7 = _track.add(Instance.new("ColorCorrectionEffect"));
    local v8 = _track.construct(MoonPropertyAnimator);
    local u9 = _track.add(NEWOT.saeotstuff:Clone());
    local v10 = _track.add(vfxUtil.getMoonEffects());
    local u11 = _track.add(vfxUtil.createVFX(NEWOT.saeoutemit, "default", Root));
    local u12, v13 = mainreplication.cutsceneBlender(Root, NEWOT.Camera, NEWOT.FOV);
    _track.add(vfxUtil.getScreenDimmer());

    local function apply_lighting() -- Line: 78
        -- upvalues: vfxUtil (ref), NEWOT (copy), Lighting (ref), Ambient (ref), OutdoorAmbient (ref), ClockTime (ref), GeographicLatitude (ref)
        vfxUtil.cache_lighting();
        local u14 = {};

        for _, child in NEWOT.Lighting:GetChildren() do
            local v15 = child:Clone();
            v15.Parent = Lighting;
            table.insert(u14, v15);
        end;

        Lighting.Ambient = Color3.fromRGB(70, 70, 70);
        Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
        Lighting.ClockTime = 4;
        Lighting.GeographicLatitude = 0;

        return function() -- Line: 95
            -- upvalues: u14 (copy), vfxUtil (ref), Lighting (ref), Ambient (ref), OutdoorAmbient (ref), ClockTime (ref), GeographicLatitude (ref)
            for _, v in u14 do
                v:Destroy();
            end;

            vfxUtil.restore_lighting();
            Lighting.Ambient = Ambient;
            Lighting.OutdoorAmbient = OutdoorAmbient;
            Lighting.ClockTime = ClockTime;
            Lighting.GeographicLatitude = GeographicLatitude;
        end;
    end;

    mainreplication.sceneEnabled(true);
    _track.add(function() -- Line: 110
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    _track.add((apply_lighting()));
    _track.add(v13);
    local v16;

    if u3:GetAttribute("femlock") then
        v16 = vfxUtil.getResources().sae.Femvoicelines.otflow;
    else
        v16 = NEWOT.Sound;
    end;

    local v17 = { (soundUtil:play(v16, SoundService, {
            Character = u3
        })) };
    Util.flowCancel(_track, p5, v17);
    local v18 = {};

    for _, v in {
        head = vfxUtil.createVFX(NEWOT.BodyParts.Head, "default", u3.Head),
        torso = vfxUtil.createVFX(NEWOT.BodyParts.Torso, "default", u3.Torso),
        right_arm = vfxUtil.createVFX(NEWOT.BodyParts["Right Arm"], "default", u3["Right Arm"]),
        right_leg = vfxUtil.createVFX(NEWOT.BodyParts["Right Leg"], "default", u3["Right Leg"]),
        left_arm = vfxUtil.createVFX(NEWOT.BodyParts["Left Arm"], "default", u3["Left Arm"]),
        left_leg = vfxUtil.createVFX(NEWOT.BodyParts["Left Leg"], "default", u3["Left Leg"])
    } do
        _track.add(v);
    end;

    v7.Parent = Lighting;
    u9.Parent = workspace.Effects;
    u9:PivotTo(Root.CFrame * CFrame.new(-1.85551834, 10.2637968, 19.5128422, 0, 0, 1, 0, 1, 0, -1, 0, 0));

    for _, child in NEWOT.CAMVFX:GetChildren() do
        local v19 = child:Clone();
        v19.Parent = u12.CamPart;
        v18[child.Name] = v19;
    end;

    KatUtil.Enable(u12, "Beam", true);
    KatUtil.Enable(u12, "ParticleEmitter", false);
    KatUtil.Enable(u9, "ParticleEmitter,PointLight", true);
    _track.add(KatUtil.frame_delay(83, function() -- Line: 147
        -- upvalues: KatUtil (ref), u12 (copy)
        KatUtil.Enable(u12, "ParticleEmitter", true);
    end));
    _track.add(KatUtil.frame_delay(102, function() -- Line: 151
        -- upvalues: KatUtil (ref), u11 (copy)
        KatUtil.Emit(u11);
    end));
    _track.add(KatUtil.frame_delay(108, function() -- Line: 155
        -- upvalues: KatUtil (ref), u9 (copy)
        KatUtil.Enable(u9.saeotaura, "Beam", true);
    end));
    _track.add(KatUtil.frame_delay(117, function() -- Line: 159
        -- upvalues: u11 (copy)
        for _, v in u11:QueryDescendants("ParticleEmitter") do
            v.TimeScale = 0.25;
        end;
    end));
    _track.add(KatUtil.frame_delay(215, function() -- Line: 165
        -- upvalues: KatUtil (ref), u6 (copy)
        KatUtil.Enable(u6, "Beam", true);
    end));
    _track.add(KatUtil.delay(3.633, function() -- Line: 169
        -- upvalues: TekrinnDialogue (ref), u3 (copy)
        TekrinnDialogue.Speak(u3, {
            {
                Text = "This is a ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            },
            {
                Text = "one-shot ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(177, 51, 78)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 73, 112)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            },
            {
                Text = "match.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 2);
    end));
    v8:LoadAndConvertSave(NEWOT.Moon, {
        Vignette = v10.Vignette,
        saeultccot = v7
    });
    v8:PlayAll();
end;

function v1.killrin(u20) -- Line: 240
    -- upvalues: camerasreplication (copy), ReplicatedStorage2 (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), PlayerGui (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Lighting (copy), TweenService (copy), Brightness (copy), TekrinnDialogue (copy)
    local v21 = u20.HumanoidRootPart or u20.PrimaryPart;
    camerasreplication.evilCamera(v21, ReplicatedStorage2.Resources.sae.evilsaecam, ReplicatedStorage2.Resources.sae.killFov);
    mainreplication.sceneEnabled(true);
    local v22;

    if u20:GetAttribute("femlock") then
        v22 = ReplicatedStorage2.Resources.sae.Femvoicelines.elasticornp;
    else
        v22 = ReplicatedStorage2.Resources.sae.NIICHAN;
    end;

    soundUtil:play(v22, SoundService);
    local u23 = ReplicatedStorage2.Resources.sae.glowscreen:Clone();
    u23.Parent = PlayerGui;
    local ImageLabel2 = u23.ImageLabel2;
    ImageLabel2.ImageTransparency = 0.3;
    local u24 = ReplicatedStorage2.Resources.sae.allNEWSAE:Clone();
    u24:PivotTo(v21.CFrame);
    u24.Parent = u20;

    if Util.canshiftcolor(LocalPlayer, u20) then
        vfxUtil.LeanTowardsColor(u24, u20:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u20:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u25 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u25.Parent = Lighting;
    u25.FarIntensity = 0;
    TweenService:Create(u25, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    local Motor6D = Instance.new("Motor6D");
    local Motor6D2 = Instance.new("Motor6D");
    local u26 = ReplicatedStorage2.Resources.sae.M1911:Clone();
    local u27 = ReplicatedStorage2.Resources.sae.Mag2:Clone();
    task.delay(8.333333333333334, function() -- Line: 278
        -- upvalues: u24 (copy)
        u24:Destroy();
    end);
    task.delay(8.95, function() -- Line: 282
        -- upvalues: u24 (copy), u26 (copy), u20 (copy), Motor6D (copy)
        u24:Destroy();
        u26.Parent = u20;
        Motor6D.Part0 = u20["Right Arm"];
        Motor6D.Part1 = u26.Handle;
        Motor6D.C0 = CFrame.new(
            -0.171947479,
            -0.855709791,
            -0.48810637,
            1,
            4.37111645e-8,
            1.14168252e-7,
            -1.14440311e-7,
            0.00624597399,
            0.999979854,
            4.29970157e-8,
            -0.999979854,
            0.00624597399
        );
        Motor6D.Parent = u20["Right Arm"];
    end);
    task.delay(9.716666666666667, function() -- Line: 291
        -- upvalues: u27 (copy), u20 (copy), Motor6D2 (copy)
        u27.Parent = u20;
        Motor6D2.Part0 = u20["Left Arm"];
        Motor6D2.Part1 = u27;
        Motor6D2.C0 = CFrame.new(
            0.107273102,
            -0.897750378,
            -0.541144371,
            3.70044582e-8,
            1.25804888e-7,
            1,
            -0.959359348,
            0.282187521,
            4.96940951e-21,
            -0.282187521,
            -0.959359348,
            1.31134044e-7
        );
        Motor6D2.Parent = Motor6D2.Part0;
    end);
    task.delay(10, function() -- Line: 299
        -- upvalues: u27 (copy), Motor6D2 (copy)
        u27:Destroy();
        Motor6D2:Destroy();
    end);
    task.delay(15.416666666666666, function() -- Line: 304
        -- upvalues: u23 (copy), u25 (copy), ColorCorrectionEffect (copy), Lighting (ref), Brightness (ref), mainreplication (ref), u26 (copy), Motor6D (copy)
        u23:Destroy();
        u25:Destroy();
        ColorCorrectionEffect:Destroy();
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        mainreplication.ultFlash(1, 0.3);
        u26:Destroy();
        Motor6D:Destroy();
        mainreplication.sceneEnabled(false);
    end);
    task.delay(3.983, function() -- Line: 316
        -- upvalues: TekrinnDialogue (ref), u20 (copy)
        TekrinnDialogue.Speak(u20, {
            {
                Text = "If you keep behaving like you\'re my little brother...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 5);
    end);
    task.delay(1.083, function() -- Line: 342
        -- upvalues: u24 (copy)
        for _, descendant in ipairs(u24.att1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.083, function() -- Line: 350
        -- upvalues: u24 (copy)
        for _, descendant in ipairs(u24.att1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u28 = nil;
    task.delay(1.283, function() -- Line: 360
        -- upvalues: ImageLabel2 (copy), u28 (ref), ReplicatedStorage2 (ref), u20 (copy), u24 (copy)
        ImageLabel2.ImageTransparency = 1;
        u28 = ReplicatedStorage2.Resources.sae.ratrail:Clone();
        u28.Weld.Part0 = u20["Right Arm"];
        u28.Parent = u24;
        u24.bgblack.Transparency = 1;

        for _, descendant in ipairs(u24.LOM:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.1, function() -- Line: 376
        -- upvalues: ImageLabel2 (copy), u28 (ref)
        ImageLabel2.ImageTransparency = 0.3;
        u28:Destroy();
    end);
    task.delay(6.117, function() -- Line: 381
        -- upvalues: ImageLabel2 (copy)
        ImageLabel2.ImageTransparency = 1;
    end);
end;

function v1.reflexaurabbbttt(p29, p30) -- Line: 388
    -- upvalues: PlayerGui (copy)
    if not p29.HumanoidRootPart then
        local _ = p29.PrimaryPart;
    end;

    local Hotbar = PlayerGui.Hotbar;
    Hotbar.MagicHealth.saeText.Text = p30 and "REFLEX" or "LOGIC";

    if p30 then
        Hotbar.MagicHealth.saeText.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 0.498039)), ColorSequenceKeypoint.new(1, Color3.new(0, 0.666667, 0.498039)) });

        return;
    end;

    Hotbar.MagicHealth.saeText.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0.333333, 0.498039)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.333333, 0.498039)) });
end;

function v1.saeSteal(u31) -- Line: 411
    -- upvalues: Lighting (copy), ReplicatedStorage2 (copy), PlayerGui (copy), MeshEmitter (copy), Util (copy), workspace_CurrentCamera (copy), mainreplication (copy), LocalPlayer (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy), RunService (copy), TekrinnDialogue (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), EnvironmentDiffuseScale (copy), EnvironmentSpecularScale (copy), Density (copy), Color (copy)
    local v32 = u31.HumanoidRootPart or u31.PrimaryPart;
    u31:FindFirstChild("Ball");
    local _ = u31.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local u33 = ReplicatedStorage2.Resources.vb:Clone();
    u33.Parent = PlayerGui;
    local u34 = ReplicatedStorage2.Resources.glowscreen:Clone();
    u34.Parent = PlayerGui;
    u34.ImageLabel2.ImageTransparency = 0;
    u34.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 2;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 2.627;
    local v35 = { MeshEmitter.StartMeshEmitter(v32, ReplicatedStorage2.Resources.sae["saeitoshi MeshEmitter"], nil).ColorCorrection };

    for _, v in ipairs(v35) do
        if not Util.isepilepsysafe() then
            v.Parent = workspace_CurrentCamera;
        end;

        task.delay(30, function() -- Line: 440
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    local u36 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u36.Parent = Lighting;
    u36.FarIntensity = 1;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1, 1, true);
    local u37 = ReplicatedStorage2.Resources.sae.saeStealEffect:Clone();
    u37:PivotTo(v32.CFrame);
    u37.Parent = u31;

    if Util.canshiftcolor(LocalPlayer, u31) then
        vfxUtil.LeanTowardsColor(u37, u31:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u31:GetAttribute("CustomAlpha") or 0.985);
    end;

    local Attribute = u31:GetAttribute("femlock");
    local v38;

    if Attribute then
        v38 = ReplicatedStorage2.Resources.sae.Femvoicelines.autosteal;
    else
        v38 = ReplicatedStorage2.Resources.sae["saeshipushed (1)"];
    end;

    local u39 = Attribute or soundUtil:play(v38, SoundService, {
        Character = u31
    }).Name == "Dub";
    mainreplication.cutscene(v32, nil, 6.517, ReplicatedStorage2.Resources.sae.saeStealFOV);
    local u40 = ReplicatedStorage2.Resources.sae.camEffectSteal:Clone();
    u40.Parent = u37;
    local u41 = nil;
    u41 = RunService.PreRender:connect(function() -- Line: 468
        -- upvalues: u40 (copy), u41 (ref)
        if u40:IsDescendantOf(game) then
            u40:PivotTo(workspace.CurrentCamera.CFrame);

            return;
        end;

        u41:Disconnect();
    end);
    task.delay(2.333, function() -- Line: 473
        -- upvalues: TekrinnDialogue (ref), u31 (copy), u39 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Text = u39 and "Lukewarm..." or "Still...",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3);
    end);
    task.delay(3.267, function() -- Line: 499
        -- upvalues: TekrinnDialogue (ref), u31 (copy), u39 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Text = u39 and "I knew it." or "Half Baked.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 87, 132)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            }
        }, 3);
    end);
    task.spawn(function() -- Line: 525
        -- upvalues: u37 (copy)
        for _, descendant in pairs(u37.saestealbg:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.06666666666666667, function() -- Line: 533
        -- upvalues: u37 (copy)
        for _, descendant in pairs(u37.saestepping:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.6833333333333333, function() -- Line: 541
        -- upvalues: u37 (copy)
        for _, descendant in pairs(u37.saestealbg:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.05;
            end;
        end;
    end);
    task.delay(4.35, function() -- Line: 549
        -- upvalues: u37 (copy)
        for _, descendant in pairs(u37.saestealbump:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.366666666666666, function() -- Line: 557
        -- upvalues: u40 (copy)
        for _, descendant in pairs(u40:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.8, function() -- Line: 565
        -- upvalues: u37 (copy)
        for _, descendant in pairs(u37.saestealbump:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.35;
            end;
        end;
    end);
    task.delay(6.517, function() -- Line: 574
        -- upvalues: u36 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), EnvironmentDiffuseScale (ref), EnvironmentSpecularScale (ref), Atmosphere (copy), Density (ref), Color (ref), u37 (copy), mainreplication (ref), u33 (copy), u34 (copy)
        u36:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.EnvironmentDiffuseScale = EnvironmentDiffuseScale;
        Lighting.EnvironmentSpecularScale = EnvironmentSpecularScale;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u37:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1, true);
        u33:Destroy();
        u34:Destroy();
    end);
end;

local function u43() -- Line: 614
    -- upvalues: Lighting (copy)
    local v42 = {};

    for _, child in Lighting:GetChildren() do
        table.insert(v42, child:Clone());
        child:Destroy();
    end;

    return v42;
end;

function v1.saeStealIsagi(u44, u45) -- Line: 625
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), mainreplication (copy), Util (copy), u43 (copy), soundUtil (copy), SoundService (copy), TweenService (copy), TekrinnDialogue (copy), ReplicatedStorage2 (copy), Debris (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), OutdoorAmbient (copy), EnvironmentDiffuseScale (copy), EnvironmentSpecularScale (copy), Density (copy), Color (copy)
    local v46 = u44.HumanoidRootPart or u44.PrimaryPart;
    local Ball = u44:FindFirstChild("Ball");
    local _ = u44.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local u47 = ReplicatedStorage.Resources.sae.IsagiSteal.CutsceneVFX:Clone();
    u47.Parent = v46;

    if Util.canshiftcolor(LocalPlayer, u44) then
        vfxUtil.LeanTowardsColor(u47, u44:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u44:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u48 = mainreplication.cutscene(v46, CFrame.new(), 14.666666666666666, ReplicatedStorage.Resources.sae.IsagiSteal.FOV);
    task.spawn(function() -- Line: 640
        -- upvalues: Util (ref), ReplicatedStorage (ref), u48 (copy)
        Util.CameraEffect(ReplicatedStorage.Resources.sae.IsagiSteal.CameraEffect, u48);
    end);
    mainreplication.sceneEnabled(true);
    local u49 = u43();

    for _, child in ReplicatedStorage.Resources.sae.IsagiSteal.newlight:Clone():GetChildren() do
        child.Parent = Lighting;
    end;

    local Attribute = u44:GetAttribute("femlock");
    local v50;

    if Attribute then
        v50 = ReplicatedStorage.Resources.sae.Femvoicelines.isagiinteraction;
    else
        v50 = ReplicatedStorage.Resources.sae.attacker;
    end;

    local v51 = soundUtil:play(v50, SoundService, {
        Character = u44
    });
    local u52 = {};

    for _, v in { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" } do
        local v53 = u45:FindFirstChild(v);

        if v53 then
            for _, child in ReplicatedStorage.Resources.sae.IsagiSteal.Speedlines:GetChildren() do
                local v54 = child:Clone();
                v54.Parent = v53;
                table.insert(u52, v54);
            end;
        end;
    end;

    Lighting.Brightness = 2;
    Lighting.Ambient = Color3.fromRGB(187, 205, 217);
    Lighting.EnvironmentDiffuseScale = 0;
    Lighting.EnvironmentSpecularScale = 0;
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ExposureCompensation = 1.5;
    Lighting.StealCC.Brightness = -0.7;
    Lighting.StealCC.TintColor = Color3.fromRGB(255, 53, 124);
    local u55 = ReplicatedStorage.Resources.sae.IsagiSteal.EyeFx:Clone();
    u55.Parent = u44.Head;
    local u56 = ReplicatedStorage.Resources.sae.IsagiSteal.CrossHair:Clone();
    u56.Parent = Ball;
    mainreplication.BetterEnable(u56, false);
    mainreplication.BetterEnable(u55, false);
    mainreplication.BetterEnable(u47, false);
    task.delay(1, function() -- Line: 693
        -- upvalues: TweenService (ref), Lighting (ref), u47 (copy)
        TweenService:Create(Lighting.StealCC, TweenInfo.new(0.36666666666666664), {
            Brightness = 0,
            TintColor = Color3.new(1, 1, 1)
        }):Play();

        for _, descendant in pairs(u47.Step:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);

    if Attribute or v51.Name == "Dub" then
        task.delay(0.32, function() -- Line: 705
            -- upvalues: TekrinnDialogue (ref), u45 (copy)
            TekrinnDialogue.Speak(u45, {
                {
                    Text = "No!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 6);
        end);
        task.delay(1.424, function() -- Line: 731
            -- upvalues: TekrinnDialogue (ref), u45 (copy)
            TekrinnDialogue.Speak(u45, {
                {
                    Text = "Not yet, ",
                    Bold = false,
                    Italic = false,
                    Pause = 0.7109999999999999,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = "I won\'t let this chance to go waste!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 4.038
                    }
                }
            }, 6);
        end);
        task.delay(6.792, function() -- Line: 780
            -- upvalues: TekrinnDialogue (ref), u45 (copy)
            TekrinnDialogue.Speak(u45, {
                {
                    Text = "Just the tip of my toe will do!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 6);
        end);
        task.delay(8.999, function() -- Line: 806
            -- upvalues: TekrinnDialogue (ref), u45 (copy)
            TekrinnDialogue.Speak(u45, {
                {
                    Text = "Just one more ",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.1,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = "step!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.1,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 6);
        end);
        task.delay(11.244, function() -- Line: 853
            -- upvalues: TekrinnDialogue (ref), u44 (copy)
            TekrinnDialogue.Speak(u44, {
                {
                    Text = "You\'re eyesores.",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 5
                    }
                }
            }, 1.3770000000000007);
        end);
    else
        task.delay(0.32, function() -- Line: 879
            -- upvalues: TekrinnDialogue (ref), u45 (copy)
            TekrinnDialogue.Speak(u45, {
                {
                    Text = "No!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 6);
        end);
        task.delay(1.59, function() -- Line: 905
            -- upvalues: TekrinnDialogue (ref), u45 (copy)
            TekrinnDialogue.Speak(u45, {
                {
                    Text = "Not yet,",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = " The moment isn\'t over yet!",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 6);
        end);
        task.delay(4.3, function() -- Line: 952
            -- upvalues: TekrinnDialogue (ref), u45 (copy)
            TekrinnDialogue.Speak(u45, {
                {
                    Text = "If I reach out, I can ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = "score!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 6);
        end);
        task.delay(6.8, function() -- Line: 999
            -- upvalues: TekrinnDialogue (ref), u45 (copy)
            TekrinnDialogue.Speak(u45, {
                {
                    Text = "Reach it!",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 6);
        end);
        task.delay(8, function() -- Line: 1025
            -- upvalues: TekrinnDialogue (ref), u45 (copy)
            TekrinnDialogue.Speak(u45, {
                {
                    Text = "My very... last ",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.1,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = "step!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.1,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 6);
        end);
        task.delay(11, function() -- Line: 1072
            -- upvalues: TekrinnDialogue (ref), u44 (copy)
            TekrinnDialogue.Speak(u44, {
                {
                    Text = "You\'re all eyesores.",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 5
                    }
                }
            }, 1.3);
        end);
    end;

    task.delay(12.6, function() -- Line: 1100
        -- upvalues: Lighting (ref)
        Lighting.ImpactCC.Enabled = true;
    end);
    task.delay(12.7, function() -- Line: 1104
        -- upvalues: Lighting (ref)
        Lighting.ImpactCC.Enabled = false;
    end);
    task.delay(1.4, function() -- Line: 1108
        -- upvalues: u47 (copy)
        for _, descendant in pairs(u47.Clash1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.3333333333333335, function() -- Line: 1116
        -- upvalues: ReplicatedStorage2 (ref), Lighting (ref), TweenService (ref), Debris (ref)
        local v57 = ReplicatedStorage2.Resources.DepthOfField:Clone();
        v57.Parent = Lighting;
        v57.FarIntensity = 0;
        TweenService:Create(v57, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FarIntensity = 1
        }):Play();
        Debris:AddItem(v57, 3);
    end);
    task.delay(3.6666666666666665, function() -- Line: 1126
        -- upvalues: u56 (copy)
        for _, descendant in pairs(u56:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.2, function() -- Line: 1134
        -- upvalues: mainreplication (ref), u52 (copy)
        mainreplication.BetterEnable(u52, true);
    end);
    task.delay(11.183333333333334, function() -- Line: 1138
        -- upvalues: mainreplication (ref), u52 (copy), u55 (copy)
        mainreplication.BetterEnable(u52, false);

        for _, descendant in pairs(u55:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(12.6, function() -- Line: 1147
        -- upvalues: u47 (copy), u55 (copy)
        for _, descendant in pairs(u47.Bump:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u55:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(14.666666666666666, function() -- Line: 1160
        -- upvalues: u47 (copy), u48 (copy), Lighting (ref), u49 (copy), u52 (copy), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), OutdoorAmbient (ref), EnvironmentDiffuseScale (ref), EnvironmentSpecularScale (ref), Atmosphere (copy), Density (ref), Color (ref), mainreplication (ref)
        u47:Destroy();

        if u48 then
            u48:Destroy();
        end;

        for _, child in Lighting:GetChildren() do
            child:Destroy();
        end;

        for _, v in u49 do
            v.Parent = Lighting;
        end;

        for _, v in u52 do
            v:Destroy();
        end;

        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.EnvironmentDiffuseScale = EnvironmentDiffuseScale;
        Lighting.EnvironmentSpecularScale = EnvironmentSpecularScale;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1, true);
    end);
end;

function v1.saeAwkPassIntercept(u58: userdata, p59: userdata, u60) -- Line: 1214
    -- upvalues: vfxUtil (copy), mainreplication (copy), LocalPlayer (copy), trove (copy), Util (copy), animationUtil (copy), soundUtil (copy), SoundService (copy), MoonPropertyAnimator (copy)
    if not (u58 and p59) then
        return;
    end;

    local Root = vfxUtil.getRoot(u58);
    local Root2 = vfxUtil.getRoot(p59);

    if not (Root and Root2) then
        return;
    end;

    local AwkPassIntercept = vfxUtil.getResources():WaitForChild("sae"):FindFirstChild("AwkPassIntercept");

    if not AwkPassIntercept then
        return;
    end;

    if typeof(u60) ~= "CFrame" then
        u60 = Root.CFrame;
    end;

    local CFrame2 = Root2.CFrame;
    Root.CFrame = Root2.CFrame;
    mainreplication.destroyVelocity(Root, LocalPlayer.Character == u58);
    mainreplication.destroyVelocity(Root2, LocalPlayer.Character == p59);
    Root.Anchored = true;
    Root2.Anchored = true;
    mainreplication.sceneEnabled(true);
    local v61 = trove.new();
    v61:AttachToInstance(u58);
    v61:AttachToInstance(p59);
    local Camera = AwkPassIntercept:FindFirstChild("Camera");
    local FOV = AwkPassIntercept:FindFirstChild("FOV");
    local v62, v63 = mainreplication.cutsceneCamRigWithLetterBox(Root, Camera, FOV, u58, "default");
    v61:Add(v63);
    v61:Add(function() -- Line: 1254
        -- upvalues: mainreplication (ref), Root (copy), Root2 (copy), u58 (copy), u60 (copy), CFrame2 (copy), LocalPlayer (ref)
        mainreplication.sceneEnabled(false);
        Root.Anchored = false;
        Root2.Anchored = false;
        u58:PivotTo(u60);
        Root.CFrame = u60;
        Root2.CFrame = CFrame2;

        if LocalPlayer.Character == u58 then
            mainreplication.destroyVelocity(Root, true);
        end;
    end);
    v61:Add(task.delay(3.43, v61.Destroy, v61));
    local v64 = v61:Clone(AwkPassIntercept.domain);
    v64.CFrame = Root.CFrame * CFrame.new(-4.174, 5.323, -2.681);
    v64.Parent = workspace.Effects;

    if Util.canshiftcolor(LocalPlayer, u58) then
        vfxUtil.LeanTowardsColor(v64, u58:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u58:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u65 = v61:Clone(AwkPassIntercept.Point);
    u65.CFrame = Root.CFrame * CFrame.new(-0.642, 2.739, 1.272);
    u65.Parent = workspace.Effects;
    local v66 = v61:Clone(AwkPassIntercept:FindFirstChild("Ball"));
    v66:FindFirstChildOfClass("Motor6D").Part0 = Root;
    v66.Parent = u58;
    v61:Add(animationUtil:loadAnimation(u58, AwkPassIntercept.Sae), "Stop"):Play();
    v61:Add(animationUtil:loadAnimation(p59, AwkPassIntercept.Chigiri), "Stop"):Play();
    soundUtil:play(AwkPassIntercept.veraiswatching, SoundService, {
        Character = u58
    });
    local Head = u58:FindFirstChild("Head");
    local u67 = v61:Clone(AwkPassIntercept.EyeFX);
    u67.Parent = Head;
    local camera = v62:FindFirstChild("camera");
    local CameraVFX = AwkPassIntercept:FindFirstChild("CameraVFX");

    if camera and CameraVFX then
        for _, child in CameraVFX:GetChildren() do
            v61:Clone(child).Parent = camera;
        end;
    end;

    local v68 = {
        Vignette = v61:Add(vfxUtil.getMoonEffects()).Vignette
    };

    if AwkPassIntercept:FindFirstChild("Lighting") then
        vfxUtil.contain_lighting(v61, v68, AwkPassIntercept.Lighting);
    end;

    local v69 = v61:Construct(MoonPropertyAnimator);
    v69:LoadAndConvertSave(AwkPassIntercept.Moon, v68);
    v69:SetRoot(Root);
    v69:PlayAll();
    v61:Add(task.delay(0.65, function() -- Line: 1321
        -- upvalues: u67 (copy)
        shared.vfx.emit(u67.Right.flames, u67.Left.flames);
    end));
    v61:Add(task.delay(1.9, function() -- Line: 1325
        -- upvalues: u65 (copy)
        shared.vfx.emit(u65);
    end));
end;

function v1.thatsaejiggywithit(p70) -- Line: 1330
    -- upvalues: mainreplication (copy), Players (copy), ReplicatedStorage2 (copy), Lighting (copy), TweenService (copy), soundUtil (copy)
    if not p70 then
        return;
    end;

    local HumanoidRootPart = p70:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    mainreplication.highlight(p70, Color3.fromRGB(255, 255, 255), 1.75, nil, 0);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p70) then
        mainreplication.springcamerashake(30, 20);
        mainreplication.fov(false, 90);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        local v71 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
        v71.Parent = Lighting;
        v71.TintColor = Color3.fromRGB(255, 255, 255);
        v71.Brightness = -0.175;
        v71.Contrast = 0.1;
        v71.Saturation = -0.4;
        TweenService:Create(v71, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v71, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end;

    soundUtil:play(ReplicatedStorage2.Resources.Feint, HumanoidRootPart);
end;

local u72 = {};
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "saeawkvideo";
ScreenGui.IgnoreGuiInset = true;
ScreenGui.ScreenInsets = Enum.ScreenInsets.None;
ScreenGui.DisplayOrder = 100;
ScreenGui.ResetOnSpawn = false;
ScreenGui.Enabled = false;
local VideoFrame = Instance.new("VideoFrame");
VideoFrame.Size = UDim2.fromScale(1, 1);
VideoFrame.BackgroundColor3 = Color3.new(0, 0, 0);
VideoFrame.BorderSizePixel = 0;
VideoFrame.Video = "rbxassetid://132348416375326";
VideoFrame.Parent = ScreenGui;
ScreenGui.Parent = PlayerGui;
task.spawn(ContentProvider.PreloadAsync, ContentProvider, { VideoFrame });

local function play_awk_video(p73) -- Line: 1380
    -- upvalues: trove (copy), SoundService (copy), RunService (copy), VideoFrame (copy), ScreenGui (copy), CollectionService (copy)
    local u74 = trove.new();
    local u75 = nil;

    for _, child in SoundService:GetChildren() do
        if child.Name == "UltimateTheme" then
            u75 = child;
        end;
    end;

    if u75 then
        local Volume = u75.Volume;
        u75.Volume = 0;
        u74:Add(function() -- Line: 1392
            -- upvalues: u75 (ref), Volume (copy)
            u75.Volume = Volume;
        end);
        u74:Connect(RunService.Heartbeat, function() -- Line: 1395
            -- upvalues: VideoFrame (ref), u75 (ref), Volume (copy)
            local math_clamp_ret = math.clamp(1 - (VideoFrame.TimeLength - VideoFrame.TimePosition) / 0.15, 0, 1);
            u75.Volume = Volume * math_clamp_ret * math_clamp_ret;
        end);
    end;

    VideoFrame.TimePosition = 0;
    ScreenGui.Enabled = true;
    VideoFrame:Play();
    u74:Add(function() -- Line: 1405
        -- upvalues: VideoFrame (ref), ScreenGui (ref)
        VideoFrame:Pause();
        ScreenGui.Enabled = false;
    end);
    u74:Connect(VideoFrame.Ended, function() -- Line: 1409
        -- upvalues: u74 (copy)
        u74:Destroy();
    end);
    u74:Connect(p73.Changed, function(p76) -- Line: 1412
        -- upvalues: u74 (copy)
        if p76 then
            u74:Destroy();
        end;
    end);
    u74:Connect(CollectionService:GetInstanceAddedSignal("DialogueUI"), function(p77) -- Line: 1417
        -- upvalues: ScreenGui (ref)
        p77.DisplayOrder = ScreenGui.DisplayOrder + 1;
    end);
end;

function v1.saeawkvideo(p78) -- Line: 1422
    -- upvalues: u72 (copy)
    u72[p78] = true;
end;

function v1.saeAwk(u79, p80, p81) -- Line: 1426
    -- upvalues: Lighting (copy), mainreplication (copy), trove (copy), u72 (copy), ReplicatedStorage2 (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), play_awk_video (copy), TekrinnDialogue (copy), RunService (copy), Density (copy), Color (copy), Brightness (copy)
    local v82 = u79.HumanoidRootPart or u79.PrimaryPart;
    local _ = u79.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.bright(-1, 0.55);
    mainreplication.sceneEnabled(true);
    local u83 = trove.new();
    u83:AttachToInstance(u79);
    local v84 = u72[u79];
    u72[u79] = nil;
    local u85 = u83:Clone(ReplicatedStorage2.Resources.Blur);
    u85.Size = 0;
    u85.Parent = Lighting;
    local v86 = u83:Clone(ReplicatedStorage2.Resources.sae.glowscreen);
    v86.Parent = PlayerGui;

    if u79:GetAttribute("RinNoPlay") then
        if not v84 then
            soundUtil:play(ReplicatedStorage2.Resources.kaiser.dribblecounter, SoundService);
            u83:Add(task.delay(1.2, function() -- Line: 1453
                -- upvalues: soundUtil (ref), ReplicatedStorage2 (ref), SoundService (ref)
                soundUtil:play(ReplicatedStorage2.Resources.sae.ouchie, SoundService);
            end));
        end;

        if p81 then
            local v87 = p81.HumanoidRootPart or p81.PrimaryPart;
            local v88 = u83:Clone(ReplicatedStorage2.Resources.Ball);
            v88.Parent = p81;
            v88:FindFirstChildOfClass("Motor6D").Part0 = v87;
            v88:FindFirstChildOfClass("Motor6D").Parent = v87;
        end;
    end;

    local ImageLabel2 = v86.ImageLabel2;
    ImageLabel2.ImageTransparency = 0;
    local u89 = u83:Clone(ReplicatedStorage2.Resources.sae.newsaeawkya.effectawk);
    u89:PivotTo(v82.CFrame);
    u89.Parent = u79;

    if Util.canshiftcolor(LocalPlayer, u79) then
        vfxUtil.LeanTowardsColor(u89, u79:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u79:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u89:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local v90 = u83:Clone(ReplicatedStorage2.Resources.DepthOfField);
    v90.Parent = Lighting;
    v90.FarIntensity = 0;
    TweenService:Create(v90, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    u83:Add(ColorCorrectionEffect);
    local Attribute = u79:GetAttribute("femlock");
    local v91;

    if v84 then
        v91 = nil;
    else
        local v92;

        if Attribute then
            v92 = ReplicatedStorage2.Resources.sae.Femvoicelines.awk;
        else
            v92 = ReplicatedStorage2.Resources.sae["Itoshi lock in"];
        end;

        v91 = soundUtil:play(v92, SoundService, {
            Character = u79
        });
    end;

    Util.flowCancel(u83, p80, { v91 });

    if v84 then
        play_awk_video(p80);
    end;

    u83:Add((mainreplication.cutscene(v82, CFrame.identity, 10.55, ReplicatedStorage2.Resources.sae.FOV)));
    local v93 = u83:Clone(ReplicatedStorage2.Resources.sae.newsaeawkya.eyesangle);
    v93.Weld.Part0 = u79.Head;
    v93.Parent = u89;

    for _, descendant in ipairs(u89.CAMERAPARTstart:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    if v91 and (Attribute or v91.Name == "Dub") then
        u83:Add(task.delay(1.61, function() -- Line: 1520
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u79 (copy)
            u83:Add(TekrinnDialogue.Speak(u79, {
                {
                    Text = "I\'m taking this game to the next level.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 4));
        end));
        u83:Add(task.delay(4.845, function() -- Line: 1546
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u79 (copy)
            u83:Add(TekrinnDialogue.Speak(u79, {
                {
                    Text = "Only the",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                },
                {
                    Text = " idiots",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(253, 255, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 74, 116)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                },
                {
                    Text = " who can keep up with me..",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 4));
        end));
        u83:Add(task.delay(8.571, function() -- Line: 1614
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u79 (copy)
            u83:Add(TekrinnDialogue.Speak(u79, {
                {
                    Text = ".. will be able to witness what comes next.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 73, 112)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 1.35
                    }
                }
            }, 2.4670000000000005));
        end));
    else
        u83:Add(task.delay(1.75, function() -- Line: 1641
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u79 (copy)
            u83:Add(TekrinnDialogue.Speak(u79, {
                {
                    Text = "I\'m taking this game to the next level.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 4));
        end));
        u83:Add(task.delay(4.883, function() -- Line: 1667
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u79 (copy)
            u83:Add(TekrinnDialogue.Speak(u79, {
                {
                    Text = "Only the",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                },
                {
                    Text = " idiots",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(253, 255, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 74, 116)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                },
                {
                    Text = " who can keep up with me.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 4));
        end));
        u83:Add(task.delay(8.767, function() -- Line: 1735
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u79 (copy)
            u83:Add(TekrinnDialogue.Speak(u79, {
                {
                    Text = "will get to see what comes next.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 73, 112)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 1.35
                    }
                }
            }, 1.35));
        end));
    end;

    u83:Add(task.delay(0.55, function() -- Line: 1765
        -- upvalues: ImageLabel2 (copy), u89 (copy)
        ImageLabel2.ImageTransparency = 1;
        u89.CAMERAPARTstart:Destroy();
    end));
    u83:Add(task.delay(0.667, function() -- Line: 1771
        -- upvalues: u89 (copy)
        for _, descendant in ipairs(u89.step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u83:Add(task.delay(0.933, function() -- Line: 1779
        -- upvalues: u89 (copy)
        for _, descendant in ipairs(u89.step2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u83:Add(task.delay(1.05, function() -- Line: 1787
        -- upvalues: u89 (copy)
        for _, descendant in ipairs(u89.step3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u83:Add(task.delay(1.183, function() -- Line: 1795
        -- upvalues: u89 (copy)
        for _, descendant in ipairs(u89.step4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u83:Add(task.delay(1.517, function() -- Line: 1803
        -- upvalues: u85 (copy), TweenService (ref), ColorCorrectionEffect (copy)
        u85.Size = 25;
        TweenService:Create(u85, TweenInfo.new(0.783, Enum.EasingStyle.Linear), {
            Size = 5
        }):Play();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 225, 241);
        ColorCorrectionEffect.Brightness = -1;
        ColorCorrectionEffect.Contrast = 1;
        ColorCorrectionEffect.Saturation = -0.8;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.516, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.466, Enum.EasingStyle.Linear), {
            Saturation = -0.4
        }):Play();
    end));
    u83:Add(task.delay(2.783, function() -- Line: 1816
        -- upvalues: TweenService (ref), u85 (copy), u83 (copy)
        local v94 = TweenService:Create(u85, TweenInfo.new(0.084, Enum.EasingStyle.Linear), {
            Size = 25
        });
        v94:Play();
        u83:Connect(v94.Completed, function() -- Line: 1819
            -- upvalues: TweenService (ref), u85 (ref)
            TweenService:Create(u85, TweenInfo.new(0.983, Enum.EasingStyle.Linear), {
                Size = 0
            }):Play();
        end);
        u83:Add(v94);
    end));
    u83:Add(task.delay(2.817, function() -- Line: 1825
        -- upvalues: u89 (copy)
        for _, descendant in ipairs(u89.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u83:Add(task.delay(2.983, function() -- Line: 1833
        -- upvalues: TweenService (ref), Atmosphere (copy), Lighting (ref), ColorCorrectionEffect (copy), u79 (copy), ReplicatedStorage2 (ref), u83 (copy), u89 (copy), RunService (ref)
        TweenService:Create(Atmosphere, TweenInfo.new(0.334, Enum.EasingStyle.Linear), {
            Density = 0.315,
            Color = Color3.fromRGB(255, 106, 138)
        }):Play();
        TweenService:Create(Lighting, TweenInfo.new(0.334, Enum.EasingStyle.Linear), {
            Brightness = 3,
            ColorShift_Top = Color3.fromRGB(255, 82, 183)
        }):Play();
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.534, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 103, 174)
        }):Play();

        for _, child in ipairs(u79:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v95 = child;

                for _, child2 in ipairs(ReplicatedStorage2.Resources.sae.auraya:GetChildren()) do
                    u83:Clone(child2).Parent = v95;
                end;
            end;
        end;

        for _, descendant in ipairs(u89.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u89.step6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
                descendant.Enabled = true;
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    TimeScale = 0.05
                }):Play();
            end;
        end;

        local u96 = u83:Clone(ReplicatedStorage2.Resources.sae.newsaeawkya.CAMERAPART);
        u96.Parent = u89;

        for _, descendant in ipairs(u96:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        local u97 = nil;
        u97 = u83:Connect(RunService.PreRender, function() -- Line: 1891
            -- upvalues: u96 (copy), u97 (ref)
            if u96:IsDescendantOf(game) then
                u96.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -0.1) * CFrame.Angles(0, 0, -0.7853981633974483);

                return;
            end;

            u97:Disconnect();
        end);
    end));
    u83:Add(task.delay(3.05, function() -- Line: 1902
        -- upvalues: u89 (copy)
        for _, descendant in ipairs(u89.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u83:Add(task.delay(4.283, function() -- Line: 1910
        -- upvalues: u85 (copy), TweenService (ref), ColorCorrectionEffect (copy), ImageLabel2 (copy), u89 (copy)
        u85.Size = 25;
        TweenService:Create(u85, TweenInfo.new(0.284, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 103, 174);
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.Saturation = -0.8;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Contrast = 1,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 103, 174)
        }):Play();
        ImageLabel2.ImageTransparency = 0.6;

        for _, descendant in ipairs(u89.aura1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u89.step6:Destroy();
    end));
    u83:Add(task.delay(8.6, function() -- Line: 1937
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref), ReplicatedStorage2 (ref), u79 (copy), u89 (copy), u85 (copy)
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        local v98 = ReplicatedStorage2.Resources.sae.newsaeawkya.eyeaura:Clone();
        v98.Weld.Part0 = u79.Head;
        v98.Parent = u89;

        for _, descendant in ipairs(u89.BeamDAD:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u85.Size = 25;
        TweenService:Create(u85, TweenInfo.new(0.767, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end));
    u83:Add(vfxUtil.getScreenDimmer());
    u83:Add(function() -- Line: 1957
        -- upvalues: Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), ImageLabel2 (copy), mainreplication (ref)
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        ImageLabel2:Destroy();
        mainreplication.ultFlash(-1, 0.7);
        mainreplication.sceneEnabled(false);
        mainreplication.fov(false, 30);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
    u83:Add(task.delay(10.55, function() -- Line: 1974
        -- upvalues: u83 (copy)
        u83:Destroy();
    end));
end;

function v1.sae_intercept_flow(u99, p100, u101) -- Line: 1979
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), Util (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(u99);
    vfxUtil.getRoot(u101);
    local v102 = vfxUtil.character_trove(u99);
    local AirFlow = vfxUtil.getResources().sae.AirFlow;
    mainreplication.sceneEnabled(true);
    local Ball = u99:FindFirstChild("Ball");
    v102:Add(function() -- Line: 1991
        -- upvalues: mainreplication (ref), Ball (copy)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);

        if Ball then
            Ball.Transparency = 0;
            Ball.Name = "Ball";
        end;
    end);
    v102:Add(task.delay(5.26, v102.Destroy, v102));
    v102:Construct(vfxUtil.getMoonEffects);
    local u103 = v102:Clone(AirFlow.VFX);
    u103:PivotTo(Root.CFrame);
    u103.Parent = u99;
    local v104 = v102:Construct(AirFlow.Aura);
    vfxUtil.setupAura(u99, v104, true, true);
    v104.Parent = workspace.Effects;
    local v105 = v102:Add(v104["azl ballllllls_rig"]);
    v105.Ball.Ball.Part0 = Root;
    v105.Parent = u99;

    if Ball then
        Ball.Transparency = 1;
        Ball.Name = "Temp";
    end;

    v102:Add(task.spawn(function() -- Line: 2020
        -- upvalues: u103 (copy), Root (copy)
        for _, v in u103:QueryDescendants("Weld") do
            v.Part1 = Root;
        end;
    end));
    local v106 = soundUtil:play(AirFlow.sound, "default");

    if p100 then
        Util.flowCancel(v102, p100, { v106 });
    end;

    local v107, v108 = mainreplication.cutsceneCamRigWithLetterBox(Root, AirFlow.CamAnim, AirFlow.FOV, nil, "default", AirFlow.Cam, "CamPart");
    v107:SetAttribute("FPS", 120);
    v102:Add(v108);
    vfxUtil.execute_compiled_ex(AirFlow.Compiled, v102, 120, v107, u99);
    v102:Add(task.spawn(function() -- Line: 2044
        -- upvalues: TekrinnDialogue (ref), u101 (copy), u99 (copy)
        TekrinnDialogue.Speak(u101, {
            {
                Text = "Huh?! ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                HigherUp = false,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 4
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            },
            {
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                HigherUp = true,
                Text = u99.Name,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 4
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 127)) })
            }
        }, 2);
        task.delay(1.6666666666666667, function() -- Line: 2082
            -- upvalues: TekrinnDialogue (ref), u99 (ref)
            TekrinnDialogue.Speak(u99, {
                {
                    Text = "You\'re all ",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 4
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = "Eyesores.",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = true,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 4
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 127)) })
                }
            }, 2);
        end);
    end));
end;

return v1;