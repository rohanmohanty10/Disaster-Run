 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local trove = require(ReplicatedStorage.forum.trove);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local CleanupHelper = require(ReplicatedStorage.util.CleanupHelper);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local raycast = require(ReplicatedStorage.util.raycast);
local Util = require(ReplicatedStorage.util.Util);
local dio = vfxUtil.getResources().dio;
local emit = vfxUtil.forge.emit;
local Linear = Enum.EasingStyle.Linear;
local u1 = {};
setmetatable({}, {
    __mode = "k"
});

local function toggle(p2: userdata, p3: number, p4: userdata?) -- Line: 31
    -- upvalues: TweenService (copy)
    if p4 then
        TweenService:Create(p2, p4, {
            Transparency = p3
        }):Play();

        return;
    end;

    p2.Transparency = p3;
end;

local function toggleStand(p5: any, p6: number, p7: userdata?) -- Line: 39
    -- upvalues: TweenService (copy)
    local HumanoidRootPart = p5.HumanoidRootPart;

    for _, child in p5:GetChildren() do
        if child ~= HumanoidRootPart then
            if child:IsA("BasePart") then
                if p7 then
                    TweenService:Create(child, p7, {
                        Transparency = p6
                    }):Play();
                else
                    child.Transparency = p6;
                end;

                if child.Name == "Head" and child:FindFirstChild("face") then
                    local face = child.face;

                    if p7 then
                        TweenService:Create(face, p7, {
                            Transparency = p6
                        }):Play();
                    else
                        face.Transparency = p6;
                    end;
                end;
            elseif child:IsA("Accessory") and child:FindFirstChild("Handle") then
                local Handle = child.Handle;

                if p7 then
                    TweenService:Create(Handle, p7, {
                        Transparency = p6
                    }):Play();
                else
                    Handle.Transparency = p6;
                end;
            end;
        end;
    end;
end;

local function latchStand(p8: any, p9: boolean) -- Line: 54
    -- upvalues: soundUtil (copy), dio (copy)
    local HumanoidRootPart = p8.HumanoidRootPart;
    HumanoidRootPart.Weld.Enabled = p9;

    if p9 then
        soundUtil:play(dio.Summon, HumanoidRootPart);
    end;
end;

local function getStand(u10) -- Line: 62
    -- upvalues: vfxUtil (copy), trove (copy), dio (copy), Players (copy), toggleStand (copy)
    local v11 = `Stand_{u10.Name}`;
    local v12 = workspace.Effects:FindFirstChild(v11);

    if not v12 then
        local Root = vfxUtil.getRoot(u10);
        local v13 = trove.new();
        v13:AttachToInstance(u10);
        v12 = v13:Clone(dio.Stand);
        v12.HumanoidRootPart.Weld.Part0 = Root;
        v12.Name = v11;
        v12.HumanoidRootPart.Weld.Enabled = false;
        v12.Parent = workspace.Effects;
        local Humanoid = v12.Humanoid;
        xpcall(function() -- Line: 79
            -- upvalues: Players (ref), u10 (copy), Humanoid (copy)
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(u10);

            if PlayerFromCharacter then
                local setting = PlayerFromCharacter:FindFirstChild("setting");

                if setting then
                    setting = setting:FindFirstChild("DuoMvp");
                end;

                local u14 = setting and (not table.find({ 0, 1 }, setting.Value) and setting.Value or 488410462) or 488410462;
                local success, result = pcall(function() -- Line: 87
                    -- upvalues: Players (ref), u14 (copy)
                    return Players:GetHumanoidDescriptionFromUserId(u14);
                end);

                if success then
                    Humanoid:ApplyDescriptionAsync(result);
                end;
            end;
        end, warn);
        toggleStand(v12, 1);
    end;

    for _, child in v12:GetChildren() do
        if child:IsA("BasePart") then
            child.CanCollide = false;
        end;
    end;

    return v12;
end;

