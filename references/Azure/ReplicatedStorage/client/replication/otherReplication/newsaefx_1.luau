 
 

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local Debris = game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("ServerStorage");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Atmosphere.Decay;
local _ = Lighting.Atmosphere.Haze;
local _ = Lighting.Atmosphere.Glare;
local _ = Lighting.Atmosphere.Offset;
local ShadowSoftness = Lighting.ShadowSoftness;
local _ = Lighting.GeographicLatitude;
local _ = Lighting.Brightness;
local ClockTime = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local OutdoorAmbient = Lighting.OutdoorAmbient;
local _ = Lighting.ExposureCompensation;
local _ = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
local _ = Lighting.Bloom.Intensity;
local _ = Lighting.Bloom.Size;
require(ReplicatedStorage2.MeshEmit2);
require(ReplicatedStorage2.client.replication.MeshEmitter);
local TekrinnDialogue = require(ReplicatedStorage2.client.replication.TekrinnDialogue);
require(ReplicatedStorage2.Temp);
require(ReplicatedStorage2.VfxHandler);
require(ReplicatedStorage2.Welder);
require(ReplicatedStorage2.util.animationUtil);
local mainreplication = require(ReplicatedStorage2.client.replication.mainreplication);
local soundUtil = require(ReplicatedStorage2.util.soundUtil);
require(script.Parent.aikuVFX.xamillmesh);
require(script.Parent.camerasreplication);
local Util2 = require(ReplicatedStorage2.util.Util);
require(ReplicatedStorage.util.KatUtil);
local u1 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);
local trove = require(ReplicatedStorage.forum.trove);

function u1.characterImage(p2) -- Line: 68
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p2);
end;

local u3 = {};

local function GetVFX(p4: userdata, p5: userdata, p6: number, p7: boolean) -- Line: 72
    -- upvalues: Debris (copy), u3 (copy)
    local v8 = p5:Clone();
    local v9 = p5.Parent:FindFirstChild(p5:GetAttribute("WeldName") and p5:GetAttribute("WeldName") or p5.Name .. "Weld");

    if v9 then
        local v10 = v9:Clone();
        v10.Parent = v8;
        v10.Part0 = p4;
        v10.Part1 = v8;
    end;

    if p6 then
        Debris:AddItem(v8, p6);
    end;

    if p7 then
        u3[v8.Name] = p5;
    end;

    v8.Parent = p4;

    return v8;
end;

function GrabSavedVFX(p11: string)
    -- upvalues: u3 (copy)
    return u3[p11];
end;

local function CreateVFXTimeline(p12: userdata, p13: table, p14: function, p15: number) -- Line: 95
    -- upvalues: GetVFX (copy)
    for i, v in p13 do
        if p14 and not p14() then
            local v16 = v;
            local v17 = i;

            for _, child in p12:GetChildren() do
                if child.Name == v17 then
                    v16:Destroy();
                end;
            end;

            return;
        end;

        local u18 = GetVFX(p12, i, p15 or 5);

        for _, v2 in v do
            task.delay(v2, function() -- Line: 109
                -- upvalues: u18 (copy)
                for _, descendant in u18:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end);
        end;
    end;
end;

local function emit(p19: userdata, p20: boolean?, p21: boolean?) -- Line: 120
    for _, descendant in p19:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            if p20 and not string.find(descendant.Name, "grass") then
                descendant.LockedToPart = true;
            end;

            if descendant:GetAttribute("EmitDelay") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 128
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 10);
                end);
            else
                descendant:Emit(descendant:GetAttribute("EmitCount") or 10);
            end;
        end;
    end;
end;

