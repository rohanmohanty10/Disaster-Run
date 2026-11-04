 

 

game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local u1 = require("@game/ReplicatedStorage/util/vfxUtil");
local u2 = require("@game/ReplicatedStorage/util/animationUtil");
local u3 = require("@game/ReplicatedStorage/client/replication/mainreplication");
local u4 = require("@game/ReplicatedStorage/util/MoonPropertyAnimator");
local u5 = require("@game/ReplicatedStorage/util/soundUtil");
local u6 = require("@game/ReplicatedStorage/util/Util");
local u7 = require("@game/ReplicatedStorage/client/replication/BackgroundHighlight");
local u8 = require("@game/ReplicatedStorage/client/replication/TekrinnDialogue");
local u9 = require("@game/ReplicatedStorage/mvputils/GlassShatter");
local u10 = require("@game/ReplicatedStorage/mvputils/highlight_emit");
local v11 = {};
local u12 = {};

local function buildRuntimeHighlight(p13: userdata, p14: any) -- Line: 24
    -- upvalues: u1 (copy)
    local _aizenHighlightProperties = p13:FindFirstChild("_aizenHighlightProperties");
    local v15;

    if _aizenHighlightProperties then
        v15 = _aizenHighlightProperties:IsA("Configuration");
    else
        v15 = _aizenHighlightProperties;
    end;

    assert(v15, "Missing Aizen Highlight properties");
    local Attributes = _aizenHighlightProperties:GetAttributes();
    Attributes.Name = p13.Name;
    Attributes.DepthMode = Enum.HighlightDepthMode[Attributes.DepthMode];
    local Adornee = _aizenHighlightProperties:FindFirstChild("Adornee");

    if Adornee then
        Attributes.Adornee = Adornee.Value;
    end;

    local v16 = p14:Add(u1.highlight(p13.Parent, Attributes));

    for i, v in p13:GetAttributes() do
        v16:SetAttribute(i, v);
    end;

    for _, v in p13:GetTags() do
        v16:AddTag(v);
    end;

    for _, child in p13:GetChildren() do
        if child ~= _aizenHighlightProperties then
            child.Parent = v16;
        end;
    end;

    p13:Destroy();

    return v16;
end;

local function buildRuntimeHighlights(p17: userdata, p18: any) -- Line: 53
    -- upvalues: buildRuntimeHighlight (copy)
    if p17:IsA("Folder") and p17:FindFirstChild("_aizenHighlightProperties") then
        p17 = buildRuntimeHighlight(p17, p18);
    end;

    for _, descendant in p17:GetDescendants() do
        if descendant:IsA("Folder") and descendant:FindFirstChild("_aizenHighlightProperties") then
            buildRuntimeHighlight(descendant, p18);
        end;
    end;

    return p17;
end;

local function cloneRuntimeEffect(p19: any, p20: userdata) -- Line: 67
    -- upvalues: buildRuntimeHighlights (copy)
    return buildRuntimeHighlights(p19:Clone(p20), p19);
end;

local function buildRuntimeRig(p21: any, p22: userdata) -- Line: 71
    -- upvalues: u1 (copy), buildRuntimeHighlights (copy)
    local v23, v24 = u1.buildFromRig(p21, p22);

    for i, v in v24 do
        v24[i] = buildRuntimeHighlights(v, v23);
    end;

    return v23, v24;
end;

local function deception_swap_flash(p25) -- Line: 80
    -- upvalues: Players (copy), Lighting (copy), TweenService (copy)
    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(p25) then
        return;
    end;

    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(147, 51, 234);
    ColorCorrectionEffect.Saturation = 0.1;
    ColorCorrectionEffect.Contrast = 0.35;
    ColorCorrectionEffect.Parent = Lighting;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 18;
    BlurEffect.Parent = Lighting;
    local TweenInfo_new_ret = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    TweenService:Create(ColorCorrectionEffect, TweenInfo_new_ret, {
        Contrast = 0,
        TintColor = Color3.new(1, 1, 1)
    }):Play();
    TweenService:Create(BlurEffect, TweenInfo_new_ret, {
        Size = 0
    }):Play();
    task.delay(TweenInfo_new_ret.Time, function() -- Line: 99
        -- upvalues: ColorCorrectionEffect (copy), BlurEffect (copy)
        ColorCorrectionEffect:Destroy();
        BlurEffect:Destroy();
    end);
end;

local function invisible(p26, p27) -- Line: 105
    if not p27 then
        if p26:GetAttribute("Invisible") then
            return false;
        end;

        p26:SetAttribute("Invisible", true);
        local v28 = {};

        for _, descendant in p26:GetDescendants() do
            if descendant:IsA("BasePart") then
                table.insert(v28, {
                    Instance = descendant,
                    OriginalTransparency = descendant.Transparency
                });
                descendant.Transparency = 1;
            elseif descendant:IsA("SurfaceGui") then
                table.insert(v28, {
                    Instance = descendant,
                    OriginalEnabled = descendant.Enabled
                });
                descendant.Enabled = false;
            elseif descendant:IsA("ParticleEmitter") and descendant:FindFirstAncestorWhichIsA("Accessory") then
                table.insert(v28, {
                    Instance = descendant,
                    OriginalEnabled = descendant.Enabled
                });
                descendant.Enabled = false;
            end;
        end;

        return v28;
    end;

    for _, v in p27 do
        if v.Instance:IsA("SurfaceGui") or v.Instance:IsA("ParticleEmitter") then
            v.Instance.Enabled = v.OriginalEnabled;
        else
            v.Instance.Transparency = v.OriginalTransparency;
        end;
    end;

    p26:SetAttribute("Invisible", nil);
end;

