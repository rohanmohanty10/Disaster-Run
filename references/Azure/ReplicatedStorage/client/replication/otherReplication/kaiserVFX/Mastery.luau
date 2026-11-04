 

 

local CollectionService = game:GetService("CollectionService");
local ContentProvider = game:GetService("ContentProvider");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local replication = ReplicatedStorage.client.replication;
local TekrinnDialogue = require(replication.TekrinnDialogue);
local mainreplication = require(replication.mainreplication);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local BackgroundHighlight = require(replication.BackgroundHighlight);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local MoonCFrameTimeline = require(ReplicatedStorage.util.MoonCFrameTimeline);
require(ReplicatedStorage.allTypes.rig);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local TrajectoryPreview = require(ReplicatedStorage.util.TrajectoryPreview);
local trove = require(ReplicatedStorage.forum.trove);
local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local wiki = require(ReplicatedStorage.wiki);
require(ReplicatedStorage.util.KatUtil);
local Mastery = vfxUtil.getResources().kaiser.Mastery;
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local u2 = {};

local function stop_restriction_charge(p3) -- Line: 56
    -- upvalues: u2 (copy)
    local v4 = u2[p3];

    if v4 then
        u2[p3] = nil;
        v4();
    end;
end;

function v1.restriction_charge(u5) -- Line: 64
    -- upvalues: Mastery (copy), vfxUtil (copy), soundUtil (copy), trove (copy), mainreplication (copy), MoonCFrameTimeline (copy), u2 (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), MoonPropertyAnimator (copy)
    local Charge = Mastery.Restriction.Charge;
    local Root = vfxUtil.getRoot(u5);
    soundUtil:play(Charge.Sound, Root);
    local u6 = trove.new();
    u6:AttachToInstance(u5);
    local v7, v8 = vfxUtil.buildFromRig(u5, Charge.TuffCharacterRig2);
    u6:Add(v7);
    local task_delay = task.delay;
    local BulkEmittersLifetime = vfxUtil.getBulkEmittersLifetime(v8.Dash, v8.DevourRun);
    u6:Add(task_delay(math.max(BulkEmittersLifetime, 1.383), function() -- Line: 77
        -- upvalues: u6 (copy)
        u6:Destroy();
    end));
    mainreplication.eradicateVelocity(Root);

    if vfxUtil.isLocalPlayer(u5) then
        local u9 = u6:Construct(MoonCFrameTimeline, {
            Information = {
                FPS = 60
            },
            Origin = CFrame.new(
                -19.089,
                3,
                -1.44382284e-10,
                1,
                2.8465729e-7,
                -1.02691047e-7,
                2.8469259e-7,
                1,
                -1.3225331e-14,
                -1.02678314e-7,
                -1.67744186e-14,
                1
            ),
            Frames = {
                {
                    0,
                    CFrame.new(
                        -19.089,
                        3,
                        -1.44382284e-10,
                        1,
                        2.8465729e-7,
                        -1.02691047e-7,
                        2.8469259e-7,
                        1,
                        -1.3225331e-14,
                        -1.02678314e-7,
                        -1.67744186e-14,
                        1
                    ),
                    "Quad",
                    "Out"
                },
                {
                    83,
                    CFrame.new(
                        -19.08889,
                        3,
                        -85.720856,
                        1,
                        2.8465729e-7,
                        -1.02691047e-7,
                        2.8469259e-7,
                        1,
                        -1.3225331e-14,
                        -1.02678314e-7,
                        -1.67744186e-14,
                        1
                    ),
                    "Linear",
                    "Out"
                }
            }
        });
        u9:Cast(Root, Vector3.new(0, 0, 0.76666665));

        local function stop_dash() -- Line: 96
            -- upvalues: u2 (ref), u5 (copy), stop_dash (copy), u6 (copy), u9 (copy)
            if u2[u5] == stop_dash then
                u2[u5] = nil;
            end;

            u6:Remove(u9);
        end;

        u2[u5] = stop_dash;
        u6:Add(function() -- Line: 103
            -- upvalues: u2 (ref), u5 (copy), stop_dash (copy)
            if u2[u5] == stop_dash then
                u2[u5] = nil;
            end;
        end);
        u6:Add(u5:GetAttributeChangedSignal("RestrictionChargeStop"):Connect(function() -- Line: 109
            -- upvalues: u5 (copy), u2 (ref)
            local v10 = u5;
            local v11 = u2[v10];

            if v11 then
                u2[v10] = nil;
                v11();
            end;
        end));
        mainreplication.springcamerashake(40, 25);
        local u12 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        u12.Parent = Lighting;
        task.delay(2.1, function() -- Line: 117
            -- upvalues: u12 (copy)
            u12:Destroy();
        end);
        u12.TintColor = Color3.fromRGB(78, 131, 255);
        u12.Brightness = 0.4;
        u12.Contrast = 1;
        u12.Saturation = -0.4;
        TweenService:Create(u12, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(u12, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        mainreplication.fov(false, 90);
        mainreplication.fov(true, 70, 1.383, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local MoonEffects = vfxUtil.getMoonEffects();
        u6:Add(MoonEffects);
        local v13 = u6:Construct(MoonPropertyAnimator);
        v13:LoadAndConvertSave(Charge.Moon, {
            Highlight = v8.Highlight,
            Vignette = MoonEffects.Vignette
        });
        v13:PlayAll();
    end;

    shared.vfx.emit(v8.Dash);
    shared.vfx.emit(v8.DevourRun);
end;

function v1.restriction_weaves(p14) -- Line: 149
    -- upvalues: Mastery (copy), vfxUtil (copy), u2 (copy), soundUtil (copy), trove (copy), mainreplication (copy), MoonCFrameTimeline (copy), Lighting (copy), MoonPropertyAnimator (copy), BackgroundHighlight (copy)
    local Weaves = Mastery.Restriction.Weaves;
    local Root = vfxUtil.getRoot(p14);
    local v15 = u2[p14];

    if v15 then
        u2[p14] = nil;
        v15();
    end;

    soundUtil:play(Weaves.Sound, Root);
    local u16 = trove.new();
    u16:AttachToInstance(p14);
    local v17, u18 = vfxUtil.buildFromRig(p14, Weaves.TuffCharacterRig2);
    u16:Add(v17);
    local task_delay = task.delay;
    local v19 = 1.267 + vfxUtil.getBulkEmittersLifetime(table.unpack(u18:GetChildren()));
    u16:Add(task_delay(math.max(v19, 2.083), function() -- Line: 164
        -- upvalues: u16 (copy)
        u16:Destroy();
    end));
    u16:Add(task.delay(1.9, function() -- Line: 168
        -- upvalues: u18 (copy)
        for _, descendant in u18:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end));
    mainreplication.rockFlakes(Root, 1.9);
    mainreplication.destroyVelocity(Root);

    if vfxUtil.isLocalPlayer(p14) then
        u16:Construct(MoonCFrameTimeline, {
            Information = {
                FPS = 60
            },
            Origin = CFrame.new(
                -18.906935,
                2.861884,
                0.07331136,
                1,
                5.69349879e-7,
                -2.05369361e-7,
                5.69349879e-7,
                1,
                -5.92315029e-14,
                -2.05369361e-7,
                -5.92315029e-14,
                1
            ),
            Frames = {
                {
                    0,
                    CFrame.new(
                        -18.906935,
                        2.861884,
                        0.07331136,
                        1,
                        5.69349879e-7,
                        -2.05369361e-7,
                        5.69349879e-7,
                        1,
                        -5.92315029e-14,
                        -2.05369361e-7,
                        -5.92315029e-14,
                        1
                    ),
                    "Quad",
                    "Out"
                },
                {
                    25,
                    CFrame.new(
                        -35.3679,
                        2.861798,
                        -21.3761,
                        1,
                        5.69349879e-7,
                        -2.05369361e-7,
                        5.69349879e-7,
                        1,
                        -5.92315029e-14,
                        -2.05369361e-7,
                        -5.92315029e-14,
                        1
                    ),
                    "Quad",
                    "Out"
                },
                {
                    54,
                    CFrame.new(
                        -1.1575108,
                        2.8619492,
                        -45.301205,
                        1,
                        5.69349879e-7,
                        -2.05369361e-7,
                        5.69349879e-7,
                        1,
                        -5.92315029e-14,
                        -2.05369361e-7,
                        -5.92315029e-14,
                        1
                    ),
                    "Quad",
                    "Out"
                },
                {
                    73,
                    CFrame.new(
                        -18.907,
                        2.861862,
                        -61.131462,
                        1,
                        5.69349879e-7,
                        -2.05369361e-7,
                        -5.69349879e-7,
                        1,
                        -5.92315029e-14,
                        2.05369361e-7,
                        1.76158513e-13,
                        1
                    ),
                    "Quad",
                    "Out"
                },
                {
                    117,
                    CFrame.new(
                        -18.907,
                        2.861862,
                        -148.19745,
                        1,
                        5.69349879e-7,
                        -2.05369361e-7,
                        -5.69349879e-7,
                        1,
                        -5.92315029e-14,
                        2.05369361e-7,
                        1.76158513e-13,
                        1
                    ),
                    "Quad",
                    "Out"
                }
            }
        }):Cast(Root);
        mainreplication.fov(false, 85);
        mainreplication.fov(true, 70, 0.417, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        u16:Add(task.delay(0.433, function() -- Line: 197
            -- upvalues: mainreplication (ref)
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 0.484, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        end));
        u16:Add(task.delay(0.933, function() -- Line: 202
            -- upvalues: mainreplication (ref)
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 0.267, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end));
        u16:Add(task.delay(1.233, function() -- Line: 207
            -- upvalues: mainreplication (ref)
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 1.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end));
        local MoonEffects = vfxUtil.getMoonEffects();
        u16:Add(MoonEffects);
        local v20 = u16:Construct(Instance, "ColorCorrectionEffect");
        v20.Parent = Lighting;
        local v21 = u16:Construct(MoonPropertyAnimator);
        v21:LoadAndConvertSave(Weaves.Moon, {
            Highlight = u18.Highlight,
            Vignette = MoonEffects.Vignette,
            ColorCorrection = v20
        });
        v21:PlayAll();
    end;

    vfxUtil.execute_compiled(Weaves.Compiled, u16, u18);
    BackgroundHighlight({
        ImageTransparency = 0.7,
        Speed = 0.3,
        CFrames = true,
        Brightness = 1,
        countSpeed = 0.06085,
        Count = 20,
        Whitelist = { p14 },
        Color = Color3.fromRGB(232, 232, 232),
        Color2 = Color3.fromRGB(79, 126, 255)
    });
end;

function v1.kaiser_shot_flow(u22: any, p23: number, p24: any, p25: any, p26: any) -- Line: 244
    -- upvalues: Mastery (copy), vfxUtil (copy), mainreplication (copy), Lighting (copy), animationUtil (copy), LocalPlayer (copy), soundUtil (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy), UserInputService (copy), RunService (copy)
    local PeepholeFlow = Mastery.PeepholeFlow;
    local Root = vfxUtil.getRoot(u22);
    local u27 = vfxUtil.character_trove(u22);
    mainreplication.sceneEnabled(true);
    u22:SetAttribute("kaiser_shot_flow", true);
    local u28 = {};

    for _, v in { "Ambient", "Brightness", "ColorShift_Top", "ColorShift_Bottom", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "GlobalShadows", "OutdoorAmbient", "ShadowSoftness", "ExposureCompensation", "ClockTime", "GeographicLatitude", "FogColor", "FogEnd", "FogStart" } do
        u28[v] = Lighting[v];
    end;

    u27:Add(function() -- Line: 258
        -- upvalues: u22 (copy), mainreplication (ref)
        u22:SetAttribute("kaiser_shot_flow", nil);
        mainreplication.sceneEnabled(false);
    end);
    u27:Add(vfxUtil.buildFromRig(u22, PeepholeFlow.Kaiser), "Destroy");
    u27:Add(animationUtil:loadAnimation(p25, PeepholeFlow.Animations.Victim1), "Stop"):Play(0);
    u27:Add(animationUtil:loadAnimation(p26, PeepholeFlow.Animations.Victim2), "Stop"):Play(0);
    local v29, v30 = mainreplication.cutsceneCamRigWithLetterBox(Root, PeepholeFlow.Animations.Camera, PeepholeFlow.FOV, nil, "default", PeepholeFlow["CamRigWithLetterBox "]);
    u27:Add(v30);
    local MoonEffects = vfxUtil.getMoonEffects();
    u27:Add(MoonEffects);

    for _, child in PeepholeFlow.GUI:GetChildren() do
        u27:Clone(child).Parent = LocalPlayer.PlayerGui;
    end;

    local v31;

    if u22:GetAttribute("femlock") then
        v31 = Mastery.Parent.Femvoicelines.peephole;
    else
        v31 = PeepholeFlow.VA;
    end;

    soundUtil:play(v31, "default", {
        Character = u22
    });
    local v32 = u27:Clone(PeepholeFlow.VFX);
    v32:PivotTo(Root.CFrame);
    v32.Parent = workspace.Effects;
    local u33 = u27:Clone(PeepholeFlow.VictimStep);
    u33.Parent = p25["Right Leg"];
    local u34 = u27:Clone(PeepholeFlow.VictimStep);
    u34.Parent = p26["Right Leg"];
    u27:Add(task.delay(1.7, function() -- Line: 293
        -- upvalues: u33 (copy), u34 (copy)
        shared.vfx.emit(u33, u34);
    end));
    local v35 = {
        DomainNeon = v32.DomainNeon,
        ["Screen Cover"] = MoonEffects["Screen Cover"],
        Vignette = MoonEffects.Vignette,
        Lighting = Lighting,
        ["CamRigWithLetterBox "] = v29,
        TuffCharacterRig = u22
    };
    vfxUtil.contain_lighting(u27, v35, PeepholeFlow.Lighting);
    local v36 = u27:Construct(MoonPropertyAnimator);
    v36:LoadAndConvertSave(PeepholeFlow.Moon, v35);
    v36:SetOriginalRoot(CFrame.new(-19.089, 3, -0));
    v36:SetRoot(Root);
    v36:PlayAll();
    vfxUtil.execute_compiled(PeepholeFlow.Compiled, u27, u22, v29);
    u27:Add(task.delay(5.221, function() -- Line: 316
        -- upvalues: u27 (copy), TekrinnDialogue (ref), u22 (copy)
        u27:Add(TekrinnDialogue.Speak(u22, {
            {
                Text = "You\'re blind.",
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1))
            }
        }, 1.2));
    end));

    if vfxUtil.isLocalPlayer(u22) then
        shared.kaiser_shot_flow_aim = nil;
        u27:Add(task.delay(4, function() -- Line: 329
            -- upvalues: u27 (copy), PeepholeFlow (copy), soundUtil (ref), UserInputService (ref), RunService (ref)
            local u37 = u27:Extend();
            local u38 = u37:Clone(PeepholeFlow.Crosshair);
            soundUtil:play(PeepholeFlow.CrosshairSFX, "default");
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
            RaycastParams_new_ret.FilterDescendantsInstances = { workspace.map.barriar, workspace.map.map.sanam.main };

            local function update_aim() -- Line: 339
                -- upvalues: UserInputService (ref), RaycastParams_new_ret (copy), u38 (copy)
                local workspace_CurrentCamera = workspace.CurrentCamera;
                local MouseLocation = UserInputService:GetMouseLocation();
                local v39 = workspace_CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y);
                local v40 = workspace:Raycast(v39.Origin, v39.Direction * 800, RaycastParams_new_ret);
                u38.CFrame = CFrame.lookAt(v39.Origin + v39.Direction * 16, v39.Origin + v39.Direction * 17);
                local v41;

                if v40 then
                    v41 = v40.Position;
                else
                    v41 = v39.Origin + v39.Direction * 800;
                end;

                shared.kaiser_shot_flow_aim = v41;
            end;

            update_aim();
            u38.Parent = workspace.CurrentCamera;
            task.delay(0.1, shared.vfx.emit, u38);
            local u42 = u37:Connect(RunService.RenderStepped, update_aim);
            u27:Add(task.delay(2, function() -- Line: 355
                -- upvalues: u37 (copy), u42 (copy)
                u37:Remove(u42);
            end));
            u27:Add(task.delay(2.3333333333333335, function() -- Line: 359
                -- upvalues: u37 (copy)
                u37:Clean();
            end));
        end));
    end;

    u27:Add(function() -- Line: 366
        -- upvalues: u28 (copy), Lighting (ref)
        for i, v in u28 do
            pcall(function() -- Line: 368
                -- upvalues: Lighting (ref), i (copy), v (copy)
                Lighting[i] = v;
            end);
        end;
    end);
    u27:Add(task.delay(7.333333333333333, u27.Destroy, u27));
end;

local u43 = {};
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "kaiserotvideo";
ScreenGui.IgnoreGuiInset = true;
ScreenGui.ScreenInsets = Enum.ScreenInsets.None;
ScreenGui.DisplayOrder = 100;
ScreenGui.ResetOnSpawn = false;
ScreenGui.Enabled = false;
local VideoFrame = Instance.new("VideoFrame");
VideoFrame.Size = UDim2.fromScale(1, 1);
VideoFrame.BackgroundColor3 = Color3.new(0, 0, 0);
VideoFrame.BorderSizePixel = 0;
VideoFrame.Video = "rbxassetid://74048406387310";
VideoFrame.Volume = 2;
VideoFrame.Parent = ScreenGui;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
task.spawn(ContentProvider.PreloadAsync, ContentProvider, { VideoFrame });

local function play_ot_video(p44) -- Line: 401
    -- upvalues: trove (copy), SoundService (copy), RunService (copy), VideoFrame (copy), ScreenGui (copy), CollectionService (copy)
    local u45 = trove.new();
    local u46 = nil;

    for _, child in SoundService:GetChildren() do
        if child.Name == "UltimateTheme" then
            u46 = child;
        end;
    end;

    if u46 then
        local Volume = u46.Volume;
        u46.Volume = 0;
        u45:Add(function() -- Line: 413
            -- upvalues: u46 (ref), Volume (copy)
            u46.Volume = Volume;
        end);
        u45:Connect(RunService.Heartbeat, function() -- Line: 416
            -- upvalues: VideoFrame (ref), u46 (ref), Volume (copy)
            local math_clamp_ret = math.clamp(1 - (VideoFrame.TimeLength - VideoFrame.TimePosition) / 0.15, 0, 1);
            u46.Volume = Volume * math_clamp_ret * math_clamp_ret;
        end);
    end;

    VideoFrame.TimePosition = 0;
    ScreenGui.Enabled = true;
    VideoFrame:Play();
    u45:Add(function() -- Line: 426
        -- upvalues: VideoFrame (ref), ScreenGui (ref)
        VideoFrame:Pause();
        ScreenGui.Enabled = false;
    end);
    u45:Connect(VideoFrame.Ended, function() -- Line: 430
        -- upvalues: u45 (copy)
        u45:Destroy();
    end);

    if p44 then
        u45:Connect(p44.Changed, function(p47) -- Line: 434
            -- upvalues: u45 (copy)
            if p47 then
                u45:Destroy();
            end;
        end);
    end;

    u45:Connect(CollectionService:GetInstanceAddedSignal("DialogueUI"), function(p48) -- Line: 440
        -- upvalues: ScreenGui (ref)
        p48.DisplayOrder = ScreenGui.DisplayOrder + 1;
    end);

    return u45;
end;

function v1.kaiser_ot_video(p49) -- Line: 447
    -- upvalues: u43 (copy)
    u43[p49] = true;
end;

function v1.i_cant_sleep(u50: any, u51: number, p52: any) -- Line: 451
    -- upvalues: Mastery (copy), vfxUtil (copy), u43 (copy), mainreplication (copy), trove (copy), soundUtil (copy), Util (copy), play_ot_video (copy), Players (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local Overtime = Mastery.Overtime;
    local Root = vfxUtil.getRoot(u50);
    local u53 = false;
    local v54 = u43[u50];
    u43[u50] = nil;
    mainreplication.sceneEnabled(true);
    local u55 = trove.new();
    u55:AttachToInstance(u50);
    u55:Add(function() -- Line: 464
        -- upvalues: u53 (ref), mainreplication (ref)
        u53 = true;
        mainreplication.sceneEnabled(false);
    end);
    u55:Add(task.delay(u51, function() -- Line: 468
        -- upvalues: u55 (copy)
        u55:Destroy();
    end));
    task.delay(9.15, function() -- Line: 471
        -- upvalues: u53 (ref), mainreplication (ref), u51 (copy)
        if not u53 then
            mainreplication.newblackscene(0.667, 1, u51 - 9.15);
        end;
    end);
    local Attribute = u50:GetAttribute("femlock");
    local v56;

    if v54 then
        v56 = nil;
    else
        local v57;

        if Attribute then
            v57 = Mastery.Parent.Femvoicelines.otflow;
        else
            v57 = Overtime.VA;
        end;

        v56 = soundUtil:play(v57, "default", {
            Character = u50
        });
    end;

    Util.flowCancel(u55, p52, v54 and {} or { soundUtil:play(Overtime.SFX, "default"), v56 });

    if v54 then
        play_ot_video(p52);
    end;

    local v58 = u55:Clone(Overtime.VFX);
    v58:PivotTo(Root.CFrame);
    v58.Parent = workspace.Effects;
    local v59, v60 = vfxUtil.buildFromRig(u50, Overtime.TuffCharacterRig);
    u55:Add(v59);
    local u61 = u55:Add(vfxUtil.newRig(Root));
    task.spawn(function() -- Line: 494
        -- upvalues: u50 (copy), u55 (copy), Players (ref), u61 (copy)
        local v62 = u50:FindFirstChildWhichIsA("Humanoid");
        u55:Add(task.delay(5.067, function() -- Line: 496
            -- upvalues: Players (ref), u50 (ref), u61 (ref)
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(u50);

            if PlayerFromCharacter and PlayerFromCharacter:FindFirstChild("setting") then
                u61.Humanoid:ApplyDescriptionAsync(Players:GetHumanoidDescriptionFromOutfitIdAsync(PlayerFromCharacter.setting.awakeningOutfitId.Value));
            end;
        end));
        u61.Humanoid:ApplyDescriptionAsync(v62.HumanoidDescription);
        u61.Shirt.ShirtTemplate = "rbxassetid://120647655731491";
        u61.Pants.PantsTemplate = "rbxassetid://132889684817055";
    end);
    task.spawn(function() -- Line: 506
        -- upvalues: u55 (copy), animationUtil (ref), u61 (copy), Overtime (copy)
        u55:Add(animationUtil:loadAnimation(u61, Overtime.HomelessAnimation), "Stop"):Play(0);
    end);
    local v63, _ = vfxUtil.buildFromRig(u61, Overtime.TuffCharacterRig2);
    u55:Add(v63);
    local v64, v65 = mainreplication.cutsceneCamRigWithLetterBox(Root, Overtime.CamAnimation, Overtime.FOV, nil, "default", Overtime["CamRigWithLetterBox "]);
    u55:Add(v65);
    local MoonEffects = vfxUtil.getMoonEffects();
    u55:Add(MoonEffects);
    local v66 = {
        Highlight = v60.Highlight,
        ["Screen Cover"] = MoonEffects["Screen Cover"],
        Vignette = MoonEffects.Vignette,
        Lighting = Lighting,
        ["CamRigWithLetterBox "] = v64,
        TuffCharacterRig = u50,
        TuffCharacterRig2 = u61,
        Workspace = v58
    };
    vfxUtil.cutscene_lighting(u55, v66, Overtime.Lighting, {
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
    local v67 = u55:Construct(MoonPropertyAnimator);
    v67:LoadAndConvertSave(Overtime.Moon, v66);
    v67:SetOriginalRoot(Overtime.VFX.Core.CFrame);
    v67:SetRoot(Root);
    v67:PlayAll();
    vfxUtil.execute_compiled(Overtime.Compiled, u55, v58, u50, v64, u61);

    if v56 and (Attribute or v56.Name == "Dub") then
        u55:Add(task.delay(0.253, function() -- Line: 551
            -- upvalues: u55 (copy), TekrinnDialogue (ref), u50 (copy)
            u55:Add(TekrinnDialogue.Speak(u50, {
                {
                    Text = "I\'ll throw it all away...",
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 3.832
                    }
                }
            }));
        end));
        u55:Add(task.delay(1.994, function() -- Line: 564
            -- upvalues: u55 (copy), TekrinnDialogue (ref), u50 (copy)
            u55:Add(TekrinnDialogue.Speak(u50, {
                {
                    Text = "And go back to ",
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 3.814
                    }
                },
                {
                    Text = "\"ZERO\"",
                    Bold = true,
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.fromRGB(0, 76, 255)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3.814
                    }
                }
            }));
        end));
        u55:Add(task.delay(4.892, function() -- Line: 587
            -- upvalues: u55 (copy), TekrinnDialogue (ref), u50 (copy)
            u55:Add(TekrinnDialogue.Speak(u50, {
                {
                    Text = "My ego...",
                    Italic = true,
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 2
                    }
                }
            }, 2.627));
        end));
        u55:Add(task.delay(6.392, function() -- Line: 601
            -- upvalues: u55 (copy), TekrinnDialogue (ref), u50 (copy)
            u55:Add(TekrinnDialogue.Speak(u50, {
                {
                    Text = "IT\'S YOU.",
                    Bold = true,
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 2
                    }
                }
            }, 3.223));
        end));
        u55:Add(task.delay(7.681, function() -- Line: 615
            -- upvalues: u55 (copy), TekrinnDialogue (ref), u50 (copy)
            u55:Add(TekrinnDialogue.Speak(u50, {
                {
                    Text = "I\'m coming for you, trash!",
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.934
                    }
                }
            }));
        end));
    else
        u55:Add(task.delay(0.193, function() -- Line: 629
            -- upvalues: u55 (copy), TekrinnDialogue (ref), u50 (copy)
            u55:Add(TekrinnDialogue.Speak(u50, {
                {
                    Text = "Peel it away...",
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 2
                    }
                }
            }, 3.834));
        end));
        u55:Add(task.delay(1.608, function() -- Line: 642
            -- upvalues: u50 (copy), Players (ref), u55 (copy), TekrinnDialogue (ref)
            local Name = u50.Name;
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(u50);

            if PlayerFromCharacter then
                Name = PlayerFromCharacter.DisplayName;
            end;

            u55:Add(TekrinnDialogue.Speak(u50, {
                {
                    Text = "Become ",
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 2
                    }
                },
                {
                    Text = "\"Zero\"",
                    Bold = true,
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.fromRGB(0, 76, 255)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                },
                {
                    Text = `, {Name}!`,
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 2
                    }
                }
            }, 4.16));
        end));
        u55:Add(task.delay(4.499, function() -- Line: 679
            -- upvalues: u55 (copy), TekrinnDialogue (ref), u50 (copy)
            u55:Add(TekrinnDialogue.Speak(u50, {
                {
                    Text = "Ah..",
                    Italic = true,
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1))
                }
            }, 3.09));
        end));
        u55:Add(task.delay(6.24, function() -- Line: 688
            -- upvalues: u55 (copy), TekrinnDialogue (ref), u50 (copy)
            u55:Add(TekrinnDialogue.Speak(u50, {
                {
                    Text = "\"Zero\"",
                    Italic = true,
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.fromRGB(0, 76, 255))
                },
                {
                    Text = " is..",
                    Italic = true,
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1))
                }
            }, 2.393));
        end));
        u55:Add(task.delay(7.808, function() -- Line: 702
            -- upvalues: u55 (copy), TekrinnDialogue (ref), u50 (copy)
            u55:Add(TekrinnDialogue.Speak(u50, {
                {
                    Text = "You!",
                    Bold = true,
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2.273
                    }
                }
            }));
        end));
        u55:Add(task.delay(8.958, function() -- Line: 716
            -- upvalues: u55 (copy), TekrinnDialogue (ref), u50 (copy)
            u55:Add(TekrinnDialogue.Speak(u50, {
                {
                    Text = "Piece of trash!",
                    Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2.5,
                        Lifetime = 1.123
                    }
                }
            }));
        end));
    end;
