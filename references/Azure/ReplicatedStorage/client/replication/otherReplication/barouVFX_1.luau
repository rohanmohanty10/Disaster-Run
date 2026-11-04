 
 

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
local RunService2 = game:GetService("RunService");
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local v1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local Brightness = Lighting.Brightness;
local ClockTime = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local Contrast = Lighting.ColorCorrection.Contrast;
local Saturation = Lighting.ColorCorrection.Saturation;
local Threshold = Lighting.Bloom.Threshold;
local MeshEmitter = require(script.Parent.Parent.MeshEmitter);
local raycast = require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local Util = require(ReplicatedStorage.util.Util);
local MoonPropertyAnimator2 = require(ReplicatedStorage.util.MoonPropertyAnimator);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local trove = require(ReplicatedStorage.forum.trove);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.util.KatUtil);

function getLorenzoLine(p2, p3)
    -- upvalues: Players (copy)
    local setting = Players.LocalPlayer:FindFirstChild("setting");

    if setting and (setting:FindFirstChild("alternatelines") and not setting.alternatelines.Value) then
        return p2;
    end;

    if p3:FindFirstChild("RickLines") and p3.RickLines:FindFirstChild(p2.Name) then
        return p3.RickLines[p2.Name];
    end;

    if p3:FindFirstChild((`{p2.Name}-Rick`)) then
        return p3[`{p2.Name}-Rick`];
    end;

    return p2;
end;

Util.OnFoundInstance(ReplicatedStorage.Resources, "barou", function() -- Line: 72
    -- upvalues: Util (copy), ReplicatedStorage (copy)
    Util.Preload(ReplicatedStorage.Resources.barou.ImpactFrame1, true);
    Util.Preload(ReplicatedStorage.Resources.barou.ImpactFrame6, true);
end);