local function attach_dash_vfx(p29: any, p30: any, p31: number, u32: boolean) -- Line: 156
    local u33 = {};

    for _, v in { "Left Arm", "Right Arm", "Left Leg", "Right Leg" } do
        local v34 = p29:FindFirstChild(v);

        if v34 then
            local v35 = p30.TrailAtt:Clone();
            v35.Parent = v34;
            local v36 = v35:FindFirstChildWhichIsA("Trail");

            if v36 then
                v36.Enabled = true;
            end;

            table.insert(u33, v35);
        end;
    end;

    local Torso = p29:FindFirstChild("Torso");
    local u37;

    if Torso and u32 then
        u37 = p30.SpeedLinesAtt:Clone();
        u37.Parent = Torso;
        local speedlines = u37:FindFirstChild("speedlines");

        if speedlines and speedlines:IsA("ParticleEmitter") then
            speedlines.Enabled = true;
        end;
    else
        u37 = nil;
    end;

    task.delay(p31, function() -- Line: 190
        -- upvalues: u33 (copy), u37 (ref), u32 (copy)
        for _, v in u33 do
            local v38 = v:FindFirstChildWhichIsA("Trail");

            if v38 then
                v38.Enabled = false;
            end;
        end;

        if u37 and u32 then
            local speedlines = u37:FindFirstChild("speedlines");

            if speedlines and speedlines:IsA("ParticleEmitter") then
                speedlines.Enabled = false;
            end;
        end;

        task.delay(0.5, function() -- Line: 205
            -- upvalues: u33 (ref), u37 (ref), u32 (ref)
            for _, v in u33 do
                pcall(v.Destroy, v);
            end;

            if u37 and u32 then
                pcall(u37.Destroy, u37);
            end;
        end);
    end);
end;

function v11.aizen_shatter(p39: any, p40: any, p41: boolean?) -- Line: 216
    -- upvalues: u1 (copy), u5 (copy), deception_swap_flash (copy), attach_dash_vfx (copy), u2 (copy), buildRuntimeHighlights (copy), RunService (copy), Lighting (copy), u3 (copy)
    if p41 then
        local v42 = u1.getResources().aizen.Shatter["On-Ball"];
        local Root = u1.getRoot(p39);
        attach_dash_vfx(p39, v42, 3, true);
        local u43 = u1.character_trove(p39);
        u2:loadAnimation(p39, v42.FirstUse):Play(0);
        u5:play(v42.FirstUseSFX, Root);
        local v44 = buildRuntimeHighlights(u43:Clone(v42.dribble2), u43);
        v44.Parent = workspace.Effects;
        local HumanoidRootPart = v42.KJ.HumanoidRootPart;
        local u45 = {};

        for _, child in v44:GetChildren() do
            if child:IsA("BasePart") then
                local v46 = {
                    part = child,
                    offset = HumanoidRootPart.CFrame:ToObjectSpace(child.CFrame)
                };
                table.insert(u45, v46);
            end;
        end;

        local u47 = nil;
        u47 = RunService.RenderStepped:Connect(function() -- Line: 258
            -- upvalues: Root (copy), u47 (ref), u45 (copy)
            if not (Root and Root:IsDescendantOf(game)) then
                u47:Disconnect();

                return;
            end;

            local CFrame2 = Root.CFrame;

            for _, v in u45 do
                v.part.CFrame = CFrame2 * v.offset;
            end;
        end);
        u43:Add(function() -- Line: 268
            -- upvalues: u47 (ref)
            u47:Disconnect();
        end);
        buildRuntimeHighlights(u43:Clone(v42.purple1), u43).Parent = Lighting;
        buildRuntimeHighlights(u43:Clone(v42.Highlight), u43).Parent = p39;
        u1.execute_compiled(v42.Compiled2, u43, {
            KJ = p39,
            dribble2 = v44
        });
        u3.destroyVelocity(Root);
        local CFrame2 = Root.CFrame;
        local _ = CFrame2.LookVector;
        local _ = CFrame2.RightVector;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Parent = Root;
        local u48 = { {
                type = "hold",
                duration = 0.05
            }, {
                type = "dash",
                duration = 0.64,
                forward_dist = 30,
                right_dist = 18
            }, {
                type = "hold",
                duration = 0.05
            }, {
                type = "dash",
                duration = 0.8,
                forward_dist = 28.5,
                right_dist = -35.5
            }, {
                type = "hold",
                duration = 0.05
            }, {
                type = "dash",
                duration = 0.55,
                forward_dist = 37,
                right_dist = 21.5
            }, {
                type = "hold",
                duration = 0.1
            }, {
                type = "dash",
                duration = 0.35,
                forward_dist = 27,
                right_dist = -4
            } };
        local u49 = 1;
        local u50 = 0;
        local u51 = nil;
        u51 = RunService.RenderStepped:Connect(function(p52) -- Line: 306
            -- upvalues: BodyVelocity (copy), u51 (ref), u48 (copy), u49 (ref), u50 (ref), Root (copy)
            if not (BodyVelocity and BodyVelocity:IsDescendantOf(game)) then
                u51:Disconnect();

                return;
            end;

            local v53 = u48[u49];

            if not v53 then
                BodyVelocity.Velocity = Vector3.new(0, 0, 0);
                u51:Disconnect();

                return;
            end;

            u50 = u50 + p52;
            BodyVelocity.Velocity = BodyVelocity.Velocity:Lerp(v53.type == "hold" and Vector3.new(0, 0, 0) or Root.CFrame.LookVector * (v53.forward_dist / v53.duration) + Root.CFrame.RightVector * (v53.right_dist / v53.duration), (math.clamp(p52 / 0.11, 0, 1)));

            if u50 >= v53.duration then
                u50 = 0;
                u49 = u49 + 1;
            end;
        end);
        task.delay(2.45, function() -- Line: 340
            -- upvalues: u43 (copy), u51 (ref), BodyVelocity (copy)
            u43:Add(task.delay(2.45, u43.Destroy, u43));
            u51:Disconnect();
            pcall(BodyVelocity.Destroy, BodyVelocity);
        end);
    else
        local v54 = u1.getResources().aizen.Shatter["Off-Ball"];
        local v55 = p39:FindFirstChild("Torso") or u1.getRoot(p39);
        u1.quickVFX(v54.chestwind, v55);
        u1.quickVFX(v54.groundwind, v55);
        u5:play(v54.SFX, v55);
        deception_swap_flash(p39);

        if p40 then
            local v56 = p40:FindFirstChild("Torso") or u1.getRoot(p40);
            u1.quickVFX(v54.chestwind, v56);
            u1.quickVFX(v54.groundwind, v56);
            u5:play(v54.SFX, v56);
            deception_swap_flash(p40);
        end;
    end;
end;

