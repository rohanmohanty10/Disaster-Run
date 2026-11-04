 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
game:GetService("ServerScriptService");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local trove = require(ReplicatedStorage.forum.trove);
local Util = require(ReplicatedStorage.util.Util);
local BackgroundHighlight = require(ReplicatedStorage.client.replication.BackgroundHighlight);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
require(ReplicatedStorage.util.KatUtil);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)) });
local u1 = {};
local u2 = {};
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.FilterDescendantsInstances = { workspace.map:FindFirstChild("barriar", true) };
local addDurations = vfxUtil.addDurations;
local getEmitterLifetime = vfxUtil.getEmitterLifetime;
local getEmittersLifetime = vfxUtil.getEmittersLifetime;
local onBallLost = vfxUtil.onBallLost;
local getRoot = vfxUtil.getRoot;
local isLocalPlayer = vfxUtil.isLocalPlayer;
local dispose = vfxUtil.dispose;
local disposal = vfxUtil.disposal;
local emitAll = vfxUtil.emitAll;
local createVFX = vfxUtil.createVFX;
local quickVFX = vfxUtil.quickVFX;
local setupAura = vfxUtil.setupAura;

local function closeQuarterCurve(p3: number) -- Line: 70
    return math.sin(p3 * 3.141592653589793);
end;

local function kuronaFlash(p4: number, p5: number?) -- Line: 74
    -- upvalues: Lighting (copy), TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p4);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.new(1, 0.396078, 0.968627);
    ColorCorrectionEffect.Contrast = 0.3;
    ColorCorrectionEffect.Brightness = 0.1;
    ColorCorrectionEffect.Parent = Lighting;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = p5 or 4;
    BlurEffect.Parent = Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo_new_ret, {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.new(1, 1, 1)
    }):Play();
    TweenService:Create(BlurEffect, TweenInfo_new_ret, {
        Size = 0
    }):Play();
    task.delay(TweenInfo_new_ret.Time, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
    task.delay(TweenInfo_new_ret.Time, BlurEffect.Destroy, BlurEffect);
end;

local function getBodyVelocity(p6: userdata, p7: any) -- Line: 90
    -- upvalues: mainreplication (copy)
    return mainreplication.bodyVelocity(p6, p7.Strength, p7.Duration, p7.FadeIn, p7.VectorFace, p7.Custom, p7.TweenInfo, p7.TweenDelay);
end;

local script_CQDVFX = require(script.CQDVFX);
local script_YoinkVFX = require(script.YoinkVFX);
local script_FlowVFX = require(script.FlowVFX);
local script_OrbitalStartVFX = require(script.OrbitalStartVFX);
local script_OrbitalAutoGoalVFX = require(script.OrbitalAutoGoalVFX);

function u2.closeQuarter(u8) -- Line: 104
    -- upvalues: ReplicatedStorage (copy), isLocalPlayer (copy), getRoot (copy), mainreplication (copy), addDurations (copy), soundUtil (copy), SoundService (copy), onBallLost (copy), RunService (copy), RaycastParams_new_ret (copy), Lighting (copy), BackgroundHighlight (copy), kuronaFlash (copy), createVFX (copy), getEmittersLifetime (copy), script_CQDVFX (copy), disposal (copy)
    local kurona = ReplicatedStorage.Resources.kurona;
    local u9 = isLocalPlayer(u8);
    local u10 = getRoot(u8);

    if not u10 then
        return;
    end;

    local u11 = {
        {
            Strength = 38.46153846153846,
            Duration = 0.75,
            FadeIn = true,
            TweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Cubic)
        },
        {
            Strength = 61.53846153846153,
            Duration = 0.6,
            Custom = true,
            TweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Cubic)
        },
        {
            Strength = 115.38461538461539,
            Duration = 0.5,
            Custom = true,
            TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint)
        },
        {
            Strength = 38.46153846153846,
            Duration = 0.15,
            TweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine)
        },
        {
            Strength = 46.15384615384615,
            Duration = 0.5,
            Custom = true,
            TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        },
        {
            Strength = 36.53846153846154,
            Duration = 1,
            TweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        }
    };

    for _, v in ipairs(u11) do
        v.Strength = v.Strength + v.Strength * 0.16;
    end;

    local u12 = 1;
    local u13 = 0;
    local Duration = u11[3].Duration;
    local u14 = false;
    local u15, u16;

    if u9 then
        local v17 = u11[1];
        u15, u16 = mainreplication.bodyVelocity(u10, v17.Strength, v17.Duration, v17.FadeIn, v17.VectorFace, v17.Custom, v17.TweenInfo, v17.TweenDelay);
        task.delay(addDurations(u11, 2), function() -- Line: 150
            -- upvalues: mainreplication (ref), u11 (copy), u12 (ref)
            mainreplication.fov(false, 90);
            mainreplication.fov(true, 70, u11[u12].Duration, Enum.EasingStyle.Quart);
        end);
    else
        u15 = nil;
        u16 = nil;
    end;

    local v18;

    if u9 then
        v18 = SoundService or u10;
    else
        v18 = u10;
    end;

    local u19 = soundUtil:play(ReplicatedStorage.Resources.kurona.CQDSFX, v18, {
        Volume = u9 and 1 or 2
    });
    local u20, v21, u22 = onBallLost(u8, function() -- Line: 158
        -- upvalues: u19 (copy)
        u19:Destroy();
    end);
    task.delay(u11[1].Duration, function() -- Line: 162
        -- upvalues: u12 (ref), u9 (copy), mainreplication (ref), u11 (copy), u15 (ref), u16 (ref), u10 (copy), RunService (ref), u14 (ref), u13 (ref), Duration (copy), RaycastParams_new_ret (ref), Lighting (ref)
        u12 = 2;

        if u9 then
            mainreplication.fov(false, 90);
            mainreplication.fov(true, 75, u11[2].Duration, Enum.EasingStyle.Quart);
            local v23 = u11[u12];
            local v24, v25 = mainreplication.bodyVelocity(u10, v23.Strength, v23.Duration, v23.FadeIn, v23.VectorFace, v23.Custom, v23.TweenInfo, v23.TweenDelay);
            u15 = v24;
            u16 = v25;
            local u26 = nil;
            u26 = RunService.RenderStepped:Connect(function(p27) -- Line: 170
                -- upvalues: u14 (ref), u26 (ref), u15 (ref), u16 (ref), u10 (ref), u12 (ref), u13 (ref), Duration (ref), u11 (ref), RaycastParams_new_ret (ref), Lighting (ref)
                if u14 then
                    u26:Disconnect();

                    return;
                end;

                if not u15 then
                    return;
                end;

                local v28 = p27 / 0.016666666666666666;
                local Value = u16.Value;
                local CFrame2 = u10.CFrame;
                local v29 = nil;

                if u12 == 2 then
                    v29 = CFrame2.LookVector * (Value * 0.25) + CFrame2.RightVector * Value;
                elseif u12 == 3 then
                    v29 = CFrame2.LookVector * (Value * 0.25) - CFrame2.RightVector * Value;
                elseif u12 == 5 then
                    u13 = math.min(u13 + p27 / Duration, 1);
                    v29 = CFrame2.LookVector * Value + CFrame2.RightVector * (u11[u12].Strength * math.sin(u13 * 3.141592653589793));
                end;

                if u11[u12] and u11[u12].Custom then
                    local v30 = u15.Velocity:Lerp(v29 or Vector3.new(0, 0, 0), 0.8 * v28);
                    u15.Parent = workspace:Raycast(u10.Position, v30.Unit * 8, RaycastParams_new_ret) and Lighting or u10;
                    u15.Velocity = v30;
                end;
            end);
        end;
    end);

    for i = 1, #u11 do
        task.delay(addDurations(u11, i), function() -- Line: 206
            -- upvalues: u14 (ref), i (copy), u11 (copy), u22 (copy), u20 (copy), u12 (ref), u9 (copy), u15 (ref), u16 (ref), u10 (copy), mainreplication (ref), BackgroundHighlight (ref), u8 (copy), kuronaFlash (ref), ReplicatedStorage (ref)
            if u14 then
                return;
            end;

            if i == #u11 or u22.Value then
                u14 = true;

                if u20 then
                    u20:Disconnect();
                end;
            else
                u12 = i + 1;

                if u9 then
                    if u12 > 1 then
                        local v31 = u11[u12];
                        local v32, v33 = mainreplication.bodyVelocity(u10, v31.Strength, v31.Duration, v31.FadeIn, v31.VectorFace, v31.Custom, v31.TweenInfo, v31.TweenDelay);
                        u15 = v32;
                        u16 = v33;
                    end;

                    if table.find({ 2, 3 }, u12) then
                        local Duration2 = u11[u12].Duration;
                        BackgroundHighlight({
                            Brightness = 1,
                            ImageTransparency = 0.5,
                            Count = 5,
                            Whitelist = { u8 },
                            BlacklistedParts = { "Ball" },
                            Speed = Duration2,
                            CountSpeed = Duration2 / 5,
                            Color = Color3.fromRGB(255, 67, 158)
                        });
                        kuronaFlash(Duration2 * 0.8);
                        mainreplication.Emit(u8:FindFirstChild("Head"), ReplicatedStorage.Resources.headball, 1);
                    end;
                end;
            end;
        end);
        local _ = i;
    end;

    local u34 = createVFX(kurona.CQDBallVFX, u8, v21);
    local u35 = createVFX(kurona.CQDRootVFX, u8, u10);
    local v36 = getEmittersLifetime(u34);
    local v37 = getEmittersLifetime(u35);

    if v37 < v36 then
        v37 = v36 or v37;
    end;

    for i, v in ipairs(script_CQDVFX) do
        task.delay(v[1] / 60, function() -- Line: 250
            -- upvalues: u22 (copy), v (copy), u34 (copy), u35 (copy)
            if u22.Value then
                return;
            end;

            v[2](u34, u35);
        end);

        if i == #script_CQDVFX then
            v37 = v37 + v[1] / 60;
        end;
    end;

    disposal(u34, v37);
    disposal(u35, v37);
