 
 

local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local trove = require(ReplicatedStorage.forum.trove);
local wiki = require(ReplicatedStorage.wiki);
local Resources = vfxUtil.getResources();
local mvpAssets = Resources.mvpAssets;
local v116 = {
    mvp_ironMouseTuffMVP = function(p1: any, p2: number) -- Line: 29, Name: mvp_ironMouseTuffMVP
        -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), TweenService (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local ironMouseTuffMVP = vfxUtil.getResources().mvpAssets.ironMouseTuffMVP;
        local v3 = vfxUtil.mvp_cutscene_defaults(mainreplication, p2);
        local Root = vfxUtil.getRoot(p1);
        local v4 = soundUtil:play(ironMouseTuffMVP.Sound, "default", {
            Volume = 0
        });
        local v5 = TweenService:Create(v4, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Volume = 1.5
        });
        local u6 = TweenService:Create(v4, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Volume = 0
        });
        v5:Play();
        v3:Add(task.delay(p2 - 1, function() -- Line: 38
            -- upvalues: u6 (copy)
            u6:Play();
        end));
        local v7, v8 = mainreplication.cutsceneCamRigWithLetterBox(Root, ironMouseTuffMVP.CamAnimation, ironMouseTuffMVP.FOV, nil, CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0));
        v3:Add(v8);

        if v7 then
            v7.letterboxbot.Transparency = 0;
            v7.letterboxtop.Transparency = 0;
            local v9 = v3:Clone(ironMouseTuffMVP.theotherletterbox);
            v9.theotherletterbox.Part0 = v7:FindFirstChild("camera");
            v9.Parent = workspace.Effects;
        end;

        local v10 = v3:Clone(ironMouseTuffMVP.ScreenGui);
        v10.Parent = vfxUtil.getPlayerGui();
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Parent = Lighting;
        v3:Add(ColorCorrectionEffect);
        local v11 = v3:Construct(MoonPropertyAnimator);
        v11:LoadAndConvertSave(ironMouseTuffMVP.Moon, {
            ScreenGui = v10,
            ColorCorrection = ColorCorrectionEffect
        });
        v11:PlayAll();
    end,

    mvp_diavoloMvp = function(u12: any, p13: number, p14: any, u15: table) -- Line: 67, Name: mvp_diavoloMvp
        -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), Util (copy), Lighting (copy), MoonPropertyAnimator (copy), animationUtil (copy), TekrinnDialogue (copy), Players (copy)
        local diavolo = vfxUtil.getResources().mvpAssets.diavolo;
        local Animations = diavolo.Animations;
        local u16 = vfxUtil.mvp_cutscene_defaults(mainreplication, p13);
        local Root = vfxUtil.getRoot(u12);
        soundUtil:play(diavolo.Sound, "default");
        u16:Add(Util.Preload(diavolo.ImpactFrames));
        local _baseplate_controller, u17 = vfxUtil.get_baseplate_controller();
        u17.Transparency = 1;
        _baseplate_controller.update();
        u16:Add(function() -- Line: 83
            -- upvalues: u17 (copy), _baseplate_controller (copy)
            u17.Transparency = 0;
            _baseplate_controller.update();
        end);
        local v18 = u16:Clone(diavolo.VFX);
        v18:PivotTo(Root.CFrame);
        v18.Parent = workspace.Effects;
        local v19 = {
            Workspace = v18,
            Lighting = Lighting
        };
        vfxUtil.cutscene_lighting(u16, v19, diavolo.Lighting, {
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            ExposureCompensation = 0,
            ClockTime = 14.5,
            GeographicLatitude = 0,
            Ambient = Color3.new(0.27451, 0.27451, 0.27451),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            ColorShift_Top = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.new(0.27451, 0.27451, 0.27451)
        });
        local v20 = u16:Construct(MoonPropertyAnimator);
        v20:LoadAndConvertSave(diavolo.Moon, v19);
        v20:PlayAll();
        local v21, v22 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations.Cam, diavolo.FOV, nil, "default", diavolo.Cam3, "CamPart");
        u16:Add(v22);
        u16:Add(task.delay(5.466666666666667, Util.Gif, diavolo.ImpactFrames, 45));
        u16:Add(task.delay(17.666666666666668, Util.Gif, diavolo.ImpactFrames, 45));
        local u23 = u16:Add(vfxUtil.newRigForFriend(Root));
        u16:Add(vfxUtil.buildFromRig(u23, diavolo.TemplateR6));
        u16:Add(vfxUtil.buildFromRig(u12, diavolo.R6));
        vfxUtil.execute_compiled(diavolo.Compiled, u16, v18, v21, u12, u23);
        local v24 = animationUtil:loadAnimation(u23, Animations.Doppio);
        local v25 = animationUtil:loadAnimation(u12, Animations.Diavolo);
        v24:Play(0);
        v25:Play(0);
        u16:Add(task.delay(0.65, function() -- Line: 129
            -- upvalues: u16 (copy), TekrinnDialogue (ref), u23 (copy)
            u16:Add(TekrinnDialogue.Speak(u23.Name, {
                {
                    Text = "This is a test.",
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 98, 187)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 1.642, nil, Color3.fromRGB(235, 80, 176)));
        end));
        u16:Add(task.delay(7.466666666666667, function() -- Line: 145
            -- upvalues: u16 (copy), TekrinnDialogue (ref), u23 (copy)
            u16:Add(TekrinnDialogue.Speak(u23.Name, {
                {
                    Text = "I\'ve accepted this test to stand victorious against my past.",
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 98, 187)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 7, nil, Color3.fromRGB(235, 80, 176)));
        end));
        u16:Add(task.delay(12.15, function() -- Line: 161
            -- upvalues: u16 (copy), TekrinnDialogue (ref)
            u16:Add(TekrinnDialogue.Speak("???", {
                {
                    Text = "A person grows once they\'re able to defeat their weaker self.",
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 4.746, nil, Color3.new(1, 1, 1)));
        end));
        u16:Add(task.delay(18.65, function() -- Line: 177
            -- upvalues: u15 (copy), Players (ref), u16 (copy), TekrinnDialogue (ref), u12 (copy)
            local v26 = u15[1];
            local Name = v26.Name;
            local v27 = not (v26 and Players:GetPlayerFromCharacter(v26)) and "Jean-Pierre Polnareff" or Name;
            u16:Add(TekrinnDialogue.Speak(u12.Name, {
                {
                    TypeSpeed = 0.03,
                    Text = `Wouldn't you agree, {v27}?`,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 32, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3.976, nil, Color3.fromRGB(255, 37, 95)));
        end));
    end,

    mvp_sothisishowitfeels = function(u28: any, p29: number) -- Line: 199, Name: mvp_sothisishowitfeels
        -- upvalues: vfxUtil (copy), mainreplication (copy), animationUtil (copy), soundUtil (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy)
        local freedom = vfxUtil.getResources().mvpAssets.freedom;
        local u30 = vfxUtil.mvp_cutscene_defaults(mainreplication, p29);
        local Root = vfxUtil.getRoot(u28);
        u30:Add(task.spawn(function() -- Line: 204
            -- upvalues: u30 (copy), freedom (copy), Root (copy), u28 (copy), mainreplication (ref), animationUtil (ref), soundUtil (ref)
            local v31 = u30:Clone(freedom.TorsoSoul);
            local v32 = u30:Clone(freedom.TorsoSkeleton);
            local v33 = u30:Clone(freedom.CamPart);
            local v34 = u30:Clone(freedom.FakeSkybox);
            v32:FindFirstChildOfClass("Motor6D").Part1 = v33;
            v31:FindFirstChild("TorsoSkeleton").Part1 = v32;
            v31:FindFirstChild("TorsoSoul").Part0 = Root;
            v31.Parent = u28;
            v32.Parent = u28;
            v33.Parent = u28;
            v34.Parent = workspace.Effects;
            v34:PivotTo(Root.CFrame * CFrame.new(
                0.296142578,
                -2.58870196,
                0.827270508,
                -0.989020407,
                -0.147779226,
                1.7261705e-7,
                -1.44713681e-7,
                -1.9956984e-7,
                -1,
                0.147779226,
                -0.989020407,
                1.75992966e-7
            ));
            mainreplication.makeitacam(Root, v33, freedom.FOV);
            u30:Add(animationUtil:loadAnimation(u28, freedom.Animation), "Stop", 0):Play(0);

            if u28:GetAttribute("RinNoPlay") or u28:GetAttribute("SillySong") then
                soundUtil:play(freedom.rnpsoundmvp, "default");

                return;
            end;

            soundUtil:play(freedom.soundmvp, "default");
        end));

        for _, child in workspace.characters:GetChildren() do
            if child ~= u28 then
                local Root2 = vfxUtil.getRoot(child);
                Root2.Anchored = true;
                u30:Add(function() -- Line: 236
                    -- upvalues: Root2 (copy)
                    Root2.Anchored = false;
                end);
            end;
        end;

        local v35 = u30:Add(vfxUtil.getMoonEffects());
        local v36 = {
            Vignette = v35.Vignette,
            ["Screen Cover"] = v35["Screen Cover"]
        };
        u30:Add(TekrinnDialogue.Speak(u28, {
            {
                Text = "The people who witnessed these things..",
                TypeSpeed = 0.03,
                Color = Color3.new(1, 1, 1)
            }
        }, 3.6, nil, Color3.fromRGB(41, 15, 56)));
        u30:Add(task.delay(3.5, function() -- Line: 265
            -- upvalues: u30 (copy), TekrinnDialogue (ref), u28 (copy)
            u30:Add(TekrinnDialogue.Speak(u28, {
                {
                    Text = "Were the ones that had obtained the greatest freedom in the world.",
                    TypeSpeed = 0.03,
                    Color = Color3.new(1, 1, 1)
                }
            }, 9, nil, Color3.fromRGB(41, 15, 56)));
        end));
        u30:Add(task.delay(11.5, function() -- Line: 277
            -- upvalues: u30 (copy), TekrinnDialogue (ref), u28 (copy)
            u30:Add(TekrinnDialogue.Speak(u28, {
                {
                    Text = "This...",
                    TypeSpeed = 0.03,
                    Color = Color3.new(1, 1, 1)
                }
            }, 5, nil, Color3.fromRGB(41, 15, 56)));
        end));
        u30:Add(task.delay(15, function() -- Line: 289
            -- upvalues: u30 (copy), TekrinnDialogue (ref), u28 (copy)
            u30:Add(TekrinnDialogue.Speak(u28, {
                {
                    Text = "Is",
                    TypeSpeed = 0.03,
                    Color = Color3.new(1, 1, 1)
                },
                {
                    Text = " freedom!",
                    Bold = true,
                    TypeSpeed = 0.03,
                    Color = Color3.new(1, 1, 1),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 0.5
                    }
                }
            }, 5, nil, Color3.fromRGB(41, 15, 56)));
        end));
        local v37 = u30:Construct(MoonPropertyAnimator);
        v37:LoadAndConvertSave(freedom.Moon, v36);
        v37:PlayAll();
    end,

    mvp_demolishitall = function(p38: any, p39: number) -- Line: 316, Name: mvp_demolishitall
        -- upvalues: vfxUtil (copy), mainreplication (copy), animationUtil (copy), soundUtil (copy), MoonPropertyAnimator (copy)
        local demolishitall = vfxUtil.getResources().mvpAssets.demolishitall;
        local v40 = vfxUtil.mvp_cutscene_defaults(mainreplication, p39);
        local Root = vfxUtil.getRoot(p38);
        local _, v41 = mainreplication.cutsceneCamRigWithLetterBox(Root, demolishitall.Cam, demolishitall.FOV, nil, nil, demolishitall.HumanoidCameraRig, "Torso");
        v40:Add(v41);
        local v42 = v40:Add(vfxUtil.getMoonEffects());
        local v43 = {
            Vignette = v42.Vignette,
            ["Screen Cover"] = v42["Screen Cover"]
        };
        local v44 = v40:Clone(demolishitall.wctrophy_body_low);
        v44:FindFirstChildOfClass("Motor6D").Part0 = p38:FindFirstChild("Right Arm");
        v44.Parent = p38:FindFirstChild("Right Arm");
        v40:Add(animationUtil:loadAnimation(p38, demolishitall.Animation), "Stop", 0):Play(0);
        local v45 = v40:Clone(demolishitall.TemplateR6);
        v45:PivotTo(Root.CFrame);
        v45.Parent = workspace.Effects;
        animationUtil:loadAnimation(v45, demolishitall.Sorra):Play(0);
        soundUtil:play(demolishitall.soundmvp, "default");
        local v46 = v40:Construct(MoonPropertyAnimator);
        v46:LoadAndConvertSave(demolishitall.Moon, v43);
        v46:PlayAll();
    end,

    mvp_LucyMvp = function(p47: any, p48: number) -- Line: 430, Name: mvp_LucyMvp
        -- upvalues: mvpAssets (copy), vfxUtil (copy), soundUtil (copy), mainreplication (copy), MoonPropertyAnimator (copy)
        local LucyMvp = mvpAssets.LucyMvp;
        local Animations = LucyMvp.Animations;
        local Root = vfxUtil.getRoot(p47);
        soundUtil:play(LucyMvp.Sound, "default");
        local v49 = vfxUtil.mvp_cutscene_defaults(mainreplication, p48);
        local v50 = v49:Clone(LucyMvp.VFX);
        v50:PivotTo(Root.CFrame);
        v50.Parent = workspace.Effects;

        if not p47:FindFirstChild("Ball") then
            local v51 = v49:Clone(LucyMvp.Ball);
            v51.ball.Part0 = Root;
            v51.Parent = p47;
        end;

        local v52 = {
            Vignette = v49:Add(vfxUtil.getMoonEffects()).Vignette
        };
        vfxUtil.cutscene_lighting(v49, v52, LucyMvp.Lighting, {
            ExposureCompensation = 0,
            ClockTime = 14.5,
            Ambient = Color3.fromRGB(70, 70, 70),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        });
        local _, v53 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations.Cam, Animations.FOV, nil, "default", LucyMvp.Cam3, "CamPart");
        v49:Add(v53);
        local v54 = v49:Construct(MoonPropertyAnimator);
        v54:LoadAndConvertSave(LucyMvp.Moon, v52);
        v54:PlayAll();
        vfxUtil.execute_compiled(LucyMvp.Compiled, v49, v50);
    end,

    mvp_sukunaMVP = function(p55: any, p56: number) -- Line: 469, Name: mvp_sukunaMVP
        -- upvalues: vfxUtil (copy), mainreplication (copy), MoonPropertyAnimator (copy), soundUtil (copy)
        local SukunaMVP = vfxUtil.getResources().mvpAssets.SukunaMVP;
        local v57 = vfxUtil.mvp_cutscene_defaults(mainreplication, p56);
        local Root = vfxUtil.getRoot(p55);
        local v58, v59 = mainreplication.cutsceneCamRigWithLetterBox(Root, SukunaMVP.Camera, SukunaMVP.FOV, nil, "default", SukunaMVP.Cam3, "CamPart");
        v57:Add(v59);
        local v60 = v57:Construct(SukunaMVP.Aura);
        vfxUtil.setupAura(p55, v60, true, true);
        v60.Parent = workspace.Effects;
        local v61 = v57:Clone(SukunaMVP.kamutoke_rig);
        v61.Parent = p55;
        local v62 = v61:FindFirstChildOfClass("Motor6D");
        v62.Part0 = p55:FindFirstChild("Right Arm");
        v62.Parent = p55:FindFirstChild("Right Arm");
        local v63 = v57:Clone(SukunaMVP["Left Arm2"]);
        v63.Parent = p55;
        local v64 = v63:FindFirstChildOfClass("Motor6D");
        v64.Part0 = p55:FindFirstChild("Torso");
        v64.Parent = p55:FindFirstChild("Torso");
        local v65 = v57:Clone(SukunaMVP["Right Arm2"]);
        v65.Parent = p55;
        local v66 = v65:FindFirstChildOfClass("Motor6D");
        v66.Part0 = p55:FindFirstChild("Torso");
        v66.Parent = p55:FindFirstChild("Torso");
        vfxUtil.execute_compiled(SukunaMVP.Compiled, v57, v60, v58, p55);
        local v67 = {
            Vignette = v57:Add(vfxUtil.getMoonEffects()).Vignette
        };
        vfxUtil.contain_lighting(v57, v67, SukunaMVP.Lighting);
        local v68 = v57:Construct(MoonPropertyAnimator);
        v68:LoadAndConvertSave(SukunaMVP.Moon, v67);
        v68:PlayAll();
        soundUtil:play(SukunaMVP.sound, "default");
    end,

    mvp_ryuvsyuta = function(u69: any, p70: number, p71: any, p72: table) -- Line: 520, Name: mvp_ryuvsyuta
        -- upvalues: vfxUtil (copy), mainreplication (copy), animationUtil (copy), Lighting (copy), Players (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy), soundUtil (copy)
        local ryuvsyuta = vfxUtil.getResources().mvpAssets.ryuvsyuta;
        local u73 = vfxUtil.mvp_cutscene_defaults(mainreplication, p70);
        local Root = vfxUtil.getRoot(u69);
        u73:Add(function() -- Line: 525
            -- upvalues: vfxUtil (ref)
            vfxUtil.restore_lighting();
        end);
        local _, v74 = mainreplication.cutsceneCamRigWithLetterBox(Root, ryuvsyuta.Camera, ryuvsyuta.FOV, nil, "default", ryuvsyuta.Cam3, "CamPart");
        u73:Add(v74);
        local v75 = u73:Clone(ryuvsyuta.VFX);
        v75:PivotTo(u69:GetPivot());
        v75.Parent = workspace.Effects;
        animationUtil:loadAnimation(v75:FindFirstChild("Rika"), ryuvsyuta.Rika):Play(0);
        local v76 = u73:Add(vfxUtil.getMoonEffects());
        local v77 = {
            Vignette = v76.Vignette,
            ["Screen Cover"] = v76["Screen Cover"],
            Lighting = Lighting,
            Workspace = v75
        };

        if p72 then
            p72 = p72[1];
        end;

        local v78;

        if p72 then
            v78 = Players:GetPlayerFromCharacter(p72);
        else
            v78 = p72;
        end;

        local u79 = v78 and v78.DisplayName or (p72 and p72.Name or "Okkotsu");
        u73:Add(task.delay(6.5, function() -- Line: 552
            -- upvalues: u73 (copy), TekrinnDialogue (ref), u79 (copy)
            u73:Add(TekrinnDialogue.Speak(u79, {
                {
                    Text = "Just this once, ",
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
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 115, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Text = "alright?",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(246, 175, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 115, 220)) })
                }
            }, 2, "rbxassetid://0", Color3.fromRGB(200, 115, 220)));
        end));
        u73:Add(task.delay(16, function() -- Line: 591
            -- upvalues: u73 (copy), TekrinnDialogue (ref), u69 (copy), u79 (copy)
            u73:Add(TekrinnDialogue.Speak(u69, {
                {
                    Text = "Are you my dessert, ",
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
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(41, 118, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                },
                {
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    Text = `{string.upper(u79)}!!`,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4.5,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(41, 118, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 4, "rbxassetid://0", Color3.fromRGB(41, 118, 220)));
        end));
        vfxUtil.contain_lighting(u73, v77, ryuvsyuta.Lighting);
        local v80 = u73:Construct(MoonPropertyAnimator);
        v80:LoadAndConvertSave(ryuvsyuta.Moon, v77);
        v80:SetOriginalRoot(CFrame.new(0, 3, 0));
        v80:SetRoot(Root);
        v80:PlayAll();
        vfxUtil.execute_compiled(ryuvsyuta.Compiled, u73, v75);
        soundUtil:play(ryuvsyuta.soundmvp, "default");
    end,

    mvp_kanekimvp = function(u81: any, p82: number) -- Line: 642, Name: mvp_kanekimvp
        -- upvalues: vfxUtil (copy), mainreplication (copy), mvpAssets (copy), Players (copy), soundUtil (copy), animationUtil (copy), TekrinnDialogue (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local Root = vfxUtil.getRoot(u81);
        local u83 = vfxUtil.mvp_cutscene_defaults(mainreplication, p82);
        local kanekimvp = mvpAssets.kanekimvp;
        u83:Add(function() -- Line: 647
            -- upvalues: vfxUtil (ref)
            vfxUtil.restore_lighting();
        end);
        u83:Add(vfxUtil.buildFromRig(u81, kanekimvp.User), "Destroy");
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(u81);
        local u84;

        if PlayerFromCharacter then
            u84 = u83:Construct(vfxUtil.newRigForFriend, Root, PlayerFromCharacter);
        else
            u84 = u83:Construct(vfxUtil.newRig, Root);
        end;

        soundUtil:play(kanekimvp.soundmvp, "default");
        animationUtil:loadAnimation(u84, kanekimvp.Rize):Play(0);
        local v85, v86 = mainreplication.cutsceneCamRigWithLetterBox(Root, kanekimvp.Camera, kanekimvp.FOV, nil, "default", kanekimvp.Cam1, "CamPart");
        u83:Add(v86);
        local u87 = u83:Clone(kanekimvp.VFX);
        u87:PivotTo(u81:GetPivot());
        u87.Parent = workspace.Effects;
        local u88 = Players:GetPlayerFromCharacter(u81) and Players:GetPlayerFromCharacter(u81).DisplayName or u81.Name;
        u83:Add(task.spawn(function() -- Line: 675
            -- upvalues: animationUtil (ref), u87 (copy), kanekimvp (copy)
            for _, v in { "kagune", "kagune_2", "kagune_3", "kagune_4" } do
                animationUtil:loadAnimation(u87:FindFirstChild(v), kanekimvp:FindFirstChild(v)):Play();
            end;
        end));
        u83:Add(task.delay(0, function() -- Line: 682
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u81 (copy)
            u83:Add(TekrinnDialogue.Speak(u81, {
                {
                    Text = "I wish you would have chosen me...!",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    },
                    Color = ColorSequence.new(Color3.new(1, 1, 1))
                }
            }, 1.5, "rbxassetid://99863411589933", Color3.fromRGB(85, 85, 127)));
        end));
        u83:Add(task.delay(2.683333333333333, function() -- Line: 701
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u81 (copy)
            u83:Add(TekrinnDialogue.Speak(u81, {
                {
                    Text = "I wish you would have lived... ",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.045,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = false,
                        Intensity = 0.1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new(Color3.new(1, 1, 1))
                },
                {
                    Text = "for me!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 0)) })
                }
            }, 3, "rbxassetid://99863411589933", Color3.fromRGB(85, 85, 127)));
        end));
        u83:Add(task.delay(7.6, function() -- Line: 737
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u84 (ref)
            u83:Add(TekrinnDialogue.Speak(u84.Name, {
                {
                    Text = "Even if it meant forsaking your ",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.022,
                    HigherUp = true,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = false,
                        Intensity = 0.1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                },
                {
                    Text = "teammate?",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.045,
                    HigherUp = true,
                    TextStrokeColor = Color3.fromRGB(170, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 4
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
                }
            }, 1.8, "rbxassetid://132442981299006", Color3.fromRGB(170, 85, 255)));
        end));
        u83:Add(task.delay(9.466666666666667, function() -- Line: 776
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u81 (copy)
            u83:Add(TekrinnDialogue.Speak(u81, {
                {
                    Text = "Even if it meant that!",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    },
                    Color = ColorSequence.new(Color3.new(1, 1, 1))
                }
            }, 1.5, "rbxassetid://99863411589933", Color3.fromRGB(85, 85, 127)));
        end));
        u83:Add(task.delay(11.233333333333333, function() -- Line: 795
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u84 (ref)
            u83:Add(TekrinnDialogue.Speak(u84.Name, {
                {
                    Text = "Even if it meant hurting ",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.022,
                    HigherUp = true,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = false,
                        Intensity = 0.1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                },
                {
                    Text = "someone?",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    HigherUp = true,
                    TextStrokeColor = Color3.fromRGB(170, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 4
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
                }
            }, 1.5, "rbxassetid://132442981299006", Color3.fromRGB(170, 85, 255)));
        end));
        u83:Add(task.delay(12.733333333333333, function() -- Line: 834
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u81 (copy)
            u83:Add(TekrinnDialogue.Speak(u81, {
                {
                    Text = "Even if it meant that!",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 6
                    },
                    Color = ColorSequence.new(Color3.new(1, 1, 1))
                }
            }, 1, "rbxassetid://99863411589933", Color3.fromRGB(85, 85, 127)));
        end));
        u83:Add(task.delay(13.95, function() -- Line: 853
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u84 (ref)
            u83:Add(TekrinnDialogue.Speak(u84.Name, {
                {
                    Text = "Even if it meant taking their ",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.022,
                    HigherUp = true,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = false,
                        Intensity = 0.1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                },
                {
                    Text = "life?",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    HigherUp = true,
                    TextStrokeColor = Color3.fromRGB(170, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
                }
            }, 1.5, "rbxassetid://132442981299006", Color3.fromRGB(170, 85, 255)));
        end));
        u83:Add(task.delay(15.733333333333333, function() -- Line: 892
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u81 (copy)
            u83:Add(TekrinnDialogue.Speak(u81, {
                {
                    Text = "EVEN IF IT MEAN\'T THAT!",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 8
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 0)) })
                }
            }, 1.5, "rbxassetid://99863411589933", Color3.fromRGB(85, 85, 127)));
        end));
        u83:Add(task.delay(17.966666666666665, function() -- Line: 914
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u84 (ref)
            u83:Add(TekrinnDialogue.Speak(u84.Name, {
                {
                    Text = "Good boy~",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.05,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = false,
                        Intensity = 4,
                        Lifetime = 8
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 85, 255)) })
                }
            }, 1, "rbxassetid://132442981299006", Color3.fromRGB(170, 85, 255)));
        end));
        u83:Add(task.delay(20.083333333333332, function() -- Line: 936
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u84 (ref), u88 (copy)
            u83:Add(TekrinnDialogue.Speak(u84.Name, {
                {
                    Text = "That\'s right, ",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.022,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = false,
                        Intensity = 0.1,
                        Lifetime = 3
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                },
                {
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    HigherUp = false,
                    Text = `{u88}-kun.`,
                    TextStrokeColor = Color3.fromRGB(170, 85, 127),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 4
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 255)) })
                }
            }, 1.5, "rbxassetid://132442981299006", Color3.fromRGB(170, 85, 255)));
        end));
        u83:Add(task.delay(22.883333333333333, function() -- Line: 975
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u81 (copy)
            u83:Add(TekrinnDialogue.Speak(u81, {
                {
                    Text = "I am...",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.06,
                    HigherUp = false,
                    TextStrokeColor = Color3.new(),
                    Shake = {
                        Enabled = false,
                        Intensity = 4,
                        Lifetime = 8
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                }
            }, 2, "rbxassetid://85959121116372", Color3.fromRGB(170, 0, 0)));
        end));
        u83:Add(task.delay(24.766666666666666, function() -- Line: 997
            -- upvalues: u83 (copy), TekrinnDialogue (ref), u81 (copy)
            u83:Add(TekrinnDialogue.Speak(u81, {
                {
                    Text = "A GHOUL.",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.06,
                    HigherUp = false,
                    TextStrokeColor = Color3.fromRGB(255, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 0.5
                    },
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 0)) })
                }
            }, 1, "rbxassetid://85959121116372", Color3.fromRGB(170, 0, 0)));
        end));
        local v89 = u83:Add(vfxUtil.getMoonEffects());
        local v90 = {
            Vignette = v89.Vignette,
            ["Screen Cover"] = v89["Screen Cover"],
            Lighting = Lighting,
            Workspace = u87
        };
        local v91 = u83:Construct(MoonPropertyAnimator);
        v91:LoadAndConvertSave(kanekimvp.Moon, v90);
        v91:SetOriginalRoot(CFrame.new(0, 0, 0));
        v91:SetRoot(Root);
        v91:PlayAll();
        vfxUtil.execute_compiled(kanekimvp.Compiled, u83, u87, u81, v85);
    end,

    mvp_flowerymvp = function(p92: any, p93: number) -- Line: 1037, Name: mvp_flowerymvp
        -- upvalues: vfxUtil (copy), mainreplication (copy), mvpAssets (copy), soundUtil (copy), Resources (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local Root = vfxUtil.getRoot(p92);
        local v94 = vfxUtil.mvp_cutscene_defaults(mainreplication, p93);
        local flowerymvp = mvpAssets.flowerymvp;
        soundUtil:play(flowerymvp.SFX, "default");
        local v95, v96 = mainreplication.cutsceneCamRigWithLetterBox(Root, flowerymvp.Animations.Cam, flowerymvp.FOV_Flowery, nil, CFrame.new(0, 2, 0), Resources.CameraRig, "Bone");
        v94:Add(v96);
        local v97 = v94:Clone(flowerymvp["Accessory (Front Jacket over Nonglow)"]);
        v97.Parent = p92;
        v97.Handle.AccessoryWeld.Part1 = p92.Torso;
        local v98 = v94:Clone(flowerymvp.VFX);
        v98:PivotTo(p92:GetPivot());
        v98.Parent = workspace.Effects;
        local v99 = {};

        for _, child in v98:GetChildren() do
            local v100 = 0;

            while true do
                if v100 == 0 then
                    v100 = -1;

                    if child:IsA("Attachment") then
                        v100 = 2;
                        continue;
                    end;

                    v100 = 1;
                    continue;
                elseif v100 == 1 then
                    v100 = -1;
                    v99[child.Name] = child;
                    v100 = 3;
                    continue;
                elseif v100 == 2 then
                    v100 = -1;

                    if child.Name ~= "Side1" then
                        v94:Add(child).Parent = p92.Head;
                        v100 = 1;
                        continue;
                    end;

                    child.Parent = v95.Bone;
                    v100 = 3;
                    continue;
                elseif v100 == 3 then
                    v100 = -1;
                    break;
                else
                    break;
                end;
            end;
        end;

        local u101 = v94:Clone(flowerymvp.ScreenGui);
        u101.Enabled = true;
        u101.Parent = vfxUtil.getPlayerGui();
        v94:Add(task.delay(9.86, function() -- Line: 1084
            -- upvalues: u101 (copy)
            u101.ImageLabel.ImageTransparency = 0;
            task.wait(1.7);
            u101.ImageLabel.ImageTransparency = 1;
        end));
        local v102 = {
            Vignette = v94:Add(vfxUtil.getMoonEffects()).Vignette,
            Lighting = Lighting,
            Workspace = v98
        };
        vfxUtil.cutscene_lighting(v94, v102, flowerymvp.Lighting, {
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            ExposureCompensation = 0,
            ClockTime = 2.625,
            GeographicLatitude = 28.949,
            Ambient = Color3.fromRGB(118, 52, 193),
            ColorShift_Bottom = Color3.new(0.00784314, 0.00784314, 0.00784314),
            ColorShift_Top = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.fromRGB(96, 57, 118)
        });

        if workspace.Terrain:FindFirstChild("Clouds") then
            workspace.Terrain.Clouds.Enabled = false;
            v94:Add(function() -- Line: 1112
                workspace.Terrain.Clouds.Enabled = true;
            end);
        end;

        local v103 = v94:Construct(MoonPropertyAnimator);
        v103:LoadAndConvertSave(flowerymvp.Moon, v102);
        v103:SetOriginalRoot(CFrame.new(-0.266, 3, 0.556));
        v103:SetRoot(Root);
        v103:PlayAll();
        vfxUtil.execute_compiled(flowerymvp.Compiled, v94, v99, v95);
    end,

    mvp_rienMVP = function(u104: any, p105: number) -- Line: 1126, Name: mvp_rienMVP
        -- upvalues: vfxUtil (copy), mainreplication (copy), wiki (copy), trove (copy), RunService (copy), Lighting (copy), animationUtil (copy), soundUtil (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy)
        local Root = vfxUtil.getRoot(u104);
        local u106 = vfxUtil.mvp_cutscene_defaults(mainreplication, p105);
        local Rien = vfxUtil.getResources().roland.MVPs.Rien;
        local rienMVP = wiki.mvp_anim.rienMVP;

        if rienMVP.customCFrame then
            u104:PivotTo(rienMVP.customCFrame);
        elseif workspace:FindFirstChild("map") and workspace.map:FindFirstChild("something") then
            u104:PivotTo(workspace.map.something.mvpCF.CFrame);
        end;

        Root.Anchored = true;
        u106:Add(function() -- Line: 1138
            -- upvalues: Root (copy)
            Root.Anchored = false;
        end);
        u106:Add(function() -- Line: 1142
            -- upvalues: vfxUtil (ref)
            vfxUtil.restore_lighting();
            vfxUtil.restore_lighting_properties();
        end);
        local u107 = u106:Clone(Rien.VFX);
        u107:PivotTo(Root.CFrame);
        u107.Parent = workspace.Effects;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local v108 = u106:Add(vfxUtil.getMoonEffects());
        u106:Add(task.spawn(function() -- Line: 1156
            -- upvalues: mainreplication (ref), Root (copy), Rien (copy), u106 (copy), trove (ref), RunService (ref), workspace_CurrentCamera (copy), u107 (copy)
            local u109, v110 = mainreplication.cutsceneCamRigWithLetterBox(Root, Rien.Animations.Cam, Rien.FOV, nil, "default", Rien["the rien camera"], "Camera");
            u106:Add(v110);
            u109:SetAttribute("Paused", true);
            local v111 = trove.new();
            v111:Add(function() -- Line: 1168
                -- upvalues: u109 (copy)
                u109:SetAttribute("Paused", nil);
            end);
            v111:Add(RunService.RenderStepped:Connect(function() -- Line: 1171
                -- upvalues: workspace_CurrentCamera (ref), u107 (ref)
                workspace_CurrentCamera.CFrame = u107.BossBattle.ProeliumFatale.CamPart.CFrame;
            end));
            u106:Add(task.delay(4, v111.Destroy, v111));
        end));
        u106:Add(vfxUtil.buildFromRig(u104, Rien["ree en"]), "Destroy");
        local v112 = {
            Vignette = v108.Vignette,
            Lighting = Lighting,
            ["Screen Cover"] = v108["Screen Cover"],
            ["ree en"] = u104
        };
        local Beeper = u104:FindFirstChild("Beeper");
        local Oracle = u104:FindFirstChild("Oracle");

        local function show(p113: userdata) -- Line: 1196
            for _, v in p113:QueryDescendants("BasePart") do
                v.Transparency = 0;
            end;
        end;

        local function hide(p114: userdata) -- Line: 1190
            for _, v in p114:QueryDescendants("BasePart") do
                v.Transparency = 1;
            end;
        end;

        for _, v in Beeper:QueryDescendants("BasePart") do
            v.Transparency = 1;
        end;

        for _, v in Oracle:QueryDescendants("BasePart") do
            v.Transparency = 1;
        end;

        u106:Add(task.delay(29.133333333333333, show, Beeper));
        u106:Add(task.delay(36.1, hide, Beeper));
        u106:Add(task.delay(36.916666666666664, show, Oracle));
        u106:Add(animationUtil:loadAnimation(u107.BossBattle.ProeliumFatale, Rien.Animations.ProeliumFatale), "Stop"):Play(0);
        u106:Add(animationUtil:loadAnimation(u104, Rien.Animations.User), "Stop"):Play(0);
        soundUtil:play(Rien.sound, "default");
        u106:Add(task.spawn(function() -- Line: 1212
            -- upvalues: u106 (copy), TekrinnDialogue (ref), u104 (copy)
            u106:Add(task.delay(4, function() -- Line: 1213
                -- upvalues: u106 (ref), TekrinnDialogue (ref), u104 (ref)
                u106:Add(TekrinnDialogue.Speak(u104, {
                    {
                        Text = "....If I let you go here, you will never come home again.",
                        Bold = false,
                        Italic = true,
                        TypeSpeed = 0.03,
                        HigherUp = false,
                        TextStrokeColor = Color3.new(),
                        Shake = {
                            Enabled = false,
                            Intensity = 2,
                            Lifetime = 4
                        },
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) })
                    }
                }, 5, "rbxassetid://137351805852238", Color3.fromRGB(170, 255, 255)));
            end));
            u106:Add(task.delay(12, function() -- Line: 1235
                -- upvalues: u106 (ref), TekrinnDialogue (ref), u104 (ref)
                u106:Add(TekrinnDialogue.Speak(u104, {
                    {
                        Text = "I could force you to stay, but I\'d get nothing out of it.",
                        Bold = false,
                        Italic = true,
                        TypeSpeed = 0.03,
                        HigherUp = false,
                        TextStrokeColor = Color3.new(),
                        Shake = {
                            Enabled = false,
                            Intensity = 2,
                            Lifetime = 4
                        },
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) })
                    }
                }, 2.3, "rbxassetid://137351805852238", Color3.fromRGB(170, 255, 255)));
            end));
            u106:Add(task.delay(15, function() -- Line: 1257
                -- upvalues: u106 (ref), TekrinnDialogue (ref), u104 (ref)
                u106:Add(TekrinnDialogue.Speak(u104, {
                    {
                        Text = "But that\'s still better than letting this empty regret burrow through the heart, isn\'t it?",
                        Bold = false,
                        Italic = true,
                        TypeSpeed = 0.03,
                        HigherUp = false,
                        TextStrokeColor = Color3.new(),
                        Shake = {
                            Enabled = false,
                            Intensity = 2,
                            Lifetime = 4
                        },
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) })
                    }
                }, 10.5, "rbxassetid://137351805852238", Color3.fromRGB(170, 255, 255)));
            end));
            u106:Add(task.delay(30.483333333333334, function() -- Line: 1279
                -- upvalues: u106 (ref), TekrinnDialogue (ref), u104 (ref)
                u106:Add(TekrinnDialogue.Speak(u104, {
                    {
                        Text = "......",
                        Bold = false,
                        Italic = true,
                        TypeSpeed = 0.03,
                        HigherUp = false,
                        TextStrokeColor = Color3.new(),
                        Shake = {
                            Enabled = true,
                            Intensity = 2,
                            Lifetime = 4
                        },
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                    }
                }, 2, "rbxassetid://137351805852238", Color3.fromRGB(170, 255, 255)));
            end));
            u106:Add(task.delay(34.333333333333336, function() -- Line: 1301
                -- upvalues: u106 (ref), TekrinnDialogue (ref), u104 (ref)
                u106:Add(TekrinnDialogue.Speak(u104, {
                    {
                        Text = "Hah. Alright. Let\'s get started.",
                        Bold = false,
                        Italic = true,
                        TypeSpeed = 0.03,
                        HigherUp = false,
                        TextStrokeColor = Color3.new(),
                        Shake = {
                            Enabled = false,
                            Intensity = 2,
                            Lifetime = 4
                        },
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) })
                    }
                }, 6, "rbxassetid://137351805852238", Color3.fromRGB(170, 255, 255)));
            end));
        end));
        vfxUtil.cutscene_lighting(u106, v112, Rien.Lighting, {
            Brightness = 4,
            ClockTime = 2,
            GeographicLatitude = 1,
            Ambient = Color3.fromRGB(49, 47, 49),
            ColorShift_Top = Color3.fromRGB(0, 0, 0),
            ColorShift_Bottom = Color3.fromRGB(0, 0, 0),
            OutdoorAmbient = Color3.fromRGB(235, 235, 235)
        });
        vfxUtil.execute_compiled(Rien.Compiled, u106, u107, u104);
        local v115 = u106:Construct(MoonPropertyAnimator);
        v115:LoadAndConvertSave(Rien.Moon, v112);
        v115:SetRoot(Root);
        v115:PlayAll();
    end
};