function v11.aizen_shatter_second(p57, p58) -- Line: 348
    -- upvalues: u1 (copy), attach_dash_vfx (copy), u2 (copy), u5 (copy), buildRuntimeHighlights (copy), RunService (copy), Lighting (copy), u3 (copy)
    local v59 = u1.getResources().aizen.Shatter["On-Ball"];
    local Root = u1.getRoot(p57);
    attach_dash_vfx(p57, v59, 1, true);
    u2:loadAnimation(p57, v59.SecondUse):Play(0);
    u5:play(v59.SecondUseSFX, Root);
    local u60 = u1.character_trove(p57);
    local v61 = buildRuntimeHighlights(u60:Clone(v59.dribble1), u60);
    v61.Parent = workspace.Effects;
    local HumanoidRootPart = v59.KJ.HumanoidRootPart;
    local u62 = {};

    for _, child in v61:GetChildren() do
        if child:IsA("BasePart") then
            local v63 = {
                part = child,
                offset = HumanoidRootPart.CFrame:ToObjectSpace(child.CFrame)
            };
            table.insert(u62, v63);
        end;
    end;

    local u64 = nil;
    u64 = RunService.RenderStepped:Connect(function() -- Line: 374
        -- upvalues: Root (copy), u64 (ref), u62 (copy)
        if not (Root and Root:IsDescendantOf(game)) then
            u64:Disconnect();

            return;
        end;

        local CFrame2 = Root.CFrame;

        for _, v in u62 do
            v.part.CFrame = CFrame2 * v.offset;
        end;
    end);
    u60:Add(function() -- Line: 384
        -- upvalues: u64 (ref)
        u64:Disconnect();
    end);
    buildRuntimeHighlights(u60:Clone(v59.purple1), u60).Parent = Lighting;
    buildRuntimeHighlights(u60:Clone(v59.Highlight), u60).Parent = p57;
    u1.execute_compiled(v59.Compiled, u60, {
        KJ = p57,
        dribble1 = v61
    });
    u3.destroyVelocity(Root);
    local CFrame2 = Root.CFrame;
    local _ = CFrame2.LookVector;
    local _ = CFrame2.RightVector;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Parent = Root;
    local u65 = 0;
    local u66 = nil;
    u66 = RunService.RenderStepped:Connect(function(p67) -- Line: 415
        -- upvalues: BodyVelocity (copy), u66 (ref), u65 (ref), Root (copy)
        if not (BodyVelocity and BodyVelocity:IsDescendantOf(game)) then
            u66:Disconnect();

            return;
        end;

        u65 = u65 + p67;

        if u65 >= 1.29 then
            BodyVelocity.Velocity = BodyVelocity.Velocity:Lerp(Vector3.new(0, 0, 0), (math.clamp(p67 / 0.15, 0, 1)));

            return;
        end;

        local LookVector = Root.CFrame.LookVector;
        local RightVector = Root.CFrame.RightVector;
        local math_sin_ret = math.sin(u65 / 1.29 * 3.141592653589793 * 5.5);
        BodyVelocity.Velocity = BodyVelocity.Velocity:Lerp(LookVector * 55 + RightVector * math_sin_ret * 14, (math.clamp(p67 / 0.1, 0, 1)));
    end);
    task.delay(1.65, function() -- Line: 437
        -- upvalues: u60 (copy), u66 (ref), BodyVelocity (copy)
        u60:Add(task.delay(2.45, u60.Destroy, u60));
        u66:Disconnect();
        pcall(BodyVelocity.Destroy, BodyVelocity);
    end);
end;

function v11.aizen_kyoka(p68, p69) -- Line: 444
    -- upvalues: u1 (copy), u5 (copy), buildRuntimeHighlights (copy), TweenService (copy)
    local KyokaSuigetsu = u1.getResources().aizen.KyokaSuigetsu;
    local Root = u1.getRoot(p68);
    local v70 = u1.character_trove(p68);
    u5:play(KyokaSuigetsu.StartSFX, Root);
    local v71 = buildRuntimeHighlights(v70:Clone(KyokaSuigetsu.StartLight), v70);
    v71.Parent = p68;
    v71.FillTransparency = 0.5;
    v71.OutlineTransparency = 0;
    TweenService:Create(v71, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FillTransparency = 1
    }):Play();
    TweenService:Create(v71, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        OutlineTransparency = 1
    }):Play();
    v70:Add(task.delay(1, v70.Destroy, v70));
end;

function v11.aizen_kyoka_end(p72) -- Line: 467
    -- upvalues: u1 (copy), u5 (copy)
    local KyokaSuigetsu = u1.getResources().aizen.KyokaSuigetsu;
    local Root = u1.getRoot(p72);
    u5:play(KyokaSuigetsu.EndSFX, Root);
    u1.quickVFX(KyokaSuigetsu.EndEffect, Root);
end;

function v11.aizen_goryu_feint(p73) -- Line: 474
    -- upvalues: u1 (copy), u2 (copy), u5 (copy), buildRuntimeHighlights (copy)
    local v74 = u1.getResources().aizen.Goryutenmetsu["On-Ball"];
    local Root = u1.getRoot(p73);
    local v75 = u1.character_trove(p73);
    u2:loadAnimation(p73, v74.Feint):Play(0);
    u5:play(v74.FeintShotSFX, Root);
    local HumanoidRootPart = v74.FeintFolder.Template.HumanoidRootPart;
    local Torso = v74.FeintFolder.Template.Torso;
    local v76 = buildRuntimeHighlights(v75:Clone(Torso), v75);
    v76.Parent = workspace.Effects;
    v76.CanCollide = false;
    v76.Massless = true;
    local v77 = HumanoidRootPart.CFrame:ToObjectSpace(Torso.CFrame);
    local Weld = Instance.new("Weld");
    Weld.Part0 = Root;
    Weld.Part1 = v76;
    Weld.C0 = v77;
    Weld.Parent = v76;
    local Feint = v74.FeintFolder.Template["azl ballllllls_rig"].Ball.Feint;
    local Ball = p73:FindFirstChild("Ball");
    local v78;

    if Ball then
        v78 = buildRuntimeHighlights(v75:Clone(Feint), v75);
        v78.Parent = Ball;
    else
        v78 = nil;
    end;

    u1.execute_compiled(v74.CompiledFeint, v75, {
        Torso = v76,
        Ball = {
            Feint = v78
        }
    });
    v75:Add(task.delay(1, v75.Destroy, v75));
end;