function u1.dioTP_Start(p15: any, p16, u17: number) -- Line: 111
    -- upvalues: dio (copy), vfxUtil (copy), trove (copy), Lighting (copy), TweenService (copy), mainreplication (copy), Util (copy), Players (copy), emit (copy), soundUtil (copy)
    local TP = dio.TP;
    local Root = vfxUtil.getRoot(p15);
    local v18 = vfxUtil.isLocalPlayer(p15);
    local u19 = trove.new();
    u19:AttachToInstance(p15);

    if v18 then
        local u20 = u19:Clone(TP.ColorCorrection);
        u20.Parent = Lighting;
        TweenService:Create(u20, TweenInfo.new(0.5 / u17), {
            Brightness = 0,
            Saturation = -1
        }):Play();
        mainreplication.fov(true, 50, 0.7 / u17, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut);
        task.delay(0.5 / u17, function() -- Line: 125
            -- upvalues: TweenService (ref), u20 (copy), u17 (copy)
            TweenService:Create(u20, TweenInfo.new(0.5 / u17), {
                Saturation = 0
            }):Play();
        end);
        task.delay(0.8 / u17, function() -- Line: 128
            -- upvalues: mainreplication (ref)
            mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        end);
    end;

    local v21 = u19:Clone(TP.VFX);
    v21:PivotTo(p16);

    for _, child in v21:GetChildren() do
        local Attribute = child:GetAttribute("EffectDuration");

        if typeof(Attribute) == "number" then
            child:SetAttribute("EffectDuration", Attribute * 2);
        end;
    end;

    v21.Parent = workspace.Effects;

    if Util.canshiftcolor(Players.LocalPlayer, p15) then
        vfxUtil.LeanTowardsColor(v21, p15:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p15:GetAttribute("CustomAlpha") or 0.985);
    end;

    emit(v21);
    local u22 = u19:Add(soundUtil:play(TP.SFX, Root));
    u19:Add(task.delay(vfxUtil.getEmittersLifetime(v21, u22), function() -- Line: 151
        -- upvalues: u19 (copy), u22 (copy)
        u19:Pop(u22);
        u19:Destroy();
    end));
end;

function u1.dio_flow_shot(p23) -- Line: 157
    -- upvalues: dio (copy), getStand (copy), vfxUtil (copy), soundUtil (copy), toggleStand (copy), Linear (copy), mainreplication (copy), SoundService (copy), Lighting (copy), trove (copy), Util (copy), Players (copy), animationUtil (copy), MoonPropertyAnimator (copy)
    local Awaken = dio.FirstMove.Awaken;
    local u24 = getStand(p23);
    local Root = vfxUtil.getRoot(p23);
    p23:FindFirstChild("Ball");
    local HumanoidRootPart = u24.HumanoidRootPart;
    HumanoidRootPart.Weld.Enabled = true;
    soundUtil:play(dio.Summon, HumanoidRootPart);
    toggleStand(u24, 0, TweenInfo.new(0, Linear));
    mainreplication.sceneEnabled(true);
    soundUtil:play(Awaken.SFX, SoundService, {
        Character = p23
    });
    local u25 = {};
    local u26 = {};

    for _, child in Lighting:GetChildren() do
        if child:IsA("Atmosphere") or (child:IsA("Sky") or (child:IsA("BloomEffect") or (child:IsA("BlurEffect") or (child:IsA("ColorCorrectionEffect") or (child:IsA("DepthOfFieldEffect") or child:IsA("SunRaysEffect")))))) then
            table.insert(u25, child);
            child.Parent = workspace;
        end;
    end;

    for _, child in Awaken.Lighting:GetChildren() do
        local v27 = child:Clone();
        v27.Parent = Lighting;
        u26[v27.ClassName] = v27;
    end;

    local u28 = mainreplication.kuronaCam(Root, Awaken.Cam, Awaken.FOV);
    local u29 = trove.new();
    local u30 = u29:Add(Awaken.VFX:Clone());
    u30.Parent = workspace.Effects;
    u30:PivotTo(Root.CFrame);

    if Util.canshiftcolor(Players.LocalPlayer, p23) then
        vfxUtil.LeanTowardsColor(u30, p23:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p23:GetAttribute("CustomAlpha") or 0.985);
    end;

    u29:Add(animationUtil:loadAnimation(u24, Awaken.Stand), "Stop"):Play(0);
    u29:AttachToInstance(p23);
    u29:Add(u28);
    u29:Add(task.delay(0.18333333333333332, function() -- Line: 202
        -- upvalues: u28 (copy), u30 (copy)
        shared.vfx.emit(u28.CameraImpacts:FindFirstChild("Start"));
        shared.vfx.emit(u30:FindFirstChild("PreImpact"));
    end));
    u29:Add(task.delay(1.0666666666666667, function() -- Line: 207
        -- upvalues: u30 (copy)
        shared.vfx.emit(u30:FindFirstChild("ImpactSmoke"));
    end));
    u29:Add(task.delay(1.25, function() -- Line: 211
        -- upvalues: u28 (copy), u30 (copy)
        shared.vfx.emit(u28.CameraImpacts:FindFirstChild("Final"));
        shared.vfx.emit(u30:FindFirstChild("KickImpact"));
        shared.vfx.emit(u30:FindFirstChild("Wind"));
    end));
    u29:Add(task.delay(1.2666666666666666, function() -- Line: 217
        -- upvalues: u30 (copy)
        shared.vfx.emit(u30:FindFirstChild("AuraFarming"));
    end));
    u29:Add(function() -- Line: 221
        -- upvalues: u24 (copy), toggleStand (ref), Linear (ref), mainreplication (ref), u25 (copy), Lighting (ref), u26 (copy)
        u24.HumanoidRootPart.Weld.Enabled = false;
        toggleStand(u24, 1, TweenInfo.new(0, Linear));
        mainreplication.sceneEnabled(false);

        for _, v in u25 do
            pcall(function() -- Line: 227
                -- upvalues: v (copy), Lighting (ref)
                v.Parent = Lighting;
            end);
        end;

        for _, v in u26 do
            pcall(game.Destroy, v);
        end;
    end);
    local v31 = {
        Workspace = u30,
        Cam = u28,
        Bloom = Lighting.Bloom,
        ColorCorrection = Lighting.ColorCorrection
    };
    local v32 = u29:Construct(MoonPropertyAnimator);
    v32:LoadSave(Awaken.Moon, MoonPropertyAnimator.ConvertSave(Awaken.Moon, v31));
    v32:SetRoot(Root);
    v32:SetOriginalRoot(Awaken.VFX.Root.CFrame);
    v32:PlayAll();
    u29:Add(task.delay(2.22, function() -- Line: 249
        -- upvalues: u29 (copy)
        u29:Destroy();
    end));
