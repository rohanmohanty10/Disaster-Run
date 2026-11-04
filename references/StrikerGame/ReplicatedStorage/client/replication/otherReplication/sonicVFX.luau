 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local _ = Players.LocalPlayer;
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local Part_Icles = require(ReplicatedStorage:WaitForChild("Part_Icles"));
local trove = require(ReplicatedStorage.forum.trove);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local sonic = vfxUtil.getResources().sonic;
local StyleData = vfxUtil.getStyleData("sonic");
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local u2 = false;

local function preload_moves() -- Line: 33
    -- upvalues: u2 (ref), sonic (copy), Part_Icles (copy)
    if u2 then
        return;
    end;

    u2 = true;
    task.spawn(function() -- Line: 39
        -- upvalues: sonic (ref), Part_Icles (ref)
        local v3 = { sonic:WaitForChild("Freestyle"):WaitForChild("SpinDash"), sonic:WaitForChild("Whirlwind Shot") };
        game:GetService("ContentProvider"):PreloadAsync(v3);

        for _, v in v3 do
            Part_Icles:Preload(v);
        end;
    end);
end;

local function watch_style(u4: userdata) -- Line: 51
    -- upvalues: u2 (ref), sonic (copy), Part_Icles (copy)
    local function check() -- Line: 52
        -- upvalues: u4 (copy), u2 (ref), sonic (ref), Part_Icles (ref)
        if u4:GetAttribute("style") == "sonic" then
            if u2 then
                return;
            end;

            u2 = true;
            task.spawn(function() -- Line: 39
                -- upvalues: sonic (ref), Part_Icles (ref)
                local v5 = { sonic:WaitForChild("Freestyle"):WaitForChild("SpinDash"), sonic:WaitForChild("Whirlwind Shot") };
                game:GetService("ContentProvider"):PreloadAsync(v5);

                for _, v in v5 do
                    Part_Icles:Preload(v);
                end;
            end);
        end;
    end;

    if u4:GetAttribute("style") == "sonic" and not u2 then
        u2 = true;
        task.spawn(function() -- Line: 39
            -- upvalues: sonic (ref), Part_Icles (ref)
            local v6 = { sonic:WaitForChild("Freestyle"):WaitForChild("SpinDash"), sonic:WaitForChild("Whirlwind Shot") };
            game:GetService("ContentProvider"):PreloadAsync(v6);

            for _, v in v6 do
                Part_Icles:Preload(v);
            end;
        end);
    end;

    u4:GetAttributeChangedSignal("style"):Connect(check);
end;

if RunService:IsClient() then
    for _, v in Players:GetPlayers() do
        local function v8() -- Line: 52
            -- upvalues: v (copy), u2 (ref), sonic (copy), Part_Icles (copy)
            if v:GetAttribute("style") == "sonic" then
                if u2 then
                    return;
                end;

                u2 = true;
                task.spawn(function() -- Line: 39
                    -- upvalues: sonic (ref), Part_Icles (ref)
                    local v7 = { sonic:WaitForChild("Freestyle"):WaitForChild("SpinDash"), sonic:WaitForChild("Whirlwind Shot") };
                    game:GetService("ContentProvider"):PreloadAsync(v7);

                    for _, v2 in v7 do
                        Part_Icles:Preload(v2);
                    end;
                end);
            end;
        end;

        if v:GetAttribute("style") == "sonic" and not u2 then
            u2 = true;
            task.spawn(function() -- Line: 39
                -- upvalues: sonic (copy), Part_Icles (copy)
                local v9 = { sonic:WaitForChild("Freestyle"):WaitForChild("SpinDash"), sonic:WaitForChild("Whirlwind Shot") };
                game:GetService("ContentProvider"):PreloadAsync(v9);

                for _, v2 in v9 do
                    Part_Icles:Preload(v2);
                end;
            end);
        end;

        v:GetAttributeChangedSignal("style"):Connect(v8);
    end;

    Players.PlayerAdded:Connect(watch_style);
end;