end;

function u2.cqdGoGo(u38) -- Line: 263
    -- upvalues: isLocalPlayer (copy), getRoot (copy), mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), kuronaFlash (copy), disposal (copy)
    local u39 = isLocalPlayer(u38);
    local u40 = getRoot(u38);

    if not u40 then
        return;
    end;

    local u41 = {
        {
            Strength = 30,
            Duration = 0.6,
            FadeIn = true,
            TweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
        },
        {
            Strength = 100,
            Duration = 1.05,
            TweenInfo = TweenInfo.new(1.3125, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        }
    };

    if u39 then
        local v42 = u41[1];
        mainreplication.bodyVelocity(u40, v42.Strength, v42.Duration, v42.FadeIn, v42.VectorFace, v42.Custom, v42.TweenInfo, v42.TweenDelay);
    end;

    local v43;

    if u39 then
        v43 = SoundService or u40;
    else
        v43 = u40;
    end;

    soundUtil:play(ReplicatedStorage.Resources.kurona.GoGoSFX, v43);
    local u44 = {};
    task.delay(u41[1].Duration, function() -- Line: 287
        -- upvalues: u39 (copy), mainreplication (ref), u41 (copy), u40 (copy), kuronaFlash (ref), ReplicatedStorage (ref), u38 (copy), u44 (copy)
        if u39 then
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 70, u41[2].Duration, Enum.EasingStyle.Quart);
            local v45 = u41[2];
            mainreplication.bodyVelocity(u40, v45.Strength, v45.Duration, v45.FadeIn, v45.VectorFace, v45.Custom, v45.TweenInfo, v45.TweenDelay);
            kuronaFlash(u41[2].Duration * 1.25);
        end;

        local GoGoVFX = ReplicatedStorage.Resources.kurona.GoGoVFX;

        for _, child in GoGoVFX.Trails:GetChildren() do
            local Attribute = child:GetAttribute("WeldTarget");

            if Attribute then
                local v46 = u38:FindFirstChild(Attribute);

                if v46 then
                    local v47 = child:Clone();
                    v47.Weld.Part1 = v46;
                    v47.Parent = v46;
                    table.insert(u44, v47);
                end;
            end;
        end;

        local v48 = GoGoVFX.RunPart:Clone();
        v48.Weld.Part1 = u40;
        v48.Parent = u40;
        table.insert(u44, v48);
    end);
    task.delay(1.35, function() -- Line: 311
        -- upvalues: u44 (copy), disposal (ref)
        for _, v in u44 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            disposal(v, 2);
        end;
    end);
end;

function u2.clearFetchMark(p49, p50) -- Line: 323
    for _, child in p49:GetChildren() do
        if child.Name == "FetchMarkVFX" and (not p50 or child.Owner.Value == p50) then
            child:SetAttribute("Enabled", false);
        end;
    end;
end;

function u2.fetchMark(p51: any, p52: any, p53: userdata, p54: any) -- Line: 334
    -- upvalues: isLocalPlayer (copy), Players (copy), LocalPlayer (copy), getRoot (copy), u2 (copy), Lighting (copy), TweenService (copy), mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), disposal (copy), emitAll (copy), getEmittersLifetime (copy)
    local v55 = isLocalPlayer(p51);

    if not v55 and Players:GetPlayerFromCharacter(p52) ~= LocalPlayer then
        task.wait(p54 or 0.35);

        if not p53:IsDescendantOf(workspace) then
            return;
        end;
    end;

    local v56 = p52:FindFirstChild("Torso") or getRoot(p52);
    u2.clearFetchMark(p52, p51);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "MarkedByKurona";
    ColorCorrectionEffect.Brightness = 0.1;
    ColorCorrectionEffect.Contrast = 0.75;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(218, 108, 255);
    ColorCorrectionEffect.Parent = Lighting;
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = v55 and p52 and p52 or p51;
    local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    TweenService:Create(ColorCorrectionEffect, TweenInfo_new_ret, {
        Brightness = 0,
        Contrast = 0,
        TintColor = Color3.new(1, 1, 1)
    }):Play();
    TweenService:Create(Highlight, TweenInfo_new_ret, {
        OutlineTransparency = 1
    }):Play();
    mainreplication.fov(false, 75);
    mainreplication.fov(true, 70, TweenInfo_new_ret.Time, TweenInfo_new_ret.EasingStyle, TweenInfo_new_ret.EasingDirection);
    mainreplication.cameraShake(5, 1, 3);
    soundUtil:play(ReplicatedStorage.Resources.kurona.FetchRunSFX, SoundService);
    disposal(ColorCorrectionEffect, TweenInfo_new_ret.Time);
    disposal(Highlight, TweenInfo_new_ret.Time);
    local u57 = ReplicatedStorage.Resources.kurona.FetchMarkVFX:Clone();
    u57.Weld.Part0 = v56;
    u57.Owner.Value = p51;
    u57:SetAttribute("Enabled", true);
    u57:GetAttributeChangedSignal("Enabled"):Connect(function() -- Line: 369
        -- upvalues: u57 (copy), emitAll (ref), getEmittersLifetime (ref)
        if not u57:GetAttribute("Enabled") then
            u57.firstMark.ThinStarSpec4x4:Destroy();
            u57.Marked.ThinStarSpec4x4.Enabled = false;
            u57.Mark.ThinStarSpec4x4:Emit(1);
            task.delay(0.85, function() -- Line: 375
                -- upvalues: u57 (ref)
                for _, child in u57.Marked:GetChildren() do
                    child.Enabled = false;
                end;
            end);
            task.delay(1.017, function() -- Line: 380
                -- upvalues: emitAll (ref), u57 (ref), getEmittersLifetime (ref)
                emitAll(u57.Mark);
                local task_delay = task.delay;
                local v58 = getEmittersLifetime(u57.Mark);
                local v59 = getEmittersLifetime(u57.Marked) - 0.167;
                task_delay(math.max(v58, v59), u57.Destroy, u57);
            end);
        end;
    end);
    u57.Parent = p52;
    emitAll(u57.firstMark);
    task.delay(0.167, function() -- Line: 388
        -- upvalues: u57 (copy)
        if u57:GetAttribute("Enabled") then
            for _, child in u57.Marked:GetChildren() do
                if child.Name:sub(1, 5) == "flame" then
                    child.Enabled = true;
                end;
            end;
        end;
    end);
    task.delay(0.95, function() -- Line: 397
        -- upvalues: u57 (copy)
        if u57:GetAttribute("Enabled") then
            u57.Marked.ThinStarSpec4x4.Enabled = true;
        end;
    end);
    p53.AncestryChanged:Once(function() -- Line: 402
        -- upvalues: u57 (copy)
        u57:SetAttribute("Enabled", false);
    end);
end;

