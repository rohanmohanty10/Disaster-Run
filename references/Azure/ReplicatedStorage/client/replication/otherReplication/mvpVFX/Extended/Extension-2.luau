 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local Util = require(ReplicatedStorage.util.Util);
local mvpAssets = vfxUtil.getResources().mvpAssets;

return {
    mvp_YamatoExit = function(p1: any, p2: number) -- Line: 19, Name: mvp_YamatoExit
        -- upvalues: mvpAssets (copy), vfxUtil (copy), soundUtil (copy), mainreplication (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local YamatoExit = mvpAssets.YamatoExit;
        local Animations = YamatoExit.Animations;
        local Root = vfxUtil.getRoot(p1);
        soundUtil:play(YamatoExit.Sound, "default");
        local v3 = vfxUtil.mvp_cutscene_defaults(mainreplication, p2, {
            Dim = true
        });
        local v4 = v3:Clone(YamatoExit.VFX);
        v4:PivotTo(Root.CFrame);
        v4.Parent = workspace.Effects;
        local v5 = v3:Clone(YamatoExit.Sheathe);
        v5.Weld.Part0 = p1:FindFirstChild("Left Arm");
        v5.Parent = p1;
        local v6 = v3:Clone(YamatoExit.Sword);
        v6.Weld.Part0 = p1:FindFirstChild("Right Arm");
        v6.Parent = p1;
        local _, v7 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations.Cam, Animations.FOV, nil, "default", YamatoExit.VergilCam);
        v3:Add(v7);
        local v8 = v3:Add(vfxUtil.getMoonEffects());
        local v9 = {
            Vignette = v8.Vignette,
            ["Screen Cover"] = v8["Screen Cover"],
            Lighting = Lighting
        };
        vfxUtil.cutscene_lighting(v3, v9, YamatoExit.Lighting, {
            Brightness = 2,
            EnvironmentDiffuseScale = 0.5,
            EnvironmentSpecularScale = 0.8,
            ClockTime = 12,
            GeographicLatitude = 23,
            ExposureCompensation = 0,
            Ambient = Color3.fromRGB(70, 70, 70),
            OutdoorAmbient = Color3.fromRGB(80, 85, 100)
        });
        local v10 = v3:Construct(MoonPropertyAnimator);
        v10:LoadAndConvertSave(YamatoExit.Moon, v9);
        v10:PlayAll();
        vfxUtil.execute_compiled(YamatoExit.Compiled, v3, v5, v4);
    end,

    mvp_hugoMvp = function(u11: any, p12: number, p13: any, p14: table) -- Line: 74, Name: mvp_hugoMvp
        -- upvalues: mvpAssets (copy), vfxUtil (copy), soundUtil (copy), mainreplication (copy), Lighting (copy), MoonPropertyAnimator (copy), Players (copy), Util (copy), TekrinnDialogue (copy)
        local HugoMvp = mvpAssets.HugoMvp;
        local Root = vfxUtil.getRoot(u11);
        soundUtil:play(HugoMvp.Sound, "default");
        local u15 = vfxUtil.mvp_cutscene_defaults(mainreplication, p12);
        local v16 = u15:Clone(HugoMvp.Aura);
        vfxUtil.setupAura(u11, v16, true);
        v16.Parent = u11;
        local v17 = u15:Clone(HugoMvp.RightHand);
        v17.Grip.Part0 = u11["Right Arm"];
        v17.Parent = u11;
        local v18 = u15:Clone(HugoMvp.LeftHand);
        v18.Grip.Part0 = u11["Left Arm"];
        v18.Parent = u11;

        for _, child in v17:GetChildren() do
            if child:IsA("BasePart") then
                child.Color = u11["Right Arm"].Color;
            end;
        end;

        for _, child in v18:GetChildren() do
            if child:IsA("BasePart") then
                child.Color = u11["Left Arm"].Color;
            end;
        end;

        local v19, v20 = mainreplication.cutsceneCamRigWithLetterBox(Root, HugoMvp.CamAnimation, HugoMvp.FOV, nil, CFrame.new(0.022, -3.096, -0.074), HugoMvp.cam, "CamPart");
        u15:Add(v20);
        local v21 = u15:Add(vfxUtil.getMoonEffects());
        local v22 = {
            Vignette = v21.Vignette,
            ["Screen Cover"] = v21["Screen Cover"],
            Lighting = Lighting
        };
        vfxUtil.cutscene_lighting(u15, v22, HugoMvp.Lighting, {
            ClockTime = 14.5,
            ExposureCompensation = 0,
            Ambient = Color3.fromRGB(70, 70, 70),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        });
        local v23 = u15:Construct(MoonPropertyAnimator);
        v23:LoadAndConvertSave(HugoMvp.Moon, v22);
        v23:PlayAll();
        vfxUtil.execute_compiled(HugoMvp.Compiled, u15, v19, v16);
        local u24 = not Players:GetPlayerFromCharacter(p14[1]) and "Isagi" or p14[1];
        u15:Add(Util.frame_delay(1, function() -- Line: 137
            -- upvalues: u15 (copy), TekrinnDialogue (ref), u24 (ref)
            u15:Add(TekrinnDialogue.Speak(u24, {
                {
                    Text = "His dream is more grandiose",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 0,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = " than mine!",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 0.1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 170, 255)) })
                }
            }, 1.5, "rbxassetid://90999141779736", Color3.fromRGB(0, 170, 255)));
        end));
        u15:Add(Util.frame_delay(126, function() -- Line: 176
            -- upvalues: u15 (copy), TekrinnDialogue (ref), u24 (ref)
            u15:Add(TekrinnDialogue.Speak(u24, {
                {
                    Text = "He\'s sharper...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.04,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 1.25, "rbxassetid://90999141779736", Color3.fromRGB(0, 170, 255)));
        end));
        u15:Add(Util.frame_delay(227, function() -- Line: 198
            -- upvalues: u15 (copy), TekrinnDialogue (ref), u24 (ref)
            u15:Add(TekrinnDialogue.Speak(u24, {
                {
                    Text = ".. than I am?!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 2
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 0.8, "rbxassetid://90999141779736", Color3.fromRGB(0, 170, 255)));
        end));
        u15:Add(Util.frame_delay(298, function() -- Line: 220
            -- upvalues: u15 (copy), TekrinnDialogue (ref), u11 (copy)
            u15:Add(TekrinnDialogue.Speak(u11, {
                {
                    Text = "But",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(199, 44, 93)) })
                },
                {
                    Text = " this is as far as it goes.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(123, 27, 56)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 1.2, "rbxassetid://78552539644648", Color3.fromRGB(123, 27, 56)));
        end));
        u15:Add(Util.frame_delay(390, function() -- Line: 259
            -- upvalues: u15 (copy), TekrinnDialogue (ref), u11 (copy)
            u15:Add(TekrinnDialogue.Speak(u11, {
                {
                    Text = "Talent,",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.05,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 0,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(123, 27, 56)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = " 66%.",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.05,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 0.1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 44, 93)), ColorSequenceKeypoint.new(1, Color3.fromRGB(199, 44, 93)) })
                },
                {
                    Text = " Environment,",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.05,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 0.1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(123, 27, 56)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = " 33%.",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.05,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 0.1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 44, 93)), ColorSequenceKeypoint.new(1, Color3.fromRGB(199, 44, 93)) })
                }
            }, 1.7, "rbxassetid://78552539644648", Color3.fromRGB(123, 27, 56)));
        end));
        u15:Add(Util.frame_delay(566, function() -- Line: 332
            -- upvalues: u15 (copy), TekrinnDialogue (ref), u11 (copy)
            u15:Add(TekrinnDialogue.Speak(u11, {
                {
                    Text = "Luck,",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(123, 27, 56)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = " 1%.",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 44, 93)), ColorSequenceKeypoint.new(1, Color3.fromRGB(199, 44, 93)) })
                }
            }, 1.2, "rbxassetid://78552539644648", Color3.fromRGB(123, 27, 56)));
        end));
    end,

    mvp_hakari = function(p25: any, p26: number, p27: any, p28: table) -- Line: 372, Name: mvp_hakari
        -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local HakariKashimo = vfxUtil.getResources().mvpAssets.HakariKashimo;
        local v29 = vfxUtil.mvp_cutscene_defaults(mainreplication, p26);
        local Root = vfxUtil.getRoot(p25);
        soundUtil:play(HakariKashimo.Sound, "default");
        local v30, v31 = mainreplication.cutsceneCamRigWithLetterBox(Root, HakariKashimo.Camera, HakariKashimo.FOV, nil, "default", HakariKashimo.Cam, "CamPart");
        v29:Add(v31);
        local v32 = v29:Construct(HakariKashimo.User);
        vfxUtil.setupAura(p25, v32, true, true);
        v32.Parent = workspace.Effects;
        local v33 = v29:Construct(HakariKashimo.Victim);
        vfxUtil.setupAura(p28[1], v33, true, true);
        v33.Parent = workspace.Effects;
        local v34 = v29:Clone(HakariKashimo.VFX);
        v34:PivotTo(Root.CFrame);
        v34.Parent = workspace.Effects;
        animationUtil:loadAnimation(v34.Doimaindsity, HakariKashimo.Domain):Play();
        local v35 = v29:Add(vfxUtil.getMoonEffects());
        local v36 = {
            Vignette = v35.Vignette,
            ["Screen Cover"] = v35["Screen Cover"],
            Lighting = Lighting
        };
        vfxUtil.cutscene_lighting(v29, v36, HakariKashimo.Lighting, {
            Brightness = 3,
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            ClockTime = 14.5,
            GeographicLatitude = 0,
            ExposureCompensation = 0,
            Ambient = Color3.fromRGB(70, 70, 70),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        });
        local v37 = v29:Construct(MoonPropertyAnimator);
        v37:LoadAndConvertSave(HakariKashimo.Moon, v36);
        v37:SetRoot(Root);
        v37:SetOriginalRoot(CFrame.new(0, 3, 0));
        v37:PlayAll();
        vfxUtil.execute_compiled(HakariKashimo.Compiled, v29, v32, v33, v34, v30, p25, p28[1]);
    end,

    mvp_gojovsukuna = function(p38: any, p39: number, p40: any, u41: table) -- Line: 426, Name: mvp_gojovsukuna
        -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), Players (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local GojoVSukuna = vfxUtil.getResources().mvpAssets.GojoVSukuna;
        local u42 = vfxUtil.mvp_cutscene_defaults(mainreplication, p39);
        local Root = vfxUtil.getRoot(p38);
        vfxUtil.getRoot(u41[1]);
        local v43 = u42:Clone(GojoVSukuna.VFX);
        v43:PivotTo(Root.CFrame);
        v43.Parent = workspace.Effects;
        soundUtil:play(GojoVSukuna.soundMVP, "default");
        local _, v44 = mainreplication.cutsceneCamRigWithLetterBox(Root, GojoVSukuna.Camera, GojoVSukuna.FOV, nil, "default", GojoVSukuna.Cam3, "CamPart");
        u42:Add(v44);
        local v45 = u42:Construct(GojoVSukuna.User);
        vfxUtil.setupAura(p38, v45, true, true);
        v45.Parent = workspace.Effects;
        local u46;

        if Players:GetPlayerFromCharacter(u41[1]) then
            u46 = u42:Construct(vfxUtil.newRig, Root);
            task.defer(function() -- Line: 449
                -- upvalues: u46 (ref), Players (ref), u41 (copy)
                local v47 = u46:FindFirstChildWhichIsA("Humanoid");

                if not v47 then
                    return;
                end;

                local GetHumanoidDescriptionFromUserId = Players.GetHumanoidDescriptionFromUserId;
                local UserId = Players:GetPlayerFromCharacter(u41[1]).UserId;
                local success, result = pcall(GetHumanoidDescriptionFromUserId, Players, UserId);

                if success and result then
                    v47:ApplyDescriptionAsync(result);
                end;
            end);
        else
            u46 = u42:Construct(vfxUtil.newRig, Root);
        end;

        animationUtil:loadAnimation(u46, GojoVSukuna.Sukuna):Play();
        local v48 = u42:Add(vfxUtil.getMoonEffects());
        local v49 = {
            Vignette = v48.Vignette,
            ["Screen Cover"] = v48["Screen Cover"],
            R6 = v45,
            Workspace = v43,
            Lighting = Lighting
        };
        vfxUtil.contain_lighting(u42, v49, GojoVSukuna.Lighting);
        u42:Add(function() -- Line: 481
            -- upvalues: vfxUtil (ref)
            vfxUtil.restore_lighting();
            vfxUtil.restore_lighting_properties();
        end);
        local v50 = u42:Construct(MoonPropertyAnimator);
        v50:LoadAndConvertSave(GojoVSukuna.Moon, v49);
        v50:SetRoot(Root);
        v50:SetOriginalRoot(CFrame.new(39.942, 3.049, -121.921));
        v50:PlayAll();
        u42:Add(task.delay(10.57, function() -- Line: 492
            -- upvalues: u42 (copy), vfxUtil (ref)
            if u42 then
                u42:Destroy();
                vfxUtil.restore_lighting();
                vfxUtil.restore_lighting_properties();
            end;
        end));
        vfxUtil.execute_compiled(GojoVSukuna.Compiled, u42, v45);
    end,

    mvp_exe = function(u51: any, p52: number) -- Line: 503, Name: mvp_exe
        -- upvalues: vfxUtil (copy), mainreplication (copy), TekrinnDialogue (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy)
        local exe = vfxUtil.getResources().mvpAssets.exe;
        local u53 = vfxUtil.mvp_cutscene_defaults(mainreplication, p52);
        local Root = vfxUtil.getRoot(u51);
        local v54, v55 = mainreplication.cutsceneCamRigWithLetterBox(Root, exe.Camera, exe.FOV, nil, "default", exe.Cam, "CamPart");
        u53:Add(v55);
        local v56 = u53:Clone(exe.VFX);
        v56:PivotTo(Root.CFrame);
        v56.Parent = workspace.Effects;
        local v57 = u53:Clone(exe.Ball);
        v57:FindFirstChildOfClass("Motor6D").Part0 = Root;
        v57.Parent = u51;
        v56:FindFirstChild("Ball"):FindFirstChildOfClass("Weld").Part0 = v57;
        v56:FindFirstChild("CamVFX"):FindFirstChildOfClass("Weld").Part0 = v54:FindFirstChild("CamPart");
        v56:FindFirstChild("FakeHead"):FindFirstChildOfClass("Weld").Part0 = u51:FindFirstChild("Head");
        local _baseplate_controller, u58 = vfxUtil.get_baseplate_controller();
        u53:Add(vfxUtil.make_baseplate_connection(_baseplate_controller));
        u53:Add(function() -- Line: 525
            -- upvalues: u58 (copy), _baseplate_controller (copy)
            u58.Transparency = 0;
            _baseplate_controller.update();
        end);
        u53:Add(task.delay(1.52, function() -- Line: 530
            -- upvalues: u58 (copy)
            u58.Transparency = 0;
        end));
        u53:Add(task.delay(2, function() -- Line: 534
            -- upvalues: u58 (copy)
            u58.Transparency = 1;
        end));
        u53:Add(task.delay(0.1, function() -- Line: 538
            -- upvalues: u53 (copy), TekrinnDialogue (ref), u51 (copy)
            u53:Add(TekrinnDialogue.Speak(u51, {
                {
                    Text = "Ready for",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 30, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = " round 2?",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 10, 10)), ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 30, 30)) })
                }
            }, 1.2, "rbxassetid://0", Color3.fromRGB(120, 0, 0)));
        end));
        u53:Add(task.delay(3.05, function() -- Line: 577
            -- upvalues: u53 (copy), TekrinnDialogue (ref), u51 (copy)
            u53:Add(TekrinnDialogue.Speak(u51, {
                {
                    Text = "*evil aura laugh*",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 10, 10)), ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 30, 30)) })
                }
            }, 1.2, "rbxassetid://0", Color3.fromRGB(120, 0, 0)));
        end));
        local v59 = {
            Main = u53:Add(vfxUtil.getMoonEffects()).Main,
            Lighting = Lighting
        };
        vfxUtil.contain_lighting(u53, v59, exe.Lighting);
        u53:Add(function() -- Line: 608
            -- upvalues: vfxUtil (ref)
            vfxUtil.restore_lighting();
            vfxUtil.restore_lighting_properties();
        end);
        local v60 = u53:Construct(MoonPropertyAnimator);
        v60:LoadAndConvertSave(exe.Moon, v59);
        v60:SetRoot(Root);
        v60:PlayAll();
        soundUtil:play(exe.soundMVP, "default");
        vfxUtil.execute_compiled(exe.Compiled, u53, v56);
    end,

    mvp_bojack = function(u61: any, p62: number) -- Line: 623, Name: mvp_bojack
        -- upvalues: vfxUtil (copy), mainreplication (copy), Lighting (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy), soundUtil (copy)
        local bojack = vfxUtil.getResources().mvpAssets.bojack;
        local u63 = vfxUtil.mvp_cutscene_defaults(mainreplication, p62);
        local Root = vfxUtil.getRoot(u61);
        local v64, v65 = mainreplication.cutsceneCamRigWithLetterBox(Root, bojack.Animations.Cam, bojack.FOV, nil, "default", bojack.Cam, "CamPart");
        u63:Add(v65);
        local v66 = {
            Vignette = u63:Add(vfxUtil.getMoonEffects()).Vignette,
            Lighting = Lighting
        };
        vfxUtil.contain_lighting(u63, v66, bojack.Lighting);
        u63:Add(task.delay(3, function() -- Line: 640
            -- upvalues: u63 (copy), TekrinnDialogue (ref), u61 (copy)
            u63:Add(TekrinnDialogue.Speak(u61, {
                {
                    Text = "*evil laugh*",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 120, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 1.2, "rbxassetid://0", Color3.fromRGB(70, 160, 150)));
        end));
        u63:Add(task.delay(4.4, function() -- Line: 662
            -- upvalues: u63 (copy), TekrinnDialogue (ref), u61 (copy)
            u63:Add(TekrinnDialogue.Speak(u61, {
                {
                    Text = "This place belongs to me now.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 120, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 1.2, "rbxassetid://0", Color3.fromRGB(70, 160, 150)));
        end));
        u63:Add(function() -- Line: 684
            -- upvalues: vfxUtil (ref)
            vfxUtil.restore_lighting();
            vfxUtil.restore_lighting_properties();
        end);
        local v67 = u63:Construct(MoonPropertyAnimator);
        v67:LoadAndConvertSave(bojack.Moon, v66);
        v67:SetRoot(Root);
        v67:PlayAll();
        soundUtil:play(bojack.soundMVP, "default");
        vfxUtil.execute_compiled(bojack.Compiled, u63, v64);
    end,

    mvp_sparkle = function(u68: any, p69: number) -- Line: 699, Name: mvp_sparkle
        -- upvalues: vfxUtil (copy), mainreplication (copy), Players (copy), soundUtil (copy), animationUtil (copy), Util (copy), TekrinnDialogue (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local sparkle = vfxUtil.getResources().mvpAssets.sparkle;
        local u70 = vfxUtil.mvp_cutscene_defaults(mainreplication, p69);
        local Root = vfxUtil.getRoot(u68);
        local v71 = u70:Clone(sparkle.VFX);
        v71:PivotTo(Root.CFrame);
        v71.Parent = workspace.Effects;
        local v72, v73 = mainreplication.cutsceneCamRigWithLetterBox(Root, sparkle.CamAnimation, sparkle.FOV, nil, nil, sparkle.Cam, "CamPart");
        u70:Add(v73);
        u70:Add(vfxUtil.buildFromRig(u68, sparkle.Rig1), "Destroy");
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(u68);
        local v74;

        if PlayerFromCharacter then
            v74 = u70:Construct(vfxUtil.newRigForFriend, Root, PlayerFromCharacter);
        else
            v74 = u70:Construct(vfxUtil.newRig, Root);
        end;

        local _baseplate_controller, u75 = vfxUtil.get_baseplate_controller();
        u70:Add(vfxUtil.make_baseplate_connection(_baseplate_controller.update));
        u75.Transparency = 1;
        u70:Add(function() -- Line: 725
            -- upvalues: u75 (copy), _baseplate_controller (copy)
            u75.Transparency = 0;
            _baseplate_controller.update();
        end);
        soundUtil:play(sparkle.soundmvp, "default");
        animationUtil:loadAnimation(v74, sparkle.Duo):Play(0);
        u70:Add(task.delay(9.25, function() -- Line: 735
            -- upvalues: Util (ref), sparkle (copy)
            Util.Gif(sparkle.ImpactFrames, 15);
        end));
        u70:Add(task.spawn(function() -- Line: 739
            -- upvalues: u70 (copy), TekrinnDialogue (ref), u68 (copy)
            u70:Add(TekrinnDialogue.Speak(u68, {
                {
                    Text = "Let me tell you what foolishness is.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 60, 65)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3, "rbxassetid://0", Color3.fromRGB(220, 60, 65)));
        end));
        u70:Add(task.delay(4.1, function() -- Line: 761
            -- upvalues: u70 (copy), TekrinnDialogue (ref), u68 (copy)
            u70:Add(TekrinnDialogue.Speak(u68, {
                {
                    Text = "Pretending to be smart, like you do.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 60, 65)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3, "rbxassetid://0", Color3.fromRGB(220, 60, 65)));
        end));
        u70:Add(task.delay(7.75, function() -- Line: 783
            -- upvalues: u70 (copy), TekrinnDialogue (ref), u68 (copy)
            u70:Add(TekrinnDialogue.Speak(u68, {
                {
                    Text = "Then, what is a fool?",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 60, 65)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3, "rbxassetid://0", Color3.fromRGB(220, 60, 65)));
        end));
        u70:Add(task.delay(10.5, function() -- Line: 805
            -- upvalues: u70 (copy), TekrinnDialogue (ref), u68 (copy)
            u70:Add(TekrinnDialogue.Speak(u68, {
                {
                    Text = "Knowing when to act clueless...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 60, 65)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3, "rbxassetid://0", Color3.fromRGB(220, 60, 65)));
        end));
        u70:Add(task.delay(14, function() -- Line: 827
            -- upvalues: u70 (copy), TekrinnDialogue (ref), u68 (copy)
            u70:Add(TekrinnDialogue.Speak(u68, {
                {
                    Text = "Like I do.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 60, 65)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3, "rbxassetid://0", Color3.fromRGB(220, 60, 65)));
        end));
        u70:Add(task.delay(17, function() -- Line: 849
            -- upvalues: u70 (copy), TekrinnDialogue (ref), u68 (copy)
            u70:Add(TekrinnDialogue.Speak(u68, {
                {
                    Text = "Do you get it now?",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 60, 65)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3, "rbxassetid://0", Color3.fromRGB(220, 60, 65)));
        end));
        local v76 = {
            ["Screen Cover"] = u70:Add(vfxUtil.getMoonEffects())["Screen Cover"],
            Lighting = Lighting
        };
        vfxUtil.contain_lighting(u70, v76, sparkle.Lighting);
        u70:Add(function() -- Line: 879
            -- upvalues: vfxUtil (ref)
            vfxUtil.restore_lighting();
            vfxUtil.restore_lighting_properties();
        end);
        local v77 = u70:Construct(MoonPropertyAnimator);
        v77:LoadAndConvertSave(sparkle.Moon, v76);
        v77:SetRoot(Root);
        v77:PlayAll();
        vfxUtil.execute_compiled(sparkle.Compiled, u70, u68, v71, v72);
    end,

    mvp_shanksMvp = function(u78: any, p79: number) -- Line: 892, Name: mvp_shanksMvp
        -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), MoonPropertyAnimator (copy), animationUtil (copy), TekrinnDialogue (copy)
        local shanksMvp = vfxUtil.getResources().mvpAssets.shanksMvp;
        local Root = vfxUtil.getRoot(u78);
        local u80 = vfxUtil.mvp_cutscene_defaults(mainreplication, p79);
        soundUtil:play(shanksMvp.Sound, "default");
        soundUtil:play(shanksMvp.Music, "default");
        local u81, u82 = vfxUtil.newRigForFriend(Root, nil, CFrame.new(0, -0.75, -2.5));
        task.spawn(function() -- Line: 902
            -- upvalues: u82 (copy), u81 (copy)
            if not u82.Value then
                u82.Changed:Wait();
            end;

            for _, child in u81:GetChildren() do
                if child:IsA("Accessory") and (child:FindFirstChild("Handle") and (child.Handle:FindFirstChild("HatAttachment") and not child.Name:lower():match("ears"))) then
                    child.Handle.Transparency = 1;
                end;
            end;

            u81:ScaleTo(0.75);
        end);
        u80:Add(u81);
        local v83 = u80:Clone(shanksMvp.VFX);
        v83:PivotTo(Root.CFrame);
        v83.Parent = workspace.Effects;
        local v84 = u80:Clone(shanksMvp.Model);
        v84.Weld.Part0 = u78:FindFirstChild("Head");
        v84.Parent = u78;
        local _, v85 = mainreplication.cutsceneCamRigWithLetterBox(Root, shanksMvp.Animations.Cam, shanksMvp.FOV, nil, "default", shanksMvp.Cam3, "CamPart");
        u80:Add(v85);
        local v86 = u80:Construct(MoonPropertyAnimator);
        v86:LoadAndConvertSave(shanksMvp.Moon, {
            Workspace = v83
        });
        v86:PlayAll();
        animationUtil:loadAnimation(u81, shanksMvp.Animations.Luffy):Play(0);
        local u87 = {};

        for _, child in u78:GetChildren() do
            if child:IsA("Accessory") and (child:FindFirstChild("Handle") and (child.Handle:FindFirstChild("HatAttachment") and not child.Name:lower():match("ears"))) then
                table.insert(u87, child.Handle);
                child.Handle.Transparency = 1;
            end;
        end;

        u80:Add(function() -- Line: 942
            -- upvalues: u87 (copy)
            for _, v in u87 do
                v.Transparency = 0;
            end;
        end);
        u80:Add(task.delay(0.232, function() -- Line: 948
            -- upvalues: u80 (copy), TekrinnDialogue (ref), u78 (copy)
            u80:Add(TekrinnDialogue.Speak(u78, {
                {
                    Text = "You\'re gonna surpass us, huh?",
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 5, "", Color3.fromRGB(191, 0, 0)));
        end));
        u80:Add(task.delay(2.683, function() -- Line: 963
            -- upvalues: u80 (copy), TekrinnDialogue (ref), u78 (copy)
            u80:Add(TekrinnDialogue.Speak(u78, {
                {
                    Text = "In that case...",
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 5, "", Color3.fromRGB(191, 0, 0)));
        end));
        u80:Add(task.delay(5.5, function() -- Line: 979
            -- upvalues: u80 (copy), TekrinnDialogue (ref), u78 (copy)
            u80:Add(TekrinnDialogue.Speak(u78, {
                {
                    Text = "... I\'ll leave this hat with you.",
                    Bold = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 5, "", Color3.fromRGB(191, 0, 0)));
        end));
        u80:Add(task.delay(7.064, function() -- Line: 995
            -- upvalues: u80 (copy), TekrinnDialogue (ref), u78 (copy)
            u80:Add(TekrinnDialogue.Speak(u78, {
                {
                    Text = "It\'s dear to me.",
                    Bold = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 5, "", Color3.fromRGB(191, 0, 0)));
        end));
        u80:Add(task.delay(8.649, function() -- Line: 1011
            -- upvalues: u80 (copy), TekrinnDialogue (ref), u78 (copy)
            u80:Add(TekrinnDialogue.Speak(u78, {
                {
                    Text = "Take good care of it!",
                    Bold = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 5, "", Color3.fromRGB(191, 0, 0)));
        end));
    end,

    mvp_barouHeadToHead = function(u88: any, p89: number, p90: any, p91: table) -- Line: 1028, Name: mvp_barouHeadToHead
        -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), Players (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
        local BarouHead = vfxUtil.getResources().mvpAssets.BarouHead;
        local Root = vfxUtil.getRoot(u88);
        local u92 = vfxUtil.mvp_cutscene_defaults(mainreplication, p89);
        soundUtil:play(BarouHead.Sound, "default");
        soundUtil:play(BarouHead.Music, "default");
        local u93 = u92:Clone(BarouHead.VFX);
        u93:PivotTo(Root.CFrame);
        u93.Parent = workspace.Effects;
        local v94, v95 = mainreplication.cutsceneCamRigWithLetterBox(Root, BarouHead.Animations.Cam, BarouHead.FOV, false, "default", BarouHead.Cam3, "CamPart");
        u92:Add(v95);
        local v96 = u92:Clone(BarouHead.Vignette);
        v96.Parent = vfxUtil.getPlayerGui();
        local u97 = p91[1];
        local Name = u97.Name;
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(u97);
        u92:Add(task.spawn(function() -- Line: 1051
            -- upvalues: u88 (copy), u93 (copy), u97 (copy)
            if u88:FindFirstChild("Head") then
                u93:FindFirstChild("FakeheadP"):FindFirstChildOfClass("Weld").Part0 = u88:FindFirstChild("Head");
            end;

            if u97:FindFirstChild("Head") then
                u93:FindFirstChild("FakeheadV"):FindFirstChildOfClass("Weld").Part0 = u97:FindFirstChild("Head");
            end;
        end));
        local v98 = {
            VFX = u93,
            Lighting = Lighting,
            Vignette = v96
        };
        vfxUtil.cutscene_lighting(u92, v98, BarouHead.Lighting, {
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            ExposureCompensation = 0.15000000596046448,
            ClockTime = 12,
            GeographicLatitude = 201,
            Ambient = Color3.new(1, 1, 1),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            ColorShift_Top = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.new(0.184314, 0.184314, 0.184314)
        });
        local v99 = u92:Construct(MoonPropertyAnimator);
        v99:LoadAndConvertSave(BarouHead.Moon, v98);
        v99:PlayAll();
        vfxUtil.execute_compiled(BarouHead.Compiled, u92, v94:FindFirstChild("CamPart"), u93);
        u92:Add(task.delay(1.619, function() -- Line: 1083
            -- upvalues: u92 (copy), TekrinnDialogue (ref), u88 (copy), PlayerFromCharacter (copy), Name (copy)
            u92:Add(TekrinnDialogue.Speak(u88, {
                {
                    Bold = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    Text = `I need more, {PlayerFromCharacter and Name or "Isagi"}.`,
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3, "", Color3.fromRGB(255, 0, 0)));
        end));
        u92:Add(task.delay(7.763, function() -- Line: 1099
            -- upvalues: u92 (copy), TekrinnDialogue (ref), u88 (copy)
            u92:Add(TekrinnDialogue.Speak(u88, {
                {
                    Text = "I need more to devour.",
                    Bold = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
                }
            }, 3, "", Color3.fromRGB(255, 0, 0)));
        end));
    end
};