 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
game:GetService("Debris");
local UserInputService = game:GetService("UserInputService");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local trove = require(ReplicatedStorage.forum.trove);
local replication = ReplicatedStorage.client.replication;
local mainreplication = require(replication.mainreplication);
local TekrinnDialogue = require(replication.TekrinnDialogue);
local VfxHandler = require(ReplicatedStorage.VfxHandler);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local Util = require(ReplicatedStorage.util.Util);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local emit = vfxUtil.forge.emit;
local v1 = {};
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Atmosphere.Offset;
local _ = Lighting.Atmosphere.Decay;
local _ = Lighting.Atmosphere.Glare;
local _ = Lighting.Atmosphere.Haze;
local Brightness = Lighting.Brightness;
local _ = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local ExposureCompensation = Lighting.ExposureCompensation;
local _ = Lighting.Bloom.Threshold;
local EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale;
local EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale;
local ColorShift_Top = Lighting.ColorShift_Top;
local _ = Lighting.GlobalShadows;
local OutdoorAmbient = Lighting.OutdoorAmbient;
local ShadowSoftness = Lighting.ShadowSoftness;
local ClockTime = Lighting.ClockTime;
local GeographicLatitude = Lighting.GeographicLatitude;
local _ = Lighting.FogColor;
local _ = Lighting.FogEnd;
local _ = Lighting.FogStart;

local function handleGlacialSide(u2: userdata, u3: any, p4: any, u5: any) -- Line: 57
    -- upvalues: vfxUtil (copy), mainreplication (copy), RunService (copy)
    if typeof(u3) == "table" then
        vfxUtil.emitAll(u3[1]);
        u3 = u3[2];
    end;

    local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection[p4 and "Out" or "In"]);
    local u6, u7 = mainreplication.bodyVelocity(u2, p4 or 60, 1, false, nil, true, TweenInfo_new_ret);

    if u6 then
        local u8 = nil;
        u8 = RunService.RenderStepped:Connect(function() -- Line: 70
            -- upvalues: u6 (copy), u2 (copy), u8 (ref), u7 (copy), u5 (copy), u3 (ref)
            if u6.Parent ~= u2 then
                u8:Disconnect();

                return;
            end;

            local Value = u7.Value;
            u6.Velocity = u2.CFrame.LookVector * Value * (u5 or 0.15) + u2.CFrame.RightVector * u3 * Value;
        end);
    end;

    return u6 ~= nil;
end;

function v1.akaza_awk(u9: userdata) -- Line: 83
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), Lighting (copy), Ambient (copy), Brightness (copy), OutdoorAmbient (copy), ExposureCompensation (copy), ShadowSoftness (copy), ClockTime (copy), GeographicLatitude (copy), Util (copy), LocalPlayer (copy), MoonPropertyAnimator (copy), soundUtil (copy), KatUtil (copy), TekrinnDialogue (copy)
    local AkazaFlow = vfxUtil.getResources().hiori.AkazaFlow;
    local os_clock_ret = os.clock();
    local u10 = nil;

    while true do
        if os.clock() - os_clock_ret >= 12.133 or u10 ~= nil then
            if not u10 then
                return;
            end;

            local Root = vfxUtil.getRoot(u9);
            local v11 = u9:FindFirstChild("Right Arm");
            local u12 = trove.new();
            u12:AttachToInstance(u9);
            mainreplication.sceneEnabled(true);
            u12:Add(function() -- Line: 111
                -- upvalues: mainreplication (ref)
                mainreplication.sceneEnabled(false);
            end);

            local function synced_delay(p13: number, p14: function, ...) -- Line: 115
                -- upvalues: u12 (copy), u10 (ref)
                return u12:Add(task.delay(math.max(0, p13 / 60 - u10.TimePosition), p14, ...));
            end;

            local function apply_lighting() -- Line: 119
                -- upvalues: Lighting (ref), AkazaFlow (copy), Ambient (ref), Brightness (ref), OutdoorAmbient (ref), ExposureCompensation (ref), ShadowSoftness (ref), ClockTime (ref), GeographicLatitude (ref)
                local Children = Lighting:GetChildren();
                local u15 = {};

                for _, v in Children do
                    v.Parent = nil;
                end;

                for _, child in AkazaFlow.Lighting:GetChildren() do
                    local v16 = child:Clone();
                    v16.Parent = Lighting;
                    table.insert(u15, v16);
                end;

                Lighting.Ambient = Color3.fromRGB(70, 70, 70);
                Lighting.Brightness = 3;
                Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
                Lighting.ShadowSoftness = 0.2;
                Lighting.ClockTime = 14.5;
                Lighting.GeographicLatitude = 0;

                return function() -- Line: 141
                    -- upvalues: Children (copy), Lighting (ref), u15 (copy), Ambient (ref), Brightness (ref), OutdoorAmbient (ref), ExposureCompensation (ref), ShadowSoftness (ref), ClockTime (ref), GeographicLatitude (ref)
                    for _, v in Children do
                        v.Parent = Lighting;
                    end;

                    for _, v in u15 do
                        pcall(game.Destroy, v);
                    end;

                    Lighting.Ambient = Ambient;
                    Lighting.Brightness = Brightness;
                    Lighting.OutdoorAmbient = OutdoorAmbient;
                    Lighting.ExposureCompensation = ExposureCompensation;
                    Lighting.ShadowSoftness = ShadowSoftness;
                    Lighting.ClockTime = ClockTime;
                    Lighting.GeographicLatitude = GeographicLatitude;
                    warn("reset ehre pls");
                end;
            end;

            local v17 = u12:Add(vfxUtil.createVFX(AkazaFlow.isagitagshotdomain, "default", Root));
            local u18 = u12:Add(vfxUtil.createVFX(AkazaFlow.SnowImpact, "default", Root));
            local u19 = u12:Add(vfxUtil.createVFX(AkazaFlow["Right Arm"], "default", v11));
            local u20 = u12:Add(vfxUtil.createVFX(AkazaFlow.HumanoidRootPart, "default", Root));
            local v21 = u12:Add(mainreplication.cutscene(Root, CFrame.identity, 12.133, AkazaFlow.FOV));
            local u22 = {};

            if Util.canshiftcolor(LocalPlayer, u9) then
                vfxUtil.LeanTowardsColor({
                    u19,
                    u20,
                    u18,
                    v17
                }, u9:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u9:GetAttribute("CustomAlpha") or 0.985);
            end;

            u12:Add((apply_lighting()));
            local v23 = u12:Add(Instance.new("ColorCorrectionEffect"));
            v23.Parent = Lighting;
            local v24 = u12:Add(vfxUtil.getMoonEffects());
            local v25 = u12:Construct(MoonPropertyAnimator);
            v25:LoadAndConvertSave(AkazaFlow.Moon, {
                Lighting = Lighting,
                Vignette = v24.Vignette,
                ColorCorrection = v23
            });
            v25:PlayAll();

            for _, child in AkazaFlow.CameraVFX:GetChildren() do
                child:Clone().Parent = v21;
                u22[child.Name] = child;
            end;

            soundUtil:play(AkazaFlow.SFX, game.SoundService);
            u12:Add(KatUtil.tween_frames(v17, { 103 }, {
                Transparency = 1
            }));
            TekrinnDialogue.Speak(u9, {
                {
                    Text = "I see...",
                    Bold = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.576471, 1, 0.972549)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.2
                    }
                }
            });
            synced_delay(107, function() -- Line: 221
                -- upvalues: vfxUtil (ref), u19 (copy)
                vfxUtil.forge.emit(u19.RightGripAttachment.Impact);
            end);
            synced_delay(138, function() -- Line: 225
                -- upvalues: vfxUtil (ref), u20 (copy)
                vfxUtil.forge.emit(u20.Steps["2"]);
            end);
            synced_delay(190, function() -- Line: 229
                -- upvalues: vfxUtil (ref), u20 (copy)
                vfxUtil.forge.emit(u20.Floor);
            end);
            synced_delay(211, function() -- Line: 233
                -- upvalues: TekrinnDialogue (ref), u9 (copy)
                TekrinnDialogue.Speak(u9, {
                    {
                        Text = "Technique Development",
                        Bold = true,
                        TypeSpeed = 0.02,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.576471, 1, 0.972549)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                        Shake = {
                            Enabled = true,
                            Intensity = 2,
                            Lifetime = 0.2
                        }
                    }
                });
            end);
            synced_delay(298, function() -- Line: 254
                -- upvalues: vfxUtil (ref), u20 (copy), u18 (copy), u22 (copy)
                vfxUtil.forge.emit(u20.Floor.Burst.GlassBreak, u20.Floor.Burst.Ice, u18, u22.glow);
            end);
            synced_delay(465, function() -- Line: 258
                -- upvalues: TekrinnDialogue (ref), u9 (copy)
                TekrinnDialogue.Speak(u9, {
                    {
                        Text = "Destructive Death... Compass Needle",
                        Bold = true,
                        TypeSpeed = 0.02,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.576471, 1, 0.972549)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                        Shake = {
                            Enabled = true,
                            Intensity = 2,
                            Lifetime = 0.2
                        }
                    }
                });
            end);
            synced_delay(728, function() -- Line: 279
                -- upvalues: u12 (copy), mainreplication (ref)
                u12:Destroy();
                mainreplication.ultFlash(1);
            end);

            return;
        end;

        for _, v in u9:FindFirstChild("Animator", true):GetPlayingAnimationTracks() do
            if v.Animation.AnimationId == AkazaFlow.User.AnimationId then
                u10 = v;
                break;
            end;
        end;

        task.wait(0.016666666666666666);
    end;
end;

local u26 = {};
local u27 = {};

local function registerChillingCounterContainer(u28, u29) -- Line: 289
    -- upvalues: u27 (copy)
    local v30 = u27[u28];

    if v30 then
        v30:Destroy();
    end;

    u27[u28] = u29;
    u29:Add(function() -- Line: 295
        -- upvalues: u27 (ref), u28 (copy), u29 (copy)
        if u27[u28] == u29 then
            u27[u28] = nil;
        end;
    end);