local function stupidfingersihatethissomuch(p117, p118, p119) -- Line: 1342
    local u120 = p119:Clone(p118.Fingers:Clone());
    u120.Parent = p117;
    u120["Left Arm Fingers"]["Left Arm Fingers"].Part0 = p117["Left Arm"];
    u120["Right Arm Fingers"]["Right Arm Fingers"].Part0 = p117["Right Arm"];

    for _, descendant in u120:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Parent:IsA("Folder") then
            if string.sub(descendant.Name, 1, 2) == "L-" then
                descendant.Color = p117["Left Arm"].Color;
            else
                descendant.Color = p117["Right Arm"].Color;
            end;
        end;
    end;

    return function(p121) -- Line: 1359
        -- upvalues: u120 (copy)
        for _, descendant in u120:GetDescendants() do
            if descendant:IsA("BasePart") and descendant.Parent:IsA("Folder") then
                descendant.Transparency = p121;
            end;
        end;
    end;
end;

function v116.mvp_starboymvp(p122: any, p123: number) -- Line: 1368
    -- upvalues: vfxUtil (copy), mainreplication (copy), stupidfingersihatethissomuch (copy), Util (copy), animationUtil (copy), Lighting (copy), soundUtil (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p122);
    local v124 = vfxUtil.mvp_cutscene_defaults(mainreplication, p123);
    local starboymvp = vfxUtil.getResources().mvpAssets.starboymvp;
    local v125 = stupidfingersihatethissomuch(p122, starboymvp, v124);
    v124:Add(function() -- Line: 1375
        -- upvalues: vfxUtil (ref)
        vfxUtil.restore_lighting();
        vfxUtil.restore_lighting_properties();
    end);
    local u126 = v124:Clone(starboymvp.Lycris);
    u126.Parent = vfxUtil.getPlayerGui();
    v124:Add(task.delay(10.1, function() -- Line: 1383
        -- upvalues: u126 (copy)
        u126.Enabled = true;
        local TextoCentro = u126:WaitForChild("TextoCentro");

        for _, v in { { "I\'M", 0.23 }, { "A", 0.23 }, { "FREAKING", 0.5 }, { "STARBOY", 1 } } do
            TextoCentro.Text = v[1];
            TextoCentro.Visible = true;
            task.wait(v[2]);
            TextoCentro.Visible = false;
        end;
    end));
    v124:Add(Util.Preload(starboymvp.ImpactFrames));
    v124:Add(task.delay(5.45, Util.Gif, starboymvp.ImpactFrames, 24));
    v124:Add(task.delay(5.45, v125, 0));
    local v127 = v124:Add(vfxUtil.newRigForFriend(Root));
    local v128 = v124:Add(vfxUtil.newRigForFriend(Root));
    v124:Add(vfxUtil.buildFromRig(v127, starboymvp.SodaGuy));

    for i, v in { v127, v128 } do
        if v then
            v124:Add(animationUtil:loadAnimation(v, starboymvp.Animations.Victims[`Victim{i}`]), "Stop"):Play(0);
        end;
    end;

    local v129 = v124:Clone(starboymvp.Map);
    v129:PivotTo(Root.CFrame);
    v129.Parent = workspace.Effects;
    local v130 = v124:Clone(starboymvp.VFX);
    v130:PivotTo(Root.CFrame);
    v130.Parent = workspace.Effects;
    v124:Add(v130.Eyelight).Parent = p122.Head;
    v124:Add(vfxUtil.getMoonEffects());
    local v131, v132 = mainreplication.cutsceneBlender(Root, starboymvp.Animations.Cam, starboymvp.FOV_Starboy, nil, nil, CFrame.new(0, -3, 0), starboymvp.Cam);
    v124:Add(v132);
    local v133 = {
        Lighting = Lighting,
        Workspace = v130,
        Black = v130.Black
    };
    soundUtil:play(starboymvp.SFX, "default");
    vfxUtil.cutscene_lighting(v124, v133, starboymvp.Lighting, {
        Brightness = 3,
        ClockTime = 14.5,
        GeographicLatitude = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        ColorShift_Top = Color3.new(),
        ColorShift_Bottom = Color3.new(),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    vfxUtil.execute_compiled(starboymvp.Compiled, v124, v130, v131, p122);
    local v134 = v124:Construct(MoonPropertyAnimator);
    v134:LoadAndConvertSave(starboymvp.Moon, v133);
    v134:SetOriginalRoot(CFrame.new(0, 3, 0));
    v134:SetRoot(Root);
    v134:PlayAll();
end;

function v116.mvp_ulquiorra(p135: any, p136: number) -- Line: 1469
    -- upvalues: vfxUtil (copy), mainreplication (copy), wiki (copy), animationUtil (copy), Players (copy), Lighting (copy), soundUtil (copy), Util (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p135);
    local v137 = vfxUtil.mvp_cutscene_defaults(mainreplication, p136);
    local ulquiorra = vfxUtil.getResources().mvpAssets.ulquiorra;
    local ulquiorra2 = wiki.mvp_anim.ulquiorra;

    if ulquiorra2.customCFrame then
        p135:PivotTo(ulquiorra2.customCFrame);
    elseif workspace:FindFirstChild("map") and workspace.map:FindFirstChild("something") then
        p135:PivotTo(workspace.map.something.mvpCF.CFrame);
    end;

    Root.Anchored = true;
    v137:Add(function() -- Line: 1482
        -- upvalues: Root (copy)
        Root.Anchored = false;
    end);
    v137:Add(function() -- Line: 1486
        -- upvalues: vfxUtil (ref)
        vfxUtil.restore_lighting();
        vfxUtil.restore_lighting_properties();
    end);
    local v138 = v137:Clone(ulquiorra.VFX);
    v138:PivotTo(Root.CFrame);
    v138.Parent = workspace.Effects;
    local _, v139 = mainreplication.cutsceneCamRigWithLetterBox(Root, ulquiorra.Animations.Camera, ulquiorra.FOV, nil, "default", ulquiorra.cam, "CamPart");
    v137:Add(v139);
    local v140 = v137:Add(vfxUtil.getMoonEffects());
    v137:Add(vfxUtil.buildFromRig(p135, ulquiorra.Ulquiorra), "Destroy");
    v137:Add(animationUtil:loadAnimation(p135, ulquiorra.Animations.User), "Stop"):Play(0);
    v137:Add(animationUtil:loadAnimation(p135:FindFirstChild("ulquiorra thing"), ulquiorra.Animations.Wings), "Stop"):Play(0);
    local v141 = v137:Clone(ulquiorra.ScreenGui);
    v141.Parent = Players.LocalPlayer.PlayerGui;
    local v142 = {
        Vignette = v140.Vignette,
        Lighting = Lighting,
        ["Screen Cover"] = v140["Screen Cover"],
        Workspace = v138,
        silhouette = p135:FindFirstChildOfClass("Highlight")
    };
    soundUtil:play(ulquiorra.SFX, "default");
    v137:Add(Util.Preload(v141.Frame, false));

    for _, child in v141.Frame:GetChildren() do
        v142[child.Name] = child;
    end;

    vfxUtil.cutscene_lighting(v137, v142, ulquiorra.Lighting, {
        Brightness = 1.51,
        ClockTime = 14.374,
        GeographicLatitude = 20.628,
        Ambient = Color3.fromRGB(33, 41, 49),
        ColorShift_Bottom = Color3.fromRGB(63, 71, 90),
        ColorShift_Top = Color3.fromRGB(164, 216, 255),
        OutdoorAmbient = Color3.fromRGB(56, 70, 70)
    });
    vfxUtil.execute_compiled(ulquiorra.Compiled, v137, v138, p135);
    local v143 = v137:Construct(MoonPropertyAnimator);
    v143:LoadAndConvertSave(ulquiorra.Moon, v142);
    v143:SetOriginalRoot(CFrame.new(0, 3, 0));
    v143:SetRoot(Root);
    v143:PlayAll();
end;

function v116.mvp_deathkid(p144: any, p145: number) -- Line: 1547
    -- upvalues: vfxUtil (copy), mainreplication (copy), animationUtil (copy), soundUtil (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p144);
    local v146 = vfxUtil.mvp_cutscene_defaults(mainreplication, p145);
    local deathkid = vfxUtil.getResources().mvpAssets.deathkid;
    v146:Add(vfxUtil.buildFromRig(p144, deathkid.Rig), "Destroy");
    v146:Add(animationUtil:loadAnimation(p144, deathkid.Animations.User), "Stop"):Play(0);
    local v147 = v146:Clone(deathkid.VFX);
    v147:PivotTo(Root.CFrame);
    v147.Parent = workspace.Effects;
    local v148 = v146:Add(mainreplication.kuronaCamToAll(Root, deathkid.Cam, deathkid.FOV));
    local v149 = {
        Workspace = v147
    };
    soundUtil:play(deathkid.SFX, "default");
    vfxUtil.cutscene_lighting(v146, v149, deathkid.Lighting, {
        Brightness = 3,
        ClockTime = 4.61,
        GeographicLatitude = 104.754,
        Ambient = Color3.fromRGB(70, 70, 70),
        ColorShift_Top = Color3.new(0, 0, 0),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    vfxUtil.execute_compiled(deathkid.Compiled, v146, p144, v147, v148);
    local v150 = v146:Construct(MoonPropertyAnimator);
    v150:LoadAndConvertSave(deathkid.Moon, v149);
    v150:SetOriginalRoot(CFrame.new(0, 3, 0));
    v150:SetRoot(Root);
    v150:PlayAll();
end;

function v116.mvp_nightfallsMVP(u151: any, p152: number) -- Line: 1587
    -- upvalues: vfxUtil (copy), mainreplication (copy), animationUtil (copy), Util (copy), soundUtil (copy), MoonPropertyAnimator (copy)
    local nightfallsMVP = vfxUtil.getResources().mvpAssets.nightfallsMVP;
    local Root = vfxUtil.getRoot(u151);
    local u153 = vfxUtil.mvp_cutscene_defaults(mainreplication, p152);
    local v154 = u153:Clone(nightfallsMVP.Models.Map);
    v154:PivotTo(Root.CFrame);
    v154.Parent = workspace.Effects;
    local u155 = u153:Clone(nightfallsMVP.Models.Vfx);
    u155:PivotTo(Root.CFrame);
    u155.Parent = workspace.Effects;
    task.defer(function() -- Line: 1601
        -- upvalues: u151 (copy), u153 (copy), vfxUtil (ref), Root (copy), animationUtil (ref), nightfallsMVP (copy), u155 (copy)
        local Archivable = u151.Archivable;
        u153:Add(animationUtil:loadAnimation(u153:Add(vfxUtil.newRigForFriend(Root)), nightfallsMVP.Animations.Friend), "Stop"):Play(0);
        u151.Archivable = true;
        local v156 = u153:Clone(u151);
        u151.Archivable = Archivable;
        local HumanoidRootPart = v156:FindFirstChild("HumanoidRootPart");
        local v157 = HumanoidRootPart and HumanoidRootPart:FindFirstChild("Cam");

        if v157 then
            v157:Destroy();
        end;

        v156:PivotTo(Root.CFrame);
        v156.Parent = workspace.Effects;
        u153:Add(vfxUtil.buildFromRig(v156, nightfallsMVP.Models.EverNight2));
        u153:Add(animationUtil:loadAnimation(v156, nightfallsMVP.Animations.SECOND), "Stop"):Play(0);
        u155.FakeHead2.Weld.Part1 = v156.Head;
    end);

    for i = 1, 6 do
        local v158 = u155:FindFirstChild((`flowerthingy{i}`));
        local v159;

        if v158 then
            u153:Add(animationUtil:loadAnimation(v158, nightfallsMVP.Animations.Flowers[i]), "Stop"):Play(0);
            v159 = i;
        else
            v159 = i;
        end;
    end;

    local v160, v161 = mainreplication.cutsceneCamRigWithLetterBox(Root, nightfallsMVP.Animations.Cam, nightfallsMVP.FOV_NightFalls, nil, CFrame.identity, nightfallsMVP.Models.Cam, "CamPart");
    u153:Add(v161);
    u155.CamVFX.Weld.Part1 = v160.CamPart;
    u155.FakeHead.Weld.Part1 = u151.Head;
    local u162 = {};

    for _, child in nightfallsMVP.ImpactFrames:GetChildren() do
        u162[child.Name] = Util.Preload(child);
    end;

    u153:Add(function() -- Line: 1656
        -- upvalues: u162 (copy)
        for _, v in u162 do
            v:Destroy();
        end;

        table.clear(u162);
    end);
    u153:Add(task.delay(13.066666666666666, Util.Gif, nightfallsMVP.ImpactFrames["1"], 24));
    u153:Add(task.delay(14.133333333333333, Util.Gif, nightfallsMVP.ImpactFrames["2"], 24));
    u153:Add(task.delay(16.25, Util.Gif, nightfallsMVP.ImpactFrames["3"], 10));
    local MoonEffects = vfxUtil.getMoonEffects();
    u153:Add(MoonEffects);
    local v163 = {
        Workspace = u155,
        ["Screen Cover"] = MoonEffects["Screen Cover"]
    };
    vfxUtil.cutscene_lighting(u153, v163, nightfallsMVP.Lighting, {
        Brightness = 3,
        ExposureCompensation = 0,
        ClockTime = 14.5,
        GeographicLatitude = 0,
        ShadowSoftness = 0.2,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70),
        ColorShift_Top = Color3.new(0, 0, 0),
        ColorShift_Bottom = Color3.new(0, 0, 0)
    });
    soundUtil:play(nightfallsMVP.soundmvp, "default");
    vfxUtil.execute_compiled(nightfallsMVP.Compiled, u153, u155);
    local v164 = u153:Construct(MoonPropertyAnimator);
    v164:LoadAndConvertSave(nightfallsMVP.Moon, v163);
    v164:SetOriginalRoot(CFrame.new(0, 3, 0));
    v164:SetRoot(Root);
    v164:PlayAll();
end;

function v116.mvp_visionary(u165: any, p166: number) -- Line: 1701
    -- upvalues: vfxUtil (copy), mainreplication (copy), TekrinnDialogue (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(u165);
    local v167 = vfxUtil.mvp_cutscene_defaults(mainreplication, p166);
    local Player = vfxUtil.getPlayer(u165);
    local gremmyMVP = vfxUtil.getResources().mvpAssets.gremmyMVP;
    local v168 = v167:Clone(gremmyMVP.VFX);
    v168:PivotTo(Root.CFrame);
    v168.Parent = workspace.Effects;
    local _, v169 = mainreplication.cutsceneBlender(Root, gremmyMVP.Animations.Cam, gremmyMVP.FOV_Gremmy);
    v167:Add(v169);
    local v170 = Player and Player.DisplayName or u165.Name;

    if u165:GetAttribute("style") == "gremmy" then
        v170 = "Sternritter V, " .. v170;
    end;

    local u171 = v167:Clone(gremmyMVP.GremmyScreen);
    u171.Parent = vfxUtil.getPlayerGui();
    u171.Frame.MVPName.Text = v170;
    v167:Add(task.delay(4.583333333333333, function() -- Line: 1728
        -- upvalues: TekrinnDialogue (ref), u165 (copy)
        TekrinnDialogue.Speak(u165, {
            {
                Text = "You should consider yourself lucky... getting the chance to fight me.",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 4);
    end));
    v167:Add(task.delay(7.833333333333333, function() -- Line: 1754
        -- upvalues: TekrinnDialogue (ref), u165 (copy)
        TekrinnDialogue.Speak(u165, {
            {
                Text = "After all... I stand above them all, ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            },
            {
                Text = "the strongest of the Sternritters.",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 1.5
                }
            }
        }, 3);
    end));
    v167:Add(task.delay(11.9, function() -- Line: 1802
        -- upvalues: u171 (copy)
        u171.Enabled = true;
    end));
    soundUtil:play(gremmyMVP.SFX, "default");
    local v172 = {
        Workspace = v168,
        Lighting = Lighting
    };
    vfxUtil.cutscene_lighting(v167, v172, gremmyMVP.Lighting);
    vfxUtil.execute_compiled(gremmyMVP.Compiled, v167, v168);
    local v173 = v167:Construct(MoonPropertyAnimator);
    v173:LoadAndConvertSave(gremmyMVP.Moon, v172);
    v173:SetOriginalRoot(gremmyMVP.VFX.Root.CFrame);
    v173:SetRoot(Root);
    v173:PlayAll();
end;

function v116.mvp_memoryshard(u174: any, p175: number, p176: any, u177: any) -- Line: 1823
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), KatUtil (copy), TekrinnDialogue (copy), soundUtil (copy)
    local memoryshard = mvpAssets.memoryshard;
    local Animations = memoryshard.Animations;
    local Root = vfxUtil.getRoot(u174);
    local u178 = vfxUtil.mvp_cutscene_defaults(mainreplication, p175);
    local _, v179, u180 = mainreplication.cutsceneBlender(Root, Animations.Cam, memoryshard.FOV_Eren);
    u178:Add(v179);

    if u180 then
        u178:Add(task.spawn(function() -- Line: 1834
            -- upvalues: KatUtil (ref), u174 (copy), Animations (copy), u178 (copy), u180 (copy)
            local _track = KatUtil.get_track(u174, Animations.User);

            if not _track then
                return;
            end;

            u178:Add(_track.trove);
            u178:Add(game:GetService("RunService").PreAnimation:Connect(function() -- Line: 1841
                -- upvalues: _track (copy), u180 (ref)
                local track = _track.track;

                if track.IsPlaying and (track.Length > 0 and u180.Length > 0) then
                    u180.TimePosition = track.TimePosition;
                    u180:AdjustSpeed(track.Speed);
                end;
            end));
        end));
    end;

    u178:Add(task.delay(1.1833333333333333, function() -- Line: 1851
        -- upvalues: TekrinnDialogue (ref), u174 (copy), u177 (copy)
        TekrinnDialogue.Speak(u174, {
            {
                Text = "What the hell are you doing? Stand up, ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.055,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.new(1, 1, 1)
                        },
                        {
                            Time = 1,
                            Value = Color3.new(1, 1, 1)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            },
            {
                Bold = true,
                Italic = false,
                TypeSpeed = 0.055,
                HigherUp = true,
                Text = u177[1].Name,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.fromRGB(120, 255, 120)
                        },
                        {
                            Time = 1,
                            Value = Color3.fromRGB(120, 255, 120)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 0.5
                }
            },
            {
                Text = ".",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.055,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.new(1, 1, 1)
                        },
                        {
                            Time = 1,
                            Value = Color3.new(1, 1, 1)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            }
        }, 4, "rbxassetid://139798283191140");
    end));
    u178:Add(task.delay(8.433333333333334, function() -- Line: 1901
        -- upvalues: TekrinnDialogue (ref), u174 (copy)
        TekrinnDialogue.Speak(u174, {
            {
                Text = "Have you forgotten? What you came to this pitch to do?",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.new(1, 1, 1)
                        },
                        {
                            Time = 1,
                            Value = Color3.new(1, 1, 1)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 0.5
                }
            }
        }, 4, "rbxassetid://139798283191140");
    end));
    u178:Add(task.delay(13.166666666666666, function() -- Line: 1921
        -- upvalues: TekrinnDialogue (ref), u174 (copy)
        TekrinnDialogue.Speak(u174, {
            {
                Text = "Your dream of reaching the world stage... ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.038,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.new(1, 1, 1)
                        },
                        {
                            Time = 1,
                            Value = Color3.new(1, 1, 1)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            },
            {
                Text = "CRUSHED ",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.fromRGB(222, 46, 46)
                        },
                        {
                            Time = 1,
                            Value = Color3.fromRGB(222, 46, 46)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            },
            {
                Text = "in the ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.038,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.new(1, 1, 1)
                        },
                        {
                            Time = 1,
                            Value = Color3.new(1, 1, 1)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            },
            {
                Text = "DUST.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.fromRGB(222, 46, 46)
                        },
                        {
                            Time = 1,
                            Value = Color3.fromRGB(222, 46, 46)
                        }
                    }
                },
                Shake = {
                    Enabled = true,
                    Intensity = 12,
                    Lifetime = 1.2
                }
            }
        }, 4, "rbxassetid://139798283191140");
    end));
    u178:Add(task.delay(18.983333333333334, function() -- Line: 1986
        -- upvalues: TekrinnDialogue (ref), u174 (copy)
        TekrinnDialogue.Speak(u174, {
            {
                Text = "Think about ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.06,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.new(1, 1, 1)
                        },
                        {
                            Time = 1,
                            Value = Color3.new(1, 1, 1)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            },
            {
                Text = "them.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.07,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.fromRGB(222, 46, 46)
                        },
                        {
                            Time = 1,
                            Value = Color3.fromRGB(222, 46, 46)
                        }
                    }
                },
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 0.6
                }
            }
        }, 4, "rbxassetid://139798283191140");
    end));
    u178:Add(task.delay(20.2, function() -- Line: 2022
        -- upvalues: TekrinnDialogue (ref), u174 (copy), u177 (copy)
        TekrinnDialogue.Speak(u174, {
            {
                Bold = true,
                Italic = false,
                TypeSpeed = 0.065,
                HigherUp = true,
                Text = u177[2].Name,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.fromRGB(85, 170, 255)
                        },
                        {
                            Time = 1,
                            Value = Color3.fromRGB(85, 170, 255)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            },
            {
                Text = ", of ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.065,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.new(1, 1, 1)
                        },
                        {
                            Time = 1,
                            Value = Color3.new(1, 1, 1)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            },
            {
                Bold = true,
                Italic = false,
                TypeSpeed = 0.065,
                HigherUp = true,
                Text = u177[3].Name,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.fromRGB(255, 170, 0)
                        },
                        {
                            Time = 1,
                            Value = Color3.fromRGB(255, 170, 0)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            },
            {
                Text = ", and especially ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.065,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.new(1, 1, 1)
                        },
                        {
                            Time = 1,
                            Value = Color3.new(1, 1, 1)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            },
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.075,
                HigherUp = true,
                Text = u177[4].Name,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.fromRGB(222, 46, 46)
                        },
                        {
                            Time = 1,
                            Value = Color3.fromRGB(222, 46, 46)
                        }
                    }
                },
                Shake = {
                    Enabled = true,
                    Intensity = 6,
                    Lifetime = 0.8
                }
            }
        }, 4, "rbxassetid://139798283191140");
    end));
    u178:Add(task.delay(23.533333333333335, function() -- Line: 2102
        -- upvalues: TekrinnDialogue (ref), u174 (copy)
        TekrinnDialogue.Speak(u174, {
            {
                Text = "They think they can block your path...",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.05,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.new(1, 1, 1)
                        },
                        {
                            Time = 1,
                            Value = Color3.new(1, 1, 1)
                        }
                    }
                },
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            }
        }, 4, "rbxassetid://139798283191140");
    end));
    u178:Add(task.delay(25.983333333333334, function() -- Line: 2122
        -- upvalues: TekrinnDialogue (ref), u174 (copy)
        TekrinnDialogue.Speak(u174, {
            {
                Text = "Crush them all.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.055,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.fromRGB(222, 46, 46)
                        },
                        {
                            Time = 1,
                            Value = Color3.fromRGB(222, 46, 46)
                        }
                    }
                },
                Shake = {
                    Enabled = true,
                    Intensity = 6,
                    Lifetime = 0.8
                }
            }
        }, 4, "rbxassetid://139798283191140");
    end));
    u178:Add(task.delay(27.9, function() -- Line: 2142
        -- upvalues: TekrinnDialogue (ref), u174 (copy)
        TekrinnDialogue.Speak(u174, {
            {
                Text = "AND KEEP FIGHTING.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.055,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = {
                    Keypoints = {
                        {
                            Time = 0,
                            Value = Color3.fromRGB(222, 46, 46)
                        },
                        {
                            Time = 1,
                            Value = Color3.fromRGB(222, 46, 46)
                        }
                    }
                },
                Shake = {
                    Enabled = true,
                    Intensity = 7,
                    Lifetime = 1
                }
            }
        }, 4, "rbxassetid://139798283191140");
    end));
    soundUtil:play(memoryshard.soundmvp, "default");

    if u174:GetAttribute("RinNoPlay") or (u174:GetAttribute("SillySong") or math.random(1, 100) == 1) then
        soundUtil:play(memoryshard.OST_Luck, "default");

        return;
    end;

    soundUtil:play(memoryshard.OST, "default");
