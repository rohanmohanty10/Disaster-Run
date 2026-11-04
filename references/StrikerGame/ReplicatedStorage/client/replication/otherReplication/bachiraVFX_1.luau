 
 

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
local u1 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local Brightness = Lighting.Brightness;
local _ = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local ExposureCompensation = Lighting.ExposureCompensation;
local Threshold = Lighting.Bloom.Threshold;
local EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale;
local EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local Threshold2 = Lighting.Bloom.Threshold;
local MeshEmitter = require(script.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local Util = require(ReplicatedStorage.util.Util);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local styles = require(ReplicatedStorage.wiki).styles;
local VfxHandler = require(ReplicatedStorage.VfxHandler);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);

function u1.characterImage(p2) -- Line: 50
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p2);
end;

function u1.bachira_overtime(u3) -- Line: 52
    -- upvalues: vfxUtil (copy), KatUtil (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), TekrinnDialogue (copy), ReplicatedStorage (copy)
    local Overtime = vfxUtil.getResources().bachira.Overtime;
    local Root = vfxUtil.getRoot(u3);
    local _track = KatUtil.get_track(u3, Overtime.Animation);
    local Ball = u3:FindFirstChild("Ball");
    local u4 = soundUtil:play(Overtime.Sound, SoundService, {
        Character = u3
    }).Name == "Dub";

    if not _track then
        return;
    end;

    if Ball then
        Ball.Size = Vector3.new(1.5, 1.5, 1.5);
    end;

    local v5, v6 = mainreplication.cutsceneAll(Root, CFrame.identity, 27.283333333333335, Overtime.FOV);
    local u7 = _track.add(vfxUtil.createVFX(Overtime.Ball, "default", u3:FindFirstChild("Ball")));
    local u8 = {};
    local u9 = {};
    local u10 = {};

    for _, child in Overtime.CameraVFX:GetChildren() do
        local v11 = _track.clone(child);
        v11.Parent = v5;
        u8[child.Name] = v11;
    end;

    for _, child in Overtime.Body:GetChildren() do
        local v12 = vfxUtil.createVFX(child, "default", u3:FindFirstChild(child.Name));
        u9[child.Name] = v12;
    end;

    local v13 = _track.add(Instance.new("Weld"));
    v13.Parent = v5;
    v13.Part0 = v5;
    v13.Part1 = u8.CamTrans;
    v13.C0 = CFrame.new(
        -0.000518798828,
        0.0380764008,
        -0.311965942,
        -1.00000346,
        1.08964741e-6,
        -0.000950872898,
        1.60187483e-7,
        1.00000155,
        0.00086363405,
        0.000950038433,
        0.000863462687,
        -1
    );
    mainreplication.sceneEnabled(true);
    vfxUtil.forge.emit(u7["Ground Gusts"], u7.Floor, u7.Dust2, u7.Debris, u7.Attachment, u7:FindFirstChild("Attachment"), u7:FindFirstChild("Attachment"));
    _track.add(v6);
    _track.add(v5);
    _track.add(function() -- Line: 101
        -- upvalues: mainreplication (ref), Ball (copy), u10 (copy), u3 (copy)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1);

        if Ball then
            Ball.Size = Vector3.new(1.95, 1.95, 1.95);
        end;

        for _, v in u10 do
            v.Parent = u3;
        end;

        table.clear(u10);
    end);
    _track.sequence({
        [33] = function(p14) -- Line: 114
            -- upvalues: vfxUtil (ref), u9 (copy), u8 (copy)
            vfxUtil.forge.emit(u9.Head.Bachiraeyes1, u9.Head.Bachiraeyes2, u8.nagistrongglare.White);
        end,

        [70.19999999999999] = function() -- Line: 118
            -- upvalues: TekrinnDialogue (ref), u3 (copy)
            TekrinnDialogue.Speak(u3, {
                {
                    Text = "How long has it been?",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 1.4);
        end,

        [195] = function() -- Line: 132
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "I\'d forgotten how to play with ",
                    TypeSpeed = 0.025,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = "freedom ",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 204, 0)) })
                },
                {
                    Text = ", but this is my starting point.",
                    TypeSpeed = 0.025,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 6);
        end,

        [198] = function() -- Line: 163
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if not u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "Since I played freely ",
                    TypeSpeed = 0.06,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 1.6);
        end,

        [303.59999999999997] = function() -- Line: 178
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if not u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "When I found you, my beginning",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 1.9);
        end,

        [483.00000000000006] = function() -- Line: 193
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if not u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "That\'s right.. ",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = "even when I was alone ",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 2
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = "i was still having fun!",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 2
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3.4);
        end,

        [730.8] = function() -- Line: 227
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if not u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "I would run around until it got dark!",
                    TypeSpeed = 0.06,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 2.6);
        end,

        [908.4000000000001] = function() -- Line: 242
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if not u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "It\'s the same as back then",
                    TypeSpeed = 0.06,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 1.9);
        end,

        [1029.6] = function() -- Line: 257
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if not u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "The only thing that matters to me ",
                    TypeSpeed = 0.04,
                    Italic = true,
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 2
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = "is being one with the ball!",
                    TypeSpeed = 0.04,
                    Italic = true,
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 2
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 2.8);
        end,

        [1212.6000000000001] = function() -- Line: 282
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if not u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "I don\'t need any other reason to play besides that!",
                    TypeSpeed = 0.04,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 2.6);
        end,

        [1392.6000000000001] = function() -- Line: 297
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if not u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "In my eyes, there\'s nothing more fun than this!",
                    TypeSpeed = 0.04,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 2.4);
        end,

        [1572] = function() -- Line: 312
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if not u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "Not in this world, ",
                    TypeSpeed = 0.02,
                    Italic = true,
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 2
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = "not in the whole universe!",
                    TypeSpeed = 0.02,
                    Italic = true,
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 2
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 1.1);
        end,

        [339] = function() -- Line: 337
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "Even ",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = "alone",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 204, 0)) })
                },
                {
                    Text = ", I had so much fun.",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 5);
        end,

        [705] = function() -- Line: 368
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "I\'ll ",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = "fight.",
                    TypeSpeed = 0.075,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 204, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 0.35
                    }
                }
            }, 5);
        end,

        [831] = function() -- Line: 397
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "I\'ll lose myself in this ",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = "passion ",
                    TypeSpeed = 0.05,
                    Bold = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 204, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 0.4
                    }
                },
                {
                    Text = "that burns inside me!",
                    TypeSpeed = 0.05,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 5);
        end,

        [1098] = function() -- Line: 434
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "Being one with the ball is all there is for me.",
                    TypeSpeed = 0.06,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 2);
        end,

        [1272] = function() -- Line: 449
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "I don\'t need any other reason to play soccer.",
                    TypeSpeed = 0.06,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 2);
        end,

        [1488.6] = function() -- Line: 464
            -- upvalues: u4 (copy), TekrinnDialogue (ref), u3 (copy)
            if u4 then
                return;
            end;

            TekrinnDialogue.Speak(u3, {
                {
                    Text = "There\'s nothing more fun than this in the whole ",
                    TypeSpeed = 0.03,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = "universe!",
                    TypeSpeed = 0.03,
                    Bold = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 204, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 0.4
                    }
                }
            }, 2);
        end,

        [300] = function(p15) -- Line: 493
            -- upvalues: _track (copy), Overtime (copy), Root (copy), vfxUtil (ref)
            local v16 = _track.clone(Overtime.Jump);
            v16.Parent = workspace.Effects;
            v16:PivotTo(Root.CFrame * CFrame.new(
                -0.0947828293,
                -1.22633564,
                -0.826904297,
                0.981642723,
                0.160412446,
                0.103203833,
                0.170537695,
                -0.980451047,
                -0.0981675312,
                0.0854389369,
                0.113965191,
                -0.989804864
            ));
            vfxUtil.forge.emit(v16);
            vfxUtil.disposal(v16, 10);
        end,

        [430] = function(p17) -- Line: 502
            -- upvalues: vfxUtil (ref), u8 (copy)
            vfxUtil.forge.emit(u8.CamTrans);
        end,

        [480] = function() -- Line: 506
        end,

        [436] = function(p18) -- Line: 509
            -- upvalues: _track (copy), Overtime (copy), Root (copy), vfxUtil (ref)
            local v19 = _track.clone(Overtime["Mesh stuff"]);
            v19.Parent = workspace.Effects;
            v19:PivotTo(Root.CFrame * CFrame.new(
                -0.680593491,
                2.51700497,
                1.53812408,
                1,
                0,
                -1.13686838e-13,
                0,
                1,
                2.20281448e-13,
                -1.13686838e-13,
                2.20281448e-13,
                1
            ));
            vfxUtil.forge.emit(v19);
            vfxUtil.disposal(v19, 15);
        end,

        [437] = function(p20) -- Line: 518
            -- upvalues: _track (copy), Overtime (copy), Root (copy), KatUtil (ref), ReplicatedStorage (ref), u3 (copy), u10 (copy)
            local v21 = _track.clone(Overtime.Domain);
            v21.Parent = workspace.Effects;
            v21.CFrame = Root.CFrame * CFrame.new(
                -1.49347305,
                6.27023411,
                4.99337006,
                1.13686838e-13,
                0,
                1,
                -2.20281448e-13,
                1,
                0,
                -1,
                2.20281448e-13,
                -1.13686838e-13
            );
            KatUtil.frame_delay(674 - p20, v21.Destroy, v21);

            for _, child in ReplicatedStorage.Resources.bachira.clothes:GetChildren() do
                if u3:FindFirstChildWhichIsA(child.ClassName) then
                    local v22 = u3:FindFirstChildWhichIsA(child.ClassName);
                    table.insert(u10, v22);
                    v22.Parent = nil;
                end;

                _track.clone(child).Parent = u3;
            end;
        end,

        [678] = function(p23) -- Line: 536
            -- upvalues: _track (copy), Overtime (copy), Root (copy), vfxUtil (ref)
            local v24 = _track.clone(Overtime["Impact Meshes2"]);
            v24.Parent = workspace.Effects;
            v24:PivotTo(Root.CFrame * CFrame.new(
                0.151546478,
                1.06450272,
                0.956569672,
                -0.104528457,
                -1.09813058e-13,
                0.994521916,
                0.96063453,
                0.258819044,
                0.100966752,
                -0.257401168,
                0.965925872,
                -0.0270539559
            ));
            vfxUtil.forge.emit(v24);
            vfxUtil.disposal(v24, 15);
        end,

        [693] = function(p25) -- Line: 545
            -- upvalues: _track (copy), Overtime (copy), Root (copy), vfxUtil (ref), u10 (copy), u3 (copy)
            local v26 = _track.clone(Overtime["Impact Meshes"]);
            v26.Parent = workspace.Effects;
            v26:PivotTo(Root.CFrame * CFrame.new(
                -1.11888695,
                0.781230927,
                -2.54387283,
                1.12287011e-13,
                -1.77845257e-14,
                1,
                0.156434312,
                0.987686992,
                0,
                -0.987686992,
                0.156434342,
                -1.13686838e-13
            ));
            vfxUtil.forge.emit(v26);
            vfxUtil.disposal(v26, 15);

            for _, v in u10 do
                v.Parent = u3;
            end;

            table.clear(u10);
        end,

        [828] = function(p27) -- Line: 559
            -- upvalues: vfxUtil (ref), u9 (copy)
            vfxUtil.forge.emit(u9.Head.Bachiraeyes1, u9.Head.Bachiraeyes2);
        end,

        [1267] = function(p28) -- Line: 563
            -- upvalues: vfxUtil (ref), u7 (copy)
            vfxUtil.forge.emit(u7["Ground Gusts"], u7.Floor, u7.Dust2, u7.Debris, u7.Attachment, u7:FindFirstChild("Attachment"), u7:FindFirstChild("Attachment"));
        end,

        [1459] = function(p29) -- Line: 567
            -- upvalues: u9 (copy), vfxUtil (ref)
            for _, v in u9 do
                vfxUtil.forge.emit(v);
            end;
        end
    });