end;

local function trackGlacialContainer(u31, u32) -- Line: 302
    -- upvalues: u26 (copy)
    if not u26[u31] then
        u26[u31] = {};
    end;

    table.insert(u26[u31], u32);
    u32:Add(function() -- Line: 307
        -- upvalues: u26 (ref), u31 (copy), u32 (copy)
        local v33 = u26[u31];

        if not v33 then
            return;
        end;

        local table_find_ret = table.find(v33, u32);

        if table_find_ret then
            table.remove(v33, table_find_ret);
        end;

        if #v33 == 0 then
            u26[u31] = nil;
        end;
    end);
end;

local function stopActiveGlacialDash(p34: any, p35: userdata) -- Line: 322
    -- upvalues: mainreplication (copy), u26 (copy)
    mainreplication.destroyVelocity(p35, true);
    local v36 = u26[p34];

    if not v36 then
        return;
    end;

    u26[p34] = nil;

    for _, v in v36 do
        v:Destroy();
    end;
end;

function v1.hioriStopGlacialVelocity(p37) -- Line: 334
    -- upvalues: vfxUtil (copy), mainreplication (copy), u26 (copy)
    local Root = vfxUtil.getRoot(p37);
    mainreplication.destroyVelocity(Root, true);
    local v38 = u26[p37];

    if not v38 then
        return;
    end;

    u26[p37] = nil;

    for _, v in v38 do
        v:Destroy();
    end;
end;

function v1.hioriStopChillingCounterFeint(p39) -- Line: 339
    -- upvalues: vfxUtil (copy), mainreplication (copy), u27 (copy)
    local Root = vfxUtil.getRoot(p39);
    mainreplication.destroyVelocity(Root, true);
    local v40 = u27[p39];

    if v40 then
        u27[p39] = nil;
        v40:Destroy();
    end;
end;

