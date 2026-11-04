 

 

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("ContentProvider");
game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("ServerStorage");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
require(ReplicatedStorage.allTypes.rig);
local trove = require(ReplicatedStorage.forum.trove);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local u1 = {};
local u2 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local _ = Lighting.GeographicLatitude;
local Brightness = Lighting.Brightness;
local ClockTime = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local _ = Lighting.OutdoorAmbient;
local ExposureCompensation = Lighting.ExposureCompensation;
local Threshold = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
local MeshEmitter = require(ReplicatedStorage2.client.replication.MeshEmitter);
require(ReplicatedStorage2.util.raycast);
local animationUtil = require(ReplicatedStorage2.util.animationUtil);
local soundUtil = require(ReplicatedStorage2.util.soundUtil);
require(ReplicatedStorage2.util.actionUtil);
local Util = require(ReplicatedStorage2.util.Util);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local mainreplication = require(ReplicatedStorage2.client.replication.mainreplication);
local TekrinnDialogue = require(ReplicatedStorage2.client.replication.TekrinnDialogue);
local UwUEffects = require(ReplicatedStorage2.util.UwUEffects);
require(script.EzDistort);
require(script.Parent.nelisagiVFX.MeshEmitModule);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);

function u1.characterImage(p3) -- Line: 62
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p3);
end;