function u2.fetchKickWindup(p60) -- Line: 407
    -- upvalues: getRoot (copy), soundUtil (copy), ReplicatedStorage (copy), isLocalPlayer (copy), SoundService (copy), mainreplication (copy)
    local v61 = getRoot(p60);
    local FetchKickSFX = ReplicatedStorage.Resources.kurona.FetchKickSFX;

    if isLocalPlayer(p60) then
        v61 = SoundService or v61;
    end;

    soundUtil:play(FetchKickSFX, v61);

    if isLocalPlayer(p60) then
        mainreplication.fov(true, 60, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
        task.wait(0.2);
        mainreplication.fov(false, 90, 0.25, Enum.EasingStyle.Cubic);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
    end;
end;

function u2.fetchKick(p62, p63) -- Line: 418
    -- upvalues: isLocalPlayer (copy), getRoot (copy), ReplicatedStorage (copy), emitAll (copy), disposal (copy), kuronaFlash (copy), u2 (copy), mainreplication (copy), soundUtil (copy), getEmitterLifetime (copy)
    local v64 = isLocalPlayer(p62);
    local v65 = getRoot(p62);
    local kurona = ReplicatedStorage.Resources.kurona;
    local v66 = kurona.FetchRootVFX:Clone();
    v66.Weld.Part0 = v65;
    v66.Parent = p62;
    emitAll(v66);
    disposal(v66);

    if v64 then
        kuronaFlash(1);
    end;

    u2.clearFetchMark(p63);
    mainreplication.cameraShake(10, 2, 6);
    local v67 = p63:FindFirstChild("Torso") or getRoot(p63);
    local v68 = kurona.FetchTargetVFX:Clone();
    v68.Weld.Part0 = v67;
    v68.Parent = p63;
    soundUtil:play(kurona.FetchRunSFX, v67);
    local CFBall = ReplicatedStorage:FindFirstChild("CFBall");

    if CFBall then
        CFBall.AncestryChanged:Wait();
    end;

    local v69 = 0;

    for _, descendant in v68:GetDescendants() do
        local v70 = getEmitterLifetime(descendant);

        if v70 > 0 then
            descendant.Enabled = false;
        end;

        if v69 < v70 then
            v69 = v70;
        end;
    end;

    disposal(v68, v69);
end;

function u2.PlanetHotlineRun(u71) -- Line: 454
    -- upvalues: ReplicatedStorage (copy), getRoot (copy), setupAura (copy), isLocalPlayer (copy), kuronaFlash (copy), mainreplication (copy), dispose (copy)
    local kurona = ReplicatedStorage.Resources.kurona;
    local u72 = getRoot(u71);
    local u73 = kurona.AuraTeammate:Clone();

    for _, descendant in u73:GetDescendants() do
        if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    setupAura(u71, u73);
    task.delay(0.1, function() -- Line: 470
        -- upvalues: isLocalPlayer (ref), u71 (copy), kuronaFlash (ref), u73 (copy)
        if isLocalPlayer(u71) then
            kuronaFlash(1);
        end;

        for _, descendant in u73:GetDescendants() do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u73.Parent = u71;
    local v74 = {
        Strength = 75,
        Duration = 1.8,
        FadeIn = true,
        TweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    };
    local u75 = mainreplication.bodyVelocity(u72, v74.Strength, v74.Duration, v74.FadeIn, v74.VectorFace, v74.Custom, v74.TweenInfo, v74.TweenDelay);
    task.delay(1.64, function() -- Line: 486
        -- upvalues: u75 (copy), u72 (copy), mainreplication (ref), u73 (copy), dispose (ref)
        if u75 and u75.Parent ~= nil then
            local v76 = {
                Strength = 25,
                Duration = 1.0200000000000002,
                TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            };
            mainreplication.bodyVelocity(u72, v76.Strength, v76.Duration, v76.FadeIn, v76.VectorFace, v76.Custom, v76.TweenInfo, v76.TweenDelay);
        end;

        for _, descendant in u73:GetDescendants() do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(1, function() -- Line: 499
            -- upvalues: dispose (ref), u73 (ref)
            dispose(u73);
        end);
    end);
end;

function u2.PlanetHotlineEnd(p77: string) -- Line: 505
    -- upvalues: u1 (copy)
    if u1[p77] then
        u1[p77].Destroy();
        u1[p77] = nil;
    end;
end;

function u2.PlanetHotlineStart(p78: any, u79: string) -- Line: 512
    -- upvalues: getRoot (copy), u1 (copy), ReplicatedStorage (copy), RunService (copy), disposal (copy)
    local TweenService2 = game:GetService("TweenService");
    local u80 = getRoot(p78);

    if u1[u79] then
        u1[u79].Destroy();
        u1[u79] = nil;
    end;

    local RaycastParams_new_ret2 = RaycastParams.new();
    RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret2.FilterDescendantsInstances = { workspace.map.map.sanam.main };
    local kurona = ReplicatedStorage.Resources.kurona;
    local u81 = kurona.HotlineSummonVFX:Clone();
    local u82 = kurona.Hotline:Clone();
    local u83 = kurona.KuronaHotlineIdle:Clone();
    u83.Parent = u82;
    u81.Parent = workspace.Effects;
    u82.Parent = workspace.Effects;
    local u84 = 0;
    local u85 = nil;
    u85 = {
        active = true,
        Connection = RunService.RenderStepped:Connect(function(p86) -- Line: 541
            -- upvalues: u80 (copy), RaycastParams_new_ret2 (copy), u84 (ref), u81 (copy), u82 (copy), u85 (ref)
            if not u80 then
                u85.Destroy();

                return;
            end;

            local v87 = workspace:Raycast(u80.Position, Vector3.new(0, -100, 0), RaycastParams_new_ret2);

            if v87 then
                u84 = v87.Position.Y + 0.1;
            end;

            u81.CFrame = CFrame.new((Vector3.new(u80.Position.X, u84 + 0.2, u80.Position.Z)));
            u82.CFrame = CFrame.new((Vector3.new(u80.Position.X, u84, u80.Position.Z)));
        end),

        Destroy = function() -- Line: 553, Name: Destroy
            -- upvalues: TweenService2 (copy), u83 (copy), u85 (ref), disposal (ref), u1 (ref), u79 (copy)
            TweenService2:Create(u83, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Volume = 0
            }):Play();
            u85.active = false;
            u85.Connection:Disconnect();

            for _, v in u85.Cleanables do
                disposal(v, 10);

                for _, descendant in v:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                        descendant.Enabled = false;
                    end;

                    if descendant:IsA("BasePart") and descendant.Transparency ~= 1 then
                        TweenService2:Create(descendant, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            Transparency = 1
                        }):Play();
                    end;
                end;
            end;

            if u1[u79] then
                u1[u79] = nil;
            end;
        end,

        Cleanables = { u81, u82 }
    };

    for _, descendant in u81:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 2);
        end;
    end;

    task.delay(1.4, function() -- Line: 580
        -- upvalues: u82 (copy), u85 (ref), u83 (copy), TweenService2 (copy)
        if u82 and u85.active then
            u83.Volume = 0;
            TweenService2:Create(u83, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Volume = 0.75
            }):Play();
            u83:Play();

            for _, descendant in u82:GetDescendants() do
                if descendant:IsA("BasePart") then
                    task.delay(2, function() -- Line: 587
                        -- upvalues: u85 (ref), descendant (copy)
                        if u85.active then
                            game:GetService("TweenService"):Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                                Transparency = 0
                            }):Play();
                        end;
                    end);
                end;

                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end);
    p78.AncestryChanged:Once(function() -- Line: 600
        -- upvalues: u85 (ref)
        if u85 and u85.active then
            u85.Destroy();
        end;
    end);
    u1[u79] = u85;
end;

function u2.PlanetHotlineAttach(p88, p89) -- Line: 610
    -- upvalues: mainreplication (copy)
    mainreplication.fov(false, p89 and 80 or 60);
    mainreplication.fov(true, 70, 0.35, Enum.EasingStyle.Quad);
end;

function u2.PlanetHotlineHit(p90) -- Line: 615
    -- upvalues: getRoot (copy), LocalPlayer (copy), mainreplication (copy)
    local u91 = getRoot(p90);

    if p90 == LocalPlayer.Character and u91 then
        task.delay(0.3, function() -- Line: 618
            -- upvalues: mainreplication (ref), u91 (copy)
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 70, 0.35, Enum.EasingStyle.Quad);
            mainreplication.cameraShake(6, 2, 7, { u91.CFrame, 50 });
        end);
    end;

    local v92 = {
        Strength = 35,
        Duration = 0.8,
        TweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    };
    mainreplication.bodyVelocity(u91, v92.Strength, v92.Duration, v92.FadeIn, v92.VectorFace, v92.Custom, v92.TweenInfo, v92.TweenDelay);
end;