end;

function v116.mvp_kafkamvp(u181: any, p182: number) -- Line: 2171
    -- upvalues: vfxUtil (copy), mainreplication (copy), animationUtil (copy), wiki (copy), soundUtil (copy), Lighting (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(u181);
    local u183 = vfxUtil.mvp_cutscene_defaults(mainreplication, p182);
    local kafkamvp = vfxUtil.getResources().mvpAssets.kafkamvp;
    u183:Add(vfxUtil.buildFromRig(u181, kafkamvp.Coiner));
    u183:Add(animationUtil:loadAnimation(u183:Add(vfxUtil.newRigForFriend(Root, nil, CFrame.new(0, 0, 0.5))), kafkamvp.Animations.Victim), "Stop"):Play(0);
    local kafkamvp2 = wiki.mvp_anim.kafkamvp;

    if kafkamvp2.customCFrame then
        u181:PivotTo(kafkamvp2.customCFrame);
    elseif workspace:FindFirstChild("map") and workspace.map:FindFirstChild("something") then
        u181:PivotTo(workspace.map.something.mvpCF.CFrame);
    end;

    Root.Anchored = true;
    u183:Add(function() -- Line: 2190
        -- upvalues: Root (copy)
        Root.Anchored = false;
    end);
    local v184 = u183:Clone(kafkamvp.VFX);
    v184:PivotTo(Root.CFrame);
    v184.Parent = workspace.Effects;
    local v185 = u183:Clone(kafkamvp["Kafka MVP Map"]);
    v185:PivotTo(Root.CFrame);
    v185.Parent = workspace.Effects;
    local v186, v187 = mainreplication.cutsceneCamRigWithLetterBox(Root, kafkamvp.Animations.Cam, kafkamvp.FOV_Kafka, nil, CFrame.new(0, -3, 0.5), kafkamvp.Cam, "CamPart");
    u183:Add(v187);
    soundUtil:play(kafkamvp.soundmvp, "default");
    local v188 = u183:Add(vfxUtil.getMoonEffects());
    local v189 = {
        Workspace = v185,
        Lighting = Lighting,
        Vignette = v188.Vignette,
        ["Screen Cover"] = v188["Screen Cover"]
    };
    vfxUtil.cutscene_lighting(u183, v189, kafkamvp.Lighting, {
        ClockTime = 0,
        ShadowSoftness = 0,
        GeographicLatitude = 0,
        Ambient = Color3.fromRGB(0, 0, 0),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    vfxUtil.execute_compiled(kafkamvp.Compiled, u183, v184, u181, v186);
    u183:Add(task.delay(0.7, function() -- Line: 2231
        -- upvalues: u183 (copy), TekrinnDialogue (ref), u181 (copy)
        u183:Add(TekrinnDialogue.Speak(u181, {
            {
                Text = "Sooner or later, ",
                TypeSpeed = 0.065,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(210, 120, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            },
            {
                Text = "the curtain ",
                Italic = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 70, 255)) })
            },
            {
                Text = "will fall.",
                Bold = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 70, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 45, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.2,
                    Lifetime = 0.35
                }
            }
        }, 4));
    end));
    u183:Add(task.delay(4.5, function() -- Line: 2271
        -- upvalues: u183 (copy), TekrinnDialogue (ref), u181 (copy)
        u183:Add(TekrinnDialogue.Speak(u181, {
            {
                Text = "As for the ending... ",
                Italic = true,
                TypeSpeed = 0.055,
                Pause = 1,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(215, 150, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(175, 65, 255)) })
            },
            {
                Text = "wanna take a guess?",
                Bold = true,
                TypeSpeed = 0.065,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 65, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 70, 145)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 0.55,
                    Lifetime = 0.5
                }
            }
        }, 4));
    end));
    u183:Add(task.delay(14.05, function() -- Line: 2303
        -- upvalues: u183 (copy), TekrinnDialogue (ref), u181 (copy)
        u183:Add(TekrinnDialogue.Speak(u181, {
            {
                Text = "HEADS ",
                Bold = true,
                TypeSpeed = 0.05,
                TextStrokeColor = Color3.fromRGB(45, 0, 65),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(185, 55, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 80, 160)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 0.7,
                    Lifetime = 0.35
                }
            },
            {
                Text = "OR ",
                Italic = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 150, 255)) })
            },
            {
                Text = "TAILS?",
                Bold = true,
                TypeSpeed = 0.05,
                TextStrokeColor = Color3.fromRGB(45, 0, 65),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 45, 135)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(210, 70, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 0.5
                }
            }
        }));
    end));
    local v190 = u183:Construct(MoonPropertyAnimator);
    v190:LoadAndConvertSave(kafkamvp.Moon, v189);
    v190:SetOriginalRoot(kafkamvp.VFX:GetPivot());
    v190:SetRoot(Root);
    v190:PlayAll();
