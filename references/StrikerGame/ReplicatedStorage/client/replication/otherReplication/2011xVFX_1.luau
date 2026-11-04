 
 

local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local u1 = require("@game/ReplicatedStorage/util/animationUtil");
local u2 = require("@game/ReplicatedStorage/client/replication/mainreplication");
local u3 = require("@game/ReplicatedStorage/util/MoonPropertyAnimator");
local u4 = require("@game/ReplicatedStorage/util/Util");
local u5 = require("@game/ReplicatedStorage/util/vfxUtil");
local u6 = require("@game/ReplicatedStorage/util/soundUtil");
local u7 = require("@game/ReplicatedStorage/client/replication/TekrinnDialogue");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u8 = require("@game/ReplicatedStorage/forum/trove");
local play2011x = require("@game/ReplicatedStorage/mvputils/RigAfterimages").play2011x;
local v9 = {};
local u10 = {};
local u11 = {};
local u12 = {};

local function buildRuntimeHighlights(p13: userdata, p14: any) -- Line: 38
    -- upvalues: u5 (copy)
    return u5.build_highlights(p13, p14, "_2011xHighlightProperties");
end;

local function cloneRuntimeEffect(p15: any, p16: userdata) -- Line: 42
    -- upvalues: buildRuntimeHighlights (copy)
    return buildRuntimeHighlights(p15:Clone(p16), p15);
end;

local function buildRuntimeRig(p17: any, p18: userdata, p19: any) -- Line: 46
    -- upvalues: u5 (copy)
    local _, v20 = u5.buildFromRig(p17, p18, p19);

    for _, v in v20 do
        u5.build_highlights(v, p19, "_2011xHighlightProperties");
    end;
end;

local function pursuit_assets() -- Line: 53
    -- upvalues: u5 (copy)
    return u5.getResources()["2011x"].Pursuit;
end;

local function charge_assets() -- Line: 57
    -- upvalues: u5 (copy)
    return u5.getResources()["2011x"].Charge;
end;

local function tartarus_assets() -- Line: 61
    -- upvalues: u5 (copy)
    return u5.getResources()["2011x"].Tartarus;
end;

local function stop_charge(p21: userdata) -- Line: 65
    -- upvalues: u12 (copy)
    local v22 = u12[p21];

    if v22 then
        v22:Destroy();
        u12[p21] = nil;
    end;
end;

local function weld_effect(p23: userdata, p24: userdata) -- Line: 73
    local v25 = nil;

    if p23:IsA("BasePart") then
        v25 = p23;
    elseif p23:IsA("Model") then
        v25 = p23.PrimaryPart or p23:FindFirstChildWhichIsA("BasePart", true);

        if v25 and not p23.PrimaryPart then
            p23.PrimaryPart = v25;
        end;
    end;

    if not v25 then
        return;
    end;

    v25.Anchored = false;
    local v26 = v25:FindFirstChildOfClass("Weld") or Instance.new("Weld");
    v26.Parent = v25;
    v26.Part0 = p24;
    v26.Part1 = v25;
end;