function u2.yoinkySploink(u93, p94) -- Line: 633
    -- upvalues: ReplicatedStorage (copy), getRoot (copy), LocalPlayer (copy), createVFX (copy), Util (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), getEmittersLifetime (copy), script_YoinkVFX (copy), TweenService (copy), TekrinnDialogue (copy), ColorSequence_new_ret (copy), disposal (copy)
    local YoinkYoink = ReplicatedStorage.Resources.kurona.YoinkYoink;
    local Linear = Enum.EasingStyle.Linear;
    local TweenInfo_new_ret = TweenInfo.new(0.083, Linear);
    local v95 = getRoot(u93);
    local Ball = p94:FindFirstChild("Ball");
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u96 = createVFX(YoinkYoink.BallVFX, u93, Ball);
    local u97 = createVFX(YoinkYoink.RootVFX, u93, v95);
    local u98 = createVFX(YoinkYoink.HeadVFX, u93, u93:FindFirstChild("Head"));
    local u99 = createVFX(YoinkYoink.RightLegVFX, u93, u93:FindFirstChild("Right Leg"));
    local u100 = createVFX(YoinkYoink.Floor, u93);
    local u101 = createVFX(YoinkYoink.Sphere, u93);
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.FillTransparency = 0;
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.Adornee = u93;
    Highlight.Enabled = false;
    Highlight.Parent = u93;
    local v102 = YoinkYoink.Vignette:Clone();
    local ImageLabel = v102.ImageLabel;
    ImageLabel.ImageTransparency = 1;
    v102.Parent = PlayerGui;
    local u103 = Util.Preload({ YoinkYoink.StealImpact });
    mainreplication.sceneEnabled(true);
    local u104 = mainreplication.kuronaCam(v95, nil, YoinkYoink.FOV, function() -- Line: 666
        -- upvalues: u93 (copy), u100 (copy), u101 (copy)
        local Pivot = u93:GetPivot();
        u100:PivotTo(Pivot);
        u101:PivotTo(Pivot);
    end);
    soundUtil:play(YoinkYoink.SFX, SoundService);
    local v105 = {
        u96,
        u97,
        u98,
        u99,
        u100,
        u101,
        Highlight,
        v102
    };
    local v106 = 0;

    for _, v in v105 do
        local _ = v106 < getEmittersLifetime(v);
    end;

    for i, v in ipairs(script_YoinkVFX) do
        task.delay(v[1] / 60, function() -- Line: 685
            -- upvalues: v (copy), u97 (copy), u104 (copy), u98 (copy), u96 (copy), u99 (copy)
            v[2](u97, u104, u98, u96, u99);
        end);

        if i == #script_YoinkVFX then
            v106 = v106 + v[1] / 60;
        end;
    end;

    TweenService:Create(ImageLabel, TweenInfo.new(0.5, Linear), {
        ImageTransparency = 0
    }):Play();

    if Ball then
        Ball.Size = Vector3.new(1.5, 1.5, 1.5);
    end;

    task.delay(1.54, function() -- Line: 699
        -- upvalues: Util (ref), YoinkYoink (copy)
        Util.Gif(YoinkYoink.StealImpact, 30);
    end);
    task.delay(1.017, function() -- Line: 703
        -- upvalues: Highlight (copy), TweenService (ref), Linear (copy), ImageLabel (copy), TweenInfo_new_ret (copy), TekrinnDialogue (ref), u93 (copy)
        Highlight.Enabled = true;
        TweenService:Create(Highlight, TweenInfo.new(0.066, Linear), {
            FillColor = Color3.fromRGB(255, 0, 136)
        }):Play();
        ImageLabel.ImageColor3 = Color3.new(1, 1, 1);
        ImageLabel.ImageTransparency = 0.5;
        TweenService:Create(ImageLabel, TweenInfo_new_ret, {
            ImageColor3 = Color3.fromRGB(207, 40, 124)
        }):Play();
        TekrinnDialogue.Speak(u93, {
            {
                Text = "Yoink yoink.",
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 3);
    end);
    task.delay(1.083, function() -- Line: 722
        -- upvalues: TweenService (ref), Highlight (copy), Linear (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.167, Linear), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end);
    task.delay(1.1, function() -- Line: 729
        -- upvalues: TweenService (ref), ImageLabel (copy), TweenInfo_new_ret (copy)
        TweenService:Create(ImageLabel, TweenInfo_new_ret, {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(2.5, function() -- Line: 733
        -- upvalues: TekrinnDialogue (ref), u93 (copy), ColorSequence_new_ret (ref)
        TekrinnDialogue.Speak(u93, {
            {
                Text = "This is ",
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            },
            {
                Text = "mine",
                Bold = true,
                Color = ColorSequence_new_ret,
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 2
                }
            },
            {
                Text = "...",
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 4);
    end);
    task.delay(3.067, function() -- Line: 766
        -- upvalues: Linear (copy), TweenService (ref), u100 (copy), u101 (copy)
        local TweenInfo_new_ret2 = TweenInfo.new(0.183, Linear);
        TweenService:Create(u100, TweenInfo_new_ret2, {
            Transparency = 0
        }):Play();
        TweenService:Create(u101, TweenInfo_new_ret2, {
            Transparency = 0
        }):Play();
    end);
    task.delay(3.583, function() -- Line: 772
        -- upvalues: Linear (copy), TweenService (ref), u100 (copy), u101 (copy)
        local TweenInfo_new_ret2 = TweenInfo.new(0.25, Linear);
        TweenService:Create(u100, TweenInfo_new_ret2, {
            Transparency = 1
        }):Play();
        TweenService:Create(u101, TweenInfo_new_ret2, {
            Transparency = 1
        }):Play();
    end);
    local u107 = nil;
    task.delay(5.4, function() -- Line: 779
        -- upvalues: u107 (ref), TekrinnDialogue (ref), u93 (copy)
        u107 = TekrinnDialogue.Speak(u93, {
            {
                Text = "See ya.",
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 1);
    end);
    task.delay(6.45, function() -- Line: 793
        -- upvalues: Ball (copy), u107 (ref), u103 (copy), u104 (copy), mainreplication (ref)
        if Ball then
            Ball.Size = Vector3.new(1.95, 1.95, 1.95);
        end;

        if u107 then
            u107();
        end;

        u103:Destroy();
        pcall(u104.Destroy, u104);
        mainreplication.sceneEnabled(false);
    end);
    disposal(v105, (math.max(v106, 6.45)));
end;

local _ = {
    aiku = {
        [0.267] = {
            {
                {
                    Text = "All the next moves.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            },
            2
        },
        [1.833] = {
            {
                {
                    Text = "My senses are in overdrive!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            },
            5
        },
        [4.517] = {
            {
                {
                    Text = "I understand it all with my whole body.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            },
            4
        },
        [6.183] = {
            {
                {
                    Text = "When I reach the max of the abilities",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    }
                }
            },
            5
        },
        [7.933] = {
            {
                {
                    Text = "There\'s a world I can see only once I\'m there.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            },
            3
        },
        [10.833] = {
            {
                {
                    Text = "This sensation is...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1
                    }
                }
            },
            2
        },
        [12.633] = {
            {
                {
                    Text = "UNSTOPPABLE!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 1
                    }
                }
            },
            1
        }
    },
    sae = {
        [1.75] = {
            {
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
            },
            4
        },
        [4.883] = {
            {
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
            },
            4
        },
        [8.767] = {
            {
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
            },
            1.35
        }
    },
    kurona = {
        [0] = {
            {
                {
                    Text = "Time to ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    }
                },
                {
                    Text = "counter.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 191)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            },
            2
        },
        [8.243] = {
            {
                {
                    Text = "Supreme domination.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            },
            3.5
        },
        [12.508] = {
            {
                {
                    Text = "Over here!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            },
            3.5
        }
    }
};

function u2.kurflowActivate(u108, p109) -- Line: 1192
    -- upvalues: ReplicatedStorage (copy), getRoot (copy), Players (copy), trove (copy), vfxUtil (copy), mainreplication (copy), createVFX (copy), Util (copy), script_FlowVFX (copy), soundUtil (copy), SoundService (copy), BackgroundHighlight (copy)
    local Flow = ReplicatedStorage.Resources.kurona.Flow;
    local v110 = getRoot(u108);
    Players:GetPlayerFromCharacter(u108);
    local u111 = trove.new();
    u111:Add(vfxUtil.getScreenDimmer());
    local v112 = u111:Add(mainreplication.kuronaCam(v110, nil, Flow.FOV));
    local u113 = createVFX(Flow.RootVFX, u108, v110);
    local u114 = createVFX(Flow.BallVFX, u108, u108.Ball);
    local u115 = createVFX(Flow.HeadVFX, u108, u108.Head);
    local u116 = createVFX(Flow.CamVFX, u108, v112);
    u111:Add(Util.Preload({ Flow.ImpactFrame }));
    local u117 = Flow.TeammateVFX:Clone();
    u117.Parent = p109;
    local u118 = {};

    for _, child in u117:GetChildren() do
        if p109:FindFirstChild(child.Name) then
            child.Weld.Part0 = p109[child.Name];
        end;
    end;

    for _, child in Flow.Aura:GetChildren() do
        local v119 = child;

        for _, v in { "Left Arm", "Right Arm", "Torso", "Left Leg", "Right Leg" } do
            local v120 = v119:Clone();
            v120.Parent = u108:FindFirstChild(v) or v110;
            table.insert(u118, v120);
        end;
    end;

    for _, v in ipairs(script_FlowVFX) do
        task.delay(v[1] / 60, function() -- Line: 1228
            -- upvalues: v (copy), u108 (copy), u113 (copy), u114 (copy), u116 (copy), u117 (copy)
            task.spawn(v[2], u108, u113, u114, u116, u117);
        end);
    end;

    soundUtil:play(Flow.FlowSFX, SoundService);
    u111:AttachToInstance(u108);
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1, 0.5);
    u111:Add(function() -- Line: 1242
        -- upvalues: u113 (copy), u114 (copy), u117 (copy), u115 (copy), u118 (copy), mainreplication (ref)
        pcall(game.Destroy, u113);
        pcall(game.Destroy, u114);
        pcall(game.Destroy, u117);
        pcall(game.Destroy, u115);

        for _, v in u118 do
            pcall(game.Destroy, v);
        end;

        table.clear(u118);
        mainreplication.sceneEnabled(false);
    end);
    u111:Add(task.delay(2.15, function() -- Line: 1257
        -- upvalues: Util (ref), Flow (copy)
        Util.Gif(Flow.ImpactFrame, 24);
    end));
    u111:Add(task.delay(9.5, function() -- Line: 1261
        -- upvalues: BackgroundHighlight (ref), u108 (copy)
        BackgroundHighlight({
            Speed = 1.6500000000000004,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.026,
            ImageTransparency = 0.8,
            Count = 64,
            Whitelist = { u108 },
            BlacklistedParts = { "Ball", "BallVFX", "RootVFX", "HeadVFX", "CamVFX", "Cam" },
            Color = Color3.fromRGB(170, 0, 255),
            Color2 = Color3.fromRGB(255, 53, 174)
        });
    end));
    u111:Add(task.delay(13.217, function() -- Line: 1276
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(-1, 0.2159999999999993);
    end));
    u111:Add(task.delay(14.1, function() -- Line: 1280
        -- upvalues: mainreplication (ref), u111 (copy)
        mainreplication.ultFlash(1, 1);
        u111:Destroy();
    end));
end;

function u2.speedyTurn(p121, p122) -- Line: 1286
    -- upvalues: getRoot (copy), ReplicatedStorage (copy), trove (copy), TweenService (copy), soundUtil (copy), isLocalPlayer (copy), SoundService (copy), mainreplication (copy), kuronaFlash (copy), BackgroundHighlight (copy), createVFX (copy), RunService (copy), getEmitterLifetime (copy), disposal (copy), emitAll (copy)
    local u123 = 70 * p122;
    local u124 = getRoot(p121);
    local Torso = p121:FindFirstChild("Torso");
    local kurona = ReplicatedStorage.Resources.kurona;
    local u125 = trove.new();
    u125:AttachToInstance(p121);
    local u126 = kurona.Aura:Clone();
    u126.Parent = Torso;
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.FillTransparency = 0;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = p121;
    TweenService:Create(Highlight, TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
        FillColor = Color3.fromRGB(255, 0, 136)
    }):Play();
    soundUtil:play(kurona.SpeedyTurnSFX, isLocalPlayer(p121) and SoundService or u124);

    if isLocalPlayer(p121) then
        mainreplication.fov(false, 95);
        kuronaFlash(1, 5);
        mainreplication.fov(true, 70, 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    u125:Add(Highlight);
    BackgroundHighlight({
        Speed = 0.667,
        Brightness = 1,
        ImageTransparency = 0.5,
        CountSpeed = 0.083375,
        Count = 8,
        Whitelist = { p121 },
        BlacklistedParts = { "Ball" },
        Color = Color3.fromRGB(255, 67, 158)
    });
    local u127 = createVFX(kurona.SpeedyTurnVFX, p121, u124);
    local u128, u129 = mainreplication.bodyVelocity(u124, u123, 0.667, nil, nil, true, TweenInfo.new(0.817, Enum.EasingStyle.Cubic, Enum.EasingDirection.In));

    if u128 then
        local u130 = 0;
        u125:Add(u128);
        u125:Add(RunService.RenderStepped:Connect(function(p131) -- Line: 1331
            -- upvalues: u130 (ref), u128 (copy), u124 (copy), u129 (copy), u123 (copy), TweenService (ref)
            u130 = u130 + p131;

            if u128.Parent == u124 then
                local CFrame2 = u124.CFrame;
                local math_clamp_ret = math.clamp(u130 / 0.667, 0, 1);
                u128.Velocity = CFrame2.LookVector * u129.Value + CFrame2.RightVector * (u123 * 2) * (1 - TweenService:GetValue(math_clamp_ret, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
            end;
        end));
    end;

    u125:Add(function() -- Line: 1340
        -- upvalues: u126 (copy), getEmitterLifetime (ref), disposal (ref)
        local v132 = 0;

        for _, child in u126:GetChildren() do
            local v133 = getEmitterLifetime(child);

            if v133 > 0 then
                child.Enabled = false;

                if v132 < v133 then
                    v132 = v133;
                end;
            end;
        end;

        disposal(u126, v132);
    end);
    u125:Add(task.delay(0.067, function() -- Line: 1353
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.166, Enum.EasingStyle.Cubic), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end));
    u125:Add(task.delay(0.167, function() -- Line: 1359
        -- upvalues: emitAll (ref), u127 (copy)
        emitAll(u127.One);
    end));
    u125:Add(task.delay(0.333, function() -- Line: 1362
        -- upvalues: emitAll (ref), u127 (copy)
        emitAll(u127.Two);
    end));
    u125:Add(task.delay(0.667, function() -- Line: 1365
        -- upvalues: u125 (copy)
        u125:Destroy();
    end));
end;

function u2.guardDogTackle(u134) -- Line: 1370
    -- upvalues: getRoot (copy), ReplicatedStorage (copy), trove (copy), setupAura (copy), soundUtil (copy), getEmittersLifetime (copy), TweenService (copy), disposal (copy), createVFX (copy), emitAll (copy), mainreplication (copy), isLocalPlayer (copy), kuronaFlash (copy)
    local u135 = getRoot(u134);
    local GuardDog = ReplicatedStorage.Resources.kurona.GuardDog;
    local u136 = {};
    local u137 = trove.new();
    u137:AttachToInstance(u134);
    local u138 = GuardDog.Aura:Clone();
    setupAura(u134, u138);
    u138.Parent = u134;
    local u139 = GuardDog.Trails:Clone();
    setupAura(u134, u139);
    u139.Parent = u134;
    soundUtil:play(GuardDog.DashSFX, u135);
    u137:Add(function() -- Line: 1383
        -- upvalues: getEmittersLifetime (ref), u138 (copy), u136 (copy), TweenService (ref), disposal (ref), u139 (copy)
        local v140 = getEmittersLifetime(u138);

        for _, v in u136 do
            if v:IsA("Beam") then
                TweenService:Create(v, TweenInfo.new(v140, Enum.EasingStyle.Linear), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            else
                v.Enabled = false;
            end;
        end;

        disposal(u138, v140);
        disposal(u139);
    end);
    u137:Add(task.delay(0.2, function() -- Line: 1395
        -- upvalues: createVFX (ref), GuardDog (copy), u134 (copy), emitAll (ref), disposal (ref), u138 (copy), u136 (copy), u139 (copy), mainreplication (ref), u135 (copy), isLocalPlayer (ref), kuronaFlash (ref)
        local v141 = createVFX(GuardDog.DashVFX, u134);
        emitAll(v141);
        disposal(v141);

        for _, descendant in u138:GetDescendants() do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                table.insert(u136, descendant);
            end;
        end;

        for _, descendant in u139:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
                table.insert(u136, descendant);
            end;
        end;

        mainreplication.bodyVelocity(u135, 160, 0.35, nil, nil, nil, TweenInfo.new(1, Enum.EasingStyle.Quart));

        if isLocalPlayer(u134) then
            kuronaFlash(0.4);
        end;
    end));
    u137:Add(task.delay(0.75, function() -- Line: 1416
        -- upvalues: u137 (copy)
        u137:Destroy();
    end));
end;

function u2.guardDogClash(u142: any, p143: any, u144: userdata?) -- Line: 1421
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), getRoot (copy), trove (copy), createVFX (copy), isLocalPlayer (copy), setupAura (copy), soundUtil (copy), SoundService (copy), emitAll (copy), kuronaFlash (copy), disposal (copy)
    print(u142, p143, u144);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u142) then
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(20, 40);
        local v145 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v145.Parent = Lighting;
        v145.TintColor = Color3.new(1, 0.396078, 0.968627);
        v145.Brightness = 0.1;
        v145.Contrast = 0.7;
        v145.Saturation = -0.2;
        TweenService:Create(v145, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v145, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v145.Destroy, v145);
    end;

    local u146 = getRoot(u142);
    local u147 = trove.new();
    local u148 = false;

    if u144 then
        u144.Destroying:Connect(function() -- Line: 1449
            -- upvalues: u144 (copy), u148 (ref), u147 (copy), mainreplication (ref), u142 (copy)
            if u144.Name ~= "idc" then
                u148 = true;
                u147:Destroy();
                mainreplication.destroyVelocity(u142, true);
                print("delete");
            end;
        end);
    end;

    local GuardDog = ReplicatedStorage.Resources.kurona.GuardDog;
    local u149 = {};
    u147:AttachToInstance(u142);
    local u150 = createVFX(GuardDog.Clash, nil, u146);
    local v151 = isLocalPlayer(u142);
    local u152 = v151 or isLocalPlayer(p143);
    setupAura(u142, u150.Trails);
    u150.Parent = u142;
    local v153;

    if v151 then
        v153 = SoundService or u146;
    else
        v153 = u146;
    end;

    soundUtil:play(GuardDog.SFX, v153);
    u147:Add(function() -- Line: 1469
        -- upvalues: u150 (copy)
        for _, descendant in u150:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = false;
            end;
        end;

        task.delay(5, function() -- Line: 1475
            -- upvalues: u150 (ref)
            pcall(game.Destroy, u150);
        end);
    end);
    u147:Add(task.delay(1.833, emitAll, u150.Yoink));
    u147:Add(task.delay(2.083, function() -- Line: 1481
        -- upvalues: u150 (copy), emitAll (ref), mainreplication (ref), u152 (copy), kuronaFlash (ref)
        for _, descendant in u150.Clash.Main.Enabled:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        emitAll(u150.Push);
        mainreplication.cameraShake(10, 2, 6);

        if u152 then
            kuronaFlash(1, 8);
        end;
    end));
    u147:Add(task.delay(2.567, function() -- Line: 1493
        -- upvalues: u150 (copy), u149 (copy), u148 (ref), mainreplication (ref), u146 (copy)
        for _, descendant in u150.Trails:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
                table.insert(u149, descendant);
            end;
        end;

        if not u148 then
            mainreplication.bodyVelocity(u146, 235.29411764705884, 0.68, nil, nil, nil, TweenInfo.new(0.85, Enum.EasingStyle.Quart));
        end;
    end));
    u147:Add(function() -- Line: 1507
        -- upvalues: u149 (copy), disposal (ref), u150 (copy)
        for _, v in u149 do
            v.Enabled = false;
        end;

        disposal(u150);
    end);
    u147:Add(task.delay(2.967, emitAll, u150.BallLand));
    u147:Add(task.delay(3.133, function() -- Line: 1514
        -- upvalues: emitAll (ref), u150 (copy), mainreplication (ref), u152 (copy), kuronaFlash (ref)
        emitAll(u150.End);
        emitAll(u150.BallLand);
        mainreplication.cameraShake(3, 0.5, 4);

        if u152 then
            kuronaFlash(1, 8);
        end;
    end));
    u147:Add(task.delay(3.367, function() -- Line: 1522
        -- upvalues: u147 (copy)
        u147:Destroy();
    end));
    emitAll(u150.Clash.Main.Emit);

    for _, descendant in u150.Clash.Main.Enabled:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;
end;

function u2.gogoTspecial(u154, p155) -- Line: 1533
    -- upvalues: isLocalPlayer (copy), getRoot (copy), ReplicatedStorage (copy), createVFX (copy), emitAll (copy), kuronaFlash (copy), disposal (copy), setupAura (copy), getEmitterLifetime (copy), TweenService (copy), soundUtil (copy), SoundService (copy), mainreplication (copy)
    local v156 = isLocalPlayer(u154);
    local v157 = getRoot(u154);
    local v158 = u154:FindFirstChild("Torso") or v157;
    local kurona = ReplicatedStorage.Resources.kurona;
    local v159 = createVFX(kurona.GoGoVFX[`{u154 == p155 and "User" or "Teammate"}TSpecialVFX`], u154, v158);
    local u160 = {};
    local u161 = 0;
    emitAll(v159.Attachment);

    if v156 then
        kuronaFlash(0.4, 4);
    end;

    if (v156 or isLocalPlayer(p155)) and v159:FindFirstChild("Indicator") then
        emitAll(v159.Indicator);
    end;

    disposal(v159);

    if u154 ~= p155 then
        u154:SetAttribute("GoGoStriker", 1);
        local u162 = kurona.AuraTeammate:Clone();
        setupAura(u154, u162);
        u162.Name = "KuronaTspecialAura";
        pcall(game.Destroy, u154:FindFirstChild(u162.Name));
        u162.Parent = u154;

        for _, descendant in u162:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                table.insert(u160, descendant);
                local v163 = getEmitterLifetime(descendant);

                if u161 < v163 then
                    u161 = v163;
                end;
            end;
        end;

        local u164 = nil;
        u164 = u154:GetAttributeChangedSignal("GoGoStriker"):Connect(function() -- Line: 1570
            -- upvalues: u154 (copy), u164 (ref), u162 (copy), u160 (copy), TweenService (ref), u161 (ref), disposal (ref)
            local Attribute = u154:GetAttribute("GoGoStriker");

            if typeof(Attribute) ~= "number" or Attribute < 1 then
                u164:Disconnect();
                u162.Name = "FadingAura";

                for _, v in u160 do
                    if v:IsA("Beam") then
                        TweenService:Create(v, TweenInfo.new(u161, Enum.EasingStyle.Linear), {
                            Width0 = 0,
                            Width1 = 0
                        }):Play();
                    else
                        v.Enabled = false;
                    end;
                end;

                disposal(u162, u161);
            end;
        end);
    end;

    if v156 then
        v157 = SoundService or v157;
    end;

    soundUtil:play(kurona.LetsGoStrikerSFX, v157);

    if v156 then
        mainreplication.cameraShake(5, 0.4, 5);
        mainreplication.fov(false, 75);
        mainreplication.fov(true, 70, 0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;
end;

function u2.oneTwoDash(u165) -- Line: 1596
    -- upvalues: ReplicatedStorage (copy), getRoot (copy), setupAura (copy), soundUtil (copy), isLocalPlayer (copy), SoundService (copy), trove (copy), getEmittersLifetime (copy), TweenService (copy), disposal (copy), quickVFX (copy), mainreplication (copy), Lighting (copy)
    local OneTwoDash = ReplicatedStorage.Resources.kurona.OneTwoDash;
    local u166 = getRoot(u165);
    local u167 = OneTwoDash.Aura:Clone();
    setupAura(u165, u167);
    u167.Parent = u165;
    local u168 = OneTwoDash.Trails:Clone();
    setupAura(u165, u168);
    u168.Parent = u165;
    local SFX = OneTwoDash.SFX;
    local v169;

    if isLocalPlayer(u165) then
        v169 = SoundService or u166;
    else
        v169 = u166;
    end;

    soundUtil:play(SFX, v169);
    local u170 = {};
    local u171 = trove.new();
    u171:AttachToInstance(u165);
    u171:Add(function() -- Line: 1609
        -- upvalues: getEmittersLifetime (ref), u167 (copy), u170 (copy), TweenService (ref), disposal (ref), u168 (copy)
        local v172 = getEmittersLifetime(u167);

        for _, v in u170 do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false;
            elseif v:IsA("Beam") then
                TweenService:Create(v, TweenInfo.new(v172), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end;
        end;

        disposal(u167, v172);
        disposal(u168);
    end);
    u171:Add(task.delay(0.167, function() -- Line: 1621
        -- upvalues: u167 (copy), u170 (copy), TweenService (ref), u168 (copy), quickVFX (ref), OneTwoDash (copy), u165 (copy), u166 (copy), isLocalPlayer (ref), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref)
        for _, descendant in u167:GetDescendants() do
            local v173 = descendant:IsA("Beam");

            if v173 or descendant:IsA("ParticleEmitter") then
                table.insert(u170, descendant);
                local v174;

                if v173 then
                    v174 = { descendant.Width0, descendant.Width1 };
                    descendant.Width0 = 0;
                    descendant.Width1 = 0;
                else
                    v174 = nil;
                end;

                descendant.Enabled = true;

                if v174 then
                    TweenService:Create(descendant, TweenInfo.new(0.2), {
                        Width0 = v174[0],
                        Width1 = v174[1]
                    }):Play();
                end;
            end;
        end;

        for _, descendant in u168:GetDescendants() do
            if descendant:IsA("Trail") then
                table.insert(u170, descendant);
                descendant.Enabled = true;
            end;
        end;

        quickVFX(OneTwoDash.Dash, u165, u166.CFrame * CFrame.new(0.07, -2.75, 0.34));

        if isLocalPlayer(u165) then
            mainreplication.bodyVelocity(u166, 158.8235294117647, 0.7, nil, nil, nil, TweenInfo.new(1.5, Enum.EasingStyle.Quart));
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 70, 0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local v175 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v175.Parent = Lighting;
            v175.TintColor = Color3.fromRGB(238, 144, 255);
            v175.Brightness = 0.1;
            v175.Contrast = 1;
            v175.Saturation = -0.4;
            TweenService:Create(v175, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v175, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v175.Destroy, v175);
        end;
    end));
    u171:Add(task.delay(0.833, function() -- Line: 1663
        -- upvalues: quickVFX (ref), OneTwoDash (copy), u165 (copy), u166 (copy), u171 (copy)
        quickVFX(OneTwoDash.Land, u165, u166.CFrame * CFrame.new(0.07, -2.95, 0.142));
        u171:Destroy();
    end));
end;

function u2.oneTwoPass(u176) -- Line: 1669
    -- upvalues: ReplicatedStorage (copy), getRoot (copy), isLocalPlayer (copy), soundUtil (copy), SoundService (copy), setupAura (copy), trove (copy), mainreplication (copy), kuronaFlash (copy), TweenService (copy), quickVFX (copy), getEmittersLifetime (copy), disposal (copy)
    local OneTwoPass = ReplicatedStorage.Resources.kurona.OneTwoPass;
    local u177 = getRoot(u176);
    local u178 = isLocalPlayer(u176);
    local SFX = OneTwoPass.SFX;
    local v179;

    if isLocalPlayer(u176) then
        v179 = SoundService or u177;
    else
        v179 = u177;
    end;

    soundUtil:play(SFX, v179);
    local u180 = OneTwoPass.Aura:Clone();
    setupAura(u176, u180);
    u180.Parent = u176;
    local u181 = OneTwoPass.Trails:Clone();
    setupAura(u176, u181);
    u181.Parent = u176;
    local u182 = trove.new();
    u182:AttachToInstance(u176);

    if u178 then
        mainreplication.fov(false, 65);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine);
        kuronaFlash(0.5, 8);
    end;

    local u183 = {};

    for _, descendant in u180:GetDescendants() do
        local v184 = descendant:IsA("Beam");

        if v184 or descendant:IsA("ParticleEmitter") then
            table.insert(u183, descendant);
            local v185;

            if v184 then
                v185 = { descendant.Width0, descendant.Width1 };
                descendant.Width0 = 0;
                descendant.Width1 = 0;
            else
                v185 = nil;
            end;

            descendant.Enabled = true;

            if v185 then
                TweenService:Create(descendant, TweenInfo.new(0.2), {
                    Width0 = v185[0],
                    Width1 = v185[1]
                }):Play();
            end;
        end;
    end;

    for _, descendant in u181:GetDescendants() do
        if descendant:IsA("Trail") then
            table.insert(u183, descendant);
            descendant.Enabled = true;
        end;
    end;

    quickVFX(OneTwoPass.BallRecieve, u176, u177.CFrame * CFrame.new(0.111, -1.36, -2.912));
    u182:Add(function() -- Line: 1711
        -- upvalues: getEmittersLifetime (ref), u180 (copy), u183 (copy), TweenService (ref), disposal (ref), u181 (copy)
        local v186 = getEmittersLifetime(u180);

        for _, v in u183 do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false;
            elseif v:IsA("Beam") then
                TweenService:Create(v, TweenInfo.new(v186), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end;
        end;

        disposal(u180, v186);
        disposal(u181);
    end);
    u182:Add(task.delay(0.233, function() -- Line: 1723
        -- upvalues: quickVFX (ref), OneTwoPass (copy), u176 (copy), u177 (copy)
        quickVFX(OneTwoPass.Land, u176, u177.CFrame * CFrame.new(-1.068, -2.95, -0.82));
    end));
    u182:Add(task.delay(0.267, function() -- Line: 1726
        -- upvalues: quickVFX (ref), OneTwoPass (copy), u176 (copy), u177 (copy)
        quickVFX(OneTwoPass.BallLand, u176, u177.CFrame * CFrame.new(0.182, -2.95, -4.5));
    end));
    u182:Add(task.delay(0.617, function() -- Line: 1729
        -- upvalues: quickVFX (ref), OneTwoPass (copy), u176 (copy), u177 (copy), u178 (copy), mainreplication (ref), kuronaFlash (ref), u182 (copy)
        quickVFX(OneTwoPass.Pass, u176, u177.CFrame * CFrame.new(0.912, -1.79, -2.52));

        if u178 then
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine);
            kuronaFlash(0.4, 5);
            mainreplication.cameraShake(8, 1, 5);
        end;

        u182:Destroy();
    end));
end;

function u2.orbitalResonanceStart(u187, p188) -- Line: 1741
    -- upvalues: ReplicatedStorage (copy), getRoot (copy), LocalPlayer (copy), actionUtil (copy), mainreplication (copy), createVFX (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), getEmittersLifetime (copy), script_OrbitalStartVFX (copy), TekrinnDialogue (copy), ColorSequence_new_ret (copy), TweenService (copy), disposal (copy)
    local Start = ReplicatedStorage.Resources.kurona.OrbitalResonance.Start;
    local v189 = getRoot(u187);
    local v190 = getRoot(p188);
    p188:FindFirstChild("Head");
    LocalPlayer:FindFirstChild("PlayerGui");

    if not actionUtil.checkGK(LocalPlayer.Character) then
        mainreplication.sceneEnabled(true);
    end;

    local u191 = mainreplication.cutsceneCamRigWithLetterBox(v189, Start.CameraAnim, Start.FOV, u187, CFrame.new(0, -3, 0), Start.Cameraa, "CamPart");
    local u192;

    if typeof(u191) == "Instance" then
        u192 = u191:FindFirstChild("CamPart");
    else
        u192 = false;
    end;

    local u193 = createVFX(Start.RootVFX, u187, v189);
    local u194 = createVFX(Start.tRootVFX, p188, v190);
    local u195 = Start.Vignette:Clone();
    u195.Parent = LocalPlayer:FindFirstChild("PlayerGui");
    u195.ImageLabel.Changed:Connect(function(p196) -- Line: 1762
        -- upvalues: u195 (copy)
        if not table.find({ "ImageTransparency", "ImageColor3" }, p196) then
            return;
        end;

        for _, descendant in u195.ImageLabel:GetDescendants() do
            if descendant:IsA("ImageLabel") then
                descendant[p196] = u195.ImageLabel[p196];
            end;
        end;
    end);
    local v197 = Start.Lighting.Blur:Clone();
    v197.Parent = Lighting;
    local v198 = Start.Lighting.DepthOfField:Clone();
    v198.Parent = Lighting;
    local v199 = MoonPropertyAnimator.new();
    v199:LoadSave(Start.MoonVFX, MoonPropertyAnimator.ConvertSave(Start.MoonVFX, {
        Vignette = u195.ImageLabel,
        DepthOfField = v198,
        Blur = v197
    }));
    v199:PlayAll();
    soundUtil:play(Start.SFX, SoundService);
    local u200 = soundUtil:play(Start.BGM, SoundService);
    local v201 = {
        u193,
        u191,
        u194,
        v199,
        u195,
        v197,
        v198
    };
    local v202 = 0;

    for _, v in v201 do
        local _ = v202 < getEmittersLifetime(v);
    end;

    for i, v in ipairs(script_OrbitalStartVFX) do
        task.delay(v[1] / 60, function() -- Line: 1798
            -- upvalues: v (copy), u192 (copy), u194 (copy), u193 (copy)
            v[2](u192, u194, u193);
        end);

        if i == #script_OrbitalStartVFX then
            v202 = v202 + v[1] / 60;
        end;
    end;

    task.delay(1.718, function() -- Line: 1806
        -- upvalues: TekrinnDialogue (ref), u187 (copy), ColorSequence_new_ret (ref)
        TekrinnDialogue.Speak(u187, {
            {
                Text = "To your right!",
                Bold = true,
                Italic = true,
                Color = ColorSequence_new_ret,
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            }
        }, 3);
    end);
    task.delay(9.443, function() -- Line: 1822
        -- upvalues: TekrinnDialogue (ref), u187 (copy)
        TekrinnDialogue.Speak(u187, {
            {
                Text = "I see.",
                Italic = true,
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 3);
    end);
    task.delay(17.307, function() -- Line: 1837
        -- upvalues: TekrinnDialogue (ref), u187 (copy), ColorSequence_new_ret (ref)
        TekrinnDialogue.Speak(u187, {
            {
                Text = "Follow ",
                Italic = true,
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            },
            {
                Text = "my ",
                Italic = true,
                Bold = true,
                Color = ColorSequence_new_ret,
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            },
            {
                Text = "lead.",
                Italic = true,
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 3);
    end);
    task.delay(18.2, function() -- Line: 1874
        -- upvalues: TweenService (ref), u200 (copy)
        TweenService:Create(u200, TweenInfo.new(1), {
            Volume = 0
        }):Play();
    end);
    task.delay(18.7, function() -- Line: 1878
        -- upvalues: u191 (copy), mainreplication (ref)
        pcall(u191.Destroy, u191);
        mainreplication.sceneEnabled(false);
    end);
    disposal(v201, (math.max(v202, 18.7)));
end;

function u2.orbitalResonanceAutoGoal(u203, u204) -- Line: 1886
    -- upvalues: ReplicatedStorage (copy), getRoot (copy), LocalPlayer (copy), mainreplication (copy), Util (copy), createVFX (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), getEmittersLifetime (copy), script_OrbitalAutoGoalVFX (copy), TekrinnDialogue (copy), ColorSequence_new_ret (copy), TweenService (copy), disposal (copy)
    local AutoGoal = ReplicatedStorage.Resources.kurona.OrbitalResonance.AutoGoal;
    local v205 = getRoot(u203);
    local v206 = getRoot(u204);
    local Head = u204:FindFirstChild("Head");
    local Ball = u203:FindFirstChild("Ball");
    local u207 = Ball:FindFirstChildWhichIsA("Motor6D");
    LocalPlayer:FindFirstChild("PlayerGui");
    local u208;

    if u207 then
        u208 = u207.C0;
    else
        u208 = u207;
    end;

    mainreplication.sceneEnabled(true);
    local ImpactFrames = AutoGoal.ImpactFrames;
    Util.Preload(ImpactFrames);
    local u209 = mainreplication.kuronaCam(v205, AutoGoal.Cam, AutoGoal.FOV);
    local u210 = createVFX(AutoGoal.RootVFX, u203, v205);
    local u211 = createVFX(AutoGoal.tRootVFX, u204, v206);
    local u212 = createVFX(AutoGoal.BallVFX, u203, Ball);
    local u213 = createVFX(AutoGoal.tHeadVFX, u204, Head);
    local u214 = AutoGoal.Lighting.Atmosphere:Clone();
    u214.Parent = Lighting;
    local u215 = AutoGoal.Lighting.ColorCorrection:Clone();
    u215.Parent = Lighting;
    local v216 = MoonPropertyAnimator.new();
    v216:LoadSave(AutoGoal.MoonVFX, MoonPropertyAnimator.ConvertSave(AutoGoal.MoonVFX, {
        Atmosphere = u214,
        ColorCorrection = u215
    }));
    v216:PlayAll();
    soundUtil:play(AutoGoal.SFX, SoundService);
    soundUtil:play(AutoGoal.BGM, SoundService);
    local v217 = {
        u210,
        u209,
        u211,
        u212,
        u213,
        v216
    };
    local v218 = 0;

    for _, v in v217 do
        local _ = v218 < getEmittersLifetime(v);
    end;

    for i, v in ipairs(script_OrbitalAutoGoalVFX) do
        task.delay(v[1] / 60, function() -- Line: 1936
            -- upvalues: v (copy), u204 (copy), u210 (copy), u209 (copy), u211 (copy), u212 (copy), u213 (copy)
            v[2](u204, u210, u209, u211, u212, u213);
        end);

        if i == #script_OrbitalAutoGoalVFX then
            v218 = v218 + v[1] / 60;
        end;
    end;

    task.delay(4.285, function() -- Line: 1944
        -- upvalues: TekrinnDialogue (ref), u203 (copy)
        TekrinnDialogue.Speak(u203, {
            {
                Text = "Let\'s go, ",
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 3);
    end);
    task.delay(5.043, function() -- Line: 1958
        -- upvalues: TekrinnDialogue (ref), u203 (copy), ColorSequence_new_ret (ref)
        TekrinnDialogue.Speak(u203, {
            {
                Text = "SMASH IT!",
                Bold = true,
                Italic = true,
                Color = ColorSequence_new_ret,
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            }
        }, 3);
    end);
    task.delay(10.9, function() -- Line: 1974
        -- upvalues: u209 (copy), u207 (copy), TweenService (ref), u208 (copy)
        u209.Weld.C0 = CFrame.new(0, 0, -25);

        if u207 then
            TweenService:Create(u207, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                C0 = u208 * CFrame.new(0, 0, -25)
            }):Play();
        end;
    end);
    task.delay(10.9 - #ImpactFrames:GetChildren() / 24, function() -- Line: 1984
        -- upvalues: Util (ref), ImpactFrames (copy)
        Util.Gif(ImpactFrames, 24);
    end);
    task.delay(12.65, function() -- Line: 1988
        -- upvalues: u214 (copy), u215 (copy), u209 (copy), u207 (copy), u208 (copy), mainreplication (ref)
        pcall(u214.Destroy, u214);
        pcall(u215.Destroy, u215);
        pcall(u209.Destroy, u209);

        if u207 then
            u207.C0 = u208;
        end;

        mainreplication.sceneEnabled(false);
    end);
    disposal(v217, (math.max(v218, 12.65)));
end;

function u2.speedyTurnLeft(p219, p220) -- Line: 2001
    -- upvalues: getRoot (copy), ReplicatedStorage (copy), trove (copy), TweenService (copy), soundUtil (copy), isLocalPlayer (copy), SoundService (copy), mainreplication (copy), kuronaFlash (copy), BackgroundHighlight (copy), createVFX (copy), RunService (copy), getEmitterLifetime (copy), disposal (copy), emitAll (copy)
    local u221 = 70 * p220;
    local u222 = getRoot(p219);
    local Torso = p219:FindFirstChild("Torso");
    local kurona = ReplicatedStorage.Resources.kurona;
    local u223 = trove.new();
    u223:AttachToInstance(p219);
    local u224 = kurona.Aura:Clone();
    u224.Parent = Torso;
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.FillTransparency = 0;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = p219;
    TweenService:Create(Highlight, TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
        FillColor = Color3.fromRGB(255, 0, 136)
    }):Play();
    soundUtil:play(kurona.SpeedyTurnSFX, isLocalPlayer(p219) and SoundService or u222);

    if isLocalPlayer(p219) then
        mainreplication.fov(false, 95);
        kuronaFlash(1, 5);
        mainreplication.fov(true, 70, 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    u223:Add(Highlight);
    BackgroundHighlight({
        Speed = 0.667,
        Brightness = 1,
        ImageTransparency = 0.5,
        CountSpeed = 0.083375,
        Count = 8,
        Whitelist = { p219 },
        BlacklistedParts = { "Ball" },
        Color = Color3.fromRGB(255, 67, 158)
    });
    local u225 = createVFX(kurona.SpeedyTurnVFX, p219, u222);
    local u226, u227 = mainreplication.bodyVelocity(u222, u221, 0.667, nil, nil, true, TweenInfo.new(0.817, Enum.EasingStyle.Cubic, Enum.EasingDirection.In));
    local CFrame2 = u222.CFrame;

    if u226 then
        local u228 = 0;
        u223:Add(u226);
        u223:Add(RunService.RenderStepped:Connect(function(p229) -- Line: 2047
            -- upvalues: u228 (ref), u226 (copy), u222 (copy), CFrame2 (copy), u227 (copy), u221 (copy), TweenService (ref)
            u228 = u228 + p229;

            if u226.Parent == u222 then
                local math_clamp_ret = math.clamp(u228 / 0.667, 0, 1);
                u226.Velocity = CFrame2.LookVector * u227.Value + -CFrame2.RightVector * (u221 * 2) * (1 - TweenService:GetValue(math_clamp_ret, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
            end;
        end));
    end;

    u223:Add(function() -- Line: 2055
        -- upvalues: u224 (copy), getEmitterLifetime (ref), disposal (ref)
        local v230 = 0;

        for _, child in u224:GetChildren() do
            local v231 = getEmitterLifetime(child);

            if v231 > 0 then
                child.Enabled = false;

                if v230 < v231 then
                    v230 = v231;
                end;
            end;
        end;

        disposal(u224, v230);
    end);
    u223:Add(task.delay(0.067, function() -- Line: 2068
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.166, Enum.EasingStyle.Cubic), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end));
    u223:Add(task.delay(0.167, function() -- Line: 2074
        -- upvalues: emitAll (ref), u225 (copy)
        emitAll(u225.One);
    end));
    u223:Add(task.delay(0.333, function() -- Line: 2077
        -- upvalues: emitAll (ref), u225 (copy)
        emitAll(u225.Two);
    end));
    u223:Add(task.delay(0.667, function() -- Line: 2080
        -- upvalues: u223 (copy)
        u223:Destroy();
    end));
end;

return u2;