end;

local function previewer(u68, p69) -- Line: 732
    -- upvalues: TrajectoryPreview (copy), LocalPlayer (copy)
    TrajectoryPreview.Preview(u68, {
        {
            nil,
            145,
            "left",

            function(p70: vector) -- Line: 734
                -- upvalues: u68 (copy), LocalPlayer (ref)
                local HumanoidRootPart = u68:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart then
                    local v71 = LocalPlayer and (LocalPlayer:FindFirstChild("setting") and LocalPlayer.setting:FindFirstChild("camAim")) and LocalPlayer.setting.camAim.Value;
                    local Y = p70.Y;

                    if not v71 then
                        Y = math.clamp(Y, 0.3, 1);
                    end;

                    local LookVector = HumanoidRootPart.CFrame.LookVector;

                    return Vector3.new(LookVector.X, Y, LookVector.Z).Unit;
                end;
            end,

            "magnus"
        },
        true,
        true
    }, p69, {
        lifetime = 15,
        lineColor = Color3.fromRGB(0, 0, 127)
    });
end;

function v1.emperor_eye(u72: any, p73: userdata) -- Line: 751
    -- upvalues: vfxUtil (copy), wiki (copy), soundUtil (copy), trove (copy), mainreplication (copy), actionUtil (copy), previewer (copy)
    local Emperor = vfxUtil.getResources().kaiser.Mastery.Emperor;
    local Head = u72:FindFirstChild("Head");
    local color = wiki.styles.masterykaiser.color;
    local u74 = vfxUtil.isLocalPlayer(u72);
    soundUtil:play(Emperor.Sound, u74 and "default" or Head);
    local v75 = trove.new();
    v75:AttachToInstance(u72);
    v75:AttachToInstance(p73);
    v75:Add(function() -- Line: 764
        -- upvalues: u74 (copy), mainreplication (ref)
        if u74 then
            mainreplication.ultFlash(0.5);
        end;
    end);

    if u74 then
        vfxUtil.flash(color, 0.5);
        local ballHolder = actionUtil.getworkspace().ballHolder;
        local u76 = v75:Extend();

        local function refresh_previewer() -- Line: 776
            -- upvalues: u76 (copy), ballHolder (copy), u72 (copy), previewer (ref)
            u76:Clean();

            if ballHolder.Value ~= u72 or u72:GetAttribute("kaiser_shot_flow") then
                return;
            end;

            previewer(u72, u76);
        end;

        v75:Connect(ballHolder.Changed, refresh_previewer);
        v75:Connect(u72:GetAttributeChangedSignal("kaiser_shot_flow"), refresh_previewer);
        u76:Clean();

        if ballHolder.Value == u72 and not u72:GetAttribute("kaiser_shot_flow") then
            previewer(u72, u76);
        end;
    end;

    local u77 = v75:Clone(Emperor.Eye);
    u77.Weld.Part0 = Head;
    u77.Parent = workspace.Effects;
    v75:Connect(actionUtil.getworkspace().disabled, function(p78) -- Line: 795
        -- upvalues: u77 (copy)
        for _, v in u77:QueryDescendants("ParticleEmitter,Beam") do
            v.Enabled = not p78;

            if p78 and v:IsA("ParticleEmitter") then
                v:Clear();
            end;
        end;
    end);