local function play_jumpscare(p27) -- Line: 94
    -- upvalues: u5 (copy), u4 (copy)
    local Pursuit = u5.getResources()["2011x"].Pursuit;

    if Pursuit then
        Pursuit = Pursuit:FindFirstChild("ImpactFrames");
    end;

    if not Pursuit then
        return;
    end;

    local v28 = {};

    for _, child in (Pursuit:FindFirstChild("FlipbookFrames") or Pursuit):GetChildren() do
        if child:IsA("ImageLabel") then
            table.insert(v28, child);
        end;
    end;

    table.sort(v28, function(p29: userdata, p30: userdata) -- Line: 108
        return (tonumber(p29.Name:match("%d+")) or 0) < (tonumber(p30.Name:match("%d+")) or 0);
    end);

    if #v28 == 0 then
        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "2011xImpactFrames";

    for i, v in v28 do
        local v31 = v:Clone();
        v31.Name = tostring(i);
        v31.Visible = true;
        v31.ImageTransparency = 0;
        v31.Parent = Folder;
    end;

    p27:Add(Folder);
    p27:Add(u4.Preload(Folder, false));
    p27:Add(u4.Gif(Folder, #v28 / 1));
end;

function v9.x2011_pursuit(u32) -- Line: 131
    -- upvalues: u5 (copy), u6 (copy), u11 (copy), RunService (copy), weld_effect (copy), play2011x (copy)
    local Root = u5.getRoot(u32);
    local Pursuit = u5.getResources()["2011x"].Pursuit;

    if not (Root and Pursuit) then
        return;
    end;

    local VFX = Pursuit:FindFirstChild("VFX");
    local Compiled = Pursuit:FindFirstChild("Compiled");
    u6:play(Pursuit.Cast, Root);
    local v33 = u11[u32];

    if v33 then
        v33:Destroy();
        u11[u32] = nil;
    end;

    local u34 = u5.character_trove(u32);
    u11[u32] = u34;
    u34:Add(function() -- Line: 151
        -- upvalues: u11 (ref), u32 (copy), u34 (copy)
        if u11[u32] == u34 then
            u11[u32] = nil;
        end;
    end);
    local v35 = u34:Clone(VFX);
    local u36 = u5.build_highlights(v35, u34, "_2011xHighlightProperties");
    u36.Parent = workspace.Effects;
    u34:Add(RunService.RenderStepped:Connect(function() -- Line: 160
        -- upvalues: u36 (copy), Root (copy)
        if u36.Parent then
            u36:PivotTo(Root.CFrame);
        end;
    end));
    local u37 = u32:FindFirstChild("Right Arm");
    local v38 = u32:FindFirstChild("Left Arm");
    local v39 = u34:Clone(Pursuit.TrailR);
    local v40 = u5.build_highlights(v39, u34, "_2011xHighlightProperties");
    local v41 = u34:Clone(Pursuit.TrailL);
    local v42 = u5.build_highlights(v41, u34, "_2011xHighlightProperties");
    v40.Parent = workspace.Effects;
    v42.Parent = workspace.Effects;
    weld_effect(v42, v38);
    weld_effect(v40, u37);
    shared.vfx.emit(v42, v40);
    u34:Add(task.delay(2.45, function() -- Line: 179
        -- upvalues: u36 (copy), u34 (copy), Pursuit (copy), u5 (ref), u37 (copy), weld_effect (ref)
        if not u36.Parent then
            return;
        end;

        local v43 = u34;
        local v44 = v43:Clone(Pursuit.HandEffectFly);
        local v45 = u5.build_highlights(v44, v43, "_2011xHighlightProperties");
        v45.Parent = workspace.Effects;
        shared.vfx.emit(v45);

        if v45 and (u37 and u37:IsA("BasePart")) then
            weld_effect(v45, u37);
        end;
    end));
    play2011x(u32, 1, u34);
    u34:Add(task.delay(0.4666666666666667, play2011x, u32, 1, u34));
    u34:Add(task.delay(1.0166666666666666, play2011x, u32, 1, u34));
    u34:Add(task.delay(1.2666666666666666, play2011x, u32, 2, u34));
    u34:Add(task.delay(1.2833333333333334, play2011x, u32, 3, u34));
    u34:Add(task.delay(2.5, play2011x, u32, 4, u34));
    u5.execute_compiled(Compiled, u34, u36);
    u34:Add(task.delay(3.9166666666666665, u34.Destroy, u34));
end;

function v9.x2011_pursuit_grab(p46, p47) -- Line: 202
    -- upvalues: u5 (copy), u11 (copy), u6 (copy), RunService (copy), weld_effect (copy), Lighting (copy), u3 (copy), play_jumpscare (copy), play2011x (copy)
    local Root = u5.getRoot(p46);
    local Pursuit = u5.getResources()["2011x"].Pursuit;

    if not (Root and Pursuit) then
        return;
    end;

    u11[p46] = nil;
    local VFX = Pursuit:FindFirstChild("VFX");
    local CompiledGrab = Pursuit:FindFirstChild("CompiledGrab");
    u6:play(Pursuit.Hit, Root);
    local v48 = u5.character_trove(p46);
    local v49 = v48:Clone(VFX);
    local u50 = u5.build_highlights(v49, v48, "_2011xHighlightProperties");
    u50.Parent = workspace.Effects;
    v48:Add(RunService.RenderStepped:Connect(function() -- Line: 219
        -- upvalues: u50 (copy), Root (copy)
        if u50.Parent then
            u50:PivotTo(Root.CFrame);
        end;
    end));
    local v51 = v48:Clone(Pursuit.Bite);
    local v52 = u5.build_highlights(v51, v48, "_2011xHighlightProperties");

    if p47 then
        local Head = p47:FindFirstChild("Head");

        if Head and Head:IsA("BasePart") then
            weld_effect(v52, Head);
        end;
    end;

    local v53 = {
        Lighting = Lighting,
        Vignette = v48:Add(u5.getMoonEffects()).Vignette
    };
    u5.cache_lighting();
    v48:Add(u5.restore_lighting);
    u5.contain_lighting(v48, v53, Pursuit.Lighting);
    local v54 = v48:Construct(u3);

    for _, v in v54:LoadAndConvertSave(Pursuit.Moon, v53) do
        for _, v2 in v do
            v2.TimePosition = 2.8666666666666667;
        end;
    end;

    v54:SetRoot(Root);
    v54:PlayAll();

    if p47 and u5.isLocalPlayer(p46, p47) then
        v48:Add(task.delay(2.4166666666666665, play_jumpscare, v48));
    end;

    v48:Add(task.delay(2.4166666666666665, play2011x, p46, 5, v48));
    v48:Add(task.delay(2.4166666666666665, shared.vfx.emit, v52));
    u5.execute_compiled(CompiledGrab, v48, u50);
    v48:Add(task.delay(6.166666666666667, v48.Destroy, v48));
end;

function v9.x2011_pursuit_jumpscare(p55, p56, p57) -- Line: 260
    -- upvalues: u5 (copy), play_jumpscare (copy), u6 (copy)
    local v58;

    if p56 then
        v58 = u5.isLocalPlayer(p55, p56);
    else
        v58 = u5.isLocalPlayer(p55);
    end;

    if not v58 then
        return;
    end;

    local v59 = u5.character_trove(p55);
    play_jumpscare(v59);
    v59:Add(task.delay(1.2, v59.Destroy, v59));

    if p57 then
        u6:play(u5.getResources()["2011x"].Scare, "default");
    end;
end;

local function charge_facing(p60: userdata, p61: userdata) -- Line: 273
    local LookVector = p61.CFrame.LookVector;
    local v62 = LookVector:Cross(Vector3.new(0, 1, 0));

    if v62.Magnitude < 0.05 then
        v62 = Vector3.new(p61.CFrame.RightVector.X, 0, p61.CFrame.RightVector.Z);
    end;

    local Unit = (v62.Magnitude < 0.05 and Vector3.new(1, 0, 0) or v62).Unit;

    return CFrame.fromMatrix(p60.Position, Unit, Unit:Cross(LookVector).Unit);
end;

local function flatten_root(p63: userdata) -- Line: 286
    local Vector3_new_ret = Vector3.new(p63.CFrame.LookVector.X, 0, p63.CFrame.LookVector.Z);

    if Vector3_new_ret.Magnitude < 0.05 then
        Vector3_new_ret = Vector3.new(p63.CFrame.UpVector.X, 0, p63.CFrame.UpVector.Z);
    end;

    if Vector3_new_ret.Magnitude < 0.05 then
        return;
    end;

    p63.CFrame = CFrame.lookAt(p63.Position, p63.Position + Vector3_new_ret.Unit);
end;

function v9.x2011_charge_start(u64: any, p65: number, u66: number) -- Line: 297
    -- upvalues: u5 (copy), u12 (copy), flatten_root (copy), u6 (copy), play2011x (copy), u2 (copy), RunService (copy), charge_facing (copy)
    local Root = u5.getRoot(u64);

    if not Root then
        return;
    end;

    local v67 = u12[u64];

    if v67 then
        v67:Destroy();
        u12[u64] = nil;
    end;

    local u68 = u5.character_trove(u64);
    u12[u64] = u68;
    u68:Add(function() -- Line: 306
        -- upvalues: u12 (ref), u64 (copy), u68 (copy), flatten_root (ref), Root (copy)
        if u12[u64] == u68 then
            u12[u64] = nil;
        end;

        flatten_root(Root);
    end);
    u6:play(u5.getResources()["2011x"].Charge.Cast, Root);
    u68:Add(task.delay(p65, function() -- Line: 315
        -- upvalues: u64 (copy), play2011x (ref), u68 (copy), u2 (ref), Root (copy), u66 (copy), RunService (ref), charge_facing (ref)
        if not u64.Parent then
            return;
        end;

        play2011x(u64, 1, u68);
        play2011x(u64, 6, u68);
        u68:Add(task.delay(1.05, play2011x, u64, 6, u68));
        u68:Add(task.delay(2.1, play2011x, u64, 6, u68));
        local u69 = u2.bodyVelocity(Root, 1, u66, false, nil, true);

        if not u69 then
            return;
        end;

        u69.MaxForce = Vector3.new(300000, 300000, 300000);
        u68:Add(u69);
        u68:Add(RunService.RenderStepped:Connect(function() -- Line: 332
            -- upvalues: u69 (copy), Root (ref), charge_facing (ref)
            local workspace_CurrentCamera = workspace.CurrentCamera;

            if not (u69.Parent and workspace_CurrentCamera) then
                return;
            end;

            u69.Velocity = workspace_CurrentCamera.CFrame.LookVector * 140;
            Root.CFrame = charge_facing(Root, workspace_CurrentCamera);
        end));
    end));
    u68:Add(task.delay(p65 + u66 + 0.2, u68.Destroy, u68));
end;

function v9.x2011_charge_trap(p70) -- Line: 345
    -- upvalues: u5 (copy), u12 (copy), u2 (copy), u6 (copy), u1 (copy)
    local Root = u5.getRoot(p70);
    local Charge = u5.getResources()["2011x"].Charge;

    if not (Root and Charge) then
        return;
    end;

    local v71 = u12[p70];

    if v71 then
        v71:Destroy();
        u12[p70] = nil;
    end;

    local v72 = u5.character_trove(p70);
    u2.sceneEnabled(true);
    v72:Add(function() -- Line: 355
        -- upvalues: u2 (ref)
        u2.sceneEnabled(false);
    end);
    v72:Add(u2.kuronaCamToAll(Root, Charge.Trap.Cam, Charge.Trap.FOV));
    local v73 = v72:Clone(Charge.Trap.BallExe);
    local v74 = u5.build_highlights(v73, v72, "_2011xHighlightProperties");
    v74:PivotTo(Root.CFrame);
    v74.Parent = workspace.Effects;
    u6:play(Charge.Trap.Cast, "default");
    v72:Add(u1:loadAnimation(v74, Charge.Trap.Ball), "Stop"):Play(0);
    v72:Add(task.delay(2.25, v72.Destroy, v72));
end;

function v9.x2011_charge_grab(p75, p76) -- Line: 370
    -- upvalues: u12 (copy), u5 (copy), RunService (copy), u6 (copy)
    local v77 = u12[p75];

    if v77 then
        v77:Destroy();
        u12[p75] = nil;
    end;

    local v78 = u5.character_trove(p75);
    local Root = u5.getRoot(p75);
    local Charge = u5.getResources()["2011x"].Charge;
    local v79 = v78:Clone(Charge.Grab.VFX);
    local u80 = u5.build_highlights(v79, v78, "_2011xHighlightProperties");
    u80:PivotTo(Root.CFrame);
    u80.Parent = workspace.Effects;
    v78:Add(RunService.RenderStepped:Connect(function() -- Line: 381
        -- upvalues: u80 (copy), Root (copy)
        if u80 then
            u80:PivotTo(Root.CFrame);
        end;
    end));
    u6:play(Charge.Grab.Cast, Root);
    u5.execute_compiled(Charge.Grab.Compiled, v78, u80);
    v78:Add(task.delay(2.75, v78.Destroy, v78));
end;

function v9.x2011_charge_throw(p81, p82) -- Line: 393
end;

local function build_rig_appearance(p83: userdata, p84: userdata) -- Line: 396
    local v85 = p84:FindFirstChildOfClass("Humanoid");
    local v86 = p83:FindFirstChildOfClass("Humanoid");

    if not (v85 and v86) then
        return;
    end;

    local success, result = pcall(v85.GetAppliedDescription, v85);

    if not (success and result) then
        return;
    end;

    local v87 = result:Clone();
    local v88 = p84:FindFirstChildOfClass("Shirt");
    local v89 = p84:FindFirstChildOfClass("Pants");
    local v90 = v88 and v88:GetAttribute("jersey");

    if not v90 then
        if v89 then
            v90 = v89:GetAttribute("jersey");
        else
            v90 = v89;
        end;
    end;

    if v90 then
        v87.Shirt = 0;
        v87.Pants = 0;
    end;

    pcall(v86.ApplyDescriptionAsync, v86, v87);

    for _, descendant in p83:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.Massless = true;

            if descendant.Name == "HumanoidRootPart" then
                descendant.Transparency = 1;
            end;
        end;
    end;

    if v90 then
        if v88 then
            v88:Clone().Parent = p83;
        end;

        if v89 then
            v89:Clone().Parent = p83;
        end;
    end;
end;

function v9.x2011_tartarus(p91, u92) -- Line: 439
    -- upvalues: u5 (copy), u2 (copy), u6 (copy), build_rig_appearance (copy), u1 (copy), Lighting (copy), u3 (copy)
    local Root = u5.getRoot(p91);
    local Tartarus = u5.getResources()["2011x"].Tartarus;

    if not (Root and Tartarus) then
        return;
    end;

    local u93 = u5.character_trove(p91);
    u2.sceneEnabled(true);
    u93:Add(function() -- Line: 448
        -- upvalues: u2 (ref)
        u2.sceneEnabled(false);
    end);
    u6:play(Tartarus.Sound, "default");
    local v94 = u93:Clone(Tartarus.VFX);
    local v95 = u5.build_highlights(v94, u93, "_2011xHighlightProperties");
    v95:PivotTo(Root.CFrame);
    v95.Parent = workspace.Effects;
    local _baseplate_controller, u96 = u5.get_baseplate_controller();
    u96.Transparency = 1;
    _baseplate_controller.update();
    u93:Add(function() -- Line: 463
        -- upvalues: u96 (copy), _baseplate_controller (copy)
        u96.Transparency = 0;
        _baseplate_controller.update();
    end);
    local v97 = u93:Add(u2.kuronaCamToAll(Root, nil, Tartarus.FOV));
    local v98 = v95:FindFirstChild("Transição");

    if v98 and v98:IsA("BasePart") then
        v98.Anchored = false;
        v98.CanCollide = false;
        v98.Massless = true;
        local AutoWeld = v98:FindFirstChild("AutoWeld");

        if AutoWeld and (AutoWeld:IsA("WeldConstraint") and (v97 and v97:IsA("BasePart"))) then
            AutoWeld.Part0 = v97;
            AutoWeld.Part1 = v98;
        end;
    end;

    local Victim = v95:FindFirstChild("Victim");
    u93:Add(task.spawn(function() -- Line: 483
        -- upvalues: Victim (copy), u92 (copy), build_rig_appearance (ref), u93 (copy), u1 (ref), Tartarus (copy)
        if Victim and u92 then
            task.defer(build_rig_appearance, Victim, u92);
            u93:Add(u1:loadAnimation(Victim, Tartarus.Victim), "Stop"):Play(0);
        end;
    end));
    local v99 = u93:Add(u5.getMoonEffects());
    local v100 = {
        Lighting = Lighting,
        Vignette = v99.Vignette,
        Workspace = v95,
        ["Screen Cover"] = v99["Screen Cover"]
    };
    u5.cache_lighting();
    u93:Add(function() -- Line: 500
        -- upvalues: u5 (ref)
        u5.restore_lighting();
        u5.restore_lighting_properties();
    end);
    u5.contain_lighting(u93, v100, Tartarus.Lighting);
    local v101 = u93:Construct(u3);
    v101:LoadAndConvertSave(Tartarus.Moon, v100);
    v101:SetOriginalRoot(CFrame.new(-150.35, 3.5, -201.6) * CFrame.Angles(0, 1.5707963267948966, 0));
    v101:SetRoot(Root);
    v101:PlayAll();
    u5.execute_compiled(Tartarus.Compiled, u93, v95);
    u93:Add(task.delay(13.483333333333333, u93.Destroy, u93));
end;

function v9.x2011_trickery_ground_windup(u102: any, u103: number, u104: number) -- Line: 518
    -- upvalues: u5 (copy), u10 (copy), RunService (copy), Lighting (copy), u3 (copy), u2 (copy)
    local Root = u5.getRoot(u102);

    if not Root then
        return;
    end;

    local Windup = u5.getResources()["2011x"].Trickery.Ground.Windup;
    local u105 = u5.character_trove(u102);
    u10[u102] = u105;
    u105:Add(function() -- Line: 527
        -- upvalues: u10 (ref), u102 (copy), u105 (copy)
        if u10[u102] == u105 then
            u10[u102] = nil;
        end;
    end);
    local v106 = game:GetService("Players").LocalPlayer.Character == u102;
    local _, v107 = u5.buildFromRig(u102, Windup["1"], u105);

    for _, v in v107 do
        u5.build_highlights(v, u105, "_2011xHighlightProperties");
    end;

    for _, v in { "Step", "TP" } do
        local v108 = u102:FindFirstChild(v);

        if v108 and v108:IsA("Highlight") then
            v108.Adornee = u102;
            local Adornee = v108:FindFirstChild("Adornee");

            if Adornee then
                Adornee.Value = u102;
            end;

            local EmitParent = v108:FindFirstChild("EmitParent");

            if EmitParent then
                EmitParent.Value = u102;
            end;
        end;
    end;

    local v109 = u105:Clone(Windup.VFX);
    local v110 = u5.build_highlights(v109, u105, "_2011xHighlightProperties");
    v110:PivotTo(Root.CFrame);
    v110.Parent = workspace.Effects;
    local WindUP = v110.WindUP;
    WindUP.SmearFrames.Link.Value = u102.Torso;
    local u111 = {};

    for _, v in { "TP GLITCH", "Lightning", "Aura" } do
        local v112 = WindUP[v];
        u111[v112] = Root.CFrame:ToObjectSpace(v112.CFrame);
    end;

    u105:Add(RunService.RenderStepped:Connect(function() -- Line: 562
        -- upvalues: u111 (copy), Root (copy)
        for i, v in u111 do
            i:PivotTo(Root.CFrame * v);
        end;
    end));
    local v113 = {};

    if v106 then
        for _, v in { "EffectStart", "Effect" } do
            local v114 = u105:Clone(Windup.Lighting[v]);
            local v115 = u5.build_highlights(v114, u105, "_2011xHighlightProperties");
            v115.Parent = Lighting;
            v113[v] = v115;
        end;

        local v116 = u105:Add(u5.getMoonEffects());
        local v117 = u105:Construct(u3);
        v117:LoadAndConvertSave(Windup.Moon, {
            Vignette = v116.Vignette
        });
        v117:PlayAll();
        local v118 = u2.bodyVelocity(Root, 13, u104, false, "LookVector", false, nil, -1);

        if v118 then
            u105:Add(v118);
        end;

        u105:Add(task.delay(u104, function() -- Line: 586
            -- upvalues: u2 (ref), Root (copy), u103 (copy), u104 (copy), u105 (copy)
            local v119 = u2.bodyVelocity(Root, 120, u103 - u104, false, "LookVector", false, nil, -1);

            if v119 then
                u105:Add(v119);
            end;
        end));
        u105:Add(function() -- Line: 593
            -- upvalues: Root (copy)
            Root.AssemblyLinearVelocity = Vector3.new(0, Root.AssemblyLinearVelocity.Y, 0);
        end);
    end;

    u5.execute_compiled(Windup.Compiled, u105, WindUP, u102, v113, v106);
    u105:Add(task.delay(u103, u105.Destroy, u105));
end;

function v9.x2011_trickery_air_windup(u120: any, p121: number, p122: number) -- Line: 603
    -- upvalues: u5 (copy), u10 (copy), u2 (copy)
    local Root = u5.getRoot(u120);

    if not Root then
        return;
    end;

    local Windup = u5.getResources()["2011x"].Trickery.Air.Windup;
    local u123 = u5.character_trove(u120);
    u10[u120] = u123;
    u123:Add(function() -- Line: 612
        -- upvalues: u10 (ref), u120 (copy), u123 (copy)
        if u10[u120] == u123 then
            u10[u120] = nil;
        end;
    end);
    local _, v124 = u5.buildFromRig(u120, Windup.Rig, u123);

    for _, v in v124 do
        u5.build_highlights(v, u123, "_2011xHighlightProperties");
    end;

    for _, v in { "FakeLArm", "FakeRArm" } do
        local u125 = u120[v];
        local EmittersLifetime = u5.getEmittersLifetime(u125);
        u123:Pop(u125);
        u123:Add(function() -- Line: 623
            -- upvalues: u125 (copy), EmittersLifetime (copy)
            for _, descendant in u125:GetDescendants() do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            u125.Weld:Destroy();
            u125.Anchored = true;
            u125.Parent = workspace.Effects;
            task.delay(EmittersLifetime, u125.Destroy, u125);
        end);
    end;

    local v126 = u123:Clone(Windup.Highlight);
    local v127 = u5.build_highlights(v126, u123, "_2011xHighlightProperties");
    v127.Name = "TrickeryAir";
    v127.Parent = u120;
    v127.Adornee = u120;

    for _, v in { "Adornee", "EmitParent" } do
        v127:FindFirstChild(v).Value = u120;
    end;

    local v128 = u123:Clone(Windup.VFX);
    local v129 = u5.build_highlights(v128, u123, "_2011xHighlightProperties");
    v129:PivotTo(Root.CFrame);
    v129.Parent = workspace.Effects;

    if game:GetService("Players").LocalPlayer.Character == u120 then
        local u130 = u2.bodyVelocity(Root, 120, p121, false, "LookVector", false, nil, -1);

        if u130 then
            u130.MaxForce = Vector3.new(400000, 400000, 400000);
            u123:Add(u130);
            u123:Add(task.delay(0.3333333333333333, function() -- Line: 652
                -- upvalues: u130 (copy)
                if u130.Parent then
                    u130.MaxForce = Vector3.new(400000, 0, 400000);
                end;
            end));
        end;

        u123:Add(function() -- Line: 659
            -- upvalues: Root (copy)
            Root.AssemblyLinearVelocity = Vector3.new(0, Root.AssemblyLinearVelocity.Y, 0);
        end);
    end;

    u5.execute_compiled(Windup.Compiled, u123, v129, u120, v127);
    u123:Add(task.delay(p121, u123.Destroy, u123));
end;

function v9.x2011_trickery_ground_hit(p131: any, u132: any, p133, p134: number) -- Line: 669
    -- upvalues: u10 (copy), u5 (copy), Lighting (copy), u3 (copy)
    local v135 = u10[p131];

    if v135 then
        v135:Destroy();
    end;

    if not (u5.getRoot(p131) and u5.getRoot(u132)) then
        return;
    end;

    local Hit = u5.getResources()["2011x"].Trickery.Ground.Hit;
    local u136 = u5.character_trove(p131);
    local v137 = u136:Extend();
    local math_max_ret = math.max(p134, 5.5166666666666675);
    v137:Add(task.delay(p134, v137.Destroy, v137));
    u136:Add(u132.AncestryChanged:Connect(function() -- Line: 685
        -- upvalues: u132 (copy), u136 (copy)
        if not u132:IsDescendantOf(workspace) then
            u136:Destroy();
        end;
    end));
    local CFrame_new_ret = CFrame.new(-48.30734634399414, 3, 5.022068023681641);
    local v138 = u136:Clone(Hit.VFX);
    local v139 = u5.build_highlights(v138, u136, "_2011xHighlightProperties");
    v139:PivotTo(p133 * CFrame_new_ret:ToObjectSpace(Hit.VFX:GetPivot()));
    v139.Parent = workspace.Effects;
    local v140 = {
        User = {},
        Victim = {}
    };

    for i, v in {
        User = p131,
        Victim = u132
    } do
        local v141 = i;
        local v142 = v;

        for _, child in Hit.Highlights[i]:GetChildren() do
            local v143 = u136:Clone(child);
            local v144 = u5.build_highlights(v143, u136, "_2011xHighlightProperties");
            v144.Adornee = v142;
            v144:FindFirstChild("Adornee").Value = v142;
            v144.EmitParent.Value = u132;
            v144.Parent = v142;
            v140[v141][child.Name] = v144;
        end;
    end;

    local Character = game:GetService("Players").LocalPlayer.Character;
    local v145 = Character == p131 and true or Character == u132;
    local v146 = {};

    if v145 then
        local v147 = u136:Clone(Hit.Lighting.Effect1);
        local v148 = u5.build_highlights(v147, u136, "_2011xHighlightProperties");
        v148.Parent = Lighting;
        v146.Effect1 = v148;
        local v149 = u136:Add(u5.getMoonEffects());
        local v150 = u136:Construct(u3);
        v150:LoadAndConvertSave(Hit.Moon, {
            Vignette = v149.Vignette
        });
        v150:PlayAll();
    end;

    u5.execute_compiled(Hit.Compiled, u136, v139, v140, v146, v145);
    u136:Add(task.delay(math_max_ret, u136.Destroy, u136));
end;

function v9.x2011_trickery_air_hit(p151: any, u152: any, p153, p154: number) -- Line: 725
    -- upvalues: u10 (copy), u5 (copy), Lighting (copy), u3 (copy)
    local v155 = u10[p151];

    if v155 then
        v155:Destroy();
    end;

    if not (u5.getRoot(p151) and u5.getRoot(u152)) then
        return;
    end;

    local Hit = u5.getResources()["2011x"].Trickery.Air.Hit;
    local u156 = u5.character_trove(p151);
    local v157 = u156:Extend();
    local v158 = 0.9833333333333333 + u5.getEmittersLifetime(Hit.VFX.Throw) + 0.1;
    local math_max_ret = math.max(p154, v158);
    v157:Add(task.delay(p154, v157.Destroy, v157));
    u156:Add(u152.AncestryChanged:Connect(function() -- Line: 741
        -- upvalues: u152 (copy), u156 (copy)
        if not u152:IsDescendantOf(workspace) then
            u156:Destroy();
        end;
    end));
    local v159 = u156:Clone(Hit.VFX);
    local v160 = u5.build_highlights(v159, u156, "_2011xHighlightProperties");

    for _, v in { "Step1", "FakeLArm", "FakeRArm", "FlashSteps2" } do
        v160[v]:Destroy();
    end;

    v160:PivotTo(p153);
    v160.Parent = workspace.Effects;
    local v161 = {};

    for i, v in {
        User = p151,
        Victim = u152
    } do
        v161[i] = v157:Add(u5.highlight(v, {
            Name = "TrickeryAirHit",
            Enabled = true,
            FillTransparency = 1,
            OutlineTransparency = 1,
            Adornee = v,
            DepthMode = Enum.HighlightDepthMode.Occluded,
            FillColor = Color3.fromRGB(62, 0, 0),
            OutlineColor = Color3.new(1, 1, 1)
        }));
    end;

    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local v162 = {};

    if LocalPlayer.Character == p151 and true or LocalPlayer.Character == u152 then
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local FieldOfView = workspace_CurrentCamera.FieldOfView;
        local v163 = v157:Clone(Hit.Lighting.ColorCorrection);
        v163.Parent = Lighting;
        local v164 = v157:Clone(Hit.LightingUI);
        v164.Name = "TrickeryAirHitOverlay";
        v164.Parent = LocalPlayer.PlayerGui;
        v162.Label = v164.R;
        local v165 = v157:Construct(u3);
        v165:LoadAndConvertSave(Hit.Moon, {
            ColorCorrection = v163,
            CurrentCamera = workspace_CurrentCamera
        });
        v165:PlayAll();
        v157:Add(function() -- Line: 785
            -- upvalues: workspace_CurrentCamera (copy), FieldOfView (copy)
            workspace_CurrentCamera.FieldOfView = FieldOfView;
        end);
    end;

    u5.execute_compiled(Hit.Compiled, u156, v160, v161, v162, v157);
    u156:Add(task.delay(math_max_ret, u156.Destroy, u156));
end;

function v9.otCutIn_2011x(p166) -- Line: 794
    -- upvalues: u5 (copy), u2 (copy), u6 (copy), play2011x (copy), Lighting (copy), u3 (copy)
    local Root = u5.getRoot(p166);
    local v167 = u5.getResources().OvertimeCutIn.Styles["2011x"];
    local v168 = u5.character_trove(p166);
    v168:Add(function() -- Line: 799
        -- upvalues: u5 (ref)
        u5.restore_lighting_properties();
        u5.restore_lighting();
    end);
    local v169 = v168:Clone(v167.VFX);
    local v170 = u5.build_highlights(v169, v168, "_2011xHighlightProperties");
    v170:PivotTo(Root.CFrame);
    v170.Parent = workspace.Effects;
    local v171 = v168:Add(u5.highlight(p166, {
        Name = "Highlight",
        Enabled = true,
        FillTransparency = -2,
        OutlineTransparency = 1,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        FillColor = Color3.new(0.580392182, 0, 0.00784313772),
        OutlineColor = Color3.new(1, 1, 1)
    }));
    v168:Add(u2.kuronaCamToAll(Root, nil, v167.FOV));
    v168:Add(task.delay(v167:GetAttribute("Length"), v168.Destroy, v168));
    u6:play(v167.sound, "default");
    v168:Add(task.delay(0.25, play2011x, p166, 1, v168));
    v168:Add(task.delay(0.7, play2011x, p166, 1, v168));
    v168:Add(task.delay(1.1166666666666667, play2011x, p166, 2, v168));
    local v172 = {
        Lighting = Lighting,
        Vignette = v168:Add(u5.getMoonEffects()).Vignette,
        Highlight = v171,
        Workspace = v170
    };
    u5.contain_lighting(v168, v172, v167.Lighting);
    local v173 = v168:Construct(u3);
    v173:LoadSave(v167.Moon, u3.ConvertSave(v167.Moon, v172));
    v173:SetOriginalRoot(CFrame.new(-4.888, 3, -16.991) * CFrame.Angles(-0, -1.5707963267948966, 0));
    v173:SetRoot(Root);
    v173:PlayAll();
end;

function v9.flowWhAT(u174, p175) -- Line: 846
    -- upvalues: u5 (copy), Lighting (copy), u2 (copy), u6 (copy), u3 (copy), build_rig_appearance (copy), u1 (copy), u7 (copy)
    local Root = u5.getRoot(u174);
    local Flow = u5.getResources()["2011x"].Flow;
    local CFrame_new_ret = CFrame.new(
        -536.4862060546875,
        3.0325145721435547,
        1274.154296875,
        1,
        0,
        0.000019039456674363464,
        0,
        1,
        0,
        -0.000019039456674363464,
        0,
        1
    );
    local CFrame_new_ret2 = CFrame.new(0, 0, 0, 1, 0, 0.00001920828981383238, 0, 1, 0, -0.00001920828981383238, 0, 1);
    local u176 = u5.character_trove(u174);
    local Ambient = Lighting.Ambient;
    local OutdoorAmbient = Lighting.OutdoorAmbient;
    u2.sceneEnabled(true);
    u176:Add(function() -- Line: 859
        -- upvalues: u2 (ref)
        u2.sceneEnabled(false);
    end);
    u176:Add(function() -- Line: 863
        -- upvalues: u5 (ref), Lighting (ref), Ambient (copy), OutdoorAmbient (copy)
        u5.restore_lighting_properties();
        u5.restore_lighting();
        Lighting.Ambient = Ambient;
        Lighting.OutdoorAmbient = OutdoorAmbient;
    end);
    local v177 = u176:Clone(Flow.VFX);
    local v178 = u5.build_highlights(v177, u176, "_2011xHighlightProperties");
    local v179 = v178.S2["2011x flownew"];

    for _, descendant in v178.S2:GetDescendants() do
        if descendant:IsA("BasePart") and not descendant:IsDescendantOf(v179) then
            descendant.Transparency = 1;
        end;
    end;

    local v180 = CFrame_new_ret:ToObjectSpace(Flow.VFX:GetPivot());
    v178:PivotTo(Root.CFrame * v180);
    v178.Parent = workspace.Effects;
    local v181 = Flow.VFX:GetPivot():ToObjectSpace(CFrame_new_ret2);
    local v182, v183, u184 = u2.cutsceneCamRigWithLetterBox(v178.Rooter, Flow.Animations.Cam, Flow["FOV_2011x flow"], nil, v181, Flow["CamRigWithLetterBox "], "cam");

    if v183 then
        u176:Add(v183);
    end;

    if u184 then
        u176:Add(task.delay(28.65, function() -- Line: 898
            -- upvalues: u184 (copy)
            if u184.IsPlaying then
                u184:AdjustSpeed(0);
                u184.TimePosition = math.max(0, u184.Length - 0.016666666666666666);
            end;
        end));
    end;

    local v185 = {};

    for _, child in Flow.CharacterEffects:GetChildren() do
        local v186 = u174:FindFirstChild(child.Name);

        if v186 and v186:IsA("BasePart") then
            local v187 = {};
            v185[child.Name] = v187;

            for _, child2 in child:GetChildren() do
                local v188 = u176:Clone(child2);
                local v189 = u5.build_highlights(v188, u176, "_2011xHighlightProperties");
                v189.Parent = v186;
                table.insert(v187, v189);
            end;
        end;
    end;

    u6:play(Flow.SFX, "default");
    local v190 = u176:Add(u5.getMoonEffects());
    local v191 = {
        Lighting = Lighting,
        Vignette = v190.Vignette,
        ["Screen Cover"] = v190["Screen Cover"],
        Workspace = v178
    };
    u5.contain_lighting(u176, v191, Flow.Lighting);
    local v192 = u176:Construct(u3);
    v192:SetOriginalRoot(CFrame_new_ret);
    v192:SetRoot(Root);
    v192:LoadSave(Flow.Moon, u3.ConvertSave(Flow.Moon, v191));
    v192:PlayAll();

    for i = 1, 4 do
        local v193 = v178:FindFirstChild((`S{i}`));
        local v194;

        if v193 then
            if i ~= 2 then
                u176:Add(task.defer(build_rig_appearance, v193, u174));
            end;

            local v195 = u1:loadAnimation(v193, Flow.Animations.Victims[tostring(i)]);

            if v195 then
                u176:Add(v195, "Stop");
                v195:Play(0);
                v194 = i;
            else
                v194 = i;
            end;
        else
            v194 = i;
        end;
    end;

    u5.execute_compiled(Flow.Compiled, u176, v178, v182, v185);
    u176:Add(task.delay(9.783333333333333, function() -- Line: 956
        -- upvalues: Lighting (ref)
        Lighting.Ambient = Color3.fromRGB(70, 70, 70);
        Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    end));
    u176:Add(task.delay(18.416666666666668, function() -- Line: 961
        -- upvalues: Lighting (ref), Ambient (copy), OutdoorAmbient (copy)
        Lighting.Ambient = Ambient;
        Lighting.OutdoorAmbient = OutdoorAmbient;
    end));
    u176:Add(task.delay(2.6666666666666665, function() -- Line: 966
        -- upvalues: u176 (copy), u7 (ref), u174 (copy)
        u176:Add(u7.Speak(u174, {
            {
                Text = "Once you shed your gaze for the unknown...",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(215, 225, 225)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 0.5,
                    Lifetime = 0.5
                }
            }
        }, 3.7));
    end));
    u176:Add(task.delay(5.666666666666667, function() -- Line: 992
        -- upvalues: u176 (copy), u7 (ref), u174 (copy)
        u176:Add(u7.Speak(u174, {
            {
                Text = "You\'re welcomed into a wonderful world.",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(205, 215, 215)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 250, 250)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 0.75,
                    Lifetime = 0.6
                }
            }
        }, 3.5));
    end));
    u176:Add(task.delay(13, function() -- Line: 1018
        -- upvalues: u176 (copy), u7 (ref), u174 (copy)
        u176:Add(u7.Speak(u174, {
            {
                Text = "Keep this... ",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.055,
                Pause = 0.5,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 205, 205)), ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 240, 240)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 0.8
                }
            },
            {
                Text = "interesting for me.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.07,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 205, 205)), ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 240, 240)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 0.8
                }
            }
        }, 3.7));
    end));
    u176:Add(task.delay(24.666666666666668, function() -- Line: 1067
        -- upvalues: u176 (copy), u7 (ref), u174 (copy)
        u176:Add(u7.Speak(u174, {
            {
                Text = "YOU SHOULDN\'T HAVE GONE LOOKING FOR ME.",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(115, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(65, 0, 0)) }),
                TextStrokeColor = Color3.fromRGB(5, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 4.4));
    end));
    u176:Add(task.delay(p175, function() -- Line: 1094
        -- upvalues: u176 (copy)
        u176:Destroy();
    end));
end;

function v9.x2011_altisimus(u196: any, p197: number, u198: string?) -- Line: 1099
    -- upvalues: u5 (copy), RunService (copy)
    local Root = u5.getRoot(u196);

    if not Root or u198 and u196:GetAttribute(u198) then
        return;
    end;

    local Shot = u5.getResources()["2011x"].Altisimus.Shot;
    local u199 = u5.character_trove(u196);

    if u198 then
        u199:Add(u196:GetAttributeChangedSignal(u198):Connect(function() -- Line: 1109
            -- upvalues: u196 (copy), u198 (copy), u199 (copy)
            if u196:GetAttribute(u198) then
                u199:Destroy();
            end;
        end));
    end;

    local v200 = u199:Extend();
    local _, v201 = u5.buildFromRig(u196, Shot["1"], v200);

    for _, v in v201 do
        u5.build_highlights(v, v200, "_2011xHighlightProperties");
    end;

    v200:Add(task.delay(p197, v200.Destroy, v200));
    local v202 = u199:Clone(Shot.VFX);
    local u203 = u5.build_highlights(v202, u199, "_2011xHighlightProperties");
    u203:PivotTo(Root.CFrame);
    u203.Parent = workspace.Effects;
    u199:Add(RunService.PreRender:Connect(function() -- Line: 1125
        -- upvalues: u203 (copy), u196 (copy)
        if u203 then
            u203:PivotTo(u196:GetPivot());
        end;
    end));
    u5.execute_compiled(Shot.Compiled, u199, u203, u196);
    local v204 = 1.0666666666666667 + u5.getEmittersLifetime(u203) + 0.25;
    local math_max_ret = math.max(p197, v204);
    u199:Add(task.delay(math_max_ret, u199.Destroy, u199));
end;

function v9.x2011_altisimus_counter(u205: any, u206: any, p207, p208: number, u209: string) -- Line: 1137
    -- upvalues: u5 (copy)
    if not (u5.getRoot(u205) and (u5.getRoot(u206) and not u205:GetAttribute(u209))) then
        return;
    end;

    local Counter = u5.getResources()["2011x"].Altisimus.Counter;
    local u210 = u5.character_trove(u205);
    local v211 = u210:Extend();
    u210:Add(u205:GetAttributeChangedSignal(u209):Connect(function() -- Line: 1146
        -- upvalues: u205 (copy), u209 (copy), u210 (copy)
        if u205:GetAttribute(u209) then
            u210:Destroy();
        end;
    end));
    u210:Add(u206.AncestryChanged:Connect(function() -- Line: 1151
        -- upvalues: u206 (copy), u210 (copy)
        if not u206:IsDescendantOf(workspace) then
            u210:Destroy();
        end;
    end));
    local _, v212 = u5.buildFromRig(u205, Counter["1"], v211);

    for _, v in v212 do
        u5.build_highlights(v, v211, "_2011xHighlightProperties");
    end;

    v211:Add(task.delay(p208, v211.Destroy, v211));
    local v213 = u210:Clone(Counter.VFX);
    local v214 = u5.build_highlights(v213, u210, "_2011xHighlightProperties");
    v214:PivotTo(p207);
    v214.Parent = workspace.Effects;
    u5.execute_compiled(Counter.Compiled, u210, v214, u205, u206);
    local v215 = 2.6 + u5.getEmittersLifetime(v214) + 0.25;
    local math_max_ret = math.max(p208, v215);
    u210:Add(task.delay(math_max_ret, u210.Destroy, u210));
end;

function v9.elevenX_idleflow(u216: any, u217: userdata) -- Line: 1170
    -- upvalues: u5 (copy), u3 (copy)
    if not (u5.getRoot(u216) and u217.IsPlaying) then
        return;
    end;

    local IdleSon = u5.getResources()["2011x"].Flow.IdleSon;
    local v218 = { "Torso", "Right Leg", "Right Arm", "Left Leg", "Left Arm", "Head" };

    for _, v in v218 do
        if not u216:FindFirstChild(v) then
            return;
        end;
    end;

    local u219 = u5.character_trove(u216);
    local u220 = u219:Extend();
    local v221 = u219:Clone(IdleSon.ExeHighlight);
    local u222 = u5.build_highlights(v221, u219, "_2011xHighlightProperties");
    u222.Adornee = u216;
    u222.Enabled = false;
    u222.Parent = u216;
    local u223 = {
        glitches = {}
    };

    for _, v in v218 do
        local v224 = u219:Clone(IdleSon["1"][v].glitch);
        local v225 = u5.build_highlights(v224, u219, "_2011xHighlightProperties");
        v225.Parent = u216[v];
        table.insert(u223.glitches, v225);
    end;

    local v226 = u219:Clone(IdleSon["1"].Torso.text);
    u223.text = u5.build_highlights(v226, u219, "_2011xHighlightProperties");
    u223.text.Parent = u216.Torso;

    local function playLoop() -- Line: 1199
        -- upvalues: u220 (copy), u217 (copy), u3 (ref), IdleSon (copy), u222 (copy), u5 (ref), u223 (copy), u216 (copy)
        u220:Clean();

        if not u217.IsPlaying then
            return;
        end;

        local v227 = u220:Construct(u3);
        v227:LoadAndConvertSave(IdleSon.Moon, {
            ExeHighlight = u222
        });
        v227:PlayAll();
        u5.execute_compiled(IdleSon.Compiled, u220, u223, u216, u220);
    end;

    u219:Add(u217.Stopped:Connect(function() -- Line: 1211
        -- upvalues: u219 (copy)
        u219:Destroy();
    end));
    u219:Add(u217.DidLoop:Connect(playLoop));
    playLoop();
end;

local function createRock(p228, p229, p230) -- Line: 1220
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    Part.Size = Vector3.new(1, 1, 1) * p229;
    Part.Material = p228.Material;
    local v231;

    if p228.Instance:IsA("Terrain") then
        v231 = workspace.Terrain:GetMaterialColor(p228.Material);
    else
        v231 = p228.Instance.Color;
    end;

    Part.Color = v231;

    if p228.Instance:IsA("BasePart") then
        Part.MaterialVariant = p228.Instance.MaterialVariant;
    end;

    Part.CFrame = CFrame.new(p230);
    Part.Parent = workspace.Effects;

    return Part;
end;

local u232 = nil;
local u233 = nil;
local u234 = nil;
local u235 = 0;
local u236 = 0;
local u237 = nil;

local function startAtmosphere() -- Line: 1248
    -- upvalues: u237 (ref), RunService (copy), ReplicatedStorage (copy), CollectionService (copy), u236 (ref), u2 (copy), u235 (ref), u232 (ref), u8 (copy), u233 (ref), Lighting (copy), u234 (ref)
    if u237 then
        return;
    end;

    u237 = RunService.PreRender:Connect(function(p238) -- Line: 1253
        -- upvalues: ReplicatedStorage (ref), CollectionService (ref), u236 (ref), u2 (ref), u235 (ref), u232 (ref), u237 (ref), u8 (ref), u233 (ref), Lighting (ref), u234 (ref)
        if ReplicatedStorage.workspace.disabled.Value then
            return;
        end;

        local math_min_ret = math.min(p238, 0.1);
        local v239 = 0;
        local v240 = 0;
        local v241 = 0;

        for _, v in CollectionService:GetTagged("TheHole") do
            if v:IsDescendantOf(workspace) and v:GetAttribute("Active") == true then
                local v242 = v:GetAttribute("Charge") or 0;
                local math_clamp_ret = math.clamp(v242, 0, 1);
                v239 = math.max(v239, math_clamp_ret);
                local Weld = v:FindFirstChild("Weld");

                if Weld and Weld.Part0 then
                    local math_clamp_ret2 = math.clamp(1 - (workspace.CurrentCamera.CFrame.Position - Weld.Part0.Position).Magnitude / (math_clamp_ret * 500 + 300), 0, 1);
                    local v243 = (math_clamp_ret * 1.2 + 0.15 + math_clamp_ret ^ 4 * 4.5) * math_clamp_ret2;

                    if v240 < v243 then
                        v241 = math_clamp_ret;
                        v240 = v243;
                    end;
                end;
            end;
        end;

        u236 = u236 + math_min_ret;

        if v240 > 0 and u236 >= 0.18 then
            u236 = 0;
            u2.cameraShake(v241 * 18 + 12 + v241 ^ 3 * 25, 0.18, v240);
        elseif v240 == 0 then
            u236 = 0;
        end;

        u235 = u235 + (v239 - u235) * math.min(1, math_min_ret * (u235 < v239 and 5 or 3));

        if u235 < 0.001 and v239 == 0 then
            u235 = 0;

            if u232 then
                u232:Destroy();
                u232 = nil;
            end;

            u237:Disconnect();
            u237 = nil;

            return;
        end;

        if not u232 then
            u232 = u8.new();
            u233 = u232:Add(Instance.new("ColorCorrectionEffect"));
            u233.Parent = Lighting;
            u234 = u232:Add(Instance.new("BloomEffect"));
            u234.Intensity = 0;
            u234.Threshold = 1.2;
            u234.Size = 32;
            u234.Parent = Lighting;
        end;

        local v244 = u235 ^ 1.3;
        u233.Brightness = v244 * -0.3;
        u233.Contrast = v244 * 0.32;
        u233.Saturation = v244 * -0.12;
        u233.TintColor = Color3.new(1, 1, 1):Lerp(Color3.fromRGB(255, 184, 148), v244);
        u234.Intensity = v244 * 0.8;
    end);
end;

local function orbitRock(u245, u246, u247, p248, u249, p250) -- Line: 1330
    -- upvalues: u8 (copy), createRock (copy), RunService (copy), ReplicatedStorage (copy)
    local u251 = u245:Construct(u8);
    local Position = p248.Position;
    local u252 = u251:Add((createRock(p248, p250:NextNumber(0.5, 1.8) * (1 + u247.Value * 3), Position)));
    local Size = u252.Size;
    local u253 = 0;
    local u254 = 0;
    u251:Add(RunService.PreRender:Connect(function(p255) -- Line: 1338
        -- upvalues: u246 (copy), u245 (copy), u251 (copy), ReplicatedStorage (ref), u247 (copy), u253 (ref), u249 (ref), u254 (ref), Position (copy), u252 (copy), Size (copy)
        if u246:GetAttribute("Active") ~= true then
            u245:Remove(u251);

            return;
        end;

        if ReplicatedStorage.workspace.disabled.Value then
            return;
        end;

        local math_min_ret = math.min(p255, 0.1);
        local Value = u247.Value;
        u253 = u253 + math_min_ret * (0.22 + Value ^ 2 * 1.4);
        u249 = u249 + math_min_ret * (0.25 + Value ^ 2 * 7);
        u254 = u254 + math_min_ret * (0.2 + Value ^ 2 * 4);

        if u253 >= 3 then
            u245:Remove(u251);

            return;
        end;

        local v256 = (3 + Value * 105) * math.clamp((3 - u253) / 0.8, 0, 1);
        local Position2 = u246.Position;
        local v257 = math.cos(u249) * v256;
        local v258 = math.sin(u249 * 0.6) * v256 * 0.4;
        local v259 = math.sin(u249) * v256;
        local v260 = Position2 + Vector3.new(v257, v258, v259);
        local math_min_ret2 = math.min(1, u253 / 1.2);
        local v261 = Position:Lerp(v260, math_min_ret2 * math_min_ret2 * (3 - math_min_ret2 * 2));
        u252.CFrame = CFrame.new(v261) * CFrame.Angles(u254 * 2, u249, u254);
        u252.Size = Size * math.clamp((3 - u253) / 0.5, 0.05, 1);
    end));

    return u251;
end;

local function attachBlackhole(u262) -- Line: 1373
    -- upvalues: u8 (copy), RunService (copy), orbitRock (copy), u237 (ref), ReplicatedStorage (copy), CollectionService (copy), u236 (ref), u2 (copy), u235 (ref), u232 (ref), u233 (ref), Lighting (copy), u234 (ref)
    if u262:FindFirstChild("BVFX") or not u262:IsDescendantOf(workspace) then
        return;
    end;

    local u263 = u8.new();
    u263:AttachToInstance(u262);
    local v264 = u263:Construct(Instance.new, "Folder");
    v264.Name = "BVFX";
    v264.Parent = u262;
    u263:Add(v264.Destroying:Connect(function() -- Line: 1385
        -- upvalues: u263 (copy)
        u263:Destroy();
    end));
    local Weld = u262:WaitForChild("Weld", 5);

    if not (Weld and v264.Parent) then
        u263:Destroy();

        return;
    end;

    local os_clock_ret = os.clock();

    while not (Weld.Part0 or (not u262.Parent or os.clock() - os_clock_ret >= 5)) do
        RunService.Heartbeat:Wait();
    end;

    if not (Weld.Part0 and v264.Parent) then
        u263:Destroy();

        return;
    end;

    local C0 = Weld.C0;
    local Size = u262.Size;
    local u265 = u262:GetAttribute("RestoreTransparency") or u262.Transparency;
    local Attribute = u262:GetAttribute("ReappearAt");
    local u266 = u263:Construct(Instance.new, "NumberValue");
    local u267 = u263:Construct(Instance.new, "NumberValue");
    local u268 = u263:Construct(Instance.new, "NumberValue");
    local Random_new_ret = Random.new();
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.map, workspace.Terrain };
    RaycastParams_new_ret.RespectCanCollide = true;
    u266.Value = u262:GetAttribute("Charge") or 0;

    for _, descendant in u262:GetDescendants() do
        if descendant:IsA("Attachment") then
            local Position = descendant.Position;
            u263:Add(u267.Changed:Connect(function(p269) -- Line: 1427
                -- upvalues: descendant (copy), Position (copy)
                descendant.Position = Position * p269;
            end));
        elseif descendant:IsA("ParticleEmitter") then
            local Size2 = descendant.Size;
            local Speed = descendant.Speed;
            local Transparency = descendant.Transparency;
            local u270 = descendant:GetAttribute("BlackholeEnabled") == true;
            u263:Add(u267.Changed:Connect(function(p271) -- Line: 1436
                -- upvalues: Size2 (copy), descendant (copy), Speed (copy)
                local v272 = {};

                for i, v in Size2.Keypoints do
                    v272[i] = NumberSequenceKeypoint.new(v.Time, v.Value * p271, v.Envelope * p271);
                end;

                descendant.Size = NumberSequence.new(v272);
                descendant.Speed = NumberRange.new(Speed.Min * p271, Speed.Max * p271);
            end));

            local function updateFade() -- Line: 1447
                -- upvalues: Transparency (copy), u268 (copy), descendant (copy), u270 (copy)
                local v273 = {};

                for i, v in Transparency.Keypoints do
                    v273[i] = NumberSequenceKeypoint.new(v.Time, 1 - (1 - v.Value) * u268.Value, v.Envelope * u268.Value);
                end;

                descendant.Transparency = NumberSequence.new(v273);
                descendant.Enabled = u270 and u268.Value > 0;
            end;

            u263:Add(u268.Changed:Connect(updateFade));
            updateFade();
        end;
    end;

    local u274 = 0;
    local u275 = 0;
    local u276 = nil;

    local function updateVisuals(p277) -- Line: 1467
        -- upvalues: u262 (copy), u266 (copy), Attribute (copy), u265 (copy), Size (copy), Weld (copy), C0 (copy), u267 (copy), u268 (copy), u275 (ref), u274 (ref), Random_new_ret (copy), RaycastParams_new_ret (copy), orbitRock (ref), u263 (copy), u276 (ref)
        local v278 = u262:GetAttribute("Charge") or 0;
        local v279 = u266.Value + (v278 - u266.Value) * (1 - math.exp(-p277 * 8));

        if math.abs(v278 - v279) < 0.0001 then
            v279 = v278;
        end;

        u266.Value = v279;
        local v280;

        if Attribute then
            local v281 = (workspace:GetServerTimeNow() - Attribute) / 2;
            v280 = math.clamp(v281, 0, 1);
        else
            v280 = 1;
        end;

        local v282 = v280 * v280 * (3 - v280 * 2);
        local v283 = (1 + v279 * 124) * math.max(0.05, v282);
        u262.Transparency = 1 - (1 - u265) * v282;
        u262.Size = Size * v283;
        Weld.C0 = C0 * CFrame.new(0, v279 * 100, 0);
        u267.Value = v283;
        u268.Value = v282;
        local v284 = u262:GetAttribute("Active") == true;
        u275 = u275 + p277;

        if v284 and (u275 >= 0.5 - v279 * 0.42 and u274 < 24) then
            u275 = 0;
            local v285 = Random_new_ret:NextNumber(0, 6.283185307179586);
            local v286 = Random_new_ret:NextNumber(8, 20 + v279 * 130);
            local Position = u262.Position;
            local v287 = math.cos(v285) * v286;
            local v288 = math.sin(v285) * v286;
            local v289 = Position + Vector3.new(v287, 25, v288);
            local v290 = workspace:Raycast(v289, Vector3.new(0, -400, 0), RaycastParams_new_ret);

            if v290 then
                u274 = u274 + 1;
                orbitRock(u263, u262, u266, v290, v285, Random_new_ret):Add(function() -- Line: 1502
                    -- upvalues: u274 (ref)
                    u274 = u274 - 1;
                end);
            end;
        end;

        if not (v284 or (v279 ~= v278 or (v280 ~= 1 or not u276))) then
            u263:Remove(u276);
            u276 = nil;
        end;
    end;

    local function startUpdating() -- Line: 1514
        -- upvalues: u262 (copy), u237 (ref), RunService (ref), ReplicatedStorage (ref), CollectionService (ref), u236 (ref), u2 (ref), u235 (ref), u232 (ref), u8 (ref), u233 (ref), Lighting (ref), u234 (ref), u276 (ref), u263 (copy), updateVisuals (copy)
        if u262:GetAttribute("Active") == true and not u237 then
            u237 = RunService.PreRender:Connect(function(p291) -- Line: 1253
                -- upvalues: ReplicatedStorage (ref), CollectionService (ref), u236 (ref), u2 (ref), u235 (ref), u232 (ref), u237 (ref), u8 (ref), u233 (ref), Lighting (ref), u234 (ref)
                if ReplicatedStorage.workspace.disabled.Value then
                    return;
                end;

                local math_min_ret = math.min(p291, 0.1);
                local v292 = 0;
                local v293 = 0;
                local v294 = 0;

                for _, v in CollectionService:GetTagged("TheHole") do
                    if v:IsDescendantOf(workspace) and v:GetAttribute("Active") == true then
                        local v295 = v:GetAttribute("Charge") or 0;
                        local math_clamp_ret = math.clamp(v295, 0, 1);
                        v292 = math.max(v292, math_clamp_ret);
                        local Weld2 = v:FindFirstChild("Weld");

                        if Weld2 and Weld2.Part0 then
                            local math_clamp_ret2 = math.clamp(1 - (workspace.CurrentCamera.CFrame.Position - Weld2.Part0.Position).Magnitude / (math_clamp_ret * 500 + 300), 0, 1);
                            local v296 = (math_clamp_ret * 1.2 + 0.15 + math_clamp_ret ^ 4 * 4.5) * math_clamp_ret2;

                            if v293 < v296 then
                                v294 = math_clamp_ret;
                                v293 = v296;
                            end;
                        end;
                    end;
                end;

                u236 = u236 + math_min_ret;

                if v293 > 0 and u236 >= 0.18 then
                    u236 = 0;
                    u2.cameraShake(v294 * 18 + 12 + v294 ^ 3 * 25, 0.18, v293);
                elseif v293 == 0 then
                    u236 = 0;
                end;

                u235 = u235 + (v292 - u235) * math.min(1, math_min_ret * (u235 < v292 and 5 or 3));

                if u235 < 0.001 and v292 == 0 then
                    u235 = 0;

                    if u232 then
                        u232:Destroy();
                        u232 = nil;
                    end;

                    u237:Disconnect();
                    u237 = nil;

                    return;
                end;

                if not u232 then
                    u232 = u8.new();
                    u233 = u232:Add(Instance.new("ColorCorrectionEffect"));
                    u233.Parent = Lighting;
                    u234 = u232:Add(Instance.new("BloomEffect"));
                    u234.Intensity = 0;
                    u234.Threshold = 1.2;
                    u234.Size = 32;
                    u234.Parent = Lighting;
                end;

                local v297 = u235 ^ 1.3;
                u233.Brightness = v297 * -0.3;
                u233.Contrast = v297 * 0.32;
                u233.Saturation = v297 * -0.12;
                u233.TintColor = Color3.new(1, 1, 1):Lerp(Color3.fromRGB(255, 184, 148), v297);
                u234.Intensity = v297 * 0.8;
            end);
        end;

        if u276 then
            return;
        end;

        u276 = u263:Add(RunService.PreRender:Connect(function(p298) -- Line: 1523
            -- upvalues: ReplicatedStorage (ref), updateVisuals (ref)
            if not ReplicatedStorage.workspace.disabled.Value then
                updateVisuals((math.min(p298, 0.1)));
            end;
        end));
    end;

    u263:Add(u262:GetAttributeChangedSignal("Active"):Connect(startUpdating));
    u263:Add(u262:GetAttributeChangedSignal("Charge"):Connect(startUpdating));
    updateVisuals(0);

    if u262:GetAttribute("Active") == true or u268.Value < 1 then
        startUpdating();
    end;
