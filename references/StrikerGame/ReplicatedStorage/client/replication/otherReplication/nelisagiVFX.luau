 

 

local CollectionService = game:GetService("CollectionService");
game:GetService("ContentProvider");
local Debris = game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("ServerStorage");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local u1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
u1.cutsceneohiocamera = mainreplication.cutsceneohiocamera;
u1.cutscene = mainreplication.cutscene;
u1.cutsceneLeftright = mainreplication.cutsceneLeftright;
u1.cutscene_JxBEj_0 = mainreplication.cutscene_JxBEj_0;
u1.cutsceneBlender = mainreplication.cutsceneBlender;
u1.cutsceneHumanoidCamera = mainreplication.cutsceneHumanoidCamera;
u1.ultFlash = mainreplication.ultFlash;
u1.bright = mainreplication.bright;
u1.cameraShake = mainreplication.cameraShake;
u1.fov = mainreplication.fov;
u1.bodyVelocity = mainreplication.bodyVelocity;
u1.destroyVelocity = mainreplication.destroyVelocity;
u1.Emit = mainreplication.Emit;
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local Brightness = Lighting.Brightness;
local ClockTime = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local ExposureCompensation = Lighting.ExposureCompensation;
local _ = Lighting.Bloom.Threshold;
local EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);

if workspace:GetAttribute("11v11") then
    Brightness = 0.5;
    EnvironmentDiffuseScale = 0.898;
    ExposureCompensation = 0;
end;

workspace:GetAttributeChangedSignal("11v11"):Connect(function() -- Line: 54
    -- upvalues: Brightness (ref), EnvironmentDiffuseScale (ref), ExposureCompensation (ref)
    if workspace:GetAttribute("11v11") then
        Brightness = 0.5;
        EnvironmentDiffuseScale = 0.898;
        ExposureCompensation = 0;

        return;
    end;

    Brightness = 3;
    EnvironmentDiffuseScale = 1;
    ExposureCompensation = 0.2;
end);
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local Util = require(ReplicatedStorage.util.Util);
local Welder = require(ReplicatedStorage.Welder);
require(script.Parent.Parent.MeshEmitter);
local mainreplication2 = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
require(ReplicatedStorage.util.UwUEffects);
local trove = require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.VfxHandler);
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);
local camerasreplication = require(script.Parent.camerasreplication);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
require(ReplicatedStorage.util.KatUtil);

function u1.characterImage(p2) -- Line: 90
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p2);
end;

Util.OnFoundInstance(ReplicatedStorage.Resources, "nelisagi", function() -- Line: 94
    -- upvalues: Util (copy), ReplicatedStorage (copy)
    Util.Preload(ReplicatedStorage.Resources.nelisagi.RebirthAssets.Impact);
    Util.Preload(ReplicatedStorage.Resources.nelisagi.twogunvfx.Impact);
    Util.Preload(ReplicatedStorage.Resources.nelisagi.STUDIOPIECES);
    Util.Preload(ReplicatedStorage.Resources.nelisagi.LeftyShot.Impact);
end);
local u3 = {
    transparencyTarget = 0.95,
    tweenTime = 0.35,
    duration = 1,
    ensureOpaqueOnRestore = true,
    colorTarget = Color3.fromRGB(255, 255, 255)
};
local u4 = {};

local function GetVFX(p5: userdata, p6: userdata, p7: number, p8: boolean) -- Line: 112
    -- upvalues: Debris (copy), u4 (copy)
    local v9 = p6:Clone();
    local v10 = p6.Parent:FindFirstChild(p6:GetAttribute("WeldName") and p6:GetAttribute("WeldName") or p6.Name .. "Weld");

    if v10 then
        local v11 = v10:Clone();
        v11.Parent = v9;
        v11.Part0 = p5;
        v11.Part1 = v9;
    end;

    if p7 then
        Debris:AddItem(v9, p7);
    end;

    if p8 then
        u4[v9.Name] = p6;
    end;

    v9.Parent = p5;

    return v9;
end;

function GrabSavedVFX(p12: string)
    -- upvalues: u4 (copy)
    return u4[p12];
end;

local function CreateVFXTimeline(p13: userdata, p14: table, u15: function, p16: number) -- Line: 135
    -- upvalues: GetVFX (copy)
    for i, v in p14 do
        if u15 and not u15() then
            local v17 = v;
            local v18 = i;

            for _, child in p13:GetChildren() do
                if child.Name == v18 then
                    v17:Destroy();
                end;
            end;

            return;
        end;

        local u19 = GetVFX(p13, i, p16 or 5);

        for _, v2 in v do
            task.delay(v2, function() -- Line: 149
                -- upvalues: u19 (copy), u15 (copy)
                task.spawn(function() -- Line: 150
                    -- upvalues: u19 (ref), u15 (ref)
                    for _, descendant in u19:GetDescendants() do
                        if not u15() then
                            break;
                        end;

                        if descendant:IsA("ParticleEmitter") then
                            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        end;
                    end;
                end);
            end);
        end;
    end;
end;

local function Emit(p20) -- Line: 165
    for _, descendant in ipairs(p20:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("SpotLight"))) then
            local u21 = descendant:GetAttribute("EmitDelay") or 0;
            local u22 = descendant:GetAttribute("EmitCount") or 1;
            local u23 = descendant:GetAttribute("EmitDuration") or 0;
            task.spawn(function() -- Line: 171
                -- upvalues: u21 (copy), descendant (copy), u22 (copy), u23 (copy)
                task.wait(u21);

                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(u22);
                end;

                if u23 > 0 then
                    descendant.Enabled = true;
                    task.wait(u23);
                    descendant.Enabled = false;
                end;
            end);
        end;
    end;
end;