function v1.hioriGlacialCut(p41: any, u42: string) -- Line: 349
    -- upvalues: vfxUtil (copy), trove (copy), trackGlacialContainer (copy), Util (copy), LocalPlayer (copy), soundUtil (copy), TweenService (copy), mainreplication (copy), handleGlacialSide (copy)
    local GlacialCut = vfxUtil.getResources().hiori.GlacialCut;
    local Root = vfxUtil.getRoot(p41);
    local u43 = trove.new();
    u43:AttachToInstance(p41);

    if p41:FindFirstChild("Ball") then
        u43:AttachToInstance(p41.Ball);
    end;

    trackGlacialContainer(p41, u43);

    if u42 ~= "Front" then
        u43:Add(task.delay(1.8, function() -- Line: 403
            -- upvalues: u43 (copy)
            u43:Destroy();
        end));
        local u44 = {
            Front = {},
            Right = { nil, 1 },
            Left = { nil, -1 }
        };

        for i, v in u44 do
            v[1] = u43:Add(vfxUtil.createVFX(GlacialCut[`{i}Dash`], "default", Root));

            for _, descendant in v[1]:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.LockedToPart = false;
                end;
            end;
        end;

        local u45 = nil;
        u43:Add(task.delay(0.2, function() -- Line: 420
            -- upvalues: u45 (ref), handleGlacialSide (ref), Root (copy), u44 (copy), u42 (copy), mainreplication (ref)
            u45 = handleGlacialSide(Root, u44[u42]);

            if u45 then
                mainreplication.fov(true, 80, 0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                mainreplication.ultFlash(0.5, 0.5, nil, Color3.new(0.666667, 1, 1));
            end;
        end));
        u43:Add(task.delay(0.6, function() -- Line: 427
            -- upvalues: handleGlacialSide (ref), Root (copy), u44 (copy), u42 (copy)
            handleGlacialSide(Root, u44[u42 == "Left" and "Right" or "Left"]);
        end));
        u43:Add(task.delay(1.2, function() -- Line: 430
            -- upvalues: u45 (ref), mainreplication (ref), vfxUtil (ref), u44 (copy), Root (copy)
            if u45 then
                mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            end;

            vfxUtil.emitAll(u44.Front[1]);
            mainreplication.bodyVelocity(Root, 90, 0.6, false, nil, false, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
        end));
        soundUtil:play(GlacialCut.SideSFX, Root);

        return;
    end;

    local u46 = GlacialCut.Dribble:Clone();
    u46.Parent = Root;

    if Util.canshiftcolor(LocalPlayer, p41) then
        vfxUtil.LeanTowardsColor({ u46 }, p41:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p41:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u47 = soundUtil:play(GlacialCut.FrontSFX, Root);
    local u48 = false;
    u43:Add(function() -- Line: 369
        -- upvalues: vfxUtil (ref), u46 (copy), u48 (ref), TweenService (ref), u47 (copy)
        vfxUtil.disposal(u46);

        if not u48 then
            TweenService:Create(u47, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                Volume = 0
            }):Play();
        end;
    end);
    u43:Add(task.delay(1.6, function() -- Line: 375
        -- upvalues: u48 (ref), u43 (copy)
        u48 = true;
        u43:Destroy();
    end));
    local u49 = mainreplication.bodyVelocity(Root, 35, 0.5, false, nil, false, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out));

    if u49 then
        mainreplication.fov(true, 40, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    end;

    u43:Add(task.delay(0.5, function() -- Line: 383
        -- upvalues: u49 (copy), mainreplication (ref), Root (copy), u43 (copy), vfxUtil (ref), u46 (copy)
        if u49 then
            mainreplication.ultFlash(0.5, 0.5, nil, Color3.new(0.666667, 1, 1));
            mainreplication.fov(true, 85, 0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut);
            mainreplication.cameraShake(25, 1.5, 7);
        end;

        mainreplication.bodyVelocity(Root, 80, 0.25, false, nil, false, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In));

        for i = 0, 11 do
            u43:Add(task.delay(i * 0.09166666666666667, function() -- Line: 391
                -- upvalues: vfxUtil (ref), u46 (ref)
                vfxUtil.emitAll(u46);
            end));
            local _ = i;
        end;
    end));
    u43:Add(task.delay(0.75, function() -- Line: 396
        -- upvalues: u49 (copy), mainreplication (ref), Root (copy)
        if u49 then
            mainreplication.fov(true, 70, 1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        end;

        mainreplication.bodyVelocity(Root, 55, 0.85, false, nil, false, TweenInfo.new(3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In));
    end));
end;

function v1.hioriGlacialForwardVariants(p50: any, u51: string) -- Line: 442
    -- upvalues: vfxUtil (copy), trove (copy), trackGlacialContainer (copy), Util (copy), LocalPlayer (copy), soundUtil (copy), TweenService (copy), handleGlacialSide (copy), mainreplication (copy)
    local GlacialCut = vfxUtil.getResources().hiori.GlacialCut;
    local Root = vfxUtil.getRoot(p50);
    local u52 = trove.new();
    u52:AttachToInstance(p50);
    trackGlacialContainer(p50, u52);
    local u53 = GlacialCut[`Front{u51}`]:Clone();
    u53.Parent = Root;

    if Util.canshiftcolor(LocalPlayer, p50) then
        vfxUtil.LeanTowardsColor({ u53 }, p50:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p50:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in u53:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.LockedToPart = false;
        end;
    end;

    local u54 = soundUtil:play(GlacialCut.FrontSideSFX, Root);
    u52:Add(function() -- Line: 465
        -- upvalues: vfxUtil (ref), u53 (copy), u54 (copy), TweenService (ref)
        vfxUtil.disposal(u53);

        if u54 then
            TweenService:Create(u54, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                Volume = 0
            }):Play();
        end;
    end);
    u52:Add(task.delay(0.3, function() -- Line: 472
        -- upvalues: vfxUtil (ref), u53 (copy), handleGlacialSide (ref), Root (copy), u51 (copy), mainreplication (ref)
        vfxUtil.emitAll(u53.One);

        if handleGlacialSide(Root, u51 == "Right" and 1 or -1, 120) then
            mainreplication.fov(true, 55, 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            mainreplication.ultFlash(0.5, 0.7, nil, Color3.new(0.666667, 1, 1));
            mainreplication.cameraShake(20, 1.5, 5);
        end;
    end));
    u52:Add(task.delay(1, function() -- Line: 482
        -- upvalues: vfxUtil (ref), u53 (copy), u52 (copy), mainreplication (ref), Root (copy)
        vfxUtil.emitAll(u53.Two);
        u52:Destroy();

        if mainreplication.bodyVelocity(Root, 125, 0.6, false, nil, false, TweenInfo.new(1.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)) then
            mainreplication.fov(true, 70, 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            mainreplication.ultFlash(0.25, 0.5, nil, Color3.new(0.666667, 1, 1));
        end;
    end));
end;

local function getGT(u55) -- Line: 493
    return function(p56) -- Line: 494
        -- upvalues: u55 (copy)
        return p56 - u55;
    end;
end;

function v1.hioriFrostGuard(u57: any, p58: boolean?, p59: boolean?) -- Line: 499
    -- upvalues: vfxUtil (copy), trove (copy), emit (copy), soundUtil (copy), RunService (copy), mainreplication (copy)
    local FrostGuard = vfxUtil.getResources().hiori.FrostGuard;
    local Root = vfxUtil.getRoot(u57);
    local v60 = vfxUtil.isLocalPlayer(u57);
    local u61 = trove.new();
    u61:AttachToInstance(u57);

    if typeof(p58) == "boolean" then
        local u62 = p58 and 0.233 or 0.25;

        local function v64(p63) -- Line: 494
            -- upvalues: u62 (copy)
            return p63 - u62;
        end;

        if p58 then
            local u65 = u61:Add(vfxUtil.createVFX(FrostGuard.Shards, "default", Root));
            u61:Add(task.delay(v64(0.3), emit, u65));
            u61:Add(task.delay(v64(0.317), function() -- Line: 518
                -- upvalues: u61 (copy), FrostGuard (copy), Root (copy), emit (ref), vfxUtil (ref), u65 (copy)
                local v66 = u61:Clone(FrostGuard.E2);
                v66:PivotTo(Root.CFrame);
                v66.Parent = workspace.Effects;
                emit(v66);
                u61:Add(task.delay(vfxUtil.getBulkEmittersLifetime(u65, v66), function() -- Line: 524
                    -- upvalues: u61 (ref)
                    u61:Destroy();
                end));
            end));
            soundUtil:play(FrostGuard.Sounds.Hit, Root);
            local u67 = FrostGuard:FindFirstChild("Animations") and FrostGuard.Animations:FindFirstChild("Hit");

            if u67 then
                u67 = u67.AnimationId;
            end;

            if u67 then
                local u68 = false;
                local u69 = nil;
                u69 = RunService.Heartbeat:Connect(function() -- Line: 535
                    -- upvalues: u57 (copy), u68 (ref), u67 (copy), u69 (ref)
                    local Attribute = u57:GetAttribute("HioriFrostGuardFreeze");
                    local Animator = u57:FindFirstChild("Animator", true);

                    if typeof(Attribute) == "number" then
                        u68 = true;

                        if not Animator then
                            return;
                        end;

                        for _, v in Animator:GetPlayingAnimationTracks() do
                            if v.Animation and v.Animation.AnimationId == u67 then
                                if v.Speed ~= 0 then
                                    v:AdjustSpeed(0);
                                end;

                                v.TimePosition = Attribute;
                            end;
                        end;

                        return;
                    end;

                    if not u68 then
                        return;
                    end;

                    if Animator then
                        for _, v in Animator:GetPlayingAnimationTracks() do
                            if v.Animation and (v.Animation.AnimationId == u67 and v.Speed == 0) then
                                v:AdjustSpeed(1);
                            end;
                        end;
                    end;

                    if u69 then
                        u69:Disconnect();
                        u69 = nil;
                    end;
                end);
                u57.Destroying:Once(function() -- Line: 568
                    -- upvalues: u69 (ref)
                    if u69 then
                        u69:Disconnect();
                        u69 = nil;
                    end;
                end);
            end;

            if v60 then
                mainreplication.fov(false, 90);
                mainreplication.fov(true, 70, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                mainreplication.ultFlash(0.5, 0.5, nil, Color3.new(0.666667, 1, 1));
                mainreplication.cameraShake(15, 2, 7);

                if p59 then
                    local u70, u71 = mainreplication.bodyVelocity(Root, 60, 1.05, nil, nil, true, TweenInfo.new(1.05, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));

                    if u70 and u71 then
                        u70.MaxForce = Vector3.new(300000, 300000, 300000);
                        u61:Add(RunService.RenderStepped:Connect(function() -- Line: 591
                            -- upvalues: u70 (copy), Root (copy), u71 (copy)
                            if not (u70 and u70:IsDescendantOf(game)) then
                                return;
                            end;

                            u70.Velocity = Root.CFrame.LookVector * 20 + Root.CFrame.UpVector * u71.Value;
                        end));
                    end;
                end;
            end;
        else
            local u72 = u61:Add(vfxUtil.createVFX(FrostGuard.Fall, "default", Root));
            u61:Add(task.delay(v64(0.6), function() -- Line: 602
                -- upvalues: mainreplication (ref), Root (copy)
                mainreplication.bodyVelocity(Root, -80, 0.3330000000000001, false, "RightVector", false, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In));
            end));
            u61:Add(task.delay(v64(0.9), function() -- Line: 605
                -- upvalues: soundUtil (ref), FrostGuard (copy), Root (copy), emit (ref), u72 (copy)
                soundUtil:play(FrostGuard.Sounds.Miss, Root, {
                    TimePosition = 0.1
                });
                emit(u72);
            end));
            u61:Add(task.delay(v64(0.933), function() -- Line: 609
                -- upvalues: mainreplication (ref), Root (copy)
                mainreplication.bodyVelocity(Root, -80, 0.3999999999999999, false, "RightVector", false, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out));
            end));
            u61:Add(task.delay(v64(1.333), function() -- Line: 612
                -- upvalues: emit (ref), u72 (copy), u61 (copy), vfxUtil (ref)
                emit(u72);
                u61:Add(task.delay(vfxUtil.getEmittersLifetime(u72), function() -- Line: 615
                    -- upvalues: u61 (ref)
                    u61:Destroy();
                end));
            end));

            if v60 then
                mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            end;
        end;
    else
        local v73 = u61:Add(vfxUtil.createVFX(FrostGuard.Jump, "default", Root));
        local u74 = u61:Clone(FrostGuard.BodyVFX);
        vfxUtil.setupAura(u57, u74, true);
        u74.Parent = workspace.Effects;
        local v75 = u61:Clone(FrostGuard.Spinning);
        v75.Parent = Root;

        if v60 then
            mainreplication.fov(true, 50, 0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        end;

        emit(u74.Head.Eyes);
        u61:Add(task.delay(0.033, emit, v73));
        u61:Add(task.delay(0.067, emit, u74["Right Leg"]));
        u61:Add(task.delay(0.083, emit, v75));
        u61:Add(task.delay(0.233, function() -- Line: 642
            -- upvalues: emit (ref), u74 (copy), u61 (copy), vfxUtil (ref)
            emit(u74["Left Leg"].Impact);
            u61:Add(task.delay(vfxUtil.getEmittersLifetime(u74), function() -- Line: 645
                -- upvalues: u61 (ref)
                u61:Destroy();
            end));
        end));
        mainreplication.bodyVelocity(Root, -125, 0.25, false, "RightVector", false, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out));
        soundUtil:play(FrostGuard.Sounds.Startup, Root);
    end;
end;

function v1.hioriChillingFeintAura(p76) -- Line: 656
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), trove (copy), mainreplication (copy)
    local hiori = vfxUtil.getResources().hiori;
    local v77 = LocalPlayer.Character == p76;
    local ChillingPass = hiori.ChillingPass;
    local u78 = trove.new();
    u78:AttachToInstance(p76);
    local HumanoidRootPart = p76:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart:FindFirstChild("SideSFX") then
        pcall(game.Destroy, HumanoidRootPart:FindFirstChild("SideSFX"));
    end;

    local v79 = u78:Construct(ChillingPass.CounterAura);
    v79.Parent = p76;
    vfxUtil.setupAura(p76, v79, true);

    if v77 then
        mainreplication.cameraShake(35, 1.5, 6);
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
    end;

    shared.vfx.emit(v79);
    u78:Add(task.delay(1.117, function() -- Line: 683
        -- upvalues: u78 (copy)
        u78:Destroy();
    end));
end;

function v1.hioriChillingPassFeint(u80, p81) -- Line: 694
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), trove (copy), u27 (copy), Util (copy), mainreplication (copy)
    local hiori = vfxUtil.getResources().hiori;
    local HumanoidRootPart = u80:FindFirstChild("HumanoidRootPart");
    local _ = LocalPlayer.Character == u80;
    local u82 = trove.new();
    local v83 = u27[u80];

    if v83 then
        v83:Destroy();
    end;

    u27[u80] = u82;
    u82:Add(function() -- Line: 295
        -- upvalues: u27 (ref), u80 (copy), u82 (copy)
        if u27[u80] == u82 then
            u27[u80] = nil;
        end;
    end);
    local v84 = u82:Construct(hiori.ChillingPass.CounterVFX);
    v84.RootPart.Weld.Part0 = HumanoidRootPart;
    v84.Parent = u80;

    if Util.canshiftcolor(LocalPlayer, u80) then
        vfxUtil.LeanTowardsColor(v84, u80:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u80:GetAttribute("CustomAlpha") or 0.985);
    end;

    if HumanoidRootPart:FindFirstChild("SideSFX") then
        pcall(game.Destroy, HumanoidRootPart:FindFirstChild("SideSFX"));
    end;

    mainreplication.highlight(p81, Color3.new(1, 0, 0), 0.5);
    u82:Add(task.delay(0.1, function() -- Line: 719
        -- upvalues: mainreplication (ref), HumanoidRootPart (copy)
        mainreplication.fov(true, 60, 0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
        mainreplication.bodyVelocity(HumanoidRootPart, 108, 0.24999999999999997, false, "RightVector");
    end));
    u82:Add(task.delay(0.483, function() -- Line: 724
        -- upvalues: mainreplication (ref), HumanoidRootPart (copy)
        mainreplication.fov(false, 100);
        mainreplication.ultFlash(0.5, 0.5, nil, Color3.new(0.666667, 1, 1));
        mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        mainreplication.bodyVelocity(HumanoidRootPart, 180, 1.2000000000000002);
    end));
    u82:Add(task.delay(0.433, shared.vfx.emit, v84.RootPart.Vfx2));
    u82:Add(task.delay(0.5, shared.vfx.emit, v84.RootPart.land, v84.RootPart.Dash, v84.RootPart.Attachment));
    u82:Add(task.delay(2.033, function() -- Line: 735
        -- upvalues: u82 (copy)
        u82:Destroy();
    end));
end;

function v1.hioriChillingPass(u85) -- Line: 740
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), trove (copy), RunService (copy), Util (copy), mainreplication (copy)
    local hiori = vfxUtil.getResources().hiori;
    local u86 = LocalPlayer.Character == u85;
    local ChillingPass = hiori.ChillingPass;
    local u87 = true;
    local u88 = trove.new();
    u88:AttachToInstance(u85);
    local HumanoidRootPart = u85:FindFirstChild("HumanoidRootPart");
    local Ball = u85:FindFirstChild("Ball");
    local u89 = u88:Construct(ChillingPass.PassVFX);
    u89:PivotTo(HumanoidRootPart.CFrame);
    u89.Parent = u85;
    local BallVFX = u89.BallVFX;
    BallVFX.Weld.Part0 = Ball or HumanoidRootPart;
    BallVFX.Parent = BallVFX.Weld.Part0;
    u88:Add(BallVFX);
    u88:Add(RunService.RenderStepped:Connect(function() -- Line: 762
        -- upvalues: u89 (copy), HumanoidRootPart (copy)
        u89:PivotTo(HumanoidRootPart.CFrame);
    end));
    u88:Add(u85:GetAttributeChangedSignal("StopHioriPassVFX"):Connect(function() -- Line: 766
        -- upvalues: u85 (copy), u87 (ref), u88 (copy)
        if not u85:GetAttribute("StopHioriPassVFX") then
            return;
        end;

        if not u87 then
            return;
        end;

        u88:Destroy();
    end));

    if Util.canshiftcolor(LocalPlayer, u85) then
        vfxUtil.LeanTowardsColor({ u89, BallVFX }, u85:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u85:GetAttribute("CustomAlpha") or 0.985);
    end;

    u88:Add(function() -- Line: 776
        -- upvalues: u86 (copy), mainreplication (ref)
        if u86 then
            mainreplication.fov(false, 70);
        end;
    end);

    if u86 then
        mainreplication.fov(true, 50, 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    end;

    shared.vfx.emit(BallVFX);
    u88:Add(task.delay(0.55, function() -- Line: 788
        -- upvalues: u86 (copy), mainreplication (ref), u87 (ref), u89 (copy)
        if u86 then
            mainreplication.fov(false, 100);
            mainreplication.bright(0.1, 0.3, Color3.new(0.396078, 0.756863, 1));
            mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        end;

        u87 = false;
        shared.vfx.emit(u89["Kick Mesh"]);
    end));
    u88:Add(task.delay(3, function() -- Line: 798
        -- upvalues: u88 (copy)
        u88:Destroy();
    end));
end;

local function GetVFX(p90: any, p91: number) -- Line: 803
    -- upvalues: vfxUtil (copy), RunService (copy)
    local hiori = vfxUtil.getResources().hiori;
    local v92 = p90:FindFirstChild("Hiori VFX");

    if v92 then
        v92:SetAttribute("Timer", v92:GetAttribute("Timer") + (p91 or 1));

        return v92;
    end;

    local u93 = hiori.LookAtAllThisIce.VFX:Clone();
    u93.Name = "Hiori VFX";
    vfxUtil.setupAura(p90, u93, true);
    u93.Parent = workspace.Effects;
    u93:SetAttribute("tick", tick());
    u93:SetAttribute("Timer", p91 or 1);
    local u94 = nil;
    u94 = RunService.Heartbeat:Connect(function() -- Line: 816
        -- upvalues: u93 (copy), u94 (ref)
        if tick() - u93:GetAttribute("tick") >= u93:GetAttribute("Timer") + 1 then
            u94:Disconnect();
            pcall(game.Destroy, u93);
        end;
    end);

    return u93;
end;

function v1.hioriIcePassRainbowFlick(p95) -- Line: 829
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), trove (copy), GetVFX (copy), mainreplication (copy)
    local hiori = vfxUtil.getResources().hiori;
    local u96 = LocalPlayer.Character == p95;
    local _ = hiori.LookAtAllThisIce;
    local Root = vfxUtil.getRoot(p95);
    local u97 = trove.new();
    u97:AttachToInstance(p95);
    local u98 = GetVFX(p95, 3);
    mainreplication.bodyVelocity(Root, 150, 1.37, false, nil, false, TweenInfo.new(1.37, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));

    if u96 then
        local v99 = mainreplication.bright(0.1, 0.6, Color3.new(0.396078, 0.756863, 1));
        v99.Brightness = 0.4;
        v99.Contrast = 1;
        v99.Saturation = -0.4;
    end;

    u97:Add(task.spawn(function() -- Line: 850
        -- upvalues: u98 (copy)
        shared.vfx.emit(u98.Head.Eyes, u98.Head.Spec24, u98.Head.Fire32, u98.Head.Fire17, u98["Left Arm"].Fire17, u98["Left Arm"].Fire32, u98["Left Arm"].Spec24, u98["Left Leg"].Fire17, u98["Left Leg"].Fire32, u98["Left Leg"].Spec24, u98["Right Arm"].Fire32, u98["Right Arm"].Fire17, u98["Right Arm"].Spec24, u98["Right Leg"].Fire32, u98["Right Leg"].Fire17, u98["Right Leg"].Spec24);
    end));
    u97:Add(task.delay(0.12, function() -- Line: 870
        -- upvalues: u98 (copy)
        shared.vfx.emit(u98.HumanoidRootPart.Attachment);
    end));
    u97:Add(task.delay(0.13, function() -- Line: 873
        -- upvalues: u98 (copy)
        shared.vfx.emit(u98.HumanoidRootPart.EReuse);
    end));
    u97:Add(task.delay(0.35, function() -- Line: 876
        -- upvalues: u98 (copy)
        shared.vfx.emit(u98.HumanoidRootPart.Fall2);
    end));
    u97:Add(task.delay(0.42, function() -- Line: 879
        -- upvalues: u98 (copy)
        shared.vfx.emit(u98.Head.Eyes, u98.Head.Spec24, u98.Head.Fire32, u98.Head.Fire17, u98["Left Arm"].Fire17, u98["Left Arm"].Fire32, u98["Left Arm"].Spec24, u98["Left Leg"].Fire17, u98["Left Leg"].Fire32, u98["Left Leg"].Spec24, u98["Right Arm"].Fire32, u98["Right Arm"].Fire17, u98["Right Arm"].Spec24, u98["Right Leg"].Fire32, u98["Right Leg"].Fire17, u98["Right Leg"].Spec24);
    end));
    local u100 = nil;
    u100 = p95.ChildAdded:Connect(function(p101) -- Line: 898
        -- upvalues: u100 (ref), u98 (copy), mainreplication (ref), u96 (copy)
        if p101.Name == "Ball" and p101:IsA("BasePart") then
            u100:Disconnect();
            shared.vfx.emit(u98.HumanoidRootPart.E3, u98.HumanoidRootPart.Shards2);
            mainreplication.fov(false, 50);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

            if u96 then
                local v102 = mainreplication.bright(0.15, 0.8, Color3.new(0.396078, 0.756863, 1));
                v102.Brightness = 0.4;
                v102.Contrast = 1;
                v102.Saturation = -0.4;
            end;
        end;
    end);
    u97:Add(task.delay(0.8, function() -- Line: 913
        -- upvalues: u100 (ref), mainreplication (ref)
        if u100 then
            u100:Disconnect();
            mainreplication.fov(false, 50);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end;
    end));
    u97:Add(task.delay(3, function() -- Line: 920
        -- upvalues: u97 (copy)
        u97:Destroy();
    end));
end;

local function isVectorNaN(p103) -- Line: 925
    return (p103.X ~= p103.X or p103.Y ~= p103.Y) and true or p103.Z ~= p103.Z;
end;

function v1.hioriIcePass(u104, p105) -- Line: 929
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), RunService (copy), mainreplication (copy), trove (copy), GetVFX (copy), Players (copy)
    local hiori = vfxUtil.getResources().hiori;
    local _ = LocalPlayer.Character == u104;
    local _ = hiori.LookAtAllThisIce;
    local Root = vfxUtil.getRoot(u104);
    local Root2 = vfxUtil.getRoot(p105);
    local u106 = nil;
    u104:SetAttribute("lockrotation", true);

    local function destroy_function() -- Line: 941
        -- upvalues: u106 (ref), u104 (copy)
        if u106 then
            u106:Disconnect();
            u106 = nil;
        end;

        if u104 then
            u104:SetAttribute("lockrotation", nil);
        end;
    end;

    u106 = RunService.PreRender:Connect(function(p107) -- Line: 951
        -- upvalues: Root (copy), u106 (ref), u104 (copy), Root2 (copy)
        if not Root then
            if u106 then
                u106:Disconnect();
                u106 = nil;
            end;

            if u104 then
                u104:SetAttribute("lockrotation", nil);
            end;

            return;
        end;

        if not Root2 then
            if u106 then
                u106:Disconnect();
                u106 = nil;
            end;

            if u104 then
                u104:SetAttribute("lockrotation", nil);
            end;

            return;
        end;

        if Root.Anchored then
            if u106 then
                u106:Disconnect();
                u106 = nil;
            end;

            if u104 then
                u104:SetAttribute("lockrotation", nil);
            end;

            return;
        end;

        if Root2.Anchored then
            if u106 then
                u106:Disconnect();
                u106 = nil;
            end;

            if u104 then
                u104:SetAttribute("lockrotation", nil);
            end;

            return;
        end;

        if u104:GetAttribute("frozen") then
            if u106 then
                u106:Disconnect();
                u106 = nil;
            end;

            if u104 then
                u104:SetAttribute("lockrotation", nil);
            end;

            return;
        end;

        if u104:GetAttribute("nostaredown") then
            if u106 then
                u106:Disconnect();
                u106 = nil;
            end;

            if u104 then
                u104:SetAttribute("lockrotation", nil);
            end;

            return;
        end;

        local CFrame_lookAt_ret = CFrame.lookAt(Root.Position, (Vector3.new(Root2.Position.X, Root.Position, Root2.Position.Z)));
        local Position = CFrame_lookAt_ret.Position;

        if Position.X == Position.X and Position.Y == Position.Y and Position.Z == Position.Z then
            local v108, v109, v110 = CFrame_lookAt_ret:ToEulerAnglesYXZ();
            local v111, v112, v113 = Root.CFrame:ToEulerAnglesYXZ();
            Root.CFrame = CFrame.new(Root.Position) * CFrame.fromEulerAnglesYXZ(v111, v112, v113):Lerp(CFrame.fromEulerAnglesYXZ(v108, v109, v110), 8 * p107);
        end;
    end);
    mainreplication.fov(false, 60);
    mainreplication.fov(true, 70, 0.31, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    local u114 = trove.new();
    u114:AttachToInstance(u104);
    local u115 = GetVFX(u104, 3);
    u114:Add(function() -- Line: 976
        -- upvalues: u106 (ref)
        if u106 then
            u106:Disconnect();
            u106 = nil;
        end;
    end);
    u114:Add(task.spawn(function() -- Line: 983
        -- upvalues: u115 (copy)
        shared.vfx.emit(u115.Head.Eyes);
    end));
    u114:Add(task.delay(0.01, function() -- Line: 986
        -- upvalues: u115 (copy)
        shared.vfx.emit(u115["Right Leg"].Spec24, u115["Right Leg"].Fire32, u115["Right Leg"].Fire17);
    end));
    u114:Add(task.delay(0.32, function() -- Line: 992
        -- upvalues: u115 (copy), Players (ref), u104 (copy), mainreplication (ref)
        shared.vfx.emit(u115.HumanoidRootPart.E);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u104) then
            mainreplication.springcamerashake(25, 40);
        end;
    end));
    u114:Add(task.delay(0.5, function() -- Line: 998
        -- upvalues: u106 (ref), u104 (copy)
        if u106 then
            u106:Disconnect();
            u106 = nil;
        end;

        if u104 then
            u104:SetAttribute("lockrotation", nil);
        end;
    end));
    u114:Add(task.delay(3, function() -- Line: 1001
        -- upvalues: u114 (copy)
        u114:Destroy();
    end));