function v11.aizen_goryu_onball(u79) -- Line: 521
    -- upvalues: u1 (copy), u12 (copy), u2 (copy), u5 (copy), buildRuntimeHighlights (copy), RunService (copy)
    local v80 = u1.getResources().aizen.Goryutenmetsu["On-Ball"];
    local Root = u1.getRoot(u79);
    local u81 = u1.character_trove(u79);
    u12[u79] = u81;
    u81:Add(function() -- Line: 527
        -- upvalues: u12 (ref), u79 (copy), u81 (copy)
        if u12[u79] == u81 then
            u12[u79] = nil;
        end;
    end);
    local u82 = u2:loadAnimation(u79, v80.Curve);
    u82:Play(0);
    u81:Add(function() -- Line: 535
        -- upvalues: u82 (copy)
        u82:Stop();
    end);
    local u83 = u5:play(v80.CurveSFX, Root);

    if u83 then
        u81:Add(function() -- Line: 539
            -- upvalues: u83 (copy)
            u83:Stop();
        end);
    end;

    local v84 = buildRuntimeHighlights(u81:Clone(v80.CurveVFX), u81);
    v84.Parent = workspace.Effects;
    local HumanoidRootPart = v80.Template.HumanoidRootPart;
    local u85 = {};

    for _, descendant in v84:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.Anchored = true;
            local v86 = {
                part = descendant,
                offset = HumanoidRootPart.CFrame:ToObjectSpace(descendant.CFrame)
            };
            table.insert(u85, v86);
        end;
    end;

    local u87 = nil;
    u87 = RunService.RenderStepped:Connect(function() -- Line: 559
        -- upvalues: Root (copy), u87 (ref), u85 (copy)
        if not (Root and Root:IsDescendantOf(game)) then
            u87:Disconnect();

            return;
        end;

        local CFrame2 = Root.CFrame;

        for _, v in u85 do
            v.part.CFrame = CFrame2 * v.offset;
        end;
    end);
    u81:Add(function() -- Line: 570
        -- upvalues: u87 (ref)
        u87:Disconnect();
    end);
    u1.execute_compiled(v80.Compiled, u81, v84);
    u81:Add(task.delay(1.5, u81.Destroy, u81));
end;

function v11.aizen_goryu_windup_cancel(p88) -- Line: 578
    -- upvalues: u12 (copy)
    local v89 = u12[p88];

    if v89 then
        v89:Destroy();
    end;
end;

local u90 = {};
local u91 = {};

function v11.aizen_goryu_volley_windup(u92, p93) -- Line: 587
    -- upvalues: u1 (copy), u90 (copy), buildRuntimeHighlights (copy), RunService (copy), u91 (copy)
    if p93 ~= nil then
        local v94 = u90[u92];

        if not v94 then
            return;
        end;

        if p93 then
            local v95 = u91[u92];

            if v95 and v95.volleyshot then
                u1.forge.emit(v95.volleyshot);

                return;
            end;
        else
            v94:Destroy();
        end;

        return;
    end;

    local v96 = u1.getResources().aizen.Goryutenmetsu["Off-Ball"];
    local Root = u1.getRoot(u92);
    local u97 = u1.character_trove(u92);
    u90[u92] = u97;
    u97:Add(function() -- Line: 594
        -- upvalues: u90 (ref), u92 (copy), u97 (copy)
        if u90[u92] == u97 then
            u90[u92] = nil;
        end;
    end);
    local v98 = buildRuntimeHighlights(u97:Clone(v96.VolleyVFX), u97);
    v98.Parent = workspace.Effects;
    local HumanoidRootPart = v96.Template.HumanoidRootPart;
    local u99 = {};

    for _, descendant in v98:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            local v100 = {
                part = descendant,
                offset = HumanoidRootPart.CFrame:ToObjectSpace(descendant.CFrame)
            };
            table.insert(u99, v100);
        end;
    end;

    local u101 = nil;
    u101 = RunService.RenderStepped:Connect(function() -- Line: 618
        -- upvalues: Root (copy), u101 (ref), u99 (copy)
        if not (Root and Root:IsDescendantOf(game)) then
            u101:Disconnect();

            return;
        end;

        local CFrame2 = Root.CFrame;

        for _, v in u99 do
            v.part.CFrame = CFrame2 * v.offset;
        end;
    end);
    u97:Add(function() -- Line: 627
        -- upvalues: u101 (ref)
        u101:Disconnect();
    end);
    local v102 = {
        wind = v98.wind,
        windup = v98.windup,
        volleyshot = v98.volleyshot
    };
    u91[u92] = v102;
    u97:Add(function() -- Line: 635
        -- upvalues: u90 (ref), u92 (copy), u97 (copy), u91 (ref)
        if u90[u92] == u97 then
            u90[u92] = nil;
        end;

        if u91[u92] then
            u91[u92] = nil;
        end;
    end);
    u1.execute_compiled(v96.CompiledVolley, u97, v102);
    u97:Add(task.delay(2, u97.Destroy, u97));
end;

function v11.aizen_goryu_onball_shot(p103) -- Line: 662
end;

function v11.aizen_goryu_offball_dash(p104) -- Line: 665
end;

function v11.aizen_goryu_offball_pass(p105: any, p106: any, p107: table?) -- Line: 668
end;

function v11.aizen_illusion_onball_windup(p108: any, p109: string) -- Line: 675
    -- upvalues: u1 (copy), buildRuntimeHighlights (copy), u10 (copy), u9 (copy)
    local aizen = u1.getResources().aizen;
    u1.getRoot(p108);
    local u110 = u1.character_trove(p108);
    local v111 = buildRuntimeHighlights(u110:Clone(aizen.IllusionaryPresences["On-Ball"].Steal.Sword), u110);
    v111.Parent = p108["Right Arm"];
    local v112 = u110:Add(v111.Sword);
    v112.Parent = p108["Right Arm"];
    v112.Part0 = p108["Right Arm"];
    u10.tweenHighlight(p108, Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255), 1, Enum.HighlightDepthMode.Occluded, "In", -0.5);
    u9.Play();
    u110:Add(p108:GetAttributeChangedSignal(p109):Once(function() -- Line: 698
        -- upvalues: u110 (copy)
        u110:Destroy();
    end));
end;

function v11.aizen_illusion_onball_counter(p113, p114) -- Line: 703
end;

