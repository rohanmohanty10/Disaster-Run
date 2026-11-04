 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local Util = require(ReplicatedStorage.util.Util);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local mvpAssets = vfxUtil.getResources().mvpAssets;

return {
    mvp_DragonInTheSky = function(p1: any, p2: number, p3: any, p4: any) -- Line: 21, Name: mvp_DragonInTheSky
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), RunService (copy), Util (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local DragonInTheSky = mvpAssets.DragonInTheSky;
        local Animations = DragonInTheSky.Animations;
        local Root = vfxUtil.getRoot(p1);
        local Root2 = vfxUtil.getRoot(p4[1]);
        local u5 = Root.CFrame * CFrame.new(0, 1000, 0);
        Root.Anchored = true;
        Root.CFrame = u5;

        if Root2 then
            Root2.Anchored = true;
            Root2.CFrame = u5;
        end;

        local v6 = vfxUtil.mvp_cutscene_defaults(mainreplication, p2, {
            Dim = true
        });

        local function pin_roots() -- Line: 39
            -- upvalues: Root (copy), u5 (copy), Root2 (copy)
            if Root.CFrame ~= u5 then
                Root.CFrame = u5;
            end;

            if Root2 and (Root2.Parent and Root2.CFrame ~= u5) then
                Root2.CFrame = u5;
            end;
        end;

        v6:Connect(RunService.PreRender, pin_roots);
        v6:Connect(RunService.PreSimulation, pin_roots);
        v6:Connect(RunService.PostSimulation, pin_roots);
        local _baseplate_controller, u7 = vfxUtil.get_baseplate_controller();
        u7.Transparency = 1;
        _baseplate_controller.update();
        v6:Add(function() -- Line: 55
            -- upvalues: u7 (copy), _baseplate_controller (copy)
            u7.Transparency = 0;
            _baseplate_controller.update();
        end);
        local v8 = v6:Clone(DragonInTheSky.Baseplate);
        v8.CFrame = u5 * CFrame.new(0, -3.35 - v8.Size.Y / 2, 0);
        v8.Parent = workspace.Effects;
        v6:Add(Util.Preload(DragonInTheSky.ImpactFrame));
        soundUtil:play(DragonInTheSky.soundmvp, "default");
        v6:Add(task.delay(8.2, function() -- Line: 68
            -- upvalues: Util (ref), DragonInTheSky (copy)
            Util.Gif(DragonInTheSky.ImpactFrame, 15);
        end));
        local v9 = v6:Clone(DragonInTheSky.Aura);
        vfxUtil.setupAura(p4[1], v9, true);
        v9.Parent = p4[1];
        local v10 = v6:Clone(DragonInTheSky.DragonModel);
        v10.Parent = workspace.Effects;
        v10:PivotTo(u5 * CFrame.new(-2.41400003, 2.00600052, 4.70000076, -1, 0, -8.74227766e-8, 0, 1, 0, 8.74227766e-8, 0, -1));
        v10.AnimationController.Animator:LoadAnimation(Animations.Dragon):Play(0);
        local v11 = v6:Clone(DragonInTheSky.Effects);
        v11:PivotTo(u5);
        v11.Parent = workspace.Effects;
        local v12, v13 = mainreplication.cutsceneBlender(Root, Animations.Cam, Animations.FOV, nil, nil, CFrame.new(0, -3, 0), DragonInTheSky.Cam);
        v6:Add(v13);
        local v14 = v6:Add(vfxUtil.getMoonEffects());
        local v15 = {
            Vignette = v14.Vignette,
            ["Screen Cover"] = v14["Screen Cover"],
            Lighting = Lighting
        };
        vfxUtil.cutscene_lighting(v6, v15, DragonInTheSky.Lighting, {
            Brightness = 3,
            EnvironmentDiffuseScale = 0.25,
            EnvironmentSpecularScale = 1,
            ClockTime = 8,
            GeographicLatitude = 0,
            ExposureCompensation = 0,
            Ambient = Color3.fromRGB(157, 151, 151),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        });
        local v16 = v6:Construct(MoonPropertyAnimator);
        v16:LoadAndConvertSave(DragonInTheSky.Moon, v15);
        v16:PlayAll();
        vfxUtil.execute_compiled(DragonInTheSky.Compiled, v6, v9, v12, v11);
    end,

    mvp_egoists_or_something = function(p17: any, p18: number, p19: any, p20: any) -- Line: 116, Name: mvp_egoists_or_something
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local egoists_or_something = mvpAssets.egoists_or_something;
        local Animations = egoists_or_something.Animations;
        local Root = vfxUtil.getRoot(p17);
        local v21 = vfxUtil.mvp_cutscene_defaults(mainreplication, p18);
        local _baseplate_controller, u22 = vfxUtil.get_baseplate_controller();
        u22.Transparency = 1;
        _baseplate_controller.update();
        v21:Add(function() -- Line: 127
            -- upvalues: u22 (copy), _baseplate_controller (copy)
            u22.Transparency = 0;
            _baseplate_controller.update();
        end);
        v21:Add(task.delay(5.566666666666666, function() -- Line: 132
            -- upvalues: u22 (copy), _baseplate_controller (copy)
            u22.Transparency = 0;
            _baseplate_controller.update();
        end));
        local u23, u24 = vfxUtil.newRigForFriend(Root);
        task.spawn(function() -- Line: 138
            -- upvalues: u24 (copy), u23 (copy)
            if not u24.Value then
                u24.Changed:Wait();
            end;

            local v25 = u23:FindFirstChildWhichIsA("Shirt");

            if v25 then
                v25.ShirtTemplate = "rbxassetid://90020804182010";
            end;

            local v26 = u23:FindFirstChildWhichIsA("Pants");

            if v26 then
                v26.PantsTemplate = "rbxassetid://124812264158811";
            end;
        end);
        v21:Add(u23);
        local v27 = v21:Clone(egoists_or_something.VFX);
        v27:PivotTo(Root.CFrame);
        v27.Parent = workspace.Effects;
        v21:Add(vfxUtil.buildFromRig(p17, egoists_or_something.kuztfr));
        v21:Add(vfxUtil.buildFromRig(p20[1], egoists_or_something.Batacoru));
        v21:Add(vfxUtil.buildFromRig(u23, egoists_or_something.CementalCLWN));
        soundUtil:play(egoists_or_something.soundmvp, "default");
        animationUtil:loadAnimation(u23, Animations.Friend):Play(0);
        local v28, v29 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations.Cam, Animations.FOV, nil, "default", egoists_or_something.cam, "CamPart");
        v21:Add(v29);
        local v30 = {
            Workspace = v27,
            Lighting = Lighting
        };
        vfxUtil.cutscene_lighting(v21, v30, egoists_or_something.Lighting, {
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            ExposureCompensation = 0,
            ClockTime = 12,
            GeographicLatitude = 24,
            Ambient = Color3.new(0.27451, 0.27451, 0.27451),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            ColorShift_Top = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.new(0.27451, 0.27451, 0.27451)
        });
        local v31 = v21:Construct(MoonPropertyAnimator);
        v31:LoadAndConvertSave(egoists_or_something.Moon, v30);
        v31:SetOriginalRoot(egoists_or_something.VFX:GetPivot());
        v31:SetRoot(Root);
        v31:PlayAll();
        vfxUtil.execute_compiled(egoists_or_something.Compiled, v21, v27, v28, { p17, p20[1], u23 });
    end,

    mvp_aizen2 = function(p32: any, p33: number) -- Line: 192, Name: mvp_aizen2
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local aizen2 = mvpAssets.aizen2;
        local Root = vfxUtil.getRoot(p32);
        local v34 = vfxUtil.mvp_cutscene_defaults(mainreplication, p33);
        v34:Add(vfxUtil.buildFromRig(p32, aizen2.aizenawk), "Destroy");
        local _, v35 = mainreplication.cutsceneCamRigWithLetterBox(Root, aizen2.Cutscene, aizen2.FOV, nil, CFrame.new(0, -3, 0) * CFrame.Angles(0, -1.5707963267948966, 0), aizen2.Cam, "CamPart");
        v34:Add(task.delay(16, v35));
        local v36 = v34:Clone(aizen2.VFX);
        v36:PivotTo(Root.CFrame);
        v36.Parent = workspace.Effects;
        soundUtil:play(aizen2.Sound, "default");
        vfxUtil.execute_compiled(aizen2.Compiled, v34, v36, p32);
        local v37 = v34:Add(vfxUtil.getMoonEffects());
        local v38 = {
            Vignette = v37.Vignette,
            ["Screen Cover"] = v37["Screen Cover"],
            Lighting = Lighting,
            Room = v36.Room
        };
        local v39 = v34:Construct(MoonPropertyAnimator);
        v39:LoadAndConvertSave(aizen2.Moon, v38);
        v39:PlayAll();
    end,

    mvp_Arachnid = function(p40: any, p41: number, p42: any, p43: any) -- Line: 232, Name: mvp_Arachnid
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local Arachnid = mvpAssets.Arachnid;
        local Animations = Arachnid.Animations;
        local Root = vfxUtil.getRoot(p40);
        local v44 = vfxUtil.mvp_cutscene_defaults(mainreplication, p41);
        local _baseplate_controller, u45 = vfxUtil.get_baseplate_controller();
        u45.Transparency = 1;
        _baseplate_controller.update();
        local v46 = p43[1];
        v44:Add(function() -- Line: 246
            -- upvalues: u45 (copy), _baseplate_controller (copy)
            u45.Transparency = 0;
            _baseplate_controller.update();
        end);
        local v47, _ = vfxUtil.newRigForFriend(Root);
        v44:Add(v47);
        local v48 = v44:Clone(Arachnid.VFX);
        v48:PivotTo(Root.CFrame);
        v48.Parent = workspace.Effects;
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = v47:FindFirstChild("Left Arm");
        Attachment.Position = Vector3.new(0, -1, 0);
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Parent = p40:FindFirstChild("Right Arm");
        Attachment2.Position = Vector3.new(0, -1, 0);
        local Attachment3 = Instance.new("Attachment");
        Attachment3.Parent = v46:FindFirstChild("Left Arm");
        Attachment3.Position = Vector3.new(0, -1, 0);

        for _, child in v48.Part:GetChildren() do
            if child:IsA("Beam") then
                child.Attachment1 = Attachment2;
            end;
        end;

        for _, child in v48.Part2:GetChildren() do
            if child:IsA("Beam") then
                child.Attachment1 = Attachment3;
            end;
        end;

        for _, child in v48.Part3:GetChildren() do
            if child:IsA("Beam") then
                child.Attachment1 = Attachment;
            end;
        end;

        soundUtil:play(Arachnid.soundmvp, "default");
        animationUtil:loadAnimation(v47, Animations.Friend):Play(0);
        local v49, v50 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations.Cam, Animations.FOV, nil, "default", Arachnid.Cam, "CamPart");
        v44:Add(v50);
        local v51 = {
            Workspace = v48,
            Lighting = Lighting
        };
        vfxUtil.cutscene_lighting(v44, v51, Arachnid.Lighting, {
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            ExposureCompensation = 0,
            ClockTime = 0,
            GeographicLatitude = 144,
            Ambient = Color3.new(0.27451, 0.27451, 0.27451),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            ColorShift_Top = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.new(0.27451, 0.27451, 0.27451)
        });
        local v52 = v44:Construct(MoonPropertyAnimator);
        v52:LoadAndConvertSave(Arachnid.Moon, v51);
        v52:SetOriginalRoot(Arachnid.VFX:GetPivot());
        v52:SetRoot(Root);
        v52:PlayAll();
        vfxUtil.execute_compiled(Arachnid.Compiled, v44, v48, v49);
    end,

    mvp_superstarMVP = function(p53: any, p54: number, p55: any, p56: table) -- Line: 317, Name: mvp_superstarMVP
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), MoonPropertyAnimator (copy), Players (copy), TekrinnDialogue (copy), Util (copy), soundUtil (copy)
        local superstarMVP = mvpAssets.superstarMVP;
        local Animations = superstarMVP.Animations;
        local Root = vfxUtil.getRoot(p53);
        local v57 = p56[1];
        local u58 = vfxUtil.mvp_cutscene_defaults(mainreplication, p54);
        local v59 = u58:Clone(superstarMVP.VFX);
        v59:PivotTo(Root.CFrame);
        v59.Parent = workspace.Effects;
        local v60, _ = vfxUtil.buildFromRig(p53, superstarMVP.TemplateR6);
        u58:Add(v60);
        local v61, _ = vfxUtil.buildFromRig(v57, superstarMVP.R6);
        u58:Add(v61);
        local MoonEffects = vfxUtil.getMoonEffects();
        u58:Add(MoonEffects);
        local v62, v63 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations.Cam, superstarMVP.FOV, nil, CFrame.new(0, -3, -4) * CFrame.Angles(0, 3.141592653589793, 0), superstarMVP.Cam, "CamPart");
        u58:Add(v63);
        local v64 = {
            Vignette = MoonEffects.Vignette,
            ["Screen Cover"] = MoonEffects["Screen Cover"],
            Cam = v62,
            Workspace = v59
        };
        vfxUtil.cutscene_lighting(u58, v64, superstarMVP.Lighting, {
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            ExposureCompensation = 0,
            ClockTime = 8,
            GeographicLatitude = 0,
            Ambient = Color3.new(0.27451, 0.27451, 0.27451),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            ColorShift_Top = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.new(0.27451, 0.27451, 0.27451)
        });
        local v65 = u58:Construct(MoonPropertyAnimator);
        v65:LoadAndConvertSave(superstarMVP.Moon, v64);
        v65:SetOriginalRoot(superstarMVP.VFX:GetPivot());
        v65:SetRoot(Root);
        v65:PlayAll();
        vfxUtil.execute_compiled(superstarMVP.Compiled, u58, v59, v62, p53, v57);
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v57);
        local u66 = not PlayerFromCharacter and "Isagi" or PlayerFromCharacter.DisplayName;
        u58:Add(task.delay(0.383, function() -- Line: 377
            -- upvalues: u58 (copy), TekrinnDialogue (ref), u66 (ref)
            u58:Add(TekrinnDialogue.Speak(u66, {
                {
                    Text = "No way...",
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 4, nil, Color3.fromRGB(0, 170, 255)));
        end));
        u58:Add(task.delay(2.155, function() -- Line: 390
            -- upvalues: u58 (copy), TekrinnDialogue (ref), u66 (ref)
            u58:Add(TekrinnDialogue.Speak(u66, {
                {
                    Text = "This guy\'s a...",
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 4, nil, Color3.fromRGB(0, 170, 255)));
        end));
        u58:Add(task.delay(3.959, function() -- Line: 403
            -- upvalues: u58 (copy), TekrinnDialogue (ref), u66 (ref)
            u58:Add(TekrinnDialogue.Speak(u66, {
                {
                    Text = ".. superstar.",
                    Bold = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255)) })
                }
            }, 1, nil, Color3.fromRGB(0, 170, 255)));
        end));
        local _baseplate_controller, u67 = vfxUtil.get_baseplate_controller();
        u58:Add(Util.frame_delay(415, function() -- Line: 419
            -- upvalues: u67 (copy), _baseplate_controller (copy)
            u67.Transparency = 1;
            _baseplate_controller.update();
        end));
        u58:Add(function() -- Line: 424
            -- upvalues: u67 (copy), _baseplate_controller (copy)
            u67.Transparency = 0;
            _baseplate_controller.update();
        end);
        soundUtil:play(superstarMVP.Sound, "default");
    end,

    mvp_raidenMVP = function(p68: any, p69: number) -- Line: 432, Name: mvp_raidenMVP
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local raidenMVP = mvpAssets.raidenMVP;
        local Root = vfxUtil.getRoot(p68);
        local v70 = vfxUtil.mvp_cutscene_defaults(mainreplication, p69);
        local v71, _ = vfxUtil.buildFromRig(p68, raidenMVP.Rig);
        v70:Add(v71);
        local v72, v73 = mainreplication.cutsceneCamRigWithLetterBox(Root, raidenMVP.Animations.Cam, raidenMVP.FOV_Raiden, nil, "default", raidenMVP.Cam, "CameraPart");
        v70:Add(v73);
        local v74 = v70:Clone(raidenMVP.VFX);
        v74:PivotTo(Root.CFrame);
        v74.Parent = workspace.Effects;
        soundUtil:play(raidenMVP.Sound, "default");
        local v75 = v70:Add(vfxUtil.getMoonEffects());
        local v76 = {
            Vignette = v75.Vignette,
            ["Screen Cover"] = v75["Screen Cover"],
            Lighting = Lighting,
            CameraController = v72
        };
        vfxUtil.cutscene_lighting(v70, v76, raidenMVP.Lighting, {
            Brightness = 4.58,
            ClockTime = 17.5,
            GeographicLatitude = 0,
            Ambient = Color3.fromRGB(70, 70, 70),
            ColorShift_Top = Color3.fromRGB(204, 216, 75),
            ColorShift_Bottom = Color3.fromRGB(214, 220, 156),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        });
        v70:Add(function() -- Line: 479
            -- upvalues: vfxUtil (ref)
            vfxUtil.restore_lighting();
            vfxUtil.restore_lighting_properties();
        end);
        local v77 = v70:Construct(MoonPropertyAnimator);
        v77:LoadAndConvertSave(raidenMVP.Moon, v76);
        v77:SetRoot(Root);
        v77:PlayAll();
    end,

    mvp_listenupMVP = function(u78: any, p79: number, p80: any, p81: any) -- Line: 490, Name: mvp_listenupMVP
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), MoonPropertyAnimator (copy), Players (copy), TekrinnDialogue (copy)
        local listenupMVP = mvpAssets.listenupMVP;
        local Root = vfxUtil.getRoot(u78);
        local u82 = vfxUtil.mvp_cutscene_defaults(mainreplication, p79);
        local v83 = p81[1];
        local v84, v85 = mainreplication.cutsceneBlender(Root, listenupMVP.Animations.Cam, listenupMVP.FOV_ListenUp);
        u82:Add(v85);
        local v86 = u82:Clone(listenupMVP.VFX.Sphere);
        v86:PivotTo(Root.CFrame);
        v86.Parent = workspace.Effects;
        local v87 = {
            Head = {}
        };

        for _, child in v86:GetChildren() do
            local v88 = child:FindFirstChildWhichIsA("Motor6D");

            if v88 then
                v88.Part0 = v84.CamPart;
                v87[child.Name] = child;
            end;
        end;

        for _, child in listenupMVP.VFX.Isagi:GetChildren() do
            local v89 = u82:Clone(child);
            v89.Parent = u78.Head;
            table.insert(v87.Head, v89);
        end;

        soundUtil:play(listenupMVP.SFX, "default");
        local v90 = u82:Construct(MoonPropertyAnimator);
        v90:LoadAndConvertSave(listenupMVP.Moon, {
            Workspace = v86
        });
        v90:SetOriginalRoot(listenupMVP.VFX.Sphere.PrimaryPart.CFrame);
        v90:SetRoot(Root);
        v90:PlayAll();
        vfxUtil.execute_compiled(listenupMVP.Compiled, u82, v87);
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v83);
        local u91 = not PlayerFromCharacter and "Barou" or PlayerFromCharacter.DisplayName;
        u82:Add(task.delay(0.18333333333333332, function() -- Line: 545
            -- upvalues: u82 (copy), TekrinnDialogue (ref), u78 (copy), u91 (ref)
            u82:Add(TekrinnDialogue.Speak(u78, {
                {
                    TypeSpeed = 0.05,
                    Text = string.format("Listen up, %s", u91),
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            }, 4));
        end));
        u82:Add(task.delay(2.066666666666667, function() -- Line: 563
            -- upvalues: u82 (copy), TekrinnDialogue (ref), u78 (copy)
            u82:Add(TekrinnDialogue.Speak(u78, {
                {
                    Text = "You just keep playing the way you are",
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 4));
        end));
        u82:Add(task.delay(4.5, function() -- Line: 576
            -- upvalues: u82 (copy), TekrinnDialogue (ref), u78 (copy)
            u82:Add(TekrinnDialogue.Speak(u78, {
                {
                    Text = "And dont drag us down.",
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 4));
        end));
        u82:Add(task.delay(7.75, function() -- Line: 589
            -- upvalues: u82 (copy), TekrinnDialogue (ref), u78 (copy)
            u82:Add(TekrinnDialogue.Speak(u78, {
                {
                    Text = "I\'m telling you, you better not get in my way.",
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 4));
        end));
        u82:Add(task.delay(10.833333333333334, function() -- Line: 602
            -- upvalues: u82 (copy), TekrinnDialogue (ref), u78 (copy)
            u82:Add(TekrinnDialogue.Speak(u78, {
                {
                    Text = "DONKEY",
                    Bold = true,
                    TypeSpeed = 0.06,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 45, 45)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 0, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2));
        end));
    end,

    mvp_potentialman = function(u92: any, p93: number, p94: any, p95: any) -- Line: 622, Name: mvp_potentialman
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
        local potentialman = mvpAssets.potentialman;
        local Root = vfxUtil.getRoot(u92);
        local u96 = p95[1];
        local u97 = vfxUtil.mvp_cutscene_defaults(mainreplication, p93);
        local _baseplate_controller, u98 = vfxUtil.get_baseplate_controller();
        u98.Transparency = 1;
        _baseplate_controller.update();
        u97:Add(function() -- Line: 633
            -- upvalues: u98 (copy), _baseplate_controller (copy)
            u98.Transparency = 0;
            _baseplate_controller.update();
        end);
        local v99, v100 = mainreplication.cutsceneBlender(Root, potentialman.Animations.Cam, potentialman.FOV_Chimera);
        u97:Add(v100);
        local v101 = u97:Clone(potentialman.VFX);
        v101:PivotTo(Root.CFrame);
        v101.Parent = workspace.Effects;
        local v102 = {
            Head = {},
            main = v101.main
        };

        for _, child in v101.Camera:GetChildren() do
            u97:Add(child).Parent = v99.CamPart;
        end;

        v101.Camera:Destroy();

        for _, child in v101.Eyes:GetChildren() do
            local v103 = u97:Clone(child);
            v103.Parent = u92.Head;
            table.insert(v102.Head, v103);
        end;

        v101.Eyes:Destroy();
        soundUtil:play(potentialman.SFX, "default");
        local MoonEffects = vfxUtil.getMoonEffects();
        u97:Add(MoonEffects);
        local v104 = {
            Workspace = v101,
            Lighting = Lighting,
            ["Screen Cover"] = MoonEffects["Screen Cover"]
        };
        vfxUtil.cutscene_lighting(u97, v104, potentialman.Lighting, {
            ClockTime = 0
        });
        local v105 = u97:Construct(MoonPropertyAnimator);
        v105:LoadAndConvertSave(potentialman.Moon, v104);
        v105:SetOriginalRoot(potentialman.VFX.PrimaryPart.CFrame);
        v105:SetRoot(Root);
        v105:PlayAll();
        vfxUtil.execute_compiled(potentialman.Compiled, u97, v102, v99.CamPart);
        u97:Add(task.delay(0.4, function() -- Line: 691
            -- upvalues: u97 (copy), TekrinnDialogue (ref), u92 (copy)
            u97:Add(TekrinnDialogue.Speak(u92, {
                {
                    Text = "Arent you forgetting something..?",
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 3
                    }
                }
            }, 4));
        end));
        u97:Add(task.delay(2.716666666666667, function() -- Line: 711
            -- upvalues: u97 (copy), TekrinnDialogue (ref), u96 (copy)
            u97:Add(TekrinnDialogue.Speak(u96, {
                {
                    Text = "Huh?",
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 4));
        end));
        u97:Add(task.delay(4.083333333333333, function() -- Line: 725
            -- upvalues: u97 (copy), TekrinnDialogue (ref), u92 (copy)
            u97:Add(TekrinnDialogue.Speak(u92, {
                {
                    Text = "ABOVE US IS A SHADOW TOO!",
                    TypeSpeed = 0.08,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                }
            }, 4));
        end));
        u97:Add(task.delay(9.666666666666666, function() -- Line: 745
            -- upvalues: u97 (copy), TekrinnDialogue (ref), u92 (copy)
            u97:Add(TekrinnDialogue.Speak(u92, {
                {
                    Text = "SHADOW GARDEN, CHIMERA!",
                    TypeSpeed = 0.06,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 4));
        end));

        if workspace.Terrain:FindFirstChild("Clouds") then
            workspace.Terrain.Clouds.Enabled = false;
            u97:Add(function() -- Line: 767
                workspace.Terrain.Clouds.Enabled = true;
            end);
        end;
    end,

    mvp_isagiNigeriaWC = function(p106: any, p107: number) -- Line: 773, Name: mvp_isagiNigeriaWC
        -- upvalues: mvpAssets (copy), vfxUtil (copy), soundUtil (copy), mainreplication (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local U20WC_Nigeria = mvpAssets.U20WC_Nigeria;
        local Root = vfxUtil.getRoot(p106);
        soundUtil:play(U20WC_Nigeria.soundmvp, "default");
        local v108 = vfxUtil.mvp_cutscene_defaults(mainreplication, p107);
        local v109 = v108:Clone(U20WC_Nigeria.VFX);
        v109:PivotTo(Root.CFrame);
        v109.Parent = workspace.Effects;
        v108:Add(vfxUtil.buildFromRig(p106, U20WC_Nigeria.isagi));
        local v110, v111 = mainreplication.cutsceneCamRigWithLetterBox(Root, U20WC_Nigeria.CamAnimation, U20WC_Nigeria.FOV, nil, "default", U20WC_Nigeria.Cam, "CamPart");
        v108:Add(v111);
        local v112 = {
            Workspace = v109,
            Lighting = Lighting,
            isagi = p106
        };
        vfxUtil.cutscene_lighting(v108, v112, U20WC_Nigeria.Lighting, {
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
        local v113 = v108:Construct(MoonPropertyAnimator);
        v113:LoadAndConvertSave(U20WC_Nigeria.Moon, v112);
        v113:SetOriginalRoot(U20WC_Nigeria.VFX:GetPivot());
        v113:SetRoot(Root);
        v113:PlayAll();
        vfxUtil.execute_compiled(U20WC_Nigeria.Compiled, v108, v109, v110, p106);
    end,

    mvp_goBeyond = function(p114: any, p115: number, p116: any, p117: any) -- Line: 813, Name: mvp_goBeyond
        -- upvalues: mvpAssets (copy), vfxUtil (copy), soundUtil (copy), mainreplication (copy), Players (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
        local goBeyond = mvpAssets.goBeyond;
        local Root = vfxUtil.getRoot(p114);
        local Root2 = vfxUtil.getRoot(p117[1]);
        soundUtil:play(goBeyond.SFX, "default", {
            Character = p114
        });
        local v118 = vfxUtil.mvp_cutscene_defaults(mainreplication, p115);
        local v119 = v118:Clone(goBeyond.background);
        v119:PivotTo(Root.CFrame * CFrame.new(0.53, 1.026, 11.16));
        v119.Parent = workspace.Effects;
        local v120 = v118:Add(vfxUtil.newRigForFriend(Root, nil, CFrame.new(12.28, 0, 0)));
        local v121 = v118:Add(vfxUtil.newRigForFriend(Root, Players:GetPlayerFromCharacter(p117[1]), CFrame.new(18.42, 0, 0)));
        v118:Add(animationUtil:loadAnimation(v120, goBeyond.Animations.Victims["2"]), "Stop"):Play(0);
        v118:Add(animationUtil:loadAnimation(v121, goBeyond.Animations.Victims["3"]), "Stop"):Play(0);

        for i, v in {
            p114,
            Root2,
            v120,
            v121
        } do
            vfxUtil.buildFromRig(v, goBeyond[i], v118);
        end;

        local v122 = {
            Cam = v118:Add(mainreplication.kuronaCamToAll(Root, goBeyond.Cam, goBeyond.FOV_Beyond)),
            Lighting = Lighting,
            Vignette = v118:Add(vfxUtil.getMoonEffects()).Vignette
        };
        vfxUtil.cutscene_lighting(v118, v122, goBeyond.Lighting, {
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
        local v123 = v118:Construct(MoonPropertyAnimator);
        v123:LoadAndConvertSave(goBeyond.Moon, v122);
        v123:SetRoot(Root);
        v123:PlayAll();
        vfxUtil.execute_compiled(goBeyond.Compiled, v118, {
            Deku = p114,
            Shigaraki = Root2,
            Bakugo = v120,
            ["All For One"] = v121
        });
        v118:Add(task.delay(2, TekrinnDialogue.Speak, "", {
            {
                Text = "GO BEYOND!",
                TypeSpeed = 0.1,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            }
        }, 3));
    end,

    mvp_talentedlearners = function(p124: any, p125: number, p126: any, p127: any) -- Line: 890, Name: mvp_talentedlearners
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local talentedlearners = mvpAssets.talentedlearners;
        local Root = vfxUtil.getRoot(p124);
        local v128 = vfxUtil.mvp_cutscene_defaults(mainreplication, p125);
        local v129, v130 = mainreplication.cutsceneBlender(Root, talentedlearners.Animations.Cam, talentedlearners.FOV_Talent, nil, nil, CFrame.new(0, -3, 0), talentedlearners.Cam3);
        v128:Add(v130);
        soundUtil:play(talentedlearners.SFX, "default", {
            Character = p124
        });
        local v131 = p127[1];

        for i, v in { p124, v131 } do
            vfxUtil.buildFromRig(v, talentedlearners.Rigs[i], v128);
        end;

        local v132 = v128:Clone(talentedlearners.VFX);
        v132:PivotTo(Root.CFrame);
        v132.Parent = workspace.Effects;
        local v133 = {
            Cam = v129,
            Lighting = Lighting,
            Workspace = v132
        };
        vfxUtil.cutscene_lighting(v128, v133, talentedlearners.Lighting, {
            ClockTime = 12,
            GeographicLatitude = 24,
            ExposureCompensation = 0,
            ShadowSoftness = 0.2,
            Ambient = Color3.fromRGB(70, 70, 70),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        });
        local v134 = v128:Construct(MoonPropertyAnimator);
        v134:LoadAndConvertSave(talentedlearners.Moon, v133);
        v134:SetOriginalRoot(talentedlearners.VFX:GetPivot());
        v134:SetRoot(Root);
        v134:PlayAll();
        vfxUtil.execute_compiled(talentedlearners.Compiled, v128, v132, v129, p124, v131);
    end,

    mvp_comeback = function(p135: any, p136: number, p137: any, p138: any) -- Line: 940, Name: mvp_comeback
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local comeback = mvpAssets.comeback;
        local Root = vfxUtil.getRoot(p135);
        local v139 = vfxUtil.mvp_cutscene_defaults(mainreplication, p136);
        local _baseplate_controller, u140 = vfxUtil.get_baseplate_controller();
        u140.Transparency = 1;
        _baseplate_controller.update();
        v139:Add(function() -- Line: 950
            -- upvalues: u140 (copy), _baseplate_controller (copy)
            u140.Transparency = 0;
            _baseplate_controller.update();
        end);
        local u141 = vfxUtil.mvp_cutscene_defaults(mainreplication, p136);
        local v142, v143 = mainreplication.cutsceneBlender(Root, comeback.Animations.Cam, comeback.FOV_Comeback, nil, nil, CFrame.new(0, -3, 0), comeback.Cam);
        u141:Add(v143);
        soundUtil:play(comeback.SFX, "default", {
            Character = p135
        });
        vfxUtil.buildFromRig(p135, comeback.Rig, u141);
        local u144, u145 = vfxUtil.newRigForFriend(Root);
        task.spawn(function() -- Line: 970
            -- upvalues: u145 (copy), u144 (copy), u141 (copy), animationUtil (ref), comeback (copy)
            if not u145.Value then
                u145.Changed:Wait();
            end;

            u144:ScaleTo(1.5);
            u141:Add(animationUtil:loadAnimation(u144, comeback.Animations.Friend), "Stop"):Play(0);
        end);
        u141:Add(u144);
        local v146 = u141:Clone(comeback.VFX);
        v146:PivotTo(Root.CFrame);
        v146.Parent = workspace.Effects;
        local v147 = {
            Cam = v142,
            Lighting = Lighting,
            Workspace = v146,
            Letterbox = u141:Add(vfxUtil.getMoonEffects()).Letterbox.Letterbox
        };
        vfxUtil.cutscene_lighting(u141, v147, comeback.Lighting, {
            ClockTime = 12,
            GeographicLatitude = 24,
            ExposureCompensation = 0,
            ShadowSoftness = 0.2,
            Ambient = Color3.fromRGB(70, 70, 70),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        });
        local v148 = u141:Construct(MoonPropertyAnimator);
        v148:LoadAndConvertSave(comeback.Moon, v147);
        v148:SetOriginalRoot(comeback.VFX:GetPivot());
        v148:SetRoot(Root);
        v148:PlayAll();
        vfxUtil.execute_compiled(comeback.Compiled, u141, v146, v142);
    end,

    mvp_cyberMVP = function(p149: any, p150: number, p151: any, p152: any) -- Line: 1009, Name: mvp_cyberMVP
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local cyberMVP = mvpAssets.cyberMVP;
        local Root = vfxUtil.getRoot(p149);
        local v153 = vfxUtil.mvp_cutscene_defaults(mainreplication, p150);
        local v154, v155 = mainreplication.cutsceneBlender(Root, cyberMVP.Animations.Cam, cyberMVP.FOV_CyberMVP, nil, nil, CFrame.identity, cyberMVP.Cam);
        v153:Add(v155);
        soundUtil:play(cyberMVP.Sound, "default", {
            Character = p149
        });
        vfxUtil.buildFromRig(p149, cyberMVP.Rig, v153);
        v153:Add(animationUtil:loadAnimation(v153:Add(vfxUtil.newRigForFriend(Root, nil, CFrame.new(0, 0, -1))), cyberMVP.Animations.Lucy), "Stop"):Play(0);
        local v156 = v153:Clone(cyberMVP.VFX);
        v156:PivotTo(Root.CFrame);
        v156.Parent = workspace.Effects;
        local u157 = v153:Clone(cyberMVP.ScreenGui);
        u157.Parent = vfxUtil.getPlayerGui();
        v153:Add(task.delay(15.15, function() -- Line: 1039
            -- upvalues: u157 (copy)
            u157.Enabled = true;
        end));
        v153:Add(task.delay(16.466666666666665, function() -- Line: 1043
            -- upvalues: u157 (copy)
            u157.Enabled = false;
        end));
        local v158 = {
            Cam = v154,
            Camera = v154,
            Lighting = Lighting,
            Workspace = v156,
            Vignette = v153:Add(vfxUtil.getMoonEffects()).Vignette
        };
        vfxUtil.cutscene_lighting(v153, v158, cyberMVP:FindFirstChild("Lighting"), {
            Brightness = 3,
            ClockTime = 8.600000381469727,
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            ExposureCompensation = 0.20000000298023224,
            GeographicLatitude = 23,
            GlobalShadows = true,
            ShadowSoftness = 1,
            Ambient = Color3.new(1, 1, 1),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            ColorShift_Top = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.new(0.18431372940540314, 0.18431372940540314, 0.18431372940540314)
        });
        local v159 = v153:Construct(MoonPropertyAnimator);
        v159:LoadAndConvertSave(cyberMVP.Moon, v158);
        v159:SetOriginalRoot(cyberMVP.VFX:GetPivot());
        v159:SetRoot(Root);
        v159:PlayAll();
        vfxUtil.execute_compiled(cyberMVP.Compiled, v153, v156, v154, p149);
    end,

    mvp_dmcMVP = function(p160: any, p161: number) -- Line: 1082, Name: mvp_dmcMVP
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy)
        local dmcMVP = mvpAssets.dmcMVP;
        local Root = vfxUtil.getRoot(p160);
        local v162 = vfxUtil.mvp_cutscene_defaults(mainreplication, p161);
        local v163, v164 = mainreplication.cutsceneBlender(Root, dmcMVP.Animations.Cam, dmcMVP.FOV_DMC);
        v162:Add(v164);
        soundUtil:play(dmcMVP.Sound, "default", {
            Character = p160
        });
        local v165 = v162:Add(vfxUtil.newRigForFriend(Root));
        v162:Add(animationUtil:loadAnimation(v165, dmcMVP.Animations.Victims["1"]), "Stop"):Play(0);

        for i, v in { p160, v165 } do
            vfxUtil.buildFromRig(v, dmcMVP.Rigs[i], v162);
        end;

        vfxUtil.cutscene_lighting(v162, {
            Cam = v163,
            Camera = v163,
            Lighting = Lighting
        }, dmcMVP:FindFirstChild("Lighting"), {
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
    end,

    mvp_leaguemvp = function(p166: any, p167: number) -- Line: 1124, Name: mvp_leaguemvp
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local leaguemvp = mvpAssets.leaguemvp;
        local Root = vfxUtil.getRoot(p166);
        local v168 = vfxUtil.mvp_cutscene_defaults(mainreplication, p167);
        local v169, v170 = mainreplication.cutsceneBlender(Root, leaguemvp.Animations.Cam, leaguemvp.FOV_League, nil, nil, CFrame.new(0, -3, 0), leaguemvp.Cam);
        v168:Add(v170);
        soundUtil:play(leaguemvp.soundmvp, "default", {
            Character = p166
        });
        vfxUtil.buildFromRig(p166, leaguemvp.Rig, v168);
        local v171 = v168:Clone(leaguemvp.VFX);
        v171:PivotTo(Root.CFrame * CFrame.new(0, -3, 0));
        v171.Parent = workspace.Effects;
        local v172 = {
            Cam = v169,
            Workspace = v171,
            Lighting = Lighting
        };
        vfxUtil.cutscene_lighting(v168, v172, leaguemvp:FindFirstChild("Lighting"), {
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
        local v173 = v168:Construct(MoonPropertyAnimator);
        v173:LoadAndConvertSave(leaguemvp.Moon, v172);
        v173:SetOriginalRoot(leaguemvp.VFX:GetPivot());
        v173:SetRoot(Root);
        v173:PlayAll();
        vfxUtil.execute_compiled(leaguemvp.Compiled, v168, v171, p166, v169);
    end,

    mvp_TheScary = function(p174: any, p175: number, p176: any) -- Line: 1177, Name: mvp_TheScary
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), Players (copy)
        local TheScary = mvpAssets.TheScary;
        local v177 = vfxUtil.mvp_cutscene_defaults(mainreplication, p175, {
            Dim = true
        });
        local u178 = v177:Clone(TheScary.UI);
        u178.Parent = Players.LocalPlayer.PlayerGui;
        u178.Sound:Play();
        v177:Add(task.delay(p175, function() -- Line: 1185
            -- upvalues: u178 (copy)
            if u178 then
                u178.Sound:Stop();
            end;
        end));
    end,

    mvp_bunnymvp = function(p179: any, p180: number, p181: any, p182: any) -- Line: 1192, Name: mvp_bunnymvp
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local bunnyMVP = mvpAssets.bunnyMVP;
        local Root = vfxUtil.getRoot(p179);

        if not Root then
            return;
        end;

        if p182 then
            p182 = p182[1];
        end;

        local v183 = vfxUtil.mvp_cutscene_defaults(mainreplication, p180);
        local CFrame_new_ret = CFrame.new(
            310.803741,
            2.95548964,
            30.5822697,
            -0.0377316736,
            -1.99640839e-27,
            0.999287069,
            -5.15986954e-26,
            1,
            -3.94612492e-27,
            -0.999287069,
            5.17108431e-26,
            -0.0377316438
        );
        v183:Add(soundUtil:play(bunnyMVP.soundmvp, "default", {
            Character = p179
        }));
        vfxUtil.cutscene_invisiball(p179, v183);

        for i, v in { p179, p182 } do
            vfxUtil.buildFromRig(v, bunnyMVP.Rigs[tostring(i)], v183);
        end;

        for _, v in { "Left Arm", "Right Arm" } do
            local v184 = p179:FindFirstChild(v);
            local v185;

            if v184 then
                v185 = v184:FindFirstChild("Fingers");
            else
                v185 = v184;
            end;

            if v185 then
                for _, child in v185:GetChildren() do
                    if child:IsA("BasePart") then
                        child.Color = v184.Color;
                    end;
                end;
            end;
        end;

        local v186 = v183:Clone(bunnyMVP.VFX);
        v186:PivotTo(Root.CFrame * CFrame_new_ret:ToObjectSpace(bunnyMVP.VFX:GetPivot()));
        v186.Parent = workspace.Effects;
        local _baseplate_controller, u187 = vfxUtil.get_baseplate_controller();
        local Transparency = u187.Transparency;
        u187.Transparency = 1;
        _baseplate_controller.update();
        v183:Add(function() -- Line: 1229
            -- upvalues: u187 (copy), Transparency (copy), _baseplate_controller (copy)
            u187.Transparency = Transparency;
            _baseplate_controller.update();
        end);
        local v188 = v183:Clone(bunnyMVP.Baseplate);
        v188.CFrame = Root.CFrame * CFrame_new_ret:ToObjectSpace(bunnyMVP.Baseplate.CFrame);
        v188.Parent = workspace.Effects;
        local v189, v190, _ = mainreplication.cutsceneCamRigWithLetterBox(Root, bunnyMVP.Animations.Cam, bunnyMVP.FOV_MVP, p179, CFrame.new(0.022, -2.455, -0.157) * CFrame.Angles(0, 3.141592653589793, 0), vfxUtil.getResources().HumanoidCameraRig, "Torso", "All");
        v183:Add(v190);
        local v191 = {
            Workspace = v186,
            ["Screen Cover"] = v183:Add(vfxUtil.getMoonEffects())["Screen Cover"]
        };
        vfxUtil.cutscene_lighting(v183, v191, bunnyMVP.Lighting, {
            Brightness = 0,
            ClockTime = 0,
            EnvironmentDiffuseScale = 0,
            EnvironmentSpecularScale = 0,
            ExposureCompensation = 0.20000000298023224,
            GeographicLatitude = 23,
            GlobalShadows = true,
            ShadowSoftness = 1,
            Ambient = Color3.new(0.27450981736183167, 0.27450981736183167, 0.27450981736183167),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            ColorShift_Top = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.new(0.27450981736183167, 0.27450981736183167, 0.27450981736183167)
        });
        local u192 = {
            FogColor = Lighting.FogColor,
            FogStart = Lighting.FogStart,
            FogEnd = Lighting.FogEnd
        };
        local u193 = workspace.Terrain:FindFirstChildOfClass("Clouds");
        local u194;

        if u193 then
            u194 = u193.Enabled;
        else
            u194 = u193;
        end;

        Lighting.FogColor = Color3.new(0.7529412508010864, 0.7529412508010864, 0.7529412508010864);
        Lighting.FogStart = 0;
        Lighting.FogEnd = 100000;

        if u193 then
            u193.Enabled = false;
        end;

        v183:Add(function() -- Line: 1282
            -- upvalues: u192 (copy), Lighting (ref), u193 (copy), u194 (copy)
            for i, v in u192 do
                Lighting[i] = v;
            end;

            if u193 and u193.Parent then
                u193.Enabled = u194;
            end;
        end);
        local v195 = v183:Construct(MoonPropertyAnimator);
        v195:LoadAndConvertSave(bunnyMVP.Moon, v191);
        v195:SetOriginalRoot(CFrame_new_ret);
        v195:SetRoot(Root);
        v195:PlayAll();
        vfxUtil.execute_compiled(bunnyMVP.Compiled, v183, v186, v189, p179, p182);
    end,

    mvp_chigirimvp = function(p196: any, p197: number, p198: any, p199: any) -- Line: 1298, Name: mvp_chigirimvp
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local chigirimvp = mvpAssets.chigirimvp;
        local Root = vfxUtil.getRoot(p196);
        local v200 = vfxUtil.mvp_cutscene_defaults(mainreplication, p197);
        local v201, v202 = mainreplication.cutsceneBlender(Root, chigirimvp.Animations.Cam, chigirimvp.FOV_bluelocker, nil, nil, CFrame.new(0, -3, 0), chigirimvp.Cam3);
        v200:Add(v202);
        v200:Add(soundUtil:play(chigirimvp.soundmvp, "default", {
            Character = p196
        }));
        vfxUtil.buildFromRig(p196, chigirimvp.Rig, v200);
        local VFX = chigirimvp.VFX;
        local v203 = v200:Clone(VFX);
        v203:PivotTo(Root.CFrame);
        v203.Parent = workspace.Effects;
        local v204 = {
            Cam = v201,
            Camera = v201,
            Lighting = Lighting,
            Workspace = v203
        };
        vfxUtil.cutscene_lighting(v200, v204, chigirimvp:FindFirstChild("Lighting"), {
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
        local v205 = v200:Construct(MoonPropertyAnimator);
        v205:LoadAndConvertSave(chigirimvp.Moon, v204);
        v205:SetOriginalRoot(VFX:GetPivot());
        v205:SetRoot(Root);
        v205:PlayAll();
        vfxUtil.execute_compiled(chigirimvp.Compiled, v200, v203, v201, p196);
    end,

    mvp_solongbluelock = function(p206: any, p207: number, p208: any, p209: any) -- Line: 1357, Name: mvp_solongbluelock
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
        local solongbluelock = mvpAssets.solongbluelock;
        local Root = vfxUtil.getRoot(p206);

        if p209 then
            p209 = p209[1];
        end;

        if not (Root and p209) then
            return;
        end;

        local v210 = vfxUtil.mvp_cutscene_defaults(mainreplication, p207);
        vfxUtil.cutscene_invisiball(p206, v210);
        local v211, v212 = mainreplication.cutsceneCamRigWithLetterBox(Root, solongbluelock.Animations.Cam, solongbluelock.FOV_SoLongBlueLockMVP, nil, CFrame.new(0, -3, 0), solongbluelock.SoLongBlueLockCAM, "CamPart", "All");
        v210:Add(v212);
        v210:Add(soundUtil:play(solongbluelock.soundmvp, "default", {
            Character = p206
        }));
        local _, v213 = vfxUtil.buildFromRig(p206, solongbluelock.Rigs["1"], v210);
        local _, v214 = vfxUtil.buildFromRig(p209, solongbluelock.Rigs["2"], v210);

        for i = 1, 2 do
            local v215, _ = vfxUtil.newRigForFriend(Root);
            v210:Add(v215);
            local u216 = animationUtil:loadAnimation(v215, solongbluelock.Animations.Victims[tostring(i)]);
            u216:Play(0);
            v210:Add(u216);
            v210:Add(task.delay(21.666666666666668, function() -- Line: 1391
                -- upvalues: u216 (copy)
                u216:AdjustSpeed(0);
            end));
            local _ = i;
        end;

        local VFX = solongbluelock.VFX;
        local v217 = v210:Clone(VFX);
        v217:PivotTo(Root.CFrame);
        v217.Parent = workspace.Effects;
        local v218 = {
            Cam = v211,
            Camera = v211,
            Lighting = Lighting,
            Workspace = v217,
            Letterbox = v210:Add(vfxUtil.getMoonEffects()).Letterbox.Letterbox
        };
        vfxUtil.cutscene_lighting(v210, v218, solongbluelock.Lighting, {
            Brightness = 3,
            ClockTime = 14.5,
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            ExposureCompensation = 0,
            GeographicLatitude = 0,
            GlobalShadows = true,
            ShadowSoftness = 0.2,
            FogStart = 0,
            FogEnd = 100000,
            Ambient = Color3.fromRGB(70, 70, 70),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            ColorShift_Top = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70),
            FogColor = Color3.fromRGB(192, 192, 192)
        });
        local v219 = v210:Construct(MoonPropertyAnimator);
        v219:LoadAndConvertSave(solongbluelock.Moon, v218);
        v219:SetOriginalRoot(VFX:GetPivot());
        v219:SetRoot(Root);
        v219:PlayAll();
        vfxUtil.execute_compiled(solongbluelock.Compiled, v210, v217, v211, v213, v214);
        v210:Add(task.delay(p207 - 1, function() -- Line: 1436
            -- upvalues: mainreplication (ref)
            mainreplication.newblackscene(0.75, 1, 3);
        end));
    end,

    mvp_doomMVP = function(u220: any, p221: number, p222: any) -- Line: 1441, Name: mvp_doomMVP
        -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), animationUtil (copy), actionUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), Util (copy), TekrinnDialogue (copy), soundUtil (copy)
        local doomMVP = mvpAssets.doomMVP;
        local u223 = vfxUtil.mvp_cutscene_defaults(mainreplication, p221);
        local Root = vfxUtil.getRoot(u220);
        local v224 = u223:Add((vfxUtil.newRigForFriend(Root)));
        u223:Add(animationUtil:loadAnimation(v224, doomMVP.Animations.Duo), "Stop"):Play(0);
        local u225 = {};

        for _, child in workspace.characters:GetChildren() do
            if child ~= u220 and actionUtil.checksameTeam(u220, child) then
                table.insert(u225, child);
            end;
        end;

        table.sort(u225, function(p226, p227) -- Line: 1455
            return p226.Name < p227.Name;
        end);
        local Random_new_ret = Random.new(p222.chosen);

        for i = 1, math.min(2, #u225 - 1) do
            local v228 = Random_new_ret:NextInteger(i, #u225);
            local v229 = u225[i];
            u225[i] = u225[v228];
            u225[v228] = v229;
            local _ = i;
        end;

        local function spawn_teammate(p230: number, p231: userdata) -- Line: 1465
            -- upvalues: u225 (copy), u223 (copy), vfxUtil (ref), Root (copy), mvpAssets (ref), animationUtil (ref)
            local v232 = u225[p230];
            local v233;

            if v232 then
                v233 = u223:Add(vfxUtil.newRig(Root));
                task.spawn(v233.Humanoid.ApplyDescriptionResetAsync, v233.Humanoid, v232.Humanoid:GetAppliedDescription());
            else
                v233 = u223:Clone(mvpAssets[`Rig{p230 + 2}`]);
                v233.HumanoidRootPart.CFrame = Root.CFrame;
                v233.Parent = workspace.Effects;
            end;

            u223:Add(animationUtil:loadAnimation(v233, p231), "Stop"):Play(0);

            return v233;
        end;

        vfxUtil.buildFromRig(u220, doomMVP.Rig, u223);
        local u234 = {};

        for _, child in u220:GetChildren() do
            local v235 = child:IsA("Accessory") and child:FindFirstChild("Handle");
            local v236;

            if v235 then
                v236 = v235:FindFirstChildOfClass("Attachment");
            else
                v236 = v235;
            end;

            if v236 and u220.Head:FindFirstChild(v236.Name) then
                v235.Transparency = 1;
                table.insert(u234, v235);
            end;
        end;

        u223:Add(function() -- Line: 1491
            -- upvalues: u234 (copy)
            for _, v in u234 do
                v.Transparency = 0;
            end;
        end);
        local v237 = {};

        for i, v in {
            Teammate1 = spawn_teammate(1, doomMVP.Animations.Teammate1),
            Duo = v224,
            Teammate2 = spawn_teammate(2, doomMVP.Animations.Teammate2)
        } do
            local v238 = v;
            local v239 = {};

            for _, child in doomMVP.HeadFX:GetChildren() do
                local v240 = u223:Clone(child);
                v240.Parent = v238.Head;

                for _, child2 in v240:GetChildren() do
                    table.insert(v239, child2);
                end;
            end;

            v237[i] = v239;
        end;

        local _, v241 = mainreplication.cutsceneCamRigWithLetterBox(Root, doomMVP.Animations.Cam, doomMVP.FOV, nil, "default", doomMVP.Cam, "CamPart");
        u223:Add(v241);
        local v242 = u223:Clone(doomMVP.VFX);
        v242:PivotTo(Root.CFrame);
        v242.Parent = workspace.Effects;
        local v243 = {
            Workspace = v242,
            Lighting = Lighting,
            MoonAnimatorEffects = u223:Add(vfxUtil.getMoonEffects())
        };
        vfxUtil.cutscene_lighting(u223, v243, doomMVP.Lighting);
        local v244 = u223:Construct(MoonPropertyAnimator);
        v244:LoadAndConvertSave(doomMVP.Moon, v243);
        v244:SetOriginalRoot(CFrame.new(0, 3, 0));
        v244:SetRoot(Root);
        v244:PlayAll();
        u223:Add(Util.Preload(doomMVP.ImpactFrames));
        vfxUtil.execute_compiled(doomMVP.Compiled, u223, v242, doomMVP, v237);
        u223:Add(task.delay(0.117, function() -- Line: 1537
            -- upvalues: u223 (copy), TekrinnDialogue (ref), u220 (copy)
            u223:Add(TekrinnDialogue.Speak(u220, {
                {
                    Text = "Hell answers to me.",
                    TypeSpeed = 0.02,
                    HigherUp = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3));
        end));
        u223:Add(task.delay(5.4, function() -- Line: 1551
            -- upvalues: u223 (copy), TekrinnDialogue (ref), u220 (copy)
            u223:Add(TekrinnDialogue.Speak(u220, {
                {
                    Text = "FOR I",
                    TypeSpeed = 0.02,
                    HigherUp = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3));
        end));
        u223:Add(task.delay(7.683, function() -- Line: 1565
            -- upvalues: u223 (copy), TekrinnDialogue (ref), u220 (copy)
            u223:Add(TekrinnDialogue.Speak(u220, {
                {
                    Text = "AM",
                    TypeSpeed = 0.02,
                    HigherUp = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
                }
            }, 3));
        end));
        u223:Add(task.delay(9.367, function() -- Line: 1579
            -- upvalues: u223 (copy), TekrinnDialogue (ref), u220 (copy)
            u223:Add(TekrinnDialogue.Speak(u220, {
                {
                    Text = "DOOM.",
                    TypeSpeed = 0.1,
                    HigherUp = true,
                    TextStrokeColor = Color3.fromRGB(40, 61, 40),
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 160, 90)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 3));
        end));
        soundUtil:play(doomMVP.soundmvp, "default");
    end
};