end;

function v1.hioriStareDown(u116: any, p117: any, p118: number?) -- Line: 1006
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), trove (copy), RunService (copy)
    local hiori = vfxUtil.getResources().hiori;
    local _ = LocalPlayer.Character == u116;
    local _ = hiori.LookAtAllThisIce;
    local Root = vfxUtil.getRoot(u116);
    local Root2 = vfxUtil.getRoot(p117);
    local u119 = nil;
    local u120 = trove.new();
    u120:AttachToInstance(u116);
    u116:SetAttribute("lockrotation", true);

    local function _() -- Line: 1021
        -- upvalues: u119 (ref), u116 (copy)
        if u119 then
            u119:Disconnect();
            u119 = nil;
        end;

        if u116 then
            u116:SetAttribute("lockrotation", nil);
        end;
    end;

    u119 = RunService.PreRender:Connect(function(p121) -- Line: 1034
        -- upvalues: Root (copy), u120 (copy), Root2 (copy), u116 (copy)
        if not Root then
            u120:Destroy();

            return;
        end;

        if not Root2 then
            u120:Destroy();

            return;
        end;

        if Root2.Anchored then
            u120:Destroy();

            return;
        end;

        if Root.Anchored then
            u120:Destroy();

            return;
        end;

        if u116:GetAttribute("frozen") then
            u120:Destroy();

            return;
        end;

        if u116:GetAttribute("nostaredown") then
            u120:Destroy();

            return;
        end;

        local CFrame_lookAt_ret = CFrame.lookAt(Root.Position, (Vector3.new(Root2.Position.X, Root.Position, Root2.Position.Z)));
        local Position = CFrame_lookAt_ret.Position;

        if Position.X == Position.X and Position.Y == Position.Y and Position.Z == Position.Z then
            local v122, v123, v124 = CFrame_lookAt_ret:ToEulerAnglesYXZ();
            local v125, v126, v127 = Root.CFrame:ToEulerAnglesYXZ();
            Root.CFrame = CFrame.new(Root.Position) * CFrame.fromEulerAnglesYXZ(v125, v126, v127):Lerp(CFrame.fromEulerAnglesYXZ(v122, v123, v124), 8 * p121);
        end;
    end);
    u120:Add(u119);
    u120:Add(function() -- Line: 1053
        -- upvalues: u119 (ref), u116 (copy)
        if u119 then
            u119:Disconnect();
            u119 = nil;
        end;

        if u116 then
            u116:SetAttribute("lockrotation", nil);
        end;
    end);
    u120:Add(task.delay(p118 or 1, function() -- Line: 1057
        -- upvalues: u120 (copy)
        u120:Destroy();
    end));