function v11.aizen_illusion_offball(u115: any, p116: number?, u117: string?) -- Line: 706
    -- upvalues: u1 (copy), invisible (copy), buildRuntimeHighlights (copy), u7 (copy)
    if not u115:GetAttribute(u117) then
        return;
    end;

    local aizen = u1.getResources().aizen;
    u1.getRoot(u115);
    local u118 = u1.character_trove(u115);
    local u119 = invisible(u115);

    for _, child in buildRuntimeHighlights(u118:Clone(aizen.IllusionaryPresences["Off-Ball"].VFX), u118):GetChildren() do
        local v120 = u118:Add(child);
        v120.Parent = u115.Torso;
        shared.vfx.emit(v120);
    end;

    u7({
        Speed = 0.3,
        CFrames = true,
        Brightness = 1,
        countSpeed = 0.05,
        ImageTransparency = 0.8,
        Count = 107,
        StopAttribute = "AizenIllusionFlashstep",
        Whitelist = { u115 },
        Color = Color3.fromRGB(0, 0, 0),
        Color2 = Color3.fromRGB(0, 0, 0)
    });
    u118:Add(u115:GetAttributeChangedSignal(u117):Connect(function() -- Line: 736
        -- upvalues: u115 (copy), u117 (copy), u119 (copy), invisible (ref), u118 (copy)
        if u115:GetAttribute(u117) then
            return;
        end;

        if u119 then
            invisible(u115, u119);
        end;

        u118:Destroy();
    end));
    u118:Add(task.delay(p116, function() -- Line: 747
        -- upvalues: u119 (copy), invisible (ref), u115 (copy), u118 (copy)
        if u119 then
            invisible(u115, u119);
        end;

        u118:Destroy();
    end));
end;

function v11.whyistheballairborneandwhyisaizenstealingit(u121: any, u122: any, p123: number?) -- Line: 755
    -- upvalues: u1 (copy), u3 (copy), buildRuntimeHighlights (copy), u5 (copy), Lighting (copy), u4 (copy), u8 (copy)
    local Air = u1.getResources().aizen.IllusionaryPresences["Off-Ball"].Flow.Air;
    local Root = u1.getRoot(u121);
    local u124 = u1.character_trove(u121);
    u3.sceneEnabled(true);
    u124:Add(function() -- Line: 762
        -- upvalues: u3 (ref), u1 (ref)
        u3.sceneEnabled(false);
        u1.cutscene_ball(false);
    end);
    u1.cutscene_invisiball(u121, u124);
    u1.cutscene_ball(true);
    local v125, v126 = u1.buildFromRig(u121, Air.TuffCharacterRig);

    for i, v in v126 do
        v126[i] = buildRuntimeHighlights(v, v125);
    end;

    u124:Add(v125, "Destroy");
    u124:Add(u5:play(Air.SFX, "default"));
    local v127 = buildRuntimeHighlights(u124:Clone(Air.Ball), u124);
    v127.Parent = u121;
    v127.ball.Part0 = Root;
    local v128 = buildRuntimeHighlights(u124:Clone(Air.VFX), u124);
    v128:PivotTo(Root.CFrame);
    v128.Parent = workspace.Effects;
    local v129, v130 = u3.cutsceneCamRigWithLetterBox(Root, Air.Animations.Cam, Air.FOV_ASA, nil, nil, Air.CamRig, "Camera");
    u124:Add(v130);
    local v131 = {
        Lighting = Lighting,
        Vignette = u124:Add(u1.getMoonEffects()).Vignette,
        Workspace = v128
    };
    u1.cutscene_lighting(u124, v131, Air.Lighting, {
        ClockTime = 14.5,
        GeographicLatitude = 35.18,
        ExposureCompensation = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    local v132 = u124:Construct(u4);
    v132:LoadAndConvertSave(Air.Moon, v131);
    v132:SetOriginalRoot(Air.VFX.PrimaryPart.CFrame);
    v132:SetRoot(Root);
    v132:PlayAll();
    u1.execute_compiled(Air.Compiled, u124, v128, v129, v127);
    u124:Add(task.delay(p123, u124.Destroy, u124));
    u124:Add(task.delay(1.19, function() -- Line: 817
        -- upvalues: u124 (copy), u8 (ref), u122 (copy)
        u124:Add(u8.Speak(u122, {
            {
                Text = "There.",
                TypeSpeed = 0.04,
                Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 90, 90))
            }
        }, 4));
    end));
    u124:Add(task.delay(4.63, function() -- Line: 827
        -- upvalues: u124 (copy), u8 (ref), u122 (copy)
        u124:Add(u8.Speak(u122, {
            {
                Text = "What!?",
                Bold = true,
                TypeSpeed = 0.025,
                Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 50, 50)),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 4));
    end));
    u124:Add(task.delay(5.81, function() -- Line: 843
        -- upvalues: u124 (copy), u8 (ref), u121 (copy)
        u124:add(u8.Speak(u121, {
            {
                Text = "You\'re Weak.",
                Bold = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new(Color3.fromRGB(180, 120, 255), Color3.fromRGB(255, 255, 255))
            }
        }, 4));
    end));
    u124:Add(task.delay(12.89, function() -- Line: 854
        -- upvalues: u124 (copy), u8 (ref), u121 (copy)
        u124:Add(u8.Speak(u121, {
            {
                Text = "How ridiculous.",
                TypeSpeed = 0.045,
                Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 80, 255))
            }
        }));
    end));
end;