end;

function v1.kaiserImpactKick(p79) -- Line: 805
    -- upvalues: vfxUtil (copy), mainreplication (copy), ReplicatedStorage (copy), TweenService (copy)
    local Root = vfxUtil.getRoot(p79);
    mainreplication.fov(false, 120);
    mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    mainreplication.cameraShake(15, 1.35, 8);
    local v80 = ReplicatedStorage.Resources.kaiser.kieff:Clone();
    v80:PivotTo(Root.CFrame);

    for _, child in v80:GetChildren() do
        if not table.find({ "Impact", "BRO" }, child.Name) then
            child:Destroy();
        end;
    end;

    for _, descendant in ipairs(v80:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.Transparency = 1;
        elseif descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    v80.Parent = workspace.Effects;

    for _, descendant in ipairs(v80.Impact:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    local v81 = v80.BRO:Clone();
    v81.Size = Vector3.new(24.622, 10.168, 10.474);
    v81.Mesh.Scale = Vector3.new(1.077, 0.338, 0.336);

    for _, descendant in ipairs(v81:GetDescendants()) do
        if descendant:IsA("Decal") then
            descendant.Transparency = 0;
        end;
    end;

    v81.Parent = workspace.Effects;
    TweenService:Create(v81, TweenInfo.new(0.0333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(52.739, 0.001, 0.001),
        CFrame = v81.CFrame * CFrame.new(-8, 0, 0)
    }):Play();
    TweenService:Create(v81.Mesh, TweenInfo.new(0.0333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Scale = Vector3.new(2.307, 0, 0)
    }):Play();
    task.delay(0.0333333333333333, v81.Destroy, v81);
    task.delay(1.983333333333333, v80.Destroy, v80);
end;

function v1.path_offball_first(u82) -- Line: 868
    -- upvalues: mainreplication (copy), trove (copy), BackgroundHighlight (copy), ReplicatedStorage (copy), Players (copy), RunService (copy)
    local u83 = u82.HumanoidRootPart or u82.PrimaryPart;
    mainreplication.highlight(u82, Color3.fromRGB(79, 102, 255), 0.2666666666666667);
    local u84 = trove.new();
    u84:AttachToInstance(u82);
    u84:Add(task.delay(0.3, function() -- Line: 879
        -- upvalues: BackgroundHighlight (ref), u82 (copy), mainreplication (ref), u83 (copy), u84 (copy), ReplicatedStorage (ref), Players (ref), RunService (ref)
        BackgroundHighlight({
            ImageTransparency = 0.7,
            Speed = 0.3,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            Count = 8,
            Whitelist = { u82 },
            Color = Color3.fromRGB(1000, 1000, 1000),
            Color2 = Color3.fromRGB(79, 126, 255)
        });
        mainreplication.rockFlakes(u83, 0.6);
        local u85 = u84:Clone(ReplicatedStorage.Resources.kaiser.A);
        u85.Weld.Part0 = u83;
        u85.Parent = u82;
        local u86 = u84:Clone(ReplicatedStorage.Resources.kaiser.roott);
        u86.Weld.Part0 = u82["Right Arm"];
        u86.Parent = u82;
        local u87 = u84:Clone(ReplicatedStorage.Resources.kaiser.roott);
        u87.Weld.Part0 = u82["Left Arm"];
        u87.Parent = u82;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u82) then
            mainreplication.bright(0.15, 1.5, Color3.fromRGB(111, 106, 255));
            mainreplication.fov(false, 55);
            mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end;

        mainreplication.cameraShake(15, 1.3, 3);
        mainreplication.Emit(u83, ReplicatedStorage.Resources.kaiser.Jump, 3, CFrame.new(0, -3, 0));
        local u88, u89 = mainreplication.bodyVelocity(u83, 110, 0.6, nil, nil, true);
        local Attribute = u82:GetAttribute("what");
        local u90 = nil;
        u90 = u84:Connect(RunService.RenderStepped, function(p91) -- Line: 920
            -- upvalues: u88 (copy), u84 (ref), u90 (ref), u83 (ref), u89 (copy), Attribute (copy)
            if not (u88 and u88:IsDescendantOf(game)) then
                u84:Remove(u90);

                return;
            end;

            local v92 = -u83.CFrame.RightVector * u89.Value / 2;

            if Attribute then
                v92 = -v92;
            end;

            u88.Velocity = u83.CFrame.LookVector * u89.Value + v92;
        end);
        u84:Add(task.delay(0.3, function() -- Line: 936
            -- upvalues: u85 (copy), u86 (copy), u87 (copy)
            for _, descendant in ipairs(u85:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in ipairs(u86:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in ipairs(u87:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end));
    end));
    u84:Add(task.delay(3.867, function() -- Line: 954
        -- upvalues: u84 (copy)
        u84:Destroy();
    end));
end;

function v1.path_offball_second(u93) -- Line: 959
    -- upvalues: mainreplication (copy), Players (copy), ReplicatedStorage (copy), BackgroundHighlight (copy), trove (copy), RunService (copy)
    local u94 = u93.HumanoidRootPart or u93.PrimaryPart;
    local Attribute = u93:GetAttribute("what");
    mainreplication.rockFlakes(u94, 0.4);
    mainreplication.highlight(u93, Color3.fromRGB(79, 102, 255), 0.2666666666666667);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u93) then
        mainreplication.fov(false, 85);
        mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    mainreplication.Emit(u94, ReplicatedStorage.Resources.kaiser.Jump, 3, CFrame.new(0, -3, 0));
    mainreplication.cameraShake(15, 0.55, 6);
    BackgroundHighlight({
        ImageTransparency = 0.7,
        Speed = 0.3,
        CFrames = true,
        Brightness = 1,
        countSpeed = 0.13333333333333333,
        Count = 3,
        Whitelist = { u93 },
        Color = Color3.fromRGB(1000, 1000, 1000),
        Color2 = Color3.fromRGB(79, 126, 255)
    });
    local u95 = trove.new();
    u95:AttachToInstance(u93);
    local u96 = u95:Clone(ReplicatedStorage.Resources.kaiser.A);
    u96.Weld.Part0 = u94;
    u96.Parent = u93;
    local u97 = u95:Clone(ReplicatedStorage.Resources.kaiser.roott);
    u97.Weld.Part0 = u93["Right Arm"];
    u97.Parent = u93;
    local u98 = u95:Clone(ReplicatedStorage.Resources.kaiser.roott);
    u98.Weld.Part0 = u93["Left Arm"];
    u98.Parent = u93;
    local u99, u100 = mainreplication.bodyVelocity(u94, 110, 0.4, nil, nil, true);
    local u101 = nil;
    u101 = u95:Connect(RunService.RenderStepped, function(p102) -- Line: 1006
        -- upvalues: u99 (copy), u95 (copy), u101 (ref), u94 (copy), u100 (copy), Attribute (copy)
        if not (u99 and u99:IsDescendantOf(game)) then
            u95:Remove(u101);

            return;
        end;

        local v103 = u94.CFrame.RightVector * u100.Value / 2;

        if Attribute then
            v103 = -v103;
        end;

        u99.Velocity = u94.CFrame.LookVector * u100.Value + v103;
    end);
    u95:Add(task.delay(0.4, function() -- Line: 1022
        -- upvalues: mainreplication (ref), u94 (copy), BackgroundHighlight (ref), u93 (copy)
        mainreplication.bodyVelocity(u94, 165, 0.6, false, nil, false, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In));
        BackgroundHighlight({
            ImageTransparency = 0.7,
            Speed = 0.3,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.12,
            Count = 8,
            Whitelist = { u93 },
            Color = Color3.fromRGB(1000, 1000, 1000),
            Color2 = Color3.fromRGB(79, 126, 255)
        });
        mainreplication.fov(false, 120);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    end));
    u95:Add(task.delay(3.867, function() -- Line: 1039
        -- upvalues: u95 (copy)
        u95:Destroy();
    end));
    u95:Add(task.delay(0.8, function() -- Line: 1043
        -- upvalues: u96 (copy), u97 (copy), u98 (copy)
        for _, descendant in ipairs(u96:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u97:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u98:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end));
end;

function v1.impact_stack_visualizer(p104: any, p105: number) -- Line: 1063
    -- upvalues: actionUtil (copy), LocalPlayer (copy)
    if actionUtil.getRole(LocalPlayer.Character) == "GK" then
        local impact_stacks = p104:FindFirstChild("impact_stacks");

        if p105 <= 0 then
            if impact_stacks then
                impact_stacks:Destroy();
            end;

            return;
        end;

        if not impact_stacks then
            impact_stacks = Instance.new("Highlight");
            impact_stacks.FillTransparency = 1;
            impact_stacks.OutlineColor = Color3.fromRGB(0, 170, 255);
            impact_stacks.Name = "impact_stacks";
            impact_stacks.Parent = p104;
        end;

        impact_stacks.OutlineTransparency = 1 - math.clamp(p105, 0, 1);
    end;
end;

return v1;