end;

function v1.hioriIceShot(u128) -- Line: 1062
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), trove (copy), GetVFX (copy), Players (copy), mainreplication (copy)
    local hiori = vfxUtil.getResources().hiori;
    local _ = LocalPlayer.Character == u128;
    local _ = hiori.LookAtAllThisIce;
    vfxUtil.getRoot(u128);
    local u129 = trove.new();
    u129:AttachToInstance(u128);
    local u130 = GetVFX(u128, 3);
    u129:Add(task.spawn(function() -- Line: 1077
        -- upvalues: u130 (copy)
        shared.vfx.emit(u130.Head.Eyes, u130["Right Leg"].Fire17, u130["Right Leg"].Fire32, u130["Right Leg"].Spec24);
    end));
    u129:Add(task.delay(0.01, function() -- Line: 1084
        -- upvalues: u130 (copy)
        shared.vfx.emit(u130.HumanoidRootPart.Start);
    end));
    u129:Add(task.delay(0.02, function() -- Line: 1087
        -- upvalues: u130 (copy)
        shared.vfx.emit(u130["Right Leg"].E3, u130["Right Leg"].E2, u130["Right Leg"].E);
    end));
    u129:Add(task.delay(0.22, function() -- Line: 1092
        -- upvalues: u130 (copy)
        shared.vfx.emit(u130.HumanoidRootPart.E);
    end));
    u129:Add(task.delay(0.23, function() -- Line: 1095
        -- upvalues: u130 (copy), Players (ref), u128 (copy), mainreplication (ref)
        shared.vfx.emit(u130.HumanoidRootPart.Start["Wind "].StartUp.GroundAttachment);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u128) then
            mainreplication.springcamerashake(30, 20);
            mainreplication.fov(false, 45);
            mainreplication.fov(true, 70, 0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end;
    end));
    u129:Add(task.delay(3, function() -- Line: 1103
        -- upvalues: u129 (copy)
        u129:Destroy();
    end));
end;

local ExposureCompensation2 = Lighting.ExposureCompensation;

function v1.hioriFlow(u131: any, p132: boolean) -- Line: 1110
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), trove (copy), Lighting (copy), ExposureCompensation2 (copy), soundUtil (copy), mainreplication (copy), RunService (copy), TekrinnDialogue (copy), Ambient (copy), Brightness (copy), ColorShift_Top (copy), EnvironmentDiffuseScale (copy), EnvironmentSpecularScale (copy), OutdoorAmbient (copy), ShadowSoftness (copy), ClockTime (copy), MoonPropertyAnimator (copy)
    local hiori = vfxUtil.getResources().hiori;
    local _ = LocalPlayer.Character == u131;
    local Flow = hiori.Flow;
    local Root = vfxUtil.getRoot(u131);
    local Ball = u131:WaitForChild("Ball");
    Ball.Size = Vector3.new(1.5, 1.5, 1.5);
    local u133 = trove.new();
    u133:AttachToInstance(u131);
    u133:Add(function() -- Line: 1124
        -- upvalues: Lighting (ref), ExposureCompensation2 (ref)
        Lighting.ExposureCompensation = ExposureCompensation2;
    end);
    local u134 = u133:Construct(Flow.VFX);
    local v135 = u133:Construct(Flow.Aura);

    if p132 then
        vfxUtil.LeanTowardsColor(u134, Color3.fromRGB(170, 0, 0), 1);
        vfxUtil.LeanTowardsColor(v135, Color3.fromRGB(170, 0, 0), 1);
    end;

    soundUtil:play(p132 and Flow["SFX-RNP"] or Flow.SFX, soundUtil);
    vfxUtil.setupAura(u131, v135, true);
    u134.Parent = workspace.Effects;
    v135.Parent = workspace.Effects;
    local u136, u137 = mainreplication.cutsceneBlender(Root, Flow.Animations.Camera, Flow.FOV, nil, nil, nil, Flow.Camera);
    local v138 = u133:Add(vfxUtil.getMoonEffects());
    local u139 = {};
    local u140 = {};
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.Brightness = 3;
    Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
    Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0);
    Lighting.EnvironmentDiffuseScale = 1;
    Lighting.EnvironmentSpecularScale = 1;
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ShadowSoftness = 0.2;
    Lighting.ClockTime = 14.5;
    u133:Add(RunService.Heartbeat:Connect(function() -- Line: 1158
        -- upvalues: Root (copy), u134 (copy)
        local CFrame2 = Root.CFrame;
        local LookVector = CFrame2.LookVector;
        local Position = CFrame2.Position;
        u134:PivotTo(CFrame.new(Position, Position + Vector3.new(LookVector.X, 0, LookVector.Z)));
    end));

    if p132 then
        u133:Add(task.delay(0.11, function() -- Line: 1166
            -- upvalues: u133 (copy), TekrinnDialogue (ref), u131 (copy)
            u133:Add(TekrinnDialogue.Speak(u131, {
                {
                    Text = "Is my situation dire?",
                    TypeSpeed = 0.07,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                }
            }, 2));
        end));
        u133:Add(task.delay(4.305, function() -- Line: 1178
            -- upvalues: u133 (copy), TekrinnDialogue (ref), u131 (copy)
            u133:Add(TekrinnDialogue.Speak(u131, {
                {
                    Text = "I think im confused.",
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                }
            }, 2));
        end));
        u133:Add(task.delay(6.5, function() -- Line: 1191
            -- upvalues: u133 (copy), TekrinnDialogue (ref), u131 (copy)
            u133:Add(TekrinnDialogue.Speak(u131, {
                {
                    Text = "You only have four people here..",
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                }
            }, 2));
        end));
        u133:Add(task.delay(10.09, function() -- Line: 1206
            -- upvalues: u133 (copy), TekrinnDialogue (ref), u131 (copy)
            u133:Add(TekrinnDialogue.Speak(u131, {
                {
                    Text = "That\'s not enough to stop me.",
                    TypeSpeed = 0.04,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                }
            }, 5));
        end));
    else
        u133:Add(task.delay(0.11, function() -- Line: 1222
            -- upvalues: u133 (copy), TekrinnDialogue (ref), u131 (copy)
            u133:Add(TekrinnDialogue.Speak(u131, {
                {
                    Text = "I\'m neither a ninja nor a sprinter.",
                    TypeSpeed = 0.045,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.666667, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                }
            }, 2));
        end));
        u133:Add(task.delay(4.305, function() -- Line: 1235
            -- upvalues: u133 (copy), TekrinnDialogue (ref), u131 (copy)
            u133:Add(TekrinnDialogue.Speak(u131, {
                {
                    Text = "So I compete a different way.",
                    TypeSpeed = 0.025,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.666667, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                }
            }, 2));
        end));
        u133:Add(task.delay(6.5, function() -- Line: 1248
            -- upvalues: u133 (copy), TekrinnDialogue (ref), u131 (copy)
            u133:Add(TekrinnDialogue.Speak(u131, {
                {
                    Text = "Being relentless... ",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.666667, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                }
            }, 2));
        end));
        u133:Add(task.delay(10.09, function() -- Line: 1262
            -- upvalues: u133 (copy), TekrinnDialogue (ref), u131 (copy)
            u133:Add(TekrinnDialogue.Speak(u131, {
                {
                    Text = "isn\'t the only type of ego.",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.666667, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                }
            }, 3));
        end));
    end;

    for _, child in Flow.Ball:GetChildren() do
        local v141 = child:Clone();
        v141.Parent = child;
        table.insert(u139, v141);
    end;

    local u142 = {};

    for _, child in Lighting:GetChildren() do
        if Flow.Lighting:FindFirstChildWhichIsA(child.ClassName) then
            table.insert(u142, child);
            child.Parent = workspace;
        end;
    end;

    for _, child in Flow.Lighting:GetChildren() do
        local v143 = child:Clone();
        v143.Parent = Lighting;
        u140[v143.Name] = v143;
    end;

    mainreplication.sceneEnabled(true);
    u133:Add(function() -- Line: 1303
        -- upvalues: mainreplication (ref), u136 (copy), u137 (copy), u139 (copy), u142 (copy), Lighting (ref), u140 (copy), Ball (copy), Ambient (ref), Brightness (ref), ColorShift_Top (ref), EnvironmentDiffuseScale (ref), EnvironmentSpecularScale (ref), OutdoorAmbient (ref), ShadowSoftness (ref), ClockTime (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);

        if u136 then
            u137();
        end;

        for _, v in u139 do
            pcall(game.Destroy, v);
        end;

        for _, v in u142 do
            pcall(function() -- Line: 1313
                -- upvalues: v (copy), Lighting (ref)
                v.Parent = Lighting;
            end);
        end;

        for _, v in u140 do
            pcall(game.Destroy, v);
        end;

        if Ball then
            Ball.Size = Vector3.new(1.95, 1.95, 1.95);
        end;

        Lighting.Ambient = Ambient;
        Lighting.Brightness = Brightness;
        Lighting.ColorShift_Top = ColorShift_Top;
        Lighting.ColorShift_Bottom = ColorShift_Top;
        Lighting.EnvironmentDiffuseScale = EnvironmentDiffuseScale;
        Lighting.EnvironmentSpecularScale = EnvironmentSpecularScale;
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.ShadowSoftness = ShadowSoftness;
        Lighting.ClockTime = ClockTime;
    end);
    local v144 = u133:Clone(Flow["Screen Flash"]);
    local v145 = u133:Clone(Flow["red vignette"]);
    v144.Parent = LocalPlayer.PlayerGui;
    v145.Parent = LocalPlayer.PlayerGui;
    local v146 = {
        Ball = Ball,
        TuffCharacterRig = v135,
        Workspace = u134,
        Vignette = v138.Vignette,
        ["Screen Flash"] = v144,
        ["red vignette"] = v145
    };
    local v147 = u133:Construct(MoonPropertyAnimator);
    v147:LoadSave(Flow.Moon, MoonPropertyAnimator.ConvertSave(Flow.Moon, v146));
    v147:PlayAll();

    for _, v in require(Flow.Module) do
        u133:Add(task.delay(v[1] / 60, v[2], u134, v135, Ball, u140));
    end;

    u133:Add(task.delay(11.39, function() -- Line: 1358
        -- upvalues: u133 (copy)
        u133:Destroy();
    end));