function v11.aizenstolemyfrickingballfromtheground(u133: any, p134: any, p135: number?) -- Line: 865
    -- upvalues: u1 (copy), u3 (copy), buildRuntimeHighlights (copy), u5 (copy), RunService (copy), Lighting (copy), u4 (copy), u8 (copy)
    local Ground = u1.getResources().aizen.IllusionaryPresences["Off-Ball"].Flow.Ground;
    local Root = u1.getRoot(u133);
    local u136 = u1.character_trove(u133);
    u3.sceneEnabled(true);
    u136:Add(function() -- Line: 871
        -- upvalues: u3 (ref)
        u3.sceneEnabled(false);
    end);
    local _baseplate_controller, u137 = u1.get_baseplate_controller();
    u136:Add(task.delay(11.883333333333333, function() -- Line: 877
        -- upvalues: u137 (copy), _baseplate_controller (copy)
        u137.Transparency = 1;
        _baseplate_controller.update();
    end));
    u136:Add(function() -- Line: 882
        -- upvalues: u137 (copy), _baseplate_controller (copy)
        u137.Transparency = 0;
        _baseplate_controller.update();
    end);
    u1.cutscene_invisiball(u133, u136);
    local v138, v139 = u1.buildFromRig(u133, Ground.AizenMan);

    for i, v in v139 do
        v139[i] = buildRuntimeHighlights(v, v138);
    end;

    u136:Add(v138, "Destroy");
    u136:Add(u5:play(Ground.SFX, "default"));
    local u140 = buildRuntimeHighlights(u136:Clone(Ground.VFX), u136);
    u140:PivotTo(Root.CFrame);
    u140.Parent = workspace.Effects;
    u136:Add(RunService.PreRender:Connect(function() -- Line: 895
        -- upvalues: u140 (copy), Root (copy)
        if u140 and Root then
            u140:PivotTo(Root.CFrame);
        end;
    end));
    local v141 = u136:Add(u1.highlight(u133, {
        Name = "Highlight",
        Enabled = false,
        FillTransparency = -10,
        OutlineTransparency = -50,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        FillColor = Color3.new(0.0980392173, 0.0862745121, 0.403921574),
        OutlineColor = Color3.new(0.250980407, 0.223529413, 1)
    }));
    u136:Add(u140.DIEE).Parent = p134.Torso;
    local v142, _ = u3.cutsceneBlender(Root, Ground.Animations.Cam, Ground.FOV_WhatIsReason, nil, nil, nil, Ground.Camera);
    local v143 = {
        Lighting = Lighting,
        Vignette = u136:Add(u1.getMoonEffects()).Vignette,
        Workspace = u140,
        Highlight = v141
    };
    u1.cutscene_lighting(u136, v143, Ground.Lighting, {
        ClockTime = 4,
        GeographicLatitude = 32.323,
        ExposureCompensation = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    local v144 = u136:Construct(u4);
    v144:LoadAndConvertSave(Ground.Moon, v143);
    v144:SetOriginalRoot(Ground.VFX.PrimaryPart.CFrame);
    v144:SetRoot(Root);
    v144:PlayAll();
    u1.execute_compiled(Ground.Compiled, u136, u140, v142, u133, p134);
    local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(175, 110, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) });
    u136:Add(task.delay(0.25, function() -- Line: 954
        -- upvalues: u136 (copy), u8 (ref), u133 (copy), ColorSequence_new_ret (copy)
        u136:Add(u8.Speak(u133, {
            {
                Text = "What is reason..?",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.055,
                Color = ColorSequence_new_ret,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 0.4
                }
            }
        }));
    end));
    u136:Add(task.delay(2.3, function() -- Line: 976
        -- upvalues: u136 (copy), u8 (ref), u133 (copy), ColorSequence_new_ret (copy)
        u136:Add(u8.Speak(u133, {
            {
                Text = "Reason is nothing but a shield ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "for those who cower behind it.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence_new_ret,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 0.8
                }
            }
        }));
    end));
    u136:Add(task.delay(7.55, function() -- Line: 1016
        -- upvalues: u136 (copy), u8 (ref), u133 (copy), ColorSequence_new_ret (copy)
        u136:Add(u8.Speak(u133, {
            {
                Text = "Now, shall we..",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.065,
                Color = ColorSequence_new_ret,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 0.5
                }
            }
        }));
    end));
    u136:Add(task.delay(10.1, function() -- Line: 1038
        -- upvalues: u136 (copy), u8 (ref), u133 (copy)
        u136:Add(u8.Speak(u133, {
            {
                Text = "..Surpass the limitation ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.045,
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "of mere reason.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.055,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 65, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1.2
                }
            }
        }));
    end));
    u136:Add(task.delay(p135, u136.Destroy, u136));
end;

function v11.aizen_illusion_steal(p145: any, p146: any, p147: number?) -- Line: 1086
    -- upvalues: u1 (copy), buildRuntimeHighlights (copy), u4 (copy)
    local Steal = u1.getResources().aizen.IllusionaryPresences["Off-Ball"].Steal;
    local Root = u1.getRoot(p145);
    local v148 = u1.character_trove(p145);
    local v149, v150 = u1.buildFromRig(p145, Steal.TempMan);

    for i, v in v150 do
        v150[i] = buildRuntimeHighlights(v, v149);
    end;

    local v151 = v148:Add(v149, "Destroy");
    u1.cutscene_invisiball(p145, v151);
    local v152 = buildRuntimeHighlights(v148:Clone(Steal.VFX), v148);
    v152:PivotTo(Root.CFrame);
    v152.Parent = workspace.Effects;
    local v153 = v148:Add(u1.highlight(p146, {
        Name = "shadowed",
        Enabled = true,
        FillTransparency = 0,
        OutlineTransparency = 1,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = Color3.new(0, 0, 0),
        OutlineColor = Color3.new(0.850980461, 0.43921572, 1)
    }));
    u1.execute_compiled(Steal.Compiled, v148, v152, p145);
    local v154 = v148:Construct(u4);
    v154:LoadAndConvertSave(Steal.Moon, {
        shadowed = v153
    });
    v154:SetRoot(Root);
    v154:PlayAll();
    v148:Add(task.delay(p147, v151.Destroy, v151));
    v148:Add(task.delay(p147 + 1, v148.Destroy, v148));
end;

function v11.aizen_wall(p155: any, p156) -- Line: 1119
    -- upvalues: u1 (copy), buildRuntimeHighlights (copy), u5 (copy)
    local aizen = u1.getResources().aizen;
    u1.getRoot(p155);
    local v157 = u1.character_trove(p155);
    local v158 = buildRuntimeHighlights(v157:Clone(aizen.Danku), v157);
    v158:PivotTo(p156);
    v158.Parent = workspace.Effects;
    u5:play(aizen.DankuSFX1, "default");
    shared.vfx.emit(v158);
    v157:Add(task.delay(9.5, function() -- Line: 1131
        -- upvalues: u5 (ref), aizen (copy)
        u5:play(aizen.DankuSFX2, "default");
    end));
    v157:Add(task.delay(10, v157.Destroy, v157));
end;