local function emit2(p22) -- Line: 138
    for _, descendant in pairs(p22:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            local u23 = descendant:GetAttribute("EmitCount") or 10;
            local u24 = descendant:GetAttribute("EmitDuration") or 0;
            local v25 = descendant:GetAttribute("EmitDelay") or 0;
            task.delay(v25, function() -- Line: 145
                -- upvalues: u24 (copy), descendant (copy), u23 (copy)
                if u24 <= 0 then
                    descendant:Emit(u23);

                    return;
                end;

                descendant.Enabled = true;
                task.delay(u24, function() -- Line: 148
                    -- upvalues: descendant (ref)
                    descendant.Enabled = false;
                end);
            end);
        end;
    end;
end;

local function _() -- Line: 159
    -- upvalues: Lighting (copy)
    local v26 = {};

    for _, child in Lighting:GetChildren() do
        table.insert(v26, child:Clone());
        child:Destroy();
    end;

    return v26;
end;

function u1.SakuyaIntercept(u27: userdata) -- Line: 171
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Util (copy), Lighting (copy), TweenService (copy), TekrinnDialogue (copy)
    local u28 = u27.HumanoidRootPart or u27.PrimaryPart;
    local izayoi = ReplicatedStorage.Resources.izayoi;
    local u29, u30 = mainreplication.cutsceneHumanoidCamera(u28, izayoi.interceptcam, izayoi.interceptfov, nil, nil, CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0));
    mainreplication.sceneEnabled(true);
    soundUtil:play(izayoi.intercept, SoundService);
    task.spawn(function() -- Line: 179
        -- upvalues: Util (ref), izayoi (copy), u29 (copy)
        Util.CameraEffect(izayoi.camvfx, u29);
    end);
    local u31 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    u31.TintColor = Color3.new(1, 1, 1);
    u31.Brightness = 0;
    u31.Contrast = 0;
    u31.Saturation = 0;
    u31.Parent = Lighting;
    task.delay(0.43333333333333335, function() -- Line: 190
        -- upvalues: TweenService (ref), u31 (copy), mainreplication (ref), u28 (copy), izayoi (copy)
        TweenService:Create(u31, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
            Contrast = 2
        }):Play();
        TweenService:Create(u31, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), {
            Contrast = 1,
            Saturation = -1
        }):Play();
        mainreplication.EmitAttachmentIn({
            Parent = u28,
            Effect = izayoi.intercetp["1"]
        });
    end);
    task.delay(0.7, function() -- Line: 199
        -- upvalues: TekrinnDialogue (ref), u27 (copy)
        TekrinnDialogue.Speak(u27, {
            {
                Text = "What a",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 223, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            },
            {
                Text = "waste",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 223, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 6,
                    Lifetime = 3
                }
            },
            {
                Text = " of time.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 223, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 1.75);
    end);
    task.delay(0.5166666666666667, function() -- Line: 267
        -- upvalues: TweenService (ref), u31 (copy)
        TweenService:Create(u31, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), {
            Contrast = 0.4,
            Saturation = -1
        }):Play();
    end);
    task.delay(0.6833333333333333, function() -- Line: 271
        -- upvalues: TweenService (ref), u31 (copy)
        TweenService:Create(u31, TweenInfo.new(0.65, Enum.EasingStyle.Linear), {
            Contrast = 0,
            Saturation = 0
        }):Play();
    end);
    task.delay(1.45, function() -- Line: 275
        -- upvalues: mainreplication (ref), u28 (copy), izayoi (copy)
        mainreplication.EmitAttachmentIn({
            Parent = u28,
            Effect = izayoi.intercetp["2"]
        });
    end);
    task.delay(2.066666666666667, function() -- Line: 282
        -- upvalues: u31 (copy), mainreplication (ref), u30 (copy)
        u31:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 0.5);

        if u30 then
            u30();
        end;
    end);
end;