function v1.barou_ot_leon(u4: userdata) -- Line: 77
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Util (copy), ReplicatedStorage (copy), animationUtil (copy), TekrinnDialogue (copy), MoonPropertyAnimator2 (copy)
    local Root = vfxUtil.getRoot(u4);
    local barouovertime = vfxUtil.getResources().barou.barouovertime;
    mainreplication.sceneEnabled(true);
    local u5 = vfxUtil.character_trove(u4);
    local v6 = u5:Construct(barouovertime.UserVFX);
    vfxUtil.setupAura(u4, v6, true);
    v6.Parent = workspace.Effects;
    local v7 = u5:Clone(barouovertime.VFX);
    v7:PivotTo(Root.CFrame);
    v7.Parent = workspace.Effects;
    soundUtil:play(barouovertime.sound, SoundService, {
        Character = u4
    });
    local v8, v9 = mainreplication.cutsceneCamRigWithLetterBox(Root, barouovertime.Camera, barouovertime.FOV, u4, "default", barouovertime["CamRigWithLetterBox "]);
    u5:Add(v9);
    local u10 = Util.Preload(ReplicatedStorage.Resources.barou.ImpactFrame1);
    u5:Add(task.spawn(function() -- Line: 98
        -- upvalues: u5 (copy), barouovertime (copy), u4 (copy)
        local v11 = u5:Clone(barouovertime.BallVFX:FindFirstChildOfClass("Attachment"));
        v11.Parent = u4.Ball;
        shared.vfx.emit(v11);
    end));
    u5:Add(animationUtil:loadAnimation(v7:FindFirstChild("RedLion"), barouovertime["El Leon"]), "Stop"):Play();
    u5:Add(function() -- Line: 108
        -- upvalues: mainreplication (ref), u10 (copy)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
        u10:Destroy();
    end);
    local v12 = {
        Vignette = u5:Add(vfxUtil.getMoonEffects()).Vignette,
        Workspace = v7,
        workspace = v7
    };
    u5:Add(task.spawn(function() -- Line: 122
        -- upvalues: TekrinnDialogue (ref), u4 (copy)
        task.delay(0.1, function() -- Line: 123
            -- upvalues: TekrinnDialogue (ref), u4 (ref)
            TekrinnDialogue.Speak(u4, {
                {
                    Text = "I was getting tired of waiting.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 1);
        end);
        task.delay(3, function() -- Line: 149
            -- upvalues: TekrinnDialogue (ref), u4 (ref)
            TekrinnDialogue.Speak(u4, {
                {
                    Text = "I need more to devour...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 1.5);
        end);
        task.delay(5, function() -- Line: 175
            -- upvalues: TekrinnDialogue (ref), u4 (ref)
            TekrinnDialogue.Speak(u4, {
                {
                    Text = "I\'ll devour everything in this match.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.08,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 3.5);
        end);
        task.delay(9.25, function() -- Line: 201
            -- upvalues: TekrinnDialogue (ref), u4 (ref)
            TekrinnDialogue.Speak(u4, {
                {
                    Text = "ALL OF YOU!",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
    end));
    vfxUtil.contain_lighting(u5, v12, barouovertime.Lighting);
    local v13 = u5:Construct(MoonPropertyAnimator2);
    v13:LoadAndConvertSave(barouovertime.Moon, v12);
    v13:SetRoot(Root);
    v13:PlayAll();
    vfxUtil.execute_compiled(barouovertime.Compiled, u5, v8, v7, v6);
    u5:Add(task.delay(7.35, function() -- Line: 237
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame1, 40);
    end));
    u5:Add(task.delay(11.05, function() -- Line: 241
        -- upvalues: u5 (copy)
        u5:Destroy();
    end));
end;

function v1.baroukyun(u14) -- Line: 246
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy), animationUtil (copy), TekrinnDialogue (copy), Players (copy), Brightness (copy), Threshold (copy)
    local v15 = u14.HumanoidRootPart or u14.PrimaryPart;
    local _ = u14.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local u16 = ReplicatedStorage.Resources.barou.barouKyunEff:Clone();
    u16:PivotTo(v15.CFrame);
    u16.Parent = u14;
    local u17 = ReplicatedStorage.Resources.barou["Barou barou kyun"]:Clone();
    u17.Parent = u14;
    u17.RootPart.RootPart.Part0 = u14.Head;
    local u18 = ReplicatedStorage.Resources.barou.LeftHand:Clone();
    u18.Parent = u14;
    u18.LeftHand.LeftHand.Part0 = u14["Left Arm"];
    local u19 = ReplicatedStorage.Resources.barou.RightHand:Clone();
    u19.Parent = u14;
    u19.RightHand.RightHand.Part0 = u14["Right Arm"];

    if Util.canshiftcolor(LocalPlayer, u14) then
        vfxUtil.LeanTowardsColor(u16, u14:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u14:GetAttribute("CustomAlpha") or 0.985);
    end;

    local v20 = soundUtil:play(ReplicatedStorage.Resources.barou.defineaura, SoundService, {
        Character = u14
    });
    mainreplication.cutsceneBlender(v15, ReplicatedStorage.Resources.barou.baroukyunCam, ReplicatedStorage.Resources.barou.baroukyunFOV);
    animationUtil:loadAnimation(u17, ReplicatedStorage.Resources.barou.baroukyun):Play(0);
    local u21 = {};
    local u22 = {};
    local u23 = {};

    if v20.Name == "Dub" then
        task.delay(1.1, function() -- Line: 287
            -- upvalues: TekrinnDialogue (ref), u14 (copy)
            TekrinnDialogue.Speak(u14, {
                {
                    Text = "Barou, Barou, and ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 149, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = "kyun!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 52, 184)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(3.917, function() -- Line: 335
            -- upvalues: TekrinnDialogue (ref), u14 (copy)
            TekrinnDialogue.Speak(u14, {
                {
                    Text = "Try!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(224, 111, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(6.433, function() -- Line: 361
            -- upvalues: TekrinnDialogue (ref), Players (ref)
            TekrinnDialogue.Speak(Players:GetPlayers()[math.random(1, #Players:GetPlayers())].Character, {
                {
                    Text = "Barou, Barou, ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 149, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = "kyun!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 52, 184)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(7, function() -- Line: 409
            -- upvalues: TekrinnDialogue (ref), u14 (copy)
            TekrinnDialogue.Speak(u14, {
                {
                    Text = "Once more!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 149, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(8.233, function() -- Line: 435
            -- upvalues: TekrinnDialogue (ref)
            TekrinnDialogue.Speak("Everyone", {
                {
                    Text = "Barou, Barou, ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.06,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 149, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = "kyuuun!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.04,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 52, 184)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 3, "rbxassetid://1169418192");
        end);
    else
        task.delay(1.6, function() -- Line: 483
            -- upvalues: TekrinnDialogue (ref), u14 (copy)
            TekrinnDialogue.Speak(u14, {
                {
                    Text = "Barou, Barou, ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 149, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = "kyun!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 52, 184)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(4.017, function() -- Line: 531
            -- upvalues: TekrinnDialogue (ref), u14 (copy)
            TekrinnDialogue.Speak(u14, {
                {
                    Text = "You try.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(224, 111, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(5.333, function() -- Line: 557
            -- upvalues: TekrinnDialogue (ref), Players (ref)
            TekrinnDialogue.Speak(Players:GetPlayers()[math.random(1, #Players:GetPlayers())].Character, {
                {
                    Text = "Barou, Barou, ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 149, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = "kyun!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 52, 184)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(7.5, function() -- Line: 605
            -- upvalues: TekrinnDialogue (ref), u14 (copy)
            TekrinnDialogue.Speak(u14, {
                {
                    Text = "Again.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 149, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(8.433, function() -- Line: 631
            -- upvalues: TekrinnDialogue (ref)
            TekrinnDialogue.Speak("Everyone", {
                {
                    Text = "Barou, Barou, ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 149, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = "kyun!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 52, 184)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 3, "rbxassetid://1169418192");
        end);
    end;

    for _, descendant in ipairs(u17:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Transparency < 1 then
            u21[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;

    for _, descendant in ipairs(u19:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Transparency < 1 then
            u23[descendant] = descendant.Transparency;
        end;
    end;

    for _, descendant in ipairs(u18:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Transparency < 1 then
            u22[descendant] = descendant.Transparency;
        end;
    end;

    for _, descendant in ipairs(u16:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(1.05, function() -- Line: 701
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.baroukyunspecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.1, function() -- Line: 709
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.barouheartbg:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.117, function() -- Line: 716
        -- upvalues: u21 (copy)
        for i, v in u21 do
            i.Transparency = v;
        end;
    end);
    task.delay(2.5166666666666666, function() -- Line: 721
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.barouheart1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.583, function() -- Line: 729
        -- upvalues: u19 (copy), u18 (copy)
        for _, descendant in ipairs(u19:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Transparency < 1 then
                descendant.Transparency = 1;
            end;
        end;

        for _, descendant in ipairs(u18:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Transparency < 1 then
                descendant.Transparency = 1;
            end;
        end;
    end);
    task.delay(4.6, function() -- Line: 739
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.baroubigheart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5.466666666666667, function() -- Line: 747
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.baroubigheart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(6.383333333333334, function() -- Line: 755
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.baroubigheart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.016666666666667, function() -- Line: 763
        -- upvalues: u16 (copy), u22 (copy), u23 (copy), u21 (copy)
        for _, descendant in pairs(u16.barouheart3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u16.Earth.Transparency = 0;

        for i, v in u22 do
            i.Transparency = v;
        end;

        for i, v in u23 do
            i.Transparency = v;
        end;

        for i, v in u21 do
            i.Transparency = v;
        end;
    end);
    task.delay(8.983333333333333, function() -- Line: 785
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.barouheart2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(9.733333333333333, function() -- Line: 793
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.barouendingthings:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.8, function() -- Line: 801
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.barouheart1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(11.283, function() -- Line: 828
        -- upvalues: Lighting (ref), Brightness (ref), Threshold (ref), u16 (copy), mainreplication (ref), u17 (copy), u19 (copy), u18 (copy)
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        u16:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
        u17:Destroy();
        u19:Destroy();
        u18:Destroy();
        Lighting.Brightness = Brightness;
    end);
end;

function v1.u20KickBarou(u24, u25) -- Line: 862
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), animationUtil (copy), soundUtil (copy), SoundService (copy), actionUtil (copy), trove (copy), TekrinnDialogue (copy), Players (copy), TweenService (copy), Brightness (copy), Threshold (copy)
    local v26 = u24.HumanoidRootPart or u24.PrimaryPart;
    local Ball = u24:FindFirstChild("Ball");
    local _ = u24.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local u27 = ReplicatedStorage.Resources.barou.allU20Eff:Clone();
    u27:PivotTo(v26.CFrame);
    u27.Parent = u24;
    local u28 = ReplicatedStorage.Resources.barou.camEffVFX:Clone();
    u28.Parent = u27;
    local u29 = ReplicatedStorage.Resources.barou.u20Ballaura:Clone();
    u29.Weld.Part0 = Ball;
    u29.Parent = u27;

    if Util.canshiftcolor(LocalPlayer, u24) then
        vfxUtil.LeanTowardsColor(u27, u24:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u24:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u30 = nil;
    u30 = RunService.PreRender:connect(function() -- Line: 895
        -- upvalues: u28 (copy), u30 (ref)
        if u28:IsDescendantOf(game) then
            u28.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u30:Disconnect();
    end);
    animationUtil:loadAnimation(u27.lion, ReplicatedStorage.Resources.barou.u20lion):Play(0);

    for _, descendant in ipairs(u27:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local u31 = {};

    for _, descendant in ipairs(u27.gm1:GetDescendants()) do
        if descendant:IsA("Part") or descendant:IsA("Decal") then
            u31[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        elseif descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    Lighting.Brightness = -1;
    Lighting.Bloom.Threshold = 0;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Brightness = -2;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Parent = Lighting;
    BlurEffect.Size = 23;
    local u32 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u32.Parent = Lighting;
    u32.FarIntensity = 1;
    local u33 = Util.Preload({ ReplicatedStorage.Resources.barou.ImpactFrame7, ReplicatedStorage.Resources.barou.ImpactFrame8, ReplicatedStorage.Resources.barou.ImpactFrame9 });
    Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame6, 24);
    local u34 = soundUtil:play(ReplicatedStorage.Resources.barou["sliding goal miss"], SoundService, {
        Character = u24
    });
    mainreplication.cutsceneBlender(v26, u25 and ReplicatedStorage.Resources.barou.u20cam or ReplicatedStorage.Resources.barou.u20camMiss, ReplicatedStorage.Resources.barou.u20FOV);
    local workspace2 = actionUtil.getworkspace();
    local u35 = trove.new();
    u35:AttachToInstance(u34);
    u35:Add(u34);
    u35:Connect(workspace2.disabled.Changed, function(p36) -- Line: 960
        -- upvalues: workspace2 (copy), u35 (copy)
        if p36 and not workspace2.checkgoal.Value then
            u35:Destroy();
        end;
    end);

    if u34.Name == "Dub" then
        task.delay(8.833, function() -- Line: 967
            -- upvalues: TekrinnDialogue (ref), u24 (copy)
            TekrinnDialogue.Speak(u24, {
                {
                    Text = "I\'ve been waiting for this...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
        task.delay(11.167, function() -- Line: 993
            -- upvalues: TekrinnDialogue (ref), u24 (copy)
            TekrinnDialogue.Speak(u24, {
                {
                    Text = "Your light...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 2);
        end);
        task.delay(13.167, function() -- Line: 1019
            -- upvalues: TekrinnDialogue (ref), u24 (copy)
            TekrinnDialogue.Speak(u24, {
                {
                    Text = "IS MY PREY!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 6,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    else
        task.delay(8.833, function() -- Line: 1045
            -- upvalues: u24 (copy), Players (ref), TekrinnDialogue (ref)
            local v37 = 0;
            local v38 = nil;

            for _, child in workspace.characters:GetChildren() do
                if child ~= u24 then
                    local state = child:FindFirstChild("state");

                    if state then
                        local strike = state:FindFirstChild("strike");

                        if strike and v37 < strike.Value then
                            v37 = strike.Value;
                            local PlayerFromCharacter = Players:GetPlayerFromCharacter(child);

                            if PlayerFromCharacter then
                                v38 = PlayerFromCharacter.DisplayName;
                            else
                                v38 = child.Name;
                            end;
                        end;
                    end;
                end;
            end;

            TekrinnDialogue.Speak(u24, {
                {
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Text = v38 and `I'll feast on you, {v38}.` or "I\'ll feast on you.",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
        task.delay(11.167, function() -- Line: 1089
            -- upvalues: TekrinnDialogue (ref), u24 (copy)
            TekrinnDialogue.Speak(u24, {
                {
                    Text = "Your light...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 2);
        end);
        task.delay(13.167, function() -- Line: 1115
            -- upvalues: TekrinnDialogue (ref), u24 (copy)
            TekrinnDialogue.Speak(u24, {
                {
                    Text = "IS MINE!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 6,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    end;

    local u39 = {};

    for _, descendant in ipairs(u24:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v40 = descendant;

            for _, descendant2 in ipairs(ReplicatedStorage.Resources.barou.u20aura:GetDescendants()) do
                local v41 = descendant2:Clone();
                v41.Enabled = false;
                v41.Parent = v40;
                table.insert(u39, v41);
            end;
        end;
    end;

    task.delay(0.8, function() -- Line: 1158
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref), BlurEffect (copy)
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(3.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Brightness = 0
        }):Play();
        TweenService:Create(BlurEffect, TweenInfo.new(3.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
    end);
    task.delay(7.233, function() -- Line: 1165
        -- upvalues: Util (ref), ReplicatedStorage (ref), ColorCorrectionEffect (copy), Lighting (ref)
        Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame7, 20);
        ColorCorrectionEffect.Brightness = -2;
        Lighting.Bloom.Threshold = 0.65;
    end);
    task.delay(8.55, function() -- Line: 1174
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.Brightness = -0.5;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 0, 0);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.467, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TintColor = Color3.fromRGB(255, 213, 213)
        }):Play();
    end);
    task.delay(11.067, function() -- Line: 1183
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.Brightness = 0;
        ColorCorrectionEffect.Contrast = 0.2;
        ColorCorrectionEffect.Saturation = -0.7;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(171, 207, 255);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.467, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TintColor = Color3.fromRGB(171, 207, 255)
        }):Play();
    end);
    task.delay(13.233, function() -- Line: 1194
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.Brightness = 0;
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.Saturation = 0;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        local v42 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.934, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 68, 68)
        });
        v42:Play();
        v42.Completed:Wait();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.866, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(16.8, function() -- Line: 1211
        -- upvalues: ColorCorrectionEffect (copy), Util (ref), ReplicatedStorage (ref)
        ColorCorrectionEffect.Brightness = -0.1;
        ColorCorrectionEffect.Contrast = 0.6;
        ColorCorrectionEffect.Saturation = 0;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(182, 158, 158);
        Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame8, 24);
    end);

    if u25 then
        task.delay(19.867, function() -- Line: 1224
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect.Brightness = -0.1;
            ColorCorrectionEffect.Contrast = 0.2;
            ColorCorrectionEffect.Saturation = 0.4;
            ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 177, 177);
        end);
        task.delay(20.3, function() -- Line: 1232
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect.Brightness = -0.1;
            ColorCorrectionEffect.Contrast = 0.2;
            ColorCorrectionEffect.Saturation = 0;
            ColorCorrectionEffect.TintColor = Color3.fromRGB(239, 112, 112);
        end);
        task.delay(20.317, function() -- Line: 1239
            -- upvalues: Util (ref), ReplicatedStorage (ref)
            Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame9, 50);
        end);
        task.delay(23.433, function() -- Line: 1243
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect.Brightness = 0;
            ColorCorrectionEffect.Contrast = 0;
            ColorCorrectionEffect.Saturation = 0.2;
            ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        end);
    end;

    task.spawn(function() -- Line: 1252
        -- upvalues: u27 (copy)
        for _, descendant in pairs(u27.baroudashparteffects:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u27.LightningDashPart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.35, function() -- Line: 1267
        -- upvalues: u27 (copy)
        u27.LightningDashPart:Destroy();

        for _, descendant in pairs(u27.LightningDashPart2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.4, function() -- Line: 1277
        -- upvalues: u28 (copy)
        for _, descendant in pairs(u28:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.233, function() -- Line: 1285
        -- upvalues: u27 (copy)
        u27.LightningDashPart2:Destroy();
    end);
    task.delay(7.716666666666667, function() -- Line: 1288
        -- upvalues: u27 (copy)
        for _, descendant in pairs(u27.baroulionlightningstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.55, function() -- Line: 1296
        -- upvalues: u27 (copy)
        for _, descendant in pairs(u27.ILLFEASTONYOUISAGI:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(10.983333333333333, function() -- Line: 1304
        -- upvalues: u28 (copy)
        for _, descendant in pairs(u28:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(11.05, function() -- Line: 1312
        -- upvalues: u27 (copy)
        for _, descendant in pairs(u27.baroulionlightningstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(11.066666666666666, function() -- Line: 1320
        -- upvalues: u27 (copy)
        for _, descendant in pairs(u27.HE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(11.883333333333333, function() -- Line: 1328
        -- upvalues: u27 (copy)
        for _, descendant in pairs(u27.HE2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(13.216666666666667, function() -- Line: 1336
        -- upvalues: u27 (copy)
        for _, descendant in pairs(u27.baroulionlightningstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(13.233, function() -- Line: 1344
        -- upvalues: u28 (copy), u27 (copy), u31 (copy)
        for _, descendant in pairs(u28:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u27.gm1:GetDescendants()) do
            if descendant:IsA("Part") or descendant:IsA("Decal") then
                descendant.Transparency = u31[descendant];
            elseif descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u27.HE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u27.HE2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(15.083, function() -- Line: 1374
        -- upvalues: TweenService (ref), u27 (copy)
        TweenService:Create(u27.ILLFEASTONYOUISAGI, TweenInfo.new(1.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = u27.ILLFEASTONYOUISAGI.CFrame * CFrame.new(-6, 8, 0) * CFrame.Angles(0, 0.16004669240788003, 0.7990640914405639)
        }):Play();
    end);
    task.delay(16.816666666666666, function() -- Line: 1377
        -- upvalues: u28 (copy), u29 (copy), u39 (copy)
        for _, descendant in pairs(u28:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u29:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in u39 do
            v.Enabled = true;
        end;
    end);
    task.delay(16.817, function() -- Line: 1402
        -- upvalues: u27 (copy)
        for _, descendant in pairs(u27.LIONSHOTRAHHH:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(16.833, function() -- Line: 1410
        -- upvalues: u27 (copy)
        u27.ILLFEASTONYOUISAGI:Destroy();
    end);
    task.delay(19.85, function() -- Line: 1413
        -- upvalues: u29 (copy)
        for _, descendant in ipairs(u29:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end);

    if u25 then
        task.delay(19.867, function() -- Line: 1423
            -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), u27 (copy)
            soundUtil:play(ReplicatedStorage.Resources.barou["siliding goal autogoal"], SoundService);

            for _, descendant in pairs(u27.LIONSHOTRAHHH:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.delay(20.267, function() -- Line: 1434
            -- upvalues: u27 (copy)
            for _, descendant in pairs(u27.LIONSHOTRAHHH:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end);
        task.delay(20.783333333333335, function() -- Line: 1443
            -- upvalues: u29 (copy)
            for _, descendant in ipairs(u29:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.delay(23.416666666666668, function() -- Line: 1452
            -- upvalues: u27 (copy)
            for _, descendant in pairs(u27.baroulionlightningstuff:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(u27.baroudashparteffects:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.delay(23.467, function() -- Line: 1466
            -- upvalues: u27 (copy)
            u27.LIONSHOTRAHHH:Destroy();
        end);
        task.delay(26.45, function() -- Line: 1469
            -- upvalues: u39 (copy), u27 (copy)
            for _, v in u39 do
                v:Destroy();
            end;

            for _, descendant in pairs(u27.HE2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(u27.HE:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end);
    end;

    task.delay(u25 and 26.45 or 19.859, function() -- Line: 1494
        -- upvalues: u34 (copy), ScreenDimmer (copy), u33 (copy), Lighting (ref), Brightness (ref), Threshold (ref), u32 (copy), ColorCorrectionEffect (copy), u27 (copy), BlurEffect (copy), mainreplication (ref), u39 (copy), u25 (copy)
        u34:Destroy();
        ScreenDimmer:Destroy();
        u33:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        u32:Destroy();
        ColorCorrectionEffect:Destroy();
        u27:Destroy();
        BlurEffect:Destroy();
        mainreplication.sceneEnabled(false);

        for _, v in u39 do
            v:Destroy();
        end;

        if not u25 then
            mainreplication.ultFlash(1, 1.5);
        end;

        Lighting.Brightness = Brightness;
    end);
end;

function v1.u20KickThurau(u43, u44) -- Line: 1538
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), animationUtil (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), TweenService (copy), Brightness (copy), Threshold (copy)
    local v45 = u43.HumanoidRootPart or u43.PrimaryPart;
    local Ball = u43:FindFirstChild("Ball");
    local _ = u43.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local u46 = ReplicatedStorage.Resources.barou.allU20Eff:Clone();
    u46:PivotTo(v45.CFrame);
    u46.Parent = u43;
    local u47 = ReplicatedStorage.Resources.barou.camEffVFX:Clone();
    u47.Parent = u46;
    local u48 = ReplicatedStorage.Resources.barou.u20Ballaura:Clone();
    u48.Weld.Part0 = Ball;
    u48.Parent = u46;

    if Util.canshiftcolor(LocalPlayer, u43) then
        vfxUtil.LeanTowardsColor(u46, u43:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u43:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u49 = nil;
    u49 = RunService.PreRender:connect(function() -- Line: 1572
        -- upvalues: u47 (copy), u49 (ref)
        if u47:IsDescendantOf(game) then
            u47.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u49:Disconnect();
    end);
    animationUtil:loadAnimation(u46.lion, ReplicatedStorage.Resources.barou.u20lion):Play(0);

    for _, descendant in ipairs(u46:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local u50 = {};

    for _, descendant in ipairs(u46.gm1:GetDescendants()) do
        if descendant:IsA("Part") or descendant:IsA("Decal") then
            u50[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        elseif descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    Lighting.Brightness = -1;
    Lighting.Bloom.Threshold = 0;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Brightness = -2;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Parent = Lighting;
    BlurEffect.Size = 23;
    local u51 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u51.Parent = Lighting;
    u51.FarIntensity = 1;
    local u52 = Util.Preload({ ReplicatedStorage.Resources.barou.ImpactFrame7, ReplicatedStorage.Resources.barou.ImpactFrame8, ReplicatedStorage.Resources.barou.ImpactFrame9 });
    Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame6, 24);
    soundUtil:play(ReplicatedStorage.Resources.barou["sliding goal miss"], SoundService, {
        Character = u43
    });
    mainreplication.cutsceneBlender(v45, u44 and ReplicatedStorage.Resources.barou.u20cam or ReplicatedStorage.Resources.barou.u20camMiss, ReplicatedStorage.Resources.barou.u20FOV);
    task.delay(8.833, function() -- Line: 1629
        -- upvalues: TekrinnDialogue (ref), u43 (copy)
        TekrinnDialogue.Speak(u43, {
            {
                Text = "I\'ll devour you pally...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3);
    end);
    task.delay(11.167, function() -- Line: 1657
        -- upvalues: TekrinnDialogue (ref), u43 (copy)
        TekrinnDialogue.Speak(u43, {
            {
                Text = "You\'re...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end);
    task.delay(13.167, function() -- Line: 1683
        -- upvalues: TekrinnDialogue (ref), u43 (copy)
        TekrinnDialogue.Speak(u43, {
            {
                Text = "MINE!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 6,
                    Lifetime = 2
                }
            }
        }, 2);
    end);
    local u53 = {};

    for _, descendant in ipairs(u43:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v54 = descendant;

            for _, descendant2 in ipairs(ReplicatedStorage.Resources.barou.u20aura:GetDescendants()) do
                local v55 = descendant2:Clone();
                v55.Enabled = false;
                v55.Parent = v54;
                table.insert(u53, v55);
            end;
        end;
    end;

    task.delay(0.8, function() -- Line: 1725
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref), BlurEffect (copy)
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(3.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Brightness = 0
        }):Play();
        TweenService:Create(BlurEffect, TweenInfo.new(3.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
    end);
    task.delay(7.233, function() -- Line: 1732
        -- upvalues: Util (ref), ReplicatedStorage (ref), ColorCorrectionEffect (copy), Lighting (ref)
        Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame7, 20);
        ColorCorrectionEffect.Brightness = -2;
        Lighting.Bloom.Threshold = 0.65;
    end);
    task.delay(8.55, function() -- Line: 1741
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.Brightness = -0.5;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 0, 0);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.467, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TintColor = Color3.fromRGB(255, 213, 213)
        }):Play();
    end);
    task.delay(11.067, function() -- Line: 1750
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.Brightness = 0;
        ColorCorrectionEffect.Contrast = 0.2;
        ColorCorrectionEffect.Saturation = -0.7;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(171, 207, 255);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.467, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TintColor = Color3.fromRGB(171, 207, 255)
        }):Play();
    end);
    task.delay(13.233, function() -- Line: 1761
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.Brightness = 0;
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.Saturation = 0;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        local v56 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.934, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 68, 68)
        });
        v56:Play();
        v56.Completed:Wait();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.866, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(16.8, function() -- Line: 1778
        -- upvalues: ColorCorrectionEffect (copy), Util (ref), ReplicatedStorage (ref)
        ColorCorrectionEffect.Brightness = -0.1;
        ColorCorrectionEffect.Contrast = 0.6;
        ColorCorrectionEffect.Saturation = 0;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(182, 158, 158);
        Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame8, 24);
    end);

    if u44 then
        task.delay(19.867, function() -- Line: 1791
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect.Brightness = -0.1;
            ColorCorrectionEffect.Contrast = 0.2;
            ColorCorrectionEffect.Saturation = 0.4;
            ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 177, 177);
        end);
        task.delay(20.3, function() -- Line: 1799
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect.Brightness = -0.1;
            ColorCorrectionEffect.Contrast = 0.2;
            ColorCorrectionEffect.Saturation = 0;
            ColorCorrectionEffect.TintColor = Color3.fromRGB(239, 112, 112);
        end);
        task.delay(20.317, function() -- Line: 1806
            -- upvalues: Util (ref), ReplicatedStorage (ref)
            Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame9, 50);
        end);
        task.delay(23.433, function() -- Line: 1810
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect.Brightness = 0;
            ColorCorrectionEffect.Contrast = 0;
            ColorCorrectionEffect.Saturation = 0.2;
            ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        end);
    end;

    task.spawn(function() -- Line: 1819
        -- upvalues: u46 (copy)
        for _, descendant in pairs(u46.baroudashparteffects:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u46.LightningDashPart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.35, function() -- Line: 1834
        -- upvalues: u46 (copy)
        u46.LightningDashPart:Destroy();

        for _, descendant in pairs(u46.LightningDashPart2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.4, function() -- Line: 1844
        -- upvalues: u47 (copy)
        for _, descendant in pairs(u47:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.233, function() -- Line: 1852
        -- upvalues: u46 (copy)
        u46.LightningDashPart2:Destroy();
    end);
    task.delay(7.716666666666667, function() -- Line: 1855
        -- upvalues: u46 (copy)
        for _, descendant in pairs(u46.baroulionlightningstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.55, function() -- Line: 1863
        -- upvalues: u46 (copy)
        for _, descendant in pairs(u46.ILLFEASTONYOUISAGI:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(10.983333333333333, function() -- Line: 1871
        -- upvalues: u47 (copy)
        for _, descendant in pairs(u47:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(11.05, function() -- Line: 1879
        -- upvalues: u46 (copy)
        for _, descendant in pairs(u46.baroulionlightningstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(11.066666666666666, function() -- Line: 1887
        -- upvalues: u46 (copy)
        for _, descendant in pairs(u46.HE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(11.883333333333333, function() -- Line: 1895
        -- upvalues: u46 (copy)
        for _, descendant in pairs(u46.HE2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(13.216666666666667, function() -- Line: 1903
        -- upvalues: u46 (copy)
        for _, descendant in pairs(u46.baroulionlightningstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(13.233, function() -- Line: 1911
        -- upvalues: u47 (copy), u46 (copy), u50 (copy)
        for _, descendant in pairs(u47:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u46.gm1:GetDescendants()) do
            if descendant:IsA("Part") or descendant:IsA("Decal") then
                descendant.Transparency = u50[descendant];
            elseif descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u46.HE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u46.HE2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(15.083, function() -- Line: 1941
        -- upvalues: TweenService (ref), u46 (copy)
        TweenService:Create(u46.ILLFEASTONYOUISAGI, TweenInfo.new(1.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = u46.ILLFEASTONYOUISAGI.CFrame * CFrame.new(-6, 8, 0) * CFrame.Angles(0, 0.16004669240788003, 0.7990640914405639)
        }):Play();
    end);
    task.delay(16.816666666666666, function() -- Line: 1944
        -- upvalues: u47 (copy), u48 (copy), u53 (copy)
        for _, descendant in pairs(u47:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u48:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in u53 do
            v.Enabled = true;
        end;
    end);
    task.delay(16.817, function() -- Line: 1969
        -- upvalues: u46 (copy)
        for _, descendant in pairs(u46.LIONSHOTRAHHH:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(16.833, function() -- Line: 1977
        -- upvalues: u46 (copy)
        u46.ILLFEASTONYOUISAGI:Destroy();
    end);
    task.delay(19.85, function() -- Line: 1980
        -- upvalues: u48 (copy)
        for _, descendant in ipairs(u48:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end);

    if u44 then
        task.delay(19.867, function() -- Line: 1990
            -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), u46 (copy)
            soundUtil:play(ReplicatedStorage.Resources.barou["siliding goal autogoal"], SoundService);

            for _, descendant in pairs(u46.LIONSHOTRAHHH:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.delay(20.267, function() -- Line: 2001
            -- upvalues: u46 (copy)
            for _, descendant in pairs(u46.LIONSHOTRAHHH:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end);
        task.delay(20.783333333333335, function() -- Line: 2010
            -- upvalues: u48 (copy)
            for _, descendant in ipairs(u48:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.delay(23.416666666666668, function() -- Line: 2019
            -- upvalues: u46 (copy)
            for _, descendant in pairs(u46.baroulionlightningstuff:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(u46.baroudashparteffects:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.delay(23.467, function() -- Line: 2033
            -- upvalues: u46 (copy)
            u46.LIONSHOTRAHHH:Destroy();
        end);
        task.delay(26.45, function() -- Line: 2036
            -- upvalues: u53 (copy), u46 (copy)
            for _, v in u53 do
                v:Destroy();
            end;

            for _, descendant in pairs(u46.HE2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(u46.HE:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end);
    end;

    task.delay(u44 and 26.45 or 19.859, function() -- Line: 2061
        -- upvalues: u52 (copy), Lighting (ref), Brightness (ref), Threshold (ref), u51 (copy), ColorCorrectionEffect (copy), u46 (copy), BlurEffect (copy), mainreplication (ref), u53 (copy), u44 (copy)
        u52:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        u51:Destroy();
        ColorCorrectionEffect:Destroy();
        u46:Destroy();
        BlurEffect:Destroy();
        mainreplication.sceneEnabled(false);

        for _, v in u53 do
            v:Destroy();
        end;

        if not u44 then
            mainreplication.ultFlash(1, 1.5);
        end;

        Lighting.Brightness = Brightness;
    end);
end;

function v1.barourun(u57, p58) -- Line: 2101
    -- upvalues: trove (copy), ReplicatedStorage (copy), mainreplication (copy), RunService2 (copy), RunService (copy), workspace_CurrentCamera (copy), Lighting (copy), TweenService (copy)
    local v59 = u57.HumanoidRootPart or u57.PrimaryPart;
    local u60 = trove.new();
    u60:AttachToInstance(p58);
    local u61 = u60:Construct(ReplicatedStorage.Resources.barou.runALLVFX);
    u61.Weld.Part0 = v59;
    u61.Parent = u57;
    local v62 = u57:FindFirstChild("state") and u57.state:FindFirstChild("team") and u57.state.team.Value;
    local u63 = mainreplication.bodyVelocity(v59, 92.7, 3, true, nil, nil, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0));

    if not u63 then
        return;
    end;

    local P = u63.P;

    if u63 then
        u60:Add(u63);

        if v62 then
            u60:Add(RunService2.RenderStepped:Connect(function() -- Line: 2120
                -- upvalues: u63 (copy), P (copy)
                u63.P = P * 1;
            end));
        end;
    end;

    local u64 = u60:Construct(ReplicatedStorage.Resources.barou.camSTART);
    u64.Parent = workspace.Effects;
    u60:Connect(RunService.PreRender, function() -- Line: 2133
        -- upvalues: u64 (copy), workspace_CurrentCamera (ref)
        u64.CFrame = workspace_CurrentCamera.CFrame;
    end);

    for _, descendant in pairs(u64.aikuleft:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    u60:Add(function() -- Line: 2146
        -- upvalues: u64 (copy), u61 (copy), mainreplication (ref), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), u57 (copy)
        u64:Destroy();
        u61:Destroy();
        mainreplication.cameraShake(10, 1.5, 6);
        mainreplication.fov(false, 60);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(1, BlurEffect.Destroy, BlurEffect);
        local v65 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v65.Parent = Lighting;
        v65.TintColor = Color3.fromRGB(255, 0, 4);
        v65.Brightness = 0.4;
        v65.Contrast = 1;
        v65.Saturation = -0.4;
        TweenService:Create(v65, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(0.8, v65.Destroy, v65);
        mainreplication.highlight(u57, Color3.fromRGB(255, 0, 4), 1.5);
    end);
    u60:Add(task.delay(3, function() -- Line: 2175
        -- upvalues: u60 (copy)
        u60:Destroy();
    end));
    mainreplication.cameraShake(10, 1.5, 6);
    mainreplication.fov(false, 60);
    mainreplication.fov(true, 90, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(1, BlurEffect.Destroy, BlurEffect);
    local v66 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v66.Parent = Lighting;
    v66.TintColor = Color3.fromRGB(255, 0, 4);
    v66.Brightness = 0.4;
    v66.Contrast = 1;
    v66.Saturation = -0.4;
    TweenService:Create(v66, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(0.8, v66.Destroy, v66);
    mainreplication.highlight(u57, Color3.fromRGB(255, 0, 4), 1.5);
end;

function v1.barouu20Hit(p67) -- Line: 2203
    -- upvalues: mainreplication (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy)
    local v68 = p67.HumanoidRootPart or p67.PrimaryPart;
    mainreplication.cameraShake(10, 1.5, 6);
    mainreplication.fov(false, 50);
    mainreplication.fov(true, 90, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    mainreplication.highlight(p67, Color3.fromRGB(255, 0, 4), 1.5);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.3, BlurEffect.Destroy, BlurEffect);
    local v69 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v69.Parent = Lighting;
    v69.TintColor = Color3.fromRGB(255, 0, 4);
    v69.Brightness = 0.4;
    v69.Contrast = 1;
    v69.Saturation = -0.4;
    TweenService:Create(v69, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(0.5, v69.Destroy, v69);
    mainreplication.Emit(v68, ReplicatedStorage.Resources.barou.victimhiteffect1, 3);
end;

function v1.BarouSteal(u70) -- Line: 2233
    -- upvalues: Lighting (copy), mainreplication (copy), MeshEmitter (copy), ReplicatedStorage (copy), Util (copy), workspace_CurrentCamera (copy), animationUtil (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Brightness (copy)
    local v71 = u70.HumanoidRootPart or u70.PrimaryPart;
    local _ = u70.Torso;
    local _ = Lighting.Atmosphere;
    local Ball = u70:FindFirstChild("Ball");
    mainreplication.sceneEnabled(true);
    local v72 = { MeshEmitter.StartMeshEmitter(v71, ReplicatedStorage.Resources.barou.baroucc, nil).barouballstealvfx };

    for _, v in ipairs(v72) do
        if not Util.isepilepsysafe() then
            v.Parent = workspace_CurrentCamera;
        end;

        task.delay(15, function() -- Line: 2250
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    local u73 = ReplicatedStorage.Resources.barou.barousteal:Clone();
    u73.Weld.Part0 = v71;
    u73.Parent = u70;
    local u74 = ReplicatedStorage.Resources.barou.lionforsteal:Clone();
    u74.RootPart.HumanoidRootPart.Part1 = v71;
    u74.Parent = u73;
    animationUtil:loadAnimation(u74, ReplicatedStorage.Resources.barou.steallion):Play(0);
    local u75 = ReplicatedStorage.Resources.barou.vfxx:Clone();
    u75.Weld.Part0 = Ball;
    u75.Parent = u73;

    if Util.canshiftcolor(LocalPlayer, u70) then
        vfxUtil.LeanTowardsColor(u73, u70:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u70:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u76 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u76.Parent = Lighting;
    u76.FarIntensity = 0;
    TweenService:Create(u76, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.barou["BAROU STEAL"], SoundService);
    mainreplication.cutsceneBlender(v71, ReplicatedStorage.Resources.barou.stealcam, ReplicatedStorage.Resources.barou.StealFOV);
    local u77 = {};
    task.spawn(function() -- Line: 2282
        -- upvalues: u70 (copy), ReplicatedStorage (ref), u77 (copy)
        for _, descendant in ipairs(u70:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v78 = descendant;

                for _, descendant2 in ipairs(ReplicatedStorage.Resources.barou.baroustealtable:GetDescendants()) do
                    local v79 = descendant2:Clone();
                    v79.Parent = v78;
                    table.insert(u77, v79);
                end;
            end;
        end;
    end);
    task.delay(0.6666666666666666, function() -- Line: 2298
        -- upvalues: u75 (copy), u77 (copy)
        for _, descendant in pairs(u75:GetDescendants()) do
            if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in u77 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end);
    task.delay(0.9166666666666666, function() -- Line: 2310
        -- upvalues: u73 (copy)
        for _, descendant in pairs(u73.baroulionstealvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u73.baroulionstealwindvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.15, function() -- Line: 2324
        -- upvalues: u73 (copy)
        for _, descendant in pairs(u73.baroulionstealvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(1.5833333333333333, function() -- Line: 2332
        -- upvalues: u73 (copy)
        for _, descendant in pairs(u73.baroulionstealvfxlightning:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u73.baroulionstealvfxlightningreal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.066666666666667, function() -- Line: 2346
        -- upvalues: u73 (copy)
        for _, descendant in pairs(u73.baroustealbackgroundbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.55, function() -- Line: 2353
        -- upvalues: u73 (copy), u77 (copy), u75 (copy)
        for _, descendant in pairs(u73.baroulionstealvfxlightning:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u73.baroulionstealwindvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u73.baroulionstealvfxlightningreal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, v in u77 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u75:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.566666666666667, function() -- Line: 2384
        -- upvalues: u73 (copy)
        for _, descendant in pairs(u73.baroustealbackgroundbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.568, function() -- Line: 2393
        -- upvalues: u76 (copy), mainreplication (ref), u73 (copy), u74 (copy), u75 (copy), Lighting (ref), Brightness (ref)
        u76:Destroy();
        mainreplication.ultFlash(1, 1.5);
        u73:Destroy();
        u74:Destroy();
        u75:Destroy();
        mainreplication.sceneEnabled(false);
        Lighting.Brightness = Brightness;
    end);
end;

local function Clone(p80: string) -- Line: 2417
    -- upvalues: ReplicatedStorage (copy)
    return ReplicatedStorage.Resources:FindFirstChild(p80, true):Clone();
end;

local function Modify(p81: any, p82: table) -- Line: 2421
    assert(p81, "no object passed");
    assert(p82, "no instance data passed");

    for i, v in p82 do
        p81[i] = v;
    end;
end;

function v1.ThurauSteal(u83) -- Line: 2431
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), LocalPlayer (copy), TweenService (copy), MeshEmitter (copy), Util (copy), workspace_CurrentCamera (copy), animationUtil (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy), Brightness (copy)
    local v84 = u83.HumanoidRootPart or u83.PrimaryPart;
    local _ = u83.Torso;
    local _ = Lighting.Atmosphere;
    local Ball = u83:FindFirstChild("Ball");
    mainreplication.sceneEnabled(true);
    local u85 = ReplicatedStorage.Resources:FindFirstChild("Balake", true):Clone();
    u85.Parent = LocalPlayer.PlayerGui;
    local u86 = {};
    table.insert(u86, u85);
    task.spawn(function() -- Line: 2447
        -- upvalues: u85 (copy), TweenService (ref), u86 (copy)
        local ImageLabel = u85.ImageLabel;
        local v87 = {
            ImageTransparency = 1,
            Transparency = 1,
            Image = "rbxassetid://117706116442449"
        };
        assert(ImageLabel, "no object passed");
        assert(v87, "no instance data passed");

        for i, v in v87 do
            ImageLabel[i] = v;
        end;

        TweenService:Create(u85.ImageLabel, TweenInfo.new(0.4), {
            ImageTransparency = 0
        }):Play();
        task.wait(0.2);
        TweenService:Create(u85.ImageLabel, TweenInfo.new(0.4), {
            ImageTransparency = 1
        }):Play();
        task.delay(1.2, function() -- Line: 2459
            -- upvalues: u86 (ref)
            for _, v in u86 do
                v:Destroy();
            end;
        end);
    end);
    local v88 = { MeshEmitter.StartMeshEmitter(v84, ReplicatedStorage.Resources.barou.baroucc, nil).barouballstealvfx };

    for _, v in ipairs(v88) do
        if not Util.isepilepsysafe() then
            v.Parent = workspace_CurrentCamera;
        end;

        task.delay(15, function() -- Line: 2474
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    local u89 = ReplicatedStorage.Resources.barou.barousteal:Clone();
    u89.Weld.Part0 = v84;
    u89.Parent = u83;
    local u90 = ReplicatedStorage.Resources.barou.lionforsteal:Clone();
    u90.RootPart.HumanoidRootPart.Part1 = v84;
    u90.Parent = u89;
    animationUtil:loadAnimation(u90, ReplicatedStorage.Resources.barou.steallion):Play(0);
    local u91 = ReplicatedStorage.Resources.barou.vfxx:Clone();
    u91.Weld.Part0 = Ball;
    u91.Parent = u89;

    if Util.canshiftcolor(LocalPlayer, u83) then
        vfxUtil.LeanTowardsColor(u89, u83:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u83:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u92 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u92.Parent = Lighting;
    u92.FarIntensity = 0;
    TweenService:Create(u92, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.barou["BAROU STEAL"], SoundService);
    mainreplication.cutsceneBlender(v84, ReplicatedStorage.Resources.barou.stealcam, ReplicatedStorage.Resources.barou.StealFOV);
    local u93 = {};
    task.spawn(function() -- Line: 2505
        -- upvalues: u83 (copy), ReplicatedStorage (ref), u93 (copy)
        for _, descendant in ipairs(u83:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v94 = descendant;

                for _, descendant2 in ipairs(ReplicatedStorage.Resources.barou.baroustealtable:GetDescendants()) do
                    local v95 = descendant2:Clone();
                    v95.Parent = v94;
                    table.insert(u93, v95);
                end;
            end;
        end;
    end);
    task.delay(0.6666666666666666, function() -- Line: 2521
        -- upvalues: u91 (copy), u93 (copy)
        for _, descendant in pairs(u91:GetDescendants()) do
            if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in u93 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end);
    task.delay(0.9166666666666666, function() -- Line: 2533
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.baroulionstealvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u89.baroulionstealwindvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.15, function() -- Line: 2547
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.baroulionstealvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(1.5833333333333333, function() -- Line: 2555
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.baroulionstealvfxlightning:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u89.baroulionstealvfxlightningreal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.066666666666667, function() -- Line: 2569
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.baroustealbackgroundbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.55, function() -- Line: 2576
        -- upvalues: u89 (copy), u93 (copy), u91 (copy)
        for _, descendant in pairs(u89.baroulionstealvfxlightning:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u89.baroulionstealwindvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u89.baroulionstealvfxlightningreal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, v in u93 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u91:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.566666666666667, function() -- Line: 2607
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.baroustealbackgroundbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.568, function() -- Line: 2616
        -- upvalues: u92 (copy), mainreplication (ref), u89 (copy), u90 (copy), u91 (copy), Lighting (ref), Brightness (ref)
        u92:Destroy();
        mainreplication.ultFlash(1, 1.5);
        u89:Destroy();
        u90:Destroy();
        u91:Destroy();
        mainreplication.sceneEnabled(false);
        Lighting.Brightness = Brightness;
    end);
end;

function v1.chopdribble(u96, u97, u98) -- Line: 2639
    -- upvalues: trove (copy), RunService (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Players (copy), Lighting (copy), TweenService (copy)
    local u99 = u96.HumanoidRootPart or u96.PrimaryPart;
    local u100 = trove.new();
    u100:AttachToInstance(u96);
    u100:Connect(RunService.PreRender, function() -- Line: 2645
        -- upvalues: u98 (copy), u100 (copy), mainreplication (ref), u99 (copy)
        if u98.Value then
            u100:Destroy();
            mainreplication.destroyVelocity(u99);
        end;
    end);
    u100:AttachToInstance(u98);
    u100:Add(function() -- Line: 2653
        -- upvalues: u100 (copy)
        task.delay(10, function() -- Line: 2654
            -- upvalues: u100 (ref)
            u100:Destroy();
        end);
    end);
    local u101 = u100:Clone(ReplicatedStorage.Resources.barou.chopdribble);
    u101:PivotTo(u99.CFrame);
    u101.BarouLightningAura.HumanoidRootPart.Part1 = u99;
    u101.Parent = u96;

    if Util.canshiftcolor(LocalPlayer, u96) then
        vfxUtil.LeanTowardsColor(u101, u96:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u96:GetAttribute("CustomAlpha") or 0.985);
    end;

    if not u97 then
        u101.BarouLightningAura.HumanoidRootPart.C0 = CFrame.new(u101.BarouLightningAura.HumanoidRootPart.C0.Position) * CFrame.Angles(0, 0, 0);
    end;

    task.delay(3, u101.Destroy, u101);
    local u102 = u100:Clone(ReplicatedStorage.Resources.barou.eyetrail);
    u102.Weld.Part0 = u96.Head;
    u102.Parent = u96;

    for _, descendant in ipairs(u102:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = true;
        end;
    end;

    u100:Add(task.delay(1, function() -- Line: 2683
        -- upvalues: u102 (copy), u100 (copy)
        for _, descendant in ipairs(u102:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        u100:Add(task.delay(2, u102.Destroy, u102));
    end));
    u100:Add(task.delay(0.05, function() -- Line: 2692
        -- upvalues: u101 (copy)
        for _, descendant in ipairs(u101.BallTap:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u100:Add(task.delay(0.267, function() -- Line: 2700
        -- upvalues: u101 (copy)
        for _, descendant in ipairs(u101.BallTap2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u100:Add(task.delay(0.6, function() -- Line: 2708
        -- upvalues: u101 (copy)
        for _, descendant in ipairs(u101.LandingParticles:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u101.BarouLightningAura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
                task.delay(0.3, function() -- Line: 2718
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end));
    local u103, u104 = mainreplication.bodyVelocity(u99, 60, 0.35, nil, nil, true, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
    u100:Add(u103);
    local u105 = nil;
    u105 = u100:Add(RunService.RenderStepped:Connect(function(p106) -- Line: 2727
        -- upvalues: u103 (copy), u105 (ref), u99 (copy), u97 (copy), u104 (copy)
        if u103 and u103:IsDescendantOf(game) then
            u103.Velocity = u99.CFrame.LookVector * 5 + (u97 and u99.CFrame.RightVector * -u104.Value or u99.CFrame.RightVector * u104.Value);

            return;
        end;

        u105:Disconnect();
    end));
    u100:Add(task.delay(15, u105.Disconnect, u105));
    u100:Add(task.delay(0.6, function() -- Line: 2738
        -- upvalues: u100 (copy), ReplicatedStorage (ref), u99 (copy), u101 (copy), Players (ref), u96 (copy), Lighting (ref), TweenService (ref), mainreplication (ref), RunService (ref), u97 (copy)
        local u107 = u100:Clone(ReplicatedStorage.Resources.barou.windupRa2);
        u107.Weld.Part0 = u99;
        u107.Parent = u101;

        for _, descendant in ipairs(u107:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;

                if descendant:IsA("Beam") then
                    u100:Add(task.spawn(function() -- Line: 2756
                        -- upvalues: u107 (copy), descendant (copy)
                        for i = 1, 50 do
                            if not u107:IsDescendantOf(game) then
                                break;
                            end;

                            descendant.CurveSize0 = Random.new():NextNumber(-8, 8);
                            descendant.CurveSize1 = Random.new():NextNumber(-8, 8);
                            descendant.Width1 = Random.new():NextNumber(0, 8);
                            u107.Weld.C0 = CFrame.Angles(Random.new():NextInteger(-360, 360), Random.new():NextInteger(-360, 360), Random.new():NextInteger(-360, 360));
                            task.wait(0.01);
                            local _ = i;
                        end;
                    end));
                end;
            end;
        end;

        u100:Add(task.delay(0.12, u107.Destroy, u107));

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u96) then
            local v108 = u100:Add(Instance.new("BlurEffect"));
            v108.Size = 25;
            v108.Parent = Lighting;
            TweenService:Create(v108, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            u100:Add(task.delay(0.533, v108.Destroy, v108));
            local v109 = u100:Clone(ReplicatedStorage.Resources.ColorCorrection);
            v109.TintColor = Color3.fromRGB(170, 0, 0);
            v109.Brightness = 0.4;
            v109.Contrast = 1;
            v109.Saturation = -0.4;
            v109.Parent = Lighting;
            TweenService:Create(v109, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v109, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            u100:Add(task.delay(2, v109.Destroy, v109));
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(10, 1.5, 6);
            local u110, u111 = mainreplication.bodyVelocity(u99, 135, 0.67, nil, nil, true, TweenInfo.new(0.7200000000000001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
            u100:Add(u110);
            local u112 = nil;
            u112 = u100:Add(RunService.RenderStepped:Connect(function(p113) -- Line: 2832
                -- upvalues: u110 (copy), u112 (ref), u97 (ref), u99 (ref), u111 (copy)
                if u110 and u110:IsDescendantOf(game) then
                    u110.Velocity = u97 and u99.CFrame.RightVector * u111.Value or u99.CFrame.RightVector * -u111.Value;

                    return;
                end;

                u112:Disconnect();
            end));
        end;
    end));
end;

function v1.thuraudash(u114, u115) -- Line: 2844
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), RunService (copy), Players (copy), Lighting (copy), TweenService (copy)
    local u116 = u114.HumanoidRootPart or u114.PrimaryPart;
    local u117 = ReplicatedStorage.Resources.barou.thuraudribble:Clone();
    u117.BarouLightningAura.HumanoidRootPart.Part1 = u116;
    u117:PivotTo(u116.CFrame);
    u117.Parent = u114;

    if Util.canshiftcolor(LocalPlayer, u114) then
        vfxUtil.LeanTowardsColor(u117, u114:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u114:GetAttribute("CustomAlpha") or 0.985);
    end;

    soundUtil:play(ReplicatedStorage.Resources.barou.dasher123, SoundService);

    if not u115 then
        u117.BarouLightningAura.HumanoidRootPart.C0 = CFrame.new(u117.BarouLightningAura.HumanoidRootPart.C0.Position) * CFrame.Angles(0, 0, 0);
    end;

    task.delay(3, u117.Destroy, u117);
    local u118 = ReplicatedStorage.Resources.barou.thuraueyetrail:Clone();
    u118.Parent = u114;
    u118.Weld.Part0 = u114.Head;

    for _, descendant in ipairs(u118:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(1, function() -- Line: 2873
        -- upvalues: u118 (copy)
        for _, descendant in ipairs(u118:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u118.Destroy, u118);
    end);
    task.delay(0.05, function() -- Line: 2883
        -- upvalues: u117 (copy)
        for _, descendant in ipairs(u117.BallTap:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.267, function() -- Line: 2891
        -- upvalues: u117 (copy)
        for _, descendant in ipairs(u117.BallTap2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.6, function() -- Line: 2899
        -- upvalues: u117 (copy)
        for _, descendant in ipairs(u117.LandingParticles:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u117.BarouLightningAura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
                task.delay(0.3, function() -- Line: 2909
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    local u119, u120 = mainreplication.bodyVelocity(u116, 100, 0.35, nil, nil, true, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
    local u121 = nil;
    u121 = RunService.RenderStepped:Connect(function(p122) -- Line: 2917
        -- upvalues: u119 (copy), u121 (ref), u116 (copy), u115 (copy), u120 (copy)
        if u119 and u119:IsDescendantOf(game) then
            u119.Velocity = u116.CFrame.LookVector * 5 + (u115 and u116.CFrame.RightVector * -u120.Value or u116.CFrame.RightVector * u120.Value);

            return;
        end;

        u121:Disconnect();
    end);
    task.delay(15, u121.Disconnect, u121);
    task.delay(0.6, function() -- Line: 2928
        -- upvalues: ReplicatedStorage (ref), u116 (copy), u117 (copy), Players (ref), u114 (copy), Lighting (ref), TweenService (ref), mainreplication (ref), RunService (ref), u115 (copy)
        local u123 = ReplicatedStorage.Resources.barou.thurauRa2:Clone();
        u123.Weld.Part0 = u116;
        u123.Parent = u117;

        for _, descendant in ipairs(u123:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;

                if descendant:IsA("Beam") then
                    task.spawn(function() -- Line: 2947
                        -- upvalues: u123 (copy), descendant (copy)
                        for i = 1, 50 do
                            if not u123:IsDescendantOf(game) then
                                break;
                            end;

                            descendant.CurveSize0 = Random.new():NextNumber(-8, 8);
                            descendant.CurveSize1 = Random.new():NextNumber(-8, 8);
                            descendant.Width1 = Random.new():NextNumber(0, 8);
                            u123.Weld.C0 = CFrame.Angles(Random.new():NextInteger(-360, 360), Random.new():NextInteger(-360, 360), Random.new():NextInteger(-360, 360));
                            task.wait(0.01);
                            local _ = i;
                        end;
                    end);
                end;
            end;
        end;

        task.delay(0.12, u123.Destroy, u123);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u114) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v124 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v124.Parent = Lighting;
            v124.TintColor = Color3.fromRGB(85, 0, 127);
            v124.Brightness = 0.4;
            v124.Contrast = 1;
            v124.Saturation = -0.4;
            TweenService:Create(v124, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v124, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v124.Destroy, v124);
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(10, 1.5, 6);
            local u125, u126 = mainreplication.bodyVelocity(u116, 200, 0.67, nil, nil, true, TweenInfo.new(0.7200000000000001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
            local u127 = nil;
            u127 = RunService.RenderStepped:Connect(function(p128) -- Line: 3021
                -- upvalues: u125 (copy), u127 (ref), u115 (ref), u116 (ref), u126 (copy)
                if u125 and u125:IsDescendantOf(game) then
                    u125.Velocity = u115 and u116.CFrame.RightVector * u126.Value or u116.CFrame.RightVector * -u126.Value;

                    return;
                end;

                u127:Disconnect();
            end);
        end;
    end);
end;

function v1.baroushot(u129, u130, p131) -- Line: 3033
    -- upvalues: MeshEmitter (copy), ReplicatedStorage (copy), vfxUtil (copy), TweenService (copy), Util (copy), LocalPlayer (copy), mainreplication (copy), Lighting (copy)
    local v132 = u129.HumanoidRootPart or u129.PrimaryPart;
    MeshEmitter.StartMeshEmitter(v132, ReplicatedStorage.Resources.barou["LongShot MeshEmitter"]);

    if p131 and vfxUtil.isLocalPlayer(u129) then
        local v133 = 0.46 / u130;
        local MoonEffects = vfxUtil.getMoonEffects();
        MoonEffects.Vignette.ImageColor3 = Color3.new(0.619608, 0, 0.0117647);
        TweenService:Create(MoonEffects.Vignette, TweenInfo.new(v133 * 0.5), {
            ImageTransparency = 0
        }):Play();
        task.delay(v133, function() -- Line: 3044
            -- upvalues: TweenService (ref), MoonEffects (copy)
            local v134 = TweenService:Create(MoonEffects.Vignette, TweenInfo.new(1), {
                ImageTransparency = 1
            });
            v134:Play();
            v134.Completed:Once(function() -- Line: 3049
                -- upvalues: MoonEffects (ref)
                MoonEffects:Destroy();
            end);
        end);
    end;

    local u135 = ReplicatedStorage.Resources.barou.LongShotVFX:Clone();
    u135.SHOT.HumanoidRootPart.Part0 = v132;
    u135.Parent = u129;
    task.delay(5 / u130, function() -- Line: 3058
        -- upvalues: u135 (copy)
        u135:Destroy();
    end);

    if Util.canshiftcolor(LocalPlayer, u129) then
        vfxUtil.LeanTowardsColor(u135, u129:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u129:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u136 = ReplicatedStorage.Resources.barou.windupRa2:Clone();
    u136.Weld.Part0 = v132;
    u136.Parent = u135;

    local function transform_trans(p137) -- Line: 3073
        local v138 = {};

        for _, v in p137.Transparency.Keypoints do
            table.insert(v138, NumberSequenceKeypoint.new(v.Time, v.Value + (1 - v.Value) * 0.75, v.Envelope));
        end;

        p137.Transparency = NumberSequence.new(v138);
    end;

    if p131 then
        for _, descendant in u135:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Rate = descendant.Rate * 0.5;
                transform_trans(descendant);
            end;
        end;

        local v139 = {};

        for _, descendant in u136:GetDescendants() do
            if descendant:IsA("Beam") then
                table.insert(v139, descendant);
            end;
        end;

        for i = 1, math.floor(#v139 / 2) do
            local table_remove_ret = table.remove(v139, math.random(#v139));
            pcall(game.Destroy, table_remove_ret);
            local _ = i;
        end;

        for _, v in v139 do
            transform_trans(v);
        end;
    end;

    local math_floor_ret = math.floor(50 / u130);

    for _, descendant in ipairs(u136:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = true;

            if descendant:IsA("Beam") then
                task.spawn(function() -- Line: 3123
                    -- upvalues: math_floor_ret (copy), u136 (copy), descendant (copy)
                    for i = 1, math_floor_ret do
                        if not u136:IsDescendantOf(game) then
                            break;
                        end;

                        descendant.CurveSize0 = Random.new():NextNumber(-8, 8);
                        descendant.CurveSize1 = Random.new():NextNumber(-8, 8);
                        descendant.Width1 = Random.new():NextNumber(0, 8);
                        u136.Weld.C0 = CFrame.Angles(Random.new():NextInteger(-360, 360), Random.new():NextInteger(-360, 360), Random.new():NextInteger(-360, 360));
                        task.wait(0.01);
                        local _ = i;
                    end;
                end);
            end;
        end;
    end;

    task.delay(0.017 / u130, function() -- Line: 3140
        -- upvalues: u135 (copy)
        for _, descendant in ipairs(u135.LongShotCharge:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.467 / u130, function() -- Line: 3148
        -- upvalues: u135 (copy)
        for _, descendant in ipairs(u135.SHOT:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);

    if u129 == LocalPlayer.Character then
        mainreplication.fov(true, 120, 0.45 / u130, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");

        if not Util.isepilepsysafe() then
            ColorCorrectionEffect.Parent = Lighting;
        end;

        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.467 / u130, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Contrast = 0.5,
            Brightness = 0.4
        }):Play();
        task.delay(0.467 / u130, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
    end;

    task.delay(0.467 / u130, function() -- Line: 3168
        -- upvalues: u136 (copy), u129 (copy), LocalPlayer (ref), Lighting (ref), TweenService (ref), u130 (copy), ReplicatedStorage (ref), Util (ref), mainreplication (ref)
        u136:Destroy();

        if u129 == LocalPlayer.Character then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533 / u130, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.3 / u130, BlurEffect.Destroy, BlurEffect);
            local v140 = ReplicatedStorage.Resources.ColorCorrection:Clone();

            if not Util.isepilepsysafe() then
                v140.Parent = Lighting;
            end;

            v140.TintColor = Color3.fromRGB(255, 0, 0);
            v140.Brightness = 0.4;
            v140.Contrast = 1;
            v140.Saturation = -0.4;
            TweenService:Create(v140, TweenInfo.new(1.5 / u130, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v140, TweenInfo.new(2 / u130, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2 / u130, v140.Destroy, v140);
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(25, 1.5, 8);
        end;
    end);
end;

function v1.kingangleDribble(u141, u142, p143) -- Line: 3215
    -- upvalues: mainreplication (copy), raycast (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Players (copy), Lighting (copy), TweenService (copy), RunService (copy)
    local u144 = u141.HumanoidRootPart or u141.PrimaryPart;
    local v145 = 1 - (p143 and 0.035 or 0);
    local u146 = mainreplication.bodyVelocity(u144, 54 * v145, 0.35, true, nil, nil, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
    local u147 = 30 * v145;
    local u148 = 30 * v145;
    local u149 = false;

    if u142.Value then
        u149 = true;
    else
        local u150 = nil;
        local u151 = nil;
        u150 = u142.Changed:Connect(function() -- Line: 3234
            -- upvalues: u142 (copy), u149 (ref), u150 (ref)
            if u142.Value then
                u149 = true;
                u150:Disconnect();
            end;
        end);
        u151 = u142.AncestryChanged:Connect(function() -- Line: 3240
            -- upvalues: u142 (copy), u150 (ref), u151 (ref)
            if not u142:IsDescendantOf(game) then
                u150:Disconnect();
                u151:Disconnect();
            end;
        end);
    end;

    task.delay(0.417, function() -- Line: 3248
        -- upvalues: u149 (ref), u146 (copy), raycast (ref), u144 (copy), mainreplication (ref), ReplicatedStorage (ref), u141 (copy), Util (ref), LocalPlayer (ref), vfxUtil (ref), Players (ref), Lighting (ref), TweenService (ref), u148 (copy), u147 (copy), RunService (ref)
        if u149 then
            return;
        end;

        if u146 then
            u146:Destroy();
        end;

        if raycast(u144.Position, u144.CFrame.UpVector * -5) then
            mainreplication.Emit(u144, ReplicatedStorage.Resources.barou.DashParticles, 3, CFrame.new(Vector3.new(-0, -3, -0)));
        end;

        local u152 = ReplicatedStorage.Resources.barou.ZigZagAura1:Clone();
        u152.ZigZagAura1.Part0 = u144;
        u152.Parent = u141;

        if Util.canshiftcolor(LocalPlayer, u141) then
            vfxUtil.LeanTowardsColor(u152, u141:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u141:GetAttribute("CustomAlpha") or 0.985);
        end;

        for _, descendant in ipairs(u152:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(0.25, function() -- Line: 3273
            -- upvalues: u152 (copy)
            for _, descendant in ipairs(u152:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(3, u152.Destroy, u152);
        end);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u141) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.3, BlurEffect.Destroy, BlurEffect);
        local v153 = ReplicatedStorage.Resources.ColorCorrection:Clone();

        if not Util.isepilepsysafe() then
            v153.Parent = Lighting;
        end;

        v153.TintColor = Color3.fromRGB(255, 0, 0);
        v153.Brightness = 0.4;
        v153.Contrast = 1;
        v153.Saturation = -0.4;
        TweenService:Create(v153, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v153, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v153.Destroy, v153);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(25, 1.5, 5);
        local v154 = u144.CFrame.RightVector * -u148 + u144.CFrame.LookVector * u147;
        local Position = (raycast(u144.Position, v154) or u144.CFrame + v154).Position;
        local u155 = nil;
        u155 = RunService.RenderStepped:connect(function(p156) -- Line: 3315
            -- upvalues: u144 (ref), u149 (ref), u155 (ref), Position (ref)
            if u144 and (u144:IsDescendantOf(game) and not u149) then
                u144.CFrame = u144.CFrame:Lerp(CFrame.new(Position, Position + u144.CFrame.LookVector), math.min(p156, 0.03333333333333333) * 10);

                return;
            end;

            u155:Disconnect();
        end);
        task.delay(0.4, u155.Disconnect, u155);
    end);
    task.delay(0.733, function() -- Line: 3322
        -- upvalues: u149 (ref), raycast (ref), u144 (copy), mainreplication (ref), ReplicatedStorage (ref), u141 (copy), Util (ref), LocalPlayer (ref), vfxUtil (ref), Players (ref), Lighting (ref), TweenService (ref), u148 (copy), u147 (copy), RunService (ref)
        if u149 then
            return;
        end;

        if raycast(u144.Position, u144.CFrame.UpVector * -5) then
            mainreplication.Emit(u144, ReplicatedStorage.Resources.barou.DashParticles, 3, CFrame.new(Vector3.new(-0, -3, -0)));
        end;

        local u157 = ReplicatedStorage.Resources.barou.ZigZagAura2:Clone();
        u157.ZigZagAura2.Part0 = u144;
        u157.Parent = u141;

        if Util.canshiftcolor(LocalPlayer, u141) then
            vfxUtil.LeanTowardsColor(u157, u141:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u141:GetAttribute("CustomAlpha") or 0.985);
        end;

        for _, descendant in ipairs(u157:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(0.25, function() -- Line: 3342
            -- upvalues: u157 (copy)
            for _, descendant in ipairs(u157:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(3, u157.Destroy, u157);
        end);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u141) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.3, BlurEffect.Destroy, BlurEffect);
        local v158 = ReplicatedStorage.Resources.ColorCorrection:Clone();

        if not Util.isepilepsysafe() then
            v158.Parent = Lighting;
        end;

        v158.TintColor = Color3.fromRGB(255, 0, 0);
        v158.Brightness = 0.4;
        v158.Contrast = 1;
        v158.Saturation = -0.4;
        TweenService:Create(v158, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v158, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v158.Destroy, v158);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(25, 1.5, 5);
        local v159 = u144.CFrame.RightVector * u148 + u144.CFrame.LookVector * u147;
        local Position = (raycast(u144.Position, v159) or u144.CFrame + v159).Position;
        local u160 = nil;
        u160 = RunService.RenderStepped:connect(function(p161) -- Line: 3384
            -- upvalues: u144 (ref), u149 (ref), u160 (ref), Position (ref)
            if u144 and (u144:IsDescendantOf(game) and not u149) then
                u144.CFrame = u144.CFrame:Lerp(CFrame.new(Position, Position + u144.CFrame.LookVector), math.min(p161, 0.03333333333333333) * 10);

                return;
            end;

            u160:Disconnect();
        end);
        task.delay(0.4, u160.Disconnect, u160);
    end);
    task.delay(1.183, function() -- Line: 3391
        -- upvalues: u149 (ref), raycast (ref), u144 (copy), mainreplication (ref), ReplicatedStorage (ref), u141 (copy), Util (ref), LocalPlayer (ref), vfxUtil (ref), Players (ref), Lighting (ref), TweenService (ref), u148 (copy), u147 (copy), RunService (ref)
        if u149 then
            return;
        end;

        if raycast(u144.Position, u144.CFrame.UpVector * -5) then
            mainreplication.Emit(u144, ReplicatedStorage.Resources.barou.DashParticles, 3, CFrame.new(Vector3.new(-0, -3, -0)));
        end;

        local u162 = ReplicatedStorage.Resources.barou.ZigZagAura3:Clone();
        u162.ZigZagAura3.Part0 = u144;
        u162.Parent = u141;

        if Util.canshiftcolor(LocalPlayer, u141) then
            vfxUtil.LeanTowardsColor(u162, u141:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u141:GetAttribute("CustomAlpha") or 0.985);
        end;

        for _, descendant in ipairs(u162:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(0.25, function() -- Line: 3412
            -- upvalues: u162 (copy)
            for _, descendant in ipairs(u162:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(3, u162.Destroy, u162);
        end);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u141) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.3, BlurEffect.Destroy, BlurEffect);
        local v163 = ReplicatedStorage.Resources.ColorCorrection:Clone();

        if not Util.isepilepsysafe() then
            v163.Parent = Lighting;
        end;

        v163.TintColor = Color3.fromRGB(255, 0, 0);
        v163.Brightness = 0.4;
        v163.Contrast = 1;
        v163.Saturation = -0.4;
        TweenService:Create(v163, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v163, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v163.Destroy, v163);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(25, 1.5, 5);
        local v164 = u144.CFrame.RightVector * -u148 + u144.CFrame.LookVector * u147;
        local Position = (raycast(u144.Position, v164) or u144.CFrame + v164).Position;
        local u165 = nil;
        u165 = RunService.RenderStepped:connect(function(p166) -- Line: 3455
            -- upvalues: u144 (ref), u149 (ref), u165 (ref), Position (ref)
            if u144 and (u144:IsDescendantOf(game) and not u149) then
                u144.CFrame = u144.CFrame:Lerp(CFrame.new(Position, Position + u144.CFrame.LookVector), math.min(p166, 0.03333333333333333) * 10);

                return;
            end;

            u165:Disconnect();
        end);
        task.delay(0.4, u165.Disconnect, u165);
    end);
    task.delay(1.7, function() -- Line: 3462
        -- upvalues: u149 (ref), raycast (ref), u144 (copy), mainreplication (ref), ReplicatedStorage (ref), RunService (ref)
        if u149 then
            return;
        end;

        if raycast(u144.Position, u144.CFrame.UpVector * -5) then
            mainreplication.Emit(u144, ReplicatedStorage.Resources.barou.DashParticles, 3, CFrame.new(Vector3.new(-0, -3, -0)));
        end;

        mainreplication.cameraShake(25, 1.5, 5);
        local u167, u168 = mainreplication.bodyVelocity(u144, 70, 1, nil, nil, true, TweenInfo.new(2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
        local u169 = nil;
        u169 = RunService.RenderStepped:Connect(function(p170) -- Line: 3474
            -- upvalues: u167 (copy), u149 (ref), u169 (ref), u144 (ref), u168 (copy)
            if u167 and (u167:IsDescendantOf(game) and not u149) then
                u167.Velocity = u144.CFrame.LookVector * u168.Value + u144.CFrame.RightVector * u168.Value;

                return;
            end;

            pcall(game.Destroy, u167);
            u169:Disconnect();
        end);
        task.delay(1, u169.Disconnect, u169);
    end);
end;

function v1.thurauangleDribble(u171) -- Line: 3487
    -- upvalues: mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), raycast (copy), Players (copy), Lighting (copy), TweenService (copy), RunService (copy)
    local u172 = u171.HumanoidRootPart or u171.PrimaryPart;
    local u173 = mainreplication.bodyVelocity(u172, 120, 0.35, true, nil, nil, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
    soundUtil:play(ReplicatedStorage.Resources.barou["THURAU STEAL"], SoundService);
    task.delay(0.417, function() -- Line: 3500
        -- upvalues: u173 (copy), raycast (ref), u172 (copy), mainreplication (ref), ReplicatedStorage (ref), u171 (copy), Players (ref), Lighting (ref), TweenService (ref), RunService (ref)
        if u173 then
            u173:Destroy();
        end;

        if raycast(u172.Position, u172.CFrame.UpVector * -15) then
            mainreplication.Emit(u172, ReplicatedStorage.Resources.barou.DashParticles, 3, CFrame.new(Vector3.new(-0, -3, -0)));
        end;

        local u174 = ReplicatedStorage.Resources.barou.ZigZagAura1:Clone();
        u174.ZigZagAura1.Part0 = u172;
        u174.Parent = u171;

        for _, descendant in ipairs(u174:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(0.25, function() -- Line: 3520
            -- upvalues: u174 (copy)
            for _, descendant in ipairs(u174:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(3, u174.Destroy, u174);
        end);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u171) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.3, BlurEffect.Destroy, BlurEffect);
        local v175 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v175.Parent = Lighting;
        v175.TintColor = Color3.fromRGB(255, 0, 0);
        v175.Brightness = 0.4;
        v175.Contrast = 1;
        v175.Saturation = -0.4;
        TweenService:Create(v175, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v175, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v175.Destroy, v175);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(25, 1.5, 5);
        local v176 = u172.CFrame.RightVector * -70 + u172.CFrame.LookVector * 70;
        local Position = (raycast(u172.Position, v176) or u172.CFrame + v176).Position;
        local u177 = nil;
        u177 = RunService.RenderStepped:connect(function(p178) -- Line: 3560
            -- upvalues: u172 (ref), u177 (ref), Position (ref)
            if u172 and u172:IsDescendantOf(game) then
                u172.CFrame = u172.CFrame:Lerp(CFrame.new(Position, Position + u172.CFrame.LookVector), p178 * 30);

                return;
            end;

            u177:Disconnect();
        end);
        task.delay(0.4, u177.Disconnect, u177);
    end);
    task.delay(0.733, function() -- Line: 3567
        -- upvalues: raycast (ref), u172 (copy), mainreplication (ref), ReplicatedStorage (ref), u171 (copy), Players (ref), Lighting (ref), TweenService (ref), RunService (ref)
        if raycast(u172.Position, u172.CFrame.UpVector * -5) then
            mainreplication.Emit(u172, ReplicatedStorage.Resources.barou.DashParticles, 3, CFrame.new(Vector3.new(-0, -3, -0)));
        end;

        local u179 = ReplicatedStorage.Resources.barou.ZigZagAura2:Clone();
        u179.ZigZagAura2.Part0 = u172;
        u179.Parent = u171;

        for _, descendant in ipairs(u179:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(0.25, function() -- Line: 3583
            -- upvalues: u179 (copy)
            for _, descendant in ipairs(u179:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(3, u179.Destroy, u179);
        end);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u171) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.3, BlurEffect.Destroy, BlurEffect);
        local v180 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v180.Parent = Lighting;
        v180.TintColor = Color3.fromRGB(255, 0, 0);
        v180.Brightness = 0.4;
        v180.Contrast = 1;
        v180.Saturation = -0.4;
        TweenService:Create(v180, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v180, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v180.Destroy, v180);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(25, 1.5, 5);
        local v181 = u172.CFrame.RightVector * 70 + u172.CFrame.LookVector * 70;
        local Position = (raycast(u172.Position, v181) or u172.CFrame + v181).Position;
        local u182 = nil;
        u182 = RunService.RenderStepped:connect(function(p183) -- Line: 3623
            -- upvalues: u172 (ref), u182 (ref), Position (ref)
            if u172 and u172:IsDescendantOf(game) then
                u172.CFrame = u172.CFrame:Lerp(CFrame.new(Position, Position + u172.CFrame.LookVector), p183 * 30);

                return;
            end;

            u182:Disconnect();
        end);
        task.delay(0.4, u182.Disconnect, u182);
    end);
    task.delay(1.183, function() -- Line: 3630
        -- upvalues: raycast (ref), u172 (copy), mainreplication (ref), ReplicatedStorage (ref), u171 (copy), Players (ref), Lighting (ref), TweenService (ref), RunService (ref)
        if raycast(u172.Position, u172.CFrame.UpVector * -15) then
            mainreplication.Emit(u172, ReplicatedStorage.Resources.barou.DashParticles, 3, CFrame.new(Vector3.new(-0, -3, -0)));
        end;

        local u184 = ReplicatedStorage.Resources.barou.ZigZagAura3:Clone();
        u184.ZigZagAura3.Part0 = u172;
        u184.Parent = u171;

        for _, descendant in ipairs(u184:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(0.25, function() -- Line: 3646
            -- upvalues: u184 (copy)
            for _, descendant in ipairs(u184:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(3, u184.Destroy, u184);
        end);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u171) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.3, BlurEffect.Destroy, BlurEffect);
        local v185 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v185.Parent = Lighting;
        v185.TintColor = Color3.fromRGB(255, 0, 0);
        v185.Brightness = 0.4;
        v185.Contrast = 1;
        v185.Saturation = -0.4;
        TweenService:Create(v185, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v185, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v185.Destroy, v185);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(25, 1.5, 5);
        local v186 = u172.CFrame.RightVector * -70 + u172.CFrame.LookVector * 70;
        local Position = (raycast(u172.Position, v186) or u172.CFrame + v186).Position;
        local u187 = nil;
        u187 = RunService.RenderStepped:connect(function(p188) -- Line: 3687
            -- upvalues: u172 (ref), u187 (ref), Position (ref)
            if u172 and u172:IsDescendantOf(game) then
                u172.CFrame = u172.CFrame:Lerp(CFrame.new(Position, Position + u172.CFrame.LookVector), p188 * 30);

                return;
            end;

            u187:Disconnect();
        end);
        task.delay(0.4, u187.Disconnect, u187);
    end);
    task.delay(1.7, function() -- Line: 3694
        -- upvalues: raycast (ref), u172 (copy), mainreplication (ref), ReplicatedStorage (ref), RunService (ref)
        if raycast(u172.Position, u172.CFrame.UpVector * -15) then
            mainreplication.Emit(u172, ReplicatedStorage.Resources.barou.DashParticles, 3, CFrame.new(Vector3.new(-0, -3, -0)));
        end;

        mainreplication.cameraShake(25, 1.5, 5);
        local u189, u190 = mainreplication.bodyVelocity(u172, 120, 1, nil, nil, true, TweenInfo.new(2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
        local u191 = nil;
        u191 = RunService.RenderStepped:Connect(function(p192) -- Line: 3706
            -- upvalues: u189 (copy), u191 (ref), u172 (ref), u190 (copy)
            if u189 and u189:IsDescendantOf(game) then
                u189.Velocity = u172.CFrame.LookVector * u190.Value + u172.CFrame.RightVector * u190.Value;

                return;
            end;

            u191:Disconnect();
        end);
        task.delay(1, u191.Disconnect, u191);
    end);
end;

function v1.barouAwk(u193, p194) -- Line: 3718
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), PlayerGui (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Players (copy), RunService (copy), TweenService (copy), soundUtil (copy), SoundService (copy), animationUtil (copy), TekrinnDialogue (copy), Contrast (copy), Saturation (copy), Ambient (copy), ClockTime (copy), Brightness (copy)
    local v195 = u193.HumanoidRootPart or u193.PrimaryPart;
    local _ = u193.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local u196 = ReplicatedStorage.Resources.barou.barouawkEff:Clone();
    u196:PivotTo(v195.CFrame);
    u196.Parent = u193;
    local u197 = ReplicatedStorage.Resources.barou.camBeam:Clone();
    u197.Parent = u196;
    local u198 = ReplicatedStorage.Resources.uibox:Clone();
    u198.Parent = PlayerGui;
    local u199 = ReplicatedStorage.Resources.glowscreen:Clone();
    u199.Parent = PlayerGui;
    u199.ImageLabel2.ImageTransparency = 0.5;
    u199.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);

    if Util.canshiftcolor(LocalPlayer, u193) then
        vfxUtil.LeanTowardsColor(u196, u193:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u193:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.spawn(function() -- Line: 3746
        -- upvalues: Players (ref), u193 (copy), u196 (copy)
        local HumanoidDescriptionFromUserId = Players:GetHumanoidDescriptionFromUserId(Players:GetPlayerFromCharacter(u193).userId);
        u196.BarouAgo.Humanoid:ApplyDescriptionReset(HumanoidDescriptionFromUserId);
    end);
    local u200 = nil;
    u200 = RunService.PreRender:connect(function() -- Line: 3752
        -- upvalues: u197 (copy), u200 (ref)
        if u197:IsDescendantOf(game) then
            u197.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u200:Disconnect();
    end);

    for _, descendant in ipairs(u196:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local u201 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u201.Parent = Lighting;
    u201.FarIntensity = 0;
    TweenService:Create(u201, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local v202 = soundUtil:play(ReplicatedStorage.Resources.barou.barouAwkSound, SoundService, {
        Character = u193
    });
    mainreplication.cutscene(v195, nil, 16.95, ReplicatedStorage.Resources.barou.barowawkFOV);
    animationUtil:loadAnimation(u196.BarouAgo, ReplicatedStorage.Resources.barou.barouAwkAgo):Play(0);
    animationUtil:loadAnimation(u196.RedLion, ReplicatedStorage.Resources.barou.barouAwkLion):Play(0);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.817, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Brightness = 1;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.917, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Brightness = 0
    }):Play();
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.ClockTime = 0;
    Lighting.ColorCorrection.Contrast = 0;
    Lighting.ColorCorrection.Saturation = 0;

    for _, descendant in ipairs(u196.barouroom:GetDescendants()) do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    local u203 = Util.Preload(ReplicatedStorage.Resources.barou.ImpactFrame1);

    if v202.Name == "Dub" then
        task.delay(0.133, function() -- Line: 3807
            -- upvalues: TekrinnDialogue (ref), u193 (copy)
            TekrinnDialogue.Speak(u193, {
                {
                    Text = "That must be a lie, an escape for those with broken dreams...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(161, 161, 161)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 5
                    }
                }
            }, 6);
        end);
        task.delay(4.533, function() -- Line: 3833
            -- upvalues: TekrinnDialogue (ref), u193 (copy)
            TekrinnDialogue.Speak(u193, {
                {
                    Text = "Who can\'t stand to think their lives were wasted.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(161, 161, 161)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 5
                    }
                }
            }, 8);
        end);
        task.delay(9.283, function() -- Line: 3859
            -- upvalues: TekrinnDialogue (ref), u193 (copy)
            TekrinnDialogue.Speak(u193, {
                {
                    Text = "The idea of living like that...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(161, 117, 117)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 4
                    }
                }
            }, 7);
        end);
        task.delay(12.083, function() -- Line: 3885
            -- upvalues: TekrinnDialogue (ref), u193 (copy)
            TekrinnDialogue.Speak(u193, {
                {
                    Text = "Is a future..",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 4);
        end);
        task.delay(14.753, function() -- Line: 3911
            -- upvalues: TekrinnDialogue (ref), u193 (copy)
            TekrinnDialogue.Speak(u193, {
                {
                    Text = "I REFUSE TO ACCEPT!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 6,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    else
        task.delay(0.133, function() -- Line: 3937
            -- upvalues: TekrinnDialogue (ref), u193 (copy)
            TekrinnDialogue.Speak(u193, {
                {
                    Text = "But that\'s just escapism for those with broken dreams",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(161, 161, 161)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 5
                    }
                }
            }, 6);
        end);
        task.delay(4.033, function() -- Line: 3963
            -- upvalues: TekrinnDialogue (ref), u193 (copy)
            TekrinnDialogue.Speak(u193, {
                {
                    Text = "who can\'t bear to deny the lives they\'ve led so far",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(161, 161, 161)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 5
                    }
                }
            }, 8);
        end);
        task.delay(9.283, function() -- Line: 3989
            -- upvalues: TekrinnDialogue (ref), u193 (copy)
            TekrinnDialogue.Speak(u193, {
                {
                    Text = "I refuse..",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(161, 117, 117)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 4
                    }
                }
            }, 7);
        end);
        task.delay(12.083, function() -- Line: 4015
            -- upvalues: TekrinnDialogue (ref), u193 (copy)
            TekrinnDialogue.Speak(u193, {
                {
                    Text = "to live in a future..",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 4);
        end);
        task.delay(16.233, function() -- Line: 4041
            -- upvalues: TekrinnDialogue (ref), u193 (copy)
            TekrinnDialogue.Speak(u193, {
                {
                    Text = "LIKE THAT!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 6,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    end;

    task.delay(3.533, function() -- Line: 4068
        -- upvalues: u196 (copy)
        for _, descendant in ipairs(u196.BarouAgo.cola.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.333, function() -- Line: 4075
        -- upvalues: u196 (copy)
        u196.BarouAgo.cola.Attachment:Destroy();
    end);
    task.delay(8.833, function() -- Line: 4079
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        local v204 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2.534, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Brightness = 1
        });
        v204:Play();
        v204.Completed:Wait();
        local v205 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            Brightness = -1
        });
        v205:Play();
        v205.Completed:Wait();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.516, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(8.833, function() -- Line: 4092
        -- upvalues: TweenService (ref), BlurEffect (copy)
        local v206 = TweenService:Create(BlurEffect, TweenInfo.new(2.534, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 25
        });
        v206:Play();
        v206.Completed:Wait();
        local v207 = TweenService:Create(BlurEffect, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            Size = 28
        });
        v207:Play();
        v207.Completed:Wait();
        TweenService:Create(BlurEffect, TweenInfo.new(0.516, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end);
    task.delay(11.733, function() -- Line: 4105
        -- upvalues: Lighting (ref), Contrast (ref), Saturation (ref), Ambient (ref), ClockTime (ref), ReplicatedStorage (ref), u193 (copy), u196 (copy)
        Lighting.ColorCorrection.Contrast = Contrast;
        Lighting.ColorCorrection.Saturation = Saturation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
        local v208 = ReplicatedStorage.Resources.barou.barouEyeAura:Clone();
        v208.Weld.Part0 = u193.Head;
        v208.Parent = u196;

        for _, descendant in pairs(u196.ragebackground:GetDescendants()) do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(14.8, function() -- Line: 4129
        -- upvalues: ColorCorrectionEffect (copy), u196 (copy), Util (ref), ReplicatedStorage (ref)
        ColorCorrectionEffect.Brightness = -1;

        for _, descendant in ipairs(u196.particleemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame1, 40);
    end);
    task.delay(15.417, function() -- Line: 4141
        -- upvalues: u196 (copy), u197 (copy), ColorCorrectionEffect (copy), TweenService (ref)
        u196.ragebackground:Destroy();

        for _, descendant in ipairs(u197:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u196.Scene:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        ColorCorrectionEffect.Brightness = 0.5;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 0, 0);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(16.95, function() -- Line: 4164
        -- upvalues: u203 (copy), u201 (copy), ColorCorrectionEffect (copy), u196 (copy), u198 (copy), u199 (copy), BlurEffect (copy), mainreplication (ref), Lighting (ref), Brightness (ref)
        u203:Destroy();
        u201:Destroy();
        ColorCorrectionEffect:Destroy();
        u196:Destroy();
        u198:Destroy();
        u199:Destroy();
        BlurEffect:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1.5);
        Lighting.Brightness = Brightness;
    end);
end;

function v1.barouAwkwithoutball(u209, p210, p211) -- Line: 4191
    -- upvalues: Lighting (copy), vfxUtil (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), RunService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), TweenService (copy), PlayerGui (copy), Brightness (copy)
    local v212 = u209.HumanoidRootPart or u209.PrimaryPart;
    local _ = u209.Torso;
    local _ = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    mainreplication.sceneEnabled(true);
    local Color3_new_ret = Color3.new(1, 0, 0);
    local u213 = ReplicatedStorage.Resources.barou.allEffectBAROUAWKSTEAL:Clone();
    u213:PivotTo(v212.CFrame);
    u213.Parent = u209;
    local u214 = ReplicatedStorage.Resources.barou.camEffSteal:Clone();
    u214.Parent = u213;

    if Util.canshiftcolor(LocalPlayer, u209) then
        Color3_new_ret = u209:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127);
        vfxUtil.LeanTowardsColor(u213, u209:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u209:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u215 = nil;
    u215 = RunService.PreRender:connect(function() -- Line: 4216
        -- upvalues: u214 (copy), u215 (ref)
        if u214:IsDescendantOf(game) then
            u214.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u215:Disconnect();
    end);
    u213.domain.Transparency = 1;

    for _, descendant in ipairs(u213:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local u216 = Util.Preload({
        ReplicatedStorage.Resources.barou.ImpactFrame2,
        ReplicatedStorage.Resources.barou.ImpactFrame3,
        ReplicatedStorage.Resources.barou.ImpactFrame4,
        ReplicatedStorage.Resources.barou.ImpactFrame5
    });
    Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame1, 50);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    local u217 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u217.Parent = Lighting;
    u217.FarIntensity = 1;
    local v218 = soundUtil:play(ReplicatedStorage.Resources.barou["KINGSTEAL AWAKE SFX (1)"], SoundService, {
        Character = u209
    });
    mainreplication.cutsceneBlender(v212, ReplicatedStorage.Resources.barou.barouAwkwithoutballCam, ReplicatedStorage.Resources.barou.barowawkWithoutballFOV);

    if v218.Name == "Dub" then
        task.delay(1.083, function() -- Line: 4245
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "I can see it! I can feel it!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 4);
        end);
        task.delay(3.317, function() -- Line: 4271
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "Because I experienced defeat, and made discovery.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(6.333, function() -- Line: 4297
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "An entirely new way of viewing the field.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(9.283, function() -- Line: 4323
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "Not a route dependant on some lead actor.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(11.283, function() -- Line: 4349
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "But the path that exists solely for me.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 4);
        end);
        task.delay(13.783, function() -- Line: 4375
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "A TWISTED PATH!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(17.567, function() -- Line: 4401
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "I WON\'T BE REDUCED TO A SUPPORTING ROLE.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 5);
        end);
        task.delay(20.733, function() -- Line: 4427
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "MOVE IT!!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 5
                    }
                }
            }, 5);
        end);
        task.delay(22.683, function() -- Line: 4453
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "So you want to the lead, fine then... I\'m more than happy to play the villain.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 5
                    }
                }
            }, 5);
        end);
        task.delay(27.2, function() -- Line: 4479
            -- upvalues: u209 (copy), soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), TekrinnDialogue (ref), Color3_new_ret (ref)
            if u209:GetAttribute("RinNoPlay") then
                soundUtil:play(ReplicatedStorage.Resources.barou.RAMPAGE, SoundService);
            end;

            TekrinnDialogue.Speak(u209, {
                {
                    Text = "THE ONE WHO DEVOURS YOUR LIGHT!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    else
        task.delay(1.083, function() -- Line: 4508
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "I can see it! I can feel it!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 4);
        end);
        task.delay(3.317, function() -- Line: 4534
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "Now that i know defeat, what i need to see is.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(6.333, function() -- Line: 4560
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "Not some legitimate route that entrusts the goal to the lead.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(9.383, function() -- Line: 4586
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "But the route that only exists for my goal. This...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 4);
        end);
        task.delay(12.383, function() -- Line: 4612
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "TWISTED PATH!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(17.567, function() -- Line: 4638
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "I WON\'T BE REDUCED TO A SUPPORTING ROLE.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 5);
        end);
        task.delay(20.733, function() -- Line: 4664
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "MOVE IT!!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 5
                    }
                }
            }, 5);
        end);
        task.delay(22.683, function() -- Line: 4690
            -- upvalues: TekrinnDialogue (ref), u209 (copy), Color3_new_ret (ref)
            TekrinnDialogue.Speak(u209, {
                {
                    Text = "If you\'re the lead, Im more than happy to play the villain...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 5
                    }
                }
            }, 5);
        end);
        task.delay(27.2, function() -- Line: 4716
            -- upvalues: u209 (copy), soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), TekrinnDialogue (ref), Color3_new_ret (ref)
            if u209:GetAttribute("RinNoPlay") then
                soundUtil:play(ReplicatedStorage.Resources.barou.RAMPAGE, SoundService);
            end;

            TekrinnDialogue.Speak(u209, {
                {
                    Text = "WHO DEVOURS YOUR LIGHT!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3_new_ret) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    end;

    task.delay(0.633, function() -- Line: 4746
        -- upvalues: ColorCorrectionEffect (copy), Color3_new_ret (ref), TweenService (ref)
        ColorCorrectionEffect.TintColor = Color3_new_ret;
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.916, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(5.95, function() -- Line: 4752
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        local v219 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.633, Enum.EasingStyle.Linear), {
            Brightness = -0.08
        });
        v219:Play();
        v219.Completed:Wait();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 81, 81);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.233, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(7.2, function() -- Line: 4763
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 81, 81);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.217, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(7.55, function() -- Line: 4770
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 81, 81);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(7.983, function() -- Line: 4777
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 81, 81);
        local v220 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.834, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        v220:Play();
        v220.Completed:Wait();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 103, 103);
        ColorCorrectionEffect.Brightness = 0;
    end);
    task.delay(10.517, function() -- Line: 4790
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.266, Enum.EasingStyle.Linear), {
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(22.467, function() -- Line: 4796
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 103, 103);
        ColorCorrectionEffect.Brightness = -0.15;
    end);
    task.delay(27.317, function() -- Line: 4803
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.716, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(0.633, function() -- Line: 4812
        -- upvalues: ReplicatedStorage (ref), u209 (copy), u213 (copy)
        local v221 = ReplicatedStorage.Resources.barou.eyeFlare:Clone();
        v221.Weld.Part0 = u209.Head;
        v221.Parent = u213;

        for _, descendant in ipairs(v221.Eyeflare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(2.983, function() -- Line: 4824
        -- upvalues: u213 (copy), TweenService (ref)
        for _, descendant in ipairs(u213["Plane.003"]:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u213.LightningParticlesEnable:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(2.9, function() -- Line: 4833
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        local Size = u213["Plane.003"].Size;
        u213["Plane.003"].Size = Vector3.new(11.123, 0.001, 3);
        TweenService:Create(u213["Plane.003"], TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
            Size = Size
        }):Play();

        for i = 1, 5 do
            u213["Plane.003"].Transparency = 0;
            task.wait(Random.new():NextNumber(0.05, 0.25));
            u213["Plane.003"].Transparency = 1;
            task.wait(Random.new():NextNumber(0.05, 0.25));
            local _ = i;
        end;

        u213["Plane.003"].Transparency = 0;
    end);
    task.delay(5.95, function() -- Line: 4855
        -- upvalues: u213 (copy)
        u213["Plane.003"]:Destroy();
    end);
    task.delay(6.6, function() -- Line: 4859
        -- upvalues: u213 (copy)
        u213["1"].Transparency = 0;

        for _, descendant in ipairs(u213["1"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u213.LINEBOOM1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(7.2, function() -- Line: 4875
        -- upvalues: u213 (copy)
        u213["2"].Transparency = 0;

        for _, descendant in ipairs(u213["2"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u213.LINEBOOM2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(7.55, function() -- Line: 4891
        -- upvalues: u213 (copy)
        u213["3"].Transparency = 0;

        for _, descendant in ipairs(u213["3"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u213.LINEBOOM3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(7.983, function() -- Line: 4907
        -- upvalues: u213 (copy)
        u213["4"].Transparency = 0;

        for _, descendant in ipairs(u213["4"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u213.LINEBOOM4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.833, function() -- Line: 4923
        -- upvalues: u213 (copy)
        u213["1"]:Destroy();
        u213["2"]:Destroy();
        u213["3"]:Destroy();
        u213["4"]:Destroy();
        u213.LINEBOOM1:Destroy();
        u213.LINEBOOM2:Destroy();
        u213.LINEBOOM3:Destroy();
        u213.LINEBOOM4:Destroy();

        for _, descendant in ipairs(u213.BigLightningThing:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u213.BigLightningThing:GetDescendants()) do
            if descendant:IsA("Part") then
                descendant.Transparency = 0;
            end;
        end;
    end);
    task.delay(10.533, function() -- Line: 4953
        -- upvalues: u213 (copy)
        u213.BigLightningThing:Destroy();
        u213.domain.Transparency = 0;

        for _, descendant in ipairs(u213.domain:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(3.9, function() -- Line: 4960
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(12.2, function() -- Line: 4965
        -- upvalues: u213 (copy)
        u213.domain.Color = Color3.fromRGB(0, 0, 0);

        for _, descendant in ipairs(u213.LightningAppear:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(0.5, function() -- Line: 4971
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    local u222 = {};
    task.delay(12.533, function() -- Line: 4978
        -- upvalues: ReplicatedStorage (ref), u209 (copy), u213 (copy), u222 (copy)
        local v223 = ReplicatedStorage.Resources.barou.bigeye:Clone();
        v223.Weld.Part0 = u209.Head;
        v223.Parent = u213;
        table.insert(u222, v223);

        for _, descendant in ipairs(u209:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v224 = ReplicatedStorage.Resources.barou["111111"]:Clone();
                v224.Parent = descendant;
                table.insert(u222, v224);
            end;
        end;
    end);
    task.delay(12.967, function() -- Line: 4997
        -- upvalues: u213 (copy), Util (ref), ReplicatedStorage (ref)
        u213.domain.Color = Color3.fromRGB(255, 255, 255);
        Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame2, 30);
    end);
    task.delay(15.433, function() -- Line: 5003
        -- upvalues: u222 (copy)
        for _, v in u222 do
            v:Destroy();
        end;
    end);
    task.delay(16.283, function() -- Line: 5010
        -- upvalues: ReplicatedStorage (ref), u209 (copy), u213 (copy), u214 (copy)
        local u225 = ReplicatedStorage.Resources.barou.bigeye2:Clone();
        u225.Weld.Part0 = u209.Head;
        u225.Parent = u213;
        task.delay(4.15, function() -- Line: 5016
            -- upvalues: u225 (copy)
            for _, descendant in ipairs(u225:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2, u225.Destroy, u225);
        end);
        u213.domain.Color = Color3.fromRGB(255, 48, 48);

        for _, descendant in ipairs(u213.domain:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u214.FX1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(4.15, function() -- Line: 5037
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        for _, descendant in ipairs(u214.FX3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(4.15, function() -- Line: 5044
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(20.817, function() -- Line: 5049
        -- upvalues: u214 (copy)
        for _, descendant in ipairs(u214.FX2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(6.5, function() -- Line: 5053
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(15.453, function() -- Line: 5058
        -- upvalues: ReplicatedStorage (ref), PlayerGui (ref), TweenService (ref), RunService (ref)
        local u226 = ReplicatedStorage.Resources.barou.ImpactFrame3:Clone();
        u226.Parent = PlayerGui;
        u226.ScreenInsets = Enum.ScreenInsets.None;
        u226.Frame.BackgroundTransparency = 1;
        local CanvasGroup = u226.Frame.CanvasGroup;
        CanvasGroup.GroupTransparency = 0;
        u226.Frame.BackgroundTransparency = 0;

        for _, child in ipairs(CanvasGroup:GetChildren()) do
            child.Visible = false;
        end;

        local u227 = #u226.Frame.CanvasGroup:GetChildren();
        local u228 = 0;
        local u229 = nil;
        u229 = RunService.PreRender:Connect(function(p230) -- Line: 5080, Name: UpdateWarper
            -- upvalues: u228 (ref), u227 (copy), TweenService (ref), CanvasGroup (copy), u226 (copy), u229 (ref)
            u228 = u228 + p230;
            local v231 = u228 // 0.03333333333333333;

            if u227 > v231 then
                u226.Frame.CanvasGroup[v231].Visible = true;

                return;
            end;

            TweenService:Create(CanvasGroup, TweenInfo.new(1), {
                GroupTransparency = 1
            }):Play();
            TweenService:Create(u226.Frame, TweenInfo.new(0.5), {
                BackgroundTransparency = 1
            }):Play();
            task.delay(0.5, u226.Destroy, u226);
            u229:Disconnect();
        end);
    end);
    task.delay(21.933, function() -- Line: 5106
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame4, 30);
    end);
    task.delay(27.25, function() -- Line: 5110
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.barou.ImpactFrame5, 30);
    end);
    task.delay(22.417, function() -- Line: 5114
        -- upvalues: ReplicatedStorage (ref), u209 (copy), u213 (copy)
        local u232 = ReplicatedStorage.Resources.barou.bigeye3:Clone();
        u232.Weld.Part0 = u209.Head;
        u232.Parent = u213;
        task.delay(4.8, function() -- Line: 5119
            -- upvalues: u232 (copy)
            for _, descendant in ipairs(u232:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2, u232.Destroy, u232);
        end);
    end);
    task.delay(22.467, function() -- Line: 5130
        -- upvalues: u213 (copy), u209 (copy), ReplicatedStorage (ref), u222 (copy)
        u213.domain.Color = Color3.fromRGB(84, 0, 0);

        for _, descendant in ipairs(u209:GetDescendants()) do
            if descendant:IsA("Part") and (descendant.Name == "Right Arm" or (descendant.Name == "Left Arm" or descendant.Name == "Torso")) then
                local v233 = ReplicatedStorage.Resources.barou.LeftArmFlames1:Clone();
                v233.Parent = descendant;
                table.insert(u222, v233);
            end;
        end;
    end);
    task.delay(27, function() -- Line: 5144
        -- upvalues: u222 (copy)
        for _, v in u222 do
            v:Destroy();
        end;
    end);
    task.delay(27.283, function() -- Line: 5151
        -- upvalues: u213 (copy)
        u213.domain:Destroy();

        for _, descendant in ipairs(u213.LASTHITEFFECTSLOL:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u213.LASTHITEFFECTSLOL:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant ~= u213.LASTHITEFFECTSLOL.PrimaryPart then
                descendant.Transparency = 0.96;
            end;
        end;
    end);
    task.delay(30.517, function() -- Line: 5167
        -- upvalues: ScreenDimmer (copy), u216 (copy), u217 (copy), ColorCorrectionEffect (copy), u213 (copy), mainreplication (ref), Lighting (ref), Brightness (ref)
        ScreenDimmer:Destroy();
        u216:Destroy();
        u217:Destroy();
        ColorCorrectionEffect:Destroy();
        u213:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1.5);
        Lighting.Brightness = Brightness;
    end);
end;

function v1.barouDonAuto(u234, u235) -- Line: 5192
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), Lighting (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy), RunService2 (copy)
    local barou = vfxUtil.getResources():WaitForChild("barou");
    local u236 = trove.new();
    u236:AttachToInstance(u234);
    u236:Add(vfxUtil.getScreenDimmer());
    local DonChemical = barou.DonChemical;
    local Root = vfxUtil.getRoot(u234);
    local _ = vfxUtil.forge;
    mainreplication.sceneEnabled(true);
    local u237, u238 = mainreplication.cutsceneBlender(Root, DonChemical.Animations.Camera, DonChemical.FOV, nil, nil, CFrame.new(0, -3, 0), DonChemical.CamRig);
    local u239 = {};
    local v240 = {};

    for _, child in Lighting:GetChildren() do
        if child:IsA("ColorCorrectionEffect") or (child:IsA("BloomEffect") or (child:IsA("Atmosphere") or (child:IsA("Sky") or (child:IsA("DepthOfFieldEffect") or child:IsA("BlurEffect"))))) then
            table.insert(u239, child);
            child.Parent = workspace;
        end;
    end;

    for _, child in DonChemical.Object:GetChildren() do
        local v241 = u236:Add(child:Clone());
        v241.Parent = Lighting;
        v240[child.Name] = v241;
    end;

    local u242 = u236:Add(DonChemical.VFX:Clone());
    u242:PivotTo(Root.CFrame);
    u242.Parent = workspace.Effects;
    local v243 = u236:Construct(DonChemical.CHREFFECTS.DonLorzeno);
    vfxUtil.setupAura(u235, v243, true);
    v243.Parent = workspace.Effects;
    local v244 = u236:Construct(DonChemical.CHREFFECTS.Barou);
    vfxUtil.setupAura(u234, v244, true);
    v244.Parent = workspace.Effects;
    local v245 = {};

    for _, child in DonChemical.CHREFFECTS.Ball:GetChildren() do
        local v246 = u236:Construct(child);
        v245[v246.Name] = v246;
        v246.Parent = u234:FindFirstChild("Ball");
    end;

    local u247 = {
        DonLorzeno = v243,
        Barou = v244,
        Ball = u234:FindFirstChild("Ball"),
        BloomBarou = v240.BloomBarou,
        Atmosphere = v240.Atmosphere,
        ColorCorrection = v240.ColorCorrection
    };

    local function dumb_yielding_function(u248, u249) -- Line: 5251
        return task.spawn(function() -- Line: 5252
            -- upvalues: u248 (copy), u249 (copy)
            local v250 = tick();

            repeat
                task.wait();
            until tick() - v250 >= u248 - 0.001;

            coroutine.wrap(u249)();
        end);
    end;

    local v251 = soundUtil:play(getLorenzoLine(DonChemical.SFX, DonChemical), SoundService, {
        Character = u234
    });
    u236:Add(task.spawn(function() -- Line: 5261
        -- upvalues: u242 (copy), DonChemical (copy)
        u242.Barou1.AnimationController.Animator:LoadAnimation(DonChemical.Animations.Lion):Play(0);
    end));
    coroutine.wrap(function() -- Line: 5266
        -- upvalues: u247 (copy), u237 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Step:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.glow3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end)();

    if v251.Name ~= "Dub" then
        u236:Add(dumb_yielding_function(0.193, function() -- Line: 5284
            -- upvalues: TekrinnDialogue (ref), u235 (copy)
            TekrinnDialogue.Speak(u235, {
                {
                    Text = "Feeding time, OK?",
                    Bold = false,
                    Italic = false,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(101, 60, 190)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            });
        end));
        u236:Add(dumb_yielding_function(2.325, function() -- Line: 5308
            -- upvalues: TekrinnDialogue (ref), u234 (copy)
            TekrinnDialogue.Speak(u234, {
                {
                    Text = "Don\'t stand in my way.",
                    Bold = false,
                    Italic = false,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            });
        end));
        u236:Add(dumb_yielding_function(5.017, function() -- Line: 5332
            -- upvalues: TekrinnDialogue (ref), u234 (copy)
            TekrinnDialogue.Speak(u234, {
                {
                    Text = "Or I\'ll kill you.",
                    Bold = false,
                    Italic = false,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            });
        end));
        u236:Add(dumb_yielding_function(9.044, function() -- Line: 5356
            -- upvalues: TekrinnDialogue (ref), u234 (copy)
            TekrinnDialogue.Speak(u234, {
                {
                    Text = "The king...",
                    Bold = true,
                    Italic = false,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            });
        end));
        u236:Add(dumb_yielding_function(10.756, function() -- Line: 5380
            -- upvalues: TekrinnDialogue (ref), u234 (copy)
            TekrinnDialogue.Speak(u234, {
                {
                    Text = "IS ME!",
                    Bold = true,
                    Italic = false,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 8,
                        Lifetime = 2
                    }
                }
            });
        end));
    end;

    u236:Add(dumb_yielding_function(0.27, function() -- Line: 5405
        -- upvalues: u247 (copy), u242 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Step:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in u242.LIONSHOTRAHHH:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(0.42, function() -- Line: 5417
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(1.3, function() -- Line: 5424
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Two:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(1.48, function() -- Line: 5431
        -- upvalues: u237 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.Transitionbarou:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(1.51, function() -- Line: 5440
        -- upvalues: u237 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.Transitionbarou:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(1.54, function() -- Line: 5449
        -- upvalues: u237 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.Transitionbarou:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(1.48, function() -- Line: 5458
        -- upvalues: u237 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.Transitionbarou:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(1.57, function() -- Line: 5467
        -- upvalues: u237 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.Transitionbarou:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(2, function() -- Line: 5476
        -- upvalues: u237 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.Transitionbarou:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(2.03, function() -- Line: 5485
        -- upvalues: u237 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.Transitionbarou:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(2.06, function() -- Line: 5494
        -- upvalues: u237 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.Transitionbarou:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(u237.CamPart.ScreenEffs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(u237.CamPart.glow3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(3.15, function() -- Line: 5513
        -- upvalues: u237 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.BarouEff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(3.21, function() -- Line: 5522
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Four:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(3.47, function() -- Line: 5529
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Five:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(4.39, function() -- Line: 5537
        -- upvalues: u237 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.BarouEff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(6.06, function() -- Line: 5546
        -- upvalues: u237 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.ScreenEffs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(6.42, function() -- Line: 5555
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Six:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(7.12, function() -- Line: 5562
        -- upvalues: u247 (copy), u237 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Seven:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u247.Ball.BallEffDribble:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.ScreenEffs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(7.24, function() -- Line: 5581
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Eight:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(7.36, function() -- Line: 5589
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Nine:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(7.51, function() -- Line: 5596
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Ten:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(8.08, function() -- Line: 5604
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Eleven:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(8.27, function() -- Line: 5611
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.Twelve:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(8.36, function() -- Line: 5618
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Ball.BallEffDribble:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(10.34, function() -- Line: 5625
        -- upvalues: u247 (copy)
        for _, descendant in pairs(u247.Barou.Head.EyeEff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(11.27, function() -- Line: 5632
        -- upvalues: u247 (copy), u237 (copy)
        for _, descendant in pairs(u247.Ball.BallKicking:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.glow3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(12.09, function() -- Line: 5646
        -- upvalues: u247 (copy), u237 (copy)
        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.FourteenStuff:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.FourteenStuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u247.Barou.Head.EyeEff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.glow3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(13.18, function() -- Line: 5671
        -- upvalues: u247 (copy), u242 (copy), u237 (copy)
        for _, descendant in pairs(u247.Ball.BallKicking:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u247.Ball.DoubleNutMeg:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.FourteenStuff:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u247.Barou.Head.EyeEff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.FifteenStuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u242.Barou1.baroulionlightningstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.glow3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end));
    u236:Add(dumb_yielding_function(15.06, function() -- Line: 5712
        -- upvalues: u237 (copy), u247 (copy), u242 (copy)
        if u237 and u237:FindFirstChild("CamPart") then
            for _, descendant in pairs(u237.CamPart.ScreenEffs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(u237.CamPart.glow3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end;

        for _, descendant in pairs(u247.Ball.DoubleNutMeg:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u247.Barou.Head.EyeEff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u247.Barou.HumanoidRootPart.CutsceneVFX.FifteenStuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u242.Barou1.baroulionlightningstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u236:Add(function() -- Line: 5751
        -- upvalues: u237 (copy), u238 (copy), mainreplication (ref), u239 (copy), Lighting (ref)
        if u237 and u237:FindFirstChild("CamPart") then
            u238();
        end;

        mainreplication.sceneEnabled(false);

        for _, v in u239 do
            pcall(function() -- Line: 5757
                -- upvalues: v (copy), Lighting (ref)
                v.Parent = Lighting;
            end);
        end;
    end);
    u236:Add(dumb_yielding_function(15.1, function() -- Line: 5763
        -- upvalues: u236 (copy)
        u236:Destroy();
    end));
    local v252 = u236:Construct(MoonPropertyAnimator);
    v252:LoadSave(DonChemical.Moon, MoonPropertyAnimator.ConvertSave(DonChemical.Moon, u247));
    v252:SetOriginalRoot(DonChemical.OG.Value);
    v252:SetRoot(Root);
    u236:Add(RunService2.PreRender:Connect(function() -- Line: 5772
        -- upvalues: u242 (copy), Root (copy)
        u242:PivotTo(Root.CFrame);
    end));
    v252:PlayAll();
end;

return v1;