function v11.aizen_kurohitsugi(p159: any, p160, p161: any) -- Line: 1138
    -- upvalues: u1 (copy), buildRuntimeHighlights (copy), RunService (copy), u4 (copy), u5 (copy)
    local Kurohitsugi = u1.getResources().aizen.Kurohitsugi;
    local Root = u1.getRoot(p159);
    local v162 = u1.character_trove(p159);
    local u163 = buildRuntimeHighlights(v162:Clone(Kurohitsugi.VFX), v162);
    u163:PivotTo(Root.CFrame);
    u163.Parent = workspace.Effects;
    local v164 = v162:Add(u1.highlight(p159, {
        Name = "Highlight",
        Enabled = false,
        FillTransparency = -10,
        OutlineTransparency = -10,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = Color3.new(0.0980392247, 0.0862745121, 0.403921604),
        OutlineColor = Color3.new(0.250980407, 0.223529428, 1)
    }));
    local u165 = buildRuntimeHighlights(v162:Clone(Kurohitsugi.Son), v162);
    u165.Parent = p159;
    u165.Weld.Part1 = p159["Left Arm"];

    for _, v in {
        u165.Model.Start,
        u165.Model.End,
        u165.leaveeav.Start,
        u165.leaveeav.End,
        u165.Lightning.Part
    } do
        u1.highlight(v, {
            Name = "Highlight",
            Enabled = true,
            FillTransparency = -10,
            OutlineTransparency = -10,
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
            FillColor = Color3.new(0.494117677, 0.294117659, 0.725490212),
            OutlineColor = Color3.new(0.431372583, 0.239215702, 1)
        });
    end;

    for _, v in { u165.online.Start, u165.online.End } do
        u1.highlight(v, {
            Name = "Highlight",
            Enabled = true,
            FillTransparency = -15,
            OutlineTransparency = 1,
            DepthMode = Enum.HighlightDepthMode.Occluded,
            FillColor = Color3.new(0.784313798, 0.407843173, 0.909803987),
            OutlineColor = Color3.new(1, 1, 1)
        });
    end;

    v162:Add(RunService.PreRender:Connect(function() -- Line: 1192
        -- upvalues: u163 (copy), Root (copy)
        if u163 then
            u163:PivotTo(Root.CFrame);
        end;
    end));
    v162:Add(task.delay(0.25, function() -- Line: 1199
        -- upvalues: u165 (copy), u163 (copy)
        shared.vfx.emit(u165);
        shared.vfx.emit(u163.ciiool, u163.Model, u163.kitai1, u163.real);
    end));
    v162:Add(task.delay(4.233333333333333, function() -- Line: 1205
        -- upvalues: u163 (copy)
        shared.vfx.emit(u163.kitai1);
    end));
    v162:Add(task.delay(p161, v162.Destroy, v162));
    local v166 = v162:Construct(u4);
    v166:LoadAndConvertSave(Kurohitsugi.Moon, {
        Highlight = v164
    });
    v166:SetRoot(Root);
    v166:PlayAll();
    u5:play(Kurohitsugi.SFX, p160);
    require(Kurohitsugi.KurohitsugiModule)(p160);
end;

function v11.aizen_kurohitsugi_explode(p167: any, p168) -- Line: 1222
    -- upvalues: u3 (copy)
    u3.cameraShake(25, 1.5, 6);
end;

local function set_model_transparency(p169: userdata, p170: number, p171: table?) -- Line: 1229
    for _, descendant in p169:GetDescendants() do
        if descendant.Name ~= "HumanoidRootPart" then
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                if p171 and p171[descendant] == nil then
                    p171[descendant] = descendant.Transparency;
                end;

                descendant.Transparency = p170;
            elseif descendant:IsA("TextLabel") then
                if p171 and p171[descendant] == nil then
                    p171[descendant] = descendant.TextTransparency;
                end;

                descendant.TextTransparency = p170;
            end;
        end;
    end;
end;

local function restore_model_transparency(p172: table) -- Line: 1248
    for i, v in p172 do
        if i.Parent then
            if i:IsA("TextLabel") then
                i.TextTransparency = v;
            else
                i.Transparency = v;
            end;
        end;
    end;
end;

local function play_track(p173: any, p174: any, p175: userdata, u176: number?) -- Line: 1261
    -- upvalues: u2 (copy)
    local u177 = u2:loadAnimation(p174, p175);
    u177:Play(0);
    p173:Add(function() -- Line: 1264
        -- upvalues: u177 (copy), u176 (copy)
        u177:Stop(u176 or 0);
    end);

    return u177;
end;

local function build_rig_appearance(p178: userdata, p179: userdata) -- Line: 1270
    local v180 = p179:FindFirstChildOfClass("Humanoid");
    local v181 = p178:FindFirstChildOfClass("Humanoid");

    if not (v180 and v181) then
        return;
    end;

    local success, result = pcall(v180.GetAppliedDescription, v180);

    if not (success and result) then
        return;
    end;

    local v182 = result:Clone();
    local v183 = p179:FindFirstChildOfClass("Shirt");
    local v184 = p179:FindFirstChildOfClass("Pants");
    local v185 = v183 and v183:GetAttribute("jersey");

    if not v185 then
        if v184 then
            v185 = v184:GetAttribute("jersey");
        else
            v185 = v184;
        end;
    end;

    if v185 then
        v182.Shirt = 0;
        v182.Pants = 0;
    end;

    pcall(v181.ApplyDescriptionAsync, v181, v182);

    for _, descendant in p178:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.Massless = true;
            descendant.CollisionGroup = "none";

            if descendant.Name == "HumanoidRootPart" then
                descendant.Transparency = 1;
            end;
        end;
    end;

    if v185 then
        if v183 then
            v183:Clone().Parent = p178;
        end;

        if v184 then
            v184:Clone().Parent = p178;
        end;
    end;

    local v186 = p179:FindFirstChild("Torso") and p179.Torso:FindFirstChild("BackDecal");
    local Torso = p178:FindFirstChild("Torso");

    if v186 and Torso then
        local BackDecal = Torso:FindFirstChild("BackDecal");

        if BackDecal then
            BackDecal:Destroy();
        end;

        v186:Clone().Parent = Torso;
    end;
end;