function u1.saenewnewauto(p32: userdata, u33: userdata, p34: any) -- Line: 292
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy), Util (copy), Lighting (copy), soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy), TekrinnDialogue (copy), CreateVFXTimeline (copy), TweenService (copy)
    local v35 = p32.HumanoidRootPart or p32.PrimaryPart;

    if u33 and not u33.HumanoidRootPart then
        local _ = u33.PrimaryPart;
    end;

    local AutoGOal = ReplicatedStorage.Resources.sae.AutoGOal;
    local Ball = p32:FindFirstChild("Ball");
    local u36 = mainreplication.cutsceneAll(v35, CFrame.new(), 7.35, AutoGOal.FOV);
    Util.CameraEffect(AutoGOal.cameravfx, u36);
    mainreplication.sceneEnabled(true);
    local u37 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    local u38 = AutoGOal.BallTrail:Clone();
    local u39 = AutoGOal.vfx4:Clone();
    local u40 = AutoGOal.vfx5:Clone();
    u39.Parent = Ball;
    u40.Parent = Ball;
    u38.Parent = Ball;
    u37.Brightness = -0.025;
    u37.Contrast = 0.05;
    u37.Saturation = -0.4;
    u37.TintColor = Color3.new(1, 1, 1);
    u37.Parent = Lighting;
    local v41 = soundUtil:play(ReplicatedStorage2.Resources.sae.AutoGOal.autog, SoundService, {
        Character = p32
    });

    for _, descendant in ipairs(u36:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
            task.delay(7.65, function() -- Line: 321
                -- upvalues: descendant (copy)
                descendant.Enabled = false;
            end);
        end;
    end;

    task.delay(1.7, function() -- Line: 325
        -- upvalues: u36 (copy)
        for _, descendant in ipairs(u36.screenshake:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(1.65, function() -- Line: 329
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);

    if v41 and v41.Name == "Dub" then
        task.delay(1.488, function() -- Line: 335
            -- upvalues: TekrinnDialogue (ref), u33 (copy)
            TekrinnDialogue.Speak(u33 and u33.Name or "???", {
                {
                    Text = "He doesn\'t have the angle...",
                    Italic = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 3);
        end);
        task.delay(2.918, function() -- Line: 355
            -- upvalues: TekrinnDialogue (ref), u33 (copy)
            TekrinnDialogue.Speak(u33 and u33.Name or "???", {
                {
                    Text = "Good.",
                    Bold = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 0.4219999999999997);
        end);
    else
        task.delay(1.488, function() -- Line: 376
            -- upvalues: TekrinnDialogue (ref), u33 (copy)
            TekrinnDialogue.Speak(u33 and u33.Name or "???", {
                {
                    Text = "He doesn\'t have the angle.",
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 1.8519999999999999);
        end);
    end;

    CreateVFXTimeline(v35, {
        [AutoGOal.lift] = { 0.7166666666666667 },
        [AutoGOal.vfx1] = { 0.16666666666666666 },
        [AutoGOal.vfx2] = { 2.066666666666667 },
        [AutoGOal.vfx3] = { 3.433333333333333 }
    });
    TweenService:Create(u37, TweenInfo.new(3.283333333333333, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Brightness = -0.25,
        Contrast = 0.1,
        Saturation = -0.5
    }):Play();
    task.delay(3.283333333333333, function() -- Line: 414
        -- upvalues: TweenService (ref), u37 (copy)
        TweenService:Create(u37, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = -0.025,
            Contrast = 0.05,
            Saturation = -1,
            TintColor = Color3.fromRGB(255, 204, 240)
        }):Play();
    end);
    task.delay(6.033333333333333, function() -- Line: 417
        -- upvalues: u40 (copy), u36 (copy)
        for _, descendant in ipairs(u40:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(0.85, function() -- Line: 421
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        for _, descendant in ipairs(u36.flares:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.4166666666666665, function() -- Line: 430
        -- upvalues: u38 (copy), u39 (copy), TweenService (ref), u37 (copy)
        task.spawn(function() -- Line: 431
            -- upvalues: u38 (ref), u39 (ref)
            for _, descendant in ipairs(u38:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = true;
                    task.delay(1.05, function() -- Line: 435
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            for _, descendant in ipairs(u39:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(0.85, function() -- Line: 443
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end);
        TweenService:Create(u37, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Saturation = -0.4
        }):Play();
        TweenService:Create(u37, TweenInfo.new(256.56666666666666), {
            TintColor = Color3.new(1, 1, 1)
        }):Play();
    end);
    task.delay(7.35, function() -- Line: 452
        -- upvalues: u39 (copy), u40 (copy), u38 (copy), u37 (copy), mainreplication (ref), u36 (copy)
        u39:Destroy();
        u40:Destroy();
        u38:Destroy();
        u37:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 0.5);
        u36:Destroy();
    end);
end;

function u1.thissaegothitbyashotgunandhejustcanthallelit(u42) -- Line: 465
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Lighting (copy), ReplicatedStorage (copy), ClockTime (copy), Ambient (copy), ShadowSoftness (copy), OutdoorAmbient (copy), TekrinnDialogue (copy)
    local thissaegothitbyashotgunandhejustcanthallelit = ReplicatedStorage2.Resources.sae.thissaegothitbyashotgunandhejustcanthallelit;
    local HumanoidRootPart = u42:FindFirstChild("HumanoidRootPart");
    local u43 = trove.new();

    local function syncedDelay(p44: number, p45: function, ...) -- Line: 470
        -- upvalues: u43 (copy)
        return u43:Add(task.delay(math.max(0, p44 / 60), p45, ...));
    end;

    mainreplication.sceneEnabled(true);
    local v46;

    if u42:GetAttribute("femlock") then
        v46 = ReplicatedStorage2.Resources.sae.Femvoicelines.nuishot;
    else
        v46 = thissaegothitbyashotgunandhejustcanthallelit.sfx;
    end;

    soundUtil:play(v46, SoundService, {
        Character = u42
    });
    local u47, v48 = mainreplication.cutsceneCamRigWithLetterBox(HumanoidRootPart, thissaegothitbyashotgunandhejustcanthallelit.camera, thissaegothitbyashotgunandhejustcanthallelit.FOV, u42, CFrame.new(0, -3, 0, -1, 0, -8.74227766e-8, 0, 1, 0, 8.74227766e-8, 0, -1));

    if u47 and v48 then
        u43:Add(v48);
        task.spawn(function() -- Line: 484
            -- upvalues: thissaegothitbyashotgunandhejustcanthallelit (copy), u47 (copy)
            for _, child in thissaegothitbyashotgunandhejustcanthallelit.VFX.CameraEffects:GetChildren() do
                child:Clone().Parent = u47.camera;
            end;
        end);
    end;

    u43:Clone(thissaegothitbyashotgunandhejustcanthallelit.VFX.EyeFX).Parent = u42.Head;
    u43:Add(function() -- Line: 494
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(2, 0.75);
        mainreplication.sceneEnabled(false);
    end);

    for _, child in Lighting:GetChildren() do
        child:Destroy();
    end;

    for _, child in thissaegothitbyashotgunandhejustcanthallelit.Lighting:GetChildren() do
        u43:Clone(child).Parent = Lighting;
    end;

    Lighting.ClockTime = 14.5;
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.ShadowSoftness = 0.2;
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    local u49 = false;

    local function restoreLighting() -- Line: 514
        -- upvalues: u49 (ref), Lighting (ref), ReplicatedStorage (ref), ClockTime (ref), Ambient (ref), ShadowSoftness (ref), OutdoorAmbient (ref)
        if u49 then
            return;
        end;

        u49 = true;
        Lighting:ClearAllChildren();

        for _, child in ReplicatedStorage.Resources.OGLightning:GetChildren() do
            child:Clone().Parent = Lighting;
        end;

        Lighting.ClockTime = ClockTime;
        Lighting.Ambient = Ambient;
        Lighting.ShadowSoftness = ShadowSoftness;
        Lighting.OutdoorAmbient = OutdoorAmbient;
    end;

    u43:Add(restoreLighting);
    task.delay(5, restoreLighting);
    syncedDelay(8, function() -- Line: 537
        -- upvalues: mainreplication (ref), thissaegothitbyashotgunandhejustcanthallelit (copy), HumanoidRootPart (copy)
        mainreplication.EmitAttachmentIn({
            Effect = thissaegothitbyashotgunandhejustcanthallelit.VFX.SkillStep1,
            Parent = HumanoidRootPart
        });
    end);
    syncedDelay(37, function() -- Line: 544
        -- upvalues: TekrinnDialogue (ref), u42 (copy), u43 (copy), thissaegothitbyashotgunandhejustcanthallelit (copy), HumanoidRootPart (copy), syncedDelay (copy)
        TekrinnDialogue.Speak(u42, {
            {
                Text = "You\'re such a pain...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 1.75);
        local v50 = u43:Clone(thissaegothitbyashotgunandhejustcanthallelit.VFX.Attachments);
        v50.Join.Part0 = HumanoidRootPart;
        v50.Parent = workspace.Effects;
        syncedDelay(156, v50.Destroy, v50);
    end);
    syncedDelay(105, function() -- Line: 576
        -- upvalues: TekrinnDialogue (ref), u42 (copy)
        TekrinnDialogue.Speak(u42, {
            {
                Text = "little brother.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 73, 112)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 2);
    end);
    syncedDelay(156, function() -- Line: 602
        -- upvalues: mainreplication (ref), thissaegothitbyashotgunandhejustcanthallelit (copy), HumanoidRootPart (copy)
        mainreplication.EmitAttachmentIn({
            Effect = thissaegothitbyashotgunandhejustcanthallelit.VFX.GroundVFX,
            Parent = HumanoidRootPart
        });
    end);
    syncedDelay(196, function() -- Line: 609
        -- upvalues: mainreplication (ref), thissaegothitbyashotgunandhejustcanthallelit (copy), HumanoidRootPart (copy)
        mainreplication.EmitAttachmentIn({
            Effect = thissaegothitbyashotgunandhejustcanthallelit.VFX.KickVFX,
            Parent = HumanoidRootPart
        });
        mainreplication.EmitAttachmentIn({
            Effect = thissaegothitbyashotgunandhejustcanthallelit.VFX.FX,
            Parent = HumanoidRootPart
        });
        mainreplication.EmitAttachmentIn({
            Effect = thissaegothitbyashotgunandhejustcanthallelit.VFX.Aura,
            Parent = HumanoidRootPart
        });
    end);
    syncedDelay(265, u43.Destroy, u43);
end;

function u1.ipotshobuda(u51, u52) -- Line: 629
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Lighting (copy), ReplicatedStorage (copy), TekrinnDialogue (copy), TweenService (copy)
    local iptoshobuda = ReplicatedStorage2.Resources.sae.iptoshobuda;
    local HumanoidRootPart = u51:FindFirstChild("HumanoidRootPart");
    local u53 = trove.new();
    local u54 = {};

    local function u57(p55: number, p56: function, ...) -- Line: 635
        -- upvalues: u53 (copy)
        return u53:Add(task.delay(math.max(0, p55 / 60), p56, ...));
    end;

    mainreplication.sceneEnabled(true);
    soundUtil:play(iptoshobuda[u52 and "sfx-VLess" or "sfx"], SoundService, {
        Character = u51
    });
    local u58 = mainreplication.cutscene(HumanoidRootPart, CFrame.identity, 5.333333333333333, iptoshobuda.FOV);

    if u58 then
        u53:Add(u58);
    end;

    for _, child in Lighting:GetChildren() do
        if child:IsA("BloomEffect") then
            child:Destroy();
        end;
    end;

    u53:Clone(iptoshobuda.Bloom).Parent = Lighting;
    u53:Add(function() -- Line: 659
        -- upvalues: mainreplication (ref), Lighting (ref), ReplicatedStorage (ref)
        mainreplication.ultFlash(2, 0.75);
        mainreplication.sceneEnabled(false);
        Lighting:ClearAllChildren();

        for _, child in ReplicatedStorage.Resources.OGLightning:GetChildren() do
            child:Clone().Parent = Lighting;
        end;
    end);
    local u59 = u53:Construct(Instance, "ColorCorrectionEffect");
    u59.Parent = Lighting;
    local u60 = u53:Clone(iptoshobuda.Atmosphere);
    u60.Parent = Lighting;
    u57(225, function() -- Line: 676
        -- upvalues: u52 (copy), TekrinnDialogue (ref), u51 (copy)
        if not u52 then
            TekrinnDialogue.Speak(u51, {
                {
                    Text = "This is a one-shot match.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end;
    end);
    u57(15, function() -- Line: 704
        -- upvalues: mainreplication (ref), iptoshobuda (copy), HumanoidRootPart (copy)
        mainreplication.EmitAttachmentIn({
            Effect = iptoshobuda.VFX.Kick,
            Parent = HumanoidRootPart
        });
    end);
    u57(39, function() -- Line: 711
        -- upvalues: TweenService (ref), u60 (copy)
        TweenService:Create(u60, TweenInfo.new(0.1), {
            Density = 0.8,
            Haze = 10
        }):Play();
    end);
    u57(45, function() -- Line: 718
        -- upvalues: u53 (copy), iptoshobuda (copy), u51 (copy), HumanoidRootPart (copy), mainreplication (ref), u54 (copy), u59 (copy), TweenService (ref), u57 (copy)
        u53:Clone(iptoshobuda.VFX.EyeFX).Parent = u51.Head;
        local v61 = u53:Clone(iptoshobuda.VFX.Aura);
        v61.Join.Part0 = HumanoidRootPart;
        v61.Parent = workspace.Effects;
        mainreplication.BetterEnable(v61, true);

        for _, v in { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" } do
            local v62 = u51:FindFirstChild(v);

            if v62 then
                for _, child in iptoshobuda.VFX.BodyAura:GetChildren() do
                    local v63 = u53:Clone(child);
                    v63.Parent = v62;
                    table.insert(u54, v63);
                end;
            end;
        end;

        mainreplication.BetterEnable(u54, true);
        mainreplication.EmitAttachmentIn({
            Effect = iptoshobuda.VFX.AuraStart,
            Parent = HumanoidRootPart
        });
        u59.Brightness = 1;
        TweenService:Create(u59, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Brightness = 0
        }):Play();
        u57(87, u59.Destroy, u59);
    end);
    u57(210, function() -- Line: 758
        -- upvalues: u53 (copy), iptoshobuda (copy), u58 (copy)
        u53:Clone(iptoshobuda.VFX.Cam).Parent = u58;
    end);
    u57(294, function() -- Line: 764
        -- upvalues: mainreplication (ref), u54 (copy)
        mainreplication.BetterEmit(u54);
    end);
    u57(320, u53.Destroy, u53);
end;

function u1.saecreativedribble(u64, p65) -- Line: 771
    -- upvalues: trove (copy), mainreplication (copy), ReplicatedStorage2 (copy), Players (copy), RunService (copy)
    local u66 = u64.HumanoidRootPart or u64.PrimaryPart;
    local u67 = false;
    local u68 = trove.new();

    local function v71(p69: number, p70: function, ...) -- Line: 777
        -- upvalues: u68 (copy)
        return u68:Add(task.delay(math.max(0, p69 / 60), p70, ...));
    end;

    mainreplication.springcamerashake(40, 30);
    mainreplication.fov(false, 90);
    mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    mainreplication.EmitAttachmentIn({
        Parent = u66,
        Effect = ReplicatedStorage2.Resources.sae.CreativeDribbleEff.AtlasWindShockwaves
    });
    mainreplication.EmitAttachmentIn({
        Parent = u66,
        Effect = ReplicatedStorage2.Resources.sae.CreativeDribbleEff.Attachment
    });
    v71(16, function() -- Line: 794
        -- upvalues: mainreplication (ref), u66 (copy), ReplicatedStorage2 (ref)
        mainreplication.EmitAttachmentIn({
            Parent = u66,
            Effect = ReplicatedStorage2.Resources.sae.CreativeDribbleEff.AtlasWindShockwaves
        });
        mainreplication.EmitAttachmentIn({
            Parent = u66,
            Effect = ReplicatedStorage2.Resources.sae.CreativeDribbleEff.Attachment
        });
    end);
    v71(30, function() -- Line: 805
        -- upvalues: mainreplication (ref), u66 (copy), ReplicatedStorage2 (ref)
        mainreplication.EmitAttachmentIn({
            Parent = u66,
            Effect = ReplicatedStorage2.Resources.sae.CreativeDribbleEff.AtlasWindShockwaves
        });
        mainreplication.EmitAttachmentIn({
            Parent = u66,
            Effect = ReplicatedStorage2.Resources.sae.CreativeDribbleEff.Attachment
        });
    end);
    v71(50, function() -- Line: 816
        -- upvalues: mainreplication (ref), u66 (copy), ReplicatedStorage2 (ref)
        mainreplication.EmitAttachmentIn({
            Parent = u66,
            Effect = ReplicatedStorage2.Resources.sae.CreativeDribbleEff.AtlasWindShockwaves
        });
        mainreplication.EmitAttachmentIn({
            Parent = u66,
            Effect = ReplicatedStorage2.Resources.sae.CreativeDribbleEff.Attachment
        });
    end);
    v71(61, function() -- Line: 827
        -- upvalues: mainreplication (ref), u66 (copy), ReplicatedStorage2 (ref)
        mainreplication.EmitAttachmentIn({
            Parent = u66,
            Effect = ReplicatedStorage2.Resources.sae.CreativeDribbleEff.AtlasWindShockwaves
        });
        mainreplication.EmitAttachmentIn({
            Parent = u66,
            Effect = ReplicatedStorage2.Resources.sae.CreativeDribbleEff.Attachment
        });
    end);
    local u72 = nil;
    local u73 = nil;
    local u74 = nil;

    local function stopDash() -- Line: 842
        -- upvalues: u74 (ref), u73 (ref)
        if u74 then
            u74:Disconnect();
            u74 = nil;
        end;

        if u73 and u73:IsDescendantOf(game) then
            u73:Destroy();
            u73 = nil;
        end;
    end;

    u72 = u64:GetAttributeChangedSignal("deathCounter"):connect(function() -- Line: 853
        -- upvalues: u64 (copy), u67 (ref), u74 (ref), u73 (ref), u68 (copy), u72 (ref)
        if u64:GetAttribute("deathCounter") then
            return;
        end;

        u67 = true;

        if u74 then
            u74:Disconnect();
            u74 = nil;
        end;

        if u73 and u73:IsDescendantOf(game) then
            u73:Destroy();
            u73 = nil;
        end;

        u68:Destroy();

        if u72 then
            u72:Disconnect();
        end;
    end);
    task.delay(2, function() -- Line: 864
        -- upvalues: u72 (ref)
        u72:Disconnect();
        u72 = nil;
    end);

    if u67 then
        return;
    end;

    if Players:GetPlayerFromCharacter(u64) ~= Players.LocalPlayer then
        return;
    end;

    local v75, v76 = mainreplication.bodyVelocity(u66, p65 and 100 or 30, 1.117, nil, nil, true, TweenInfo.new(5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 40));
    u73 = v75;
    local u77 = v76;
    u74 = RunService.RenderStepped:Connect(function(p78) -- Line: 874
        -- upvalues: u73 (ref), u74 (ref), u66 (copy), u77 (ref)
        if u73 and u73:IsDescendantOf(game) then
            u73.Velocity = u66.CFrame.LookVector * u77.Value;

            return;
        end;

        if u74 then
            u74:Disconnect();
            u74 = nil;
        end;
    end);
    task.delay(1.117, stopDash);
    v71(67, u68.Destroy, u68);
end;

function u1.followupcreative(u79, p80, p81) -- Line: 890
    -- upvalues: trove (copy), mainreplication (copy), ReplicatedStorage2 (copy), u1 (copy), Util2 (copy), LocalPlayer (copy), vfxUtil (copy), ReplicatedStorage (copy), Players (copy), RunService (copy)
    local u82 = u79.HumanoidRootPart or u79.PrimaryPart;
    local u83 = false;
    local u84 = trove.new();

    local function v87(p85: number, p86: function, ...) -- Line: 895
        -- upvalues: u84 (copy)
        return u84:Add(task.delay(math.max(0, p85 / 60), p86, ...));
    end;

    mainreplication.EmitAttachmentIn({
        Parent = u82,
        Effect = ReplicatedStorage2.Resources.sae.CreativeDribbleEff.FX
    });
    u1.characterImage({
        Speed = 0.3,
        CFrames = true,
        Brightness = 1,
        countSpeed = 0.03,
        Count = 16,
        Whitelist = { u79 },
        Color = Color3.fromRGB(255, 74, 146),
        Color2 = Color3.fromRGB(66, 255, 113)
    });
    game:GetService("TweenService");
    local u88 = ReplicatedStorage2.Resources.sae["Divine Lift"].Wind_Beams:Clone();
    u88.Weld.Part1 = u79.Torso;
    u88.Parent = u79;

    if Util2.canshiftcolor(LocalPlayer, u79) then
        vfxUtil.LeanTowardsColor(u88, u79:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u79:GetAttribute("CustomAlpha") or 0.985);
    end;

    mainreplication.BetterEmit(u88);
    local TweenService2 = game:GetService("TweenService");

    for _, descendant in ipairs(u88:GetDescendants()) do
        if descendant:IsA("Beam") and (descendant.Attachment0 and descendant.Attachment1) then
            descendant.Enabled = true;
            local Color3_fromRGB_ret = Color3.fromRGB(255, 60, 100);
            local Color3Value = Instance.new("Color3Value");
            Color3Value.Value = Color3_fromRGB_ret;
            descendant.LightEmission = 0;
            Color3Value:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 938
                -- upvalues: Color3Value (copy), descendant (copy)
                local Value = Color3Value.Value;
                descendant.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Value), ColorSequenceKeypoint.new(1, Value) });
            end);
            descendant.Color = ColorSequence.new(Color3_fromRGB_ret);
            local v89 = TweenService2:Create(Color3Value, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Value = Color3.new(0, 0, 0)
            });
            local v90 = TweenService2:Create(descendant, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                LightEmission = 1
            });
            v89:Play();
            v90:Play();
            TweenService2:Create(descendant, TweenInfo.new(0.325, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextureLength = 1
            }):Play();
            descendant.TextureSpeed = 15;
            local v91 = TweenService2:Create(descendant, TweenInfo.new(0.325, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextureSpeed = 8
            });
            local u92 = TweenService2:Create(descendant, TweenInfo.new(0.325, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextureSpeed = 3
            });
            v91:Play();
            v91.Completed:Connect(function() -- Line: 977
                -- upvalues: u92 (copy)
                u92:Play();
            end);
            u92.Completed:Connect(function() -- Line: 981
                -- upvalues: descendant (copy), Color3Value (copy), Color3_fromRGB_ret (copy), u88 (copy)
                descendant.LightEmission = 0;
                Color3Value.Value = Color3_fromRGB_ret;
                descendant.Color = ColorSequence.new(Color3_fromRGB_ret);
                descendant.TextureSpeed = 15;
                descendant.TextureLength = 0;
                descendant.Enabled = false;
                u88:Destroy();
            end);
        end;
    end;

    mainreplication.fov(false, 80);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    mainreplication.springcamerashake(10, 45);
    local v93 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v93.Parent = game.Lighting;
    v93.TintColor = Color3.fromRGB(255, 1, 111);
    v93.Brightness = 0.4;
    v93.Contrast = 1;
    v93.Saturation = -0.4;
    TweenService2:Create(v93, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService2:Create(v93, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(2, v93.Destroy, v93);
    local u94 = nil;
    u94 = u79:GetAttributeChangedSignal("deathCounter"):connect(function() -- Line: 1010
        -- upvalues: u94 (ref), u79 (copy), u83 (ref)
        if u94 then
            u94:Disconnect();
        end;

        if u79:GetAttribute("deathCounter") then
            u83 = true;
            u94:Disconnect();
        end;
    end);
    task.delay(2, function() -- Line: 1017
        -- upvalues: u94 (ref)
        u94:Disconnect();
        u94 = nil;
    end);

    if u83 then
        return;
    end;

    if Players:GetPlayerFromCharacter(u79) ~= Players.LocalPlayer then
        return;
    end;

    if p80 then
        local u95, u96 = mainreplication.bodyVelocity(u82, p81 and 130 or 80, 1, nil, nil, true, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0));
        local u97 = nil;
        u97 = RunService.RenderStepped:Connect(function(p98) -- Line: 1044
            -- upvalues: u95 (copy), u97 (ref), u82 (copy), u96 (copy)
            if u95 and u95:IsDescendantOf(game) then
                u95.Velocity = u82.CFrame.LookVector * u96.Value + u82.CFrame.RightVector * u96.Value * 1.25;

                return;
            end;

            u97:Disconnect();
        end);
        task.delay(15, u97.Disconnect, u97);
    else
        local u99, u100 = mainreplication.bodyVelocity(u82, p81 and 130 or 80, 1, nil, nil, true, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0));
        local u101 = nil;
        u101 = RunService.RenderStepped:Connect(function(p102) -- Line: 1031
            -- upvalues: u99 (copy), u101 (ref), u82 (copy), u100 (copy)
            if u99 and u99:IsDescendantOf(game) then
                u99.Velocity = u82.CFrame.LookVector * u100.Value + u82.CFrame.RightVector * -u100.Value * 1.25;

                return;
            end;

            u101:Disconnect();
        end);
        task.delay(15, u101.Disconnect, u101);
    end;

    v87(67, u84.Destroy, u84);
end;

return u1;