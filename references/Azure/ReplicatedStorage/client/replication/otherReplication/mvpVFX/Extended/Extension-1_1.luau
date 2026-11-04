 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local trove = require(ReplicatedStorage.forum.trove);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local mvpAssets = vfxUtil.getResources().mvpAssets;
local PlayerGui = vfxUtil.getPlayerGui();
local _ = Players.LocalPlayer;
local Ambient = Lighting.Ambient;
local OutdoorAmbient = Lighting.OutdoorAmbient;
local ExposureCompensation = Lighting.ExposureCompensation;
local ClockTime = Lighting.ClockTime;
local v20 = {
    mvp_allOutAttack = function(p1: any, p2: number) -- Line: 29, Name: mvp_allOutAttack
        -- upvalues: mvpAssets (copy), vfxUtil (copy), trove (copy), Lighting (copy), ClockTime (copy), Ambient (copy), OutdoorAmbient (copy), ExposureCompensation (copy), mainreplication (copy), animationUtil (copy), PlayerGui (copy), MoonPropertyAnimator (copy), soundUtil (copy)
        local AllOutAttack = mvpAssets.AllOutAttack;
        local Root = vfxUtil.getRoot(p1);
        local u3 = trove.new();
        u3:Add(function() -- Line: 34
            -- upvalues: Lighting (ref), ClockTime (ref), Ambient (ref), OutdoorAmbient (ref), ExposureCompensation (ref)
            Lighting.ClockTime = ClockTime;
            Lighting.Ambient = Ambient;
            Lighting.OutdoorAmbient = OutdoorAmbient;
            Lighting.ExposureCompensation = ExposureCompensation;
        end);
        u3:Add(task.delay(p2 - 0.5, function() -- Line: 40
            -- upvalues: mainreplication (ref)
            mainreplication.blackscene(0.5);
        end));
        u3:Add(task.delay(p2, function() -- Line: 43
            -- upvalues: u3 (copy)
            u3:Destroy();
        end));
        mainreplication.sceneEnabled(true);
        Lighting.Ambient = Color3.new(0, 0, 0);
        Lighting.OutdoorAmbient = Color3.new(0, 0, 0);
        Lighting.ExposureCompensation = 0;
        local u4 = u3:Add(Instance.new("Highlight"));
        u4.Enabled = false;
        u4.FillColor = Color3.fromRGB(48, 111, 117);
        u4.FillTransparency = 555;
        u4.OutlineColor = Color3.new(1, 1, 1);
        u4.OutlineTransparency = 0.01;
        u4.Parent = p1;

        for _, child in AllOutAttack.Highlight:GetChildren() do
            child:Clone().Parent = u4;
        end;

        local u5 = u3:Clone(AllOutAttack.Attachment);
        u5.Parent = Root;
        local u6 = u3:Clone(AllOutAttack.VFX);
        u6:PivotTo(Root.CFrame);
        u6.Parent = workspace.Effects;
        local u7 = u3:Clone(AllOutAttack.Star);
        u7:PivotTo(Root.CFrame);
        u7.Plane.Transparency = 1;
        u7.Parent = workspace.Effects;
        animationUtil:loadAnimation(u7, AllOutAttack.Animation):Play(0);
        local v8 = u3:Clone(AllOutAttack.ScreenGui);
        v8.Parent = PlayerGui;
        u3:Add(mainreplication.kuronaCam(Root, AllOutAttack.Cam, AllOutAttack.FOV));
        local v9 = u3:Construct(MoonPropertyAnimator);
        v9:LoadAndConvertSave(AllOutAttack.Moon, {
            ScreenGui = v8,
            Lighting = Lighting
        });
        v9:PlayAll();
        task.defer(function() -- Line: 91
            -- upvalues: u6 (copy)
            shared.vfx.emit(u6.Balls);
        end);
        u3:Add(task.delay(1.6, function() -- Line: 95
            -- upvalues: u4 (copy), u5 (copy), u6 (copy)
            shared.vfx.emit(u4, u5, u6.Splashes);
        end));
        u3:Add(task.delay(1.567, function() -- Line: 99
            -- upvalues: u7 (copy)
            u7.Plane.Transparency = 0;
        end));
        soundUtil:play(AllOutAttack.SFX, soundUtil);
    end,

    mvp_caught = function(p10: any, p11: number) -- Line: 106, Name: mvp_caught
        -- upvalues: mvpAssets (copy), vfxUtil (copy), trove (copy), Lighting (copy), Ambient (copy), OutdoorAmbient (copy), ClockTime (copy), mainreplication (copy), MoonPropertyAnimator (copy), soundUtil (copy), TweenService (copy)
        local Caught = mvpAssets.Caught;
        local Root = vfxUtil.getRoot(p10);
        local u12 = {};

        for _, descendant in workspace.map:GetDescendants() do
            if descendant:IsA("BasePart") and descendant.Transparency < 1 then
                u12[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;

        local u13 = trove.new();
        u13:Add(function() -- Line: 120
            -- upvalues: Lighting (ref), Ambient (ref), OutdoorAmbient (ref), ClockTime (ref), u12 (copy)
            Lighting.Ambient = Ambient;
            Lighting.OutdoorAmbient = OutdoorAmbient;
            Lighting.ClockTime = ClockTime;

            for i, v in u12 do
                i.Transparency = v;
            end;
        end);
        u13:Add(task.delay(p11 - 1, function() -- Line: 128
            -- upvalues: mainreplication (ref)
            mainreplication.blackscene(1);
        end));
        u13:Add(task.delay(p11, function() -- Line: 131
            -- upvalues: u13 (copy)
            u13:Destroy();
        end));
        mainreplication.sceneEnabled(true);
        Lighting.ClockTime = 1;
        Lighting.Ambient = Color3.new(0, 0, 0);
        Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
        local u14 = u13:Clone(Caught.VFX);
        u14:PivotTo(Root.CFrame);
        u14.Parent = workspace.Effects;
        vfxUtil.setupAura(p10, u14.NotYrize, true);
        local _, v15 = mainreplication.cutsceneCamRigWithLetterBox(Root, Caught.CamAnimation, Caught.FOV, u14, CFrame.identity, Caught.HumanoidCameraRig, "Torso");

        if v15 then
            u13:Add(v15);
        end;

        local v16 = u13:Add(vfxUtil.getMoonEffects());
        local v17 = {
            Vignette = v16.Vignette,
            Letterbox = v16.Letterbox.Letterbox
        };

        for _, child in Caught.Lighting:GetChildren() do
            u13:Clone(child).Parent = Lighting;
            v17[child.Name] = child;
        end;

        local v18 = u13:Construct(MoonPropertyAnimator);
        v18:LoadAndConvertSave(Caught.Moon, v17);
        v18:PlayAll();
        u13:Add(task.delay(5.933333333333334, function() -- Line: 164
            -- upvalues: u14 (copy)
            shared.vfx.emit(u14.NotYrize.Head.Flare);
        end));
        u13:Add(task.delay(16.566666666666666, function() -- Line: 168
            -- upvalues: u14 (copy)
            shared.vfx.emit(u14.NotYrize.Head.Flare2);
        end));
        u13:Add(task.delay(21.916666666666668, function() -- Line: 172
            -- upvalues: u14 (copy)
            shared.vfx.emit(u14.NotYrize.Head["Flare Final"]);
        end));
        local u19 = soundUtil:play(Caught.SFX, soundUtil);
        u13:Add(function() -- Line: 177
            -- upvalues: TweenService (ref), u19 (copy)
            TweenService:Create(u19, TweenInfo.new(2), {
                Volume = 0
            }):Play();
        end);
    end
};
local u21 = nil;

function v20.mvp_broly(p22: any, p23: number) -- Line: 184
    -- upvalues: mvpAssets (copy), vfxUtil (copy), trove (copy), mainreplication (copy), Lighting (copy), MoonPropertyAnimator (copy), u21 (ref), soundUtil (copy)
    local Broly = mvpAssets.Broly;
    local Root = vfxUtil.getRoot(p22);
    local u24 = trove.new();
    u24:Add(task.delay(p23 - 1, function() -- Line: 189
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u24:Add(task.delay(p23, function() -- Line: 192
        -- upvalues: u24 (copy)
        u24:Destroy();
    end));
    mainreplication.sceneEnabled(true);
    local v25 = u24:Add(Instance.new("Highlight"));
    v25.FillColor = Color3.new(0, 0, 0);
    v25.FillTransparency = 0.1;
    v25.OutlineColor = Color3.new(0, 0, 0);
    v25.OutlineTransparency = 0;
    v25.Parent = p22;
    local v26 = u24:Clone(Broly.VFX);
    v26:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p22, v26.Broly, true);
    v26.Parent = workspace.Effects;
    local _, v27 = mainreplication.cutsceneCamRigWithLetterBox(Root, Broly.CamAnimation, Broly.FOV, v26, CFrame.new(-0.0519511625, -3.0433495, -2.1708715), Broly.BrolyCam);

    if v27 then
        u24:Add(v27);
    end;

    local v28 = u24:Add(vfxUtil.getMoonEffects());
    local v29 = {
        Vignette = v28.Vignette,
        Letterbox = v28.Letterbox.Letterbox,
        ["Screen Cover"] = v28["Screen Cover"],
        Workspace = v26,
        Highlight = v25
    };

    for _, child in Broly.Lighting:GetChildren() do
        u24:Clone(child).Parent = Lighting;
        v29[child.Name] = child;
    end;

    local v30 = u24:Construct(MoonPropertyAnimator);
    v30:LoadAndConvertSave(Broly.Moon, v29);
    v30:SetOriginalRoot(Broly.VFX.Root.CFrame);
    v30:SetRoot(Root);
    v30:PlayAll();

    if not u21 then
        u21 = require(Broly.Compiled);
    end;

    for _, v in u21 do
        u24:Add(task.delay(v[1] / 60, v[2], v26));
    end;

    local Children = Broly.SFX[p22:GetAttribute("RinNoPlay") and "RinNoPlay" or "Normal"]:GetChildren();
    soundUtil:play(Children[math.random(#Children)], soundUtil);
end;

function v20.mvp_yakuzaMVP(p31: any, p32: number) -- Line: 244
    -- upvalues: mvpAssets (copy), vfxUtil (copy), KatUtil (copy), soundUtil (copy), mainreplication (copy), MoonPropertyAnimator (copy), Lighting (copy)
    local yakuza = mvpAssets.yakuza;
    local Root = vfxUtil.getRoot(p31);
    local _track = KatUtil.get_track(p31, yakuza.Animation);
    soundUtil:play(yakuza.SFX, soundUtil);

    if not _track then
        return;
    end;

    local u33, v34 = mainreplication.cutsceneCamRigWithLetterBox(Root, yakuza.Camera, yakuza.FOV, nil, CFrame.new(
        0.000564575195,
        -2.95587158,
        -0.0000686645508,
        -0.999996781,
        0,
        -0.00253728032,
        0,
        0.99999994,
        0,
        0.00253728032,
        0,
        -0.999996781
    ), yakuza.HumanoidCameraRig, "Torso");

    if v34 then
        _track.add(v34);
    end;

    local u35 = _track.add(vfxUtil.createVFX(yakuza.Body["Right Leg"], "default", p31["Left Arm"]));
    local u36 = _track.add(vfxUtil.createVFX(yakuza.Body["Left Leg"], "default", p31["Right Leg"]));
    local u37 = _track.add(vfxUtil.createVFX(yakuza.Body.Torso, "default", p31.Torso));
    local u38 = _track.add(vfxUtil.getMoonEffects());
    local u39 = _track.construct(MoonPropertyAnimator);

    local function apply_lighting() -- Line: 267
        -- upvalues: Lighting (ref), yakuza (copy), u39 (copy), u38 (copy)
        local Children = Lighting:GetChildren();
        local u40 = {};
        local u41 = {};

        for _, v in Children do
            v.Parent = nil;
        end;

        for _, child in yakuza.Lighting:GetChildren() do
            local v42 = child:Clone();
            v42.Parent = Lighting;
            table.insert(u40, v42);
        end;

        for i, v in yakuza.Lighting:GetAttributes() do
            u41[i] = Lighting[i];
            Lighting[i] = v;
        end;

        u39:LoadAndConvertSave(yakuza.Moon, {
            Vignette = u38.Vignette,
            Blur = u40.Blur,
            ColorCorrection = u40.ColorCorrection
        });

        return function() -- Line: 294
            -- upvalues: u41 (copy), Lighting (ref), Children (copy), u40 (copy)
            for i, v in u41 do
                Lighting[i] = v;
                u41[i] = nil;
            end;

            for _, v in Children do
                v.Parent = Lighting;
            end;

            for _, v in u40 do
                v:Destroy();
            end;
        end;
    end;

    workspace.CurrentCamera.FieldOfView = 16;
    mainreplication.sceneEnabled(true);
    KatUtil.Enable(u33, "Beam,Trail", true);
    _track.add((apply_lighting()));
    _track.add(function() -- Line: 314
        -- upvalues: mainreplication (ref)
        workspace.CurrentCamera.FieldOfView = 70;
        mainreplication.sceneEnabled(false);
    end);
    KatUtil.Emit(u35);
    _track.sequence({
        [86] = function() -- Line: 321
            -- upvalues: KatUtil (ref), u35 (copy)
            KatUtil.Emit(u35);
        end,

        [110] = function() -- Line: 325
            -- upvalues: KatUtil (ref), u36 (copy)
            KatUtil.Emit(u36);
        end,

        [129] = function() -- Line: 329
            -- upvalues: KatUtil (ref), u35 (copy)
            KatUtil.Emit(u35);
        end,

        [142] = function() -- Line: 333
            -- upvalues: KatUtil (ref), u37 (copy)
            KatUtil.Emit(u37);
        end,

        [284] = function() -- Line: 337
            -- upvalues: KatUtil (ref), u33 (copy)
            KatUtil.Enable(u33, "ParticleEmitter", true);
        end,

        [301] = function() -- Line: 341
            -- upvalues: mainreplication (ref)
            mainreplication.newblackscene(0.75, 1, 3);
        end
    });
end;

local u43 = nil;

function v20.mvp_executedOLD(p44: any, p45: number) -- Line: 349
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), trove (copy), PlayerGui (copy), Lighting (copy), u43 (ref), MoonPropertyAnimator (copy), soundUtil (copy)
    local executedOld = mvpAssets.executedOld;
    local Root = vfxUtil.getRoot(p44);
    local _baseplate_controller, u46 = vfxUtil.get_baseplate_controller();
    local u47 = vfxUtil.make_baseplate_connection(_baseplate_controller.update);
    mainreplication.sceneEnabled(true);
    local u48 = trove.new();
    u48:Add(vfxUtil.getScreenDimmer());
    u48:Add(function() -- Line: 360
        -- upvalues: u46 (copy), _baseplate_controller (copy), u47 (copy)
        u46.Transparency = 0;
        _baseplate_controller.update();
        u47:Disconnect();
    end);
    u48:Add(task.delay(p45 - 1, function() -- Line: 365
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u48:Add(task.delay(p45, function() -- Line: 368
        -- upvalues: u48 (copy)
        u48:Destroy();
    end));
    local v49 = u48:Clone(executedOld.AllVFX);
    v49:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p44, v49.aa.KaiserExecuted.Kaiser, true);
    v49.Parent = workspace.Effects;
    local v50 = u48:Clone(executedOld.VignetteGui);
    v50.Parent = PlayerGui;
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ExposureCompensation = 0;
    Lighting.ClockTime = 14.5;
    Lighting.GeographicLatitude = 0;
    u48:Add(vfxUtil.restore_lighting_properties);
    vfxUtil.cache_lighting();
    u48:Add(vfxUtil.restore_lighting);
    local v51 = {
        Workspace = v49,
        VignetteGui = v50,
        Baseplate = u46
    };

    for _, child in executedOld.Lighting:GetChildren() do
        local v52 = u48:Clone(child);
        v52.Parent = Lighting;
        v51[child.Name] = v52;
    end;

    if not u43 then
        u43 = require(executedOld.compiled_all);
    end;

    for _, v in ipairs(u43) do
        u48:Add(task.delay(v[1] / 60, v[2], v49));
    end;

    local v53 = u48:Construct(MoonPropertyAnimator);
    v53:LoadAndConvertSave(executedOld.Moon, v51);
    v53:SetOriginalRoot(executedOld.AllVFX:GetPivot());
    v53:SetRoot(Root);
    v53:PlayAll();
    local _, v54 = mainreplication.cutsceneCamRigWithLetterBox(Root, executedOld.CamAnimation, executedOld.FOV, nil, executedOld.AllVFX.aa.KaiserExecuted.Kaiser.HumanoidRootPart.CFrame:ToObjectSpace(executedOld.HumanoidCameraRig.RootPart.CFrame), executedOld.HumanoidCameraRig, "Torso");
    u48:Add(v54);
    soundUtil:play(executedOld.soundmvp, soundUtil);
end;

function v20.mvp_kiyoraMvp(p55: any, p56: number) -- Line: 424
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), trove (copy), Lighting (copy), animationUtil (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local KiyoraMvpV2 = mvpAssets.KiyoraMvpV2;
    local Root = vfxUtil.getRoot(p55);
    mainreplication.sceneEnabled(true);
    local u57 = trove.new();
    u57:Add(vfxUtil.getScreenDimmer());
    u57:Add(task.delay(p56 - 1, function() -- Line: 432
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u57:Add(task.delay(p56, function() -- Line: 435
        -- upvalues: u57 (copy)
        u57:Destroy();
    end));
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ShadowSoftness = 0.2;
    Lighting.ClockTime = 14.5;
    u57:Add(vfxUtil.restore_lighting_properties);
    local v58 = u57:Clone(KiyoraMvpV2.ScreenGui);
    local v59 = u57:Clone(KiyoraMvpV2.VFX);
    v59:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p55, v59.User, true);
    v59.Parent = workspace.Effects;
    local v60 = {
        Lighting = Lighting,
        ScreenGui = v58,
        Workspace = v59
    };
    vfxUtil.cache_lighting();

    for _, child in KiyoraMvpV2.Lighting:GetChildren() do
        local v61 = u57:Clone(child);
        v61.Parent = Lighting;
        v60[child.Name] = v61;
    end;

    u57:Add(vfxUtil.restore_lighting);
    local _, v62 = mainreplication.cutsceneCamRigWithLetterBox(Root, KiyoraMvpV2.CamAnimation, KiyoraMvpV2.FOV, nil, CFrame.new(0, -3, 0), KiyoraMvpV2.Cam, "CamPart");
    u57:Add(v62);
    animationUtil:loadAnimation(v59["Kiyora JUGEMENT"], KiyoraMvpV2.Balance):Play(0);
    local v63 = u57:Construct(MoonPropertyAnimator);
    v63:LoadAndConvertSave(KiyoraMvpV2.Moon, v60);
    v63:SetOriginalRoot(KiyoraMvpV2.VFX.Core.CFrame);
    v63:SetRoot(Root);
    v63:PlayAll();
    vfxUtil.execute_compiled(KiyoraMvpV2.Compiled, u57, v59);
    soundUtil:play(KiyoraMvpV2.SFX, soundUtil, {
        TimePosition = 0.1
    });
end;

function v20.mvp_EvernightMVP(p64: any, p65: number, p66: any, p67: table) -- Line: 482
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), trove (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local EvernightMvpV2 = mvpAssets.EvernightMvpV2;
    local Root = vfxUtil.getRoot(p64);
    mainreplication.sceneEnabled(true);
    local u68 = trove.new();
    u68:Add(vfxUtil.getScreenDimmer());
    u68:Add(task.delay(p65 - 1, function() -- Line: 490
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u68:Add(task.delay(p65, function() -- Line: 493
        -- upvalues: u68 (copy)
        u68:Destroy();
    end));
    local _baseplate_controller, u69 = vfxUtil.get_baseplate_controller();
    u69.Transparency = 1;
    _baseplate_controller.update();
    u68:Add(function() -- Line: 502
        -- upvalues: u69 (copy), _baseplate_controller (copy)
        u69.Transparency = 0;
        _baseplate_controller.update();
    end);
    local v70 = { p67[1] };
    v70[1].Archivable = true;

    for i = 2, 5 do
        local v71 = u68:Clone(v70[1]);
        v71.HumanoidRootPart.Anchored = true;
        v71:PivotTo(p64:GetPivot());
        v71.Parent = workspace.Effects;
        animationUtil:loadAnimation(v71, EvernightMvpV2[`Victim{i}`]):Play(0);
        table.insert(v70, v71);
        local _ = i;
    end;

    local v72 = u68:Clone(EvernightMvpV2.thing1);
    v72.Name = "1";
    v72.Weld.Part0 = Root;
    v72.Parent = p64;
    local v73 = u68:Clone(EvernightMvpV2.thing2);
    v73.Weld.Part0 = Root;
    v73.Parent = p64;
    local v74 = u68:Clone(EvernightMvpV2.VFX);
    v74:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p64, v74.EvernightStarRail, true);
    v74.Parent = workspace.Effects;
    local v75, v76 = mainreplication.cutsceneCamRigWithLetterBox(Root, EvernightMvpV2.CamAnimation, EvernightMvpV2.FOV, nil, CFrame.new(0, -3, 0), EvernightMvpV2.Cameraa, "CamPart");
    u68:Add(v76);
    local v77 = u68:Add(vfxUtil.getMoonEffects());
    local v78 = {
        Vignette = v77.Vignette,
        ["Screen Cover"] = v77["Screen Cover"],
        Workspace = v74
    };
    vfxUtil.cache_lighting();

    for _, child in EvernightMvpV2.Lighting:GetChildren() do
        local v79 = u68:Clone(child);
        v79.Parent = Lighting;
        v78[child.Name] = v79;
    end;

    u68:Add(vfxUtil.restore_lighting);
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ClockTime = 14.5;
    u68:Add(vfxUtil.restore_lighting_properties);
    local v80 = u68:Construct(MoonPropertyAnimator);
    v80:LoadAndConvertSave(EvernightMvpV2.Moon, v78);
    v80:SetOriginalRoot(EvernightMvpV2.VFX.Core.CFrame);
    v80:SetRoot(Root);
    v80:PlayAll();
    vfxUtil.execute_compiled(EvernightMvpV2.Compiled, u68, v74, p64, v75);
    soundUtil:play(EvernightMvpV2.SFX, soundUtil);
end;

function v20.mvp_doneAndDusted(p81: any, p82: number) -- Line: 573
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), Lighting (copy), PlayerGui (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local DoneAndDusted = mvpAssets.DoneAndDusted;
    local Root = vfxUtil.getRoot(p81);
    mainreplication.sceneEnabled(true);
    local v83 = vfxUtil.mvp_cutscene_defaults(mainreplication, p82);
    Lighting.Ambient = Color3.fromRGB(0, 57, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(102, 135, 255);
    Lighting.Brightness = 4;
    Lighting.ShadowSoftness = 0.2;
    Lighting.ClockTime = 0;
    Lighting.GeographicLatitude = 105;
    Lighting.ExposureCompensation = 0.44;
    v83:Add(vfxUtil.restore_lighting_properties);
    local _baseplate_controller, u84 = vfxUtil.get_baseplate_controller();
    v83:Add(task.delay(0.933, function() -- Line: 593
        -- upvalues: u84 (copy), _baseplate_controller (copy)
        u84.Transparency = 1;
        _baseplate_controller.update();
    end));
    v83:Add(function() -- Line: 598
        -- upvalues: u84 (copy), _baseplate_controller (copy)
        u84.Transparency = 0;
        _baseplate_controller.update();
    end);
    local v85, v86 = mainreplication.cutsceneCamRigWithLetterBox(Root, DoneAndDusted.Animations.Cam, DoneAndDusted.FOV, nil, CFrame.new(0.282, -2.5, -1.5), DoneAndDusted.Cam, "CamPart", "All");
    v83:Add(v86);
    local v87 = v83:Clone(DoneAndDusted.VFX);
    v87:PivotTo(Root.CFrame);
    v87.Parent = workspace.Effects;
    local v88 = v83:Construct(vfxUtil.getMoonEffects);
    local v89 = v83:Clone(DoneAndDusted.ScreenGui);
    v89.Parent = PlayerGui;
    local v90 = {
        Vignette = v88.Vignette,
        Workspace = v87,
        ScreenGui = v89,
        Cam = v85
    };
    vfxUtil.cache_lighting();

    for _, child in DoneAndDusted.Lighting:GetChildren() do
        local v91 = v83:Clone(child);
        v91.Parent = Lighting;
        v90[child.Name] = v91;
    end;

    v83:Add(vfxUtil.restore_lighting);
    local v92 = v83:Construct(MoonPropertyAnimator);
    v92:LoadAndConvertSave(DoneAndDusted.Moon, v90);
    v92:SetOriginalRoot(DoneAndDusted.VFX.Root.CFrame);
    v92:SetRoot(Root);
    v92:PlayAll();
    vfxUtil.execute_compiled(DoneAndDusted.Compiled, v83, v87, v85);
    soundUtil:play(DoneAndDusted.Sound, "default");
end;

function v20.mvp_megusplosion(p93: any, p94: number) -- Line: 637
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), trove (copy), Lighting (copy), PlayerGui (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local Megumin = mvpAssets.Megumin;
    local Root = vfxUtil.getRoot(p93);
    mainreplication.sceneEnabled(true);
    local u95 = trove.new();
    u95:Add(task.delay(p94 - 1, function() -- Line: 644
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u95:Add(task.delay(p94, function() -- Line: 647
        -- upvalues: u95 (copy)
        u95:Destroy();
    end));
    Lighting.Ambient = Color3.fromRGB(255, 255, 255);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ShadowSoftness = 0.2;
    Lighting.ClockTime = 14.5;
    Lighting.ExposureCompensation = 0.3;
    u95:Add(vfxUtil.restore_lighting_properties);
    local v96 = u95:Clone(Megumin.VFX);
    v96:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p93, v96["Megumin MVP"].Megumin, true);
    v96.Parent = workspace.Effects;
    local v97 = u95:Clone(Megumin["Megu Staff"]);
    v97.Weld.Part0 = p93:FindFirstChild("Right Arm");
    v97.Parent = p93;
    local _, v98 = mainreplication.cutsceneCamRigWithLetterBox(Root, Megumin.Animations.Cam, Megumin.FOV, nil, CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0), Megumin.Cam);
    u95:Add(v98);
    local v99 = u95:Construct(vfxUtil.getMoonEffects);
    local v100 = u95:Clone(Megumin.ScreenGui);
    v100.Parent = PlayerGui;
    local v101 = {
        Vignette = v99.Vignette,
        Lighting = Lighting,
        Workspace = v96,
        ScreenGui = v100
    };
    vfxUtil.cache_lighting();

    for _, child in Megumin.Lighting:GetChildren() do
        local v102 = u95:Clone(child);
        v102.Parent = Lighting;
        v101[child.Name] = v102;
    end;

    u95:Add(vfxUtil.restore_lighting);
    local v103 = u95:Construct(MoonPropertyAnimator);
    v103:LoadAndConvertSave(Megumin.Moon, v101);
    v103:SetOriginalRoot(Megumin.VFX.Root.CFrame);
    v103:SetRoot(Root);
    v103:PlayAll();
    vfxUtil.execute_compiled(Megumin.Compiled, u95, v96, v97);
    soundUtil:play(Megumin.Sound, "default");
end;

function v20.mvp_CursedRidicule(u104: any, p105: number, p106: any, u107: table) -- Line: 698
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), trove (copy), Lighting (copy), PlayerGui (copy), MoonPropertyAnimator (copy), soundUtil (copy), Players (copy), TekrinnDialogue (copy)
    local CursedRidicule = mvpAssets.CursedRidicule;
    local Root = vfxUtil.getRoot(u104);
    mainreplication.sceneEnabled(true);
    local u108 = trove.new();
    u108:Add(vfxUtil.getScreenDimmer());
    u108:Add(task.delay(p105 - 1, function() -- Line: 706
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u108:Add(task.delay(p105, function() -- Line: 709
        -- upvalues: u108 (copy)
        u108:Destroy();
    end));
    local v109 = CursedRidicule.VFX["2nd evil dude"]:GetPivot():ToObjectSpace(CursedRidicule.VFX["1st evil dude"]:GetPivot());
    local v110 = u108:Clone(CursedRidicule.VFX);
    v110:PivotTo(Root.CFrame * v109);
    vfxUtil.setupAura(u107[1], v110["1st evil dude"], true);
    vfxUtil.setupAura(u104, v110["2nd evil dude"], true);
    vfxUtil.setupAura(u107[2], v110["3rd"], true);
    vfxUtil.regenerate(v110["2nd evil dude"].Highlight);
    vfxUtil.regenerate(v110["3rd"].Highlight);
    v110.Parent = workspace.Effects;
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.Brightness = 3;
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ExposureCompensation = 0;
    u108:Add(vfxUtil.restore_lighting_properties);
    local _, v111 = mainreplication.cutsceneCamRigWithLetterBox(Root, CursedRidicule.Animations.Cam, CursedRidicule.FOV, nil, v109 * CFrame.new(0, -3, 0), CursedRidicule.Cam, "CamPart");
    u108:Add(v111);
    local v112 = u108:Construct(vfxUtil.getMoonEffects);
    local v113 = u108:Clone(CursedRidicule.ScreenGui);
    v113.Parent = PlayerGui;
    local v114 = {
        Vignette = v112.Vignette,
        Lighting = Lighting,
        Workspace = v110,
        ScreenGui = v113
    };
    vfxUtil.cache_lighting();

    for _, child in CursedRidicule.Lighting:GetChildren() do
        local v115 = u108:Clone(child);
        v115.Parent = Lighting;
        v114[child.Name] = v115;
    end;

    u108:Add(vfxUtil.restore_lighting);
    local v116 = u108:Construct(MoonPropertyAnimator);
    v116:LoadAndConvertSave(CursedRidicule.Moon, v114);
    v116:SetOriginalRoot(CursedRidicule.VFX["1st evil dude"].HumanoidRootPart.CFrame);
    v116:SetRoot(Root);
    v116:PlayAll();
    vfxUtil.execute_compiled(CursedRidicule.Compiled, u108, v110);
    soundUtil:play(CursedRidicule.Sound, "default", {
        TimePosition = 0.5
    });
    u108:Add(task.delay(-0.02400000000000002, function() -- Line: 762
        -- upvalues: Players (ref), u104 (copy), u108 (copy), TekrinnDialogue (ref), u107 (copy)
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(u104);
        u108:Add(TekrinnDialogue.Speak(u107[1], {
            {
                Bold = true,
                TypeSpeed = 0.02,
                Text = `{string.upper(PlayerFromCharacter and PlayerFromCharacter.DisplayName or "sukunaaa")}!!`,
                Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }));
    end));
    u108:Add(task.delay(1.226, function() -- Line: 782
        -- upvalues: u108 (copy), TekrinnDialogue (ref), u107 (copy)
        u108:Add(TekrinnDialogue.Speak(u107[1], {
            {
                Text = "I\'ll do anything!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 2
                }
            }
        }));
    end));
    u108:Add(task.delay(2.602, function() -- Line: 800
        -- upvalues: u108 (copy), TekrinnDialogue (ref), u107 (copy)
        u108:Add(TekrinnDialogue.Speak(u107[1], {
            {
                Text = "You can do ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 2
                }
            },
            {
                Text = "anything",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 0, 0)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            },
            {
                Text = " you want with me!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 2
                }
            }
        }));
    end));
    u108:Add(task.delay(4.434, function() -- Line: 845
        -- upvalues: u108 (copy), TekrinnDialogue (ref), u107 (copy)
        u108:Add(TekrinnDialogue.Speak(u107[1], {
            {
                Text = "So..",
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 2
                }
            }
        }));
    end));
    u108:Add(task.delay(4.89, function() -- Line: 864
        -- upvalues: u108 (copy), TekrinnDialogue (ref), u107 (copy)
        u108:Add(TekrinnDialogue.Speak(u107[1], {
            {
                Text = ".. why can\'t I score?!",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }));
    end));
    u108:Add(task.delay(7.113, function() -- Line: 883
        -- upvalues: u108 (copy), TekrinnDialogue (ref), u104 (copy)
        u108:Add(TekrinnDialogue.Speak(u104, {
            {
                Text = "You\'d offer up your pride, your future, your everything, to try to rely on us...",
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(0.4, 0, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 6
                }
            }
        }));
    end));
    u108:Add(task.delay(11.984, function() -- Line: 901
        -- upvalues: u108 (copy), TekrinnDialogue (ref), u104 (copy)
        u108:Add(TekrinnDialogue.Speak(u104, {
            {
                Text = "And you can\'t score a goal!",
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(0.4, 0, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.7360000000000007
                }
            }
        }));
    end));
end;

function v20.mvp_divineBeatdown(u117: any, p118: number) -- Line: 921
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), trove (copy), Players (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), TekrinnDialogue (copy)
    local SSJ4_new = mvpAssets.SSJ4_new;
    local Root = vfxUtil.getRoot(u117);
    mainreplication.sceneEnabled(true);
    local u119 = trove.new();
    u119:Add(task.delay(p118 - 1, function() -- Line: 928
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u119:Add(task.delay(p118, function() -- Line: 931
        -- upvalues: u119 (copy)
        u119:Destroy();
    end));
    local u120 = u119:Construct(vfxUtil.newRigForFriend, Root, Players:GetPlayerFromCharacter(u117));
    task.defer(function() -- Line: 937
        -- upvalues: animationUtil (ref), u120 (copy), SSJ4_new (copy)
        animationUtil:loadAnimation(u120, SSJ4_new.Animations.Teammate):Play(0);
    end);
    local v121 = u119:Clone(SSJ4_new.VFX);
    v121:PivotTo(Root.CFrame);
    vfxUtil.setupAura(u117, v121.Rigs.R6, true);
    vfxUtil.setupAura(u120, v121.Rigs.TemplateR6, true);
    v121.Parent = workspace.Effects;
    local v122, v123 = mainreplication.cutsceneCamRigWithLetterBox(Root, SSJ4_new.Animations.Cam, SSJ4_new.FOV, nil, CFrame.new(0, -3, 0), SSJ4_new.Cam3, "CamPart");
    u119:Add(v123);
    animationUtil:loadAnimation(v121["12_rig"], SSJ4_new.Animations.Dragon):Play(0);
    local v124 = {
        Workspace = v121,
        Vignette = u119:Construct(vfxUtil.getMoonEffects).Vignette
    };
    local v125 = {
        R6 = v121.Rigs.R6,
        TemplateR6 = v121.Rigs.TemplateR6,
        Cam3 = v122
    };
    vfxUtil.cache_lighting();
    local v126 = {};

    for _, child in SSJ4_new.Lighting:GetChildren() do
        local v127 = u119:Clone(child);
        v127.Parent = Lighting;
        v126[v127.Name] = v127;
        v124[v127.Name] = v127;
    end;

    u119:Add(vfxUtil.restore_lighting);
    local v128 = u119:Construct(MoonPropertyAnimator);
    v128:LoadAndConvertSave(SSJ4_new.Moon, v124);
    v128:SetOriginalRoot(SSJ4_new.VFX.Root.CFrame);
    v128:SetRoot(Root);
    v128:PlayAll();
    vfxUtil.execute_compiled(SSJ4_new.Compiled, u119, v126, v125, v121);
    soundUtil:play(SSJ4_new.Sound, "default");
    u119:Add(task.delay(0.602, function() -- Line: 984
        -- upvalues: u119 (copy), TekrinnDialogue (ref), u117 (copy)
        u119:Add(TekrinnDialogue.Speak(u117, {
            {
                Text = "This\'ll take 10 seconds.",
                TypeSpeed = 0.02,
                Color = ColorSequence.new(Color3.new(1, 1, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.499
                }
            }
        }));
    end));
    u119:Add(task.delay(4.202, function() -- Line: 1002
        -- upvalues: u119 (copy), TekrinnDialogue (ref), u117 (copy)
        u119:Add(TekrinnDialogue.Speak(u117, {
            {
                Text = "DRAGON FIST!",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(1, 1, 0)),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1.2220000000000004
                }
            }
        }));
    end));
    u119:Add(task.delay(9.487, function() -- Line: 1021
        -- upvalues: u119 (copy), TekrinnDialogue (ref)
        u119:Add(TekrinnDialogue.Speak("???", {
            {
                Text = "I\'ll handle this.",
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new(Color3.new(0.666667, 0, 1), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }));
    end));
    u119:Add(task.delay(10.653, function() -- Line: 1040
        -- upvalues: u119 (copy), TekrinnDialogue (ref), u117 (copy)
        u119:Add(TekrinnDialogue.Speak(u117, {
            {
                Text = "You heard what he said...",
                TypeSpeed = 0.01,
                Color = ColorSequence.new(Color3.new(1, 1, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }));
    end));
    u119:Add(task.delay(11.829, function() -- Line: 1058
        -- upvalues: u119 (copy), TekrinnDialogue (ref), u117 (copy)
        u119:Add(TekrinnDialogue.Speak(u117, {
            {
                Text = "You messed with the wrong ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(1, 1, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.943999999999999
                }
            },
            {
                Text = "saiyans",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(1, 1, 0)),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 1.943999999999999
                }
            },
            {
                Text = ".",
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(1, 1, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.943999999999999
                }
            }
        }));
    end));
end;

function v20.mvp_zantetsu(p129: any, p130: number) -- Line: 1105
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), trove (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local zantetsu = mvpAssets.zantetsu;
    local Root = vfxUtil.getRoot(p129);
    mainreplication.sceneEnabled(true);
    local _baseplate_controller, u131 = vfxUtil.get_baseplate_controller();
    local u132 = vfxUtil.make_baseplate_connection(_baseplate_controller.update);
    local u133 = trove.new();
    u133:Add(vfxUtil.getScreenDimmer());
    u133:Add(function() -- Line: 1116
        -- upvalues: u132 (copy), u131 (copy), _baseplate_controller (copy)
        u132:Disconnect();
        u131.Transparency = 0;
        _baseplate_controller.update();
    end);
    u133:Add(task.delay(p130 - 1, function() -- Line: 1121
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u133:Add(task.delay(p130, function() -- Line: 1124
        -- upvalues: u133 (copy)
        u133:Destroy();
    end));
    local v134 = u133:Add(Instance.new("Highlight"));
    v134.FillColor = Color3.fromRGB(85, 195, 255);
    v134.FillTransparency = 0.3;
    v134.OutlineColor = Color3.fromRGB(64, 239, 255);
    v134.OutlineTransparency = 0;
    v134.DepthMode = Enum.HighlightDepthMode.Occluded;
    v134.Enabled = false;
    v134.Parent = p129;
    local v135 = u133:Clone(zantetsu.VFX);
    v135:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p129, v135.aaa, true);
    v135.Parent = workspace.Effects;
    vfxUtil.cache_lighting();
    local v136 = {
        Workspace = v135,
        Baseplate = u131,
        Highlight = v134
    };

    for _, child in zantetsu.Lighting:GetChildren() do
        local v137 = u133:Clone(child);
        v137.Parent = Lighting;
        v136[child.Name] = v137;
    end;

    vfxUtil.restore_lighting();
    u133:Add(vfxUtil.restore_lighting_properties);
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ExposureCompensation = 0;
    Lighting.ClockTime = 14.5;
    local v138, v139 = mainreplication.cutsceneCamRigWithLetterBox(Root, zantetsu.CamAnimation, zantetsu.FOV, nil, CFrame.new(0, -3, 0), zantetsu.Cam, "CamPart");
    u133:Add(v139);
    local v140 = u133:Construct(MoonPropertyAnimator);
    v140:LoadAndConvertSave(zantetsu.Moon, v136);
    v140:SetOriginalRoot(zantetsu.VFX.aaa.HumanoidRootPart.CFrame);
    v140:SetRoot(Root);
    v140:PlayAll();
    vfxUtil.execute_compiled(zantetsu.Compiled, u133, v135, v138);
    soundUtil:play(zantetsu.Sound, "default");
end;

function v20.mvp_aizen(p141: any, p142: number, p143: any, p144: table) -- Line: 1175
    -- upvalues: mvpAssets (copy), vfxUtil (copy), mainreplication (copy), trove (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local aizen = mvpAssets.aizen;
    local Root = vfxUtil.getRoot(p141);
    mainreplication.sceneEnabled(true);
    local u145 = trove.new();
    u145:Add(task.delay(p142 - 1, function() -- Line: 1182
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end));
    u145:Add(task.delay(p142, function() -- Line: 1185
        -- upvalues: u145 (copy)
        u145:Destroy();
    end));
    local v146 = u145:Clone(aizen.VFX);
    v146:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p144[1], v146.N0WHOWTOPLAY, true);
    v146.Parent = workspace.Effects;
    local v147 = u145:Add(Instance.new("Highlight"));
    v147.FillColor = Color3.new(1, 1, 1);
    v147.FillTransparency = 0;
    v147.OutlineColor = Color3.new(1, 1, 1);
    v147.OutlineTransparency = 1;
    v147.DepthMode = Enum.HighlightDepthMode.Occluded;
    v147.Parent = p141;
    local v148 = u145:Add(Instance.new("Highlight"));
    v148.FillColor = Color3.new(1, 1, 1);
    v148.FillTransparency = 0;
    v148.OutlineColor = Color3.new(1, 1, 1);
    v148.OutlineTransparency = 1;
    v148.DepthMode = Enum.HighlightDepthMode.Occluded;
    v148.Parent = p144[1];
    local v149 = u145:Clone(aizen.uchigatana);
    v149.Weld.Part0 = p141["Right Arm"];
    v149.Parent = p141;
    local v150 = u145:Clone(aizen.glasses);
    v150.Weld.Part0 = p141.Head;
    v150.Parent = p141;
    local v151 = {
        Workspace = v146,
        ["sword man thing i forgot"] = p141,
        N0WHOWTOPLAY = p144[1]
    };
    vfxUtil.cache_lighting();

    for _, child in aizen.Lighting:GetChildren() do
        local v152 = u145:Clone(child);
        v152.Parent = Lighting;
        v151[child.Name] = v152;
    end;

    vfxUtil.restore_lighting();
    u145:Add(vfxUtil.restore_lighting_properties);
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ExposureCompensation = 0;
    Lighting.ClockTime = 14.5;
    local v153, v154 = mainreplication.cutsceneCamRigWithLetterBox(Root, aizen.CamAnimation, aizen.FOV, nil, CFrame.new(0, -3, 0), aizen.Cam3, "CamPart");
    u145:Add(v154);
    local v155 = u145:Construct(MoonPropertyAnimator);
    v155:LoadAndConvertSave(aizen.Moon, v151);
    v155:SetOriginalRoot(aizen.VFX.Root.CFrame);
    v155:SetRoot(Root);
    v155:PlayAll();
    vfxUtil.execute_compiled(aizen.Compiled, u145, v146, v153);
    soundUtil:play(aizen.Sound, "default");
end;

local function pivotOffset(p156, p157) -- Line: 1251
    p156:PivotTo(p156:GetPivot() * p157);
end;

function v20.mvp_retrial(p158: any, p159: number) -- Line: 1255
    -- upvalues: mvpAssets (copy), vfxUtil (copy), soundUtil (copy), mainreplication (copy), animationUtil (copy), PlayerGui (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local retrial = mvpAssets.retrial;
    local Root = vfxUtil.getRoot(p158);
    soundUtil:play(retrial.Sound, "default");
    local u160 = vfxUtil.mvp_cutscene_defaults(mainreplication, p159);
    task.defer(function() -- Line: 1263
        -- upvalues: u160 (copy), retrial (copy), Root (copy), animationUtil (ref)
        local u161 = nil;
        u160:Add(task.delay(8.18, function() -- Line: 1266
            -- upvalues: u161 (ref)
            local biggles_rig = u161.biggles_rig;
            local CFrame_new_ret = CFrame.new(0, 0, 50);
            biggles_rig:PivotTo(biggles_rig:GetPivot() * CFrame_new_ret);
        end));
        u161 = u160:Clone(retrial.Scene);
        u161:PivotTo(Root.CFrame);
        u161.Parent = workspace.Effects;
        local biggles_rig = u161.biggles_rig;
        local CFrame_new_ret = CFrame.new(0, 4, -50);
        biggles_rig:PivotTo(biggles_rig:GetPivot() * CFrame_new_ret);
        animationUtil:loadAnimation(u161.biggles_rig, retrial.DominantWoman):Play(0);
    end);
    task.defer(function() -- Line: 1280
        -- upvalues: vfxUtil (ref), u160 (copy)
        local _map_controller = vfxUtil.get_map_controller();
        _map_controller.update(1);
        u160:Add(function() -- Line: 1284
            -- upvalues: _map_controller (copy)
            _map_controller.update(0);
        end);
    end);
    local v162 = u160:Clone(retrial.vfx);
    v162:PivotTo(Root.CFrame);
    v162.Parent = workspace.Effects;
    u160:Clone(retrial.Bars).Parent = PlayerGui;
    local v163 = u160:Clone(retrial.Gavel);
    v163.Weld.Part0 = p158["Right Arm"];
    v163.Parent = p158;
    local _, v164 = mainreplication.cutsceneCamRigWithLetterBox(Root, retrial.CamAnimation, retrial.FOV, nil, "default", retrial.MVPCam, "CamPart", "All");
    u160:Add(v164);
    local v165 = {
        Vignette = u160:Add(vfxUtil.getMoonEffects()).Vignette
    };
    vfxUtil.cache_lighting();
    u160:Add(vfxUtil.restore_lighting);

    for _, child in retrial.Lighting:GetChildren() do
        local v166 = u160:Clone(child);
        v166.Parent = Lighting;
        v165[child.Name] = v166;
    end;

    Lighting.Ambient = Color3.fromRGB(27, 27, 27);
    Lighting.OutdoorAmbient = Color3.new(0, 0, 0);
    Lighting.Brightness = 3.42;
    Lighting.ShadowSoftness = 0.2;
    Lighting.ClockTime = 17.85;
    Lighting.GeographicLatitude = 111.222;
    u160:Add(vfxUtil.restore_lighting_properties);
    local v167 = u160:Construct(MoonPropertyAnimator);
    v167:LoadAndConvertSave(retrial.Moon_Scene, v165);
    v167:PlayAll();
    local v168 = u160:Construct(MoonPropertyAnimator);
    v168:LoadAndConvertSave(retrial.Moon_VFX, {
        vfx = v162
    });
    v168:SetOriginalRoot(retrial.vfx.Root.CFrame);
    v168:SetRoot(Root);
    v168:PlayAll();
    vfxUtil.execute_compiled(retrial.Compiled, u160, v162);
end;

function v20.mvp_AreYouWatchingMe(p169: any, p170: number) -- Line: 1338
    -- upvalues: mvpAssets (copy), vfxUtil (copy), soundUtil (copy), mainreplication (copy), MoonPropertyAnimator (copy), ReplicatedStorage (copy)
    local AreYouWatchingMe = mvpAssets.AreYouWatchingMe;
    local Root = vfxUtil.getRoot(p169);
    soundUtil:play(AreYouWatchingMe.Sound, "default");
    local v171 = vfxUtil.mvp_cutscene_defaults(mainreplication, p170);
    v171:Add(vfxUtil.getScreenDimmer());
    local v172 = v171:Clone(AreYouWatchingMe.VFX);
    v172:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p169, v172.Dio, true);
    v172.Parent = workspace.Effects;
    local v173 = v171:Clone(AreYouWatchingMe.LeftHand);
    v173.Weld.Part0 = p169["Left Arm"];
    v173.Parent = p169;
    local v174 = v171:Clone(AreYouWatchingMe.RightHand);
    v174.Weld.Part0 = p169["Right Arm"];
    v174.Parent = p169;

    for _, child in v174:GetChildren() do
        if child:IsA("BasePart") then
            child.Color = p169["Right Arm"].Color;
        end;
    end;

    for _, child in v173:GetChildren() do
        if child:IsA("BasePart") then
            child.Color = p169["Left Arm"].Color;
        end;
    end;

    local _, v175 = mainreplication.cutsceneCamRigWithLetterBox(Root, AreYouWatchingMe.Animations.Cam, AreYouWatchingMe.FOV, nil, "default", AreYouWatchingMe.DioCam);
    v171:Add(v175);
    local v176 = {
        Vignette = v171:Construct(vfxUtil.getMoonEffects).Vignette,
        Workspace = v172
    };
    vfxUtil.cutscene_lighting(v171, v176, AreYouWatchingMe.Lighting, {
        ClockTime = 14.5,
        GeographicLatitude = 0,
        ExposureCompensation = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    local v177 = v171:Construct(MoonPropertyAnimator);
    v177:LoadAndConvertSave(AreYouWatchingMe.Moon, v176);
    v177:SetOriginalRoot(AreYouWatchingMe.VFX:GetPivot());
    v177:SetRoot(Root);
    v177:PlayAll();
    vfxUtil.execute_compiled(AreYouWatchingMe.Compiled, v171, v172);
    local v178 = p169:FindFirstChildWhichIsA("Shirt");
    local Torso = p169.Torso;

    if v178 then
        v178.ShirtTemplate = ReplicatedStorage.Resources.mvpAssets.king.Clothingtest.ShirtTemplate;

        if Torso:FindFirstChild("BackDecal") then
            Torso.BackDecal.Enabled = false;
        end;
    end;
end;

return v20;