local u10 = {
    images_per_second = 25,
    lifetime = 0.2,
    mode = "outandin",
    direction = Vector3.new(1, 0, 0),
    position_offset = Vector3.new(-0.1, 0.2, 1),
    color_fade_delay = 0.1,
    color_fade_time = 0.1,
    initial_transparency = 0.6,
    fade_out = true,
    fade_delay = 0.1,
    fade_time = 0.1,
    spread = Vector2.new(35, 35),
    distance = NumberRange.new(0, 0),
    start_color = Color3.fromRGB(66, 93, 217),
    end_color = Color3.fromRGB(113, 140, 238)
};
local RigAfterimages = require(ReplicatedStorage.mvputils.RigAfterimages);

local function playSpinDashAfterimages(p11: userdata, p12: any, p13: any) -- Line: 88
    -- upvalues: u10 (copy), RigAfterimages (copy)
    local table_clone_ret = table.clone(p13 or u10);
    table_clone_ret.name = table_clone_ret.name or "SonicSpinDashAfterImage";

    return RigAfterimages.play(p11, p12, table_clone_ret);
end;

local function is_local_character(p14) -- Line: 94
    -- upvalues: LocalPlayer (copy), Players (copy)
    return LocalPlayer == Players:GetPlayerFromCharacter(p14);
end;

local function invisible(p15, p16) -- Line: 98
    if not p16 then
        if p15:GetAttribute("Invisible") then
            return false;
        end;

        p15:SetAttribute("Invisible", true);
        local v17 = {};

        for _, descendant in p15:GetDescendants() do
            if descendant:IsA("BasePart") then
                table.insert(v17, {
                    Instance = descendant,
                    OriginalTransparency = descendant.Transparency
                });
                descendant.Transparency = 1;
            elseif descendant:IsA("SurfaceGui") then
                table.insert(v17, {
                    Instance = descendant,
                    OriginalEnabled = descendant.Enabled
                });
                descendant.Enabled = false;
            elseif descendant:IsA("ParticleEmitter") and descendant:FindFirstAncestorWhichIsA("Accessory") then
                table.insert(v17, {
                    Instance = descendant,
                    OriginalEnabled = descendant.Enabled
                });
                descendant.Enabled = false;
            end;
        end;

        return v17;
    end;

    for _, v in p16 do
        if v.Instance:IsA("SurfaceGui") or v.Instance:IsA("ParticleEmitter") then
            v.Instance.Enabled = v.OriginalEnabled;
        else
            v.Instance.Transparency = v.OriginalTransparency;
        end;
    end;

    p15:SetAttribute("Invisible", nil);
end;

function v1.sonic_freestyle(p18: any, p19: boolean?) -- Line: 148
end;

function v1.sonic_roundabout_juke(u20: any, p21: number?) -- Line: 151
    -- upvalues: vfxUtil (copy), RunService (copy), Part_Icles (copy)
    vfxUtil.getRoot(u20);
    local v22 = vfxUtil.getResources().sonic["Roundabout Juke"];
    local Ball = u20:FindFirstChild("Ball");

    if not Ball then
        return;
    end;

    local u23 = vfxUtil.character_trove(u20);
    local u24 = u23:Clone(v22.VFX);
    u24:PivotTo(u20:GetPivot());
    u24.Parent = workspace.Effects;
    local u25 = u23:Clone(v22.BallT);
    u25.Weld.Part0 = Ball;
    u25.Parent = workspace.Effects;
    u23:Add(RunService.PreRender:Connect(function() -- Line: 169
        -- upvalues: u24 (copy), u20 (copy)
        if u24 then
            u24:PivotTo(u20:GetPivot());
        end;
    end));
    u23:Add(task.delay(0.4666666666666667, function() -- Line: 175
        -- upvalues: Part_Icles (ref), u24 (copy), u25 (copy)
        Part_Icles:AbsoluteEmit(u24);
        shared.vfx.emit(u25.Attachment.B.Trail:FindFirstChild("Enabled"));
        shared.vfx.emit(u25.VFX);
    end));
    u23:Add(task.delay(p21, function() -- Line: 183
        -- upvalues: u23 (copy)
        u23:Destroy();
    end));
end;

