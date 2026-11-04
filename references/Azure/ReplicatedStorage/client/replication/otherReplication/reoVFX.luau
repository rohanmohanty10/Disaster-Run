 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.util.UwUEffects);
local trove = require(ReplicatedStorage.forum.trove);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local BezierCurve = require(ReplicatedStorage.client.replication.BezierCurve);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local Util = require(ReplicatedStorage.util.Util);
local VfxHandler = require(ReplicatedStorage.VfxHandler);
local styles = require(ReplicatedStorage.wiki.styles);
local CancelHelper = require(ReplicatedStorage.util.CancelHelper);
require(ReplicatedStorage.util.KatUtil);
local LocalPlayer = Players.LocalPlayer;
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);

function mainreplication.characterImage(p1) -- Line: 35
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p1);
end;

local ClockTime = Lighting.ClockTime;
local u2 = {};
local u3 = {
    chigiriPanther = "rbxassetid://139980526798289",
    nagiJumpingTurn = "rbxassetid://97449173564383",
    bachiraCA1 = "rbxassetid://110232981475599",
    bachiraFull = "rbxassetid://98580707144938",
    bachiraCA2 = "rbxassetid://72692813427883",
    flowIcon = "rbxassetid://137400361433441",
    chameleonVolley = "rbxassetid://139517037021307"
};

for _, child in script.compiled:GetChildren() do
    u2[child.Name] = require(child);
end;

local u4 = {};

local function getcurrentIcon(p5, p6) -- Line: 57
    -- upvalues: Players (copy), actionUtil (copy), u3 (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p5);

    if actionUtil.checkStyle(PlayerFromCharacter) == "reo" and (p6 or actionUtil.checkflow(p5)) then
        return not p6 and "rbxassetid://137400361433441" or u3[p6];
    end;

    local l_print = print;
    local v7 = actionUtil.checkflow(p5);
    local v8 = actionUtil.checkStyle(PlayerFromCharacter);
    local v9 = not p6 and not actionUtil.checkflow(p5);
    l_print(p6, v7, v8, v9);
end;

local function reoFlash(p10: number, p11: number?) -- Line: 72
    -- upvalues: vfxUtil (copy)
    vfxUtil.flash(Color3.new(0.667, 0, 1), p10, p11);
end;

function u4.switchStance(p12: any, p13: boolean) -- Line: 76
    -- upvalues: vfxUtil (copy), soundUtil (copy), SoundService (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local Root = vfxUtil.getRoot(p12);
    local StanceShift = reo.StanceShift;
    vfxUtil.quickVFX(StanceShift.RootVFX, p12, Root);
    soundUtil:play(StanceShift[`SFX{p13 and 1 or 2}`], SoundService);
end;

function u4.offensiveReoFlow(u14) -- Line: 84
    -- upvalues: vfxUtil (copy), Players (copy), trove (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), animationUtil (copy), Lighting (copy), TekrinnDialogue (copy), getcurrentIcon (copy), MoonPropertyAnimator (copy), u2 (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u14);
    local Root = vfxUtil.getRoot(u14);
    local Head = u14:FindFirstChild("Head");
    local Attribute = u14:GetAttribute("RinNoPlay");
    local OffensiveFlow = reo.OffensiveFlow;
    local VFX = OffensiveFlow.VFX;
    local main = workspace.map.map.sanam.main;
    local u15 = trove.new();
    u15:Add(vfxUtil.getScreenDimmer());
    local u16 = u15:Construct(VFX);
    local Friend = u16.Friend;
    local RootVFX = u16.RootVFX;
    local OffensiveFlow2 = RootVFX.OffensiveFlow;
    local v17 = u15:Construct(vfxUtil.newRigForFriend, Root, PlayerFromCharacter);
    local v18 = u15:Construct(vfxUtil.getMoonEffects);
    local UPAIN = u16:FindFirstChild("UPAIN", true);
    local v19 = UPAIN and Attribute and UPAIN:FindFirstChildWhichIsA("ParticleEmitter");

    if v19 then
        v19.Texture = "rbxassetid://140004333318904";
    end;

    u16.Parent = workspace.Effects;
    u16:PivotTo(u14:GetPivot());
    soundUtil:play(Attribute and OffensiveFlow["SFX-rnp"] or OffensiveFlow.SFX, SoundService);
    vfxUtil.setupAura(u14, u16.User);
    vfxUtil.setupAura(v17, Friend);
    local v20 = u15:Construct(mainreplication.kuronaCam, Root, OffensiveFlow.Cam, OffensiveFlow.FOV, function() -- Line: 124
        -- upvalues: u16 (copy), u14 (copy)
        u16:PivotTo(u14:GetPivot());
    end);
    local v21 = animationUtil:loadAnimation(v17, OffensiveFlow.FriendAnimation);
    local v22 = animationUtil:loadAnimation(u16.CHAMELEON, OffensiveFlow.ChameleonAnimation);
    v21:Play(0);
    v22:Play(0);
    local v23 = {};

    for _, child in ipairs(OffensiveFlow.Lighting:GetChildren()) do
        local v24 = u15:Construct(child);
        v24.Parent = Lighting;
        v23[child.Name] = v24;
    end;

    mainreplication.sceneEnabled(true);
    u15:Add(function() -- Line: 144
        -- upvalues: mainreplication (ref), main (copy), Head (copy), u14 (copy)
        mainreplication.sceneEnabled(false);
        main.Transparency = 0;
        mainreplication.ultFlash(1);

        if Head then
            Head.Transparency = 0;
        end;

        for _, child in u14:GetChildren() do
            if child:IsA("Accessory") then
                local v25 = child:FindFirstChild("Handle") or child:FindFirstChild("handle");

                if v25 then
                    v25.Transparency = 0;
                end;
            end;
        end;
    end);
    u15:Add(task.delay(9.417, function() -- Line: 160
        -- upvalues: Head (copy), u14 (copy)
        if Head then
            Head.Transparency = 1;
        end;

        for _, child in u14:GetChildren() do
            if child:IsA("Accessory") then
                local v26 = child:FindFirstChild("Handle") or child:FindFirstChild("handle");

                if v26 then
                    v26.Transparency = 1;
                end;
            end;
        end;
    end));
    u15:Add(task.delay(12.9, function() -- Line: 173
        -- upvalues: Head (copy), u14 (copy)
        if Head then
            Head.Transparency = 0;
        end;

        for _, child in u14:GetChildren() do
            if child:IsA("Accessory") then
                local v27 = child:FindFirstChild("Handle") or child:FindFirstChild("handle");

                if v27 then
                    v27.Transparency = 0;
                end;
            end;
        end;
    end));

    if Attribute then
        u15:Add(task.delay(11.858, function() -- Line: 187
            -- upvalues: TekrinnDialogue (ref), u14 (copy), getcurrentIcon (ref)
            TekrinnDialogue.Speak(u14, {
                {
                    Text = "But you never had to ",
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(170, 0, 255)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                },
                {
                    Text = "save me!",
                    TypeSpeed = 0.05,
                    Bold = true,
                    Color = ColorSequence.new(Color3.fromRGB(170, 0, 255), Color3.fromRGB(255, 255, 255)),
                    Shake = {
                        Enabled = true,
                        Intensity = 3.5,
                        Lifetime = 3
                    }
                }
            }, 3.3, getcurrentIcon(u14));
        end));
        u15:Add(task.delay(14.1, function() -- Line: 214
            -- upvalues: TekrinnDialogue (ref), u14 (copy), getcurrentIcon (ref)
            TekrinnDialogue.Speak(u14, {
                {
                    Text = "All I ever wanted was for you to ",
                    TypeSpeed = 0.07,
                    Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(170, 0, 255)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2.5,
                        Lifetime = 4
                    }
                },
                {
                    Text = "live!",
                    TypeSpeed = 0.07,
                    Bold = true,
                    Color = ColorSequence.new(Color3.fromRGB(170, 0, 255), Color3.fromRGB(255, 255, 255)),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 4
                    }
                }
            }, 4.5, getcurrentIcon(u14));
        end));
    else
        u15:Add(task.delay(11.858, function() -- Line: 242
            -- upvalues: TekrinnDialogue (ref), u14 (copy), getcurrentIcon (ref)
            TekrinnDialogue.Speak(u14, {
                {
                    Text = "If my dream\'s going to ",
                    Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    }
                },
                {
                    Text = "shatter miserably",
                    Bold = true,
                    Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.667, 0, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                },
                {
                    Text = " and ",
                    Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    }
                },
                {
                    Text = "fade away",
                    Bold = true,
                    Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2.5,
                        Lifetime = 4
                    }
                },
                {
                    Text = ",",
                    Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    }
                }
            }, 4, getcurrentIcon(u14));
        end));
        u15:Add(task.delay(14.968, function() -- Line: 294
            -- upvalues: TekrinnDialogue (ref), u14 (copy), getcurrentIcon (ref)
            TekrinnDialogue.Speak(u14, {
                {
                    Text = "I\'ll throw it away..",
                    Bold = true,
                    Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 3.5,
                        Lifetime = 3
                    }
                }
            }, 2.032, getcurrentIcon(u14));
        end));
    end;

    u15:Add(task.delay(16.083, function() -- Line: 311
        -- upvalues: u16 (copy)
        u16.CHAMELEON:Destroy();
    end));
    u15:Add(task.delay(17.933, function() -- Line: 315
        -- upvalues: u15 (copy)
        u15:Destroy();
    end));
    local v28 = MoonPropertyAnimator.new();
    v28:LoadSave(OffensiveFlow.MVP, MoonPropertyAnimator.ConvertSave(OffensiveFlow.MVP, {
        ColorCorrection = v23.ColorCorrection,
        BlackBG = OffensiveFlow2.BlackBG,
        FlashbackBG = OffensiveFlow2.FlashbackBG,
        Vignette = v18.Vignette,
        main = main
    }));
    v28:SetOriginalRoot(OffensiveFlow.AnimRoot.Value);
    v28:SetRoot(Root);
    v28:PlayAll();

    for _, v in ipairs(u2.OffensiveFlow) do
        u15:Add(task.delay(v[1] / 60, v[2], RootVFX, v20));
    end;
end;