end;

local function explosionRocks(p299) -- Line: 1541
    -- upvalues: u8 (copy), createRock (copy), TweenService (copy)
    local u300 = u8.new();
    local Random_new_ret = Random.new();
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.map, workspace.Terrain };
    RaycastParams_new_ret.RespectCanCollide = true;

    for i = 1, 28 do
        local v301 = Random_new_ret:NextNumber(0, 6.283185307179586);
        local math_cos_ret = math.cos(v301);
        local math_sin_ret = math.sin(v301);
        local Vector3_new_ret = Vector3.new(math_cos_ret, 0, math_sin_ret);
        local v302 = p299.Position + Vector3_new_ret * Random_new_ret:NextNumber(8, 65);
        local v303 = workspace:Raycast(v302 + Vector3.new(0, 30, 0), Vector3.new(0, -700, 0), RaycastParams_new_ret);
        local v304;

        if v303 then
            local u305 = u300:Add((createRock(v303, Random_new_ret:NextNumber(2, 6), v302)));
            u305.CollisionGroup = "DashCollide";
            u305.CanCollide = true;
            u305.Anchored = false;
            local v306 = Vector3_new_ret * Random_new_ret:NextNumber(35, 110);
            local v307 = Random_new_ret:NextNumber(25, 70);
            u305.AssemblyLinearVelocity = v306 + Vector3.new(0, v307, 0);
            local v308 = Random_new_ret:NextNumber(-4, 4);
            local v309 = Random_new_ret:NextNumber(-4, 4);
            u305.AssemblyAngularVelocity = Vector3.new(v308, v309, Random_new_ret:NextNumber(-4, 4));
            u300:Add(task.delay(3, function() -- Line: 1563
                -- upvalues: u300 (copy), TweenService (ref), u305 (copy)
                u300:Add(TweenService:Create(u305, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Transparency = 1,
                    Size = Vector3.new(0, 0, 0)
                }), "Cancel"):Play();
            end));
            v304 = i;
        else
            v304 = i;
        end;
    end;

    task.delay(4.6, function() -- Line: 1573
        -- upvalues: u300 (copy)
        u300:Destroy();
    end);
