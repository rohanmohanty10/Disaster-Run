 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local v1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local Brightness = Lighting.Brightness;
local _ = Lighting.ClockTime;
local _ = Lighting.Ambient;
local _ = Lighting.Bloom.Threshold;
local _ = Lighting.ExposureCompensation;
local newmeshEmitter = require(script.Parent.Parent.newmeshEmitter);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.util.KatUtil);
local TekrinnDialogue = require(script.Parent.Parent.TekrinnDialogue);
local UwUEffects = require(ReplicatedStorage.util.UwUEffects);
local trove = require(ReplicatedStorage.forum.trove);
local BackgroundHighlight = require(ReplicatedStorage.client.replication.BackgroundHighlight);
local StyleData = vfxUtil.getStyleData("kaiser");

function v1.kaiserSuperStar(u2, p3) -- Line: 50
    -- upvalues: ReplicatedStorage (copy), vfxUtil (copy), Util (copy), mainreplication (copy), soundUtil (copy), TekrinnDialogue (copy), UwUEffects (copy)
    local HumanoidRootPart = u2:FindFirstChild("HumanoidRootPart");
    local HumanoidRootPart2 = p3:FindFirstChild("HumanoidRootPart");
    local kaiser = ReplicatedStorage.Resources.kaiser;

    if not (HumanoidRootPart and HumanoidRootPart2) then
        return;
    end;

    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local u4 = Util.Preload(kaiser.SuperStarImpact);
    mainreplication.bright(-1, 0.15);
    mainreplication.sceneEnabled(true);
    local v5, _ = mainreplication.cutscene(HumanoidRootPart, CFrame.new(), 12.4, kaiser.SuperStarFOV);
    Util.CameraEffect(kaiser.SuperStarCam, v5);
    local Attribute = u2:GetAttribute("femlock");
    local v6;

    if Attribute then
        v6 = kaiser.Femvoicelines.superstar;
    else
        v6 = kaiser.SuperStarSound;
    end;

    local u7 = Attribute or soundUtil:play(v6, ReplicatedStorage, {
        Character = u2
    }).Name == "Dub";

    local function getLine(p8, p9) -- Line: 73
        -- upvalues: u7 (copy)
        if u7 then
            p9 = p8 or p9;
        end;

        return p9;
    end;

    if not u7 then
        task.delay(5.7, function() -- Line: 78
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "Sorry...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.075,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 0.5,
                        Lifetime = 2
                    }
                }
            }, 1.5);
        end);
    end;

    task.delay(7.35, function() -- Line: 105
        -- upvalues: TekrinnDialogue (ref), u2 (copy), u7 (copy)
        TekrinnDialogue.Speak(u2, {
            {
                Text = "When it comes to physical contact...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.075,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 0.5,
                    Lifetime = 2
                }
            },
            {
                Bold = true,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u7 and "I WIN!" or "I GOT SPECIAL TRAINING!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 89, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 3.5);
    end);
    UwUEffects.createEffect({
        Character = u2,
        Victim = p3
    }, "KaiserSuperStar");
    task.delay(10, function() -- Line: 154
        -- upvalues: Util (ref), kaiser (copy)
        Util.Gif(kaiser.SuperStarImpact, 30);
    end);
    task.delay(12.4, function() -- Line: 158
        -- upvalues: ScreenDimmer (copy), u4 (copy), mainreplication (ref)
        ScreenDimmer:Destroy();
        u4:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash();
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function v1.kaiser_chemicals(u10: userdata, p11: userdata, p12: any) -- Line: 169
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), ReplicatedStorage (copy), TekrinnDialogue (copy), LocalPlayer (copy), mainreplication (copy), MoonPropertyAnimator (copy)
    local Chemical = vfxUtil.getResources().kaiser.Chemical;
    local u13 = u10.HumanoidRootPart or u10.PrimaryPart;

    if not p11.HumanoidRootPart then
        local _ = p11.PrimaryPart;
    end;

    u13.Anchored = true;
    local u14 = trove.new();
    u14:AttachToInstance(u10);
    local v15 = soundUtil:play(Chemical.SFX, ReplicatedStorage, {
        Character = u10
    });
    soundUtil:play(Chemical.MUS, ReplicatedStorage, {
        Character = u10
    });
    local u16 = v15.Name == "Dub";

    local function _(p17, p18) -- Line: 185
        -- upvalues: u16 (copy)
        if u16 then
            p18 = p17 or p18;
        end;

        return p18;
    end;

    u14:Add(task.delay(0.91, function() -- Line: 189
        -- upvalues: TekrinnDialogue (ref), u10 (copy), u16 (copy)
        TekrinnDialogue.Speak(u10, {
            {
                Bold = true,
                Italic = false,
                TypeSpeed = 0.075,
                Text = u16 and "IT\'S MINE NOW!" or "I\'ve got it!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 89, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 3.5);
    end));
    u14:Add(task.delay(3.436, function() -- Line: 223
        -- upvalues: TekrinnDialogue (ref), u10 (copy), u16 (copy)
        TekrinnDialogue.Speak(u10, {
            {
                Bold = true,
                Italic = false,
                TypeSpeed = 0.075,
                Text = u16 and "My impossible challenge," or "Everything\'s falling into place!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 3.5);
    end));
    u14:Add(task.delay(6.148, function() -- Line: 249
        -- upvalues: TekrinnDialogue (ref), u10 (copy), u16 (copy)
        TekrinnDialogue.Speak(u10, {
            {
                Bold = true,
                Italic = false,
                TypeSpeed = 0.075,
                Text = u16 and "SO LET\'S DO THIS!" or "SO LET\'S GO!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 3.5);
    end));
    u14:Add(task.delay(7.88, function() -- Line: 276
        -- upvalues: TekrinnDialogue (ref), u10 (copy)
        TekrinnDialogue.Speak(u10, {
            {
                Text = "YOU PIECE OF ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.075,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 5,
                    Lifetime = 2
                }
            },
            {
                Text = "TRASH!",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.075,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            }
        }, 3.5);
    end));

    if v15.Name == "Dub" then
        u14:Add(task.delay(15.75, function() -- Line: 325
            -- upvalues: TekrinnDialogue (ref), u10 (copy)
            TekrinnDialogue.Speak(u10, {
                {
                    Text = "loved....",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.075,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 10
                    }
                }
            }, 5);
        end));
        u14:Add(task.delay(17.005, function() -- Line: 352
            -- upvalues: TekrinnDialogue (ref), u10 (copy)
            TekrinnDialogue.Speak(u10, {
                {
                    Text = "I want to be loved....",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.075,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 10
                    }
                }
            }, 2.5);
        end));
    end;

    local Compiled = require(Chemical.Compiled);
    local v19 = u14:Add(Chemical.Effects:Clone());
    v19.Parent = workspace.Effects;
    local v20 = u14:Construct(Chemical.Kaiser);
    vfxUtil.setupAura(u10, v20, true);
    v20.Parent = u10;
    local v21 = u14:Construct(Chemical.Kiyora);
    vfxUtil.setupAura(p11, v21, true);
    v21.Parent = workspace.Effects;
    u14:Construct(Chemical.ScreenGui).Parent = LocalPlayer.PlayerGui;
    v19:PivotTo(u13.CFrame);

    if u10:FindFirstChild("Ball") then
        u10:FindFirstChild("Ball").Transparency = 1;
    end;

    mainreplication.sceneEnabled(true);
    u14:Add(function() -- Line: 403
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    local v22, _ = mainreplication.cutsceneBlender(u13, Chemical.Animations.Cam, Chemical.FOV, nil, nil, CFrame.new(0, -3, 0), Chemical.Cam);

    for _, v in Compiled do
        u14:Add(task.delay(v[1] / 60, v[2], v22, v21, v20, v19, p12));
    end;

    u14:Add(function() -- Line: 430
        -- upvalues: u13 (copy)
        u13.Anchored = false;
    end);
    u14:Add(task.delay(23.08, function() -- Line: 435
        -- upvalues: u14 (copy)
        u14:Destroy();
    end));
    local v23 = {
        Workspace = v19,
        Vignette = u14:Add(vfxUtil.getMoonEffects()).Vignette,
        Lighting = game:GetService("Lighting")
    };

    if Chemical:FindFirstChild("Lighting") then
        vfxUtil.cutscene_lighting(u14, v23, Chemical.Lighting, {
            Brightness = 3,
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            GlobalShadows = true,
            ShadowSoftness = 0.2,
            ExposureCompensation = 0,
            ClockTime = 14.5,
            GeographicLatitude = 0,
            Ambient = Color3.fromRGB(70, 70, 70),
            ColorShift_Top = Color3.new(0, 0, 0),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        });
    end;

    MoonPropertyAnimator.ConvertSave(Chemical.Moon, v23);
    local v24 = u14:Construct(MoonPropertyAnimator);
    v24:LoadAndConvertSave(Chemical.Moon, v23);
    v24:SetOriginalRoot(Chemical.Location.Value);
    v24:SetRoot(u13);
    v24:PlayAll();
end;

function v1.kaiserAwk(u25, p26, p27) -- Line: 471
    -- upvalues: Lighting (copy), mainreplication (copy), trove (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), Util (copy), TweenService (copy), LocalPlayer (copy), vfxUtil (copy), TekrinnDialogue (copy), Density (copy), Color (copy), Brightness (copy)
    local v28 = u25.HumanoidRootPart or u25.PrimaryPart;
    local _ = u25.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.bright(-1, 1);
    mainreplication.sceneEnabled(true);
    local u29 = trove.new();
    u29:AttachToInstance(u25);
    local v30;

    if u25:GetAttribute("femlock") then
        v30 = ReplicatedStorage.Resources.kaiser.Femvoicelines.ballflow;
    else
        v30 = ReplicatedStorage.Resources.kaiser.alkaiserawake_1;
    end;

    local v31 = { (soundUtil:play(v30, SoundService, {
            Character = u25
        })) };
    Util.flowCancel(u29, p27, v31);
    local u32 = u29:Clone(ReplicatedStorage.Resources.kaiser.ultEff);
    u32:PivotTo(v28.CFrame);
    u32.Parent = u25;
    local u33 = u29:Clone(ReplicatedStorage.Resources.kaiser.rose);
    u33.rose.Part0 = u25["Right Arm"];
    u33.Parent = u32;
    local v34 = u29:Clone(ReplicatedStorage.Resources.DepthOfField);
    v34.Parent = Lighting;
    v34.FarIntensity = 0;
    TweenService:Create(v34, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();

    if Util.canshiftcolor(LocalPlayer, u25) then
        vfxUtil.LeanTowardsColor(u32, u25:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u25:GetAttribute("CustomAlpha") or 0.985);
    end;

    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    u29:Add(ColorCorrectionEffect);
    u29:Add(Util.Preload(ReplicatedStorage.Resources.kaiser.ImpactFrame4));
    local _, v35 = mainreplication.cutsceneBlender(v28, ReplicatedStorage.Resources.kaiser.flowAnim2, ReplicatedStorage.Resources.kaiser.FOV2);
    u29:Add(v35);

    for _, descendant in pairs(u32.Rose:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.TimeScale = 1;
        end;
    end;

    for _, descendant in pairs(u32.Aura:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    u29:Add(task.delay(0.3, function() -- Line: 535
        -- upvalues: u29 (copy), TekrinnDialogue (ref), u25 (copy)
        u29:Add(TekrinnDialogue.Speak(u25, {
            {
                Text = "Get down on your knees...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 2.867));
    end));
    u29:Add(task.delay(2.867, function() -- Line: 561
        -- upvalues: u29 (copy), TekrinnDialogue (ref), u25 (copy)
        u29:Add(TekrinnDialogue.Speak(u25, {
            {
                Text = "Soccer Game.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 89, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 1
                }
            }
        }, 1));
    end));
    u29:Add(task.delay(0.4666666666666667, function() -- Line: 589
        -- upvalues: u32 (copy)
        for _, descendant in ipairs(u32.AMM1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u29:Add(task.delay(1.183333333333333, function() -- Line: 597
        -- upvalues: u32 (copy)
        for _, descendant in ipairs(u32.AMM2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u29:Add(task.delay(2.083333333333333, function() -- Line: 605
        -- upvalues: u32 (copy)
        for _, descendant in ipairs(u32.AMM3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u29:Add(task.delay(3.983333333333333, function() -- Line: 613
        -- upvalues: mainreplication (ref), u25 (copy), ReplicatedStorage (ref)
        mainreplication.Emit(u25.Head, ReplicatedStorage.Resources.kaiser.XD, 3);
    end));
    u29:Add(task.delay(4.383333333333333, function() -- Line: 617
        -- upvalues: u32 (copy)
        for _, descendant in ipairs(u32.JA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u29:Add(task.delay(5.033333333333333, function() -- Line: 625
        -- upvalues: u32 (copy)
        for _, descendant in ipairs(u32.Aura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u29:Add(task.delay(5.783333333333333, function() -- Line: 633
        -- upvalues: u32 (copy)
        for _, descendant in ipairs(u32.JA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u29:Add(task.delay(5.85, function() -- Line: 641
        -- upvalues: u32 (copy)
        for _, descendant in ipairs(u32.JA2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u29:Add(task.delay(5.85, function() -- Line: 649
        -- upvalues: u32 (copy), u33 (copy)
        for _, descendant in ipairs(u32.Rose:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u33.Transparency = 1;
    end));
    u29:Add(task.delay(6.183333333333333, function() -- Line: 658
        -- upvalues: u32 (copy), TweenService (ref)
        for _, descendant in pairs(u32.Rose:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.9;
                TweenService:Create(descendant, TweenInfo.new(1), {
                    TimeScale = 0.15
                }):Play();
            end;
        end;
    end));
    u29:Add(task.delay(5.766666666666667, function() -- Line: 669
        -- upvalues: u29 (copy), Util (ref), ReplicatedStorage (ref)
        u29:Add(Util.Gif(ReplicatedStorage.Resources.kaiser.ImpactFrame4, 30));
    end));
    local u36 = false;
    task.delay(p26 - 0.58, function() -- Line: 676
        -- upvalues: u36 (ref), mainreplication (ref)
        if not u36 then
            mainreplication.blackscene(0.58);
        end;
    end);
    u29:Add(task.delay(p26, function() -- Line: 682
        -- upvalues: u29 (copy)
        u29:Destroy();
    end));
    u29:Add(function() -- Line: 686
        -- upvalues: u36 (ref), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), mainreplication (ref)
        u36 = true;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        mainreplication.sceneEnabled(false);
        mainreplication.fov(false, 15);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function v1.kaiserexcuseme(u37, p38, p39) -- Line: 701
    -- upvalues: Lighting (copy), mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), trove (copy), Util (copy), newmeshEmitter (copy), workspace_CurrentCamera (copy), TweenService (copy), LocalPlayer (copy), vfxUtil (copy), TekrinnDialogue (copy), Brightness (copy)
    local Ball = u37:FindFirstChild("Ball");
    local v40 = u37.HumanoidRootPart or u37.PrimaryPart;
    local _ = u37.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local Attribute = u37:GetAttribute("femlock");
    local v41;

    if Attribute then
        v41 = ReplicatedStorage.Resources.kaiser.Femvoicelines.stealflow;
    else
        v41 = ReplicatedStorage.Resources.kaiser.kaiser_1;
    end;

    local v42 = soundUtil:play(v41, SoundService, {
        Character = u37
    });
    local u43 = Attribute or v42.Name == "Dub";
    local u44 = trove.new();
    u44:AttachToInstance(u37);
    Util.flowCancel(u44, p39, { v42 });
    local _, v45 = mainreplication.cutsceneBlender(v40, ReplicatedStorage.Resources.kaiser.excusecam, ReplicatedStorage.Resources.kaiser.ExcuseFOV);
    u44:Add(v45);
    local v46 = { u44:Add(newmeshEmitter.StartMeshEmitter(v40, ReplicatedStorage.Resources.kaiser.kaisacc, nil)).qewlrk };

    for _, v in ipairs(v46) do
        u44:Add(v);

        if not Util.isepilepsysafe() then
            v.Parent = workspace_CurrentCamera;
        end;
    end;

    local v47 = u44:Clone(ReplicatedStorage.Resources.DepthOfField);
    v47.Parent = Lighting;
    v47.FarIntensity = 0;
    TweenService:Create(v47, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local u48 = u44:Clone(ReplicatedStorage.Resources.kaiser.kaisa);
    u48:PivotTo(v40.CFrame);
    u48.rootpos.Weld.Part0 = v40;
    u48.Parent = u37;
    u48.rootpos.Ball.Weld.Part0 = Ball;

    if Ball then
        Ball.Size = Vector3.new(1.5, 1.5, 1.5);
    end;

    if Util.canshiftcolor(LocalPlayer, u37) then
        vfxUtil.LeanTowardsColor(u48, u37:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u37:GetAttribute("CustomAlpha") or 0.985);
    end;

    u44:Add(task.delay(0.08333333333333333, function() -- Line: 752
        -- upvalues: u48 (copy)
        for _, descendant in pairs(u48.rootpos.kaiserballglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u44:Add(task.delay(0.5, function() -- Line: 760
        -- upvalues: u48 (copy)
        for _, descendant in pairs(u48.rootpos.Ball.kaiserexcuseme:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u44:Add(task.delay(1.6333333333333333, function() -- Line: 768
        -- upvalues: u48 (copy)
        for _, descendant in pairs(u48.rootpos.Ball.emit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u48.rootpos.Ball.kaiserexcuseme:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u44:Add(task.delay(1.6666666666666667, function() -- Line: 782
        -- upvalues: u48 (copy)
        for _, descendant in pairs(u48.rootpos.kaiserballglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u44:Add(task.delay(3.216666666666667, function() -- Line: 790
        -- upvalues: u48 (copy)
        for _, descendant in pairs(u48.rootpos.kaiserlegslam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u48.rootpos.kaiserrunpartvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u44:Add(task.delay(3.85, function() -- Line: 804
        -- upvalues: u48 (copy)
        for _, descendant in pairs(u48.rootpos.grassemit05:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u44:Add(task.delay(3.933333333333333, function() -- Line: 812
        -- upvalues: u48 (copy)
        for _, descendant in pairs(u48.rootpos.kaiserdashemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u44:Add(task.delay(4.066666666666666, function() -- Line: 820
        -- upvalues: u48 (copy)
        for _, descendant in pairs(u48.rootpos.grassemit1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u44:Add(task.delay(4.133333333333334, function() -- Line: 828
        -- upvalues: u48 (copy)
        for _, descendant in pairs(u48.rootpos.kaiserballglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));

    local function _(p49, p50) -- Line: 837
        -- upvalues: u43 (copy)
        if u43 then
            p50 = p49 or p50;
        end;

        return p50;
    end;

    if u43 then
        u44:Add(task.delay(3.7, function() -- Line: 842
            -- upvalues: u44 (copy), TekrinnDialogue (ref), u37 (copy), u43 (copy)
            u44:Add(TekrinnDialogue.Speak(u37, {
                {
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Text = u43 and "Well, excuse me!" or "I\'m barging in!",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 89, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1
                    }
                }
            }, 2));
        end));
    end;

    local u51 = {};
    u44:Add(task.delay(4.35, function() -- Line: 871
        -- upvalues: u37 (copy), ReplicatedStorage (ref), u44 (copy), u51 (copy)
        for _, descendant in ipairs(u37:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v52 = descendant;

                for _, descendant2 in ipairs(ReplicatedStorage.Resources.kaiser.kaisaaura:GetDescendants()) do
                    local v53 = u44:Clone(descendant2);
                    v53.Parent = v52;
                    table.insert(u51, v53);
                end;
            end;
        end;
    end));
    u44:Add(task.delay(4.716666666666667, function() -- Line: 884
        -- upvalues: u48 (copy)
        for _, descendant in pairs(u48.rootpos.kaiserlegendemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u48.rootpos.kaiserrunpartvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    local u54 = false;
    task.delay(5, function() -- Line: 899
        -- upvalues: u54 (ref), mainreplication (ref)
        if not u54 then
            mainreplication.blackscene(1);
        end;
    end);
    u44:Add(task.delay(6.45, function() -- Line: 904
        -- upvalues: u48 (copy), u51 (copy)
        for _, descendant in pairs(u48.rootpos.kaiserballglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, v in u51 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;
    end));
    u44:Add(function() -- Line: 918
        -- upvalues: u54 (ref), Ball (copy), mainreplication (ref), Lighting (ref), Brightness (ref)
        u54 = true;

        if Ball then
            Ball.Size = Vector3.new(1.95, 1.95, 1.95);
        end;

        mainreplication.sceneEnabled(false);
        Lighting.Brightness = Brightness;
    end);
    u44:Add(task.delay(p38, function() -- Line: 930
        -- upvalues: u44 (copy)
        u44:Destroy();
    end));
end;

local u55 = { "KaiserImpacting", "PathOffSuperDash" };

function v1.kaiserdribble(u56) -- Line: 937
    -- upvalues: u55 (copy), mainreplication (copy), trove (copy), BackgroundHighlight (copy), ReplicatedStorage (copy), Players (copy), RunService (copy)
    local u57 = u56.HumanoidRootPart or u56.PrimaryPart;

    for _, v in u55 do
        if u56:GetAttribute(v) then
            return;
        end;
    end;

    mainreplication.highlight(u56, Color3.fromRGB(79, 102, 255), 0.2666666666666667);
    local u58 = trove.new();
    u58:AttachToInstance(u56);

    for _, v in u55 do
        u58:Connect(u56:GetAttributeChangedSignal(v), function() -- Line: 955
            -- upvalues: u56 (copy), v (copy), u58 (copy)
            if u56:GetAttribute(v) then
                u58:Destroy();
            end;
        end);
    end;

    u58:Add(task.delay(0.2666666666666667, function() -- Line: 962
        -- upvalues: BackgroundHighlight (ref), u56 (copy), mainreplication (ref), u57 (copy), u58 (copy), ReplicatedStorage (ref), Players (ref), RunService (ref)
        BackgroundHighlight({
            ImageTransparency = 0.7,
            Speed = 0.3,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            Count = 16,
            Whitelist = { u56 },
            Color = Color3.fromRGB(1000, 1000, 1000),
            Color2 = Color3.fromRGB(79, 126, 255)
        });
        mainreplication.rockFlakes(u57, 0.5);
        local u59 = u58:Clone(ReplicatedStorage.Resources.kaiser.A);
        u59.Weld.Part0 = u57;
        u59.Parent = u56;
        local u60 = u58:Clone(ReplicatedStorage.Resources.kaiser.roott);
        u60.Weld.Part0 = u56["Right Arm"];
        u60.Parent = u56;
        local u61 = u58:Clone(ReplicatedStorage.Resources.kaiser.roott);
        u61.Weld.Part0 = u56["Left Arm"];
        u61.Parent = u56;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u56) then
            mainreplication.bright(0.15, 1.5, Color3.fromRGB(111, 106, 255));
            mainreplication.fov(false, 55);
            mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end;

        mainreplication.cameraShake(15, 1.3, 3);
        mainreplication.Emit(u57, ReplicatedStorage.Resources.kaiser.Jump, 3, CFrame.new(0, -3, 0));
        local u62, u63 = mainreplication.bodyVelocity(u57, 110, 0.5, nil, nil, true);
        local Attribute = u56:GetAttribute("what");
        local u64 = nil;
        u64 = RunService.RenderStepped:Connect(function(p65) -- Line: 1005
            -- upvalues: u62 (copy), u64 (ref), u57 (ref), u63 (copy), Attribute (copy)
            if not (u62 and u62:IsDescendantOf(game)) then
                u64:Disconnect();

                return;
            end;

            local v66 = -u57.CFrame.RightVector * u63.Value / 2;

            if Attribute then
                v66 = -v66;
            end;

            u62.Velocity = u57.CFrame.LookVector * u63.Value + v66;
        end);
        u58:Add(task.delay(0.3, function() -- Line: 1022
            -- upvalues: mainreplication (ref), u57 (ref), Players (ref), u56 (ref), ReplicatedStorage (ref), RunService (ref), Attribute (copy)
            mainreplication.rockFlakes(u57, 0.5);

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u56) then
                mainreplication.fov(false, 85);
                mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            end;

            mainreplication.Emit(u57, ReplicatedStorage.Resources.kaiser.Jump, 3, CFrame.new(0, -3, 0));
            mainreplication.cameraShake(15, 0.55, 6);
            local u67, u68 = mainreplication.bodyVelocity(u57, 165, 0.5, nil, nil, true);
            local u69 = nil;
            u69 = RunService.RenderStepped:Connect(function(p70) -- Line: 1036
                -- upvalues: u67 (copy), u69 (ref), u57 (ref), u68 (copy), Attribute (ref)
                if not (u67 and u67:IsDescendantOf(game)) then
                    u69:Disconnect();

                    return;
                end;

                local v71 = u57.CFrame.RightVector * u68.Value / 2;

                if Attribute then
                    v71 = -v71;
                end;

                u67.Velocity = u57.CFrame.LookVector * u68.Value + v71;
            end);
        end));
        u58:Add(task.delay(0.6, function() -- Line: 1054
            -- upvalues: u59 (copy), u60 (copy), u61 (copy)
            for _, descendant in ipairs(u59:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in ipairs(u60:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in ipairs(u61:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end));
    end));
    u58:Add(task.delay(3.867, function() -- Line: 1072
        -- upvalues: u58 (copy)
        u58:Destroy();
    end));
end;

function v1.kaiserImpact(u72, p73, p74) -- Line: 1077
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), mainreplication (copy)
    local u75 = u72.HumanoidRootPart or u72.PrimaryPart;
    local Ball = u72:FindFirstChild("Ball");
    local u76 = p73 or 1;
    local u77 = p74 and 0.7 or 1;

    local function scaleTime(p78: number) -- Line: 1085
        -- upvalues: u76 (ref)
        return p78 / u76;
    end;

    local u79 = ReplicatedStorage.Resources.kaiser.kieff:Clone();
    u79:PivotTo(u75.CFrame);
    u79.Parent = u72;

    if Util.canshiftcolor(LocalPlayer, u72) then
        vfxUtil.LeanTowardsColor(u79, u72:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u72:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.delay(1.983333333333333, u79.Destroy, u79);

    for _, descendant in ipairs(u79:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.Transparency = 1;
        elseif descendant:IsA("ParticleEmitter") then
            if p74 and not descendant.Name:match("7") then
                descendant:Destroy();
            else
                descendant.Enabled = false;
            end;
        end;
    end;

    task.spawn(function() -- Line: 1111
        -- upvalues: u79 (copy), u75 (copy)
        while u79.Parent do
            u79:PivotTo(u75.CFrame);
            task.wait();
        end;
    end);
    task.delay(0.1333333333333333 / u76, function() -- Line: 1119
        -- upvalues: u79 (copy), TweenService (ref), u76 (ref), u77 (copy)
        for i = 1, 4 do
            local v80 = u79.Wind1:Clone();
            v80.Size = Vector3.new(4.996, 11.287, 11.663);
            v80.Transparency = 0.85;
            v80.Parent = workspace.Effects;
            TweenService:Create(v80, TweenInfo.new(0.3 / u76, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = Vector3.new(12.96, 24.999, 24.999) * u77,
                CFrame = v80.CFrame * CFrame.new(16 * u77, 0, 0) * CFrame.Angles(5, 0, 0)
            }):Play();
            task.delay(0.3 / u76, v80.Destroy, v80);
            task.wait(0.15 / u76);
            local _ = i;
        end;
    end);
    task.delay(0.0666666666666667 / u76, function() -- Line: 1139
        -- upvalues: mainreplication (ref), u76 (ref), u79 (copy)
        mainreplication.cameraShake(15, 0.65 / u76, 4);

        for _, descendant in ipairs(u79.Jump:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.12333333333333334 / u76, function() -- Line: 1149
        -- upvalues: u79 (copy)
        for _, descendant in ipairs(u79.A:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.0666666666666667 / u76, function() -- Line: 1157
        -- upvalues: ReplicatedStorage (ref), u72 (copy)
        local v81 = ReplicatedStorage.Resources.kaiser.ADA:Clone();
        v81.Weld.Part0 = u72["Right Leg"];
        v81.Parent = u72;

        for _, descendant in ipairs(v81:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.delay(3, v81.Destroy, v81);
    end);
    task.delay(0.15 / u76, function() -- Line: 1170
        -- upvalues: Ball (copy), ReplicatedStorage (ref), u72 (copy)
        if not Ball then
            return;
        end;

        local v82 = ReplicatedStorage.Resources.kaiser.Charge:Clone();
        v82.Weld.Part0 = Ball;
        v82.Parent = u72;

        for _, descendant in ipairs(v82:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.delay(3, v82.Destroy, v82);
    end);
    task.delay(0.1833333333333333 / u76, function() -- Line: 1187
        -- upvalues: Ball (copy), ReplicatedStorage (ref), u72 (copy), u76 (ref)
        if not Ball then
            return;
        end;

        local v83 = ReplicatedStorage.Resources.kaiser.Charge2:Clone();
        v83.Weld.Part0 = Ball;
        v83.Parent = u72;
        task.delay(0.2333333333333334 / u76, v83.Destroy, v83);

        for _, descendant in ipairs(v83:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    mainreplication.fov(true, 120, 0.3 / u76, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
    task.delay(0.35 / u76, function() -- Line: 1206
        -- upvalues: mainreplication (ref), u76 (ref), u79 (copy), TweenService (ref), u77 (copy)
        mainreplication.fov(false, 70);
        mainreplication.cameraShake(15, 1.35 / u76, 8);

        for _, descendant in ipairs(u79.Impact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v84 = u79.BRO:Clone();
        v84.Size = Vector3.new(24.622, 10.168, 10.474);
        v84.Mesh.Scale = Vector3.new(1.077, 0.338, 0.336);

        for _, descendant in ipairs(v84:GetDescendants()) do
            if descendant:IsA("Decal") then
                descendant.Transparency = 0;
            end;
        end;

        v84.Parent = workspace.Effects;
        TweenService:Create(v84, TweenInfo.new(0.0333333333333333 / u76, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(52.739, 0.001, 0.001) * u77,
            CFrame = v84.CFrame * CFrame.new(-8 * u77, 0, 0)
        }):Play();
        TweenService:Create(v84.Mesh, TweenInfo.new(0.0333333333333333 / u76, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = Vector3.new(2.307, 0, 0)
        }):Play();
        task.delay(0.0333333333333333 / u76, v84.Destroy, v84);
    end);
    task.delay(0.2666666666666667 / u76, function() -- Line: 1245
        -- upvalues: u79 (copy), TweenService (ref), u76 (ref), u77 (copy)
        local v85 = u79.MeshPart:Clone();
        v85.Size = Vector3.new(8, 1.382, 8);
        v85.Transparency = 0;
        v85.Parent = workspace.Effects;
        TweenService:Create(v85, TweenInfo.new(0.1166666666666666 / u76, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(19.999, 1.382, 19.999) * u77,
            CFrame = v85.CFrame * CFrame.new(0, -11 * u77, 0)
        }):Play();
        task.delay(0.1166666666666666 / u76, v85.Destroy, v85);
        task.wait(0.015 / u76);
        local v86 = u79.MeshPart2:Clone();
        v86.Size = Vector3.new(5, 1.382, 5);
        v86.Transparency = 0;
        v86.Parent = workspace.Effects;
        TweenService:Create(v86, TweenInfo.new(0.1016666666666666 / u76, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(14, 1.382, 14) * u77,
            CFrame = v86.CFrame * CFrame.new(0, -9 * u77, 0)
        }):Play();
        task.delay(0.1016666666666666 / u76, v86.Destroy, v86);
    end);
    task.delay(0.3 / u76, function() -- Line: 1281
        -- upvalues: u79 (copy), TweenService (ref), u76 (ref), u77 (copy)
        local v87 = u79.First:Clone();
        v87.Size = Vector3.new(24.622, 19.953, 19.969);
        v87.Mesh.Scale = Vector3.new(1.077, 0.663, 0.641);
        v87.Decal.Transparency = 0.4;
        v87.Parent = workspace.Effects;
        TweenService:Create(v87, TweenInfo.new(0.0333333333333333 / u76, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(48.149, 12.068, 9.594) * u77,
            CFrame = v87.CFrame * CFrame.new(-11 * u77, 0, 0)
        }):Play();
        TweenService:Create(v87.Mesh, TweenInfo.new(0.0333333333333333 / u76, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = Vector3.new(1.503, 0.571, 0.518)
        }):Play();
        task.delay(0.0333333333333333 / u76, v87.Destroy, v87);
    end);
    task.delay(0.3333333333333333 / u76, function() -- Line: 1306
        -- upvalues: u79 (copy), TweenService (ref), u76 (ref), u77 (copy)
        local v88 = u79.Haze:Clone();
        v88.Size = Vector3.new(13.115, 17.07, 13.602);
        v88.Mesh.Scale = Vector3.new(-0.052, -0.085, -0.054);
        v88.Decal.Transparency = 0.8;
        v88.Parent = workspace.Effects;
        TweenService:Create(v88, TweenInfo.new(0.6666666666666667 / u76, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(22.987, 28.914, 21.857) * u77,
            CFrame = v88.CFrame * CFrame.new(0, -11 * u77, 0) * CFrame.Angles(0, -5, 0)
        }):Play();
        TweenService:Create(v88.Mesh, TweenInfo.new(0.6666666666666667 / u76, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = Vector3.new(-0.092, -0.145, -0.087)
        }):Play();
        TweenService:Create(v88.Decal, TweenInfo.new(0.6666666666666667 / u76, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        task.delay(0.6666666666666667 / u76, v88.Destroy, v88);
        local v89 = u79.End:Clone();
        v89.Size = Vector3.new(27.739, 7.389, 26.128);
        v89.Transparency = 0;
        v89.Parent = workspace.Effects;
        TweenService:Create(v89, TweenInfo.new(0.6666666666666667 / u76, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = Vector3.new(18.992, 6.23, 20.161),
            Color = Color3.fromRGB(13, 105, 172),
            CFrame = v89.CFrame * CFrame.new(0, 15 * u77, 0) * CFrame.Angles(0, 5, 0)
        }):Play();
        task.delay(0.6666666666666667 / u76, v89.Destroy, v89);
    end);
end;

function v1.nights_intercept_kaiser(u90, u91, p92) -- Line: 1354
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy), StyleData (copy)
    local Root = vfxUtil.getRoot(u90);
    local Special = vfxUtil.getResources().kaiser.Special;
    local u93 = vfxUtil.character_trove(u90);
    vfxUtil.cutscene_invisiball(u90, u93);
    mainreplication.sceneEnabled(true);
    u93:Add(function() -- Line: 1362
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    local u94, v95 = mainreplication.cutsceneCamRigWithLetterBox(Root, Special.Animations.Cam, Special.FOV_KaiserSpecial, u90, "default");
    u93:Add(v95);
    soundUtil:play(Special.SFX, "default");
    local u96 = u93:Add(Special.Ball:Clone());
    u96.ball.Part0 = Root;
    u96.Parent = u90;
    local u97 = u93:Add(Special.VFX:Clone());
    u97:PivotTo(u90:GetPivot());
    u97.Parent = workspace.Effects;
    local v98 = {};

    for _, v in { u90, u91[3] } do
        local v99 = u97.TuffHighlights:Clone();
        v99.Parent = v;
        table.insert(v98, v99);
    end;

    u93:Add(task.spawn(function() -- Line: 1392
        -- upvalues: u97 (copy), u94 (copy), u90 (copy), u91 (copy), u96 (copy)
        u97.CamVFX.Weld.Part1 = u94.camera;
        u97.Ambience.Weld.Part1 = u94.camera;
        u97.Ambience2.Weld.Part1 = u94.camera;
        u97.FakeRightLeg.Weld.Part1 = u90:FindFirstChild("Right Leg");
        u97.FakeheadP.Weld.Part1 = u90:FindFirstChild("Head");

        if u91[1] then
            u97.FakeheadV1.Weld.Part1 = u91[2]:FindFirstChild("Head");
        end;

        u97.Ballvfx.Weld.Part1 = u96;
    end));
    local v100 = u93:Construct(u97.KaiserAura1);
    vfxUtil.setupAura(u90, v100, true);
    v100.Parent = workspace.Effects;
    local v101 = u93:Add(vfxUtil.getMoonEffects());
    u93:Add(v101);
    local v102 = {
        Workspace = u97,
        Vignette = v101.Vignette,
        Lighting = Lighting
    };

    if Special:FindFirstChild("Lighting") then
        vfxUtil.cutscene_lighting(u93, v102, Special.Lighting);
    end;

    local v103 = u93:Construct(MoonPropertyAnimator);
    v103:LoadAndConvertSave(Special.Moon, v102);
    v103:SetOriginalRoot(Special.VFX.PrimaryPart.CFrame);
    v103:SetRoot(Root);
    v103:PlayAll();
    vfxUtil.execute_compiled(Special.Compiled, u93, u97, v98);
    u93:Add(task.delay(p92, u93.Destroy, u93));
    u93:Add(task.delay(3.933333333333333, function() -- Line: 1434
        -- upvalues: u93 (copy), TekrinnDialogue (ref), u90 (copy), StyleData (ref)
        u93:Add(TekrinnDialogue.Speak(u90, {
            {
                Text = "Huh?",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 89, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 3, StyleData.icon, StyleData.color));
    end));
    u93:Add(task.delay(5.833333333333333, function() -- Line: 1460
        -- upvalues: u93 (copy), TekrinnDialogue (ref), u90 (copy), StyleData (ref)
        u93:Add(TekrinnDialogue.Speak(u90, {
            {
                Text = "Too slow.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 89, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 3, StyleData.icon, StyleData.color));
    end));
    u93:Add(task.delay(10.966666666666667, function() -- Line: 1486
        -- upvalues: u93 (copy), TekrinnDialogue (ref), u90 (copy), StyleData (ref)
        u93:Add(TekrinnDialogue.Speak(u90, {
            {
                Text = "EAT TRASH!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 89, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 3, StyleData.icon, StyleData.color));
    end));
    u93:Add(task.delay(12.666666666666666, function() -- Line: 1512
        -- upvalues: u93 (copy), TekrinnDialogue (ref), u90 (copy), StyleData (ref)
        u93:Add(TekrinnDialogue.Speak(u90, {
            {
                Text = "YOU LOSERS!!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 89, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 3, StyleData.icon, StyleData.color));
    end));
end;

for i, v in require(script.Mastery) do
    v1[i] = v;
end;

return v1;