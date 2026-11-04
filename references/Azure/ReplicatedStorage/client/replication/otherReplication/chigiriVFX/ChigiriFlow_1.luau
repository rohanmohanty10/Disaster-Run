 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local Lighting = game:GetService("Lighting");
game:GetService("SoundService");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local _ = workspace.CurrentCamera;
local PlayerGui = Players.LocalPlayer.PlayerGui;
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local _ = Lighting.GeographicLatitude;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local _ = Lighting.OutdoorAmbient;
local ExposureCompensation = Lighting.ExposureCompensation;
local Threshold = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
local mainreplication = require(script.Parent.Parent.Parent.mainreplication);
local TekrinnDialogue = require(script.Parent.Parent.Parent.TekrinnDialogue);
local MeshEmitter = require(script.Parent.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.util.SignalValue);
local UwUEffects = require(ReplicatedStorage.util.UwUEffects);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local PlayerGui2 = Players.LocalPlayer.PlayerGui;
local Brightness = Lighting.Brightness;
require(ReplicatedStorage.util.KatUtil);

return function(p1: table) -- Line: 52
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), vfxUtil (copy), PlayerGui (copy), mainreplication (copy), Util (copy), soundUtil (copy), Debris (copy), animationUtil (copy), UwUEffects (copy), PlayerGui2 (copy), MeshEmitter (copy), TweenService (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), Density (copy), Color (copy), TekrinnDialogue (copy)
    local Value = p1.Character.Value;
    local Atmosphere = Lighting.Atmosphere;
    local _ = Value.Humanoid;
    local v2 = Value.HumanoidRootPart or Value.PrimaryPart;
    local chigiri = ReplicatedStorage.Resources.chigiri;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local u3 = ReplicatedStorage.Resources.uibox:Clone();
    u3.Parent = PlayerGui;
    Lighting.Brightness = 1;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 3.55;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.25;
    ColorCorrectionEffect.Saturation = -0.1;
    ColorCorrectionEffect.Brightness = 0;
    local u4 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u4.Parent = Lighting;
    u4.FarIntensity = 1;
    local v5 = mainreplication.cutscene(v2, CFrame.new(Vector3.new(0, 0, 0)), 17.35, chigiri.CHIGIRIFLOWFOV);

    for _, child in chigiri.Cam:GetChildren() do
        child:Clone().Parent = v5;
    end;

    local u6 = Util.Preload({ ReplicatedStorage.Resources.chigiri.AwakeningImpact1, ReplicatedStorage.Resources.chigiri.AwakeningImpact2, ReplicatedStorage.Resources.chigiri.AwakeningImpact3 });
    local u7 = ReplicatedStorage.Resources.chigiri.awakenCC:Clone();
    u7.Parent = Lighting;
    local u8 = ReplicatedStorage.Resources.chigiri.awakenBlur:Clone();
    u8.Parent = Lighting;
    local v9 = soundUtil:play(chigiri.ChigiriAwaken, ReplicatedStorage, {
        Character = Value
    });
    Util.AttributeTween(u7);
    Util.AttributeTween(u8);
    local u10 = chigiri.ChainRig:Clone();
    Util.Weld(v2, v2, u10.RootPart, CFrame.new(0, -3, 0, -1, 0, -8.74227766e-8, 0, 1, 0, 8.74227766e-8, 0, -1));
    u10.Parent = Value;
    Debris:AddItem(u10, 16.8);
    animationUtil:loadAnimation(u10, chigiri.ChainAnim):Play(0);
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1);
    Util.MidLighting();
    UwUEffects.createEffect({
        Character = Value
    }, script.Name);
    local u11 = ReplicatedStorage.Resources.chigiri.flowVignette:Clone();
    u11.Parent = PlayerGui2;
    Util.AttributeTween(u11);
    local u12 = MeshEmitter.StartMeshEmitter(v2, ReplicatedStorage.Resources.chigiri.AwakeningModel);
    task.delay(10.95, function() -- Line: 130
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.chigiri.AwakeningImpact1, 30);
    end);
    task.delay(12.1, function() -- Line: 134
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.chigiri.AwakeningImpact2, 30);
    end);
    task.delay(12.56, function() -- Line: 138
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.chigiri.AwakeningImpact3, 30);
    end);
    task.delay(14, function() -- Line: 142
        -- upvalues: u10 (copy), TweenService (ref)
        for _, child in pairs(u10:GetChildren()) do
            if child:IsA("MeshPart") then
                TweenService:Create(child, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end);
    task.delay(17.2, function() -- Line: 150
        -- upvalues: ScreenDimmer (copy), mainreplication (ref), u12 (copy), u7 (copy), u8 (copy), u11 (copy), Util (ref), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Atmosphere (copy), Density (ref), Color (ref), u3 (copy), u4 (copy), ColorCorrectionEffect (copy)
        ScreenDimmer:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1.5);
        u12:Destroy();
        u7:Destroy();
        u8:Destroy();
        u11:Destroy();
        Util.ReturnLighting();
        mainreplication.fov(false, 15);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u3:Destroy();
        u4:Destroy();
        ColorCorrectionEffect:Destroy();
    end);

    if v9.Name == "Dub" then
        TekrinnDialogue.Speak(Value, {
            {
                Text = "No more waiting.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 0.5
                }
            }
        }, 0.25);
        task.delay(1.7, function() -- Line: 203
            -- upvalues: TekrinnDialogue (ref), Value (copy)
            TekrinnDialogue.Speak(Value, {
                {
                    Text = "If it tears again, so be it.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 2);
        end);
        task.delay(5, function() -- Line: 229
            -- upvalues: TekrinnDialogue (ref), Value (copy)
            TekrinnDialogue.Speak(Value, {
                {
                    Text = "I don\'t care if this is my last match.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 1.5);
        end);
        task.delay(7.9, function() -- Line: 255
            -- upvalues: TekrinnDialogue (ref), Value (copy)
            TekrinnDialogue.Speak(Value, {
                {
                    Text = "Ready or not, leg.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 2);
        end);
        task.delay(13.5, function() -- Line: 281
            -- upvalues: TekrinnDialogue (ref), Value (copy)
            TekrinnDialogue.Speak(Value, {
                {
                    Text = "I\'m the best striker in the world. I\'LL PROVE IT!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.06,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 3.2);
        end);
    else
        TekrinnDialogue.Speak(Value, {
            {
                Text = "I don\'t care anymore.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 0.5
                }
            }
        }, 0.25);
        task.delay(1.7, function() -- Line: 331
            -- upvalues: TekrinnDialogue (ref), Value (copy)
            TekrinnDialogue.Speak(Value, {
                {
                    Text = "If it tears again, so be it.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 2);
        end);
        task.delay(5, function() -- Line: 357
            -- upvalues: TekrinnDialogue (ref), Value (copy)
            TekrinnDialogue.Speak(Value, {
                {
                    Text = "I don\'t care if this is my last play.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 1.5);
        end);
        task.delay(7.9, function() -- Line: 383
            -- upvalues: TekrinnDialogue (ref), Value (copy)
            TekrinnDialogue.Speak(Value, {
                {
                    Text = "Are you ready, right leg?",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 2);
        end);
        task.delay(13.5, function() -- Line: 409
            -- upvalues: TekrinnDialogue (ref), Value (copy)
            TekrinnDialogue.Speak(Value, {
                {
                    Text = "The best striker in the world, IS ME!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.08,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 3.2);
        end);
    end;

    task.delay(16, function() -- Line: 437
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;