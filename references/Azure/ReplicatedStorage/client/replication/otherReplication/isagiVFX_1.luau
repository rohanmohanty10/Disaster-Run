 
 

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
local StarterGui = game:GetService("StarterGui");
local v1 = {};
local _ = workspace.CurrentCamera;
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
local EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale;
local EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local Util = require(ReplicatedStorage.util.Util);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local UwUEffects = require(ReplicatedStorage.util.UwUEffects);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local trove = require(ReplicatedStorage.forum.trove);
local WickerSprite = require(ReplicatedStorage.forum.WickerSprite);
require(ReplicatedStorage.util.KatUtil);
Util.OnFoundInstance(ReplicatedStorage.Resources, "isagi", function(p2) -- Line: 53
    -- upvalues: Util (copy)
    Util.Preload(p2.ImpactFrame5, true);
end);

function v1.bonIsagiReaction(u3, u4) -- Line: 57
    -- upvalues: ReplicatedStorage (copy), Util (copy), mainreplication (copy), UwUEffects (copy), soundUtil (copy), PlayerGui (copy), Lighting (copy), TekrinnDialogue (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy)
    local v5 = u3:FindFirstChild("HumanoidRootPart") or u3.PrimaryPart;
    local v6 = u4:FindFirstChild("HumanoidRootPart") or u4.PrimaryPart;
    local isagi = ReplicatedStorage.Resources.isagi;

    if not (v5 and v6) then
        return;
    end;

    local u7 = Util.Preload(isagi.bonReactionImpact);
    local v8 = mainreplication.cutscene(v5, CFrame.new(), 9.85, isagi.bonReactionFOV);
    Util.CameraEffect(isagi.bonReactionCam, v8);
    UwUEffects.createEffect({
        Character = u3,
        Victim = u4
    }, "IsagiBachiraReaction");
    local v9 = soundUtil:play(isagi.bonReactionSound, ReplicatedStorage, {
        Character = u3
    });
    local u10 = ReplicatedStorage.Resources.uibox:Clone();
    u10.Parent = PlayerGui;
    Lighting.Brightness = 1;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 3.55;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.4;
    ColorCorrectionEffect.Saturation = -0.4;
    ColorCorrectionEffect.Brightness = 0;
    local u11 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u11.Parent = Lighting;
    u11.FarIntensity = 1;
    mainreplication.sceneEnabled(true);

    if v9.Name == "Dub" then
        task.delay(4.367, function() -- Line: 96
            -- upvalues: TekrinnDialogue (ref), u3 (copy)
            TekrinnDialogue.Speak(u3, {
                {
                    Text = "He was right... Find the strongest...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 5);
        end);
        task.delay(7.3, function() -- Line: 123
            -- upvalues: TekrinnDialogue (ref), u4 (copy)
            TekrinnDialogue.Speak(u4, {
                {
                    Text = "Boom!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 213, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 1
                    }
                }
            }, 1);
        end);
    else
        task.delay(4.367, function() -- Line: 149
            -- upvalues: TekrinnDialogue (ref), u3 (copy)
            TekrinnDialogue.Speak(u3, {
                {
                    Text = "The strongest guy...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 5);
        end);
        task.delay(7.3, function() -- Line: 176
            -- upvalues: TekrinnDialogue (ref), u4 (copy)
            TekrinnDialogue.Speak(u4, {
                {
                    Text = "Boom!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 213, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 1
                    }
                }
            }, 1);
        end);
    end;

    task.delay(8, function() -- Line: 203
        -- upvalues: Util (ref), isagi (copy)
        Util.Gif(isagi.bonReactionImpact, 30);
    end);
    task.delay(9.85, function() -- Line: 207
        -- upvalues: mainreplication (ref), u7 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref), ColorCorrectionEffect (copy), u10 (copy), u11 (copy)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash();
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        u7:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;

        if ColorCorrectionEffect then
            ColorCorrectionEffect:Destroy();
        end;

        u10:Destroy();
        u11:Destroy();
    end);
end;

function v1.backheelshotIsagi(u12) -- Line: 229
    -- upvalues: mainreplication (copy), PlayerGui (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), TekrinnDialogue (copy), Lighting (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), TweenService (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), EnvironmentDiffuseScale (copy), EnvironmentSpecularScale (copy), Density (copy), Color (copy)
    local v13 = u12.HumanoidRootPart or u12.PrimaryPart;
    u12:FindFirstChild("Ball");
    mainreplication.sceneEnabled(true);
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.DisplayOrder = 4;
    ScreenGui.ScreenInsets = Enum.ScreenInsets.None;
    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = Color3.new();
    Frame.Size = UDim2.fromScale(2, 2);
    Frame.Parent = ScreenGui;
    ScreenGui.Parent = PlayerGui;
    local v14 = soundUtil:play(ReplicatedStorage.Resources.isagi["back heel shot new"], SoundService, {
        Character = u12
    });

    if v14.Name == "Dub" then
        TekrinnDialogue.Speak("???", {
            {
                Text = "Gotteem.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 0.5);
    else
        TekrinnDialogue.Speak("???", {
            {
                Text = "Not.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 0.5);
    end;

    task.wait(1.56);
    pcall(game.Destroy, ScreenGui);
    local _ = u12.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local u15 = ReplicatedStorage.Resources.vb:Clone();
    u15.Parent = PlayerGui;
    local u16 = ReplicatedStorage.Resources.glowscreen:Clone();
    u16.Parent = PlayerGui;
    u16.ImageLabel2.ImageTransparency = 0;
    u16.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 3;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 2.627;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.55;
    ColorCorrectionEffect.Saturation = -0.4;
    local u17 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u17.Parent = Lighting;
    u17.FarIntensity = 1;
    mainreplication.ultFlash(1, 1, true);
    local u18 = ReplicatedStorage.Resources.isagi.backheelshotVFX:Clone();
    u18:PivotTo(v13.CFrame);
    u18.Parent = u12;

    if Util.canshiftcolor(LocalPlayer, u12) then
        vfxUtil.LeanTowardsColor(u18, u12:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u12:GetAttribute("CustomAlpha") or 0.985);
    end;

    mainreplication.cutscene(v13, nil, 13.15, ReplicatedStorage.Resources.isagi.backheelShotFOV);
    local u19 = ReplicatedStorage.Resources.gagamaru.perfectCamEff:Clone();
    u19.Parent = u18;

    if Util.canshiftcolor(LocalPlayer, u12) then
        vfxUtil.LeanTowardsColor(u18, u12:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u12:GetAttribute("CustomAlpha") or 0.985);
    end;

    u19.Beam.Enabled = true;
    local u20 = nil;
    u20 = RunService.PreRender:connect(function() -- Line: 351
        -- upvalues: u19 (copy), u20 (ref)
        if u19 and u19.Parent then
            u19.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        if u20 then
            u20:Disconnect();
        end;
    end);
    u18.vfx.vfx2.Weld.Part0 = u12["Right Leg"];

    if v14.Name == "Dub" then
        task.delay(0.1, function() -- Line: 370
            -- upvalues: TekrinnDialogue (ref), u12 (copy)
            TekrinnDialogue.Speak(u12, {
                {
                    Text = "I fooled you, genius!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
        task.delay(6, function() -- Line: 396
            -- upvalues: TekrinnDialogue (ref), u12 (copy)
            TekrinnDialogue.Speak(u12, {
                {
                    Text = "My true last action!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 2);
        end);
        task.delay(8, function() -- Line: 422
            -- upvalues: TekrinnDialogue (ref), u12 (copy)
            TekrinnDialogue.Speak(u12, {
                {
                    Text = "When you least expect it...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 1.5
                    }
                }
            }, 1.5);
        end);
        task.delay(10, function() -- Line: 447
            -- upvalues: TekrinnDialogue (ref), u12 (copy)
            TekrinnDialogue.Speak(u12, {
                {
                    Text = "MY DIRECT BACK-HEEL!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(39, 53, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
    else
        task.delay(0.1, function() -- Line: 473
            -- upvalues: TekrinnDialogue (ref), u12 (copy)
            TekrinnDialogue.Speak(u12, {
                {
                    Text = "I fooled you, genius!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
        task.delay(6, function() -- Line: 499
            -- upvalues: TekrinnDialogue (ref), u12 (copy)
            TekrinnDialogue.Speak(u12, {
                {
                    Text = "This is my true last action!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 2);
        end);
        task.delay(8, function() -- Line: 525
            -- upvalues: TekrinnDialogue (ref), u12 (copy)
            TekrinnDialogue.Speak(u12, {
                {
                    Text = "My reverse...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 1.5
                    }
                }
            }, 1.5);
        end);
        task.delay(10, function() -- Line: 550
            -- upvalues: TekrinnDialogue (ref), u12 (copy)
            TekrinnDialogue.Speak(u12, {
                {
                    Text = "Back-heel Shot!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(39, 53, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
    end;

    task.delay(0.05, function() -- Line: 577
        -- upvalues: u18 (copy)
        for _, descendant in ipairs(u18.vfx.Part.vfx1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.08333333333333333, function() -- Line: 585
        -- upvalues: u18 (copy)
        for _, descendant in ipairs(u18.vfx.vfx2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(2, function() -- Line: 590
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(1.817, function() -- Line: 594
        -- upvalues: TweenService (ref), u18 (copy)
        TweenService:Create(u18.backheelshotdomain, TweenInfo.new(1), {
            Transparency = 0
        }):Play();
    end);
    task.delay(6.25, function() -- Line: 597
        -- upvalues: u18 (copy)
        for _, descendant in ipairs(u18.vfx.Part.stomp:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.8, function() -- Line: 605
        -- upvalues: u18 (copy)
        for _, descendant in pairs(u18.vfx.beamtransition2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.433333333333334, function() -- Line: 612
        -- upvalues: u18 (copy)
        for _, descendant in pairs(u18.vfx.beamtransition2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(9.45, function() -- Line: 619
        -- upvalues: u18 (copy)
        for _, descendant in pairs(u18.vfx.beamtransition3:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.466666666666667, function() -- Line: 626
        -- upvalues: u18 (copy)
        for _, descendant in pairs(u18.vfx.backheellines:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(10.033, function() -- Line: 634
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect.Saturation = -1;
        ColorCorrectionEffect.Contrast = -2.5;
    end);
    task.delay(10.066666666666666, function() -- Line: 638
        -- upvalues: u18 (copy)
        local vfx6 = u18.vfx.Part.vfx6;

        for _, descendant in ipairs(u18.vfx.Part.vfx6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.wait(0.05);

        for _, descendant in pairs(vfx6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.002;
            end;
        end;
    end);
    task.delay(10.116666666666667, function() -- Line: 653
        -- upvalues: u18 (copy)
        for _, descendant in pairs(u18.vfx.backheellines:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(10.166666666666666, function() -- Line: 661
        -- upvalues: u18 (copy)
        for _, descendant in pairs(u18.vfx.beamtransition3:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(10.633333333333333, function() -- Line: 668
        -- upvalues: u18 (copy)
        for _, descendant in pairs(u18.vfx.Part.vfx6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in ipairs(u18.vfx.Part.vfx6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(10.65, function() -- Line: 683
        -- upvalues: u18 (copy), ColorCorrectionEffect (copy)
        for _, descendant in pairs(u18.vfx.windemitsheel:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 687
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        ColorCorrectionEffect.Saturation = 0;
        ColorCorrectionEffect.Contrast = 0;
    end);
    task.delay(10.716666666666667, function() -- Line: 695
        -- upvalues: u18 (copy)
        for _, descendant in ipairs(u18.vfx.Part.vfx7:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(11.083333333333334, function() -- Line: 711
        -- upvalues: u18 (copy)
        for _, descendant in pairs(u18.vfx.windemitsheel:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.075;
            end;
        end;
    end);
    task.delay(13.15, function() -- Line: 719
        -- upvalues: u18 (copy)
        for _, descendant in pairs(u18.vfx.windemitsheel:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end);
    task.delay(13.15, function() -- Line: 728
        -- upvalues: u17 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), EnvironmentDiffuseScale (ref), EnvironmentSpecularScale (ref), Atmosphere (copy), Density (ref), Color (ref), ColorCorrectionEffect (copy), u18 (copy), mainreplication (ref), u15 (copy), u16 (copy)
        u17:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.EnvironmentDiffuseScale = EnvironmentDiffuseScale;
        Lighting.EnvironmentSpecularScale = EnvironmentSpecularScale;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;

        if ColorCorrectionEffect then
            ColorCorrectionEffect:Destroy();
        end;

        u18:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1, true);
        u15:Destroy();
        u16:Destroy();
    end);
end;

function v1.overtimeisagi(u21: any, u22: any, u23: any, u24: boolean) -- Line: 769
    -- upvalues: Lighting (copy), trove (copy), mainreplication (copy), ReplicatedStorage (copy), PlayerGui (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), Players (copy), Brightness (copy), Ambient (copy)
    local v25 = u21.HumanoidRootPart or u21.PrimaryPart;
    local _ = u21.Torso;
    local _ = Lighting.Atmosphere;
    local u26 = trove.new();
    u26:AttachToInstance(u21);

    if u23 then
        u26:AttachToInstance(u23);
    end;

    local function delay(p27, p28) -- Line: 781
        -- upvalues: u26 (copy)
        u26:Add(task.delay(p27, p28));
    end;

    local function emitGroup(p29, p30, p31) -- Line: 785
        for _, descendant in ipairs(p29:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if p30 ~= nil then
                    descendant.Enabled = p30;
                end;

                if p31 ~= nil then
                    descendant.TimeScale = p31;
                end;
            end;
        end;
    end;

    local u32 = false;

    local function getLine(p33, p34) -- Line: 796
        -- upvalues: u32 (ref)
        if u32 then
            p34 = p33 or p34;
        end;

        return p34;
    end;

    mainreplication.sceneEnabled(true);
    Lighting.Brightness = 2;
    u26:Clone(ReplicatedStorage.Resources.uibox).Parent = PlayerGui;
    local u35 = u26:Clone(ReplicatedStorage.Resources.glowscreen);
    u35.Parent = PlayerGui;
    u35.ImageLabel2.ImageTransparency = 0;
    u35.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    local u36 = u26:Clone(ReplicatedStorage.Resources.isagi.allEff);
    u36:PivotTo(v25.CFrame);
    u36.Parent = u21;

    if Util.canshiftcolor(LocalPlayer, u21) then
        vfxUtil.LeanTowardsColor(u36, u21:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u21:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in pairs(u36:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local v37 = u26:Clone(ReplicatedStorage.Resources.isagi.puzzlethings);
    v37.root.root.Part0 = v25;
    v37.Parent = u36;
    local u38 = u26:Clone(ReplicatedStorage.Resources.isagi.overtileCam);
    u38.Parent = u36;
    u26:Connect(RunService.PreRender, function() -- Line: 837
        -- upvalues: u38 (copy)
        if not (u38 and u38.Parent) then
            return;
        end;

        u38.CFrame = workspace.CurrentCamera.CFrame;
    end);
    local u39 = u26:Clone(ReplicatedStorage.Resources.isagi.isagiEye);
    u39.Weld.Part0 = u21.Head;
    u39.Parent = u36;
    local u40 = u26:Clone(ReplicatedStorage.Resources.isagi.TorsoEff);
    u40.Weld.Part0 = u21.Torso;
    u40.Parent = u36;
    local v41 = u26:Clone(ReplicatedStorage.Resources.DepthOfField);
    v41.Parent = Lighting;
    v41.FarIntensity = 0;
    TweenService:Create(v41, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local u42 = soundUtil:play(ReplicatedStorage.Resources.isagi["isagiovertime_1 (1)"], SoundService, {
        Character = u21
    });

    if u42.Name == "Dub" then
        u32 = true;
    else
        u32 = false;
    end;

    u26:Connect(u23.Changed, function(p43) -- Line: 858
        -- upvalues: u42 (copy), u26 (copy)
        if p43 then
            u42:Destroy();
            u26:Destroy();
        end;
    end);
    u26:Add((mainreplication.cutscene(v25, nil, 6.15, ReplicatedStorage.Resources.isagi.overtimeFOV)));
    local u44 = u26:Add(Instance.new("BlurEffect"));
    u44.Size = 22;
    u44.Parent = Lighting;
    local u45 = u26:Add(Instance.new("ColorCorrectionEffect"));
    u45.Parent = Lighting;
    u45.Saturation = -0.4;
    u45.Brightness = -1;
    TweenService:Create(u45, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Brightness = 0
    }):Play();
    TweenService:Create(u44, TweenInfo.new(0.567, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    u36.domain.Transparency = 0.25;
    u26:Add(task.delay(0.113, function() -- Line: 882
        -- upvalues: TekrinnDialogue (ref), u21 (copy), u32 (ref)
        TekrinnDialogue.Speak(u21, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u32 and "That\'s not..." or "This isn\'t...",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end));

    if u32 then
        u26:Add(task.delay(1.2, function() -- Line: 900
            -- upvalues: TekrinnDialogue (ref), u21 (copy)
            TekrinnDialogue.Speak(u21, {
                {
                    Text = "The kind of soccer...",
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
            }, 2);
        end));
    end;

    u26:Add(task.delay(3.382, function() -- Line: 918
        -- upvalues: TekrinnDialogue (ref), u21 (copy), u32 (ref)
        TekrinnDialogue.Speak(u21, {
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Text = u32 and "I want to play!" or "The soccer that I want to play.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end));
    u26:Add(task.delay(0.917, function() -- Line: 935
        -- upvalues: TweenService (ref), u44 (copy)
        local v46 = TweenService:Create(u44, TweenInfo.new(0.116, Enum.EasingStyle.Linear), {
            Size = 16
        });
        v46:Play();
        v46.Completed:Wait();
        TweenService:Create(u44, TweenInfo.new(1.4, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end));
    u26:Add(task.delay(3.667, function() -- Line: 942
        -- upvalues: TweenService (ref), u44 (copy)
        local v47 = TweenService:Create(u44, TweenInfo.new(0.116, Enum.EasingStyle.Linear), {
            Size = 7
        });
        v47:Play();
        v47.Completed:Wait();
        TweenService:Create(u44, TweenInfo.new(0.284, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end));
    u26:Add(task.delay(1.05, function() -- Line: 949
        -- upvalues: u36 (copy)
        u36.domain.Transparency = 0.86;
    end));
    u26:Add(task.delay(0.617, function() -- Line: 953
        -- upvalues: TweenService (ref), u35 (copy)
        local v48 = TweenService:Create(u35.ImageLabel2, TweenInfo.new(0.416, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        });
        v48:Play();
        v48.Completed:Wait();
        TweenService:Create(u35.ImageLabel2, TweenInfo.new(0.734, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        });
        local v49 = TweenService:Create(u35.ImageLabel2, TweenInfo.new(0.55, Enum.EasingStyle.Linear), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        });
        v49:Play();
        v49.Completed:Wait();
    end));
    u26:Add(task.delay(0.833, function() -- Line: 965
        -- upvalues: TweenService (ref), u45 (copy)
        local v50 = TweenService:Create(u45, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            Brightness = 0.1
        });
        v50:Play();
        v50.Completed:Wait();
        u45.Brightness = 0.2;
        local v51 = TweenService:Create(u45, TweenInfo.new(0.7, Enum.EasingStyle.Linear), {
            Brightness = 0
        });
        v51:Play();
        v51.Completed:Wait();
        local v52 = TweenService:Create(u45, TweenInfo.new(1.617, Enum.EasingStyle.Linear), {
            Brightness = 0.1
        });
        v52:Play();
        v52.Completed:Wait();
        u45.Brightness = -0.1;
        local v53 = TweenService:Create(u45, TweenInfo.new(0.284, Enum.EasingStyle.Linear), {
            Brightness = 0.1
        });
        v53:Play();
        v53.Completed:Wait();
        local v54 = TweenService:Create(u45, TweenInfo.new(0.516, Enum.EasingStyle.Linear), {
            Brightness = 0
        });
        v54:Play();
        v54.Completed:Wait();
    end));

    for _, descendant in ipairs(u36.isagiflowpuzzlesandspecs:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    for _, descendant in ipairs(u36.isagiflowpuzzlesandspecs1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    for _, descendant in ipairs(v37:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    for _, descendant in ipairs(u39:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    for _, descendant in ipairs(u36.isagiflowpuzzlesandspecs:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.TimeScale = 1;
        end;
    end;

    u26:Add(task.delay(0.233, function() -- Line: 997
        -- upvalues: u39 (copy)
        for _, descendant in ipairs(u39:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u26:Add(task.delay(0.383, function() -- Line: 1005
        -- upvalues: u39 (copy)
        for _, descendant in ipairs(u39:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u26:Add(task.delay(0.583, function() -- Line: 1009
        -- upvalues: u38 (copy)
        for _, descendant in pairs(u38:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u26:Add(task.delay(0.633, function() -- Line: 1017
        -- upvalues: u38 (copy), TweenService (ref)
        for _, descendant in pairs(u38:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Transparency = NumberSequence.new(1);
                local NumberValue = Instance.new("NumberValue");
                NumberValue.Value = 1;
                NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 1025
                    -- upvalues: NumberValue (copy), descendant (copy)
                    local Value = NumberValue.Value;
                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, Value), NumberSequenceKeypoint.new(1, Value) });
                end);
                local v55 = TweenService:Create(NumberValue, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Value = 0
                });
                local u56 = TweenService:Create(NumberValue, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Value = 1
                });
                v55:Play();
                v55.Completed:Connect(function() -- Line: 1037
                    -- upvalues: u56 (copy)
                    u56:Play();
                end);
            end;
        end;
    end));
    u26:Add(task.delay(0.683, function() -- Line: 1044
        -- upvalues: u38 (copy)
        for _, descendant in ipairs(u38:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u26:Add(task.delay(0.8, function() -- Line: 1052
        -- upvalues: u36 (copy)
        for _, descendant in ipairs(u36.isagiflowpuzzlesandspecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.05;
            end;
        end;
    end));
    u26:Add(task.delay(0.85, function() -- Line: 1056
        -- upvalues: u36 (copy)
        for _, descendant in ipairs(u36.isagiflowpuzzlesandspecs1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end));
    u26:Add(task.delay(1.05, function() -- Line: 1060
        -- upvalues: u38 (copy)
        for _, descendant in pairs(u38:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u26:Add(task.delay(3.233, function() -- Line: 1068
        -- upvalues: u40 (copy), u39 (copy), u36 (copy)
        for _, descendant in ipairs(u40:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u39:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u36.isagiflowpuzzlesandspecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u26:Add(task.delay(5.65, function() -- Line: 1074
        -- upvalues: u39 (copy)
        for _, descendant in ipairs(u39:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u26:Add(function() -- Line: 1082
        -- upvalues: mainreplication (ref), Players (ref), u21 (copy), u23 (copy), u24 (copy), trove (ref), ReplicatedStorage (ref), u22 (copy), TweenService (ref), Lighting (ref), Brightness (ref), Ambient (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1.5);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u21) then
            return;
        end;

        if u23.Value then
            return;
        end;

        if not u24 then
            return;
        end;

        local u57 = trove.new();
        local u58 = u57:Add(ReplicatedStorage.Resources.isagi.isagipuzzleareaVFX:Clone());
        u58:SetAttribute("IgnoresTheKid", true);
        u58.Parent = workspace.Effects;
        u58.CFrame = workspace.map.something[`isagiu20{u22}`].isagipuzzleareaVFX.CFrame;

        for _, descendant in ipairs(u58:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Brightness = 0;
                TweenService:Create(Lighting, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Brightness = 11.58
                }):Play();
            end;
        end;

        TweenService:Create(Lighting, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Ambient = Color3.fromRGB(138, 138, 138)
        }):Play();
        u57:Add(task.delay(6, function() -- Line: 1107, Name: destroy
            -- upvalues: TweenService (ref), Lighting (ref), Brightness (ref), Ambient (ref), u58 (copy), u57 (copy)
            TweenService:Create(Lighting, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Brightness = Brightness,
                Ambient = Ambient
            }):Play();

            for _, descendant in ipairs(u58:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                elseif descendant:IsA("PointLight") then
                    TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                        Brightness = 0
                    }):Play();
                end;
            end;

            u57:Add(task.delay(3, function() -- Line: 1118
                -- upvalues: u57 (ref)
                u57:Destroy();
            end));
        end));
    end);
    u26:Add(task.delay(6.15, function() -- Line: 1126
        -- upvalues: u26 (copy)
        u26:Destroy();
    end));
end;

function v1.directshotUlt(u59, p60) -- Line: 1131
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), PlayerGui (copy), TweenService (copy), soundUtil (copy), SoundService (copy), RunService (copy), TekrinnDialogue (copy), Brightness (copy)
    local v61 = u59.HumanoidRootPart or u59.PrimaryPart;
    local _ = u59.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local u62 = ReplicatedStorage.Resources.isagi.directUltEff:Clone();
    u62:PivotTo(v61.CFrame);
    u62.Parent = u59;

    if Util.canshiftcolor(LocalPlayer, u59) then
        vfxUtil.LeanTowardsColor(u62, u59:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u59:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u63 = ReplicatedStorage.Resources.uibox:Clone();
    u63.Parent = PlayerGui;
    local u64 = ReplicatedStorage.Resources.glowscreen:Clone();
    u64.Parent = PlayerGui;
    u64.ImageLabel2.ImageTransparency = 0.7;
    u64.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    local u65 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u65.Parent = Lighting;
    u65.FarIntensity = 0;
    TweenService:Create(u65, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local u66 = Util.Preload({ ReplicatedStorage.Resources.isagi.ImpactFrame1, ReplicatedStorage.Resources.isagi.ImpactFrame2, ReplicatedStorage.Resources.isagi.ImpactFrame3 });
    local Attribute = u59:GetAttribute("RinNoPlay");
    local v67;

    if Attribute then
        v67 = ReplicatedStorage.Resources.isagi.isagidirectshot.RNP;
    else
        v67 = ReplicatedStorage.Resources.isagi.isagidirectshot;
    end;

    local v68 = soundUtil:play(v67, SoundService, {
        Character = u59
    });
    mainreplication.cutscene(v61, nil, 8.267, ReplicatedStorage.Resources.isagi.directUltFOV);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    local u69 = ReplicatedStorage.Resources.isagi.zoomCam:Clone();
    u69.Parent = u62;
    local u70 = nil;
    u70 = RunService.PreRender:connect(function() -- Line: 1180
        -- upvalues: u69 (copy), u70 (ref)
        if u69:IsDescendantOf(game) then
            u69.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u70:Disconnect();
    end);

    if Attribute then
        task.delay(1.05, function() -- Line: 1188
            -- upvalues: TekrinnDialogue (ref), u59 (copy)
            TekrinnDialogue.Speak(u59, {
                {
                    Text = "I want to win with my own goal...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.08,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 4, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 0,
                        Lifetime = 3.9
                    }
                }
            }, 3.9, nil, nil, nil, "rbxassetid://104021709643547");
        end);
        task.delay(4.95, function() -- Line: 1214
            -- upvalues: TekrinnDialogue (ref), u59 (copy)
            TekrinnDialogue.Speak(u59, {
                {
                    Text = "My...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.1,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 4, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.6
                    }
                }
            }, 0.6, nil, nil, nil, "rbxassetid://104021709643547");
        end);
        task.delay(5.55, function() -- Line: 1240
            -- upvalues: TekrinnDialogue (ref), u59 (copy)
            TekrinnDialogue.Speak(u59, {
                {
                    Text = "DIRECT SHOT!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 4, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 2.5
                    }
                }
            }, 2.5, nil, nil, nil, "rbxassetid://104021709643547");
        end);
    elseif v68.Name == "Dub" then
        task.delay(1.683, function() -- Line: 1268
            -- upvalues: TekrinnDialogue (ref), u59 (copy)
            TekrinnDialogue.Speak(u59, {
                {
                    Text = "With this!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 4, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(4.683, function() -- Line: 1295
            -- upvalues: TekrinnDialogue (ref), u59 (copy)
            TekrinnDialogue.Speak(u59, {
                {
                    Text = "MY DIRECT!!!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 4, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(6.283, function() -- Line: 1321
            -- upvalues: TekrinnDialogue (ref), u59 (copy)
            TekrinnDialogue.Speak(u59, {
                {
                    Text = "SHOT!!!!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 4, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    else
        task.delay(4.683, function() -- Line: 1348
            -- upvalues: TekrinnDialogue (ref), u59 (copy)
            TekrinnDialogue.Speak(u59, {
                {
                    Text = "DIRECT!!!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 4, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(6.283, function() -- Line: 1374
            -- upvalues: TekrinnDialogue (ref), u59 (copy)
            TekrinnDialogue.Speak(u59, {
                {
                    Text = "SHOT!!!!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 4, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    end;

    task.delay(0.167, function() -- Line: 1406
        -- upvalues: u62 (copy)
        for _, descendant in pairs(u62.fsteo:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5.617, function() -- Line: 1415
        -- upvalues: u62 (copy)
        for _, descendant in pairs(u62.hitya:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u64.ImageLabel2.ImageTransparency = 0;
    task.delay(1.083, function() -- Line: 1430
        -- upvalues: u64 (copy), ColorCorrectionEffect (copy), TweenService (ref), Util (ref), ReplicatedStorage (ref), u69 (copy)
        u64.ImageLabel2.ImageTransparency = 0.75;
        ColorCorrectionEffect.Brightness = 0.2;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Brightness = 0
        }):Play();
        Util.Gif(ReplicatedStorage.Resources.isagi.ImpactFrame1, 30);
        u69.camvfx.camparticles.Enabled = true;
        task.wait(0.3);
        u69.camvfx.camparticles.Enabled = false;
    end);
    local u71 = {};
    task.delay(2.7, function() -- Line: 1442
        -- upvalues: u59 (copy), ReplicatedStorage (ref), u71 (copy), Util (ref)
        for _, descendant in ipairs(u59:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v72 = ReplicatedStorage.Resources.isagi.isagiAura:Clone();
                v72.Color = ColorSequence.new(Color3.fromRGB(71, 105, 255));
                v72.Parent = descendant;
                table.insert(u71, v72);
            end;
        end;

        Util.Gif(ReplicatedStorage.Resources.isagi.ImpactFrame2, 30);
    end);
    task.delay(6.167, function() -- Line: 1460
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.isagi.ImpactFrame3, 20);
    end);
    task.delay(6.667, function() -- Line: 1464
        -- upvalues: u64 (copy), ColorCorrectionEffect (copy), TweenService (ref)
        u64:Destroy();
        ColorCorrectionEffect.Brightness = -1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Brightness = 0
        }):Play();
    end);
    local u73 = nil;
    task.delay(7.083, function() -- Line: 1473
        -- upvalues: u64 (copy), u69 (copy), u71 (copy), u73 (ref), ReplicatedStorage (ref), u59 (copy), ColorCorrectionEffect (copy), TweenService (ref)
        u64:Destroy();

        for _, descendant in pairs(u69.camvfx2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in u71 do
            v.Color = ColorSequence.new(Color3.fromRGB(82, 255, 55));
        end;

        u73 = ReplicatedStorage.Resources.isagi.lineaura:Clone();
        u73.Parent = u59["Right Leg"];
        ColorCorrectionEffect.Brightness = 0.5;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Brightness = 0
        }):Play();
    end);
    task.delay(8.267, function() -- Line: 1495
        -- upvalues: u66 (copy), u65 (copy), ColorCorrectionEffect (copy), u62 (copy), u69 (copy), u73 (ref), u71 (copy), u63 (copy), u64 (copy), mainreplication (ref), Lighting (ref), Brightness (ref)
        u66:Destroy();
        u65:Destroy();
        ColorCorrectionEffect:Destroy();
        u62:Destroy();
        u69:Destroy();
        u73:Destroy();

        for _, v in u71 do
            v:Destroy();
        end;

        u63:Destroy();
        u64:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1.5);
        Lighting.Brightness = Brightness;
    end);
end;

function v1.kniffight(p74, p75) -- Line: 1527
    -- upvalues: vfxUtil (copy), mainreplication (copy), ReplicatedStorage (copy), soundUtil (copy)
    local Root = vfxUtil.getRoot(p74);
    local KnifeFight = vfxUtil.getResources().isagi.KnifeFight;
    local v76 = vfxUtil.character_trove(p74);
    v76:Add(function() -- Line: 1532
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    mainreplication.sceneEnabled(true);
    local _, v77 = mainreplication.cutsceneCamRigWithLetterBox(Root, KnifeFight.Camera, KnifeFight.FOV, p74, CFrame.new(0, -3, 0) * CFrame.Angles(0, -1.5707963267948966, 0), KnifeFight.Cam, "CamPart");
    v76:Add(v77);
    local v78 = v76:Clone(ReplicatedStorage.Resources.rin.RinNoPlayAsset["Kitchen KnifeRight"]);
    v78["Kitchen KnifeRight"].Part0 = p75["Right Arm"];
    v78.Parent = workspace.Effects;
    v76:Add(task.delay(14.05, v76.Destroy, v76));
    soundUtil:play(KnifeFight.sound, "default");
end;

function v1.MOVEIT(u79, p80) -- Line: 1550
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), SoundService (copy), PlayerGui (copy), TweenService (copy), soundUtil (copy), RunService (copy), TekrinnDialogue (copy), Brightness (copy)
    local v81 = u79.HumanoidRootPart or u79.PrimaryPart;
    local _ = u79.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local u82 = ReplicatedStorage.Resources.isagi.MOVEIT:Clone();
    u82:PivotTo(v81.CFrame);
    u82.HollowSphere.HumanoidRootPart.Part1 = v81;
    u82.egohead.Weld.Part0 = u79.Head;
    u82.moveitgrab.Weld.Part0 = p80["Right Arm"];
    u82.Parent = u79;

    if Util.canshiftcolor(LocalPlayer, u79) then
        vfxUtil.LeanTowardsColor(u82, u79:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u79:GetAttribute("CustomAlpha") or 0.985);
    end;

    if u79:GetAttribute("RinNoPlay") then
        task.spawn(function() -- Line: 1570
            -- upvalues: ReplicatedStorage (ref), u79 (copy), SoundService (ref)
            for i = 1, 20 do
                task.wait(0.1);
                local u83 = ReplicatedStorage.Resources.isagi[u79:GetAttribute("FunnyVoicelines") and "MOVEEEIT" or "TOKE"]:Clone();
                u83.Name = i;
                u83.Parent = SoundService;
                u83:Play();
                u83.Ended:Once(function(p84: string) -- Line: 1577
                    -- upvalues: u83 (copy)
                    u83:Destroy();
                end);
                local _ = i;
            end;
        end);
    end;

    local u85 = ReplicatedStorage.Resources.glowscreen:Clone();
    u85.Parent = PlayerGui;
    u85.ImageLabel2.ImageTransparency = 0.7;
    u85.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    local u86 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u86.Parent = Lighting;
    u86.FarIntensity = 0;
    TweenService:Create(u86, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.isagi[u79:GetAttribute("FunnyVoicelines") and "MOVEEEIT" or "TOKE"], SoundService, {
        Character = u79
    });
    mainreplication.cutscene(v81, nil, 3.767, ReplicatedStorage.Resources.isagi.MOVEFOV);
    local u87 = ReplicatedStorage.Resources.isagi.MOVEITCAM:Clone();
    u87.Parent = u82;
    local u88 = nil;
    u88 = RunService.PreRender:connect(function() -- Line: 1601
        -- upvalues: u87 (copy), u88 (ref)
        if u87:IsDescendantOf(game) then
            u87.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u88:Disconnect();
    end);
    task.spawn(function() -- Line: 1606
        -- upvalues: u82 (copy)
        for _, descendant in ipairs(u82.HollowSphere:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        u82.HollowSphere.Transparency = 1;
        u82.HollowSphere.Floor.Transparency = 1;
    end);
    task.delay(0.3333333333333333, function() -- Line: 1617
        -- upvalues: u82 (copy)
        for _, descendant in pairs(u82.moveitgrab.Grip:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.8833333333333333, function() -- Line: 1625
        -- upvalues: u82 (copy), TekrinnDialogue (ref), u79 (copy)
        for _, descendant in pairs(u82.HollowSphere:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        u82.HollowSphere.Transparency = 0;
        u82.HollowSphere.Floor.Transparency = 0;

        for _, descendant in pairs(u82.egohead:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        task.wait(0.2375);
        TekrinnDialogue.Speak(u79, {
            {
                Text = "MOVE IT.",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 7.5,
                    Lifetime = 1
                }
            }
        });
    end);
    task.delay(2.0833333333333335, function() -- Line: 1663
        -- upvalues: u82 (copy), u87 (copy)
        local HollowSphere = u82.HollowSphere;

        for _, descendant in pairs(HollowSphere:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Speedlines" then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u82.egohead:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u87:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.wait(0.2);
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(HollowSphere:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "FAST" then
                descendant.Enabled = true;
                task.wait(0.2);
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.767, function() -- Line: 1701
        -- upvalues: u86 (copy), u82 (copy), u87 (copy), u85 (copy), mainreplication (ref), Lighting (ref), Brightness (ref)
        u86:Destroy();
        u82:Destroy();
        u87:Destroy();
        u85:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1.5);
        Lighting.Brightness = Brightness;
    end);
end;

function v1.NewFlow(u89, p90, p91) -- Line: 1725
    -- upvalues: Lighting (copy), trove (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), RunService (copy), TekrinnDialogue (copy), ClockTime (copy), Ambient (copy), Brightness (copy)
    local u92 = u89.HumanoidRootPart or u89.PrimaryPart;
    local _ = u89.Torso;
    local _ = Lighting.Atmosphere;
    local u93 = trove.new();
    u93:AttachToInstance(u89);
    u93:AttachToInstance(p91);

    local function _(p94, p95) -- Line: 1734
        -- upvalues: u93 (copy)
        u93:Add(task.delay(p94, p95));
    end;

    local function _(p96, p97, p98) -- Line: 1738
        for _, descendant in ipairs(p96:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if p97 ~= nil then
                    descendant.Enabled = p97;
                end;

                if p98 ~= nil then
                    descendant.TimeScale = p98;
                end;
            end;
        end;
    end;

    local u99 = false;

    local function _(p100, p101) -- Line: 1749
        -- upvalues: u99 (ref)
        if u99 then
            p101 = p100 or p101;
        end;

        return p101;
    end;

    mainreplication.sceneEnabled(true);
    local u102 = {};

    for _, descendant in ipairs(workspace.map.map:GetDescendants()) do
        if descendant:IsA("BasePart") then
            u102[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;

    Lighting.ClockTime = 0;
    Lighting.Bloom.Enabled = false;
    Lighting.Ambient = Color3.fromRGB(141, 141, 141);
    local u103 = u93:Clone(ReplicatedStorage.Resources.isagi.newisagiflow);
    u103:PivotTo(u92.CFrame);
    u103.Parent = workspace.Effects;
    local _, v104 = mainreplication.cutsceneBlender(u92, ReplicatedStorage.Resources.isagi.camnewflow, ReplicatedStorage.Resources.isagi.NewFlovFOV);
    u93:Add(v104);

    if Util.canshiftcolor(LocalPlayer, u89) then
        vfxUtil.LeanTowardsColor(u103, u89:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u89:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u105 = u93:Clone(ReplicatedStorage.Resources.isagi.newisagiflowhead);
    u105.Parent = u89;
    u105.Weld.Part0 = u89.Head;
    local v106 = u93:Clone(ReplicatedStorage.Resources.DepthOfField);
    v106.Parent = Lighting;
    v106.FarIntensity = 0;
    TweenService:Create(v106, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local u107 = u93:Add(vfxUtil.highlight(u89, {
        Name = "isagiawkhighlight",
        Enabled = true,
        FillTransparency = 1,
        OutlineTransparency = 0.876899719,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        FillColor = Color3.new(0.13333334, 0.262745112, 1),
        OutlineColor = Color3.new(1, 1, 1)
    }));
    u103.rootpos.light.Attachment.PointLight.Color = Color3.fromRGB(103, 152, 255);
    local u108 = soundUtil:play(ReplicatedStorage.Resources.isagi.isaginewflowS, SoundService, {
        Character = u89
    });

    if u108.Name == "Dub" then
        u99 = true;
    else
        u99 = false;
    end;

    u93:Connect(p91.Changed, function(p109) -- Line: 1807
        -- upvalues: u108 (copy), u93 (copy)
        if p109 then
            u108:Destroy();
            u93:Destroy();
        end;
    end);
    local u110 = u93:Add(Instance.new("ColorCorrectionEffect"));
    u110.Parent = Lighting;
    u93:Connect(RunService.PreRender, function(p111) -- Line: 1817
        -- upvalues: u103 (copy)
        local puzzles = u103.rootpos.puzzles;
        puzzles.CFrame = puzzles.CFrame * CFrame.Angles(0.08, 0, 0);
    end);
    u93:Add(Util.Preload(ReplicatedStorage.Resources.isagi.ImpactFrame5));
    task.spawn(function() -- Line: 1823
        -- upvalues: u105 (copy), u103 (copy), u93 (copy), Util (ref), ReplicatedStorage (ref)
        for _, descendant in ipairs(u105.norm1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u105.norm2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u103.rootpos.isagiawkbackground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u103.rootpos.isagiawkbackground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        u93:Add(Util.Gif(ReplicatedStorage.Resources.isagi.ImpactFrame5, 30));
    end);
    u93:Add(task.delay(0.85, function() -- Line: 1832
        -- upvalues: u103 (copy)
        local puzzles = u103.rootpos:WaitForChild("puzzles");

        for _, descendant in ipairs(puzzles:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        local littleflow = u103.rootpos:WaitForChild("littleflow");

        for _, descendant in ipairs(littleflow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u93:Add(task.delay(0.8833333333333333, function() -- Line: 1837
        -- upvalues: u103 (copy)
        local puddle1 = u103.rootpos:WaitForChild("puddle1");

        for _, descendant in ipairs(puddle1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        local puddle2 = u103.rootpos:WaitForChild("puddle2");

        for _, descendant in ipairs(puddle2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u93:Add(task.delay(0.917, function() -- Line: 1842
        -- upvalues: u110 (copy), TweenService (ref)
        u110.Brightness = 1;
        TweenService:Create(u110, TweenInfo.new(1), {
            Brightness = 0
        }):Play();
    end));
    u93:Add(task.delay(1.8333333333333333, function() -- Line: 1847
        -- upvalues: u103 (copy), TekrinnDialogue (ref), u89 (copy)
        for _, descendant in ipairs(u103.rootpos.isagiawkbackground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        TekrinnDialogue.Speak(u89, {
            {
                Text = "Blind spot. Off the ball.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3.5);
    end));
    u93:Add(task.delay(2.5166666666666666, function() -- Line: 1865
        -- upvalues: u103 (copy)
        for _, descendant in ipairs(u103.rootpos.isagiglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u93:Add(task.delay(3.117, function() -- Line: 1869
        -- upvalues: u107 (copy), TweenService (ref)
        u107.FillColor = Color3.fromRGB(0, 48, 255);
        u107.FillTransparency = 0;
        TweenService:Create(u107, TweenInfo.new(1), {
            FillTransparency = 1
        }):Play();
    end));
    u93:Add(task.delay(4, function() -- Line: 1875
        -- upvalues: u103 (copy)
        for _, descendant in ipairs(u103.rootpos.isagiawkbackground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.25;
            end;
        end;
    end));
    u93:Add(task.delay(5.5, function() -- Line: 1879
        -- upvalues: u103 (copy)
        for _, descendant in ipairs(u103.rootpos.isagiawkbackground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u103.rootpos.isagiawkbackground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end));
    u93:Add(task.delay(5.95, function() -- Line: 1884
        -- upvalues: u93 (copy), ReplicatedStorage (ref), u92 (copy), u89 (copy)
        local v112 = u93:Clone(ReplicatedStorage.Resources.isagi.puzzlefloattocam);
        v112.Motor6D.Part0 = u92;
        v112.Parent = u89;
    end));
    u93:Add(task.delay(7.317, function() -- Line: 1890
        -- upvalues: TweenService (ref), u110 (copy)
        local v113 = TweenService:Create(u110, TweenInfo.new(0.116), {
            Brightness = 1
        });
        v113:Play();
        v113.Completed:Wait();
        TweenService:Create(u110, TweenInfo.new(0.116), {
            Brightness = 0
        }):Play();
    end));
    u93:Add(task.delay(7.366666666666666, function() -- Line: 1897
        -- upvalues: u103 (copy)
        for _, descendant in ipairs(u103.rootpos.isagiglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u93:Add(task.delay(7.467, function() -- Line: 1901
        -- upvalues: TweenService (ref), u103 (copy)
        TweenService:Create(u103.rootpos.light.Attachment.PointLight, TweenInfo.new(2), {
            Color = Color3.fromRGB(127, 255, 125)
        }):Play();
    end));
    u93:Add(task.delay(7.483333333333333, function() -- Line: 1909
        -- upvalues: u105 (copy), TekrinnDialogue (ref), u89 (copy), u99 (ref)
        for _, descendant in ipairs(u105.flameye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u105.flameye2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u105.norm1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u105.norm2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        TekrinnDialogue.Speak(u89, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u99 and "Do me a favor and shut it, genius." or "I need you to shut up, genius.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end));
    u93:Add(task.delay(7.533, function() -- Line: 1931
        -- upvalues: u107 (copy), TweenService (ref)
        u107.FillColor = Color3.fromRGB(111, 255, 92);
        TweenService:Create(u107, TweenInfo.new(2), {
            FillColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end));
    u93:Add(task.delay(10.316666666666666, function() -- Line: 1936
        -- upvalues: u103 (copy)
        local puzzles = u103.rootpos:WaitForChild("puzzles");

        for _, descendant in ipairs(puzzles:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        local littleflow = u103.rootpos:WaitForChild("littleflow");

        for _, descendant in ipairs(littleflow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u93:Add(task.delay(10.8, function() -- Line: 1941
        -- upvalues: TweenService (ref), u103 (copy), TekrinnDialogue (ref), u89 (copy), u99 (ref)
        TweenService:Create(u103.rootpos.light.Attachment.PointLight, TweenInfo.new(0.15), {
            Color = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(u103.rootpos.background, TweenInfo.new(1), {
            Color = Color3.fromRGB(255, 255, 255)
        }):Play();
        TekrinnDialogue.Speak(u89, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u99 and "I\'m just about to get to the good part." or "I\'m about to get to the good part.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end));
    u93:Add(task.delay(11.116666666666667, function() -- Line: 1965
        -- upvalues: u103 (copy)
        for _, descendant in pairs(u103.rootpos.isagibeamend:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u93:Add(function() -- Line: 1973
        -- upvalues: mainreplication (ref), Lighting (ref), ClockTime (ref), Ambient (ref), Brightness (ref), u102 (copy), u93 (copy)
        mainreplication.sceneEnabled(false);
        Lighting.Bloom.Enabled = true;
        Lighting.ClockTime = ClockTime;
        Lighting.Ambient = Ambient;
        Lighting.Brightness = Brightness;

        for i, v in u102 do
            i.Transparency = v;
        end;

        table.clear(u102);
        mainreplication.ultFlash(1, 1.5);
        u93:Destroy();
    end);
    u93:Add(task.delay(12.883, function() -- Line: 1991
        -- upvalues: u93 (copy)
        u93:Destroy();
    end));
end;

function v1.u20Directshot(u114, u115) -- Line: 1996
    -- upvalues: Lighting (copy), mainreplication (copy), StarterGui (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy), TweenService (copy), animationUtil (copy), Density (copy), Color (copy), Brightness (copy)
    local Ball = u114:FindFirstChild("Ball");
    local v116 = u114.HumanoidRootPart or u114.PrimaryPart;
    local _ = u114.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1);

    if u115 then
        task.spawn(function() -- Line: 2006
            -- upvalues: mainreplication (ref), StarterGui (ref)
            for i = 1, 100 do
                task.wait(0.016666666666666666);
                mainreplication.sceneEnabled(true);
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false);
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
                local _ = i;
            end;
        end);
    end;

    local u117 = ReplicatedStorage.Resources.isagi.u20allEffects:Clone();
    u117:PivotTo(v116.CFrame);
    u117.Parent = u114;

    if Util.canshiftcolor(LocalPlayer, u114) then
        vfxUtil.LeanTowardsColor(u117, u114:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u114:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in pairs(u117:GetDescendants()) do
        if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        elseif descendant:IsA("BasePart") or descendant:IsA("Texture") then
            descendant.Transparency = 1;
        end;
    end;

    local u118 = ReplicatedStorage.Resources.isagi.u20CamEff:Clone();
    u118.Parent = u117;
    local u119 = nil;
    u119 = RunService.PreRender:connect(function() -- Line: 2037
        -- upvalues: u118 (copy), u119 (ref)
        if u118:IsDescendantOf(game) then
            u118.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u119:Disconnect();
    end);
    local u120 = ReplicatedStorage.Resources.vb:Clone();
    u120.Parent = PlayerGui;
    local u121 = ReplicatedStorage.Resources.glowscreen:Clone();
    u121.Parent = PlayerGui;
    u121.ImageLabel2.ImageTransparency = 0.7;
    u121.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    local u122 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u122.Parent = Lighting;
    u122.FarIntensity = 1;
    local u123 = soundUtil:play(ReplicatedStorage.Resources.isagi["isagiu20 goal"], SoundService);
    mainreplication.cutsceneBlender(v116, ReplicatedStorage.Resources.isagi.u20Cam, ReplicatedStorage.Resources.isagi.u20FOV);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(191, 218, 255);
    ColorCorrectionEffect.Brightness = -0.2;
    ColorCorrectionEffect.Saturation = -1;
    task.delay(1.7, function() -- Line: 2071
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(191, 218, 255);
        ColorCorrectionEffect.Saturation = -0.6;
    end);
    task.delay(5.35, function() -- Line: 2076
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        ColorCorrectionEffect.Brightness = -0.1;
        ColorCorrectionEffect.Contrast = 0.5;
        ColorCorrectionEffect.Saturation = -1;
    end);
    task.delay(7.35, function() -- Line: 2083
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        ColorCorrectionEffect.Brightness = 1;
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.Saturation = 0;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.95, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Brightness = 0,
            TintColor = Color3.fromRGB(236, 239, 255)
        }):Play();
    end);
    task.delay(16.6, function() -- Line: 2092
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect.Saturation = -0.3;
    end);
    local JJ = u117.JJ;
    animationUtil:loadAnimation(JJ, ReplicatedStorage.Resources.isagi.u20JJ):Play(0);
    local u124 = {};

    for _, descendant in pairs(JJ:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant ~= JJ.RootPart then
            descendant.Transparency = 0;
        end;
    end;

    for _, descendant in pairs(JJ:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    for _, descendant in pairs(u117.HELP:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(5.317, function() -- Line: 2121
        -- upvalues: u117 (copy)
        for _, descendant in pairs(u117.HELP:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(5.617, function() -- Line: 2131
        -- upvalues: JJ (copy)
        for _, descendant in pairs(JJ:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(7.317, function() -- Line: 2141
        -- upvalues: Atmosphere (copy)
        Atmosphere.Density = 3;
        Atmosphere.Color = Color3.fromRGB(30, 30, 30);
    end);
    task.delay(7.333, function() -- Line: 2146
        -- upvalues: u114 (copy), ReplicatedStorage (ref), u124 (copy), u117 (copy)
        for _, descendant in ipairs(u114:GetDescendants()) do
            if descendant:IsA("Part") and (descendant.Transparency < 1 and descendant ~= u114.Head) then
                local v125 = ReplicatedStorage.Resources.isagi.u20Aura:Clone();
                v125.Parent = descendant;
                table.insert(u124, v125);
            end;
        end;

        for _, descendant in pairs(u117.AURA1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u117.HELP3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(7.35, function() -- Line: 2172
        -- upvalues: u118 (copy), u117 (copy), JJ (copy)
        u118.Attachment.SpotLight.Enabled = true;
        u117.groundpuzzlepieces.Transparency = 0;
        u117.groundpuzzlepieces.Texture.Transparency = 0;

        for _, descendant in pairs(JJ:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant ~= JJ.RootPart then
                descendant.Material = Enum.Material.Neon;
            end;
        end;

        for _, descendant in pairs(u118:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u117.BEAMWIND:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.517, function() -- Line: 2201
        -- upvalues: u117 (copy), u118 (copy)
        for _, descendant in pairs(u117.AURA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u118:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u117.BEAMWIND:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(9.667, function() -- Line: 2226
        -- upvalues: u117 (copy)
        for _, descendant in pairs(u117.PuzzlePiecesShot:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Transparency = 0;
            end;
        end;
    end);
    task.delay(10.1, function() -- Line: 2234
        -- upvalues: u117 (copy)
        for _, descendant in pairs(u117.JJ:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(14.3, function() -- Line: 2244
        -- upvalues: Atmosphere (copy), Density (ref), Color (ref)
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
    end);
    task.delay(14.317, function() -- Line: 2249
        -- upvalues: u124 (copy), u117 (copy)
        for _, v in u124 do
            v:Destroy();
        end;

        for _, descendant in pairs(u117.AURA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u117.AURA1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u117.PuzzlePiecesShot:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Transparency = 1;
            end;
        end;
    end);
    task.delay(14.333, function() -- Line: 2275
        -- upvalues: u117 (copy)
        u117.Part.Transparency = 0;

        for _, descendant in pairs(u117.Part:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(15.8, function() -- Line: 2286
        -- upvalues: u117 (copy)
        for _, descendant in pairs(u117.JJ:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(16.6, function() -- Line: 2295
        -- upvalues: u117 (copy), u118 (copy)
        u117.groundpuzzlepieces.Transparency = 1;
        u117.groundpuzzlepieces.Texture.Transparency = 1;
        u118.Attachment.SpotLight.Enabled = false;
        u117.Part:Destroy();
    end);
    task.delay(16.883, function() -- Line: 2304
        -- upvalues: u117 (copy)
        for _, descendant in ipairs(u117.shootpart1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(17.667, function() -- Line: 2312
        -- upvalues: u117 (copy)
        for _, descendant in ipairs(u117.shootpart2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(18.533, function() -- Line: 2320
        -- upvalues: u117 (copy), ReplicatedStorage (ref), Ball (copy)
        for _, descendant in ipairs(u117.shootpart3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u117.ignore:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v126 = ReplicatedStorage.Resources.isagi.Ballshot2trail:Clone();
        v126.Parent = u117;
        v126.Weld.Part0 = Ball;
        task.delay(0.484, v126.Destroy, v126);
    end);
    task.delay(18.533, function() -- Line: 2340
        -- upvalues: u117 (copy)
        for _, descendant in ipairs(u117.shootpart3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u117.ignore:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(19.133, function() -- Line: 2354
        -- upvalues: u117 (copy)
        for _, descendant in ipairs(u117.shootpart4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(19.3, function() -- Line: 2362
        -- upvalues: u117 (copy)
        for _, descendant in ipairs(u117.Ballshot4waves:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(20.333, function() -- Line: 2370
        -- upvalues: u117 (copy)
        for _, descendant in ipairs(u117.shootpart5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(20.667, function() -- Line: 2480
        -- upvalues: u122 (copy), ColorCorrectionEffect (copy), u117 (copy), u118 (copy), u115 (copy), TweenService (ref), u123 (copy), u120 (copy), u121 (copy), StarterGui (ref), mainreplication (ref), Lighting (ref), Brightness (ref)
        u122:Destroy();
        ColorCorrectionEffect:Destroy();
        u117:Destroy();
        u118:Destroy();

        if u115 then
            TweenService:Create(u123, TweenInfo.new(0.5), {
                Volume = 0.1
            }):Play();
        end;

        u120:Destroy();
        u121:Destroy();
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1.5);
        Lighting.Brightness = Brightness;
    end);
end;

function v1.iwanttowinwithmygoal(u127: any, p128: number) -- Line: 2518
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), WickerSprite (copy), Util (copy), TekrinnDialogue (copy)
    local iwanttowinwithmygoal = vfxUtil.getResources().isagi.iwanttowinwithmygoal;
    local Root = vfxUtil.getRoot(u127);
    soundUtil:play(iwanttowinwithmygoal.SFX, "default");
    mainreplication.sceneEnabled(true);
    local u129 = trove.new();
    u129:Add(function() -- Line: 2526
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(1);
        mainreplication.sceneEnabled(false);
    end);
    u129:Add(task.delay(p128, function() -- Line: 2530
        -- upvalues: u129 (copy)
        u129:Destroy();
    end));
    u129:Add(mainreplication.kuronaCam(Root, iwanttowinwithmygoal.Cam, iwanttowinwithmygoal.FOV));
    local v130 = u129:Clone(iwanttowinwithmygoal.VFX);
    v130:PivotTo(Root.CFrame);
    local u131 = u129:Add(v130.Initialized);
    u131.Parent = u127;
    vfxUtil.setupAura(u127, u131, true);

    for _, v in u131:QueryDescendants("Motor6D") do
        if v.Part0 and v.Part0.Parent == u131 then
            v.Part0 = u127:FindFirstChild(v.Name) or v.Part0;
        end;
    end;

    v130.Parent = workspace.Effects;
    local u132 = u129:Clone(iwanttowinwithmygoal.my_goal);
    u132.Parent = vfxUtil.getPlayerGui();
    local v133 = WickerSprite.new();
    v133.TotalFrames = 9;
    v133.Frames = Vector2.new(3, 3);
    v133.FPS = 10;
    v133.Dimensions = Vector2.new(1024, 576);
    v133:Add(u132.ImageLabel);
    v133:AttachToInstance(u132);
    v133:Play();
    u129:Add(task.delay(0.9, function() -- Line: 2560
        -- upvalues: u132 (copy), mainreplication (ref)
        u132:Destroy();
        mainreplication.ultFlash(1);
    end));
    u129:Add(Util.frame_delay(54, function() -- Line: 2565
        -- upvalues: u131 (copy)
        local Puzzle = u131.Torso.Puzzle;
        Puzzle:Emit(Puzzle:GetAttribute("EmitCount"));
    end));
    u129:Add(task.delay(1.426, function() -- Line: 2570
        -- upvalues: u129 (copy), TekrinnDialogue (ref), u127 (copy)
        u129:Add(TekrinnDialogue.Speak(u127, {
            {
                Text = "I want to win with my goal!",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }, 3));
    end));
end;

function v1.reflexshot(u134) -- Line: 2594
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), Players (copy), LocalPlayer (copy), Lighting (copy), MoonPropertyAnimator (copy), animationUtil (copy), TekrinnDialogue (copy)
    local ReflexShot = vfxUtil.getResources().isagi.ReflexShot;
    local Root = vfxUtil.getRoot(u134);
    soundUtil:play(ReflexShot.SFX, "default");
    local u135 = vfxUtil.character_trove(u134);
    mainreplication.ultFlash(1);
    mainreplication.sceneEnabled(true);
    u135:Add(function() -- Line: 2604
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(1);
        mainreplication.sceneEnabled(false);
    end);
    local v136 = u135:Clone(ReflexShot.VFX);
    v136:PivotTo(Root.CFrame);
    vfxUtil.setupAura(u134, v136.TuffCharacterRig0, true);
    v136.Parent = workspace.Effects;
    local u137;

    if Players:GetPlayerFromCharacter(u134) then
        u137 = u135:Construct(vfxUtil.newRig, Root);
        task.defer(function() -- Line: 2617
            -- upvalues: u137 (ref), Players (ref), u134 (copy)
            local v138 = u137:FindFirstChildWhichIsA("Humanoid");

            if not v138 then
                return;
            end;

            local GetHumanoidDescriptionFromUserId = Players.GetHumanoidDescriptionFromUserId;
            local UserId = Players:GetPlayerFromCharacter(u134).UserId;
            local success, result = pcall(GetHumanoidDescriptionFromUserId, Players, UserId);

            if success and result then
                v138:ApplyDescriptionAsync(result);
            end;
        end);
    else
        u137 = u135:Construct(vfxUtil.newRig, Root);
        task.defer(function() -- Line: 2629
            -- upvalues: u137 (ref), Players (ref), LocalPlayer (ref)
            local v139 = u137:FindFirstChildWhichIsA("Humanoid");

            if not v139 then
                return;
            end;

            local success, result = pcall(Players.GetHumanoidDescriptionFromUserId, Players, LocalPlayer.UserId);

            if success and result then
                v139:ApplyDescriptionAsync(result);
            end;
        end);
    end;

    vfxUtil.setupAura(u137, v136.TuffCharacterRig2, true);
    local _baseplate_controller, u140 = vfxUtil.get_baseplate_controller();
    u135:Add(vfxUtil.make_baseplate_connection(_baseplate_controller));
    u135:Add(function() -- Line: 2645
        -- upvalues: u140 (copy), _baseplate_controller (copy)
        u140.Transparency = 0;
        _baseplate_controller.update();
    end);
    u135:Add(task.delay(1.017, function() -- Line: 2650
        -- upvalues: u140 (copy)
        u140.Transparency = 1;
    end));
    u135:Add(task.delay(1.842, function() -- Line: 2654
        -- upvalues: u140 (copy)
        u140.Transparency = 0;
    end));
    local v141, v142 = mainreplication.cutsceneCamRigWithLetterBox(Root, ReflexShot.Camera, ReflexShot.FOV, u134, "default", ReflexShot["CamRigWithLetterBox "]);
    u135:Add(v142);

    if v141 then
        v141:SetAttribute("FPS", 120);
    end;

    local v143 = {
        Vignette = u135:Add(vfxUtil.getMoonEffects()).Vignette,
        Workspace = v136,
        Lighting = Lighting
    };
    vfxUtil.cutscene_lighting(u135, v143, ReflexShot.Lighting, {
        Brightness = 3,
        ClockTime = 14.5,
        GeographicLatitude = 0,
        ExposureCompensation = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    local v144 = u135:Construct(MoonPropertyAnimator);
    v144:LoadAndConvertSave(ReflexShot.Moon, v143);
    v144:SetOriginalRoot(ReflexShot.Origin.Value);
    v144:SetRoot(Root);
    v144:SetFPS(120);
    local v145 = animationUtil:loadAnimation(v136.JJ, ReflexShot.Puzzles);
    local v146 = animationUtil:loadAnimation(u137, ReflexShot.Fall);
    local v147 = animationUtil:loadAnimation(u134, ReflexShot.Isagi);
    v146:Play(0);
    v145:Play(0);
    v147:Play(0);
    v144:PlayAll();
    vfxUtil.execute_compiled_ex(ReflexShot.Compiled, u135, v144.FrameRate, v136);
    u135:Add(function() -- Line: 2698
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u135:Add(task.delay(9.08, function() -- Line: 2703
        -- upvalues: u135 (copy)
        u135:Destroy();
    end));
    u135:Add(task.delay(2.4, function() -- Line: 2707
        -- upvalues: u135 (copy), TekrinnDialogue (ref), u134 (copy)
        u135:Add(TekrinnDialogue.Speak(u134, {
            {
                Text = "I want to ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            },
            {
                Text = "win",
                Bold = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 53, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            },
            {
                Text = ".",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1.6));
    end));
    u135:Add(task.delay(5.2, function() -- Line: 2749
        -- upvalues: u135 (copy), TekrinnDialogue (ref), u134 (copy)
        u135:Add(TekrinnDialogue.Speak(u134, {
            {
                Text = "The time to ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            },
            {
                Text = "evolve",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            },
            {
                Text = " is..",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 5));
    end));
    u135:Add(task.delay(7, function() -- Line: 2791
        -- upvalues: u135 (copy), TekrinnDialogue (ref), u134 (copy)
        u135:Add(TekrinnDialogue.Speak(u134, {
            {
                Text = "now!",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5
                }
            }
        }, 2));
    end));
end;

function v1.reflexshotrun(p148: any, p149: userdata) -- Line: 2811
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy)
    local Root = vfxUtil.getRoot(p148);
    local v150 = trove.new();
    v150:AttachToInstance(p149);
    local v151 = mainreplication.bodyVelocity(Root, 97.33500000000001, 7, true, nil, nil, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0));

    if v151 then
        v150:Add(v151);
    end;

    local isagi = vfxUtil.getResources().isagi;
    soundUtil:play(isagi.ReflexShot.RunSFX, v151 and "default" or Root);
    local v152 = v150:Clone(isagi.iwanttowinwithmygoal.runALLVFX);
    v152.Weld.Part0 = Root;
    v152.Parent = p148;
end;

function v1.reflexshotcomplete(p153) -- Line: 2831
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local Shot = vfxUtil.getResources().isagi.ReflexShot.Shot;
    local Root = vfxUtil.getRoot(p153);
    soundUtil:play(Shot.Sound, "default");
    local u154 = vfxUtil.character_trove(p153);
    mainreplication.ultFlash(1);
    mainreplication.sceneEnabled(true);
    u154:Add(function() -- Line: 2841
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(1);
        mainreplication.sceneEnabled(false);
    end);
    local v155 = u154:Clone(Shot.VFX);
    v155:PivotTo(Root.CFrame);
    v155.Parent = workspace.Effects;
    local v156 = u154:Construct(Shot.UserAura);
    vfxUtil.setupAura(p153, v156, true);
    v156.Parent = workspace.Effects;
    local _, v157 = mainreplication.cutsceneCamRigWithLetterBox(Root, Shot.Camera, Shot.FOV, p153, "default", Shot["CamRigWithLetterBox "]);
    u154:Add(v157);
    local v158 = {
        Vignette = u154:Add(vfxUtil.getMoonEffects()).Vignette,
        Workspace = v155,
        Lighting = Lighting
    };
    vfxUtil.contain_lighting(u154, v158, Shot.Lighting);
    local v159 = u154:Construct(MoonPropertyAnimator);
    v159:LoadAndConvertSave(Shot.Moon, v158);
    v159:SetRoot(Root);
    v159:SetOriginalRoot(v155.Origin.Value);
    v159:PlayAll();
    vfxUtil.execute_compiled(Shot.Compiled, u154, v155, v156);
    u154:Add(function() -- Line: 2875
        -- upvalues: vfxUtil (ref), mainreplication (ref)
        vfxUtil.restore_lighting_properties();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u154:Add(task.delay(5.26, function() -- Line: 2881
        -- upvalues: u154 (copy)
        u154:Destroy();
    end));
end;

return v1;