end;

function u1.bachiracontrolwindup(u30, p31) -- Line: 575
    -- upvalues: ReplicatedStorage (copy), Players (copy), mainreplication (copy), RunService (copy)
    local u32 = u30.HumanoidRootPart or u30.PrimaryPart;
    local _ = u30.Torso;
    local u33 = ReplicatedStorage.Resources.armdrip:Clone();
    u33.Parent = u30;
    u33.Weld.Part0 = u30["Left Arm"];
    local u34 = ReplicatedStorage.Resources.armdrip:Clone();
    u34.Parent = u30;
    u34.Weld.Part0 = u30["Right Arm"];
    task.delay(0.35, function() -- Line: 589
        -- upvalues: u33 (copy), u34 (copy)
        for _, descendant in ipairs(u33:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u34:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u33.Destroy, u33);
        task.delay(2, u34.Destroy, u34);
    end);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u30) then
        mainreplication.springcamerashake(40, 30);
    end;

    local u35 = mainreplication.bodyVelocity(u32, 1, 0.35, nil, nil, true);

    if u35 then
        u35.MaxForce = Vector3.new(300000, 300000, 300000);
        local u36 = nil;
        local u37 = u30:GetAttribute("RinNoPlay") and not p31 and 200 or 100;
        u36 = RunService.RenderStepped:Connect(function(p38) -- Line: 616
            -- upvalues: u35 (copy), u36 (ref), u30 (copy), u32 (copy), u37 (ref)
            if not (u35 and u35:IsDescendantOf(game)) then
                u36:Disconnect();

                return;
            end;

            local MoveDirection = u30.Humanoid.MoveDirection;
            local LookVector = u32.CFrame.LookVector;

            if MoveDirection.Magnitude > 0 then
                LookVector = (LookVector * 0.7 + MoveDirection.Unit * 0.5).Unit;
            end;

            u35.Velocity = LookVector * u37 + u32.CFrame.UpVector * 30;
        end);
        task.delay(15, u36.Disconnect, u36);
    end;

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u30) then
        return;
    end;

    mainreplication.cameraShake(15, 0.7, 4);
    mainreplication.fov(false, 90);
    mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.bachiracontrol(p39) -- Line: 643
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage (copy), RunService (copy), MeshEmitter (copy), Lighting (copy), TweenService (copy)
    local u40 = p39.HumanoidRootPart or p39.PrimaryPart;
    local _ = p39.Torso;
    local Ball = p39:FindFirstChild("Ball");

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p39) then
        mainreplication.springcamerashake(15, 60);
    end;

    mainreplication.fov(false, 50);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    mainreplication.cameraShake(35, 1.5, 6);

    if Ball then
        local v41 = ReplicatedStorage.Resources.controlBall:Clone();
        v41.Weld.Part0 = Ball;
        v41.Parent = Ball;
        task.delay(1, v41.Destroy, v41);

        for _, descendant in ipairs(v41:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if descendant.Parent == v41.Emit then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                else
                    descendant.Enabled = true;
                end;
            end;
        end;
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p39) then
        local u42, u43 = mainreplication.bodyVelocity(u40, 60, 0.84, nil, nil, true, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
        u42.MaxForce = Vector3.new(300000, 300000, 300000);
        local u44 = nil;
        u44 = RunService.RenderStepped:Connect(function(p45) -- Line: 677
            -- upvalues: u42 (copy), u44 (ref), u40 (copy), u43 (copy)
            if u42 and u42:IsDescendantOf(game) then
                u42.Velocity = u40.CFrame.LookVector * 20 + u40.CFrame.UpVector * u43.Value;

                return;
            end;

            u44:Disconnect();
        end);
        task.delay(15, u44.Disconnect, u44);
    end;

    task.wait(0.85);
    MeshEmitter.StartMeshEmitter(u40, ReplicatedStorage.Resources.bachira.beeshottomesh);
    local u46 = ReplicatedStorage.Resources.bachira.beeshotto:Clone();
    u46.Weld.Part0 = u40;
    u46.Parent = p39;
    task.delay(5, function() -- Line: 695
        -- upvalues: u46 (copy)
        u46:Destroy();
    end);
    task.spawn(function() -- Line: 699
        -- upvalues: u46 (copy)
        for _, descendant in pairs(u46.bachirabeeshotwindvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u46.bachirabeeshotshootingemitvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u46.bachirabeeshotwindvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);

    if Players:GetPlayerFromCharacter(p39) == Players.LocalPlayer then
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        local v47 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v47.Parent = Lighting;
        v47.TintColor = Color3.fromRGB(255, 225, 0);
        v47.Brightness = 0.4;
        v47.Contrast = 1;
        v47.Saturation = -0.4;
        TweenService:Create(v47, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v47, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v47.Destroy, v47);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(35, 1.5, 6);
    end;

    local u48, u49 = mainreplication.bodyVelocity(u40, 95, 0.15, nil, nil, true, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
    u48.MaxForce = Vector3.new(300000, 300000, 300000);
    local u50 = nil;
    u50 = RunService.RenderStepped:Connect(function(p51) -- Line: 748
        -- upvalues: u48 (copy), u50 (ref), u40 (copy), u49 (copy)
        if u48 and u48:IsDescendantOf(game) then
            u48.Velocity = u40.CFrame.UpVector * u49.Value + u40.CFrame.LookVector * -u49.Value;

            return;
        end;

        u50:Disconnect();
    end);
    task.delay(1, u50.Disconnect, u50);
end;

function u1.monsterTranceBaseStartup(p52) -- Line: 758
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), mainreplication (copy), Lighting (copy), TweenService (copy)
    local v53 = p52.HumanoidRootPart or p52.PrimaryPart;
    task.wait(0.3);
    local v54 = ReplicatedStorage.Resources.bachira.startupMonstertrance:Clone();
    v54:PivotTo(v53.CFrame);
    v54.Parent = p52;

    if Util.canshiftcolor(LocalPlayer, p52) then
        vfxUtil.LeanTowardsColor(v54, p52:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p52:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(v54.bachiramonstertrancestartup1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(3, v54.Destroy, v54);
    mainreplication.cameraShake(20, 1, 4);
    mainreplication.fov(false, 60);
    mainreplication.fov(true, 70, 0.85, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.15, BlurEffect.Destroy, BlurEffect);
    local v55 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v55.Parent = Lighting;
    v55.TintColor = Color3.fromRGB(255, 200, 0);
    v55.Brightness = 0.4;
    v55.Contrast = 1;
    v55.Saturation = -0.4;
    TweenService:Create(v55, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(0.5, v55.Destroy, v55);
end;

function u1.monsterTranceBaseEndlagYa(p56) -- Line: 801
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), mainreplication (copy), TweenService (copy), Lighting (copy)
    local u57 = p56.HumanoidRootPart or p56.PrimaryPart;
    local u58 = ReplicatedStorage.Resources.bachira.monsterTranceBaseEndlag:Clone();
    u58:PivotTo(u57.CFrame);
    u58.Parent = p56;

    if Util.canshiftcolor(LocalPlayer, p56) then
        vfxUtil.LeanTowardsColor(u58, p56:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p56:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.delay(3, u58.Destroy, u58);
    local u59 = RunService.PreRender:connect(function() -- Line: 814
        -- upvalues: u58 (copy), u57 (copy)
        u58:PivotTo(u57.CFrame);
    end);
    u58.AncestryChanged:Once(function() -- Line: 817
        -- upvalues: u59 (copy)
        u59:Disconnect();
    end);
    task.delay(0.2833333333333333, function() -- Line: 821
        -- upvalues: u58 (copy)
        for _, descendant in pairs(u58.ballhit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.3, function() -- Line: 828
        -- upvalues: u58 (copy)
        for _, descendant in pairs(u58.ballslam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.317, function() -- Line: 835
        -- upvalues: mainreplication (ref), u57 (copy), TweenService (ref), u58 (copy), Lighting (ref), ReplicatedStorage (ref)
        mainreplication.bodyVelocity(u57, 200, 0.9, nil, nil, nil, TweenInfo.new(1.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));
        mainreplication.cameraShake(20, 2, 7);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        local u60 = TweenService;
        local windbachira = u58.windbachira;
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Parent = windbachira;
        NumberValue.Value = 1;
        local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(1, 1) });
        u60:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
        task.spawn(function() -- Line: 858
            -- upvalues: windbachira (copy), NumberSequence_new_ret (copy), u60 (copy), NumberValue (copy)
            for _, descendant in pairs(windbachira:GetDescendants()) do
                task.spawn(function() -- Line: 860
                    -- upvalues: descendant (copy), NumberSequence_new_ret (ref), u60 (ref), NumberValue (ref)
                    if descendant:IsA("Beam") then
                        descendant.Enabled = true;
                        descendant.Transparency = NumberSequence_new_ret;
                        descendant.TextureSpeed = 7;
                        u60:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            TextureSpeed = 0.01
                        }):Play();
                        NumberValue.Changed:Connect(function() -- Line: 868
                            -- upvalues: descendant (ref), NumberValue (ref)
                            task.spawn(function() -- Line: 869
                                -- upvalues: descendant (ref), NumberValue (ref)
                                descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                            end);
                        end);
                        task.delay(0.24966666666666665, function() -- Line: 877
                            -- upvalues: NumberValue (ref), descendant (ref)
                            NumberValue.Changed:Connect(function() -- Line: 878
                                -- upvalues: descendant (ref), NumberValue (ref)
                                task.spawn(function() -- Line: 879
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                                end);
                            end);
                            task.wait(1);
                            descendant.Enabled = false;
                            NumberValue:Destroy();
                        end);
                    end;
                end);
            end;
        end);
        task.delay(0.24966666666666665, function() -- Line: 895
            -- upvalues: u60 (copy), NumberValue (copy)
            u60:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 1
            }):Play();
        end);
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.15, BlurEffect.Destroy, BlurEffect);
        local v61 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v61.Parent = Lighting;
        v61.TintColor = Color3.fromRGB(255, 200, 0);
        v61.Brightness = 0.4;
        v61.Contrast = 1;
        v61.Saturation = -0.4;
        TweenService:Create(v61, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(0.5, v61.Destroy, v61);
    end);
    task.delay(0.36633333333333334, function() -- Line: 916
        -- upvalues: u58 (copy)
        for _, descendant in pairs(u58.runenabled:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        wait(0.7);

        for _, descendant in pairs(u58.runenabled:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.4, function() -- Line: 932
        wait(0.7);
    end);
    task.delay(0.48333333333333334, function() -- Line: 948
        -- upvalues: u58 (copy)
        for _, descendant in pairs(u58.run1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.6833333333333333, function() -- Line: 955
        -- upvalues: u58 (copy)
        for _, descendant in pairs(u58.run2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.85, function() -- Line: 962
        -- upvalues: u58 (copy)
        for _, descendant in pairs(u58.run3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.0666666666666667, function() -- Line: 969
        -- upvalues: u58 (copy)
        for _, descendant in pairs(u58.run4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
end;

function u1.beeShot(u62) -- Line: 978
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), PlayerGui (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy), animationUtil (copy), RunService (copy), TekrinnDialogue (copy), TweenService (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), Density (copy), Color (copy)
    local v63 = u62.HumanoidRootPart or u62.PrimaryPart;
    local Ball = u62:FindFirstChild("Ball");
    local _ = u62.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local u64 = ReplicatedStorage.Resources.vb:Clone();
    u64.Parent = PlayerGui;
    local u65 = ReplicatedStorage.Resources.glowscreen:Clone();
    u65.Parent = PlayerGui;
    u65.ImageLabel2.ImageTransparency = 0;
    u65.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 2;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 2.627;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.55;
    ColorCorrectionEffect.Saturation = -0.4;
    local u66 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u66.Parent = Lighting;
    u66.FarIntensity = 1;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1, 1, true);
    local u67 = Util.Preload(ReplicatedStorage.Resources.bachira.ImpactFrameBee);
    local u68 = ReplicatedStorage.Resources.bachira.beeshotEffect:Clone();
    u68:PivotTo(v63.CFrame);
    u68.Parent = u62;

    if Util.canshiftcolor(LocalPlayer, u62) then
        vfxUtil.LeanTowardsColor(u68, u62:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u62:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u69 = soundUtil:play(ReplicatedStorage.Resources.bachira["bachira beeshot_1"], SoundService, {
        Character = u62
    });
    local v70 = u69.Name == "Dub";
    animationUtil:loadAnimation(u68.buzzbuzz, ReplicatedStorage.Resources.bachira.beeshotBee):Play(0);
    animationUtil:loadAnimation(u68.Bachiramonsterrrrrrrrrrrr, ReplicatedStorage.Resources.bachira.beeshotMonster):Play(0);
    mainreplication.cutsceneBlender(v63, ReplicatedStorage.Resources.bachira.beeshotCam, ReplicatedStorage.Resources.bachira.beeshotFOV);
    local u71 = ReplicatedStorage.Resources.bachira.beeShotCamEffect:Clone();
    u71.Parent = u68;
    local u72 = nil;
    u72 = RunService.PreRender:connect(function() -- Line: 1032
        -- upvalues: u71 (copy), u72 (ref)
        if u71:IsDescendantOf(game) then
            u71.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u72:Disconnect();
    end);
    local u73 = ReplicatedStorage.Resources.bachira.beeShotBall:Clone();
    u73.Weld.Part0 = Ball;
    u73.Parent = u68;
    local u74 = ReplicatedStorage.Resources.bachira.beeShotEye:Clone();
    u74.Weld.Part0 = u62.Head;
    u74.Parent = u68;
    u68.bachirabeeshotdomain.Color = Color3.fromRGB(0, 0, 0);
    task.delay(0.05, function() -- Line: 1047
        -- upvalues: TekrinnDialogue (ref), u62 (copy), u69 (copy)
        TekrinnDialogue.Speak(u62, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Text = u69 and u69.Name == "Dub" and "What is my ego..." or "My ego...",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 191, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3);
    end);

    if not v70 then
        task.delay(2.017, function() -- Line: 1074
            -- upvalues: TekrinnDialogue (ref), u62 (copy)
            TekrinnDialogue.Speak(u62, {
                {
                    Text = "What is it...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 183, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 3);
        end);
    end;

    task.delay(3.083, function() -- Line: 1101
        -- upvalues: TekrinnDialogue (ref), u62 (copy)
        TekrinnDialogue.Speak(u62, {
            {
                Text = "Stop distracting me!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 179, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3);
    end);
    task.delay(5.433, function() -- Line: 1127
        -- upvalues: TekrinnDialogue (ref), u62 (copy), u69 (copy)
        TekrinnDialogue.Speak(u62, {
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Text = u69 and u69.Name == "Dub" and "You little insects!" or "You pieces of crappawappa!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 179, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            }
        }, 1);
    end);
    task.delay(8, function() -- Line: 1153
        -- upvalues: TekrinnDialogue (ref), u62 (copy), u69 (copy)
        TekrinnDialogue.Speak(u62, {
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Text = u69 and u69.Name == "Dub" and "Boom!" or "Bon!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 179, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 5
                }
            }
        }, 1);
    end);
    task.spawn(function() -- Line: 1179
        -- upvalues: u68 (copy)
        for _, descendant in pairs(u68.beeshotaura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u68.beeshotaura:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.25, function() -- Line: 1204
        -- upvalues: u74 (copy)
        for _, descendant in pairs(u74.bachirabeeshotlefteye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u74.bachirabeeshotlefteyerighteye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    local u75 = {};
    task.delay(2.9833333333333334, function() -- Line: 1221
        -- upvalues: u68 (copy), u62 (copy), ReplicatedStorage (ref), u75 (copy), u71 (copy)
        u68.bachirabeeshotdomain.Color = Color3.fromRGB(255, 255, 255);

        for _, descendant in pairs(u68.bachirabeeshotstepemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, child in ipairs(u62:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v76 = child;

                for _, descendant in ipairs(ReplicatedStorage.Resources.bachira.beeshotTrail:GetDescendants()) do
                    local v77 = descendant:Clone();
                    v77.Parent = v76;
                    table.insert(u75, v77);
                end;
            end;
        end;

        for _, descendant in pairs(u71:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u71.bachirabeeshotlineeffects1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3, function() -- Line: 1256
        -- upvalues: u68 (copy)
        for _, descendant in pairs(u68.beeshotaura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u68.beeshotaura:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.3666666666666667, function() -- Line: 1269
        -- upvalues: u68 (copy)
        for _, descendant in pairs(u68.bachirabeeshotstepemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.4166666666666665, function() -- Line: 1277
        -- upvalues: u71 (copy)
        for _, descendant in pairs(u71.transitionbeeshot:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.6, function() -- Line: 1285
        -- upvalues: u71 (copy)
        for _, descendant in pairs(u71.transitionbeeshot:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.6666666666666665, function() -- Line: 1293
        -- upvalues: u68 (copy)
        for _, descendant in pairs(u68.bachirabeeshotshitjumpemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.5;
            end;
        end;
    end);
    task.delay(3.8, function() -- Line: 1301
        -- upvalues: u62 (copy), ReplicatedStorage (ref), u75 (copy)
        for _, child in ipairs(u62:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v78 = child;

                for _, descendant in ipairs(ReplicatedStorage.Resources.bachira.beeshotAura:GetDescendants()) do
                    local v79 = descendant:Clone();
                    v79.Parent = v78;
                    table.insert(u75, v79);
                end;
            end;
        end;
    end);
    task.delay(4.266666666666667, function() -- Line: 1315
        -- upvalues: u68 (copy)
        for _, descendant in pairs(u68.bachirabeeshotshitjumpemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(4.283333333333333, function() -- Line: 1323
        -- upvalues: u75 (copy), u73 (copy)
        for _, v in u75 do
            if v:IsA("Trail") then
                v.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u73:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.333, function() -- Line: 1335
        -- upvalues: TweenService (ref), u68 (copy)
        TweenService:Create(u68.buzzbuzz.bachirabeeshothighlight, TweenInfo.new(1), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end);
    task.delay(4.633333333333334, function() -- Line: 1338
        -- upvalues: u68 (copy)
        for _, descendant in pairs(u68.bachirabeebeeshotlines1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u68.bachirabeebeeshotlines2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.083, function() -- Line: 1352
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.bachira.ImpactFrameBee, 35);
    end);
    task.delay(6.183333333333334, function() -- Line: 1355
        -- upvalues: u68 (copy)
        for _, descendant in pairs(u68.bachirabeebeeshotlines1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u68.bachirabeebeeshotlines2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(6.2, function() -- Line: 1369
        -- upvalues: u68 (copy), u75 (copy)
        for _, descendant in pairs(u68.bachirabeeshotshitemit2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, v in u75 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;
    end);
    task.delay(6.216666666666667, function() -- Line: 1382
        -- upvalues: u68 (copy)
        for _, descendant in pairs(u68.bachirabeeshotlines:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.233, function() -- Line: 1390
        -- upvalues: u68 (copy)
        u68.bachirabeeshotdomain.Transparency = 1;
    end);
    task.delay(6.883333333333334, function() -- Line: 1393
        -- upvalues: u68 (copy)
        for _, descendant in pairs(u68.bachirabeeshotlines:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(6.9, function() -- Line: 1401
        -- upvalues: u75 (copy)
        for _, v in u75 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end);
    task.delay(7.216666666666667, function() -- Line: 1408
        -- upvalues: u68 (copy), u75 (copy)
        for _, descendant in pairs(u68.bachirabeeshotshitemit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, v in u75 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;
    end);
    task.delay(7.733333333333333, function() -- Line: 1421
        -- upvalues: u68 (copy), u75 (copy)
        for _, descendant in pairs(u68.bachirabeeshotshitemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, v in u75 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end);
    task.delay(7.933333333333334, function() -- Line: 1434
        -- upvalues: u68 (copy)
        for _, descendant in pairs(u68.bachirabeeshotshitemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.35;
            end;
        end;
    end);
    task.delay(8.633333333333333, function() -- Line: 1454
        -- upvalues: u71 (copy)
        for _, descendant in pairs(u71:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u71.bachirabeeshotlineeffects1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(8.65, function() -- Line: 1467
        -- upvalues: u68 (copy), u75 (copy), u73 (copy)
        for _, descendant in pairs(u68.bachirabeeshotshitemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, v in u75 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u73:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.delay(8.65, function() -- Line: 1488
        -- upvalues: ScreenDimmer (copy), u67 (copy), u66 (copy), u75 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Atmosphere (copy), Density (ref), Color (ref), ColorCorrectionEffect (copy), u68 (copy), mainreplication (ref), u64 (copy), u65 (copy)
        ScreenDimmer:Destroy();
        u67:Destroy();
        u66:Destroy();

        for _, v in u75 do
            v:Destroy();
        end;

        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;

        if ColorCorrectionEffect then
            ColorCorrectionEffect:Destroy();
        end;

        u68:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1, true);
        u64:Destroy();
        u65:Destroy();
    end);
end;

function u1.monsterTrance(u80) -- Line: 1531
    -- upvalues: Lighting (copy), vfxUtil (copy), ReplicatedStorage (copy), PlayerGui (copy), mainreplication (copy), Util (copy), soundUtil (copy), SoundService (copy), RunService (copy), LocalPlayer (copy), TekrinnDialogue (copy), TweenService (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), EnvironmentDiffuseScale (copy), EnvironmentSpecularScale (copy), Density (copy), Color (copy)
    local v81 = u80.HumanoidRootPart or u80.PrimaryPart;
    local Ball = u80:FindFirstChild("Ball");
    local _ = u80.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local u82 = ReplicatedStorage.Resources.vb:Clone();
    u82.Parent = PlayerGui;
    local u83 = ReplicatedStorage.Resources.glowscreen:Clone();
    u83.Parent = PlayerGui;
    u83.ImageLabel2.ImageTransparency = 0;
    u83.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 2;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 2.627;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.55;
    ColorCorrectionEffect.Saturation = -0.4;
    local u84 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u84.Parent = Lighting;
    u84.FarIntensity = 1;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1, 1, true);
    local u85 = Util.Preload(ReplicatedStorage.Resources.bachira.monsterTranceImpactFrame);
    local u86 = ReplicatedStorage.Resources.bachira.monsterTranceEffect:Clone();
    u86:PivotTo(v81.CFrame);
    u86.Parent = u80;
    local v87 = soundUtil:play(ReplicatedStorage.Resources.bachira["monster tranceSFX"], SoundService, {
        Character = u80
    }).Name == "Dub";
    mainreplication.cutsceneBlender(v81, ReplicatedStorage.Resources.bachira.monsterTranceCam, ReplicatedStorage.Resources.bachira.monsterTranceFOV);
    local u88 = ReplicatedStorage.Resources.bachira.monsterTranceCamEffect:Clone();
    u88.Parent = u86;
    local u89 = nil;
    u89 = RunService.PreRender:connect(function() -- Line: 1582
        -- upvalues: u88 (copy), u89 (ref)
        if u88:IsDescendantOf(game) then
            u88.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u89:Disconnect();
    end);
    local u90 = ReplicatedStorage.Resources.bachira.monsterTranceBall:Clone();
    u90.Weld.Part0 = Ball;
    u90.Parent = u86;
    local u91 = ReplicatedStorage.Resources.bachira.eyeBachira:Clone();
    u91.Weld.Part0 = u80.Head;
    u91.Parent = u86;

    if Util.canshiftcolor(LocalPlayer, u80) then
        vfxUtil.LeanTowardsColor(u86, u80:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u80:GetAttribute("CustomAlpha") or 0.985);
    end;

    if v87 then
        task.delay(0.0167, function() -- Line: 1600
            -- upvalues: TekrinnDialogue (ref), u80 (copy)
            TekrinnDialogue.Speak(u80, {
                {
                    Text = "Yep...",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 1.5);
        end);
    end;

    if v87 then
        task.delay(2.1333, function() -- Line: 1628
            -- upvalues: TekrinnDialogue (ref), u80 (copy)
            TekrinnDialogue.Speak(u80, {
                {
                    Text = "Or so you thought...",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
    end;

    if not v87 then
        task.delay(3.083, function() -- Line: 1656
            -- upvalues: TekrinnDialogue (ref), u80 (copy)
            TekrinnDialogue.Speak(u80, {
                {
                    Text = "what you think.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 179, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
    end;

    task.delay(5.45, function() -- Line: 1683
        -- upvalues: TekrinnDialogue (ref), u80 (copy)
        TekrinnDialogue.Speak(u80, {
            {
                Text = "Smash!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 179, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end);
    task.delay(7.4, function() -- Line: 1704
        -- upvalues: TekrinnDialogue (ref), u80 (copy)
        TekrinnDialogue.Speak(u80, {
            {
                Text = "Monster Lift!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 179, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end);

    if v87 then
        task.delay(9.1833, function() -- Line: 1731
            -- upvalues: TekrinnDialogue (ref), u80 (copy)
            TekrinnDialogue.Speak(u80, {
                {
                    Text = "This is it, I put all my focus on overcoming my challenge.",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3.3);
        end);
    end;

    if not v87 then
        task.delay(10.25, function() -- Line: 1759
            -- upvalues: TekrinnDialogue (ref), u80 (copy)
            TekrinnDialogue.Speak(u80, {
                {
                    Text = "This is me concentrating on a daring challenge.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 179, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3);
        end);
    end;

    task.delay(14.65, function() -- Line: 1786
        -- upvalues: TekrinnDialogue (ref), u80 (copy)
        TekrinnDialogue.Speak(u80, {
            {
                Text = "My Monster Trance!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 179, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end);
    task.delay(v87 and 18.89 or 18.97, function() -- Line: 1812
        -- upvalues: TekrinnDialogue (ref), u80 (copy)
        TekrinnDialogue.Speak(u80, {
            {
                Text = "Boom.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 179, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end);
    task.delay(0.25, function() -- Line: 1833
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancesstartwind:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.26666666666666666, function() -- Line: 1841
        -- upvalues: u86 (copy), u88 (copy)
        for _, descendant in pairs(u86.bachiramonstertranceemit1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u88.bachiramonstertrancelineeffect:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u88.bachiramonstertrancewindcameffect:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.883, function() -- Line: 1860
        -- upvalues: TweenService (ref), u86 (copy)
        TweenService:Create(u86.bachiramonstertrancedomain, TweenInfo.new(0.5), {
            Color = Color3.fromRGB(138, 108, 0)
        }):Play();
    end);
    task.delay(2.1, function() -- Line: 1863
        -- upvalues: u91 (copy)
        for _, descendant in pairs(u91.bachiramonstermaskrighteye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u91.bachiramonsterlefteye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.017, function() -- Line: 1877
        -- upvalues: u86 (copy)
        u86.bachiramonstertrancedomain:Destroy();
    end);
    task.delay(4.183333333333334, function() -- Line: 1880
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertranceemit2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u86.bachiramonstertrancesstartwind2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.416666666666667, function() -- Line: 1900
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancestars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u86.bachiramonstertrancestars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(4.533333333333333, function() -- Line: 1914
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancestars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.05;
            end;
        end;
    end);
    task.delay(5.916666666666667, function() -- Line: 1922
        -- upvalues: u91 (copy)
        for _, descendant in pairs(u91.bachiramonstermaskrighteye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u91.bachiramonsterlefteye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(5.933333333333334, function() -- Line: 1936
        -- upvalues: u91 (copy)
        for _, descendant in pairs(u91.bachiramonstermasksideangle:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.033333333333333, function() -- Line: 1944
        -- upvalues: u90 (copy)
        for _, descendant in pairs(u90.bachiramonstertranceballglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.05, function() -- Line: 1952
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancestomp1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(6.116666666666666, function() -- Line: 1960
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancestomp1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end);
    task.delay(9.316666666666666, function() -- Line: 1968
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancestomp2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(9.35, function() -- Line: 1976
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancestomp1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(9.866666666666667, function() -- Line: 1984
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancetransitionemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(9.966666666666667, function() -- Line: 1992
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancewindbeams2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.983333333333333, function() -- Line: 1999
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancestomp3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(10, function() -- Line: 2007
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancesstartwind3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(10.033333333333333, function() -- Line: 2015
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancestomp3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end);
    task.delay(12.466666666666667, function() -- Line: 2023
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancestomp3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(12.483333333333333, function() -- Line: 2031
        -- upvalues: u91 (copy)
        for _, descendant in pairs(u91.bachiramonstermasksideangle:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(12.5, function() -- Line: 2039
        -- upvalues: u91 (copy)
        for _, descendant in pairs(u91.bachiramonstermaskrighteyeLAST:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(12.916666666666666, function() -- Line: 2047
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancewindbeams2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(13.083333333333334, function() -- Line: 2054
        -- upvalues: u90 (copy)
        for _, descendant in pairs(u90.bachiramonstertranceballglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(13.3, function() -- Line: 2062
        -- upvalues: u86 (copy), Util (ref), ReplicatedStorage (ref)
        for _, descendant in pairs(u86.bachiramonstertrancewindbeams1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        Util.Gif(ReplicatedStorage.Resources.bachira.monsterTranceImpactFrame, 30);
    end);
    task.delay(13.35, function() -- Line: 2070
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertranceemit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(13.433333333333334, function() -- Line: 2078
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertranceemit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.2;
            end;
        end;
    end);
    task.delay(16.45, function() -- Line: 2086
        -- upvalues: u91 (copy)
        u91.bachiramonstermaskrighteyeLAST:Destroy();
    end);
    task.delay(16.716666666666665, function() -- Line: 2090
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancewindbeams1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(16.75, function() -- Line: 2097
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertranceemit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(16.8, function() -- Line: 2105
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancelanding:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(18.566666666666666, function() -- Line: 2113
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancecrowdcameras:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(18.583333333333332, function() -- Line: 2121
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancelight:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(18.633333333333333, function() -- Line: 2128
        -- upvalues: u88 (copy)
        for _, descendant in pairs(u88.bachiramonstertrancelineeffect:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u88.bachiramonstertrancewindcameffect:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(18.783, function() -- Line: 2147
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy), Atmosphere (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
            Contrast = 1
        }):Play();
        TweenService:Create(Atmosphere, TweenInfo.new(0.5), {
            Density = 0.7,
            Color = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(18.9, function() -- Line: 2151
        -- upvalues: u91 (copy)
        for _, descendant in pairs(u91.bachiramonstermaskrighteye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u91.bachiramonsterlefteye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(19.816666666666666, function() -- Line: 2165
        -- upvalues: u86 (copy)
        for _, descendant in pairs(u86.bachiramonstertrancestars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u86.bachiramonstertrancestars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(u86.bachiramonstertrancelight:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(19.833, function() -- Line: 2185
        -- upvalues: ScreenDimmer (copy), u85 (copy), u84 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), EnvironmentDiffuseScale (ref), EnvironmentSpecularScale (ref), Atmosphere (copy), Density (ref), Color (ref), ColorCorrectionEffect (copy), u86 (copy), mainreplication (ref), u82 (copy), u83 (copy)
        ScreenDimmer:Destroy();
        u85:Destroy();
        u84:Destroy();
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

        u86:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1, true);
        u82:Destroy();
        u83:Destroy();
    end);
end;

function u1.bachiraautodribble(p92, p93) -- Line: 2227
    -- upvalues: PlayerGui (copy)
    if not p92.HumanoidRootPart then
        local _ = p92.PrimaryPart;
    end;

    local Hotbar = PlayerGui.Hotbar;
    Hotbar.MagicHealth.saeText.Text = p93 and "Monster Trance" or "Self Control";

    if p93 then
        Hotbar.MagicHealth.saeText.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0)) });

        return;
    end;

    Hotbar.MagicHealth.saeText.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.666667, 0)) });
end;

function u1.bachiraAwk(u94) -- Line: 2250
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy), animationUtil (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), Debris (copy), VfxHandler (copy), actionUtil (copy), Players (copy), TekrinnDialogue (copy), styles (copy), TweenService (copy), Brightness (copy), Threshold2 (copy), ExposureCompensation (copy), Ambient (copy)
    local v95 = u94.HumanoidRootPart or u94.PrimaryPart;
    local _ = u94.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1);
    local u96 = nil;
    local u97 = ReplicatedStorage.Resources.glowscreen:Clone();
    u97.Parent = PlayerGui;
    u97.ImageLabel2.ImageTransparency = 0;
    u97.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    local u98 = ReplicatedStorage.Resources.bachira.bachiraBloom:Clone();
    u98.Parent = Lighting;
    local u99 = ReplicatedStorage.Resources.bachira.bachiraColorCorrection:Clone();
    u99.Parent = Lighting;
    local u100 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u100.Parent = Lighting;
    u100.FarIntensity = 1;
    Lighting.Brightness = 2;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 2.627;
    local u101 = ReplicatedStorage.Resources.bachira.awkEffect:Clone();
    u101:PivotTo(v95.CFrame);
    u101.Parent = u94;
    soundUtil:play(ReplicatedStorage.Resources.bachira["bachira awake_1 (1)"], SoundService, {
        Character = u94
    });
    mainreplication.cutsceneBlender(v95, ReplicatedStorage.Resources.bachira.awkAnimCam, ReplicatedStorage.Resources.bachira.FOV);
    animationUtil:loadAnimation(u101.bachiramonsterme, ReplicatedStorage.Resources.bachira.awkAnimMonster):Play(0);
    local u102 = ReplicatedStorage.Resources.bachira.awkheadEff:Clone();
    u102.Weld.Part0 = u94.Head;
    u102.Parent = u101;
    local u103 = ReplicatedStorage.Resources.bachira.awkCamEff:Clone();
    u103.Parent = u101;

    if Util.canshiftcolor(LocalPlayer, u94) then
        vfxUtil.LeanTowardsColor(u101, u94:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u94:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u104 = nil;
    u104 = RunService.PreRender:connect(function() -- Line: 2303
        -- upvalues: u103 (copy), u104 (ref)
        if u103:IsDescendantOf(game) then
            u103.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u104:Disconnect();
    end);
    local u105 = {};

    for _, child in ReplicatedStorage.Resources.bachira.clothes:GetChildren() do
        if u94:FindFirstChildWhichIsA(child.ClassName) then
            local v106 = u94:FindFirstChildWhichIsA(child.ClassName);
            table.insert(u105, v106);
            v106.Parent = workspace.Terrain;
        end;

        local v107 = child:Clone();
        v107.Parent = u94;
        Debris:AddItem(v107, 16.663);
    end;

    VfxHandler.HideCharacters({ u94 }, u101);
    task.delay(8.433, function() -- Line: 2333
        -- upvalues: actionUtil (ref), Players (ref), TekrinnDialogue (ref), styles (ref)
        local v108 = "Isagi";

        for _, child in workspace.characters:GetChildren() do
            if actionUtil.checkStyle(Players:GetPlayerFromCharacter(child)) == "isagi" then
                v108 = child.Name;
                break;
            end;
        end;

        TekrinnDialogue.Speak(v108, {
            {
                Text = "A",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            },
            {
                Text = " monster?",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 204, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }, 3, styles.isagi.icon, styles.isagi.color);
    end);
    task.delay(0.15, function() -- Line: 2391
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterawkstomp:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.3, function() -- Line: 2399
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterawkstomp2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.1, function() -- Line: 2407
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterawkhit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(2, function() -- Line: 2415
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterawkstompenable:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u101.monsterawkstompenable:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.5;
            end;
        end;
    end);
    task.delay(2.15, function() -- Line: 2429
        -- upvalues: u96 (ref), ReplicatedStorage (ref), PlayerGui (ref)
        u96 = ReplicatedStorage.Resources.vb:Clone();
        u96.Parent = PlayerGui;
    end);
    task.delay(2.2, function() -- Line: 2434
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterawkmonsterstomp:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u101.monsteraurabeamsfoot1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.466666666666667, function() -- Line: 2447
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterawkstompenable:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.25;
            end;
        end;
    end);
    task.delay(2.75, function() -- Line: 2455
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterawkstompenable:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end);
    task.delay(4.983333333333333, function() -- Line: 2463
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsteraurareal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u101.monsteraurareal3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(5.1, function() -- Line: 2477
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterauracoverup:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u101.monsterauracoverup:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(5.4, function() -- Line: 2491
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsteraurabeamsfoot1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(5.516666666666667, function() -- Line: 2498
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterawkstompenable:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u101.monsterawkstompenable:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(6.1, function() -- Line: 2512
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterauracoverupground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.283333333333333, function() -- Line: 2520
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterauracoverup:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end);
    task.delay(6.416666666666667, function() -- Line: 2528
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterauracoverup:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u101.monsterauracoverup:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(u101.monsterbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.817, function() -- Line: 2547
        -- upvalues: u101 (copy)
        u101.monsterawkdomain.Transparency = 0;
    end);
    task.delay(8.316666666666666, function() -- Line: 2550
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterauracoverupground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(8.683333333333334, function() -- Line: 2558
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsteraurareal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u101.monsteraurareal3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(9, function() -- Line: 2572
        -- upvalues: u102 (copy)
        for _, descendant in pairs(u102:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.483, function() -- Line: 2580
        -- upvalues: u101 (copy)
        u101.monsterawkdomain.Transparency = 1;
    end);
    task.delay(9.6, function() -- Line: 2583
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsteraurareal2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.866666666666667, function() -- Line: 2591
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(10.767, function() -- Line: 2598
        -- upvalues: TweenService (ref), u99 (copy)
        local v109 = TweenService:Create(u99, TweenInfo.new(0.416, Enum.EasingStyle.Linear), {
            Brightness = -1
        });
        v109:Play();
        v109.Completed:Wait();
        TweenService:Create(u99, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(11.113, function() -- Line: 2606
        -- upvalues: u96 (ref)
        if u96 then
            u96:Destroy();
        end;
    end);
    task.delay(11.216666666666667, function() -- Line: 2611
        -- upvalues: u102 (copy)
        for _, descendant in pairs(u102:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(14.833333333333334, function() -- Line: 2635
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsterawksmileemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(16.6, function() -- Line: 2643
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsteraurabachiraarm:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u101.monsteraurabachiraarm:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(16.616666666666667, function() -- Line: 2657
        -- upvalues: u101 (copy), u102 (copy)
        for _, descendant in pairs(u101.monsterawkmonsterhandshake:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u102:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(16.783333333333335, function() -- Line: 2671
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsteraurabachiraarm:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u101.monsteraurabachiraarm:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.25;
            end;
        end;
    end);
    task.delay(18.15, function() -- Line: 2685
        -- upvalues: u101 (copy)
        for _, descendant in pairs(u101.monsteraurareal2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(16.663, function() -- Line: 2714
        -- upvalues: mainreplication (ref), u96 (ref), u97 (copy), u100 (copy), u105 (copy), u94 (copy), Lighting (ref), Brightness (ref), Threshold2 (ref), ExposureCompensation (ref), Ambient (ref), u98 (copy), u99 (copy), u101 (copy)
        mainreplication.blackscene(2.22);

        if u96 then
            u96:Destroy();
        end;

        if u97 then
            u97:Destroy();
        end;

        u100:Destroy();

        for _, v in u105 do
            if v and v.Parent ~= nil then
                pcall(function() -- Line: 2733
                    -- upvalues: v (copy), u94 (ref)
                    v.Parent = u94;
                end);
            end;
        end;

        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold2;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        u98:Destroy();
        u99:Destroy();
        u101:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
end;

function u1.footworkfollowup(u110) -- Line: 2768
    -- upvalues: MeshEmitter (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), mainreplication (copy), u1 (copy), Players (copy), RunService (copy)
    local u111 = u110.HumanoidRootPart or u110.PrimaryPart;
    MeshEmitter.StartMeshEmitter(u111, ReplicatedStorage.Resources.bachira.footworkfollowup);
    local u112 = ReplicatedStorage.Resources.bachira.stepoversfollow:Clone();
    u112.Weld.Part0 = u111;
    u112.Parent = u110;
    task.delay(5, function() -- Line: 2775
        -- upvalues: u112 (copy)
        u112:Destroy();
    end);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.25, BlurEffect.Destroy, BlurEffect);
    local v113 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v113.Parent = Lighting;
    v113.TintColor = Color3.fromRGB(255, 255, 255);
    v113.Brightness = 0.4;
    v113.Contrast = 1;
    v113.Saturation = -0.4;
    TweenService:Create(v113, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v113, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v113.Destroy, v113);
    mainreplication.cameraShake(35, 1.5, 6);
    task.delay(0.25, function() -- Line: 2798
        -- upvalues: u112 (copy)
        for _, descendant in pairs(u112.bachirafollowupdribbleflashstepstartvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.26666666666666666, function() -- Line: 2806
        -- upvalues: u112 (copy)
        for _, descendant in pairs(u112.bachirafollowupdribbleflashstepstart2vfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.4, function() -- Line: 2814
        -- upvalues: u112 (copy)
        for _, descendant in pairs(u112.bachirafollowupdribbleendrun:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u112.bachirafollowupdribbleendrun:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.85, function() -- Line: 2828
        -- upvalues: u112 (copy)
        for _, descendant in pairs(u112.bachirafollowupdribbleendrun:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.2, function() -- Line: 2837
        -- upvalues: u1 (ref), u110 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), mainreplication (ref), Players (ref), u111 (copy), RunService (ref)
        u1.characterImage({
            ImageTransparency = 0.7,
            Speed = 0.3,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            Count = 16,
            Whitelist = { u110 },
            Color = Color3.fromRGB(1000, 1000, 1000),
            Color2 = Color3.fromRGB(255, 200, 0)
        });
        local BlurEffect2 = Instance.new("BlurEffect");
        BlurEffect2.Size = 25;
        BlurEffect2.Parent = Lighting;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect2.Destroy, BlurEffect2);
        local v114 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v114.Parent = Lighting;
        v114.TintColor = Color3.fromRGB(255, 225, 0);
        v114.Brightness = 0.4;
        v114.Contrast = 1;
        v114.Saturation = -0.4;
        TweenService:Create(v114, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v114, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v114.Destroy, v114);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(10, 1.5, 6);

        if Players:GetPlayerFromCharacter(u110) ~= Players.LocalPlayer then
            return;
        end;

        local u115, u116 = mainreplication.bodyVelocity(u111, 200, 0.6, nil, nil, true, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0.5));
        local u117 = nil;
        u117 = RunService.RenderStepped:Connect(function(p118) -- Line: 2866
            -- upvalues: u115 (copy), u117 (ref), u111 (ref), u116 (copy)
            if u115 and u115:IsDescendantOf(game) then
                u115.Velocity = u111.CFrame.LookVector * u116.Value;

                return;
            end;

            u117:Disconnect();
        end);
        task.delay(1, u117.Disconnect, u117);
    end);
end;

function u1.beeshotto(u119) -- Line: 2878
    -- upvalues: MeshEmitter (copy), ReplicatedStorage (copy), Players (copy), mainreplication (copy), RunService (copy), Lighting (copy), TweenService (copy)
    local u120 = u119.HumanoidRootPart or u119.PrimaryPart;
    MeshEmitter.StartMeshEmitter(u120, ReplicatedStorage.Resources.bachira.beeshottomesh);
    local u121 = ReplicatedStorage.Resources.bachira.beeshotto:Clone();
    u121.Weld.Part0 = u120;
    u121.Parent = u119;
    task.delay(5, function() -- Line: 2885
        -- upvalues: u121 (copy)
        u121:Destroy();
    end);

    if Players:GetPlayerFromCharacter(u119) == Players.LocalPlayer then
        local u122, u123 = mainreplication.bodyVelocity(u120, 100, 0.15, nil, nil, true, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
        u122.MaxForce = Vector3.new(300000, 300000, 300000);
        local u124 = nil;
        u124 = RunService.RenderStepped:Connect(function(p125) -- Line: 2894
            -- upvalues: u122 (copy), u124 (ref), u120 (copy), u123 (copy)
            if u122 and u122:IsDescendantOf(game) then
                u122.Velocity = u120.CFrame.UpVector * u123.Value;

                return;
            end;

            u124:Disconnect();
        end);
        task.delay(1, u124.Disconnect, u124);
    end;

    task.spawn(function() -- Line: 2904
        -- upvalues: u121 (copy)
        for _, descendant in pairs(u121.bachirabeeshotwindvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.43333333333333335, function() -- Line: 2912
        -- upvalues: u121 (copy)
        for _, descendant in pairs(u121.bachirabeeshotshootingemitvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u121.bachirabeeshotwindvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.433, function() -- Line: 2927
        -- upvalues: Players (ref), u119 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), mainreplication (ref), u120 (copy), RunService (ref)
        if Players:GetPlayerFromCharacter(u119) == Players.LocalPlayer then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v126 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v126.Parent = Lighting;
            v126.TintColor = Color3.fromRGB(255, 225, 0);
            v126.Brightness = 0.4;
            v126.Contrast = 1;
            v126.Saturation = -0.4;
            TweenService:Create(v126, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v126, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v126.Destroy, v126);
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(35, 1.5, 6);
            local u127, u128 = mainreplication.bodyVelocity(u120, 85, 0.25, nil, nil, true, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
            u127.MaxForce = Vector3.new(300000, 300000, 300000);
            local u129 = nil;
            u129 = RunService.RenderStepped:Connect(function(p130) -- Line: 2956
                -- upvalues: u127 (copy), u129 (ref), u120 (ref), u128 (copy)
                if u127 and u127:IsDescendantOf(game) then
                    u127.Velocity = u120.CFrame.UpVector * u128.Value + u120.CFrame.LookVector * -u128.Value;

                    return;
                end;

                u129:Disconnect();
            end);
            task.delay(1, u129.Disconnect, u129);
        end;
    end);
end;

function u1.bon(p131) -- Line: 2968
    -- upvalues: ReplicatedStorage (copy), Lighting (copy), TweenService (copy), mainreplication (copy)
    local v132 = p131.HumanoidRootPart or p131.PrimaryPart;
    local u133 = ReplicatedStorage.Resources.bachira.bon:Clone();
    u133.wel.Part0 = v132;
    u133.Parent = p131;
    task.delay(5, function() -- Line: 2974
        -- upvalues: u133 (copy)
        u133:Destroy();
    end);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.25, BlurEffect.Destroy, BlurEffect);
    local v134 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v134.Parent = Lighting;
    v134.TintColor = Color3.fromRGB(255, 255, 255);
    v134.Brightness = 0.4;
    v134.Contrast = 1;
    v134.Saturation = -0.4;
    TweenService:Create(v134, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v134, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v134.Destroy, v134);
    mainreplication.cameraShake(35, 1.5, 6);
    task.delay(0.18333333333333332, function() -- Line: 2996
        -- upvalues: u133 (copy)
        for _, descendant in pairs(u133.bachirabonshootingemitvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
end;

function u1.bachiracounterland(u135) -- Line: 3006
    -- upvalues: ReplicatedStorage (copy), Players (copy), Lighting (copy), TweenService (copy), mainreplication (copy), RunService (copy)
    local u136 = u135.HumanoidRootPart or u135.PrimaryPart;
    local u137 = ReplicatedStorage.Resources.bachira.counterdribble:Clone();
    u137.Weld.Part0 = u136;
    u137.Parent = u135;
    task.delay(5, function() -- Line: 3012
        -- upvalues: u137 (copy)
        u137:Destroy();
    end);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u135) then
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        local v138 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v138.Parent = Lighting;
        v138.TintColor = Color3.fromRGB(255, 225, 0);
        v138.Brightness = 0.4;
        v138.Contrast = 1;
        v138.Saturation = -0.4;
        TweenService:Create(v138, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v138, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v138.Destroy, v138);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(10, 1.5, 6);
    end;

    task.delay(0.18333333333333332, function() -- Line: 3039
        -- upvalues: u137 (copy)
        for _, descendant in pairs(u137.bachiracounterdribbleendrun:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u137.bachiracounterdribbleendrun:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.36666666666666664, function() -- Line: 3053
        -- upvalues: u137 (copy)
        for _, descendant in pairs(u137.bachiracounterdribbleemit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.5, function() -- Line: 3061
        -- upvalues: u137 (copy)
        for _, descendant in pairs(u137.bachiracounterdribbleemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.0166666666666666, function() -- Line: 3069
        -- upvalues: u137 (copy)
        for _, descendant in pairs(u137.bachiracounterdribbleemit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u137.bachiracounterdribbleendrun:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(1.1833333333333333, function() -- Line: 3083
        -- upvalues: u137 (copy)
        for _, descendant in pairs(u137.bachiracounterdribbleemit2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.7, function() -- Line: 3092
        -- upvalues: Players (ref), u135 (copy), mainreplication (ref), u136 (copy), RunService (ref)
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u135) then
            local u139, u140 = mainreplication.bodyVelocity(u136, 163.63636363636365, 0.8, nil, nil, true, TweenInfo.new(2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0.5));
            local u141 = nil;
            u141 = RunService.RenderStepped:Connect(function(p142) -- Line: 3098
                -- upvalues: u139 (copy), u141 (ref), u136 (ref), u140 (copy)
                if u139 and u139:IsDescendantOf(game) then
                    u139.Velocity = u136.CFrame.LookVector * u140.Value;

                    return;
                end;

                u141:Disconnect();
            end);
            task.delay(1, u141.Disconnect, u141);
        end;
    end);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u135) then
        local u143, u144 = mainreplication.bodyVelocity(u136, 130.9090909090909, 1, nil, nil, true, TweenInfo.new(3.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0.5));
        local u145 = nil;
        u145 = RunService.RenderStepped:Connect(function(p146) -- Line: 3114
            -- upvalues: u143 (copy), u145 (ref), u136 (copy), u144 (copy)
            if u143 and u143:IsDescendantOf(game) then
                u143.Velocity = u136.CFrame.LookVector * u144.Value;

                return;
            end;

            u145:Disconnect();
        end);
        task.delay(1, u145.Disconnect, u145);
    end;
end;

function u1.bachiracounterstart(u147) -- Line: 3127
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy)
    local v148 = u147.HumanoidRootPart or u147.PrimaryPart;
    local u149 = ReplicatedStorage.Resources.bachira.counterstart:Clone();
    u149.Weld.Part0 = v148;
    u149.Parent = u147;
    task.delay(5, function() -- Line: 3133
        -- upvalues: u149 (copy)
        u149:Destroy();
    end);
    local u150 = {};
    mainreplication.cameraShake(35, 1.5, 6);
    task.spawn(function() -- Line: 3139
        -- upvalues: u147 (copy), ReplicatedStorage (ref), u150 (copy)
        for _, descendant in ipairs(u147:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v151 = descendant;

                for _, descendant2 in ipairs(ReplicatedStorage.Resources.bachira.bachiraaura:GetDescendants()) do
                    local v152 = descendant2:Clone();
                    v152.Parent = v151;
                    table.insert(u150, v152);
                end;
            end;
        end;
    end);
    task.delay(0.05, function() -- Line: 3152
        -- upvalues: u149 (copy), u150 (copy)
        for _, descendant in pairs(u149.bachiracounterstompvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u149.bachiracounterstompvfx2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, v in u150 do
            v.Enabled = true;
        end;
    end);
    task.delay(0.75, function() -- Line: 3170
        -- upvalues: u150 (copy)
        for _, v in u150 do
            v.Enabled = false;
        end;
    end);
    task.delay(2, function() -- Line: 3175
        -- upvalues: u150 (copy)
        for _, v in u150 do
            v:Destroy();
        end;
    end);
end;

function u1.stepovers(u153, u154) -- Line: 3182
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), Players (copy), RunService (copy)
    local u155 = u153.HumanoidRootPart or u153.PrimaryPart;
    local u156 = ReplicatedStorage.Resources.bachira.stepoversnew:Clone();
    u156.Weld.Part0 = u155;
    u156.Parent = u153;
    task.delay(6, function() -- Line: 3188
        -- upvalues: u156 (copy)
        u156:Destroy();
    end);
    local u157 = false;
    local u158 = nil;
    u158 = u153:GetAttributeChangedSignal("StepsLanded"):Connect(function() -- Line: 3195
        -- upvalues: u154 (copy), u153 (copy), u158 (ref), u156 (copy), u157 (ref)
        if u154 ~= u153:GetAttribute("StepsLanded") then
            if u158 then
                u158:Disconnect();
            end;

            u156:Destroy();
            u157 = true;
            u158:Disconnect();
        end;
    end);
    task.delay(2, function() -- Line: 3203
        -- upvalues: u158 (ref)
        u158:Disconnect();
        u158 = nil;
    end);
    task.delay(1.167, function() -- Line: 3208
        -- upvalues: u157 (ref), mainreplication (ref), u155 (copy), ReplicatedStorage (ref), Util (ref), LocalPlayer (ref), u153 (copy), vfxUtil (ref), TweenService (ref), Players (ref)
        if u157 then
            return;
        end;

        mainreplication.Emit(u155, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
        local u159 = ReplicatedStorage.Resources.rundasheff:Clone();
        u159.main.Weld.Part0 = u155;
        u159.Parent = workspace.Effects;

        if Util.canshiftcolor(LocalPlayer, u153) then
            vfxUtil.LeanTowardsColor(u159, u153:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u153:GetAttribute("CustomAlpha") or 0.985);
        end;

        u159.Air.Size = Vector3.new(4.998, 0.503, 4.998);
        u159.Air.Transparency = 0.8;
        local Air = u159.main.Air;
        Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
        TweenService:Create(u159.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            C0 = u159.main.Air.C0 * CFrame.new(0, 15, 0)
        }):Play();
        TweenService:Create(u159.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(17.136, 1.132, 16.878),
            Transparency = 1
        }):Play();
        u159.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
        u159.Wind1.Transparency = 0.9;
        TweenService:Create(u159.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(19.108, 11.452, 11.292),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 3248
            -- upvalues: u159 (copy), TweenService (ref)
            u159.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
            u159.Wind1.Transparency = 0.9;
            TweenService:Create(u159.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(19.108, 11.452, 11.292),
                Transparency = 1
            }):Play();
        end);
        u159.End.Size = Vector3.new(5, 1, 5);
        u159.End.Transparency = 0.65;
        local End = u159.main.End;
        End.C0 = End.C0 * CFrame.new(0, 0, 0);
        TweenService:Create(u159.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            C0 = u159.main.End.C0 * CFrame.new(0, -15, 0)
        }):Play();
        TweenService:Create(u159.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            Size = Vector3.new(12.999, 2.766, 12.999),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 3264
            -- upvalues: u159 (copy), TweenService (ref)
            u159.End.Size = Vector3.new(5, 1, 5);
            u159.End.Transparency = 0.65;
            local End2 = u159.main.End;
            End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
            TweenService:Create(u159.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                C0 = u159.main.End.C0 * CFrame.new(0, -15, 0)
            }):Play();
            TweenService:Create(u159.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                Size = Vector3.new(12.999, 2.766, 12.999),
                Transparency = 1
            }):Play();
        end);
        u159.A.Size = Vector3.new(14.29, 4.752, 5.444);
        u159.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
        u159.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
        u159.A.Decal.Transparency = 0.9;
        TweenService:Create(u159.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            C0 = u159.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
        }):Play();
        TweenService:Create(u159.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Size = Vector3.new(33.166, 4.752, 5.443)
        }):Play();
        TweenService:Create(u159.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Scale = Vector3.new(0.715, 0.303, 0.315)
        }):Play();
        TweenService:Create(u159.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        mainreplication.bodyVelocity(u155, 150, 0.55, nil, nil, nil, TweenInfo.new(0.7000000000000001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
        task.delay(2, u159.Destroy, u159);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u153) then
            return;
        end;

        mainreplication.cameraShake(10, 0.4, 5);
        mainreplication.fov(false, 75);
        mainreplication.fov(true, 70, 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
    task.spawn(function() -- Line: 3297
        -- upvalues: u157 (ref), u156 (copy)
        if u157 then
            return;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstepvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstepdirtvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstepdirtvfx.leftstart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstepdirtvfx.rightstart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstep2vfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.03333333333333333, function() -- Line: 3330
        -- upvalues: u157 (ref), u156 (copy)
        if u157 then
            return;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstepdirtvfx.leftstart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.16666666666666666, function() -- Line: 3339
        -- upvalues: u157 (ref), u156 (copy)
        if u157 then
            return;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstepdirtvfx.rightstart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.9333333333333333, function() -- Line: 3348
        -- upvalues: u157 (ref), u156 (copy)
        if u157 then
            return;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstepvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstepdirtvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstep2vfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(1.0333333333333334, function() -- Line: 3369
        -- upvalues: u157 (ref), u156 (copy)
        if u157 then
            return;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstepstartvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.0833333333333333, function() -- Line: 3378
        -- upvalues: u157 (ref), u156 (copy)
        if u157 then
            return;
        end;

        for _, descendant in pairs(u156.bachiradribbleflashstepstart2vfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);

    if u157 then
        return;
    end;

    if Players:GetPlayerFromCharacter(u153) ~= Players.LocalPlayer then
        return;
    end;

    local u160, u161 = mainreplication.bodyVelocity(u155, 60, 1.5, nil, nil, true, TweenInfo.new(5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 40));
    local u162 = nil;
    u162 = RunService.RenderStepped:Connect(function(p163) -- Line: 3418
        -- upvalues: u160 (copy), u162 (ref), u155 (copy), u161 (copy)
        if u160 and u160:IsDescendantOf(game) then
            u160.Velocity = u155.CFrame.LookVector * u161.Value;

            return;
        end;

        u162:Disconnect();
    end);
    task.delay(1, u162.Disconnect, u162);
end;

local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local trove = require(ReplicatedStorage.forum.trove);

function u1.bachira_ginga(u164: any, p165: any, p166: table) -- Line: 3435
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), trove (copy), PlayerGui (copy), animationUtil (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local GingaDribble = vfxUtil.getResources().bachira.GingaDribble;
    local Root = vfxUtil.getRoot(u164);
    local Ball = u164:FindFirstChild("Ball");
    mainreplication.sceneEnabled(true);
    local u167 = soundUtil:play(GingaDribble.SFX, SoundService, {
        Character = u164
    });
    local v168 = u167.Name == "Dub";
    soundUtil:play(GingaDribble.Music, SoundService);
    local u169 = trove.new();
    u169:AttachToInstance(u164);
    u169:Add(function() -- Line: 3450
        -- upvalues: mainreplication (ref), Ball (copy), vfxUtil (ref)
        mainreplication.sceneEnabled(false);

        if Ball then
            Ball.Transparency = 0;
        end;

        vfxUtil.flash(Color3.new(1, 1, 0), 1);
    end);
    u169:Add(task.delay(5.9, function() -- Line: 3455
        -- upvalues: u169 (copy)
        u169:Destroy();
    end));

    if Ball then
        Ball.Transparency = 1;
    end;

    local v170 = u169:Clone(GingaDribble.VFX);
    v170:PivotTo(Root.CFrame);
    vfxUtil.setupAura(u164, v170.Itoshi_RinNELVer, true);
    vfxUtil.setupAura(p166[2], v170.tomthebighead, true);
    v170.Parent = workspace.Effects;
    local _, v171 = mainreplication.cutsceneHumanoidCameraWithoutRootTerms(Root, GingaDribble.CamAnimation, GingaDribble.FOV, GingaDribble.HumanoidCameraRig, CFrame.identity, "Torso");
    u169:Add(v171);

    for _, child in GingaDribble.UI:GetChildren() do
        u169:Clone(child).Parent = PlayerGui;
    end;

    animationUtil:loadAnimation(v170.ball, GingaDribble.BallAnimation):Play(0);
    local v172 = {
        Vignette = u169:Add(vfxUtil.getMoonEffects()).Vignette,
        Workspace = v170,
        bachirabeeshotdomain = v170.bachirabeeshotdomain
    };
    vfxUtil.cutscene_lighting(u169, v172, GingaDribble.Lighting, {
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 1,
        ClockTime = 12,
        GeographicLatitude = 201,
        Ambient = Color3.new(0.615686, 0.709804, 0.972549),
        ColorShift_Bottom = Color3.new(0.00784314, 0.00784314, 0.00784314),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.new(0.184314, 0.184314, 0.184314)
    });
    local v173 = u169:Construct(MoonPropertyAnimator);
    v173:LoadAndConvertSave(GingaDribble.Moon, v172);
    v173:SetOriginalRoot(GingaDribble.VFX:GetPivot());
    v173:SetRoot(Root);
    v173:PlayAll();
    vfxUtil.execute_compiled(GingaDribble.Compiled, u169, v170);

    if v168 then
        u169:Add(task.delay(0.0667, function() -- Line: 3510
            -- upvalues: u169 (copy), TekrinnDialogue (ref), u164 (copy)
            u169:Add(TekrinnDialogue.Speak(u164, {
                {
                    Text = "Have you met my ideas?",
                    TypeSpeed = 0.02,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 1.6));
        end));
    end;

    if not v168 then
        u169:Add(task.delay(1.404, function() -- Line: 3529
            -- upvalues: u169 (copy), TekrinnDialogue (ref), u164 (copy)
            u169:Add(TekrinnDialogue.Speak(u164, {
                {
                    Text = "Lemme introduce some more...",
                    TypeSpeed = 0.02,
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 5));
        end));
    end;

    u169:Add(task.delay(3.478, function() -- Line: 3546
        -- upvalues: u169 (copy), TekrinnDialogue (ref), u164 (copy), u167 (copy)
        u169:Add(TekrinnDialogue.Speak(u164, {
            {
                TypeSpeed = 0.05,
                Bold = true,
                Text = u167 and u167.Name == "Dub" and "SHOCKING!" or "SHOCK!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 204, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 5));
    end));
    u169:Add(task.delay(4.298, function() -- Line: 3567
        -- upvalues: u169 (copy), TekrinnDialogue (ref), u164 (copy), u167 (copy)
        u169:Add(TekrinnDialogue.Speak(u164, {
            {
                TypeSpeed = 0.03,
                Italic = true,
                Text = u167 and u167.Name == "Dub" and "Then allow me to introduce you..." or "...ideas into this field!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 204, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 5));
    end));
end;

return u1;