end;

function v116.mvp_sorrychichi(p191: any, p192: number) -- Line: 2357
    -- upvalues: vfxUtil (copy), mainreplication (copy), animationUtil (copy), soundUtil (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p191);
    local v193 = vfxUtil.mvp_cutscene_defaults(mainreplication, p192);
    local sorrychichi = vfxUtil.getResources().mvpAssets.sorrychichi;
    local v194 = v193:Add(vfxUtil.newRigForFriend(Root));
    v193:Add(animationUtil:loadAnimation(v194, sorrychichi.Animations.Victim), "Stop"):Play(0);
    local v195 = v193:Clone(sorrychichi.VFX);
    v195.Name = "vfx";
    v195:PivotTo(Root.CFrame);
    v195.Parent = workspace.Effects;
    v193:Add(v195.ThrownEnable).Parent = v194.Torso;
    v193:Add(v195.CutsceneVFX).Parent = Root;
    local _, v196 = mainreplication.cutsceneBlender(Root, sorrychichi.Animations.Cam, sorrychichi.FOV_Chichi, nil, nil, CFrame.identity);
    v193:Add(v196);
    local v197 = {
        Workspace = v195
    };
    soundUtil:play(sorrychichi.soundmvp, "default");
    vfxUtil.cutscene_lighting(v193, v197, sorrychichi.Lighting, {});
    vfxUtil.execute_compiled(sorrychichi.Compiled, v193, v195, p191, v194);
    local v198 = v193:Construct(MoonPropertyAnimator);
    v198:LoadAndConvertSave(sorrychichi.Moon, v197);
    v198:SetOriginalRoot(sorrychichi.VFX:GetPivot());
    v198:SetRoot(Root);
    v198:PlayAll();