function v1.sonic_spin_dash(u26, p27) -- Line: 188
    -- upvalues: vfxUtil (copy), animationUtil (copy), invisible (copy), LocalPlayer (copy), Players (copy), mainreplication (copy), Part_Icles (copy), u10 (copy), RigAfterimages (copy)
    local Root = vfxUtil.getRoot(u26);
    local SpinDash = vfxUtil.getResources().sonic.Freestyle.SpinDash;
    local u28 = vfxUtil.character_trove(u26);
    local u29 = u28:Clone(SpinDash.Visuals.VFX);
    u29.Weld.Part1 = Root;
    u29.Parent = workspace.Effects;
    local u30 = u28:Clone(SpinDash.Visuals.Ball2);
    u30.HumanoidRootPart.Weld.Part1 = Root;
    u30.Parent = workspace.Effects;
    local u31 = animationUtil:loadAnimation(u30, SpinDash.Animations.Ball);
    u31:Play(0);
    u28:Add(task.delay(0.23333333333333334, function() -- Line: 207
        -- upvalues: invisible (ref), u26 (copy), u28 (copy), LocalPlayer (ref), Players (ref), mainreplication (ref), Root (copy), u31 (copy), animationUtil (ref), u30 (copy), SpinDash (copy), Part_Icles (ref), u29 (copy), u10 (ref), RigAfterimages (ref)
        local u32 = invisible(u26);
        u28:Add(function() -- Line: 210
            -- upvalues: invisible (ref), u26 (ref), u32 (copy)
            invisible(u26, u32);
        end);

        if LocalPlayer == Players:GetPlayerFromCharacter(u26) then
            local v33 = mainreplication.bodyVelocity(Root, 300, "inf", false, "LookVector", false, nil, -1);

            if v33 then
                u28:Add(v33);
            end;

            mainreplication.fov(true, 90, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            u28:Add(function() -- Line: 231
                -- upvalues: mainreplication (ref)
                mainreplication.fov(true, 70, 1, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
            end);
        end;

        u31:Stop();
        u28:Add(animationUtil:loadAnimation(u30, SpinDash.Animations.BallLoop), "Stop"):Play(0);
        Part_Icles:AbsoluteEnable(u29);
        local table_clone_ret = table.clone(u10);
        table_clone_ret.name = table_clone_ret.name or "SonicSpinDashAfterImage";
        RigAfterimages.play(u30, u28, table_clone_ret);
    end));
    local v34 = LocalPlayer == Players:GetPlayerFromCharacter(u26) and mainreplication.bodyVelocity(Root, 70, 0.23333333333333334, true, "LookVector");

    if v34 then
        u28:Add(v34);
    end;

    u28:Add(u26:GetAttributeChangedSignal(p27):Connect(function() -- Line: 258
        -- upvalues: u28 (copy)
        u28:Destroy();
    end));
end;

function v1.sonic_spin_dash_arc(u35: any, p36: vector, u37: string, u38: boolean?, u39: any) -- Line: 263
    -- upvalues: LocalPlayer (copy), Players (copy), vfxUtil (copy), mainreplication (copy), RunService (copy)
    if LocalPlayer ~= Players:GetPlayerFromCharacter(u35) or typeof(p36) ~= "Vector3" then
        return;
    end;

    local Root = vfxUtil.getRoot(u35);

    if not Root then
        return;
    end;

    local u40 = vfxUtil.character_trove(u35);
    local Position = Root.Position;
    local Vector3_new_ret = Vector3.new(p36.X - Position.X, 0, p36.Z - Position.Z);
    local u41;

    if Vector3_new_ret.Magnitude > 0.05 then
        u41 = Vector3_new_ret.Unit;
    else
        local Vector3_new_ret2 = Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z);
        u41 = Vector3_new_ret2.Magnitude <= 0.05 and Vector3.new(0, 0, 1) or Vector3_new_ret2.Unit;
    end;

    local X = p36.X;
    local math_max_ret = math.max(Position.Y + 12, p36.Y + 6);
    local Vector3_new_ret2 = Vector3.new(X, math_max_ret, p36.Z);
    local u42 = mainreplication.bodyVelocity(Root, 1, "inf", false, nil, true, nil, -1);

    if not u42 then
        u40:Destroy();

        return;
    end;

    u42.MaxForce = Vector3.new(100000, 100000, 100000);
    u40:Add(u42);
    u40:Add(u35:GetAttributeChangedSignal(u37):Connect(function() -- Line: 302
        -- upvalues: u35 (copy), u37 (copy), u40 (copy), u38 (copy), u39 (copy), mainreplication (ref), Root (copy)
        if u35:GetAttribute(u37) then
            return;
        end;

        u40:Destroy();

        if not u38 and u35:GetAttribute(u39) then
            mainreplication.bodyVelocity(Root, 300, "inf", false, "LookVector", false, nil, -1);
        end;
    end));
    local u43 = 0;
    u40:Add(RunService.PreRender:Connect(function(p44) -- Line: 320
        -- upvalues: u43 (ref), u42 (copy), Vector3_new_ret2 (copy), Position (copy), u41 (ref)
        u43 = u43 + p44;
        local math_clamp_ret = math.clamp(u43 / 0.55, 0, 1);
        u42.Velocity = ((Vector3_new_ret2 - Position) * ((1 - math_clamp_ret) * 2) + (Position - u41 * 28 - Vector3_new_ret2) * (math_clamp_ret * 2)) / 0.55;
    end));
end;

function v1.sonic_homing_start(p45: any, p46: boolean?) -- Line: 328
end;

function v1.sonic_homing_trap(p47) -- Line: 331
end;

function v1.sonic_whirlwind_shot(u48, p49) -- Line: 334
    -- upvalues: vfxUtil (copy), trove (copy), RunService (copy), MoonPropertyAnimator (copy), playSpinDashAfterimages (copy)
    local Root = vfxUtil.getRoot(u48);

    if not Root then
        return;
    end;

    local Normal = vfxUtil.getResources().sonic["Whirlwind Shot"].Normal;
    local u50 = trove.new();
    u50:AttachToInstance(u48);
    local v51 = u50:Construct(Normal.Aura);
    vfxUtil.setupAura(u48, v51, true);
    v51.Parent = workspace.Effects;
    local u52 = u50:Clone(Normal.VFX);
    u52:PivotTo(u48:GetPivot());
    u52.Parent = workspace.Effects;
    local v53 = u50:Clone(Normal.SpinBALL);
    v53.Weld.Part1 = u48.Ball;
    v53.Parent = u48.Ball;
    u50:Add(RunService.PreRender:Connect(function() -- Line: 355
        -- upvalues: u52 (copy), u48 (copy)
        if u52 then
            u52:PivotTo(u48:GetPivot());
        end;
    end));
    local v54 = {
        TuffCharacterRig = u48,
        Folder = v51,
        SpeedEffects = v51.HumanoidRootPart,
        VFX = u52
    };
    local v55 = u50:Construct(MoonPropertyAnimator);
    v55:LoadAndConvertSave(Normal.Moon, v54);
    v55:SetOriginalRoot(CFrame.new(-100, 3, -7.875));
    v55:SetRoot(Root);
    v55:PlayAll();
    vfxUtil.execute_compiled(Normal.Compiled, u50, u52, u48, playSpinDashAfterimages, u50, v51);
    u50:Add(task.delay(p49, function() -- Line: 376
        -- upvalues: u50 (copy)
        u50:Destroy();
    end));
end;

function v1.sonic_eagle(p56) -- Line: 381
end;

local function peelout_screenFX(p57, p58, p59) -- Line: 385
    -- upvalues: vfxUtil (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy), mainreplication (copy)
    local Root = vfxUtil.getRoot(p57);

    if not Root then
        return;
    end;

    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    p59:Add(BlurEffect);
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v60 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v60.Parent = Lighting;
    v60.TintColor = Color3.fromRGB(0, 85, 255);
    v60.Brightness = 0.5;
    v60.Contrast = 0.5;
    v60.Saturation = -0.5;
    p59:Add(v60);
    TweenService:Create(v60, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v60, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(2, v60.Destroy, v60);
    mainreplication.fov(true, 90, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    task.delay(0.15, function() -- Line: 413
        -- upvalues: mainreplication (ref)
        mainreplication.fov(true, 70, 0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    end);
    p59:Add(mainreplication.rockFlakes(Root, p58));
end;

function v1.sonic_peelout_start(u61, p62, p63) -- Line: 421
    -- upvalues: vfxUtil (copy), trove (copy), animationUtil (copy), LocalPlayer (copy), Players (copy), mainreplication (copy), peelout_screenFX (copy), TweenService (copy), Debris (copy)
    local Root = vfxUtil.getRoot(u61);

    if not Root then
        return;
    end;

    local v64 = vfxUtil.getResources().sonic["Figure-8 Peelout"];
    local u65 = trove.new();
    u65:Add(u61:GetAttributeChangedSignal(p63):Connect(function() -- Line: 428
        -- upvalues: u65 (copy)
        u65:Destroy();
    end));
    local _, v66 = vfxUtil.buildFromRig(u61, v64.R6, u65);
    local NiaplixSonicRigFix = v66.NiaplixSonicRigFix;
    u65:Add(task.delay(0.3, function() -- Line: 437
        -- upvalues: NiaplixSonicRigFix (copy)
        for _, child in NiaplixSonicRigFix:GetChildren() do
            if child:IsA("MeshPart") then
                child.Transparency = 0;
            end;
        end;
    end));
    u65:Add(animationUtil:loadAnimation(NiaplixSonicRigFix, v64.Animations.Legs):Play(0), "Stop");
    u65:Add(task.delay(2.35, NiaplixSonicRigFix.Destroy, NiaplixSonicRigFix));

    if LocalPlayer == Players:GetPlayerFromCharacter(u61) then
        local u67 = p62 - 0.8;
        u65:Add(task.delay(0.8, function() -- Line: 451
            -- upvalues: mainreplication (ref), Root (copy), u67 (copy), peelout_screenFX (ref), u61 (copy), u65 (copy)
            mainreplication.bodyVelocity(Root, 320, u67, false, "LookVector");
            peelout_screenFX(u61, u67, u65);
        end));
    end;

    u65:Add(task.delay(0, function() -- Line: 463
        -- upvalues: u61 (copy), u65 (copy), TweenService (ref), Debris (ref)
        for _, v in { "Left Leg", "Right Leg" } do
            local v68 = u61:FindFirstChild(v);

            if v68 then
                local Highlight = Instance.new("Highlight");
                Highlight.FillColor = Color3.fromRGB(170, 0, 0);
                Highlight.OutlineColor = Highlight.FillColor;
                Highlight.FillTransparency = 1;
                Highlight.OutlineTransparency = 1;
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.Parent = v68;
                u65:Add(Highlight);
                TweenService:Create(Highlight, TweenInfo.new(2), {
                    FillTransparency = 0,
                    OutlineTransparency = 0
                }):Play();
                Debris:AddItem(Highlight, 2);
            end;
        end;
    end));
    vfxUtil.execute_compiled(v64.Compiled, u65, u61);
    u65:Add(task.delay(p62, function() -- Line: 490
        -- upvalues: u65 (copy)
        u65:Destroy();
    end));
end;

function v1.sonic_trick_action(p69: any, p70: vector?, p71: number?) -- Line: 495
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), Players (copy), mainreplication (copy)
    local Root = vfxUtil.getRoot(p69);

    if not Root or typeof(p70) ~= "Vector3" then
        return;
    end;

    local Vector3_new_ret = Vector3.new(p70.X, 0, p70.Z);

    if Vector3_new_ret.Magnitude < 0.05 or LocalPlayer ~= Players:GetPlayerFromCharacter(p69) then
        return;
    end;

    Root.CFrame = CFrame.new(Root.Position, Root.Position + Vector3_new_ret.Unit);
    mainreplication.bodyVelocity(Root, (p71 or 72) / 0.25, 0.25, true, "LookVector", nil, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));
end;

function v1.sonic_idleflow(p72: any, p73: userdata) -- Line: 524
    -- upvalues: vfxUtil (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p72);
    local BreakIn = vfxUtil.getResources().sonic.Flow.OT.BreakIn;
    local u74 = vfxUtil.character_trove(p72);
    local v75 = u74:Clone(BreakIn.VFX);
    v75:PivotTo(Root.CFrame);
    v75.Parent = workspace.Effects;
    local v76 = {
        Workspace = v75,
        Highlight = u74:Add(vfxUtil.highlight(p72, {
            Name = "Highlight",
            Enabled = true,
            FillTransparency = 1,
            OutlineTransparency = 0,
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
            FillColor = Color3.new(1, 0.717647076, 0),
            OutlineColor = Color3.new(1, 0.054901965, 0.384313762)
        }))
    };
    vfxUtil.execute_compiled(BreakIn.Compiled, u74, v75);
    local v77 = u74:Construct(MoonPropertyAnimator);
    v77:LoadAndConvertSave(BreakIn.Moon, v76);
    v77:SetOriginalRoot(CFrame.new(-100, 3, -7.875));
    v77:SetRoot(Root);
    v77:PlayAll();
    u74:Add(p73.Stopped:Connect(function() -- Line: 555
        -- upvalues: u74 (copy)
        u74:Destroy();
    end));
end;

function v1.sonic_steal_run(u78) -- Line: 561
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), Part_Icles (copy), TweenService (copy), ReplicatedStorage (copy), mainreplication (copy), RunService (copy), LocalPlayer (copy), Players (copy)
    local Root = vfxUtil.getRoot(u78);

    if not Root then
        return;
    end;

    local CFrame_new_ret = CFrame.new(-0.00062561, -0.86471, -3.30592, -1, 0, 0, 0, 0, -1, 0, -1, 0);
    local RunSequence = vfxUtil.getResources().sonic.Flow.Steal.RunSequence;
    local VFX = RunSequence.VFX;
    local u79 = trove.new();
    u79:AttachToInstance(u78);
    u79:Add(soundUtil:play(RunSequence.SFX, "default"));

    if VFX then
        local u80 = u79:Add(VFX:Clone());
        u80:PivotTo(Root.CFrame * CFrame_new_ret);
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = Root;
        WeldConstraint.Part1 = u80.Part;
        WeldConstraint.Parent = u80.Part;
        u80.Parent = workspace.Effects;
        Part_Icles:AbsoluteEnable(u80);
        u79:Add(function() -- Line: 589
            -- upvalues: Part_Icles (ref), u80 (copy)
            Part_Icles:AbsoluteDisable(u80);
        end);
    end;

    local u81 = u79:Add(Instance.new("NumberValue"));
    u81.Value = 40;
    TweenService:Create(u81, TweenInfo.new(0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 280
    }):Play();
    require(ReplicatedStorage.util.KatUtil).destroy_all_velocities(u78);
    local u82, u83 = mainreplication.bodyVelocity(Root, 280, 3, nil, nil, nil, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0));

    if typeof(u82) == "Instance" then
        u79:Add(u82);
    end;

    u79:Add(RunService.PreRender:Connect(function() -- Line: 604
        -- upvalues: u83 (copy), u82 (copy), Root (copy), u81 (copy)
        if u83 and u82 then
            u82.Velocity = Root.CFrame.LookVector * u81.Value;
        end;
    end));

    if LocalPlayer == Players:GetPlayerFromCharacter(u78) then
        mainreplication.fov(false, 40);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(20, 40);
    end;

    u79:Add(task.delay(2.8, function() -- Line: 616
        -- upvalues: TweenService (ref), u81 (copy)
        TweenService:Create(u81, TweenInfo.new(0.20000000000000018, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
    end));
    u79:Add(u78:GetAttributeChangedSignal("FlowActive"):Connect(function() -- Line: 620
        -- upvalues: u78 (copy), u79 (copy)
        if u78:GetAttribute("FlowActive") then
            u79:Destroy();
        end;
    end));
    u79:Add(task.delay(3, function() -- Line: 626
        -- upvalues: u79 (copy)
        u79:Destroy();
    end));
end;

function v1.sonic_steal_flow(u84: any, p85: number) -- Line: 631
    -- upvalues: vfxUtil (copy), mainreplication (copy), RunService (copy), Lighting (copy), soundUtil (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(u84);

    if not Root then
        return;
    end;

    local Steal = vfxUtil.getResources().sonic.Flow.Steal;
    local u86 = vfxUtil.character_trove(u84);
    mainreplication.sceneEnabled(true);
    u86:Add(function() -- Line: 642
        -- upvalues: mainreplication (ref), vfxUtil (ref)
        mainreplication.sceneEnabled(false);
        vfxUtil.restore_lighting_properties();
    end);
    vfxUtil.buildFromRig(u84, Steal.Rigs["1"], u86);
    local u87 = u86:Clone(Steal.VFX);
    u87:PivotTo(u84:GetPivot());
    u87.Parent = workspace.Effects;
    u86:Add(RunService.PreRender:Connect(function() -- Line: 653
        -- upvalues: u87 (copy), u84 (copy)
        if u87 then
            u87:PivotTo(u84:GetPivot());
        end;
    end));
    local v88, v89 = mainreplication.cutsceneBlender(Root, Steal.Animations.Cam, Steal["FOV_sonic bf"]);

    if v89 then
        u86:Add(v89);
    end;

    local v90 = {
        Lighting = Lighting,
        Workspace = u87,
        Vignette = u86:Add(vfxUtil.getMoonEffects()).Vignette
    };
    vfxUtil.cutscene_lighting(u86, v90, Steal.Lighting);
    vfxUtil.execute_compiled(Steal.Compiled, u86, u87, v88, u84, u84);
    soundUtil:play(Steal.SFX, "default");
    local v91 = u86:Construct(MoonPropertyAnimator);
    v91:LoadAndConvertSave(Steal.Moon, v90);
    v91:SetOriginalRoot(Steal.VFX:GetPivot());
    v91:SetRoot(Root);
    v91:PlayAll();
    u86:Add(task.delay(p85, function() -- Line: 687
        -- upvalues: u86 (copy)
        u86:Destroy();
    end));
end;

function v1.sonic_ot_flow(u92: any, p93: number) -- Line: 692
    -- upvalues: vfxUtil (copy), mainreplication (copy), animationUtil (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy), StyleData (copy)
    local Root = vfxUtil.getRoot(u92);
    local OT = vfxUtil.getResources().sonic.Flow.OT;
    local u94 = vfxUtil.character_trove(u92);
    mainreplication.sceneEnabled(true);
    u94:Add(function() -- Line: 699
        -- upvalues: mainreplication (ref), vfxUtil (ref)
        mainreplication.sceneEnabled(false);
        vfxUtil.restore_lighting_properties();
        vfxUtil.restore_lighting();
    end);
    local v95 = u94:Clone(OT.Models.Handle);
    v95.Parent = u92["Right Arm"];
    v95.Handle.Part0 = u92["Right Arm"];
    u94:Add(v95);
    local v96 = u94:Clone(OT.Models["Chaos Emeralds"]);
    v96.Parent = u92;
    v96["Emerald handle"].HumanoidRootPart.Part1 = Root;
    u94:Add(v96);
    animationUtil:loadAnimation(v96, OT.Animations.Emeralds):Play();
    local v97 = u94:Clone(OT.VFX.VFX);
    v97:PivotTo(Root.CFrame);
    v97.Parent = workspace.Effects;
    u94:Add(v97.CutsceneVFX).Parent = Root;
    local v98 = u94:Clone(OT.VFX.Transformed);
    v98.Parent = u92;

    for _, descendant in v98:GetDescendants() do
        if descendant:IsA("Weld") then
            descendant.Part1 = u92.Torso;
        end;
    end;

    local v99, v100 = mainreplication.cutsceneHumanoidCameraWithoutRootTerms(Root, OT.Animations.Camera, OT.FOV_STFLOW, OT.Parent.Parent["The Fastest"].Models.amera, CFrame.new(-0.5, -2.5, -3) * CFrame.Angles(0, 3.141592653589793, 0), "Torso");
    u94:Add(v100);
    soundUtil:play(OT.SFX.SFX, "default");
    local v101 = {
        Lighting = Lighting
    };
    vfxUtil.contain_lighting(u94, v101, OT.VFX.Lighting);
    vfxUtil.execute_compiled(OT.Compiled, u94, v97, u92, v99);
    local v102 = u94:Construct(MoonPropertyAnimator);
    v102:LoadAndConvertSave(OT.Moon, v101);
    v102:SetOriginalRoot(CFrame.new(-529.848, 3.009, 1206.263));
    v102:SetRoot(Root);
    v102:PlayAll();
    u94:Add(task.delay(0.2, function() -- Line: 759
        -- upvalues: TekrinnDialogue (ref), u92 (copy), StyleData (ref)
        TekrinnDialogue.Speak(u92, {
            {
                Text = "HA!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 1.35, StyleData.icon, StyleData.color);
    end));
    u94:Add(task.delay(1, function() -- Line: 785
        -- upvalues: TekrinnDialogue (ref), u92 (copy), StyleData (ref)
        TekrinnDialogue.Speak(u92, {
            {
                Text = "What a ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.07,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            },
            {
                Text = "JOKE!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.07,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 2, StyleData.icon, StyleData.color);
    end));
    u94:Add(task.delay(13.2, function() -- Line: 833
        -- upvalues: TekrinnDialogue (ref), u92 (copy), StyleData (ref)
        TekrinnDialogue.Speak(u92, {
            {
                Text = "HMPH!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.07,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 2, StyleData.awkiconot);
    end));
    u94:Add(task.delay(p93, function() -- Line: 859
        -- upvalues: u94 (copy)
        u94:Destroy();
    end));
end;

function v1.sonic_the_fastest(u103: any, p104: number) -- Line: 865
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(u103);

    if not Root then
        return;
    end;

    local v105 = vfxUtil.getResources().sonic["The Fastest"];
    local u106 = vfxUtil.character_trove(u103);
    mainreplication.sceneEnabled(true);
    u106:Add(function() -- Line: 876
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    vfxUtil.cutscene_ball(true);
    u106:Add(function() -- Line: 881
        -- upvalues: vfxUtil (ref)
        vfxUtil.cutscene_ball(false);
    end);
    local v107 = u106:Clone(v105.VFX.CutsceneVFX);
    v107.Parent = Root;
    v107.RunPast.Weld.Part0 = Root;
    local v108 = u106:Clone(v105.Models.Chilidoghandle);
    v108.Parent = u103["Left Arm"];
    u106:Add(v108.Chilidoghandle);
    v108.Chilidoghandle.Part0 = u103["Left Arm"];
    v108.Chilidoghandle.Parent = u103["Left Arm"];
    local v109, v110 = mainreplication.cutsceneHumanoidCameraWithoutRootTerms(Root, v105.Animations.Camera, v105.FOV, v105.Models.amera, CFrame.Angles(0, 3.141592653589793, 0), "Torso");
    u106:Add(v110);
    soundUtil:play(v105.SFX, "default");
    local v111 = {
        Workspace = v107,
        ["1"] = v107.BlitzBeams.Blitz1["1"],
        ["2"] = v107.BlitzBeams.Blitz2["2"],
        ["3"] = v107.BlitzBeams.Blitz3["3"]
    };
    vfxUtil.cutscene_lighting(u106, v111, v105.VFX.Lighting, {
        Ambient = Color3.fromRGB(187, 205, 217)
    });
    local v112 = u106:Construct(MoonPropertyAnimator);
    v112:LoadAndConvertSave(v105.Moon, v111);
    v112:SetOriginalRoot(CFrame.new(-476.995, 3.01, 1368.696));
    v112:SetRoot(Root);
    v112:PlayAll();
    vfxUtil.execute_compiled(v105.Compiled, u106, v107, v109);
    u106:Add(task.delay(2.9, function() -- Line: 932
        -- upvalues: TekrinnDialogue (ref), u103 (copy)
        TekrinnDialogue.Speak(u103, {
            {
                Text = "Come on, this is nothing!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 1.35);
    end));
    u106:Add(task.delay(15.5, function() -- Line: 958
        -- upvalues: TekrinnDialogue (ref), u103 (copy)
        TekrinnDialogue.Speak(u103, {
            {
                Text = "That was ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.07,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            },
            {
                Text = "TIGHT!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.07,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 2);
    end));
    u106:Add(task.delay(p104, function() -- Line: 1005
        -- upvalues: u106 (copy)
        u106:Destroy();
    end));
end;

function v1.sonic_s_rank(p113) -- Line: 1010
end;

function v1.sonic_awaken(p114: any, p115: number?) -- Line: 1013
end;

return v1;