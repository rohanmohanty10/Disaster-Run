 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.util.UwUEffects);
local trove = require(ReplicatedStorage.forum.trove);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
require(ReplicatedStorage.client.replication.BezierCurve);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.MoonPropertyAnimator);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.VfxHandler);
require(ReplicatedStorage.wiki.styles);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local _ = workspace.CurrentCamera;
local u1 = {};
local u2 = {};

local function clear_twister_vfx(p3: userdata) -- Line: 35
    -- upvalues: u2 (copy)
    local v4 = u2[p3];

    if v4 then
        for _, v in v4 do
            pcall(game.Destroy, v);
        end;

        u2[p3] = nil;
    end;
end;

function u1.windmill_shot(u5: any, p6: number) -- Line: 45
    -- upvalues: vfxUtil (copy), KatUtil (copy), mainreplication (copy), trove (copy), Players (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local v7 = p6 or 1;
    local Root = vfxUtil.getRoot(u5);
    local u8 = vfxUtil.getResources().kiyora["Windmill Shot"];
    local _track = KatUtil.get_track(u5, u8.Animation);

    if not _track then
        return;
    end;

    local u9 = vfxUtil.createVFX(u8.VFX.HumanoidRootPart, "default", Root);
    _track.add(function() -- Line: 55
        -- upvalues: vfxUtil (ref), u9 (copy)
        vfxUtil.disposal(u9);
    end);
    local u10 = KatUtil.create_vfx_instance(vfxUtil.getResources().kiyora["Twister Pass"].Offball.VFX.Start["Left Leg"], u5["Left Leg"].CFrame, CFrame.identity);
    local u11 = KatUtil.create_vfx_instance(vfxUtil.getResources().kiyora["Twister Pass"].Offball.VFX.Start["Right Leg"], u5["Right Leg"].CFrame, CFrame.identity);
    vfxUtil.disposal(u10, 2.5);
    vfxUtil.disposal(u11, 2.5);
    KatUtil.weld(u5["Left Leg"], u10, CFrame.identity, CFrame.identity);
    KatUtil.weld(u5["Right Leg"], u11, CFrame.identity, CFrame.identity);
    _track.add(KatUtil.frame_delay(18 / v7, function() -- Line: 71
        -- upvalues: mainreplication (ref), u5 (copy), trove (ref), u8 (copy), Root (copy), KatUtil (ref), u10 (copy), u11 (copy), vfxUtil (ref)
        mainreplication.highlight(u5, Color3.new(0.615686, 0.835294, 1), 0.5);
        local v12 = trove.new();
        v12:AttachToInstance(u5);
        local v13 = v12:Construct(u8.VFX.Meshes["Combo Meshes1"]);
        v13:PivotTo(Root.CFrame * CFrame.Angles(0, 0, 3.141592653589793));
        v13.Parent = workspace.Effects;
        KatUtil.forge_emit(v13);
        KatUtil.Enable(u10, "Trail", true);
        KatUtil.Enable(u11, "Trail", true);
        vfxUtil.disposal(u10, 1);
        vfxUtil.disposal(u11, 1);
    end));
    _track.add(KatUtil.frame_delay(62 / v7, function() -- Line: 92
        -- upvalues: u8 (copy), Root (copy), KatUtil (ref), u9 (copy), vfxUtil (ref), Players (ref), u5 (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
        local v14 = u8.VFX.Meshes["Combo Meshes"]:Clone();
        v14.Parent = workspace.Effects;
        v14:PivotTo(Root.CFrame * CFrame.new(
            0.331043243,
            1.36783266,
            -0.461181641,
            0.999997556,
            -1.96695009e-6,
            9.83476639e-7,
            -1.96694714e-6,
            -1.00000095,
            -4.47046773e-8,
            2.98023224e-7,
            4.47067627e-8,
            -0.999999166
        ));
        KatUtil.forge_emit(v14);
        KatUtil.forge_emit(u9["Kick/Jump"].Grnd, u9["Kick/Jump"].Dust, u9["Kick/Jump"].Dust);
        vfxUtil.disposal(v14, 10);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u5) then
            mainreplication.fov(true, 60, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
            mainreplication.highlight(u5, Color3.new(0.615686, 0.835294, 1), 0.25);
            local v15 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v15.Parent = Lighting;
            v15.TintColor = Color3.fromRGB(155, 228, 255);
            v15.Brightness = 0.3;
            v15.Contrast = 0.3;
            v15.Saturation = -0.3;
            TweenService:Create(v15, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v15, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v15.Destroy, v15);
        end;
    end));
    _track.add(KatUtil.frame_delay(94 / v7, function() -- Line: 121
        -- upvalues: u8 (copy), Root (copy), KatUtil (ref), u9 (copy), vfxUtil (ref), Players (ref), u5 (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
        local v16 = u8.VFX.Meshes["Kick Meshes"]:Clone();
        v16.Parent = workspace.Effects;
        v16:PivotTo(Root.CFrame * CFrame.new(
            0.503902435,
            0.888158798,
            -5.09448242,
            0.999997556,
            -9.83476639e-7,
            -1.96695009e-6,
            -1.96694714e-6,
            4.47046773e-8,
            -1.00000095,
            2.98023224e-7,
            0.999999166,
            4.47067627e-8
        ));
        KatUtil.forge_emit(v16);
        KatUtil.forge_emit(u9["Kick/Jump"].Crescents, u9["Kick/Jump"].Speeds, u9["Kick/Jump"].Shockwaves, u9["Kick/Jump"].Impact);
        vfxUtil.disposal(v16, 10);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u5) then
            mainreplication.springcamerashake(30, 40);
            mainreplication.fov(false, 105);
            mainreplication.fov(true, 70, 0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end;

        local v17 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v17.Parent = Lighting;
        v17.TintColor = Color3.fromRGB(139, 220, 255);
        v17.Brightness = 0.5;
        v17.Contrast = 1;
        v17.Saturation = -0.4;
        TweenService:Create(v17, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v17, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v17.Destroy, v17);
    end));
end;

function u1.kiyora_danceparty(u18: any, p19: userdata, p20: number) -- Line: 152
    -- upvalues: vfxUtil (copy), KatUtil (copy), vfxUtil (copy), RunService (copy), Players (copy), mainreplication (copy), Lighting (copy), ReplicatedStorage (copy), TweenService (copy), trove (copy), animationUtil (copy), soundUtil (copy)
    local u21 = p20 or 1;
    local Root = vfxUtil.getRoot(u18);
    local u22 = vfxUtil.getResources().kiyora["Dance Party"];
    local _track = KatUtil.get_track(u18, u22.Animations.Initial);

    if not _track then
        return;
    end;

    local u23 = u22.Aura:Clone();
    vfxUtil.setupAura(u18, u23, true);
    u23.Parent = workspace.Effects;
    local u24 = u22.Meshes:Clone();
    u24.Parent = workspace.Effects;
    local u25 = nil;
    _track.add(function() -- Line: 167
        -- upvalues: u21 (copy), u25 (ref), u24 (copy), u23 (copy)
        task.delay(1.5 / u21, function() -- Line: 168
            -- upvalues: u25 (ref), u24 (ref), u23 (ref)
            if u25 then
                u25:Disconnect();
                u25 = nil;
            end;

            pcall(game.Destroy, u24);
            pcall(game.Destroy, u23);
        end);
    end);
    u25 = RunService.RenderStepped:Connect(function() -- Line: 178
        -- upvalues: Root (copy), u24 (copy)
        if Root and u24 then
            u24:PivotTo(Root.CFrame);
        end;
    end);
    local u26 = false;
    local v27 = u18:GetAttributeChangedSignal("DancePartyTackled"):Connect(function() -- Line: 187
        -- upvalues: u18 (copy), u26 (ref)
        if u18:GetAttribute("DancePartyTackled") then
            u26 = true;

            if current_bodyvelocity then
                pcall(function() -- Line: 191
                    current_bodyvelocity.Parent = nil;
                end);
                current_bodyvelocity = nil;
            end;
        end;
    end);
    _track.add(v27);
    local DancePartyDribble = require(script.Compiled.DancePartyDribble);

    for _, v in ipairs(DancePartyDribble) do
        _track.add(task.delay(v[1] / 60 / u21, function() -- Line: 202
            -- upvalues: u26 (ref), v (copy), u23 (copy), u24 (copy)
            if not u26 then
                v[2](u23, u24);
            end;
        end));
    end;

    local u28 = Players:GetPlayerFromCharacter(u18) == Players.LocalPlayer;

    if u28 then
        mainreplication.fov(true, 65, 0.4 / u21, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    end;

    tick();
    local u29 = nil;
    _track.sequence({
        [math.round(24 / u21)] = function() -- Line: 219
            -- upvalues: u26 (ref), u29 (ref), mainreplication (ref), Root (copy), u21 (copy), u28 (copy), Lighting (ref), ReplicatedStorage (ref), TweenService (ref)
            if not u26 then
                u29 = mainreplication.bodyVelocity(Root, 85, 0.4 / u21, false);

                if u28 then
                    mainreplication.fov(false, 75);
                    mainreplication.fov(true, 70, 1 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                    mainreplication.cameraShake(5, 1 / u21, 6);
                    local BlurEffect = Instance.new("BlurEffect");
                    BlurEffect.Size = 5;
                    BlurEffect.Parent = Lighting;
                    local v30 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v30.Parent = Lighting;
                    v30.TintColor = Color3.fromRGB(144, 222, 255);
                    v30.Brightness = 0.3;
                    v30.Contrast = 1;
                    v30.Saturation = -0.4;
                    TweenService:Create(BlurEffect, TweenInfo.new(0.533 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Size = 0
                    }):Play();
                    TweenService:Create(v30, TweenInfo.new(0.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v30, TweenInfo.new(1 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Brightness = 0,
                        Contrast = 0,
                        TintColor = Color3.new(1, 1, 1)
                    }):Play();
                    task.delay(0.533 / u21, BlurEffect.Destroy, BlurEffect);
                    task.delay(1.5 / u21, v30.Destroy, v30);
                end;
            end;
        end,

        [math.round(54 / u21)] = function() -- Line: 250
            -- upvalues: u26 (ref), u29 (ref), mainreplication (ref), Root (copy), u21 (copy), u28 (copy), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
            if not u26 then
                u29 = mainreplication.bodyVelocity(Root, 65, 0.65 / u21, false);

                if u28 then
                    mainreplication.fov(false, 71);
                    mainreplication.fov(true, 70, 3.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                    local v31 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v31.Parent = Lighting;
                    v31.TintColor = Color3.fromRGB(174, 236, 255);
                    v31.Brightness = 0.1;
                    v31.Contrast = 0.3;
                    v31.Saturation = -0.3;
                    TweenService:Create(v31, TweenInfo.new(0.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v31, TweenInfo.new(0.75 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Brightness = 0,
                        Contrast = 0,
                        TintColor = Color3.new(1, 1, 1)
                    }):Play();
                    task.delay(1.5 / u21, v31.Destroy, v31);
                end;
            end;
        end,

        [math.round(76 / u21)] = function() -- Line: 281
            -- upvalues: u26 (ref), u29 (ref), mainreplication (ref), Root (copy), u21 (copy), u28 (copy), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
            if not u26 then
                u29 = mainreplication.bodyVelocity(Root, 75, 0.7 / u21, false);

                if u28 then
                    mainreplication.fov(false, 71);
                    mainreplication.fov(true, 70, 3.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                    local v32 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v32.Parent = Lighting;
                    v32.TintColor = Color3.fromRGB(174, 236, 255);
                    v32.Brightness = 0.1;
                    v32.Contrast = 0.3;
                    v32.Saturation = -0.3;
                    TweenService:Create(v32, TweenInfo.new(0.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v32, TweenInfo.new(0.75 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Brightness = 0,
                        Contrast = 0,
                        TintColor = Color3.new(1, 1, 1)
                    }):Play();
                    task.delay(1.5 / u21, v32.Destroy, v32);
                end;
            end;
        end,

        [math.round(116 / u21)] = function() -- Line: 312
            -- upvalues: u26 (ref), u29 (ref), mainreplication (ref), Root (copy), u21 (copy), u28 (copy), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
            if not u26 then
                u29 = mainreplication.bodyVelocity(Root, 60, 0.5 / u21, false);

                if u28 then
                    mainreplication.fov(false, 71);
                    mainreplication.fov(true, 70, 3.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                    local v33 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v33.Parent = Lighting;
                    v33.TintColor = Color3.fromRGB(174, 236, 255);
                    v33.Brightness = 0.1;
                    v33.Contrast = 0.3;
                    v33.Saturation = -0.3;
                    TweenService:Create(v33, TweenInfo.new(0.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v33, TweenInfo.new(0.75 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Brightness = 0,
                        Contrast = 0,
                        TintColor = Color3.new(1, 1, 1)
                    }):Play();
                    task.delay(1.5 / u21, v33.Destroy, v33);
                end;
            end;
        end,

        [math.round(132 / u21)] = function() -- Line: 343
            -- upvalues: u26 (ref), u29 (ref), mainreplication (ref), Root (copy), u21 (copy), u28 (copy), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
            if not u26 then
                u29 = mainreplication.bodyVelocity(Root, 65, 0.4 / u21, false);

                if u28 then
                    mainreplication.fov(false, 71);
                    mainreplication.fov(true, 70, 3.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                    local v34 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v34.Parent = Lighting;
                    v34.TintColor = Color3.fromRGB(174, 236, 255);
                    v34.Brightness = 0.1;
                    v34.Contrast = 0.3;
                    v34.Saturation = -0.3;
                    TweenService:Create(v34, TweenInfo.new(0.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v34, TweenInfo.new(0.75 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Brightness = 0,
                        Contrast = 0,
                        TintColor = Color3.new(1, 1, 1)
                    }):Play();
                    task.delay(1.5 / u21, v34.Destroy, v34);
                end;
            end;
        end,

        [math.round(170 / u21)] = function() -- Line: 374
            -- upvalues: u26 (ref), u29 (ref), mainreplication (ref), Root (copy), u21 (copy), u28 (copy), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
            if not u26 then
                u29 = mainreplication.bodyVelocity(Root, 60, 0.4 / u21, false);

                if u28 then
                    mainreplication.fov(false, 71);
                    mainreplication.fov(true, 70, 3.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                    local v35 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v35.Parent = Lighting;
                    v35.TintColor = Color3.fromRGB(174, 236, 255);
                    v35.Brightness = 0.1;
                    v35.Contrast = 0.3;
                    v35.Saturation = -0.3;
                    TweenService:Create(v35, TweenInfo.new(0.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v35, TweenInfo.new(0.75 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Brightness = 0,
                        Contrast = 0,
                        TintColor = Color3.new(1, 1, 1)
                    }):Play();
                    task.delay(1.5 / u21, v35.Destroy, v35);
                end;
            end;
        end,

        [math.round(192 / u21)] = function() -- Line: 405
            -- upvalues: u26 (ref), u29 (ref), mainreplication (ref), Root (copy), u21 (copy), u28 (copy), Lighting (ref), ReplicatedStorage (ref), TweenService (ref)
            if not u26 then
                u29 = mainreplication.bodyVelocity(Root, 85, 0.55 / u21, false);

                if u28 then
                    mainreplication.fov(false, 80);
                    mainreplication.fov(true, 70, 1 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                    mainreplication.cameraShake(3, 1 / u21, 6);
                    local BlurEffect = Instance.new("BlurEffect");
                    BlurEffect.Size = 5;
                    BlurEffect.Parent = Lighting;
                    local v36 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v36.Parent = Lighting;
                    v36.TintColor = Color3.fromRGB(144, 222, 255);
                    v36.Brightness = 0.4;
                    v36.Contrast = 1;
                    v36.Saturation = -0.4;
                    TweenService:Create(BlurEffect, TweenInfo.new(0.533 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Size = 0
                    }):Play();
                    TweenService:Create(v36, TweenInfo.new(0.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v36, TweenInfo.new(1 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Brightness = 0,
                        Contrast = 0,
                        TintColor = Color3.new(1, 1, 1)
                    }):Play();
                    task.delay(0.533 / u21, BlurEffect.Destroy, BlurEffect);
                    task.delay(1.5 / u21, v36.Destroy, v36);
                end;
            end;
        end
    });

    if p19 then
        local u37 = trove.new();
        u37:AttachToInstance(p19);
        _track.add(function() -- Line: 442
            -- upvalues: u21 (copy), u23 (copy), u37 (copy)
            task.delay(0.8 / u21, function() -- Line: 443
                -- upvalues: u23 (ref)
                if u23 then
                    for _, descendant in u23:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                            descendant.Enabled = false;
                        end;
                    end;
                end;
            end);
            u37:Destroy();
        end);
        local u38 = {};
        local u39 = {
            forward = Vector3.new(0, 0, -1),
            backward = Vector3.new(0, 0, 1),
            left = Vector3.new(-1, 0, 0),
            right = Vector3.new(1, 0, 0)
        };
        local u40 = 0;

        for _, child in script.Compiled.dancepartydirections:GetChildren() do
            u38[child.Name] = require(child);
        end;

        for i, _ in u39 do
            u37:Add(task.spawn(function() -- Line: 473
                -- upvalues: i (copy), KatUtil (ref), u18 (copy), u22 (copy), u38 (copy), u23 (copy), u24 (copy), u37 (copy)
                local u41 = i;
                KatUtil.get_track(u18, u22.Animations[u41 == "left" and "Left" or (u41 == "right" and "Right" or (u41 == "backward" and "Back" or (u41 == "forward" and "Front" or false)))]);
                local v42;

                repeat
                    task.wait();
                    v42 = KatUtil.get_track(u18, u22.Animations[u41 == "left" and "Left" or (u41 == "right" and "Right" or (u41 == "backward" and "Back" or (u41 == "forward" and "Front" or false)))]);
                until v42;

                if v42 then
                    u37:Add((v42.track.KeyframeReached:Connect(function(p43) -- Line: 479
                        -- upvalues: u41 (copy), u38 (ref), u23 (ref), u24 (ref)
                        if u41 and u38[u41] then
                            coroutine.wrap(u38[u41][tonumber(p43)][2])(u23, u24);
                        end;
                    end)));
                end;
            end));
        end;

        local u44 = Vector3.new(0, 0, 0);
        u37:Add(RunService.PreRender:Connect(function() -- Line: 492
            -- upvalues: u18 (copy), u26 (ref), u37 (copy), u40 (ref), u28 (copy), u39 (copy), u44 (ref), u29 (ref), animationUtil (ref), u22 (copy), u21 (copy), mainreplication (ref), Lighting (ref), ReplicatedStorage (ref), TweenService (ref), soundUtil (ref), Root (copy), RunService (ref)
            if u18:GetAttribute("frozen") then
                u37:Destroy();

                return;
            end;

            if u26 then
                local Unit = Vector3.new(workspace.CurrentCamera.CFrame.LookVector.X, 0, workspace.CurrentCamera.CFrame.LookVector.Z).Unit;

                if u18 and u18:FindFirstChild("HumanoidRootPart") then
                    u18:FindFirstChild("HumanoidRootPart").CFrame = CFrame.lookAt(u18:FindFirstChild("HumanoidRootPart").Position, u18:FindFirstChild("HumanoidRootPart").Position + Unit * 10);
                end;
            end;

            if u40 == 4 then
                return;
            end;

            if u28 and (not u26 and (u18 and (u18:FindFirstChild("HumanoidRootPart") and u18:FindFirstChildWhichIsA("Humanoid")))) then
                local _ = u18:FindFirstChild("HumanoidRootPart").CFrame;
                local shared_moveVector = shared.moveVector;
                local v45 = 10;
                local u46 = nil;

                for i, v in u39 do
                    if (v - shared_moveVector).Magnitude < v45 then
                        v45 = (v - shared_moveVector).Magnitude;
                        u46 = i;
                    end;
                end;

                local v47 = u46 and (u39[u46] or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0);

                if shared_moveVector ~= Vector3.new(0, 0, 0) and u44 ~= v47 then
                    u44 = v47;
                    u26 = true;

                    if u29 then
                        pcall(function() -- Line: 532
                            -- upvalues: u29 (ref)
                            u29.Parent = nil;
                        end);
                    end;

                    local u48 = animationUtil:Load(u18, u22.Animations[u46 == "left" and "Left" or (u46 == "right" and "Right" or (u46 == "backward" and "Back" or (u46 == "forward" and "Front" or false)))]);
                    u48:Play(0.1);
                    u48:AdjustSpeed(u21);

                    if u28 then
                        mainreplication.fov(false, 75);
                        mainreplication.fov(true, 70, 1 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                        mainreplication.cameraShake(5, 1 / u21, 6);
                        local BlurEffect = Instance.new("BlurEffect");
                        BlurEffect.Size = 5;
                        BlurEffect.Parent = Lighting;
                        local v49 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                        v49.Parent = Lighting;
                        v49.TintColor = Color3.fromRGB(144, 222, 255);
                        v49.Brightness = 0.3;
                        v49.Contrast = 1;
                        v49.Saturation = -0.4;
                        TweenService:Create(BlurEffect, TweenInfo.new(0.533 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            Size = 0
                        }):Play();
                        TweenService:Create(v49, TweenInfo.new(0.5 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            Saturation = 0
                        }):Play();
                        TweenService:Create(v49, TweenInfo.new(1 / u21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            Brightness = 0,
                            Contrast = 0,
                            TintColor = Color3.new(1, 1, 1)
                        }):Play();
                        task.delay(0.533 / u21, BlurEffect.Destroy, BlurEffect);
                        task.delay(1.5 / u21, v49.Destroy, v49);
                    end;

                    soundUtil:play(u22.Sounds[u48.Name], Root);
                    u40 = u40 + 1;
                    local u50, u51 = mainreplication.bodyVelocity(Root, u40 >= 110 and true or 60, 1 / u21, false, nil, true);
                    u37:Add(u50);
                    u37:Add(u51);
                    local u53 = RunService.PostSimulation:Connect(function() -- Line: 577
                        -- upvalues: u46 (ref), Root (ref), u50 (copy), u51 (copy)
                        local v52 = u46 == "left" and -Root.CFrame.RightVector or (u46 == "right" and Root.CFrame.RightVector or u46 == "backward" and -Root.CFrame.LookVector);

                        if not v52 then
                            if u46 == "forward" then
                                v52 = Root.CFrame.LookVector;
                            else
                                v52 = false;
                            end;
                        end;

                        u50.Velocity = v52 * u51.Value;
                    end);
                    u37:Add(task.spawn(function() -- Line: 584
                        -- upvalues: u48 (copy), u21 (ref), u26 (ref), u50 (copy), u51 (copy), u29 (ref), Root (ref), u53 (ref), u40 (ref), u37 (ref)
                        repeat
                            task.wait();
                        until u48.Length ~= 0;

                        repeat
                            task.wait();
                        until u48.TimePosition >= u48.Length * 0.75 / u21 or not u48.IsPlaying;

                        u26 = false;
                        pcall(game.Destroy, u50);
                        pcall(game.Destroy, u51);

                        if u29 then
                            pcall(function() -- Line: 592
                                -- upvalues: u29 (ref), Root (ref)
                                u29.Parent = Root;
                            end);
                        end;

                        u53:Disconnect();
                        u53 = nil;

                        if u40 >= 4 then
                            u37:Destroy();
                        end;
                    end));
                    u37:Add(u53);
                end;
            end;
        end));
    end;
end;

function u1.kiyora_danceparty_back(p54) -- Line: 610
    -- upvalues: vfxUtil (copy), KatUtil (copy), mainreplication (copy), RunService (copy)
    local Root = vfxUtil.getRoot(p54);
    local v55 = vfxUtil.getResources().kiyora["Dance Party"];
    local _track = KatUtil.get_track(p54, v55.Animations.Back);

    if not _track then
        return;
    end;

    local u56, u57 = mainreplication.bodyVelocity(Root, 110, 0.4, false, nil, true);
    _track.add(u56);
    _track.add(u57);
    _track.add(RunService.PostSimulation:Connect(function() -- Line: 622
        -- upvalues: u56 (copy), Root (copy), u57 (copy)
        u56.Velocity = -Root.CFrame.LookVector * u57.Value;
    end));
end;

function u1.kiyora_danceparty_left(p58) -- Line: 627
    -- upvalues: vfxUtil (copy), KatUtil (copy), mainreplication (copy), RunService (copy)
    local Root = vfxUtil.getRoot(p58);
    local v59 = vfxUtil.getResources().kiyora["Dance Party"];
    local _track = KatUtil.get_track(p58, v59.Animations.Left);

    if not _track then
        return;
    end;

    local u60, u61 = mainreplication.bodyVelocity(Root, 110, 0.4, false, nil, true);
    _track.add(u60);
    _track.add(u61);
    _track.add(RunService.PostSimulation:Connect(function() -- Line: 639
        -- upvalues: u60 (copy), Root (copy), u61 (copy)
        u60.Velocity = -Root.CFrame.RightVector * u61.Value;
    end));
end;

function u1.kiyora_danceparty_right(p62) -- Line: 644
    -- upvalues: vfxUtil (copy), KatUtil (copy), mainreplication (copy), RunService (copy)
    local Root = vfxUtil.getRoot(p62);
    local v63 = vfxUtil.getResources().kiyora["Dance Party"];
    local _track = KatUtil.get_track(p62, v63.Animations.Right);

    if not _track then
        return;
    end;

    local u64, u65 = mainreplication.bodyVelocity(Root, 110, 0.4, false, nil, true);
    _track.add(u64);
    _track.add(u65);
    _track.add(RunService.PostSimulation:Connect(function() -- Line: 656
        -- upvalues: u64 (copy), Root (copy), u65 (copy)
        u64.Velocity = Root.CFrame.RightVector * u65.Value;
    end));
end;

function u1.kiyora_danceparty_forward(p66) -- Line: 661
    -- upvalues: vfxUtil (copy), KatUtil (copy), mainreplication (copy), RunService (copy)
    local Root = vfxUtil.getRoot(p66);
    local v67 = vfxUtil.getResources().kiyora["Dance Party"];
    local _track = KatUtil.get_track(p66, v67.Animations.Front);

    if not _track then
        return;
    end;

    local u68, u69 = mainreplication.bodyVelocity(Root, 110, 0.4, false, nil, true);
    _track.add(u68);
    _track.add(u69);
    _track.add(RunService.PostSimulation:Connect(function() -- Line: 673
        -- upvalues: u68 (copy), Root (copy), u69 (copy)
        u68.Velocity = Root.CFrame.LookVector * u69.Value;
    end));
end;

function u1.kiyora_danceparty_pass(u70) -- Line: 678
    -- upvalues: vfxUtil (copy), KatUtil (copy), Players (copy), mainreplication (copy), Lighting (copy), ReplicatedStorage (copy), TweenService (copy), vfxUtil (copy), RunService (copy)
    local Root = vfxUtil.getRoot(u70);
    local v71 = vfxUtil.getResources().kiyora["Dance Party"];
    local _track = KatUtil.get_track(u70, v71.Animations.Pass);

    if not _track then
        return;
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u70) then
        mainreplication.fov(false, 90);
        mainreplication.fov(true, 70, 0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(5, 0.8, 4);
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 8;
        BlurEffect.Parent = Lighting;
        local v72 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v72.Parent = Lighting;
        v72.TintColor = Color3.fromRGB(138, 218, 255);
        v72.Brightness = 0.25;
        v72.Contrast = 0.5;
        v72.Saturation = -0.35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        TweenService:Create(v72, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v72, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(0.5, BlurEffect.Destroy, BlurEffect);
        task.delay(1, v72.Destroy, v72);
    end;

    mainreplication.highlight(u70, Color3.new(0.505882, 0.843137, 1), 0.5);
    local u73 = v71.Aura:Clone();
    u73.Parent = workspace.Effects;
    vfxUtil.setupAura(u70, u73, true);
    local u74 = v71.Meshes:Clone();
    u74.Parent = workspace.Effects;
    local u75 = nil;
    _track.add(function() -- Line: 720
        -- upvalues: u75 (ref), u74 (copy), u73 (copy)
        task.delay(1.25, function() -- Line: 721
            -- upvalues: u75 (ref), u74 (ref), u73 (ref)
            if u75 then
                u75:Disconnect();
                u75 = nil;
            end;

            pcall(game.Destroy, u74);
            pcall(game.Destroy, u73);
        end);
    end);
    u75 = RunService.RenderStepped:Connect(function() -- Line: 731
        -- upvalues: Root (copy), u74 (copy)
        if Root and u74 then
            u74:PivotTo(Root.CFrame);
        end;
    end);
    local v76 = require(script.Compiled["Dance party Pass"]);

    for _, v in ipairs(v76) do
        task.delay(v[1] / 60, function() -- Line: 739
            -- upvalues: v (copy), u73 (copy), u74 (copy)
            v[2](u73, u74);
        end);
    end;

    task.delay(0.933, function() -- Line: 744
        -- upvalues: Players (ref), u70 (copy), mainreplication (ref)
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u70) then
            mainreplication.fov(true, 67, 0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
        end;
    end);
    task.delay(1.5333, function() -- Line: 750
        -- upvalues: Players (ref), u70 (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u70) then
            mainreplication.fov(false, 110);
            mainreplication.fov(true, 70, 0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(15, 1.5, 6);
            local v77 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v77.Parent = Lighting;
            v77.TintColor = Color3.fromRGB(138, 218, 255);
            v77.Brightness = 0.3;
            v77.Contrast = 0.6;
            v77.Saturation = -0.35;
            TweenService:Create(v77, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v77, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(1, v77.Destroy, v77);
        end;
    end);
end;

function u1.PassIndicator(p78: userdata) -- Line: 771
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), ReplicatedStorage (copy)
    local Root = vfxUtil.getRoot(p78);
    local v79 = vfxUtil.getResources().kiyora["Twister Pass"];
    local v80 = trove.new();
    v80:AttachToInstance(p78);

    if Root then
        local v81 = v80:Add(v79.Offball.VFX.Indicator.Attachment:Clone());
        v81.Parent = Root;

        for _, descendant in v81:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;

        soundUtil:play(ReplicatedStorage.Resources.uishow, Root);
    end;
end;

function u1.kiyora_twisterpass_offball(u82: any, p83: string) -- Line: 791
    -- upvalues: vfxUtil (copy), KatUtil (copy), u2 (copy), mainreplication (copy), Players (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local Root = vfxUtil.getRoot(u82);
    local u84 = vfxUtil.getResources().kiyora["Twister Pass"];

    if p83 == "start" then
        local _track = KatUtil.get_track(u82, u84.Offball.Start);

        if not _track then
            return;
        end;

        local u85 = KatUtil.create_vfx_instance(u84.Offball.VFX.Start["Left Leg"], u82["Left Leg"].CFrame, CFrame.identity);
        local u86 = KatUtil.create_vfx_instance(u84.Offball.VFX.Start["Right Leg"], u82["Right Leg"].CFrame, CFrame.identity);
        local u87 = { u85, u86 };
        local v88 = u2[u82];

        if v88 then
            for _, v in v88 do
                pcall(game.Destroy, v);
            end;

            u2[u82] = nil;
        end;

        u2[u82] = u87;
        KatUtil.weld(u82["Left Leg"], u85, CFrame.identity, CFrame.identity);
        KatUtil.weld(u82["Right Leg"], u86, CFrame.identity, CFrame.identity);
        mainreplication.bodyVelocity(Root, 66.3, 0.367, true);
        _track.add(function() -- Line: 812
            -- upvalues: u2 (ref), u82 (copy), u87 (copy), KatUtil (ref), vfxUtil (ref)
            if u2[u82] == u87 then
                u2[u82] = nil;
            end;

            for _, v in u87 do
                if v and v.Parent then
                    KatUtil.Enable(v, "Trail,ParticleEmitter", false);
                    vfxUtil.disposal(v, 2);
                end;
            end;
        end);
        KatUtil.delay(5, function() -- Line: 824
            -- upvalues: u85 (copy), u86 (copy), KatUtil (ref), vfxUtil (ref)
            for _, v in { u85, u86 } do
                if v and v.Parent then
                    KatUtil.Enable(v, "Trail,ParticleEmitter", false);
                    vfxUtil.disposal(v, 0.5);
                end;
            end;
        end);
        _track.sequence({
            [22] = function() -- Line: 834
                -- upvalues: mainreplication (ref), Root (copy), KatUtil (ref), u85 (copy), u86 (copy)
                mainreplication.bodyVelocity(Root, 102, 1.1);
                KatUtil.forge_emit(u85, u86);
            end
        });

        return;
    end;

    if p83 ~= "confirm" then
        if p83 == "fail" then
            local _track = KatUtil.get_track(u82, u84.Offball.Fail);

            if not _track then
                return;
            end;

            local v89 = KatUtil.magnitude(u82);
            KatUtil.destroy_all_velocities(u82);
            mainreplication.bodyVelocity(Root, v89, 0.45);
            local u90 = KatUtil.create_vfx_instance(u84.Offball.VFX.Confirm["Left Leg"], u82["Left Leg"].CFrame, CFrame.identity);
            local u91 = KatUtil.create_vfx_instance(u84.Offball.VFX.Confirm["Right Leg"], u82["Right Leg"].CFrame, CFrame.identity);
            local u92 = { u90, u91 };
            local v93 = u2[u82];

            if v93 then
                for _, v in v93 do
                    pcall(game.Destroy, v);
                end;

                u2[u82] = nil;
            end;

            u2[u82] = u92;
            KatUtil.weld(u82["Left Leg"], u90, CFrame.identity, CFrame.identity);
            KatUtil.weld(u82["Right Leg"], u91, CFrame.identity, CFrame.identity);
            local v94 = KatUtil.create_vfx_instance(u84.Offball.VFX.Fail.Smoke, Root.CFrame, "offset");
            KatUtil.forge_emit(u90["Kiyora Trail Burst"], u90["Kiyora Trail Burst"], v94);
            _track.add(function() -- Line: 1034
                -- upvalues: u2 (ref), u82 (copy), u92 (copy), KatUtil (ref)
                if u2[u82] == u92 then
                    u2[u82] = nil;
                end;

                local v95 = {};

                for _, v in u92 do
                    if v and v.Parent then
                        table.insert(v95, v);
                    end;
                end;

                for _, v in v95 do
                    KatUtil.Enable(v, "Trail,ParticleEmitter,Beam", false);
                end;

                KatUtil.destroy_effect(v95);
            end);
            KatUtil.delay(6, function() -- Line: 1050
                -- upvalues: u90 (copy), u91 (copy), KatUtil (ref), vfxUtil (ref)
                for _, v in { u90, u91 } do
                    if v and v.Parent then
                        KatUtil.Enable(v, "Trail,ParticleEmitter,Beam", false);
                        vfxUtil.disposal(v, 0.5);
                    end;
                end;
            end);
        end;

        return;
    end;

    local _track = KatUtil.get_track(u82, u84.Offball.Confirm);

    if not _track then
        return;
    end;

    local u96 = KatUtil.create_vfx_instance(u84.Offball.VFX.Confirm["Left Leg"], u82["Left Leg"].CFrame, CFrame.identity);
    local u97 = KatUtil.create_vfx_instance(u84.Offball.VFX.Confirm["Right Leg"], u82["Right Leg"].CFrame, CFrame.identity);
    local u98 = u82:FindFirstChild("Ball") and KatUtil.create_vfx_instance(u84.Offball.VFX.Confirm.Ball, Root.CFrame);
    local u99 = {};

    for _, v in { u96, u97, u98 } do
        if v then
            table.insert(u99, v);
        end;
    end;

    local v100 = u2[u82];

    if v100 then
        for _, v in v100 do
            pcall(game.Destroy, v);
        end;

        u2[u82] = nil;
    end;

    u2[u82] = u99;
    KatUtil.forge_emit(u96, u97);
    _track.add(function() -- Line: 864
        -- upvalues: u2 (ref), u82 (copy), u99 (copy), KatUtil (ref)
        if u2[u82] == u99 then
            u2[u82] = nil;
        end;

        local v101 = {};

        for _, v in u99 do
            if v and v.Parent then
                table.insert(v101, v);
            end;
        end;

        for _, v in v101 do
            KatUtil.Enable(v, "Trail,ParticleEmitter,Beam", false);
        end;

        KatUtil.destroy_effect(v101);
    end);
    KatUtil.delay(8, function() -- Line: 880
        -- upvalues: u99 (copy), KatUtil (ref), vfxUtil (ref)
        for _, v in u99 do
            if v and v.Parent then
                KatUtil.Enable(v, "Trail,ParticleEmitter,Beam", false);
                vfxUtil.disposal(v, 0.5);
            end;
        end;
    end);
    KatUtil.weld(u82["Left Leg"], u96, CFrame.identity, CFrame.identity);
    KatUtil.weld(u82["Right Leg"], u97, CFrame.identity, CFrame.identity);

    if u98 then
        KatUtil.weld(u82:FindFirstChild("Ball"), u98, CFrame.identity, CFrame.identity);
    end;

    local v102 = KatUtil.magnitude(u82);
    KatUtil.destroy_all_velocities(u82);
    mainreplication.bodyVelocity(Root, v102 / 1.5, 1.3, false);
    _track.sequence({
        [1] = function() -- Line: 900
            -- upvalues: Players (ref), u82 (copy), mainreplication (ref)
            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u82) then
                mainreplication.fov(true, 65, 0.3833, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            end;

            mainreplication.highlight(u82, Color3.new(0.615686, 0.835294, 1), 0.75);
        end,

        [23] = function() -- Line: 906
            -- upvalues: KatUtil (ref), u84 (copy), Root (copy), u98 (copy), vfxUtil (ref), Players (ref), u82 (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
            local v103 = KatUtil.create_vfx_instance(u84.Offball.VFX.Confirm.Swing, Root.CFrame, "offset");

            if u98 then
                KatUtil.forge_emit(v103, u98.Impact, u98.Crescents);
            else
                KatUtil.forge_emit(v103);
            end;

            vfxUtil.disposal(v103, 2);

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u82) then
                mainreplication.springcamerashake(15, 40);
                mainreplication.fov(false, 80);
                mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                local v104 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                v104.Parent = Lighting;
                v104.TintColor = Color3.fromRGB(138, 218, 255);
                v104.Brightness = 0.2;
                v104.Contrast = 0.5;
                v104.Saturation = -0.4;
                TweenService:Create(v104, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Saturation = 0
                }):Play();
                TweenService:Create(v104, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Contrast = 0,
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                task.delay(1.5, v104.Destroy, v104);
            end;
        end,

        [60] = function() -- Line: 935
            -- upvalues: u98 (copy), KatUtil (ref)
            if u98 then
                KatUtil.forge_emit(u98.Impact, u98.Crescents);
            end;
        end,

        [80] = function() -- Line: 941
            -- upvalues: u98 (copy), KatUtil (ref)
            if u98 then
                KatUtil.forge_emit(u98.Impact, u98.Crescents);
            end;
        end,

        [96] = function() -- Line: 947
            -- upvalues: u98 (copy), KatUtil (ref), Players (ref), u82 (copy), mainreplication (ref)
            if u98 then
                KatUtil.forge_emit(u98.Impact, u98.Crescents);
            end;

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u82) then
                mainreplication.fov(true, 67, 0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
            end;
        end,

        [145] = function() -- Line: 973
            -- upvalues: KatUtil (ref), u84 (copy), Root (copy), u98 (copy), vfxUtil (ref), Players (ref), u82 (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
            local v105 = KatUtil.create_vfx_instance(u84.Offball.VFX.Confirm["Dance Party Kick"], Root.CFrame, "offset");

            if u98 then
                KatUtil.forge_emit(u98.Impact, u98.Crescents, v105);
            else
                KatUtil.forge_emit(v105);
            end;

            vfxUtil.disposal(v105, 2);

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u82) then
                mainreplication.fov(false, 110);
                mainreplication.fov(true, 70, 0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                mainreplication.cameraShake(15, 1.5, 6);
                local v106 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                v106.Parent = Lighting;
                v106.TintColor = Color3.fromRGB(138, 218, 255);
                v106.Brightness = 0.3;
                v106.Contrast = 0.7;
                v106.Saturation = -0.35;
                TweenService:Create(v106, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Saturation = 0
                }):Play();
                TweenService:Create(v106, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Contrast = 0,
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                task.delay(1, v106.Destroy, v106);
            end;
        end,

        [166] = function() -- Line: 1002
            -- upvalues: KatUtil (ref), u96 (copy), u97 (copy)
            KatUtil.Emit(u96["Kiyora Trail Burst"], u97["Kiyora Trail Burst"]);
        end
    });
end;

function u1.kiyora_sidetrap(u107: any, u108: string, p109: string) -- Line: 1061
    -- upvalues: vfxUtil (copy), KatUtil (copy), trove (copy), mainreplication (copy), RunService (copy), Players (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local Root = vfxUtil.getRoot(u107);
    local v110 = vfxUtil.getResources().kiyora["Side Trap"];

    if p109 ~= "try" then
        if p109 == "confirm" then
            if not KatUtil.get_track(u107, v110.Animations[`{u108}Confirm`]) then
                return;
            end;

            local u111 = trove.new();
            u111:AttachToInstance(u107);
            local v112 = require(script.Compiled.Trap["success" .. u108]);
            local u113 = u111:Construct(v110.VFX.Trap);
            u113.Parent = workspace.Effects;
            u111:Add(task.delay(4, function() -- Line: 1164
                -- upvalues: u111 (copy)
                u111:Destroy();
            end));
            u111:Add(RunService.RenderStepped:Connect(function() -- Line: 1167
                -- upvalues: u113 (copy), Root (copy)
                u113:PivotTo(Root.CFrame);
            end));

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u107) then
                mainreplication.springcamerashake(12.5, 50);
            end;

            local v114 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v114.Parent = Lighting;
            v114.TintColor = Color3.fromRGB(176, 230, 255);
            v114.Brightness = 0.2;
            v114.Contrast = 0.5;
            v114.Saturation = -0.4;
            TweenService:Create(v114, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v114, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(1.5, v114.Destroy, v114);
            mainreplication.fov(false, 55);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            KatUtil.destroy_all_velocities(u107);
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Parent = Root;
            BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
            BodyVelocity.P = 13500;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = u108 == "Left" and -25 or 25;
            local NumberValue2 = Instance.new("NumberValue");
            NumberValue2.Value = 6.25;
            TweenService:Create(NumberValue, TweenInfo.new(0.883, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Value = 0
            }):Play();
            TweenService:Create(NumberValue2, TweenInfo.new(1.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Value = 0
            }):Play();
            local u115 = tick();
            local u116 = nil;
            u116 = RunService.RenderStepped:Connect(function(p117) -- Line: 1208
                -- upvalues: u107 (copy), Root (copy), BodyVelocity (copy), u115 (copy), u116 (ref), NumberValue (copy), NumberValue2 (copy)
                local v118 = u107 and u107:FindFirstChild("Ball") ~= nil and true or false;

                if Root and (BodyVelocity and (BodyVelocity.Parent ~= nil and (tick() - u115 < 0.75 and v118))) then
                    BodyVelocity.Velocity = Root.CFrame.RightVector * NumberValue.Value + Root.CFrame.UpVector * NumberValue2.Value;

                    return;
                end;

                pcall(game.Destroy, BodyVelocity);
                u116:Disconnect();
            end);

            for _, v in ipairs(v112) do
                task.delay(v[1] / 60, v[2], u113);
            end;
        end;

        return;
    end;

    if not KatUtil.get_track(u107, v110.Animations[`{u108}`]) then
        return;
    end;

    local u119 = trove.new();
    u119:AttachToInstance(u107);
    local u120 = (u108 == "Left" and -95 or 95) * 0.75;
    local v121 = require(script.Compiled.Trap[u108]);
    mainreplication.cameraShake(10, 0.7, 4);
    mainreplication.fov(false, 80);
    mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local u122 = u119:Construct(v110.VFX.Trap);
    u122.Parent = workspace.Effects;
    u119:Add(task.delay(3, function() -- Line: 1087
        -- upvalues: u119 (copy)
        u119:Destroy();
    end));
    u119:Add(RunService.RenderStepped:Connect(function() -- Line: 1090
        -- upvalues: u122 (copy), Root (copy)
        u122:PivotTo(Root.CFrame);
    end));
    u107:SetAttribute("hadballforthisstupidbug", nil);
    u119:Add(u107.ChildAdded:Connect(function(p123) -- Line: 1097
        -- upvalues: u107 (copy)
        if p123.Name == "Ball" then
            u107:SetAttribute("hadballforthisstupidbug", true);
        end;
    end));
    u119:Add(task.delay(0.6, function() -- Line: 1103
        -- upvalues: u107 (copy), u108 (copy), mainreplication (ref), Root (copy), RunService (ref)
        if u107:FindFirstChild("Ball") then
            return;
        end;

        local u124 = 25;

        if u108 == "Left" then
            u124 = -u124;
        end;

        local u125 = mainreplication.bodyVelocity(Root, 0.5, 0.6799999999999999, nil, nil, true);

        if u125 then
            u125.MaxForce = Vector3.new(100000, 0, 100000);
            local u126 = tick();
            local u127 = nil;
            u127 = RunService.RenderStepped:Connect(function(p128) -- Line: 1114
                -- upvalues: u125 (copy), u127 (ref), u124 (ref), u126 (copy), Root (ref)
                if not (u125 and u125:IsDescendantOf(game)) then
                    u127:Disconnect();

                    return;
                end;

                local v129 = (tick() - u126) / 0.6799999999999999;
                local math_min_ret = math.min(v129, 1);
                local math_lerp_ret = math.lerp(u124, 0, math_min_ret);
                u125.Velocity = Root.CFrame.RightVector * math_lerp_ret;
            end);
            task.delay(15, u127.Disconnect, u127);
        end;
    end));
    local u130 = mainreplication.bodyVelocity(Root, 0.5, 0.395, nil, nil, true);

    if u130 then
        u130.MaxForce = Vector3.new(300000, 300000, 300000);
        local u131 = nil;
        u131 = RunService.RenderStepped:Connect(function(p132) -- Line: 1132
            -- upvalues: u130 (copy), u131 (ref), Root (copy), u120 (ref)
            if u130 and u130:IsDescendantOf(game) then
                u130.Velocity = Root.CFrame.RightVector * u120 + Root.CFrame.UpVector * 25;

                return;
            end;

            u131:Disconnect();
        end);
        task.delay(15, u131.Disconnect, u131);
    end;

    for _, v in ipairs(v121) do
        task.delay(v[1] / 60, function() -- Line: 1144
            -- upvalues: u107 (copy), v (copy), u122 (copy), Root (copy)
            if not u107:FindFirstChild("Ball") then
                v[2](u122, Root);
            end;
        end);
    end;
end;

function u1.kiyora_twisterpass_onball_startfx(p133) -- Line: 1235
    -- upvalues: mainreplication (copy), Players (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    mainreplication.highlight(p133, Color3.new(0.615686, 0.835294, 1), 0.6);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p133) then
        mainreplication.springcamerashake(5, 15);
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        local v134 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v134.Parent = Lighting;
        v134.TintColor = Color3.fromRGB(139, 220, 255);
        v134.Brightness = 0.2;
        v134.Contrast = 0.4;
        v134.Saturation = -0.4;
        TweenService:Create(v134, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v134, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v134.Destroy, v134);
    end;
end;

function u1.kiyora_twisterpass_onball(u135: any, p136: string) -- Line: 1255
    -- upvalues: vfxUtil (copy), trove (copy), KatUtil (copy), RunService (copy), soundUtil (copy), vfxUtil (copy), u2 (copy), Players (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local Onball = vfxUtil.getResources().kiyora["Twister Pass"].Onball;
    local Root = vfxUtil.getRoot(u135);

    if p136 ~= "start" then
        if p136 == "use" then
            local u137 = trove.new();
            u137:AttachToInstance(u135);
            soundUtil:play(Onball.Sounds["Twister Shot"], Root);
            soundUtil:stop(Root, "Loop");
            local _track = KatUtil.get_track(u135, Onball.Shot);

            if not _track then
                return;
            end;

            local u138 = Onball.VFX.Shot:Clone();
            u138.Parent = workspace.Effects;
            u137:Add(RunService.RenderStepped:Connect(function() -- Line: 1329
                -- upvalues: u138 (copy), Root (copy)
                u138:PivotTo(Root.CFrame);
            end));
            local shot = require(script.Compiled.TwisterPassOnball.shot);
            _track.track.Stopped:Once(function() -- Line: 1335
                -- upvalues: u137 (copy)
                u137:Destroy();
            end);
            local u139 = Onball.VFX.Aura:Clone();
            u139.Parent = workspace.Effects;
            vfxUtil.setupAura(u135, u139, true);
            local u140 = { u138, u139 };
            local v141 = u2[u135];

            if v141 then
                for _, v in v141 do
                    pcall(game.Destroy, v);
                end;

                u2[u135] = nil;
            end;

            u2[u135] = u140;

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u135) then
                mainreplication.fov(true, 65, 0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
            end;

            mainreplication.highlight(u135, Color3.new(0.615686, 0.835294, 1), 0.6);
            task.delay(0.6166, function() -- Line: 1353
                -- upvalues: Players (ref), u135 (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
                if Players.LocalPlayer == Players:GetPlayerFromCharacter(u135) then
                    mainreplication.springcamerashake(20, 40);
                    mainreplication.fov(false, 95);
                    mainreplication.fov(true, 70, 0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                    local v142 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v142.Parent = Lighting;
                    v142.TintColor = Color3.fromRGB(139, 220, 255);
                    v142.Brightness = 0.5;
                    v142.Contrast = 1;
                    v142.Saturation = -0.4;
                    TweenService:Create(v142, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v142, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Contrast = 0,
                        Brightness = 0,
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                    task.delay(2, v142.Destroy, v142);
                end;
            end);
            u137:Add(function() -- Line: 1373
                -- upvalues: u2 (ref), u135 (copy), u140 (copy), u139 (copy), u138 (copy)
                if u2[u135] == u140 then
                    u2[u135] = nil;
                end;

                if u139.Parent then
                    for _, descendant in u139:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                            descendant.Enabled = false;
                        end;
                    end;
                end;

                task.delay(2, function() -- Line: 1384
                    -- upvalues: u139 (ref), u138 (ref)
                    pcall(game.Destroy, u139);
                    pcall(game.Destroy, u138);
                end);
            end);
            u137:Add(_track.track.KeyframeReached:Connect(function(p143) -- Line: 1390
                -- upvalues: _track (copy), shot (copy), u138 (copy)
                print(_track.track.Speed, p143);

                if _track.track.Speed == 1 then
                    coroutine.wrap(shot[tonumber(p143)][2])(u138);
                end;
            end));
        end;

        return;
    end;

    local u144 = trove.new();
    u144:AttachToInstance(u135);
    local _track = KatUtil.get_track(u135, Onball.Loop);

    if not _track then
        return;
    end;

    local u145 = Onball.VFX.Loop:Clone();
    u145.Parent = workspace.Effects;
    u144:Add(RunService.RenderStepped:Connect(function() -- Line: 1270
        -- upvalues: u145 (copy), Root (copy)
        u145:PivotTo(Root.CFrame);
    end));
    u144:Add(soundUtil:play(Onball.Sounds.Loop, Root));
    local loop = require(script.Compiled.TwisterPassOnball.loop);
    _track.track.Stopped:Once(function() -- Line: 1278
        -- upvalues: u144 (copy)
        u144:Destroy();
    end);
    local u146 = Onball.VFX.Aura:Clone();
    u146.Parent = workspace.Effects;
    vfxUtil.setupAura(u135, u146, true);
    local u147 = { u145, u146 };
    local v148 = u2[u135];

    if v148 then
        for _, v in v148 do
            pcall(game.Destroy, v);
        end;

        u2[u135] = nil;
    end;

    u2[u135] = u147;
    u144:Add(function() -- Line: 1290
        -- upvalues: u2 (ref), u135 (copy), u147 (copy), u146 (copy), u145 (copy)
        if u2[u135] == u147 then
            u2[u135] = nil;
        end;

        if u146.Parent then
            for _, descendant in u146:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end;

        task.delay(2, function() -- Line: 1302
            -- upvalues: u146 (ref), u145 (ref)
            pcall(game.Destroy, u146);
            pcall(game.Destroy, u145);
        end);
    end);
    u144:Add(_track.track.KeyframeReached:Connect(function(p149) -- Line: 1308
        -- upvalues: _track (copy), loop (copy), u145 (copy)
        if _track.track.Speed == 1 then
            coroutine.wrap(loop[tonumber(p149)][2])(u145);
        end;
    end));
end;

function u1.kiyora_flow(u150, p151) -- Line: 1399
    -- upvalues: vfxUtil (copy), soundUtil (copy), trove (copy), mainreplication (copy), vfxUtil (copy), Util (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(u150);
    local Flow = vfxUtil.getResources().kiyora.Flow;
    local v152 = soundUtil:play(Flow.SFX, soundUtil);
    local u153 = trove.new();
    u153:AttachToInstance(u150);
    mainreplication.sceneEnabled(true);
    vfxUtil.cutscene_ball(true);
    vfxUtil.cache_lighting();
    u153:Add(vfxUtil.restore_lighting);
    u153:Add(vfxUtil.restore_lighting_properties);
    local _ = shared.allvfxcheck and shared.allvfxcheck();
    local _baseplate_controller, u154 = vfxUtil.get_baseplate_controller();
    u153:Add(vfxUtil.make_baseplate_connection(_baseplate_controller.update));
    u154.Transparency = 1;
    u153:Add(function() -- Line: 1423
        -- upvalues: u154 (copy), _baseplate_controller (copy), vfxUtil (ref)
        u154.Transparency = 0;
        _baseplate_controller.update();
        vfxUtil.cutscene_ball(false);
    end);
    Util.flowCancel(u153, p151, { v152 });
    local v155 = u153:Construct(Flow.Aura);
    vfxUtil.setupAura(u150, v155, true);
    local v156 = u153:Construct(Flow.Effects);
    v156:PivotTo(Root.CFrame);
    local v157 = v156["kiyora flow"];
    v156.Parent = workspace.Effects;
    v155.Parent = workspace.Effects;
    v157.AnimationController:LoadAnimation(Flow.Animations.Object):Play();
    local v158, v159 = mainreplication.cutsceneBlender(Root, Flow.Animations.Camera, Flow.FOV, nil, nil, CFrame.new(0, -3, 0), Flow.Cam);
    u153:Add(v159);
    local u160 = {};

    for _, child in Flow.Lighting:GetChildren() do
        local v161 = child:Clone();
        v161.Parent = Lighting;
        u160[child.Name] = v161;
    end;

    Lighting.Ambient = Color3.new(0, 0, 0);
    Lighting.Brightness = 3;
    Lighting.ColorShift_Top = Color3.new(0, 0, 0);
    Lighting.ColorShift_Bottom = Color3.new(0, 0, 0);
    Lighting.EnvironmentDiffuseScale = 1;
    Lighting.EnvironmentSpecularScale = 1;
    Lighting.GlobalShadows = true;
    Lighting.OutdoorAmbient = Color3.new(0, 0, 0);
    Lighting.ShadowSoftness = 0.2;
    Lighting.GeographicLatitude = 98;
    Lighting.ExposureCompensation = 0;
    Lighting.ClockTime = 0;
    u153:Add(function() -- Line: 1470
        -- upvalues: u160 (copy), mainreplication (ref)
        for _, v in u160 do
            pcall(game.Destroy, v);
        end;

        mainreplication.bright(-1, 1);
        mainreplication.sceneEnabled(false);
    end);
    u153:Add(task.delay(13.1, function() -- Line: 1478
        -- upvalues: u153 (copy)
        u153:Destroy();
    end));
    local v162 = {
        Burst = v156.Burst,
        Step0 = v156.Step0,
        Step1 = v156.Step1,
        Step2 = v156.Step2,
        Step3 = v156.Step3,
        TuffCharacterRig = v155,
        Workspace = v156,
        Baseplate = u154,
        Lighting = Lighting
    };

    for i, v in u160 do
        v162[i] = v;
    end;

    local v163 = u153:Construct(MoonPropertyAnimator);
    v163:LoadAndConvertSave(Flow.Moon, v162);
    v163:SetOriginalRoot(Flow.CFrame.Value);
    v163:SetRoot(Root);
    v163:PlayAll();
    vfxUtil.execute_compiled(script.Compiled.Flow, u153, v155, v156, v158);
    u153:Add(task.delay(0.522, function() -- Line: 1505
        -- upvalues: u153 (copy), TekrinnDialogue (ref), u150 (copy)
        u153:Add(TekrinnDialogue.Speak(u150, {
            {
                Text = "Times like this I need to stay calm.",
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0, 0.211765, 0.309804), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 5));
    end));
    u153:Add(task.delay(3.509, function() -- Line: 1520
        -- upvalues: u153 (copy), TekrinnDialogue (ref), u150 (copy)
        u153:Add(TekrinnDialogue.Speak(u150, {
            {
                Text = "And I\'m still standing.",
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0, 0.211765, 0.309804), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 5));
    end));
    u153:Add(task.delay(7.445, function() -- Line: 1535
        -- upvalues: u153 (copy), TekrinnDialogue (ref), u150 (copy)
        u153:Add(TekrinnDialogue.Speak(u150, {
            {
                Text = "Who do I choose to make myself ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0, 0.211765, 0.309804), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "shine",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 0)),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "..",
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0, 0.211765, 0.309804), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 5));
    end));
    u153:Add(task.delay(10.632, function() -- Line: 1571
        -- upvalues: u153 (copy), TekrinnDialogue (ref), u150 (copy)
        u153:Add(TekrinnDialogue.Speak(u150, {
            {
                Text = "Where is the ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0, 0.211765, 0.309804), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            },
            {
                Text = "borderline",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(0, 0.211765, 0.309804)),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 3
                }
            },
            {
                Text = ".",
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0, 0.211765, 0.309804), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }, 1.8890000000000011));
    end));
end;

local function borderlineLighting(p164) -- Line: 1608
    -- upvalues: vfxUtil (copy), Lighting (copy), vfxUtil (copy)
    local kiyora = vfxUtil.getResources().kiyora;
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    task.defer(vfxUtil.cache_lighting);
    p164:Add(vfxUtil.restore_lighting);
    p164:Add(vfxUtil.restore_lighting_properties);

    for _, child in kiyora.Borderline.Lighting:GetChildren() do
        p164:Clone(child).Parent = Lighting;
    end;
end;

function u1.kiyora_borderline(u165: any, u166: number, u167: any, u168: any) -- Line: 1621
    -- upvalues: vfxUtil (copy), mainreplication (copy), vfxUtil (copy), trove (copy), u1 (copy), borderlineLighting (copy), soundUtil (copy)
    local Borderline = vfxUtil.getResources().kiyora.Borderline;
    local Animations = Borderline.Animations;
    local Root = vfxUtil.getRoot(u165);
    mainreplication.sceneEnabled(true);
    vfxUtil.cutscene_ball(true);
    local u169 = false;
    local u170 = trove.new();
    u170:AttachToInstance(u165);
    u170:Add(function() -- Line: 1633
        -- upvalues: mainreplication (ref), u169 (ref), u1 (ref), u165 (copy), u166 (copy), u167 (copy), u168 (copy), vfxUtil (ref)
        mainreplication.ultFlash(-1, 1);
        mainreplication.sceneEnabled(false);

        if u169 then
            u1.kiyora_borderline_loop(u165, u166, u167, u168);

            return;
        end;

        vfxUtil.cutscene_ball(false);
    end);
    u170:Add(task.delay(2.117, function() -- Line: 1642
        -- upvalues: u169 (ref), u170 (copy)
        u169 = true;
        u170:Destroy();
    end));
    borderlineLighting(u170);
    local v171 = u170:Clone(Borderline.User);
    vfxUtil.setupAura(u165, v171, true);
    v171.Parent = workspace.Effects;
    local _, v172 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations["Start.cam"], Animations["Start.fov"], u165, CFrame.new(0, -3, 0), Borderline.Cam, "CamPart");
    u170:Add(v172);
    vfxUtil.execute_compiled(Animations["Start.compiled"], u170, v171);
    soundUtil:play(Borderline.Sounds["Start.inst"], soundUtil);
    soundUtil:play(Borderline.Sounds["Start.sfx"], soundUtil);
end;

local Mouse = Players.LocalPlayer:GetMouse();

function u1.kiyora_borderline_loop(p173: any, p174: number, p175: any, p176: any) -- Line: 1665
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), vfxUtil (copy), trove (copy), TweenService (copy), RunService (copy), Mouse (copy), borderlineLighting (copy)
    local Borderline = vfxUtil.getResources().kiyora.Borderline;
    local Animations = Borderline.Animations;
    local Root = vfxUtil.getRoot(p173);
    local u177 = soundUtil:play(Borderline.Sounds["Loop.inst"], soundUtil);
    mainreplication.sceneEnabled(true);
    vfxUtil.cutscene_ball(true);
    local u178 = trove.new();
    u178:AttachToInstance(p173);
    u178:Add(function() -- Line: 1678
        -- upvalues: mainreplication (ref), vfxUtil (ref), TweenService (ref), u177 (copy)
        mainreplication.ultFlash(-1, 1);
        mainreplication.sceneEnabled(false);
        vfxUtil.cutscene_ball(false);
        TweenService:Create(u177, TweenInfo.new(1), {
            Volume = 0
        }):Play();
    end);
    u178:Add(task.delay(p174, function() -- Line: 1684
        -- upvalues: u178 (copy)
        u178:Destroy();
    end));

    if vfxUtil.isLocalPlayer(p173) then
        local u179 = u178:Add(Instance.new("Highlight"));
        u179.FillColor = Color3.new(1, 1, 1);
        u179.FillTransparency = 1;
        u179.OutlineColor = Color3.new(1, 1, 1);
        u179.OutlineTransparency = 1;
        u179.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        u179.Parent = p175;
        local u180 = u178:Clone(u179);
        u180.Parent = p176;
        u178:Connect(RunService.RenderStepped, function(p181) -- Line: 1700
            -- upvalues: Mouse (ref), u179 (copy), u180 (copy)
            local v182 = workspace.CurrentCamera.ViewportSize.X / 2;
            local v183 = v182 * 0.1 > math.abs(Mouse.X - v182);
            local v184 = p181 / 0.016666666666666666;

            if v183 then
                local v185 = v184 / 3;
                shared.kiyoraSide = 0;
                u179.FillTransparency = math.lerp(u179.FillTransparency, 1, v185);
                u179.OutlineTransparency = math.lerp(u179.OutlineTransparency, 1, v185);
                u180.FillTransparency = math.lerp(u180.FillTransparency, 1, v185);
                u180.OutlineTransparency = math.lerp(u180.OutlineTransparency, 1, v185);

                return;
            end;

            if Mouse.X < v182 then
                shared.kiyoraSide = 1;
                u179.FillTransparency = math.lerp(u179.FillTransparency, 0.5, v184);
                u179.OutlineTransparency = math.lerp(u179.OutlineTransparency, 0, v184);
                u180.FillTransparency = math.lerp(u180.FillTransparency, 1, v184);
                u180.OutlineTransparency = math.lerp(u180.OutlineTransparency, 1, v184);

                return;
            end;

            shared.kiyoraSide = 2;
            u179.FillTransparency = math.lerp(u179.FillTransparency, 1, v184);
            u179.OutlineTransparency = math.lerp(u179.OutlineTransparency, 1, v184);
            u180.FillTransparency = math.lerp(u180.FillTransparency, 0.5, v184);
            u180.OutlineTransparency = math.lerp(u180.OutlineTransparency, 0, v184);
        end);
    end;

    borderlineLighting(u178);
    local _, v186 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations["Loop.cam"], Animations["Loop.fov"], p173, CFrame.new(0, -3, 0), Borderline.Cam, "CamPart");
    u178:Add(v186);
end;

function u1.kiyora_borderline_kick(p187: any, p188: string) -- Line: 1736
    -- upvalues: vfxUtil (copy), mainreplication (copy), vfxUtil (copy), trove (copy), borderlineLighting (copy), soundUtil (copy)
    local Borderline = vfxUtil.getResources().kiyora.Borderline;
    local Animations = Borderline.Animations;
    local Root = vfxUtil.getRoot(p187);
    mainreplication.sceneEnabled(true);
    vfxUtil.cutscene_ball(true);
    local u189 = trove.new();
    u189:AttachToInstance(p187);
    u189:Add(function() -- Line: 1747
        -- upvalues: mainreplication (ref), vfxUtil (ref)
        mainreplication.ultFlash(1, 1);
        mainreplication.sceneEnabled(false);
        vfxUtil.cutscene_ball(false);
    end);
    u189:Add(task.delay(1.5, function() -- Line: 1752
        -- upvalues: u189 (copy)
        u189:Destroy();
    end));
    borderlineLighting(u189);
    local v190 = u189:Clone(Borderline.VFX);
    v190:PivotTo(Root.CFrame);
    v190.Parent = workspace.Effects;
    local _, v191 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations[`{p188}.cam`], Animations[`{p188}.fov`], p187, CFrame.new(0, -3, 0), Borderline.Cam, "CamPart");
    u189:Add(v191);
    vfxUtil.execute_compiled(Animations["Kick.compiled"], u189, v190);
    soundUtil:play(Borderline.Sounds["Shoot.inst"], soundUtil);
    soundUtil:play(Borderline.Sounds["Shoot.sfx"], soundUtil);
end;

function u1.kiyora_accelerating_shot(u192) -- Line: 1771
    -- upvalues: vfxUtil (copy), mainreplication (copy), vfxUtil (copy), trove (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy), TekrinnDialogue (copy)
    local Borderline = vfxUtil.getResources().kiyora.Borderline;
    local Animations = Borderline.Animations;
    local Root = vfxUtil.getRoot(u192);
    mainreplication.sceneEnabled(true);
    vfxUtil.cutscene_ball(true);
    local u193 = trove.new();
    u193:AttachToInstance(u192);
    u193:Add(vfxUtil.getScreenDimmer());
    u193:Add(function() -- Line: 1783
        -- upvalues: mainreplication (ref), vfxUtil (ref)
        mainreplication.sceneEnabled(false);
        vfxUtil.cutscene_ball(false);
        mainreplication.ultFlash(1, 1.5);
    end);
    u193:Add(task.delay(7.9, function() -- Line: 1788
        -- upvalues: u193 (copy)
        u193:Destroy();
    end));
    local _baseplate_controller, v194 = vfxUtil.get_baseplate_controller();
    u193:Add(vfxUtil.make_baseplate_connection(_baseplate_controller.update));
    local v195 = u193:Add(vfxUtil.getMoonEffects());
    local v196 = u193:Clone(Borderline.Accelerating.VFX);
    v196:PivotTo(Root.CFrame);
    vfxUtil.setupAura(u192, v196.TuffCharacterRig, true);
    v196.Parent = workspace.Effects;
    local v197, v198 = mainreplication.cutsceneCamRigWithLetterBox(Root, Animations["Accelerating.cam"], Animations["Accelerating.fov"], u192, CFrame.new(0, -3, 0), Borderline.Accelerating.Cam, "CamPart");
    u193:Add(v198);
    local v199 = {
        Vignette = v195.Vignette,
        Baseplate = v194,
        Workspace = v196
    };
    vfxUtil.cache_lighting();

    for _, child in ipairs(Borderline.Accelerating.Lighting:GetChildren()) do
        local v200 = u193:Clone(child);
        v200.Parent = Lighting;
        v199[child.Name] = v200;
    end;

    u193:Add(vfxUtil.restore_lighting);
    u193:Add(vfxUtil.restore_lighting_properties);
    local v201 = u193:Construct(MoonPropertyAnimator);
    v201:LoadAndConvertSave(Borderline.Accelerating.Moon, v199);
    v201:PlayAll();
    vfxUtil.execute_compiled(Borderline.Accelerating.Compiled, u193, v196, v197);
    soundUtil:play(Borderline.Accelerating.SFX, soundUtil);
    u193:Add(task.delay(1.643, function() -- Line: 1824
        -- upvalues: u193 (copy), TekrinnDialogue (ref), u192 (copy)
        u193:Add(TekrinnDialogue.Speak(u192, {
            {
                Text = "Grounder Backspin Accelerating Shot!",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new(Color3.new(0, 0.211765, 0.309804), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2.6530000000000005
                }
            }
        }));
    end));
end;

function u1.kiyora_underdog(p202) -- Line: 1841
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), vfxUtil (copy), Lighting (copy), RunService (copy)
    local Root = vfxUtil.getRoot(p202);
    local Underdog = vfxUtil.getResources().kiyora.Underdog;
    local u203 = trove.new();
    u203:AttachToInstance(p202);
    mainreplication.sceneEnabled(true);
    soundUtil:play(Underdog.SFX, soundUtil);
    local u204 = u203:Construct(Underdog.VFX.Aura);
    vfxUtil.setupAura(p202, u204, true);
    local v205 = u203:Add(Instance.new("ColorCorrectionEffect"));
    v205.Parent = Lighting;
    local _ = {
        Vignette = u203:Add(vfxUtil.getMoonEffects()).Vignette,
        ColorCorrection = v205
    };
    local u206 = u203:Construct(Underdog.VFX.VFX);
    u203:Add(RunService.RenderStepped:Connect(function() -- Line: 1861
        -- upvalues: u206 (copy), Root (copy)
        u206:PivotTo(Root.CFrame);
    end));
    u206.Parent = workspace.Effects;
    u204.Parent = workspace.Effects;
    local u207, u208 = mainreplication.cutsceneBlender(Root, Underdog.Animations.Cam, Underdog.FOV, nil, nil, CFrame.new(0, -3, 0), Underdog.Cam);
    u203:Add(function() -- Line: 1874
        -- upvalues: u207 (copy), u208 (copy), mainreplication (ref)
        if u207 then
            u208();
        end;

        mainreplication.sceneEnabled(false);
    end);
    u203:Add(task.delay(2.58, function() -- Line: 1881
        -- upvalues: u203 (copy)
        u203:Destroy();
    end));
    local Module = require(script.Compiled.Underdog.Module);

    for _, v in ipairs(Module) do
        task.delay(v[1] / 60, function() -- Line: 1888
            -- upvalues: v (copy), u204 (copy), u206 (copy), u207 (copy)
            v[2](u204, u206.vfx, u207);
        end);
    end;
end;

function u1.kiyora_flarepass(p209, p210, p211) -- Line: 1895
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), vfxUtil (copy), RunService (copy)
    local Root = vfxUtil.getRoot(p209);
    local v212 = vfxUtil.getResources().kiyora["Twister Pass"]["Flare Pass"];
    local u213 = trove.new();
    u213:AttachToInstance(p209);
    mainreplication.sceneEnabled(true);
    soundUtil:play(v212.SFX, soundUtil);
    local u214 = u213:Construct(v212.UserAura);
    vfxUtil.setupAura(p209, u214, true);
    u214.Parent = workspace.Effects;
    local u215 = u213:Construct(v212.VFX);
    u215.Parent = workspace.Effects;
    local u216 = u213:Construct(v212.HumanoidVFX);
    u216.Parent = workspace.Effects;
    u213:Add(RunService.RenderStepped:Connect(function() -- Line: 1916
        -- upvalues: u215 (copy), Root (copy), u216 (copy)
        u215:PivotTo(Root.CFrame);
        u216.CFrame = Root.CFrame * CFrame.new(0, 0, -5.2);
    end));
    local u217 = nil;
    local u218;

    if p210 then
        u218 = u213:Construct(v212.NagiAura);
        vfxUtil.setupAura(p210, u218, true);
        u218.Parent = workspace.Effects;
    else
        u218 = nil;
    end;

    if p211 then
        u217 = u213:Construct(v212.BarouAura);
        vfxUtil.setupAura(p211, u217, true);
        u217.Parent = workspace.Effects;
    end;

    local u219, u220 = mainreplication.cutsceneBlender(Root, v212.AnimCam, v212.FOV, nil, nil, CFrame.new(0, -3, 0), v212.Cam);
    u213:Add(function() -- Line: 1938
        -- upvalues: u219 (copy), u220 (copy), mainreplication (ref)
        if u219 then
            u220();
        end;

        mainreplication.sceneEnabled(false);
    end);
    u213:Add(task.delay(10.97, function() -- Line: 1945
        -- upvalues: u213 (copy)
        u213:Destroy();
    end));
    local FlarePass = require(script.Compiled.FlarePass);

    for _, v in ipairs(FlarePass) do
        task.delay(v[1] / 60, function() -- Line: 1951
            -- upvalues: v (copy), u214 (copy), u218 (ref), u217 (ref), u215 (copy), u216 (copy)
            v[2](u214, u218, u217, u215, u216);
        end);
    end;
end;

return u1;