end;

function u1.dioTP_End(p33: any, p34, p35) -- Line: 254
    -- upvalues: dio (copy), trove (copy), emit (copy), Util (copy), Players (copy), vfxUtil (copy)
    local TP = dio.TP;
    local u36 = trove.new();
    u36:AttachToInstance(p33);
    local v37 = u36:Clone(TP.VFX);
    v37:PivotTo(p34);
    v37.Parent = workspace.Effects;
    local v38 = u36:Clone(TP.VFX);
    v38:PivotTo(p35);
    v38.Parent = workspace.Effects;
    local v39 = u36:Clone(TP.tp);
    v39.CFrame = p35 * CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966);
    v39.Parent = workspace.Effects;
    emit(v39, v37, v38);

    if Util.canshiftcolor(Players.LocalPlayer, p33) then
        vfxUtil.LeanTowardsColor({ v37, v38, v39 }, p33:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p33:GetAttribute("CustomAlpha") or 0.985);
    end;

    u36:Add(task.delay(vfxUtil.getBulkEmittersLifetime(v39, v37, v38), function() -- Line: 278
        -- upvalues: u36 (copy)
        u36:Destroy();
    end));
end;

function u1.counter_land(p40: any, p41, p42) -- Line: 283
    -- upvalues: u1 (copy), dio (copy), vfxUtil (copy), Lighting (copy), TweenService (copy), mainreplication (copy), soundUtil (copy)
    u1.dioTP_End(p40, p41, p42);
    local TP = dio.TP;
    local v43 = vfxUtil.isLocalPlayer(p40);
    local Root = vfxUtil.getRoot(p40);

    if v43 then
        local u44 = TP.ColorCorrection:Clone();
        u44.Parent = Lighting;
        TweenService:Create(u44, TweenInfo.new(0.5), {
            Brightness = 0,
            Saturation = -1
        }):Play();
        mainreplication.fov(true, 50, 0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut);
        task.delay(0.5, function() -- Line: 296
            -- upvalues: TweenService (ref), u44 (copy)
            TweenService:Create(u44, TweenInfo.new(0.5), {
                Saturation = 0
            }):Play();
            task.wait(0.5);
            u44:Destroy();
        end);
        task.delay(0.8, function() -- Line: 302
            -- upvalues: mainreplication (ref)
            mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        end);
    end;

    local v45 = soundUtil:play(TP.SFX, Root);
    task.delay(v45.TimeLength, v45.Destroy, v45);
end;

function u1.dioGreatestHigh_Dash(p46) -- Line: 311
    -- upvalues: dio (copy), vfxUtil (copy), trove (copy), mainreplication (copy)
    local _ = dio.GreatestHigh;
    local Root = vfxUtil.getRoot(p46);
    local u47 = trove.new();
    u47:AttachToInstance(p46);
    u47:Add(task.delay(0.233, function() -- Line: 319
        -- upvalues: mainreplication (ref), Root (copy)
        mainreplication.bodyVelocity(Root, 200, 0.434, false, nil, false, TweenInfo.new(1, Enum.EasingStyle.Quart));
    end));
    u47:Add(task.delay(1.117, function() -- Line: 323
        -- upvalues: u47 (copy)
        u47:Destroy();
    end));
end;