end;

function v116.mvp_shinrajump(p199: any, p200: number, p201: any, p202: any) -- Line: 2402
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local shinrajump = mvpAssets.shinrajump;
    local Root = vfxUtil.getRoot(p199);
    local v203 = vfxUtil.mvp_cutscene_defaults(mainreplication, p200);
    local v204, v205 = mainreplication.cutsceneBlender(Root, shinrajump.Animations.Cam, shinrajump.FOV_Shinra, nil, nil, CFrame.new(0, -3, 0), shinrajump.Cam);
    v203:Add(v205);
    soundUtil:play(shinrajump.soundmvp, "default", {
        Character = p199
    });
    local u206 = p202[1];

    for i, v in { p199, u206 } do
        vfxUtil.buildFromRig(v, shinrajump.Rigs[i], v203);
    end;

    local v207 = {
        Cam = v204,
        Lighting = Lighting
    };
    vfxUtil.cutscene_lighting(v203, v207, shinrajump.Lighting, {
        ClockTime = 14.5,
        GeographicLatitude = 24,
        ExposureCompensation = 0,
        ShadowSoftness = 0.2,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    local v208 = v203:Construct(MoonPropertyAnimator);
    v208:LoadAndConvertSave(shinrajump.Moon, v207);
    v208:SetOriginalRoot(shinrajump.VFX:GetPivot());
    v208:SetRoot(Root);
    v208:PlayAll();
    vfxUtil.execute_compiled(shinrajump.Compiled, v203, p199, u206, v204);
    v203:Add(task.delay(0.6833333333333333, function() -- Line: 2449
        -- upvalues: TekrinnDialogue (ref), u206 (copy)
        TekrinnDialogue.Speak(u206, {
            {
                Text = "I looked up to you, more than anyone",
                Bold = false,
                Italic = true,
                TypeSpeed = 0.08,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 4);
    end));
    v203:Add(task.delay(5.066666666666666, function() -- Line: 2475
        -- upvalues: TekrinnDialogue (ref), u206 (copy)
        TekrinnDialogue.Speak(u206, {
            {
                Text = "Help me please.",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 4);
    end));
end;

function v116.mvp_travisMVP(p209: any, p210: number, p211: any, p212: any) -- Line: 2502
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy)
    local travisMVP = mvpAssets.travisMVP;
    local Root = vfxUtil.getRoot(p209);
    local v213 = vfxUtil.mvp_cutscene_defaults(mainreplication, p210);
    v213:Add(mainreplication.kuronaCamToAll(Root, nil, travisMVP.FOV_Travis));
    soundUtil:play(travisMVP.soundmvp, "default", {
        Character = p209
    });
    vfxUtil.buildFromRig(p209, travisMVP.Rig, v213);
    local v214 = v213:Clone(travisMVP.VFX);
    v214:PivotTo(Root.CFrame);
    v214.Parent = workspace.Effects;
    v213:Add(animationUtil:loadAnimation(v214.astroworld, travisMVP.Animations.Astro), "Stop"):Play(0);
    vfxUtil.cutscene_lighting(v213, {
        Lighting = Lighting
    }, travisMVP.Lighting, {
        Brightness = 0,
        ClockTime = 2,
        GeographicLatitude = 201,
        ExposureCompensation = -0.03,
        ShadowSoftness = 1,
        Ambient = Color3.fromRGB(255, 123, 15),
        OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    });
    vfxUtil.execute_compiled(travisMVP.Compiled, v213, v214, p209);
end;

function v116.mvp_jimmymvp1(p215: any, p216: number, p217: any, p218: any) -- Line: 2537
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local gameon = mvpAssets.gameon;
    local Root = vfxUtil.getRoot(p215);
    local v219 = vfxUtil.mvp_cutscene_defaults(mainreplication, p216);
    soundUtil:play(gameon.soundmvp, "default", {
        Character = p215
    });
    local v220 = v219:Clone(gameon.VFX);
    v220:PivotTo(Root.CFrame);
    v220.Parent = workspace.Effects;
    v219:Add(vfxUtil.highlight(p215, {
        Name = "Highlight",
        Enabled = true,
        FillTransparency = 1,
        OutlineTransparency = 1,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        FillColor = Color3.new(1, 0, 0),
        OutlineColor = Color3.new(1, 1, 1)
    }));
    mainreplication.makeitacam(Root, v220.camera, gameon.FOV_GameOn);
    local v221 = {
        Lighting = Lighting,
        Workspace = v220,
        ytes = p215
    };
    vfxUtil.cutscene_lighting(v219, v221, gameon.Lighting, {
        Brightness = 2,
        ClockTime = 14.5,
        GeographicLatitude = 0,
        ExposureCompensation = 0,
        ShadowSoftness = 0.2,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    local v222 = v219:Construct(MoonPropertyAnimator);
    v222:LoadAndConvertSave(gameon.Moon, v221);
    v222:SetOriginalRoot(gameon.VFX:GetPivot());
    v222:SetRoot(Root);
    v222:PlayAll();
end;

function v116.mvp_jimmymvp2(u223: any, p224: number, p225: any, p226: any) -- Line: 2585
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local gameover = mvpAssets.gameover;
    local Root = vfxUtil.getRoot(u223);
    local u227 = vfxUtil.mvp_cutscene_defaults(mainreplication, p224);
    local _baseplate_controller, u228 = vfxUtil.get_baseplate_controller();
    u228.Transparency = 1;
    _baseplate_controller.update();
    u227:Add(function() -- Line: 2596
        -- upvalues: u228 (copy), _baseplate_controller (copy)
        u228.Transparency = 0;
        _baseplate_controller.update();
    end);
    soundUtil:play(gameover.soundmvp, "default", {
        Character = u223
    });
    local u229 = u227:Clone(gameover.VFX);
    u229:PivotTo(Root.CFrame);
    u229.Parent = workspace.Effects;
    u227:Add(task.spawn(function() -- Line: 2608
        -- upvalues: u223 (copy), u229 (copy), u227 (copy), animationUtil (ref), gameover (copy)
        local AppliedDescription = u223.Humanoid:GetAppliedDescription();

        for _, v in { "1", "2", "3", "4" } do
            local v230 = u229:FindFirstChild(v);

            if v230 then
                local v231 = v230:FindFirstChildOfClass("Humanoid");

                if v231 and v230:FindFirstChild("HumanoidRootPart") then
                    local Scale = v230:GetScale();
                    v230:ScaleTo(1);
                    v231:ApplyDescriptionResetAsync(AppliedDescription);
                    v230:ScaleTo(Scale);
                    u227:Add(animationUtil:loadAnimation(v230, gameover.Animations.LittleGuys[v]), "Stop"):Play(0);
                end;
            end;
        end;
    end));
    u227:Add(task.delay(10.7, function() -- Line: 2634
        -- upvalues: u229 (copy)
        shared.vfx.emit(u229.naiteyo);
    end));
    u227:Add(task.delay(22.2, function() -- Line: 2638
        -- upvalues: u229 (copy)
        for _, v in { "1", "2", "3", "4" } do
            local v232 = u229:FindFirstChild(v);

            if v232 then
                v232:Destroy();
            end;
        end;
    end));
    local _, v233 = mainreplication.cutsceneCamRigWithLetterBoxForIdiots(Root, gameover.Animations.Camera, gameover.FOV_GameOver, nil, CFrame.new(0, -3, 0), gameover.TheMvpCamera, "Camera");
    u227:Add(v233);
    local v234 = u227:Add(vfxUtil.getMoonEffects());
    local v235 = {
        Lighting = Lighting,
        Workspace = u229,
        ["Screen Cover"] = v234["Screen Cover"],
        Subtitles = v234.Subtitles,
        MvpGuy1 = u223
    };
    vfxUtil.cutscene_lighting(u227, v235, gameover.Lighting, {
        Brightness = 3,
        ClockTime = 14.5,
        GeographicLatitude = 0,
        ExposureCompensation = 0,
        ShadowSoftness = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    local v236 = u227:Construct(MoonPropertyAnimator);
    v236:LoadAndConvertSave(gameover.Moon, v235);
    v236:SetOriginalRoot(gameover.VFX:GetPivot());
    v236:SetRoot(Root);
    v236:PlayAll();
end;

function v116.mvp_remiellethingy(p237: any, p238: number) -- Line: 2677
    -- upvalues: mvpAssets (copy), vfxUtil (copy), ReplicatedStorage (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local remiellethingy = mvpAssets.remiellethingy;
    local Animations = remiellethingy.Animations;
    local Root = vfxUtil.getRoot(p237);
    local remiellethingy2 = require(ReplicatedStorage.wiki.mvpAnimations).remiellethingy;

    if remiellethingy2 then
        remiellethingy2 = remiellethingy2.isRemielle(p237);
    end;

    local v239 = vfxUtil.mvp_cutscene_defaults(mainreplication, p238);
    soundUtil:play(remiellethingy.SFX, "default");
    local v240 = vfxUtil.newRigForFriend(Root);
    v239:Add(v240);
    local v241;

    if remiellethingy2 then
        v241 = Animations.Wise;
    else
        v241 = Animations.Remielle;
    end;

    v239:Add(animationUtil:loadAnimation(v240, v241), "Stop"):Play(0);
    local v242 = remiellethingy2 and {
        remielle = p237,
        wise = v240
    } or {
        remielle = v240,
        wise = p237
    };
    local _baseplate_controller, u243 = vfxUtil.get_baseplate_controller();
    u243.Transparency = 1;
    _baseplate_controller.update();
    v239:Add(function() -- Line: 2701
        -- upvalues: u243 (copy), _baseplate_controller (copy)
        u243.Transparency = 0;
        _baseplate_controller.update();
    end);
    local v244 = v239:Clone(remiellethingy.VFX);
    v244:PivotTo(Root.CFrame);
    v244.Parent = workspace.Effects;
    local v245 = v239:Clone(remiellethingy.ScreenGui);
    v245.Parent = vfxUtil.getPlayerGui();

    if v242.remielle then
        v239:Add(vfxUtil.buildFromRig(v242.remielle, remiellethingy.Remielle));
    end;

    if v242.wise then
        v239:Add(vfxUtil.buildFromRig(v242.wise, remiellethingy.Wise));
    end;

    local v246, v247 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations.Cam, Animations.FOV, nil, "default", remiellethingy.cam, "CamPart");
    v239:Add(v247);
    local v248 = {
        Workspace = v244,
        Lighting = Lighting,
        ScreenGui = v245,
        cam = v246
    };
    vfxUtil.cutscene_lighting(v239, v248, remiellethingy.Lighting, {
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0,
        ClockTime = 14.5,
        GeographicLatitude = 0,
        Ambient = Color3.new(0.27451, 0.27451, 0.27451),
        OutdoorAmbient = Color3.new(0.27451, 0.27451, 0.27451),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(0, 0, 0)
    });
    local v249 = v239:Construct(MoonPropertyAnimator);
    v249:LoadAndConvertSave(remiellethingy.Moon, v248);
    v249:SetOriginalRoot(remiellethingy.VFX:GetPivot());
    v249:SetRoot(Root);
    v249:PlayAll();
    vfxUtil.execute_compiled(remiellethingy.Compiled, v239, v244, v246, v242);
end;

function v116.mvp_heianvsgang(p250: any, u251: number, p252: any, p253: table?) -- Line: 2752
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), animationUtil (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local HeianVSGang = mvpAssets.HeianVSGang;
    local Animations = HeianVSGang.Animations;
    local Root = vfxUtil.getRoot(p250);

    if p253 then
        p253 = p253[1];
    end;

    if not (Root and p253) then
        return;
    end;

    local u254 = vfxUtil.mvp_cutscene_defaults(mainreplication, u251);
    local os_clock_ret = os.clock();
    local v255 = u254:Clone(HeianVSGang.VFX);
    v255:PivotTo(Root.CFrame);
    v255.Parent = workspace.Effects;
    vfxUtil.buildFromRig(p250, HeianVSGang.Rigs["1"], u254);
    vfxUtil.buildFromRig(p253, HeianVSGang.Rigs["6"], u254);
    local v256 = u254:Add(vfxUtil.highlight(p253, {
        Name = "heianhl",
        Enabled = true,
        FillTransparency = 1,
        OutlineTransparency = 1,
        Adornee = p253,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = Color3.new(0.27450981736183167, 0, 0),
        OutlineColor = Color3.new(1, 1, 1)
    }));
    u254:Add(vfxUtil.highlight(p250, {
        Name = "ythl",
        Enabled = false,
        FillTransparency = -10,
        OutlineTransparency = 1,
        Adornee = p250,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = Color3.new(1, 0.5058823823928833, 0.9921569228172302),
        OutlineColor = Color3.new(1, 1, 1)
    }));
    local v257 = {};

    for _, v in { { 1, "2" }, { 2 }, { 3, "4" }, { 6 } } do
        local u258, u259 = vfxUtil.newRigForFriend(Root);
        u254:Add(u258);
        u258:PivotTo(Root.CFrame);
        table.insert(v257, u258);
        local u260 = nil;

        local function prepareFriend() -- Line: 2805
            -- upvalues: u260 (ref), u254 (copy), u258 (copy), Root (copy), v (copy), vfxUtil (ref), HeianVSGang (copy), animationUtil (ref), Animations (copy), os_clock_ret (copy), u251 (copy)
            if u260 then
                u254:Remove(u260);
            end;

            u260 = u254:Extend();
            u258:PivotTo(Root.CFrame);

            if v[2] then
                vfxUtil.buildFromRig(u258, HeianVSGang.Rigs[v[2]], u260);
            end;

            local v261 = u260:Add(animationUtil:loadAnimation(u258, Animations.Victims[tostring(v[1])], 0, Enum.AnimationPriority.Action, false), "Stop");
            v261:Play(0);
            local v262 = os.clock() - os_clock_ret;
            v261.TimePosition = math.min(v262, u251);
        end;

        prepareFriend();
        u254:Add(task.spawn(function() -- Line: 2822
            -- upvalues: u259 (copy), u258 (copy), prepareFriend (copy)
            if not u259.Value then
                u259.Changed:Wait();
            end;

            if u258.Parent then
                prepareFriend();
            end;
        end));
    end;

    local v263 = u254:Clone(HeianVSGang.Rigs["5"]);
    v263.Name = "HeianArms";
    v263.PrimaryPart = v263.HumanoidRootPart;
    v263:PivotTo(Root.CFrame * CFrame.new(0, -3, 0));
    v263["Left Arm"].Color = p253["Left Arm"].Color;
    v263["Right Arm"].Color = p253["Right Arm"].Color;

    for _, child in p253:GetChildren() do
        if child:IsA("Shirt") or (child:IsA("Pants") or child:IsA("ShirtGraphic")) then
            child:Clone().Parent = v263;
        end;
    end;

    v263.Parent = workspace.Effects;
    local v264 = u254:Add(vfxUtil.highlight(v263, {
        Name = "heianarmhl",
        Enabled = true,
        FillTransparency = 1,
        OutlineTransparency = 1,
        Adornee = v263,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = Color3.new(0.27450981736183167, 0, 0),
        OutlineColor = Color3.new(1, 1, 1)
    }));
    u254:Add(animationUtil:loadAnimation(v263, Animations.Victims["4"], 0, Enum.AnimationPriority.Action, false), "Stop"):Play(0);
    local v265, v266 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations.Cam, HeianVSGang.FOV_HeianVSGang, nil, CFrame.new(0, -3, 0), HeianVSGang.Cam, "Camera", "All");
    u254:Add(v266);
    local u267 = u254:Add(vfxUtil.getMoonEffects());
    u254:Add(task.delay(8.9, function() -- Line: 2864
        -- upvalues: u267 (copy)
        u267["Screen Cover"].Transparency = 0;
    end));
    local v268 = {
        heianarmhl = v264,
        heianhl = v256,
        ["Heian Sukuna"] = p253,
        Yuta = p250
    };
    vfxUtil.cutscene_lighting(u254, v268, HeianVSGang.Lighting, {
        Brightness = 3,
        ClockTime = 14.5,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0,
        GeographicLatitude = 0,
        GlobalShadows = true,
        ShadowSoftness = 0.2,
        Ambient = Color3.fromRGB(70, 70, 70),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    local v269 = u254:Construct(MoonPropertyAnimator);
    v269:LoadAndConvertSave(HeianVSGang.Moon, v268);
    v269:PlayAll();
    u254:Add(soundUtil:play(HeianVSGang.Sound, "default"));
    vfxUtil.execute_compiled(HeianVSGang.Compiled, u254, v255, v265, p250, v257[1], v263, p253);
end;

function v116.mvp_loreaccuratekaiser(p270: any, p271: number, p272: any, p273: table?) -- Line: 2898
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), Players (copy), TekrinnDialogue (copy)
    local loreaccuratekaiser = mvpAssets.loreaccuratekaiser;
    local Root = vfxUtil.getRoot(p270);

    if p273 then
        p273 = p273[1];
    end;

    if not (Root and p273) then
        return;
    end;

    local u274 = vfxUtil.mvp_cutscene_defaults(mainreplication, p271, {
        NoFade = true
    });
    local v275, v276 = mainreplication.cutsceneBlender(Root, loreaccuratekaiser.Animations.Cam);

    if not v275 then
        return;
    end;

    u274:Add(v276);
    u274:Add(soundUtil:play(loreaccuratekaiser.soundmvp, "default"));
    local v277 = u274:Clone(loreaccuratekaiser.VFX);
    v277:PivotTo(Root.CFrame);
    local VFX = v277.VFX;
    VFX.FakeheadTeammate.Weld.Part1 = p273.Head;
    VFX.FakeRArm.Weld.Part1 = p270["Right Arm"];
    VFX.FakeheadP.Weld.Part1 = p270.Head;
    VFX.CamVFX.Weld.Part1 = v275.CamPart;
    VFX.Rose.Weld.Part1 = p270.Torso;

    for _, v in {
        VFX.FakeheadTeammate,
        VFX.FakeRArm,
        VFX.FakeheadP,
        VFX.CamVFX,
        VFX.Rose,
        VFX.Ambience
    } do
        local Weld = v.Weld;
        v.CFrame = Weld.Part1.CFrame * Weld.C1 * Weld.C0:Inverse();
    end;

    v277.Parent = workspace.Effects;
    local v278 = u274:Add(vfxUtil.getMoonEffects());
    local v279 = {
        Cam = v275,
        CurrentCamera = workspace.CurrentCamera,
        Lighting = Lighting,
        Workspace = v277,
        ["Screen Cover"] = v278["Screen Cover"],
        Vignette = v278.Vignette
    };
    vfxUtil.cutscene_lighting(u274, v279, loreaccuratekaiser.Lighting, {
        Brightness = 3,
        ClockTime = 12,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0.15000000596046448,
        GeographicLatitude = 201,
        GlobalShadows = true,
        ShadowSoftness = 1,
        Ambient = Color3.new(1, 1, 1),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.new(0.18431372940540314, 0.18431372940540314, 0.18431372940540314)
    });
    local v280 = u274:Construct(MoonPropertyAnimator);
    v280:LoadAndConvertSave(loreaccuratekaiser.Moon, v279);
    v280:PlayAll();
    vfxUtil.execute_compiled(loreaccuratekaiser.Compiled, u274, v277, v275, p270, p273);
    u274:Add(task.delay(p271 - 1, function() -- Line: 2964
        -- upvalues: mainreplication (ref)
        mainreplication.newblackscene(0.75, 1, 3, Color3.fromRGB(255, 255, 255));
    end));
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p273);
    local u281 = not PlayerFromCharacter and "Isagi" or PlayerFromCharacter.DisplayName;
    u274:Add(task.delay(0.383, function() -- Line: 2979
        -- upvalues: u274 (copy), TekrinnDialogue (ref), u281 (ref)
        u274:Add(TekrinnDialogue.Speak(u281, {
            {
                Text = "No way...",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, 4, "rbxassetid://125768802107076", Color3.fromRGB(0, 170, 255)));
    end));
    u274:Add(task.delay(2.155, function() -- Line: 2992
        -- upvalues: u274 (copy), TekrinnDialogue (ref), u281 (ref)
        u274:Add(TekrinnDialogue.Speak(u281, {
            {
                Text = "This guy\'s a...",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, 4, "rbxassetid://125768802107076", Color3.fromRGB(0, 170, 255)));
    end));
    u274:Add(task.delay(3.959, function() -- Line: 3005
        -- upvalues: u274 (copy), TekrinnDialogue (ref), u281 (ref)
        u274:Add(TekrinnDialogue.Speak(u281, {
            {
                Text = ".. superstar.",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255)) })
            }
        }, 1, "rbxassetid://125768802107076", Color3.fromRGB(0, 170, 255)));
    end));
end;

function v116.mvp_JetVSRaiden(u282: any, p283: number) -- Line: 3020
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local JetVSRaiden = mvpAssets.JetVSRaiden;
    local Animations = JetVSRaiden.Animations;
    local Root = vfxUtil.getRoot(u282);
    local u284 = vfxUtil.mvp_cutscene_defaults(mainreplication, p283);
    soundUtil:play(JetVSRaiden.SFX, "default");
    local u285 = vfxUtil.newRigForFriend(Root);
    u284:Add(u285);
    u284:Add(animationUtil:loadAnimation(u285, Animations.Raiden), "Stop"):Play(0);
    vfxUtil.buildFromRig(u282, JetVSRaiden.Sam, u284);
    vfxUtil.buildFromRig(u285, JetVSRaiden.Raiden, u284);
    local v286 = u284:Clone(JetVSRaiden.VFX);
    v286:PivotTo(Root.CFrame);
    v286.Parent = workspace.Effects;
    local _, v287 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations.Cam, Animations.FOV, nil, "default", JetVSRaiden.cam, "CamPart");
    u284:Add(v287);
    local v288 = {
        Workspace = v286,
        Lighting = Lighting
    };
    vfxUtil.cutscene_lighting(u284, v288, JetVSRaiden.Lighting, {
        Brightness = 3,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 0,
        ExposureCompensation = 0,
        ClockTime = 8,
        GeographicLatitude = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(255, 179, 0),
        ColorShift_Bottom = Color3.fromRGB(255, 179, 0),
        ColorShift_Top = Color3.fromRGB(255, 179, 0)
    });
    local v289 = u284:Construct(MoonPropertyAnimator);
    v289:LoadAndConvertSave(JetVSRaiden.Moon, v288);
    v289:PlayAll();
    vfxUtil.execute_compiled(JetVSRaiden.Compiled, u284, v286, u282, u285);
    u284:Add(task.delay(0.43, function() -- Line: 3069
        -- upvalues: u284 (copy), TekrinnDialogue (ref), u285 (copy)
        u284:Add(TekrinnDialogue.Speak(u285.Name, {
            {
                Text = "Don\'t interfere.",
                TypeSpeed = 0.045,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 70, 70)) })
            }
        }, 1.8, nil, Color3.fromRGB(255, 70, 70)));
    end));
    u284:Add(task.delay(6.25, function() -- Line: 3082
        -- upvalues: u284 (copy), TekrinnDialogue (ref), u285 (copy)
        u284:Add(TekrinnDialogue.Speak(u285.Name, {
            {
                Text = "This is between us... ",
                TypeSpeed = 0.05,
                Pause = 1.1,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 70, 70)) })
            },
            {
                Text = "and it ends here.",
                Bold = true,
                TypeSpeed = 0.045,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, 3.7, nil, Color3.fromRGB(255, 70, 70)));
    end));
    u284:Add(task.delay(11.5, function() -- Line: 3106
        -- upvalues: u284 (copy), TekrinnDialogue (ref), u282 (copy)
        u284:Add(TekrinnDialogue.Speak(u282.Name, {
            {
                Text = "Okay... ",
                Italic = true,
                TypeSpeed = 0.08,
                Pause = 1.45,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 70, 70)) })
            },
            {
                Text = "Let\'s dance!",
                Bold = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 160, 40)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.2,
                    Lifetime = 0.35
                }
            }
        }, 3.6, nil, Color3.fromRGB(255, 70, 70)));
    end));
