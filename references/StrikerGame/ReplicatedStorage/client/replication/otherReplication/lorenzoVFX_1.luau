 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local trove = require(ReplicatedStorage.forum.trove);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
require(ReplicatedStorage.util.KatUtil);
local Color3_fromRGB_ret = Color3.fromRGB(157, 0, 255);
Color3.fromRGB(68, 0, 124);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = {};
local u2 = {};
local u3 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };

for _, child in script.compiled:GetChildren() do
    u1[child.Name] = require(child);
end;

function getLorenzoLine(p4, p5)
    -- upvalues: Players (copy)
    local setting = Players.LocalPlayer:FindFirstChild("setting");

    if setting and (setting:FindFirstChild("alternatelines") and not setting.alternatelines.Value) then
        return p4;
    end;

    if p5:FindFirstChild("RickLines") and p5.RickLines:FindFirstChild(p4.Name) then
        return p5.RickLines[p4.Name];
    end;

    if p5:FindFirstChild((`{p4.Name}-Rick`)) then
        return p5[`{p4.Name}-Rick`];
    end;

    return p4;
end;

function u2.donFlash(p6) -- Line: 55
    -- upvalues: Lighting (copy), TweenService (copy), ReplicatedStorage (copy)
    local v7 = p6 or 1;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25 * v7;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v8 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v8.Parent = Lighting;
    v8.TintColor = Color3.fromRGB(85, 0, 255):Lerp(Color3.new(1, 1, 1), 1 - v7);
    v8.Brightness = 0.4 * v7;
    v8.Contrast = 1 * v7;
    v8.Saturation = -0.4 * v7;
    TweenService:Create(v8, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v8, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(2, v8.Destroy, v8);
end;

function u2.AceEaterOnTheBall(p9: any, p10: number, ...) -- Line: 90
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), LocalPlayer (copy), Color3_fromRGB_ret (copy), Util (copy), TekrinnDialogue (copy), soundUtil (copy), SoundService (copy), Lighting (copy), MoonPropertyAnimator (copy), u1 (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local Root = vfxUtil.getRoot(p9);
    local v11 = donlorenzo.AceEaterOnTheBall:FindFirstChild(p10);

    if not v11 then
        return;
    end;

    local u12 = trove.new();
    u12:AttachToInstance(p9);
    local v13 = u12:Construct(vfxUtil.getMoonEffects);
    local v14 = {
        Vignette = v13.Vignette,
        Letterbox = v13.Letterbox.Letterbox
    };
    local v15 = nil;

    if p10 == 1 then
        local Ball = p9:FindFirstChild("Ball");
        local v16 = u12:Construct(v11.FlowAura);
        vfxUtil.setupAura(p9, v16);
        v16.Parent = p9;
        local v17 = u12:Construct(v11.CutsceneVFX);
        v17.Parent = Root;
        local v18 = u12:Construct(v11.Enable);
        v18.Parent = Ball;
        local v19, v20 = mainreplication.cutsceneCamRigWithLetterBox(Root, v11.Animations.Cam, v11.FOV, p9, CFrame.new(0, -3, 0), v11.Cam, "CamPart");

        if v20 then
            u12:Add(v20);
        end;

        v15 = {};
        local v21;

        if v19 then
            v21 = v19:FindFirstChild("CamPart");
        else
            v21 = v19;
        end;

        v15[1], v15[2], v15[3] = v21, Ball, Root;
        vfxUtil.EzLeanHueTowardsColor(LocalPlayer, p9, {
            v16,
            v17,
            v19,
            v18
        });
    elseif p10 == 2 then
        local Head = p9:FindFirstChild("Head");
        local v22 = u12:Construct(v11.CutsceneAura);
        vfxUtil.setupAura(p9, v22);
        v22.Parent = p9;
        local v23 = u12:Construct(v11.TeethVFX);
        v23.Parent = Head;
        local v24 = u12:Construct(v11.CutsceneVFX);
        v24.Parent = Root;
        local v25 = u12:Construct(mainreplication.kuronaCam, Root, v11.Cam, v11.FOV);
        v25.ScreenEffsweld.Part1 = v24.ScreenEffs1;
        u12:Add(task.delay(11.15, function() -- Line: 147
            -- upvalues: mainreplication (ref), Color3_fromRGB_ret (ref)
            mainreplication.bright(1, 1, Color3_fromRGB_ret);
        end));
        vfxUtil.EzLeanHueTowardsColor(LocalPlayer, p9, {
            v24,
            v23,
            v22,
            v25
        });
        v15 = { Head, Root };
    elseif p10 == 3 then
        local ImpactFrames = v11.ImpactFrames;
        local v26 = u12:Construct(v11.Aura);
        vfxUtil.setupAura(p9, v26, true);
        v26.Parent = workspace.Effects;
        Util.Preload(ImpactFrames);
        local v27 = u12:Add(vfxUtil.createVFX(v11.RootVFX, workspace.Effects, Root));
        local v28 = u12:Add(vfxUtil.createVFX(v11.BallVFX, workspace.Effects, p9:FindFirstChild("Ball")));
        local v29 = u12:Construct(mainreplication.kuronaCam, Root, v11.Cam, v11.FOV);
        vfxUtil.EzLeanHueTowardsColor(LocalPlayer, p9, {
            v28,
            v27,
            v29,
            v26
        });
        TekrinnDialogue.Speak(p9, {
            {
                Text = "Nyo-ho!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 37, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            }
        }, 3);
        v15 = {
            v28,
            v27,
            v29,
            v26,
            ImpactFrames,
            p9
        };
    end;

    local u30 = u12:Add(soundUtil:play(getLorenzoLine(v11.SFX, v11), SoundService, {
        Character = p9
    }));

    for _, child in v11.Lighting:GetChildren() do
        local v31 = u12:Construct(child);
        v31.Parent = Lighting;
        v14[child.Name] = v31;
    end;

    local v32 = u12:Construct(MoonPropertyAnimator);
    v32:LoadSave(v11.Moon, MoonPropertyAnimator.ConvertSave(v11.Moon, v14));
    v32:PlayAll();

    for _, v in ipairs(u1[`AEOnTB_{p10}`]) do
        u12:Add(task.delay(v[1] / 60, v[2], table.unpack(v15)));
    end;

    mainreplication.sceneEnabled(true);
    u12:Add(function() -- Line: 214
        -- upvalues: mainreplication (ref), Color3_fromRGB_ret (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1, true, Color3_fromRGB_ret);
    end);
    u12:Add(task.delay(v11:GetAttribute("Length"), function() -- Line: 219
        -- upvalues: u12 (copy), u30 (copy)
        u12:Pop(u30);
        u12:Destroy();
    end));
end;

local function zombieHighlight(p33: userdata) -- Line: 225
    -- upvalues: vfxUtil (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.new(0, 0, 0);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.fromRGB(86, 34, 255);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = p33;

    for _, child in donlorenzo.ZombieStep.Highlight:GetChildren() do
        child:Clone().Parent = Highlight;
    end;

    return Highlight;
end;

function u2.zombieCounter(p34) -- Line: 241
    -- upvalues: vfxUtil (copy), trove (copy), zombieHighlight (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), u2 (copy), u3 (copy), Util (copy), LocalPlayer (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local Counter = donlorenzo.ZombieStep.Counter;
    local v35 = vfxUtil.isLocalPlayer(p34);
    local Root = vfxUtil.getRoot(p34);
    local u36 = trove.new();
    u36:AttachToInstance(p34);
    local v37 = u36:Construct(zombieHighlight, p34);
    local v38 = u36:Construct(Counter.VFX);
    v38.CFrame = Root.CFrame;
    v38.Parent = workspace.Effects;
    vfxUtil.forge.emit(v38, v37);

    if v35 then
        Root = SoundService or Root;
    end;

    soundUtil:play(Counter.SFX, Root, {
        Volume = v35 and 2 or 3
    }, {
        Character = p34
    });

    if v35 then
        mainreplication.fov(false, 40);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        u2.donFlash();
    end;

    local u39 = {};

    for _, v in u3 do
        local v40 = p34:FindFirstChild(v);

        if v40 then
            if v:match("Left") or v:match("Right") then
                local v41 = vfxUtil.createVFX(donlorenzo.trail, v40, v40);
                table.insert(u39, v41);
            end;

            local v42 = vfxUtil.createVFX(donlorenzo.ult4aura, v40, v40);

            for _, v2 in v42:QueryDescendants("ParticleEmitter") do
                v2.LockedToPart = true;
            end;

            table.insert(u39, v42);
        end;
    end;

    u36:Add(function() -- Line: 285
        -- upvalues: u39 (copy), vfxUtil (ref)
        for _, v in u39 do
            vfxUtil.enableEffects(v, false, "ParticleEmitter,Trail");
            vfxUtil.disposal(v);
        end;
    end);

    if Util.canshiftcolor(LocalPlayer, p34) then
        vfxUtil.LeanTowardsColor(v38, p34:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p34:GetAttribute("CustomAlpha") or 0.985);
    end;

    local task_delay = task.delay;
    local EmittersLifetime = vfxUtil.getEmittersLifetime(v38);
    u36:Add(task_delay(math.max(EmittersLifetime, vfxUtil.getEmittersLifetime(v37)), function() -- Line: 296
        -- upvalues: u36 (copy)
        u36:Destroy();
    end));
    mainreplication.destroyVelocity(p34);
end;

function u2.zombieStep(u43, p44) -- Line: 303
    -- upvalues: vfxUtil (copy), trove (copy), zombieHighlight (copy), soundUtil (copy), SoundService (copy), u2 (copy), mainreplication (copy)
    local Step = vfxUtil.getResources().donlorenzo.ZombieStep.Step;
    local v45 = vfxUtil.isLocalPlayer(u43);
    local Root = vfxUtil.getRoot(u43);
    local Ball = u43:FindFirstChild("Ball");
    local u46 = trove.new();
    u46:AttachToInstance(u43);
    local u47 = u46:Construct(zombieHighlight, u43);
    u46:Construct(zombieHighlight, Ball);
    local v48 = u46:Construct(Step.Burst);
    v48.CFrame = Root.CFrame * CFrame.new(0.251, 0.222, 0.679);
    v48.Parent = workspace.Effects;
    vfxUtil.forge.emit(v48, u47);
    local v49;

    if v45 then
        v49 = SoundService or Root;
    else
        v49 = Root;
    end;

    soundUtil:play(Step.SFX, v49, {
        Volume = v45 and 2 or 3
    }, {
        Character = u43
    });

    if v45 or vfxUtil.isLocalPlayer(p44) then
        u2.donFlash();
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 60, 0.65, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
        task.delay(0.7, function() -- Line: 330
            -- upvalues: mainreplication (ref)
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        end);
    end;

    local EmittersLifetime = vfxUtil.getEmittersLifetime(v48);

    local function delayedNew(p50: number, p51: userdata, p52: function) -- Line: 338
        -- upvalues: vfxUtil (ref), u46 (copy), EmittersLifetime (ref)
        local v53 = p50 + vfxUtil.getEmittersLifetime(p51);
        local v54 = u46:Construct(p51);

        if EmittersLifetime < v53 then
            EmittersLifetime = v53;
        end;

        return task.delay(p50, p52, v54);
    end;

    u46:Add(delayedNew(0.167, Step.Stomp, function(p55) -- Line: 347
        -- upvalues: Root (copy), vfxUtil (ref)
        p55.CFrame = Root.CFrame * CFrame.new(-0.859, 0, -2.875);
        p55.Parent = workspace.Effects;
        vfxUtil.forge.emit(p55);
    end));
    u46:Add(delayedNew(0.233, Step.BallVFX, function(u56) -- Line: 353
        -- upvalues: Ball (copy), vfxUtil (ref), u47 (copy), u46 (copy)
        u56.Weld.Part0 = Ball;
        u56.Parent = Ball;
        vfxUtil.forge.emit(u56, u47);
        u46:Add(task.delay(0.9, function() -- Line: 357
            -- upvalues: vfxUtil (ref), u56 (copy)
            vfxUtil.enableEffects(u56, false, "Trail");
        end));
    end));
    u46:Add(delayedNew(0.7, Step.Burst2, function(p57) -- Line: 362
        -- upvalues: Root (copy), vfxUtil (ref), u47 (copy), mainreplication (ref), u43 (copy)
        p57.CFrame = Root.CFrame * CFrame.new(0.251, 0.222, -5.521);
        p57.Parent = workspace.Effects;
        vfxUtil.forge.emit(p57, u47);
        mainreplication.destroyVelocity(u43);
        mainreplication.bodyVelocity(Root, 300, 0.5330000000000001);
        task.delay(0.5330000000000001, function() -- Line: 372
            -- upvalues: mainreplication (ref), u43 (ref)
            mainreplication.destroyVelocity(u43);
        end);
    end));
    u46:Add(delayedNew(0.717, Step.PurpleMesh, function(p58) -- Line: 377
        -- upvalues: Root (copy), vfxUtil (ref)
        p58:PivotTo(Root.CFrame * CFrame.new(0.342, -2.346, -6.562) * CFrame.Angles(-0.10547024669801734, 1.0344566476570392, 0.24007003861182005));
        p58.Parent = workspace.Effects;
        vfxUtil.forge.emit(p58);
    end));
    u46:Add(delayedNew(0.717, Step.Impact, function(p59) -- Line: 383
        -- upvalues: Root (copy), vfxUtil (ref)
        p59.CFrame = Root.CFrame * CFrame.new(1.765, -2.078, -5.315) * CFrame.Angles(-1.5707963267948966, -2.4609142453120048, 0);
        p59.Parent = workspace.Effects;
        vfxUtil.forge.emit(p59);
    end));
    u46:Add(delayedNew(0.883, Step.Step, function(p60) -- Line: 389
        -- upvalues: Root (copy), vfxUtil (ref)
        p60.CFrame = Root.CFrame * CFrame.new(-0.259, 0, -1.575);
        p60.Parent = workspace.Effects;
        vfxUtil.forge.emit(p60);
    end));
    u46:Add(delayedNew(1.133, Step.Step2, function(p61) -- Line: 395
        -- upvalues: Root (copy), vfxUtil (ref), u46 (copy), EmittersLifetime (ref)
        p61.CFrame = Root.CFrame * CFrame.new(1.441, 0, -1.375);
        p61.Parent = workspace.Effects;
        vfxUtil.forge.emit(p61);
        u46:Add(task.delay(EmittersLifetime, function() -- Line: 400
            -- upvalues: u46 (ref)
            u46:Destroy();
        end));
    end));
end;

function u2.lorenzoUndeadCrash(u62, p63) -- Line: 406
    -- upvalues: vfxUtil (copy), trove (copy), u3 (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), u2 (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local Root = vfxUtil.getRoot(u62);
    local Ball = u62:FindFirstChild("Ball");
    local u64 = trove.new();
    u64:AttachToInstance(u62);

    if p63 then
        u64:AttachToInstance(p63);
    end;

    local u65 = {};

    for _, child in ipairs(u62:GetChildren()) do
        if child:IsA("BasePart") and (table.find(u3, child.Name) or child.Name == "Ball") then
            local v66 = child;

            for _, descendant in ipairs(donlorenzo.zombiedribble:GetDescendants()) do
                local v67 = descendant:Clone();
                v67.Parent = v66;
                table.insert(u65, v67);
            end;
        end;
    end;

    local v68 = u64:Construct(donlorenzo.trail);
    v68.Weld.Part0 = u62["Right Arm"];
    v68.Parent = u62;
    local v69 = u64:Construct(donlorenzo.trail);
    v69.Weld.Part0 = u62["Left Arm"];
    v69.Parent = u62;
    local v70 = u64:Construct(donlorenzo.balltrail);
    v70.Weld.Part0 = Ball;
    v70.Parent = u62;
    local u71 = donlorenzo.skill1movingpart:Clone();
    u71.Weld.Part0 = Root;
    u71.Parent = u62;
    u64:Add(function() -- Line: 446
        -- upvalues: u71 (copy)
        for _, descendant in u71:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = false;
            end;
        end;

        task.delay(3, game.Destroy, u71);
    end);
    u64:Add(task.delay(0.12, function() -- Line: 455
        -- upvalues: mainreplication (ref), Root (copy)
        mainreplication.bodyVelocity(Root, 75, 0.6, nil, nil, nil);
    end));
    u64:Add(task.delay(0.4, function() -- Line: 459
        -- upvalues: mainreplication (ref), Root (copy)
        mainreplication.bodyVelocity(Root, 135, 1, nil, nil, nil);
    end));
    u64:Add(task.delay(0.55, function() -- Line: 463
        -- upvalues: donlorenzo (copy), Root (copy), u62 (copy), Util (ref), LocalPlayer (ref), vfxUtil (ref)
        local v72 = donlorenzo.skull2lorenzoheader:Clone();
        v72:PivotTo(Root.CFrame);
        v72.Parent = u62;

        if Util.canshiftcolor(LocalPlayer, u62) then
            vfxUtil.LeanTowardsColor(v72, u62:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u62:GetAttribute("CustomAlpha") or 0.985);
        end;

        for _, descendant in pairs(v72:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.delay(3, v72.Destroy, v72);
    end));
    u64:Add(function() -- Line: 481
        -- upvalues: u65 (copy)
        for _, v in u65 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;
    end);
    u64:Add(task.delay(1.25, function() -- Line: 488
        -- upvalues: u64 (copy)
        u64:Destroy();
    end));
    u64:Add(task.delay(0.5, function() -- Line: 492
        -- upvalues: vfxUtil (ref), u62 (copy), u2 (ref), mainreplication (ref)
        if vfxUtil.isLocalPlayer(u62) then
            u2.donFlash();
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(15, 1.5, 6);
        end;
    end));
end;

function u2.zombieWalk(p73: any, p74: number, u75: number) -- Line: 503
    -- upvalues: vfxUtil (copy), zombieHighlight (copy), u3 (copy), mainreplication (copy), soundUtil (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local ZombieWalk = donlorenzo.ZombieWalk;
    local v76 = vfxUtil.isLocalPlayer(p73);
    local Root = vfxUtil.getRoot(p73);
    local u77 = vfxUtil.character_trove(p73);
    local u78 = u77:Construct(zombieHighlight, p73);
    local u79 = {};

    for _, v in u3 do
        local v80 = p73:FindFirstChild(v);

        if v80 and (v:match("Left") or v:match("Right")) then
            local v81 = vfxUtil.createVFX(donlorenzo.trail, v80, v80);
            table.insert(u79, v81);
        end;
    end;

    local u82 = u77:Construct(ZombieWalk.DirtDrag);
    u82.Parent = Root;
    local u83 = u77:Construct(ZombieWalk.DirtDrag2);
    u83.Parent = Root;
    u77:Add(task.delay(p74, function() -- Line: 533
        -- upvalues: ZombieWalk (copy), Root (copy), vfxUtil (ref), u78 (copy), mainreplication (ref), u75 (copy)
        local v84 = ZombieWalk.Grass:Clone();
        v84.Parent = Root;
        local v85 = ZombieWalk.Startup:Clone();
        v85.Parent = Root;
        vfxUtil.forge.emit(v84, v85, u78);
        vfxUtil.disposal({ v84, v85 });
        mainreplication.bodyVelocity(Root, 86.5, 0.8, nil, nil, nil, TweenInfo.new(u75, Enum.EasingStyle.Quint, Enum.EasingDirection.In));
    end));

    for _, v in { p74 + u75 * 0.2, p74 + u75 * 0.6 } do
        u77:Add(task.delay(v, function() -- Line: 558
            -- upvalues: vfxUtil (ref), u83 (copy)
            vfxUtil.forge.emit(u83);
        end));
    end;

    for _, v in { p74 + u75 * 0.35, p74 + u75 * 0.8 } do
        u77:Add(task.delay(v, function() -- Line: 567
            -- upvalues: vfxUtil (ref), u82 (copy)
            vfxUtil.forge.emit(u82);
        end));
    end;

    u77:Add(function() -- Line: 572
        -- upvalues: u79 (copy), vfxUtil (ref)
        for _, v in u79 do
            vfxUtil.enableEffects(v, false, "Trail");
            vfxUtil.disposal(v);
        end;
    end);
    u77:Add(task.delay(p74 + u75, function() -- Line: 579
        -- upvalues: u77 (copy)
        u77:Destroy();
    end));
    soundUtil:play(ZombieWalk.WalkSFX, Root, {
        Volume = 3
    }, {
        Character = p73
    });

    if v76 then
        mainreplication.fov(true, 50, p74, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        task.delay(p74, function() -- Line: 587
            -- upvalues: mainreplication (ref)
            mainreplication.fov(true, 90, 0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut);
        end);
        task.delay(p74 + u75 * 0.2, function() -- Line: 590
            -- upvalues: mainreplication (ref), u75 (copy)
            mainreplication.fov(true, 70, u75 * 0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        end);
    end;
end;

function u2.zombieWalkDribble(p86: any, u87: number) -- Line: 596
    -- upvalues: vfxUtil (copy), zombieHighlight (copy), u3 (copy), mainreplication (copy), soundUtil (copy), u2 (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local ZombieWalk = donlorenzo.ZombieWalk;
    local v88 = vfxUtil.isLocalPlayer(p86);
    local Root = vfxUtil.getRoot(p86);
    local Ball = p86:FindFirstChild("Ball");
    local v89 = not (shared.allvfxcheck and shared.allvfxcheck());
    local u90 = vfxUtil.character_trove(p86);
    local u91 = zombieHighlight(p86);
    local u92 = {};

    if v89 then
        for _, v in u3 do
            local v93 = p86:FindFirstChild(v);

            if v93 then
                if v:match("Left") or v:match("Right") then
                    local v94 = vfxUtil.createVFX(donlorenzo.trail, v93, v93);
                    table.insert(u92, v94);
                end;

                local v95 = vfxUtil.createVFX(donlorenzo.ult4aura, v93, v93);

                for _, v2 in v95:QueryDescendants("ParticleEmitter") do
                    v2.LockedToPart = true;
                end;

                table.insert(u92, v95);
            end;
        end;
    end;

    local u96 = ZombieWalk.Grass:Clone();
    u96.Parent = Root;
    local u97 = ZombieWalk.Startup:Clone();
    u97.Parent = Root;
    local u98 = vfxUtil.createVFX(donlorenzo.ZombieStep.Step.BallVFX, Ball, Ball);
    vfxUtil.forge.emit(u96, u97, u91, u98);
    mainreplication.bodyVelocity(Root, 90, 0.567 / u87, nil, nil, nil, TweenInfo.new(0.6 / u87, Enum.EasingStyle.Quart, Enum.EasingDirection.In));
    u90:Add(function() -- Line: 645
        -- upvalues: u92 (copy), vfxUtil (ref), u96 (copy), u97 (copy), u91 (copy), u98 (copy)
        for _, v in u92 do
            vfxUtil.enableEffects(v, false, "ParticleEmitter,Trail");
            vfxUtil.disposal(v);
        end;

        vfxUtil.disposal({
            u96,
            u97,
            u91,
            u98
        });
    end);
    u90:Add(task.delay(0.567 / u87, function() -- Line: 653
        -- upvalues: vfxUtil (ref), u96 (copy), u97 (copy), u91 (copy), u98 (copy), mainreplication (ref), Root (copy), u87 (copy), u90 (copy)
        vfxUtil.forge.emit(u96, u97, u91, u98);
        mainreplication.bodyVelocity(Root, 80, 0.5 / u87, nil, nil, nil, TweenInfo.new(0.5 / u87, Enum.EasingStyle.Quint, Enum.EasingDirection.In));
        u90:Destroy();
    end));
    soundUtil:play(ZombieWalk.DribbleSFX, Root, {
        Volume = 3
    }, {
        Character = p86
    });

    if v88 then
        u2.donFlash();
        mainreplication.fov(true, 60, 0.55 / u87, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
        task.delay(0.567 / u87, function() -- Line: 665
            -- upvalues: mainreplication (ref), u87 (copy)
            mainreplication.fov(false, 90);
            mainreplication.fov(true, 70, 0.5 / u87, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        end);
    end;
end;

function u2.zombieDribble(u99, p100) -- Line: 672
    -- upvalues: vfxUtil (copy), u3 (copy), Util (copy), LocalPlayer (copy), u2 (copy), mainreplication (copy), animationUtil (copy), RunService (copy), soundUtil (copy), TweenService (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local u101 = vfxUtil.isLocalPlayer(u99);
    local Root = vfxUtil.getRoot(u99);
    local Ball = u99:FindFirstChild("Ball");
    local u102 = u99:FindFirstChildWhichIsA("Humanoid");
    local v103 = not (shared.allvfxcheck and shared.allvfxcheck());
    local u104 = vfxUtil.character_trove(u99);

    if p100 then
        u104:AttachToInstance(p100);
    end;

    local u105 = {};
    local u106;

    if v103 then
        local v107 = u104:Clone(donlorenzo.trail);
        v107.Weld.Part0 = u99["Right Arm"];
        v107.Parent = u99;
        local v108 = u104:Clone(donlorenzo.trail);
        v108.Weld.Part0 = u99["Left Arm"];
        v108.Parent = u99;
        local v109 = u104:Clone(donlorenzo.balltrail);
        v109.Weld.Part0 = Ball;
        v109.Parent = u99;
        local u110 = donlorenzo.skill1movingpart:Clone();
        u110.Weld.Part0 = Root;
        u110.Parent = u99;
        u104:Add(function() -- Line: 717
            -- upvalues: u110 (ref)
            for _, descendant in u110:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(3, game.Destroy, u110);
        end);
        u106 = donlorenzo.ZombieDribble.DribbleVFX:Clone();
        u106.Parent = Root;

        for _, child in ipairs(u99:GetChildren()) do
            if child:IsA("BasePart") and (table.find(u3, child.Name) or child.Name == "Ball") then
                local v111 = child;

                for _, descendant in ipairs(donlorenzo.zombiedribble:GetDescendants()) do
                    local v112 = descendant:Clone();
                    v112.Parent = v111;
                    table.insert(u105, v112);
                end;
            end;
        end;

        for _, child in ipairs(u99:GetChildren()) do
            if child:IsA("BasePart") and (table.find(u3, child.Name) or child.Name == "Ball") then
                local v113 = child;

                for _, descendant in ipairs(donlorenzo.zombiedribble:GetDescendants()) do
                    local v114 = descendant:Clone();
                    v114.Parent = v113;
                    table.insert(u105, v114);
                end;
            end;
        end;

        if Util.canshiftcolor(LocalPlayer, u99) then
            vfxUtil.LeanTowardsColor(u105, u99:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u99:GetAttribute("CustomAlpha") or 0.985);
            vfxUtil.LeanTowardsColor({
                v107,
                v108,
                v109,
                u110
            }, u99:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u99:GetAttribute("CustomAlpha") or 0.985);
        end;
    else
        u106 = nil;
    end;

    u104:Add(task.delay(0.15, function() -- Line: 756
        -- upvalues: u101 (copy), u2 (ref), mainreplication (ref)
        if u101 then
            u2.donFlash();
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(10, 1.5, 6);
        end;
    end));
    u104:Add(function() -- Line: 765
        -- upvalues: u105 (copy), vfxUtil (ref), u106 (ref)
        for _, v in u105 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;

        vfxUtil.disposal(u106);
    end);
    u104:Add(task.delay(2.03, function() -- Line: 773
        -- upvalues: u104 (copy)
        u104:Destroy();
    end));
    local u115 = nil;
    local u116 = nil;
    local u117 = nil;

    local function makeDash(p118, p119, p120) -- Line: 780
        -- upvalues: u115 (ref), u116 (ref), mainreplication (ref), Root (copy), u117 (ref)
        local v121, v122 = mainreplication.bodyVelocity(Root, p118, p119, nil, nil, true);
        u115 = v121;
        u116 = v122;

        if p120 then
            u117 = p118;
        end;
    end;

    local v123 = { { 0.57, 65, 0.6 }, { 0.67, 75, 1 }, { 1.29, 95, 0.8 }, { 1.59, 85, 0.6 } };

    for i, v in ipairs(v123) do
        u104:Add(task.delay(v[1], makeDash, v[2], v[3], i == #v123));
    end;

    local v124, v125 = mainreplication.bodyVelocity(Root, 70, 0.8, nil, nil, true);
    u115 = v124;
    u116 = v125;
    local u126 = 0;
    local u127 = 0;
    local u128 = 2;
    local u129 = true;
    local u130 = nil;
    local u131 = 0;
    local ZombieDribble = donlorenzo.ZombieDribble;
    local u132 = {};

    if u115 then
        u132.Left = animationUtil:loadAnimation(u99, ZombieDribble.Left.Animation);
        u132.Right = animationUtil:loadAnimation(u99, ZombieDribble.Right.Animation);
    end;

    u104:Add(RunService.RenderStepped:Connect(function(p133) -- Line: 819
        -- upvalues: Root (copy), u102 (copy), u126 (ref), u128 (ref), u131 (ref), u115 (ref), u2 (ref), u130 (ref), soundUtil (ref), ZombieDribble (copy), u99 (copy), u132 (copy), u106 (ref), vfxUtil (ref), u127 (ref), u129 (ref), TweenService (ref), u116 (ref), u117 (ref)
        local os_clock_ret = os.clock();
        local CFrame2 = Root.CFrame;
        local RightVector = CFrame2.RightVector;
        local v134 = u102.MoveDirection:Dot(RightVector);
        local math_sign_ret = math.sign(v134);

        if os_clock_ret - u126 > 0.05 and (u128 > 0 and (math.abs(v134) > 0.05 and math_sign_ret ~= u131)) then
            if u115 then
                u2.donFlash(0.5);
            end;

            u130 = math_sign_ret < 0 and "Left" or "Right";
            soundUtil:play(ZombieDribble.Weave, Root, {
                Character = u99
            });

            for i, v in u132 do
                v:Stop();

                if i == u130 then
                    v:Play();
                end;
            end;

            if u106 then
                vfxUtil.emitAll(u106[u130].Start);
            end;

            u127 = math_sign_ret;
            u126 = os_clock_ret;
            u128 = u128 - 1;
            u129 = false;
        end;

        u131 = math_sign_ret;
        local v135 = os_clock_ret - u126;
        local v136;

        if v135 < 0.25 then
            local Value = TweenService:GetValue(v135 / 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
            v136 = RightVector * u127 * 100 * (1 - Value);
        else
            v136 = Vector3.new(0, 0, 0);
        end;

        if v135 > 0.45 and (u130 and (u129 and (u106 and (u106[u130] and u106[u130].End)))) then
            vfxUtil.emitAll(u106[u130].End);
        end;

        if v135 > 0.5 then
            for _, v in u132 do
                if v.IsPlaying then
                    v:Stop();
                end;
            end;
        end;

        if not (u115 and u116) then
            return;
        end;

        u115.Velocity = CFrame2.LookVector * u116.Value + v136 * (u117 and u116.Value / u117 or 1);
    end));
end;

function u2.yoMichaelKaiser(u137, u138) -- Line: 882
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Lighting (copy), u3 (copy), ReplicatedStorage (copy), LocalPlayer (copy), MoonPropertyAnimator (copy), u1 (copy), u2 (copy), TekrinnDialogue (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local YoMichaelKaiser = donlorenzo.YoMichaelKaiser;
    local Root = vfxUtil.getRoot(u137);
    local u139 = trove.new();
    u139:AttachToInstance(u137);
    local v140 = u139:Construct(vfxUtil.getMoonEffects);
    local v141 = u139:Clone(YoMichaelKaiser.VictimVFX);
    vfxUtil.setupAura(u138, v141, true);
    v141.Parent = workspace.Effects;
    local v142 = u139:Add(vfxUtil.createVFX(YoMichaelKaiser.TorsoVFX, workspace.Effects, u137:FindFirstChild("Torso")));
    local v143 = u139:Add(vfxUtil.createVFX(YoMichaelKaiser.HeadVFX, workspace.Effects, u137:FindFirstChild("Head")));
    local v144 = u139:Clone(YoMichaelKaiser.VFX);
    v144:PivotTo(Root.CFrame);
    v144.Parent = u137;
    local v145 = u139:Clone(YoMichaelKaiser.BallVFX);
    v145.Weld.Part0 = u137:FindFirstChild("Ball");
    v145.Parent = workspace.Effects;
    local _, v146 = mainreplication.cutsceneCamRigWithLetterBox(Root, YoMichaelKaiser.Animations.Cam, YoMichaelKaiser.FOV, u137, CFrame.new(0, -3, 0), YoMichaelKaiser.Cam, "CamPart");

    if v146 then
        u139:Add(v146);
    end;

    soundUtil:play(YoMichaelKaiser.SFX, SoundService, {
        Character = u137
    });
    local v147 = {
        Vignette = v140.Vignette
    };

    for _, child in YoMichaelKaiser.Lighting:GetChildren() do
        local v148 = u139:Clone(child);
        v148.Parent = Lighting;
        v147[v148.Name] = v148;
    end;

    for _, v in u3 do
        local v149 = u137:FindFirstChild(v);

        if v149 then
            for _, v2 in u139:Add(vfxUtil.createVFX(donlorenzo.ult4aura, v149, v149)):QueryDescendants("ParticleEmitter") do
                v2.LockedToPart = true;
            end;
        end;
    end;

    local u150 = u139:Clone(ReplicatedStorage.Resources.darkscreen);
    u150.Parent = LocalPlayer:FindFirstChild("PlayerGui");
    u139:Add(task.delay(3.15, function() -- Line: 940
        -- upvalues: u139 (copy), u150 (copy)
        u139:Remove(u150);
    end));
    local v151 = u139:Construct(MoonPropertyAnimator);
    v151:LoadSave(YoMichaelKaiser.Moon, MoonPropertyAnimator.ConvertSave(YoMichaelKaiser.Moon, v147));
    v151:PlayAll();

    for _, v in ipairs(u1.YoMichaelKaiser) do
        u139:Add(task.delay(v[1] / 60, v[2], v141, v145, v144, v142, v144.RootVFX, v143));
    end;

    mainreplication.sceneEnabled(true);
    u139:Add(function() -- Line: 954
        -- upvalues: u2 (ref), mainreplication (ref)
        u2.donFlash();
        mainreplication.sceneEnabled(false);
    end);
    u139:Add(task.delay(1.25, function() -- Line: 959
        -- upvalues: TekrinnDialogue (ref), u137 (copy)
        TekrinnDialogue.Speak(u137, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u137:GetAttribute("RinNoPlay") and "Salutations, Michael Kaiser..." or "Yo Michael...",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(119, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5
                }
            }
        }, 2.25);
    end));
    u139:Add(task.delay(9, function() -- Line: 985
        -- upvalues: TekrinnDialogue (ref), u137 (copy)
        TekrinnDialogue.Speak(u137, {
            {
                Bold = true,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u137:GetAttribute("RinNoPlay") and "Truly scrumptious!" or "Delicious.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(119, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2.5
                }
            }
        }, 3.167);
    end));
    u139:Add(task.delay(11.167, function() -- Line: 1011
        -- upvalues: TekrinnDialogue (ref), u138 (copy), u137 (copy)
        TekrinnDialogue.Speak(u138, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u137:GetAttribute("RinNoPlay") and "That scoundrel Don Lorenzo!" or "Tch.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 1.5
                }
            }
        }, 1.016);
    end));
    u139:Add(task.delay(12.183, function() -- Line: 1036
        -- upvalues: u139 (copy)
        u139:Destroy();
    end));
end;

function u2.lorenzoPenaltyAwk(u152) -- Line: 1041
    -- upvalues: vfxUtil (copy), trove (copy), u3 (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), TekrinnDialogue (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local PenaltyFlow = donlorenzo.PenaltyFlow;
    local Root = vfxUtil.getRoot(u152);
    local u153 = trove.new();
    u153:AttachToInstance(u152);
    local u154 = u153:Construct(Instance, "Highlight");
    u154.FillColor = Color3.new(0, 0, 0);
    u154.FillTransparency = 1;
    u154.OutlineColor = Color3.fromRGB(74, 42, 255);
    u154.OutlineTransparency = 1;
    u154.Parent = u152;

    for _, child in PenaltyFlow.Highlight:GetChildren() do
        child:Clone().Parent = u154;
    end;

    local u155 = u153:Clone(PenaltyFlow.keep);
    u155.Parent = u152:FindFirstChild("Head");
    local u156 = u153:Clone(PenaltyFlow.Kick);
    u156.Parent = Root;
    local u157 = u153:Construct(vfxUtil.createVFX, PenaltyFlow.BallVFX, workspace.Effects, u152:FindFirstChild("Ball"));

    for _, v in u3 do
        local v158 = u152:FindFirstChild(v);

        if v158 then
            u153:Construct(vfxUtil.createVFX, donlorenzo.ult4aura, v158, v158);
        end;
    end;

    local v159 = {
        Vignette = u153:Construct(vfxUtil.getMoonEffects).Vignette
    };

    for _, child in PenaltyFlow.Lighting:GetChildren() do
        local v160 = u153:Clone(child);
        v160.Parent = Lighting;
        v159[v160.Name] = v160;
    end;

    local v161 = u153:Construct(MoonPropertyAnimator);
    v161:LoadSave(PenaltyFlow.Moon, MoonPropertyAnimator.ConvertSave(PenaltyFlow.Moon, v159));
    v161:PlayAll();
    local u162 = getLorenzoLine(PenaltyFlow.SFX, PenaltyFlow);
    soundUtil:play(u162, SoundService, {
        Character = u152
    });
    u153:Add(mainreplication.kuronaCam(Root, PenaltyFlow.Cam, PenaltyFlow.FOV));
    u153:Add(task.delay(0.8, function() -- Line: 1095
        -- upvalues: TekrinnDialogue (ref), u152 (copy), u162 (copy), vfxUtil (ref), u154 (copy)
        TekrinnDialogue.Speak(u152, {
            {
                Bold = true,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u162:GetAttribute("Line") or "Ya-hoo~",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(119, 0, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 1);
        vfxUtil.forge.emit(u154);
    end));
    u153:Add(task.delay(1.233, function() -- Line: 1120
        -- upvalues: vfxUtil (ref), u155 (copy)
        vfxUtil.forge.emit(u155);
    end));
    u153:Add(task.delay(2.067, function() -- Line: 1124
        -- upvalues: vfxUtil (ref), u156 (copy), u157 (copy)
        vfxUtil.forge.emit(u156, u157);
    end));
    mainreplication.sceneEnabled(true);
    u153:Add(function() -- Line: 1130
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(1);
        mainreplication.sceneEnabled(false);
    end);
    u153:Add(task.delay(3.017, function() -- Line: 1135
        -- upvalues: u153 (copy)
        u153:Destroy();
    end));
end;

function u2.lorenzoPenaltyAwkRNP(p163) -- Line: 1140
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy)
    local Root = vfxUtil.getRoot(p163);
    local RNP = vfxUtil.getResources().donlorenzo.PenaltyFlow.RNP;
    local v164 = vfxUtil.character_trove(p163);
    local v165 = v164:Construct(vfxUtil.getMoonEffects);
    local _ = {
        Vignette = v165.Vignette,
        ["Screen Cover"] = v165["Screen Cover"]
    };
    soundUtil:play(RNP.SFX, "default");
    local _, v166 = mainreplication.cutsceneCamRigWithLetterBox(Root, RNP.Camera, RNP.FOV, nil, CFrame.new(1.5, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0), RNP.Cam, "CamPart");
    v164:Add(v166);
    v164:Add(task.delay(5.17, v164.Destroy, v164));
end;

function u2.lorenzo4Dribble(p167) -- Line: 1169
    -- upvalues: vfxUtil (copy), trove (copy), u3 (copy), soundUtil (copy), mainreplication (copy), u2 (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local Dribble = donlorenzo.TerrifyingIntercept.Dribble;
    local Root = vfxUtil.getRoot(p167);
    local u168 = trove.new();
    u168:AttachToInstance(p167);
    local u169 = {};

    for _, v in u3 do
        local v170 = p167:FindFirstChild(v);

        if v170 then
            local v171 = vfxUtil.createVFX(donlorenzo.zombiedribble, v170, v170);
            v171.Transparency = 1;
            table.insert(u169, v171);

            if v:match("Left") or v:match("Right") then
                local v172 = vfxUtil.createVFX(donlorenzo.trail, v170, v170);
                table.insert(u169, v172);
            end;
        end;
    end;

    soundUtil:play(Dribble.SFX, Root, {
        Character = p167
    });

    if mainreplication.bodyVelocity(Root, 50, 2.1, nil, nil, false, TweenInfo.new(3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)) then
        u2.donFlash(0.5);
    end;

    mainreplication.fov(false, 50);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    local u173 = Dribble.HorrificDribble:Clone();
    u173.Parent = Root;

    for _, v in ipairs({ { 0.25, "One" }, { 0.5, "Two" }, { 0.95, "Three" }, { 1.3, "Four" }, { 1.4, "Five" }, { 1.8, "Six" } }) do
        u168:Add(task.delay(v[1], function() -- Line: 1208
            -- upvalues: vfxUtil (ref), u173 (copy), v (copy)
            vfxUtil.emitAll(u173[v[2]]);
        end));
    end;

    u168:Add(function() -- Line: 1213
        -- upvalues: u169 (copy), vfxUtil (ref), u173 (copy)
        for _, v in u169 do
            for _, v2 in v:QueryDescendants("ParticleEmitter,Trail") do
                v2.Enabled = false;
            end;

            vfxUtil.disposal(v);
        end;

        vfxUtil.disposal(u173);
    end);
    u168:Add(task.delay(Dribble:GetAttribute("Duration"), function() -- Line: 1223
        -- upvalues: u168 (copy)
        u168:Destroy();
    end));
end;

function u2.lorenzo4Pass(p174) -- Line: 1228
    -- upvalues: vfxUtil (copy), trove (copy), u3 (copy), mainreplication (copy), soundUtil (copy), RunService (copy), u2 (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local Pass = donlorenzo.TerrifyingIntercept.Pass;
    local Root = vfxUtil.getRoot(p174);
    local u175 = trove.new();
    u175:AttachToInstance(p174);
    local u176 = {};

    for _, v in u3 do
        local v177 = p174:FindFirstChild(v);

        if v177 then
            local v178 = vfxUtil.createVFX(donlorenzo.zombiedribble, v177, v177);
            v178.Transparency = 1;
            table.insert(u176, v178);
        end;
    end;

    mainreplication.fov(false, 50);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    soundUtil:play(Pass.SFX, Root, {
        Character = p174
    });
    local u179 = Pass.HorrificPass:Clone();
    u179.Parent = Root;
    vfxUtil.emitAll(u179.Start);

    for i = 0, 11 do
        u175:Add(task.delay(i * 0.05 + 0.1, function() -- Line: 1257
            -- upvalues: vfxUtil (ref), u179 (copy)
            vfxUtil.emitAll(u179.Loop);
        end));
        local _ = i;
    end;

    local u180, u181 = mainreplication.bodyVelocity(Root, 60, 1, nil, nil, true, TweenInfo.new(1, Enum.EasingStyle.Quart));

    if u180 then
        u180.MaxForce = Vector3.new(300000, 300000, 300000);
        local u182 = nil;
        u182 = u175:Connect(RunService.RenderStepped, function() -- Line: 1266
            -- upvalues: u180 (copy), u175 (copy), u182 (ref), Root (copy), u181 (copy)
            if u180 and u180:IsDescendantOf(game) then
                u180.Velocity = Root.CFrame.LookVector * 20 + Root.CFrame.UpVector * u181.Value;

                return;
            end;

            u175:Remove(u182);
        end);
        u175:Add(task.delay(0.8, function() -- Line: 1273
            -- upvalues: u175 (copy), u182 (ref)
            u175:Remove(u182);
        end));
        u2.donFlash(0.5);
        mainreplication.springcamerashake(15, 60);
    end;

    u175:Add(task.delay(0.8, function() -- Line: 1280
        -- upvalues: vfxUtil (ref), u179 (copy), u180 (copy), u2 (ref)
        vfxUtil.emitAll(u179.Pass);

        if u180 then
            u2.donFlash(0.5);
        end;
    end));
    u175:Add(function() -- Line: 1286
        -- upvalues: u176 (copy), vfxUtil (ref), u179 (copy)
        for _, v in u176 do
            for _, v2 in v:QueryDescendants("ParticleEmitter") do
                v2.Enabled = false;
            end;

            vfxUtil.disposal(v);
        end;

        vfxUtil.disposal(u179);
    end);
    u175:Add(task.delay(Pass:GetAttribute("Duration"), function() -- Line: 1296
        -- upvalues: u175 (copy)
        u175:Destroy();
    end));
end;

function u2.lorenzoHorrificIntercept(p183) -- Line: 1301
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), RunService (copy), workspace_CurrentCamera (copy), TekrinnDialogue (copy)
    local donlorenzo = vfxUtil.getResources().donlorenzo;
    local Root = vfxUtil.getRoot(p183);
    local Ball = p183:FindFirstChild("Ball");
    p183:FindFirstChild("Torso");
    local u184 = trove.new();
    u184:AttachToInstance(p183);

    if vfxUtil.isLocalPlayer(p183) then
        local v185 = u184:Add(Instance.new("BodyPosition"));
        v185.MaxForce = Vector3.new(100000, 100000, 100000);
        v185.P = 10000;
        v185.Position = Root.Position;
        v185.Parent = Root;
    end;

    local u186 = u184:Add(soundUtil:play(getLorenzoLine(donlorenzo.ult4, donlorenzo), SoundService, {
        Character = p183
    }));
    local u187 = u184:Clone(donlorenzo.ult4vfx);
    u187.rootlocation.Weld.Part0 = Root;
    u187:PivotTo(Root.CFrame);
    u187.Parent = workspace.Effects;

    if p183:GetAttribute("ReoCopy") then
        vfxUtil.LeanTowardsColor(u187, p183:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p183:GetAttribute("CustomAlpha") or 0.985);
    end;

    mainreplication.sceneEnabled(true);
    local v188 = u184:Clone(ReplicatedStorage.Resources.DepthOfField);
    v188.Parent = Lighting;
    v188.FarIntensity = 0;
    TweenService:Create(v188, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local _, v189 = mainreplication.cutsceneBlender(Root, donlorenzo.Skill4Cam, donlorenzo.FOV);

    if v189 then
        u184:Add(v189);
    end;

    local v190 = u184:Clone(donlorenzo.ult4ball);
    v190.Weld.Part0 = Ball;
    v190.Parent = workspace.Effects;
    u184:Add(task.delay(0.025, function() -- Line: 1347
        -- upvalues: u187 (copy)
        for _, child in ipairs(u187.skill4ballpartflashsteps:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
            end;
        end;
    end));
    local u191 = u184:Clone(donlorenzo.lorenzocam);
    u191.Parent = u187;
    local u192 = nil;
    u192 = u184:Connect(RunService.PreRender, function() -- Line: 1359
        -- upvalues: u191 (copy), u184 (copy), u192 (ref), workspace_CurrentCamera (ref)
        if u191:IsDescendantOf(game) then
            u191.CFrame = workspace_CurrentCamera.CFrame;

            return;
        end;

        u184:Remove(u192);
    end);
    u184:Add(task.delay(0.2, function() -- Line: 1368
        -- upvalues: u187 (copy)
        for _, descendant in ipairs(u187.skill4emit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    local u193 = {};

    for _, descendant in ipairs(p183:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v194 = descendant;

            for _, child in ipairs(donlorenzo.ult4aura:GetChildren()) do
                local v195 = child:Clone();
                v195.Parent = v194;
                table.insert(u193, v195);
            end;
        end;
    end;

    u184:Add(function() -- Line: 1388
        -- upvalues: mainreplication (ref), u193 (copy)
        mainreplication.sceneEnabled(false);

        for _, v in u193 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;
    end);
    u184:Add(task.delay(2, function() -- Line: 1396
        -- upvalues: u184 (copy), u186 (copy)
        u184:Pop(u186);
        u184:Destroy();
    end));
    u184:Add(TekrinnDialogue.Speak(p183, {
        {
            Text = "It\'s mine now!",
            Bold = true,
            TypeSpeed = 0.02,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(119, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            Shake = {
                Enabled = true,
                Intensity = 5,
                Lifetime = 2
            }
        }
    }, 2));
end;

function u2.lorenzoOTAwk(u196) -- Line: 1423
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), u1 (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy)
    local OvertimeFlow = vfxUtil.getResources().donlorenzo.OvertimeFlow;
    local Root = vfxUtil.getRoot(u196);
    local u197 = trove.new();
    u197:AttachToInstance(u196);
    u197:Add(vfxUtil.getScreenDimmer());
    local v198 = u197:Construct(vfxUtil.getMoonEffects);
    local v199 = u197:Clone(OvertimeFlow.Aura);
    vfxUtil.setupAura(u196, v199);
    v199.Parent = u196;
    local v200 = u197:Clone(OvertimeFlow.CutsceneVFX);
    v200.Parent = Root;
    local v201 = u197:Clone(OvertimeFlow.TeethVFX);
    v201.Parent = u196:FindFirstChild("Head");
    local v202 = u197:Add(mainreplication.kuronaCam(Root, OvertimeFlow.Cam, OvertimeFlow.FOV));

    for _, v in ipairs(u1.OTFlow) do
        u197:Add(task.delay(v[1] / 60, v[2], v200, v201, v202, v199));
    end;

    local v203 = {
        Vignette = v198.Vignette,
        ["Screen Cover"] = v198["Screen Cover"]
    };

    for _, child in OvertimeFlow.Lighting:GetChildren() do
        local v204 = u197:Clone(child);
        v204.Parent = Lighting;
        v203[child.Name] = v204;
    end;

    local v205 = u197:Construct(MoonPropertyAnimator);
    v205:LoadSave(OvertimeFlow.Moon, MoonPropertyAnimator.ConvertSave(OvertimeFlow.Moon, v203));
    v205:PlayAll();
    local u206 = u197:Add(soundUtil:play(getLorenzoLine(OvertimeFlow.SFX, OvertimeFlow), SoundService, {
        Character = u196
    }));
    mainreplication.sceneEnabled(true);
    u197:Add(function() -- Line: 1472
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(1);
        mainreplication.sceneEnabled(false);
    end);
    u197:Add(task.delay(12.083, function() -- Line: 1477
        -- upvalues: u197 (copy), u206 (copy)
        u197:Pop(u206);
        u197:Destroy();
    end));
    u197:Add(task.delay(2.73, function() -- Line: 1482
        -- upvalues: u197 (copy), TekrinnDialogue (ref), u196 (copy)
        u197:Add(TekrinnDialogue.Speak(u196, {
            {
                Text = "47 Million...",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(78, 46, 147)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 3));
    end));
    u197:Add(task.delay(4.634, function() -- Line: 1506
        -- upvalues: u197 (copy), TekrinnDialogue (ref), u196 (copy)
        u197:Add(TekrinnDialogue.Speak(u196, {
            {
                Text = "Let\'s devour them, ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(101, 60, 190)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            },
            {
                Text = "Ubers",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(101, 60, 190)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            },
            {
                Text = "..",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(101, 60, 190)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            }
        }, 5));
    end));
    u197:Add(task.delay(8.255, function() -- Line: 1561
        -- upvalues: u197 (copy), TekrinnDialogue (ref), u196 (copy)
        u197:Add(TekrinnDialogue.Speak(u196, {
            {
                Text = "Yo...",
                Bold = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(101, 60, 190)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 3));
    end));
    u197:Add(task.delay(9.877, function() -- Line: 1584
        -- upvalues: u197 (copy), TekrinnDialogue (ref), u196 (copy)
        u197:Add(TekrinnDialogue.Speak(u196, {
            {
                Text = "Counter-attack, OK?",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(101, 60, 190)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 2.1229999999999993));
    end));
end;

function u2.lorenzoMarker(p207: any, p208: any, p209: userdata) -- Line: 1608
    -- upvalues: vfxUtil (copy), ReplicatedStorage (copy), trove (copy), soundUtil (copy), SoundService (copy), u2 (copy), mainreplication (copy)
    local Mark = vfxUtil.getResources().donlorenzo.Mark;
    local disabled = ReplicatedStorage.workspace.disabled;
    local Root = vfxUtil.getRoot(p207);
    local Root2 = vfxUtil.getRoot(p208);
    local v210 = trove.new();
    v210:AttachToInstance(p207);
    v210:AttachToInstance(p208);
    v210:AttachToInstance(p209);
    local u211 = v210:Construct(Instance, "Highlight");
    u211.FillColor = Color3.new(0, 0, 0);
    u211.FillTransparency = 1;
    u211.OutlineColor = Color3.fromRGB(94, 20, 255);
    u211.OutlineTransparency = 1;
    u211.Parent = p207;

    for _, child in Mark.User.Highlight:GetChildren() do
        child:Clone().Parent = u211;
    end;

    local v212 = v210:Clone(Mark.User["Activate FX"]);
    v212.Parent = Root;
    local v213 = v210:Clone(Mark.User.FloorHit);
    v213.Parent = Root;
    local u214 = v210:Construct(Instance, "Highlight");
    u214.FillColor = Color3.new(0, 0, 0);
    u214.FillTransparency = 1;
    u214.OutlineColor = Color3.fromRGB(94, 20, 255);
    u214.OutlineTransparency = 1;
    u214.Parent = p208;

    for _, child in Mark.Victim.Highlight:GetChildren() do
        child:Clone().Parent = u214;
    end;

    local u215 = Mark.Victim.FX:Clone();
    u215.Parent = Root2;

    if p207:GetAttribute("RinNoPlay") then
        for _, child in u215.Emit.Attachment:GetChildren() do
            if child:IsA("ParticleEmitter") and child.Name:match("Tattoo") then
                child.Texture = "rbxassetid://85732057422046";
            end;
        end;
    end;

    v210:AttachToInstance(disabled);
    v210:Add(disabled.Changed:Connect(function(p216) -- Line: 1659
        -- upvalues: u215 (copy), u211 (copy), u214 (copy)
        if p216 then
            for _, descendant in u215:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Clear();
                    descendant.Enabled = false;
                end;
            end;
        else
            for _, descendant in u215:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant:GetAttribute("ToEnable") then
                    descendant:Emit(1);
                    descendant.Enabled = true;
                end;
            end;
        end;

        u211.Enabled = p216;
        u214.Enabled = p216;
    end));
    v210:Add(function() -- Line: 1679
        -- upvalues: u215 (copy), vfxUtil (ref)
        for _, descendant in u215:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Clear();

                if descendant:GetAttribute("EmitWhenDisabled") then
                    vfxUtil.forge.emit(descendant);
                end;

                descendant.Enabled = false;
            end;
        end;

        vfxUtil.disposal(u215);
    end);
    local v217 = v210:Clone(Mark.Victim.FloorHit);
    v217.Parent = Root2;
    vfxUtil.forge.emit(v212, v213, u211, u214, v217);
    vfxUtil.disposal({
        v212,
        v213,
        u211,
        u214,
        v217
    });

    for _, descendant in u215:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            if descendant:GetAttribute("ToEnable") then
                task.delay(descendant:GetAttribute("EmitDelay") or 0, function() -- Line: 1701
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                    descendant.Enabled = true;
                end);
            elseif not descendant:GetAttribute("EmitWhenDisabled") then
                vfxUtil.forge.emit(descendant);
            end;
        end;
    end;

    if vfxUtil.isLocalPlayer(p207, p208) then
        soundUtil:play(Mark.SFX, SoundService, {
            Character = p207
        });
        u2.donFlash(0.5);
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut);
    end;
end;

function u2.AceEaterOffTheBall(u218, p219) -- Line: 1719
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), u1 (copy)
    local AceEaterOffTheBall = vfxUtil.getResources().donlorenzo.AceEaterOffTheBall;
    local Root = vfxUtil.getRoot(u218);
    local u220 = trove.new();
    u220:AttachToInstance(u218);
    local v221 = u220:Add(vfxUtil.getMoonEffects());
    local v222 = u220:Add(vfxUtil.createVFX(AceEaterOffTheBall.RootVFX, workspace.Effects, Root));
    local v223 = u220:Clone(AceEaterOffTheBall.Aura);
    vfxUtil.setupAura(u218, v223);
    v223.Parent = workspace.Effects;
    local v224, v225 = mainreplication.cutsceneCamRigWithLetterBox(Root, AceEaterOffTheBall.Animations.Cam, AceEaterOffTheBall.FOV, u218, CFrame.new(0, -3, 0), AceEaterOffTheBall.CameraS, "CamPart");
    local v226;

    if v224 then
        v226 = v224:FindFirstChild("CamPart");
    else
        v226 = nil;
    end;

    if v225 then
        u220:Add(v225);
    end;

    local v227 = {
        Vignette = v221.Vignette
    };

    for _, child in AceEaterOffTheBall.Lighting:GetChildren() do
        local v228 = u220:Clone(child);
        v228.Parent = Lighting;
        v227[child.Name] = v228;
    end;

    local v229 = u220:Construct(MoonPropertyAnimator);
    v229:LoadSave(AceEaterOffTheBall.Moon, MoonPropertyAnimator.ConvertSave(AceEaterOffTheBall.Moon, v227));
    v229:PlayAll();
    soundUtil:play(getLorenzoLine(AceEaterOffTheBall.SFX, AceEaterOffTheBall), SoundService, {
        Character = u218
    });
    u220:Add(task.delay(1.5, function() -- Line: 1759
        -- upvalues: u220 (copy), TekrinnDialogue (ref), u218 (copy)
        u220:Add(TekrinnDialogue.Speak(u218, {
            {
                Text = "Chow time!",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(101, 60, 190)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 0.9500000000000002));
    end));
    mainreplication.sceneEnabled(true);
    u220:Add(function() -- Line: 1784
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u220:Add(task.delay(3.95, function() -- Line: 1789
        -- upvalues: u220 (copy)
        u220:Destroy();
    end));

    for _, v in u1.AEOffTB do
        u220:Add(task.delay(v[1] / 60, v[2], v222, v226, v223));
    end;
end;

return u2;