end;

function v9.exeBlackholeExplosion(p310, p311: number) -- Line: 1578
    -- upvalues: u2 (copy), explosionRocks (copy), u5 (copy), TweenService (copy)
    u2.cameraShake(50, 1.5, 6, { p310, p311 });
    explosionRocks(p310);
    local v312 = u5.createVFX(u5.getResources().exe.Blackhole.ExplodeAfterHole, "default", p310);
    local Model = Instance.new("Model");
    v312.Parent = Model;
    Model.PrimaryPart = v312;
    Model.Parent = workspace.Effects;
    Model:ScaleTo(p311 / 60);

    for _, descendant in v312:GetDescendants() do
        u5.emit(descendant, true);
    end;

    u5.disposal(Model, (math.max(5, u5.getEmittersLifetime(v312))));
    local Part = Instance.new("Part");
    local SpecialMesh = Instance.new("SpecialMesh");
    SpecialMesh.MeshType = Enum.MeshType.Sphere;
    SpecialMesh.Scale = Vector3.new(5, 5, 5);
    SpecialMesh.Parent = Part;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3.fromRGB(255, 208, 72);
    Part.Size = Vector3.new(1, 1, 1);
    Part.Transparency = 0.45;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CFrame = p310;
    Part.Parent = workspace.Effects;
    TweenService:Create(SpecialMesh, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Scale = Vector3.new(1, 1, 1) * p311 * 2
    }):Play();
    TweenService:Create(Part, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    u5.disposal(Part, 1.6);
end;

CollectionService:GetInstanceAddedSignal("TheHole"):Connect(attachBlackhole);
CollectionService:GetInstanceRemovedSignal("TheHole"):Connect(function(p313) -- Line: 1619
    local BVFX = p313:FindFirstChild("BVFX");

    if BVFX then
        BVFX:Destroy();
    end;
end);

for _, v in CollectionService:GetTagged("TheHole") do
    attachBlackhole(v);
end;

local u314 = {};

local function body_parts(p315: userdata) -- Line: 1633
    local v316 = {};

    for _, descendant in p315:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            table.insert(v316, descendant);
        end;
    end;

    return v316;
end;

local function set_hidden(p317: table, p318: boolean) -- Line: 1643
    for _, v in p317 do
        v.LocalTransparencyModifier = p318 and 1 or 0;
    end;
end;

function v9.x2011_ego_death_hit(u319: any, u320: userdata?, p321: any) -- Line: 1649
    -- upvalues: u5 (copy), u314 (copy), body_parts (copy), Lighting (copy), u3 (copy), set_hidden (copy)
    local Root = u5.getRoot(u319);

    if not (u320 and Root) then
        return;
    end;

    local Hit = u5.getResources()["2011x"].Trickery.Counter.Hit;
    local u322 = u5.character_trove(u319);
    u314[u319] = u322;
    u322:Add(function() -- Line: 1658
        -- upvalues: u314 (ref), u319 (copy), u322 (copy)
        if u314[u319] == u322 then
            u314[u319] = nil;
        end;
    end);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = game:GetService("Players").LocalPlayer.Character;
    local u323 = u319 == Character;
    local u324 = u319:FindFirstChildOfClass("Humanoid");
    local u325 = body_parts(u319);
    local v326 = body_parts(u320);
    local _, v327 = u5.buildFromRig(u319, Hit.Rigs.User, u322);

    for _, v in v327 do
        u5.build_highlights(v, u322, "_2011xHighlightProperties");
    end;

    local Clone = Hit.Rigs:FindFirstChild("Clone");
    local _, v328 = u5.buildFromRig(u320, Clone, u322);

    for _, v in v328 do
        u5.build_highlights(v, u322, "_2011xHighlightProperties");
    end;

    if p321 then
        local _, v329 = u5.buildFromRig(p321, Hit.Rigs.Victim, u322);

        for _, v in v329 do
            u5.build_highlights(v, u322, "_2011xHighlightProperties");
        end;
    end;

    local v330 = u322:Clone(Hit.VFX);
    v330:PivotTo(Root.CFrame);
    v330.Parent = workspace.Effects;

    if u323 or p321 and p321 == Character then
        for _, child in Hit.Lighting:GetChildren() do
            u322:Clone(child).Parent = Lighting;
        end;

        u322:Add(u5.restore_lighting_properties);
        local v331 = u322:Construct(u3);
        v331:LoadAndConvertSave(Hit.Moon, {
            Lighting = Lighting,
            Workspace = v330
        });
        v331:SetOriginalRoot(Hit.VFX:GetPivot());
        v331:SetRoot(Root);
        v331:PlayAll();
    end;

    u5.execute_compiled(Hit.Compiled, u322, v330, workspace_CurrentCamera, u319, p321, u320);
    u322:Add(task.delay(12.633333333333333, u322.Destroy, u322));

    local function show_user() -- Line: 1696
        -- upvalues: u325 (copy), u323 (copy), u324 (copy), workspace_CurrentCamera (copy)
        for _, v in u325 do
            v.LocalTransparencyModifier = 0;
        end;

        if u323 and u324 then
            workspace_CurrentCamera.CameraSubject = u324;
        end;
    end;

    u322:Add(task.delay(4.2, set_hidden, v326, true));
    u322:Add(task.delay(1.42, function() -- Line: 1704
        -- upvalues: u325 (copy), u320 (copy), u323 (copy), workspace_CurrentCamera (copy)
        for _, v in u325 do
            v.LocalTransparencyModifier = 1;
        end;

        local Head = u320:FindFirstChild("Head");

        if u323 and Head then
            workspace_CurrentCamera.CameraSubject = Head;
        end;
    end));
    u322:Add(task.delay(3.97, show_user));
    u322:Add(show_user);
end;

function v9.x2011_ego_death_quicktime(p332: any, p333: any, p334: number) -- Line: 1715
    -- upvalues: u5 (copy)
    if not (p333 and u5.getRoot(p332)) then
        return;
    end;

    local QuickTime = u5.getResources()["2011x"].Trickery.Counter.QuickTime;
    local v335 = u5.character_trove(p332);
    u5.buildFromRig(p333, QuickTime.Rigs.Victim, v335);
    u5.execute_compiled(QuickTime.Compiled, v335, nil, workspace.CurrentCamera, p332, p333);
    v335:Add(task.delay(p334, v335.Destroy, v335));
end;

function v9.x2011_ego_death_win(p336: any, p337: any, p338: number) -- Line: 1727
    -- upvalues: u314 (copy), u5 (copy), u2 (copy), body_parts (copy), set_hidden (copy), Lighting (copy), u3 (copy)
    local v339 = u314[p336];

    if v339 then
        v339:Destroy();
    end;

    local Root = u5.getRoot(p336);

    if not Root then
        return;
    end;

    local Win = u5.getResources()["2011x"].Trickery.Counter.Win;
    local u340 = u5.character_trove(p336);
    u2.sceneEnabled(true);
    u340:Add(function() -- Line: 1741
        -- upvalues: u2 (ref), u5 (ref)
        u2.sceneEnabled(false);
        u5.restore_lighting_properties();
    end);
    local u341 = {};

    if p337 then
        for _, v in body_parts(p337) do
            if not (v.Name == "Left Arm" or v.Name == "Right Arm" or (v:FindFirstAncestor("Left Arm") or v:FindFirstAncestor("Right Arm")) or v:FindFirstAncestorWhichIsA("Accessory")) then
                table.insert(u341, v);
            end;
        end;
    end;

    local _, v342 = u5.buildFromRig(p336, Win.Rigs.User, u340);

    for _, v in v342 do
        u5.build_highlights(v, u340, "_2011xHighlightProperties");
    end;

    if p337 then
        local _, v343 = u5.buildFromRig(p337, Win.Rigs.Victim, u340);

        for _, v in v343 do
            u5.build_highlights(v, u340, "_2011xHighlightProperties");
        end;
    end;

    u340:Add(task.delay(1.8333333333333333, set_hidden, u341, true));
    u340:Add(task.delay(4.75, set_hidden, u341, false));
    u340:Add(function() -- Line: 1763
        -- upvalues: u341 (copy)
        for _, v in u341 do
            v.LocalTransparencyModifier = 0;
        end;
    end);
    local u344 = {};
    local Head = p336:FindFirstChild("Head");

    if Head then
        table.insert(u344, Head);

        for _, child in Head:GetChildren() do
            if child:IsA("Decal") then
                table.insert(u344, child);
            end;
        end;
    end;

    if p337 then
        for _, child in p337:GetChildren() do
            if child:IsA("Accessory") then
                for _, descendant in child:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        table.insert(u344, descendant);
                    end;
                end;
            end;
        end;
    end;

    for _, v in u344 do
        v.LocalTransparencyModifier = 1;
    end;

    u340:Add(function() -- Line: 1791
        -- upvalues: u344 (copy)
        for _, v in u344 do
            v.LocalTransparencyModifier = 0;
        end;
    end);
    local v345 = u340:Clone(Win.VFX);
    v345:PivotTo(Root.CFrame);
    v345.Parent = workspace.Effects;
    local v346, v347, v348 = u2.cutsceneCamRigWithLetterBox(Root, Win.Animations.Cam, Win.FOV, nil, Win:GetAttribute("CamOffset"), Win.Cam, "Part");

    if v347 then
        u340:Add(v347);
    end;

    if v348 then
        u340:Add(v348.Stopped:Once(function() -- Line: 1814
            -- upvalues: u340 (copy)
            u340:Destroy();
        end));
    end;

    local v349 = {
        Lighting = Lighting,
        Workspace = v345
    };
    u5.cutscene_lighting(u340, v349, Win.Lighting);
    u5.execute_compiled(Win.Compiled, u340, v345, v346, p336, p337);
    local v350 = u340:Construct(u3);
    v350:LoadAndConvertSave(Win.Moon, v349);
    v350:SetOriginalRoot(Win.VFX:GetPivot());
    v350:SetRoot(Root);
    v350:PlayAll();
    u340:Add(task.delay(p338, u340.Destroy, u340));
end;

return v9;