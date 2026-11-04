 

 

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
game:GetService("ServerScriptService");
local camerasreplication = require(ReplicatedStorage.client.replication.otherReplication.camerasreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local v1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local Offset = Lighting.Atmosphere.Offset;
local Decay = Lighting.Atmosphere.Decay;
local Glare = Lighting.Atmosphere.Glare;
local Haze = Lighting.Atmosphere.Haze;
local Brightness = Lighting.Brightness;
local ClockTime = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local ExposureCompensation = Lighting.ExposureCompensation;
local Threshold = Lighting.Bloom.Threshold;
local EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale;
local EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale;
local ColorShift_Top = Lighting.ColorShift_Top;
local GlobalShadows = Lighting.GlobalShadows;
local OutdoorAmbient = Lighting.OutdoorAmbient;
local ShadowSoftness = Lighting.ShadowSoftness;
local ClockTime2 = Lighting.ClockTime;
local GeographicLatitude = Lighting.GeographicLatitude;
local FogColor = Lighting.FogColor;
local FogEnd = Lighting.FogEnd;
local FogStart = Lighting.FogStart;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
local MeshEmitter = require(script.Parent.Parent.MeshEmitter);
require(ReplicatedStorage2.util.raycast);
local animationUtil = require(ReplicatedStorage2.util.animationUtil);
local soundUtil = require(ReplicatedStorage2.util.soundUtil);
require(ReplicatedStorage2.util.actionUtil);
local UwUEffects = require(ReplicatedStorage2.util.UwUEffects);
local Util = require(ReplicatedStorage2.util.Util);
require(ReplicatedStorage2.Temp);
local VfxHandler = require(ReplicatedStorage2.VfxHandler);
require(ReplicatedStorage2.Welder);
local trove = require(ReplicatedStorage.forum.trove);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local mainreplication = require(ReplicatedStorage2.client.replication.mainreplication);
local TekrinnDialogue = require(ReplicatedStorage2.client.replication.TekrinnDialogue);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local u2 = require("../Colorcorrectionzstr");
local u3 = require("../Disortion");
require("../LunarisService");
local u4 = require("../mainreplication");

function v1.mvp_u20(p5, p6) -- Line: 76
    -- upvalues: Lighting (copy), vfxUtil (copy), mainreplication (copy), ReplicatedStorage2 (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy), RunService (copy), TweenService (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy), Density (copy), Color (copy)
    local v7 = p5.HumanoidRootPart or p5.PrimaryPart;
    local _ = p5.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    mainreplication.sceneEnabled(true);
    local u8 = ReplicatedStorage2.Resources.vb:Clone();
    u8.Parent = PlayerGui;
    local u9 = ReplicatedStorage2.Resources.glowscreen:Clone();
    u9.Parent = PlayerGui;
    u9.ImageLabel2.ImageTransparency = 0;
    u9.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = -1;
    Lighting.Ambient = Color3.fromRGB(147, 209, 255);
    Lighting.ExposureCompensation = 2;
    Lighting.Bloom.Threshold = 2;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.7;
    ColorCorrectionEffect.Saturation = -0.35;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(187, 208, 255);
    local u10 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u10.Parent = Lighting;
    u10.Enabled = false;
    u10.FarIntensity = 1;
    local u11 = ReplicatedStorage2.Resources.mvpAssets.u20.allEffects:Clone();
    u11:PivotTo(v7.CFrame);
    u11.Parent = p5;
    soundUtil:play(ReplicatedStorage2.Resources.mvpAssets.u20["mvpisagisound (1)"], SoundService);
    mainreplication.cutsceneBlender(v7, ReplicatedStorage2.Resources.mvpAssets.u20.Animation2, ReplicatedStorage2.Resources.mvpAssets.u20.FOV);
    local u12 = ReplicatedStorage2.Resources.mvpAssets.u20.camPart:Clone();
    u12.Parent = u11;
    local u13 = nil;
    u13 = RunService.PreRender:connect(function() -- Line: 143
        -- upvalues: u12 (copy), u13 (ref)
        if u12:IsDescendantOf(game) then
            u12.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u13:Disconnect();
    end);
    task.delay(1.317, function() -- Line: 148
        -- upvalues: Lighting (ref)
        Lighting.Brightness = 0.5;
    end);
    task.spawn(function() -- Line: 152
        -- upvalues: u11 (copy)
        for _, descendant in ipairs(u11.glare1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.3166666666666667, function() -- Line: 159
        -- upvalues: u11 (copy)
        for _, descendant in ipairs(u11.glare1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u11.glare2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.5833333333333333, function() -- Line: 172
        -- upvalues: u11 (copy), TweenService (ref)
        for _, descendant in ipairs(u11.ker:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    TimeScale = 0.05
                }):Play();
            end;
        end;
    end);
    task.delay(2.816666666666667, function() -- Line: 181
        -- upvalues: u11 (copy)
        for _, descendant in ipairs(u11.glare2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2.817, function() -- Line: 189
        -- upvalues: u12 (copy)
        u12.Beam.Enabled = true;
    end);
    task.delay(10.63, function() -- Line: 192
        -- upvalues: u11 (copy), u12 (copy), ColorCorrectionEffect (copy), TweenService (ref)
        for _, descendant in ipairs(u11.glare3:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u12.Beam.Enabled = false;
        u12.Beam2.Enabled = true;
        ColorCorrectionEffect.Brightness = 2;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Brightness = 0
        }):Play();
    end);
    task.delay(12.517, function() -- Line: 206
        -- upvalues: u11 (copy), u12 (copy), u10 (copy)
        for _, descendant in ipairs(u11.ker2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0;
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u11.glare3:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        u12.Beam2.Enabled = false;
        u10.Enabled = true;
    end);
    task.delay(13.533333333333333, function() -- Line: 223
        -- upvalues: u11 (copy)
        for _, descendant in ipairs(u11.ker2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in ipairs(u11.ker3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0;
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(14.55, function() -- Line: 237
        -- upvalues: u11 (copy)
        for _, descendant in ipairs(u11.ker3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in ipairs(u11.ker4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0;
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(15.566666666666666, function() -- Line: 251
        -- upvalues: u11 (copy)
        for _, descendant in ipairs(u11.ker4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in ipairs(u11.glare4:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(15.583333333333334, function() -- Line: 264
        -- upvalues: u11 (copy), TweenService (ref)
        for _, descendant in ipairs(u11.ker5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.5;
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                TweenService:Create(descendant, TweenInfo.new(1), {
                    TimeScale = 0.055
                }):Play();
            end;
        end;
    end);
    task.delay(19.25, function() -- Line: 273
        for _, descendant in ipairs(workspace.glare4:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(21.016666666666666, function() -- Line: 280
        -- upvalues: u11 (copy), TweenService (ref)
        for _, descendant in ipairs(u11.ker6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    TimeScale = 0.05
                }):Play();
            end;
        end;
    end);
    task.delay(22.783, function() -- Line: 289
        -- upvalues: ScreenDimmer (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref), Atmosphere (copy), Density (ref), Color (ref), ColorCorrectionEffect (copy), u8 (copy), u11 (copy), u9 (copy), u10 (copy), mainreplication (ref)
        ScreenDimmer:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        ColorCorrectionEffect:Destroy();
        Atmosphere.Density = Density;
        u8:Destroy();
        u11:Destroy();
        u9:Destroy();
        u10:Destroy();
        mainreplication.blackscene(1);
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_nagiMvp(p14, p15) -- Line: 326
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Util (copy), Lighting (copy), UwUEffects (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy)
    local v16 = p14.HumanoidRootPart or p14.PrimaryPart;
    local nagiMvp = ReplicatedStorage2.Resources.mvpAssets.nagiMvp;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    mainreplication.sceneEnabled(true);
    soundUtil:play(nagiMvp.soundmvp, ReplicatedStorage2);
    local v17 = mainreplication.cutscene(v16, CFrame.new(), 6.6, nagiMvp.FOV);
    Util.CameraEffect(nagiMvp.Cam, v17);
    Lighting.Brightness = 2.5;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1.5;
    Lighting.Bloom.Threshold = 1;
    Lighting.ClockTime = 0;
    UwUEffects.createEffect({
        Character = p14
    }, "NagiMVP");
    task.delay(p15, function() -- Line: 348
        -- upvalues: ScreenDimmer (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref), mainreplication (ref)
        ScreenDimmer:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
        mainreplication.fov(false, 70);
        mainreplication.blackscene(1);
    end);
end;

function v1.mvp_saeGlory(u18: userdata, p19: number, p20: any) -- Line: 362
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), TweenService (copy)
    local SaeGlory = ReplicatedStorage2.Resources.mvpAssets.SaeGlory;
    local HumanoidRootPart = u18:FindFirstChild("HumanoidRootPart");
    local u21 = trove.new();
    local v22 = p20.chance == 1 and true or (u18:GetAttribute("SillySong") or u18.Name == "swrerm");
    mainreplication.sceneEnabled(true);
    local u23 = soundUtil:play(SaeGlory:FindFirstChild(v22 and "cartisong" or "soundmvp"), SoundService);

    for _, descendant in ipairs(u18:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency == 0 then
            local v24 = descendant;

            for _, child in ipairs(ReplicatedStorage2.Resources.mvpAssets.sae.ReflexAura:GetChildren()) do
                local u25 = child:Clone();
                u25.Parent = v24;
                task.spawn(function() -- Line: 378
                    -- upvalues: u25 (copy)
                    for _, descendant2 in u25:GetDescendants() do
                        if descendant2:IsA("ParticleEmitter") or descendant2:IsA("Beam") then
                            descendant2.Enabled = true;
                        end;
                    end;
                end);
            end;
        end;
    end;

    local v26, v27 = mainreplication.cutsceneCamRigWithLetterBox(HumanoidRootPart, SaeGlory.caniamtion, SaeGlory.FOV, u18, CFrame.new(0, -3, 0));
    u21:Add(v27);
    local v28 = u21:Clone(SaeGlory.CameraEffects);
    v28.Parent = v26;
    v28.Join.Part0 = v26.camera;
    u21:Add(task.delay(p19 - 1, function() -- Line: 396
        -- upvalues: mainreplication (ref)
        mainreplication.newblackscene(0.75, 1, 3);
    end));
    u21:Clone(SaeGlory.EyeFx).Parent = u18.Head;

    if v22 then
        u21:Add(task.delay(8.5, function() -- Line: 404
            -- upvalues: soundUtil (ref), SaeGlory (copy), SoundService (ref), u21 (copy), TekrinnDialogue (ref), u18 (copy)
            u21:Add((soundUtil:play(SaeGlory.nurui, SoundService)));
            task.wait(0.15);
            TekrinnDialogue.Speak(u18.Name, {
                {
                    Text = "Half Baked.",
                    Bold = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 87, 132)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 2);
        end));
    end;

    u21:Add(function() -- Line: 435
        -- upvalues: u23 (copy), TweenService (ref), mainreplication (ref)
        if u23 then
            TweenService:Create(u23, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Volume = 0
            }):Play();
            task.delay(3, function() -- Line: 441
                -- upvalues: u23 (ref)
                if not u23 then
                    return;
                end;

                u23:Destroy();
            end);
        end;

        task.delay(0.3, function() -- Line: 450
            -- upvalues: mainreplication (ref)
            mainreplication.sceneEnabled(false);
        end);
    end);
    task.delay(p19, u21.Destroy, u21);
end;

function v1.mvp_saeMvp(p29: userdata, p30: number) -- Line: 458
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Lighting (copy), ReplicatedStorage (copy), Ambient (copy), Brightness (copy), ColorShift_Top (copy), EnvironmentDiffuseScale (copy), GlobalShadows (copy), OutdoorAmbient (copy), ShadowSoftness (copy), ClockTime2 (copy), GeographicLatitude (copy), ExposureCompensation (copy), FogColor (copy), FogEnd (copy), FogStart (copy)
    local SaeMvp = ReplicatedStorage2.Resources.mvpAssets.SaeMvp;
    local HumanoidRootPart = p29:FindFirstChild("HumanoidRootPart");
    local v31 = trove.new();
    mainreplication.sceneEnabled(true);
    soundUtil:play(SaeMvp:FindFirstChild("soundmvp"), SoundService);
    soundUtil:play(SaeMvp:FindFirstChild("thememvp"), SoundService);
    local v32, v33 = mainreplication.cutsceneCamRigWithLetterBox(HumanoidRootPart, SaeMvp.caniamtion, nil, p29, CFrame.new(0, -3, 0));
    v31:Add(v33);
    v31:Add(task.delay(p30 - 1, function() -- Line: 471
        -- upvalues: mainreplication (ref)
        mainreplication.newblackscene(0.75, 1, 3);
    end));
    local v34 = v31:Clone(SaeMvp.CameraEffects);
    v34.Join.Part0 = v32.camera;
    v34.Parent = v32;
    v31:Clone(SaeMvp.EyeFX).Parent = p29.Head;
    local v35 = v31:Clone(SaeMvp["Light Parts"]);
    v35.Join.Part0 = HumanoidRootPart;
    v35.Parent = workspace.Effects;
    local v36 = v31:Clone(SaeMvp.Snow);
    v36.Join.Part0 = HumanoidRootPart;
    v36.Parent = workspace.Effects;
    local v37 = v31:Clone(SaeMvp.Rays);
    v37.Join.Part0 = HumanoidRootPart;
    v37.Parent = workspace.Effects;
    Lighting:ClearAllChildren();

    for _, child in SaeMvp["Lighting Effects"]:GetChildren() do
        v31:Clone(child).Parent = Lighting;
    end;

    Lighting.Ambient = Color3.new();
    Lighting.Brightness = 4;
    Lighting.ColorShift_Top = Color3.fromRGB(98, 106, 255);
    Lighting.EnvironmentDiffuseScale = 0.222;
    Lighting.GlobalShadows = false;
    Lighting.OutdoorAmbient = Color3.fromRGB(33, 33, 33);
    Lighting.ShadowSoftness = 0;
    Lighting.ClockTime = 0;
    Lighting.GeographicLatitude = 41.733;
    Lighting.ExposureCompensation = 0.5;
    Lighting.FogColor = Color3.fromRGB(192, 192, 192);
    Lighting.FogStart = 0;
    Lighting.FogEnd = 100000;
    local u38 = false;
    v31:Add(function() -- Line: 516, Name: restoreLighting
        -- upvalues: u38 (ref), Lighting (ref), ReplicatedStorage (ref), Ambient (ref), Brightness (ref), ColorShift_Top (ref), EnvironmentDiffuseScale (ref), GlobalShadows (ref), OutdoorAmbient (ref), ShadowSoftness (ref), ClockTime2 (ref), GeographicLatitude (ref), ExposureCompensation (ref), FogColor (ref), FogEnd (ref), FogStart (ref)
        if u38 then
            return;
        end;

        u38 = true;
        Lighting:ClearAllChildren();

        for _, child in ReplicatedStorage.Resources.OGLightning:GetChildren() do
            child:Clone().Parent = Lighting;
        end;

        Lighting.Ambient = Ambient;
        Lighting.Brightness = Brightness;
        Lighting.ColorShift_Top = ColorShift_Top;
        Lighting.EnvironmentDiffuseScale = EnvironmentDiffuseScale;
        Lighting.GlobalShadows = GlobalShadows;
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.ShadowSoftness = ShadowSoftness;
        Lighting.ClockTime = ClockTime2;
        Lighting.GeographicLatitude = GeographicLatitude;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.FogColor = FogColor;
        Lighting.FogEnd = FogEnd;
        Lighting.FogStart = FogStart;
    end);
    v31:Add(function() -- Line: 546
        -- upvalues: mainreplication (ref)
        task.delay(0.3, function() -- Line: 547
            -- upvalues: mainreplication (ref)
            mainreplication.sceneEnabled(false);
        end);
    end);
    task.delay(p30, v31.Destroy, v31);
end;

function v1.mvp_saeXShidou(u39: userdata, p40: number, ...) -- Line: 555
    -- upvalues: vfxUtil (copy), Players (copy), trove (copy), ReplicatedStorage2 (copy), PlayerGui (copy), Lighting (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Ambient (copy), Brightness (copy), OutdoorAmbient (copy), ClockTime (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy), KatUtil (copy)
    warn(u39, p40);
    local Root = vfxUtil.getRoot(u39);
    Players:GetPlayerFromCharacter(u39);
    local v41 = trove.new();
    local saeXShidou = vfxUtil.getResources().mvpAssets.saeXShidou;
    local u42 = vfxUtil.newRigForFriend(Root, nil, CFrame.new(
        0.208000183,
        0,
        -3.42800045,
        1,
        -1.50249603e-25,
        -4.54747351e-13,
        -1.50249603e-25,
        1,
        8.81072992e-13,
        -4.54747351e-13,
        8.81072992e-13,
        1
    ));
    v41:Add(u42);
    v41:AttachToInstance(u39);
    local u43 = v41:Add(ReplicatedStorage2.Resources.vb:Clone());
    u43.Parent = PlayerGui;
    u43.Enabled = false;

    for _, v in { u43.Frame0, u43.Frame1 } do
        v.BackgroundTransparency = 1;
    end;

    u42.Humanoid.Animator:LoadAnimation(saeXShidou.Sae):Play(0);
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.Brightness = 6;
    Lighting.ColorShift_Bottom = Color3.new();
    Lighting.ColorShift_Top = Color3.new();
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ShadowSoftness = 0.2;
    Lighting.ClockTime = 14.5;
    Lighting.GeographicLatitude = 0;
    Lighting.ExposureCompensation = 0;
    mainreplication.sceneEnabled(true);
    soundUtil:play(saeXShidou.soundmvp, SoundService);
    v41:Add(((function() -- Line: 593, Name: apply_lighting_instances
        -- upvalues: Lighting (ref), saeXShidou (copy)
        local Children = Lighting:GetChildren();
        local u44 = {};

        for _, v in Children do
            v.Parent = nil;
        end;

        for _, child in saeXShidou.Lighting:GetChildren() do
            u44[child.Name] = child:Clone();
            u44[child.Name].Parent = Lighting;
        end;

        return function() -- Line: 606
            -- upvalues: u44 (copy), Children (copy), Lighting (ref)
            for _, v in u44 do
                v:Destroy();
            end;

            for _, v in Children do
                v.Parent = Lighting;
            end;
        end;
    end)()));
    v41:Add(mainreplication.cutscene(u39.HumanoidRootPart, CFrame.new(0, 0, 0), p40, saeXShidou.FOV));
    v41:Add(function() -- Line: 619
        -- upvalues: mainreplication (ref), Lighting (ref), Ambient (ref), Brightness (ref), OutdoorAmbient (ref), ClockTime (ref)
        mainreplication.sceneEnabled(false);
        Lighting.Ambient = Ambient;
        Lighting.Brightness = Brightness;
        Lighting.ColorShift_Bottom = Color3.new(0, 0, 0);
        Lighting.ColorShift_Top = Color3.new(0, 0, 0);
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.ShadowSoftness = 1;
        Lighting.ClockTime = ClockTime;
        Lighting.GeographicLatitude = 23;
        Lighting.ExposureCompensation = 0.2;
    end);
    local v45 = v41:Construct(vfxUtil.getMoonEffects);
    local v46 = v41:Construct(MoonPropertyAnimator);
    v46:LoadSave(saeXShidou.Moon, {
        Vignette = v45.Vignette
    });
    v46:PlayAll();
    local v47 = v41:Add(vfxUtil.createVFX(saeXShidou.Vfx.Floor, workspace.Effects, Root));
    local u48 = v41:Add(vfxUtil.createVFX(saeXShidou.Vfx.Part, workspace.Effects, Root));
    local u49 = v41:Add(vfxUtil.createVFX(saeXShidou.Vfx.Part1, workspace.Effects, Root));
    local u50 = v41:Add(vfxUtil.createVFX(saeXShidou.Vfx.Windier, workspace.Effects, Root));
    local u51 = v41:Add(vfxUtil.createVFX(saeXShidou.Vfx.ShidouClingHit, workspace.Effects, Root));
    local u52 = v41:Add(vfxUtil.createVFX(saeXShidou.Vfx.Backwind, workspace.Effects, Root));
    local u53 = v41:Add(vfxUtil.createVFX(saeXShidou.Vfx.Windier1, workspace.Effects, Root));
    local u54 = v41:Add(saeXShidou.Vfx.SaeBody:Clone());
    u54.Parent = workspace.Effects;
    u54:PivotTo(Root.CFrame * CFrame.new(
        0.807232857,
        -2.90516353,
        -7.06865692,
        1,
        -2.50416006e-26,
        -2.27373675e-13,
        -2.50416006e-26,
        1,
        4.40536496e-13,
        -2.27373675e-13,
        4.40536496e-13,
        1
    ));
    vfxUtil.forge.emit(v47);
    v41:Add(task.delay(0.18333333333333332, function() -- Line: 651
        -- upvalues: vfxUtil (ref), u48 (copy)
        vfxUtil.forge.emit(u48.Foot);
    end));
    v41:Add(task.delay(0.23333333333333334, function() -- Line: 655
        -- upvalues: vfxUtil (ref), u49 (copy)
        vfxUtil.forge.emit(u49.Foot);
    end));
    v41:Add(task.delay(0.7, function() -- Line: 659
        -- upvalues: vfxUtil (ref), u48 (copy)
        vfxUtil.forge.emit(u48.Foot1);
    end));
    v41:Add(task.delay(0.7333333333333333, function() -- Line: 663
        -- upvalues: vfxUtil (ref), u49 (copy)
        vfxUtil.forge.emit(u49.Foot1);
    end));
    v41:Add(task.delay(0.8666666666666667, function() -- Line: 667
        -- upvalues: vfxUtil (ref), u49 (copy)
        vfxUtil.forge.emit(u49.Foot);
    end));
    v41:Add(task.delay(1.1833333333333333, function() -- Line: 671
        -- upvalues: vfxUtil (ref), u48 (copy)
        vfxUtil.forge.emit(u48.Foot2);
    end));
    v41:Add(task.delay(1.2333333333333334, function() -- Line: 675
        -- upvalues: vfxUtil (ref), u49 (copy)
        vfxUtil.forge.emit(u49.Foot2);
    end));
    v41:Add(task.delay(2.1, function() -- Line: 679
        -- upvalues: vfxUtil (ref), u50 (copy)
        vfxUtil.forge.emit(u50);
    end));
    v41:Add(task.delay(4.383333333333334, function() -- Line: 683
        -- upvalues: vfxUtil (ref), u51 (copy)
        vfxUtil.forge.emit(u51);
    end));
    v41:Add(task.delay(5.35, function() -- Line: 687
        -- upvalues: vfxUtil (ref), u52 (copy)
        vfxUtil.forge.emit(u52);
    end));
    v41:Add(task.delay(7.95, function() -- Line: 691
        -- upvalues: vfxUtil (ref), u53 (copy)
        vfxUtil.forge.emit(u53);
    end));
    v41:Add(task.delay(12.333333333333334, function() -- Line: 695
        -- upvalues: vfxUtil (ref), u54 (copy)
        vfxUtil.forge.emit(u54);
    end));
    v41:Add(task.delay(1.83, function() -- Line: 699
        -- upvalues: TekrinnDialogue (ref), u39 (copy), u42 (copy)
        TekrinnDialogue.Speak(u39.Name, {
            {
                Text = "I scored, ",
                Bold = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            },
            {
                Bold = true,
                TypeSpeed = 0.035,
                Text = `{u42.Name}!`,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 60, 135)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            }
        }, nil, "rbxassetid://123604384147107", Color3.fromRGB(255, 0, 132));
    end));
    v41:Add(task.delay(4.8, function() -- Line: 735
        -- upvalues: TekrinnDialogue (ref), u39 (copy)
        TekrinnDialogue.Speak(u39.Name, {
            {
                Text = "I\'ll play soccer with you forever!",
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, nil, "rbxassetid://123604384147107", Color3.fromRGB(255, 0, 132));
    end));
    v41:Add(task.delay(7.4, function() -- Line: 749
        -- upvalues: TekrinnDialogue (ref), u39 (copy)
        TekrinnDialogue.Speak(u39.Name, {
            {
                Text = "When I\'m with you, I start to get ",
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            },
            {
                Text = "excited ",
                Bold = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 132)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 0.3
                }
            },
            {
                Text = "like never before!",
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, nil, "rbxassetid://123604384147107", Color3.fromRGB(255, 0, 132));
    end));
    v41:Add(task.delay(7.967, function() -- Line: 786
        -- upvalues: u43 (copy), KatUtil (ref)
        u43.Enabled = true;

        for _, v in { u43.Frame0, u43.Frame1 } do
            KatUtil.tween(v, { 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out }, {
                BackgroundTransparency = 0
            });
        end;
    end));
    v41:Add(task.delay(11.5, function() -- Line: 796
        -- upvalues: TekrinnDialogue (ref), u42 (copy)
        TekrinnDialogue.Speak(u42.Name, {
            {
                Text = "Creep.",
                Bold = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 135)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            }
        }, nil, "rbxassetid://87031389627015", Color3.fromRGB(255, 60, 135));
    end));
    v41:Add(task.delay(p40 - 2, function() -- Line: 817
        -- upvalues: mainreplication (ref)
        mainreplication.newblackscene(2, 1, 3.3);
    end));
end;

function v1.mvp_kiyoraMvpOld(u55: userdata, p56: number, p57: any) -- Line: 822
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), TweenService (copy)
    print(p57);
    local KiyoraMvp = ReplicatedStorage2.Resources.mvpAssets.KiyoraMvp;
    local os_clock_ret = os.clock();
    local u58 = nil;

    while true do
        if os.clock() - os_clock_ret >= p56 or u58 ~= nil then
            if u58 == nil then
                return;
            end;

            local HumanoidRootPart = u55:FindFirstChild("HumanoidRootPart");
            local u59 = trove.new();
            mainreplication.sceneEnabled(true);
            local v60;

            if p57.chance == 1 then
                v60 = KiyoraMvp:FindFirstChild("soundmvp");
            else
                v60 = KiyoraMvp:FindFirstChild("soundmvp2");
            end;

            local u61 = soundUtil:play(v60, SoundService);
            local u62 = u59:Add(mainreplication.cutscene(HumanoidRootPart, CFrame.identity, p56, KiyoraMvp.FOV));
            u59:Add(task.delay(p56 - 1, function() -- Line: 853
                -- upvalues: mainreplication (ref)
                mainreplication.newblackscene(0.75, 1, 3);
            end));

            local function syncedDelay(p63: number, p64: function, ...) -- Line: 857
                -- upvalues: u59 (copy), u58 (ref)
                return u59:Add(task.delay(math.max(0, p63 / 60 - u58.TimePosition), p64, ...));
            end;

            local u65 = false;
            u59:Add(function() -- Line: 863, Name: restoreLighting
                -- upvalues: u65 (ref)
                if u65 then
                    return;
                end;

                u65 = true;
            end);
            local v66 = {};
            local u67 = nil;
            local u68 = nil;
            local u69 = nil;

            for _, child in KiyoraMvp["Camera Effects"]:GetChildren() do
                local v70 = child:Clone();
                mainreplication.BetterEnable(v70, true);
                v70.Parent = u62;
                table.insert(v66, v70);
            end;

            local u71 = u59:Clone(KiyoraMvp.beamWinds);
            u71.Join.Part0 = HumanoidRootPart;
            u71.Parent = workspace.Effects;
            mainreplication.BetterEnable(u71, true);
            local u72 = u59:Clone(KiyoraMvp.Balance);
            u72.RootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -100, 0);
            u72.Parent = workspace.Effects;
            syncedDelay(320, function() -- Line: 894
                -- upvalues: u72 (copy), HumanoidRootPart (copy)
                u72.RootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                    57.668251,
                    -2.31092072,
                    -2.14672852,
                    4.54747351e-13,
                    1,
                    1.48003063e-25,
                    -8.76165785e-13,
                    -1.50258614e-25,
                    -1,
                    -1,
                    -4.54747351e-13,
                    -8.76165785e-13
                );
            end);
            syncedDelay(139, function() -- Line: 898
                -- upvalues: u71 (copy), u68 (ref), u59 (copy), KiyoraMvp (copy), u55 (copy), mainreplication (ref)
                u71:Destroy();
                u68 = u59:Clone(KiyoraMvp.EyeFX);
                u68.Parent = u55.Head;
                mainreplication.BetterEnable(u68, true);
            end);
            syncedDelay(238, function() -- Line: 905
                -- upvalues: u68 (ref)
                if u68 then
                    u68:Destroy();
                end;
            end);
            syncedDelay(290, function() -- Line: 911
                -- upvalues: mainreplication (ref), KiyoraMvp (copy), HumanoidRootPart (copy)
                mainreplication.EmitAttachmentIn({
                    Effect = KiyoraMvp.step,
                    Parent = HumanoidRootPart
                });
            end);
            syncedDelay(317, function() -- Line: 918
                -- upvalues: mainreplication (ref), KiyoraMvp (copy), HumanoidRootPart (copy)
                mainreplication.EmitAttachmentIn({
                    Effect = KiyoraMvp.step2,
                    Parent = HumanoidRootPart
                });
            end);
            syncedDelay(321, function() -- Line: 925
                -- upvalues: u69 (ref), u59 (copy), KiyoraMvp (copy), u62 (copy), mainreplication (ref), u67 (ref), HumanoidRootPart (copy)
                u69 = u59:Clone(KiyoraMvp.cameraShine);
                u69.Join.Part0 = u62;
                u69.Parent = workspace.Effects;
                mainreplication.BetterEnable(u69, true);
                u67 = u59:Clone(KiyoraMvp.shine);
                u67.Parent = HumanoidRootPart;
                mainreplication.BetterEnable(u67, true);
            end);
            syncedDelay(324, function() -- Line: 936
                -- upvalues: u59 (copy), KiyoraMvp (copy), HumanoidRootPart (copy), mainreplication (ref)
                local v73 = u59:Clone(KiyoraMvp.Dust);
                v73.Join.Part0 = HumanoidRootPart;
                v73.Parent = workspace.Effects;
                mainreplication.BetterEnable(v73, true);
                local v74 = u59:Clone(KiyoraMvp.Dust);
                v74.Join.Part0 = HumanoidRootPart;
                v74.Parent = workspace.Effects;
                mainreplication.BetterEnable(v74, true);
                mainreplication.EmitAttachmentIn({
                    Effect = KiyoraMvp.wada,
                    Parent = HumanoidRootPart
                });
                mainreplication.EmitAttachmentIn({
                    Effect = KiyoraMvp.boom,
                    Parent = HumanoidRootPart
                });
            end);
            syncedDelay(350, function() -- Line: 958
                -- upvalues: u67 (ref)
                for _, descendant in u67:GetDescendants() do
                    pcall(function() -- Line: 960
                        -- upvalues: descendant (copy)
                        descendant.TimeScale = 0.001;
                    end);
                end;
            end);
            u59:Add(function() -- Line: 966
                -- upvalues: u61 (copy), TweenService (ref), mainreplication (ref)
                if u61 then
                    TweenService:Create(u61, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Volume = 0
                    }):Play();
                    task.delay(3, function() -- Line: 972
                        -- upvalues: u61 (ref)
                        if not u61 then
                            return;
                        end;

                        u61:Destroy();
                    end);
                end;

                task.delay(0.3, function() -- Line: 981
                    -- upvalues: mainreplication (ref)
                    mainreplication.sceneEnabled(false);
                end);
            end);
            task.delay(p56, u59.Destroy, u59);

            return;
        end;

        for _, v in u55:FindFirstChild("Animator", true):GetPlayingAnimationTracks() do
            if v.Animation.AnimationId == KiyoraMvp.Animation.AnimationId then
                u58 = v;
                break;
            end;
        end;

        task.wait(0.016666666666666666);
    end;
end;

function v1.mvp_nagiTriumph(u75: userdata, p76: number) -- Line: 989
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), u2 (copy), u3 (copy), TweenService (copy)
    local NagiTriumph = ReplicatedStorage2.Resources.mvpAssets.NagiTriumph;
    local os_clock_ret = os.clock();
    local u77 = nil;

    while true do
        if os.clock() - os_clock_ret >= p76 or u77 ~= nil then
            if u77 == nil then
                return;
            end;

            local HumanoidRootPart = u75:FindFirstChild("HumanoidRootPart");
            local u78 = trove.new();
            mainreplication.sceneEnabled(true);
            local u79 = soundUtil:play(NagiTriumph:FindFirstChild("soundmvp"), SoundService);
            local u80 = u78:Add(mainreplication.cutscene(HumanoidRootPart, CFrame.identity, p76, NagiTriumph.FOV));

            local function v83(p81: number, p82: function, ...) -- Line: 1019
                -- upvalues: u78 (copy), u77 (ref)
                return u78:Add(task.delay(math.max(0, p81 / 60 - u77.TimePosition), p82, ...));
            end;

            local u84 = u78:Clone(NagiTriumph.WindBeams);
            u84.Join.Part0 = u80;
            u84.Parent = workspace.Effects;
            mainreplication.BetterEnable(u84, false);
            mainreplication.BetterEnable(u84.Blacked, true);
            mainreplication.BetterEnable(u84.Beams1, true);
            local u85 = u78:Clone(NagiTriumph.StupidCameraEffect);
            u85.Join.Part0 = u80;
            u85.Parent = workspace.Effects;
            mainreplication.BetterEnable(u85, false);
            local u86 = u78:Clone(NagiTriumph.Speedlines);
            u86.Join.Part0 = u75.Torso;
            u86.Parent = workspace.Effects;
            mainreplication.BetterEnable(u86, false);
            v83(59, function() -- Line: 1043
                -- upvalues: u2 (ref), u3 (ref), mainreplication (ref), NagiTriumph (copy), u75 (copy), HumanoidRootPart (copy), u84 (copy), u85 (copy), u86 (copy)
                u2(0.1, 0.5, 0.9, Color3.fromRGB(255, 255, 255), 0.5);
                u3.Play({
                    StartRadius = 0,
                    EndRadius = 65,
                    Duration = 2,
                    StartDistortion = 15,
                    EndDistortion = 1,
                    Position = CFrame.new(-0.009, 2.882, 0.005),
                    EasingStyle = Enum.EasingStyle.Quad,
                    EasingDirection = Enum.EasingDirection.Out
                });
                mainreplication.EmitAttachmentIn({
                    Effect = NagiTriumph.SweatEmit,
                    Parent = u75.Head
                });
                mainreplication.EmitAttachmentIn({
                    Effect = NagiTriumph.RootSmoke,
                    Parent = HumanoidRootPart
                });
                mainreplication.BetterEnable(u84.Blacked, false);
                mainreplication.BetterEnable(u84.ScreenChroma, true);
                mainreplication.BetterEnable(u84.WindStuff, true);
                mainreplication.BetterEnable(u84.Spec, true);
                mainreplication.BetterEnable(u85, true);
                mainreplication.BetterEnable(u86, true);
            end);
            v83(303, function() -- Line: 1077
                -- upvalues: mainreplication (ref), u85 (copy)
                mainreplication.BetterEnable(u85, false);
            end);
            v83(493, function() -- Line: 1081
                -- upvalues: mainreplication (ref), u84 (copy), u86 (copy), u78 (copy), NagiTriumph (copy), u80 (copy)
                mainreplication.BetterEnable(u84.ScreenChroma, false);
                mainreplication.BetterEnable(u86, false);
                local v87 = u78:Clone(NagiTriumph.Transition);
                v87.Join.Part0 = u80;
                v87.Parent = workspace.Effects;
                mainreplication.BetterEmit(v87);
            end);
            v83(497, function() -- Line: 1092
                -- upvalues: u78 (copy), NagiTriumph (copy), HumanoidRootPart (copy)
                local v88 = u78:Clone(NagiTriumph.Domain);
                v88:PivotTo(HumanoidRootPart.CFrame);
                v88.Parent = workspace.Effects;
            end);
            v83(508, function() -- Line: 1098
                -- upvalues: mainreplication (ref), u85 (copy), u78 (copy), NagiTriumph (copy), HumanoidRootPart (copy)
                mainreplication.BetterEnable(u85, true);
                local v89 = u78:Clone(NagiTriumph.Aura);
                v89.Join.Part0 = HumanoidRootPart;
                v89.Parent = workspace.Effects;
                mainreplication.BetterEmit(v89.Aura);
                mainreplication.BetterEnable(v89, true);
            end);
            v83(690, function() -- Line: 1109
                -- upvalues: mainreplication (ref)
                mainreplication.newblackscene(0.75, 1, 3);
            end);
            u78:Add(function() -- Line: 1113
                -- upvalues: u79 (copy), TweenService (ref), mainreplication (ref)
                if u79 then
                    TweenService:Create(u79, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Volume = 0
                    }):Play();
                    task.delay(3, function() -- Line: 1119
                        -- upvalues: u79 (ref)
                        if not u79 then
                            return;
                        end;

                        u79:Destroy();
                    end);
                end;

                task.delay(0.3, function() -- Line: 1128
                    -- upvalues: mainreplication (ref)
                    mainreplication.sceneEnabled(false);
                end);
            end);
            task.delay(p76, u78.Destroy, u78);

            return;
        end;

        for _, v in u75:FindFirstChild("Animator", true):GetPlayingAnimationTracks() do
            if v.Animation.AnimationId == NagiTriumph.Animation.AnimationId then
                u77 = v;
                break;
            end;
        end;

        task.wait(0.016666666666666666);
    end;
end;

function v1.mvp_bambiettaMVP(u90, p91) -- Line: 1136
    -- upvalues: ReplicatedStorage2 (copy), mainreplication (copy), Util (copy), soundUtil (copy), UwUEffects (copy), Lighting (copy), ReplicatedStorage (copy), TekrinnDialogue (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy)
    local v92 = u90.HumanoidRootPart or u90.PrimaryPart;
    local BambiettaMVP = ReplicatedStorage2.Resources.mvpAssets.BambiettaMVP;
    mainreplication.sceneEnabled(true);
    Util.Preload(BambiettaMVP.HHG);
    soundUtil:play(BambiettaMVP.soundmvp, ReplicatedStorage2);
    local v93 = mainreplication.cutscene(v92, CFrame.new(), p91, BambiettaMVP.FOV);
    Util.CameraEffect(BambiettaMVP.Cam, v93);
    UwUEffects.createEffect({
        Character = u90
    }, "BambiettaMVP");
    Lighting.Brightness = 0.2;
    Lighting.Ambient = Color3.fromRGB(170, 0, 0);
    Lighting.ExposureCompensation = 1.5;
    Lighting.Bloom.Threshold = 1;
    Lighting.ClockTime = 3;
    local u94 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u94.Parent = Lighting;
    u94.FarIntensity = 0.4;
    task.delay(8.166666666666666, function() -- Line: 1160
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.mvpAssets.BambiettaMVP.HHG, 30, ReplicatedStorage.Resources.kaiser.SuperStarImpact["1"]);
    end);
    TekrinnDialogue.Speak(u90, {
        {
            Text = "I\'m grateful, you know?",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 3,
                Lifetime = 4
            }
        },
        {
            Text = " For allowing me to use this power.",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 3,
                Lifetime = 4
            }
        }
    }, 3, "rbxassetid://1", Color3.fromRGB(255, 0, 0));
    task.delay(9, function() -- Line: 1209
        -- upvalues: TekrinnDialogue (ref), u90 (copy)
        TekrinnDialogue.Speak(u90, {
            {
                Text = "Quincy Voll Stern Dich.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 4
                }
            }
        }, 3, "rbxassetid://1", Color3.fromRGB(255, 0, 0));
    end);
    task.delay(p91 - 1, function() -- Line: 1236
        -- upvalues: mainreplication (ref), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref), u94 (copy)
        mainreplication.newblackscene(0.5, 0.5, 2);
        mainreplication.fov(false, 70);
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
        u94:Destroy();
    end);
end;

function v1.mvp_hitMVP(p95, p96) -- Line: 1250
    -- upvalues: ReplicatedStorage2 (copy), mainreplication (copy), soundUtil (copy), UwUEffects (copy), Util (copy), PlayerGui (copy), Lighting (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy)
    local v97 = p95.HumanoidRootPart or p95.PrimaryPart;
    local HitMVP = ReplicatedStorage2.Resources.mvpAssets.HitMVP;
    mainreplication.sceneEnabled(true);
    soundUtil:play(HitMVP.soundmvp, ReplicatedStorage2);
    UwUEffects.createEffect({
        Character = p95
    }, "hitMVP");
    local v98, v99 = mainreplication.cutsceneCamRigWithLetterBox(v97, HitMVP.caniamtion, HitMVP.FOV, nil, CFrame.new() * CFrame.Angles(0, -3.141592653589793, 0));
    Util.CameraEffect(HitMVP.Cam, v98);
    task.delay(p96 - 0.2, v99);
    local u100 = ReplicatedStorage2.Resources.vb:Clone();
    u100.Parent = PlayerGui;
    local u101 = ReplicatedStorage2.Resources.glowscreen:Clone();
    u101.Parent = PlayerGui;
    u101.ImageLabel2.ImageTransparency = 0.45;
    u101.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 2.5;
    Lighting.Ambient = Color3.fromRGB(200, 165, 248);
    Lighting.ExposureCompensation = 1.5;
    Lighting.Bloom.Threshold = 1;
    Lighting.ClockTime = 14.5;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.55;
    ColorCorrectionEffect.Saturation = -0.4;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(214, 185, 255);
    local u102 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u102.Parent = Lighting;
    u102.FarIntensity = 0.4;
    task.delay(p96 - 1, function() -- Line: 1288
        -- upvalues: mainreplication (ref), u100 (copy), u101 (copy), ColorCorrectionEffect (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref), u102 (copy)
        mainreplication.newblackscene(0.5, 0.5, 2);
        mainreplication.fov(false, 70);
        u100:Destroy();
        u101:Destroy();
        ColorCorrectionEffect:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
        u102:Destroy();
    end);
end;

function v1.mvp_ronaldoMvp(p103, p104) -- Line: 1304
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), UwUEffects (copy), PlayerGui (copy), TweenService (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy)
    local v105 = p103.HumanoidRootPart or p103.PrimaryPart;
    local ronaldoMvp = ReplicatedStorage2.Resources.mvpAssets.ronaldoMvp;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    mainreplication.sceneEnabled(true);
    soundUtil:play(ronaldoMvp.soundmvp, ReplicatedStorage2);
    mainreplication.cutscene(v105, CFrame.new(), 6.6, ronaldoMvp.FOV);
    Lighting.Brightness = 2.5;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1.5;
    Lighting.Bloom.Threshold = 1;
    Lighting.ClockTime = 0;
    UwUEffects.createEffect({
        Character = p103
    }, "RonaldoMVP");
    local u106 = ronaldoMvp.Parent.HitMVP.Vignette:Clone();
    u106.Parent = PlayerGui;
    task.delay(4.9, function() -- Line: 1325
        -- upvalues: TweenService (ref), u106 (copy)
        TweenService:Create(u106.Vignette, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            ImageTransparency = 0
        }):Play();
        task.delay(0.4166666666666667, function() -- Line: 1329
            -- upvalues: u106 (ref)
            u106:Destroy();
        end);
    end);
    task.delay(p104, function() -- Line: 1333
        -- upvalues: ScreenDimmer (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref), mainreplication (ref)
        ScreenDimmer:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
        mainreplication.fov(false, 70);
        mainreplication.blackscene(1);
    end);
end;

function v1.mvp_inoMvp(p107, p108) -- Line: 1347
    -- upvalues: ReplicatedStorage2 (copy), Lighting (copy), PlayerGui (copy), mainreplication (copy), soundUtil (copy), Util (copy), UwUEffects (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), Density (copy), Color (copy)
    local v109 = p107.HumanoidRootPart or p107.PrimaryPart;
    local inoMvp = ReplicatedStorage2.Resources.mvpAssets.inoMvp;
    local Atmosphere = Lighting.Atmosphere;
    local u110 = ReplicatedStorage2.Resources.vb:Clone();
    u110.Parent = PlayerGui;
    local u111 = ReplicatedStorage2.Resources.glowscreen:Clone();
    u111.Parent = PlayerGui;
    u111.ImageLabel2.ImageTransparency = 0;
    u111.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 1;
    Lighting.Ambient = Color3.fromRGB(192, 211, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 3.55;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.3;
    ColorCorrectionEffect.Saturation = 0;
    ColorCorrectionEffect.Brightness = 0;
    local u112 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u112.Parent = Lighting;
    u112.FarIntensity = 1;
    mainreplication.sceneEnabled(true);
    soundUtil:play(inoMvp.soundmvp, ReplicatedStorage2);
    local v113 = mainreplication.cutsceneBlender(v109, inoMvp.Animation2, inoMvp.FOV, nil, nil, CFrame.new(0, -3, 0) * CFrame.Angles(0, -1.5707963267948966, 0));
    Util.CameraEffect(inoMvp.Cam, v113.CamPart);
    UwUEffects.createEffect({
        Character = p107
    }, "InoMVP");
    task.delay(p108 - 1, function() -- Line: 1384
        -- upvalues: mainreplication (ref), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Atmosphere (copy), Density (ref), Color (ref), ColorCorrectionEffect (copy), u111 (copy), u112 (copy), u110 (copy)
        mainreplication.newblackscene(0.5, 0.5, 2);
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

        mainreplication.sceneEnabled(false);
        u111:Destroy();
        u112:Destroy();
        u110:Destroy();
    end);
end;

local u114 = {};

function v1.mvp_vipMvp(u115, p116) -- Line: 1413
    -- upvalues: u114 (copy), ReplicatedStorage2 (copy), Lighting (copy), mainreplication (copy), soundUtil (copy), Util (copy), UwUEffects (copy), vfxUtil (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), Density (copy), Color (copy)
    if u114[u115] then
        return;
    end;

    u114[u115] = true;
    local v117 = u115.HumanoidRootPart or u115.PrimaryPart;
    local vipMvp = ReplicatedStorage2.Resources.mvpAssets.vipMvp;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    soundUtil:play(vipMvp.soundmvp, ReplicatedStorage2);
    local v118 = mainreplication.cutscene(v117, CFrame.new(), p116, vipMvp.FOV);
    Util.CameraEffect(vipMvp.Cam, v118);
    UwUEffects.createEffect({
        Character = u115
    }, "VIPMVP");
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.delay(p116 - 1, function() -- Line: 1432
        -- upvalues: ScreenDimmer (copy), mainreplication (ref), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Atmosphere (copy), Density (ref), Color (ref), u114 (ref), u115 (copy)
        ScreenDimmer:Destroy();
        mainreplication.newblackscene(0.5, 0.5, 2);
        mainreplication.fov(false, 70);
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        task.wait(2);
        u114[u115] = nil;
    end);
end;

function v1.mvp_kunigamiMvp(u119, p120) -- Line: 1451
    -- upvalues: u114 (copy), ReplicatedStorage2 (copy), Lighting (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Util (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), Density (copy), Color (copy)
    if u114[u119] then
        return;
    end;

    u114[u119] = true;
    local v121 = u119.HumanoidRootPart or u119.PrimaryPart;
    local kunigamiMvp = ReplicatedStorage2.Resources.mvpAssets.kunigamiMvp;
    local Atmosphere = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    mainreplication.sceneEnabled(true);
    soundUtil:play(kunigamiMvp.soundmvp, ReplicatedStorage2);
    local v122 = mainreplication.cutscene(v121, CFrame.new(), p120, kunigamiMvp.FOV);
    Util.CameraEffect(kunigamiMvp.Cam, v122);
    kunigamiMvp.Two:Clone().Parent = u119["Right Arm"];
    kunigamiMvp.One:Clone().Parent = u119["Right Arm"];
    local u123 = kunigamiMvp.Land:Clone();
    u123.Parent = v121;
    local u124 = kunigamiMvp.KuniTriumph:Clone();
    local Weld = Instance.new("Weld");
    Weld.Part0 = v121;
    Weld.Part1 = u124;
    Weld.Parent = u124;
    u124.Parent = v121;
    local u125 = kunigamiMvp.Emit:Clone();
    u125.CFrame = v121.CFrame;
    u125.Parent = workspace.Effects;
    local u126 = {};

    for _, child in ipairs(u119:GetChildren()) do
        if child:IsA("Part") and child.Transparency < 1 then
            local v127 = child;

            for _, child2 in ipairs(ReplicatedStorage2.Resources.kunigami.chem.kuniAura:GetChildren()) do
                local v128 = child2:Clone();
                v128.Parent = v127;
                v128.Enabled = false;
                table.insert(u126, v128);
            end;
        end;
    end;

    task.delay(0.4, function() -- Line: 1499
        -- upvalues: u123 (copy)
        for _, descendant in pairs(u123:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.35, function() -- Line: 1507
        -- upvalues: u119 (copy)
        for _, descendant in pairs(u119["Left Arm"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.35, function() -- Line: 1515
        -- upvalues: mainreplication (ref)
        mainreplication.bright(1, 0.5);
    end);
    task.delay(2.3, function() -- Line: 1519
        -- upvalues: u124 (copy), u126 (copy), u119 (copy)
        for _, descendant in pairs(u124:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in u126 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;

        for _, v in u126 do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u119["Left Arm"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2.4, function() -- Line: 1542
        -- upvalues: u125 (copy)
        for _, descendant in pairs(u125:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4, function() -- Line: 1550
        -- upvalues: ScreenDimmer (copy), mainreplication (ref), u126 (copy), u124 (copy), u123 (copy), u125 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Atmosphere (copy), Density (ref), Color (ref)
        ScreenDimmer:Destroy();
        mainreplication.newblackscene(0.5, 0.5, 3);
        mainreplication.fov(false, 70);

        for _, v in u126 do
            v:Destroy();
        end;

        u124:Destroy();
        u123:Destroy();
        u125:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
    end);
end;

function v1.mvp_saeNextLevel(u129, p130) -- Line: 1574
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage2 (copy), PlayerGui (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), RunService (copy), vfxUtil (copy), Density (copy), Color (copy), Brightness (copy), Debris (copy)
    local v131 = u129.HumanoidRootPart or u129.PrimaryPart;
    local _ = u129.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.bright(-1, 0.55);
    mainreplication.sceneEnabled(true);
    local u132 = ReplicatedStorage2.Resources.Blur:Clone();
    u132.Size = 0;
    u132.Parent = Lighting;
    local v133 = ReplicatedStorage2.Resources.mvpAssets.sae.glowscreen:Clone();
    v133.Parent = PlayerGui;
    local ImageLabel2 = v133.ImageLabel2;
    ImageLabel2.ImageTransparency = 0;
    local u134 = ReplicatedStorage2.Resources.mvpAssets.sae.newsaeawkya.effectawk:Clone();
    u134:PivotTo(v131.CFrame);
    u134.Parent = u129;

    for _, descendant in ipairs(u134:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local u135 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u135.Parent = Lighting;
    u135.FarIntensity = 0;
    TweenService:Create(u135, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    local u136 = soundUtil:play(ReplicatedStorage2.Resources.mvpAssets.sae["sae theme"], SoundService);
    soundUtil:play(ReplicatedStorage2.Resources.mvpAssets.sae["Itoshi lock in"], SoundService);
    mainreplication.cutscene(v131, CFrame.new(Vector3.new(0, 0, 0)), 10.55, ReplicatedStorage2.Resources.mvpAssets.sae.FOV);
    local v137 = ReplicatedStorage2.Resources.mvpAssets.sae.newsaeawkya.eyesangle:Clone();
    v137.Weld.Part0 = u129.Head;
    v137.Parent = u134;

    for _, descendant in ipairs(u134.CAMERAPARTstart:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(1.75, function() -- Line: 1632
        -- upvalues: TekrinnDialogue (ref), u129 (copy)
        TekrinnDialogue.Speak(u129.Name, {
            {
                Text = "I\'m taking this game to the next level.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 4, "rbxassetid://87031389627015", Color3.fromRGB(255, 60, 135));
    end);
    task.delay(4.883, function() -- Line: 1658
        -- upvalues: TekrinnDialogue (ref), u129 (copy)
        TekrinnDialogue.Speak(u129.Name, {
            {
                Text = "Only the",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            },
            {
                Text = " idiots",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(253, 255, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 74, 116)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            },
            {
                Text = " who can keep up with me.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 4, "rbxassetid://87031389627015", Color3.fromRGB(255, 60, 135));
    end);
    task.delay(8.767, function() -- Line: 1726
        -- upvalues: TekrinnDialogue (ref), u129 (copy)
        TekrinnDialogue.Speak(u129.Name, {
            {
                Text = "will get to see what comes next.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 73, 112)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 1.35
                }
            }
        }, 1.35, "rbxassetid://87031389627015", Color3.fromRGB(255, 60, 135));
    end);
    task.delay(0.55, function() -- Line: 1755
        -- upvalues: ImageLabel2 (copy), u134 (copy)
        ImageLabel2.ImageTransparency = 1;
        u134.CAMERAPARTstart:Destroy();
    end);
    task.delay(0.667, function() -- Line: 1761
        -- upvalues: u134 (copy)
        for _, descendant in ipairs(u134.step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.933, function() -- Line: 1769
        -- upvalues: u134 (copy)
        for _, descendant in ipairs(u134.step2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.05, function() -- Line: 1777
        -- upvalues: u134 (copy)
        for _, descendant in ipairs(u134.step3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.183, function() -- Line: 1785
        -- upvalues: u134 (copy)
        for _, descendant in ipairs(u134.step4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.517, function() -- Line: 1793
        -- upvalues: u132 (copy), TweenService (ref), ColorCorrectionEffect (copy)
        u132.Size = 25;
        TweenService:Create(u132, TweenInfo.new(0.783, Enum.EasingStyle.Linear), {
            Size = 5
        }):Play();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 225, 241);
        ColorCorrectionEffect.Brightness = -1;
        ColorCorrectionEffect.Contrast = 1;
        ColorCorrectionEffect.Saturation = -0.8;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.516, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.466, Enum.EasingStyle.Linear), {
            Saturation = -0.4
        }):Play();
    end);
    task.delay(2.783, function() -- Line: 1806
        -- upvalues: TweenService (ref), u132 (copy)
        local v138 = TweenService:Create(u132, TweenInfo.new(0.084, Enum.EasingStyle.Linear), {
            Size = 25
        });
        v138:Play();
        v138.Completed:Wait();
        v138:Destroy();
        TweenService:Create(u132, TweenInfo.new(0.983, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end);
    task.delay(2.817, function() -- Line: 1815
        -- upvalues: u134 (copy)
        for _, descendant in ipairs(u134.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    local u139 = {};
    task.delay(2.983, function() -- Line: 1825
        -- upvalues: TweenService (ref), Atmosphere (copy), Lighting (ref), ColorCorrectionEffect (copy), u129 (copy), ReplicatedStorage2 (ref), u139 (copy), u134 (copy), RunService (ref)
        TweenService:Create(Atmosphere, TweenInfo.new(0.334, Enum.EasingStyle.Linear), {
            Density = 0.315,
            Color = Color3.fromRGB(255, 106, 138)
        }):Play();
        TweenService:Create(Lighting, TweenInfo.new(0.334, Enum.EasingStyle.Linear), {
            Brightness = 3,
            ColorShift_Top = Color3.fromRGB(255, 82, 183)
        }):Play();
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.534, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 103, 174)
        }):Play();

        for _, child in ipairs(u129:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v140 = child;

                for _, child2 in ipairs(ReplicatedStorage2.Resources.mvpAssets.sae.auraya:GetChildren()) do
                    local v141 = child2:Clone();
                    v141.Parent = v140;
                    table.insert(u139, v141);
                end;
            end;
        end;

        for _, descendant in ipairs(u134.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u134.step6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
                descendant.Enabled = true;
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    TimeScale = 0.05
                }):Play();
            end;
        end;

        local u142 = ReplicatedStorage2.Resources.mvpAssets.sae.newsaeawkya.CAMERAPART:Clone();
        u142.Parent = u134;

        for _, descendant in ipairs(u142:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        local u143 = nil;
        u143 = RunService.PreRender:connect(function() -- Line: 1886
            -- upvalues: u142 (copy), u143 (ref)
            if u142:IsDescendantOf(game) then
                u142.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -0.1) * CFrame.Angles(0, 0, -0.7853981633974483);

                return;
            end;

            u143:Disconnect();
        end);
    end);
    task.delay(3.05, function() -- Line: 1897
        -- upvalues: u134 (copy)
        for _, descendant in ipairs(u134.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.283, function() -- Line: 1905
        -- upvalues: u132 (copy), TweenService (ref), ColorCorrectionEffect (copy), ImageLabel2 (copy), u134 (copy)
        u132.Size = 25;
        TweenService:Create(u132, TweenInfo.new(0.284, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 103, 174);
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.Saturation = -0.8;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Contrast = 1,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 103, 174)
        }):Play();
        ImageLabel2.ImageTransparency = 0.6;

        for _, descendant in ipairs(u134.aura1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u134.step6:Destroy();
    end);
    task.delay(8.6, function() -- Line: 1932
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref), ReplicatedStorage2 (ref), u129 (copy), u134 (copy), u132 (copy)
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        local v144 = ReplicatedStorage2.Resources.mvpAssets.sae.newsaeawkya.eyeaura:Clone();
        v144.Weld.Part0 = u129.Head;
        v144.Parent = u134;

        for _, descendant in ipairs(u134.BeamDAD:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u132.Size = 25;
        TweenService:Create(u132, TweenInfo.new(0.767, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end);
    task.delay(10, function() -- Line: 1950
        -- upvalues: mainreplication (ref)
        mainreplication.newblackscene(0.5, 0.5, 2);
    end);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.delay(10.55, function() -- Line: 1956
        -- upvalues: ScreenDimmer (copy), u135 (copy), u134 (copy), ColorCorrectionEffect (copy), u139 (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), TweenService (ref), u136 (copy), Debris (ref), ImageLabel2 (copy), mainreplication (ref)
        ScreenDimmer:Destroy();
        u135:Destroy();
        u134:Destroy();
        ColorCorrectionEffect:Destroy();

        for _, v in u139 do
            v:Destroy();
        end;

        table.clear(u139);
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        TweenService:Create(u136, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Volume = 0
        }):Play();
        Debris:AddItem(u136, 1);
        ImageLabel2:Destroy();
        mainreplication.sceneEnabled(false);
    end);
end;

function v1.mvp_BIGBANGDRIVE(u145, p146) -- Line: 1982
    -- upvalues: ReplicatedStorage (copy), Lighting (copy), mainreplication (copy), ReplicatedStorage2 (copy), Util (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), vfxUtil (copy)
    local v147 = u145.HumanoidRootPart or u145.PrimaryPart;
    local u148 = ReplicatedStorage.Resources.Ball:Clone();
    u148.ball.Part0 = v147;
    u148.Parent = u145;
    local _ = u145.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local u149 = ReplicatedStorage2.Resources.mvpAssets.shidou.NEWBIGBANGDRIVE:Clone();
    u149:PivotTo(v147.CFrame);
    u149.Parent = u145;

    for _, descendant in ipairs(u149:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local u150 = Util.Preload({ ReplicatedStorage2.Resources.mvpAssets.shidou.ImpactFrame1, ReplicatedStorage2.Resources.mvpAssets.shidou.ImpactFrame2, ReplicatedStorage2.Resources.mvpAssets.shidou.ImpactFrame3 });
    local u151 = ReplicatedStorage2.Resources.Blur:Clone();
    u151.Size = 0;
    u151.Parent = Lighting;
    local u152 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
    TweenService:Create(u152, TweenInfo.new(0.417, Enum.EasingStyle.Linear), {
        Brightness = 0,
        Contrast = 0.3,
        Saturation = -0.2,
        TintColor = Color3.fromRGB(207, 218, 255)
    }):Play();
    u152.Parent = Lighting;
    local u153 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u153.Parent = Lighting;
    u153.FarIntensity = 0;
    TweenService:Create(u153, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage2.Resources.mvpAssets.shidou.bigbangdrive, SoundService);
    mainreplication.cutsceneBlender(v147, ReplicatedStorage2.Resources.mvpAssets.shidou.skill32, ReplicatedStorage2.Resources.mvpAssets.shidou.FOV);

    for _, descendant in ipairs(u149.help:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(0.733, function() -- Line: 2049
        -- upvalues: TekrinnDialogue (ref), u145 (copy)
        TekrinnDialogue.Speak(u145.Name, {
            {
                Text = "My soccer cells...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 2.5, "rbxassetid://123604384147107", Color3.fromRGB(255, 0, 132));
    end);
    task.delay(6.267, function() -- Line: 2075
        -- upvalues: TekrinnDialogue (ref), u145 (copy)
        TekrinnDialogue.Speak(u145.Name, {
            {
                Text = "are tingling and stirring to spark.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 5, "rbxassetid://123604384147107", Color3.fromRGB(255, 0, 132));
    end);
    task.delay(10.217, function() -- Line: 2101
        -- upvalues: TekrinnDialogue (ref), u145 (copy)
        TekrinnDialogue.Speak(u145.Name, {
            {
                Text = "With my goal...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 46, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = " With my genes...",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 3, "rbxassetid://123604384147107", Color3.fromRGB(255, 0, 132));
    end);
    task.delay(13.995, function() -- Line: 2149
        -- upvalues: TekrinnDialogue (ref), u145 (copy)
        TekrinnDialogue.Speak(u145.Name, {
            {
                Text = "BIG BANG DRIVE!!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            }
        }, 3, "rbxassetid://123604384147107", Color3.fromRGB(255, 0, 132));
    end);
    task.delay(18.583, function() -- Line: 2175
        -- upvalues: TekrinnDialogue (ref), u145 (copy)
        TekrinnDialogue.Speak(u145.Name, {
            {
                Text = "ILL BEAT YOU UP!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1.15
                }
            }
        }, 1.15, "rbxassetid://123604384147107", Color3.fromRGB(255, 0, 132));
    end);
    task.delay(0.633, function() -- Line: 2203
        -- upvalues: mainreplication (ref), u145 (copy), ReplicatedStorage2 (ref)
        mainreplication.Emit(u145.Head, ReplicatedStorage2.Resources.mvpAssets.shidou.EYE2, 3);
    end);
    task.delay(0.983, function() -- Line: 2207
        -- upvalues: u149 (copy)
        for _, descendant in ipairs(u149.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.717, function() -- Line: 2215
        -- upvalues: u149 (copy)
        for _, descendant in ipairs(u149.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.05, function() -- Line: 2223
        -- upvalues: u149 (copy)
        for _, descendant in ipairs(u149.help:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.667, function() -- Line: 2231
        -- upvalues: u149 (copy)
        for _, descendant in ipairs(u149.Jumpshidou:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u149.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.933, function() -- Line: 2245
        -- upvalues: u149 (copy)
        for _, descendant in ipairs(u149.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.2, function() -- Line: 2253
        -- upvalues: u149 (copy)
        for _, descendant in ipairs(u149.charge:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.417, function() -- Line: 2261
        -- upvalues: u149 (copy)
        for _, descendant in pairs(u149.bigbang1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.5, function() -- Line: 2270
        -- upvalues: u149 (copy)
        for _, descendant in pairs(u149.bigbang1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.567, function() -- Line: 2279
        -- upvalues: u152 (copy), TweenService (ref)
        u152.Brightness = -0.7;
        u152.Contrast = 1;
        u152.Saturation = 0;
        task.wait(0.016);
        u152.Brightness = 0;
        u152.Contrast = 0;
        u152.Saturation = 0;
        task.wait(0.016);
        u152.Brightness = -50;
        u152.Contrast = -200;
        u152.Saturation = -1;
        task.wait(0.016);
        u152.Brightness = 0;
        u152.Contrast = -200;
        u152.Saturation = -1;
        task.wait(0.016);
        u152.Brightness = 0;
        u152.Contrast = 200;
        u152.Saturation = -1;
        task.wait(0.016);
        u152.Brightness = 100;
        u152.Contrast = 500;
        u152.Saturation = -1;
        task.wait(0.016);
        u152.Brightness = 0;
        u152.Contrast = 200;
        u152.Saturation = -1;
        task.wait(0.016);
        u152.Brightness = -50;
        u152.Contrast = -200;
        u152.Saturation = -1;
        task.wait(0.016);
        u152.Brightness = 1;
        u152.Contrast = 20;
        u152.Saturation = -1;
        task.wait(0.016);
        u152.Brightness = 0.3;
        u152.Contrast = 10;
        u152.Saturation = -1;
        task.wait(0.016);
        u152.Brightness = -0.2;
        u152.Contrast = 0.3;
        u152.Saturation = 0.6;
        TweenService:Create(u152, TweenInfo.new(0.417, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 0.3,
            Saturation = -0.2,
            TintColor = Color3.fromRGB(207, 218, 255)
        }):Play();
    end);
    task.delay(4.6, function() -- Line: 2353
        -- upvalues: Util (ref), ReplicatedStorage2 (ref)
        Util.Gif(ReplicatedStorage2.Resources.mvpAssets.shidou.ImpactFrame1, 30);
    end);
    local u154 = nil;
    task.delay(4.667, function() -- Line: 2358
        -- upvalues: u154 (ref), ReplicatedStorage2 (ref), u145 (copy), u149 (copy)
        u154 = ReplicatedStorage2.Resources.mvpAssets.shidou.wingyaya:Clone();
        u154.Weld.Part0 = u145.Torso;
        u154.Parent = u149;

        for _, descendant in pairs(u149.helpemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(u149.charge:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u149.help:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u149.helpemit1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5.9, function() -- Line: 2393
        -- upvalues: u149 (copy)
        for _, descendant in pairs(u149.helpemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.1;
            end;
        end;
    end);
    task.delay(10.517, function() -- Line: 2402
        -- upvalues: u149 (copy)
        for _, descendant in pairs(u149.help:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u149.helpemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(10.533, function() -- Line: 2418
        -- upvalues: u154 (ref), u151 (copy), u152 (copy), TweenService (ref)
        if u154 then
            u154:Destroy();
        end;

        u151.Size = 10;
        u152.TintColor = Color3.fromRGB(255, 195, 209);
        u152.Brightness = -0.2;
        u152.Contrast = 1;
        u152.Saturation = -1;
        TweenService:Create(u151, TweenInfo.new(1.234, Enum.EasingStyle.Linear), {
            Size = 25
        }):Play();
        task.delay(1.234, function() -- Line: 2432
            -- upvalues: TweenService (ref), u151 (ref)
            TweenService:Create(u151, TweenInfo.new(0.75, Enum.EasingStyle.Linear), {
                Size = 0
            }):Play();
        end);
        TweenService:Create(u152, TweenInfo.new(1.117, Enum.EasingStyle.Linear), {
            Saturation = -0.8,
            TintColor = Color3.fromRGB(255, 105, 105)
        }):Play();
        task.wait(1.117);
        TweenService:Create(u152, TweenInfo.new(0.55, Enum.EasingStyle.Linear), {
            Saturation = -1,
            Contrast = 0.7,
            TintColor = Color3.fromRGB(255, 71, 71)
        }):Play();
        TweenService:Create(u152, TweenInfo.new(0.233, Enum.EasingStyle.Linear), {
            Brightness = 1
        }):Play();
        task.wait(0.233);
        TweenService:Create(u152, TweenInfo.new(0.167, Enum.EasingStyle.Linear), {
            Brightness = 0.4
        }):Play();
    end);
    local u155 = nil;
    task.delay(11.6, function() -- Line: 2460
        -- upvalues: u155 (ref), ReplicatedStorage2 (ref), u145 (copy), u149 (copy)
        u155 = ReplicatedStorage2.Resources.mvpAssets.shidou.eye2:Clone();
        u155.Weld.Part0 = u145.Head;
        u155.Parent = u149;

        for _, descendant in ipairs(u149.Blackhole:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(12.967, function() -- Line: 2472
        -- upvalues: u155 (ref), u152 (copy), u149 (copy)
        if u155 then
            u155:Destroy();
        end;

        u152.TintColor = Color3.fromRGB(177, 201, 255);
        u152.Brightness = 0;
        u152.Contrast = 0.3;
        u152.Saturation = -0.4;

        for _, descendant in ipairs(u149.Blackhole:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u149.AA2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(180);
            end;
        end;
    end);
    task.delay(15.85, function() -- Line: 2495
        -- upvalues: Util (ref), ReplicatedStorage2 (ref)
        Util.Gif(ReplicatedStorage2.Resources.mvpAssets.shidou.ImpactFrame2, 30);
    end);
    local u156 = {};
    task.delay(16.65, function() -- Line: 2501
        -- upvalues: u145 (copy), ReplicatedStorage2 (ref), u156 (copy), u152 (copy)
        for _, child in ipairs(u145:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v157 = child;

                for _, child2 in ipairs(ReplicatedStorage2.Resources.mvpAssets.shidou.lineya:GetChildren()) do
                    local v158 = child2:Clone();
                    v158.Parent = v157;
                    table.insert(u156, v158);
                end;
            end;
        end;

        u152.TintColor = Color3.fromRGB(255, 255, 255);
        u152.Brightness = 0;
        u152.Contrast = 0;
        u152.Saturation = 0;
    end);
    task.delay(17.05, function() -- Line: 2519
        -- upvalues: Util (ref), ReplicatedStorage2 (ref), u148 (copy), u149 (copy), u152 (copy), TweenService (ref)
        Util.Gif(ReplicatedStorage2.Resources.mvpAssets.shidou.ImpactFrame3, 30);

        if u148 then
            local v159 = ReplicatedStorage2.Resources.mvpAssets.shidou.ballspin:Clone();
            v159.Weld.Part0 = u148;
            v159.Parent = u149;
            task.delay(0.8, v159.Destroy, v159);
        end;

        for _, descendant in ipairs(u149.WIND:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u149.normalkick2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(10);
            end;
        end;

        u152.TintColor = Color3.fromRGB(255, 45, 203);
        u152.Brightness = 5;
        u152.Contrast = 6;
        u152.Saturation = -0.4;
        TweenService:Create(u152, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(17.85, function() -- Line: 2550
        -- upvalues: u156 (copy), u149 (copy), u152 (copy)
        for _, v in u156 do
            v:Destroy();
        end;

        table.clear(u156);
        u149.WIND:Destroy();
        u149.normalkick2:Destroy();
        u149.AA2:Destroy();
        u152.TintColor = Color3.fromRGB(255, 255, 255);
        u152.Brightness = 0;
        u152.Contrast = 0;
        u152.Saturation = 0;
    end);
    task.delay(18.467, function() -- Line: 2566
        -- upvalues: u151 (copy), u152 (copy), TweenService (ref)
        u151.Size = 25;
        u152.TintColor = Color3.fromRGB(240, 35, 255);
        u152.Contrast = 255;
        task.wait(0.1);
        u152.Contrast = 25;
        task.wait(0.05);
        TweenService:Create(u152, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Contrast = -3
        }):Play();
        TweenService:Create(u151, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
            Size = 7
        }):Play();
        TweenService:Create(u152, TweenInfo.new(0.666, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 5,
            Saturation = -0.3,
            TintColor = Color3.fromRGB(255, 66, 132)
        }):Play();
    end);
    task.delay(18.683, function() -- Line: 2588
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), u149 (copy)
        soundUtil:play(ReplicatedStorage.Resources.goal, SoundService);
        soundUtil:play(ReplicatedStorage.Resources.goal2, SoundService);

        for _, descendant in ipairs(u149.SCREAM:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(19.25, function() -- Line: 2598
        -- upvalues: mainreplication (ref)
        mainreplication.newblackscene(0.5, 0.5, 2);
    end);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.delay(19.85, function() -- Line: 2604
        -- upvalues: ScreenDimmer (copy), u150 (copy), u151 (copy), u149 (copy), u152 (copy), u153 (copy), mainreplication (ref)
        ScreenDimmer:Destroy();
        u150:Destroy();
        u151:Destroy();
        u149:Destroy();
        u152:Destroy();
        u153:Destroy();
        mainreplication.sceneEnabled(false);
    end);
end;

function v1.mvp_ssj4Mvp(p160, p161) -- Line: 2619
    -- upvalues: ReplicatedStorage2 (copy), Lighting (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Util (copy), UwUEffects (copy), animationUtil (copy)
    local v162 = p160.HumanoidRootPart or p160.PrimaryPart;
    local ssj4Mvp = ReplicatedStorage2.Resources.mvpAssets.ssj4Mvp;
    local _ = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    Lighting.Bloom.Threshold = 1.25;
    Lighting.ExposureCompensation = 0;
    Lighting.ClockTime = 14.5;
    Lighting.Brightness = 3;
    local u163 = p160:FindFirstChildOfClass("Shirt");
    mainreplication.sceneEnabled(true);
    soundUtil:play(ssj4Mvp.soundmvp, ReplicatedStorage2);
    local u164 = ssj4Mvp.clothinghanger:Clone();
    local Shirt = u164:WaitForChild("Shirt");
    u164:PivotTo(v162.CFrame);
    u164.Parent = workspace.Effects;
    Shirt.ShirtTemplate = u163.ShirtTemplate;
    task.delay(2.7, function() -- Line: 2644
        -- upvalues: u163 (copy)
        if u163 then
            u163.ShirtTemplate = "";
        end;
    end);
    local v165 = mainreplication.cutscene(v162, CFrame.new(), p161, ssj4Mvp.FOV);
    Util.CameraEffect(ssj4Mvp.Cam, v165);
    UwUEffects.createEffect({
        Character = p160
    }, "SSJ4Mvp");
    animationUtil:loadAnimation(u164, ssj4Mvp.Animation2):Play(0);
    task.delay(p161 - 0.5, function() -- Line: 2659
        -- upvalues: ScreenDimmer (copy), mainreplication (ref), u164 (copy), Util (ref)
        ScreenDimmer:Destroy();
        mainreplication.newblackscene(0.5, 0.5, 2);
        mainreplication.fov(false, 70);
        u164:Destroy();
        Util.ReturnLighting();
    end);
end;

function v1.mvp_isagiDemon(p166, p167) -- Line: 2671
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), UwUEffects (copy), Util (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy)
    local v168 = p166.HumanoidRootPart or p166.PrimaryPart;
    local isagiDemon = ReplicatedStorage2.Resources.mvpAssets.isagiDemon;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    mainreplication.sceneEnabled(true);
    soundUtil:play(isagiDemon.soundmvp, ReplicatedStorage2);
    mainreplication.cutsceneBlender(v168, isagiDemon.CamAnimation, isagiDemon.FOV);
    Lighting.Brightness = 2.5;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1.5;
    Lighting.Bloom.Threshold = 1;
    Lighting.ClockTime = 0;
    UwUEffects.createEffect({
        Character = p166
    }, "IsagiDemon");
    local u169 = Util.Preload(isagiDemon.Impact);
    task.delay(1.583, function() -- Line: 2693
        -- upvalues: Util (ref), isagiDemon (copy)
        Util.Gif(isagiDemon.Impact, 30);
    end);
    task.delay(p167 - 0.5, function() -- Line: 2697
        -- upvalues: ScreenDimmer (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref), mainreplication (ref), u169 (copy)
        ScreenDimmer:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
        mainreplication.fov(false, 70);
        mainreplication.blackscene(1);
        u169:Destroy();
    end);
end;

function v1.mvp_executedCelebration(p170, p171) -- Line: 2713
    -- upvalues: Lighting (copy), vfxUtil (copy), mainreplication (copy), ReplicatedStorage2 (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy), TweenService (copy), Density (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy), Color (copy)
    local v172 = p170.HumanoidRootPart or p170.PrimaryPart;
    local _ = p170.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    mainreplication.sceneEnabled(true);
    local u173 = ReplicatedStorage2.Resources.vb:Clone();
    u173.Parent = PlayerGui;
    local u174 = ReplicatedStorage2.Resources.glowscreen:Clone();
    u174.Parent = PlayerGui;
    u174.ImageLabel2.ImageTransparency = 0;
    u174.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 2.5;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1.5;
    Lighting.Bloom.Threshold = 1;
    Lighting.ClockTime = 14.5;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.55;
    ColorCorrectionEffect.Saturation = -0.4;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(161, 186, 255);
    local u175 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u175.Parent = Lighting;
    u175.FarIntensity = 1;
    local u176 = ReplicatedStorage2.Resources.mvpAssets.executedCelebration.allEffects:Clone();
    u176:PivotTo(v172.CFrame);
    u176.Parent = p170;
    soundUtil:play(ReplicatedStorage2.Resources.mvpAssets.executedCelebration.soundmvp, SoundService);
    mainreplication.cutsceneBlender(v172, ReplicatedStorage2.Resources.mvpAssets.executedCelebration.Animation2, ReplicatedStorage2.Resources.mvpAssets.executedCelebration.FOV);

    for _, descendant in ipairs(u176:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local v177 = ReplicatedStorage2.Resources.mvpAssets.executedCelebration.roseArm:Clone();
    v177.Weld.Part0 = p170["Left Arm"];
    v177.Parent = u176;
    local u178 = ReplicatedStorage2.Resources.mvpAssets.executedCelebration.roseEye:Clone();
    u178.Weld.Part0 = p170.Head;
    u178.Parent = u176;
    local u179 = ReplicatedStorage2.Resources.mvpAssets.executedCelebration.roseTorso:Clone();
    u179.Weld.Part0 = p170.Torso;
    u179.Parent = u176;
    task.delay(0.23333333333333334, function() -- Line: 2792
        -- upvalues: u176 (copy)
        for _, descendant in ipairs(u176.VFX.Floor:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                local v180 = descendant:GetAttribute("EmitDelay") or 0;
                local u181 = descendant:GetAttribute("EmitCount") or 1;
                local u182 = descendant:GetAttribute("EmitDuration") or 0;
                task.delay(v180, function() -- Line: 2800
                    -- upvalues: descendant (copy), u181 (copy), u182 (copy)
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(u181);
                    end;

                    if u182 > 0 then
                        descendant.Enabled = true;
                        task.wait(u182);
                        descendant.Enabled = false;
                    end;
                end);
            end;
        end;
    end);
    task.delay(1.5, function() -- Line: 2813
        -- upvalues: u176 (copy)
        for _, descendant in pairs(u176.VFX.star:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.7, function() -- Line: 2820
        -- upvalues: u176 (copy), u174 (copy), u175 (copy), Lighting (ref), ColorCorrectionEffect (copy), TweenService (ref), Atmosphere (copy)
        for _, descendant in ipairs(u176.VFX.Emit2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                local v183 = descendant:GetAttribute("EmitDelay") or 0;
                local u184 = descendant:GetAttribute("EmitCount") or 1;
                local u185 = descendant:GetAttribute("EmitDuration") or 0;
                task.delay(v183, function() -- Line: 2829
                    -- upvalues: descendant (copy), u184 (copy), u185 (copy)
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(u184);
                    end;

                    if u185 > 0 then
                        descendant.Enabled = true;
                        task.wait(u185);
                        descendant.Enabled = false;
                    end;
                end);
            end;
        end;

        for _, descendant in ipairs(u176.Beams:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u176.Spotlight:GetDescendants()) do
            if descendant:IsA("SpotLight") then
                descendant.Enabled = true;
            end;
        end;

        u176.Tetsintigng.Transparency = 0;
        u176.Tetsintigng.Decal.Transparency = 0;

        for _, descendant in ipairs(u176["beam light"]:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u176.chaptersayshi:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u174.ImageLabel2.ImageColor3 = Color3.fromRGB(44, 55, 115);
        u175.FocusDistance = 0;
        u175.InFocusRadius = 9;
        u175.FarIntensity = 1;
        u175.NearIntensity = 0.75;
        Lighting.Brightness = 1;
        ColorCorrectionEffect.Brightness = 1;
        ColorCorrectionEffect.Contrast = 1;
        ColorCorrectionEffect.Saturation = -0.3;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            Brightness = 0
        }):Play();
        Atmosphere.Density = 0.6;
        Atmosphere.Color = Color3.fromRGB(0, 0, 0);
    end);
    task.delay(2.85, function() -- Line: 2883
        -- upvalues: TweenService (ref), u174 (copy), Lighting (ref), ColorCorrectionEffect (copy)
        TweenService:Create(u174.ImageLabel2, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(Lighting.Bloom, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            Threshold = 2
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            Brightness = -0.7,
            Saturation = -0.15,
            TintColor = Color3.fromRGB(207, 228, 255)
        }):Play();
    end);
    task.delay(3, function() -- Line: 2888
        -- upvalues: u178 (copy)
        for _, descendant in pairs(u178:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3, function() -- Line: 2895
        -- upvalues: u179 (copy)
        for _, descendant in pairs(u179:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(5.15, function() -- Line: 2902
        -- upvalues: u176 (copy)
        for _, descendant in pairs(u176.VFX.star:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(6.233, function() -- Line: 2910
        -- upvalues: ScreenDimmer (copy), mainreplication (ref), ColorCorrectionEffect (copy), Atmosphere (copy), Density (ref), u173 (copy), u176 (copy), u174 (copy), u175 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref), Color (ref)
        ScreenDimmer:Destroy();
        mainreplication.blackscene(1);
        ColorCorrectionEffect:Destroy();
        Atmosphere.Density = Density;
        u173:Destroy();
        u176:Destroy();
        u174:Destroy();
        u175:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        mainreplication.fov(false, 70);
    end);
end;

local function LoadAvatar(p186, p187) -- Line: 2944
    if p187 then
        for _, child in p187:GetChildren() do
            if child:IsA("Accessory") or (child:IsA("BodyColors") or (child:IsA("Shirt") or (child:IsA("Pants") or (child:IsA("ShirtGraphic") or child:IsA("CharacterMesh"))))) then
                local v188 = child:Clone();
                v188.Parent = p186;

                if v188:IsA("Accessory") then
                    local Handle = v188:FindFirstChild("Handle");

                    if Handle then
                        local v189 = Handle:FindFirstChildWhichIsA("Weld");

                        if v189 then
                            v189.Part1 = p186:FindFirstChild(v189.Part1.Name);
                        end;
                    end;
                end;
            end;
        end;

        local Head = p187:FindFirstChild("Head");

        if Head then
            local face = Head:FindFirstChild("face");
            local v190 = Head:FindFirstChildWhichIsA("SpecialMesh");

            if face then
                face:Clone().Parent = p186.Head;
            end;

            if v190 then
                v190:Clone().Parent = p186.Head;
            end;
        end;
    end;
end;

function v1.mvp_TripleTMVP(u191, p192) -- Line: 2976
    -- upvalues: ReplicatedStorage (copy), trove (copy), Lighting (copy), LoadAvatar (copy), Players (copy), mainreplication (copy), camerasreplication (copy), LocalPlayer (copy), u4 (copy)
    local Lighting2 = game:GetService("Lighting");
    local Teams = game:GetService("Teams");
    local TweenService2 = game:GetService("TweenService");
    local workspace_CurrentCamera2 = workspace.CurrentCamera;
    local TripleTMVP = ReplicatedStorage.Resources.mvpAssets.TripleTMVP;
    local u193 = trove.new();
    local v194 = u191.HumanoidRootPart or u191.PrimaryPart;
    u191.Parent = Lighting;
    u193:AttachToInstance(u191);
    local u195 = u193:Add(ReplicatedStorage.Resources.Rig:Clone());
    local u196 = u193:Add(ReplicatedStorage.Resources.Rig:Clone());
    local v197 = TripleTMVP.Bat:Clone();
    v197.Parent = u196;
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Parent = u196["Right Arm"];
    Motor6D.Part0 = Motor6D.Parent;
    Motor6D.Part1 = v197;
    Motor6D.C0 = CFrame.new(0, -1, -1.5, 0, 1, 0, 1, 0, 0, 0, 0, -1);
    LoadAvatar(u196, u191);
    u196:ScaleTo(0.75);
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u191);
    local v198 = PlayerFromCharacter and PlayerFromCharacter.Team and PlayerFromCharacter.Team.Name;
    local v199 = v198 and (v198 == "A" and Teams:FindFirstChild("B") or Teams:FindFirstChild("A"));

    if v199 then
        local Players2 = v199:GetPlayers();

        if #Players2 ~= 0 then
            local v200 = Players2[math.random(1, #Players2)];

            if v200.Character then
                LoadAvatar(u195, v200.Character);
            end;
        end;
    end;

    u195.HumanoidRootPart.CFrame = v194.CFrame;
    u196.HumanoidRootPart.CFrame = v194.CFrame * CFrame.new(0, -0.75, -2) * CFrame.fromEulerAnglesYXZ(0, 3.141592653589793, 0);
    u195.Parent = workspace.Effects;
    u196.Parent = workspace.Effects;
    local v201 = TripleTMVP.Bat:Clone();
    v201.Parent = u195;
    local Motor6D2 = Instance.new("Motor6D");
    Motor6D2.Parent = u195["Left Arm"];
    Motor6D2.Part0 = Motor6D2.Parent;
    Motor6D2.Part1 = v201;
    Motor6D2.C0 = CFrame.new(0, -1, -1.5, 0, 1, 0, 1, 0, 0, 0, 0, -1);
    local v202 = u195.Humanoid.Animator:LoadAnimation(TripleTMVP.Animations.User);
    local v203 = u196.Humanoid.Animator:LoadAnimation(TripleTMVP.Animations.Victim);
    local _ = u191.Torso;
    local _ = Lighting.Atmosphere;
    v202:Play(0);
    v203:Play(0);
    mainreplication.sceneEnabled(true);
    local u204 = camerasreplication.KimCamera(u195.HumanoidRootPart, TripleTMVP.Animations.CameraRig, nil, CFrame.new(0, 0, 0));
    ({}).CameraRig = u204;
    local u205 = TripleTMVP.sfx:Clone();
    u205.Parent = workspace;
    u205:Play();
    local u206 = TripleTMVP.funk:Clone();
    u206.Volume = 0.25;
    u206.Parent = workspace;
    u206:Play();
    u206.TimePosition = 1.9300000000000002;
    u193:Add(task.delay(0.67, function() -- Line: 3066
        -- upvalues: TripleTMVP (copy), LocalPlayer (ref), u4 (ref), Lighting2 (copy), workspace_CurrentCamera2 (copy), TweenService2 (copy), u193 (copy), u206 (copy)
        local u207 = TripleTMVP.dumbframe:Clone();
        u207.Enabled = true;
        u207.Parent = LocalPlayer.PlayerGui or nil;
        u207.ImageLabel.ImageTransparency = 1;
        u4.cameraShake(150, 1, 20);
        local BloomEffect = Instance.new("BloomEffect");
        BloomEffect.Size = 60;
        BloomEffect.Parent = Lighting2;
        workspace_CurrentCamera2.FieldOfView = 120;
        TweenService2:Create(workspace_CurrentCamera2, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 70
        }):Play();
        TweenService2:Create(BloomEffect, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = 0
        }):Play();
        TweenService2:Create(u207.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ImageTransparency = 0.1
        }):Play();
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Brightness = 0.3;
        ColorCorrectionEffect.Parent = Lighting2;
        TweenService2:Create(ColorCorrectionEffect, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Brightness = 0
        }):Play();
        local v208 = 0;

        for i = 1, 4 do
            local v209 = v208 + 1;
            local ColorCorrectionEffect2 = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect2.Brightness = v209 == 2 and -0.7 or 0.05;
            ColorCorrectionEffect2.Parent = Lighting2;
            v208 = v209 >= 2 and 0 or v209;
            task.wait(0.025);
            pcall(game.Destroy, ColorCorrectionEffect2);
            local _ = i;
        end;

        u193:Add(task.delay(2, function() -- Line: 3098
            -- upvalues: TweenService2 (ref), u206 (ref), u207 (copy), BloomEffect (copy), ColorCorrectionEffect (copy)
            TweenService2:Create(u206, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Volume = 0
            }):Play();
            TweenService2:Create(u207.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ImageTransparency = 1
            }):Play();
            task.wait(1.1);
            pcall(game.Destroy, BloomEffect);
            pcall(game.Destroy, ColorCorrectionEffect);
            pcall(game.Destroy, u207);
        end));
    end));
    u193:Add(function() -- Line: 3109
        -- upvalues: mainreplication (ref), u191 (copy), Lighting2 (copy), u204 (copy), u195 (copy), u196 (copy), u206 (copy), u205 (copy), LocalPlayer (ref), workspace_CurrentCamera2 (copy)
        mainreplication.blackscene(0.5);
        task.wait(0.5);

        if u191 and u191.Parent == Lighting2 then
            u191.Parent = workspace.characters;
        end;

        u204:Destroy();
        pcall(game.Destroy, u195);
        pcall(game.Destroy, u196);
        pcall(game.Destroy, u206);
        pcall(game.Destroy, u205);

        if LocalPlayer and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) then
            workspace_CurrentCamera2.CameraSubject = LocalPlayer.Character.Humanoid;

            return;
        end;

        local v210 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
        local v211 = v210 and v210:WaitForChild("Humanoid");

        if v211 then
            workspace_CurrentCamera2.CameraSubject = v211;
        end;
    end);
    task.delay(p192, function() -- Line: 3133
        -- upvalues: u193 (copy)
        u193:Destroy();
    end);
end;

function v1.mvp_nelisagiMVP(p212, p213) -- Line: 3138
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), ReplicatedStorage2 (copy), animationUtil (copy), UwUEffects (copy), soundUtil (copy), SoundService (copy), workspace_CurrentCamera (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), OutdoorAmbient (copy), Ambient (copy), ClockTime (copy), Density (copy), Offset (copy), Color (copy), Decay (copy), Glare (copy), Haze (copy)
    local v214 = p212.HumanoidRootPart or p212.PrimaryPart;
    local _ = p212.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local NelIsagiMvp = ReplicatedStorage.Resources.mvpAssets.NelIsagiMvp;
    local v215 = NelIsagiMvp.VFX:Clone();
    v215:PivotTo(v214.CFrame);
    v215.Parent = p212;
    Lighting.Brightness = 3;
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.ExposureCompensation = 0;
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ClockTime = 14.5;
    Atmosphere.Density = 0.3;
    Atmosphere.Offset = 0.25;
    Atmosphere.Color = Color3.fromRGB(199, 199, 199);
    Atmosphere.Decay = Color3.fromRGB(106, 112, 125);
    Atmosphere.Glare = 0;
    Atmosphere.Haze = 0;
    local u216 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u216.Parent = Lighting;
    u216.FarIntensity = 0.1;
    u216.FocusDistance = 0.05;
    u216.InFocusRadius = 30;
    u216.NearIntensity = 0.75;
    local u217 = ReplicatedStorage.Resources.Blur:Clone();
    u217.Size = 24;
    u217.Parent = Lighting;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    local v218 = {
        CameraRig = mainreplication.cutsceneCamRigWithLetterBox(v214, NelIsagiMvp.Animations.CameraRig, NelIsagiMvp.FOV, p212, CFrame.new(0, -3, 0), NelIsagiMvp.Models.CameraRig)
    };

    for _, child in NelIsagiMvp.Models:GetChildren() do
        if not v218[child.Name] then
            local v219 = child:Clone();
            v219.Parent = p212;
            v219:PivotTo(v214.CFrame * (child:GetAttribute("Offset") or CFrame.new(0, -3, 0)));

            if not table.find({ "FakeHead", "CameraRig" }, child.Name) and NelIsagiMvp.Animations:FindFirstChild(child.Name) then
                animationUtil:loadAnimation(v219, NelIsagiMvp.Animations:FindFirstChild(child.Name)):Play();
            end;

            if v219.Name == "FakeHead" then
                v219.Head.Weld.Part1 = p212:FindFirstChild("Head") or v214;
            end;

            v218[child.Name] = v219;
        end;
    end;

    UwUEffects.createEffect({
        Atmosphere = Atmosphere,
        Blur = u217,
        Depth = u216,
        ColorCorrection = ColorCorrectionEffect,
        Character = p212,
        Models = v218,
        Effects = v215
    }, "NelisagiMVP");
    soundUtil:play(NelIsagiMvp.soundmvp, SoundService);
    local u220 = {};

    for _, child in workspace_CurrentCamera:GetChildren() do
        if child:IsA("Attachment") then
            table.insert(u220, child);
            child.Parent = ReplicatedStorage;
        end;
    end;

    task.delay(p213, function() -- Line: 3211
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end);
    task.delay(p213 + 0.5, function() -- Line: 3214
        -- upvalues: u220 (copy), workspace_CurrentCamera (ref), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), OutdoorAmbient (ref), Ambient (ref), ClockTime (ref), Atmosphere (copy), Density (ref), Offset (ref), Color (ref), Decay (ref), Glare (ref), Haze (ref), u216 (copy), ColorCorrectionEffect (copy), u217 (copy), mainreplication (ref)
        for _, v in u220 do
            v.Parent = workspace_CurrentCamera;
        end;

        table.clear(u220);
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
        Atmosphere.Density = Density;
        Atmosphere.Offset = Offset;
        Atmosphere.Color = Color;
        Atmosphere.Decay = Decay;
        Atmosphere.Glare = Glare;
        Atmosphere.Haze = Haze;
        pcall(game.Destroy, u216);
        pcall(game.Destroy, ColorCorrectionEffect);
        pcall(game.Destroy, u217);
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_MightMVP(p221, p222) -- Line: 3244
    -- upvalues: trove (copy), Lighting (copy), vfxUtil (copy), mainreplication (copy), ReplicatedStorage (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy)
    local u223 = trove.new();
    local v224 = p221.HumanoidRootPart or p221.PrimaryPart;
    local _ = Lighting.Atmosphere;
    u223:AttachToInstance(p221);
    u223:Add(vfxUtil.getScreenDimmer());
    mainreplication.sceneEnabled(true);
    local MightMVP = ReplicatedStorage.Resources.mvpAssets.MightMVP;
    local v225 = u223:Construct(MightMVP.Blur);
    v225.Parent = Lighting;
    local v226 = u223:Construct(MightMVP.VFX);
    v226:PivotTo(v224.CFrame * CFrame.new(0, 3.105, 0));
    v226.Parent = p221;
    v226.Steam.Weld.Part0 = p221:FindFirstChild("Left Arm") or v224;
    local ScreenEffect = v226.ScreenEffect;
    ScreenEffect.Parent = workspace;
    u223:Add(ScreenEffect);
    local ScreenEffect2 = v226.ScreenEffect2;
    ScreenEffect2.Parent = workspace;
    u223:Add(ScreenEffect2);
    local Breath = v226.Breath;
    Breath.Parent = p221:FindFirstChild("Head") or v224;
    u223:Add(Breath);
    local Eyes = v226.Eyes;
    Eyes.Parent = p221:FindFirstChild("Head") or v224;
    u223:Add(Eyes);
    local Lights2 = v226.Lights2;
    Lights2.Parent = v224;
    u223:Add(Lights2);
    local Lights = v226.Lights;
    Lights.Parent = v224;
    u223:Add(Lights);
    local v227 = u223:Construct(vfxUtil.getMoonEffects);
    local v228 = MoonPropertyAnimator.new();
    v228:LoadSave(MightMVP.MVP, MoonPropertyAnimator.ConvertSave(MightMVP.MVP, {
        Vignette = v227.Vignette,
        ["Screen Cover"] = v227["Screen Cover"],
        LetterBox = v227.Letterbox
    }));
    v228:PlayAll();
    local v229 = mainreplication.cutsceneCamRigWithLetterBox(v224, MightMVP.Animations.Camera, MightMVP.FOV, p221, CFrame.new(0, -3, 0), MightMVP.Camera);

    if v229 then
        u223:Add(v229);
    end;

    soundUtil:play(MightMVP.soundmvp, SoundService);
    u223:Add(task.delay(3.233, shared.vfx.emit, v226["Spot Lights2"], Lights2));
    u223:Add(task.delay(5.333, shared.vfx.emit, ScreenEffect));
    u223:Add(task.delay(6.083, shared.vfx.emit, v226.Rootpart));
    u223:Add(task.delay(9.883, shared.vfx.emit, Lights, Eyes, v226["Spot Lights"], v225));
    u223:Add(task.delay(9.9, shared.vfx.emit, ScreenEffect2));
    u223:Add(task.delay(11.5, shared.vfx.emit, Breath));
    u223:Add(task.delay(17.483, function() -- Line: 3314
        -- upvalues: u223 (copy), mainreplication (ref)
        u223:Destroy();
        mainreplication.fov(false, 70);
    end));
end;

function v1.mvp_bachiraMVP(p230, p231) -- Line: 3320
    -- upvalues: Lighting (copy), mainreplication (copy), vfxUtil (copy), ReplicatedStorage (copy), UwUEffects (copy), soundUtil (copy), SoundService (copy)
    local v232 = p230.HumanoidRootPart or p230.PrimaryPart;
    local _ = p230.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local bachiraMVP = ReplicatedStorage.Resources.mvpAssets.bachiraMVP;
    local v233 = bachiraMVP.VFX:Clone();
    v233:PivotTo(v232.CFrame);
    v233.Parent = p230;

    for _, child in bachiraMVP.Trails:GetChildren() do
        if p230:FindFirstChild(child.Name) then
            local v234 = p230:FindFirstChild(child.Name);
            local v235 = child:Clone();
            v235.Weld.Part0 = v234;
            v235.Parent = v234;
        end;
    end;

    ({}).CameraRig = mainreplication.cutsceneCamRigWithLetterBox(v232, bachiraMVP.Animations.Cam, bachiraMVP.FOV, p230, CFrame.new(0, -3, 0));
    UwUEffects.createEffect({
        BachiraVFX = v233,
        Character = p230
    }, "bachiraMVP");
    soundUtil:play(bachiraMVP.soundmvp, SoundService);
    task.delay(p231 - 0.5, function() -- Line: 3350
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end);
    task.delay(p231, function() -- Line: 3354
        -- upvalues: ScreenDimmer (copy), mainreplication (ref)
        ScreenDimmer:Destroy();
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_thanksgivingMVP(p236, p237) -- Line: 3361
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy)
    local v238 = p236.HumanoidRootPart or p236.PrimaryPart;
    local _ = p236.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local thanksgivingMVP = ReplicatedStorage.Resources.mvpAssets.thanksgivingMVP;
    local v239 = thanksgivingMVP.VFX:Clone();
    v239:PivotTo(v238.CFrame);
    v239.Parent = p236;
    mainreplication.cutsceneCamRigWithLetterBox(v238, thanksgivingMVP.Animations.Cam, nil, p236, CFrame.new(0, -3, 0));
    soundUtil:play(thanksgivingMVP.soundmvp, SoundService);
    task.delay(p237 - 0.5, function() -- Line: 3377
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end);
    task.delay(p237, function() -- Line: 3381
        -- upvalues: mainreplication (ref)
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_kiyoraappraisal(p240: userdata, p241: number, p242: any, p243: table) -- Line: 3386
    -- upvalues: vfxUtil (copy), mainreplication (copy), Players (copy), animationUtil (copy), soundUtil (copy), MoonPropertyAnimator (copy)
    local kiyoraappraisal = vfxUtil.getResources().mvpAssets.kiyoraappraisal;
    local v244 = vfxUtil.mvp_cutscene_defaults(mainreplication, p241);
    local Root = vfxUtil.getRoot(p240);
    local u245 = v244:Construct(vfxUtil.newRigForFriend, Root, Players:GetPlayerFromCharacter(p240));
    task.defer(function() -- Line: 3393
        -- upvalues: animationUtil (ref), u245 (copy), kiyoraappraisal (copy)
        animationUtil:loadAnimation(u245, kiyoraappraisal.Animations.Team1):Play(0);
    end);
    soundUtil:play(kiyoraappraisal.Sound, "default");
    local v246 = v244:Construct(kiyoraappraisal.Teamate1);
    vfxUtil.setupAura(p243[1], v246, true, true);
    v246.Parent = workspace.Effects;
    local v247 = v244:Construct(kiyoraappraisal.Teamate2);
    vfxUtil.setupAura(p243[2], v247, true, true);
    v247.Parent = workspace.Effects;
    local v248, v249 = mainreplication.cutsceneCamRigWithLetterBox(Root, kiyoraappraisal.Animations.Cam, kiyoraappraisal.FOV, nil, CFrame.new(-0.005, -3.062, -0.017) * CFrame.Angles(0, 3.141592653589793, 0), kiyoraappraisal.HumanoidCameraRig, "Torso");
    v244:Add(v249);
    local v250 = {
        HumanoidCameraRig = v248,
        ["Screen Cover"] = v244:Add(vfxUtil.getMoonEffects())["Screen Cover"]
    };
    local v251 = v244:Construct(MoonPropertyAnimator);
    v251:LoadAndConvertSave(kiyoraappraisal.Moon, v250);
    v251:SetRoot(Root);
    v251:PlayAll();
    vfxUtil.execute_compiled(kiyoraappraisal.Compiled, v244, v246, v247);
end;

function v1.mvp_otoyakarasu(p252: userdata, p253: number, p254: any, p255: table) -- Line: 3427
    -- upvalues: vfxUtil (copy), mainreplication (copy), Players (copy), animationUtil (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local otoyakarasu = vfxUtil.getResources().mvpAssets.otoyakarasu;
    local v256 = vfxUtil.mvp_cutscene_defaults(mainreplication, p253);
    local Root = vfxUtil.getRoot(p252);

    if p255[1] then
        p255[1]:Destroy();
    end;

    local u257 = v256:Construct(vfxUtil.newRigForFriend, Root, Players:GetPlayerFromCharacter(p252));
    task.defer(function() -- Line: 3438
        -- upvalues: animationUtil (ref), u257 (copy), otoyakarasu (copy)
        animationUtil:loadAnimation(u257, otoyakarasu.Animations.Otoya):Play(0);
    end);
    soundUtil:play(otoyakarasu.Sound, "default");
    local v258 = v256:Construct(otoyakarasu.Karasu);
    vfxUtil.setupAura(p252, v258, true, true);
    v258.Parent = workspace.Effects;
    local v259 = v256:Construct(otoyakarasu.Otoya);
    vfxUtil.setupAura(u257, v259, true, true);
    v259.Parent = workspace.Effects;
    local v260, v261 = mainreplication.cutsceneCamRigWithLetterBox(Root, otoyakarasu.Animations.Cam, otoyakarasu.FOV, nil, "default", otoyakarasu.Camera, "CamPart");
    v256:Add(v261);
    local v262 = {
        HumanoidCameraRig = v260,
        ["Screen Cover"] = v256:Add(vfxUtil.getMoonEffects())["Screen Cover"],
        Lighting = Lighting
    };
    local v263 = v256:Construct(MoonPropertyAnimator);
    v263:LoadAndConvertSave(otoyakarasu.Moon, v262);
    v263:SetRoot(Root);
    v263:PlayAll();
    vfxUtil.execute_compiled(otoyakarasu.Compiled, v256, v258, v259, v260);
    vfxUtil.cutscene_lighting(v256, v262, otoyakarasu.Lighting, {
        Brightness = 3,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ClockTime = 14.5,
        GeographicLatitude = 0,
        ExposureCompensation = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70),
        ColorShift_Top = Color3.fromRGB(0, 0, 0),
        ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
    });
end;

function v1.mvp_saemvp2(p264: any, p265: any, p266: any, p267: table) -- Line: 3485
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy)
    local saemvp2 = vfxUtil.getResources().mvpAssets.saemvp2;
    local v268 = vfxUtil.mvp_cutscene_defaults(mainreplication, p265);
    local Root = vfxUtil.getRoot(p264);
    soundUtil:play(saemvp2.Sound, "default");
    local _, v269 = mainreplication.cutsceneCamRigWithLetterBox(Root, saemvp2.Animations.Cam, saemvp2.FOV, nil, "default", saemvp2.Cam, "CamPart");
    v268:Add(v269);
    local v270 = v268:Construct(saemvp2.SaeAura);
    vfxUtil.setupAura(p264, v270, true, true);
    v270.Parent = workspace.Effects;
    local v271 = v268:Construct(saemvp2.VictimAura);
    vfxUtil.setupAura(p267[1], v271, true, true);
    v271.Parent = workspace.Effects;
    local v272 = v268:Add(vfxUtil.getMoonEffects());
    vfxUtil.cutscene_lighting(v268, {
        Vignette = v272.Vignette,
        Letterbox = v272.Letterbox,
        ["Screen Cover"] = v272["Screen Cover"],
        Lighting = Lighting
    }, saemvp2.Lighting, {
        Brightness = 3,
        EnvironmentDiffuseScale = 0.6,
        EnvironmentSpecularScale = 1,
        ClockTime = 12,
        GeographicLatitude = 24,
        ExposureCompensation = 0.2,
        Ambient = Color3.fromRGB(255, 255, 255),
        OutdoorAmbient = Color3.fromRGB(47, 47, 47),
        ColorShift_Top = Color3.fromRGB(0, 0, 0),
        ColorShift_Bottom = Color3.fromRGB(27, 217, 238)
    });
    vfxUtil.execute_compiled(saemvp2.Compiled, v268, v271);
end;

function v1.mvp_dawnwalkerMVP(p273: any, p274: any, p275: any, p276: table) -- Line: 3534
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), PlayerGui (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local dawnwalkerMVP = vfxUtil.getResources().mvpAssets.dawnwalkerMVP;
    local v277 = vfxUtil.mvp_cutscene_defaults(mainreplication, p274);
    soundUtil:play(dawnwalkerMVP.soundmvp, "default");
    local Root = vfxUtil.getRoot(p273);
    local v278 = v277:Clone(dawnwalkerMVP.Map);
    v278:PivotTo(Root.CFrame * CFrame.new(1.2485475540161133, 45.638824462890625, 0.4774169921875));
    v278.Parent = workspace.Effects;
    local v279, v280 = mainreplication.cutsceneCamRigWithLetterBox(Root, dawnwalkerMVP.Animations.Cam, nil, nil, CFrame.new(0.8337185978889465, -3, 0) * CFrame.Angles(0, -1.5707963267948966, 0), dawnwalkerMVP.Cam, "CamPart");
    v277:Add(v280);

    local function playOnce(p281: userdata?) -- Line: 3547
        if not p281 then
            return;
        end;

        local v282 = p281:FindFirstChildOfClass("Humanoid") or p281:FindFirstChildOfClass("AnimationController");

        if v282 then
            v282 = v282:FindFirstChildOfClass("Animator");
        end;

        if not v282 then
            return;
        end;

        for _, v in v282:GetPlayingAnimationTracks() do
            v.Looped = false;
        end;
    end;

    playOnce(p273);

    if p276 then
        for _, v in p276 do
            playOnce(v);
        end;
    end;

    local v283 = v277:Clone(dawnwalkerMVP.VFX);
    v283:PivotTo(Root.CFrame);
    v283.Parent = workspace.Effects;
    local v284 = {
        [v283:FindFirstChild("CamVfx")] = v279:FindFirstChild("CamPart"),
        [v283:FindFirstChild("FakeHead")] = p273:FindFirstChild("Head"),
        [v283:FindFirstChild("FakeRarm")] = p273:FindFirstChild("Right Arm")
    };

    for _, descendant in v283:GetDescendants() do
        if descendant:IsA("BasePart") then
            local v285 = descendant;
            local v286 = false;

            for i in v284 do
                if v285 == i or v285:IsDescendantOf(i) then
                    v286 = true;
                    break;
                end;
            end;

            v285.Anchored = not v286;
        end;
    end;

    for i, v in v284 do
        if i and v then
            local Weld = Instance.new("Weld");
            Weld.Part0 = v;
            Weld.Part1 = i;
            Weld.C0 = v.CFrame:ToObjectSpace(i.CFrame);
            Weld.Parent = i;
        end;
    end;

    local v287 = p273:FindFirstChild("Torso") or p273:FindFirstChild("UpperTorso");

    if v287 then
        for _, child in dawnwalkerMVP.Aura:GetChildren() do
            v277:Clone(child).Parent = v287;
        end;
    end;

    local v288 = v277:Clone(dawnwalkerMVP.Vignette);
    v288.Parent = PlayerGui;
    local v289 = {
        Main = v288.Frame.Main,
        Lighting = Lighting,
        CurrentCamera = workspace.CurrentCamera
    };
    vfxUtil.cutscene_lighting(v277, v289, dawnwalkerMVP.Lighting, {
        Brightness = 3,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        GlobalShadows = true,
        ShadowSoftness = 0.2,
        ExposureCompensation = 0,
        ClockTime = 14.5,
        GeographicLatitude = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        ColorShift_Top = Color3.new(0, 0, 0),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });

    if p276 then
        p276 = p276[1];
    end;

    vfxUtil.execute_compiled(dawnwalkerMVP.Compiled, v277, v283, p273, p276);
    local v290 = v277:Construct(MoonPropertyAnimator);
    v290:LoadAndConvertSave(dawnwalkerMVP.Moon, v289);
    v290:SetRoot(Root);
    v290:PlayAll();
end;

function v1.mvp_luffyRanked(u291, p292, p293, p294) -- Line: 3636
    -- upvalues: vfxUtil (copy), mainreplication (copy), trove (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), TekrinnDialogue (copy), Util (copy)
    local Root = vfxUtil.getRoot(u291);

    if not Root then
        return;
    end;

    mainreplication.sceneEnabled(true);
    local v295 = p294[1];
    local luffyRanked = vfxUtil.getResources().mvpAssets.luffyRanked;
    local u296 = trove.new();
    local v297 = u296:Clone(luffyRanked.VFX.VFX);
    v297:PivotTo(Root.CFrame);
    v297.Parent = workspace.Effects;
    local FakeheadV = v297.FakeheadV;
    FakeheadV.Parent = v295;
    FakeheadV.Weld.Part0 = v295.Head;

    for _, child in u296:Clone(luffyRanked.VFX.Aura):GetChildren() do
        for _, child2 in child:GetChildren() do
            child2.Parent = u291[child2.Parent.Name];
        end;
    end;

    vfxUtil.setupAura(u291, luffyRanked.VFX.Aura, true);
    local v298, v299 = mainreplication.cutsceneBlender(Root, luffyRanked.Animations.Camera, luffyRanked.FOV_Luffy, nil, nil, CFrame.new(0, -3, 0));
    u296:Add(v299);

    for _, child in u296:Clone(luffyRanked.VFX.CamStuff):GetChildren() do
        child.Parent = v298.CamPart;

        if child.Name == "CamLines" then
            child.Weld.Part0 = v298.CamPart;
        end;
    end;

    vfxUtil.cache_lighting();
    local v300 = {
        Lighting = Lighting
    };

    for _, child in luffyRanked.VFX.Lighting:GetChildren() do
        local v301 = u296:Clone(child);
        v301.Parent = Lighting;
        v300[child.Name] = v301;
    end;

    u296:Add(vfxUtil.restore_lighting);
    Lighting.GeographicLatitude = 201;
    Lighting.ExposureCompensation = 0.15;
    u296:Add(vfxUtil.restore_lighting_properties);
    local v302 = u296:Construct(MoonPropertyAnimator);
    v302:LoadAndConvertSave(luffyRanked.Moon, v300);
    v302:SetOriginalRoot(CFrame.new(0, 3, 0));
    v302:SetRoot(Root);
    v302:PlayAll();
    soundUtil:play(luffyRanked.SFX, soundUtil);
    vfxUtil.execute_compiled(luffyRanked.Compiled, u296, {
        v297,
        v298.CamPart,
        u291,
        FakeheadV,
        v295
    }, function(p303, p304) -- Line: 3708
        -- upvalues: TekrinnDialogue (ref), u291 (copy)
        TekrinnDialogue.Speak(u291, p303, p304);
    end);
    u296:Add(task.delay(p292 - 1, function() -- Line: 3713
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u296:Add(task.delay(p292, function() -- Line: 3717
        -- upvalues: mainreplication (ref), u296 (copy)
        mainreplication.fov(false, 70);
        u296:Destroy();
    end));
    u296:Add(task.delay(0, function() -- Line: 3723
        -- upvalues: Util (ref), luffyRanked (copy)
        Util.Preload(luffyRanked.IF);
    end));
    u296:Add(task.delay(3.3333333333333335, Util.Gif, luffyRanked.IF, 24));
end;

local function resolve_icon(p305, p306) -- Line: 3730
    if not p306 then
        return nil;
    end;

    local Models = p305.Models;

    if Models then
        Models = Models:FindFirstChild(p306);
    end;

    return Models and Models.Image or nil;
end;

local function resolve_companion(p307, p308, p309) -- Line: 3740
    -- upvalues: vfxUtil (copy)
    if p307 then
        p307 = p307[p308];
    end;

    if p307 then
        return p307, false;
    end;

    return vfxUtil.newRigForFriend(p309), true;
end;

local function weld_hand(p310, p311, p312, p313, p314) -- Line: 3748
    local v315 = p310:FindFirstChild(p312);
    local v316 = p311.Models and p311.Models[p313];

    if not (v315 and v316) then
        return nil;
    end;

    local u317 = v316:Clone();
    local v318 = u317:FindFirstChild(p313);

    if not v318 then
        u317:Destroy();

        return nil;
    end;

    u317.Parent = p310;
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Name = p313;
    Motor6D.Part0 = v315;
    Motor6D.Part1 = v318;
    Motor6D.C0 = p314;
    Motor6D.C1 = CFrame.new();
    Motor6D.Parent = v315;
    local Color2 = v315.Color;

    for _, descendant in u317:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Color = Color2;
        end;
    end;

    return function() -- Line: 3780
        -- upvalues: Motor6D (copy), u317 (copy)
        Motor6D:Destroy();
        u317:Destroy();
    end;
end;

function v1.mvp_vydiaMVP(p319, p320, p321, p322) -- Line: 3786
    -- upvalues: vfxUtil (copy), mainreplication (copy), trove (copy), animationUtil (copy), weld_hand (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), Players (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(p319);

    if not Root then
        return;
    end;

    mainreplication.sceneEnabled(true);
    local vydiaMVP = vfxUtil.getResources().mvpAssets.vydiaMVP;
    local u323 = trove.new();
    local u324;

    if p322 then
        u324 = p322[1];
    else
        u324 = p322;
    end;

    local v325;

    if u324 then
        v325 = false;
    else
        u324 = vfxUtil.newRigForFriend(Root);
        v325 = true;
    end;

    if p322 then
        p322 = p322[2];
    end;

    local v326;

    if p322 then
        v326 = false;
    else
        p322 = vfxUtil.newRigForFriend(Root);
        v326 = true;
    end;

    if v325 then
        u323:Add(u324);
    end;

    if v326 then
        u323:Add(p322);
    end;

    local u327 = animationUtil:loadAnimation(u324, vydiaMVP.Animations.Victims[1]);
    u327:Play(0);
    local u328 = animationUtil:loadAnimation(p322, vydiaMVP.Animations.Victims[2]);
    u328:Play(0);
    u323:Add(function() -- Line: 3811
        -- upvalues: u327 (copy), u328 (copy)
        u327:Stop();
        u328:Stop();
    end);
    local v329 = weld_hand(p319, vydiaMVP, "Left Arm", "LeftHand", CFrame.new(0, -0.75, 0, 0, -1, 0, 0, 0, -1, 1, 0, 0));
    local v330 = weld_hand(p319, vydiaMVP, "Right Arm", "RightHand", CFrame.new(0, -0.75, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0));

    if v329 then
        u323:Add(v329);
    end;

    if v330 then
        u323:Add(v330);
    end;

    local v331 = u323:Construct(vydiaMVP.VFX.Map);
    v331.Parent = workspace.Effects;
    v331:PivotTo(Root.CFrame * CFrame.new(-1.574, 44.74, 2.513) * CFrame.Angles(0, -1.3962634015954636, -0.19198621771937624));
    u323:Add(v331);
    local _, v332 = mainreplication.cutsceneCamRigWithLetterBox(Root, vydiaMVP.Animations.Camera, vydiaMVP.FOV_Vydia, nil, "default", vydiaMVP.Models.VydlaMVPCam);
    u323:Add(v332);
    vfxUtil.cache_lighting();
    local v333 = {
        Lighting = Lighting,
        ["Screen Cover"] = u323:Add(vfxUtil.getMoonEffects())["Screen Cover"]
    };

    for _, child in vydiaMVP.VFX.Lighting:GetChildren() do
        local v334 = u323:Clone(child);
        v334.Parent = Lighting;
        v333[child.Name] = v334;
    end;

    u323:Add(vfxUtil.restore_lighting);
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.GeographicLatitude = 0;
    Lighting.ClockTime = 14.5;
    u323:Add(vfxUtil.restore_lighting_properties);
    local v335 = u323:Construct(MoonPropertyAnimator);
    v335:LoadAndConvertSave(vydiaMVP.Moon, v333);
    v335:SetOriginalRoot(CFrame.new(0, 3, 0));
    v335:SetRoot(Root);
    v335:PlayAll();
    soundUtil:play(vydiaMVP.SFX, soundUtil);
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p319);
    local u336 = PlayerFromCharacter and PlayerFromCharacter.DisplayName or p319.Name;
    vfxUtil.execute_compiled(vydiaMVP.Compiled, u323, function(p337, p338, p339, p340) -- Line: 3872
        -- upvalues: TekrinnDialogue (ref), u324 (copy), u336 (copy), vydiaMVP (copy)
        local Speak = TekrinnDialogue.Speak;
        local v341 = p340 and u324.Name or u336;
        local v342 = vydiaMVP;
        local v343;

        if p339 then
            local Models = v342.Models;

            if Models then
                Models = Models:FindFirstChild(p339);
            end;

            v343 = Models and Models.Image or nil;
        else
            v343 = nil;
        end;

        Speak(v341, p337, p338, v343);
    end);
    u323:Add(task.delay(p320 - 0.5, function() -- Line: 3876
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end));
    u323:Add(task.delay(p320, function() -- Line: 3880
        -- upvalues: mainreplication (ref), u323 (copy)
        mainreplication.fov(false, 70);
        u323:Destroy();
    end));
end;

function v1.mvp_giantTurkeyMVP(p344, p345) -- Line: 3886
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), MoonPropertyAnimator (copy), animationUtil (copy), UwUEffects (copy), Density (copy), Offset (copy), Color (copy), Decay (copy), Glare (copy), Haze (copy)
    local v346 = p344.HumanoidRootPart or p344.PrimaryPart;
    local _ = p344.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local giantTurkeyMVP = ReplicatedStorage.Resources.mvpAssets.giantTurkeyMVP;
    local u347 = giantTurkeyMVP.Turkey:Clone();
    u347:PivotTo(v346.CFrame);
    u347.HumanoidRootPart.Anchored = true;
    u347.Parent = workspace.Effects;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 0;
    BlurEffect.Parent = Lighting;
    local Highlight = Instance.new("Highlight");
    local Highlight2 = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight2.FillTransparency = 1;
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight2.FillColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight2.OutlineTransparency = 1;
    Highlight.Parent = p344;
    Highlight2.Parent = u347;
    local v348 = giantTurkeyMVP.VFX:Clone();
    v348:PivotTo(v346.CFrame);
    v348.Parent = p344;
    mainreplication.cutsceneCamRigWithLetterBox(v346, giantTurkeyMVP.Animations.Cam, giantTurkeyMVP.FOV, p344, CFrame.Angles(0, 3.141592653589793, 0), giantTurkeyMVP.CamRigWithLetterBox);
    soundUtil:play(giantTurkeyMVP.soundmvp, SoundService);
    local v349 = MoonPropertyAnimator.ConvertSave(giantTurkeyMVP.MVP, {
        Highlight = Highlight,
        Highlight2 = Highlight2,
        Atmosphere = Atmosphere,
        ColorCorrection = ColorCorrectionEffect,
        Blur = BlurEffect
    });
    local v350 = MoonPropertyAnimator.new();
    v350:LoadSave(giantTurkeyMVP.MVP, v349);
    v350:PlayAll();
    animationUtil:loadAnimation(u347, giantTurkeyMVP.Animations:FindFirstChild("Turkey")):Play();
    UwUEffects.createEffect({
        VFX = v348,
        Character = p344
    }, "giantTurkeyMVP");
    task.delay(p345 - 0.5, function() -- Line: 3936
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end);
    task.delay(p345, function() -- Line: 3940
        -- upvalues: mainreplication (ref), Atmosphere (copy), Density (ref), Offset (ref), Color (ref), Decay (ref), Glare (ref), Haze (ref), u347 (copy)
        mainreplication.fov(false, 70);
        Atmosphere.Density = Density;
        Atmosphere.Offset = Offset;
        Atmosphere.Color = Color;
        Atmosphere.Decay = Decay;
        Atmosphere.Glare = Glare;
        Atmosphere.Haze = Haze;
        pcall(game.Destroy, u347);
    end);
end;

function v1.mvp_crimsonSnakeMVP(p351, p352) -- Line: 3954
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), UwUEffects (copy), soundUtil (copy), SoundService (copy)
    local v353 = p351.HumanoidRootPart or p351.PrimaryPart;
    local _ = p351.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local crimsonSnakeMVP = ReplicatedStorage.Resources.mvpAssets.crimsonSnakeMVP;
    mainreplication.cutsceneCamRigWithLetterBox(v353, crimsonSnakeMVP.Animations.Cam, nil, p351, CFrame.new(0, -3, 0));
    local u354 = crimsonSnakeMVP.VFX:Clone();
    u354.Parent = p351;

    for _, child in u354:GetChildren() do
        if p351:FindFirstChild(child.Name) then
            local v355 = p351:FindFirstChild(child.Name);
            child.Weld.Part0 = v355;
        end;
    end;

    UwUEffects.createEffect({
        Effects = u354,
        Character = p351
    }, "crimsonSnakeMVP");
    soundUtil:play(crimsonSnakeMVP.soundmvp, SoundService);
    task.delay(p352 - 0.5, function() -- Line: 3976
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end);
    task.delay(p352, function() -- Line: 3980
        -- upvalues: u354 (copy), mainreplication (ref)
        pcall(game.Destroy, u354);
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_crushedDreams(p356, p357, p358, p359) -- Line: 3987
    -- upvalues: mainreplication (copy), vfxUtil (copy), ReplicatedStorage (copy), PlayerGui (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy)
    local v360 = p356.HumanoidRootPart or p356.PrimaryPart;
    local _ = p356.Torso;
    mainreplication.sceneEnabled(true);
    local crushedDreams = vfxUtil.getResources().mvpAssets.crushedDreams;
    local u361 = ReplicatedStorage.Resources.MoonAnimatorEffects:Clone();
    local Vignette = u361.Vignette;
    Vignette.Changed:Connect(function(p362) -- Line: 3998
        -- upvalues: Vignette (copy)
        if not table.find({ "ImageTransparency", "ImageColor3" }, p362) then
            return;
        end;

        for _, descendant in Vignette:GetDescendants() do
            if descendant:IsA("ImageLabel") then
                descendant[p362] = Vignette[p362];
            end;
        end;
    end);
    u361.Parent = PlayerGui;
    local u363 = mainreplication.kuronaCam(v360, nil, crushedDreams.FOV);
    local u364 = crushedDreams.VFX:Clone();
    u364.Parent = p356;
    u364:PivotTo(v360.CFrame);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Brightness = 0;
    ColorCorrectionEffect.Contrast = 0;
    ColorCorrectionEffect.Saturation = -1;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    local v365 = MoonPropertyAnimator.ConvertSave(crushedDreams.MVP, {
        Workspace = u364,
        ColorCorrection = ColorCorrectionEffect,
        ["Screen Cover"] = u361["Screen Cover"],
        Vignette = Vignette
    });
    local v366 = MoonPropertyAnimator.new();
    v366:LoadSave(crushedDreams.MVP, v365);
    v366:SetOriginalRoot(crushedDreams.AnimationRoot.Value);
    v366:SetRoot(v360);
    v366:PlayAll();
    soundUtil:play(crushedDreams.soundmvp, SoundService);
    local styles = require(ReplicatedStorage.wiki).styles;
    task.spawn(TekrinnDialogue.Speak, p356.Name, {
        {
            Text = "I crushed..",
            TypeSpeed = 0.03,
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 1.5,
                Lifetime = 1.5
            }
        }
    }, 4, styles.isagi.icon, styles.isagi.color);
    task.delay(3.05, TekrinnDialogue.Speak, p356.Name, {
        {
            Text = ".. the ",
            TypeSpeed = 0.03,
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 1.5,
                Lifetime = 1.5
            }
        },
        {
            Text = "dreams",
            Bold = true,
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 5,
                Lifetime = 1.5
            }
        },
        {
            Text = " of these people.",
            TypeSpeed = 0.03,
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 1.5,
                Lifetime = 1.5
            }
        }
    }, 6, styles.isagi.icon, styles.isagi.color);
    task.delay(6.3, TekrinnDialogue.Speak, p356.Name, {
        {
            Text = "So this is what it means to ",
            TypeSpeed = 0.03,
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 1.5,
                Lifetime = 1.5
            }
        },
        {
            Text = "win",
            Bold = true,
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 3,
                Lifetime = 1.5
            }
        },
        {
            Text = ".",
            TypeSpeed = 0.03,
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 1.5,
                Lifetime = 1.5
            }
        }
    }, 3.7, styles.isagi.icon, styles.isagi.color);
    task.delay(12.15, TekrinnDialogue.Speak, p356.Name, {
        {
            Text = "It feels so good!",
            Bold = true,
            Italic = true,
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 5,
                Lifetime = 1.5
            }
        }
    }, 1.949, styles.isagi.icon, styles.isagi.color);
    task.delay(13.717, soundUtil.play, soundUtil, crushedDreams.score, SoundService);
    task.delay(p357 - 0.5, mainreplication.blackscene, 0.5);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.delay(p357, function() -- Line: 4184
        -- upvalues: ScreenDimmer (copy), u361 (copy), u363 (copy), ColorCorrectionEffect (copy), u364 (copy), mainreplication (ref)
        ScreenDimmer:Destroy();
        pcall(game.Destroy, u361);
        pcall(game.Destroy, u363);
        pcall(game.Destroy, ColorCorrectionEffect);
        pcall(game.Destroy, u364);
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_finestClown(p367, p368, p369, p370) -- Line: 4196
    -- upvalues: trove (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy), Lighting (copy), ReplicatedStorage (copy), PlayerGui (copy), mainreplication (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy), VfxHandler (copy)
    local v371 = p367:FindFirstChild("HumanoidRootPart") or p367.PrimaryPart;
    p367:FindFirstChild("Torso");
    local u372 = trove.new();
    u372:Add(vfxUtil.getScreenDimmer());
    local finestClown = vfxUtil.getResources().mvpAssets.finestClown;
    local v373 = p370[1];
    soundUtil:play(finestClown.soundmvp, SoundService);
    local Atmosphere = Instance.new("Atmosphere");
    Atmosphere.Parent = Lighting;
    u372:Add(Atmosphere);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Parent = Lighting;
    u372:Add(BlurEffect);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    u372:Add(ColorCorrectionEffect);
    local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect");
    DepthOfFieldEffect.Parent = Lighting;
    u372:Add(DepthOfFieldEffect);
    local v374 = ReplicatedStorage.Resources.MoonAnimatorEffects:Clone();
    local Vignette = v374.Vignette;
    Vignette.Changed:Connect(function(p375) -- Line: 4225
        -- upvalues: Vignette (copy)
        if not table.find({ "ImageTransparency", "ImageColor3" }, p375) then
            return;
        end;

        for _, descendant in Vignette:GetDescendants() do
            if descendant:IsA("ImageLabel") then
                descendant[p375] = Vignette[p375];
            end;
        end;
    end);
    v374.Parent = PlayerGui;
    u372:Add(v374);
    local u376 = finestClown.VFX:Clone();
    u376:PivotTo(v371.CFrame);
    local u377 = nil;

    for _, v in u376.Sweat1:QueryDescendants("Weld") do
        local Parent = v.Parent;

        if p367:FindFirstChild(Parent.Name) then
            v.Part0 = p367[Parent.Name];
        end;
    end;

    for _, v in u376.Sweat2:QueryDescendants("Weld") do
        local Parent = v.Parent;

        if v373:FindFirstChild(Parent.Name) then
            v.Part0 = v373[Parent.Name];
        end;
    end;

    u376.Eyes.Weld.Part0 = p367:FindFirstChild("Head") or p367.PrimaryPart;
    u376.breath.Weld.Part0 = v373:FindFirstChild("Head");
    u376.Parent = workspace.Effects;
    u372:Add(u376);
    u372:Add((mainreplication.cutsceneCamRigWithLetterBox(v371, finestClown.Animations.Camera, finestClown.FOV, p367, CFrame.new(0, -3, 0), finestClown.Camera, "CamPart")));
    u376.Domain.Transparency = 1;
    local v378 = MoonPropertyAnimator.new();
    v378:LoadSave(finestClown.MVP, MoonPropertyAnimator.ConvertSave(finestClown.MVP, {
        Vignette = Vignette,
        ["Screen Cover"] = v374["Screen Cover"],
        Blur = BlurEffect,
        ColorCorrection = ColorCorrectionEffect,
        Atmosphere = Atmosphere,
        DepthOfField = DepthOfFieldEffect
    }));
    v378:PlayAll();
    vfxUtil.enableEffects(u376.Background, false, "Beam");
    vfxUtil.enableEffects(u376.AtmosphericBeams, true, "Beam");
    u372:Add(task.delay(0.18, shared.vfx.emit, u376.Grass));
    u372:Add(task.delay(1.15, TekrinnDialogue.Speak, p367, {
        {
            Text = "Thats right...",
            Bold = true,
            Italic = true,
            TypeSpeed = 0.01,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            Shake = {
                Enabled = false,
                Intensity = 1,
                Lifetime = 1.7
            }
        }
    }, 2));
    u372:Add(task.delay(1.25, shared.vfx.emit, u376.Grass2));
    u372:Add(task.delay(2.52, function() -- Line: 4303
        -- upvalues: u376 (copy), u377 (ref), VfxHandler (ref), vfxUtil (ref)
        u376.Domain.Transparency = 0;
        u377 = VfxHandler.HideMap("MapOnly");
        vfxUtil.enableEffects(u376.TragicBackground, true, "ParticleEmitter");
        vfxUtil.enableEffects(u376.First, true, "SpotLight,SurfaceLight");
        vfxUtil.enableEffects(u376.AtmosphericBeams, false, "Beam");
    end));
    u372:Add(task.delay(3.5, TekrinnDialogue.Speak, p367, {
        {
            Text = "That was a nice pass.",
            Bold = true,
            Italic = true,
            TypeSpeed = 0.01,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            Shake = {
                Enabled = false,
                Intensity = 1,
                Lifetime = 1.7
            }
        }
    }, 2));
    u372:Add(task.delay(5.15, function() -- Line: 4330
        -- upvalues: u377 (ref), VfxHandler (ref), u376 (copy), vfxUtil (ref)
        if u377 then
            VfxHandler.ShowMap(u377);
        end;

        u376.Domain.Transparency = 1;
        vfxUtil.enableEffects(u376.TragicBackground, false, "ParticleEmitter");
        vfxUtil.enableEffects(u376.AtmosphericBeams2, true, "Beam");
    end));
    u372:Add(task.delay(5.98, shared.vfx.emit, u376.breath));
    u372:Add(task.delay(6.75, function() -- Line: 4341
        -- upvalues: vfxUtil (ref), u376 (copy)
        vfxUtil.enableEffects(u376.Last, true, "ParticleEmitter,SpotLight");
        vfxUtil.enableEffects(u376.Eyes, true, "ParticleEmitter,SpotLight");
        vfxUtil.enableEffects(u376.SunBack, true, "ParticleEmitter,SpotLight");
        vfxUtil.enableEffects(u376.First, false, "ParticleEmitter,SpotLight");
        vfxUtil.enableEffects(u376.AtmosphericBeams2, false, "Beam");
    end));
    u372:Add(task.delay(6.92, TekrinnDialogue.Speak, p367, {
        {
            Text = "You have to move, so I can score...",
            Bold = true,
            Italic = true,
            TypeSpeed = 0.05,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            Shake = {
                Enabled = true,
                Intensity = 1,
                Lifetime = 1.7
            }
        }
    }, 2));
    u372:Add(task.delay(9.67, function() -- Line: 4373
        -- upvalues: u376 (copy), vfxUtil (ref)
        for _, v in u376.SunBack:QueryDescendants("ParticleEmitter") do
            v.Enabled = false;
            v:Clear();
        end;

        vfxUtil.enableEffects(u376.LastLast, false, "PointLight");
        vfxUtil.enableEffects(u376.Background, true, "Beam");
        vfxUtil.enableEffects(u376.LastLast, true, "SurfaceLight");
    end));
    u372:Add(task.delay(10, TekrinnDialogue.Speak, p367, {
        {
            Text = "Donkey.",
            Bold = true,
            Italic = true,
            TypeSpeed = 0.05,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 0)) }),
            Shake = {
                Enabled = true,
                Intensity = 1,
                Lifetime = 1.7
            }
        }
    }, 2));
    u372:Add(task.delay(p368 - 0.5, mainreplication.blackscene, 0.5));
    u372:Add(task.delay(p368, function() -- Line: 4402
        -- upvalues: u377 (ref), VfxHandler (ref), mainreplication (ref), u372 (copy)
        if u377 then
            VfxHandler.ShowMap(u377);
        end;

        mainreplication.sceneEnabled(false);
        u372:Destroy();
    end));
    mainreplication.sceneEnabled(true);
end;

function v1.mvp_DivineTechniqueMVP(p379, p380) -- Line: 4413
    -- upvalues: trove (copy), vfxUtil (copy), Lighting (copy), mainreplication (copy), TweenService (copy), TekrinnDialogue (copy), soundUtil (copy), SoundService (copy)
    local v381 = p379:FindFirstChild("HumanoidRootPart") or p379.PrimaryPart;
    p379:FindFirstChild("Torso");
    local u382 = trove.new();
    local DivineTechniqueMVP = vfxUtil.getResources().mvpAssets.DivineTechniqueMVP;
    u382:Add(vfxUtil.getScreenDimmer());
    local v383 = u382:Construct(Instance, "ColorCorrectionEffect");
    v383.Brightness = -1;
    v383.Parent = Lighting;
    local v384 = u382:Construct(DivineTechniqueMVP.VFX);

    for _, child in v384:GetChildren() do
        if child:FindFirstChild("Weld") and not child.Weld.Part0 then
            child.Weld.Part0 = p379:FindFirstChild(child.Name) or v381;
        end;
    end;

    v384:PivotTo(v381.CFrame);
    v384.Parent = workspace.Effects;
    local u385, v386 = mainreplication.cutsceneCamRigWithLetterBox(v381, DivineTechniqueMVP.Animations.Camera, DivineTechniqueMVP.FOV, p379, CFrame.new(0, -3, 0), DivineTechniqueMVP.Camera);

    if v386 then
        u382:Add(v386);
    end;

    TweenService:Create(v383, TweenInfo.new(0.217, Enum.EasingStyle.Linear), {
        Brightness = 0
    }):Play();
    u382:Add(task.delay(0.517, mainreplication.bright, 1, 0.2));
    u382:Add(task.delay(0.533, shared.vfx.emit, u385.camera.ScreenFX));
    u382:Add(task.delay(1.083, mainreplication.bright, 1, 0.2));
    u382:Add(task.delay(1.1, shared.vfx.emit, u385.camera.ScreenFX));
    u382:Add(task.delay(1.582, mainreplication.bright, 1, 0.2));
    u382:Add(task.delay(1.583, shared.vfx.emit, u385.camera.ScreenFX));
    u382:Add(task.delay(1.983, vfxUtil.enableEffects, v384.Head.Glares, true, "ParticleEmitter"));
    u382:Add(task.delay(2.15, shared.vfx.emit, v384.Head.Eyes));
    u382:Add(task.delay(4.533, vfxUtil.enableEffects, u385.camera.Attachment, true, "ParticleEmitter"));
    u382:Add(task.delay(5.332, shared.vfx.emit, u385.camera.ScreenFX));
    u382:Add(task.delay(5.333, function() -- Line: 4453
        -- upvalues: vfxUtil (ref), u385 (copy)
        vfxUtil.enableEffects(u385.camera, true, "#CameraLines");
        shared.vfx.emit(u385.camera.Attachment);
    end));
    u382:Add(task.delay(5.533, TekrinnDialogue.Speak, "", {
        {
            Text = "What\'s wrong? ",
            TypeSpeed = 0.03,
            Pause = 1.0139999999999993,
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 1,
                Lifetime = 1
            }
        },
        {
            Text = "Is that all you\'ve got?",
            TypeSpeed = 0.03,
            Color = ColorSequence.new(Color3.new(1, 1, 1)),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 1,
                Lifetime = 1
            }
        }
    }, 6));
    u382:Add(task.delay(11.667, vfxUtil.enableEffects, u385.camera.Attachment, false, "ParticleEmitter"));
    u382:Add(task.delay(p380 - 0.5, mainreplication.blackscene, 0.5));
    u382:Add(task.delay(p380, function() -- Line: 4493
        -- upvalues: mainreplication (ref), u382 (copy)
        mainreplication.sceneEnabled(false);
        u382:Destroy();
    end));
    soundUtil:play(DivineTechniqueMVP[`soundmvp{p379:GetAttribute("SillySong") and "RNP" or ""}`], SoundService);
    mainreplication.sceneEnabled(true);
end;

function v1.mvp_heianPeriod(u387, p388, p389, p390) -- Line: 4503
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), PlayerGui (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), TweenService (copy), vfxUtil (copy)
    local v391 = u387.HumanoidRootPart or u387.PrimaryPart;
    local _ = u387.Torso;
    mainreplication.sceneEnabled(true);
    local heianPeriod = ReplicatedStorage.Resources.mvpAssets.heianPeriod;
    local Assets = heianPeriod.Assets;
    local u392 = ReplicatedStorage.Resources.MoonAnimatorEffects:Clone();
    local Vignette = u392.Vignette;
    Vignette.Changed:Connect(function(p393) -- Line: 4514
        -- upvalues: Vignette (copy)
        if not table.find({ "ImageTransparency", "ImageColor3" }, p393) then
            return;
        end;

        for _, descendant in Vignette:GetDescendants() do
            if descendant:IsA("ImageLabel") then
                descendant[p393] = Vignette[p393];
            end;
        end;
    end);
    u392.Parent = PlayerGui;
    local u394 = mainreplication.kuronaCam(v391, heianPeriod.Cam, heianPeriod.FOV);
    local u395 = heianPeriod.VFX:Clone();
    u395.Parent = u387;
    u395:PivotTo(v391.CFrame);
    local u396 = Assets.LeftArm2:Clone();
    u396.Weld.Part0 = v391;
    u396.Parent = u387;
    local u397 = Assets.RightArm2:Clone();
    u397.Weld.Part0 = v391;
    u397.Parent = u387;
    local u398 = nil;
    local v399 = MoonPropertyAnimator.new();
    v399:LoadSave(heianPeriod.MVP, MoonPropertyAnimator.ConvertSave(heianPeriod.MVP, {
        Workspace = u395,
        ["Screen Cover"] = u392["Screen Cover"],
        Vignette = Vignette
    }));
    v399:PlayAll();
    soundUtil:play(heianPeriod.soundmvp, SoundService);
    task.spawn(function() -- Line: 4550
        -- upvalues: u396 (copy), u397 (copy), u398 (ref), u395 (copy), u387 (copy)
        u396.Transparency = 1;
        u397.Transparency = 1;
        u398 = Instance.new("ColorCorrectionEffect", game.Lighting);
        u398.Brightness = -0.035;
        u398.Contrast = 0.15;
        u398.Saturation = -0.1;
        u398.TintColor = Color3.fromRGB(255, 240, 240);
        u398.Name = "CutsceneColorCorrection";

        for _, child in ipairs(u395.SukunaAura:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
                child:Clear();
                child.Brightness = 5;
                child.LightEmission = 1;
            end;
        end;

        u396.Color = u387["Left Arm"].Color;
        u397.Color = u387["Right Arm"].Color;
    end);
    task.delay(2.733, function() -- Line: 4574
        -- upvalues: u395 (copy)
        for _, child in pairs(u395.SukunaAura:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
            end;
        end;
    end);
    task.delay(6.25, function() -- Line: 4582
        -- upvalues: u396 (copy), u397 (copy)
        u396.Transparency = 0;
        u397.Transparency = 0;
    end);
    task.delay(6.3, TekrinnDialogue.Speak, u387.Name, {
        {
            Text = "I shall go back...",
            TypeSpeed = 0.03,
            Color = ColorSequence.new(Color3.new(0.223529, 0, 0), Color3.new(1, 0, 0)),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 2,
                Lifetime = 1.5
            }
        }
    }, 4);
    task.delay(8, TekrinnDialogue.Speak, u387.Name, {
        {
            Text = "TO THE HEIAN ERA!",
            Bold = true,
            TypeSpeed = 0.03,
            Color = ColorSequence.new(Color3.new(0.223529, 0, 0), Color3.new(1, 0, 0)),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 5,
                Lifetime = 1.5
            }
        }
    }, 1.7);
    task.delay(9.267, function() -- Line: 4623
        -- upvalues: u398 (ref), TweenService (ref)
        u398.Brightness = -0.035;
        u398.Contrast = 0.45;
        u398.Saturation = -1;
        u398.TintColor = Color3.fromRGB(163, 3, 3);
        TweenService:Create(u398, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = -0.035,
            Contrast = 0.15,
            Saturation = -0.1,
            TintColor = Color3.fromRGB(255, 240, 240)
        }):Play();
    end);
    task.delay(9.917, function() -- Line: 4641
        -- upvalues: u395 (copy), TweenService (ref)
        for _, child in pairs(u395.SukunaAura:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                TweenService:Create(child, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    LightEmission = 0,
                    Brightness = 0
                }):Play();
            end;
        end;
    end);
    task.delay(p388 - 0.5, mainreplication.blackscene, 0.5);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.delay(p388, function() -- Line: 4660
        -- upvalues: ScreenDimmer (copy), u392 (copy), u394 (copy), u398 (ref), u395 (copy), mainreplication (ref)
        ScreenDimmer:Destroy();
        pcall(game.Destroy, u392);
        pcall(game.Destroy, u394);
        pcall(game.Destroy, u398);
        pcall(game.Destroy, u395);
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_yukimiyaMVP(p400, p401) -- Line: 4671
    -- upvalues: ReplicatedStorage (copy), Lighting (copy), vfxUtil (copy), Util (copy), mainreplication (copy), ReplicatedStorage2 (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), UwUEffects (copy)
    local yukimiyaMVP = ReplicatedStorage.Resources.mvpAssets.yukimiyaMVP;
    local v402 = p400.HumanoidRootPart or p400.PrimaryPart;
    local _ = p400.Torso;
    local _ = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    v402.CFrame = v402.CFrame * (CFrame.new(-16, -9, 38) * CFrame.Angles(0, -1.7453292519943295, 0));
    v402.Anchored = true;
    Util.Preload(yukimiyaMVP.ImpactFrames);
    mainreplication.sceneEnabled(true);
    local v403 = yukimiyaMVP.VFX:Clone();
    v403:PivotTo(v402.CFrame);
    v403.Parent = p400;
    local v404 = mainreplication.cutsceneCamRigWithLetterBox(v402, yukimiyaMVP.Animations.CameraRig, yukimiyaMVP.FOV, nil, nil, yukimiyaMVP.Cam, "Part");
    local u405 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
    u405.Brightness = -1;
    u405.Contrast = 0.2;
    u405.Saturation = -0.1;
    u405.Parent = Lighting;
    local u406 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u406.FarIntensity = 0.192;
    u406.FocusDistance = 0;
    u406.InFocusRadius = 15.15;
    u406.NearIntensity = 0.75;
    u406.Parent = Lighting;
    local u407 = ReplicatedStorage.Resources.Bloom:Clone();
    u407.Intensity = 1;
    u407.Size = 18.666666666666668;
    u407.Threshold = 0.8;
    u407.Parent = Lighting;
    local v408 = MoonPropertyAnimator.ConvertSave(yukimiyaMVP.MVP, {
        Cam = v404,
        Workspace = v403,
        DepthOfField = u406,
        ColorCorrection = u405
    });
    soundUtil:play(yukimiyaMVP.soundmvp, SoundService);
    local u409 = MoonPropertyAnimator.new();
    u409:LoadSave(yukimiyaMVP.MVP, v408);
    u409:PlayAll();
    UwUEffects.createEffect({
        Character = p400,
        Camera = v404,
        Effects = v403
    }, "YukimiyaMVP");
    task.delay(p401 - 0.5, function() -- Line: 4726
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end);
    task.delay(p401, function() -- Line: 4730
        -- upvalues: ScreenDimmer (copy), u406 (copy), u405 (copy), u407 (copy), u409 (copy), mainreplication (ref)
        ScreenDimmer:Destroy();
        pcall(game.Destroy, u406);
        pcall(game.Destroy, u405);
        pcall(game.Destroy, u407);
        u409:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_EscanorMVP(p410, p411) -- Line: 4745
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), PlayerGui (copy), ReplicatedStorage2 (copy), UwUEffects (copy), soundUtil (copy), SoundService (copy), vfxUtil (copy), Density (copy), Offset (copy), Color (copy), Decay (copy), Glare (copy), Haze (copy)
    local v412 = p410.HumanoidRootPart or p410.PrimaryPart;
    local _ = p410.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local EscanorMVP = ReplicatedStorage.Resources.mvpAssets.EscanorMVP;
    local v413 = EscanorMVP.EscanorVFX:Clone();
    v413:PivotTo(v412.CFrame);
    v413.Parent = p410;
    Atmosphere.Density = 0.3;
    Atmosphere.Offset = 0.25;
    Atmosphere.Color = Color3.fromRGB(199, 199, 199);
    Atmosphere.Decay = Color3.fromRGB(106, 112, 125);
    Atmosphere.Glare = 0;
    Atmosphere.Haze = 0;
    local u414 = EscanorMVP.Parent.HitMVP.Vignette:Clone();
    u414.Parent = PlayerGui;
    local u415 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u415.Parent = Lighting;
    u415.FarIntensity = 0.1;
    u415.FocusDistance = 0.3;
    u415.InFocusRadius = 25;
    u415.NearIntensity = 0;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    local v416 = mainreplication.cutsceneCamRigWithLetterBox(v412, EscanorMVP.Animations.Camera, EscanorMVP.FOV, p410, CFrame.new(0, -3, 0), EscanorMVP.CameraRig);
    UwUEffects.createEffect({
        Character = p410,
        Vignette = u414.Vignette,
        camera = v416,
        VFX = v413,
        DepthOfField = u415,
        ColorCorrection = ColorCorrectionEffect
    }, "EscanorMVP");
    soundUtil:play(EscanorMVP.soundmvp, SoundService);
    task.delay(p411 - 0.5, function() -- Line: 4786
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.delay(p411, function() -- Line: 4792
        -- upvalues: ScreenDimmer (copy), Atmosphere (copy), Density (ref), Offset (ref), Color (ref), Decay (ref), Glare (ref), Haze (ref), u415 (copy), ColorCorrectionEffect (copy), u414 (copy), mainreplication (ref)
        ScreenDimmer:Destroy();
        Atmosphere.Density = Density;
        Atmosphere.Offset = Offset;
        Atmosphere.Color = Color;
        Atmosphere.Decay = Decay;
        Atmosphere.Glare = Glare;
        Atmosphere.Haze = Haze;
        pcall(game.Destroy, u415);
        pcall(game.Destroy, ColorCorrectionEffect);
        pcall(game.Destroy, u414);
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_pixelatedMVP(p417, p418) -- Line: 4810
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), ReplicatedStorage2 (copy), Lighting (copy), soundUtil (copy), SoundService (copy)
    local v419 = p417.HumanoidRootPart or p417.PrimaryPart;
    mainreplication.sceneEnabled(true);
    local PixelatedMvp = ReplicatedStorage.Resources.mvpAssets.PixelatedMvp;
    local u420 = ReplicatedStorage2.Resources.ColorCorrection:Clone();
    u420.TintColor = Color3.new(1, 0, 0);
    u420.Brightness = 5;
    u420.Contrast = 100;
    u420.Parent = Lighting;
    local v421 = mainreplication.cutsceneCamRigWithLetterBox(v419, PixelatedMvp.Animations.CameraRig, nil, p417);
    v421.letterboxbot.Transparency = 0;
    v421.letterboxtop.Transparency = 0;
    soundUtil:play(PixelatedMvp.soundmvp, SoundService);
    task.delay(p418, function() -- Line: 4829
        -- upvalues: mainreplication (ref), u420 (copy)
        mainreplication.blackscene(0.5);
        pcall(game.Destroy, u420);
    end);
end;

function v1.mvp_testerMVP(u422, p423, p424, u425) -- Line: 4835
    -- upvalues: vfxUtil (copy), mainreplication (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), Players (copy), Util (copy), TekrinnDialogue (copy)
    local TesterMVP = vfxUtil.getResources().mvpAssets.TesterMVP;
    local u426 = vfxUtil.mvp_cutscene_defaults(mainreplication, p423);
    local Root = vfxUtil.getRoot(u422);
    local _, v427 = mainreplication.cutsceneCamRigWithLetterBox(Root, TesterMVP.Camera, TesterMVP.FOV, nil, CFrame.new(0.016, -2.985, 0.001), TesterMVP.Cam, "CamPart");
    u426:Add(v427);
    local v428 = u426:Construct(TesterMVP.Aura);
    vfxUtil.setupAura(u422, v428, true, true);
    v428.Parent = workspace.Effects;
    vfxUtil.execute_compiled(TesterMVP.Compiled, u426, v428);
    local v429 = {
        Vignette = u426:Add(vfxUtil.getMoonEffects()).Vignette
    };
    vfxUtil.contain_lighting(u426, v429, TesterMVP.Lighting);
    local v430 = u426:Construct(MoonPropertyAnimator);
    v430:LoadAndConvertSave(TesterMVP.Moon, v429);
    v430:PlayAll();
    soundUtil:play((math.random(1, 10) == 1 or u422:GetAttribute("SillySong")) and TesterMVP.aura or TesterMVP.noaura, SoundService);

    if u425 then
        u425 = u425[1];
    end;

    local v431;

    if u425 then
        v431 = Players:GetPlayerFromCharacter(u425);
    else
        v431 = u425;
    end;

    local u432 = v431 and v431.DisplayName or (u425 and (u425.Name or "them") or "them");
    local Color3_fromRGB_ret = Color3.fromRGB(244, 56, 122);
    local Color3_fromRGB_ret2 = Color3.fromRGB(208, 48, 104);
    u426:Add(Util.frame_delay(26, function() -- Line: 4871
        -- upvalues: u426 (copy), TekrinnDialogue (ref), u425 (copy)
        u426:Add(TekrinnDialogue.Speak(u425, {
            {
                Text = "Yo,",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                HigherUp = false,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(206, 103, 0)) })
            },
            {
                Text = " you can\'t have forgotten about me.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                HigherUp = false,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 0.1,
                    Lifetime = 3
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, 5));
    end));
    u426:Add(Util.frame_delay(270, function() -- Line: 4910
        -- upvalues: u426 (copy), TekrinnDialogue (ref), u425 (copy)
        u426:Add(TekrinnDialogue.Speak(u425, {
            {
                Text = "I\'ll kick your butt!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                HigherUp = false,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 4
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, 5));
    end));
    u426:Add(Util.frame_delay(410, function() -- Line: 4932
        -- upvalues: u426 (copy), TekrinnDialogue (ref), u422 (copy), u432 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
        u426:Add(TekrinnDialogue.Speak(u422, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                HigherUp = false,
                Text = `Of course I remember you, {u432}.`,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 3
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_fromRGB_ret2), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, 5, "rbxassetid://123504602661683", Color3_fromRGB_ret));
    end));
    u426:Add(Util.frame_delay(690, function() -- Line: 4954
        -- upvalues: u426 (copy), TekrinnDialogue (ref), u422 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
        u426:Add(TekrinnDialogue.Speak(u422, {
            {
                Text = "I won\'t allow anyone acting against me to look down on me...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                HigherUp = false,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 3
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_fromRGB_ret2), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, 5, "rbxassetid://123504602661683", Color3_fromRGB_ret));
    end));
    u426:Add(Util.frame_delay(894, function() -- Line: 4976
        -- upvalues: u426 (copy), TekrinnDialogue (ref), u422 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
        u426:Add(TekrinnDialogue.Speak(u422, {
            {
                Text = "So lower your head.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                HigherUp = false,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 3
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3_fromRGB_ret2) })
            }
        }, 5, "rbxassetid://123504602661683", Color3_fromRGB_ret));
    end));
    u426:Add(Util.frame_delay(1025, function() -- Line: 4998
        -- upvalues: u426 (copy), TekrinnDialogue (ref), u425 (copy)
        u426:Add(TekrinnDialogue.Speak(u425, {
            {
                Text = "If wasn\'t brute force...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.045,
                HigherUp = false,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 0.1,
                    Lifetime = 3
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            },
            {
                Text = " Then what was that?!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                HigherUp = false,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 4
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        }, 5));
    end));
end;

function v1.mvp_pear(p433, p434) -- Line: 5038
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), SoundService (copy)
    local Pear = vfxUtil.getResources().mvpAssets.Pear;
    local Root = vfxUtil.getRoot(p433);
    mainreplication.kuronaCam(Root, Pear.Cam, Pear.FOV);
    mainreplication.sceneEnabled(true);
    local u435 = Pear.Attachment:Clone();
    u435.Parent = Root;
    u435.Teto:Emit(1);
    soundUtil:play(Pear.Teto, SoundService);
    task.delay(2, function() -- Line: 5053
        -- upvalues: soundUtil (ref), Pear (copy), SoundService (ref)
        soundUtil:play(Pear.ImAPear, SoundService);
    end);
    task.delay(2.845, function() -- Line: 5057
        -- upvalues: u435 (copy), soundUtil (ref), Pear (copy), SoundService (ref)
        u435.Teto.Enabled = false;
        u435.Pear.Enabled = true;
        u435.Pear:Emit(1);
        u435.Teto:Clear();
        soundUtil:play(Pear.Boom, SoundService);
    end);
    task.delay(4, function() -- Line: 5065
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end);

    for _, child in p433:GetChildren() do
        if child:IsA("BasePart") then
            child.Transparency = 1;

            if child.Name == "Head" and child:FindFirstChild("face") then
                child.face.Transparency = 1;
            end;
        elseif child:IsA("Accessory") and child:FindFirstChild("Handle") then
            child.Handle.Transparency = 1;
        end;
    end;
end;

function v1.mvp_explosion(p436, p437) -- Line: 5081
    -- upvalues: Lighting (copy), vfxUtil (copy), mainreplication (copy), ReplicatedStorage2 (copy), Util (copy), MeshEmitter (copy), soundUtil (copy), SoundService (copy), Density (copy), Brightness (copy), Color (copy)
    local v438 = p436.HumanoidRootPart or p436.PrimaryPart;
    local _ = p436.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    mainreplication.sceneEnabled(true);
    p436:FindFirstChildOfClass("Shirt");
    local u439 = {};

    for _, descendant in ipairs(workspace.map.map:GetDescendants()) do
        if descendant:IsA("BasePart") then
            u439[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;

    Lighting.Brightness = 4;
    Atmosphere.Density = 0.343;
    local u440 = ReplicatedStorage2.Resources.Ball:Clone();
    u440.ball.Part0 = v438;
    u440.Parent = p436;
    local v441 = ReplicatedStorage2.Resources.mvpAssets.Explosion.BallTrail:Clone();
    v441.Weld.Part0 = u440;
    v441.Parent = u440;
    local u442 = Util.Preload(ReplicatedStorage2.Resources.mvpAssets.Explosion.ImpactFrame);
    local u443 = MeshEmitter.StartMeshEmitter(v438, ReplicatedStorage2.Resources.mvpAssets.Explosion.ExplosionEff);
    soundUtil:play(ReplicatedStorage2.Resources.mvpAssets.Explosion["barou mvp_1"], SoundService);
    mainreplication.cutsceneBlender(v438, ReplicatedStorage2.Resources.mvpAssets.Explosion.camAnimation, ReplicatedStorage2.Resources.mvpAssets.Explosion.FOV);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    task.delay(0.6833333333333333, function() -- Line: 5140
        -- upvalues: u443 (copy)
        for _, descendant in ipairs(u443.barou.vfx1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.767, function() -- Line: 5148
        -- upvalues: Util (ref), ReplicatedStorage2 (ref)
        Util.Gif(ReplicatedStorage2.Resources.mvpAssets.Explosion.ImpactFrame, 30);
    end);
    task.delay(0.8666666666666667, function() -- Line: 5151
        -- upvalues: u443 (copy)
        for _, descendant in ipairs(u443.barou.vfx2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(1.35, function() -- Line: 5156
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(4.333, function() -- Line: 5161
        -- upvalues: ScreenDimmer (copy), u442 (copy), mainreplication (ref), ColorCorrectionEffect (copy), u440 (copy), Atmosphere (copy), Density (ref), u439 (copy), u443 (copy), Lighting (ref), Brightness (ref), Color (ref)
        ScreenDimmer:Destroy();
        u442:Destroy();
        mainreplication.blackscene(1);
        task.wait(1);
        ColorCorrectionEffect:Destroy();
        u440:Destroy();
        Atmosphere.Density = Density;

        for i, v in u439 do
            i.Transparency = v;
        end;

        table.clear(u439);
        u443:Destroy();
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_isagiTriumph(p444, p445) -- Line: 5195
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage2 (copy), TweenService (copy), soundUtil (copy), SoundService (copy), RunService (copy), vfxUtil (copy), Brightness (copy), Density (copy), Color (copy)
    local v446 = p444.HumanoidRootPart or p444.PrimaryPart;
    local _ = p444.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local u447 = ReplicatedStorage2.Resources.mvpAssets.IsagiTriumph.isagivfx:Clone();
    u447:PivotTo(v446.CFrame);
    u447.Parent = p444;
    local u448 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u448.Parent = Lighting;
    u448.FarIntensity = 0;
    TweenService:Create(u448, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage2.Resources.mvpAssets.IsagiTriumph.soundmvp, SoundService);
    mainreplication.cutscene(v446, nil, 14, ReplicatedStorage2.Resources.mvpAssets.IsagiTriumph.FOV);
    local u449 = ReplicatedStorage2.Resources.mvpAssets.IsagiTriumph.Cam:Clone();
    u449.Parent = p444;
    local u450 = nil;
    u450 = RunService.PreRender:connect(function() -- Line: 5218
        -- upvalues: u449 (copy), u450 (ref)
        if u449:IsDescendantOf(game) then
            u449.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u450:Disconnect();
    end);
    task.spawn(function() -- Line: 5224
        -- upvalues: u449 (copy), u447 (copy)
        for _, descendant in pairs(u449:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u447.rootpos.beamlines:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u447.rootpos.SpeedlinePart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.333333333333333, function() -- Line: 5249
        -- upvalues: u447 (copy)
        for _, descendant in pairs(u447.rootpos.sweat:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5.133333333333334, function() -- Line: 5258
        -- upvalues: u449 (copy), u447 (copy)
        for _, descendant in pairs(u449:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u447.rootpos.beamlines:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.6, function() -- Line: 5275
        -- upvalues: u449 (copy), u447 (copy)
        for _, descendant in pairs(u449:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u447.rootpos.SpeedlinePart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(13, function() -- Line: 5292
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.delay(14, function() -- Line: 5298
        -- upvalues: ScreenDimmer (copy), u448 (copy), u447 (copy), u449 (copy), Lighting (ref), Brightness (ref), Atmosphere (copy), Density (ref), Color (ref), mainreplication (ref)
        ScreenDimmer:Destroy();
        u448:Destroy();
        u447:Destroy();
        u449:Destroy();
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_FieldKing(u451, p452) -- Line: 5312
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage2 (copy), TweenService (copy), soundUtil (copy), SoundService (copy), MeshEmitter (copy), Util (copy), workspace_CurrentCamera (copy), RunService (copy), Brightness (copy), Density (copy), Color (copy), TekrinnDialogue (copy)
    local v453 = u451.HumanoidRootPart or u451.PrimaryPart;
    local _ = u451.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local u454 = ReplicatedStorage2.Resources.mvpAssets.FieldKing.baroufield:Clone();
    u454:PivotTo(v453.CFrame);
    u454.Parent = u451;
    local u455 = ReplicatedStorage2.Resources.DepthOfField:Clone();
    u455.Parent = Lighting;
    u455.FarIntensity = 0;
    TweenService:Create(u455, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage2.Resources.mvpAssets.FieldKing.soundmvp, SoundService);
    mainreplication.cutscene(v453, nil, 9, ReplicatedStorage2.Resources.mvpAssets.FieldKing.FOV);
    local u456 = ReplicatedStorage2.Resources.mvpAssets.FieldKing.Cam:Clone();
    u456.Parent = u451;
    local v457 = { MeshEmitter.StartMeshEmitter(v453, ReplicatedStorage2.Resources.mvpAssets.FieldKing.baroucc, nil).flashz };

    for _, v in ipairs(v457) do
        if not Util.isepilepsysafe() then
            v.Parent = workspace_CurrentCamera;
        end;

        task.delay(15, function() -- Line: 5342
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    local u458 = nil;
    u458 = RunService.PreRender:connect(function() -- Line: 5346
        -- upvalues: u456 (copy), u458 (ref)
        if u456:IsDescendantOf(game) then
            u456.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u458:Disconnect();
    end);
    task.delay(3.216666666666667, function() -- Line: 5350
        -- upvalues: u456 (copy)
        for _, descendant in pairs(u456:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if descendant:GetAttribute("EmitDelay") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 5354
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end);
                end;

                if descendant:GetAttribute("EmitDuration") then
                    descendant.Enabled = true;
                    task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 5360
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;
    end);
    task.delay(7.016666666666667, function() -- Line: 5367
        -- upvalues: u454 (copy)
        for _, descendant in pairs(u454.root.LightningVFX:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if descendant:GetAttribute("EmitDelay") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 5373
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end);
                end;

                if descendant:GetAttribute("EmitDuration") then
                    descendant.Enabled = true;
                    task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 5379
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;

        for _, descendant in pairs(u454.root.lightningz:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if descendant:GetAttribute("EmitDelay") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 5388
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end);
                end;

                if descendant:GetAttribute("EmitDuration") then
                    descendant.Enabled = true;
                    task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 5394
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;
    end);
    task.delay(8.25, function() -- Line: 5401
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end);
    task.delay(9, function() -- Line: 5404
        -- upvalues: u455 (copy), u454 (copy), u456 (copy), Lighting (ref), Brightness (ref), Atmosphere (copy), Density (ref), Color (ref), mainreplication (ref)
        u455:Destroy();
        u454:Destroy();
        u456:Destroy();
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        mainreplication.fov(false, 70);
    end);
    task.delay(0.24, function() -- Line: 5416
        -- upvalues: TekrinnDialogue (ref), u451 (copy)
        TekrinnDialogue.Speak(u451.Name, {
            {
                Text = "Now hear me, suckers, and ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "remember",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            },
            {
                Text = " my words.",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 6);
    end);
    task.delay(4.5, function() -- Line: 5461
        -- upvalues: TekrinnDialogue (ref), u451 (copy)
        TekrinnDialogue.Speak(u451.Name, {
            {
                Text = "On the field, I am the ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "king",
                Bold = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            },
            {
                Text = "..",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 3.5);
    end);
end;

function v1.mvp_SunKissed(u459, p460) -- Line: 5495
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy), Lighting (copy), Players (copy), mainreplication (copy), TweenService (copy), TekrinnDialogue (copy), Ambient (copy), Brightness (copy), ColorShift_Top (copy), EnvironmentDiffuseScale (copy), GlobalShadows (copy), OutdoorAmbient (copy), ShadowSoftness (copy), ClockTime2 (copy), GeographicLatitude (copy), ExposureCompensation (copy), FogColor (copy), FogEnd (copy), FogStart (copy)
    local SunKissed = ReplicatedStorage2.Resources.mvpAssets.SunKissed;
    local v461 = u459.HumanoidRootPart or u459.PrimaryPart;
    local _ = u459.Torso;
    local u462 = trove.new();
    u462:Add(vfxUtil.getScreenDimmer());
    local u463 = nil;
    task.delay(0.1, function() -- Line: 5504
        -- upvalues: u463 (ref), soundUtil (ref), SunKissed (copy), SoundService (ref)
        u463 = soundUtil:play(SunKissed:FindFirstChild("soundmvp"), SoundService);
    end);
    local u464 = {};
    local u465 = {};

    for _, child in Lighting:GetChildren() do
        if child:IsA("Atmosphere") or (child:IsA("SunRaysEffect") or (child:IsA("BloomEffect") or (child:IsA("ColorCorrectionEffect") or child:IsA("DepthOfFieldEffect")))) then
            table.insert(u464, child);
            child.Parent = nil;
        end;
    end;

    local CFrame_identity = CFrame.identity;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u459);

    if PlayerFromCharacter and (PlayerFromCharacter and (PlayerFromCharacter.Team and PlayerFromCharacter.Team.Name == "B")) then
        CFrame_identity = CFrame.fromEulerAnglesYXZ(0, 3.141592653589793, 0);
    end;

    v461.CFrame = workspace.map.PrimaryPart.CFrame * CFrame.new(0, 2, 0) * CFrame_identity;
    local v466 = SunKissed.Assets.Handle:Clone();
    v466.Parent = u459;
    v466.CFrame = v461.CFrame;
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Parent = u459:FindFirstChild("Torso");
    Motor6D.Part0 = Motor6D.Parent;
    Motor6D.Part1 = v466;
    Motor6D.C0 = CFrame.new(0.0394287109, -0.678276777, 1.02062988, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    local v467 = SunKissed.Assets.Flair:Clone();
    v467.Parent = u459;
    local Motor6D2 = Instance.new("Motor6D");
    Motor6D2.Parent = u459:FindFirstChild("HumanoidRootPart");
    Motor6D2.Part0 = Motor6D.Parent;
    Motor6D2.Part1 = v467.Par2t;
    Motor6D2.C0 = CFrame.new(
        -157.713989,
        47.7802429,
        -227.756348,
        0.665312767,
        0.315512866,
        0.676619411,
        -3.37335052e-7,
        0.906309783,
        -0.422618866,
        -0.746564806,
        0.281173676,
        0.602977693
    );
    table.insert(u465, v467);
    table.insert(u465, Motor6D2);
    table.insert(u465, v466);
    table.insert(u465, Motor6D);
    local u468, u469 = mainreplication.cutsceneCamRigWithLetterBox(v461, SunKissed.caniamtion, SunKissed.FOV, u459, CFrame.new(0, -3, 0), SunKissed.CamRigWithLetterBox);
    local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect");
    DepthOfFieldEffect.Enabled = true;
    DepthOfFieldEffect.FocusDistance = 5;
    DepthOfFieldEffect.InFocusRadius = 5;
    DepthOfFieldEffect.FarIntensity = 0.8;
    DepthOfFieldEffect.NearIntensity = 5;
    DepthOfFieldEffect.Parent = Lighting;
    local Atmosphere = Instance.new("Atmosphere");
    Atmosphere.Color = Color3.fromRGB(99, 167, 255);
    Atmosphere.Density = 0.35;
    Atmosphere.Offset = 0;
    Atmosphere.Decay = Color3.fromRGB(255, 255, 255);
    local SunRaysEffect = Instance.new("SunRaysEffect");
    SunRaysEffect.Enabled = false;
    SunRaysEffect.Intensity = 0.2;
    SunRaysEffect.Spread = 0.8;
    local BloomEffect = Instance.new("BloomEffect");
    BloomEffect.Intensity = 12;
    BloomEffect.Size = 12;
    BloomEffect.Enabled = false;
    BloomEffect.Threshold = 1;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Enabled = true;
    ColorCorrectionEffect.TintColor = Color3.new(0, 0, 0);
    ColorCorrectionEffect.Brightness = 0;
    ColorCorrectionEffect.Contrast = 0;
    ColorCorrectionEffect.Saturation = 0;
    table.insert(u465, SunRaysEffect);
    table.insert(u465, Atmosphere);
    table.insert(u465, DepthOfFieldEffect);
    table.insert(u465, BloomEffect);
    table.insert(u465, ColorCorrectionEffect);
    DepthOfFieldEffect.Parent = Lighting;
    Atmosphere.Parent = Lighting;
    BloomEffect.Parent = Lighting;
    ColorCorrectionEffect.Parent = Lighting;
    SunRaysEffect.Parent = Lighting;
    Lighting.Brightness = 3;
    Lighting.EnvironmentSpecularScale = 0.64;
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ShadowSoftness = 0.07;
    Lighting.GeographicLatitude = 20.912;
    task.delay(0.4, function() -- Line: 5604
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        local v470 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.69, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        v470:Play();
        v470.Completed:Wait();
        ColorCorrectionEffect.Brightness = 0.03;
    end);
    task.delay(7.18, function() -- Line: 5611
        -- upvalues: u468 (copy)
        if u468 and (u468:FindFirstChild("camera") and u468:FindFirstChild("camera"):FindFirstChild("3")) then
            for _, child in u468.camera["3"]:GetChildren() do
                if child:IsA("ParticleEmitter") then
                    child.Enabled = true;
                end;
            end;
        end;
    end);
    task.delay(1.166, function() -- Line: 5621
        -- upvalues: TekrinnDialogue (ref), u459 (copy)
        TekrinnDialogue.Speak(u459.Name, {
            {
                Text = "Be honest, ain\'t I clean tho?",
                Bold = true,
                TypeSpeed = 0.075,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 170, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 127)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 0.5
                }
            }
        }, 2.9825000000000004);
    end);
    task.delay(4.1485, function() -- Line: 5647
        -- upvalues: u468 (copy), SunRaysEffect (copy), Atmosphere (copy), BloomEffect (copy), TweenService (ref), DepthOfFieldEffect (copy)
        for i = 1, 3 do
            local v471;

            if u468 and (u468:FindFirstChild("camera") and u468:FindFirstChild("camera"):FindFirstChild(i)) then
                v471 = i;

                for _, child in u468.camera[i]:GetChildren() do
                    if child:IsA("ParticleEmitter") then
                        child.Enabled = true;
                    end;
                end;
            else
                v471 = i;
            end;
        end;

        SunRaysEffect.Enabled = true;
        Atmosphere.Color = Color3.fromRGB(200, 220, 255);
        Atmosphere.Density = 0.3;
        Atmosphere.Offset = 0.25;
        Atmosphere.Decay = Color3.fromRGB(120, 150, 200);
        BloomEffect.Enabled = true;
        TweenService:Create(BloomEffect, TweenInfo.new(0.96, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            Intensity = 2,
            Size = 12,
            Threshold = 2
        }):Play();
        DepthOfFieldEffect.FocusDistance = 25;
        DepthOfFieldEffect.InFocusRadius = 15;
        DepthOfFieldEffect.FarIntensity = 0.3;
        DepthOfFieldEffect.NearIntensity = 0;
        local v472 = TweenService:Create(DepthOfFieldEffect, TweenInfo.new(1.05, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            FocusDistance = 35,
            InFocusRadius = 25
        });
        v472:Play();
        v472.Completed:Wait();
        DepthOfFieldEffect.NearIntensity = 0.18;
        TweenService:Create(DepthOfFieldEffect, TweenInfo.new(3.01, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            NearIntensity = 0
        }):Play();
    end);
    task.delay(4.2, function() -- Line: 5683
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.Brightness = 0.5;
        local v473 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            Brightness = 1
        });
        v473:Play();
        v473.Completed:Wait();
        ColorCorrectionEffect.Saturation = 0.35;
        local v474 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.92, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            Brightness = 0.2
        });
        v474:Play();
        v474.Completed:Wait();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Brightness = 0.1
        });
    end);
    task.delay(10.01, function() -- Line: 5697
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.43, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            TintColor = Color3.new(0, 0, 0)
        });
    end);
    mainreplication.sceneEnabled(true);
    local u475 = false;

    local function this_is_the_freaking_best_i_know_i_can_become_so_much_stronger() -- Line: 5703
        -- upvalues: u475 (ref), mainreplication (ref), u469 (copy), u462 (copy), u465 (copy), u464 (copy), Lighting (ref), Ambient (ref), Brightness (ref), ColorShift_Top (ref), EnvironmentDiffuseScale (ref), GlobalShadows (ref), OutdoorAmbient (ref), ShadowSoftness (ref), ClockTime2 (ref), GeographicLatitude (ref), ExposureCompensation (ref), FogColor (ref), FogEnd (ref), FogStart (ref)
        if u475 then
            return;
        end;

        u475 = true;
        mainreplication.blackscene(1);
        print("we done here");
        u469();
        u462:Destroy();

        for _, v in u465 do
            pcall(game.Destroy, v);
        end;

        for _, v in u464 do
            v.Parent = Lighting;
        end;

        task.delay(1, function() -- Line: 5716
            -- upvalues: Lighting (ref), Ambient (ref), Brightness (ref), ColorShift_Top (ref), EnvironmentDiffuseScale (ref), GlobalShadows (ref), OutdoorAmbient (ref), ShadowSoftness (ref), ClockTime2 (ref), GeographicLatitude (ref), ExposureCompensation (ref), FogColor (ref), FogEnd (ref), FogStart (ref), mainreplication (ref)
            Lighting.Ambient = Ambient;
            Lighting.Brightness = Brightness;
            Lighting.ColorShift_Top = ColorShift_Top;
            Lighting.EnvironmentDiffuseScale = EnvironmentDiffuseScale;
            Lighting.GlobalShadows = GlobalShadows;
            Lighting.OutdoorAmbient = OutdoorAmbient;
            Lighting.ShadowSoftness = ShadowSoftness;
            Lighting.ClockTime = ClockTime2;
            Lighting.GeographicLatitude = GeographicLatitude;
            Lighting.ExposureCompensation = ExposureCompensation;
            Lighting.FogColor = FogColor;
            Lighting.FogEnd = FogEnd;
            Lighting.FogStart = FogStart;
            mainreplication.sceneEnabled(false);
        end);
    end;

    u462:Add(this_is_the_freaking_best_i_know_i_can_become_so_much_stronger);
    task.delay(p460 - 1, function() -- Line: 5738
        -- upvalues: u475 (ref), u462 (copy), this_is_the_freaking_best_i_know_i_can_become_so_much_stronger (copy)
        if not u475 then
            u462:Destroy();
            this_is_the_freaking_best_i_know_i_can_become_so_much_stronger();
        end;
    end);
end;

function v1.mvp_GetFunky(p476, p477) -- Line: 5747
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), soundUtil (copy), SoundService (copy), Lighting (copy), vfxUtil (copy), mainreplication (copy), Ambient (copy), Brightness (copy), OutdoorAmbient (copy), ExposureCompensation (copy)
    local GetFunky = ReplicatedStorage2.Resources.mvpAssets.GetFunky;
    local v478 = p476.HumanoidRootPart or p476.PrimaryPart;
    local _ = p476.Torso;
    local u479 = trove.new();
    soundUtil:play(GetFunky:FindFirstChild("soundmvp"), SoundService);
    local u480 = {};

    for _, child in p476:GetChildren() do
        if child:IsA("BasePart") then
            local PointLight = Instance.new("PointLight");
            PointLight.Parent = child;
            PointLight.Range = 2;
            table.insert(u480, PointLight);
        end;
    end;

    Lighting.Ambient = Color3.new(0, 0, 0);
    Lighting.Brightness = 0;
    Lighting.OutdoorAmbient = Color3.new(0, 0, 0);
    Lighting.ExposureCompensation = -1;
    local v481 = GetFunky.Lights:Clone();
    table.insert(u480, v481);
    v478.CFrame = workspace.map.PrimaryPart.CFrame * CFrame.new(0, 2.15, 45);
    local v482 = vfxUtil.newRigForFriend(v478);
    table.insert(u480, v482);

    for _, child in v482:GetChildren() do
        if child:IsA("BasePart") then
            local PointLight = Instance.new("PointLight");
            PointLight.Range = 2;
            PointLight.Parent = child;
            table.insert(u480, PointLight);
        end;
    end;

    v482.Humanoid.Animator:LoadAnimation(GetFunky.DuoAnimation):Play(0);

    for _, descendant in v482:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "none";
        end;
    end;

    v481.Parent = workspace.Effects;
    v481:PivotTo(v478.CFrame * CFrame.new(0, -4, 7) * CFrame.fromEulerAnglesYXZ(0, -1.5707963267948966, 0));
    local _, u483 = mainreplication.cutsceneCamRigWithLetterBox(v478, GetFunky.caniamtion, GetFunky.FOV, p476, CFrame.new(0, -3, 0), GetFunky.GetFunkyCamera);
    local u484 = GetFunky.Assets.ending.Attachment:Clone();
    u484.Parent = v478;
    table.insert(u480, u484);
    local u485 = {
        trail = GetFunky.Assets["Left Leg"].Trail:Clone()
    };
    local u486 = {
        trail = GetFunky.Assets["Left Leg"].Trail:Clone()
    };
    u485.trail.Parent = p476:FindFirstChild("Left Leg");

    for i = 1, 2 do
        local Attachment = Instance.new("Attachment");
        Attachment.Position = Vector3.new(0, -0.75, 0.5 * (i == 1 and 1 or -1));
        Attachment.Parent = p476:FindFirstChild("Left Leg");
        u485["Attachment" .. tostring(i == 1 and 0 or 1)] = Attachment;
        local _ = i;
    end;

    u485.trail.Attachment0 = u485.Attachment0;
    u485.trail.Attachment1 = u485.Attachment1;
    u486.trail.Parent = p476:FindFirstChild("Right Leg");

    for i = 1, 2 do
        local Attachment = Instance.new("Attachment");
        Attachment.Position = Vector3.new(0, -0.75, 0.5 * (i == 1 and 1 or -1));
        Attachment.Parent = p476:FindFirstChild("Right Leg");
        u486["Attachment" .. tostring(i == 1 and 0 or 1)] = Attachment;
        local _ = i;
    end;

    u486.trail.Attachment0 = u486.Attachment0;
    u486.trail.Attachment1 = u486.Attachment1;
    u486.trail.Enabled = false;
    u485.trail.Enabled = false;
    mainreplication.sceneEnabled(true);
    local u487 = false;

    local function u488() -- Line: 5838
        -- upvalues: u487 (ref), mainreplication (ref), u479 (copy), u483 (copy), u480 (copy), u485 (copy), u486 (copy), Lighting (ref), Ambient (ref), Brightness (ref), OutdoorAmbient (ref), ExposureCompensation (ref)
        if u487 then
            return;
        end;

        u487 = true;
        mainreplication.blackscene(1);
        u479:Destroy();
        u483();

        for _, v in u480 do
            pcall(game.Destroy, v);
        end;

        for _, v in { table.unpack(u485), table.unpack(u486) } do
            pcall(game.Destroy, v);
        end;

        task.delay(1, function() -- Line: 5853
            -- upvalues: Lighting (ref), Ambient (ref), Brightness (ref), OutdoorAmbient (ref), ExposureCompensation (ref)
            Lighting.Ambient = Ambient;
            Lighting.Brightness = Brightness;
            Lighting.OutdoorAmbient = OutdoorAmbient;
            Lighting.ExposureCompensation = ExposureCompensation;
        end);
    end;

    u479:Add(task.delay(10.21, function() -- Line: 5861
        -- upvalues: u486 (copy), u485 (copy)
        u486.trail.Enabled = true;
        u485.trail.Enabled = true;
        task.wait(1.81);
        u486.trail.Enabled = false;
        u485.trail.Enabled = false;
    end));
    u479:Add(task.delay(17.23, function() -- Line: 5869
        -- upvalues: u484 (copy)
        for _, descendant in u484:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;
    end));
    u479:Add(u488);
    task.delay(p477 - 1, function() -- Line: 5881
        -- upvalues: u487 (ref), u479 (copy), u488 (copy)
        if not u487 then
            u479:Destroy();
            u488();
        end;
    end);
end;

function v1.mvp_contractMVP(p489, p490) -- Line: 5889
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), soundUtil (copy), SoundService (copy), vfxUtil (copy), Lighting (copy), ReplicatedStorage (copy), PlayerGui (copy), mainreplication (copy), MoonPropertyAnimator (copy), UwUEffects (copy), Color (copy), Haze (copy), Density (copy), Offset (copy), Ambient (copy), Brightness (copy), ClockTime2 (copy)
    local DevilsContract = ReplicatedStorage2.Resources.mvpAssets.DevilsContract;
    local u491 = p489.HumanoidRootPart or p489.PrimaryPart;
    local _ = p489.Torso;
    u491.CFrame = workspace.map.PrimaryPart.CFrame * CFrame.new(0, 2.15, 0);
    local u492 = trove.new();
    soundUtil:play(DevilsContract.soundmvp, SoundService);
    local u493 = {};
    local u494 = vfxUtil.newRigForFriend(u491);
    table.insert(u493, u494);
    local u495 = DevilsContract.VFX:Clone();
    u495.Parent = p489;
    u495:PivotTo(u491.CFrame);
    table.insert(u493, u495);
    local u496 = DevilsContract.CamFX3:Clone();
    u496.Parent = p489;
    table.insert(u493, u496);
    local v497 = DevilsContract.Assets.Bloom:Clone();
    v497.Parent = workspace.Effects;
    table.insert(u493, v497);
    local v498 = DevilsContract.Assets.DepthOfField:Clone();
    v498.Parent = workspace.Effects;
    table.insert(u493, v498);
    local v499 = DevilsContract.Assets.CC:Clone();
    v499.Parent = workspace.Effects;
    table.insert(u493, v499);
    Lighting.Atmosphere.Density = 0.3;
    Lighting.Atmosphere.Offset = 0.25;
    local v500 = ReplicatedStorage.Resources.MoonAnimatorEffects:Clone();
    local Vignette = v500.Vignette;
    Vignette.Changed:Connect(function(p501) -- Line: 5931
        -- upvalues: Vignette (copy)
        if not table.find({ "ImageTransparency", "ImageColor3" }, p501) then
            return;
        end;

        for _, descendant in Vignette:GetDescendants() do
            if descendant:IsA("ImageLabel") then
                descendant[p501] = Vignette[p501];
            end;
        end;
    end);
    v500.Parent = PlayerGui;
    table.insert(u493, v500);
    local u502 = nil;
    u502 = mainreplication.kuronaCam(u491, nil, DevilsContract.FOV, function() -- Line: 5942
        -- upvalues: u494 (copy), u491 (copy), u495 (copy), u496 (copy), u502 (ref)
        u494.HumanoidRootPart.CFrame = u491.CFrame;
        u495:PivotTo(u491.CFrame);
        u496.CFrame = u502.CFrame;
    end);
    table.insert(u493, u502);
    u494.Humanoid.Animator:LoadAnimation(DevilsContract.DuoAnimation):Play(0);
    mainreplication.sceneEnabled(true);
    local v503 = MoonPropertyAnimator.ConvertSave(DevilsContract.MVP, {
        Lighting = Lighting,
        ["Screen Cover"] = v500["Screen Cover"],
        DepthOfField = v498
    });
    local v504 = MoonPropertyAnimator.new();
    v504:LoadSave(DevilsContract.MVP, v503);
    v504:PlayAll();
    UwUEffects.createEffect({
        Character = p489,
        VFX = u495
    }, "ContractMVP");
    u492:Add(function() -- Line: 5967
        -- upvalues: Lighting (ref), Color (ref), Haze (ref), Density (ref), Offset (ref), Ambient (ref), Brightness (ref), ClockTime2 (ref), u493 (copy)
        Lighting.Atmosphere.Color = Color;
        Lighting.Atmosphere.Haze = Haze;
        Lighting.Atmosphere.Density = Density;
        Lighting.Atmosphere.Offset = Offset;
        Lighting.Ambient = Ambient;
        Lighting.Brightness = Brightness;
        Lighting.ClockTime = ClockTime2;

        for _, v in u493 do
            pcall(game.Destroy, v);
        end;
    end);
    task.delay(p490 - 1, function() -- Line: 5982
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end);
    task.delay(p490, function() -- Line: 5986
        -- upvalues: u492 (copy)
        u492:Destroy();
    end);
end;

function v1.mvp_MidorimaMVP(p505, p506) -- Line: 5992
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), soundUtil (copy), SoundService (copy), PlayerGui (copy), Lighting (copy), mainreplication (copy), Ambient (copy), Brightness (copy), OutdoorAmbient (copy), ExposureCompensation (copy), ClockTime2 (copy), GeographicLatitude (copy), TweenService (copy)
    local Midorima = ReplicatedStorage2.Resources.mvpAssets.Midorima;
    local v507 = p505.HumanoidRootPart or p505.PrimaryPart;
    local _ = p505.Torso;
    local u508 = trove.new();
    soundUtil:play(Midorima:FindFirstChild("soundmvp"), SoundService);
    local u509 = {};
    local u510 = Midorima.Assets.vignette:Clone();
    table.insert(u509, u510);
    u510.Parent = PlayerGui;
    local v511 = Midorima.Assets.Cam:Clone();
    v511.Parent = v507;
    v511.Cam.Part0 = v507;
    local u512 = {};
    local u513 = {};

    for _, child in Lighting:GetChildren() do
        if child:IsA("ColorCorrectionEffect") or (child:IsA("Sky") or (child:IsA("SunRaysEffect") or (child:IsA("DepthOfFieldEffect") or (child:IsA("Atmosphere") or child:IsA("BloomEffect"))))) then
            table.insert(u512, child);
            child.Parent = workspace;
        end;
    end;

    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.Brightness = 3;
    Lighting.ClockTime = 14.5;
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ExposureCompensation = 0;
    Lighting.GeographicLatitude = 0;

    for _, child in Midorima.Assets.Lighting:GetChildren() do
        local v514 = child:Clone();
        table.insert(u513, v514);
        v514.Parent = Lighting;
    end;

    local v515 = Midorima.Assets.MidorimaGlasses:Clone();
    table.insert(u509, v515);
    v515.Parent = p505;
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Parent = v507;
    Motor6D.Part0 = Motor6D.Parent;
    Motor6D.Part1 = v515;
    Motor6D.C0 = CFrame.new(
        -4.98309269e-8,
        1.49624825,
        -0.285000116,
        1,
        -3.82135103e-15,
        1.74845326e-7,
        -1.14641894e-14,
        1,
        8.74232171e-8,
        -1.74845781e-7,
        -8.7422336e-8,
        1
    );
    local u516 = Midorima.Assets.VFX:Clone();
    u516.Parent = workspace.Effects;
    u516.core_part.CFrame = v507.CFrame;

    for i = 1, 3 do
        local Weld = Instance.new("Weld");
        Weld.Parent = v511;
        Weld.Part0 = Weld.Parent;
        Weld.Part1 = u516["CamFX" .. tostring(i)];
        local Weld2 = Instance.new("Weld");
        Weld2.Parent = u516["Shine" .. tostring(i)];
        Weld2.Part0 = Weld2.Parent;
        Weld2.Part1 = v515;
        Weld2.C0 = CFrame.new(i == 1 and 0.100000001 or (i == 2 and -0.5 or 0.5), 0, 0.300000012, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        local _ = i;
    end;

    table.insert(u509, u516);
    local v517 = p505.Humanoid:LoadAnimation(Midorima.Animation);
    mainreplication.CutsceneLrBrick(v507, v517, Midorima.FOV);
    v517:Play(0);
    mainreplication.sceneEnabled(true);
    local u518 = false;

    local function u519() -- Line: 6073
        -- upvalues: u518 (ref), mainreplication (ref), u508 (copy), u509 (copy), u513 (copy), u512 (copy), Lighting (ref), Ambient (ref), Brightness (ref), OutdoorAmbient (ref), ExposureCompensation (ref), ClockTime2 (ref), GeographicLatitude (ref)
        if u518 then
            return;
        end;

        u518 = true;
        mainreplication.blackscene(1);
        u508:Destroy();

        for _, v in u509 do
            pcall(game.Destroy, v);
        end;

        for _, v in u513 do
            pcall(game.Destroy, v);
        end;

        for _, v in u512 do
            v.Parent = Lighting;
        end;

        task.delay(0.35, function() -- Line: 6089
            -- upvalues: Lighting (ref), Ambient (ref), Brightness (ref), OutdoorAmbient (ref), ExposureCompensation (ref), ClockTime2 (ref), GeographicLatitude (ref)
            Lighting.Ambient = Ambient;
            Lighting.Brightness = Brightness;
            Lighting.OutdoorAmbient = OutdoorAmbient;
            Lighting.ExposureCompensation = ExposureCompensation;
            Lighting.ClockTime = ClockTime2;
            Lighting.GeographicLatitude = GeographicLatitude;
        end);
    end;

    for _, descendant in ipairs(u516.Beams:GetDescendants()) do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    u508:Add(task.delay(0.37, function() -- Line: 6105
        -- upvalues: u516 (copy)
        for _, descendant in ipairs(u516.Step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u508:Add(task.delay(1.05, function() -- Line: 6114
        -- upvalues: u516 (copy)
        for _, descendant in ipairs(u516.Step2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u508:Add(task.delay(1.51, function() -- Line: 6123
        -- upvalues: u510 (copy), TweenService (ref)
        for _, descendant in u510:GetDescendants() do
            if descendant:IsA("ImageLabel") then
                TweenService:Create(descendant, TweenInfo.new(0.82, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    ImageTransparency = 1
                }):Play();
            end;
        end;
    end));
    u508:Add(task.delay(1.6, function() -- Line: 6131
        -- upvalues: u516 (copy)
        for _, descendant in ipairs(u516.CamFX1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u508:Add(task.delay(1.8, function() -- Line: 6139
        -- upvalues: u516 (copy)
        for _, descendant in ipairs(u516.Beams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u508:Add(task.delay(2.36, function() -- Line: 6147
        -- upvalues: u516 (copy)
        for _, descendant in pairs(u516.CamFX1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u508:Add(task.delay(3.04, function() -- Line: 6155
        -- upvalues: u516 (copy)
        for _, descendant in ipairs(u516.Shine1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u508:Add(task.delay(4, function() -- Line: 6162
        -- upvalues: u516 (copy)
        for _, descendant in ipairs(u516.CamFX2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u516.Shine2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u508:Add(task.delay(5.42, function() -- Line: 6174
        -- upvalues: u516 (copy)
        for _, descendant in ipairs(u516.CamFX2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
                descendant:Clear();
            end;
        end;

        for _, descendant in ipairs(u516.impact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u516.CamFX2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u516.Shine2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Clear();
            end;
        end;

        for _, descendant in ipairs(u516.CamFX1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u508:Add(task.delay(7.37, function() -- Line: 6204
        -- upvalues: u516 (copy)
        for _, descendant in pairs(u516.CamFX1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u508:Add(task.delay(8.04, function() -- Line: 6213
        -- upvalues: u516 (copy)
        for _, descendant in ipairs(u516.Shine3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u516.CamFX3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
                task.delay(2, function() -- Line: 6222
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end));
    u508:Add(u519);
    task.delay(p506 - 1, function() -- Line: 6231
        -- upvalues: u518 (ref), u508 (copy), u519 (copy)
        if not u518 then
            u508:Destroy();
            u519();
        end;
    end);
end;

function v1.mvp_watchOutMVP(u520) -- Line: 6239
    -- upvalues: vfxUtil (copy), trove (copy), ReplicatedStorage2 (copy), soundUtil (copy), SoundService (copy), Lighting (copy), mainreplication (copy), MoonPropertyAnimator (copy), ClockTime2 (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(u520);
    local u521 = trove.new();
    u521:AttachToInstance(u520);
    u521:Add(vfxUtil.getScreenDimmer());
    local rin = require(ReplicatedStorage2.wiki.styles).rin;
    local watchOutMVP = vfxUtil.getResources().mvpAssets.watchOutMVP;
    local u522 = watchOutMVP.Assets.VFX:Clone();
    u522.Parent = u520;
    u522:PivotTo(u520:GetPivot());
    u521:Add(u522);
    soundUtil:play(watchOutMVP.SFX, SoundService);
    local v523 = {};

    for _, child in watchOutMVP.Lighting:GetChildren() do
        local v524 = child:Clone();
        v524.Parent = Lighting;
        u521:Add(v524);
        v523[v524.Name] = v524;
    end;

    local v525 = mainreplication.cutsceneCamRigWithLetterBox(Root, watchOutMVP.CamAnimation, watchOutMVP.FOV, nil, CFrame.new(0, -3, 0), watchOutMVP.Cam, "CamPart");
    local v526;

    if v525 then
        v526 = v525:FindFirstChild("CamPart");
    else
        v526 = v525;
    end;

    local u527 = MoonPropertyAnimator.new();
    u527:LoadSave(watchOutMVP.MVP, MoonPropertyAnimator.ConvertSave(watchOutMVP.MVP, {
        Lighting = Lighting,
        DepthOfField = v523.DepthOfField,
        Atmosphere = v523.Atmosphere,
        Workspace = u522,
        Cam = v525
    }));
    u527:PlayAll();

    if v526 then
        u521:Add(v526);
    end;

    u521:Add(function() -- Line: 6281
        -- upvalues: Lighting (ref), ClockTime2 (ref), u527 (copy)
        Lighting.ClockTime = ClockTime2;
        u527:Destroy();
    end);
    u521:Add(task.delay(0.267, function() -- Line: 6286
        -- upvalues: vfxUtil (ref), u522 (copy)
        vfxUtil.emitAll(u522.Impact);
    end));
    u521:Add(task.delay(2.657, function() -- Line: 6290
        -- upvalues: TekrinnDialogue (ref), u520 (copy), rin (copy)
        TekrinnDialogue.Speak(u520.Name, {
            {
                Text = "Don\'t forget.",
                Color = ColorSequence.new(rin.color, Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }, 3);
    end));
    u521:Add(task.delay(4.876, function() -- Line: 6304
        -- upvalues: TekrinnDialogue (ref), u520 (copy), rin (copy)
        TekrinnDialogue.Speak(u520.Name, {
            {
                Text = "It means I\'ll ",
                Bold = true,
                Color = ColorSequence.new(rin.color, Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3.1239999999999997
                }
            },
            {
                Text = "end",
                Bold = true,
                Color = ColorSequence.new(Color3.new(0, 0, 0), rin.color),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 3.1239999999999997
                }
            },
            {
                Text = " you, no matter what.",
                Bold = true,
                Color = ColorSequence.new(rin.color, Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3.1239999999999997
                }
            }
        }, 3.1239999999999997);
    end));
    u521:Add(task.delay(4.8, function() -- Line: 6340
        -- upvalues: vfxUtil (ref), u522 (copy)
        vfxUtil.emitAll(u522.KaBoom);
    end));
    u521:Add(task.delay(9, function() -- Line: 6344
        -- upvalues: mainreplication (ref), u521 (copy)
        mainreplication.blackscene(1);
        task.wait(1);
        u521:Destroy();
    end));
    mainreplication.sceneEnabled(true);
end;

function v1.mvp_oiiTensai(p528) -- Line: 6353
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), SoundService (copy), Lighting (copy), mainreplication (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p528);
    local u529 = trove.new();
    u529:AttachToInstance(p528);
    u529:Add(vfxUtil.getScreenDimmer());
    local oiiTensai = vfxUtil.getResources().mvpAssets.oiiTensai;
    local u530 = oiiTensai.VFX:Clone();
    u530.Parent = workspace.Effects;
    u530:PivotTo(p528:GetPivot());
    vfxUtil.setupAura(p528, u530["Oii tensai"].Rig, true);
    u529:Add(u530);
    soundUtil:play(oiiTensai.SFX, SoundService);
    local v531 = {};

    for _, child in oiiTensai.Lighting:GetChildren() do
        local v532 = child:Clone();
        v532.Parent = Lighting;
        u529:Add(v532);
        v531[v532.Name] = v532;
    end;

    local v533 = mainreplication.cutsceneCamRigWithLetterBox(Root, oiiTensai.CamAnimation, oiiTensai.FOV, nil, CFrame.new(0, -3, 0), oiiTensai.OiiTensaiCamera, "camera");
    local u534 = MoonPropertyAnimator.new();
    u534:LoadSave(oiiTensai.MoonVFX, MoonPropertyAnimator.ConvertSave(oiiTensai.MoonVFX, {
        Lighting = Lighting,
        Workspace = u530,
        Cam = v533
    }));
    u534:PlayAll();
    u529:Add(function() -- Line: 6388
        -- upvalues: u534 (copy)
        u534:Destroy();
    end);
    u529:Add(task.delay(3.3, function() -- Line: 6392
        -- upvalues: vfxUtil (ref), u530 (copy)
        vfxUtil.emitAll(u530.WingsBoom);
    end));
    u529:Add(task.delay(9.65, function() -- Line: 6396
        -- upvalues: mainreplication (ref), u529 (copy)
        mainreplication.blackscene(1);
        task.wait(1);
        u529:Destroy();
    end));
    mainreplication.sceneEnabled(true);
end;

function v1.mvp_shidouXCharles(p535) -- Line: 6405
    -- upvalues: vfxUtil (copy), Players (copy), trove (copy), soundUtil (copy), SoundService (copy), Lighting (copy), mainreplication (copy), MoonPropertyAnimator (copy), ClockTime2 (copy)
    local Root = vfxUtil.getRoot(p535);
    Players:GetPlayerFromCharacter(p535);
    local u536 = trove.new();
    u536:AttachToInstance(p535);
    local shidouXCharles = vfxUtil.getResources().mvpAssets.shidouXCharles;
    local u537 = shidouXCharles.VFX:Clone();
    u537.Parent = workspace.Effects;
    u537:PivotTo(p535:GetPivot());
    vfxUtil.setupAura(p535, u537.ShidouSXCMVP, true);
    u536:Add(u537);
    local v538 = vfxUtil.newRigForFriend(Root);
    u536:Add(v538);
    v538.Humanoid.Animator:LoadAnimation(shidouXCharles.Animations.Charles):Play(0);
    soundUtil:play(shidouXCharles.SFX, SoundService);
    local u539 = {};

    for _, child in shidouXCharles.Lighting:GetChildren() do
        local v540 = child:Clone();
        v540.Parent = Lighting;
        u536:Add(v540);
        u539[v540.Name] = v540;
    end;

    local v541 = mainreplication.cutsceneCamRigWithLetterBox(Root, shidouXCharles.CamAnimation, shidouXCharles.FOV, nil, CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0), shidouXCharles.CamRigWithLetterBox, "camera");
    local u542 = MoonPropertyAnimator.new();
    u542:LoadSave(shidouXCharles.MoonVFX, MoonPropertyAnimator.ConvertSave(shidouXCharles.MoonVFX, {
        Lighting = Lighting,
        DepthOfField = u539.DepthOfField,
        Workspace = u537,
        Cam = v541
    }));
    u542:PlayAll();
    u536:Add(function() -- Line: 6446
        -- upvalues: Lighting (ref), ClockTime2 (ref), u542 (copy)
        Lighting.ClockTime = ClockTime2;
        u542:Destroy();
    end);
    u536:Add(task.delay(0.1, function() -- Line: 6451
        -- upvalues: vfxUtil (ref), u537 (copy)
        vfxUtil.emitAll(u537.Ground);
    end));
    u536:Add(task.delay(0.333, function() -- Line: 6455
        -- upvalues: vfxUtil (ref), u537 (copy)
        vfxUtil.emitAll(u537.ShidouSXCMVP);
    end));
    u536:Add(task.delay(1, function() -- Line: 6459
        -- upvalues: u539 (copy)
        u539.DepthOfField:Destroy();
    end));
    u536:Add(task.delay(3.8, function() -- Line: 6463
        -- upvalues: vfxUtil (ref), u537 (copy)
        vfxUtil.emitAll(u537.Footthing);
    end));
    u536:Add(task.delay(5.483, function() -- Line: 6467
        -- upvalues: mainreplication (ref), u536 (copy)
        mainreplication.blackscene(1);
        task.wait(1);
        u536:Destroy();
    end));
    mainreplication.sceneEnabled(true);
end;

local script_amazingFeeling = require(script.amazingFeeling);

function v1.mvp_amazingFeeling(u543) -- Line: 6478
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), SoundService (copy), Lighting (copy), mainreplication (copy), animationUtil (copy), MoonPropertyAnimator (copy), Ambient (copy), Brightness (copy), script_amazingFeeling (copy), ReplicatedStorage2 (copy), TekrinnDialogue (copy)
    vfxUtil.getRoot(u543);
    local u544 = trove.new();
    u544:AttachToInstance(u543);
    u544:Add(vfxUtil.getScreenDimmer());
    local amazingFeeling = vfxUtil.getResources().mvpAssets.amazingFeeling;
    local v545 = amazingFeeling.VFX:Clone();
    v545.Parent = workspace.Effects;
    v545:PivotTo(u543:GetPivot());
    u544:Add(v545);
    local RootVFX = v545.RootVFX;
    local HeadVFX = v545.HeadVFX;
    HeadVFX.Weld.Part0 = u543:FindFirstChild("Head");
    soundUtil:play(amazingFeeling.SFX, SoundService);
    local v546 = {};

    for _, child in amazingFeeling.Lighting:GetChildren() do
        local v547 = child:Clone();
        v547.Parent = Lighting;
        u544:Add(v547);
        v546[v547.Name] = v547;
    end;

    local CameraRig = v545.CameraRig;
    mainreplication.kuronaCamButRig(CameraRig.HumanoidRootPart, CameraRig, nil, amazingFeeling.FOV);
    animationUtil:loadAnimation(CameraRig, amazingFeeling.CamAnimation):Play(0);
    u544:Add(CameraRig);
    local u548 = MoonPropertyAnimator.new();
    u548:LoadSave(amazingFeeling.MoonVFX, MoonPropertyAnimator.ConvertSave(amazingFeeling.MoonVFX, {
        Lighting = Lighting,
        Workspace = v545
    }));
    u548:PlayAll();
    u544:Add(function() -- Line: 6518
        -- upvalues: Lighting (ref), Ambient (ref), Brightness (ref), u548 (copy)
        Lighting.Ambient = Ambient;
        Lighting.Brightness = Brightness;
        u548:Destroy();
    end);

    for _, v in ipairs(script_amazingFeeling) do
        u544:Add(task.delay(v[1] / 60, v[2], RootVFX, HeadVFX));
    end;

    local rin = require(ReplicatedStorage2.wiki.styles).rin;
    u544:Add(task.delay(5.9, function() -- Line: 6530
        -- upvalues: TekrinnDialogue (ref), u543 (copy), rin (copy)
        TekrinnDialogue.Speak(u543.Name, {
            {
                Text = "Kill... kill.. kill.",
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0, 0, 0)),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 4
                }
            }
        }, 2.799999999999999, nil, rin.color);
    end));
    u544:Add(task.delay(8.083, function() -- Line: 6546
        -- upvalues: mainreplication (ref), u544 (copy)
        mainreplication.blackscene(1);
        task.wait(1);
        u544:Destroy();
    end));
    mainreplication.sceneEnabled(true);
end;

function v1.mvp_ReoMVP(u549) -- Line: 6555
    -- upvalues: vfxUtil (copy), trove (copy), Lighting (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), Ambient (copy), Brightness (copy), ColorShift_Top (copy), EnvironmentDiffuseScale (copy), EnvironmentSpecularScale (copy), GlobalShadows (copy), OutdoorAmbient (copy), ShadowSoftness (copy), ClockTime2 (copy), ExposureCompensation (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(u549);
    local u550 = trove.new();
    u550:AttachToInstance(u549);
    local ReoMVP = vfxUtil.getResources().mvpAssets.ReoMVP;
    local u551 = {};
    local u552 = {};

    for _, child in Lighting:GetChildren() do
        if child:IsA("ColorCorrectionEffect") or (child:IsA("Sky") or (child:IsA("Atmosphere") or child:IsA("BloomEffect"))) then
            table.insert(u551, child);
            child.Parent = workspace;
        end;
    end;

    for _, child in ReoMVP.Assets.Lighting:GetChildren() do
        local v553 = child:Clone();
        table.insert(u552, v553);
        v553.Parent = Lighting;
    end;

    for _, child in ReoMVP.Assets.HumanoidRootPart:GetChildren() do
        u550:Add(child:Clone()).Parent = Root;
    end;

    soundUtil:play(ReoMVP.soundmvp, SoundService);
    Lighting.Ambient = Color3.new(0, 0, 0);
    Lighting.Brightness = 3;
    Lighting.ColorShift_Top = Color3.new(0, 0, 0);
    Lighting.ColorShift_Bottom = Color3.new(0, 0, 0);
    Lighting.EnvironmentDiffuseScale = 1;
    Lighting.EnvironmentSpecularScale = 1;
    Lighting.GlobalShadows = true;
    Lighting.OutdoorAmbient = Color3.new(0, 0, 0);
    Lighting.ShadowSoftness = 0.2;
    Lighting.ClockTime = 0;
    Lighting.ExposureCompensation = 0;
    local u554 = u550:Add(ReoMVP.Assets.Head.Eye:Clone());
    local u555 = u550:Add(ReoMVP.Assets.Head.FaceShot2:Clone());
    local v556 = {};

    for _, child in ReoMVP.Assets["Right Arm"]:GetChildren() do
        local v557 = u550:Add(child:Clone());
        table.insert(v556, v557);
        v557.Parent = u549:FindFirstChild("Right Arm");
    end;

    local _, v558 = mainreplication.cutsceneCamRigWithLetterBoxForIdiots(Root, ReoMVP.CamAnimation, ReoMVP.FOV, nil, CFrame.new(4, 0, 0), ReoMVP.Assets.Cam, "Camera");
    u550:Add(v558);
    u550:Add(function() -- Line: 6612
        -- upvalues: u552 (copy), u551 (copy), Lighting (ref), Ambient (ref), Brightness (ref), ColorShift_Top (ref), EnvironmentDiffuseScale (ref), EnvironmentSpecularScale (ref), GlobalShadows (ref), OutdoorAmbient (ref), ShadowSoftness (ref), ClockTime2 (ref), ExposureCompensation (ref)
        for _, v in u552 do
            pcall(game.Destroy, v);
        end;

        for _, v in u551 do
            v.Parent = Lighting;
        end;

        Lighting.Ambient = Ambient;
        Lighting.Brightness = Brightness;
        Lighting.ColorShift_Top = ColorShift_Top;
        Lighting.ColorShift_Bottom = ColorShift_Top;
        Lighting.EnvironmentDiffuseScale = EnvironmentDiffuseScale;
        Lighting.EnvironmentSpecularScale = EnvironmentSpecularScale;
        Lighting.GlobalShadows = GlobalShadows;
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.ShadowSoftness = ShadowSoftness;
        Lighting.ClockTime = ClockTime2;
        Lighting.ExposureCompensation = ExposureCompensation;
    end);
    u550:Add(task.delay(1.02, function() -- Line: 6633
        -- upvalues: u549 (copy)
        for _, descendant in u549:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;
    end));
    u550:Add(task.delay(2.65, function() -- Line: 6641
        -- upvalues: TekrinnDialogue (ref), u549 (copy)
        TekrinnDialogue.Speak(u549.Name, {
            {
                Text = "Call me the master of all trades.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 0, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 4);
    end));
    u550:Add(task.delay(2.14, function() -- Line: 6667
        -- upvalues: u554 (copy), u555 (copy)
        for _, descendant in u554:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in u555:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u550:Add(task.delay(3.7800000000000002, function() -- Line: 6681
        -- upvalues: mainreplication (ref), u550 (copy)
        mainreplication.blackscene(1);
        task.wait(1);
        u550:Destroy();
    end));
    mainreplication.sceneEnabled(true);
end;

function v1.mvp_auraMonsterMVP(p559: userdata, p560: any) -- Line: 6690
    -- upvalues: ReplicatedStorage (copy), LoadAvatar (copy), mainreplication (copy), trove (copy), vfxUtil (copy), VfxHandler (copy), animationUtil (copy), soundUtil (copy), SoundService (copy), UwUEffects (copy)
    local HumanoidRootPart = p559:FindFirstChild("HumanoidRootPart");
    p559:FindFirstChild("Humanoid");

    if not HumanoidRootPart then
        return;
    end;

    local Model = Instance.new("Model");
    local v561 = ReplicatedStorage.Resources.Rig:Clone();
    LoadAvatar(v561, p559);
    v561:ScaleTo(8);

    for _, child in v561:GetChildren() do
        child.Parent = Model;
    end;

    v561:Destroy();
    Model.HumanoidRootPart.Anchored = true;
    mainreplication.sceneEnabled(true);
    local v562 = trove.new();
    v562:AttachToInstance(p559);
    local auraMonsterMVP = vfxUtil.getResources().mvpAssets.auraMonsterMVP;
    local u563 = VfxHandler.HideMap("MapOnly");
    local u564 = auraMonsterMVP.VFX:Clone();
    u564.SubaruCamera:Destroy();
    u564.Parent = workspace.Effects;
    u564:PivotTo(HumanoidRootPart.CFrame);
    local v565, v566 = mainreplication.cutsceneCamRigWithLetterBox(HumanoidRootPart, auraMonsterMVP.Animations.Cam, nil, p559, CFrame.new(0, -3, -3), auraMonsterMVP.VFX.SubaruCamera);
    v562:Add(v566);
    Model.Parent = u564;
    Model.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
    animationUtil:loadAnimation(Model, auraMonsterMVP.Animations.giantSubaru):Play();
    soundUtil:play(auraMonsterMVP.SFX, SoundService);
    UwUEffects.createEffect({
        Character = p559,
        Camera = v565
    }, "auraMonsterMVP");
    task.delay(p560 - 0.5, function() -- Line: 6730
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.delay(p560, function() -- Line: 6736
        -- upvalues: ScreenDimmer (copy), Model (copy), u564 (copy), VfxHandler (ref), u563 (copy), mainreplication (ref)
        ScreenDimmer:Destroy();
        pcall(game.Destroy, Model);
        pcall(game.Destroy, u564);
        VfxHandler.ShowMap(u563);
        mainreplication.fov(false, 70);
    end);
end;

function v1.mvp_rinTriumphV2(p567) -- Line: 6745
    -- upvalues: vfxUtil (copy), KatUtil (copy), soundUtil (copy), SoundService (copy), PlayerGui (copy), mainreplication (copy), Lighting (copy)
    local rinTriumphV2 = vfxUtil.getResources().mvpAssets.rinTriumphV2;
    local _track = KatUtil.get_track(p567, rinTriumphV2.Animation);
    local Root = vfxUtil.getRoot(p567);
    soundUtil:play(vfxUtil.getResources().mvpAssets.rinTriumphV2.soundmvp, SoundService);

    if not _track then
        return;
    end;

    local v568 = _track.add(Instance.new("Weld"));
    local u569 = _track.add(rinTriumphV2["big winds"]:Clone());
    local u570 = _track.add(rinTriumphV2.Stuff:Clone());
    u570.Parent = PlayerGui;
    local u571 = _track.add(vfxUtil.createVFX(rinTriumphV2.headEff, "default", p567.Head));
    local v572, v573 = mainreplication.cutsceneCamRigWithLetterBox(Root, rinTriumphV2.Camera, rinTriumphV2.FOV, nil, CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 3.141592653589793, 0));
    local u574 = _track.add(rinTriumphV2.CamVFX:Clone());
    _track.add(v572);
    _track.add(v573);
    _track.add(vfxUtil.getScreenDimmer());

    local function apply_lighting() -- Line: 6764
        -- upvalues: Lighting (ref), rinTriumphV2 (copy)
        local Children = Lighting:GetChildren();
        local u575 = {};
        local u576 = {};

        for _, v in Children do
            v.Parent = nil;
        end;

        for _, child in rinTriumphV2.Lighting:GetChildren() do
            local v577 = child:Clone();
            v577.Parent = Lighting;
            u575[v577.Name] = v577;
        end;

        for i, v in rinTriumphV2.Lighting:GetAttributes() do
            u576[i] = Lighting[i];
            Lighting[i] = v;
        end;

        return function() -- Line: 6784
            -- upvalues: Children (copy), Lighting (ref), u575 (copy), u576 (copy)
            for _, v in Children do
                v.Parent = Lighting;
            end;

            for _, v in u575 do
                v:Destroy();
            end;

            for i, v in u576 do
                Lighting[i] = v;
            end;
        end;
    end;

    u569:PivotTo(Root.CFrame * CFrame.new(-1.35959387, 0.138221741, 23.8124676, -1.00000072, 0, 0, 0, 1, 0, 0, 0, -1.00000072));
    u569.Parent = workspace.Effects;
    u574.Parent = workspace.Effects;
    v568.Parent = v572;
    v568.Part0 = v572.camera;
    v568.part1 = u574;
    v568.C0 = CFrame.new(
        0.00021129963,
        -0.000421047211,
        0.0188124925,
        0.999759734,
        0.010869544,
        0.0190329943,
        -0.010560357,
        0.999811947,
        -0.0162705816,
        -0.0192062613,
        0.0160656814,
        0.999686241
    );
    mainreplication.BetterEnable(u569, false);
    mainreplication.BetterEnable(u574, false);
    mainreplication.sceneEnabled(true);
    _track.add(function() -- Line: 6810
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    _track.add((apply_lighting()));
    _track.add(KatUtil.frame_delay(90, function() -- Line: 6815
        -- upvalues: mainreplication (ref), u569 (copy), u574 (copy)
        mainreplication.BetterEnable(u569, true);
        mainreplication.BetterEnable(u574, true);
    end));
    _track.add(KatUtil.frame_delay(96, function() -- Line: 6820
        -- upvalues: u570 (copy), KatUtil (ref)
        u570.White.BackgroundTransparency = 0.7;
        KatUtil.tween_frames(u570.White, { 56, Enum.EasingStyle.Quad, Enum.EasingDirection.Out }, {
            BackgroundTransparency = 1
        });
    end));
    _track.add(KatUtil.frame_delay(260, function() -- Line: 6827
        -- upvalues: mainreplication (ref), u569 (copy), u574 (copy)
        mainreplication.BetterEnable(u569, false);
        mainreplication.BetterEnable(u574, false);
    end));
    _track.add(KatUtil.frame_delay(286, function() -- Line: 6832
        -- upvalues: KatUtil (ref), u571 (copy)
        KatUtil.Emit(u571.Attachment);
    end));
    _track.add(KatUtil.frame_delay(370, function() -- Line: 6836
        -- upvalues: mainreplication (ref)
        mainreplication.newblackscene(1, 5, 2);
    end));
end;

function v1.mvp_isagixhioriMVP(p578) -- Line: 6841
    -- upvalues: vfxUtil (copy), Players (copy), trove (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p578);
    Players:GetPlayerFromCharacter(p578);
    local u579 = trove.new();
    u579:AttachToInstance(p578);
    local isagixhioriMVP = vfxUtil.getResources().mvpAssets.isagixhioriMVP;
    local MoonEffects = vfxUtil.getMoonEffects();
    u579:Add(MoonEffects);
    local u580 = isagixhioriMVP.VFX:Clone();
    u580.Parent = workspace.Effects;
    u580:PivotTo(p578:GetPivot());
    u579:Add(u580);
    local v581 = vfxUtil.newRigForFriend(Root);
    u579:Add(v581);
    v581.Humanoid.Animator:LoadAnimation(isagixhioriMVP.HioriAnimation):Play(0);
    soundUtil:play(isagixhioriMVP.SFX, SoundService);
    local _, v582 = mainreplication.cutsceneCamRigWithLetterBox(Root, isagixhioriMVP.CamAnimation, isagixhioriMVP.FOV, nil, CFrame.new(0, -3, 0), isagixhioriMVP.IsagiXHioriCamera, "camera");

    if v582 then
        u579:Add(v582);
    end;

    local u583 = MoonPropertyAnimator.new();
    u583:LoadSave(isagixhioriMVP.MoonVFX, MoonPropertyAnimator.ConvertSave(isagixhioriMVP.MoonVFX, {
        Vignette = MoonEffects.Vignette
    }));
    u583:PlayAll();
    u579:Add(function() -- Line: 6876
        -- upvalues: u583 (copy)
        u583:Destroy();
    end);
    u579:Add(task.delay(6.417, function() -- Line: 6880
        -- upvalues: u580 (copy), vfxUtil (ref)
        for _, child in u580.END:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
            end;
        end;

        vfxUtil.emitAll(u580.Root);
    end));
    u579:Add(task.delay(9, function() -- Line: 6889
        -- upvalues: mainreplication (ref), u579 (copy)
        mainreplication.blackscene(1);
        task.wait(1);
        u579:Destroy();
    end));
    mainreplication.sceneEnabled(true);
end;

function v1.mvp_finestJolly(p584: any, p585: number, p586: any, p587: table) -- Line: 6898
    -- upvalues: vfxUtil (copy), trove (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), mainreplication (copy)
    local finestJolly = vfxUtil.getResources().mvpAssets.finestJolly;
    local Root = vfxUtil.getRoot(p584);
    local u588 = trove.new();
    local v589 = u588:Construct(vfxUtil.getMoonEffects);
    local v590 = MoonPropertyAnimator.new();
    v590:LoadSave(finestJolly.MoonVFX, MoonPropertyAnimator.ConvertSave(finestJolly.MoonVFX, {
        ["Screen Cover"] = v589["Screen Cover"]
    }));
    v590:PlayAll();
    soundUtil:play(finestJolly.soundmvp, SoundService);

    for i = 2, 4 do
        local v591 = p587[i];
        local v592;

        if v591 then
            local v593 = u588:Construct(finestJolly[`{i - 1}dudesgift`]);
            v593.Weld.Part0 = vfxUtil.getRoot(v591);
            v593.Parent = v591;
            v592 = i;
        else
            v592 = i;
        end;
    end;

    local v594 = u588:Construct(finestJolly.HeadVFX);
    v594.Weld.Part0 = p584:FindFirstChild("Head");
    v594.Parent = p584;
    local v595 = u588:Construct(finestJolly["christmas gift"]);
    v595.Weld.Part0 = p584:FindFirstChild("Right Arm");
    v595.Parent = p584;
    local v596 = u588:Construct(finestJolly["Jolly Snow"]);
    v596.Weld.Part0 = Root;
    v596.Parent = p584;
    local _, v597 = mainreplication.cutsceneCamRigWithLetterBox(Root, finestJolly.Animations.CamAnimation, finestJolly.Animations.FOV, nil, CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0), finestJolly.CamRigWithLetterBox, "camera");

    if v597 then
        u588:Add(v597);
    end;

    u588:Add(task.delay(p585 - 1, mainreplication.blackscene, 1));
    u588:Add(task.delay(p585, function() -- Line: 6941
        -- upvalues: u588 (copy)
        u588:Destroy();
    end));
    mainreplication.sceneEnabled(true);
end;

local function processDescendants(p598: userdata, p599: table) -- Line: 6948
    for _, descendant in p598:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
            p599[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;
end;

local function toggleClouds(p600: boolean) -- Line: 6957
    local Terrain = workspace:FindFirstChild("Terrain");

    if not Terrain then
        return;
    end;

    local Clouds = Terrain:FindFirstChild("Clouds");

    if not Clouds then
        return;
    end;

    Clouds.Enabled = p600;
end;

function v1.mvp_LyxBestRapper(u601: any, u602: number) -- Line: 6965
    -- upvalues: vfxUtil (copy), processDescendants (copy), Lighting (copy), mainreplication (copy), trove (copy), ClockTime2 (copy), Brightness (copy), GeographicLatitude (copy), Ambient (copy), OutdoorAmbient (copy), ExposureCompensation (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), PlayerGui (copy), TweenService (copy)
    local SpringtrapMVP = vfxUtil.getResources().mvpAssets.SpringtrapMVP;
    local Root = vfxUtil.getRoot(u601);
    local u603 = {};
    processDescendants(workspace.map.map, u603);

    for _, child in workspace.characters:GetChildren() do
        if child ~= u601 and (child:FindFirstChild("state") and (child.state:FindFirstChild("ingame") and child.state.ingame.Value)) then
            processDescendants(child, u603);
        end;
    end;

    local Sky = Lighting.Sky;
    Sky.Parent = nil;
    local Atmosphere = Lighting.Atmosphere;
    Atmosphere.Parent = nil;
    local u604 = SpringtrapMVP.Sky:Clone();
    u604.Parent = Lighting;
    local Terrain = workspace:FindFirstChild("Terrain");
    local v605 = Terrain and Terrain:FindFirstChild("Clouds");

    if v605 then
        v605.Enabled = false;
    end;

    mainreplication.EnableMapLights(false);
    mainreplication.stadiumLights(false);
    local u606 = trove.new();
    u606:Add(task.delay(u602 - 1, mainreplication.blackscene, 1));
    u606:Add(task.delay(u602, function() -- Line: 6997
        -- upvalues: u606 (copy)
        u606:Destroy();
    end));
    u606:Add(function() -- Line: 7000
        -- upvalues: u604 (copy), Sky (copy), Lighting (ref), ClockTime2 (ref), Brightness (ref), GeographicLatitude (ref), Ambient (ref), OutdoorAmbient (ref), ExposureCompensation (ref), mainreplication (ref), Atmosphere (copy), u603 (copy)
        u604:Destroy();
        Sky.Parent = Lighting;
        Lighting.ClockTime = ClockTime2;
        Lighting.Brightness = Brightness;
        Lighting.GeographicLatitude = GeographicLatitude;
        Lighting.Ambient = Ambient;
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.ExposureCompensation = ExposureCompensation;
        local Terrain2 = workspace:FindFirstChild("Terrain");
        local v607 = Terrain2 and Terrain2:FindFirstChild("Clouds");

        if v607 then
            v607.Enabled = true;
        end;

        mainreplication.EnableMapLights(true);
        mainreplication.stadiumLights(true);
        Atmosphere.Parent = Lighting;

        for i, v in u603 do
            i.Transparency = v;
        end;
    end);
    local v608 = u606:Construct(vfxUtil.getMoonEffects);
    local u609 = u606:Clone(SpringtrapMVP.Model);
    u609:PivotTo(u601:GetPivot());
    u609.Parent = workspace.Effects;
    u606:Add(task.delay(10.267, function() -- Line: 7024
        -- upvalues: vfxUtil (ref), u609 (copy)
        vfxUtil.forge.emit(u609.VFX.doorOpen);
    end));
    local v610, v611 = mainreplication.cutsceneCamRigWithLetterBox(Root, SpringtrapMVP.Animations.Cam, SpringtrapMVP.FOV, nil, CFrame.new(-0.2, -2.5, -1.193) * CFrame.Angles(0, 3.141592653589793, 0), SpringtrapMVP.Cam, "CamPart");

    if v611 then
        u606:Add(v611);
    end;

    if v610 and v610:FindFirstChild("CamPart") then
        local CamPart = v610.CamPart;
        u606:Add(task.delay(6.45, function() -- Line: 7034
            -- upvalues: vfxUtil (ref), CamPart (copy)
            vfxUtil.forge.emit(CamPart.screeneffects);
        end));
    end;

    Lighting.ClockTime = 23.403;
    Lighting.GeographicLatitude = 79.621;
    Lighting.Brightness = 3;
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ExposureCompensation = 0;

    for _, child in SpringtrapMVP.Lighting:GetChildren() do
        u606:Clone(child).Parent = Lighting;
    end;

    local v612 = {
        ["Screen Cover"] = v608["Screen Cover"],
        Vignette = v608.Vignette,
        Letterbox = v608.Letterbox.Letterbox,
        Workspace = u609
    };
    local v613 = u606:Construct(MoonPropertyAnimator);
    v613:LoadSave(SpringtrapMVP.Moon, MoonPropertyAnimator.ConvertSave(SpringtrapMVP.Moon, v612));
    v613:PlayAll();
    mainreplication.sceneEnabled(true);
    soundUtil:play(SpringtrapMVP.soundmvp, SoundService);
    u606:Add(task.delay(1.685, function() -- Line: 7065
        -- upvalues: TekrinnDialogue (ref), u601 (copy)
        TekrinnDialogue.Speak(u601.Name, {
            {
                Text = "I\'m going to get out..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.203922, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 4
                }
            }
        }, 5, nil, Color3.new(0.333333, 0, 0));
    end));
    u606:Add(task.delay(4.559, function() -- Line: 7089
        -- upvalues: TekrinnDialogue (ref), u601 (copy)
        TekrinnDialogue.Speak(u601.Name, {
            {
                Text = ".. and I\'m going to find you..",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.203922, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 4
                }
            }
        }, 5, nil, Color3.new(0.333333, 0, 0));
    end));
    u606:Add(task.delay(8.091, function() -- Line: 7113
        -- upvalues: TekrinnDialogue (ref), u601 (copy)
        TekrinnDialogue.Speak(u601.Name, {
            {
                Text = ".. and I\'ll give you a ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.203922, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 4
                }
            },
            {
                Text = "real",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 4
                }
            },
            {
                Text = " reason to cry.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.203922, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 4
                }
            }
        }, 4.074, nil, Color3.new(0.333333, 0, 0));
    end));
    local u614 = u606:Clone(SpringtrapMVP.Subtitle);
    u614.Enabled = false;
    u614.Parent = PlayerGui;

    local function updateSubtitles(p615) -- Line: 7179
        -- upvalues: u614 (copy)
        for _, child in u614:GetChildren() do
            if child:IsA("TextLabel") then
                child.Text = p615;
            end;
        end;
    end;

    u606:Add(task.delay(15.114, function() -- Line: 7187
        -- upvalues: u614 (copy), updateSubtitles (copy)
        u614.Enabled = true;
        updateSubtitles("I");
    end));
    u606:Add(task.delay(15.68, updateSubtitles, "ALWAYS"));
    u606:Add(task.delay(16.667, updateSubtitles, "COME"));
    u606:Add(task.delay(17.074, updateSubtitles, "BACK"));
    u606:Add(task.delay(17.7, function() -- Line: 7194
        -- upvalues: u614 (copy), TweenService (ref), u602 (copy)
        for _, child in u614:GetChildren() do
            if child:IsA("TextLabel") then
                TweenService:Create(child, TweenInfo.new(u602 - 17.7), {
                    TextTransparency = 1
                }):Play();
            end;
        end;
    end));
end;

local u616 = nil;

function v1.mvp_Vindication(u617: any, p618: number) -- Line: 7207
    -- upvalues: vfxUtil (copy), soundUtil (copy), SoundService (copy), trove (copy), Lighting (copy), Ambient (copy), OutdoorAmbient (copy), ClockTime2 (copy), ExposureCompensation (copy), mainreplication (copy), u616 (ref), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local Vindication = vfxUtil.getResources().mvpAssets.Vindication;
    local Root = vfxUtil.getRoot(u617);
    soundUtil:play(Vindication.soundmvp, SoundService);
    local u619 = trove.new();
    u619:Add(function() -- Line: 7215
        -- upvalues: Lighting (ref), Ambient (ref), OutdoorAmbient (ref), ClockTime2 (ref), ExposureCompensation (ref), mainreplication (ref)
        Lighting.Ambient = Ambient;
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.ClockTime = ClockTime2;
        Lighting.ExposureCompensation = ExposureCompensation;
        mainreplication.sceneEnabled(false);
    end);
    u619:Add(task.delay(p618 - 1, mainreplication.blackscene, 1));
    u619:Add(task.delay(p618, function() -- Line: 7223
        -- upvalues: u619 (copy)
        u619:Destroy();
    end));
    local _, v620 = mainreplication.cutsceneCamRigWithLetterBox(Root, Vindication.CamAnimation, nil, nil, CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0), Vindication.Cameraa, "CamPart");

    if v620 then
        u619:Add(v620);
    end;

    local v621 = u619:Clone(Vindication.Ambience);
    v621:PivotTo(Root.CFrame);
    v621.Parent = workspace.Effects;
    local v622 = u619:Clone(Vindication.cVFX);
    vfxUtil.setupAura(u617, v622, true);
    v622.Parent = workspace.Effects;
    u616 = u616 or require(Vindication.VFX);

    for _, v in ipairs(u616) do
        u619:Add(task.delay(v[1] / 60, v[2], v622));
    end;

    local v623 = u619:Construct(vfxUtil.getMoonEffects);
    local v624 = {
        Vignette = v623.Vignette,
        ["Screen Cover"] = v623["Screen Cover"],
        CurrentCamera = workspace.CurrentCamera
    };

    for _, child in Vindication.Lighting:GetChildren() do
        local v625 = u619:Clone(child);
        v625.Parent = Lighting;
        v624[child.Name] = v625;
    end;

    local v626 = u619:Construct(MoonPropertyAnimator);
    v626:LoadAndConvertSave(Vindication.Moon, v624);
    v626:PlayAll();
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Lighting.Ambient;
    Lighting.ClockTime = 14.2;
    Lighting.ExposureCompensation = 0;
    mainreplication.sceneEnabled(true);
    u619:Add(task.delay(9.904, function() -- Line: 7267
        -- upvalues: TekrinnDialogue (ref), u617 (copy)
        TekrinnDialogue.Speak(u617.Name, {
            {
                Text = "I..",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 1, 0.666667)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 5, nil, Color3.new(0, 0.121569, 0.0823529));
    end));
    u619:Add(task.delay(11.115, function() -- Line: 7291
        -- upvalues: TekrinnDialogue (ref), u617 (copy)
        TekrinnDialogue.Speak(u617.Name, {
            {
                Text = ".. can still move...",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 1, 0.666667)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 5, nil, Color3.new(0, 0.121569, 0.0823529));
    end));
    u619:Add(task.delay(12.633, function() -- Line: 7315
        -- upvalues: TekrinnDialogue (ref), u617 (copy)
        TekrinnDialogue.Speak(u617.Name, {
            {
                Text = "I\'m fine.",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 1, 0.666667)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 1.3670000000000009, nil, Color3.new(0, 0.121569, 0.0823529));
    end));
end;

function v1.mvp_Brother(p627: any, p628: number) -- Line: 7340
    -- upvalues: vfxUtil (copy), soundUtil (copy), SoundService (copy), trove (copy), PlayerGui (copy), Lighting (copy), TweenService (copy), Ambient (copy), Brightness (copy), ColorShift_Top (copy), EnvironmentDiffuseScale (copy), EnvironmentSpecularScale (copy), OutdoorAmbient (copy), mainreplication (copy), RunService (copy), MoonPropertyAnimator (copy)
    local Brother = vfxUtil.getResources().mvpAssets.Brother;
    local Lighting2 = game:GetService("Lighting");
    local Root = vfxUtil.getRoot(p627);
    soundUtil:play(Brother.soundmvp, SoundService);
    local u629 = trove.new();
    u629:Add(vfxUtil.getScreenDimmer());
    u629:Add(Brother.Vignette:Clone()).Parent = PlayerGui;
    Lighting2.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting2.Brightness = 3;
    Lighting2.ColorShift_Top = Color3.fromRGB(0, 0, 0);
    Lighting2.ColorShift_Bottom = Color3.fromRGB(0, 0, 0);
    Lighting2.EnvironmentDiffuseScale = 1;
    Lighting2.EnvironmentSpecularScale = 1;
    Lighting2.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    local u630 = {};

    for _, child in Lighting:GetChildren() do
        if Brother.Lighting:FindFirstChildWhichIsA(child.ClassName) then
            table.insert(u630, child);
            child.Parent = workspace;
        end;
    end;

    for _, child in Brother.Lighting:GetChildren() do
        local v631 = child:Clone();
        u629:Add(v631);
        v631.Parent = Lighting;
    end;

    u629:Add(function() -- Line: 7378
        -- upvalues: TweenService (ref), Lighting2 (copy), Ambient (ref), Brightness (ref), ColorShift_Top (ref), EnvironmentDiffuseScale (ref), EnvironmentSpecularScale (ref), OutdoorAmbient (ref), mainreplication (ref)
        TweenService:Create(Lighting2, TweenInfo.new(1), {
            Ambient = Ambient,
            Brightness = Brightness,
            ColorShift_Top = ColorShift_Top,
            ColorShift_Bottom = ColorShift_Top,
            EnvironmentDiffuseScale = EnvironmentDiffuseScale,
            EnvironmentSpecularScale = EnvironmentSpecularScale
        }):Play();
        Lighting2.OutdoorAmbient = OutdoorAmbient;
        mainreplication.sceneEnabled(false);
    end);
    u629:Add(task.delay(p628 - 1, mainreplication.blackscene, 1));
    u629:Add(task.delay(p628, function() -- Line: 7392
        -- upvalues: u629 (copy)
        u629:Destroy();
    end));
    local v632 = vfxUtil.newRigForFriend(Root);
    u629:Add(v632);
    v632.Humanoid.Animator:LoadAnimation(Brother.Friend):Play(0);

    for _, descendant in v632:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "none";
        end;
    end;

    local v633, v634 = mainreplication.cutsceneCamRigWithLetterBox(Root, Brother.CamAnimation, Brother.FOV, nil, CFrame.new(0, -3, 0), Brother.Cam3, "CamPart");

    if v634 then
        u629:Add(v634);
    end;

    local u635 = u629:Clone(Brother.VFX);
    u629:Add(RunService.Heartbeat:Connect(function() -- Line: 7414
        -- upvalues: u635 (copy), Root (copy)
        u635:PivotTo(CFrame.lookAt(Root.Position, Root.Position + Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z)));
    end));
    u635.Parent = workspace.Effects;

    for _, v in require(Brother.Module) do
        u629:Add(task.delay(v[1] / 60, v[2], u635, v633));
    end;

    local v636 = u629:Construct(MoonPropertyAnimator);
    v636:LoadAndConvertSave(Brother.Moon, {
        Workspace = u635
    });
    v636:PlayAll();
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Lighting.Ambient;
    Lighting.ClockTime = 14.2;
    Lighting.ExposureCompensation = 0;
    mainreplication.sceneEnabled(true);
    u629:Add(function() -- Line: 7440
        -- upvalues: mainreplication (ref), u630 (copy), Lighting2 (copy)
        mainreplication.sceneEnabled(false);

        for _, v in u630 do
            pcall(function() -- Line: 7443
                -- upvalues: v (copy), Lighting2 (ref)
                v.Parent = Lighting2;
            end);
        end;
    end);
end;

local u637 = {};

for _, child in script.Variants:GetChildren() do
    local v638 = {};

    for _, child2 in child:GetChildren() do
        v638[child2.Name] = require(child2);
    end;

    u637[child.Name] = v638;
end;

function v1.mvp_Shadow(p639: any, p640: number) -- Line: 7465
    -- upvalues: u637 (copy)
    local Shadow = u637.Shadow;
    local v641 = p639:GetAttribute("strike") or 0;
    local v642 = { { 2, "B" }, { 3, "A" }, { 4, "S" } };
    local v643 = "B";

    for _, v in ipairs(v642) do
        if v[1] <= v641 then
            v643 = v[2];
        end;
    end;

    local v644 = Shadow[v643];

    if v644 then
        task.spawn(v644, p639, p640);

        return;
    end;

    for _, v in v642 do
        if Shadow[v] then
            v643 = v;
            break;
        end;
    end;

    task.spawn(Shadow[v643], p639, p640);
end;

function v1.mvp_Sonic(p645: any, p646: number) -- Line: 7496
    -- upvalues: u637 (copy)
    local Sonic = u637.Sonic;
    local v647 = p645:GetAttribute("strike") or 0;
    local v648 = { { 2, "B" }, { 3, "A" }, { 4, "S" } };
    local v649 = "B";

    for _, v in ipairs(v648) do
        if v[1] <= v647 then
            v649 = v[2];
        end;
    end;

    local v650 = Sonic[v649];

    if v650 then
        task.spawn(v650, p645, p646);

        return;
    end;

    for _, v in v648 do
        if Sonic[v] then
            v649 = v;
            break;
        end;
    end;

    task.spawn(Sonic[v649], p645, p646);
end;

function v1.mvp_Pillarman(p651: any, p652: number, p653: any, p654: table, p655: userdata) -- Line: 7527
    -- upvalues: vfxUtil (copy), KatUtil (copy), soundUtil (copy), SoundService (copy), trove (copy), mainreplication (copy), RunService (copy), MoonPropertyAnimator (copy)
    local Pillarman = vfxUtil.getResources().mvpAssets.Pillarman;
    game:GetService("Lighting");
    local _track = KatUtil.get_track(p651, Pillarman.Animations.User);
    local v656 = p654[1];
    local v657 = p654[2];
    local Root = vfxUtil.getRoot(p651);
    Root.Anchored = true;
    soundUtil:play(Pillarman.soundmvp, SoundService);
    local u658 = trove.new();
    u658:Add(vfxUtil.getScreenDimmer());
    local v659 = u658:Add(Pillarman.Emblem:Clone());
    v659.Parent = v656;
    local v660 = u658:Add(Instance.new("Motor6D"));
    v660.Name = "Emblem";
    v660.Part0 = v656.HumanoidRootPart;
    v660.Part1 = v659.Emblem;
    v660.C0 = CFrame.new(0.0774345398, -1.77568316, -0.174770236, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v660.Parent = v656.HumanoidRootPart;
    local v661 = u658:Add(Pillarman["Stone Mask"]:Clone());
    v661.Parent = v657;
    local v662 = u658:Add(Instance.new("Motor6D"));
    v662.Part0 = v657.HumanoidRootPart;
    v662.Part1 = v661["Stone Mask"];
    v662.C0 = CFrame.new(0.241999626, -1.6502862, -0.401698947, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v662.Parent = v657.HumanoidRootPart;
    u658:Add(task.delay(p652 - 1, mainreplication.blackscene, 1));
    u658:Add(task.delay(p652, function() -- Line: 7563
        -- upvalues: u658 (copy)
        u658:Destroy();
    end));
    local _, v663, v664 = mainreplication.cutsceneCamRigWithLetterBox(Root, Pillarman.Animations.CamAnimation, Pillarman.FOV, nil, CFrame.new(0, -3, 0), Pillarman.Cam, "CamPart");

    if v663 then
        u658:Add(v663);
    end;

    if v664 and _track then
        v664.TimePosition = _track.track.TimePosition;
    end;

    local u665 = u658:Clone(Pillarman.Effects);
    u658:Add(RunService.Heartbeat:Connect(function() -- Line: 7577
        -- upvalues: u665 (copy), Root (copy)
        u665:PivotTo(Root.CFrame);
    end));
    u665.Parent = workspace.Effects;

    for _, v in require(Pillarman.Compiled) do
        u658:Add(task.delay(v[1] / 60, v[2], u665, Root));
    end;

    local v666 = {
        Workspace = u665,
        ["Circular Star"] = v659.Emblem["Circular Star"]
    };
    local v667 = u658:Construct(MoonPropertyAnimator);
    v667:LoadAndConvertSave(Pillarman.Moon, v666);
    v667:PlayAll();
    mainreplication.sceneEnabled(true);
    u658:Add(function() -- Line: 7598
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
end;

function v1.mvp_nettspendlisteningparty(u668, p669) -- Line: 7603
    -- upvalues: vfxUtil (copy), mainreplication (copy), trove (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(u668);

    if not Root then
        return;
    end;

    mainreplication.sceneEnabled(true);
    local jimmy1 = vfxUtil.getResources().mvpAssets.jimmy1;
    local u670 = trove.new();
    local v671 = u670:Construct(jimmy1.VFX.Map);
    v671.Parent = workspace.Effects;
    u670:Add(v671);
    soundUtil:play(jimmy1.SFX, soundUtil);
    animationUtil:loadAnimation(v671.Ryuk, jimmy1.Animations.Ryuk):Play(0);
    local _, v672 = mainreplication.cutsceneAll(Root, CFrame.identity, p669, jimmy1.FOV_Yagami, nil, nil, nil, nil, CFrame.new(
        4.32060242,
        -1.00672817,
        -2.30828857,
        0.772743285,
        -0.0072311312,
        0.634676874,
        0.0171988942,
        0.999806106,
        -0.00954911765,
        -0.634485126,
        0.0182947498,
        0.772718489
    ));
    u670:Add(v672);
    vfxUtil.cache_lighting();
    local v673 = u670:Add(vfxUtil.getMoonEffects());
    local v674 = {
        Vignette = v673.Vignette,
        ["Screen Cover"] = v673["Screen Cover"]
    };

    for _, child in jimmy1.VFX.Lighting:GetChildren() do
        local v675 = u670:Clone(child);
        v675.Parent = Lighting;
        v674[child.Name] = v675;
    end;

    u670:Add(vfxUtil.restore_lighting);
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(211, 91, 22);
    Lighting.ClockTime = 16.4;
    u670:Add(vfxUtil.restore_lighting_properties);
    local v676 = u670:Construct(MoonPropertyAnimator);
    v676:LoadAndConvertSave(jimmy1.Moon, v674);
    v676:SetRoot(Root);
    v676:PlayAll();
    vfxUtil.execute_compiled(jimmy1.Compiled, u670, function(p677, p678) -- Line: 7651
        -- upvalues: TekrinnDialogue (ref), u668 (copy)
        TekrinnDialogue.Speak(u668.Name, p677, p678, "rbxassetid://79875821859124", Color3.fromRGB(255, 0, 0));
    end);
    u670:Add(task.delay(p669 - 1, function() -- Line: 7655
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u670:Add(task.delay(p669, function() -- Line: 7659
        -- upvalues: u670 (copy)
        u670:Destroy();
    end));
end;

function v1.mvp_remmyava(p679, p680) -- Line: 7664
    -- upvalues: vfxUtil (copy), mainreplication (copy), trove (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p679);

    if not Root then
        return;
    end;

    mainreplication.sceneEnabled(true);
    local remmyava = vfxUtil.getResources().mvpAssets.remmyava;
    local u681 = trove.new();
    soundUtil:play(remmyava.SFX, soundUtil);
    local _, v682 = mainreplication.cutsceneBlender(Root, remmyava.Animations.Camera, remmyava.FOV_APT, nil, nil, CFrame.new(0, -3, 0) * CFrame.Angles(0, -1.5707963267948966, 0));
    u681:Add(v682);
    vfxUtil.cache_lighting();
    local v683 = {
        ["Screen Cover"] = u681:Add(vfxUtil.getMoonEffects())["Screen Cover"]
    };

    for _, child in remmyava.VFX.Lighting:GetChildren() do
        local v684 = u681:Clone(child);
        v684.Parent = Lighting;
        v683[child.Name] = v684;
    end;

    u681:Add(vfxUtil.restore_lighting);
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ClockTime = 19;
    Lighting.ShadowSoftness = 0.2;
    u681:Add(vfxUtil.restore_lighting_properties);
    local v685 = u681:Construct(MoonPropertyAnimator);
    v685:LoadAndConvertSave(remmyava.Moon, v683);
    v685:SetRoot(Root);
    v685:PlayAll();
    u681:Add(task.delay(p680 - 1, function() -- Line: 7709
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u681:Add(task.delay(p680, function() -- Line: 7713
        -- upvalues: u681 (copy)
        u681:Destroy();
    end));
end;

function v1.mvp_nightRaiders(u686, p687, p688, p689) -- Line: 7718
    -- upvalues: vfxUtil (copy), mainreplication (copy), trove (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(u686);

    if not Root then
        return;
    end;

    mainreplication.sceneEnabled(true);
    local nightRaiders = vfxUtil.getResources().mvpAssets.nightRaiders;
    local u690 = trove.new();
    local v691 = u690:Construct(nightRaiders.VFX.Map);
    v691.Parent = workspace.Effects;
    u690:Add(v691);
    soundUtil:play(nightRaiders.SFX, soundUtil);
    local _, v692 = mainreplication.cutsceneBlender(Root, nightRaiders.Animations.Camera, nightRaiders.FOV_NightRaider, nil, nil, CFrame.new(0, -3, 0));
    u690:Add(v692);
    vfxUtil.cache_lighting();
    local v693 = {
        Lighting = Lighting,
        Workspace = v691,
        ["Screen Cover"] = u690:Add(vfxUtil.getMoonEffects())["Screen Cover"]
    };

    for _, child in nightRaiders.VFX.Lighting:GetChildren() do
        local v694 = u690:Clone(child);
        v694.Parent = Lighting;
        v693[child.Name] = v694;
    end;

    for _, v in p689 do
        u690:Clone(nightRaiders.VFX.Highlight).Parent = v;
    end;

    u690:Add(vfxUtil.restore_lighting);
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ClockTime = 14.5;
    Lighting.ShadowSoftness = 0.2;
    Lighting.Sky.MoonAngularSize = 0;
    u690:Add(vfxUtil.restore_lighting_properties);
    local v695 = u690:Construct(MoonPropertyAnimator);
    v695:LoadAndConvertSave(nightRaiders.Moon, v693);
    v695:SetOriginalRoot(CFrame.new(0, 3, 0) * CFrame.Angles(0, 3.141592653589793, 0));
    v695:SetRoot(Root);
    v695:PlayAll();
    vfxUtil.execute_compiled(nightRaiders.Compiled, u690, function(p696, p697) -- Line: 7774
        -- upvalues: TekrinnDialogue (ref), u686 (copy)
        TekrinnDialogue.Speak(u686, p696, p697);
    end);
    u690:Add(task.delay(p687 - 1, function() -- Line: 7778
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u690:Add(task.delay(p687, function() -- Line: 7782
        -- upvalues: u690 (copy)
        u690:Destroy();
    end));
end;

function v1.mvp_aikuMVP(p698, p699, p700, u701) -- Line: 7787
    -- upvalues: vfxUtil (copy), KatUtil (copy), mainreplication (copy), trove (copy), soundUtil (copy), TekrinnDialogue (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p698);

    if not Root then
        return;
    end;

    local aikuMVP = vfxUtil.getResources().mvpAssets.aikuMVP;
    local _track = KatUtil.get_track(p698, aikuMVP.Animations.User);
    mainreplication.sceneEnabled(true);
    local u702 = trove.new();
    local v703 = u702:Clone(aikuMVP.VFX.VFX);
    v703:PivotTo(Root.CFrame * CFrame.new(0, 20, 0));
    v703.Parent = workspace.Effects;
    v703.FakeheadV.Weld.Part0 = u701[1].Head;
    vfxUtil.setupAura(p698, v703.IsagiAura, true);
    vfxUtil.setupAura(u701[1], v703.AikuAura, true);
    local _baseplate_controller, u704 = vfxUtil.get_baseplate_controller();
    u702:Add(function() -- Line: 7810
        -- upvalues: u704 (copy), _baseplate_controller (copy)
        u704.Transparency = 0;
        _baseplate_controller.update();
    end);
    local v705, v706, u707 = mainreplication.cutsceneCamRigWithLetterBox(Root, aikuMVP.Animations.Camera, aikuMVP.FOV_Aiku, nil, CFrame.new(0, -3, 0), aikuMVP.blenderCam, "CamPart");
    u702:Add(task.delay(0.5, function() -- Line: 7826
        -- upvalues: _track (copy), u707 (copy), u701 (copy), KatUtil (ref), aikuMVP (copy)
        if _track and _track.track then
            u707.TimePosition = _track.track.TimePosition;

            for i, v in u701 do
                local v708 = i > 1 and tostring(i - 1) or "Enemy";
                local _track2 = KatUtil.get_track(v, v708 == "Enemy" and aikuMVP.Animations.Enemy or aikuMVP.Animations.Victims[v708]);

                if _track2 and _track2.track then
                    _track2.track.TimePosition = _track.track.TimePosition;
                end;
            end;
        end;
    end));
    soundUtil:play(aikuMVP.SFX, soundUtil);
    vfxUtil.execute_compiled(aikuMVP.Compiled, u702, v703, function(p709) -- Line: 7843
        -- upvalues: u704 (copy), _baseplate_controller (copy)
        u704.Transparency = p709;
        _baseplate_controller.update();
    end, function(p710, p711) -- Line: 7847
        -- upvalues: TekrinnDialogue (ref), u701 (copy)
        TekrinnDialogue.Speak(u701[1], p710, p711);
    end);
    u702:Add(v706);
    v703.CamVFX.Weld.Part1 = v705.CamPart;
    vfxUtil.cache_lighting();
    local u712 = {
        Lighting = Lighting
    };
    u702:Add(task.spawn(function() -- Line: 7864
        -- upvalues: aikuMVP (copy), u702 (copy), Lighting (ref), u712 (copy)
        for _, child in aikuMVP.VFX.Lighting:GetChildren() do
            local v713 = u702:Clone(child);
            v713.Parent = Lighting;
            u712[child.Name] = v713;
        end;
    end));
    u702:Add(vfxUtil.restore_lighting);
    Lighting.GeographicLatitude = 201;
    Lighting.ExposureCompensation = 0.15;
    u702:Add(vfxUtil.restore_lighting_properties);
    local v714 = u702:Construct(MoonPropertyAnimator);
    v714:LoadAndConvertSave(aikuMVP.Moon, u712);
    v714:SetOriginalRoot(CFrame.new(0, 3, 0));
    v714:SetRoot(Root);
    v714:PlayAll();
    u702:Add(task.delay(p699 - 1, function() -- Line: 7888
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u702:Add(task.delay(p699, function() -- Line: 7892
        -- upvalues: mainreplication (ref), u702 (copy)
        mainreplication.fov(false, 70);
        u702:Destroy();
    end));
end;

function v1.mvp_Ubers(p715: any, p716: number, p717: any, p718: table, p719: userdata) -- Line: 7900
    -- upvalues: vfxUtil (copy), KatUtil (copy), soundUtil (copy), SoundService (copy), trove (copy), mainreplication (copy), MoonPropertyAnimator (copy)
    local Ubers = vfxUtil.getResources().mvpAssets.Ubers;
    game:GetService("Lighting");
    local _track = KatUtil.get_track(p715, Ubers.Animations.User);
    local Root = vfxUtil.getRoot(p715);
    Root.Anchored = true;
    soundUtil:play(Ubers.soundmvp, SoundService);
    local u720 = trove.new();
    u720:Add(vfxUtil.getScreenDimmer());
    local v721 = u720:Construct(Ubers.Barou);
    vfxUtil.setupAura(p715, v721, true, true);
    v721.Parent = workspace.Effects;
    u720:Add(task.delay(p716 - 1, mainreplication.blackscene, 1));
    u720:Add(task.delay(p716, function() -- Line: 7920
        -- upvalues: u720 (copy)
        u720:Destroy();
    end));
    local v722, v723, v724 = mainreplication.cutsceneCamRigWithLetterBox(Root, Ubers.Animations.CamAnimation, Ubers.FOV, nil, CFrame.new(0, -3, 0), Ubers.Cam3, "CamPart");

    if v723 then
        u720:Add(v723);
    end;

    if v724 and _track then
        v724.TimePosition = _track.track.TimePosition;
    end;

    local v725 = u720:Clone(Ubers.Transiton);
    v725.Parent = workspace.Effects;

    for _, v in require(Ubers.Compiled) do
        u720:Add(task.delay(v[1] / 60, v[2], p715, v721, v722, v725));
    end;

    local v726 = {
        Vignette = u720:Add(vfxUtil.getMoonEffects()).Vignette,
        Lighting = game:GetService("Lighting")
    };

    if Ubers:FindFirstChild("Lighting") then
        vfxUtil.cutscene_lighting(u720, v726, Ubers.Lighting, {
            Brightness = 3,
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            GlobalShadows = true,
            ShadowSoftness = 0.2,
            ExposureCompensation = 0,
            ClockTime = 14.5,
            GeographicLatitude = 0,
            Ambient = Color3.fromRGB(70, 70, 70),
            ColorShift_Top = Color3.new(0, 0, 0),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        });
    end;

    local v727 = u720:Construct(MoonPropertyAnimator);
    v727:LoadAndConvertSave(Ubers.Moon, v726);
    v727:PlayAll();
    mainreplication.sceneEnabled(true);
    u720:Add(function() -- Line: 7971
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
end;

function v1.mvp_ryuvsyuta(u728: userdata, p729: number, p730: any, p731: table) -- Line: 7976
    -- upvalues: vfxUtil (copy), mainreplication (copy), animationUtil (copy), Lighting (copy), Players (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local ryuvsyuta = vfxUtil.getResources().mvpAssets.ryuvsyuta;
    local u732 = vfxUtil.mvp_cutscene_defaults(mainreplication, p729);
    local Root = vfxUtil.getRoot(u728);
    u732:Add(function() -- Line: 7981
        -- upvalues: vfxUtil (ref)
        vfxUtil.restore_lighting();
    end);
    local _, v733 = mainreplication.cutsceneCamRigWithLetterBox(Root, ryuvsyuta.Camera, ryuvsyuta.FOV, nil, "default", ryuvsyuta.Cam3, "CamPart");
    u732:Add(v733);
    local v734 = u732:Clone(ryuvsyuta.VFX);
    v734:PivotTo(u728:GetPivot());
    v734.Parent = workspace.Effects;
    animationUtil:loadAnimation(v734:FindFirstChild("Rika"), ryuvsyuta.Rika):Play(0);
    local v735 = u732:Add(vfxUtil.getMoonEffects());
    local v736 = {
        Vignette = v735.Vignette,
        ["Screen Cover"] = v735["Screen Cover"],
        Lighting = Lighting,
        Workspace = v734
    };

    if p731 then
        p731 = p731[1];
    end;

    local v737;

    if p731 then
        v737 = Players:GetPlayerFromCharacter(p731);
    else
        v737 = p731;
    end;

    local u738 = v737 and v737.DisplayName or (p731 and p731.Name or "Okkotsu");
    u732:Add(task.delay(6.5, function() -- Line: 8008
        -- upvalues: u732 (copy), TekrinnDialogue (ref), u738 (copy)
        u732:Add(TekrinnDialogue.Speak(u738, {
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
    u732:Add(task.delay(16, function() -- Line: 8047
        -- upvalues: u732 (copy), TekrinnDialogue (ref), u728 (copy), u738 (copy)
        u732:Add(TekrinnDialogue.Speak(u728, {
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
                Text = `{string.upper(u738)}!!`,
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
    vfxUtil.contain_lighting(u732, v736, ryuvsyuta.Lighting);
    local v739 = u732:Construct(MoonPropertyAnimator);
    v739:LoadAndConvertSave(ryuvsyuta.Moon, v736);
    v739:SetOriginalRoot(CFrame.new(0, 3, 0));
    v739:SetRoot(Root);
    v739:PlayAll();
    vfxUtil.execute_compiled(ryuvsyuta.Compiled, u732, v734);
    soundUtil:play(ryuvsyuta.soundmvp, "default");
end;

function v1.mvp_polyester(p740: userdata, p741: number, p742: any, p743: table) -- Line: 8098
    -- upvalues: vfxUtil (copy), mainreplication (copy), animationUtil (copy), ReplicatedStorage2 (copy), PlayerGui (copy), Util (copy), RunService (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local polyester = vfxUtil.getResources().mvpAssets.polyester;
    local u744 = vfxUtil.mvp_cutscene_defaults(mainreplication, p741);
    local Root = vfxUtil.getRoot(p740);
    local u745 = u744:Add(polyester.background:Clone());
    u745.Parent = p740;
    u745.CanCollide = false;
    u745.Massless = true;
    u745.CFrame = Root.CFrame;
    local v746 = u744:Add(Instance.new("Motor6D"));
    v746.Parent = Root;
    v746.Part0 = v746.Parent;
    v746.Part1 = u745;
    u744:Add(animationUtil:loadAnimation(p740, polyester.Animations.User), "Stop", 0):Play(0);
    local v747 = u744:Add(ReplicatedStorage2.Resources.Ball:Clone());
    v747.ball.Part0 = Root;
    v747.Parent = p740;
    local _, v748 = mainreplication.cutsceneCamRigWithLetterBox(Root, polyester.Animations.Cam, polyester.FOV, nil, CFrame.identity, polyester.CameraRig, "CamPart");
    u744:Add(v748);
    local v749 = u744:Add(polyester.UIs.polyesterframe:Clone());
    v749.Parent = PlayerGui;
    local v750 = u744:Add(polyester.UIs.polyesterframe2:Clone());
    v750.Parent = PlayerGui;
    task.spawn(function() -- Line: 8131
        -- upvalues: Util (ref), RunService (ref), u745 (copy), u744 (copy)
        local u751 = 0;
        local u752 = 0;
        local u753 = 0;

        if not Util.isepilepsysafe() then
            local u754 = nil;
            u754 = RunService.RenderStepped:Connect(function(p755) -- Line: 8140
                -- upvalues: u753 (ref), u754 (ref), u752 (ref), u751 (ref), u745 (ref)
                u753 = u753 + p755;

                if u753 >= 11 then
                    u754:Disconnect();
                    u754 = nil;
                end;

                u752 = u752 + p755;

                if u752 >= 0.02857142857142857 then
                    u752 = u752 - 0.02857142857142857;
                    u751 = u751 + 1;

                    if not u745:FindFirstChild((tostring(u751))) then
                        u751 = 1;
                    end;

                    local v756 = u745:FindFirstChild((tostring(u751)));

                    for _, child in u745:GetChildren() do
                        child.Transparency = child == v756 and 0 or 1;
                    end;
                end;
            end);
            u744:Add(u754);
        end;
    end);
    local v757 = u744:Construct(MoonPropertyAnimator);
    v757:LoadAndConvertSave(polyester.Moon, {
        background = u745
    });
    v757:SetRoot(Root);
    v757:PlayAll();
    vfxUtil.execute_compiled(polyester.Compiled, u744, u745, v749, v750);
    soundUtil:play(polyester.soundmvp, "default");
end;

for i, v in require(script.Extended) do
    v1[i] = v;
end;

return v1;