end;

function v116.mvp_redspace(p290: any, p291: number) -- Line: 3138
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p290);

    if not Root then
        return;
    end;

    local v292 = vfxUtil.mvp_cutscene_defaults(mainreplication, p291, {
        NoFade = true,
        BackScene = true
    });
    local redspace = vfxUtil.getResources().mvpAssets.redspace;
    local _, _ = vfxUtil.buildFromRig(p290, redspace.Rig, v292);
    v292:Add(soundUtil:play(redspace.soundmvp, "default"));
    vfxUtil.cutscene_invisiball(p290, v292);
    local v293 = v292:Clone(redspace.VFX);
    v293:PivotTo(Root.CFrame);
    v293.Parent = workspace.Effects;
    local _baseplate_controller, u294 = vfxUtil.get_baseplate_controller();
    local Transparency = u294.Transparency;
    u294.Transparency = 1;
    _baseplate_controller.update();
    v292:Add(function() -- Line: 3160
        -- upvalues: u294 (copy), Transparency (copy), _baseplate_controller (copy)
        u294.Transparency = Transparency;
        _baseplate_controller.update();
    end);
    v292:Add(mainreplication.kuronaCamToAll(Root, redspace.Cam, redspace.FOV));
    local v295 = {
        Workspace = v293,
        ["Screen Cover"] = v292:Add(vfxUtil.getMoonEffects())["Screen Cover"]
    };
    vfxUtil.cutscene_lighting(v292, v295, redspace.Lighting, {
        Brightness = 3,
        ClockTime = 0,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0.20000000298023224,
        GeographicLatitude = 0,
        GlobalShadows = true,
        ShadowSoftness = 1,
        Ambient = Color3.new(1, 0.45098042488098145, 0),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(1, 0, 0.01568627543747425),
        OutdoorAmbient = Color3.new(1, 0, 0.01568627543747425)
    });
    local u296 = {
        FogColor = Lighting.FogColor,
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd
    };
    local u297 = workspace.Terrain:FindFirstChildOfClass("Clouds");
    local u298;

    if u297 then
        u298 = u297.Enabled;
    else
        u298 = u297;
    end;

    Lighting.FogColor = Color3.new(0.7529412508010864, 0.7529412508010864, 0.7529412508010864);
    Lighting.FogStart = 0;
    Lighting.FogEnd = 100000;

    if u297 then
        u297.Enabled = false;
    end;

    v292:Add(function() -- Line: 3207
        -- upvalues: u296 (copy), Lighting (ref), u297 (copy), u298 (copy)
        for i, v in u296 do
            Lighting[i] = v;
        end;

        if u297 and u297.Parent then
            u297.Enabled = u298;
        end;
    end);
    local v299 = v292:Construct(MoonPropertyAnimator);
    v299:LoadAndConvertSave(redspace.Moon, v295);
    v299:SetOriginalRoot(redspace.VFX:GetPivot());
    v299:SetRoot(Root);
    v299:PlayAll();
    v292:Add(function() -- Line: 3222
        -- upvalues: mainreplication (ref)
        mainreplication.newblackscene(0, 1, 3);
    end);