function u4.defensiveReoFlow(u29) -- Line: 336
    -- upvalues: vfxUtil (copy), soundUtil (copy), SoundService (copy), animationUtil (copy), Lighting (copy), mainreplication (copy), u2 (copy), MoonPropertyAnimator (copy), Util (copy), TekrinnDialogue (copy), getcurrentIcon (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local Root = vfxUtil.getRoot(u29);
    local Ball = u29:WaitForChild("Ball");
    local DefensiveFlow = reo.DefensiveFlow;
    local u30 = DefensiveFlow.VFX:Clone();
    local BallVFX = u30.BallVFX;
    local HeadVFX = u30.HeadVFX;
    u30.Parent = workspace.Effects;
    u30:PivotTo(u29:GetPivot());
    BallVFX.Weld.Part0 = Ball;
    HeadVFX.Weld.Part0 = u29:FindFirstChild("Head");
    soundUtil:play(DefensiveFlow.SFX, SoundService);
    animationUtil:loadAnimation(u30.CHAMELEON, DefensiveFlow.ChameleonAnimation):Play(0);
    local u31 = {};

    for _, child in ipairs(DefensiveFlow.Lighting:GetChildren()) do
        local v32 = child:Clone();
        v32.Parent = Lighting;
        u31[child.Name] = v32;
    end;

    local MoonEffects = vfxUtil.getMoonEffects();
    local u33 = mainreplication.cutsceneCamRigWithLetterBox(Root, DefensiveFlow.CamAnimation, DefensiveFlow.FOV, nil, CFrame.new(0, -3, 0), DefensiveFlow.ReoCam, "CamPart");
    local v34;

    if u33 and u33:FindFirstChild("VFXpart") then
        v34 = u33.VFXpart;
    else
        v34 = nil;
    end;

    for _, v in ipairs(u2.DefensiveFlow) do
        task.delay(v[1] / 60, v[2], v34, BallVFX, HeadVFX, u30);
    end;

    local v35 = MoonPropertyAnimator.ConvertSave(DefensiveFlow.MoonVFX, {
        Ball = BallVFX,
        ColorCorrection = u31.ColorCorrection,
        Atmosphere = u31.Atmosphere,
        DepthOfField = u31.DepthOfField,
        BG = u30.BG,
        Vignette = MoonEffects.Vignette
    });
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local v36 = MoonPropertyAnimator.new();
    v36:LoadSave(DefensiveFlow.MoonVFX, v35);
    v36:SetOriginalRoot(DefensiveFlow.AnimRoot.Value);
    v36:SetRoot(Root);
    v36:PlayAll();
    mainreplication.sceneEnabled(true);
    local ImpactFrames = DefensiveFlow.ImpactFrames;
    local u37 = Util.Preload(ImpactFrames);
    task.delay(0.933, function() -- Line: 388
        -- upvalues: Util (ref), ImpactFrames (copy)
        Util.Gif(ImpactFrames, 24);
    end);
    task.delay(1.8, function() -- Line: 392
        -- upvalues: TekrinnDialogue (ref), u29 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u29, {
            {
                Text = "This is..",
                Italic = true,
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 2, getcurrentIcon(u29));
    end);
    task.delay(3, function() -- Line: 408
        -- upvalues: TekrinnDialogue (ref), u29 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u29, {
            {
                Text = ".. my ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            },
            {
                Text = "role",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(0.667, 0, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            },
            {
                Text = " in this match!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 3, getcurrentIcon(u29));
    end);
    task.delay(7.5, function() -- Line: 448
        -- upvalues: TekrinnDialogue (ref), u29 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u29, {
            {
                Text = "CHAMELEON DEFENSE!",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.667, 0, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 2.767, getcurrentIcon(u29));
    end);
    task.delay(9.583, function() -- Line: 465
        -- upvalues: ScreenDimmer (copy), u30 (copy), u33 (copy), u31 (copy), u37 (copy), MoonEffects (copy), mainreplication (ref)
        ScreenDimmer:Destroy();
        u30:Destroy();

        if u33 then
            u33:Destroy();
        end;

        for _, v in u31 do
            v:Destroy();
        end;

        u37:Destroy();
        MoonEffects:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
end;

function u4.tapliftReoFlow(u38) -- Line: 481
    -- upvalues: vfxUtil (copy), mainreplication (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), u2 (copy), TekrinnDialogue (copy), getcurrentIcon (copy), actionUtil (copy), Players (copy)
    local TapLift = vfxUtil.getResources():WaitForChild("reo").TapLift;
    local Root = vfxUtil.getRoot(u38);
    local Ball = u38:WaitForChild("Ball");
    local v39 = TapLift.FullAura:Clone();
    vfxUtil.setupAura(u38, v39);
    v39.Parent = u38;
    local u40 = vfxUtil.createVFX(TapLift.BallVFX, u38, Ball);
    local u41 = vfxUtil.createVFX(TapLift.RootVFX, u38, Root);
    local u42 = vfxUtil.createVFX(TapLift.HeadVFX, u38, u38:FindFirstChild("Head"));
    local u43 = mainreplication.cutsceneCamRigWithLetterBox(Root, TapLift.CamAnimation, TapLift.FOV, nil, CFrame.new(0, -3, 0), TapLift.Cam, "CamPart");
    local v44;

    if u43 and u43:FindFirstChild("CamPart") then
        v44 = u43.CamPart;
    else
        v44 = nil;
    end;

    for _, child in u41.ReoVFX.Kick:GetChildren() do
        if child:IsA("Beam") then
            child.Attachment0 = u41.ReoVFX.Kick.a0;
            child.Attachment1 = u40.a1;
        end;
    end;

    local MoonEffects = vfxUtil.getMoonEffects();
    local u45 = {};

    for _, child in ipairs(TapLift.Lighting:GetChildren()) do
        local v46 = child:Clone();
        v46.Parent = Lighting;
        u45[child.Name] = v46;
    end;

    local v47 = MoonPropertyAnimator.ConvertSave(TapLift.MoonVFX, {
        Ball = u40,
        HumanoidRootPart = u41,
        ColorCorrection = u45.ColorCorrection,
        Bloom = u45.Bloom,
        Vignette = MoonEffects.Vignette
    });
    local v48 = MoonPropertyAnimator.new();
    v48:LoadSave(TapLift.MoonVFX, v47);
    v48:PlayAll();
    soundUtil:play(TapLift.SFX, SoundService);
    mainreplication.ultFlash(1);

    for _, v in ipairs(u2.TapLift) do
        task.delay(v[1] / 60, v[2], u42, u41, v44, v39, u40);
    end;

    mainreplication.sceneEnabled(true);
    task.spawn(function() -- Line: 534
        -- upvalues: TekrinnDialogue (ref), u38 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u38, {
            {
                Text = "Do you know how many times I\'ve seen it?",
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 2, getcurrentIcon(u38));
    end);
    task.delay(3.4, function() -- Line: 550
        -- upvalues: TekrinnDialogue (ref), u38 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u38, {
            {
                Text = "Instantly ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            },
            {
                Text = "kill",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.667, 0, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            },
            {
                Text = " it.",
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 0.65, getcurrentIcon(u38, "nagiJumpingTurn"));
    end);
    task.delay(5.4, function() -- Line: 588
        -- upvalues: TekrinnDialogue (ref), u38 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u38, {
            {
                Text = "A tap lift..",
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.667, 0, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 1.55, getcurrentIcon(u38, "nagiJumpingTurn"));
    end);
    task.delay(6.7, function() -- Line: 604
        -- upvalues: TekrinnDialogue (ref), u38 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u38, {
            {
                Text = "into...",
                Italic = true,
                TypeSpeed = 0.08,
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 1.55, getcurrentIcon(u38, "nagiJumpingTurn"));
    end);
    task.delay(8.3, function() -- Line: 620
        -- upvalues: TekrinnDialogue (ref), u38 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u38, {
            {
                Text = "A JUMPING TURN!",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.667, 0, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 1, getcurrentIcon(u38, "nagiJumpingTurn"));
    end);
    task.delay(10.4, function() -- Line: 636
        -- upvalues: actionUtil (ref), Players (ref), TekrinnDialogue (ref), u38 (copy), getcurrentIcon (ref)
        local v49 = "Nagi Seishiro";

        for _, child in workspace.characters:GetChildren() do
            if actionUtil.checkStyle(Players:GetPlayerFromCharacter(child)) == "nagi" then
                v49 = child.Name;
                break;
            end;
        end;

        TekrinnDialogue.Speak(u38, {
            {
                TypeSpeed = 0.03,
                Text = `{v49}...`,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0, 0.333333, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 0.8, getcurrentIcon(u38, "nagiJumpingTurn"));
    end);
    task.delay(12.75, function() -- Line: 659
        -- upvalues: TekrinnDialogue (ref), u38 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u38, {
            {
                Text = "COPIED!",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.667, 0, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 2, getcurrentIcon(u38, "nagiJumpingTurn"));
    end);
    task.delay(15, function() -- Line: 675
        -- upvalues: u40 (copy), u41 (copy), u42 (copy), u45 (copy), u43 (copy), MoonEffects (copy), mainreplication (ref)
        u40:Destroy();
        u41:Destroy();
        u42:Destroy();

        for _, v in u45 do
            v:Destroy();
        end;

        if u43 then
            u43:Destroy();
        end;

        MoonEffects:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
end;

function u4.reoTwinSteps(u50, u51) -- Line: 691
    -- upvalues: vfxUtil (copy), Players (copy), trove (copy), LocalPlayer (copy), mainreplication (copy), RunService (copy), VfxHandler (copy), BezierCurve (copy), TweenService (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u50);
    local TwinSteps = reo.TwinSteps;
    local HumanoidRootPart = u50:WaitForChild("HumanoidRootPart");
    vfxUtil.isLocalPlayer(u50);
    local u52 = trove.new();
    u52:AttachToInstance(u50);
    local u53 = TwinSteps.TwinSteps:Clone();
    u53.Parent = HumanoidRootPart;
    u53.Dash.Weld.Part0 = HumanoidRootPart;
    u52:Add(u53);
    local u54 = {};

    for _, v in { "Left Arm", "Right Arm" } do
        local v55 = vfxUtil.getResources().rintrail:Clone();
        v55:FindFirstChildWhichIsA("Trail", true).Color = ColorSequence.new(Color3.fromRGB(161, 47, 255));
        v55.Weld.Part0 = u50[v];
        v55.Parent = u50;
        table.insert(u54, v55);
    end;

    local v56 = 57;
    local u57 = v56 - v56 * 0;

    if LocalPlayer == PlayerFromCharacter then
        local u58 = 1;
        local u59 = u58 % 2 == 0 and 1 or -1;
        u52:Add(task.spawn(function() -- Line: 725
            -- upvalues: mainreplication (ref), HumanoidRootPart (copy), u51 (copy), u52 (copy), RunService (ref), u59 (ref), u58 (ref), u57 (ref), VfxHandler (ref)
            local u60 = mainreplication.bodyVelocity(HumanoidRootPart, 35, 1.665 / u51, nil, nil, true, TweenInfo.new(1.665 / u51, Enum.EasingStyle.Quart, Enum.EasingDirection.In));
            u52:Add(u60);
            u52:Add(RunService.RenderStepped:Connect(function(p61) -- Line: 730
                -- upvalues: u60 (copy), HumanoidRootPart (ref), u59 (ref), u58 (ref), u57 (ref)
                if not u60:IsDescendantOf(HumanoidRootPart) then
                    return;
                end;

                u59 = math.lerp(u59, u58 % 2 == 0 and 1 or -1, 7 * p61);
                local CFrame2 = HumanoidRootPart.CFrame;
                u60.Velocity = CFrame2.LookVector * (u57 * 0.4) + CFrame2.RightVector * (u57 * u59 * 0.35);
            end));
            VfxHandler.FadeBright(1 / u51, Color3.fromRGB(161, 47, 255), 0, 0, 0);
        end));
        u52:Add(task.delay(0.48 / u51, function() -- Line: 743
            -- upvalues: u58 (ref)
            u58 = u58 + 1;
        end));
        u52:Add(task.delay(0.87 / u51, function() -- Line: 746
            -- upvalues: u58 (ref)
            u58 = u58 + 1;
        end));
        u52:Add(task.delay(1.26 / u51, function() -- Line: 749
            -- upvalues: u58 (ref)
            u58 = u58 + 1;
        end));
    end;

    for _, v in u53.DribbleEnable:QueryDescendants("ParticleEmitter") do
        v.Enabled = true;
    end;

    u52:Add(task.delay(0.4 / u51, shared.vfx.emit, u53.One));
    u52:Add(task.delay(0.75 / u51, shared.vfx.emit, u53.Two));
    u52:Add(task.delay(1.11 / u51, shared.vfx.emit, u53.One));
    u52:Add(task.delay(1.5 / u51, function() -- Line: 763
        -- upvalues: u53 (copy), u54 (copy)
        shared.vfx.emit(u53.Two);

        for _, v in u53.DribbleEnable:QueryDescendants("ParticleEmitter") do
            v.Enabled = true;
        end;

        for _, v in u54 do
            pcall(game.Destroy, v);
        end;

        table.clear(u54);
    end));
    u52:Add(task.delay(1.667 / u51, function() -- Line: 774
        -- upvalues: u51 (copy), mainreplication (ref), u50 (copy), u53 (copy), LocalPlayer (ref), PlayerFromCharacter (copy), HumanoidRootPart (copy), VfxHandler (ref), u52 (copy), RunService (ref), BezierCurve (ref), TweenService (ref)
        tick();
        local u62 = 0.45 / u51;
        mainreplication.characterImage({
            Speed = 0.5,
            Brightness = 1,
            Whitelist = { u50 },
            Color = Color3.fromRGB(170, 85, 255)
        });
        mainreplication.characterImage({
            Speed = 3,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            Count = 16,
            Whitelist = { u50 },
            Color = Color3.fromRGB(170, 85, 255),
            Color2 = Color3.fromRGB(170, 170, 255)
        });
        shared.vfx.emit(u53.Turn);

        if LocalPlayer == PlayerFromCharacter then
            local u63 = u50 and u50:FindFirstChild("Humanoid") and HumanoidRootPart.CFrame:VectorToObjectSpace(u50.Humanoid.MoveDirection);

            if u63 then
                local v64 = math.round(u63.X) == 1;
                u63 = not v64;
            end;

            local u65 = mainreplication.bodyVelocity(HumanoidRootPart, 105, u62, nil, nil, true, TweenInfo.new(u62, Enum.EasingStyle.Quart, Enum.EasingDirection.In));
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 0.5 / u51, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            VfxHandler.FadeBright(0.25 / u51, Color3.fromRGB(161, 47, 255), 0, 0, 0);
            task.delay(u62, u65.Destroy, u65);
            u52:Add(u65);
            local u66 = tick();
            local u67 = 0;
            local NumberValue = Instance.new("NumberValue");
            u52:Add(NumberValue);
            u52:Add(RunService.RenderStepped:Connect(function() -- Line: 826
                -- upvalues: u67 (ref), u66 (ref), u62 (copy), u51 (ref), u65 (copy), BezierCurve (ref), NumberValue (copy), HumanoidRootPart (ref), u63 (copy)
                u67 = u67 + (tick() - u66);
                u66 = tick();

                if u67 >= u62 - 0.115 / u51 then
                    pcall(game.Destroy, u65);

                    return;
                end;

                local v68 = BezierCurve.OneTimeBezier(50, 237.5, -75, NumberValue.Value);

                if not u65:IsDescendantOf(HumanoidRootPart) then
                    return;
                end;

                local CFrame2 = HumanoidRootPart.CFrame;

                if u63 then
                    v68 = -v68 or v68;
                end;

                u65.Velocity = CFrame2.LookVector * 105 + CFrame2.RightVector * v68;
            end));
            TweenService:Create(NumberValue, TweenInfo.new(u62 - 0.115 / u51, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Value = 1
            }):Play();
        end;
    end));
    u52:Add(task.delay(2.5 / u51, function() -- Line: 850
        -- upvalues: LocalPlayer (ref), PlayerFromCharacter (copy), mainreplication (ref), HumanoidRootPart (copy), u51 (copy), u53 (copy)
        if LocalPlayer == PlayerFromCharacter then
            mainreplication.bodyVelocity(HumanoidRootPart, 160, 0.1835 / u51, nil, "lookVector", nil, TweenInfo.new(0.25 / u51, Enum.EasingStyle.Exponential, Enum.EasingDirection.In));
        end;

        shared.vfx.emit(u53.Dash);
    end));
    u52:Add(task.delay(3.3 / u51, function() -- Line: 858
        -- upvalues: u52 (copy)
        u52:Destroy();
    end));
end;

function u4.ChameleonVolley(u69, p70) -- Line: 863
    -- upvalues: vfxUtil (copy), trove (copy), Util (copy), animationUtil (copy), Lighting (copy), LocalPlayer (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), TweenService (copy), TekrinnDialogue (copy), getcurrentIcon (copy), u4 (copy), Debris (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local ChameleonVolley = reo.ChameleonVolley;
    local HumanoidRootPart = u69:WaitForChild("HumanoidRootPart");
    local u71 = trove.new();
    u71:AttachToInstance(u69);
    local v72 = ChameleonVolley.ChameleonButInAModelSoIdontLoseit:Clone();
    v72.nope.Weld.Part0 = HumanoidRootPart;
    v72.Parent = workspace.Effects;
    u71:Add(v72);
    local ImpactFrames = ChameleonVolley.ImpactFrames;
    Util.Preload(ImpactFrames);
    animationUtil:loadAnimation(v72.CHAMELEON, ChameleonVolley.Animations.Chameleon):Play(0);
    local u73 = u71:Construct(ChameleonVolley.VFX.VolleyVFX);
    u73.Parent = HumanoidRootPart;
    u73.BlackBG:Destroy();
    u73.VolleySpeedline:Destroy();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Brightness = 0;
    ColorCorrectionEffect.Contrast = 0.2;
    ColorCorrectionEffect.Saturation = -0.3;
    ColorCorrectionEffect.TintColor = Color3.new(1, 1, 1);
    ColorCorrectionEffect.Enabled = true;
    ColorCorrectionEffect.Parent = Lighting;
    u71:Add(ColorCorrectionEffect);
    local Atmosphere = Instance.new("Atmosphere");
    Atmosphere.Color = Color3.fromRGB(178, 208, 255);
    Atmosphere.Decay = Color3.fromRGB(255, 255, 255);
    Atmosphere.Glare = 0;
    Atmosphere.Haze = 5;
    Atmosphere.Density = 0.25;
    Atmosphere.Offset = 1;
    Atmosphere.Parent = Lighting;
    u71:Add(Atmosphere);
    local BloomEffect = Instance.new("BloomEffect");
    BloomEffect.Enabled = true;
    BloomEffect.Intensity = 0.8;
    BloomEffect.Size = 30;
    BloomEffect.Threshold = 1.856;
    BloomEffect.Parent = Lighting;
    u71:Add(BloomEffect);
    local v74 = reo.TripDawg.Vignette:Clone();
    local ImageLabel = v74.ImageLabel;
    ImageLabel.ImageTransparency = 1;
    v74.Parent = LocalPlayer.PlayerGui;
    u71:Add(v74);
    mainreplication.sceneEnabled(true);
    soundUtil:play(ChameleonVolley.SFX, SoundService);
    local u75 = mainreplication.cutsceneCamRigWithLetterBox(HumanoidRootPart, ChameleonVolley.Animations.Camera, ChameleonVolley.FOV, nil, CFrame.new(0, -3, 0), ChameleonVolley.CameraRig, "CamPart");

    if u75 then
        u71:Add(u75);
    end;

    vfxUtil.enableEffects(u73.VolleyArm, false, "ParticleEmitter,Beam");
    vfxUtil.enableEffects(u73.VolleyShot, false, "ParticleEmitter");

    if u75 then
        vfxUtil.enableEffects(u75.CamPart.ShotBeam, false, "Beam");
    end;

    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Linear), {
        Contrast = 0.1
    }):Play();
    u71:Add(task.delay(0.767, function() -- Line: 935
        -- upvalues: TweenService (ref), ImageLabel (copy)
        TweenService:Create(ImageLabel, TweenInfo.new(0.06599999999999995, Enum.EasingStyle.Linear), {
            ImageTransparency = 0
        }):Play();
    end));
    u71:Add(task.delay(0.783, function() -- Line: 939
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref), Atmosphere (copy)
        ColorCorrectionEffect.Brightness = 0.2;
        ColorCorrectionEffect.Contrast = 0.3;
        ColorCorrectionEffect.Saturation = 0.3;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.6169999999999999, Enum.EasingStyle.Linear), {
            Brightness = 0.1,
            Contrast = 0.2
        }):Play();
        TweenService:Create(Atmosphere, TweenInfo.new(0.11699999999999999, Enum.EasingStyle.Linear), {
            Density = 0.4,
            Offset = 1,
            Haze = 4,
            Color = Color3.fromRGB(147, 54, 255)
        }):Play();
    end));
    u71:Add(task.delay(0.833, function() -- Line: 947
        -- upvalues: TweenService (ref), ImageLabel (copy)
        TweenService:Create(ImageLabel, TweenInfo.new(0.534, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
    end));
    u71:Add(task.delay(0.85, function() -- Line: 951
        -- upvalues: u73 (copy), u75 (copy), vfxUtil (ref)
        shared.vfx.emit(u73.Appear);

        if u75 then
            vfxUtil.enableEffects(u75.CamPart.AppearBeam, true, "Beam");
        end;
    end));
    u71:Add(task.delay(0.9, function() -- Line: 958
        -- upvalues: TweenService (ref), Atmosphere (copy)
        TweenService:Create(Atmosphere, TweenInfo.new(1.267, Enum.EasingStyle.Linear), {
            Color = Color3.fromRGB(131, 51, 240)
        }):Play();
    end));
    u71:Add(task.delay(1.4, function() -- Line: 962
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.050000000000000044, Enum.EasingStyle.Linear), {
            Brightness = 0.2,
            Contrast = 0.3
        }):Play();
    end));
    u71:Add(task.delay(1.45, function() -- Line: 966
        -- upvalues: TekrinnDialogue (ref), u69 (copy), getcurrentIcon (ref), TweenService (ref), ColorCorrectionEffect (copy), vfxUtil (ref), u73 (copy), u4 (ref), u75 (copy)
        TekrinnDialogue.Speak(u69, {
            {
                Text = "If my ",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            },
            {
                Text = "talent ",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.667, 0, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            },
            {
                Text = "is to deftly pull off any play...",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 5, getcurrentIcon(u69, "chameleonVolley"));
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2330000000000001, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0
        }):Play();
        vfxUtil.enableEffects(u73.Dash, true, "ParticleEmitter");
        shared.vfx.emit(u73.Dash);
        u4.reoCopy(u69, true, true);

        if u75 then
            vfxUtil.enableEffects(u75.CamPart.AppearBeam, false, "Beam");
        end;
    end));
    u71:Add(task.delay(1.683, function() -- Line: 1014
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.34999999999999987, Enum.EasingStyle.Linear), {
            Contrast = 0.041,
            Saturation = -0.124
        }):Play();
    end));
    u71:Add(task.delay(2.033, function() -- Line: 1018
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.11699999999999999, Enum.EasingStyle.Linear), {
            Saturation = -0.165
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = -0.2,
            Contrast = 0.3
        }):Play();
    end));
    u71:Add(task.delay(2.15, function() -- Line: 1023
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.1499999999999999, Enum.EasingStyle.Linear), {
            Saturation = -0.165
        }):Play();
    end));
    u71:Add(task.delay(2.167, function() -- Line: 1027
        -- upvalues: TweenService (ref), Atmosphere (copy)
        TweenService:Create(Atmosphere, TweenInfo.new(0.383, Enum.EasingStyle.Linear), {
            Density = 1,
            Color = Color3.fromRGB(0, 0, 0)
        }):Play();
    end));
    u71:Add(task.delay(2.3, function() -- Line: 1031
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3500000000000001, Enum.EasingStyle.Linear), {
            Saturation = -1
        }):Play();
    end));
    u71:Add(task.delay(2.533, function() -- Line: 1035
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.11699999999999999, Enum.EasingStyle.Linear), {
            Brightness = 1
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.06700000000000017, Enum.EasingStyle.Linear), {
            Contrast = 10
        }):Play();
    end));
    u71:Add(task.delay(2.55, function() -- Line: 1040
        -- upvalues: vfxUtil (ref), u73 (copy), u75 (copy)
        vfxUtil.enableEffects(u73.Dash, false, "ParticleEmitter");

        if u75 then
            vfxUtil.enableEffects(u75.CamPart.AppearBeam, false, "Beam");
        end;
    end));
    u71:Add(task.delay(2.567, function() -- Line: 1047
        -- upvalues: Atmosphere (copy)
        Atmosphere.Color = Color3.fromRGB(178, 208, 255);
        Atmosphere.Density = 0.25;
        Atmosphere.Offset = 1;
    end));
    u71:Add(task.delay(2.65, function() -- Line: 1053
        -- upvalues: u75 (copy)
        if u75 then
            u75.CamPart.VFXpart.TransitionFX1.Enabled = true;
            u75.CamPart.VFXpart["TransitionFX1.1"].Enabled = true;
        end;
    end));
    u71:Add(task.delay(2.667, function() -- Line: 1060
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.20000000000000018, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.18300000000000027, Enum.EasingStyle.Linear), {
            Contrast = 0,
            Saturation = 0
        }):Play();
    end));

    if u75 then
        u71:Add(task.delay(2.97, vfxUtil.enableEffects, u75.CamPart, false, "ParticleEmitter"));
    end;

    u71:Add(task.delay(3.067, function() -- Line: 1070
        -- upvalues: ImageLabel (copy), ColorCorrectionEffect (copy), TweenService (ref)
        ImageLabel.ImageTransparency = 0;
        ColorCorrectionEffect.Brightness = -0.1;
        ColorCorrectionEffect.Contrast = 0.2;
        ColorCorrectionEffect.Saturation = -0.3;
        TweenService:Create(ImageLabel, TweenInfo.new(0.5329999999999999, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2829999999999999, Enum.EasingStyle.Linear), {
            Contrast = 0,
            Saturation = 0,
            Brightness = 0
        }):Play();
    end));
    u71:Add(task.delay(3.07, shared.vfx.emit, u73.Step));
    u71:Add(task.delay(3.35, function() -- Line: 1081
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2669999999999999, Enum.EasingStyle.Linear), {
            Contrast = 0.5,
            Saturation = 0.3
        }):Play();
    end));
    u71:Add(task.delay(3.45, function() -- Line: 1085
        -- upvalues: u75 (copy)
        if u75 then
            u75.CamPart.VFXpart.TransitionFX2.Enabled = true;
            u75.CamPart.VFXpart["TransitionFX2.1"].Enabled = true;
        end;
    end));
    u71:Add(task.delay(3.617, function() -- Line: 1092
        -- upvalues: TekrinnDialogue (ref), u69 (copy), getcurrentIcon (ref), ChameleonVolley (copy), HumanoidRootPart (copy), u71 (copy), Debris (ref), Atmosphere (copy), TweenService (ref), ColorCorrectionEffect (copy)
        TekrinnDialogue.Speak(u69, {
            {
                Text = "then I should be proud of that and ",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            },
            {
                Text = "LEAN INTO IT!",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.667, 0, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 2, getcurrentIcon(u69, "chameleonVolley"));
        local v76 = ChameleonVolley.VFX.VolleyVFX.BlackBG:Clone();
        v76.Anchored = true;
        v76.CFrame = HumanoidRootPart.CFrame;
        v76.Parent = workspace.Effects;
        u71:Add(v76);
        Debris:AddItem(v76, 1.4000000000000004);
        Atmosphere.Color = Color3.fromRGB(174, 83, 255);
        Atmosphere.Density = 0.3;
        TweenService:Create(Atmosphere, TweenInfo.new(2.2329999999999997, Enum.EasingStyle.Linear), {
            Density = 0.4
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.3329999999999997, Enum.EasingStyle.Linear), {
            Contrast = 0.1,
            Saturation = -0.3
        }):Play();
    end));
    u71:Add(task.delay(3.68, function() -- Line: 1131
        -- upvalues: ImageLabel (copy), TweenService (ref), u73 (copy), u75 (copy), vfxUtil (ref)
        ImageLabel.ImageTransparency = 0.958;
        TweenService:Create(ImageLabel, TweenInfo.new(1.4369999999999998, Enum.EasingStyle.Linear), {
            ImageTransparency = 0
        }):Play();
        shared.vfx.emit(u73.Jump);

        if u75 then
            vfxUtil.enableEffects(u75.CamPart.VFXpart, false, "ParticleEmitter");
            vfxUtil.enableEffects(u75.CamPart.VFXpart.Wind, true, "Beam");
        end;
    end));
    u71:Add(task.delay(4.85, Util.Gif, ImpactFrames, 24));
    u71:Add(task.delay(4.983, function() -- Line: 1143
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.21700000000000053, Enum.EasingStyle.Linear), {
            Brightness = 0.2,
            Contrast = 0.3,
            Saturation = 0.1
        }):Play();
    end));
    u71:Add(task.delay(5.02, function() -- Line: 1147
        -- upvalues: u4 (ref), u69 (copy), vfxUtil (ref), u73 (copy), u75 (copy)
        u4.reoClearCopy(u69);
        vfxUtil.enableEffects(u73.VolleyArm, true, "ParticleEmitter");

        if u75 then
            vfxUtil.enableEffects(u75.CamPart.TransitionsEnabled, true, "ParticleEmitter");
        end;
    end));
    u71:Add(task.delay(5.117, function() -- Line: 1155
        -- upvalues: ChameleonVolley (copy), HumanoidRootPart (copy), u71 (copy), Debris (ref), TweenService (ref), ImageLabel (copy)
        local v77 = ChameleonVolley.VFX.VolleyVFX.VolleySpeedline:Clone();
        v77.Anchored = true;
        v77.CFrame = HumanoidRootPart.CFrame * CFrame.new(11.195, 6.179, -12.82) * CFrame.Angles(-0.08087855753741724, -1.5707963267948966, 0);
        v77.Parent = workspace.Effects;
        u71:Add(v77);
        Debris:AddItem(v77, 0.23299999999999965);
        TweenService:Create(ImageLabel, TweenInfo.new(0.09999999999999964, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
    end));
    u71:Add(task.delay(5.2, function() -- Line: 1165
        -- upvalues: u75 (copy), vfxUtil (ref), TweenService (ref), ColorCorrectionEffect (copy)
        if u75 then
            vfxUtil.enableEffects(u75.CamPart.TransitionsEnabled, false, "ParticleEmitter");
        end;

        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.633, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0
        }):Play();
    end));
    u71:Add(task.delay(5.25, function() -- Line: 1172
        -- upvalues: u73 (copy), vfxUtil (ref), u75 (copy)
        shared.vfx.emit(u73.VolleyShot);
        vfxUtil.enableEffects(u73.VolleyShot, true, "ParticleEmitter");

        if u75 then
            vfxUtil.enableEffects(u75.CamPart.ShotBeam, true, "Beam");
        end;
    end));
    u71:Add(function() -- Line: 1180
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    u71:Add(task.delay(5.967, function() -- Line: 1184
        -- upvalues: u71 (copy)
        u71:Destroy();
    end));
end;

function u4.reoTripDawg(u78, p79, p80) -- Line: 1190
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), getcurrentIcon (copy), TweenService (copy)
    local TripDawg = vfxUtil.getResources():WaitForChild("reo").TripDawg;
    local HumanoidRootPart = u78:WaitForChild("HumanoidRootPart");
    local u81 = trove.new();
    local u82 = p80.Name == "Trip2";
    u81:AttachToInstance(u78);
    mainreplication.sceneEnabled(true);
    u81:Add(function() -- Line: 1201
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    local v83 = mainreplication.kuronaCam(HumanoidRootPart, nil, TripDawg.FOV);
    u81:Add(v83);
    local ImpactFrames = TripDawg.ImpactFrames;
    u81:Add(Util.Preload(ImpactFrames));
    local v84 = TripDawg.Vignette:Clone();
    local ImageLabel = v84.ImageLabel;
    ImageLabel.ImageTransparency = 1;
    v84.Parent = LocalPlayer.PlayerGui;
    u81:Add(v84);
    local u85 = TripDawg.VFX.Ball:Clone();
    u85.Parent = u78:FindFirstChild("Ball") or u78;
    u85.Weld.Part0 = u85.Parent;
    u81:Add(u85);
    local u86 = TripDawg.VFX.Cam:Clone();
    u86.Parent = v83;
    u86.Weld.Part0 = u86.Parent;
    u81:Add(u86);
    local u87 = u81:Construct(TripDawg.VFX.MainVFX);
    u87.Parent = workspace.Effects;
    u87:PivotTo(HumanoidRootPart.CFrame);
    local u88 = u81:Construct(TripDawg.VFX.Spin);
    u88.Weld.Part0 = u78:FindFirstChild("Torso") or HumanoidRootPart;
    u88.Parent = workspace.Effects;
    soundUtil:play(p80, SoundService);
    vfxUtil.enableEffects(u86.CamWind, true, "Beam");
    vfxUtil.enableEffects(u86.CubeAtmosphere, true, "ParticleEmitter");
    u81:Add(task.delay(0.32, function() -- Line: 1241
        -- upvalues: u87 (copy)
        shared.vfx.emit(u87.hand1);
        shared.vfx.emit(u87.hand2);
    end));
    u81:Add(task.delay(0.77, function() -- Line: 1246
        -- upvalues: u88 (copy), u78 (copy), vfxUtil (ref), u86 (copy)
        print(u88.CFrame, u78.Torso.CFrame);
        vfxUtil.enableEffects(u88, true, "Trail,ParticleEmitter");
        vfxUtil.enableEffects(u86.Cam1, true, "ParticleEmitter");
    end));
    u81:Add(task.delay(1.07, function() -- Line: 1252
        -- upvalues: u88 (copy), u78 (copy), vfxUtil (ref)
        print(u88.CFrame, u78.Torso.CFrame);
        vfxUtil.enableEffects(u88, false, "Trail,ParticleEmitter");
    end));
    u81:Add(task.delay(1.17, function() -- Line: 1257
        -- upvalues: vfxUtil (ref), u86 (copy)
        vfxUtil.enableEffects(u86.Cam1, false, "ParticleEmitter");
    end));
    local Color3_new_ret = Color3.new(1, 1, 1);
    local Color3_fromRGB_ret = Color3.fromRGB(170, 85, 255);
    u81:Add(task.delay(0.967, function() -- Line: 1262
        -- upvalues: TekrinnDialogue (ref), u78 (copy), u82 (copy), Color3_new_ret (copy), Color3_fromRGB_ret (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u78, {
            {
                Bold = true,
                TypeSpeed = 0.02,
                Text = u82 and "I will stop it!" or "I\'ll gladly take it!",
                Color = ColorSequence.new(Color3_new_ret, Color3_fromRGB_ret),
                Shake = {
                    Intensity = 2,
                    Lifetime = 2,
                    Enabled = u82
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 2, getcurrentIcon(u78));
    end));
    u81:Add(task.delay(1.55, function() -- Line: 1279
        -- upvalues: TweenService (ref), ImageLabel (copy)
        TweenService:Create(ImageLabel, TweenInfo.new(0.19999999999999996), {
            ImageTransparency = 0.2
        }):Play();
    end));
    u81:Add(task.delay(1.667, function() -- Line: 1283
        -- upvalues: Util (ref), ImpactFrames (copy)
        Util.Gif(ImpactFrames, 24);
    end));
    u81:Add(task.delay(1.75, function() -- Line: 1287
        -- upvalues: vfxUtil (ref), u86 (copy), u87 (copy), u85 (copy)
        vfxUtil.enableEffects(u86.Cam2, true, "Beam");
        vfxUtil.enableEffects(u86.CamSpeedlines, true, "ParticleEmitter");
        shared.vfx.emit(u87.Steal);
        shared.vfx.emit(u85);
    end));
    u81:Add(task.delay(3.25, function() -- Line: 1294
        -- upvalues: vfxUtil (ref), u86 (copy)
        vfxUtil.enableEffects(u86.Cam2, false, "Beam");
        vfxUtil.enableEffects(u86.CamSpeedlines, false, "ParticleEmitter");
    end));
    u81:Add(task.delay(3.433, function() -- Line: 1299
        -- upvalues: u81 (copy)
        u81:Destroy();
    end));
end;

function u4.reoClearCopy(p89) -- Line: 1304
    local ReoAura = p89:FindFirstChild("ReoAura");

    if ReoAura then
        ReoAura.Name = "FadingAura";
        local _ALIVE = ReoAura:FindFirstChild("_ALIVE");

        if _ALIVE then
            _ALIVE:Destroy();
        end;
    end;
end;

function u4.OneHundredPointPass(u90, p91, p92) -- Line: 1315
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), Players (copy), LocalPlayer (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local u93 = vfxUtil.isLocalPlayer(u90);
    local u94 = reo["100PointPass"];
    local u95 = trove.new();
    u95:AttachToInstance(u90);
    local u96 = false;

    if u93 then
        mainreplication.fov(true, 50, 0.4 / p92, Enum.EasingStyle.Quint);
    end;

    if p91 then
        if Players:GetPlayerFromCharacter(p91) == LocalPlayer then
            vfxUtil.flash(Color3.new(0.667, 0, 1), 1, 1);
        end;

        local Root = vfxUtil.getRoot(p91);

        if Root then
            local v97 = u95:Add(u94.Part2.Attachment:Clone());
            v97.Parent = Root;

            for _, descendant in v97:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end;
    end;

    u95:Add(task.delay(0.42 / p92, function() -- Line: 1342
        -- upvalues: u96 (ref), u93 (copy), mainreplication (ref), vfxUtil (ref), u90 (copy), Players (ref), LocalPlayer (ref), u95 (copy), u94 (copy)
        u96 = true;

        if u93 then
            mainreplication.fov(false, 90);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(20, 1.5, 5);
        end;

        local Root = vfxUtil.getRoot(u90);

        if Root then
            if Players:GetPlayerFromCharacter(u90) == LocalPlayer then
                vfxUtil.flash(Color3.new(0.667, 0, 1), 1, 1);
            end;

            local v98 = u95:Add(u94.Part:Clone());
            v98.Parent = workspace.Effects;
            v98.CFrame = Root.CFrame;
            local v99 = u95:Add(Instance.new("Motor6D"));
            v99.Parent = Root;
            v99.Part0 = v99.Parent;
            v99.Part1 = v98;
            v99.C0 = CFrame.new(0.5, -1.5, -3, 0, 1, 0, 0, 0, 1, 1, 0, 0);

            for _, descendant in v98:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end;
    end));
    u95:Add(task.delay(1.5, function() -- Line: 1371
        -- upvalues: u96 (ref), mainreplication (ref), u95 (copy)
        if not u96 then
            mainreplication.fov(false, 70);
        end;

        u95:Destroy();
    end));
end;

function u4.reoCopy(p100: any, p101: boolean, p102: boolean, p103: any, p104: string) -- Line: 1379
    -- upvalues: vfxUtil (copy), trove (copy), u4 (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), styles (copy), ReplicatedStorage (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local Root = vfxUtil.getRoot(p100);
    local v105 = vfxUtil.isLocalPlayer(p100);
    local v106 = trove.new();
    v106:AttachToInstance(p100);
    local Copy = reo.Copy;
    u4.reoClearCopy(p100);
    local u107 = Copy.Auras[`{p101 and "Full" or "Half"}Aura`]:Clone();
    vfxUtil.setupAura(p100, u107);
    u107.Name = "ReoAura";
    local BoolValue = Instance.new("BoolValue");
    BoolValue.Name = "_ALIVE";
    BoolValue.Value = true;
    BoolValue.Parent = u107;
    u107.Parent = p100;
    v106:AttachToInstance(BoolValue);

    if not p102 then
        if vfxUtil.isLocalPlayer(p100, p103) then
            vfxUtil.flash(Color3.new(0.667, 0, 1), 1, nil);
            mainreplication.fov(false, 75);
            mainreplication.fov(true, 70, 0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

            if p101 then
                local Children = Copy.Awakened:GetChildren();
                soundUtil:play(Children[math.random(#Children)], SoundService, {
                    Volume = 1
                });
            else
                local v108;

                if v105 then
                    v108 = SoundService or Root;
                else
                    v108 = Root;
                end;

                soundUtil:play(Copy.SFX, v108, {
                    Volume = v105 and 1 or 2
                });
            end;
        end;

        if typeof(p104) == "string" then
            local BGUI = v106:Construct(vfxUtil.createVFX, Copy.IconRoot, u107, Root).CharacterIcon.BGUI;
            local Icon = BGUI.Icon;
            local v109 = styles[p104];

            if v109 and v109.icon then
                Icon.Image = v109.icon;
            else
                Icon.Visible = false;
            end;

            local disabled = ReplicatedStorage.workspace.disabled;
            v106:Add(disabled.Changed:Connect(function(p110) -- Line: 1419
                -- upvalues: BGUI (copy)
                BGUI.Enabled = not p110;
            end));
            BGUI.Enabled = not disabled.Value;
        end;
    end;

    v106:Add(function() -- Line: 1425
        -- upvalues: BoolValue (copy), u107 (copy), vfxUtil (ref)
        BoolValue.Value = false;
        local v111 = {};
        local v112 = 0;

        for _, v in u107:QueryDescendants("Beam") do
            local v113 = {};

            for _, v2 in ipairs(v.Transparency.Keypoints) do
                table.insert(v113, { v2.Time, v2.Value });
            end;

            table.insert(v111, { v, v113 });
        end;

        for _, v in u107:QueryDescendants("ParticleEmitter") do
            v.Enabled = false;
        end;

        local disposal = vfxUtil.disposal;
        local EmittersLifetime = vfxUtil.getEmittersLifetime(u107);
        disposal(u107, (math.max(EmittersLifetime, 1)));

        while true do
            v112 = v112 + task.wait();

            for _, v in ipairs(v111) do
                local v114, v115 = unpack(v);
                local v116 = {};

                for _, v2 in ipairs(v115) do
                    local NumberSequenceKeypoint_new = NumberSequenceKeypoint.new;
                    local v117 = v2[1];
                    local math_lerp_ret = math.lerp(v2[2], 1, v112 / 1);
                    table.insert(v116, NumberSequenceKeypoint_new(v117, math_lerp_ret));
                end;

                v114.Transparency = NumberSequence.new(v116);
            end;

            if v112 > 1 then
                for _, v in v111 do
                    v[1]:Destroy();
                end;

                return;
            end;
        end;
    end);
    vfxUtil.quickVFX(Copy.RootVFX, p100, Root);
end;

function u4.reoElasticoStart(p118) -- Line: 1460
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local Root = vfxUtil.getRoot(p118);
    soundUtil:play(reo.CrossElastico.Startup, Root);

    if vfxUtil.isLocalPlayer(p118) then
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(20, 30);
    end;
end;

function u4.reoCrossElastico(u119) -- Line: 1472
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), SoundService (copy), Lighting (copy), Util (copy), RunService (copy), mainreplication (copy), TweenService (copy)
    local CrossElastico = vfxUtil.getResources():WaitForChild("reo").CrossElastico;
    local VFX = CrossElastico.VFX;
    local Root = vfxUtil.getRoot(u119);
    local u120 = vfxUtil.isLocalPlayer(u119);
    local u121 = trove.new();
    u121:AttachToInstance(u119);
    soundUtil:play(CrossElastico.Sound, SoundService);
    local u122 = u121:Add(Instance.new("ColorCorrectionEffect"));
    u122.Parent = Lighting;
    local u123 = u121:Add(VFX.HitVFX:Clone());
    u123.Parent = workspace.Effects;
    local u124 = u121:Add(VFX.CameraVFX:Clone());
    u124.Parent = workspace.Effects;
    local u125 = u121:Add(Instance.new("Highlight"));
    u125.FillTransparency = 0.5;
    u125.OutlineTransparency = 1;
    u125.FillColor = Color3.fromRGB(191, 62, 255);
    u125.DepthMode = Enum.HighlightDepthMode.Occluded;
    u125.Parent = u119;
    u121:Add(Util.Weld(Root, Root, u123, CFrame.new(0, 0, -1.75)));
    u121:Add(RunService.PreRender:Connect(function() -- Line: 1501
        -- upvalues: u124 (copy)
        u124.CFrame = workspace.CurrentCamera.CFrame;
    end));
    u121:Add(task.delay(0.08, function() -- Line: 1505
        -- upvalues: mainreplication (ref), TweenService (ref), u122 (copy)
        mainreplication.fov(false, 30);
        mainreplication.cameraShake(20, 1.5, 3);
        mainreplication.fov(true, 70, 0.8333333333333333, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

        for _, v in {
            Contrast = { {
                    time = 0.04,
                    changes = {
                        Contrast = 0.5
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Contrast = -3
                    }
                }, {
                    time = 0.06,
                    changes = {
                        Contrast = 1
                    }
                }, {
                    time = 0.16,
                    changes = {
                        Contrast = 0
                    }
                } },
            TintColor = {
                {
                    time = 0.21,
                    changes = {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }
                },
                {
                    time = 0.73,
                    changes = {
                        TintColor = Color3.fromRGB(209, 181, 255)
                    }
                },
                {
                    time = 1.34,
                    changes = {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }
                }
            },
            Saturation = { {
                    time = 0.05,
                    changes = {
                        Saturation = 0
                    }
                }, {
                    time = 0.9,
                    changes = {
                        Saturation = -1
                    }
                }, {
                    time = 1.21,
                    changes = {
                        Saturation = -1
                    }
                }, {
                    time = 0.12,
                    changes = {
                        Saturation = 0
                    }
                } }
        } do
            coroutine.wrap(function() -- Line: 1531
                -- upvalues: v (copy), TweenService (ref), u122 (ref)
                for _, v2 in v do
                    local v126 = TweenService:Create(u122, TweenInfo.new(v2.time, Enum.EasingStyle.Linear, Enum.EasingDirection.In), v2.changes);
                    v126:Play();
                    v126.Completed:Wait();
                end;
            end)();
        end;
    end));
    u121:Add(task.delay(0.1, function() -- Line: 1542
        -- upvalues: u123 (copy)
        shared.vfx.emit(u123);
    end));
    u121:Add(task.delay(0.15, function() -- Line: 1545
        -- upvalues: u124 (copy)
        shared.vfx.emit(u124);
    end));
    u121:Add(task.delay(1.48, function() -- Line: 1549
        -- upvalues: TweenService (ref), u125 (copy), u120 (copy), mainreplication (ref), Root (copy)
        TweenService:Create(u125, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FillTransparency = 1
        }):Play();

        if u120 then
            mainreplication.bodyVelocity(Root, 142.84666177549522, 1.0300000000000002, nil, nil, nil, TweenInfo.new(1.9100000000000001, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
        end;
    end));
    u121:Add(task.delay(1.4, function() -- Line: 1555
        -- upvalues: mainreplication (ref), u119 (copy)
        mainreplication.characterImage({
            Speed = 1,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.05,
            Count = 17,
            Whitelist = { u119 },
            Color = Color3.fromRGB(170, 85, 255),
            Color2 = Color3.fromRGB(170, 170, 255)
        });
    end));
    u121:Add(task.delay(5, function() -- Line: 1569
        -- upvalues: u121 (copy)
        u121:Destroy();
    end));
end;

function u4.reoDP_Dash(u127) -- Line: 1574
    -- upvalues: vfxUtil (copy), trove (copy), RunService (copy), mainreplication (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local Root = vfxUtil.getRoot(u127);
    local v128 = trove.new();
    v128:AttachToInstance(u127);
    local u129 = v128:Construct(reo.DobermanPress.Dash);
    u129.Parent = workspace.Effects;
    u129:PivotTo(u127:GetPivot());
    vfxUtil.forge.emit(u129);
    local EmittersLifetime = vfxUtil.getEmittersLifetime(u129);
    v128:Add(RunService.PreRender:Connect(function() -- Line: 1587
        -- upvalues: u129 (copy), u127 (copy)
        u129:PivotTo(u127:GetPivot());
    end));
    vfxUtil.disposal(v128, EmittersLifetime);
    mainreplication.bodyVelocity(Root, 129.9902629016553, 0.55, nil, nil, nil, TweenInfo.new(0.7000000000000001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));

    if not vfxUtil.isLocalPlayer(u127) then
        return;
    end;

    mainreplication.cameraShake(10, 0.4, 5);
    mainreplication.fov(false, 85);
    mainreplication.fov(true, 70, 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    mainreplication.cameraShake(4, 1, 5);
end;

function u4.reoDP_Hit(p130: any, p131: any, p132: userdata) -- Line: 1616
    -- upvalues: vfxUtil (copy), trove (copy), CancelHelper (copy), Lighting (copy), mainreplication (copy), MoonPropertyAnimator (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    vfxUtil.getRoot(p130);
    local DobermanPress = reo.DobermanPress;
    local v133 = vfxUtil.isLocalPlayer(p130, p131);
    local v134 = DobermanPress.Impact:Clone();
    v134.Parent = workspace.Effects;
    v134:PivotTo(p130:GetPivot());
    vfxUtil.forge.emit(v134);
    vfxUtil.disposal(v134);
    local u135 = trove.new();
    u135:AttachToInstance(p130);
    CancelHelper.cancelHelperToTrove(p132, u135);
    local v136 = u135:Construct(Instance, "Highlight");
    v136.FillColor = Color3.fromRGB(227, 89, 255);
    v136.FillTransparency = 0.5;
    v136.OutlineColor = Color3.new(1, 1, 1);
    v136.OutlineTransparency = 1;
    v136.Parent = p130;
    local v137, v138;

    if v133 then
        v137 = u135:Construct(Instance, "ColorCorrectionEffect");
        v137.Parent = Lighting;
        v138 = u135:Construct(vfxUtil.getMoonEffects);
        mainreplication.fov(false, 90);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut);
        mainreplication.cameraShake(5, 0.6, 5);
    else
        v137 = nil;
        v138 = nil;
    end;

    local v139 = u135:Construct(MoonPropertyAnimator);
    local Moon = DobermanPress.Moon;
    local ConvertSave = MoonPropertyAnimator.ConvertSave;
    local Moon2 = DobermanPress.Moon;
    local v140 = {
        ColorCorrection = v137,
        Highlight = v136,
        PointLight = v134["Particles+PL"].PL.PointLight
    };

    if v138 then
        v138 = v138.Vignette;
    end;

    v140.Vignette = v138;
    v139:LoadSave(Moon, ConvertSave(Moon2, v140));
    v139:PlayAll();
    local task_delay = task.delay;
    local v141 = 1.6 + vfxUtil.getEmittersLifetime(reo.DobermanPress.LastHit);
    u135:Add(task_delay(math.max(2.1, v141), function() -- Line: 1664
        -- upvalues: u135 (copy)
        u135:Destroy();
    end));
end;

function u4.reoDP_HitAway(p142, p143) -- Line: 1669
    -- upvalues: vfxUtil (copy), mainreplication (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    vfxUtil.getRoot(p142);
    local v144 = reo.DobermanPress.LastHit:Clone();
    v144.Parent = workspace.Effects;
    v144:PivotTo(p142:GetPivot());
    vfxUtil.forge.emit(v144);
    vfxUtil.disposal(v144);

    if vfxUtil.isLocalPlayer(p142, p143) then
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        mainreplication.cameraShake(10, 1, 5);
    end;
end;

function u4.reoSerpentJump(p145) -- Line: 1684
    -- upvalues: vfxUtil (copy), mainreplication (copy)
    if vfxUtil.isLocalPlayer(p145) then
        mainreplication.cameraShake(15, 0.35, 2);
        mainreplication.fov(true, 80, 0.55, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        task.delay(0.55, function() -- Line: 1688
            -- upvalues: mainreplication (ref)
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut);
        end);
    end;
end;

function u4.reoSerpentHeader(p146: any, p147: number) -- Line: 1694
    -- upvalues: vfxUtil (copy), trove (copy), Lighting (copy), MoonPropertyAnimator (copy), mainreplication (copy), soundUtil (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local v148 = p147 or 1;
    local Root = vfxUtil.getRoot(p146);
    local SerpentHeader = reo.SerpentHeader;
    local u149 = vfxUtil.isLocalPlayer(p146);
    local u150 = trove.new();
    u150:AttachToInstance(p146);

    if u149 then
        local v151 = u150:Construct(Instance, "ColorCorrectionEffect");
        v151.Parent = Lighting;
        local v152 = MoonPropertyAnimator.new();
        v152:LoadSave(SerpentHeader.Moon, MoonPropertyAnimator.ConvertSave(SerpentHeader.Moon, {
            ColorCorrection = v151
        }));
        v152:PlayAll();
        mainreplication.fov(true, 50, 0.15, Enum.EasingStyle.Cubic);
        mainreplication.cameraShake(15, 1.5, 5);
    end;

    local v153 = mainreplication.bodyVelocity(Root, 0.8, 0.15);

    if v153 then
        v153.MaxForce = Vector3.new(0, 30000, 0);
    end;

    soundUtil:play(SerpentHeader.Hit, Root);
    local v154 = SerpentHeader.VFX:Clone();
    v154.Parent = workspace.Effects;
    v154:PivotTo(p146:GetPivot());
    vfxUtil.forge.emit(v154);
    vfxUtil.disposal(v154);
    u150:Add(task.delay(0.15 / v148, function() -- Line: 1723
        -- upvalues: u149 (copy), mainreplication (ref)
        if u149 then
            mainreplication.fov(false, 90);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Cubic);
        end;
    end));
    u150:Add(task.delay(0.483 / v148, function() -- Line: 1729
        -- upvalues: u150 (copy)
        u150:Destroy();
    end));
end;

function u4.reoDraconicShot(p155: any, p156: number) -- Line: 1734
    -- upvalues: vfxUtil (copy), soundUtil (copy), trove (copy), Lighting (copy), MoonPropertyAnimator (copy), mainreplication (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local Root = vfxUtil.getRoot(p155);
    local v157 = vfxUtil.isLocalPlayer(p155);
    local DraconicShot = reo.DraconicShot;
    soundUtil:play(DraconicShot.WindUp, Root);
    local u158 = trove.new();
    u158:AttachToInstance(p155);
    local v159 = u158:Construct(DraconicShot.BodyEffects);
    local TorsoVFX = v159.TorsoVFX;
    TorsoVFX.Weld.Part0 = p155:FindFirstChild("Torso");
    v159.Parent = workspace.Effects;
    u158:Add(v159);

    if v157 then
        local v160 = u158:Construct(Instance, "ColorCorrectionEffect");
        v160.Parent = Lighting;
        local v161 = MoonPropertyAnimator.new();
        v161:LoadSave(DraconicShot.Moon, MoonPropertyAnimator.ConvertSave(DraconicShot.Moon, {
            ColorCorrection = v160
        }));
        v161:PlayAll();
        u158:Add(task.delay(0.267 / p156, function() -- Line: 1760
            -- upvalues: mainreplication (ref)
            mainreplication.fov(true, 60, 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            mainreplication.cameraShake(15, 0.35, 2);
        end));
        u158:Add(task.delay(0.783 / p156, function() -- Line: 1764
            -- upvalues: mainreplication (ref)
            mainreplication.fov(true, 70, 0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end));
    end;

    u158:Add(task.delay(0.467 / p156, function() -- Line: 1769
        -- upvalues: vfxUtil (ref), TorsoVFX (copy)
        vfxUtil.forge.emit(TorsoVFX.Wings);
        vfxUtil.forge.emit(TorsoVFX.rwSum, TorsoVFX.lwSum);
    end));
    u158:Add(task.delay(0.5 / p156, function() -- Line: 1774
        -- upvalues: vfxUtil (ref), TorsoVFX (copy)
        vfxUtil.forge.emit(TorsoVFX.rwEnab, TorsoVFX.lwEnab);
    end));
    u158:Add(task.delay(1.45 / p156, function() -- Line: 1778
        -- upvalues: vfxUtil (ref), TorsoVFX (copy)
        vfxUtil.forge.emit(TorsoVFX.rwSum, TorsoVFX.lwSum);
    end));
    local task_delay = task.delay;
    local EmittersLifetime = vfxUtil.getEmittersLifetime(TorsoVFX.rwSum);
    u158:Add(task_delay(1.45 / p156 + math.max(EmittersLifetime, vfxUtil.getEmittersLifetime(TorsoVFX.rwSum)), function() -- Line: 1782
        -- upvalues: u158 (copy)
        u158:Destroy();
    end));
end;

function u4.reoDraconicKick(p162) -- Line: 1787
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), mainreplication (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local Root = vfxUtil.getRoot(p162);
    local v163 = vfxUtil.isLocalPlayer(p162);
    local v164 = trove.new();
    local DraconicShot = reo.DraconicShot;
    v164:AttachToInstance(p162);
    local v165 = v164:Construct(DraconicShot.Shot);
    v165:PivotTo(Root.CFrame);
    v165.Parent = workspace.Effects;
    vfxUtil.forge.emit(v165);
    soundUtil:play(DraconicShot.Kick, Root);

    if v163 then
        mainreplication.cameraShake(15, 1.5, 7);
    end;
end;

function u4.reoMirrorZone(p166) -- Line: 1807
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), SoundService (copy), Lighting (copy), mainreplication (copy), MoonPropertyAnimator (copy), Util (copy), animationUtil (copy), u2 (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local Root = vfxUtil.getRoot(p166);
    local Ball = p166:FindFirstChild("Ball");
    local MirrorZone = reo.MirrorZone;
    local u167 = trove.new();
    u167:AttachToInstance(p166);
    local v168 = u167:Construct(MirrorZone.VFX);
    v168:PivotTo(p166:GetPivot());
    v168.Parent = workspace.Effects;
    vfxUtil.setupAura(p166, v168.HalfAura);
    vfxUtil.setupAura(p166, v168.FullAura);
    vfxUtil.setupAura(p166, v168.Sweat1);
    v168.Breath.Weld.Part1 = p166:FindFirstChild("Head");
    v168.Chomp.Weld.Part1 = Ball;
    v168.ballaura.Weld.Part1 = Ball;
    soundUtil:play(MirrorZone.SFX, SoundService);

    if Ball then
        local v169 = u167:Construct(Instance, "Attachment");
        v169.Parent = Ball;

        for _, v in v168.Shot:QueryDescendants("Beam") do
            if not v.Attachment1 then
                v.Attachment1 = v169;
            end;
        end;
    end;

    local v170 = {};

    for _, child in MirrorZone.Lighting:GetChildren() do
        local v171 = u167:Construct(child);
        v171.Parent = Lighting;
        v170[v171.Name] = v171;
    end;

    local v172, v173 = mainreplication.cutsceneCamRigWithLetterBox(Root, MirrorZone.CamAnimation, MirrorZone.FOV, p166, CFrame.new(0, -3, 0), MirrorZone["Panther Cam"], "CamPart");

    if v172 and v172:FindFirstChild("CamPart") then
        v168.CamWind.Weld.Part1 = v172.CamPart;

        for _, v in { "Transition", "Transition2" } do
            local v174 = v168:FindFirstChild(v);

            if v174 then
                v174.Weld.Part1 = v172.CamPart;
            end;
        end;
    end;

    if v173 then
        u167:Add(v173);
    end;

    local v175 = u167:Construct(vfxUtil.getMoonEffects);
    local v176 = MoonPropertyAnimator.new();
    v176:LoadSave(MirrorZone.Moon, MoonPropertyAnimator.ConvertSave(MirrorZone.Moon, Util.blendTables({
        Vignette = v175.Vignette
    }, v170)));
    v176:PlayAll();
    animationUtil:loadAnimation(v168.Panther, MirrorZone.PantherAnimation):Play(0);
    mainreplication.sceneEnabled(true);
    u167:Add(function() -- Line: 1873
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u167:Add(task.delay(5.4, function() -- Line: 1878
        -- upvalues: u167 (copy)
        u167:Destroy();
    end));

    for _, v in ipairs(u2.MirrorZone) do
        u167:Add(task.delay(v[1] / 60, v[2], v172, v168.Panther, v168));
    end;
end;

function u4.reoMetavision(p177) -- Line: 1887
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), trove (copy), Lighting (copy), MoonPropertyAnimator (copy), Util (copy), ClockTime (copy), u2 (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    vfxUtil.getRoot(p177);
    mainreplication.destroyVelocity(p177, true);
    local Head = p177:FindFirstChild("Head");
    local Metavision = reo.Metavision;
    soundUtil:play(Metavision.SFX, SoundService);
    local u178 = trove.new();
    u178:AttachToInstance(p177);
    local v179 = u178:Construct(Metavision.VFX);
    local Floor = v179.Floor;
    Floor.CFrame = Floor.CFrame * CFrame.new(0, 0.25, 0);
    v179:PivotTo(p177:GetPivot());
    v179.Parent = workspace.Effects;
    v179.Slide.Weld.Part1 = p177:FindFirstChild("Torso");
    v179.Head.Weld.Part1 = Head;
    v179.Eyes.Weld.Part1 = Head;
    local v180 = {};

    for _, child in Metavision.Lighting:GetChildren() do
        local v181 = u178:Construct(child);
        v181.Parent = Lighting;
        v180[v181.Name] = v181;
    end;

    local v182, _ = mainreplication.cutsceneCamRigWithLetterBox(v179.Root4Cam, Metavision.CamAnimation, Metavision.FOV, p177, nil, Metavision.CamMeta, "CamPart");

    if v182 and v182:FindFirstChild("CamPart") then
        for _, child in v179:GetChildren() do
            if child.Name:sub(1, 3) == "Cam" and child:FindFirstChild("Weld") then
                child.Weld.Part1 = v182.CamPart;
            end;
        end;
    end;

    local u183 = MoonPropertyAnimator.new();
    u183:LoadSave(Metavision.Moon, MoonPropertyAnimator.ConvertSave(Metavision.Moon, Util.blendTables({
        Lighting = Lighting,
        Tunnel = v179.Tunnel
    }, v180)));
    u183:PlayAll();
    mainreplication.sceneEnabled(true);
    u178:Add(function() -- Line: 1936
        -- upvalues: u183 (copy), Lighting (ref), ClockTime (ref), mainreplication (ref)
        u183:Destroy();
        Lighting.ClockTime = ClockTime;
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u178:Add(task.delay(6.35, function() -- Line: 1943
        -- upvalues: u178 (copy)
        u178:Destroy();
    end));

    for _, v in ipairs(u2.Metavision) do
        u178:Add(task.delay(v[1] / 60, v[2], v179));
    end;
end;

function u4.reoMetavisionRun(p184) -- Line: 1952
    -- upvalues: Players (copy), mainreplication (copy)
    local v185 = p184.HumanoidRootPart or p184.PrimaryPart;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p184) then
        mainreplication.fov(true, 81, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        task.delay(0.25, function() -- Line: 1957
            -- upvalues: mainreplication (ref)
            mainreplication.cameraShake(25, 0.8, 3, nil);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end);
    end;

    mainreplication.bodyVelocity(v185, 80.85, 1.55, true, nil, nil, TweenInfo.new(0.233, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
end;

function u4.defensiveovertimeReoFlow(u186) -- Line: 1974
    -- upvalues: vfxUtil (copy), trove (copy), Lighting (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), LocalPlayer (copy), animationUtil (copy), RunService (copy), TekrinnDialogue (copy), getcurrentIcon (copy), TweenService (copy)
    local reo = vfxUtil.getResources():WaitForChild("reo");
    local u187 = u186.HumanoidRootPart or u186.PrimaryPart;
    local OvertimeFlow = reo.OvertimeFlow;
    local u188 = vfxUtil.isLocalPlayer(u186);
    local Ball = u186:WaitForChild("Ball");
    local u189 = trove.new();
    u189:AttachToInstance(u186);
    local u190 = u189:Add(OvertimeFlow.VFX:Clone());
    u190.Parent = workspace.Effects;
    local u191 = {};

    for _, child in Lighting:GetChildren() do
        if child:IsA("ColorCorrectionEffect") or (child:IsA("BlurEffect") or (child:IsA("DepthOfFieldEffect") or child:IsA("Atmosphere"))) then
            table.insert(u191, child);
            child.Parent = workspace;
        end;
    end;

    coroutine.wrap(function() -- Line: 1996
        -- upvalues: u188 (copy), mainreplication (ref), u187 (copy)
        if u188 then
            mainreplication.bodyVelocity(u187, 25, 0.8, nil, nil, true, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));
        end;
    end)();
    soundUtil:play(OvertimeFlow.Sound, SoundService);
    local u192 = u189:Add(Instance.new("ColorCorrectionEffect"));
    u192.Saturation = -0.3;
    u192.Parent = Lighting;
    local u193 = u189:Add(Instance.new("BlurEffect"));
    u193.Size = 24;
    u193.Parent = Lighting;
    local u194 = u189:Add(Instance.new("DepthOfFieldEffect"));
    u194.FarIntensity = 1;
    u194.Parent = Lighting;
    local u195 = u189:Add(Instance.new("Atmosphere"));
    u195.Color = Color3.fromRGB(178, 208, 255);
    u195.Parent = Lighting;
    local u196 = u189:Add(OvertimeFlow.Vignette:Clone());
    u196.Parent = LocalPlayer.PlayerGui;
    local Weld = Instance.new("Weld");
    Weld.Parent = u187;
    Weld.Part0 = Weld.Parent;
    Weld.C0 = CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesYXZ(0, 3.141592653589793, 0);
    local u197 = OvertimeFlow.CHAMELEON:Clone();
    u197.Parent = workspace.Effects;
    u197.RootPart.CFrame = u187.CFrame;
    Weld.Part1 = u197.RootPart;
    u189:Add(Weld);
    u189:Add(u197);
    local u198, u199 = mainreplication.cutsceneCamRigWithLetterBox(u187, OvertimeFlow.Animations.Camera, OvertimeFlow.FOV, nil, CFrame.new(0, -3, 0), OvertimeFlow.Cameraa, "CamPart");
    local v200;

    if u198 then
        v200 = u198:FindFirstChild("CamPart");
    else
        v200 = u198;
    end;

    animationUtil:loadAnimation(u197, OvertimeFlow.Animations.Lizard):Play(0);
    local u201 = {};

    for i, v in {
        Breath = { u186:FindFirstChild("Head"), CFrame.identity },
        CamImpact = { v200, CFrame.identity * CFrame.new(0, 0, -1) },
        CamImpact2 = { v200, CFrame.identity * CFrame.new(0, 0, -1) },
        CamImpactstart = { v200, CFrame.identity * CFrame.new(0, 0, -1) },
        Transition = { v200, CFrame.identity * CFrame.new(0, 0, -1) },
        ReoMeta = { u186:FindFirstChild("Head"), CFrame.identity },
        Trails1 = { Ball, CFrame.identity },
        Trails2 = { Ball, CFrame.identity }
    } do
        if u190:FindFirstChild(i) and v[1] then
            local v202 = u190[i];
            local Weld2 = Instance.new("Weld");
            Weld2.Parent = v[1];
            Weld2.Part0 = Weld2.Parent;
            Weld2.Part1 = v202;
            Weld2.C0 = v[2];
            u189:Add(Weld2);
            u201[v202.Name] = v202;
            v202.Parent = workspace.Effects;
        end;
    end;

    u189:Add(RunService.PreRender:Connect(function() -- Line: 2068
        -- upvalues: u190 (copy), u187 (copy)
        u190:PivotTo(u187.CFrame * CFrame.new(0, -1, 0));
    end));
    mainreplication.sceneEnabled(true);
    u189:Add(function() -- Line: 2072
        -- upvalues: u199 (copy), mainreplication (ref), u191 (copy), Lighting (ref)
        if u199 then
            u199();
        end;

        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);

        for _, v in u191 do
            v.Parent = Lighting;
        end;
    end);
    u189:Add(task.delay(9.65, function() -- Line: 2082
        -- upvalues: u189 (copy)
        u189:Destroy();
    end));
    u189:Add(task.delay(0.603, function() -- Line: 2089
        -- upvalues: TekrinnDialogue (ref), u186 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u186, {
            {
                Text = "If my talent is to deftly pull off any play...",
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 4
                }
            }
        }, 4, getcurrentIcon(u186));
    end));
    u189:Add(task.delay(3.497, function() -- Line: 2104
        -- upvalues: TekrinnDialogue (ref), u186 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u186, {
            {
                Text = "Just like you\'re changing at Soccer Game...",
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 4
                }
            }
        }, 4, getcurrentIcon(u186));
    end));
    u189:Add(task.delay(7.15, function() -- Line: 2119
        -- upvalues: TekrinnDialogue (ref), u186 (copy), getcurrentIcon (ref)
        TekrinnDialogue.Speak(u186, {
            {
                Text = "I\'ll change into whatever color I want!",
                Color = ColorSequence.new(Color3.new(0.667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 6
                }
            }
        }, 4, getcurrentIcon(u186));
    end));
    u189:Add(task.spawn(function() -- Line: 2137
        -- upvalues: u192 (copy), RunService (ref)
        local u203 = u192;

        for _, v in {
            Contrast = { {
                    time = 0.04,
                    changes = {
                        Contrast = 0
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Contrast = 0.25
                    }
                }, {
                    time = 1.54,
                    changes = {
                        Contrast = 0
                    }
                }, {
                    time = 1.37,
                    changes = {
                        Contrast = 0
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Contrast = 0.3
                    }
                }, {
                    time = 1.77,
                    changes = {
                        Contrast = 0
                    }
                }, {
                    time = 0.27,
                    changes = {
                        Contrast = 0
                    }
                }, {
                    time = 0.14,
                    changes = {
                        Contrast = 0.3
                    }
                }, {
                    time = 0.76,
                    changes = {
                        Contrast = 0
                    }
                }, {
                    time = 0.13,
                    changes = {
                        Contrast = 0
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Contrast = -0.2
                    }
                }, {
                    time = 0.72,
                    changes = {
                        Contrast = 0
                    }
                }, {
                    time = 0.35,
                    changes = {
                        Contrast = -0.2
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Contrast = 0.25
                    }
                }, {
                    time = 0.95,
                    changes = {
                        Contrast = 0
                    }
                } },
            TintColor = {
                {
                    time = 0.46,
                    changes = {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }
                },
                {
                    time = 0.02,
                    changes = {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }
                },
                {
                    time = 1.54,
                    changes = {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }
                },
                {
                    time = 1.37,
                    changes = {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }
                },
                {
                    time = 0.02,
                    changes = {
                        TintColor = Color3.fromRGB(195, 48, 255)
                    }
                },
                {
                    time = 1.77,
                    changes = {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }
                },
                {
                    time = 2.04,
                    changes = {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }
                },
                {
                    time = 0.35,
                    changes = {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }
                }
            },
            Brightness = { {
                    time = 0.46,
                    changes = {
                        Brightness = 0
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Brightness = 0.2
                    }
                }, {
                    time = 1.54,
                    changes = {
                        Brightness = 0
                    }
                }, {
                    time = 1.37,
                    changes = {
                        Brightness = 0
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Brightness = 0.3
                    }
                }, {
                    time = 1.77,
                    changes = {
                        Brightness = 0
                    }
                }, {
                    time = 0.27,
                    changes = {
                        Brightness = 0
                    }
                }, {
                    time = 0.14,
                    changes = {
                        Brightness = 0.3
                    }
                }, {
                    time = 0.76,
                    changes = {
                        Brightness = 0
                    }
                }, {
                    time = 0.13,
                    changes = {
                        Brightness = 0
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Brightness = -0.1
                    }
                }, {
                    time = 0.72,
                    changes = {
                        Brightness = 0
                    }
                }, {
                    time = 0.35,
                    changes = {
                        Brightness = -0.1
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Brightness = 0.1
                    }
                }, {
                    time = 0.95,
                    changes = {
                        Brightness = 0
                    }
                } },
            Saturation = { {
                    time = 0.46,
                    changes = {
                        Saturation = 0.2
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Saturation = 0.2
                    }
                }, {
                    time = 1.54,
                    changes = {
                        Saturation = 0
                    }
                }, {
                    time = 1.37,
                    changes = {
                        Saturation = 0
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Saturation = 0.3
                    }
                }, {
                    time = 1.77,
                    changes = {
                        Saturation = 0
                    }
                }, {
                    time = 0.27,
                    changes = {
                        Saturation = 0
                    }
                }, {
                    time = 0.14,
                    changes = {
                        Saturation = 0.3
                    }
                }, {
                    time = 0.76,
                    changes = {
                        Saturation = 0
                    }
                }, {
                    time = 0.13,
                    changes = {
                        Saturation = 0
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Saturation = -0.3
                    }
                }, {
                    time = 0.72,
                    changes = {
                        Saturation = 0
                    }
                }, {
                    time = 0.35,
                    changes = {
                        Saturation = -0.2
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Saturation = 0.25
                    }
                }, {
                    time = 0.95,
                    changes = {
                        Saturation = 0
                    }
                } }
        } do
            coroutine.wrap(function() -- Line: 2203
                -- upvalues: v (copy), u203 (copy), RunService (ref)
                for _, v2 in v do
                    local v204 = tick();
                    local v205 = v2;
                    local v206 = {};

                    for i, _ in v2.changes do
                        v206[i] = u203[i];
                    end;

                    local v207;

                    repeat
                        RunService.PreRender:Wait();
                        local v208 = (tick() - v204) / v205.time;
                        v207 = v208 > 1 and 1 or v208;

                        for i, v3 in v205.changes do
                            if typeof(v3) == "number" then
                                u203[i] = math.lerp(v206[i], v3, v207);
                            elseif typeof(v3) == "Color3" then
                                u203[i] = v206[i]:Lerp(v3, v207);
                            end;
                        end;
                    until v207 >= 1;
                end;
            end)();
        end;
    end));
    u189:Add(task.spawn(function() -- Line: 2228
        -- upvalues: u193 (copy), RunService (ref)
        local u209 = u193;

        for _, v in {
            Size = { {
                    time = 0.43,
                    changes = {
                        Size = 5
                    }
                }, {
                    time = 0.08,
                    changes = {
                        Size = 12
                    }
                }, {
                    time = 0.56,
                    changes = {
                        Size = 12
                    }
                }, {
                    time = 1.17,
                    changes = {
                        Size = 4
                    }
                }, {
                    time = 0.01,
                    changes = {
                        Size = 24
                    }
                }, {
                    time = 0.79,
                    changes = {
                        Size = 4
                    }
                }, {
                    time = 0.35,
                    changes = {
                        Size = 4
                    }
                }, {
                    time = 0.09,
                    changes = {
                        Size = 10
                    }
                }, {
                    time = 1.57,
                    changes = {
                        Size = 4
                    }
                }, {
                    time = 0.43,
                    changes = {
                        Size = 4
                    }
                }, {
                    time = 0.11,
                    changes = {
                        Size = 20
                    }
                }, {
                    time = 0.07,
                    changes = {
                        Size = 19.051
                    }
                }, {
                    time = 0.12,
                    changes = {
                        Size = 4
                    }
                }, {
                    time = 1.39,
                    changes = {
                        Size = 4
                    }
                }, {
                    time = 0.02,
                    changes = {
                        Size = 15
                    }
                }, {
                    time = 0.75,
                    changes = {
                        Size = 4
                    }
                } }
        } do
            coroutine.wrap(function() -- Line: 2252
                -- upvalues: v (copy), u209 (copy), RunService (ref)
                for _, v2 in v do
                    local v210 = tick();
                    local v211 = v2;
                    local v212 = {};

                    for i, _ in v2.changes do
                        v212[i] = u209[i];
                    end;

                    local v213;

                    repeat
                        RunService.PreRender:Wait();
                        local v214 = (tick() - v210) / v211.time;
                        v213 = v214 > 1 and 1 or v214;

                        for i, v3 in v211.changes do
                            if typeof(v3) == "number" then
                                u209[i] = math.lerp(v212[i], v3, v213);
                            elseif typeof(v3) == "Color3" then
                                u209[i] = v212[i]:Lerp(v3, v213);
                            end;
                        end;
                    until v213 >= 1;
                end;
            end)();
        end;
    end));
    u189:Add(task.spawn(function() -- Line: 2277
        -- upvalues: u194 (copy), RunService (ref)
        local u215 = u194;

        for _, v in {
            Size = { {
                    time = 0.37,
                    changes = {
                        InFocusRadius = 5
                    }
                }, {
                    time = 0.12,
                    changes = {
                        InFocusRadius = 0
                    }
                }, {
                    time = 0.85,
                    changes = {
                        InFocusRadius = 5
                    }
                }, {
                    time = 2.06,
                    changes = {
                        InFocusRadius = 5
                    }
                }, {
                    time = 0.67,
                    changes = {
                        InFocusRadius = 25
                    }
                }, {
                    time = 1.36,
                    changes = {
                        InFocusRadius = 50
                    }
                }, {
                    time = 0.16,
                    changes = {
                        InFocusRadius = 2
                    }
                }, {
                    time = 0.57,
                    changes = {
                        InFocusRadius = 1.778
                    }
                }, {
                    time = 0.07,
                    changes = {
                        InFocusRadius = 0
                    }
                }, {
                    time = 0.15,
                    changes = {
                        InFocusRadius = 1.778
                    }
                }, {
                    time = 0.12,
                    changes = {
                        InFocusRadius = 1.778
                    }
                }, {
                    time = 0.09,
                    changes = {
                        InFocusRadius = 0
                    }
                }, {
                    time = 0.62,
                    changes = {
                        InFocusRadius = 0
                    }
                }, {
                    time = 0.17,
                    changes = {
                        InFocusRadius = 10
                    }
                }, {
                    time = 0.67,
                    changes = {
                        InFocusRadius = 10
                    }
                }, {
                    time = 1.01,
                    changes = {
                        InFocusRadius = 35
                    }
                } }
        } do
            coroutine.wrap(function() -- Line: 2301
                -- upvalues: v (copy), u215 (copy), RunService (ref)
                for _, v2 in v do
                    local v216 = tick();
                    local v217 = v2;
                    local v218 = {};

                    for i, _ in v2.changes do
                        v218[i] = u215[i];
                    end;

                    local v219;

                    repeat
                        RunService.PreRender:Wait();
                        local v220 = (tick() - v216) / v217.time;
                        v219 = v220 > 1 and 1 or v220;

                        for i, v3 in v217.changes do
                            if typeof(v3) == "number" then
                                u215[i] = math.lerp(v218[i], v3, v219);
                            elseif typeof(v3) == "Color3" then
                                u215[i] = v218[i]:Lerp(v3, v219);
                            end;
                        end;
                    until v219 >= 1;
                end;
            end)();
        end;
    end));
    u189:Add(task.spawn(function() -- Line: 2326
        -- upvalues: u195 (copy), RunService (ref)
        local u221 = u195;

        for _, v in {
            Color = {
                {
                    time = 4.09,
                    changes = {
                        Color = Color3.fromRGB(207, 40, 255)
                    }
                },
                {
                    time = 5.05,
                    changes = {
                        Color = Color3.fromRGB(207, 40, 255)
                    }
                },
                {
                    time = 0.25,
                    changes = {
                        Color = Color3.fromRGB(178, 208, 255)
                    }
                }
            },
            Density = { {
                    time = 3.42,
                    changes = {
                        Density = 0.295
                    }
                }, {
                    time = 0.67,
                    changes = {
                        Density = 0.3
                    }
                }, {
                    time = 5.05,
                    changes = {
                        Density = 0.3
                    }
                }, {
                    time = 0.25,
                    changes = {
                        Density = 0.25
                    }
                } },
            Offset = { {
                    time = 4.09,
                    changes = {
                        Offset = 3
                    }
                } }
        } do
            coroutine.wrap(function() -- Line: 2347
                -- upvalues: v (copy), u221 (copy), RunService (ref)
                for _, v2 in v do
                    local v222 = tick();
                    local v223 = v2;
                    local v224 = {};

                    for i, _ in v2.changes do
                        v224[i] = u221[i];
                    end;

                    local v225;

                    repeat
                        RunService.PreRender:Wait();
                        local v226 = (tick() - v222) / v223.time;
                        v225 = v226 > 1 and 1 or v226;

                        for i, v3 in v223.changes do
                            if typeof(v3) == "number" then
                                u221[i] = math.lerp(v224[i], v3, v225);
                            elseif typeof(v3) == "Color3" then
                                u221[i] = v224[i]:Lerp(v3, v225);
                            end;
                        end;
                    until v225 >= 1;
                end;
            end)();
        end;
    end));
    u189:Add(task.spawn(function() -- Line: 2373
        -- upvalues: u196 (copy), RunService (ref)
        local u227 = u196;

        for _, v in {
            ImageTransparency = { {
                    time = 0.46,
                    changes = {
                        ImageTransparency = 0
                    }
                }, {
                    time = 1.77,
                    changes = {
                        ImageTransparency = 0.495
                    }
                }, {
                    time = 0.01,
                    changes = {
                        ImageTransparency = 0.5
                    }
                }, {
                    time = 0.01,
                    changes = {
                        ImageTransparency = 0
                    }
                }, {
                    time = 1,
                    changes = {
                        ImageTransparency = 0.4
                    }
                }, {
                    time = 0.15,
                    changes = {
                        ImageTransparency = 0
                    }
                }, {
                    time = 1.99,
                    changes = {
                        ImageTransparency = 0.5
                    }
                }, {
                    time = 0.63,
                    changes = {
                        ImageTransparency = 0
                    }
                }, {
                    time = 0.4,
                    changes = {
                        ImageTransparency = 0.8
                    }
                }, {
                    time = 0.05,
                    changes = {
                        ImageTransparency = 0
                    }
                }, {
                    time = 0.72,
                    changes = {
                        ImageTransparency = 1
                    }
                }, {
                    time = 0.33,
                    changes = {
                        ImageTransparency = 0.4
                    }
                }, {
                    time = 0.07,
                    changes = {
                        ImageTransparency = 0
                    }
                }, {
                    time = 0.06,
                    changes = {
                        ImageTransparency = 0
                    }
                }, {
                    time = 0.49,
                    changes = {
                        ImageTransparency = 1
                    }
                } },
            ImageColor3 = {
                {
                    time = 0.46,
                    changes = {
                        ImageColor3 = Color3.fromRGB(0, 0, 0)
                    }
                },
                {
                    time = 0.02,
                    changes = {
                        ImageColor3 = Color3.fromRGB(66, 41, 79)
                    }
                },
                {
                    time = 1.77,
                    changes = {
                        ImageColor3 = Color3.fromRGB(0, 0, 0)
                    }
                },
                {
                    time = 0.99,
                    changes = {
                        ImageColor3 = Color3.fromRGB(66, 41, 79)
                    }
                },
                {
                    time = 0.12,
                    changes = {
                        ImageColor3 = Color3.fromRGB(125, 77, 148)
                    }
                },
                {
                    time = 1.79,
                    changes = {
                        ImageColor3 = Color3.fromRGB(66, 41, 79)
                    }
                },
                {
                    time = 1.79,
                    changes = {
                        ImageColor3 = Color3.fromRGB(66, 41, 79)
                    }
                },
                {
                    time = 0.11,
                    changes = {
                        ImageColor3 = Color3.fromRGB(114, 74, 142)
                    }
                },
                {
                    time = 0.16,
                    changes = {
                        ImageColor3 = Color3.fromRGB(114, 74, 142)
                    }
                },
                {
                    time = 0.32,
                    changes = {
                        ImageColor3 = Color3.fromRGB(114, 74, 142)
                    }
                },
                {
                    time = 0.05,
                    changes = {
                        ImageColor3 = Color3.fromRGB(206, 133, 255)
                    }
                },
                {
                    time = 0.68,
                    changes = {
                        ImageColor3 = Color3.fromRGB(114, 74, 142)
                    }
                },
                {
                    time = 0.4,
                    changes = {
                        ImageColor3 = Color3.fromRGB(114, 74, 142)
                    }
                },
                {
                    time = 0.09,
                    changes = {
                        ImageColor3 = Color3.fromRGB(169, 110, 210)
                    }
                },
                {
                    time = 1.28,
                    changes = {
                        ImageColor3 = Color3.fromRGB(114, 74, 142)
                    }
                }
            }
        } do
            coroutine.wrap(function() -- Line: 2413
                -- upvalues: v (copy), u227 (copy), RunService (ref)
                for _, v2 in v do
                    local v228 = tick();
                    local v229 = v2;
                    local v230 = {};

                    for i, _ in v2.changes do
                        v230[i] = u227.Vignette[i];
                    end;

                    local v231;

                    repeat
                        RunService.PreRender:Wait();
                        local v232 = (tick() - v228) / v229.time;
                        v231 = v232 > 1 and 1 or v232;

                        for i, v3 in v229.changes do
                            local v233 = i;
                            local v234 = v3;

                            for _, descendant in u227:GetDescendants() do
                                if descendant:IsA("ImageLabel") then
                                    if typeof(v234) == "number" then
                                        descendant[v233] = math.lerp(v230[v233], v234, v231);
                                    elseif typeof(v234) == "Color3" then
                                        descendant[v233] = v230[v233]:Lerp(v234, v231);
                                    end;
                                end;
                            end;
                        end;
                    until v231 >= 1;
                end;
            end)();
        end;
    end));
    u189:Add(task.spawn(function() -- Line: 2444
        -- upvalues: u198 (copy), u197 (copy)
        for _, descendant in ipairs(u198.VFXpart.Wind:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u197.RootPart.Head.Top.FirstGlow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(2.4, function() -- Line: 2454
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                    descendant:Clear();
                end);
            end;
        end;
    end));
    u189:Add(task.delay(0.36, function() -- Line: 2459
        -- upvalues: u201 (copy)
        for _, descendant in ipairs(u201.ReoMeta:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(2.4, function() -- Line: 2463
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                    descendant:Clear();
                end);
            end;
        end;
    end));
    u189:Add(task.delay(0.47, function() -- Line: 2468
        -- upvalues: u198 (copy)
        for _, descendant in ipairs(u198.VFXpart.FirstBeam:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u198.VFXpart.secondglow:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u189:Add(task.delay(0.5, function() -- Line: 2482
        -- upvalues: u201 (copy)
        for _, descendant in ipairs(u201.CamImpactstart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u201.Breath:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u189:Add(task.delay(2.25, function() -- Line: 2495
        -- upvalues: u190 (copy), u197 (copy)
        for _, descendant in ipairs(u190.EyeImpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u197.RootPart.Head.Top.Meta:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(1, function() -- Line: 2504
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end));
    u189:Add(task.delay(2.28, function() -- Line: 2509
        -- upvalues: u198 (copy)
        for _, descendant in ipairs(u198.VFXpart.FirstBeam:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u198.VFXpart.secondglow:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u189:Add(task.delay(3.39, function() -- Line: 2523
        -- upvalues: u198 (copy), u201 (copy), u190 (copy)
        for _, descendant in ipairs(u198.VFXpart.Wind:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u201.CamImpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u190.FloorEmit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u201.Trails1:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
                task.delay(2.2, function() -- Line: 2545
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        for _, descendant in ipairs(u190.MetaFloor:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u190.Floor:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u189:Add(task.delay(6.02, function() -- Line: 2559
        -- upvalues: u198 (copy), u201 (copy), u190 (copy)
        for _, descendant in ipairs(u198.VFXpart.Wind:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u201.CamImpact2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u201.Breath:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u190.MetaFloor:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u190.Floor:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
                descendant:Clear();
            end;
        end;
    end));
    u189:Add(task.delay(6.45, function() -- Line: 2591
        -- upvalues: u190 (copy)
        for _, descendant in ipairs(u190.ReoStep:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u189:Add(task.delay(7.17, function() -- Line: 2598
        -- upvalues: u198 (copy)
        for _, descendant in ipairs(u198.VFXpart.firstglow:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u189:Add(task.delay(7.2, function() -- Line: 2606
        -- upvalues: u201 (copy)
        for _, descendant in ipairs(u201.Trails2:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
                task.delay(0.45, function() -- Line: 2610
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end));
    u189:Add(task.delay(7.57, function() -- Line: 2614
        -- upvalues: u198 (copy)
        for _, descendant in ipairs(u198.VFXpart.LastBeam:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u189:Add(task.delay(7.58, function() -- Line: 2621
        -- upvalues: u190 (copy), TweenService (ref)
        for _, descendant in ipairs(u190.Recieve:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local u235 = TweenService;
        local u236 = u190.Beams:Clone();
        u236.Parent = workspace.Camera;

        for _, descendant in pairs(u236:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                local NumberValue = Instance.new("NumberValue");
                NumberValue.Parent = workspace.Camera;
                NumberValue.Value = 0.3;
                NumberValue.Changed:Connect(function(p237) -- Line: 2640
                    -- upvalues: descendant (copy)
                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1, p237), NumberSequenceKeypoint.new(1, 1) });
                end);
                local v238 = u235:Create(NumberValue, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Value = 1
                });
                v238:Play();
                task.spawn(function() -- Line: 2652
                    -- upvalues: u236 (copy), u235 (copy)
                    for _, descendant2 in pairs(u236:GetDescendants()) do
                        if descendant2:IsA("Beam") then
                            descendant2.TextureSpeed = 2;
                            u235:Create(descendant2, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                TextureSpeed = 0
                            }):Play();
                        end;
                    end;
                end);
                v238.Completed:Connect(function() -- Line: 2661
                    -- upvalues: NumberValue (copy), descendant (copy), u236 (copy)
                    NumberValue:Destroy();
                    descendant.Enabled = false;
                    task.wait(2);
                    u236:Destroy();
                end);
            end;
        end;
    end));
    u189:Add(task.delay(9.15, function() -- Line: 2671
        -- upvalues: u198 (copy)
        u198.VFXpart.TransitionFX1.Enabled = true;
        u198.VFXpart["TransitionFX1.1"].Enabled = true;
    end));
    u189:Add(task.delay(9.21, function() -- Line: 2676
        -- upvalues: u201 (copy)
        for _, descendant in ipairs(u201.Transition:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(0.2, function() -- Line: 2680
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end));
    u189:Add(task.delay(9.39, function() -- Line: 2685
        -- upvalues: u198 (copy)
        u198.VFXpart.TransitionFX1.Enabled = false;
        u198.VFXpart["TransitionFX1.1"].Enabled = false;

        for _, descendant in ipairs(u198.VFXpart.LastBeam:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u198.VFXpart.firstglow:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u198.VFXpart.Wind:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u198.VFXpart.FirstBeam:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u198.VFXpart.FirstBeam:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u198.VFXpart.secondglow:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end));
end;

return u4;