function v11.aizen_awaken(p187: any, p188: number?) -- Line: 1325
    -- upvalues: u1 (copy), u3 (copy), u6 (copy), buildRuntimeHighlights (copy), u5 (copy), u4 (copy)
    local Root = u1.getRoot(p187);
    local v189 = u1.character_trove(p187);
    u1.cutscene_ball(true);
    u3.sceneEnabled(true);
    v189:Add(function() -- Line: 1332
        -- upvalues: u3 (ref), u1 (ref)
        u3.sceneEnabled(false);
        u1.cutscene_ball(false);
    end);
    local Flow = u1.getResources().aizen.Flow;
    local u190 = {};

    for _, child in Flow.ImpactFrames:GetChildren() do
        u190[child.Name] = u6.Preload(child);
    end;

    v189:Add(function() -- Line: 1343
        -- upvalues: u190 (copy)
        for _, v in u190 do
            v:Destroy();
        end;

        table.clear(u190);
    end);
    local v191 = buildRuntimeHighlights(v189:Clone(Flow.VFX), v189);
    v191:PivotTo(Root.CFrame);
    v191.Parent = workspace.Effects;
    v189:Add(task.delay(2.183333333333333, u6.Gif, Flow.ImpactFrames.Sequence1, 60));
    v189:Add(task.delay(11.8, u6.Gif, Flow.ImpactFrames.Sequence2, 60));
    v189:Add(task.delay(12.783333333333333, u6.Gif, Flow.ImpactFrames.Sequence3, 60));
    local v192, v193 = u1.buildFromRig(p187, Flow.aizenawk);

    for i, v in v193 do
        v193[i] = buildRuntimeHighlights(v, v192);
    end;

    v189:Add(v192, "Destroy");
    local v194 = v189:Add(u1.highlight(p187, {
        Name = "Highlight",
        Enabled = true,
        FillTransparency = 1,
        OutlineTransparency = 1,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        FillColor = Color3.new(1, 0, 0),
        OutlineColor = Color3.new(1, 1, 1)
    }));
    u5:play(Flow.SFX, "default");
    u5:play(Flow.VL, "default");
    local v195, v196 = u3.cutsceneCamRigWithLetterBox(Root, Flow.Camera, Flow.FOV, nil, CFrame.new(0, -3, 0) * CFrame.Angles(0, -1.5707963267948966, 0), Flow.Cam, "CamPart");
    v189:Add(task.delay(16, v196));
    local MoonEffects = u1.getMoonEffects();
    v189:Add(MoonEffects);
    local v197 = {
        Terrain = workspace.Terrain,
        Highlight = v194,
        Vignette = MoonEffects.Vignette,
        Workspace = v191
    };
    v191.camstarts.Motor6D.Part1 = v195.CamPart;
    local v198 = v189:Construct(u4);
    v198:LoadAndConvertSave(Flow.Moon, v197);
    v198:SetRoot(Root);
    v198:PlayAll();
    u1.execute_compiled(Flow.Compiled, v189, v191, p187, v195);
    v189:Add(task.delay(20.35, v189.Destroy, v189));
end;

function v11.aizen_awaken_steal(p199: any, p200: any, u201: any, p202: number?) -- Line: 1415
    -- upvalues: u1 (copy), u3 (copy), build_rig_appearance (copy), buildRuntimeHighlights (copy), set_model_transparency (copy), restore_model_transparency (copy), u5 (copy), u2 (copy), Lighting (copy), u4 (copy)
    local Root = u1.getRoot(p199);

    if not (Root and (u1.getRoot(p200) and u1.getRoot(u201))) then
        return;
    end;

    local Steal = u1.getResources().aizen.Flow.Steal;
    local v203 = u1.character_trove(p199);
    u3.sceneEnabled(true);
    v203:Add(function() -- Line: 1430
        -- upvalues: u3 (ref), Root (copy)
        u3.sceneEnabled(false);
        Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        Root.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
        u3.destroyVelocity(Root);
    end);
    local u204 = v203:Construct(u1.newRig, Root);
    u204.Name = "FakeAizen";
    build_rig_appearance(u204, p199);
    u204:PivotTo(Root.CFrame);
    local Root2 = u1.getRoot(u204);

    if Root2 then
        local Weld = Instance.new("Weld");
        Weld.Part0 = Root;
        Weld.Part1 = Root2;
        Weld.Parent = Root2;
        v203:Add(Weld);
    end;

    local v205, v206 = u1.buildFromRig(p199, Steal.VFXRigs.Aizen);

    for i, v in v206 do
        v206[i] = buildRuntimeHighlights(v, v205);
    end;

    v203:Add(v205, "Destroy");
    local v207, v208 = u1.buildFromRig(p200, Steal.VFXRigs.Victim);

    for i, v in v208 do
        v208[i] = buildRuntimeHighlights(v, v207);
    end;

    v203:Add(v207, "Destroy");
    local v209, v210 = u1.buildFromRig(u201, Steal.VFXRigs.Teammate);

    for i, v in v210 do
        v210[i] = buildRuntimeHighlights(v, v209);
    end;

    v203:Add(v209, "Destroy");
    local v211, v212 = u1.buildFromRig(u204, Steal.VFXRigs.FakeAizen);

    for i, v in v212 do
        v212[i] = buildRuntimeHighlights(v, v211);
    end;

    v203:Add(v211, "Destroy");
    local u213 = {};
    set_model_transparency(u201, 1, u213);
    v203:Add(function() -- Line: 1458
        -- upvalues: restore_model_transparency (ref), u213 (copy)
        restore_model_transparency(u213);
    end);
    v203:Add(task.delay(7.1, function() -- Line: 1461
        -- upvalues: u204 (copy), set_model_transparency (ref), u201 (copy), restore_model_transparency (ref), u213 (copy)
        if u204.Parent then
            set_model_transparency(u204, 1);
        end;

        if u201.Parent then
            restore_model_transparency(u213);
        end;
    end));
    local v214 = buildRuntimeHighlights(v203:Clone(Steal.VFX), v203);
    v214:PivotTo(Root.CFrame);
    v214.Parent = workspace.Effects;
    u5:play(Steal.SFX, "default");
    local u215 = u2:loadAnimation(p199, Steal.Animation);
    u215:Play(0);
    local u216 = 0.15;
    v203:Add(function() -- Line: 1264
        -- upvalues: u215 (copy), u216 (copy)
        u215:Stop(u216 or 0);
    end);
    local u217 = u2:loadAnimation(p200, Steal.Victim);
    u217:Play(0);
    local u218 = 0.15;
    v203:Add(function() -- Line: 1264
        -- upvalues: u217 (copy), u218 (copy)
        u217:Stop(u218 or 0);
    end);
    local u219 = u2:loadAnimation(u201, Steal.Teammate);
    u219:Play(0);
    local u220 = 0.15;
    v203:Add(function() -- Line: 1264
        -- upvalues: u219 (copy), u220 (copy)
        u219:Stop(u220 or 0);
    end);
    local u221 = u2:loadAnimation(u204, Steal.FakeAizen);
    u221:Play(0);
    local u222 = nil;
    v203:Add(function() -- Line: 1264
        -- upvalues: u221 (copy), u222 (copy)
        u221:Stop(u222 or 0);
    end);
    local _, v223 = u3.cutsceneCamRigWithLetterBox(Root, Steal.Camera, Steal.FOV, nil, "default", Steal.HumanoidCameraRig, "Torso");
    v203:Add(v223);
    local v224 = {
        Lighting = Lighting
    };
    u1.cache_lighting();
    v203:Add(u1.restore_lighting);
    u1.contain_lighting(v203, v224, Steal.Lighting);
    local v225 = v203:Construct(u4);
    v225:LoadAndConvertSave(Steal.Moon, v224);
    v225:SetRoot(Root);
    v225:PlayAll();
    u1.execute_compiled(Steal.Compiled, v203, p199, p200, v214);
    v203:Add(task.delay(13.29, v203.Destroy, v203));
end;

return v11;