end;

local table_freeze_ret = table.freeze({
    Brightness = 3,
    ClockTime = 14.5,
    EnvironmentDiffuseScale = 0,
    EnvironmentSpecularScale = 0,
    ExposureCompensation = 0,
    GeographicLatitude = 0,
    GlobalShadows = true,
    ShadowSoftness = 0.2,
    Ambient = Color3.fromRGB(70, 70, 70),
    OutdoorAmbient = Color3.fromRGB(70, 70, 70),
    ColorShift_Top = Color3.new(0, 0, 0),
    ColorShift_Bottom = Color3.new(0, 0, 0)
});
local TweenInfo_new_ret = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

function v116.mvp_backrooms(p300: any, p301: number) -- Line: 3244
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), RunService (copy), animationUtil (copy), soundUtil (copy), TweenService (copy), TweenInfo_new_ret (copy), table_freeze_ret (copy)
    local backrooms = mvpAssets:FindFirstChild("backrooms");

    if not backrooms then
        return;
    end;

    local Animations = backrooms:FindFirstChild("Animations");
    local Root = vfxUtil.getRoot(p300);

    if not (Animations and Root) then
        return;
    end;

    local u302 = Root.CFrame * CFrame.new(0, 1000, 0);
    Root.Anchored = true;
    Root.CFrame = u302;
    local v303 = vfxUtil.mvp_cutscene_defaults(mainreplication, p301);

    local function pin_root() -- Line: 3262
        -- upvalues: Root (copy), u302 (copy)
        if Root.CFrame ~= u302 then
            Root.CFrame = u302;
        end;
    end;

    v303:Connect(RunService.PreRender, pin_root);
    v303:Connect(RunService.PreSimulation, pin_root);
    v303:Connect(RunService.PostSimulation, pin_root);
    local v304 = vfxUtil.newRigForFriend(Root);
    v303:Add(v304);
    v303:Add(animationUtil:loadAnimation(v304, Animations.Enemy), "Stop"):Play(0);
    local _baseplate_controller, u305 = vfxUtil.get_baseplate_controller();
    u305.Transparency = 1;
    _baseplate_controller.update();
    v303:Add(function() -- Line: 3279
        -- upvalues: u305 (copy), _baseplate_controller (copy)
        u305.Transparency = 0;
        _baseplate_controller.update();
    end);
    local v306 = v303:Clone(backrooms.Map);
    v306:PivotTo(u302);
    v306.Parent = workspace.Effects;
    local u307 = soundUtil:play(backrooms.soundmvp, "default");
    v303:Add(function() -- Line: 3289
        -- upvalues: u307 (copy), TweenService (ref), TweenInfo_new_ret (ref)
        if typeof(u307) ~= "Instance" or not (u307:IsA("Sound") and u307.Parent) then
            return;
        end;

        local v308 = TweenService:Create(u307, TweenInfo_new_ret, {
            Volume = 0
        });
        v308.Completed:Once(function() -- Line: 3294
            -- upvalues: u307 (ref)
            u307:Destroy();
        end);
        v308:Play();
    end);
    local _, v309 = mainreplication.cutsceneBlender(Root, Animations.Cam, Animations.FOV, nil, nil, CFrame.new(0, -3, 0), backrooms.Cam);

    if v309 then
        v303:Add(v309);
    end;

    vfxUtil.cutscene_lighting(v303, {}, backrooms:FindFirstChild("Lighting"), table_freeze_ret);
end;