function u1.AwkOnBallIsagi(u24: userdata) -- Line: 186
    -- upvalues: camerasreplication (copy), ReplicatedStorage (copy), trove (copy), mainreplication2 (copy), soundUtil (copy), SoundService (copy), PlayerGui (copy), Lighting (copy), TekrinnDialogue (copy), TweenService (copy), animationUtil (copy), Emit (copy)
    local v25 = u24.HumanoidRootPart or u24.PrimaryPart;
    local u26 = camerasreplication.KimCamera(v25, ReplicatedStorage.Resources.nelisagi.OnBallNelSagiAwkCam, ReplicatedStorage.Resources.nelisagi.FOV_Awk, CFrame.new(0, 1.847, 0));
    local u27 = trove.new();
    u27:AttachToInstance(u24);
    mainreplication2.sceneEnabled(true);
    soundUtil:play(ReplicatedStorage.Resources.nelisagi["nelisagi awk sfx"], SoundService);
    local u28 = {};

    for _, descendant in ipairs(workspace.map.map:GetDescendants()) do
        if descendant:IsA("BasePart") then
            u28[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;

    local v29 = ReplicatedStorage.Resources.vb:Clone();
    v29.Parent = PlayerGui;
    u27:Add(v29);
    local v30 = ReplicatedStorage.Resources.glowscreen:Clone();
    v30.Parent = PlayerGui;
    v30.ImageLabel2.ImageTransparency = 0.7;
    v30.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    u27:Add(v30);
    local v31 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v31.Parent = Lighting;
    v31.FarIntensity = 1;
    u27:Add(v31);
    TekrinnDialogue.Speak(u24, {
        {
            Text = "A clue to how I can ",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.04,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 3,
                Lifetime = 10
            }
        },
        {
            Text = "evolve ",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.04,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 3,
                Lifetime = 6
            }
        },
        {
            Text = "lies somewhere inside of me.",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.04,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 3,
                Lifetime = 10
            }
        }
    }, 3);
    u27:Add(task.delay(2.7, function() -- Line: 287
        -- upvalues: TekrinnDialogue (ref), u24 (copy)
        TekrinnDialogue.Speak(u24, {
            {
                Text = "I have to think about what I can do and can\'t do!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 10
                }
            }
        }, 2.3);
    end));
    u27:Add(task.delay(5, function() -- Line: 313
        -- upvalues: TekrinnDialogue (ref), u24 (copy)
        TekrinnDialogue.Speak(u24, {
            {
                Text = "How do I ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 10
                }
            },
            {
                Text = "evolve ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 6
                }
            },
            {
                Text = "my weapon in this limited amount of time?!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 10
                }
            }
        }, 3);
    end));
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Brightness = -0.05;
    ColorCorrectionEffect.Contrast = 0.5;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    u27:Add(ColorCorrectionEffect);
    local ColorCorrectionEffect2 = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect2.Parent = Lighting;
    ColorCorrectionEffect2.TintColor = Color3.fromRGB(0, 0, 0);
    ColorCorrectionEffect2.Brightness = -1;
    u27:Add(ColorCorrectionEffect2);
    TweenService:Create(ColorCorrectionEffect2, TweenInfo.new(0.87, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    local v32 = ReplicatedStorage.Resources.nelisagi.AwkBg:Clone();
    v32.Parent = workspace.Effects;
    u27:Add(v32);

    for _, descendant in v32:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.Anchored = true;
        end;
    end;

    v32:PivotTo(v25.CFrame * CFrame.new(-27.609, -5.25, 27.27));
    local v33 = ReplicatedStorage.Resources.nelisagi["Metavision EyeBIG"]:Clone();
    v33.Parent = workspace.Effects;
    u27:Add(v33);
    v33:PivotTo(v25.CFrame * CFrame.new(0, 23, 0) * CFrame.Angles(0, 1.5707963267948966, 0));
    animationUtil:loadAnimation(v33, ReplicatedStorage.Resources.nelisagi.MetavisionEyeAwk):Play();
    local v34 = ReplicatedStorage.Resources.nelisagi.NELISAGI:Clone();
    v34.Parent = workspace.Effects;
    u27:Add(v34);
    v34:PivotTo(v25.CFrame * CFrame.new(0, -2.843, 0));
    animationUtil:loadAnimation(v34, ReplicatedStorage.Resources.nelisagi.MetavisionEyeAwkSmall):Play();
    local u35 = ReplicatedStorage.Resources.nelisagi.AwkOnBall:Clone();
    u27:Add(u35);
    local u36 = ReplicatedStorage.Resources.nelisagi.CutsceneVFXOnBall:Clone();
    u36.Parent = workspace.Effects;
    u27:Add(u36);
    u36.Crack.CFrame = v25.CFrame * CFrame.new(-0.186, 0.845, 27.9);
    u36.Line.CFrame = v25.CFrame * CFrame.new(-2.427, 0.356, 27.9);
    u36.Scan1.CFrame = v25.CFrame * CFrame.new(-40.983, -0.354, 28.848);
    u36.Scan2.CFrame = v25.CFrame * CFrame.new(-40.983, -0.354, 22.851);
    u36.Scan3.CFrame = v25.CFrame * CFrame.new(39.568, -0.354, 31.401);
    u36.Scan4.CFrame = v25.CFrame * CFrame.new(43.888, -0.354, 24.616);
    task.spawn(function() -- Line: 434
        -- upvalues: u35 (copy), u26 (copy), u27 (copy)
        for _, child in u35:GetChildren() do
            if child then
                child.Parent = u26.Bone;
                u27:Add(child);
            end;
        end;
    end);
    u27:Add(function() -- Line: 443
        -- upvalues: u28 (copy), mainreplication2 (ref)
        for i, v in u28 do
            i.Transparency = v;
        end;

        table.clear(u28);
        mainreplication2.sceneEnabled(false);
    end);
    u27:Add(task.delay(1.75, function() -- Line: 452
        -- upvalues: mainreplication2 (ref), Emit (ref), u36 (copy)
        mainreplication2.ultFlash(0.5, 1);
        Emit(u36.Scan2);
    end));
    u27:Add(task.delay(1.7833333333333334, function() -- Line: 457
        -- upvalues: mainreplication2 (ref), Emit (ref), u36 (copy)
        mainreplication2.ultFlash(0.5, 1);
        Emit(u36.Scan1);
    end));
    u27:Add(task.delay(3.533333333333333, function() -- Line: 462
        -- upvalues: mainreplication2 (ref), Emit (ref), u36 (copy)
        mainreplication2.ultFlash(0.5, 1);
        Emit(u36.Scan3);
    end));
    u27:Add(task.delay(3.6333333333333333, function() -- Line: 467
        -- upvalues: mainreplication2 (ref), Emit (ref), u36 (copy)
        mainreplication2.ultFlash(0.5, 1);
        Emit(u36.Scan4);
    end));
    u27:Add(task.delay(4.833333333333333, function() -- Line: 472
        -- upvalues: Emit (ref), u36 (copy)
        Emit(u36.Line);
    end));
    u27:Add(task.delay(6.1, function() -- Line: 476
        -- upvalues: mainreplication2 (ref), Emit (ref), u36 (copy)
        mainreplication2.ultFlash(0.1, 1);
        Emit(u36.Crack);
    end));
    u27:Add(task.delay(4.266666666666667, function() -- Line: 481
        -- upvalues: u26 (copy)
        for _, child in ipairs(u26.Bone:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
            end;
        end;
    end));
    u27:Add(task.delay(4.533333333333333, function() -- Line: 489
        -- upvalues: u26 (copy)
        for _, child in ipairs(u26.Bone:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
            end;
        end;
    end));
    u27:Add(task.delay(4.483333333333333, function() -- Line: 497
        -- upvalues: u26 (copy)
        for _, child in ipairs(u26.Bone.GLOW.WindScene.AT:GetChildren()) do
            if child:IsA("Beam") then
                child.Enabled = true;
            end;
        end;
    end));
    u27:Add(task.delay(7.65, function() -- Line: 505
        -- upvalues: Lighting (ref), u27 (copy), TweenService (ref)
        local ColorCorrectionEffect3 = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect3.Parent = Lighting;
        ColorCorrectionEffect3.TintColor = Color3.fromRGB(255, 255, 255);
        u27:Add(ColorCorrectionEffect3);
        TweenService:Create(ColorCorrectionEffect3, TweenInfo.new(0.87, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Brightness = -1,
            TintColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end));
    u27:Add(task.delay(8.5, function() -- Line: 513
        -- upvalues: u27 (copy)
        u27:Destroy();
    end));
end;

function u1.KILLERGUN(p37: userdata) -- Line: 518
    -- upvalues: mainreplication2 (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy)
    local v38 = p37.HumanoidRootPart or p37.PrimaryPart;
    mainreplication2.cutsceneCamRigWithLetterBox(v38, ReplicatedStorage.Resources.nelisagi.KillerIsagiCamera, ReplicatedStorage.Resources.nelisagi.FOV_Killer, nil, CFrame.new(0, -3, 0));
    mainreplication2.sceneEnabled(true);
    soundUtil:play(ReplicatedStorage.Resources.nelisagi.KillerGunsAudio, SoundService);
    local u39 = ReplicatedStorage.Resources.nelisagi.KillerGuns.Gun1:Clone();
    local u40 = ReplicatedStorage.Resources.nelisagi.KillerGuns.Gun2:Clone();
    local u41 = ReplicatedStorage.Resources.nelisagi.KillerGuns.HandleMain2:Clone();
    u41.Part1 = u39.HandleMain2;
    local u42 = ReplicatedStorage.Resources.nelisagi.KillerGuns.HandleMain:Clone();
    u42.Part1 = u40.HandleMain;
    u42.Part0 = v38;
    u41.Part0 = v38;
    u42.Parent = v38;
    u41.Parent = v38;
    u40.Parent = p37;
    u39.Parent = p37;
    task.delay(19.066666666666666, function() -- Line: 547
        -- upvalues: u39 (copy), u40 (copy), u42 (copy), u41 (copy), mainreplication2 (ref)
        u39:Destroy();
        u40:Destroy();
        u42:Destroy();
        u41:Destroy();
        mainreplication2.sceneEnabled(false);
        mainreplication2.ultFlash(3, 0.5);
    end);
end;

function u1.TwoGunVolleyNEL(u43: userdata) -- Line: 558
    -- upvalues: mainreplication2 (copy), ReplicatedStorage (copy), trove (copy), soundUtil (copy), SoundService (copy), Welder (copy), PlayerGui (copy), Lighting (copy), TweenService (copy), RunService (copy), Util (copy)
    local v44 = u43.HumanoidRootPart or u43.PrimaryPart;
    local u45 = mainreplication2.cutsceneCamRigWithLetterBox(v44, ReplicatedStorage.Resources.nelisagi.TGVCamAnim, ReplicatedStorage.Resources.nelisagi.FOV_TwoGun, nil, CFrame.new(-0.012, -2.94, -0.006) * CFrame.Angles(0, -3.141592653589793, 0));
    local u46 = trove.new();
    u46:AttachToInstance(u43);
    mainreplication2.sceneEnabled(true);
    soundUtil:play(ReplicatedStorage.Resources.nelisagi.TwoGunVolley, SoundService);
    u46:Add(function() -- Line: 574
        -- upvalues: mainreplication2 (ref), u45 (copy)
        mainreplication2.sceneEnabled(false);

        if u45 then
            u45:Destroy();
        end;

        mainreplication2.ultFlash(3, 1);
    end);
    local u47 = ReplicatedStorage.Resources.nelisagi.twogunvfx:Clone();
    u47.Parent = workspace.Effects;
    u46:Add(u47);
    u47.vfx:PivotTo(v44.CFrame);
    local u48 = ReplicatedStorage.Resources.nelisagi.camerascreenvfx:Clone();
    u48.Parent = u45;
    u46:Add(u48);
    task.spawn(function() -- Line: 590
        -- upvalues: Welder (ref), u45 (copy), u48 (copy)
        Welder:Weld(u45.camera, u48, CFrame.new(0, 0, 0), CFrame.new(), "Cam");
    end);

    for _, descendant in ipairs(u48:GetDescendants()) do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
            task.delay(6.45, function() -- Line: 597
                -- upvalues: descendant (copy)
                descendant.Enabled = false;
            end);
        end;
    end;

    for _, descendant in ipairs(u48:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
            task.delay(6.45, function() -- Line: 604
                -- upvalues: descendant (copy)
                descendant.Enabled = false;
            end);
        end;
    end;

    local v49 = ReplicatedStorage.Resources.vb:Clone();
    v49.Parent = PlayerGui;
    u46:Add(v49);
    local v50 = ReplicatedStorage.Resources.glowscreen:Clone();
    v50.Parent = PlayerGui;
    v50.ImageLabel2.ImageTransparency = 0.7;
    v50.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    u46:Add(v50);
    local v51 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v51.Parent = Lighting;
    v51.FarIntensity = 1;
    u46:Add(v51);
    u46:Add(task.delay(0.06666666666666667, function() -- Line: 623
        -- upvalues: u47 (copy)
        for _, descendant in ipairs(u47.vfx.vfx.vfx1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u46:Add(task.delay(0.1, function() -- Line: 631
        -- upvalues: mainreplication2 (ref), Lighting (ref), u46 (copy), TweenService (ref)
        mainreplication2.ultFlash(1, 0.5);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Parent = Lighting;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(191, 218, 255);
        ColorCorrectionEffect.Brightness = -0.2;
        ColorCorrectionEffect.Saturation = -0.3;
        u46:Add(ColorCorrectionEffect);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.95, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Brightness = 0,
            TintColor = Color3.fromRGB(236, 239, 255)
        }):Play();
    end));
    local u52 = ReplicatedStorage.Resources.nelisagi.Gunsofdoomanddespair:Clone();
    u52.Parent = u43;
    Welder:Motor6D(v44, u52.Part, CFrame.new(0.981, -2.5, 7.51), CFrame.new(), "Part", v44);

    for _, child in ipairs(u52:GetChildren()) do
        if child:IsA("MeshPart") then
            child.Transparency = 1;
        end;
    end;

    u46:Add(u52);
    local u53 = ReplicatedStorage.Resources.nelisagi.STUDIOPIECES:Clone();
    u53.Parent = u43;
    Welder:Motor6D(v44, u53.RootPart, CFrame.new(-0.256, -2.417, 9.209), CFrame.new(), "RootPart", v44);

    for _, child in ipairs(u53:GetChildren()) do
        if child:IsA("MeshPart") then
            child.Transparency = 1;
        end;
    end;

    u46:Add(u53);
    u46:Add(task.delay(1.7166666666666666, function() -- Line: 667
        -- upvalues: ReplicatedStorage (ref), u46 (copy), u47 (copy), TweenService (ref), RunService (ref), Welder (ref), u43 (copy)
        local u54 = ReplicatedStorage.Resources.nelisagi.swirl:Clone();
        u54.Parent = workspace.Effects;
        u46:Add(u54);
        u54.CFrame = u47.vfx.vfx.vfxbeamspawn.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0);

        for _, descendant in u54:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                local u55 = {
                    Width0 = descendant.Width0,
                    Width1 = descendant.Width1,
                    TextureSpeed = descendant.TextureSpeed,
                    Brightness = descendant.Brightness,
                    LightEmission = descendant.LightEmission
                };
                local v56 = TweenService:Create(descendant, TweenInfo.new(0.95, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Width0 = 0,
                    Width1 = 0
                });
                v56:Play();
                v56.Completed:Once(function() -- Line: 697
                    -- upvalues: descendant (copy), u55 (copy)
                    descendant.Enabled = false;

                    for i, v in u55 do
                        descendant[i] = v;
                    end;
                end);
            end;
        end;

        TweenService:Create(u54, TweenInfo.new(0.95, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = u47.vfx.vfx.vfxbeamspawn.CFrame.Position
        }):Play();
        local u57 = 0;
        local u58 = nil;
        u58 = RunService.Heartbeat:Connect(function(p59) -- Line: 716
            -- upvalues: u54 (copy), u57 (ref), u58 (ref)
            local v60 = u54;
            v60.CFrame = v60.CFrame * CFrame.Angles(0, 0, 0);
            u57 = u57 + p59;

            if u57 > 5 and u58 then
                u58:Disconnect();
            end;
        end);

        for _, child in ipairs(u47.vfx.vfx.bodyaura:GetChildren()) do
            if child:IsA("BasePart") then
                Welder:Weld(child, u43:FindFirstChild(child.Name), CFrame.new(0, 0, 0), CFrame.new(), "Weld");
            end;
        end;
    end));
    u46:Add(task.delay(1.8166666666666667, function() -- Line: 734
        -- upvalues: u52 (copy), u53 (copy)
        for _, child in ipairs(u52:GetChildren()) do
            if child:IsA("MeshPart") and (child.Name ~= "Goldtop" or child.Name ~= "goldbottom") then
                child.Transparency = 1;
            end;
        end;

        for _, child in ipairs(u53:GetChildren()) do
            if child:IsA("MeshPart") then
                child.Transparency = 0;
            end;
        end;
    end));
    u46:Add(task.delay(1.8333333333333333, function() -- Line: 751
        -- upvalues: u47 (copy)
        for _, descendant in ipairs(u47.vfx.vfx.bodyaura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(4.15, function() -- Line: 755
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end));
    u46:Add(task.delay(1.8666666666666667, function() -- Line: 760
        -- upvalues: u47 (copy), u48 (copy)
        for _, descendant in ipairs(u47.vfx.vfx.vfx1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u48:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                task.delay(1.45, function() -- Line: 770
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        for _, descendant in ipairs(u48.screenvfx2.flare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(1.45, function() -- Line: 777
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end));
    u46:Add(task.delay(2.8833333333333333, function() -- Line: 782
        -- upvalues: u48 (copy)
        for _, descendant in ipairs(u48.screenvfx3.screenshake:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(1.65, function() -- Line: 786
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end));
    u46:Add(task.delay(2.9, function() -- Line: 791
        -- upvalues: ReplicatedStorage (ref), u45 (copy), u46 (copy), u43 (copy), Welder (ref)
        local u61 = ReplicatedStorage.Resources.nelisagi.balleff:Clone();
        task.spawn(function() -- Line: 795
            -- upvalues: u61 (copy), u45 (ref)
            u61.Parent = u45;
        end);
        u46:Add(u61);

        if u43:FindFirstChild("Ball") then
            Welder:Weld(u43.Ball, u61, CFrame.new(0, 0, 0), CFrame.new(), "Ball");

            for _, descendant in ipairs(u61.vfx4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(1.65, function() -- Line: 805
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;
    end));
    u46:Add(task.delay(3.75, function() -- Line: 811
        -- upvalues: Util (ref), u47 (copy)
        Util.Gif(u47.Impact, 30);
    end));
    u46:Add(task.delay(3.783333333333333, function() -- Line: 816
        -- upvalues: u47 (copy)
        for _, descendant in ipairs(u47.vfx.vfx.vfx4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u46:Add(task.delay(4.316666666666666, function() -- Line: 824
        -- upvalues: u47 (copy)
        for _, descendant in ipairs(u47.vfx.vfx.gunvfx.smoke1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(1.25, function() -- Line: 829
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        for _, descendant in ipairs(u47.vfx.vfx.gunvfx.smoke2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(1.25, function() -- Line: 836
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end));
    u46:Add(task.delay(4.366666666666666, function() -- Line: 841
        -- upvalues: u47 (copy)
        for _, descendant in ipairs(u47.vfx.vfx.vfx5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u46:Add(task.delay(4.383333333333334, function() -- Line: 850
        -- upvalues: mainreplication2 (ref), u52 (copy)
        mainreplication2.ultFlash(1, 0.5);

        for _, child in ipairs(u52:GetChildren()) do
            if child:IsA("MeshPart") then
                child.Transparency = 0;
            end;
        end;
    end));
    u46:Add(task.delay(4.633333333333334, function() -- Line: 859
        -- upvalues: u47 (copy)
        for _, descendant in ipairs(u47.vfx.vfx.gunvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u46:Add(task.delay(5.583333333333333, function() -- Line: 867
        -- upvalues: u46 (copy)
        u46:Destroy();
    end));
end;

function u1.NELRebirth(u62: userdata) -- Line: 872
    -- upvalues: mainreplication2 (copy), ReplicatedStorage (copy), trove (copy), Util (copy), Lighting (copy), soundUtil (copy), SoundService (copy), Ambient (copy), ClockTime (copy), ExposureCompensation (ref), Welder (copy), TekrinnDialogue (copy), TweenService (copy)
    local u63 = u62.HumanoidRootPart or u62.PrimaryPart;
    local Ball = u62:FindFirstChild("Ball");
    local u64 = mainreplication2.cutscene(u63, CFrame.new(), 6.5, ReplicatedStorage.Resources.nelisagi.FOV_Rebirth);
    local u65 = trove.new();
    u65:AttachToInstance(u62);
    task.spawn(function() -- Line: 881
        -- upvalues: u65 (copy), Util (ref), ReplicatedStorage (ref), u64 (copy)
        u65:Add(Util.CameraEffect(ReplicatedStorage.Resources.nelisagi.RebirthAssets.Camera, u64));
    end);
    mainreplication2.sceneEnabled(true);

    if u64 then
        Lighting.Ambient = Color3.fromRGB(70, 70, 70);
        Lighting.Brightness = 3;
        Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
        Lighting.ClockTime = 14;
        Lighting.GeographicLatitude = 0;
        Lighting.ExposureCompensation = 0;
    end;

    local u66 = soundUtil:play(ReplicatedStorage.Resources.nelisagi.rebirthshot, SoundService, {
        Character = u62
    }).Name == "Dub";
    u65:Add(function() -- Line: 901
        -- upvalues: Lighting (ref), Ambient (ref), ClockTime (ref), ExposureCompensation (ref), u64 (copy), mainreplication2 (ref)
        Lighting.Ambient = Ambient;
        Lighting.Brightness = 3;
        Lighting.OutdoorAmbient = Color3.fromRGB(47, 47, 47);
        Lighting.ClockTime = ClockTime;
        Lighting.GeographicLatitude = 23;
        Lighting.ExposureCompensation = ExposureCompensation;

        if u64 then
            u64:Destroy();
        end;

        mainreplication2.sceneEnabled(false);
        mainreplication2.ultFlash(3, 1);
    end);
    local u67 = u65:Clone(ReplicatedStorage.Resources.ColorCorrection);

    if u64 then
        u67.Parent = Lighting;
    end;

    u67.Contrast = 0.2;
    u67.Saturation = -0.4;
    local u68 = Lighting.Atmosphere:Clone();
    Lighting.Atmosphere:Destroy();
    local u69 = u65:Clone(ReplicatedStorage.Resources.RebirthAtmosphere);
    u69.Parent = Lighting;
    local u70 = u65:Clone(ReplicatedStorage.Resources.nelisagi.RebirthAssets.Beams);
    local v71 = u65:Clone(ReplicatedStorage.Resources.nelisagi.RebirthAssets.Fall);
    local v72 = u65:Clone(ReplicatedStorage.Resources.nelisagi.RebirthAssets.Puzzle1);
    local v73 = u65:Clone(ReplicatedStorage.Resources.nelisagi.RebirthAssets.Puzzle2);
    u65:Clone(ReplicatedStorage.Resources.nelisagi.RebirthAssets.KickFX).Parent = u63;
    local v74 = ReplicatedStorage.Resources.nelisagi.RebirthAssets["Left Leg"];

    for _, child in ReplicatedStorage.Resources.nelisagi.RebirthAssets.BallAssets:GetChildren() do
        local v75 = u65:Clone(child);
        v75.Parent = Ball;

        if typeof(v75) == "Part" then
            Welder:Weld(Ball, v75);
        end;
    end;

    for _, child in v74:GetChildren() do
        u65:Clone(child).Parent = u62["Left Leg"];
    end;

    u70.Parent = workspace.Effects;
    v71.Parent = u63;
    v72.Parent = u63;
    v73.Parent = u63;
    u70:PivotTo(u63.CFrame);
    u70.BeamCollection.CFrame = u63.CFrame;
    v71:PivotTo(u63.CFrame);
    v73.CFrame = u63.CFrame;
    v72.CFrame = u63.CFrame;
    Welder:Weld(v73, u63);
    Welder:Weld(v72, u63);
    u65:Add(function() -- Line: 969
        -- upvalues: u68 (copy), Lighting (ref), u69 (copy)
        u68.Parent = Lighting;
        u69:Destroy();
    end);
    u65:Add(u67);
    task.delay(0.15, function() -- Line: 976
        -- upvalues: u66 (copy), TekrinnDialogue (ref), u62 (copy)
        if not u66 then
            return;
        end;

        TekrinnDialogue.Speak(u62, {
            {
                Text = "I have to go beyond the player I used to be..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 2.6);
    end);
    task.delay(3.033, function() -- Line: 1003
        -- upvalues: u66 (copy), TekrinnDialogue (ref), u62 (copy)
        if not u66 then
            return;
        end;

        TekrinnDialogue.Speak(u62, {
            {
                Text = "Change..",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 1.2);
    end);
    task.delay(4.5, function() -- Line: 1030
        -- upvalues: u66 (copy), TekrinnDialogue (ref), u62 (copy)
        if not u66 then
            return;
        end;

        TekrinnDialogue.Speak(u62, {
            {
                Text = "Become NEW!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 4);
    end);
    task.delay(0.2, function() -- Line: 1058
        -- upvalues: u66 (copy), TekrinnDialogue (ref), u62 (copy)
        if u66 then
            return;
        end;

        TekrinnDialogue.Speak(u62, {
            {
                Text = "I need to become the light that leads to the goal..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            },
            {
                Text = " I\'ll reach my new self..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.025,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2.7);
    end);
    u65:Add(task.delay(4, function() -- Line: 1106
        -- upvalues: u66 (copy), TekrinnDialogue (ref), u62 (copy)
        if u66 then
            return;
        end;

        TekrinnDialogue.Speak(u62, {
            {
                Text = "IN THE TERRITORY OF GENIUSES!",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 2.5
                }
            }
        }, 2);
    end));
    u65:Add(task.delay(1.0166666666666666, function() -- Line: 1133
        -- upvalues: mainreplication2 (ref), u69 (copy)
        mainreplication2.ultFlash(0.7, 0.5);
        u69.Density = 0.66;
        u69.Haze = 10;
    end));
    u65:Add(task.delay(5.433333333333334, function() -- Line: 1139
        -- upvalues: TweenService (ref), u69 (copy)
        TweenService:Create(u69, TweenInfo.new(0.1), {
            Density = 0,
            Haze = 0
        }):Play();
    end));
    TweenService:Create(u67, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        Brightness = 0.4
    }):Play();
    u65:Add(task.delay(0.1, function() -- Line: 1146
        -- upvalues: TweenService (ref), u67 (copy), u62 (copy), u70 (copy)
        TweenService:Create(u67, TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), {
            Brightness = -0.1
        }):Play();

        for _, descendant in pairs(u62["Left Leg"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u70.BeamCollection.Slide:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                descendant.TextureSpeed = 0.7;
            end;
        end;
    end));
    u65:Add(task.delay(1.0333333333333334, function() -- Line: 1162
        -- upvalues: u62 (copy), u70 (copy), Ball (copy)
        for _, descendant in pairs(u62["Left Leg"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u70.BeamCollection.Slide:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
                descendant.TextureSpeed = 0;
            end;
        end;

        for _, descendant in pairs(u70.BeamCollection.BallWind:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                descendant.TextureSpeed = 0.7;
            end;
        end;

        for _, descendant in pairs(Ball.ChargeKick:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u65:Add(task.delay(4.65, function() -- Line: 1190
        -- upvalues: Ball (copy)
        for _, descendant in pairs(Ball.ChargeKick:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u65:Add(task.delay(5.1, function() -- Line: 1198
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.nelisagi.RebirthAssets.Impact, 30);
    end));
    u65:Add(task.delay(5.5, function() -- Line: 1202
        -- upvalues: u70 (copy), Ball (copy), u63 (copy)
        for _, descendant in pairs(u70.BeamCollection.BallZoom:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Ball:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u63.KickFX:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u65:Add(task.delay(4.85, function() -- Line: 1220
        -- upvalues: u70 (copy), Ball (copy)
        for _, descendant in pairs(u70.BeamCollection.BallWind:GetDescendants()) do
            if descendant:IsA("Beam") then
                print(descendant.Enabled);
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u70.BeamCollection.BallZoom:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Ball:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u65:Add(task.delay(1, function() -- Line: 1239
        -- upvalues: TweenService (ref), u67 (copy)
        TweenService:Create(u67, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = -0.3
        }):Play();
    end));
    u65:Add(task.delay(1.5, function() -- Line: 1243
        -- upvalues: TweenService (ref), u67 (copy)
        TweenService:Create(u67, TweenInfo.new(142.5, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end));
    u65:Add(task.delay(6.5, function() -- Line: 1247
        -- upvalues: u65 (copy)
        u65:Destroy();
    end));
end;

function u1.neldash(u76, u77, p78) -- Line: 1253
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), u3 (copy), TweenService (copy), Players (copy), soundUtil (copy), SoundService (copy), mainreplication2 (copy), Lighting (copy), RunService (copy), workspace_CurrentCamera (copy), PlayerGui (copy), Util (copy), vfxUtil (copy), u1 (copy)
    local u79 = {};
    local u80 = u76.HumanoidRootPart or u76.PrimaryPart;
    local u81 = ReplicatedStorage.Resources.nelisagi.WeldDash:Clone();
    u81.Parent = u76;
    u81.Weld.Part0 = u80;
    local v82;

    if LocalPlayer and (LocalPlayer:FindFirstChild("setting") and LocalPlayer.setting:FindFirstChild("WeakerVFX")) then
        v82 = LocalPlayer.setting:FindFirstChild("WeakerVFX").Value;
    else
        v82 = false;
    end;

    local function TransparencyEffect(u83: userdata, p84: any) -- Line: 1270
        -- upvalues: u3 (ref), u79 (copy), TweenService (ref)
        if not (u83 and u83:IsA("Model")) then
            return;
        end;

        local v85 = p84 or {};
        local u86 = v85.transparencyTarget or u3.transparencyTarget;
        local u87 = v85.colorTarget or u3.colorTarget;
        local u88 = v85.tweenTime or u3.tweenTime;
        local v89 = v85.duration or u3.duration;
        local u90 = v85.ensureOpaqueOnRestore == nil and u3.ensureOpaqueOnRestore or v85.ensureOpaqueOnRestore;

        if u79[u83] then
            for _, v in ipairs(u79[u83].tweens) do
                pcall(function() -- Line: 1281
                    -- upvalues: v (copy)
                    v:Cancel();
                end);
            end;
        end;

        local u91 = {};
        local v92 = {};
        u79[u83] = {
            token = u91,
            tweens = v92
        };
        local u93 = {};

        for _, descendant in ipairs(u83:GetDescendants()) do
            local v94 = descendant:IsA("Accessory") and descendant:FindFirstChild("Handle");

            if v94 then
                u93[v94] = {
                    Transparency = v94.Transparency
                };
                local v95 = TweenService:Create(v94, TweenInfo.new(u88), {
                    Transparency = 1
                });
                v95:Play();
                table.insert(v92, v95);
            end;

            if (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) and descendant.Transparency < u86 then
                u93[descendant] = {
                    Transparency = descendant.Transparency
                };
                local v96 = TweenService:Create(descendant, TweenInfo.new(u88), {
                    Transparency = u86
                });
                v96.Completed:Connect(function() -- Line: 1305
                    -- upvalues: descendant (copy), u86 (copy)
                    descendant.Transparency = u86;
                end);
                v96:Play();
                table.insert(v92, v96);
            end;

            if descendant:IsA("BasePart") then
                u93[descendant] = u93[descendant] or {};
                u93[descendant].Color = descendant.Color;
                local v97 = TweenService:Create(descendant, TweenInfo.new(u88), {
                    Color = u87
                });
                v97.Completed:Connect(function() -- Line: 1315
                    -- upvalues: descendant (copy), u87 (copy)
                    descendant.Color = u87;
                end);
                v97:Play();
                table.insert(v92, v97);
            end;

            if descendant:IsA("ShirtGraphic") or (descendant:IsA("Shirt") or descendant:IsA("Pants")) then
                u93[descendant] = {
                    Color3 = descendant.Color3
                };
                local v98 = TweenService:Create(descendant, TweenInfo.new(u88), {
                    Color3 = u87
                });
                v98:Play();
                table.insert(v92, v98);
            end;
        end;

        task.delay(v89, function() -- Line: 1328
            -- upvalues: u79 (ref), u83 (copy), u91 (copy), u93 (copy), u90 (copy), TweenService (ref), u88 (copy)
            if not u79[u83] or u79[u83].token ~= u91 then
                return;
            end;

            for i, v in pairs(u93) do
                if i and i.Parent then
                    if v.Transparency ~= nil then
                        local v99 = u90 and 0 or v.Transparency;
                        TweenService:Create(i, TweenInfo.new(u88), {
                            Transparency = v99
                        }):Play();
                    end;

                    if v.Color ~= nil then
                        TweenService:Create(i, TweenInfo.new(u88), {
                            Color = v.Color
                        }):Play();
                    end;

                    if v.Color3 ~= nil then
                        TweenService:Create(i, TweenInfo.new(u88), {
                            Color3 = v.Color3
                        }):Play();
                    end;
                end;
            end;

            u79[u83] = nil;
        end);
    end;

    task.spawn(function() -- Line: 1354
        -- upvalues: Players (ref), u76 (copy), u77 (copy), soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), mainreplication2 (ref), Lighting (ref), TweenService (ref), RunService (ref), workspace_CurrentCamera (ref), PlayerGui (ref), u80 (copy), Util (ref), LocalPlayer (ref), vfxUtil (ref)
        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u76) then
            return;
        end;

        if u77 then
            soundUtil:play(ReplicatedStorage.Resources.nelisagi.guh, SoundService);
        else
            soundUtil:play(ReplicatedStorage.Resources.nelisagi.redline, SoundService);
        end;

        mainreplication2.cameraShake(10, 1.5, 6);
        mainreplication2.fov(false, 120);
        mainreplication2.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication2.highlight(u76, Color3.fromRGB(75, 120, 48), 1.5);
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.15, BlurEffect.Destroy, BlurEffect);
        local v100 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v100.Parent = Lighting;
        v100.TintColor = Color3.fromRGB(37, 186, 255);
        v100.Brightness = 0.4;
        v100.Contrast = 1;
        v100.Saturation = -0.4;
        v100.Name = "NELRaumdeuterCC";
        TweenService:Create(v100, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v100.Destroy, v100);
        local u101 = ReplicatedStorage.Resources.nelisagi.isagicamSTART:Clone();
        u101.Parent = workspace.Effects;
        local u102 = nil;
        u102 = RunService.PreRender:connect(function() -- Line: 1392
            -- upvalues: u101 (copy), u102 (ref), workspace_CurrentCamera (ref)
            if not u101:IsDescendantOf(game) then
                u102:Disconnect();
            end;

            u101.CFrame = workspace_CurrentCamera.CFrame;
        end);

        for _, descendant in pairs(u101.isagileft:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(0.15, u101.isagileft.Destroy, u101.isagileft);
        local u103 = ReplicatedStorage.Resources.glowscreen:Clone();
        u103.ImageLabel2.ImageColor3 = Color3.fromRGB(101, 109, 255);
        u103.Parent = PlayerGui;
        task.delay(0.15, function() -- Line: 1413
            -- upvalues: mainreplication2 (ref), u80 (ref), ReplicatedStorage (ref), Util (ref), LocalPlayer (ref), u76 (ref), vfxUtil (ref), TweenService (ref)
            mainreplication2.Emit(u80, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
            local u104 = ReplicatedStorage.Resources.rundasheff:Clone();
            u104.main.Weld.C0 = CFrame.new(0, 0, 0);
            u104.main.Weld.Part0 = u80;
            u104.Parent = workspace.Effects;

            if Util.canshiftcolor(LocalPlayer, u76) then
                vfxUtil.LeanTowardsColor(u104, u76:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u76:GetAttribute("CustomAlpha") or 0.985);
            end;

            u104.Air.Size = Vector3.new(4.998, 0.503, 4.998);
            u104.Air.Transparency = 0.8;
            local Air = u104.main.Air;
            Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
            TweenService:Create(u104.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                C0 = u104.main.Air.C0 * CFrame.new(0, 15, 0)
            }):Play();
            TweenService:Create(u104.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(17.136, 1.132, 16.878),
                Transparency = 1
            }):Play();
            u104.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
            u104.Wind1.Transparency = 0.9;
            TweenService:Create(u104.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(19.108, 11.452, 11.292),
                Transparency = 1
            }):Play();
            task.delay(0.15, function() -- Line: 1439
                -- upvalues: u104 (copy), TweenService (ref)
                u104.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
                u104.Wind1.Transparency = 0.9;
                TweenService:Create(u104.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(19.108, 11.452, 11.292),
                    Transparency = 1
                }):Play();
            end);
            u104.End.Size = Vector3.new(5, 1, 5);
            u104.End.Transparency = 0.65;
            local End = u104.main.End;
            End.C0 = End.C0 * CFrame.new(0, 0, 0);
            TweenService:Create(u104.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                C0 = u104.main.End.C0 * CFrame.new(0, -15, 0)
            }):Play();
            TweenService:Create(u104.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                Size = Vector3.new(12.999, 2.766, 12.999),
                Transparency = 1
            }):Play();
            task.delay(0.15, function() -- Line: 1455
                -- upvalues: u104 (copy), TweenService (ref)
                u104.End.Size = Vector3.new(5, 1, 5);
                u104.End.Transparency = 0.65;
                local End2 = u104.main.End;
                End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
                TweenService:Create(u104.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    C0 = u104.main.End.C0 * CFrame.new(0, -15, 0)
                }):Play();
                TweenService:Create(u104.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(12.999, 2.766, 12.999),
                    Transparency = 1
                }):Play();
            end);
            u104.A.Size = Vector3.new(14.29, 4.752, 5.444);
            u104.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
            u104.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
            u104.A.Decal.Transparency = 0.9;
            TweenService:Create(u104.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                C0 = u104.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
            }):Play();
            TweenService:Create(u104.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                Size = Vector3.new(33.166, 4.752, 5.443)
            }):Play();
            TweenService:Create(u104.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                Scale = Vector3.new(0.715, 0.303, 0.315)
            }):Play();
            TweenService:Create(u104.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            task.delay(2, u104.Destroy, u104);
        end);
        task.delay(1, function() -- Line: 1479
            -- upvalues: TweenService (ref), u103 (copy), u101 (copy)
            TweenService:Create(u103.ImageLabel2, TweenInfo.new(1), {
                ImageTransparency = 1
            }):Play();

            for _, descendant in pairs(u101:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(3, u101.Destroy, u101);
            task.delay(1, u103.Destroy, u103);
        end);
    end);
    task.delay(0.3, function() -- Line: 1496
        -- upvalues: u81 (copy)
        for _, descendant in ipairs(u81:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u81.Destroy, u81);
    end);
    u1.bodyVelocity(u80, p78 and 54.54545454545454 or (u77 and 90 or 70), 1.1, true, nil, nil, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));

    if not u77 then
        if vfxUtil.IsSettingOn(Players.LocalPlayer, "NoVFXAtAll") then
            return;
        end;

        u1.characterImage({
            Speed = 1.1,
            CFrames = true,
            Brightness = 1,
            ImageTransparency = 0.8,
            Whitelist = { u76 },
            countSpeed = v82 and 0.12 or 0.03,
            Count = v82 and 7 or 26,
            Color = Color3.fromRGB(0, 85, 127),
            Color2 = Color3.fromRGB(0, 85, 255)
        });

        return;
    end;

    TransparencyEffect(u76);

    if vfxUtil.IsSettingOn(Players.LocalPlayer, "NoVFXAtAll") then
        return;
    end;

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u76) then
        return;
    end;

    u1.characterImage({
        Speed = 1.1,
        CFrames = true,
        Brightness = 1,
        ImageTransparency = 0.8,
        Whitelist = { u76 },
        countSpeed = v82 and 0.15 or 0.03,
        Count = v82 and 6 or 32,
        Color = Color3.fromRGB(0, 85, 127),
        Color2 = Color3.fromRGB(0, 85, 255)
    });
end;

function u1.feintland(p105, u106) -- Line: 1537
    -- upvalues: mainreplication2 (copy), ReplicatedStorage (copy)
    local u107 = p105.HumanoidRootPart or p105.PrimaryPart;
    mainreplication2.bodyVelocity(u107, 50, 0.5);
    local CounterAssets = ReplicatedStorage.Resources.nelisagi.CounterAssets;
    task.spawn(function() -- Line: 1543
        -- upvalues: mainreplication2 (ref)
        mainreplication2.ultFlash(0.3, 0.4);
        mainreplication2.cameraShake(25, 0.4, 7);
    end);

    if p105:FindFirstChild("counterstartup") then
        p105.counterstartup:Destroy();
    end;

    local u108 = {};
    local u109 = CounterAssets.slide:Clone();
    u109.Motor6D.Part0 = u107;
    u109.Parent = workspace.Effects;
    local u110 = CounterAssets.step:Clone();
    u110.Motor6D.Part0 = u107;
    u110.Parent = workspace.Effects;
    local u111 = CounterAssets.steptwo:Clone();
    u111.Motor6D.Part0 = u107;
    u111.Parent = workspace.Effects;
    local u112 = CounterAssets.stepthird:Clone();
    u112.Motor6D.Part0 = u107;
    u112.Parent = workspace.Effects;
    task.delay(0.23333333333333334, function() -- Line: 1570
        -- upvalues: u109 (copy)
        for _, descendant in pairs(u109:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.38333333333333336, function() -- Line: 1579
        -- upvalues: u110 (copy)
        for _, descendant in pairs(u110:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.6, function() -- Line: 1588
        -- upvalues: u111 (copy)
        for _, descendant in pairs(u111:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.7833333333333333, function() -- Line: 1597
        -- upvalues: u112 (copy)
        for _, descendant in pairs(u112:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.8666666666666667, function() -- Line: 1608
        -- upvalues: u108 (copy)
        for _, v in u108 do
            v:Destroy();
        end;
    end);
    task.delay(0.25, function() -- Line: 1614
        -- upvalues: mainreplication2 (ref), u107 (copy), u106 (copy), u112 (copy), u111 (copy), u110 (copy), u109 (copy)
        local u113 = mainreplication2.bodyVelocity(u107, 250 * (u106 and 0.525 or 1), 0.8666666666666667);
        task.delay(0.8666666666666667, function() -- Line: 1616
            -- upvalues: u112 (ref), u111 (ref), u110 (ref), u109 (ref), u113 (copy)
            u112:Destroy();
            u111:Destroy();
            u110:Destroy();
            u109:Destroy();

            if u113 then
                u113:Destroy();
            end;
        end);
    end);
end;

function u1.isagishot(p114) -- Line: 1628
    -- upvalues: Lighting (copy), TweenService (copy), ReplicatedStorage (copy), u1 (copy)
    local v115 = p114.HumanoidRootPart or p114.PrimaryPart;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v116 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v116.Parent = Lighting;
    v116.TintColor = Color3.fromRGB(111, 154, 255);
    v116.Brightness = 0.4;
    v116.Contrast = 1;
    v116.Saturation = -0.4;
    TweenService:Create(v116, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v116, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v116.Destroy, v116);
    u1.fov(false, 100);
    u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.cameraShake(10, 2, 6);
    u1.Emit(v115, ReplicatedStorage.Resources.sae.hota, 5, CFrame.new(3, 0, -4));
end;

function u1.metaBurstPointRun(p117: userdata) -- Line: 1666
    -- upvalues: mainreplication2 (copy), ReplicatedStorage (copy), LocalPlayer (copy), TweenService (copy)
    local HumanoidRootPart = p117:FindFirstChild("HumanoidRootPart");
    mainreplication2.bodyVelocity(HumanoidRootPart, 75, 1.5, nil, nil, nil, TweenInfo.new(0.85, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0), 1);
    local u118 = ReplicatedStorage.Resources.nelisagi.MetaBurstRun:Clone();
    u118.Join.Part0 = HumanoidRootPart;
    u118.Parent = workspace.Effects;

    for _, descendant in u118:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    if p117 == LocalPlayer.Character then
        mainreplication2.cameraShake(10, 1.5, 6);
    end;

    task.delay(0.85, function() -- Line: 1686
        -- upvalues: u118 (copy), TweenService (ref)
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0.5;
        NumberValue.Parent = u118;
        TweenService:Create(NumberValue, TweenInfo.new(0.15, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Value = 1
        }):Play();
        local u119 = {};

        for _, descendant in u118:GetDescendants() do
            if descendant:IsA("Beam") then
                table.insert(u119, descendant);
            end;
        end;

        task.spawn(function() -- Line: 1705
            -- upvalues: NumberValue (copy), u119 (copy)
            while NumberValue:IsDescendantOf(game) do
                local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });

                for _, v in u119 do
                    v.Transparency = NumberSequence_new_ret;
                end;

                task.wait();
            end;
        end);
    end);
    task.delay(1, function() -- Line: 1722
        -- upvalues: u118 (copy)
        u118:Destroy();
    end);
end;

function u1.metaBurstPointSuccess(u120: userdata) -- Line: 1727
    -- upvalues: mainreplication2 (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), TekrinnDialogue (copy), u1 (copy), RunService (copy), workspace_CurrentCamera (copy)
    local v121 = u120.HumanoidRootPart or u120.PrimaryPart;
    local Ball = u120:FindFirstChild("Ball");
    mainreplication2.sceneEnabled(true);
    soundUtil:play(ReplicatedStorage.Resources.nelisagi.metaBurstPointBlockHit, SoundService);
    local v122 = soundUtil:play(ReplicatedStorage.Resources.nelisagi.LandedMeta, SoundService, {
        Character = u120
    });
    soundUtil:play(ReplicatedStorage.Resources.nelisagi.LandedMeta2, SoundService);
    local u123 = v122.Name == "Dub";
    task.delay(0, function() -- Line: 1748
        -- upvalues: u123 (copy), TekrinnDialogue (ref), u120 (copy)
        if not u123 then
            return;
        end;

        TekrinnDialogue.Speak(u120, {
            {
                Text = "You and i know this spot..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end);
    task.delay(0, function() -- Line: 1775
        -- upvalues: u123 (copy), TekrinnDialogue (ref), u120 (copy)
        if u123 then
            return;
        end;

        TekrinnDialogue.Speak(u120, {
            {
                Text = "It\'s here, isn\'t it?",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end);
    local v124 = u1.cutscene(v121, nil, 1.45, ReplicatedStorage.Resources.nelisagi.FOV_Intercept);
    local u125 = ReplicatedStorage.Resources.nelisagi.balleff.vfx4:Clone();
    u125.Parent = Ball;
    local u126 = {};
    task.spawn(function() -- Line: 1809
        -- upvalues: u120 (copy), ReplicatedStorage (ref), u126 (copy)
        for _, descendant in ipairs(u120:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v127 = descendant;

                for _, descendant2 in ipairs(ReplicatedStorage.Resources.nelisagi.twogunvfx.vfx.vfx.bodyaura.Torso:GetDescendants()) do
                    local v128 = descendant2:Clone();
                    v128.Parent = v127;
                    v128.Enabled = true;
                    table.insert(u126, v128);
                end;
            end;
        end;
    end);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 12500;
    BodyPosition.MaxForce = Vector3.new(30000, 30000, 30000);
    BodyPosition.D = 300;
    BodyPosition.Parent = v121;
    BodyPosition.Position = v121.Position;
    local u129 = ReplicatedStorage.Resources.nelisagi.lorenzocam:Clone();
    u129.Parent = v124;
    local u130 = nil;
    u130 = RunService.PreRender:connect(function() -- Line: 1835
        -- upvalues: u129 (copy), u130 (ref), workspace_CurrentCamera (ref)
        if not u129:IsDescendantOf(game) then
            u130:Disconnect();
        end;

        u129.CFrame = workspace_CurrentCamera.CFrame;
    end);

    for _, child in u125:GetChildren() do
        child.Enabled = true;
    end;

    task.delay(1.45, function() -- Line: 1847
        -- upvalues: u126 (copy), u130 (ref), u125 (copy), mainreplication2 (ref), BodyPosition (copy)
        for _, v in u126 do
            v:Destroy();
        end;

        u130:Disconnect();
        u125:Destroy();
        mainreplication2.sceneEnabled(false);
        BodyPosition:Destroy();
    end);
end;

function u1.metaBurstPointDeflect(p131: userdata) -- Line: 1858
    -- upvalues: mainreplication2 (copy)
    local HumanoidRootPart = p131:FindFirstChild("HumanoidRootPart");
    mainreplication2.bodyVelocity(HumanoidRootPart, -60, 0.75, nil, nil, nil, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0), 0.5);
end;

function u1.luckyisagiflow(u132, p133, p134) -- Line: 1864
    -- upvalues: Lighting (copy), mainreplication2 (copy), ReplicatedStorage (copy), soundUtil (copy), trove (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), PlayerGui (copy), TweenService (copy), animationUtil (copy), workspace_CurrentCamera (copy), TekrinnDialogue (copy), Brightness (ref)
    local v135 = u132.HumanoidRootPart or u132.PrimaryPart;
    local _ = u132.Torso;
    local _ = Lighting.Atmosphere;
    local u136 = {
        Isagi_Eye_Glow = true,
        Isagi_Hand_FX = true
    };
    mainreplication2.sceneEnabled(true);
    mainreplication2.ultFlash(-1);
    local v137 = soundUtil:play(ReplicatedStorage.Resources.nelisagi["isagi 1 percent flow sfx"], "default", {
        Character = u132
    });
    local v138 = v137.Name == "Dub";
    Lighting.Brightness = 2;
    local u139 = trove.new();
    u139:AttachToInstance(u132);
    Util.flowCancel(u139, p134, { v137 });
    local u140 = u139:Clone(ReplicatedStorage.Resources.nelisagi["1%AllEff"]);
    u140:PivotTo(v135.CFrame);
    u140.Parent = workspace;

    if Util.canshiftcolor(LocalPlayer, u132) then
        vfxUtil.LeanTowardsColor(u140, u132:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u132:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in pairs(u140:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local v141 = u139:Clone(ReplicatedStorage.Resources.glowscreen);
    v141.Parent = PlayerGui;
    v141.ImageLabel2.ImageTransparency = 0;
    v141.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    local u142 = u139:Clone(ReplicatedStorage.Resources.DepthOfField);
    u142.Parent = Lighting;
    u142.FarIntensity = 0;
    TweenService:Create(u142, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    animationUtil:loadAnimation(u140["Metavision Eye"], ReplicatedStorage.Resources.nelisagi["1%eye"]):Play(0);
    animationUtil:loadAnimation(u140.JJ, ReplicatedStorage.Resources.nelisagi["1%JJ"]):Play(0);
    u139:Add((mainreplication2.cutsceneBlender(v135, ReplicatedStorage.Resources.nelisagi["1%cam"], ReplicatedStorage.Resources.nelisagi["1%FOV"])));
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    u139:Add(ColorCorrectionEffect);
    local u143 = {};
    local u144 = {};
    local u145 = {};

    for _, child in workspace_CurrentCamera:GetChildren() do
        if child:IsA("Attachment") then
            table.insert(u143, child);
        end;
    end;

    local v146 = {
        [2.841] = {
            {
                {
                    Text = "How stupid am I?!",
                    Bold = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(93, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            2.2
        },
        [4.977] = {
            {
                {
                    Text = "Seeing it, then ",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "thinking ",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(1, 0, 81)), ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 0, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "it over, is ",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "too slow!",
                    Bold = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(93, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            4
        },
        [8.274] = {
            {
                {
                    Text = "Don\'t think with your head..",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            2.5
        },
        [12.323] = {
            {
                {
                    Text = "Just ",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "sense ",
                    Bold = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 0, 255)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "it and move.",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            4
        },
        [14.781] = {
            {
                {
                    Text = "Believe..",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            1
        },
        [17.234] = {
            {
                {
                    Text = "All of my ",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "abilities.",
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 94, 141)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            1.5
        },
        [20.531] = {
            {
                {
                    Text = "All of my ",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "nerve fibers!",
                    Bold = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(99, 66, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            5
        }
    };
    local v147 = {
        [0.79] = {
            {
                {
                    Text = "STOP IT!",
                    Bold = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(93, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            2
        },
        [2.75] = {
            {
                {
                    Text = "How stupid am I?!",
                    Bold = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(93, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            1.9
        },
        [4.9] = {
            {
                {
                    Text = "Envisioning a play and overthinking it is ",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "too slow!",
                    Bold = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(93, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            3.7
        },
        [8.65] = {
            {
                {
                    Text = "That thought patterns outdated..",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            2.5
        },
        [12.35] = {
            {
                {
                    Text = "Just ",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "sense ",
                    Bold = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 0, 255)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "it and move!",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            2
        },
        [14.95] = {
            {
                {
                    Text = "Trust in my abilities!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 94, 141)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            2.6
        },
        [17.117] = {
            {
                {
                    Text = "All of my ",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "nerve fibres..",
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(99, 66, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            2.8
        },
        [20.183] = {
            {
                {
                    Text = "All of my ",
                    Bold = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                },
                {
                    Text = "senses!",
                    Bold = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(99, 66, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            },
            5
        }
    };

    if v138 then
        v146 = v147 or v146;
    end;

    for i, v in v146 do
        u139:Add(task.delay(i, function() -- Line: 2278
            -- upvalues: u139 (copy), TekrinnDialogue (ref), u132 (copy), v (copy)
            u139:Add(TekrinnDialogue.Speak(u132, v[1], v[2]));
        end));
    end;

    u139:Add(task.delay(1.65, function() -- Line: 2283
        -- upvalues: u140 (copy)
        for _, descendant in pairs(u140.Fx.JigsawFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 2287
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end);
            elseif descendant:IsA("Beam") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u139:Add(task.delay(3.4833333333333334, function() -- Line: 2296
        -- upvalues: u143 (copy), ReplicatedStorage (ref), u140 (copy)
        for _, v in u143 do
            v.Parent = ReplicatedStorage;
        end;

        for _, descendant in pairs(u140.Fx.JustSmokeFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u139:Add(task.delay(5.4, function() -- Line: 2307
        -- upvalues: u140 (copy)
        for _, descendant in pairs(u140.Fx.JigsawFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 2311
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end);
            elseif descendant:IsA("Beam") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end));
    task.delay(8.233333333333333, function() -- Line: 2319
        -- upvalues: u140 (copy)
        for _, descendant in pairs(u140.Fx.JustSmokeFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u140.Fx.LightFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u139:Add(task.delay(9.5, function() -- Line: 2334
        -- upvalues: u142 (copy), Lighting (ref), u144 (copy), u140 (copy), u132 (copy), u136 (copy)
        u142.Enabled = false;
        Lighting.Bloom.Enabled = false;

        for _, descendant in ipairs(workspace.map.map:GetDescendants()) do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                u144[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;

        u140.Fx.Box.Transparency = 0;

        for _, descendant in pairs(u132:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and u136[descendant.Name] then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u140.Fx.LightFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u140.Fx.BGBEAMS:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u139:Add(task.delay(13.433333333333334, function() -- Line: 2367
        -- upvalues: u140 (copy), u132 (copy), u136 (copy)
        u140.Fx.Box1.Transparency = 0;

        for _, descendant in pairs(u132:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and u136[descendant.Name] then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u140.Fx.BGBEAMS:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u140.Fx.EyeFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u140.Fx.EyeFx:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u139:Add(task.delay(13.583333333333334, function() -- Line: 2398
        -- upvalues: u140 (copy)
        for _, descendant in pairs(u140.Fx.BGBEAMS:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u139:Add(task.delay(14.816666666666666, function() -- Line: 2406
        -- upvalues: u140 (copy)
        for _, descendant in pairs(u140.Fx.JustSmokeFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u140.Fx.MiniJigsawFx:GetDescendants()) do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u139:Add(task.delay(16.366666666666667, function() -- Line: 2421
        -- upvalues: u145 (copy), u140 (copy)
        for i, v in u145 do
            i.Transparency = v;
        end;

        table.clear(u145);

        for _, descendant in pairs(u140.Fx.MiniJigsawFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 2429
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end);
            elseif descendant:IsA("Beam") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u139:Add(task.delay(16.883333333333333, function() -- Line: 2437
        -- upvalues: u140 (copy)
        for _, descendant in pairs(u140.Fx.EyeFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u140.Fx.EyeFx:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u139:Add(task.delay(19.066666666666666, function() -- Line: 2452
        -- upvalues: u140 (copy), u143 (copy), workspace_CurrentCamera (ref), u142 (copy), Lighting (ref), u144 (copy)
        u140.Fx.Box.Transparency = 1;
        u140.Fx.Box1.Transparency = 1;

        for _, v in u143 do
            v.Parent = workspace_CurrentCamera;
        end;

        u142.Enabled = true;
        Lighting.Bloom.Enabled = true;

        for i, v in u144 do
            i.Transparency = v;
        end;

        table.clear(u144);

        for _, descendant in pairs(u140.Fx.BGBEAMS.Part:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u140.Fx.JIGFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 2476
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end);
            elseif descendant:IsA("Beam") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u140.Fx.JIGFx:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u140.Fx.JIGFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u139:Add(task.delay(19.066666666666666, function() -- Line: 2498
        -- upvalues: u140 (copy)
        for _, descendant in pairs(u140.Fx.MiniJigsawFx:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u140.Fx.MiniJigsawFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u139:Add(task.delay(21.866666666666667, function() -- Line: 2513
        -- upvalues: u140 (copy)
        for _, descendant in pairs(u140.Fx.JIGFx:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u140.Fx.JIGFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u139:Add(function() -- Line: 2528
        -- upvalues: u144 (copy), Lighting (ref), mainreplication2 (ref), Brightness (ref)
        for i, v in u144 do
            i.Transparency = v;
        end;

        table.clear(u144);
        Lighting.Bloom.Enabled = true;
        mainreplication2.sceneEnabled(false);
        mainreplication2.ultFlash(1, 1.5);
        Lighting.Brightness = Brightness;
    end);
    u139:Add(task.delay(p133, function() -- Line: 2543
        -- upvalues: u139 (copy)
        u139:Destroy();
    end));
    task.spawn(function() -- Line: 2547
        -- upvalues: u140 (copy), u145 (copy)
        for _, descendant in pairs(u140.Fx.TestRBGFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 2551
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end);
            elseif descendant:IsA("Beam") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u140.JJ:GetDescendants()) do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                u145[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;
    end);
end;

function u1.OvertimeNELSagi(u148) -- Line: 2568
    -- upvalues: trove (copy), mainreplication2 (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), PlayerGui (copy), Lighting (copy), TekrinnDialogue (copy), Brightness (ref), Ambient (copy), ExposureCompensation (ref), ClockTime (copy), Welder (copy), animationUtil (copy), Util (copy), TweenService (copy)
    local u149 = u148.HumanoidRootPart or u148.PrimaryPart;
    local u150 = trove.new();
    u150:AttachToInstance(u148);
    local u151 = mainreplication2.cutscene(u149, CFrame.new(), 8.883333333333333, ReplicatedStorage.Resources.nelisagi.FOV_Overtime);
    mainreplication2.sceneEnabled(true);
    soundUtil:play(ReplicatedStorage.Resources.nelisagi["Isagi overtime sfx"], SoundService);
    local v152 = ReplicatedStorage.Resources.vb:Clone();
    v152.Parent = PlayerGui;
    u150:Add(v152);
    local v153 = ReplicatedStorage.Resources.glowscreen:Clone();
    v153.Parent = PlayerGui;
    v153.ImageLabel2.ImageTransparency = 0.7;
    v153.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    u150:Add(v153);
    local v154 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v154.Parent = Lighting;
    v154.FarIntensity = 1;
    u150:Add(v154);
    TekrinnDialogue.Speak(u148, {
        {
            Text = "I\'ve found the new pieces I need..",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 1,
                Lifetime = 1
            }
        }
    }, 2.5);
    u150:Add(task.delay(2, function() -- Line: 2622
        -- upvalues: TekrinnDialogue (ref), u148 (copy)
        TekrinnDialogue.Speak(u148, {
            {
                Text = "Blind Spot..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = " Off the ball..!!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 50
                }
            }
        }, 4);
    end));
    u150:Add(task.delay(4.4, function() -- Line: 2669
        -- upvalues: TekrinnDialogue (ref), u148 (copy)
        TekrinnDialogue.Speak(u148, {
            {
                Text = "I\'ll overwrite my ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "concept ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 50
                }
            },
            {
                Text = "of soccer!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 4);
    end));
    u150:Add(task.delay(6.9, function() -- Line: 2737
        -- upvalues: TekrinnDialogue (ref), u148 (copy)
        TekrinnDialogue.Speak(u148, {
            {
                Text = "I\'ll be reborn ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "again ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 50
                }
            },
            {
                Text = "and ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "again!",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 5
                }
            }
        }, 2);
    end));
    u150:Add(function() -- Line: 2826
        -- upvalues: u151 (copy), Lighting (ref), Brightness (ref), Ambient (ref), ExposureCompensation (ref), ClockTime (ref), mainreplication2 (ref)
        if u151 then
            u151:Destroy();
        end;

        Lighting.Brightness = Brightness;
        Lighting.Ambient = Ambient;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.ClockTime = ClockTime;
        Lighting.GeographicLatitude = 23;
        mainreplication2.ultFlash(2, 0.3);
        mainreplication2.sceneEnabled(false);
    end);

    local function syncedDelay(p155: number, p156: function) -- Line: 2840
        -- upvalues: u150 (copy)
        return u150:Add(task.delay(math.max(0, p155 / 60), p156));
    end;

    local u157 = u150:Clone(ReplicatedStorage.Resources.nelisagi.AwkOvertime.OvertimeCC);
    u157.Parent = Lighting;
    Lighting.Brightness = 2;
    Lighting.Ambient = Color3.fromRGB(187, 205, 217);
    Lighting.ExposureCompensation = 1.5;
    Lighting.ClockTime = 3.92;
    Lighting.GeographicLatitude = -61.413;
    local u158 = u150:Clone(ReplicatedStorage.Resources.nelisagi.AwkOvertime.Tunnel);
    local u159 = u150:Clone(ReplicatedStorage.Resources.nelisagi.AwkOvertime.BeamPierces);
    local u160 = u150:Clone(ReplicatedStorage.Resources.nelisagi.AwkOvertime.Steps);
    local v161 = u150:Clone(ReplicatedStorage.Resources.nelisagi.AwkOvertime.STUDIOPIECES);
    local u162 = u150:Clone(ReplicatedStorage.Resources.nelisagi.AwkOvertime.FacePuzzles);
    local u163 = u150:Clone(ReplicatedStorage.Resources.nelisagi.AwkOvertime.BeforeTransition);
    local v164 = u150:Clone(ReplicatedStorage.Resources.nelisagi.AwkOvertime.StartingTransition);
    local u165 = u150:Clone(ReplicatedStorage.Resources.nelisagi.AwkOvertime.TunnelPuzzles);
    local u166 = u150:Clone(ReplicatedStorage.Resources.nelisagi.AwkOvertime.MetaVis);
    v161.Parent = u148;
    u159.Parent = u149;
    u160.Parent = u149;
    u162.Parent = u149;
    u163.Parent = u149;
    v164.Parent = u149;
    u165.Parent = u149;
    u166.Parent = u148.Head;
    Welder:Motor6D(u149, v161.RootPart, CFrame.new(-0.064, -2.5, 5.194), CFrame.new(), "RootPart", v161.RootPart);
    animationUtil:loadAnimation(u148, ReplicatedStorage.Resources.nelisagi.AwkOvertime.PuzzleOverTime):Play();

    for _, child in ReplicatedStorage.Resources.nelisagi.AwkOvertime.Beams.BeamModels:GetChildren() do
        u150:Clone(child).Parent = u148;
    end;

    for _, child in ReplicatedStorage.Resources.nelisagi.AwkOvertime.Beams.BeamWelds:GetChildren() do
        local v167 = u150:Clone(child);
        v167.Part1 = u148:FindFirstChild(child.Name);
        v167.Part0 = u149;
        v167.Parent = u149;
    end;

    task.spawn(function() -- Line: 2890
        -- upvalues: Util (ref), ReplicatedStorage (ref), u151 (copy)
        Util.CameraEffect(ReplicatedStorage.Resources.nelisagi.AwkOvertime.Camera, u151);
    end);
    u150:Add(task.delay(1.0833333333333333, function() -- Line: 2894
        -- upvalues: TweenService (ref), u157 (copy), u158 (copy), u149 (copy), mainreplication2 (ref)
        TweenService:Create(u157, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Saturation = 0
        }):Play();
        u158.Parent = workspace.Effects;
        u158:PivotTo(u149.CFrame);
        mainreplication2.ultFlash(1, 0.6);
    end));
    u150:Add(task.delay(0, function() -- Line: 2903
        -- upvalues: u160 (copy)
        for _, descendant in pairs(u160.Step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u150:Add(task.delay(0.3, function() -- Line: 2911
        -- upvalues: u160 (copy)
        for _, descendant in pairs(u160.Step2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u150:Add(task.delay(0.5, function() -- Line: 2921
        -- upvalues: u160 (copy)
        for _, descendant in pairs(u160.Step3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u150:Add(task.delay(1.0666666666666667, function() -- Line: 2929
        -- upvalues: u165 (copy)
        for _, descendant in pairs(u165:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u150:Add(task.delay(2.3, function() -- Line: 2937
        -- upvalues: u159 (copy)
        for _, descendant in pairs(u159.One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u150:Add(task.delay(2.783333333333333, function() -- Line: 2945
        -- upvalues: u159 (copy)
        for _, descendant in pairs(u159.Two:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u150:Add(task.delay(3.3333333333333335, function() -- Line: 2953
        -- upvalues: u159 (copy)
        for _, descendant in pairs(u159.Three:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u150:Add(task.delay(3.933333333333333, function() -- Line: 2961
        -- upvalues: u159 (copy)
        for _, descendant in pairs(u159.Four:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u150:Add(task.delay(4.65, function() -- Line: 2969
        -- upvalues: u159 (copy)
        for _, descendant in pairs(u159.Five:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u150:Add(task.delay(5.233333333333333, function() -- Line: 2977
        -- upvalues: u165 (copy)
        for _, descendant in pairs(u165:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u165:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u150:Add(task.delay(5.9, function() -- Line: 2990
        -- upvalues: mainreplication2 (ref), u151 (copy), u163 (copy)
        mainreplication2.ultFlash(1, 0.7);

        for _, descendant in pairs(u151.Transition:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u163:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u150:Add(task.delay(6.2, function() -- Line: 3004
        -- upvalues: u162 (copy), u166 (copy)
        for _, descendant in pairs(u162:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u166:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u166:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u150:Add(task.delay(8.3, function() -- Line: 3022
        -- upvalues: u162 (copy)
        for _, descendant in pairs(u162:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u150:Add(task.delay(8.5, function() -- Line: 3030
        -- upvalues: u151 (copy)
        for _, descendant in pairs(u151.TransitionEnd:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u150:Add(task.delay(8.866666666666667, function() -- Line: 3038
        -- upvalues: u166 (copy)
        for _, descendant in pairs(u166:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u166:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u150:Add(task.delay(6.183333333333334, function() -- Line: 3051
    end));
    u150:Add(task.delay(8.883333333333333, function() -- Line: 3055
        -- upvalues: u158 (copy), u150 (copy)
        u158:Destroy();
        u150:Destroy();
    end));
end;

function u1.nelcounterstart(u168) -- Line: 3061
    -- upvalues: ReplicatedStorage (copy), mainreplication2 (copy)
    local v169 = u168.HumanoidRootPart or u168.PrimaryPart;
    local u170 = ReplicatedStorage.Resources.nelisagi.CounterAssets.counterstartup:Clone();
    u170.Weld.Part0 = v169;
    u170.Parent = u168;
    task.delay(2, function() -- Line: 3067
        -- upvalues: u170 (copy)
        u170:Destroy();
    end);
    local u171 = {};
    mainreplication2.cameraShake(35, 1.5, 6);
    task.spawn(function() -- Line: 3073
        -- upvalues: u168 (copy), ReplicatedStorage (ref), u171 (copy)
        for _, descendant in ipairs(u168:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v172 = descendant;

                for _, descendant2 in ipairs(ReplicatedStorage.Resources.nelisagi.twogunvfx.vfx.vfx.bodyaura.Torso:GetDescendants()) do
                    local v173 = descendant2:Clone();
                    v173.Parent = v172;
                    table.insert(u171, v173);
                end;
            end;
        end;
    end);
    task.delay(0.05, function() -- Line: 3086
        -- upvalues: u170 (copy), u171 (copy)
        for _, descendant in pairs(u170.v1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, v in u171 do
            v.Enabled = true;
        end;
    end);
    task.delay(0.75, function() -- Line: 3097
        -- upvalues: u171 (copy)
        for _, v in u171 do
            v.Enabled = false;
        end;
    end);
    task.delay(2, function() -- Line: 3102
        -- upvalues: u171 (copy)
        for _, v in u171 do
            v:Destroy();
        end;
    end);
end;

function u1.nelisaiLeftyShot(u174: userdata) -- Line: 3109
    -- upvalues: ReplicatedStorage (copy), trove (copy), u1 (copy), soundUtil (copy), SoundService (copy), mainreplication2 (copy), TekrinnDialogue (copy), Lighting (copy), TweenService (copy), Util (copy)
    local LeftyShot = ReplicatedStorage.Resources.nelisagi.LeftyShot;
    local HumanoidRootPart = u174:FindFirstChild("HumanoidRootPart");
    local u175 = trove.new();
    u175:AttachToInstance(u174);
    local u176 = u1.cutscene(HumanoidRootPart, nil, 11.1, ReplicatedStorage.Resources.nelisagi.FOV_Lefty);
    local u177 = soundUtil:play(LeftyShot.leftyshoot, SoundService, {
        Character = u174
    }).Name == "Dub";
    mainreplication2.sceneEnabled(true);
    u175:Add(task.delay(11.033333333333333, function() -- Line: 3124
        -- upvalues: u175 (copy)
        u175:Destroy();
    end));

    local function _(p178: number, p179: function) -- Line: 3128
        -- upvalues: u175 (copy)
        return u175:Add(task.delay(math.max(0, p178 / 60), p179));
    end;

    u175:Add(function() -- Line: 3132
        -- upvalues: u176 (copy), mainreplication2 (ref)
        if u176 then
            u176:Destroy();
        end;

        mainreplication2.sceneEnabled(false);
        mainreplication2.ultFlash(3, 0.7);
    end);
    local v180 = u175:Clone(LeftyShot.STUDIOPIECES);
    local v181 = u175:Add(v180.RootPart.HumanoidRootPart);
    v181.Part0 = HumanoidRootPart;
    v181.Parent = HumanoidRootPart;
    v180.Parent = u174;

    local function setPuzzelTransparency(p182: number?) -- Line: 3149
    end;

    u175:Add(task.delay(1, function() -- Line: 3162
        -- upvalues: u177 (copy), TekrinnDialogue (ref), u174 (copy)
        if not u177 then
            return;
        end;

        TekrinnDialogue.Speak(u174, {
            {
                Text = "What? I lost my ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "balance?",
                Bold = false,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1.2);
    end));
    u175:Add(task.delay(3.3333333333333335, function() -- Line: 3210
        -- upvalues: u177 (copy), TekrinnDialogue (ref), u174 (copy)
        if not u177 then
            return;
        end;

        TekrinnDialogue.Speak(u174, {
            {
                Text = "NO, NOT YET!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 2
                }
            }
        }, 1.7);
    end));
    u175:Add(task.delay(4.316666666666666, function() -- Line: 3237
        -- upvalues: u177 (copy), TekrinnDialogue (ref), u174 (copy)
        if not u177 then
            return;
        end;

        TekrinnDialogue.Speak(u174, {
            {
                Text = "I won\'t let this ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "chance",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.045,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5
                }
            },
            {
                Text = "..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 3.4);
    end));
    u175:Add(task.delay(8.166666666666666, function() -- Line: 3306
        -- upvalues: u177 (copy), TekrinnDialogue (ref), u174 (copy)
        if not u177 then
            return;
        end;

        TekrinnDialogue.Speak(u174, {
            {
                Text = "GO TO WASTE!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            }
        }, 3);
    end));
    u175:Add(task.delay(1.25, function() -- Line: 3333
        -- upvalues: u177 (copy), TekrinnDialogue (ref), u174 (copy)
        if u177 then
            return;
        end;

        TekrinnDialogue.Speak(u174, {
            {
                Text = "Huh? Am I losing my balance?",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end));
    u175:Add(task.delay(2.75, function() -- Line: 3360
        -- upvalues: u177 (copy), TekrinnDialogue (ref), u174 (copy)
        if u177 then
            return;
        end;

        TekrinnDialogue.Speak(u174, {
            {
                Text = "NO, NOT YET!",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 5);
    end));
    u175:Add(task.delay(4.75, function() -- Line: 3387
        -- upvalues: u177 (copy), TekrinnDialogue (ref), u174 (copy)
        if u177 then
            return;
        end;

        TekrinnDialogue.Speak(u174, {
            {
                Text = " The moment isn\'t over!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 8);
    end));
    u175:Add(task.delay(7, function() -- Line: 3414
        -- upvalues: u177 (copy), TekrinnDialogue (ref), u174 (copy)
        if u177 then
            return;
        end;

        TekrinnDialogue.Speak(u174, {
            {
                Text = "My very...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 6);
    end));
    u175:Add(task.delay(9, function() -- Line: 3441
        -- upvalues: u177 (copy), TekrinnDialogue (ref), u174 (copy)
        if u177 then
            return;
        end;

        TekrinnDialogue.Speak(u174, {
            {
                Text = "LAST STEP!!!",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 4);
    end));
    u175:Add(task.delay(0.9, function() -- Line: 3468
        -- upvalues: mainreplication2 (ref), HumanoidRootPart (copy), LeftyShot (copy)
        mainreplication2.EmitAttachmentIn({
            AttachPart = HumanoidRootPart,
            Effect = LeftyShot.Bump,
            Offset = CFrame.new(
                1.43682861,
                -0.547015667,
                0.0830078125,
                1,
                0.0000174534107,
                -8.17357843e-22,
                9.84162287e-16,
                -5.63886715e-11,
                1,
                0.0000174531779,
                -1,
                5.63886715e-11
            )
        });
    end));
    u175:Add(task.delay(3.8833333333333333, function() -- Line: 3476
        -- upvalues: mainreplication2 (ref), HumanoidRootPart (copy), LeftyShot (copy)
        mainreplication2.EmitAttachmentIn({
            AttachPart = HumanoidRootPart,
            Effect = LeftyShot.Step1,
            Offset = CFrame.new(
                -6.99554443,
                -2.85801506,
                -13.7456055,
                1,
                -8.17357843e-22,
                -0.0000174534107,
                9.84162287e-16,
                1,
                5.63886715e-11,
                0.0000174531779,
                5.63886715e-11,
                1
            )
        });
    end));
    u175:Add(task.delay(4.333333333333333, function() -- Line: 3484
    end));
    u175:Add(task.delay(5.516666666666667, function() -- Line: 3488
        -- upvalues: mainreplication2 (ref), HumanoidRootPart (copy), LeftyShot (copy)
        mainreplication2.EmitAttachmentIn({
            AttachPart = HumanoidRootPart,
            Effect = LeftyShot.ew,
            Offset = CFrame.new(
                -2.45507812,
                4.07097435,
                0.171020508,
                1,
                -8.17357843e-22,
                -0.0000174534107,
                9.84162287e-16,
                1,
                5.63886715e-11,
                0.0000174531779,
                5.63886715e-11,
                1
            )
        });
    end));
    u175:Add(task.delay(7.75, function() -- Line: 3496
        -- upvalues: mainreplication2 (ref), HumanoidRootPart (copy), LeftyShot (copy)
        mainreplication2.EmitAttachmentIn({
            AttachPart = HumanoidRootPart,
            Effect = LeftyShot.T,
            Offset = CFrame.new(
                -4.37341309,
                1.72392178,
                -1.57836914,
                1,
                -8.17357843e-22,
                -0.0000174534107,
                9.84162287e-16,
                1,
                5.63886715e-11,
                0.0000174531779,
                5.63886715e-11,
                1
            )
        });
    end));
    u175:Add(task.delay(7.9, function() -- Line: 3504
        -- upvalues: u175 (copy), LeftyShot (copy), Lighting (ref), TweenService (ref)
        local v183 = u175:Clone(LeftyShot.INTROCC);
        v183.Parent = Lighting;
        TweenService:Create(v183, TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Saturation = -1
        }):Play();
        task.wait(0.21666666666666667);

        if v183 == nil then
            return;
        end;

        TweenService:Create(v183, TweenInfo.new(0.7333333333333333, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Saturation = 0
        }):Play();
    end));
    u175:Add(task.delay(7.916666666666667, function() -- Line: 3523
        -- upvalues: LeftyShot (copy), u175 (copy)
        for _, child in LeftyShot.CameraLinesThing:GetChildren() do
            local u184 = u175:Clone(child);
            u184.Enabled = true;
            task.delay(24, function() -- Line: 3528
                -- upvalues: u184 (copy)
                u184.Enabled = false;
            end);
        end;
    end));
    u175:Add(task.delay(8.183333333333334, function() -- Line: 3534
        -- upvalues: mainreplication2 (ref), HumanoidRootPart (copy), LeftyShot (copy)
        mainreplication2.EmitAttachmentIn({
            AttachPart = HumanoidRootPart,
            Effect = LeftyShot.Emit,
            Offset = CFrame.new(
                -1.96392822,
                -3.07161045,
                -1.1192627,
                1,
                -8.17357843e-22,
                -0.0000174534107,
                9.84162287e-16,
                1,
                5.63886715e-11,
                0.0000174531779,
                5.63886715e-11,
                1
            )
        });
    end));
    u175:Add(task.delay(10.083333333333334, function() -- Line: 3542
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.nelisagi.LeftyShot.Impact, 30);
    end));
    u175:Add(task.delay(10.65, function() -- Line: 3546
        -- upvalues: mainreplication2 (ref), HumanoidRootPart (copy), LeftyShot (copy)
        mainreplication2.EmitAttachmentIn({
            AttachPart = HumanoidRootPart,
            Effect = LeftyShot.Shot,
            Offset = CFrame.new(
                -1.95806885,
                -0.0000152587891,
                -1.66711426,
                0.976167202,
                -8.17357843e-22,
                -0.217019647,
                1.22374498e-11,
                1,
                5.50447708e-11,
                0.217019632,
                5.63886715e-11,
                0.976167202
            )
        });
    end));
end;

function u1.passIt(u185: userdata, u186: userdata) -- Line: 3555
    -- upvalues: ReplicatedStorage (copy), trove (copy), u1 (copy), SoundService (copy), mainreplication2 (copy), PlayerGui (copy), Lighting (copy), TweenService (copy), TekrinnDialogue (copy), CollectionService (copy)
    local PassItassets = ReplicatedStorage.Resources.nelisagi.PassItassets;
    local HumanoidRootPart = u185:FindFirstChild("HumanoidRootPart");
    local u187 = trove.new();
    u187:AttachToInstance(u185);

    local function _(p188: number, p189: function) -- Line: 3562
        -- upvalues: u187 (copy)
        return u187:Add(task.delay(math.max(0, p188 / 60), p189));
    end;

    local u190 = u1.cutscene(HumanoidRootPart, nil, 9.966666666666667, ReplicatedStorage.Resources.nelisagi.FOV_PassIt);
    SoundService:PlayLocalSound(ReplicatedStorage.Resources.nelisagi.passit);
    mainreplication2.sceneEnabled(true);
    local u191 = u187:Clone(PassItassets.VignetteUI);
    u191.Parent = PlayerGui;
    local u192 = u187:Clone(PassItassets.PassItCC);
    u192.Parent = Lighting;
    local u193 = u187:Clone(PassItassets.StartBeam);

    for _, descendant in u193:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    u193.Parent = HumanoidRootPart;
    local u194 = u187:Clone(PassItassets.Stare);

    for _, descendant in u194:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    u187:Add(task.delay(0.75, function() -- Line: 3596
        -- upvalues: mainreplication2 (ref), HumanoidRootPart (copy), PassItassets (copy)
        mainreplication2.EmitAttachmentIn({
            Parent = HumanoidRootPart,
            Effect = PassItassets.Step
        });
    end));
    u187:Add(task.delay(4.7, function() -- Line: 3603
        -- upvalues: TweenService (ref), u192 (copy)
        TweenService:Create(u192, TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Brightness = 0,
            Contrast = 0.1,
            Saturation = -0.1
        }):Play();
    end));
    u187:Add(task.delay(4.9, function() -- Line: 3611
        -- upvalues: u194 (copy), u185 (copy), u191 (copy), TweenService (ref), TekrinnDialogue (ref)
        u194.Parent = u185:FindFirstChild("Head");

        for _, child in u191:GetChildren() do
            TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ImageTransparency = 0
            }):Play();
        end;

        TekrinnDialogue.Speak(u185, {
            {
                Text = "Give me..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2.7);
    end));
    u187:Add(task.delay(4.966666666666667, function() -- Line: 3645
        -- upvalues: TweenService (ref), u192 (copy)
        TweenService:Create(u192, TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Brightness = -0.3,
            Contrast = 0.5,
            Saturation = -0.4
        }):Play();
    end));
    u187:Add(task.delay(5.15, function() -- Line: 3653
        -- upvalues: TweenService (ref), u192 (copy)
        TweenService:Create(u192, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Brightness = -0.1
        }):Play();
    end));
    u187:Add(task.delay(6.166666666666667, function() -- Line: 3659
        -- upvalues: TekrinnDialogue (ref), u185 (copy)
        TekrinnDialogue.Speak(u185, {
            {
                Text = "THE BALL.",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.025,
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)),
                    ColorSequenceKeypoint.new(0.15, Color3.fromRGB(0, 0, 0)),
                    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(61, 122, 255)),
                    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 0, 0)),
                    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0))
                }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2.7);
    end));
    u187:Add(task.delay(7.9, function() -- Line: 3690
        -- upvalues: u193 (copy), u194 (copy)
        for _, descendant in u193:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in u194:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u187:Add(task.delay(7.95, function() -- Line: 3704
        -- upvalues: PassItassets (copy), u190 (copy), u186 (copy)
        for _, child in PassItassets.cam:GetChildren() do
            local v195 = child:Clone();
            v195:AddTag("passitcameffect");
            v195.Parent = u190;
        end;

        for _, child in u186:GetChildren() do
            if not table.find({ "HumanoidRootPart" }, child.Name) then
                local v196 = child;

                for _, child2 in PassItassets.victimlines:GetChildren() do
                    local v197 = child2:Clone();
                    v197:AddTag("passitcameffect");
                    v197.Parent = v196;
                end;
            end;
        end;
    end));
    u187:Add(task.delay(8.983333333333333, function() -- Line: 3724
        -- upvalues: u191 (copy), CollectionService (ref)
        if u191 then
            u191:Destroy();
        end;

        for _, v in CollectionService:GetTagged("passitcameffect") do
            v:Destroy();
        end;
    end));
    u187:Add(task.delay(9.25, function() -- Line: 3734
        -- upvalues: mainreplication2 (ref), HumanoidRootPart (copy), PassItassets (copy)
        mainreplication2.EmitAttachmentIn({
            Parent = HumanoidRootPart,
            Effect = PassItassets.Pass
        });
    end));
    u187:Add(function() -- Line: 3741
        -- upvalues: u190 (copy), mainreplication2 (ref)
        if u190 then
            u190:Destroy();
        end;

        mainreplication2.sceneEnabled(false);
        mainreplication2.ultFlash(2, 0.75);
    end);
    u187:Add(task.delay(9.966666666666667, function() -- Line: 3750
        -- upvalues: u187 (copy)
        u187:Destroy();
    end));
end;

function u1.AwkOffBallNELIsagi(u198: userdata, p199: any, p200: any) -- Line: 3754
    -- upvalues: ReplicatedStorage (copy), trove (copy), u1 (copy), PlayerGui (copy), Lighting (copy), mainreplication2 (copy), soundUtil (copy), Util (copy), TekrinnDialogue (copy), animationUtil (copy), Welder (copy)
    local _ = ReplicatedStorage.Resources.nelisagi.AwkOffBall;
    local HumanoidRootPart = u198:FindFirstChild("HumanoidRootPart");
    local u201 = trove.new();
    u201:AttachToInstance(u198);
    local u202 = {};
    local u203, u204 = u1.cutsceneHumanoidCamera(HumanoidRootPart, ReplicatedStorage.Resources.nelisagi.OTBA_Cam, ReplicatedStorage.Resources.nelisagi.FOV_OffTheBall);

    if u203 then
        u203.Parent = workspace.Effects;
    end;

    local v205 = ReplicatedStorage.Resources.vb:Clone();
    v205.Parent = PlayerGui;
    u201:Add(v205);
    local v206 = ReplicatedStorage.Resources.glowscreen:Clone();
    v206.Parent = PlayerGui;
    v206.ImageLabel2.ImageTransparency = 0.4;
    v206.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    u201:Add(v206);
    local v207 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v207.Parent = Lighting;
    v207.FarIntensity = 1;
    u201:Add(v207);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Brightness = -0.05;
    ColorCorrectionEffect.Contrast = 0.15;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    u201:Add(ColorCorrectionEffect);
    mainreplication2.sceneEnabled(true);
    local u208 = u201:Clone(ReplicatedStorage.Resources.nelisagi.AwkOffBall.VFX);
    u208.Parent = workspace.Effects;
    u208.AtmosphericVFX.PuzzleSpin:PivotTo(HumanoidRootPart.CFrame * CFrame.new(1.166, 0.821, 1.621));
    u208.Meshes.GroundHit:PivotTo(HumanoidRootPart.CFrame * CFrame.new(188.414, 5.692, -301.889));
    u208.Meshes.SpinMesh:PivotTo(HumanoidRootPart.CFrame * CFrame.new(188.414, 6.259, -301.889));

    for _, child in u208:GetChildren() do
        if child and child:IsA("BasePart") then
            child.CFrame = HumanoidRootPart.CFrame * child.CFrame;
        end;
    end;

    local v209 = soundUtil:play(ReplicatedStorage.Resources.nelisagi["nelisagi awk off sfx"], "default", {
        Character = u198
    });
    Util.flowCancel(u201, p200, { v209 });
    local u210 = v209.Name == "Dub";
    u201:Add(task.delay(0.033, function() -- Line: 3813
        -- upvalues: u210 (copy), u201 (copy), TekrinnDialogue (ref), u198 (copy)
        if not u210 then
            return;
        end;

        u201:Add(TekrinnDialogue.Speak(u198, {
            {
                Text = "Losing\'s the same as ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "dying",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.045,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5
                }
            },
            {
                Text = ", and we aren\'t dead yet.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 3.5));
    end));
    u201:Add(task.delay(4, function() -- Line: 3882
        -- upvalues: u210 (copy), u201 (copy), TekrinnDialogue (ref), u198 (copy)
        if not u210 then
            return;
        end;

        u201:Add(TekrinnDialogue.Speak(u198, {
            {
                Text = "Nothing matters except being the ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "best in the world!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 3));
    end));
    u201:Add(task.delay(7.75, function() -- Line: 3930
        -- upvalues: u210 (copy), u201 (copy), TekrinnDialogue (ref), u198 (copy)
        if not u210 then
            return;
        end;

        u201:Add(TekrinnDialogue.Speak(u198, {
            {
                Text = "Not this time, ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "Genius",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.045,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5
                }
            },
            {
                Text = ". You wanted it, you ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "should\'ve been here!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 5));
    end));
    u201:Add(task.delay(0, function() -- Line: 4020
        -- upvalues: u210 (copy), u201 (copy), TekrinnDialogue (ref), u198 (copy)
        if u210 then
            return;
        end;

        u201:Add(TekrinnDialogue.Speak(u198, {
            {
                Text = "Losing ",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 10
                }
            },
            {
                Text = "is the same as ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            },
            {
                Text = "dying.",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 10
                }
            }
        }, 2.3));
    end));
    u201:Add(task.delay(1.8, function() -- Line: 4089
        -- upvalues: u210 (copy), u201 (copy), TekrinnDialogue (ref), u198 (copy)
        if u210 then
            return;
        end;

        u201:Add(TekrinnDialogue.Speak(u198, {
            {
                Text = "But we aren\'t dead yet.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 10
                }
            }
        }, 2.7));
    end));
    u201:Add(task.delay(4, function() -- Line: 4116
        -- upvalues: u210 (copy), u201 (copy), TekrinnDialogue (ref), u198 (copy)
        if u210 then
            return;
        end;

        u201:Add(TekrinnDialogue.Speak(u198, {
            {
                Text = "I want to be the ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 10
                }
            },
            {
                Text = "best",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.025,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 10
                }
            },
            {
                Text = " in the world.. Nothing else.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.025,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 10
                }
            }
        }, 2.7));
    end));
    u201:Add(task.delay(7.8, function() -- Line: 4185
        -- upvalues: u210 (copy), u201 (copy), TekrinnDialogue (ref), u198 (copy)
        if u210 then
            return;
        end;

        u201:Add(TekrinnDialogue.Speak(u198, {
            {
                Text = " Not this time,",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 10
                }
            },
            {
                Text = " Genius.",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 10
                }
            },
            {
                Text = " If you wanted it, you should\'ve been here!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 10
                }
            }
        }, 4));
    end));
    local u211 = u201:Clone(ReplicatedStorage.Resources.nelisagi.AwkOffBall.MetaBallVision);
    u211.Parent = workspace.Effects;
    u211:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.4, -1.974, 0));
    animationUtil:loadAnimation(u211, ReplicatedStorage.Resources.nelisagi.OTBA_Eye):Play();

    if u203 then
        for _, child in u201:Clone(ReplicatedStorage.Resources.nelisagi.AwkOffBall.CamVFX):GetChildren() do
            if child then
                local CFrame2 = child.CFrame;
                child.Anchored = false;
                child.Parent = u203.Torso;
                Welder:Weld(u203.Torso, child, CFrame2);
            end;
        end;
    end;

    local u212 = u201:Clone(ReplicatedStorage.Resources.nelisagi.AwkOffBall.Aura);
    u212.Parent = u198;

    for _, child in u212:GetChildren() do
        if child:IsA("BasePart") or child:IsA("MeshPart") then
            Welder:Weld(u198:FindFirstChild(child.Name), child, CFrame.new());
        end;
    end;

    if u203 then
        for _, descendant in pairs(u203.Torso.WindBeams.Beams1.A1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end;

    u201:Add(function() -- Line: 4288
        -- upvalues: u204 (copy), u202 (copy), mainreplication2 (ref)
        if u204 then
            u204();
        end;

        for i, v in pairs(u202) do
            if i and i:IsA("BasePart") then
                i.Transparency = v;
            end;
        end;

        mainreplication2.sceneEnabled(false);
        mainreplication2.ultFlash(2, 0.75);
    end);
    u201:Add(task.delay(0.11666666666666667, function() -- Line: 4301
        -- upvalues: u208 (copy), HumanoidRootPart (copy)
        u208.Step1.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.122, -2.966, 3.281);

        for _, descendant in pairs(u208.Step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;
    end));
    u201:Add(task.delay(0.38333333333333336, function() -- Line: 4311
        -- upvalues: u208 (copy), HumanoidRootPart (copy)
        u208.Step2.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.188, -2.964, 2.152);

        for _, descendant in pairs(u208.Step2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;
    end));
    u201:Add(task.delay(1.9, function() -- Line: 4321
        -- upvalues: u202 (copy), u208 (copy), HumanoidRootPart (copy)
        for _, descendant in ipairs(workspace.map.map:GetDescendants()) do
            if descendant:IsA("BasePart") then
                u202[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;

        u208.AtmosphericVFX.Domain:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0.006, -0));
        u208.AuralordEmitPls.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.53, -2.88, 1.987);

        for _, descendant in pairs(u208.AuralordEmitPls:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;
    end));
    u201:Add(task.delay(1.9166666666666667, function() -- Line: 4341
        -- upvalues: u212 (copy)
        for _, descendant in pairs(u212:GetDescendants()) do
            if descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("ParticleEmitter")) then
                descendant.Enabled = true;
            end;
        end;
    end));
    u201:Add(task.delay(2.0833333333333335, function() -- Line: 4349
        -- upvalues: u212 (copy)
        for _, descendant in pairs(u212.Ball.Enable:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));

    if u203 then
        u201:Add(task.delay(2.0833333333333335, function() -- Line: 4358
            -- upvalues: u203 (copy)
            for _, descendant in pairs(u203.Torso.IntenseLines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end));
    end;

    u201:Add(task.delay(5, function() -- Line: 4367
        -- upvalues: u208 (copy)
        for _, descendant in pairs(u208.EnableCircle:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;
    end));

    if u203 then
        u201:Add(task.delay(6.35, function() -- Line: 4377
            -- upvalues: u203 (copy)
            for _, descendant in pairs(u203.Torso.WindBeams.Beams1.FORATMOSPHEREBEAM:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end));
        u201:Add(task.delay(6.366666666666666, function() -- Line: 4385
            -- upvalues: u203 (copy)
            for _, descendant in pairs(u203.Torso.IntenseLines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(u203.Torso.Transition:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end));
    end;

    u201:Add(task.delay(7.816666666666666, function() -- Line: 4400
        -- upvalues: u208 (copy)
        for _, descendant in pairs(u208.AtmosphericVFX:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u201:Add(task.delay(7.9, function() -- Line: 4408
        -- upvalues: u208 (copy), u212 (copy), u211 (copy)
        for _, descendant in pairs(u208.AtmosphericVFX:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u212.Ball.Enable:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u211:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u201:Add(task.delay(7.916666666666667, function() -- Line: 4428
        -- upvalues: u203 (copy), u208 (copy)
        if u203 then
            for _, descendant in pairs(u203.Torso.IntenseLines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(u203.Torso.Transition:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end;

        for _, descendant in pairs(u208.Speedlines:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;
    end));
    u201:Add(task.delay(9.15, function() -- Line: 4451
        -- upvalues: u208 (copy)
        for _, descendant in pairs(u208.Spin1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;
    end));
    u201:Add(task.delay(9.883333333333333, function() -- Line: 4460
        -- upvalues: u208 (copy)
        for _, descendant in pairs(u208.Spin2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;
    end));
    u201:Add(task.delay(11.966666666666667, function() -- Line: 4469
        -- upvalues: u208 (copy), u203 (copy)
        for _, descendant in pairs(u208.EndAura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        if u203 then
            for _, descendant in pairs(u203.Torso.No1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(u203.Torso.No2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end));
    u201:Add(task.delay(14.016666666666667, function() -- Line: 4491
        -- upvalues: u201 (copy)
        u201:Destroy();
    end));
end;

local ClockTime2 = Lighting.ClockTime;
local u213 = nil;

function u1.allahOnTheBallFlow(u214: any, p215: number, p216: any) -- Line: 4499
    -- upvalues: vfxUtil (copy), mainreplication2 (copy), soundUtil (copy), trove (copy), Lighting (copy), Ambient (copy), Brightness (ref), ClockTime2 (copy), ExposureCompensation (ref), Util (copy), animationUtil (copy), MoonPropertyAnimator (copy), u213 (ref), TekrinnDialogue (copy)
    local nelisagi = vfxUtil.getResources().nelisagi;
    local Root = vfxUtil.getRoot(u214);
    local AwkOnTheBall = nelisagi.AwkOnTheBall;
    local main = workspace.map.map.sanam.main;
    local Ball = u214:FindFirstChild("Ball");
    local u217 = {};
    local u218 = false;

    local function updateTransparency() -- Line: 4511
        -- upvalues: main (copy), u218 (ref), u217 (copy)
        local Transparency = main.Transparency;

        if u218 then
            for i, v in u217 do
                i.Transparency = Transparency + v;
            end;

            return;
        end;

        for _, descendant in workspace.map:GetDescendants() do
            if descendant:IsA("BasePart") and (descendant ~= main and descendant.Transparency < 1) then
                local Transparency2 = descendant.Transparency;
                u217[descendant] = Transparency2;
                descendant.Transparency = Transparency + Transparency2;
            end;
        end;

        u218 = true;
    end;

    local u219 = main:GetPropertyChangedSignal("Transparency"):Connect(updateTransparency);
    mainreplication2.sceneEnabled(true);
    local v220 = soundUtil:play(AwkOnTheBall.SFX, soundUtil, {
        Character = u214
    });
    local u221 = v220.Name == "Dub";
    local u222 = trove.new();
    u222:Add(task.delay(13.4, function() -- Line: 4538
        -- upvalues: mainreplication2 (ref)
        mainreplication2.ultFlash(1);
    end));
    u222:Add(task.delay(p215, function() -- Line: 4541
        -- upvalues: u222 (copy)
        u222:Destroy();
    end));
    u222:Add(function() -- Line: 4544
        -- upvalues: main (copy), updateTransparency (copy), u219 (copy), Lighting (ref), Ambient (ref), Brightness (ref), ClockTime2 (ref), ExposureCompensation (ref), mainreplication2 (ref)
        main.Transparency = 0;
        updateTransparency();
        u219:Disconnect();
        Lighting.Ambient = Ambient;
        Lighting.Brightness = Brightness;
        Lighting.ClockTime = ClockTime2;
        Lighting.ExposureCompensation = ExposureCompensation;
        mainreplication2.sceneEnabled(false);
    end);
    Util.flowCancel(u222, p216, { v220 });

    if Ball then
        Ball.Size = Vector3.new(1.5, 1.5, 1.5);
        u222:Add(function() -- Line: 4559
            -- upvalues: Ball (copy)
            Ball.Size = Vector3.new(1.95, 1.95, 1.95);
        end);
    end;

    local v223 = u222:Add(mainreplication2.kuronaCam(Root, AwkOnTheBall.Cam, AwkOnTheBall.FOV));
    local v224 = u222:Add(vfxUtil.getMoonEffects());
    local v225 = u222:Clone(AwkOnTheBall.VFX);
    v225:PivotTo(Root.CFrame);
    v225.Parent = workspace.Effects;
    local v226 = u222:Clone(AwkOnTheBall["Metavision EyeBIG"]);
    v226.Parent = v225;
    v226:PivotTo(Root.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    animationUtil:loadAnimation(v226, AwkOnTheBall.Animations.Metavision):Play(0);
    local v227 = u222:Clone(AwkOnTheBall.CharacterFX);
    vfxUtil.setupAura(u214, v227, true);
    v227.Parent = v225;
    local v228 = u222:Clone(AwkOnTheBall.Luck);
    v228.Weld.Part0 = Root;
    v228.Parent = u214;
    local v229 = {
        Vignette = v224.Vignette,
        Workspace = v225,
        Baseplate = main,
        Lighting = Lighting
    };

    for _, child in AwkOnTheBall.Lighting:GetChildren() do
        local v230 = u222:Clone(child);
        v230.Parent = Lighting;
        v229[child.Name] = v230;
    end;

    Lighting.ExposureCompensation = 0;
    local v231 = u222:Construct(MoonPropertyAnimator);
    v231:LoadAndConvertSave(AwkOnTheBall.Moon, v229);
    v231:SetOriginalRoot(AwkOnTheBall.VFX.Root.CFrame);
    v231:SetRoot(Root);
    v231:PlayAll();

    if not u213 then
        u213 = require(AwkOnTheBall.Compiled);
    end;

    for _, v in u213 do
        u222:Add(task.delay(v[1] / 60, v[2], v227, v223, v225));
    end;

    task.delay(0.083, function() -- Line: 4607
        -- upvalues: u221 (copy), TekrinnDialogue (ref), u214 (copy)
        if not u221 then
            return;
        end;

        TekrinnDialogue.Speak(u214, {
            {
                Text = "With these eyes and my brain..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 1);
    end);
    task.delay(1.325, function() -- Line: 4634
        -- upvalues: u221 (copy), TekrinnDialogue (ref), u214 (copy)
        if not u221 then
            return;
        end;

        TekrinnDialogue.Speak(u214, {
            {
                Text = "I can foresee the future of the field.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 2.6);
    end);
    task.delay(4.85, function() -- Line: 4661
        -- upvalues: u221 (copy), TekrinnDialogue (ref), u214 (copy)
        if not u221 then
            return;
        end;

        TekrinnDialogue.Speak(u214, {
            {
                Text = "The territory that will make a goal possible!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 2.4);
    end);
    task.delay(7.083, function() -- Line: 4688
        -- upvalues: u221 (copy), TekrinnDialogue (ref), u214 (copy)
        if not u221 then
            return;
        end;

        TekrinnDialogue.Speak(u214, {
            {
                Text = "I can do this.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 0.9);
    end);
    task.delay(8.25, function() -- Line: 4715
        -- upvalues: u221 (copy), TekrinnDialogue (ref), u214 (copy)
        if not u221 then
            return;
        end;

        TekrinnDialogue.Speak(u214, {
            {
                Text = "I will!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5
                }
            }
        }, 1.6);
    end);
    task.delay(10.1, function() -- Line: 4742
        -- upvalues: u221 (copy), TekrinnDialogue (ref), u214 (copy)
        if not u221 then
            return;
        end;

        TekrinnDialogue.Speak(u214, {
            {
                Text = "I am..",
                Bold = false,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 0.9);
    end);
    task.delay(11.85, function() -- Line: 4769
        -- upvalues: u221 (copy), TekrinnDialogue (ref), u214 (copy)
        if not u221 then
            return;
        end;

        TekrinnDialogue.Speak(u214, {
            {
                Text = "A STRIKER!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            }
        }, 3);
    end);
    task.defer(function() -- Line: 4797
        -- upvalues: u221 (copy), u222 (copy), TekrinnDialogue (ref), u214 (copy)
        if u221 then
            return;
        end;

        u222:Add(TekrinnDialogue.Speak(u214, {
            {
                Text = "With these ",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            },
            {
                Text = "eyes",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            },
            {
                Text = " and my ",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            },
            {
                Text = "brain",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            },
            {
                Text = "..",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }), 3);
    end);
    u222:Add(task.delay(1.826, function() -- Line: 4863
        -- upvalues: u221 (copy), u222 (copy), TekrinnDialogue (ref), u214 (copy)
        if u221 then
            return;
        end;

        u222:Add(TekrinnDialogue.Speak(u214, {
            {
                Text = "I can foresee the ",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            },
            {
                Text = "future",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 3
                }
            },
            {
                Text = " of this field.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }), 4);
    end));
    u222:Add(task.delay(4.733, function() -- Line: 4906
        -- upvalues: u221 (copy), u222 (copy), TekrinnDialogue (ref), u214 (copy)
        if u221 then
            return;
        end;

        u222:Add(TekrinnDialogue.Speak(u214, {
            {
                Text = "That\'s the territory that\'ll make my ",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            },
            {
                Text = "goal",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            },
            {
                Text = " possible!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }), 3);
    end));
    u222:Add(task.delay(6.996, function() -- Line: 4949
        -- upvalues: u221 (copy), u222 (copy), TekrinnDialogue (ref), u214 (copy)
        if u221 then
            return;
        end;

        u222:Add(TekrinnDialogue.Speak(u214, {
            {
                Text = "I can ",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            },
            {
                Text = "see",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            },
            {
                Text = " it.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }), 3);
    end));
    u222:Add(task.delay(8.048, function() -- Line: 4992
        -- upvalues: u221 (copy), u222 (copy), TekrinnDialogue (ref), u214 (copy)
        if u221 then
            return;
        end;

        u222:Add(TekrinnDialogue.Speak(u214, {
            {
                Text = "I can ",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            },
            {
                Text = "feel",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            },
            {
                Text = " it.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }), 3);
    end));
    u222:Add(task.delay(9.735, function() -- Line: 5035
        -- upvalues: u221 (copy), u222 (copy), TekrinnDialogue (ref), u214 (copy)
        if u221 then
            return;
        end;

        u222:Add(TekrinnDialogue.Speak(u214, {
            {
                Text = "I will use this power to score..",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }), 4);
    end));
    u222:Add(task.delay(11.739, function() -- Line: 5053
        -- upvalues: u221 (copy), u222 (copy), TekrinnDialogue (ref), u214 (copy)
        if u221 then
            return;
        end;

        u222:Add(TekrinnDialogue.Speak(u214, {
            {
                Text = ".. my goal!",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            }
        }), 1.1219999999999999);
    end));
end;

local OutdoorAmbient = Lighting.OutdoorAmbient;

function u1.peterTingle(p232: boolean) -- Line: 5084
    -- upvalues: vfxUtil (copy), actionUtil (copy), soundUtil (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), Ambient (copy), OutdoorAmbient (copy), ExposureCompensation (ref), ClockTime2 (copy), RunService (copy), trove (copy), Players (copy), mainreplication2 (copy)
    local nelisagi = vfxUtil.getResources().nelisagi;
    local workspace2 = actionUtil.getworkspace();
    local SuperSenses = nelisagi.SuperSenses;
    local v233 = workspace.Effects:FindFirstChild("SUPER METAVISION™");

    if v233 then
        v233:Destroy();
    end;

    if p232 then
        soundUtil:play(SuperSenses.Cast, soundUtil);
        local Character = LocalPlayer.Character;
        local TweenInfo_new_ret = TweenInfo.new(1);
        local Color3_new_ret = Color3.new(0, 0, 1);
        local Color3_new_ret2 = Color3.new(0, 0, 0.15);
        local v234 = SuperSenses:WaitForChild(actionUtil.checkteam(Character)):Clone();
        v234.Name = "SUPER METAVISION™";
        v234.Parent = workspace.Effects;
        local Design = v234.Design;
        local SecondBeam = Design.isagimetavisiongrid.SecondBeam;
        local Puzzles = Design.Puzzles;
        local u235 = {};

        for _, descendant in v234:GetDescendants() do
            if descendant:IsA("BasePart") and descendant.Name == "Piece3" then
                table.insert(u235, descendant);
            end;
        end;

        local u236 = nil;
        local u237 = 0;
        local u238 = 0.6;

        local function u242(p239) -- Line: 5115
            -- upvalues: TweenService (ref), u237 (ref), TweenInfo_new_ret (copy), workspace2 (copy), u238 (ref), u236 (ref), SecondBeam (copy), Puzzles (copy), Lighting (ref), Color3_new_ret (copy), Ambient (ref), Color3_new_ret2 (copy), OutdoorAmbient (ref), ExposureCompensation (ref), ClockTime2 (ref)
            local v240 = p239 / 0.016666666666666666;
            local Value = TweenService:GetValue(math.clamp(u237 / TweenInfo_new_ret.Time, 0, 1), TweenInfo_new_ret.EasingStyle, TweenInfo_new_ret.EasingDirection);
            local v241;

            if workspace2.disabled.Value then
                v241 = 1;
            else
                local math_lerp_ret = math.lerp(u238, u236 and 0.5 or 1, 0.5 * v240);
                v241 = math.lerp(0.5, math_lerp_ret, Value);
            end;

            SecondBeam.Beam.Transparency = NumberSequence.new(v241);
            SecondBeam.black.Transparency = NumberSequence.new((math.lerp(0.6499999999999999, 1, v241)));

            for _, child in Puzzles:GetChildren() do
                child.Transparency = NumberSequence.new(v241);
            end;

            u238 = v241;
            Lighting.Ambient = Color3_new_ret:Lerp(Ambient, Value);
            Lighting.OutdoorAmbient = Color3_new_ret2:Lerp(OutdoorAmbient, Value);
            Lighting.ExposureCompensation = math.lerp(-1, ExposureCompensation, Value);
            Lighting.ClockTime = math.lerp(6, ClockTime2, Value);
        end;

        local u243 = nil;
        u243 = RunService.RenderStepped:Connect(function(p244) -- Line: 5135
            -- upvalues: u237 (ref), TweenInfo_new_ret (copy), u243 (ref), u242 (copy)
            if u237 > TweenInfo_new_ret.Time then
                u243:Disconnect();

                return;
            end;

            u237 = u237 + p244;
            u242(0);
        end);

        if v234:IsDescendantOf(workspace) then
            local metaMovement = Character.movements:FindFirstChild("metaMovement");
            local u245 = trove.new();
            u245:AttachToInstance(v234);
            local u246 = u245:Clone(SuperSenses.Attachment);
            u246.Parent = Character:FindFirstChild("Head");

            local function newMetapiece(p247) -- Line: 5150
                -- upvalues: Character (copy), Players (ref), u245 (copy), SuperSenses (copy), RunService (ref), workspace2 (copy)
                if p247 == Character then
                    return;
                end;

                if not (p247:FindFirstChild("state") and p247.state:FindFirstChild("camCF")) then
                    return;
                end;

                if not Players:GetPlayerFromCharacter(p247) then
                    return;
                end;

                local camCF = p247.state.camCF;
                local u248 = u245:Extend();
                u248:AttachToInstance(p247);
                u248:Add(function() -- Line: 5161
                    -- upvalues: u245 (ref), u248 (copy)
                    u245:Remove(u248);
                end);
                local u249 = u248:Clone(SuperSenses.Metapiece);
                u249.Parent = workspace.Effects;
                u248:Add(RunService.RenderStepped:Connect(function() -- Line: 5166
                    -- upvalues: workspace2 (ref), u249 (copy), camCF (copy)
                    local v250 = workspace2.disabled.Value or workspace2.checkgoal.Value;

                    if v250 and u249.Parent then
                        u249.Parent = nil;
                    elseif not v250 and u249.Parent ~= workspace.Effects then
                        u249.Parent = workspace.Effects;
                    end;

                    u249.CFrame = camCF.Value * CFrame.Angles(0.3490658503988659, 1.5707963267948966, 0);
                end));
            end;

            for _, child in workspace.characters:GetChildren() do
                task.spawn(newMetapiece, child);
            end;

            u245:Add(workspace.characters.ChildAdded:Connect(newMetapiece));
            u245:Add(RunService.RenderStepped:Connect(function(p251) -- Line: 5180
                -- upvalues: TweenService (ref), u237 (ref), TweenInfo_new_ret (copy), workspace2 (copy), u236 (ref), u246 (copy), metaMovement (copy), u235 (copy), Character (copy), u242 (copy)
                local v252 = p251 / 0.016666666666666666;
                local Value = TweenService:GetValue(math.clamp(u237 / TweenInfo_new_ret.Time, 0, 1), TweenInfo_new_ret.EasingStyle, TweenInfo_new_ret.EasingDirection);

                if workspace2.disabled.Value then
                    u236 = nil;

                    for _, child in u246:GetChildren() do
                        if child:IsA("ParticleEmitter") and child.Enabled then
                            child:Clear();
                            child.Enabled = false;
                        end;
                    end;

                    u246.Ambient:Pause();
                else
                    if metaMovement then
                        u236 = metaMovement:GetAttribute("nelTerritory");
                    end;

                    for _, child in u246:GetChildren() do
                        if child:IsA("ParticleEmitter") and not child.Enabled then
                            child.Enabled = true;
                        end;
                    end;

                    u246.Ambient:Resume();
                end;

                for _, v in u235 do
                    local v253 = ((Character:GetPivot().Position - v.Position).Magnitude - 20) / 55;
                    local math_clamp_ret = math.clamp(v253, 0, 1);
                    local v254 = u236 == v.Parent.Name;
                    local Transparency = v.Transparency;
                    local v255 = v254 and math.lerp(0.6, 1, math_clamp_ret) or 1;
                    local math_lerp_ret = math.lerp(Transparency, v255, 0.5 * v252);
                    v.Transparency = math.lerp(0.8, math_lerp_ret, Value);

                    for _, child in v.Rain:GetChildren() do
                        child.Enabled = not v254;
                    end;
                end;

                u242(p251);
            end));
        end;
    else
        soundUtil:play(SuperSenses.Decast, soundUtil);
    end;

    mainreplication2.ultFlash(0.5, 1, nil, Color3.new(0, 0, 1));
end;

local u256 = nil;

function u1.newNelTwoGunVolley(u257: any, u258: table) -- Line: 5230
    -- upvalues: vfxUtil (copy), mainreplication2 (copy), soundUtil (copy), SoundService (copy), trove (copy), Util (copy), u256 (ref), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local NewTwoGunVolley = vfxUtil.getResources().nelisagi.NewTwoGunVolley;
    local Root = vfxUtil.getRoot(u257);
    mainreplication2.sceneEnabled(true);
    local u259 = soundUtil:play(NewTwoGunVolley.SFX, SoundService, {
        Character = u257
    }).Name == "Dub";
    soundUtil:play(NewTwoGunVolley.BGM, soundUtil);
    local u260 = trove.new();
    u260:AttachToInstance(u257);
    u260:Add(function() -- Line: 5243
        -- upvalues: mainreplication2 (ref)
        mainreplication2.ultFlash(1);
        mainreplication2.sceneEnabled(false);
    end);
    u260:Add(task.delay(19, function() -- Line: 5247
        -- upvalues: u260 (copy)
        u260:Destroy();
    end));
    u260:Add(Util.Preload(NewTwoGunVolley.ImpactFrames.VolleyShot));
    u260:Add(task.delay(17.35, function() -- Line: 5252
        -- upvalues: Util (ref), NewTwoGunVolley (copy)
        Util.Gif(NewTwoGunVolley.ImpactFrames.VolleyShot, 24);
    end));
    u260:Add(Util.Preload(NewTwoGunVolley.ImpactFrames.Guns));
    u260:Add(task.delay(18.117, function() -- Line: 5257
        -- upvalues: Util (ref), NewTwoGunVolley (copy)
        Util.Gif(NewTwoGunVolley.ImpactFrames.Guns, 24);
    end));
    local v261 = u260:Clone(NewTwoGunVolley.VFX);
    v261:PivotTo(Root.CFrame);
    v261.Parent = workspace.Effects;
    vfxUtil.setupAura(u257, v261.CharacterFX, true);
    local v262 = u260:Add(mainreplication2.kuronaCam(Root, NewTwoGunVolley.Cam, NewTwoGunVolley.FOV));
    local v263 = {};

    for i = 1, 2 do
        local v264 = u260:Clone(NewTwoGunVolley[`Aura{i}`]);
        local v265 = u258[i];

        if v265 then
            vfxUtil.setupAura(v265, v264, true);
        end;

        v264.Parent = v261;
        table.insert(v263, v264);
        local _ = i;
    end;

    if not u256 then
        u256 = require(NewTwoGunVolley.Compiled);
    end;

    for _, v in ipairs(u256) do
        u260:Add(task.delay(v[1] / 60, v[2], v262, v263[1], v263[2], v261, v261.CharacterFX));
    end;

    local v266 = u260:Add(vfxUtil.getMoonEffects());
    local v267 = {
        Vignette = v266.Vignette,
        ["Screen Cover"] = v266["Screen Cover"],
        Workspace = v261,
        TuffCharacterRig = v261.CharacterFX
    };

    for _, child in NewTwoGunVolley.Lighting:GetChildren() do
        u260:Clone(child).Parent = Lighting;
        v267[child.Name] = child;
    end;

    local v268 = u260:Construct(MoonPropertyAnimator);
    v268:LoadAndConvertSave(NewTwoGunVolley.Moon, v267);
    v268:SetOriginalRoot(NewTwoGunVolley.VFX.CharacterFX.HumanoidRootPart.CFrame);
    v268:SetRoot(Root);
    v268:PlayAll();
    u260:Add(task.delay(0.117, function() -- Line: 5305
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if not u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "The answer to how I ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 4
                }
            },
            {
                Text = "evolve",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.045,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5
                }
            },
            {
                Text = " is buried somewhere inside of me!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 3.4));
    end));
    u260:Add(task.delay(3.85, function() -- Line: 5366
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if not u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "I must ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "refine my technique",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            },
            {
                Text = "..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 1.4));
    end));
    u260:Add(task.delay(5.517, function() -- Line: 5435
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if not u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "..and I have to do it before the ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "clock runs out!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 2.2));
    end));
    u260:Add(task.delay(8.067, function() -- Line: 5483
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if not u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "Do me a favour genius and ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "shut it!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 1.5
                }
            }
        }, 1.6));
    end));
    u260:Add(task.delay(10, function() -- Line: 5531
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u258 (copy)
        if not u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u258[1], {
            {
                Text = "I\'m going to ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "kill you",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.045,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 2
                }
            },
            {
                Text = " no matter what.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 2.7, ""));
    end));
    u260:Add(task.delay(12.95, function() -- Line: 5600
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if not u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "No..",
                Bold = false,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 0.9));
    end));
    u260:Add(task.delay(14, function() -- Line: 5627
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if not u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "NOT YET!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 2
                }
            }
        }, 1.4));
    end));
    u260:Add(task.delay(15.6, function() -- Line: 5654
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if not u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "POUR ALL OF IT INTO ",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            },
            {
                Text = "THIS MOMENT!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            }
        }, 5));
    end));
    u260:Add(task.delay(0.121, function() -- Line: 5702
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "I gotta think about what I can and can\'t do!",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 4
                }
            }
        }));
    end));
    u260:Add(task.delay(2.956, function() -- Line: 5721
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "How do I evolve my ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            },
            {
                Text = "weapon",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 3
                }
            },
            {
                Text = "...",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }));
    end));
    u260:Add(task.delay(4.636, function() -- Line: 5767
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = ".. in this ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            },
            {
                Text = "limited",
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 3
                }
            },
            {
                Text = " amount of time?!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }));
    end));
    u260:Add(task.delay(6.893, function() -- Line: 5813
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "The ones on the move...",
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }));
    end));
    u260:Add(task.delay(8.291, function() -- Line: 5833
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "I won\'t let them get it, even if it ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            },
            {
                Text = "kills",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            },
            {
                Text = " me!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }));
    end));
    u260:Add(task.delay(10.307, function() -- Line: 5879
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u258 (copy)
        if u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u258[1], {
            {
                Text = "I\'ll ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.2219999999999995
                }
            },
            {
                Text = "kill",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.2219999999999995
                }
            },
            {
                Text = " you, no matter what..",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.2219999999999995
                }
            }
        }, nil, ""));
    end));
    u260:Add(task.delay(12.967, function() -- Line: 5926
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "No..",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }));
    end));
    u260:Add(task.delay(14.052, function() -- Line: 5946
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "NOT YET!",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 4
                }
            }
        }));
    end));
    u260:Add(task.delay(16.347, function() -- Line: 5966
        -- upvalues: u259 (copy), u260 (copy), TekrinnDialogue (ref), u257 (copy)
        if u259 then
            return;
        end;

        u260:Add(TekrinnDialogue.Speak(u257, {
            {
                Text = "THE ",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            },
            {
                Text = "MOMENT",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            },
            {
                Text = " ISN\'T OVER!",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }));
    end));
end;

local u269 = nil;

function u1.NELisagiXhiori(u270, u271) -- Line: 6017
    -- upvalues: vfxUtil (copy), soundUtil (copy), SoundService (copy), mainreplication2 (copy), trove (copy), u269 (ref), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local xHiori = vfxUtil.getResources().nelisagi.xHiori;
    local Root = vfxUtil.getRoot(u270);
    local Ball = u270:WaitForChild("Ball");
    Ball.Size = Vector3.new(1.5, 1.5, 1.5);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local u272 = soundUtil:play(xHiori.SFX, SoundService, {
        Character = u270
    }).Name == "Dub";
    soundUtil:play(xHiori.BGM, soundUtil);
    mainreplication2.sceneEnabled(true);
    local u273 = trove.new();
    u273:AttachToInstance(u271);
    u273:Add(ScreenDimmer);
    u273:Add(function() -- Line: 6038
        -- upvalues: mainreplication2 (ref), Ball (copy)
        mainreplication2.sceneEnabled(false);
        mainreplication2.ultFlash(1, 2);
        Ball.Size = Vector3.new(1.95, 1.95, 1.95);
    end);
    u273:Add(task.delay(14.15, function() -- Line: 6043
        -- upvalues: u273 (copy)
        u273:Destroy();
    end));
    local v274 = u273:Clone(xHiori.CharacterFX);
    vfxUtil.setupAura(u270, v274, true);
    v274.Parent = workspace.Effects;
    local v275 = u273:Add(mainreplication2.kuronaCam(Root, xHiori.Cam, xHiori.FOV, nil, nil, "All"));

    if not u269 then
        u269 = require(xHiori.Compiled);
    end;

    for _, v in ipairs(u269) do
        u273:Add(task.delay(v[1] / 60, v[2], v274, v275));
    end;

    local v276 = {
        Vignette = u273:Add(vfxUtil.getMoonEffects()).Vignette,
        CutsceneVFX = v274.HumanoidRootPart.CutsceneVFX
    };

    for _, child in xHiori.Lighting:GetChildren() do
        local v277 = u273:Clone(child);
        v277.Parent = Lighting;
        v276[child.Name] = v277;
    end;

    local v278 = u273:Construct(MoonPropertyAnimator);
    v278:LoadAndConvertSave(xHiori.Moon, v276);
    v278:SetOriginalRoot(xHiori.CharacterFX.HumanoidRootPart.CFrame);
    v278:SetRoot(Root);
    v278:PlayAll();
    u273:Add(task.delay(0.017, function() -- Line: 6073
        -- upvalues: u272 (copy), u273 (copy), TekrinnDialogue (ref), u270 (copy)
        if not u272 then
            return;
        end;

        u273:Add(TekrinnDialogue.Speak(u270, {
            {
                Text = "Alright..",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.666667, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 1));
    end));
    u273:Add(task.delay(1.067, function() -- Line: 6087
        -- upvalues: u272 (copy), u273 (copy), TekrinnDialogue (ref), u270 (copy)
        if not u272 then
            return;
        end;

        u273:Add(TekrinnDialogue.Speak(u270, {
            {
                Text = "Here goes.",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.333333, 0.666667, 1)) })
            }
        }, 3));
    end));
    u273:Add(task.delay(1.317, function() -- Line: 6102
        -- upvalues: u272 (copy), u273 (copy), TekrinnDialogue (ref), u271 (copy)
        if not u272 then
            return;
        end;

        u273:Add(TekrinnDialogue.Speak(u271, {
            {
                Text = "Trust in my ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            },
            {
                Text = "abilities",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            },
            {
                Text = "!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }));
    end));
    u273:Add(task.delay(4.017, function() -- Line: 6148
        -- upvalues: u272 (copy), u273 (copy), TekrinnDialogue (ref), u271 (copy)
        if not u272 then
            return;
        end;

        u273:Add(TekrinnDialogue.Speak("???", {
            {
                TypeSpeed = 0.03,
                Text = `{u271.Name}?`,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }));
    end));
    u273:Add(task.delay(5.367, function() -- Line: 6167
        -- upvalues: u272 (copy), u273 (copy), TekrinnDialogue (ref), u271 (copy)
        if not u272 then
            return;
        end;

        u273:Add(TekrinnDialogue.Speak(u271, {
            {
                Text = "All of my ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5330000000000004
                }
            },
            {
                Text = "senses",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 1.5330000000000004
                }
            },
            {
                Text = "!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5330000000000004
                }
            }
        }));
    end));
    u273:Add(task.delay(0, function() -- Line: 6214
        -- upvalues: u272 (copy), u273 (copy), TekrinnDialogue (ref), u270 (copy)
        if u272 then
            return;
        end;

        u273:Add(TekrinnDialogue.Speak(u270, {
            {
                Text = "All righty.",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.666667, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 3));
    end));
    u273:Add(task.delay(0.898, function() -- Line: 6228
        -- upvalues: u272 (copy), u273 (copy), TekrinnDialogue (ref), u270 (copy)
        if u272 then
            return;
        end;

        u273:Add(TekrinnDialogue.Speak(u270, {
            {
                Text = "Shall we get going?",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.333333, 0.666667, 1)) })
            }
        }, 3));
    end));
    u273:Add(task.delay(2.106, function() -- Line: 6243
        -- upvalues: u272 (copy), u273 (copy), TekrinnDialogue (ref), u271 (copy)
        if u272 then
            return;
        end;

        u273:Add(TekrinnDialogue.Speak(u271, {
            {
                Text = "All of my ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            },
            {
                Text = "abilities",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            },
            {
                Text = "...",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }));
    end));
    u273:Add(task.delay(4.115, function() -- Line: 6289
        -- upvalues: u272 (copy), u273 (copy), TekrinnDialogue (ref), u271 (copy)
        if u272 then
            return;
        end;

        u273:Add(TekrinnDialogue.Speak("???", {
            {
                TypeSpeed = 0.03,
                Text = `{u271.Name}..?!`,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }));
    end));
    u273:Add(task.delay(5.9, function() -- Line: 6308
        -- upvalues: u272 (copy), u273 (copy), TekrinnDialogue (ref), u271 (copy)
        if u272 then
            return;
        end;

        u273:Add(TekrinnDialogue.Speak(u271, {
            {
                Text = "All of my ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.3899999999999997
                }
            },
            {
                Text = "nerve fibers",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 1.3899999999999997
                }
            },
            {
                Text = "!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.3899999999999997
                }
            }
        }));
    end));
end;

function u1.nothisisntwhatiwanted(u279: any, p280: number) -- Line: 6356
    -- upvalues: vfxUtil (copy), mainreplication2 (copy), RunService (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), Util (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(u279);

    if not Root then
        return;
    end;

    local Rebel = vfxUtil.getResources().nelisagi.Rebel;
    local u281 = vfxUtil.character_trove(u279);
    vfxUtil.buildFromRig(u279, Rebel.NewAZLBallRig, u281);
    local u282 = u281:Extend();
    local _baseplate_controller, u283 = vfxUtil.get_baseplate_controller();
    u282:Add(vfxUtil.make_baseplate_connection(_baseplate_controller.update));
    u282:Add(task.delay(3.533333333333333, function() -- Line: 6373
        -- upvalues: u283 (copy), _baseplate_controller (copy), u282 (copy)
        u283.Transparency = 1;
        _baseplate_controller.update();
        task.wait(3.2666666666666666);
        u282:Destroy();
    end));
    u282:Add(function() -- Line: 6380
        -- upvalues: u283 (copy), _baseplate_controller (copy)
        u283.Transparency = 0;
        _baseplate_controller.update();
    end);
    mainreplication2.sceneEnabled(true);
    u281:Add(function() -- Line: 6387
        -- upvalues: mainreplication2 (ref), vfxUtil (ref)
        mainreplication2.sceneEnabled(false);
        vfxUtil.cutscene_ball(false);
    end);
    vfxUtil.cutscene_invisiball(u279, u281);
    vfxUtil.cutscene_ball(true);
    local v284 = u281:Clone(Rebel.VFX);
    v284:PivotTo(Root.CFrame);
    v284.Parent = workspace.Effects;
    local u285, v286 = mainreplication2.cutsceneCamRigWithLetterBox(Root, Rebel.Animations.Camera, Rebel.FOV_Striker, nil, CFrame.new(0, -2.5, 1) * CFrame.Angles(0, -3.141592653589793, 0), vfxUtil.getResources().HumanoidCameraRig, "Torso");
    u281:Add(v286);
    u285:SetAttribute("Paused", true);
    u281:Add(task.spawn(function() -- Line: 6411
        -- upvalues: u279 (copy), RunService (ref), u281 (copy), u285 (copy)
        u279.Head.Transparency = 1;
        local u287 = RunService.PreRender:Connect(function() -- Line: 6414
            -- upvalues: u279 (ref)
            if u279 and u279:FindFirstChild("Head") then
                workspace.CurrentCamera.CFrame = u279.Head.CFrame;

                for _, child in u279:GetChildren() do
                    if child:IsA("Accessory") and (child:FindFirstChild("Handle") and child.Handle.Transparency ~= 1) then
                        child.Handle.Transparency = 1;
                    end;
                end;
            end;
        end);
        u281:Add(task.delay(3.966666666666667, function() -- Line: 6429
            -- upvalues: u287 (copy), u285 (ref), RunService (ref), u279 (ref)
            u287:Disconnect();
            u285:SetAttribute("Paused", nil);
            RunService.PreRender:Wait();
            u279.Head.Transparency = 0;

            for _, child in u279:GetChildren() do
                if child:IsA("Accessory") and child:FindFirstChild("Handle") then
                    child.Handle.Transparency = 0;
                end;
            end;
        end));
    end));
    local v288 = u281:Add(vfxUtil.getMoonEffects());
    local v289 = {
        Vignette = v288.Vignette,
        Letterbox = v288.Letterbox.Letterbox,
        ["Screen Cover"] = v288["Screen Cover"],
        Workspace = v284,
        Lighting = Lighting,
        Domain = v284.Domain
    };
    vfxUtil.cutscene_lighting(u281, v289, Rebel.Lighting, {
        ShadowSoftness = 0.2,
        ClockTime = 14.5,
        GeographicLatitude = 0,
        ExposureCompensation = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    local v290 = u281:Construct(MoonPropertyAnimator);
    v290:LoadAndConvertSave(Rebel.Moon, v289);
    v290:SetOriginalRoot(Rebel.VFX:GetPivot());
    v290:SetRoot(Root);
    v290:PlayAll();
    vfxUtil.execute_compiled(Rebel.Compiled, u281, v284, u279);
    u281:Add(soundUtil:play(u279:GetAttribute("RinNoPlay") and Rebel.SFXR or Rebel.SFX, "default"));
    u281:Add(task.delay(p280, u281.Destroy, u281));
    u281:Add(Util.Preload(Rebel.ImpactFrames));
    u281:Add(task.delay(9.05, function() -- Line: 6479
        -- upvalues: Util (ref), Rebel (copy)
        Util.Gif(Rebel.ImpactFrames, 24);
    end));
    u281:Add(task.delay(0, function() -- Line: 6483
        -- upvalues: u281 (copy), TekrinnDialogue (ref), u279 (copy)
        u281:Add(TekrinnDialogue.Speak(u279, {
            {
                Text = "NO!",
                Bold = true,
                TypeSpeed = 0.025,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(211, 226, 250)), ColorSequenceKeypoint.new(1, Color3.fromRGB(121, 158, 215)) }),
                TextStrokeColor = Color3.fromRGB(65, 86, 125),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 0.7
                }
            }
        }, 3));
    end));
    u281:Add(task.delay(0.6, function() -- Line: 6504
        -- upvalues: u281 (copy), TekrinnDialogue (ref), u279 (copy)
        u281:Add(TekrinnDialogue.Speak(u279, {
            {
                Text = "THIS ISN\'T WHAT I WANTED!",
                Bold = true,
                TypeSpeed = 0.025,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(211, 226, 250)), ColorSequenceKeypoint.new(1, Color3.fromRGB(121, 158, 215)) }),
                TextStrokeColor = Color3.fromRGB(65, 86, 125),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 3));
    end));
    u281:Add(task.delay(2.65, function() -- Line: 6525
        -- upvalues: u281 (copy), TekrinnDialogue (ref), u279 (copy)
        u281:Add(TekrinnDialogue.Speak(u279, {
            {
                Text = "COME ON, BRAIN!",
                Bold = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(225, 237, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(153, 183, 226)) }),
                TextStrokeColor = Color3.fromRGB(65, 86, 125),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 0.8
                }
            }
        }, 3));
    end));
    u281:Add(task.delay(4.25, function() -- Line: 6546
        -- upvalues: u281 (copy), TekrinnDialogue (ref), u279 (copy)
        u281:Add(TekrinnDialogue.Speak(u279, {
            {
                Text = "THINK!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(235, 245, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(165, 195, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(87, 126, 190)) }),
                TextStrokeColor = Color3.fromRGB(48, 65, 100),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 0.5
                }
            }
        }, 3));
    end));
    u281:Add(task.delay(5.05, function() -- Line: 6568
        -- upvalues: u281 (copy), TekrinnDialogue (ref), u279 (copy)
        u281:Add(TekrinnDialogue.Speak(u279, {
            {
                Text = "THINK OF A SOLUTION!",
                Bold = true,
                TypeSpeed = 0.025,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(211, 226, 250)), ColorSequenceKeypoint.new(1, Color3.fromRGB(121, 158, 215)) }),
                TextStrokeColor = Color3.fromRGB(65, 86, 125),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 3));
    end));
    u281:Add(task.delay(6.8, function() -- Line: 6589
        -- upvalues: u281 (copy), TekrinnDialogue (ref), u279 (copy)
        u281:Add(TekrinnDialogue.Speak(u279, {
            {
                Text = "THINK OF A STRATEGY!",
                Bold = true,
                TypeSpeed = 0.025,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(195, 215, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(105, 143, 204)) }),
                TextStrokeColor = Color3.fromRGB(55, 75, 112),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 3));
    end));
    u281:Add(task.delay(8.1, function() -- Line: 6610
        -- upvalues: u281 (copy), TekrinnDialogue (ref), u279 (copy)
        u281:Add(TekrinnDialogue.Speak(u279, {
            {
                Text = "I CAN\'T FAIL...",
                Bold = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(225, 237, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(153, 183, 226)) }),
                TextStrokeColor = Color3.fromRGB(65, 86, 125),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1.5
                }
            }
        }, 3));
    end));
    u281:Add(task.delay(9.3, function() -- Line: 6631
        -- upvalues: u281 (copy), TekrinnDialogue (ref), u279 (copy)
        u281:Add(TekrinnDialogue.Speak(u279, {
            {
                Text = "CAUSE I CAN ONLY SHINE...",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.45, Color3.fromRGB(220, 235, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(121, 158, 215)) }),
                TextStrokeColor = Color3.fromRGB(65, 86, 125),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1.5
                }
            }
        }, 3));
    end));
    u281:Add(task.delay(10.7, function() -- Line: 6653
        -- upvalues: u281 (copy), TekrinnDialogue (ref), u279 (copy)
        u281:Add(TekrinnDialogue.Speak(u279, {
            {
                Text = "WHEN I\'M DEVOURING THE BEST!",
                Bold = true,
                TypeSpeed = 0.025,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(235, 245, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(165, 195, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(87, 126, 190)) }),
                TextStrokeColor = Color3.fromRGB(48, 65, 100),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 1
                }
            }
        }, 3));
    end));
    u281:Add(task.delay(12.45, function() -- Line: 6674
        -- upvalues: u281 (copy), TekrinnDialogue (ref), u279 (copy)
        u281:Add(TekrinnDialogue.Speak(u279, {
            {
                Text = "I\'M A REBEL!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(204, 224, 252)),
                    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(137, 174, 226)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(87, 126, 190))
                }),
                TextStrokeColor = Color3.fromRGB(48, 65, 100),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 3));
    end));
end;

for i, v in require(script.Recode) do
    u1[i] = v;
end;

return u1;