local function emitall(p4, p5) -- Line: 64
    if not p4 then
        return;
    end;

    for _, descendant in pairs(p4:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(p5 or descendant:GetAttribute("EmitCount"));
        end;
    end;
end;

local function enableall(u6, p7, p8) -- Line: 73
    if not u6 then
        return;
    end;

    for _, descendant in pairs(u6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    if p7 then
        for _, descendant in pairs(u6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 83
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        return;
    end;

    task.delay(p8, function() -- Line: 89
        -- upvalues: u6 (copy)
        if not u6 then
            return;
        end;

        for _, descendant in pairs(u6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

local function makeweld(p9, p10, p11, p12) -- Line: 100
    local Weld = Instance.new("Weld");
    Weld.Parent = p9;
    Weld.Part0 = p10;
    Weld.Part1 = p11;

    if p12 then
        Weld.C0 = p12;
    end;
end;

local function addDurations(p13: table, p14: any) -- Line: 113
    local v15 = 0;

    if typeof(p14) == "table" then
        for _, v in ipairs(p14) do
            v15 = v15 + p13[v].Duration;
        end;

        return v15;
    end;

    if typeof(p14) == "number" then
        for i = 1, p14 do
            v15 = v15 + p13[i].Duration;
            local _ = i;
        end;

        return v15;
    end;

    for _, v in ipairs(p13) do
        v15 = v15 + v.Duration;
    end;

    return v15;
end;

local function closeQuarterCurve(p16: number) -- Line: 131
    return math.sin(p16 * 3.141592653589793);
end;

local function getEmitterLifetime(p17: userdata?) -- Line: 135
    local v18 = 0;

    if typeof(p17) ~= "Instance" then
        return v18;
    end;

    if p17:IsA("ParticleEmitter") then
        return p17.Lifetime.Max / p17.TimeScale;
    end;

    if p17:IsA("Trail") then
        v18 = p17.Lifetime;
    end;

    return v18;
end;

local function getEmittersLifetime(p19: userdata) -- Line: 148
    local v20 = 0;

    if typeof(p19) == "Instance" then
        if p19:IsA("ParticleEmitter") then
            v20 = p19.Lifetime.Max / p19.TimeScale;
        elseif p19:IsA("Trail") then
            v20 = p19.Lifetime;
        end;
    end;

    if typeof(p19) == "Instance" then
        for _, descendant in p19:GetDescendants() do
            local v21 = 0;

            if typeof(descendant) == "Instance" then
                if descendant:IsA("ParticleEmitter") then
                    v21 = descendant.Lifetime.Max / descendant.TimeScale;
                elseif descendant:IsA("Trail") then
                    v21 = descendant.Lifetime;
                end;
            end;

            if v20 < v21 then
                v20 = v21;
            end;
        end;
    end;

    return v20;
end;

local function kuronaFlash(p22: number, p23: number?) -- Line: 161
    -- upvalues: Lighting (copy), TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p22);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.new(1, 0, 1);
    ColorCorrectionEffect.Contrast = 0.5;
    ColorCorrectionEffect.Parent = Lighting;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = p23 or 4;
    BlurEffect.Parent = Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo_new_ret, {
        Contrast = 0,
        TintColor = Color3.new(1, 1, 1)
    }):Play();
    TweenService:Create(BlurEffect, TweenInfo_new_ret, {
        Size = 0
    }):Play();
    task.delay(TweenInfo_new_ret.Time, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
    task.delay(TweenInfo_new_ret.Time, BlurEffect.Destroy, BlurEffect);
end;

local function onBallLost(u24: userdata, u25: userdata?) -- Line: 176
    local Ball = u24:FindFirstChild("Ball");
    local u26 = nil;
    local BoolValue = Instance.new("BoolValue");

    if Ball then
        u26 = Ball.AncestryChanged:Connect(function() -- Line: 181
            -- upvalues: Ball (copy), u24 (copy), BoolValue (copy), u26 (ref), u25 (copy)
            if Ball.Parent ~= u24 then
                BoolValue.Value = true;
                u26:Disconnect();

                if typeof(u25) == "function" then
                    u25();
                end;
            end;
        end);
    elseif typeof(u25) == "function" then
        u25();
    end;

    return u26, Ball, BoolValue;
end;

local function getRoot(p27: userdata) -- Line: 196
    return p27:FindFirstChild("HumanoidRootPart") or p27.PrimaryPart;
end;

local function isLocalPlayer(p28: userdata) -- Line: 200
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer.Character == p28;
end;

local function emit(u29: userdata) -- Line: 204
    task.delay(u29:GetAttribute("EmitDelay") or 0, function() -- Line: 205
        -- upvalues: u29 (copy)
        u29:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or u29:GetAttribute("EmitCount"));
    end);
end;

local function emitAll(p30) -- Line: 210
    if typeof(p30) ~= "Instance" then
        for _, v in p30 do
            task.delay(v:GetAttribute("EmitDelay") or 0, function() -- Line: 205
                -- upvalues: v (copy)
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end);
        end;

        return p30;
    end;

    local v31 = {};

    for _, descendant in p30:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            task.delay(descendant:GetAttribute("EmitDelay") or 0, function() -- Line: 205
                -- upvalues: descendant (copy)
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end);
            table.insert(v31, descendant);
        end;
    end;

    return v31;
end;

local function dispose(u32: userdata) -- Line: 229
    xpcall(function() -- Line: 230
        -- upvalues: u32 (copy)
        u32:Destroy();
    end, warn);
end;

local function disposal(u33: any, p34: number?) -- Line: 235
    -- upvalues: getEmittersLifetime (copy)
    local u35;

    if typeof(u33) == "table" then
        u35 = typeof(u33.Destroy) ~= "function";
    else
        u35 = false;
    end;

    if typeof(p34) ~= "number" then
        p34 = getEmittersLifetime(u33);

        if u35 then
            for _, v in u33 do
                local v36 = getEmittersLifetime(v);

                if p34 < v36 then
                    p34 = v36;
                end;
            end;
        end;
    end;

    task.delay(p34, function() -- Line: 248
        -- upvalues: u35 (copy), u33 (copy)
        if u35 then
            for _, v in u33 do
                xpcall(function() -- Line: 230
                    -- upvalues: v (copy)
                    v:Destroy();
                end, warn);
            end;

            return;
        end;

        local u37 = u33;
        xpcall(function() -- Line: 230
            -- upvalues: u37 (copy)
            u37:Destroy();
        end, warn);
    end);
end;

local function createVFX(p38: userdata, p39: userdata, p40: any) -- Line: 259
    local v41 = p38:Clone();

    if typeof(p40) == "Instance" and p40:IsA("BasePart") then
        v41.Weld.Part0 = p40;
    elseif typeof(p40) == "CFrame" then
        v41.CFrame = p40;
    end;

    v41.Parent = p39;

    return v41;
end;

local function quickVFX(p42: userdata, p43: userdata, p44: any) -- Line: 270
    -- upvalues: emitAll (copy), disposal (copy)
    local v45 = p42:Clone();

    if typeof(p44) == "Instance" and p44:IsA("BasePart") then
        v45.Weld.Part0 = p44;
    elseif typeof(p44) == "CFrame" then
        v45.CFrame = p44;
    end;

    v45.Parent = p43;
    emitAll(v45);
    disposal(v45);
end;

local function setupAura(p46: userdata, p47: userdata) -- Line: 276
    for _, child in p47:GetChildren() do
        local v48 = p46:FindFirstChild(child.Name);

        if v48 then
            child.Name = "Aura";
            local v49 = child:FindFirstChild("Weld") or Instance.new("Weld");
            v49.Part0 = v48;
            v49.Part1 = child;
            v49.Parent = child;
        else
            child:Destroy();
        end;
    end;
end;

local function createData(p50, p51) -- Line: 292
    -- upvalues: u2 (copy)
    if not u2[p50] then
        u2[p50] = {};
    end;

    if not u2[p50][p51] then
        u2[p50][p51] = {};
    end;

    return u2[p50][p51];
end;

function u1.roulettevolley(u52) -- Line: 304
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage2 (copy), soundUtil (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), MeshEmitter (copy), UwUEffects (copy), TekrinnDialogue (copy)
    local v53 = u52.HumanoidRootPart or u52.PrimaryPart;
    local _ = u52.Torso;
    local _ = Lighting.Atmosphere;
    u52:FindFirstChild("Ball");
    mainreplication.bright(-1, 0.15);
    mainreplication.sceneEnabled(true);
    local u54, u55 = mainreplication.cutsceneBlender(v53, ReplicatedStorage2.Resources.nagi.roulettecam, ReplicatedStorage2.Resources.nagi.rouletteFOV);
    task.spawn(function() -- Line: 317
        -- upvalues: ReplicatedStorage2 (ref), u54 (copy)
        for _, child in ReplicatedStorage2.Resources.nagi.RouletteCam:GetChildren() do
            child:Clone().Parent = u54.CamPart;
        end;
    end);
    local v56 = soundUtil:play(ReplicatedStorage2.Resources.nagi.nagiroulette, ReplicatedStorage2, {
        Character = u52
    });
    local u57 = ReplicatedStorage2.Resources.nagi.nagiroulettecc:Clone();
    u57.Parent = game.Lighting;

    if Util.canshiftcolor(LocalPlayer, u52) then
        vfxUtil.LeanTowardsColor(u57, u52:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u52:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u58 = MeshEmitter.StartMeshEmitter(v53, ReplicatedStorage2.Resources.nagi.rouletteModel);
    Util.AttributeTween(u57);
    UwUEffects.createEffect({
        Character = u52
    }, "NagiRoulette");
    local ScreenDimmer = vfxUtil.getScreenDimmer();

    if v56.Name == "Dub" then
        task.delay(0.65, function() -- Line: 340
            -- upvalues: TekrinnDialogue (ref), u52 (copy)
            TekrinnDialogue.Speak(u52, {
                {
                    Text = "Huh..?",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 0.3);
        end);
        task.delay(2, function() -- Line: 366
            -- upvalues: TekrinnDialogue (ref), u52 (copy)
            TekrinnDialogue.Speak(u52, {
                {
                    Text = "I totally can..",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 2.667);
        end);
    else
        task.delay(0.65, function() -- Line: 392
            -- upvalues: TekrinnDialogue (ref), u52 (copy)
            TekrinnDialogue.Speak(u52, {
                {
                    Text = "Eh..?",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 0.3);
        end);
        task.delay(2, function() -- Line: 418
            -- upvalues: TekrinnDialogue (ref), u52 (copy)
            TekrinnDialogue.Speak(u52, {
                {
                    Text = "I totally can..",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 2.667);
        end);
    end;

    task.delay(8.35, function() -- Line: 445
        -- upvalues: ScreenDimmer (copy), u55 (copy), mainreplication (ref), u58 (copy), u57 (copy)
        ScreenDimmer:Destroy();

        if u55 then
            u55();
        end;

        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash();
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        u58:Destroy();
        u57:Destroy();
    end);
end;

function u1.fivestagevolley(p59) -- Line: 459
    -- upvalues: Lighting (copy), vfxUtil (copy), ReplicatedStorage2 (copy), PlayerGui (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), soundUtil (copy), MeshEmitter (copy), UwUEffects (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), Density (copy), Color (copy), ClockTime (copy)
    local v60 = p59.HumanoidRootPart or p59.PrimaryPart;
    local _ = p59.Humanoid;
    local Atmosphere = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local Ball = p59:FindFirstChild("Ball");
    pcall(function() -- Line: 467
        -- upvalues: Ball (copy)
        Ball.Size = Vector3.new(1.5, 1.5, 1.5);
    end);
    local u61 = ReplicatedStorage2.Resources.vb:Clone();
    u61.Parent = PlayerGui;
    local u62 = ReplicatedStorage2.Resources.glowscreen:Clone();
    u62.Parent = PlayerGui;
    u62.ImageLabel2.ImageTransparency = 0;
    u62.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 1;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 3.55;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.4;
    ColorCorrectionEffect.Saturation = -0.4;
    ColorCorrectionEffect.Brightness = 0;
    local u63 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u63.Parent = Lighting;
    u63.FarIntensity = 1;
    local v64 = mainreplication.cutscene(v60, CFrame.new(Vector3.new(0, 0, 0)), 16, ReplicatedStorage2.Resources.nagi.fivestagevolleyFOV);
    local u65 = ReplicatedStorage2.Resources.nagi.nagi5stagevolleycc:Clone();
    u65.Parent = game.Lighting;

    if Util.canshiftcolor(LocalPlayer, p59) then
        vfxUtil.LeanTowardsColor(u65, p59:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p59:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u66 = ReplicatedStorage2.Resources.nagi.fiveStageVolleyVignette:Clone();
    u66.Parent = PlayerGui;
    local u67 = Util.Preload(ReplicatedStorage2.Resources.nagi.FiveStarVolleyImpact);
    soundUtil:play(ReplicatedStorage2.Resources.nagi.FiveStarVolleySFX, ReplicatedStorage2);
    Util.AttributeTween(u66);
    Util.AttributeTween(u65);
    Util.CameraEffect(ReplicatedStorage2.Resources.nagi.fivestagevolleyCam, v64);
    task.delay(10.9, function() -- Line: 512
        -- upvalues: Util (ref), ReplicatedStorage2 (ref)
        Util.Gif(ReplicatedStorage2.Resources.nagi.FiveStarVolleyImpact, 40);
    end);
    local u68 = MeshEmitter.StartMeshEmitter(v60, ReplicatedStorage2.Resources.nagi.fiveStageVolleyModel);
    UwUEffects.createEffect({
        Character = p59
    }, "NagiFiveStageVolley", CFrame.Angles(-0.7330382858376184, 0.08726646259971647, 0));
    mainreplication.bright(-1, 0.15);
    mainreplication.sceneEnabled(true);
    task.delay(3.933, function() -- Line: 523
        -- upvalues: Lighting (ref)
        Lighting.ClockTime = 6;
    end);
    task.delay(16, function() -- Line: 527
        -- upvalues: ScreenDimmer (copy), Ball (copy), mainreplication (ref), u65 (copy), u68 (copy), u66 (copy), u67 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Atmosphere (copy), Density (ref), Color (ref), ClockTime (ref), ColorCorrectionEffect (copy), u61 (copy), u62 (copy), u63 (copy)
        ScreenDimmer:Destroy();
        pcall(function() -- Line: 530
            -- upvalues: Ball (ref)
            Ball.Size = Vector3.new(1.95, 1.95, 1.95);
        end);
        mainreplication.ultFlash();
        mainreplication.sceneEnabled(false);
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        u65:Destroy();
        u68:Destroy();
        u66:Destroy();
        u67:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ClockTime = ClockTime;

        if ColorCorrectionEffect then
            ColorCorrectionEffect:Destroy();
        end;

        u61:Destroy();
        u62:Destroy();
        u63:Destroy();
    end);
end;

function u1.newheavywindup(u69) -- Line: 559
    -- upvalues: ReplicatedStorage2 (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), trove (copy), MeshEmitter (copy), Players (copy), mainreplication (copy)
    local v70 = u69.HumanoidRootPart or u69.PrimaryPart;
    local v71 = ReplicatedStorage2.Resources.nagi.nagiheavyleg:Clone();
    v71.Weld.Part0 = u69["Right Leg"];
    v71.Parent = u69;
    local u72 = ReplicatedStorage2.Resources.nagi.heavywind:Clone();
    u72.Wind.Part0 = v70;
    u72.Parent = u69;

    if Util.canshiftcolor(LocalPlayer, u69) then
        vfxUtil.LeanTowardsColor({ u72, v71 }, u69:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u69:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u73 = trove.new();
    u73:Connect(u69:GetAttributeChangedSignal("shooting_motion"), function() -- Line: 576
        -- upvalues: u69 (copy), u73 (copy)
        if not u69:GetAttribute("shooting_motion") then
            u73:Destroy();
        end;
    end);
    u73:Connect(u69:GetAttributeChangedSignal("striking_motion"), function() -- Line: 582
        -- upvalues: u69 (copy), u73 (copy)
        if not u69:GetAttribute("striking_motion") then
            u73:Destroy();
        end;
    end);
    local v74 = MeshEmitter.StartMeshEmitter(v70, ReplicatedStorage2.Resources.nagi["HEAVY MeshEmitter"], nil, 3);
    v74.Parent = workspace.Effects;
    u73:Add(v74);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u69) then
        mainreplication.fov(true, 90, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
    end;

    for _, descendant in pairs(v71:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(2, v71.Destroy, v71);

    for _, descendant in ipairs(u72:GetDescendants()) do
        if descendant:IsA("Beam") then
            game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.25), {
                Width0 = 0,
                Width1 = 5
            }):Play();
        end;
    end;

    task.delay(0.3, function() -- Line: 612
        -- upvalues: u72 (copy)
        for _, descendant in ipairs(u72:GetDescendants()) do
            if descendant:IsA("Beam") then
                game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.12), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end;
        end;
    end);
    task.delay(2, u72.Destroy, u72);
end;

function u1.newheavykicked(p75) -- Line: 624
    -- upvalues: mainreplication (copy), ReplicatedStorage2 (copy), Players (copy), Lighting (copy), TweenService (copy)
    mainreplication.Emit(p75.HumanoidRootPart or p75.PrimaryPart, ReplicatedStorage2.Resources.nagi.heavykickeffect, 3, CFrame.new(Vector3.new(-0, -0, -3)));

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p75) then
        mainreplication.springcamerashake(60, 50);
        mainreplication.fov(false, 40);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    local v76 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
    v76.Parent = Lighting;
    v76.TintColor = Color3.fromRGB(151, 144, 255);
    v76.Brightness = 0.4;
    v76.Contrast = 1;
    v76.Saturation = -0.4;
    TweenService:Create(v76, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v76, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(2, v76.Destroy, v76);
end;

function u1.newheavykick(u77) -- Line: 648
    -- upvalues: u1 (copy)
    u1.newheavywindup(u77);
    task.delay(0.35, function() -- Line: 650
        -- upvalues: u1 (ref), u77 (copy)
        u1.newheavykicked(u77);
    end);
end;

function u1.nagiawaken(u78) -- Line: 655
    -- upvalues: Util (copy), ReplicatedStorage2 (copy), animationUtil (copy), mainreplication (copy), soundUtil (copy), UwUEffects (copy), TekrinnDialogue (copy)
    local v79 = u78.HumanoidRootPart or u78.PrimaryPart;
    local _ = u78.Humanoid;
    local _ = u78.Torso;
    local u80 = Util.Preload(ReplicatedStorage2.Resources.nagi.NagiFlowImpact);
    local u81 = ReplicatedStorage2.Resources.nagi.Skull:Clone();
    u81:PivotTo(v79.CFrame);
    u81.Parent = u78;
    local v82 = animationUtil:loadAnimation(u81, ReplicatedStorage2.Resources.nagi.nagiawakenskull);
    local u83 = ReplicatedStorage2.Resources.nagi.awakenCC:Clone();
    u83.Parent = game.Lighting;
    local v84 = mainreplication.cutscene(v79, CFrame.new(Vector3.new(0, 0, 0)), 7.25, ReplicatedStorage2.Resources.nagi["2FOV"]);
    Util.CameraEffect(ReplicatedStorage2.Resources.nagi.Cam, v84);
    local v85 = soundUtil:play(ReplicatedStorage2.Resources.nagi.awakenSound, ReplicatedStorage2, {
        Character = u78
    });
    UwUEffects.createEffect({
        Character = u78
    }, "NagiFlow");
    Util.AttributeTween(u83);
    Util.MidDarkLighting();
    v82:Play(0);
    mainreplication.sceneEnabled(true);

    if v85.Name == "Dub" then
        task.delay(0.5, function() -- Line: 686
            -- upvalues: TekrinnDialogue (ref), u78 (copy)
            TekrinnDialogue.Speak(u78, {
                {
                    Text = "You can\'t beat me...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 2.867);
        end);
        task.delay(2, function() -- Line: 712
            -- upvalues: TekrinnDialogue (ref), u78 (copy)
            TekrinnDialogue.Speak(u78, {
                {
                    Text = "You know.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 2.867);
        end);
        task.delay(4, function() -- Line: 738
            -- upvalues: TekrinnDialogue (ref), u78 (copy)
            TekrinnDialogue.Speak(u78, {
                {
                    Text = "Bring it.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 0, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 1);
        end);
    else
        task.delay(0.5, function() -- Line: 764
            -- upvalues: TekrinnDialogue (ref), u78 (copy)
            TekrinnDialogue.Speak(u78, {
                {
                    Text = "You can\'t.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 2.867);
        end);
        task.delay(2, function() -- Line: 790
            -- upvalues: TekrinnDialogue (ref), u78 (copy)
            TekrinnDialogue.Speak(u78, {
                {
                    Text = "Beat me.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 2.867);
        end);
        task.delay(4, function() -- Line: 816
            -- upvalues: TekrinnDialogue (ref), u78 (copy)
            TekrinnDialogue.Speak(u78, {
                {
                    Text = "Bring it.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 0, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 1);
        end);
    end;

    task.delay(6.6, function() -- Line: 845
        -- upvalues: Util (ref), ReplicatedStorage2 (ref), u81 (copy), mainreplication (ref), u83 (copy), u80 (copy)
        Util.Gif(ReplicatedStorage2.Resources.nagi.NagiFlowImpact, 40);
        Util.ReturnLighting();
        task.wait(0.74);
        u81:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash();
        u83:Destroy();
        task.wait(0.5);
        u80:Destroy();
    end);
end;

function u1.newcontrolgoal(u86) -- Line: 859
    -- upvalues: Lighting (copy), ReplicatedStorage2 (copy), PlayerGui (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), soundUtil (copy), SoundService (copy), MeshEmitter (copy), TekrinnDialogue (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), Density (copy), Color (copy)
    local v87 = u86.HumanoidRootPart or u86.PrimaryPart;
    local Ball = u86:FindFirstChild("Ball");
    local Atmosphere = Lighting.Atmosphere;
    local v88 = ReplicatedStorage2.Resources.vb:Clone();
    v88.Parent = PlayerGui;
    local v89 = ReplicatedStorage2.Resources.glowscreen:Clone();
    v89.Parent = PlayerGui;
    v89.ImageLabel2.ImageTransparency = 0;
    v89.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 1;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 3.55;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.4;
    ColorCorrectionEffect.Saturation = -0.4;
    ColorCorrectionEffect.Brightness = 0;
    local v90 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    v90.Parent = Lighting;
    v90.FarIntensity = 1;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1, 1, true);
    local u91 = ReplicatedStorage2.Resources.nagi.controlgoalassets:Clone();
    u91:PivotTo(v87.CFrame);
    u91.Parent = u86;

    if Util.canshiftcolor(LocalPlayer, u86) then
        vfxUtil.LeanTowardsColor(u91, u86:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u86:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u92 = ReplicatedStorage2.Resources.nagi.controlgoalcam:Clone();
    u92.Parent = u86;
    local u93 = ReplicatedStorage2.Resources.nagi.controltrailleg:Clone();
    u93.Parent = u86;
    u93.Weld.Part0 = u86["Right Leg"];
    local u94 = nil;
    u94 = RunService.PreRender:connect(function() -- Line: 906
        -- upvalues: u92 (copy), u94 (ref)
        if u92:IsDescendantOf(game) then
            u92.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u94:Disconnect();
    end);
    local u95 = ReplicatedStorage2.Resources.nagi.controlgoalball:Clone();
    u95.Weld.Part0 = Ball;
    u95.Parent = Ball;
    local v96 = soundUtil:play(ReplicatedStorage2.Resources.nagi.controlgoals, SoundService, {
        Character = u86
    });
    MeshEmitter.StartMeshEmitter(v87, ReplicatedStorage2.Resources.nagi["NagiControl MeshEmitter"]);
    mainreplication.CutsceneCustom(v87, ReplicatedStorage2.Resources.nagi.nagicontrolgoalcam, ReplicatedStorage2.Resources.nagi.FOV6);

    if v96.Name == "Dub" then
        task.delay(0.01, function() -- Line: 920
            -- upvalues: TekrinnDialogue (ref), u86 (copy)
            TekrinnDialogue.Speak(u86, {
                {
                    Text = "Blame my curiosity, it can\'t be stopped!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.045,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 2.667
                    }
                }
            }, 4);
        end);
        task.delay(3, function() -- Line: 945
            -- upvalues: TekrinnDialogue (ref), u86 (copy)
            TekrinnDialogue.Speak(u86, {
                {
                    Text = "For the first time in my life...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.9
                    }
                }
            }, 1.9);
        end);
        task.delay(5.7, function() -- Line: 971
            -- upvalues: TekrinnDialogue (ref), u86 (copy)
            TekrinnDialogue.Speak(u86, {
                {
                    Text = "I want a challenge!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 1.9
                    }
                }
            }, 1.9);
        end);
    else
        task.delay(0.01, function() -- Line: 997
            -- upvalues: TekrinnDialogue (ref), u86 (copy)
            TekrinnDialogue.Speak(u86, {
                {
                    Text = "This curiosity of mine can\'t be stopped...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 2.667
                    }
                }
            }, 4);
        end);
        task.delay(3, function() -- Line: 1022
            -- upvalues: TekrinnDialogue (ref), u86 (copy)
            TekrinnDialogue.Speak(u86, {
                {
                    Text = "With soccer...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.9
                    }
                }
            }, 1.9);
        end);
        task.delay(5.7, function() -- Line: 1048
            -- upvalues: TekrinnDialogue (ref), u86 (copy)
            TekrinnDialogue.Speak(u86, {
                {
                    Text = "I want to challenge myself!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 1.9
                    }
                }
            }, 1.9);
        end);
    end;

    task.delay(0.23333333333333334, function() -- Line: 1075
        -- upvalues: u95 (copy), u91 (copy)
        for _, descendant in pairs(u95["2"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u91:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u95:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.8666666666666667, function() -- Line: 1089
        -- upvalues: u92 (copy)
        for _, descendant in pairs(u92:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.5833333333333335, function() -- Line: 1098
        -- upvalues: u93 (copy), u95 (copy), u92 (copy)
        for _, descendant in pairs(u93:GetDescendants()) do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u95["2"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u95:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u92:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.033333333333333, function() -- Line: 1125
        -- upvalues: u91 (copy)
        for _, descendant in pairs(u91["3"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.833333333333333, function() -- Line: 1128
        -- upvalues: u93 (copy), u91 (copy)
        for _, descendant in pairs(u93.TrailHolder:GetDescendants()) do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u91["4"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5.033333333333333, function() -- Line: 1139
        -- upvalues: u95 (copy)
        for _, descendant in pairs(u95["4.5"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5.383333333333334, function() -- Line: 1142
        -- upvalues: u92 (copy)
        for _, descendant in pairs(u92.BeamHolder1:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.166666666666667, function() -- Line: 1151
        -- upvalues: u92 (copy)
        for _, descendant in pairs(u92.BeamHolder1:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(6.35, function() -- Line: 1160
        -- upvalues: u91 (copy), u95 (copy)
        for _, descendant in pairs(u91["5"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u95:GetDescendants()) do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.466666666666667, function() -- Line: 1171
        -- upvalues: u91 (copy)
        for _, descendant in pairs(u91["6"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(7.016666666666667, function() -- Line: 1174
        -- upvalues: u95 (copy)
        for _, descendant in pairs(u95:GetDescendants()) do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.wait(7.07);
    u91:Destroy();
    u93:Destroy();
    mainreplication.fov(false, 15);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    Lighting.Brightness = Brightness;
    Lighting.Bloom.Threshold = Threshold;
    Lighting.ExposureCompensation = ExposureCompensation;
    Lighting.Ambient = Ambient;
    Atmosphere.Density = Density;
    Atmosphere.Color = Color;

    if ColorCorrectionEffect then
        ColorCorrectionEffect:Destroy();
    end;

    u91:Destroy();
    mainreplication.sceneEnabled(false);
    mainreplication.ultFlash(1, 1, true);
    v88:Destroy();
    v89:Destroy();
    v90:Destroy();
end;

function u1.groundcontrolstart(p97, p98) -- Line: 1210
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage2 (copy), Lighting (copy), TweenService (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy)
    local u99 = p98 or 1;
    local u100 = p97.HumanoidRootPart or p97.PrimaryPart;
    local _ = p97.Humanoid;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p97) then
        mainreplication.fov(false, 40);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(20, 40);
        local v101 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
        v101.Parent = Lighting;
        v101.TintColor = Color3.fromRGB(151, 144, 255);
        v101.Brightness = 0.4;
        v101.Contrast = 1;
        v101.Saturation = -0.4;
        TweenService:Create(v101, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v101, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v101.Destroy, v101);
    end;

    local u102 = ReplicatedStorage2.Resources.nagi.newgroundcontroleffect:Clone();
    u102.Weld.Part0 = u100;
    u102.Parent = p97;
    local u103 = ReplicatedStorage2.Resources.nagi.groundcontroltrail:Clone();
    u103.Weld.Part0 = p97["Left Arm"];
    u103.Parent = u102;
    local u104 = ReplicatedStorage2.Resources.nagi.groundcontroltrail:Clone();
    u104.Weld.Part0 = p97["Right Arm"];
    u104.Parent = u102;
    local u105 = ReplicatedStorage2.Resources.nagi.groundcontroltrail:Clone();
    u105.Weld.Part0 = p97["Left Leg"];
    u105.Parent = u102;
    local u106 = ReplicatedStorage2.Resources.nagi.groundcontroltrail:Clone();
    u106.Weld.Part0 = p97["Right Leg"];
    u106.Parent = u102;

    if Util.canshiftcolor(LocalPlayer, p97) then
        vfxUtil.LeanTowardsColor({
            u102,
            u103,
            u104,
            u105,
            u106
        }, p97:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p97:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in pairs(u102["1"]:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    mainreplication.bodyVelocity(u100, 190 * u99, 2, nil, nil, nil);
    task.delay(0.1, function() -- Line: 1267
        -- upvalues: mainreplication (ref), u100 (copy), u99 (copy)
        mainreplication.bodyVelocity(u100, 90 * u99, 2, nil, nil, nil);
    end);
    task.delay(0.817, function() -- Line: 1270
        -- upvalues: u102 (copy), u103 (copy), u104 (copy), u105 (copy), u106 (copy)
        for _, descendant in pairs(u102["1"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u103:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u104:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u105:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u106:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2, u102.Destroy, u102);
end;

function u1.groundcontrolend(p107, p108) -- Line: 1302
    -- upvalues: ReplicatedStorage2 (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), mainreplication (copy)
    local v109 = p108 or 1;
    local v110 = p107.HumanoidRootPart or p107.PrimaryPart;
    local _ = p107.Humanoid;
    local v111 = ReplicatedStorage2.Resources.nagi.newgroundcontroleffect:Clone();
    v111.Weld.Part0 = v110;
    v111.Parent = p107;

    if Util.canshiftcolor(LocalPlayer, p107) then
        vfxUtil.LeanTowardsColor({ v111 }, p107:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p107:GetAttribute("CustomAlpha") or 0.985);
    end;

    local v112 = v111["2"];
    local Descendants = v112:GetDescendants();
    local Children = v112:GetChildren();

    for _, v in ipairs(Descendants or Children) do
        if v:IsA("ParticleEmitter") then
            v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
        end;
    end;

    if not p107:GetAttribute("ZeroResetBackDash") then
        mainreplication.bodyVelocity(v110, 125 * v109, 0.5, nil, nil, nil);
    end;

    task.delay(2, v111.Destroy, v111);
end;

function u1.groundcontrolconfirm(u113: userdata, p114: any) -- Line: 1334
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage2 (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Lighting (copy), TweenService (copy)
    local u115 = p114 or 1;
    local u116 = u113.HumanoidRootPart or u113.PrimaryPart;
    local _ = u113.Humanoid;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u113) then
        mainreplication.springcamerashake(15, 40);
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    local u117 = ReplicatedStorage2.Resources.nagi.groundcontrolhit:Clone();
    u117.Weld.Part0 = u116;
    u117.Parent = u113;
    local u118 = ReplicatedStorage2.Resources.nagi.groundcontroltrail:Clone();
    u118.Weld.Part0 = u113["Left Arm"];
    u118.Parent = u117;
    local u119 = ReplicatedStorage2.Resources.nagi.groundcontroltrail:Clone();
    u119.Weld.Part0 = u113["Right Arm"];
    u119.Parent = u117;
    local u120 = ReplicatedStorage2.Resources.nagi.groundcontroltrail:Clone();
    u120.Weld.Part0 = u113["Left Leg"];
    u120.Parent = u117;
    local u121 = ReplicatedStorage2.Resources.nagi.groundcontroltrail:Clone();
    u121.Weld.Part0 = u113["Right Leg"];
    u121.Parent = u117;

    if Util.canshiftcolor(LocalPlayer, u113) then
        vfxUtil.LeanTowardsColor({
            u117,
            u118,
            u119,
            u120,
            u121
        }, u113:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u113:GetAttribute("CustomAlpha") or 0.985);
    end;

    mainreplication.bodyVelocity(u116, 85 * u115, 2, nil, nil, nil, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), 0.5);
    task.delay(0.183, function() -- Line: 1385
        -- upvalues: u117 (copy)
        local v122 = u117["1"];
        local Descendants = v122:GetDescendants();
        local Children = v122:GetChildren();

        for _, v in ipairs(Descendants or Children) do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.367, function() -- Line: 1399
        -- upvalues: u117 (copy), Players (ref), u113 (copy), mainreplication (ref)
        local v123 = u117["2"];
        local Descendants = v123:GetDescendants();
        local Children = v123:GetChildren();

        for _, v in ipairs(Descendants or Children) do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u113) then
            mainreplication.springcamerashake(8, 5);
        end;
    end);
    task.delay(0.517, function() -- Line: 1417
        -- upvalues: u117 (copy)
        local v124 = u117["2.5"];
        local Descendants = v124:GetDescendants();
        local Children = v124:GetChildren();

        for _, v in ipairs(Descendants or Children) do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1, function() -- Line: 1432
        -- upvalues: u113 (copy), u117 (copy), Players (ref), mainreplication (ref), ReplicatedStorage2 (ref), Lighting (ref), TweenService (ref), u118 (copy), u119 (copy), u120 (copy), u121 (copy)
        if u113:FindFirstChild("Ball") and not u113:GetAttribute("ZeroResetBackDash") then
            local v125 = u117["3"];
            local Descendants = v125:GetDescendants();
            local Children = v125:GetChildren();

            for _, v in ipairs(Descendants or Children) do
                if v:IsA("ParticleEmitter") then
                    v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
                end;
            end;

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u113) then
                mainreplication.springcamerashake(8, 15);
                local v126 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
                v126.Parent = Lighting;
                v126.TintColor = Color3.fromRGB(151, 144, 255);
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
            end;
        end;

        for _, descendant in pairs(u118:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u119:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u120:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u121:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
    local u127 = u113:GetAttribute("ZeroResetBackDash") == true;
    local u128 = nil;

    if not u127 then
        u128 = u113:GetAttributeChangedSignal("ZeroResetBackDash"):Once(function() -- Line: 1490
            -- upvalues: u113 (copy), u127 (ref), u128 (ref)
            if u113:GetAttribute("ZeroResetBackDash") then
                u127 = true;
                u128:Disconnect();
            end;
        end);
    end;

    task.delay(0.9, function() -- Line: 1499
        -- upvalues: u127 (ref), mainreplication (ref), u116 (copy), u115 (copy)
        if not u127 then
            mainreplication.bodyVelocity(u116, 35 * u115, 0.8, nil, nil, nil, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), 0.125);
        end;
    end);
    task.delay(1.2, function() -- Line: 1505
        -- upvalues: u127 (ref), mainreplication (ref), u116 (copy), u115 (copy)
        if not u127 then
            mainreplication.bodyVelocity(u116, 50 * u115, 0.4, nil, nil, nil, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), 0.125);
        end;
    end);
    task.delay(2, function() -- Line: 1511
        -- upvalues: u128 (ref), u117 (copy)
        if typeof(u128) == "RBXScriptConnection" then
            u128:Disconnect();
        end;

        u117:Destroy();
    end);
end;

function u1.newzeroreturn(u129: userdata) -- Line: 1519
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage2 (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Lighting (copy), TweenService (copy), RunService (copy)
    local u130 = u129.HumanoidRootPart or u129.PrimaryPart;
    local _ = u129.Humanoid;
    local Ball = u129:FindFirstChild("Ball");

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u129) then
        mainreplication.fov(true, 90, 0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        mainreplication.springcamerashake(15, 40);
    end;

    local u131 = ReplicatedStorage2.Resources.nagi.newzeroreturneffect:Clone();
    u131.Weld.Part0 = u130;
    u131.Parent = u129;
    local u132 = ReplicatedStorage2.Resources.nagi.zeroreturnballeffect:Clone();
    u132.Weld.Part0 = Ball;
    u132.Parent = u131;

    if Util.canshiftcolor(LocalPlayer, u129) then
        vfxUtil.LeanTowardsColor({ u131, u132 }, u129:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u129:GetAttribute("CustomAlpha") or 0.985);
    end;

    mainreplication.bodyVelocity(u130, 77, 0.4, nil, nil, nil, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
    task.delay(0.067, function() -- Line: 1543
        -- upvalues: u131 (copy)
        local v133 = u131["1"];
        local Descendants = v133:GetDescendants();
        local Children = v133:GetChildren();

        for _, v in ipairs(Descendants or Children) do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.383, function() -- Line: 1557
        -- upvalues: u131 (copy), u132 (copy)
        local v134 = u131["2"];
        local Descendants = v134:GetDescendants();
        local Children = v134:GetChildren();

        for _, v in ipairs(Descendants or Children) do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u132["2.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        local tra = u132:WaitForChild("tra");

        for _, descendant in pairs(tra:GetDescendants()) do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.767, function() -- Line: 1587
        -- upvalues: u132 (copy)
        for _, descendant in pairs(u132["2.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        local tra = u132:WaitForChild("tra");

        for _, descendant in pairs(tra:GetDescendants()) do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.4, function() -- Line: 1604
        -- upvalues: Players (ref), u129 (copy), mainreplication (ref), ReplicatedStorage2 (ref), Lighting (ref), TweenService (ref), u130 (copy), RunService (ref)
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u129) then
            mainreplication.springcamerashake(20, 40);
            mainreplication.fov(false, 40);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local v135 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
            v135.Parent = Lighting;
            v135.TintColor = Color3.fromRGB(151, 144, 255);
            v135.Brightness = 0.4;
            v135.Contrast = 1;
            v135.Saturation = -0.4;
            TweenService:Create(v135, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v135, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v135.Destroy, v135);
        end;

        local u136 = false;
        local u137 = 120;
        local u138 = 10;
        local u139 = tick();
        local u140, u141, u142 = mainreplication.bodyVelocity(u130, u137, 0.5, nil, nil, true);
        local u143 = 15;
        local u144 = 0;
        local u145 = nil;
        u145 = RunService.RenderStepped:Connect(function(p146) -- Line: 1637
            -- upvalues: u140 (copy), u145 (ref), u136 (ref), u129 (ref), u137 (ref), u138 (ref), u139 (copy), u142 (ref), u141 (copy), TweenService (ref), u144 (ref), u143 (ref), u130 (ref)
            local math_min_ret = math.min(p146, 0.03333333333333333);

            if not (u140 and u140:IsDescendantOf(game)) then
                u145:Disconnect();

                return;
            end;

            if not u136 and u129:GetAttribute("ZeroResetBackDash") == true then
                u136 = true;
                u137 = 200;
                u138 = 0;
                local v147 = tick() - u139;
                u142:Pause();
                u141.Value = math.lerp(u137, 0, v147 / 0.5);
                u142 = TweenService:Create(u141, TweenInfo.new(0.5 - v147, Enum.EasingStyle.Linear), {
                    Value = 0
                });
                u142:Play();
            end;

            u144 = u144 + math_min_ret;
            u143 = u143 + math.sin(u144 * -5) * math_min_ret * 200;
            u143 = math.clamp(u143, 0, (1 / 0));
            u140.Velocity = -u130.CFrame.LookVector * u141.Value - u130.CFrame.RightVector * -(u143 * u138);
        end);
        task.delay(15, u145.Disconnect, u145);
    end);
    task.delay(2, u131.Destroy, u131);
end;

function u1.nagicontrolwindup(u148) -- Line: 1674
    -- upvalues: ReplicatedStorage2 (copy), Players (copy), mainreplication (copy), RunService (copy)
    local u149 = u148.HumanoidRootPart or u148.PrimaryPart;
    local _ = u148.Torso;
    local u150 = ReplicatedStorage2.Resources.armdrip:Clone();
    u150.Parent = u148;
    u150.Weld.Part0 = u148["Left Arm"];
    local u151 = ReplicatedStorage2.Resources.armdrip:Clone();
    u151.Parent = u148;
    u151.Weld.Part0 = u148["Right Arm"];
    task.delay(0.35, function() -- Line: 1688
        -- upvalues: u150 (copy), u151 (copy)
        for _, descendant in ipairs(u150:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u151:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u150.Destroy, u150);
        task.delay(2, u151.Destroy, u151);
    end);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u148) then
        mainreplication.springcamerashake(40, 30);
    end;

    local u152 = mainreplication.bodyVelocity(u149, 1, 0.35, nil, nil, true);

    if u152 then
        u152.MaxForce = Vector3.new(300000, 300000, 300000);
        local u153 = nil;
        local u154 = u148:GetAttribute("RinNoPlay") and 200 or 78;
        u153 = RunService.RenderStepped:Connect(function(p155) -- Line: 1715
            -- upvalues: u152 (copy), u153 (ref), u148 (copy), u149 (copy), u154 (ref)
            if not (u152 and u152:IsDescendantOf(game)) then
                u153:Disconnect();

                return;
            end;

            local MoveDirection = u148.Humanoid.MoveDirection;
            local LookVector = u149.CFrame.LookVector;

            if MoveDirection.Magnitude > 0 then
                LookVector = (LookVector * 0.7 + MoveDirection.Unit * 0.5).Unit;
            end;

            u152.Velocity = LookVector * u154 + u149.CFrame.UpVector * 60;
        end);
        task.delay(15, u153.Disconnect, u153);
    end;

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u148) then
        return;
    end;

    mainreplication.cameraShake(15, 0.7, 4);
    mainreplication.fov(false, 90);
    mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.nagicontrol(p156) -- Line: 1742
    -- upvalues: ReplicatedStorage2 (copy), Players (copy), mainreplication (copy), RunService (copy), TweenService (copy)
    local u157 = p156.HumanoidRootPart or p156.PrimaryPart;
    local _ = p156.Torso;
    local Ball = p156:FindFirstChild("Ball");
    local v158 = ReplicatedStorage2.Resources.nagi.controlWind:Clone();
    v158.Weld.Part0 = u157;
    v158.Parent = p156;

    if Ball then
        local v159 = ReplicatedStorage2.Resources.controlBall:Clone();
        v159.Weld.Part0 = Ball;
        v159.Parent = v158;

        for _, descendant in ipairs(v159:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if descendant.Parent == v159.Emit then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                else
                    descendant.Enabled = true;
                end;
            end;
        end;
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p156) then
        mainreplication.springcamerashake(15, 60);
    end;

    mainreplication.fov(false, 50);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p156) then
        local u160, u161 = mainreplication.bodyVelocity(u157, 60, 1, nil, nil, true, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
        u160.MaxForce = Vector3.new(300000, 300000, 300000);
        local u162 = nil;
        u162 = RunService.RenderStepped:Connect(function(p163) -- Line: 1798
            -- upvalues: u160 (copy), u162 (ref), u157 (copy), u161 (copy)
            if u160 and u160:IsDescendantOf(game) then
                u160.Velocity = u157.CFrame.LookVector * 20 + u157.CFrame.UpVector * u161.Value;

                return;
            end;

            u162:Disconnect();
        end);
        task.delay(15, u162.Disconnect, u162);
    end;

    task.wait(1.0499999523162842);

    for _, descendant in ipairs(v158:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        elseif descendant:IsA("Beam") then
            TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Width0 = 0,
                Width1 = 0
            }):Play();
        end;
    end;

    task.delay(1, v158.Destroy, v158);
end;

function u1.nagi4(p164, u165) -- Line: 1830
    -- upvalues: mainreplication (copy), ReplicatedStorage2 (copy), Lighting (copy), TweenService (copy), RunService (copy)
    local u166 = p164.HumanoidRootPart or p164.PrimaryPart;
    local _ = p164.Humanoid;
    mainreplication.bodyVelocity(u166, 70, 0.4, nil, nil, nil, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
    task.delay(0.4, function() -- Line: 1836
        -- upvalues: mainreplication (ref), ReplicatedStorage2 (ref), Lighting (ref), TweenService (ref), u166 (copy), RunService (ref), u165 (copy)
        mainreplication.cameraShake(10, 1.5, 6);
        local v167 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
        v167.Parent = Lighting;
        v167.TintColor = Color3.fromRGB(115, 0, 255);
        v167.Brightness = 0.4;
        v167.Contrast = 1;
        v167.Saturation = -0.4;
        TweenService:Create(v167, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v167, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v167.Destroy, v167);
        local u168, u169 = mainreplication.bodyVelocity(u166, 120, 0.5, nil, nil, true);
        local u170 = 15;
        local u171 = 0;
        local u172 = nil;
        u172 = RunService.RenderStepped:Connect(function(p173) -- Line: 1870
            -- upvalues: u168 (copy), u172 (ref), u171 (ref), u170 (ref), u165 (ref), u166 (ref), u169 (copy)
            local math_min_ret = math.min(p173, 0.03333333333333333);

            if not (u168 and u168:IsDescendantOf(game)) then
                u172:Disconnect();

                return;
            end;

            u171 = u171 + math_min_ret;
            u170 = u170 + math.sin(u171 * -5) * math_min_ret * 200;
            u170 = math.clamp(u170, 0, (1 / 0));
            u168.Velocity = -u166.CFrame.LookVector * u169.Value - (not u165 and u166.CFrame.RightVector * -(u170 * 10) or u166.CFrame.RightVector * (u170 * 10));
        end);
        task.delay(15, u172.Disconnect, u172);
    end);
end;

function u1.NagiOffBallV2(u174) -- Line: 1892
    -- upvalues: vfxUtil (copy), KatUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), mainreplication (copy), PlayerGui (copy), Util (copy), ReplicatedStorage2 (copy), animationUtil (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy)
    local OffballV2 = vfxUtil.getResources().nagi.OffballV2;
    local _track = KatUtil.get_track(u174, OffballV2.UserAnimation);
    local Root = vfxUtil.getRoot(u174);

    if not _track then
        return;
    end;

    local function apply_lighting() -- Line: 1900
        -- upvalues: Lighting (ref), OffballV2 (copy)
        local Children = Lighting:GetChildren();
        local u175 = {};
        local u176 = {};

        for _, v in Children do
            v.Parent = nil;
        end;

        for _, child in OffballV2.Lighting:GetChildren() do
            local v177 = child:Clone();
            v177.Parent = Lighting;
            table.insert(u175, v177);
        end;

        for i, v in OffballV2.Lighting:GetAttributes() do
            u176[i] = Lighting[i];
            Lighting[i] = v;
        end;

        return function() -- Line: 1921
            -- upvalues: u175 (copy), u176 (copy), Lighting (ref), Children (copy)
            for _, v in u175 do
                v:Destroy();
            end;

            for i, v in u176 do
                Lighting[i] = v;
            end;

            for _, v in Children do
                v.Parent = Lighting;
            end;
        end;
    end;

    local v178 = _track.construct(MoonPropertyAnimator);
    local _, v179 = mainreplication.cutsceneCamRigWithLetterBox(Root, OffballV2.CameraAnimation, OffballV2.FOV, u174, CFrame.new(0, -3, 0), OffballV2.Cameraa, "CamPart");
    local u180 = _track.clone(OffballV2.StepThing);
    local v181 = _track.clone(OffballV2.Stuff);
    local v182 = _track.clone(OffballV2.Skull);
    v181.Parent = PlayerGui;
    v182:PivotTo(Root.CFrame);
    v182.Parent = workspace.Effects;
    u180.Parent = workspace.Effects;
    u180.CFrame = Root.CFrame * CFrame.new(0.442650706, -2.99950027, -0.0207190067, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    _track.add(vfxUtil.getScreenDimmer());
    task.spawn(function() -- Line: 1950
        -- upvalues: Util (ref), ReplicatedStorage2 (ref)
        Util.Preload(ReplicatedStorage2.Resources.nagi.NagiFlowImpact);
    end);
    animationUtil:loadAnimation(v182, OffballV2.SkullAnimation):Play();
    local u183 = soundUtil:play(OffballV2.Sound, SoundService, {
        Character = u174
    });
    _track.add((apply_lighting()));
    _track.add(v179);
    _track.add(function() -- Line: 1958
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1, true);
    end);
    mainreplication.sceneEnabled(true);
    local u184 = {};

    for _, child in OffballV2.Body:GetChildren() do
        local v185 = _track.add(vfxUtil.createVFX(child, "default", u174:FindFirstChild(child.Name)));
        u184[child.Name] = v185;
    end;

    v178:LoadAndConvertSave(OffballV2.Moon, {
        Vignette = v181.Vignette,
        ColorCorrection = Lighting.ColorCorrection,
        Atmosphere = Lighting.Atmosphere,
        Lighting = Lighting,
        Blur = Lighting.Blur,
        DepthOfField = Lighting.DepthOfField
    });
    v178:PlayAll();
    _track.add(KatUtil.frame_delay(32, function() -- Line: 1980
        -- upvalues: vfxUtil (ref), u180 (copy)
        vfxUtil.disposal(u180, 5);
        vfxUtil.forge.emit(u180);
    end));
    _track.add(KatUtil.frame_delay(90, function() -- Line: 1986
        -- upvalues: _track (copy), OffballV2 (copy), Root (copy), vfxUtil (ref)
        local v186 = _track.clone(OffballV2.nagiroulettevolleyemit);
        v186.Parent = workspace.Effects;
        v186.CFrame = Root.CFrame * CFrame.new(
            0.41016227,
            -2.8109026,
            0.0658284724,
            1.00000179,
            1.49010691e-6,
            -2.38418988e-6,
            -1.78812968e-6,
            1.00000048,
            -5.96051052e-7,
            2.86102613e-6,
            7.15266424e-7,
            1.00000167
        );
        vfxUtil.disposal(v186, 5);
        vfxUtil.forge.emit(v186);
    end));
    _track.add(KatUtil.frame_delay(150, function() -- Line: 1995
        -- upvalues: _track (copy), OffballV2 (copy), Root (copy), vfxUtil (ref)
        local v187 = _track.clone(OffballV2.nagirouletteambience);
        v187.Parent = workspace.Effects;
        v187.CFrame = Root.CFrame * CFrame.new(
            0.705526352,
            2.39862108,
            -3.25507379,
            1.00000107,
            0,
            -2.98023224e-8,
            0,
            1,
            0,
            2.98023224e-8,
            0,
            1.00000107
        );
        vfxUtil.disposal(v187, 10);
        vfxUtil.forge.emit(v187);
    end));
    _track.add(KatUtil.frame_delay(233, function() -- Line: 2004
        -- upvalues: u184 (copy), vfxUtil (ref)
        for _, v in u184 do
            vfxUtil.forge.emit(v);
        end;
    end));
    _track.add(KatUtil.frame_delay(6, function() -- Line: 2010
        -- upvalues: u183 (copy), TekrinnDialogue (ref), u174 (copy), _track (copy), KatUtil (ref)
        if u183.Name == "Dub" then
            TekrinnDialogue.Speak(u174, {
                {
                    Text = "I\'m gonna devour your ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 20
                    }
                },
                {
                    Text = "soccer!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 20
                    }
                }
            }, 4);
            _track.add(KatUtil.frame_delay(205, function() -- Line: 2061
                -- upvalues: TekrinnDialogue (ref), u174 (ref)
                TekrinnDialogue.Speak(u174, {
                    {
                        Text = "Swallow it... ",
                        Bold = false,
                        Italic = false,
                        TypeSpeed = 0.02,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = false,
                            Intensity = 3,
                            Lifetime = 0.8
                        }
                    },
                    {
                        Text = "fire and all!",
                        Bold = true,
                        Italic = true,
                        TypeSpeed = 0.02,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = true,
                            Intensity = 3,
                            Lifetime = 0.8
                        }
                    }
                }, 4);
            end));
            _track.add(KatUtil.frame_delay(347, function() -- Line: 2111
                -- upvalues: TekrinnDialogue (ref), u174 (ref)
                TekrinnDialogue.Speak(u174, {
                    {
                        Text = "Sorry...",
                        Bold = false,
                        Italic = false,
                        TypeSpeed = 0.02,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = false,
                            Intensity = 2,
                            Lifetime = 20
                        }
                    }
                }, 3);
            end));
            _track.add(KatUtil.frame_delay(435, function() -- Line: 2139
                -- upvalues: TekrinnDialogue (ref), u174 (ref)
                TekrinnDialogue.Speak(u174, {
                    {
                        Text = "But you can\'t defeat me.",
                        Bold = false,
                        Italic = false,
                        TypeSpeed = 0.02,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = false,
                            Intensity = 2,
                            Lifetime = 20
                        }
                    }
                }, 3);
            end));

            return;
        end;

        TekrinnDialogue.Speak(u174, {
            {
                Text = "I\'ll devour all of your ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 20
                }
            },
            {
                Text = "soccer skills!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 20
                }
            }
        }, 4);
        _track.add(KatUtil.frame_delay(205, function() -- Line: 2215
            -- upvalues: TekrinnDialogue (ref), u174 (ref)
            TekrinnDialogue.Speak(u174, {
                {
                    Text = "Everything... ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 0.8
                    }
                },
                {
                    Text = "Single-Handedly!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 0.8
                    }
                }
            }, 4);
        end));
        _track.add(KatUtil.frame_delay(347, function() -- Line: 2265
            -- upvalues: TekrinnDialogue (ref), u174 (ref)
            TekrinnDialogue.Speak(u174, {
                {
                    Text = "You can\'t..",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 20
                    }
                }
            }, 3);
        end));
        _track.add(KatUtil.frame_delay(435, function() -- Line: 2293
            -- upvalues: TekrinnDialogue (ref), u174 (ref)
            TekrinnDialogue.Speak(u174, {
                {
                    Text = "beat me...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 20
                    }
                }
            }, 3);
        end));
        _track.add(KatUtil.frame_delay(560, function() -- Line: 2321
            -- upvalues: TekrinnDialogue (ref), u174 (ref)
            TekrinnDialogue.Speak(u174, {
                {
                    Text = "Bring it.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 20
                    }
                }
            }, 3);
        end));
    end));
    _track.add(KatUtil.frame_delay(619, function() -- Line: 2351
        -- upvalues: _track (copy), OffballV2 (copy), Root (copy), vfxUtil (ref)
        local v188 = _track.clone(OffballV2.ScreenEffect);
        v188.Parent = workspace.Effects;
        v188.CFrame = Root.CFrame * CFrame.new(-2.57482386, 6.05478477, -30.217968, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        vfxUtil.forge.emit(v188);
        vfxUtil.disposal(v188, 10);
    end));
    _track.add(KatUtil.frame_delay(638, function() -- Line: 2360
        -- upvalues: Util (ref), ReplicatedStorage2 (ref)
        Util.Gif(ReplicatedStorage2.Resources.nagi.NagiFlowImpact, 40);
    end));
end;

function u1.NagiOffBall(u189) -- Line: 2366
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), animationUtil (copy), LocalPlayer (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy), emitAll (copy), enableall (copy), Util (copy)
    local OffBallAwk = ReplicatedStorage2.Resources.nagi.OffBallAwk;
    local v190 = u189:FindFirstChild("HumanoidRootPart") or u189.PrimaryPart;
    local u191 = trove.new();
    u191:AttachToInstance(u189);

    local function syncConnect(p192: number, p193: any) -- Line: 2373
        -- upvalues: u191 (copy)
        u191:Add(task.delay(p192 / 60, p193));
    end;

    soundUtil:play(OffBallAwk.Sound, SoundService);
    local u194, u195 = mainreplication.cutsceneCamRigWithLetterBox(v190, OffBallAwk.CameraAnimation, OffBallAwk.FOV, u189, CFrame.new(0, -3, 0), OffBallAwk.Cameraa, "CamPart");
    mainreplication.sceneEnabled(true);
    u191:Add(function() -- Line: 2382
        -- upvalues: u195 (copy), mainreplication (ref)
        if u195 then
            u195();
        end;

        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1, true);
    end);
    local v196 = u191:Clone(OffBallAwk.Skull);
    v196:PivotTo(v190.CFrame);
    v196.Parent = workspace.Effects;
    animationUtil:loadAnimation(v196, OffBallAwk.SkullAnimation):Play();
    local u197 = u191:Clone(OffBallAwk.GroundAura);
    u197.CFrame = v190.CFrame * CFrame.new(0, -2.8, 0) * CFrame.Angles(0, 0, 196.345);
    u197.Parent = workspace.Effects;
    local u198 = u191:Clone(OffBallAwk.Mist);
    u198.CFrame = v190.CFrame * CFrame.new(0, -2.8, 0) * CFrame.Angles(0, 0, 196.345);
    u198.Parent = workspace.Effects;
    local u199 = u191:Clone(OffBallAwk.StepThing);
    u199.Parent = v190;
    local u200 = u191:Clone(OffBallAwk.Bluething);
    u200.Parent = v190;
    local u201 = u191:Clone(OffBallAwk.Background2);
    u201:PivotTo(v190.CFrame);
    u201.Parent = workspace.Effects;

    for _, v in { "Emit", "EyeGlare", "MouthWave" } do
        u191:Clone(OffBallAwk[v]).Parent = u189.Head;
    end;

    local u202 = u191:Clone(OffBallAwk.Vignette);
    u202.Parent = LocalPlayer:FindFirstChild("PlayerGui");
    u191:Add(u202.ImageLabel.Changed:Connect(function(p203) -- Line: 2423
        -- upvalues: u202 (copy)
        if not table.find({ "ImageTransparency", "ImageColor3" }, p203) then
            return;
        end;

        for _, descendant in u202.ImageLabel:GetDescendants() do
            if descendant:IsA("ImageLabel") then
                descendant[p203] = u202.ImageLabel[p203];
            end;
        end;
    end));
    local v204 = u191:Clone(OffBallAwk.Lighting.Blur);
    v204.Parent = Lighting;
    local v205 = u191:Clone(OffBallAwk.Lighting.DepthOfField);
    v205.Parent = Lighting;
    local v206 = u191:Clone(OffBallAwk.Lighting.Atmosphere);
    v206.Parent = Lighting;
    local v207 = u191:Clone(OffBallAwk.Lighting.ColorCorrection);
    v207.Parent = Lighting;
    local v208 = MoonPropertyAnimator.new();
    v208:LoadSave(OffBallAwk["Nagi OFFBALL"], MoonPropertyAnimator.ConvertSave(OffBallAwk["Nagi OFFBALL"], {
        Vignette = u202.ImageLabel,
        DepthOfField = v205,
        Blur = v204,
        ColorCorrection = v207,
        Atmosphere = v206
    }));
    v208:PlayAll();
    u191:Add(task.delay(10.65, function() -- Line: 2454
        -- upvalues: u191 (copy)
        u191:Destroy();
    end));
    u191:Add(task.delay(0.1, function() -- Line: 2458
        -- upvalues: TekrinnDialogue (ref), u189 (copy)
        TekrinnDialogue.Speak(u189, {
            {
                Text = "I\'ll devour all of your ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 20
                }
            },
            {
                Text = "soccer skills!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 20
                }
            }
        }, 3);
    end));
    u191:Add(task.delay(0.55, function() -- Line: 2508
        -- upvalues: emitAll (ref), u199 (copy)
        emitAll(u199);
    end));
    u191:Add(task.delay(10.3, function() -- Line: 2512
        -- upvalues: emitAll (ref), u199 (copy)
        emitAll(u199);
    end));
    u191:Add(task.delay(1.5666666666666667, function() -- Line: 2516
        -- upvalues: emitAll (ref), u200 (copy)
        emitAll(u200);
    end));
    u191:Add(task.delay(3.4166666666666665, function() -- Line: 2520
        -- upvalues: TekrinnDialogue (ref), u189 (copy)
        TekrinnDialogue.Speak(u189, {
            {
                Text = "Everything... ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 0.8
                }
            },
            {
                Text = "Single-Handedly!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 0.8
                }
            }
        }, 3);
    end));
    u191:Add(task.delay(2.2333333333333334, function() -- Line: 2570
        -- upvalues: enableall (ref), u194 (copy)
        enableall(u194.Flames, true);
    end));
    u191:Add(task.delay(2.466666666666667, function() -- Line: 2574
        -- upvalues: enableall (ref), u194 (copy)
        enableall(u194.Flames, true);
    end));
    u191:Add(task.delay(2.4, function() -- Line: 2578
        -- upvalues: enableall (ref), u197 (copy), u198 (copy), u201 (copy)
        enableall(u197, true);
        enableall(u198, true);
        enableall(u201, true);
    end));
    u191:Add(task.delay(5.6, function() -- Line: 2584
        -- upvalues: u197 (copy), u198 (copy), u201 (copy)
        local u209 = u197;

        if u209 then
            for _, descendant in pairs(u209:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            task.delay(nil, function() -- Line: 89
                -- upvalues: u209 (copy)
                if not u209 then
                    return;
                end;

                for _, descendant in pairs(u209:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end);
        end;

        local u210 = u198;

        if u210 then
            for _, descendant in pairs(u210:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            task.delay(nil, function() -- Line: 89
                -- upvalues: u210 (copy)
                if not u210 then
                    return;
                end;

                for _, descendant in pairs(u210:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end);
        end;

        local u211 = u201;

        if not u211 then
            return;
        end;

        for _, descendant in pairs(u211:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(nil, function() -- Line: 89
            -- upvalues: u211 (copy)
            if not u211 then
                return;
            end;

            for _, descendant in pairs(u211:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end);
    end));
    u191:Add(task.delay(3.9, function() -- Line: 2590
        -- upvalues: emitAll (ref), u189 (copy)
        emitAll(u189.Head);
    end));
    u191:Add(task.delay(5.783333333333333, function() -- Line: 2594
        -- upvalues: TekrinnDialogue (ref), u189 (copy)
        TekrinnDialogue.Speak(u189, {
            {
                Text = "You can\'t..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 20
                }
            }
        }, 2);
    end));
    u191:Add(task.delay(7.25, function() -- Line: 2622
        -- upvalues: TekrinnDialogue (ref), u189 (copy)
        TekrinnDialogue.Speak(u189, {
            {
                Text = "beat me...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 20
                }
            }
        }, 2);
    end));
    u191:Add(task.delay(9.333333333333334, function() -- Line: 2650
        -- upvalues: TekrinnDialogue (ref), u189 (copy)
        TekrinnDialogue.Speak(u189, {
            {
                Text = "Bring it.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 20
                }
            }
        }, 2);
    end));
    u191:Add(task.delay(10.666666666666666, function() -- Line: 2678
        -- upvalues: Util (ref), ReplicatedStorage2 (ref)
        Util.Gif(ReplicatedStorage2.Resources.nagi.NagiFlowImpact, 40);
    end));
end;

function u1.nagilevitateforheavy(p212) -- Line: 2683
    -- upvalues: vfxUtil (copy), mainreplication (copy)
    local Root = vfxUtil.getRoot(p212);
    mainreplication.destroyVelocity(Root);
    mainreplication.destroyPosition(p212);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 1250;
    BodyPosition.MaxForce = Vector3.new(30000, 30000, 30000);
    BodyPosition.D = 500;
    BodyPosition.Position = Root.Position;
    BodyPosition.Parent = Root;
    vfxUtil.disposal(BodyPosition, 1);
end;

function u1.nagidoublecontrolprep(u213) -- Line: 2698
    -- upvalues: vfxUtil (copy), mainreplication (copy), TweenService (copy), ReplicatedStorage2 (copy)
    local Root = vfxUtil.getRoot(u213);
    mainreplication.cameraShake(15, 0.7, 4);
    mainreplication.fov(true, 80, 0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
    mainreplication.destroyVelocity(Root);
    mainreplication.destroyPosition(u213);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 12500;
    BodyPosition.MaxForce = Vector3.new(30000, 30000, 30000);
    BodyPosition.D = 300;
    BodyPosition.Position = Root.Position;
    BodyPosition.Parent = Root;
    vfxUtil.disposal(BodyPosition, 1);
    TweenService:Create(BodyPosition, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        P = 2500,
        D = 500
    }):Play();
    task.delay(0.5, function() -- Line: 2718
        -- upvalues: ReplicatedStorage2 (ref), u213 (copy)
        local v214 = ReplicatedStorage2.Resources.nagi.nagiheavyleg:Clone();
        v214.Weld.Part0 = u213["Left Leg"];
        v214.Parent = u213;

        for _, descendant in pairs(v214:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.delay(2, v214.Destroy, v214);
    end);
end;

function u1.nagidoublecontrolkick(p215) -- Line: 2734
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage2 (copy), Lighting (copy), TweenService (copy)
    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p215) then
        mainreplication.springcamerashake(40, 30);
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    local v216 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
    v216.Parent = Lighting;
    v216.TintColor = Color3.fromRGB(151, 144, 255);
    v216.Brightness = 0.4;
    v216.Contrast = 1;
    v216.Saturation = -0.4;
    TweenService:Create(v216, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v216, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(2, v216.Destroy, v216);
end;

function u1.nagi_directHeelLift(p217, p218, p219, p220) -- Line: 2755
    -- upvalues: vfxUtil (copy), ReplicatedStorage2 (copy), mainreplication (copy), Lighting (copy), TweenService (copy)
    local u221 = vfxUtil.earlyCancel(p218, p217);
    local u222 = vfxUtil.isLocalPlayer(p217);
    local u223 = ReplicatedStorage2.Resources.nagi.DirectHeelLift.TemplateR6:Clone();
    u223.Parent = p217;
    vfxUtil.setupAura(p217, u223, true);
    shared.vfx.emit(u223["Right Leg"].Attachment);

    for _, v in u223:QueryDescendants("Trail") do
        v.Enabled = false;
    end;

    u221:Add(task.delay(0.2, function() -- Line: 2769
        -- upvalues: u223 (copy), u222 (copy), mainreplication (ref)
        shared.vfx.emit(u223.HumanoidRootPart.Lift);

        if u222 then
            mainreplication.cameraShake(15, 0.7, 4);
            mainreplication.fov(false, 50);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end;
    end));
    local u224 = 1.517 / p219;
    u221:Add(task.delay(0.833 - p220, function() -- Line: 2782
        -- upvalues: u223 (copy), u222 (copy), mainreplication (ref), u224 (copy), ReplicatedStorage2 (ref), Lighting (ref), TweenService (ref)
        shared.vfx.emit(u223.HumanoidRootPart.Steps);
        shared.vfx.emit(u223.HumanoidRootPart.Dash);
        shared.vfx.emit(u223.HumanoidRootPart["4"]);

        for _, v in u223:QueryDescendants("Trail") do
            v.Enabled = true;
        end;

        if u222 then
            mainreplication.springcamerashake(40, 30);
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, u224, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            local u225 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
            u225.TintColor = Color3.fromRGB(151, 144, 255);
            u225.Brightness = 0.4;
            u225.Contrast = 1;
            u225.Saturation = -0.4;
            u225.Parent = Lighting;
            TweenService:Create(u225, TweenInfo.new(u224 * 0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            local v226 = TweenService:Create(u225, TweenInfo.new(u224, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.new(1, 1, 1)
            });
            v226:Play();
            v226.Completed:Once(function() -- Line: 2808
                -- upvalues: u225 (copy)
                u225:Destroy();
            end);
        end;
    end));
    u221:Add(function() -- Line: 2814
        -- upvalues: vfxUtil (ref), u223 (copy)
        vfxUtil.enableEffects(u223, false, "ParticleEmitter,Trail");
        task.delay(vfxUtil.getEmittersLifetime(u223), function() -- Line: 2817
            -- upvalues: u223 (ref)
            u223:Destroy();
        end);
    end);
    u221:Add(task.delay(u224 + (0.833 - p220), function() -- Line: 2822
        -- upvalues: u221 (copy)
        u221:Destroy();
    end));
end;

function u1.phantom_killer(p227) -- Line: 2827
    -- upvalues: vfxUtil (copy), mainreplication (copy), trove (copy), ReplicatedStorage2 (copy), Lighting (copy), TweenService (copy)
    local PhantomKiller = vfxUtil.getResources().nagi.PhantomKiller;
    local HumanoidRootPart = p227:FindFirstChild("HumanoidRootPart");
    local v228 = p227:FindFirstChild("Left Leg");
    local v229 = p227:FindFirstChild("AlternateBallRig") and p227.AlternateBallRig:FindFirstChild("Ball");
    mainreplication.eradicateVelocity(HumanoidRootPart);
    local u230 = trove.new();
    u230:AttachToInstance(p227);
    local v231 = u230:Clone(PhantomKiller.Emit);
    v231.Parent = v229;
    local v232 = u230:Clone(PhantomKiller.rahn);
    v232.Parent = v228;
    local v233 = u230:Clone(PhantomKiller["2.5"]);
    v233.Parent = v229;
    local v234 = u230:Clone(PhantomKiller.KickDown);
    v234.Parent = HumanoidRootPart;
    local v235 = u230:Clone(PhantomKiller.Dash);
    v235.Parent = HumanoidRootPart;
    shared.vfx.emit(v231);

    if vfxUtil.isLocalPlayer(p227) then
        mainreplication.fov(false, 85);
        mainreplication.fov(true, 70, 0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    end;

    shared.vfx.emit(v232);
    shared.vfx.emit(v233);
    shared.vfx.emit(v234);
    shared.vfx.emit(v235);
    local u236 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
    u236.TintColor = Color3.fromRGB(151, 144, 255);
    u236.Brightness = 0.4;
    u236.Contrast = 1;
    u236.Saturation = -0.4;
    u236.Parent = Lighting;
    TweenService:Create(u236, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    local v237 = TweenService:Create(u236, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.new(1, 1, 1)
    });
    v237:Play();
    v237.Completed:Once(function() -- Line: 2885
        -- upvalues: u236 (copy)
        u236:Destroy();
    end);
    u230:Add(task.delay(vfxUtil.getBulkEmittersLifetime(v231, v232, v233, v234, v235), function() -- Line: 2889
        -- upvalues: u230 (copy)
        u230:Destroy();
    end));
end;

function u1.one_touch_distortion_1(p238, p239, p240, p241) -- Line: 2895
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy)
    local OneTouchDistortion = vfxUtil.getResources().nagi.OneTouchDistortion;
    local PhantomKiller = vfxUtil.getResources().nagi.PhantomKiller;
    local HumanoidRootPart = p238:FindFirstChild("HumanoidRootPart");
    local v242 = trove.new();
    v242:AttachToInstance(p238);
    local v243 = {};
    local u244 = v242:Clone(OneTouchDistortion["4"]);
    u244.Parent = HumanoidRootPart;
    table.insert(v243, u244);
    shared.vfx.emit(u244);

    if p239 then
        local v245 = v242:Clone(PhantomKiller.Dash);
        v245.Parent = HumanoidRootPart;
        table.insert(v243, v245);
        shared.vfx.emit(v245);
    end;

    v242:Add(task.delay(vfxUtil.getBulkEmittersLifetime(table.unpack(v243)), function() -- Line: 2918
        -- upvalues: u244 (copy)
        u244:Destroy();
    end));

    if vfxUtil.isLocalPlayer(p238) then
        mainreplication.fov(false, 85);
        mainreplication.fov(true, 70, 0.866, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.bodyVelocity(HumanoidRootPart, p240, p241);
    end;
end;

function u1.one_touch_distortion_2(p246) -- Line: 2929
    -- upvalues: vfxUtil (copy), mainreplication (copy)
    local u247 = vfxUtil.getResources().nagi.OneTouchDistortion.Lift:Clone();
    u247.Parent = p246:FindFirstChild("Left Leg");
    shared.vfx.emit(u247);
    task.delay(vfxUtil.getEmittersLifetime(u247), function() -- Line: 2937
        -- upvalues: u247 (copy)
        u247:Destroy();
    end);

    if vfxUtil.isLocalPlayer(p246) then
        mainreplication.fov(false, 60);
        mainreplication.fov(true, 70, 0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    end;
end;

function u1.king_killer(u248, p249, p250, p251) -- Line: 2947
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), PlayerGui (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local KingKiller = vfxUtil.getResources().nagi.KingKiller;
    local HumanoidRootPart = u248:FindFirstChild("HumanoidRootPart");
    local AlternateBallRig = u248:WaitForChild("AlternateBallRig");
    local u252 = false;
    local u253 = soundUtil:play(KingKiller.Sound, "default");
    mainreplication.sceneEnabled(true);
    local u254 = trove.new();
    u254:AttachToInstance(u248);
    u254:Add(function() -- Line: 2959
        -- upvalues: mainreplication (ref), u252 (ref), u253 (copy)
        mainreplication.sceneEnabled(false);

        if not u252 then
            u253:Destroy();
        end;
    end);
    u254:Add(task.delay(p251.Duration, function() -- Line: 2965
        -- upvalues: u252 (ref), u254 (copy)
        u252 = true;
        u254:Destroy();
    end));
    local v255 = u254:Clone(KingKiller.VFX);
    v255:PivotTo(u248:GetPivot());
    v255.Parent = u248;
    vfxUtil.buildFromRig(u248, KingKiller.TemplateR6, u254);
    local v256 = u254:Add(mainreplication.kuronaCam(HumanoidRootPart, KingKiller.Cam, KingKiller.FOV));
    local v257 = {
        TemplateR6 = u248,
        Workspace = v255,
        ["azl ballllllls_rig"] = AlternateBallRig,
        Vignette = u254:Add(vfxUtil.getMoonEffects()).Vignette,
        Cam = v256
    };

    for _, child in KingKiller.UI:GetChildren() do
        u254:Clone(child).Parent = PlayerGui;
        v257[child.Name] = child;
    end;

    vfxUtil.cutscene_lighting(u254, v257, KingKiller.Lighting, {
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0.15000000596046448,
        ClockTime = 12,
        GeographicLatitude = 0,
        Ambient = Color3.new(1, 1, 1),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.new(0.27451, 0.27451, 0.27451)
    });
    local v258 = u254:Construct(MoonPropertyAnimator);
    v258:LoadAndConvertSave(KingKiller.Moon, v257);
    v258:SetOriginalRoot(KingKiller.VFX:GetPivot());
    v258:SetRoot(HumanoidRootPart);
    v258:PlayAll();
    vfxUtil.execute_compiled(KingKiller.Compiled, u254, v255, u248, AlternateBallRig, v256);
    u254:Add(task.delay(1.24, function() -- Line: 3014
        -- upvalues: u254 (copy), TekrinnDialogue (ref), u248 (copy)
        u254:Add(TekrinnDialogue.Speak(u248, {
            {
                Text = "I don\'t need ",
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            },
            {
                Text = "special passes",
                Bold = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 26, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            },
            {
                Text = " to me.",
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 4));
    end));
    u254:Add(task.delay(4.1, function() -- Line: 3057
        -- upvalues: u254 (copy), TekrinnDialogue (ref), u248 (copy)
        u254:Add(TekrinnDialogue.Speak(u248, {
            {
                Text = "I can breathe life into a ball with my ",
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            },
            {
                Text = "first touch",
                Bold = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 26, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            },
            {
                Text = ".",
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 5));
    end));
    u254:Add(task.delay(8.49, function() -- Line: 3100
        -- upvalues: u254 (copy), TekrinnDialogue (ref), u248 (copy)
        u254:Add(TekrinnDialogue.Speak(u248, {
            {
                Text = "See? This is my rhythm.",
                Italic = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 5));
    end));
    u254:Add(task.delay(10.52, function() -- Line: 3119
        -- upvalues: u254 (copy), TekrinnDialogue (ref), u248 (copy)
        u254:Add(TekrinnDialogue.Speak(u248, {
            {
                Text = "Try and take it off me, ",
                Italic = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            },
            {
                Text = "King",
                Bold = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(33, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            },
            {
                Text = ".",
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 5));
    end));
    u254:Add(task.delay(12.65, function() -- Line: 3164
        -- upvalues: u254 (copy), TekrinnDialogue (ref), u248 (copy)
        u254:Add(TekrinnDialogue.Speak(u248, {
            {
                Text = "Now",
                Italic = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            },
            {
                Text = " I\'m ",
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            },
            {
                Text = "the god of this field.",
                Italic = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 3));
    end));
end;

return u1;