function v116.mvp_fatchudbnuuy(u310: any, p311: number, p312: any, p313: table?) -- Line: 3308
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local fatchudbnuuy = mvpAssets.fatchudbnuuy;
    local Animations = fatchudbnuuy.Animations;
    local Root = vfxUtil.getRoot(u310);
    local u314 = vfxUtil.mvp_cutscene_defaults(mainreplication, p311);
    vfxUtil.cutscene_invisiball(u310, u314);
    u314:Add(soundUtil:play(fatchudbnuuy.soundmvp, "default"));
    local CFrame_new_ret = CFrame.new(-4, 7, 16.5);
    local v315 = u314:Clone(fatchudbnuuy.Rigs["1"]);
    v315:PivotTo(Root.CFrame * CFrame_new_ret:ToObjectSpace(fatchudbnuuy.Rigs["1"]:GetPivot()));
    v315.Parent = workspace.Effects;
    u314:Add(animationUtil:loadAnimation(v315, Animations["1"], 0, Enum.AnimationPriority.Action, false), "Stop"):Play(0);
    local v316 = u314:Clone(fatchudbnuuy.Rigs["11"]);
    v316:PivotTo(Root.CFrame * CFrame_new_ret:ToObjectSpace(fatchudbnuuy.Rigs["11"]:GetPivot()));
    v316.Parent = workspace.Effects;
    u314:Add(animationUtil:loadAnimation(v316, Animations["11"], 0, Enum.AnimationPriority.Action, false), "Stop"):Play(0);
    local v317, v318, _ = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations["13"], fatchudbnuuy.FOV, u310, CFrame.identity, fatchudbnuuy.Rigs["13"], "Camera", "All");
    u314:Add(v318);
    local v319 = u314:Clone(fatchudbnuuy.VFX);
    v319:PivotTo(Root.CFrame * CFrame_new_ret:ToObjectSpace(fatchudbnuuy.VFX:GetPivot()));
    v319.CamVFX.Weld.Part1 = v317.Camera;
    v319.Parent = workspace.Effects;
    local _baseplate_controller, u320 = vfxUtil.get_baseplate_controller();
    local Transparency = u320.Transparency;
    u320.Transparency = 1;
    _baseplate_controller.update();
    u314:Add(function() -- Line: 3348
        -- upvalues: u320 (copy), Transparency (copy), _baseplate_controller (copy)
        u320.Transparency = Transparency;
        _baseplate_controller.update();
    end);
    local v321 = u314:Clone(fatchudbnuuy.Scenery);
    v321:PivotTo(Root.CFrame * CFrame_new_ret:ToObjectSpace(fatchudbnuuy.Scenery:GetPivot()));

    for _, descendant in v321:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
        end;
    end;

    v321.Parent = workspace.Effects;
    local v322 = {
        Subtitles = u314:Add(vfxUtil.getMoonEffects()).Subtitles,
        Workspace = v319
    };
    local u323 = {
        FogColor = Lighting.FogColor,
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd
    };
    local u324 = workspace.Terrain:FindFirstChildOfClass("Clouds");
    local u325;

    if u324 then
        u325 = u324.Enabled;
    else
        u325 = u324;
    end;

    vfxUtil.cutscene_lighting(u314, v322, fatchudbnuuy.Lighting, {
        Brightness = 3,
        ClockTime = 12,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0.15000000596046448,
        FogStart = 0,
        GeographicLatitude = 201,
        GlobalShadows = true,
        ShadowSoftness = 1,
        Ambient = Color3.new(1, 1, 1),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(0, 0, 0),
        FogColor = Color3.new(0.7529412508010864, 0.7529412508010864, 0.7529412508010864),
        OutdoorAmbient = Color3.new(0.18431372940540314, 0.18431372940540314, 0.18431372940540314)
    });

    if u324 then
        u324.Enabled = false;
    end;

    u314:Add(function() -- Line: 3401
        -- upvalues: u323 (copy), Lighting (ref), u324 (copy), u325 (copy)
        for i, v in u323 do
            Lighting[i] = v;
        end;

        if u324 then
            u324.Enabled = u325;
        end;
    end);
    local v326 = u314:Construct(MoonPropertyAnimator);
    v326:LoadAndConvertSave(fatchudbnuuy.Moon, v322);
    v326:SetOriginalRoot(fatchudbnuuy.VFX:GetPivot());
    v326:SetRoot(Root);
    v326:PlayAll();
    vfxUtil.execute_compiled(fatchudbnuuy.Compiled, u314, v319);
    u314:Add(task.delay(p311 - 1, function() -- Line: 3418
        -- upvalues: mainreplication (ref)
        mainreplication.newblackscene(0.75, 1, 3);
    end));
    u314:Add(task.delay(7, function() -- Line: 3424
        -- upvalues: u314 (copy), TekrinnDialogue (ref), u310 (copy)
        u314:Add(TekrinnDialogue.Speak(u310, {
            {
                Text = "OH MA GAAH!!",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, 4, "rbxassetid://100522008655226"));
    end));
    u314:Add(task.delay(8.4, function() -- Line: 3437
        -- upvalues: u314 (copy), TekrinnDialogue (ref), u310 (copy)
        u314:Add(TekrinnDialogue.Speak(u310, {
            {
                Text = "A BNUUYYY",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, 4, "rbxassetid://100522008655226"));
    end));
end;

function v116.mvp_ogurinmvp(p327: any, p328: number, p329: any, p330: table?) -- Line: 3452
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), MoonPropertyAnimator (copy)
    local ogurinmvp = mvpAssets.ogurinmvp;
    local Animations = ogurinmvp.Animations;
    local Root = vfxUtil.getRoot(p327);
    local u331 = vfxUtil.mvp_cutscene_defaults(mainreplication, p328, {
        NoFade = true,
        BackScene = true
    });
    vfxUtil.cutscene_invisiball(p327, u331);
    soundUtil:play(ogurinmvp.soundmvp, "default");
    local v332, v333, _ = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations.Cam, ogurinmvp.FOV, p327, CFrame.new(0, -3, 0), ogurinmvp.Cam, "CamPart", "All");
    u331:Add(v333);
    local u334, u335 = vfxUtil.newRigForFriend(Root);
    u331:Add(u334);
    local u336 = nil;

    local function u337() -- Line: 3471
        -- upvalues: u336 (ref), u331 (copy), u334 (copy), Root (copy), animationUtil (ref), Animations (copy)
        if u336 then
            u331:Remove(u336);
        end;

        u334:PivotTo(Root.CFrame);
        u336 = u331:Add(animationUtil:loadAnimation(u334, Animations.Victims["10"], 0, Enum.AnimationPriority.Action, false), "Stop");
        u336:Play(0);
    end;

    u337();
    u331:Add(task.spawn(function() -- Line: 3482
        -- upvalues: u335 (copy), u334 (copy), u337 (copy)
        if not u335.Value then
            u335.Changed:Wait();
        end;

        if u334.Parent then
            u337();
        end;
    end));
    local v338 = u331:Clone(ogurinmvp.VFX);
    v338:PivotTo(Root.CFrame);
    v338.Parent = workspace.Effects;
    local v339 = u331:Add(vfxUtil.highlight(p327, {
        Name = "OguriHighlight",
        Enabled = false,
        FillTransparency = 0,
        OutlineTransparency = 1,
        Adornee = p327,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        FillColor = Color3.new(0, 0, 0),
        OutlineColor = Color3.new(1, 1, 1)
    }));

    if p330 and p330[9] then
        u331:Add(vfxUtil.highlight(p330[9], {
            Name = "OguriTeammateHighlight",
            Enabled = true,
            FillTransparency = 0.8,
            OutlineTransparency = 1,
            Adornee = p330[9],
            DepthMode = Enum.HighlightDepthMode.Occluded,
            FillColor = Color3.fromRGB(87, 210, 255),
            OutlineColor = Color3.new(1, 1, 1)
        }));
    end;

    local _baseplate_controller, u340 = vfxUtil.get_baseplate_controller();
    local Transparency = u340.Transparency;
    u340.Transparency = 1;
    _baseplate_controller.update();
    u331:Add(function() -- Line: 3523
        -- upvalues: u340 (copy), Transparency (copy), _baseplate_controller (copy)
        u340.Transparency = Transparency;
        _baseplate_controller.update();
    end);
    local v341 = u331:Add(vfxUtil.getMoonEffects());
    local v342 = {
        Workspace = v338,
        Highlight = v339,
        Vignette = v341.Vignette,
        ["Screen Cover"] = v341["Screen Cover"]
    };
    vfxUtil.cutscene_lighting(u331, v342, ogurinmvp.Lighting, {
        Brightness = 3,
        ClockTime = 14.5,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0,
        GeographicLatitude = 0,
        GlobalShadows = true,
        ShadowSoftness = 0.2,
        Ambient = Color3.new(0, 0, 0),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.new(0.27450981736183167, 0.27450981736183167, 0.27450981736183167)
    });
    local v343 = u331:Construct(MoonPropertyAnimator);
    v343:LoadAndConvertSave(ogurinmvp.Moon, v342);
    v343:SetOriginalRoot(ogurinmvp.VFX:GetPivot());
    v343:SetRoot(Root);
    v343:PlayAll();
    vfxUtil.execute_compiled(ogurinmvp.Compiled, u331, v338, v332, p327, u331);
    u331:Add(task.delay(p328 - 1, function() -- Line: 3560
        -- upvalues: mainreplication (ref)
        mainreplication.newblackscene(0.75, 1, 3);
    end));
end;

local table_freeze_ret2 = table.freeze({
    Brightness = 3,
    ClockTime = 10.820833206176758,
    EnvironmentDiffuseScale = 1,
    EnvironmentSpecularScale = 1,
    ExposureCompensation = 0,
    GeographicLatitude = -50.26844787597656,
    GlobalShadows = true,
    ShadowSoftness = 0,
    Ambient = Color3.new(0.27451, 0.27451, 0.27451),
    OutdoorAmbient = Color3.new(0.27451, 0.27451, 0.27451),
    ColorShift_Top = Color3.new(0, 0, 0),
    ColorShift_Bottom = Color3.new(0, 0, 0)
});
local table_freeze_ret3 = table.freeze({ CFrame.new(
        2.31050873,
        -53.4776611,
        -90.2446671,
        0.512906909,
        0,
        -0.858444214,
        0,
        1,
        0,
        0.858444214,
        0,
        0.512906909
    ), CFrame.new(
        -1.14628665e-6,
        -149.747101,
        -97.9983139,
        -0.300492167,
        0,
        -0.953784287,
        0,
        1,
        0,
        0.953784287,
        0,
        -0.300492167
    ), CFrame.new(
        5.13322448e-7,
        -126.422142,
        -3.78000186e-6,
        0.1345644,
        0,
        0.990904808,
        0,
        1,
        0,
        -0.990904808,
        0,
        0.1345644
    ) });

local function ruler_target(p344: userdata) -- Line: 3586
    -- upvalues: ReplicatedStorage (copy)
    local rulerofmyheart = require(ReplicatedStorage.wiki.mvpAnimations).rulerofmyheart;

    if rulerofmyheart then
        rulerofmyheart = rulerofmyheart.customCFrame;
    end;

    if typeof(rulerofmyheart) == "CFrame" then
        return rulerofmyheart;
    end;

    local map = workspace:FindFirstChild("map");

    if map then
        map = map:FindFirstChild("something");
    end;

    if map then
        map = map:FindFirstChild("mvpCF");
    end;

    if map and map:IsA("BasePart") then
        return map.CFrame;
    end;

    return p344.CFrame;
end;

local function ruler_owner(p345) -- Line: 3601
    -- upvalues: Players (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p345);

    if PlayerFromCharacter then
        return PlayerFromCharacter;
    end;

    if p345 and p345.Name == "Cutscene Boy" then
        return Players.LocalPlayer;
    end;

    return nil;
end;

function v116.mvp_rulerofmyheart(p346: any, p347: number, p348: any, p349: table?) -- Line: 3612
    -- upvalues: mvpAssets (copy), vfxUtil (copy), ReplicatedStorage (copy), Players (copy), soundUtil (copy), ruler_target (copy), mainreplication (copy), RunService (copy), animationUtil (copy), table_freeze_ret3 (copy), Lighting (copy), table_freeze_ret2 (copy), MoonPropertyAnimator (copy)
    local rulerofmyheart = mvpAssets:FindFirstChild("rulerofmyheart");

    if not rulerofmyheart then
        return;
    end;

    local Animations = rulerofmyheart:FindFirstChild("Animations");
    local Root = vfxUtil.getRoot(p346);

    if not (Animations and Root) then
        return;
    end;

    local rulerofmyheart2 = require(ReplicatedStorage.wiki.mvpAnimations).rulerofmyheart;
    local v350;

    if rulerofmyheart2 == nil then
        v350 = false;
    else
        v350 = rulerofmyheart2.duoEnemies(p346);
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p346);

    if not PlayerFromCharacter then
        if p346 and p346.Name == "Cutscene Boy" then
            PlayerFromCharacter = Players.LocalPlayer;
        else
            PlayerFromCharacter = nil;
        end;
    end;

    soundUtil:play(rulerofmyheart.Sound, "default");
    local u351 = ruler_target(Root);
    Root.Anchored = true;
    Root.CFrame = u351;
    local u352 = vfxUtil.mvp_cutscene_defaults(mainreplication, p347);

    local function v353() -- Line: 3636
        -- upvalues: Root (copy), u351 (copy)
        if Root.CFrame ~= u351 then
            Root.CFrame = u351;
        end;
    end;

    u352:Connect(RunService.PreRender, v353);
    u352:Connect(RunService.PreSimulation, v353);
    u352:Connect(RunService.PostSimulation, v353);
    local _baseplate_controller, u354 = vfxUtil.get_baseplate_controller();
    u354.Transparency = 1;
    _baseplate_controller.update();
    u352:Add(function() -- Line: 3648
        -- upvalues: u354 (copy), _baseplate_controller (copy)
        u354.Transparency = 0;
        _baseplate_controller.update();
    end);

    local function spawn_rig(p355: userdata, p356: boolean) -- Line: 3653
        -- upvalues: vfxUtil (ref), Root (copy), PlayerFromCharacter (copy), u352 (copy), animationUtil (ref)
        local v357;

        if p356 then
            v357 = vfxUtil.newRigForFriend(Root, PlayerFromCharacter);
        else
            v357 = vfxUtil.newRig(Root);
        end;

        u352:Add(v357);
        u352:Add(animationUtil:loadAnimation(v357, p355), "Stop"):Play(0);

        return v357;
    end;

    local v358;

    if v350 then
        v358 = spawn_rig(Animations.Enemy, true);
        spawn_rig(Animations.EnemyDuo, true);
    else
        local v359;

        if p349 then
            v359 = p349[1];
        else
            v359 = p349;
        end;

        if p349 then
            p349 = p349[2];
        end;

        local v360 = v359 or spawn_rig(Animations.User, false);

        if p349 then
            v358 = p346;
            p346 = v360;
        else
            spawn_rig(Animations.EnemyDuo, false);
            v358 = p346;
            p346 = v360;
        end;
    end;

    vfxUtil.buildFromRig(v358, rulerofmyheart.Rigs.User, u352);

    if p346 then
        vfxUtil.buildFromRig(p346, rulerofmyheart.Rigs.Enemy, u352);
    end;

    local v361 = u352:Clone(rulerofmyheart.VFX);
    v361:PivotTo(u351);
    v361.Parent = workspace.Effects;
    local v362 = v361:FindFirstChild("alien stage map");
    local v363;

    if v362 then
        v363 = v362:FindFirstChild("RootPart");
    else
        v363 = v362;
    end;

    local u364;

    if v362 then
        u364 = v362:FindFirstChild("Circle");
    else
        u364 = v362;
    end;

    local u365 = {};
    local u366 = {};

    if v362 and (v363 and v363:IsA("BasePart")) then
        for _, descendant in v362:GetDescendants() do
            if descendant:IsA("BasePart") and (descendant ~= u364 and descendant.Name ~= "VFXPART") then
                descendant.Anchored = true;
                table.insert(u365, descendant);
                table.insert(u366, v363.CFrame:ToObjectSpace(descendant.CFrame));
            end;
        end;
    end;

    if u364 and u364:IsA("BasePart") then
        u364.Anchored = true;
    end;

    local function set_phase(p367: number) -- Line: 3705
        -- upvalues: table_freeze_ret3 (ref), u365 (copy), u364 (copy), u366 (copy)
        local v368 = table_freeze_ret3[p367 + 1];

        if not (v368 and (#u365 ~= 0 and (u364 and u364:IsA("BasePart")))) then
            return;
        end;

        local v369 = u364.CFrame * v368;
        local table_create_ret = table.create(#u365);

        for i, v in u366 do
            table_create_ret[i] = v369 * v;
        end;

        workspace:BulkMoveTo(u365, table_create_ret, Enum.BulkMoveMode.FireCFrameChanged);
    end;

    set_phase(0);
    local v370;

    if v362 then
        v370 = v362:FindFirstChild("VFXPART");
    else
        v370 = v362;
    end;

    if v370 then
        local u371 = {};

        for _, descendant in v370:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and (descendant.Enabled and descendant.TimeScale < 1) then
                table.insert(u371, {
                    emitter = descendant,
                    transparency = descendant.Transparency,
                    time_scale = descendant.TimeScale
                });
                descendant.Transparency = NumberSequence.new(1);
                descendant.TimeScale = 1;
            end;
        end;

        if #u371 > 0 then
            local v372 = 0;

            for _, v in u371 do
                v372 = math.max(v372, v.emitter.Lifetime.Max);
            end;

            u352:Add(task.delay(v372 + 0.05, function() -- Line: 3734
                -- upvalues: u371 (copy)
                for _, v in u371 do
                    if v.emitter.Parent then
                        v.emitter.TimeScale = v.time_scale;
                        v.emitter.Transparency = v.transparency;
                    end;
                end;
            end));
        end;
    end;

    local v373 = u352:Clone(rulerofmyheart.MoonAnimatorEffects);
    v373.Parent = vfxUtil.getPlayerGui();
    local _, v374 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations.Cam, rulerofmyheart.FOV, nil, "default", rulerofmyheart.cam, "Camera");

    if v374 then
        u352:Add(v374);
    end;

    local v375 = {
        Lighting = Lighting,
        MoonAnimatorEffects = v373,
        ["alien stage map"] = v362
    };
    local v376;

    if v363 then
        v376 = v363:FindFirstChild("Scene1Lighting");
    else
        v376 = v363;
    end;

    v375.Scene1Lighting = v376;

    if v363 then
        v363 = v363:FindFirstChild("Scene2Lighting");
    end;

    v375.Scene2Lighting = v363;
    v375.R61 = p346;
    vfxUtil.cutscene_lighting(u352, v375, rulerofmyheart:FindFirstChild("Lighting"), table_freeze_ret2);
    local v377 = u352:Construct(MoonPropertyAnimator);
    v377:LoadAndConvertSave(rulerofmyheart.Moon, v375);
    v377:SetRoot(Root);
    v377:PlayAll();
    vfxUtil.execute_compiled(rulerofmyheart.Compiled, u352, v361, {
        user = v358,
        set_phase = set_phase
    });
end;

function v116.mvp_gokuxzamasu(p378: any, p379: number) -- Line: 3775
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), animationUtil (copy), Lighting (copy), soundUtil (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local gokuxzamasu = mvpAssets.gokuxzamasu;
    local Root = vfxUtil.getRoot(p378);
    local v380 = vfxUtil.mvp_cutscene_defaults(mainreplication, p379);
    local v381, v382 = mainreplication.cutsceneBlender(Root, gokuxzamasu.Animations.Cam, gokuxzamasu["FOV_GB AND Z MVP"], nil, nil, CFrame.new(0, -3, 0), gokuxzamasu.Cam);
    v380:Add(v382);
    local v383 = v380:Add(vfxUtil.newRigForFriend(Root));
    vfxUtil.buildFromRig(v383, gokuxzamasu.Rigs["2"], v380);
    v380:Add(animationUtil:loadAnimation(v383, gokuxzamasu.Animations.Victims["1"]), "Stop"):Play(0);
    local VFX = gokuxzamasu.VFX;
    local v384 = v380:Clone(VFX);
    v384:PivotTo(Root.CFrame);
    v384.Parent = workspace.Effects;
    local v385 = {
        Cam = v381,
        Camera = v381,
        Lighting = Lighting,
        Workspace = v384
    };
    vfxUtil.cutscene_lighting(v380, v385, gokuxzamasu:FindFirstChild("Lighting"), {
        Brightness = 3,
        ClockTime = 14.5,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0,
        GeographicLatitude = 0,
        GlobalShadows = true,
        ShadowSoftness = 0.20000000298023224,
        Ambient = Color3.new(0.27450981736183167, 0.27450981736183167, 0.27450981736183167),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.new(0.27450981736183167, 0.27450981736183167, 0.27450981736183167)
    });
    soundUtil:play(gokuxzamasu.soundMVP, "default");
    local v386 = v380:Construct(MoonPropertyAnimator);
    v386:LoadAndConvertSave(gokuxzamasu.Moon, v385);
    v386:SetOriginalRoot(VFX:GetPivot());
    v386:SetRoot(Root);
    v386:PlayAll();
    vfxUtil.execute_compiled(gokuxzamasu.Compiled, v380, v384, v381, p378, v383, TekrinnDialogue);
end;

function v116.mvp_highestintheroom(p387: any, p388: number, p389: any, p390: any) -- Line: 3835
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), Lighting (copy), soundUtil (copy), MoonPropertyAnimator (copy)
    local highestintheroom = mvpAssets.highestintheroom;
    local Root = vfxUtil.getRoot(p387);
    local v391 = vfxUtil.mvp_cutscene_defaults(mainreplication, p388);
    local v392, v393 = mainreplication.cutsceneBlender(Root, highestintheroom.Animations.Cam, highestintheroom.FOV_CutsceneMVP, nil, nil, CFrame.new(), highestintheroom.CamRig);
    v391:Add(v393);
    local VFX = highestintheroom.VFX;
    local v394 = v391:Clone(VFX);
    v394:PivotTo(Root.CFrame);
    v391:Add(v394.MVPCloud).Parent = workspace.Terrain;
    v394.Parent = workspace.Effects;
    local v395 = v391:Add(vfxUtil.getMoonEffects());
    local v396 = {
        Cam = v392,
        Camera = v392,
        Lighting = Lighting,
        Workspace = v394,
        nights = p387,
        Letterbox = v395.Letterbox.Letterbox,
        ["Screen Cover"] = v395["Screen Cover"]
    };
    local u397 = {};

    for _, v in { "Ambient", "Brightness", "ClockTime", "ColorShift_Bottom", "ColorShift_Top", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "ExposureCompensation", "FogColor", "FogEnd", "FogStart", "GeographicLatitude", "GlobalShadows", "OutdoorAmbient", "ShadowSoftness" } do
        u397[v] = Lighting[v];
    end;

    local Folder = Instance.new("Folder");
    local Children = Lighting:GetChildren();

    for _, v in Children do
        v.Parent = Folder;
    end;

    v391:Add(function() -- Line: 3883
        -- upvalues: Lighting (ref), Children (copy), Folder (copy), u397 (copy)
        for _, child in Lighting:GetChildren() do
            child:Destroy();
        end;

        for _, v in Children do
            if v.Parent == Folder then
                v.Parent = Lighting;
            end;
        end;

        Folder:Destroy();

        for i, v in u397 do
            Lighting[i] = v;
        end;
    end);
    soundUtil:play(highestintheroom.soundmvp, "default");
    local v398 = v391:Construct(MoonPropertyAnimator);
    v398:LoadAndConvertSave(highestintheroom.Moon, v396);
    v398:SetOriginalRoot(VFX:GetPivot());
    v398:SetRoot(v394.Rooter);
    v398:PlayAll();
    vfxUtil.execute_compiled(highestintheroom.Compiled, v391, v394, v392, p387);
end;

return v116;