end;

function v1.hioriChillingPassFlow(u148) -- Line: 1363
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), VfxHandler (copy), Lighting (copy), Util (copy), LocalPlayer (copy), soundUtil (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy), TweenService (copy)
    local hiori = vfxUtil.getResources().hiori;
    local HumanoidRootPart = u148:FindFirstChild("HumanoidRootPart");
    u148:FindFirstChild("Torso");
    u148:FindFirstChild("Head");
    local ChillingPassFlow = hiori.ChillingPassFlow;
    local u149 = trove.new();
    u149:AttachToInstance(u148);
    mainreplication.sceneEnabled(true);
    local u150 = u149:Construct(ChillingPassFlow.VFX);
    u150.Parent = u148;
    u150:PivotTo(HumanoidRootPart.CFrame);
    local u151 = VfxHandler.HideMap("MapOnly");
    local v152 = u149:Construct(ChillingPassFlow.Aura);
    v152.Parent = u148;
    vfxUtil.setupAura(u148, v152);
    local ClockTime2 = Lighting.ClockTime;
    local v153 = {
        Lighting = Lighting
    };

    for _, child in ChillingPassFlow.Lighting:GetChildren() do
        local v154 = u149:Construct(child);
        v154.Parent = Lighting;
        v153[v154.Name] = v154;
    end;

    if Util.canshiftcolor(LocalPlayer, u148) then
        vfxUtil.LeanTowardsColor({ u150, v152 }, u148:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u148:GetAttribute("CustomAlpha") or 0.985);
    end;

    local v155 = u148:GetAttribute("RinNoPlay") == true;
    soundUtil:play(v155 and ChillingPassFlow.Rnp or ChillingPassFlow.Sound, soundUtil);

    if v155 then
        TekrinnDialogue.Speak(u148, {
            {
                Text = "All of you are",
                Italic = true,
                TypeSpeed = 0.07,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        });
        task.delay(1.8, function() -- Line: 1416
            -- upvalues: TekrinnDialogue (ref), u148 (copy)
            TekrinnDialogue.Speak(u148, {
                {
                    Text = "Nothing but tools to me.",
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.2
                    }
                }
            });
        end);
    else
        TekrinnDialogue.Speak(u148, {
            {
                Text = "Yer one loud ",
                Italic = true,
                TypeSpeed = 0.045,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.666667, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            },
            {
                Text = "Crow",
                Bold = true,
                TypeSpeed = 0.045,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.137255, 0.756863)), ColorSequenceKeypoint.new(1, Color3.new(0.25098, 0.00392157, 0.619608)) })
            },
            {
                Text = ", are ya?",
                Italic = true,
                TypeSpeed = 0.045,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.666667, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        });
    end;

    local v156 = mainreplication.cutsceneCamRigWithLetterBox(HumanoidRootPart, ChillingPassFlow.Animations.Camera, ChillingPassFlow.FOV, nil, nil, ChillingPassFlow.CameraRig, "CamPart");
    pcall(u149.Add, u149, v156);
    local v157 = u149:Construct(MoonPropertyAnimator);
    v157:LoadSave(ChillingPassFlow.MoonFile, MoonPropertyAnimator.ConvertSave(ChillingPassFlow.MoonFile, v153));
    v157:SetRoot(HumanoidRootPart);
    v157:PlayAll();
    shared.vfx.emit(u150.RootPart.Kick.Wind, u150.RootPart.Kick.Smoke);
    u149:Add(function() -- Line: 1480
        -- upvalues: Lighting (ref), ClockTime2 (copy)
        Lighting.ClockTime = ClockTime2;
    end);
    u149:Add(task.delay(1.6, function() -- Line: 1483
        -- upvalues: u150 (copy), VfxHandler (ref), u151 (copy)
        pcall(game.Destroy, u150.Tunnel);
        VfxHandler.ShowMap(u151);
    end));
    u149:Add(task.delay(1.833, shared.vfx.emit, u150.RootPart.Kick));
    u149:Add(task.delay(3.2, function() -- Line: 1489
        -- upvalues: u149 (copy), Lighting (ref), TweenService (ref)
        local v158 = u149:Construct(Instance, "ColorCorrectionEffect");
        v158.Parent = Lighting;
        TweenService:Create(v158, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = -1
        }):Play();
    end));
    u149:Add(function() -- Line: 1495
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1);
    end);
    u149:Add(task.delay(3.7, function() -- Line: 1500
        -- upvalues: u149 (copy)
        u149:Destroy();
    end));
end;

local u159 = nil;
local workspace_map = workspace.map;
local fieldZoneSafe = workspace_map:FindFirstChild("fieldZoneSafe", true);
local gkzone = workspace_map:FindFirstChild("gkzone", true);
local Size = fieldZoneSafe.Size;
local u160 = CFrame.new(0, 0, -10) * CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0);

local function rayPlane(p161, p162, p163, p164) -- Line: 1518
    local v165 = p164:Dot(p162);

    if math.abs(v165) < 0.00001 then
        return p163;
    end;

    return p161 + p162 * (p164:Dot(p163 - p161) / v165);
end;

local function scaleXZ(p166, p167, p168) -- Line: 1526
    return Vector3.new(p166.X * p167, 0, p166.Z * p168);
end;

local function clampRect(p169, p170, p171) -- Line: 1530
    local math_clamp_ret = math.clamp(p169.X, -p170, p170);
    local math_clamp_ret2 = math.clamp(p169.Z, -p171, p171);

    return Vector3.new(math_clamp_ret, 0, math_clamp_ret2);
end;

local function isOnField(p172) -- Line: 1538
    -- upvalues: fieldZoneSafe (copy), Size (copy)
    local v173 = fieldZoneSafe.CFrame:PointToObjectSpace(p172);
    local v174;

    if math.abs(v173.X) <= Size.X * 0.5 then
        v174 = math.abs(v173.Z) <= Size.Z * 0.5;
    else
        v174 = false;
    end;

    return v174;
end;