function u1.dioGreatestHigh_Steal(u48, p49) -- Line: 328
    -- upvalues: dio (copy), vfxUtil (copy), getStand (copy), soundUtil (copy), trove (copy), CleanupHelper (copy), toggleStand (copy), Linear (copy), emit (copy), Util (copy), Players (copy), animationUtil (copy), Lighting (copy), TweenService (copy), mainreplication (copy)
    local GreatestHigh = dio.GreatestHigh;
    local Root = vfxUtil.getRoot(u48);
    local u50 = getStand(u48);
    local v51 = vfxUtil.isLocalPlayer(u48, p49);
    local HumanoidRootPart = u50.HumanoidRootPart;
    HumanoidRootPart.Weld.Enabled = true;
    soundUtil:play(dio.Summon, HumanoidRootPart);
    local u52 = trove.new();
    u52:AttachToInstance(u48);
    local u53 = CleanupHelper.new();
    u53.Trove = u52;
    u52:Add(task.delay(1, function() -- Line: 343
        -- upvalues: toggleStand (ref), u50 (copy), Linear (ref)
        toggleStand(u50, 1, TweenInfo.new(0.6, Linear));
    end));
    local v54 = u53:Clone(GreatestHigh.VFX);
    v54.Root.Weld.Part0 = Root;
    v54.Parent = workspace.Effects;
    emit(v54.DioTeleportVFX);
    local u55 = u53:Clone(GreatestHigh.LeftLeg);
    u55.Weld.Part0 = u50["Left Leg"];
    u55.Parent = workspace.Effects;

    if Util.canshiftcolor(Players.LocalPlayer, u48) then
        vfxUtil.LeanTowardsColor({ v54, u55 }, u48:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u48:GetAttribute("CustomAlpha") or 0.985);
    end;

    u52:Add(animationUtil:loadAnimation(u50, GreatestHigh.Animations.Stand), "Stop"):Play(0);
    toggleStand(u50, 0, TweenInfo.new(0.333, Linear));

    if v51 then
        local u56 = u52:Construct(Instance, "ColorCorrectionEffect");
        u56.Parent = Lighting;
        TweenService:Create(u56, TweenInfo.new(0.55, Linear), {
            Saturation = -1
        }):Play();
        mainreplication.fov(true, 30, 0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        u52:Add(task.delay(0.6, function() -- Line: 370
            -- upvalues: mainreplication (ref), u56 (copy), TweenService (ref)
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            u56.Contrast = -2;
            u56.Saturation = -2;
            TweenService:Create(u56, TweenInfo.new(1), {
                Contrast = 0,
                Saturation = 0
            }):Play();
        end));
    end;

    u52:Add(task.delay(0.15, function() -- Line: 379
        -- upvalues: emit (ref), u55 (copy)
        emit(u55);
    end));
    u52:Add(task.delay(0.3, function() -- Line: 383
        -- upvalues: soundUtil (ref), GreatestHigh (copy), Root (copy)
        soundUtil:play(GreatestHigh.SFX, Root);
    end));
    u52:Add(task.delay(0.583, function() -- Line: 387
        -- upvalues: u53 (copy), GreatestHigh (copy), Root (copy), emit (ref), Util (ref), Players (ref), u48 (copy), vfxUtil (ref)
        local v57 = u53:Clone(GreatestHigh.KickVFX);
        v57.CFrame = Root.CFrame * v57.Offset.Value;
        v57.Parent = workspace.Effects;
        emit(v57);

        if Util.canshiftcolor(Players.LocalPlayer, u48) then
            vfxUtil.LeanTowardsColor(v57, u48:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u48:GetAttribute("CustomAlpha") or 0.985);
        end;
    end));
    u52:Add(task.delay(1.6, function() -- Line: 397
        -- upvalues: u50 (copy), u52 (copy), u53 (copy)
        u50.HumanoidRootPart.Weld.Enabled = false;
        u52:Add(task.delay(u53:GetTimeLeft(), function() -- Line: 399
            -- upvalues: u52 (ref)
            u52:Destroy();
        end));
    end));
end;

function u1.dioGreatestHigh_StealFlow(u58, u59) -- Line: 405
    -- upvalues: dio (copy), vfxUtil (copy), getStand (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), mainreplication (copy), trove (copy), animationUtil (copy), Util (copy), toggleStand (copy), Linear (copy), MoonPropertyAnimator (copy)
    local Flow = dio.GreatestHigh.Flow;
    local Root = vfxUtil.getRoot(u58);
    local u60 = getStand(u58);
    local HumanoidRootPart = u60.HumanoidRootPart;
    HumanoidRootPart.Weld.Enabled = true;
    soundUtil:play(dio.Summon, HumanoidRootPart);
    soundUtil:play(ReplicatedStorage.Resources.dcsound, SoundService);
    mainreplication.fov(false, 100);
    mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    mainreplication.cameraShake(10, 2, 6);
    task.wait(1);
    local u61 = trove.new();
    u61:AttachToInstance(u58);
    mainreplication.sceneEnabled(true);
    u61:Add(function() -- Line: 425
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    u61:Add(function() -- Line: 429
        -- upvalues: vfxUtil (ref)
        vfxUtil.restore_lighting();
        vfxUtil.restore_lighting_properties();
    end);
    local u62 = u61:Clone(Flow.Knives);
    u62:PivotTo(Root.CFrame);
    u62.Parent = workspace.Effects;
    soundUtil:play(Flow.SFX, "default");
    u61:Add(task.spawn(function() -- Line: 443
        -- upvalues: Flow (copy), u58 (copy), u61 (copy), u59 (copy)
        for _, descendant in Flow.Aura:GetDescendants() do
            if not (descendant:IsA("ParticleEmitter") and descendant.Parent:IsA("Attachment")) and (descendant:IsA("Attachment") or descendant:IsA("ParticleEmitter")) then
                local v63 = u58:FindFirstChild(descendant.Parent.Name, true);

                if v63 then
                    u61:Clone(descendant).Parent = v63;
                end;
            end;
        end;

        for _, descendant in Flow.VictimAura:GetDescendants() do
            if not (descendant:IsA("ParticleEmitter") and descendant.Parent:IsA("Attachment")) and (descendant:IsA("Attachment") or descendant:IsA("ParticleEmitter")) then
                local v64 = u59:FindFirstChild(descendant.Parent.Name, true);

                if v64 then
                    u61:Clone(descendant).Parent = v64;
                end;
            end;
        end;
    end));

    for _, child in Flow.VFX:GetChildren() do
        if child:IsA("Part") then
            local v65 = u61:Clone(child);
            v65:FindFirstChildOfClass("Motor6D").Part0 = Root;
            v65.Parent = u58;
        end;
    end;

    u61:Add(animationUtil:loadAnimation(u58, Flow.User), "Stop"):Play(0);
    local u66 = u61:Add(animationUtil:loadAnimation(u59, Flow.Victim), "Stop");
    u66:Play(0);
    u61:Add(task.delay(u66.Length * 0.9999999, function() -- Line: 498
        -- upvalues: u66 (ref), u61 (copy), animationUtil (ref), u59 (copy), Flow (copy)
        u66 = u61:Add(animationUtil:loadAnimation(u59, Flow.Victim), "Stop");
        u66:Play(0, 1, 0);
        u66.TimePosition = u66.Length * 0.9999999;
        u66:AdjustSpeed(0);
    end));
    local u67 = u61:Add(animationUtil:loadAnimation(u60, Flow.Stand), "Stop");
    u67:Play(0);
    u61:Add(task.delay(u67.Length * 0.9999999, function() -- Line: 508
        -- upvalues: u67 (ref), u61 (copy), animationUtil (ref), u60 (copy), Flow (copy)
        u67 = u61:Add(animationUtil:loadAnimation(u60, Flow.Stand), "Stop");
        u67:Play(0, 1, 0);
        u67.TimePosition = u67.Length * 0.9999999;
        u67:AdjustSpeed(0);
    end));
    u61:Add(task.delay(12.68, function() -- Line: 515
        -- upvalues: Util (ref), Flow (copy)
        Util.Gif(Flow.ImpactFrames);
    end));
    local v68 = u61:Add(vfxUtil.highlight(u58, {
        Name = "Highlight",
        Enabled = true,
        FillTransparency = 1,
        OutlineTransparency = 1,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = Color3.new(1, 0, 0),
        OutlineColor = Color3.new(1, 1, 1)
    }));
    toggleStand(u60, 0, TweenInfo.new(0, Linear));
    local v69 = mainreplication.kuronaCamToAll(Root, Flow.Cam, Flow.FOV);
    u61:Add(v69);
    vfxUtil.execute_compiled(Flow.Compiled, u61, v69, u58, u59);
    local v70 = {
        Cam = v69,
        Highlight = v68
    };
    vfxUtil.contain_lighting(u61, v70, Flow.Lighting);
    u61:Add(task.spawn(function() -- Line: 546
        -- upvalues: u62 (copy)
        for _, child in u62:GetChildren() do
            if child:IsA("Model") then
                local u71 = child:FindFirstChildOfClass("AnimationController"):LoadAnimation(child:FindFirstChildOfClass("Animation"));
                u71:Play(0);
                task.delay(u71.Length * 0.9999999, function() -- Line: 555
                    -- upvalues: u71 (copy)
                    u71.TimePosition = u71.Length * 0.9999999;
                    u71:AdjustSpeed(0);
                end);
            end;
        end;
    end));
    u61:Add(task.delay(8.5, function() -- Line: 564
        -- upvalues: u62 (copy)
        for _, descendant in u62:GetDescendants() do
            if descendant:IsA("MeshPart") then
                descendant.Transparency = 0;
            end;
        end;
    end));
    local v72 = u61:Construct(MoonPropertyAnimator);
    v72:LoadAndConvertSave(Flow.Moon, v70);
    v72:SetRoot(Root);
    v72:SetOriginalRoot(Flow.VFX.Root.Value);
    v72:PlayAll();
    u61:Add(task.delay(13.39, function() -- Line: 580
        -- upvalues: toggleStand (ref), u60 (copy), Linear (ref), u61 (copy)
        toggleStand(u60, 1, TweenInfo.new(0, Linear));
        u60.HumanoidRootPart.Weld.Enabled = false;
        u61:Destroy();
    end));
end;

local u73 = nil;

function u1.dioFlow_On(u74: any, u75: any, p76: number) -- Line: 590
    -- upvalues: dio (copy), vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Util (copy), Players (copy), Lighting (copy), MoonPropertyAnimator (copy), u73 (ref), TekrinnDialogue (copy)
    local OnTheBall = dio.OnTheBall;
    local Root = vfxUtil.getRoot(u74);
    local u77 = trove.new();
    u77:Add(function() -- Line: 596
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    u77:Add(task.delay(p76, function() -- Line: 599
        -- upvalues: u77 (copy)
        u77:Destroy();
    end));
    mainreplication.sceneEnabled(true);
    soundUtil:play(OnTheBall.SFX, SoundService, {
        Character = u74
    });
    local v78 = u77:Add(mainreplication.kuronaCam(Root, OnTheBall.Cam, OnTheBall.FOV));
    local v79 = u77:Add(vfxUtil.getMoonEffects());
    local v80 = u77:Clone(OnTheBall.VFX);
    v80:PivotTo(Root.CFrame);
    v80.Parent = workspace.Effects;
    local v81 = u77:Clone(OnTheBall.AuraDio);
    vfxUtil.setupAura(u74, v81);
    v81.Parent = workspace.Effects;
    local v82 = u77:Clone(OnTheBall.JotaroAura);
    vfxUtil.setupAura(u75, v82);
    v82.Parent = workspace.Effects;

    if Util.canshiftcolor(Players.LocalPlayer, u74) then
        vfxUtil.LeanTowardsColor({ v80, v81, v82 }, u74:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u74:GetAttribute("CustomAlpha") or 0.985);
    end;

    local v83 = u77:Add(Instance.new("Highlight"));
    v83.FillColor = Color3.fromRGB(133, 76, 255);
    v83.FillTransparency = 0.65;
    v83.OutlineColor = Color3.fromRGB(123, 46, 255);
    v83.OutlineTransparency = 1;
    v83.Parent = u74;
    local v84 = {
        ["Screen Cover"] = v79["Screen Cover"],
        Letterbox = v79.Letterbox.Letterbox,
        Workspace = v80,
        Cam = v78,
        DioImpactMenacing = v83
    };

    for _, child in OnTheBall.Lighting:GetChildren() do
        local v85 = u77:Clone(child);
        v85.Parent = Lighting;
        v84[child.Name] = v85;
    end;

    local v86 = u77:Construct(MoonPropertyAnimator);
    v86:LoadAndConvertSave(OnTheBall.Moon, v84);
    v86:SetOriginalRoot(OnTheBall.VFX.Root.CFrame);
    v86:SetRoot(Root);
    v86:PlayAll();

    if not u73 then
        u73 = {};

        for _, child in script.OnTheBall:GetChildren() do
            table.insert(u73, require(child));
        end;
    end;

    for _, v in u73 do
        for _, v2 in v do
            u77:Add(task.delay(v2[1] / 60, v2[2], v80, v81, v82));
        end;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u74);
    u77:Add(task.delay(2.156, function() -- Line: 666
        -- upvalues: TekrinnDialogue (ref), u75 (copy), PlayerFromCharacter (copy), u74 (copy)
        TekrinnDialogue.Speak(u75.Name, {
            {
                Bold = true,
                Text = `{string.upper(PlayerFromCharacter and PlayerFromCharacter.DisplayName or u74.Name)}!`,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 3);
    end));
    u77:Add(task.delay(3.749, function() -- Line: 688
        -- upvalues: TekrinnDialogue (ref), u74 (copy)
        TekrinnDialogue.Speak(u74, {
            {
                Text = "Oh..",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 3);
    end));
    u77:Add(task.delay(4.59, function() -- Line: 708
        -- upvalues: TekrinnDialogue (ref), u74 (copy)
        TekrinnDialogue.Speak(u74, {
            {
                Text = ".. you\'re approaching me?",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 3);
    end));
    u77:Add(task.delay(5.793, function() -- Line: 728
        -- upvalues: TekrinnDialogue (ref), u74 (copy)
        TekrinnDialogue.Speak(u74, {
            {
                Text = "Instead of running away, you\'re running at me?",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 2.8370000000000006);
    end));
    u77:Add(task.delay(10.975, function() -- Line: 748
        -- upvalues: TekrinnDialogue (ref), u75 (copy)
        TekrinnDialogue.Speak(u75.Name, {
            {
                Text = "I can\'t steal the ball without getting any closer.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 6);
    end));
    u77:Add(task.delay(13.977, function() -- Line: 768
        -- upvalues: TekrinnDialogue (ref), u74 (copy)
        TekrinnDialogue.Speak(u74, {
            {
                Text = "Oh, ho!",
                Italic = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 3);
    end));
    u77:Add(task.delay(15.689, function() -- Line: 790
        -- upvalues: TekrinnDialogue (ref), u74 (copy)
        TekrinnDialogue.Speak(u74, {
            {
                Text = "Then, come as close as you\'d like.",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 2.6950000000000003);
    end));
end;

local u87 = nil;

function u1.dioTimestop(u88) -- Line: 815
    -- upvalues: dio (copy), vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Util (copy), Players (copy), Lighting (copy), MoonPropertyAnimator (copy), u87 (ref), TekrinnDialogue (copy)
    local Timestop = dio.Timestop;
    local Root = vfxUtil.getRoot(u88);
    local u89 = trove.new();
    u89:AttachToInstance(u88);
    mainreplication.sceneEnabled(true);
    u89:Add(function() -- Line: 823
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    soundUtil:play(Timestop.SFX, SoundService);
    local v90 = u89:Clone(Timestop.Aura);
    vfxUtil.setupAura(u88, v90);
    v90.Parent = workspace.Effects;
    local v91, v92 = mainreplication.cutsceneCamRigWithLetterBox(Root, Timestop.Animations.Cam, Timestop.FOV, nil, CFrame.new(0, -3, 0), Timestop.Cam, "CamPart", "All");

    if v92 then
        u89:Add(v92);
    end;

    local v93 = u89:Clone(Timestop.VFX);
    v93:PivotTo(Root.CFrame);
    v93.Parent = workspace.Effects;

    if Util.canshiftcolor(Players.LocalPlayer, u88) then
        vfxUtil.LeanTowardsColor(v93, u88:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u88:GetAttribute("CustomAlpha") or 0.985);
    end;

    local v94 = u89:Add(Instance.new("Highlight"));
    v94.FillColor = Color3.fromRGB(112, 186, 255);
    v94.FillTransparency = -2;
    v94.OutlineColor = Color3.new(0, 0, 0);
    v94.OutlineTransparency = 1;
    v94.Parent = v93.up2sum;
    local v95 = u89:Add(Instance.new("Highlight"));
    v95.FillTransparency = 1;
    v95.OutlineTransparency = 1;
    v95.Parent = v93.DistortionBall;
    local v96 = {
        Workspace = v93
    };

    for _, child in Lighting:GetChildren() do
        local v97 = u89:Clone(child);
        v97.Parent = Lighting;
        v96[child.Name] = v97;
    end;

    local v98 = u89:Construct(MoonPropertyAnimator);
    v98:LoadAndConvertSave(Timestop.Moon, v96);
    v98:SetOriginalRoot(Timestop.VFX.Root.CFrame);
    v98:SetRoot(Root);
    v98:PlayAll();

    if not u87 then
        u87 = require(script.Timestop);
    end;

    for _, v in ipairs(u87) do
        u89:Add(task.delay(v[1] / 60, v[2], v93, v91));
    end;

    u89:Add(task.delay(5.833, function() -- Line: 880
        -- upvalues: u89 (copy)
        u89:Destroy();
    end));
    u89:Add(task.delay(0.137, function() -- Line: 884
        -- upvalues: TekrinnDialogue (ref), u88 (copy)
        TekrinnDialogue.Speak(u88, {
            {
                Text = "I\'ll finish you all off in one go!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }, 6);
    end));
    u89:Add(task.delay(3.062, function() -- Line: 903
        -- upvalues: TekrinnDialogue (ref), u88 (copy)
        TekrinnDialogue.Speak(u88, {
            {
                Text = "THE WORLD!",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 2
                }
            }
        }, 1.722);
    end));
end;

function u1.dio_skill1_base_start(p99) -- Line: 925
    -- upvalues: dio (copy), vfxUtil (copy), getStand (copy), soundUtil (copy), toggleStand (copy), Linear (copy), animationUtil (copy), trove (copy), Util (copy), Players (copy), Lighting (copy), MoonPropertyAnimator (copy), mainreplication (copy)
    local Base = dio.FirstMove.Base;
    local Root = vfxUtil.getRoot(p99);
    local u100 = getStand(p99);
    local HumanoidRootPart = u100.HumanoidRootPart;
    HumanoidRootPart.Weld.Enabled = true;
    soundUtil:play(dio.Summon, HumanoidRootPart);
    toggleStand(u100, 0, TweenInfo.new(0, Linear));
    animationUtil:loadAnimation(u100, Base.Stand):Play(0);
    local u101 = trove.new();
    u101:AttachToInstance(p99);
    local u102 = u101:Add(vfxUtil.highlight(p99, {
        Name = "Highlight",
        Enabled = true,
        FillTransparency = 1,
        OutlineTransparency = 1,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = Color3.new(1, 1, 1),
        OutlineColor = Color3.new(1, 1, 1)
    }));
    u101:Add(u102:GetPropertyChangedSignal("FillTransparency"):Connect(function() -- Line: 948
        -- upvalues: u102 (copy)
        print(u102.FillTransparency);
    end));
    local v103 = dio:FindFirstChild("Ball Trail"):Clone();
    v103.Parent = workspace.Effects;
    v103:FindFirstChildOfClass("Weld").Part1 = p99:FindFirstChild("Ball");

    if Util.canshiftcolor(Players.LocalPlayer, p99) then
        vfxUtil.LeanTowardsColor(v103, p99:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p99:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u104 = {
        TheWorld = u100,
        Highlight = u102,
        ["TheWorld.Highlight"] = u101:Add(vfxUtil.highlight(u100, {
            Name = "Highlight",
            Enabled = true,
            FillTransparency = 1,
            OutlineTransparency = 1,
            DepthMode = Enum.HighlightDepthMode.Occluded,
            FillColor = Color3.new(1, 1, 1),
            OutlineColor = Color3.new(1, 1, 1)
        }))
    };

    for _, child in Base.Lighting:GetChildren() do
        local v105 = u101:Clone(child);
        v105.Parent = Lighting;
        u104[child.Name] = v105;
    end;

    local v106 = u101:Construct(MoonPropertyAnimator);
    v106:LoadSave(Base.Moon, MoonPropertyAnimator.ConvertSave(Base.Moon, u104));
    v106:SetRoot(Root);
    v106:SetOriginalRoot(Base.Origin.Value);
    v106:PlayAll();
    u101:Add(task.delay(0.65, function() -- Line: 988
        -- upvalues: u104 (copy)
        u104.TheWorld = nil;
    end));
    u101:Add(task.delay(3.1, function() -- Line: 992
        -- upvalues: u101 (copy), u100 (copy), toggleStand (ref), Linear (ref), mainreplication (ref), Root (copy)
        u101:Destroy();
        u100.HumanoidRootPart.Weld.Enabled = false;
        toggleStand(u100, 1, TweenInfo.new(0.15, Linear));
        mainreplication.destroyVelocity(Root);
    end));
end;

function u1.dio_skill1_base_zig(p107: any, p108: number) -- Line: 1001
    -- upvalues: vfxUtil (copy), mainreplication (copy), raycast (copy), ReplicatedStorage (copy), Players (copy), RunService (copy)
    local Root = vfxUtil.getRoot(p107);

    if not Root then
        return;
    end;

    mainreplication.destroyVelocity(Root);

    if raycast(Root.Position, Root.CFrame.UpVector * -5) then
        mainreplication.Emit(Root, ReplicatedStorage.Resources.barou.DashParticles, 3, CFrame.new(Vector3.new(-0, -3, -0)));
    end;

    if Players:GetPlayerFromCharacter(p107) ~= Players.LocalPlayer then
        return;
    end;

    local v109 = Root.CFrame.RightVector * (p108 == 1 and -18 or 18) + Root.CFrame.LookVector * 28;
    local v110 = raycast(Root.Position, v109);
    local u111;

    if v110 then
        u111 = v110.Position;
    else
        u111 = (Root.CFrame + v109).Position;
    end;

    local u112 = not shared.TabbedIn or false;
    local u113 = nil;
    u113 = RunService.RenderStepped:Connect(function(p114) -- Line: 1037
        -- upvalues: Root (copy), u112 (ref), u113 (ref), u111 (ref)
        if not Root:IsDescendantOf(game) or u112 then
            u113:Disconnect();

            return;
        end;

        if shared.TabbedIn then
            local math_clamp_ret = math.clamp(p114 * 6, 0, 1);
            Root.CFrame = Root.CFrame:Lerp(CFrame.new(u111, u111 + Root.CFrame.LookVector), math_clamp_ret);

            return;
        end;

        u112 = true;
        u113:Disconnect();
    end);
    task.delay(0.52, function() -- Line: 1054
        -- upvalues: u112 (ref), u113 (ref)
        u112 = true;
        u113:Disconnect();
    end);
end;

function u1.dio_skill1_base_volley(p115) -- Line: 1060
    -- upvalues: getStand (copy), soundUtil (copy), dio (copy), toggleStand (copy), Linear (copy), animationUtil (copy)
    local v116 = getStand(p115);
    local HumanoidRootPart = v116.HumanoidRootPart;
    HumanoidRootPart.Weld.Enabled = true;
    soundUtil:play(dio.Summon, HumanoidRootPart);
    toggleStand(v116, 0, TweenInfo.new(0.12, Linear));
    local u117 = animationUtil:loadAnimation(v116, dio.FirstMove.Base.StandKick);
    u117:Play(0.05);
    u117:AdjustSpeed(1.45);
    task.delay(0.5, function() -- Line: 1068
        -- upvalues: u117 (copy)
        if u117.IsPlaying then
            u117:Stop(0.1);
        end;
    end);
end;

function u1.dio_skill1_base_end(p118) -- Line: 1075
end;

function u1.dioTokiWaUgokidasu(p119: userdata) -- Line: 1093
    -- upvalues: soundUtil (copy), dio (copy), SoundService (copy), TweenService (copy)
    soundUtil:play(dio.Timestop.ResumeSFX, SoundService);
    TweenService:Create(p119, TweenInfo.new(1.5), {
        Contrast = 0,
        Saturation = 0
    }):Play();
end;

return u1;