function v1.hioriNoLookAlleyCross(u175) -- Line: 1546
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), trove (copy), Lighting (copy), MoonPropertyAnimator (copy), u159 (ref), TweenService (copy), fieldZoneSafe (copy), Size (copy), actionUtil (copy), RunService (copy), workspace_CurrentCamera (copy), u160 (copy), UserInputService (copy), gkzone (copy), TekrinnDialogue (copy)
    local NoLookAlleyPass = vfxUtil.getResources().hiori.NoLookAlleyPass;
    local Root = vfxUtil.getRoot(u175);
    local u176 = vfxUtil.isLocalPlayer(u175);
    mainreplication.sceneEnabled(true);
    soundUtil:play(NoLookAlleyPass.SFX, soundUtil);
    local u177 = trove.new();
    u177:AttachToInstance(u175);
    u177:Add(function() -- Line: 1559
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(1);
        mainreplication.sceneEnabled(false);
    end);
    u177:Add(task.delay(4.5, function() -- Line: 1563
        -- upvalues: u177 (copy)
        u177:Destroy();
    end));
    local v178 = u177:Clone(NoLookAlleyPass.CharacterFX);
    vfxUtil.setupAura(u175, v178, true);
    v178.Parent = workspace.Effects;
    local u179 = u177:Clone(NoLookAlleyPass.VFX);
    u179:PivotTo(Root.CFrame);
    u179.Parent = workspace.Effects;
    local v180 = u177:Add(mainreplication.kuronaCam(Root, NoLookAlleyPass.Cam, NoLookAlleyPass.FOV, function() -- Line: 1575
        -- upvalues: u179 (copy), Root (copy)
        u179:PivotTo(Root.CFrame);
    end));
    local v181 = u177:Add(vfxUtil.getMoonEffects());
    local v182 = u177:Clone(NoLookAlleyPass.Lighting.ColorCorrection);
    v182.Parent = Lighting;
    local v183 = u177:Construct(MoonPropertyAnimator);
    v183:LoadAndConvertSave(NoLookAlleyPass.Moon, {
        Vignette = v181.Vignette,
        ColorCorrection = v182,
        Workspace = u179
    });
    v183:SetOriginalRoot(NoLookAlleyPass.VFX.Root.CFrame);
    v183:SetRoot(Root);
    v183:PlayAll();

    if not u159 then
        u159 = require(NoLookAlleyPass.Compiled);
    end;

    for _, v in u159 do
        u177:Add(task.delay(v[1] / 60, v[2], v178, v180));
    end;

    local u184 = nil;
    u177:Add(task.delay(u176 and 0.8 or 1.6, function() -- Line: 1601
        -- upvalues: u184 (ref), u177 (copy), NoLookAlleyPass (copy), TweenService (ref), u176 (copy), fieldZoneSafe (ref), Size (ref), u175 (copy), actionUtil (ref), RunService (ref), workspace_CurrentCamera (ref), u160 (ref), UserInputService (ref), gkzone (ref)
        u184 = u177:Extend();
        local u185 = NoLookAlleyPass.HField:Clone();
        u185.Parent = workspace.Effects;
        u184:Add(function() -- Line: 1607
            -- upvalues: u185 (copy), TweenService (ref), u177 (ref)
            print("Death");

            for _, descendant in u185:GetDescendants() do
                if descendant:IsA("BasePart") or (descendant:IsA("CylinderHandleAdornment") or (descendant:IsA("Texture") or descendant:IsA("SelectionBox"))) then
                    TweenService:Create(descendant, TweenInfo.new(1), {
                        Transparency = 1
                    }):Play();

                    if descendant:IsA("SelectionBox") then
                        TweenService:Create(descendant, TweenInfo.new(1), {
                            SurfaceTransparency = 1
                        }):Play();
                    end;
                end;
            end;

            u177:Add(u185);
            task.delay(1, function() -- Line: 1618
                -- upvalues: u177 (ref), u185 (ref)
                u177:Remove(u185);
            end);
        end);
        local Base = u185.Base;
        local Marker = u185.Marker;
        local Shield = u185.Shield;
        Marker.Transparency = u176 and 0 or 1;
        Base.Size = Vector3.new(6.4235797, 0.001, 8.65636);
        Shield.Transparency = 1;
        local u186 = math.max(Marker.Size.Y, Marker.Size.Z) * 0.5;
        local v187 = {};

        for _, child in workspace.characters:GetChildren() do
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                local v188 = fieldZoneSafe.CFrame:PointToObjectSpace(HumanoidRootPart.Position);
                local v189;

                if math.abs(v188.X) <= Size.X * 0.5 then
                    v189 = math.abs(v188.Z) <= Size.Z * 0.5;
                else
                    v189 = false;
                end;

                if v189 then
                    local v190 = NoLookAlleyPass[`{child == u175 and "Hiori" or (actionUtil.checksameTeam(u175, child) and "Teammate" or "Opponent")}Marker`]:Clone();
                    local v191 = fieldZoneSafe.CFrame:PointToObjectSpace(HumanoidRootPart.Position);
                    local Vector3_new_ret = Vector3.new(v191.X, 0, v191.Z);
                    local Vector3_new_ret2 = Vector3.new(Vector3_new_ret.X * (Base.Size.X / Size.X), 0, Vector3_new_ret.Z * (Base.Size.Z / Size.Z));
                    v190.CFrame = Base.CFrame * CFrame.new(Vector3_new_ret2) * CFrame.new(0, 0.025, 0) * CFrame.Angles(0, 0, 1.5707963267948966);
                    v190.Parent = u185;
                    v187[child] = v190;
                end;
            end;
        end;

        local u192 = 0;
        local u193 = false;
        local u194 = nil;
        u184:Connect(RunService.RenderStepped, function(p195) -- Line: 1669
            -- upvalues: u192 (ref), TweenService (ref), u193 (ref), Shield (copy), u185 (copy), Base (copy), workspace_CurrentCamera (ref), u160 (ref), Size (ref), u186 (copy), UserInputService (ref), u194 (ref), gkzone (ref), fieldZoneSafe (ref), u175 (ref), Marker (copy)
            u192 = u192 + p195;
            local Value = TweenService:GetValue(math.clamp(u192 / 1.5, 0, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out);
            local Value2 = TweenService:GetValue(math.clamp(u192 / 1.45, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);

            if Value2 >= 1 and not u193 then
                u193 = true;
                TweenService:Create(Shield, TweenInfo.new(2), {
                    Transparency = 0
                }):Play();
            end;

            u185:ScaleTo((math.lerp(0.01, 1, Value)));
            Base.Size = Vector3.new(Base.Size.X, 0, Base.Size.Z);
            local v196 = workspace_CurrentCamera.CFrame * u160;
            local CFrame_Angles = CFrame.Angles;
            local math_lerp_ret = math.lerp(90, 0, Value2);
            local math_rad_ret = math.rad(math_lerp_ret);
            local math_lerp_ret2 = math.lerp(90, 0, Value2);
            u185:PivotTo(v196 * CFrame_Angles(math_rad_ret, math.rad(math_lerp_ret2), 0));
            local v197 = Size.X / Base.Size.X;
            local v198 = Size.Z / Base.Size.Z;
            local v199 = Base.Size.X / Size.X;
            local v200 = Base.Size.Z / Size.Z;
            local v201 = u186 * v197;
            local v202 = u186 * v198;
            local v203 = Size.X * 0.5 - v201;
            local v204 = Size.Z * 0.5 - v202;
            local MouseLocation = UserInputService:GetMouseLocation();
            local v205 = workspace_CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y);
            local Origin = v205.Origin;
            local Direction = v205.Direction;
            local Position = Base.Position;
            local UpVector = Base.CFrame.UpVector;
            local v206 = UpVector:Dot(Direction);

            if math.abs(v206) >= 0.00001 then
                Position = Origin + Direction * (UpVector:Dot(Position - Origin) / v206);
            end;

            local v207 = Base.CFrame:PointToObjectSpace(Position);
            local Vector3_new_ret = Vector3.new(v207.X, 0, v207.Z);
            local Vector3_new_ret2 = Vector3.new(Vector3_new_ret.X * v197, 0, Vector3_new_ret.Z * v198);

            if not u194 then
                local math_clamp_ret = math.clamp(Vector3_new_ret2.X, -v203, v203);
                local math_clamp_ret2 = math.clamp(Vector3_new_ret2.Z, -v204, v204);
                u194 = Vector3.new(math_clamp_ret, 0, math_clamp_ret2);
            end;

            local v208 = Vector3_new_ret2 - u194;
            local v209 = u194;

            for _, child in gkzone:GetChildren() do
                if child:IsA("BasePart") then
                    local v210 = child.Size.X * 0.5 + v201;
                    local v211 = child.Size.Z * 0.5 + v202;
                    local v212 = fieldZoneSafe.CFrame:PointToWorldSpace(v209);
                    local v213 = child.CFrame:PointToObjectSpace(v212);

                    if math.abs(v213.X) <= v210 and math.abs(v213.Z) <= v211 then
                        local v214;

                        if v210 - math.abs(v213.X) < v211 - math.abs(v213.Z) then
                            local math_sign_ret = math.sign(v213.X);
                            v214 = Vector3.new(math_sign_ret, 0, 0);
                        else
                            local math_sign_ret = math.sign(v213.Z);
                            v214 = Vector3.new(0, 0, math_sign_ret);
                        end;

                        local v215 = child.CFrame.Rotation * v214;
                        local v216 = fieldZoneSafe.CFrame.Rotation:Inverse() * v215;
                        local v217 = v208:Dot(v216);

                        if v217 < 0 then
                            v208 = v208 - v216 * v217;
                        end;
                    end;
                end;
            end;

            local v218 = v209 + v208;
            local math_clamp_ret = math.clamp(v218.X, -v203, v203);
            local math_clamp_ret2 = math.clamp(v218.Z, -v204, v204);
            local Vector3_new_ret3 = Vector3.new(math_clamp_ret, 0, math_clamp_ret2);
            local HumanoidRootPart = u175:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                local v219 = fieldZoneSafe.CFrame:PointToObjectSpace(HumanoidRootPart.Position);
                local Vector3_new_ret4 = Vector3.new(v219.X, 0, v219.Z);
                local v220 = Vector3_new_ret3 - Vector3_new_ret4;

                if v220.Magnitude > 550 then
                    Vector3_new_ret3 = Vector3_new_ret4 + v220.Unit * 550;
                end;
            end;

            u194 = Vector3_new_ret3;
            local Vector3_new_ret4 = Vector3.new(Vector3_new_ret3.X * v199, 0, Vector3_new_ret3.Z * v200);
            Marker.CFrame = Base.CFrame * CFrame.new(Vector3_new_ret4) * CFrame.new(0, 0.025, 0) * CFrame.Angles(0, 0, 1.5707963267948966);
            shared.hioriMarker = fieldZoneSafe.CFrame * CFrame.new(Vector3_new_ret3.X, 3, Vector3_new_ret3.Z);
        end);
    end));
    u177:Add(task.delay(0.496, function() -- Line: 1797
        -- upvalues: u177 (copy), TekrinnDialogue (ref), u175 (copy)
        u177:Add(TekrinnDialogue.Speak(u175, {
            {
                Text = "Ah...",
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.666667, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 0.921));
    end));
    u177:Add(task.delay(3.141, function() -- Line: 1811
        -- upvalues: u184 (ref), u177 (copy), TekrinnDialogue (ref), u175 (copy)
        if u184 then
            u177:Remove(u184);
        end;

        u177:Add(TekrinnDialogue.Speak(u175, {
            {
                Text = "Let\'s go.",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.666667, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 0.577));
    end));
end;

function v1.NELisagiXKaiserXiSAGI(u221, p222) -- Line: 1830
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), soundUtil (copy), trove (copy), mainreplication (copy), RunService (copy), TekrinnDialogue (copy), Lighting (copy), Ambient (copy), Brightness (copy), ColorShift_Top (copy), EnvironmentDiffuseScale (copy), EnvironmentSpecularScale (copy), OutdoorAmbient (copy), ShadowSoftness (copy), MoonPropertyAnimator (copy)
    local nelisagi = vfxUtil.getResources().nelisagi;
    local _ = LocalPlayer.Character == u221;
    local v223 = nelisagi["isagi n kaiser"];
    local Root = vfxUtil.getRoot(u221);
    local u224 = soundUtil:play(v223.Sound, soundUtil, {
        Character = u221
    }).Name == "Dub";
    local Ball = u221:WaitForChild("Ball");
    Ball.Size = Vector3.new(1.5, 1.5, 1.5);
    local u225 = trove.new();
    u225:AttachToInstance(u221);
    local u226 = u225:Construct(v223.VFX);
    local v227 = u225:Construct(v223.Isagi);
    local v228 = u225:Construct(v223.Kaiser);
    mainreplication.sceneEnabled(true);
    v228.Parent = workspace.Effects;
    v227.Parent = workspace.Effects;
    u226.Parent = workspace.Effects;
    vfxUtil.setupAura(u221, v227, true);
    vfxUtil.setupAura(p222, v228, true);
    u225:Add(RunService.Heartbeat:Connect(function() -- Line: 1861
        -- upvalues: u226 (copy), Root (copy)
        u226:PivotTo(CFrame.new(Root.Position, Root.Position + Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z)));
    end));
    u225:Add(task.delay(0.183, function() -- Line: 1865
        -- upvalues: u224 (copy), u225 (copy), TekrinnDialogue (ref), u221 (copy)
        if not u224 then
            return;
        end;

        u225:Add(TekrinnDialogue.Speak(u221, {
            {
                Text = "I can do this!",
                TypeSpeed = 0.025,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 1.6));
    end));
    u225:Add(task.delay(2.067, function() -- Line: 1879
        -- upvalues: u224 (copy), u225 (copy), TekrinnDialogue (ref), u221 (copy)
        if not u224 then
            return;
        end;

        u225:Add(TekrinnDialogue.Speak(u221, {
            {
                Text = "This..",
                TypeSpeed = 0.08,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 0.9));
    end));
    u225:Add(task.delay(3.1, function() -- Line: 1893
        -- upvalues: u224 (copy), u225 (copy), TekrinnDialogue (ref), u221 (copy)
        if not u224 then
            return;
        end;

        u225:Add(TekrinnDialogue.Speak(u221, {
            {
                Text = "is our ",
                TypeSpeed = 0.08,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            },
            {
                Text = "last chance.",
                Bold = true,
                TypeSpeed = 0.08,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0)) })
            }
        }, 2.6));
    end));
    u225:Add(task.delay(6.05, function() -- Line: 1916
        -- upvalues: u224 (copy), u225 (copy), TekrinnDialogue (ref), u221 (copy)
        if not u224 then
            return;
        end;

        u225:Add(TekrinnDialogue.Speak(u221, {
            {
                Text = "He cut inside?",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 0.9));
    end));
    u225:Add(task.delay(7.1, function() -- Line: 1930
        -- upvalues: u224 (copy), u225 (copy), TekrinnDialogue (ref), u221 (copy)
        if not u224 then
            return;
        end;

        u225:Add(TekrinnDialogue.Speak(u221, {
            {
                Text = "Make a ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            },
            {
                Text = "choice!",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)) })
            }
        }, 4));
    end));
    u225:Add(task.delay(0.38, function() -- Line: 1953
        -- upvalues: u224 (copy), u225 (copy), TekrinnDialogue (ref), u221 (copy)
        if u224 then
            return;
        end;

        u225:Add(TekrinnDialogue.Speak(u221, {
            {
                Text = "I see it!",
                TypeSpeed = 0.025,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 2));
    end));
    u225:Add(task.delay(1.85, function() -- Line: 1967
        -- upvalues: u224 (copy), u225 (copy), TekrinnDialogue (ref), u221 (copy)
        if u224 then
            return;
        end;

        u225:Add(TekrinnDialogue.Speak(u221, {
            {
                Text = "This is my ",
                TypeSpeed = 0.08,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            },
            {
                Text = "last chance",
                Bold = true,
                TypeSpeed = 0.08,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0)) })
            },
            {
                Text = "...",
                TypeSpeed = 0.08,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 2));
    end));
    u225:Add(task.delay(5.9, function() -- Line: 1998
        -- upvalues: u224 (copy), u225 (copy), TekrinnDialogue (ref), u221 (copy)
        if u224 then
            return;
        end;

        u225:Add(TekrinnDialogue.Speak(u221, {
            {
                Text = "He cut inside?!",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 2));
    end));
    u225:Add(task.delay(7.13, function() -- Line: 2012
        -- upvalues: u224 (copy), u225 (copy), TekrinnDialogue (ref), u221 (copy)
        if u224 then
            return;
        end;

        u225:Add(TekrinnDialogue.Speak(u221, {
            {
                Text = "I need to make a ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            },
            {
                Text = "decision",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)) })
            },
            {
                Text = "!",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 2));
    end));
    Lighting.Ambient = Color3.fromRGB(255, 255, 255);
    Lighting.Brightness = 3;
    Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
    Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0);
    Lighting.EnvironmentDiffuseScale = 1;
    Lighting.EnvironmentSpecularScale = 1;
    Lighting.OutdoorAmbient = Color3.fromRGB(47, 47, 47);
    Lighting.ShadowSoftness = 1;
    local v229 = u225:Add(vfxUtil.getMoonEffects());
    local u230 = {};
    local v231 = {};

    for _, child in Lighting:GetChildren() do
        if v223.Lighting:FindFirstChildWhichIsA(child.ClassName) then
            table.insert(u230, child);
            child.Parent = workspace;
        end;
    end;

    for _, child in v223.Lighting:GetChildren() do
        local v232 = child:Clone();
        u225:Add(v232);
        v231[v232.Name] = v232;
        v232.Parent = Lighting;
    end;

    for _, child in v223.Ball:GetChildren() do
        local v233 = child:Clone();
        v233.Parent = Ball;
        u225:Add(v233);
    end;

    u225:Add(function() -- Line: 2078
        -- upvalues: mainreplication (ref), u230 (copy), Lighting (ref), Ambient (ref), Brightness (ref), ColorShift_Top (ref), EnvironmentDiffuseScale (ref), EnvironmentSpecularScale (ref), OutdoorAmbient (ref), ShadowSoftness (ref)
        mainreplication.sceneEnabled(false);

        for _, v in u230 do
            pcall(function() -- Line: 2081
                -- upvalues: v (copy), Lighting (ref)
                v.Parent = Lighting;
            end);
        end;

        Lighting.Ambient = Ambient;
        Lighting.Brightness = Brightness;
        Lighting.ColorShift_Top = ColorShift_Top;
        Lighting.ColorShift_Bottom = ColorShift_Top;
        Lighting.EnvironmentDiffuseScale = EnvironmentDiffuseScale;
        Lighting.EnvironmentSpecularScale = EnvironmentSpecularScale;
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.ShadowSoftness = ShadowSoftness;
    end);
    local v234 = {
        Ball = Ball,
        TuffCharacterRig = v227,
        Kaiser = v228,
        Workspace = u226,
        Vignette = v229.Vignette,
        Blur = v231.Blur,
        DepthOfField = v231.DepthOfField,
        DepthOfField2 = v231.DepthOfField2,
        ColorCorrection = v231.ColorCorrection,
        Bloom = v231.Bloom,
        Atmosphere = v231.Atmosphere,
        Sky = v231.Sky
    };
    u225:Add(task.delay(10.43, function() -- Line: 2110
        -- upvalues: Root (copy)
        Root.CFrame = Root.CFrame + Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z) * 70.131;
    end));
    local v235 = u225:Construct(MoonPropertyAnimator);
    v235:LoadSave(v223.Moon, MoonPropertyAnimator.ConvertSave(v223.Moon, v234));
    v235:SetOriginalRoot(v223.OG);
    v235:SetRoot(Root);
    v235:PlayAll();
    local v236 = mainreplication.kuronaCam(Root, v223.Cam, v223.FOV);
    u225:Add(v236);

    for _, v in require(v223.Module) do
        u225:Add(task.delay(v[1] / 60, v[2], v228, v227, u226, v236));
    end;

    u225:Add(task.delay(11.4, function() -- Line: 2127
        -- upvalues: u225 (copy)
        u225:Destroy();
    end));
end;

return v1;