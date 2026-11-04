 

 

local Players = game:GetService("Players");
local u1 = {};
local Parent = script.Parent.Parent;
local AnimationConfig = require(Parent.Animation.AnimationConfig);
local ScythePose = require(script.Parent.ScythePose);
local KnifeClips = require(script.Parent.KnifeClips);
local KnifeVisibility = require(script.Parent.KnifeVisibility);
local EmoteCatalog = require(Parent.Emotes.EmoteCatalog);
local EmotePieces = require(Parent.Emotes.EmotePieces);

local function scaled(p2, p3) -- Line: 13
    return CFrame.new(p2.Position * p3) * p2.Rotation;
end;

function u1.create(p4, p5, p6) -- Line: 16
    -- upvalues: KnifeClips (copy), Players (copy), ScythePose (copy)
    local v7 = p4:Clone();
    v7.Name = p5.Name .. "_Preview";

    for _, descendant in v7:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") or (descendant:IsA("BillboardGui") or (descendant:IsA("SurfaceGui") or descendant:IsA("Tool"))) then
            descendant:Destroy();
        end;
    end;

    for i in v7:GetAttributes() do
        v7:SetAttribute(i, nil);
    end;

    local v8 = v7:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = v7:FindFirstChild("HumanoidRootPart");
    local v9 = v7:FindFirstChild("Right Arm");
    local v10;

    if v8 then
        if HumanoidRootPart then
            v10 = v9;
        else
            v10 = HumanoidRootPart;
        end;
    else
        v10 = v8;
    end;

    assert(v10, "Display requires R6 body");

    for _, child in v8:GetChildren() do
        if child:IsA("Animator") then
            child:Destroy();
        end;
    end;

    v8.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v8.AutoRotate = false;
    v8.BreakJointsOnDeath = false;
    v8.Health = v8.MaxHealth;
    v8.WalkSpeed = 0;
    v8.JumpPower = 0;
    v7.PrimaryPart = HumanoidRootPart;
    v7:ScaleTo(1);
    local v11 = nil;
    local v12 = nil;
    local v13 = nil;
    local v14, v15, v16, v17, v18, v19, v20, v21;

    if p6 then
        v14 = p6:Clone();
        v14.Name = "DisplayKnife";
        local Handle = v14.Handle;
        v15 = v14.Blade;
        v16 = v14.StowedBlade;
        Handle.Transparency = 1;
        v15.Transparency = 0;
        v17 = Instance.new("Motor6D");
        v17.Name = "Handle";
        v17.Part0 = v9;
        v17.Part1 = Handle;
        v17.C0 = require(script.Parent.DaggerGrip).c0(v14);
        v17.C1 = v14:GetAttribute("GripC1");
        Handle.CFrame = v9.CFrame * v17.C0 * v17.C1:Inverse();
        local BladeWeld = Handle:FindFirstChild("BladeWeld");

        if not (BladeWeld and BladeWeld:IsA("JointInstance")) then
            if BladeWeld then
                BladeWeld:Destroy();
            end;

            local BladeWeld2 = p6.Handle:FindFirstChild("BladeWeld");

            if not (BladeWeld2 and BladeWeld2:IsA("JointInstance")) then
                v14:Destroy();
                v7:Destroy();
                error("Knife template has no BladeWeld: " .. p6.Name);
            end;

            BladeWeld = Instance.new("Weld");
            BladeWeld.Name = "BladeWeld";
            BladeWeld.C0 = BladeWeld2.C0;
            BladeWeld.C1 = BladeWeld2.C1;
            BladeWeld.Part0 = Handle;
            BladeWeld.Part1 = v15;
            BladeWeld.Parent = Handle;
        end;

        v15.CFrame = Handle.CFrame * BladeWeld.C0 * BladeWeld.C1:Inverse();
        local Torso = v7.Torso;
        v16.CFrame = Torso.CFrame * v14:GetAttribute("StowedOffset");
        local Weld = Instance.new("Weld");
        Weld.Name = "DisplaySheath";
        Weld.Part0 = Torso;
        Weld.Part1 = v16;
        Weld.C0 = v14:GetAttribute("StowedOffset");
        Weld.Parent = v16;
        local Attribute = v14:GetAttribute("RootPart");

        if type(Attribute) == "string" then
            v18 = v14:FindFirstChild(Attribute);
        else
            v18 = false;
        end;

        if v18 and v18:IsA("BasePart") then
            local RootStow = v18:FindFirstChild("RootStow");

            if RootStow then
                RootStow:Destroy();
            end;

            v12 = Instance.new("Motor6D");
            v12.Name = Attribute;
            v12.Part0 = HumanoidRootPart;
            v12.Part1 = v18;
            v12.C0 = v14:GetAttribute("RootC0") or CFrame.identity;
            v12.C1 = v14:GetAttribute("RootC1") or CFrame.identity;
            v12.Parent = HumanoidRootPart;
            v13 = v14:GetAttribute("RootRest");
        else
            v18 = v11;
        end;

        local DualWield = require(script.Parent.DualWield);
        v19 = DualWield.attach(v14, v7:FindFirstChild("Left Arm"));
        v20 = DualWield.stow(v14, Torso);
        require(script.Parent.WeaponEffects).position(v14);
        v14.Parent = v7;
        v17.Parent = v9;
        v21 = v14:GetAttribute("IdleGrip");
    else
        v18 = v11;
        v14 = nil;
        v20 = nil;
        v21 = nil;
        v17 = nil;
        v15 = nil;
        v16 = nil;
        v19 = nil;
    end;

    local v22 = KnifeClips.animated(v14);

    for _, descendant in v7:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = descendant == HumanoidRootPart;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Massless = descendant ~= HumanoidRootPart;
            descendant.LocalTransparencyModifier = 0;
        end;
    end;

    local v23 = p5:GetAttribute("DisplayScale") or p5:GetScale();
    v7:ScaleTo(v23);
    v7:PivotTo(p5:GetPivot());
    local v24 = p5:FindFirstChild("Left Leg");
    local v25 = v7:FindFirstChild("Left Leg");

    if v24 and v25 then
        local v26 = v24.Position.Y - v24.Size.Y * 0.5;
        local v27 = v25.Position.Y - v25.Size.Y * 0.5;
        v7:PivotTo(v7:GetPivot() + Vector3.new(0, v26 - v27, 0));
    end;

    v7:SetAttribute("LobbyKnifeDisplay", true);
    v7:SetAttribute("LocalAvatarUserId", Players.LocalPlayer and Players.LocalPlayer.UserId or 0);
    local Animator = Instance.new("Animator");
    Animator.Parent = v8;
    local v28 = {
        model = v7,
        root = HumanoidRootPart,
        humanoid = v8,
        animator = Animator,
        motor = v17
    };
    local v29;

    if v22 or typeof(v21) ~= "CFrame" then
        v29 = nil;
    else
        v29 = CFrame.new(v21.Position * v23) * v21.Rotation or nil;
    end;

    v28.idle = v29;
    v28.blade = v15;
    v28.stowed = v16;
    v28.leftBlade = v19;
    v28.leftStowed = v20;
    v28.knife = v14;
    v28.ball = v18;
    v28.rootMotor = v12;
    local v30;

    if typeof(v13) == "CFrame" then
        v30 = CFrame.new(v13.Position * v23) * v13.Rotation or nil;
    else
        v30 = nil;
    end;

    v28.rest = v30;
    local v31;

    if v14 and not (v22 or KnifeClips.custom(v14, "Dive")) then
        v31 = ScythePose.new(v14) or nil;
    else
        v31 = nil;
    end;

    v28.scythe = v31;
    v28.scale = v23;
    v28.basePivot = v7:GetPivot();
    v28.tracks = {};
    v28.assets = {};
    v28.rates = {};
    v28.custom = {};
    v28.cueFired = {};

    return v28;
end;

u1.Sequence = {
    {
        label = "IDLE",
        clip = "Idle",
        duration = 1.6
    },
    {
        label = "DRAW",
        clip = "DaggerEquip",
        duration = 0.94,
        held = true,
        draw = true,
        cues = { { 0.08, "Equip" } }
    },
    {
        label = "READY",
        clip = "Idle",
        duration = 1.5,
        held = true
    },
    {
        label = "WALK",
        clip = "Walk",
        duration = 2,
        held = true,
        steps = 0.52
    },
    {
        label = "RUN",
        clip = "Run",
        duration = 2.2,
        held = true,
        steps = 0.3
    },
    {
        label = "STOP",
        clip = "Stop",
        duration = 1.65,
        held = true,
        cues = { { 0.1, "RunStop" } }
    },
    {
        label = "WIND-UP",
        clip = "DaggerWindup",
        duration = 0.65,
        held = true,
        windup = true,
        cues = { { 0.04, "Windup" } }
    },
    {
        label = "STAB",
        clip = "DaggerStab",
        duration = 0.84,
        held = true,
        cues = { { 0.04, "Swing" }, { 0.26, "Hit" } }
    },
    {
        label = "RECOVER",
        clip = "Idle",
        duration = 1,
        held = true
    },
    {
        label = "DIVE",
        clip = "DaggerDive",
        duration = 0.72,
        held = true,
        cues = { { 0.02, "Dive" }, { 0.32, "Hit" } }
    },
    {
        label = "RECOVER",
        clip = "Idle",
        duration = 1.3,
        held = true
    },
    {
        label = "WIND-UP",
        clip = "DaggerWindup",
        duration = 0.48,
        held = true,
        windup = true,
        cues = { { 0.04, "Windup" } }
    },
    {
        label = "CANCEL",
        clip = "Idle",
        duration = 0.65,
        held = true,
        cues = { { 0.04, "Cancel" } }
    },
    {
        label = "SHEATHE",
        clip = "DaggerEquip",
        duration = 0.94,
        held = true,
        reverse = true,
        cues = { { 0.7, "Sheath" } }
    },
    {
        label = "RUNNER WALK",
        clip = "Walk",
        duration = 1.5,
        steps = 0.52
    },
    {
        label = "RUNNER RUN",
        clip = "Run",
        duration = 1.8,
        steps = 0.3
    },
    {
        label = "MOVE LEFT",
        clip = "Left",
        duration = 1,
        steps = 0.5
    },
    {
        label = "MOVE RIGHT",
        clip = "Right",
        duration = 1,
        steps = 0.5
    },
    {
        label = "MOVE BACK",
        clip = "Back",
        duration = 1,
        steps = 0.5
    },
    {
        label = "DASH LEFT",
        clip = "DashLeft",
        duration = 0.62,
        cues = { { 0.02, "BoostStart" } }
    },
    {
        label = "DASH RIGHT",
        clip = "DashRight",
        duration = 0.62,
        cues = { { 0.02, "BoostStart" } }
    },
    {
        label = "DASH BACK",
        clip = "DashBack",
        duration = 0.71,
        cues = { { 0.02, "BoostStart" } }
    },
    {
        label = "FALL",
        clip = "Fall",
        duration = 0.85,
        lift = 0.55
    },
    {
        label = "LAND",
        clip = "Land",
        duration = 0.36,
        cues = { { 0.04, "LandSoft" } }
    },
    {
        label = "CAUGHT",
        clip = "CaughtIdle",
        duration = 1.67
    }
};
u1.BundleSequence = { {
        label = "RUNNER WALK",
        clip = "Walk",
        duration = 2,
        steps = 0.52
    }, {
        label = "RUNNER RUN",
        clip = "Run",
        duration = 2.2,
        steps = 0.3
    }, {
        label = "DRAW",
        clip = "DaggerEquip",
        duration = 0.94,
        held = true,
        draw = true,
        cues = { { 0.08, "Equip" } }
    }, {
        label = "READY",
        clip = "Idle",
        duration = 0.8,
        held = true
    }, {
        label = "WIND-UP",
        clip = "DaggerWindup",
        duration = 0.65,
        held = true,
        windup = true,
        cues = { { 0.04, "Windup" } }
    }, {
        label = "STAB",
        clip = "DaggerStab",
        duration = 0.84,
        held = true,
        cues = { { 0.04, "Swing" }, { 0.26, "Hit" } }
    }, {
        label = "RECOVER",
        clip = "Idle",
        duration = 0.8,
        held = true
    }, {
        label = "DIVE",
        clip = "DaggerDive",
        duration = 0.72,
        held = true,
        cues = { { 0.02, "Dive" }, { 0.32, "Hit" } }
    }, {
        label = "RECOVER",
        clip = "Idle",
        duration = 1,
        held = true
    } };
u1.BundleTail = { {
        label = "SHEATHE",
        clip = "DaggerEquip",
        duration = 0.94,
        held = true,
        reverse = true,
        cues = { { 0.7, "Sheath" } }
    }, {
        label = "IDLE",
        clip = "Idle",
        duration = 0.8
    } };
u1.Strike = {
    label = "STAB",
    clip = "DaggerStab",
    duration = 0.84,
    held = true,
    cues = { { 0.04, "Swing" } }
};
local u32 = 1;

for i, v in u1.Sequence do
    if v.label == "STAB" then
        u32 = i;
        break;
    end;
end;

local u33 = {
    Idle = true,
    Walk = true,
    Run = true,
    Left = true,
    Right = true,
    Back = true,
    CaughtIdle = true,
    DaggerHold = true
};
local u34 = {
    DaggerEquip = true,
    DaggerWindup = true,
    DaggerStab = true,
    DaggerDive = true,
    DashLeft = true,
    DashRight = true,
    DashBack = true,
    Fall = true,
    Land = true,
    Stop = true
};
local u35 = {
    DaggerEquip = true,
    DaggerWindup = true,
    DaggerStab = true,
    DaggerDive = true
};

local function emoteCues(p36, p37) -- Line: 298
    -- upvalues: EmoteCatalog (copy)
    if not EmoteCatalog.soundId(p36.Id) then
        return nil;
    end;

    local v38 = "EmoteSound:" .. p36.Id;
    local v39 = tonumber(p36.SoundDelay) or 0;
    local v40 = {
        { v39, v38 }
    };
    local v41 = tonumber(p36.Length);

    if p36.SoundEachLoop == true and (v41 and v41 > 0) then
        local v42 = tonumber(p36.SoundPerLoop) or 1;
        local math_floor_ret = math.floor(v42);
        local v43 = v41 / math.clamp(math_floor_ret, 1, 8);
        local v44 = v39 + v43;

        while v44 < p37 - 0.25 and #v40 < 8 do
            table.insert(v40, { v44, v38 });
            v44 = v44 + v43;
        end;
    end;

    local _, _, v45 = EmoteCatalog.soundIds(p36.Id);

    for i, v in v45 do
        local v46 = i;
        local v47 = v;

        while v47 < p37 - 0.25 and #v40 < 16 do
            table.insert(v40, { v47, v38 .. ":" .. v46 });

            if not v41 or v41 <= 0.5 then
                break;
            end;

            v47 = v47 + v41;
        end;
    end;

    return v40;
end;

local function sequenceFor(p48, p49, p50, p51) -- Line: 333
    -- upvalues: u1 (copy), EmoteCatalog (copy), emoteCues (copy)
    local v52;

    if p51 then
        v52 = u1.BundleSequence;
    else
        v52 = u1.Sequence;
    end;

    local table_clone_ret = table.clone(v52);
    local v53 = not p49 and {} or EmoteCatalog.bundle(p49);

    for _, v in p50 or {} do
        local v54 = EmoteCatalog.get(v);

        if v54 and not table.find(v53, v54) then
            table.insert(v53, v54);
        end;
    end;

    for _, v in v53 do
        if EmoteCatalog.assetId(v.Id) then
            local v55 = tonumber(v.Length) or 0;
            local math_max_ret = math.max(5, v55);
            local v56 = {
                label = string.upper(v.Name),
                clip = "Emote:" .. v.Id,
                duration = math_max_ret,
                held = v.Prop ~= nil and (p48.ball == nil and v.HideProp ~= true) and true or nil,
                hidden = v.HideProp == true and true or nil,
                pieces = v.Pieces and v and v or nil,
                root = v.Prop ~= nil and p48.ball ~= nil and true or nil,
                cues = emoteCues(v, math_max_ret)
            };
            table.insert(table_clone_ret, v56);
        end;
    end;

    if p51 then
        for _, v in u1.BundleTail do
            table.insert(table_clone_ret, v);
        end;
    end;

    return table_clone_ret;
end;

local function loadTrack(u57, p58) -- Line: 365
    -- upvalues: KnifeClips (copy), EmoteCatalog (copy), AnimationConfig (copy), loadTrack (copy), u33 (copy), u34 (copy)
    if u57.tracks[p58] then
        return u57.tracks[p58];
    end;

    local v59 = p58:match("^Emote:(.+)$");
    local v60 = not v59 and KnifeClips.ByClip[p58];
    local v61 = v60 and u57.knife and KnifeClips.custom(u57.knife, v60);
    local v62;

    if v59 then
        v62 = EmoteCatalog.assetId(v59);
    else
        v62 = v61 or AnimationConfig.PublishedIds[p58];
    end;

    if not v62 then
        return;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = v62;
    table.insert(u57.assets, Animation);
    local success, result = pcall(function() -- Line: 379
        -- upvalues: u57 (copy), Animation (copy)
        return u57.animator:LoadAnimation(Animation);
    end);

    if success then
        local v63;

        if v61 == nil then
            v63 = false;
        else
            v63 = v61 ~= false;
        end;

        u57.custom[p58] = v63;
        result.Name = "Display_" .. p58;
        result.Looped = u33[p58] == true and true or v59 ~= nil;

        if v59 then
            result.Priority = Enum.AnimationPriority.Action4;
        elseif p58 == "DaggerHold" then
            result.Priority = Enum.AnimationPriority.Action;
        elseif u34[p58] then
            result.Priority = Enum.AnimationPriority.Action2;
        elseif p58 == "Idle" or p58 == "CaughtIdle" then
            result.Priority = Enum.AnimationPriority.Idle;
        else
            result.Priority = Enum.AnimationPriority.Movement;
        end;

        u57.tracks[p58] = result;

        return result;
    end;

    if v61 then
        KnifeClips.fail(v61);

        return loadTrack(u57, p58);
    end;
end;

local function play(p64, p65, p66, p67) -- Line: 407
    -- upvalues: KnifeClips (copy)
    local v68 = p64.tracks[p65];

    if not v68 then
        return;
    end;

    local v69 = (p66 and -1 or 1) * (p64.custom[p65] and p67 and (KnifeClips.fit(v68.Length, p67) or 1) or 1);
    p64.rates[p65] = v69;
    v68:Play(0.12, 1, v69);

    if p66 and v68.Length > 0 then
        v68.TimePosition = math.max(0, v68.Length - 0.01);
    end;
end;

local function enter(p70, p71, p72) -- Line: 420
    -- upvalues: KnifeClips (copy), play (copy), EmotePieces (copy)
    p70.stageIndex = p71;
    p70.stage = p72 or p70.sequence[p71];
    p70.elapsed = 0;
    p70.nextStep = 0;
    table.clear(p70.cueFired);
    local stage = p70.stage;

    for i, v in p70.tracks do
        if i ~= stage.clip and (i ~= "DaggerHold" or not stage.held) and v.IsPlaying then
            v:Stop(0.12);
        end;
    end;

    if stage.held and p70.motor then
        local DaggerHold = p70.tracks.DaggerHold;
        local v73 = DaggerHold and not DaggerHold.IsPlaying and p70.tracks.DaggerHold;

        if v73 then
            local _ = p70.custom.DaggerHold;
            local v74 = 1 * 1;
            p70.rates.DaggerHold = v74;
            v73:Play(0.12, 1, v74);
        end;
    end;

    play(p70, stage.clip, stage.reverse, stage.duration);
    p70.model:SetAttribute("PreviewAction", stage.label);

    if p70.pieces then
        EmotePieces.clear(p70.pieces);
        p70.pieces = nil;
    end;

    if stage.pieces and p70.knife then
        p70.pieces = EmotePieces.build(p70.model, stage.pieces, p70.knife, p70.model);

        for _, v in p70.pieces do
            local v75 = v:FindFirstChildOfClass("Motor6D");

            if v75 then
                local C0 = v75.C0;
                v75.C0 = CFrame.new(C0.Position * p70.scale) * C0.Rotation;
            end;
        end;
    end;

    p70.model:PivotTo(p70.basePivot + Vector3.new(0, (stage.lift or 0) * p70.scale, 0));
end;

function u1.animate(p76, p77, p78, p79, p80) -- Line: 457
    -- upvalues: sequenceFor (copy), u32 (ref), loadTrack (copy), enter (copy)
    p76.sequence = sequenceFor(p76, p78, p79, p80);
    p76.stabIndex = u32;

    for i, v in p76.sequence do
        if v.label == "STAB" then
            p76.stabIndex = i;
            break;
        end;
    end;

    for _, v in p76.sequence do
        loadTrack(p76, v.clip);
    end;

    if p76.motor then
        loadTrack(p76, "DaggerHold");
    end;

    enter(p76, p77 or 1);
end;

function u1.strike(p81) -- Line: 475
    -- upvalues: enter (copy), u32 (ref), u1 (copy)
    if p81.stage and p81.tracks.DaggerStab then
        enter(p81, p81.stabIndex or u32, u1.Strike);
    end;
end;

function u1.perform(p82, p83) -- Line: 482
    -- upvalues: enter (copy)
    for i, v in p82.sequence or {} do
        if v.label == p83 then
            enter(p82, i);

            return true;
        end;
    end;

    return false;
end;

function u1.preAnimation(p84) -- Line: 491
    if p84.motor and p84.baseGrip then
        p84.motor.Transform = p84.baseGrip;
    end;
end;

function u1.step(p85, p86, p87, p88, p89) -- Line: 497
    -- upvalues: enter (copy), KnifeVisibility (copy), u35 (copy), ScythePose (copy)
    if not p85.stage then
        return;
    end;

    if p85.near ~= p86 then
        p85.near = p86;

        for i, v in p85.tracks do
            v:AdjustSpeed(p86 and (p85.rates[i] or 1) or 0);
        end;
    end;

    if p86 then
        p85.elapsed = p85.elapsed + math.min(p87 or 0, 0.1);

        if p85.elapsed >= p85.stage.duration then
            enter(p85, p85.stageIndex % #p85.sequence + 1);
        end;
    end;

    local stage = p85.stage;

    if p85.blade then
        local v90 = stage.held == true;

        if stage.draw then
            v90 = p85.elapsed >= 0.17;
        elseif stage.reverse then
            v90 = p85.elapsed < 0.77;
        end;

        local v91 = stage.root or stage.hidden;
        local v92;

        if v90 then
            v92 = not v91;
        else
            v92 = v90;
        end;

        KnifeVisibility.set(p85.blade, v92);
        KnifeVisibility.set(p85.stowed, not v90 and not v91);

        if p85.leftBlade then
            local v93;

            if v90 then
                v93 = not v91;
            else
                v93 = v90;
            end;

            KnifeVisibility.set(p85.leftBlade, v93);
        end;

        if p85.leftStowed then
            KnifeVisibility.set(p85.leftStowed, not v90 and not v91);
        end;
    end;

    if p85.ball then
        local v94;

        if stage.root == true then
            v94 = p85.elapsed >= 0.15;
        else
            v94 = false;
        end;

        KnifeVisibility.set(p85.ball, v94);
        local Transform = p85.rootMotor.Transform;

        if p85.rest and Transform.Position.Magnitude < 0.0001 then
            local v95 = select(2, Transform:ToAxisAngle());

            if math.abs(v95) < 0.001 then
                p85.rootMotor.Transform = p85.rest;
            end;
        end;
    end;

    local v96 = p85.tracks[stage.clip];

    if stage.reverse and (v96 and (v96.Length > 0 and (p85.elapsed < 0.15 and v96.TimePosition == 0))) then
        v96.TimePosition = v96.Length - 0.01;
    end;

    if stage.windup and (v96 and (v96.Length > 0 and v96.TimePosition >= v96.Length - 0.04)) then
        v96:AdjustSpeed(0);
        p85.rates[stage.clip] = 0;
    end;

    if p85.motor then
        if p85.idle then
            local v97 = 0;

            for i, v in p85.tracks do
                if (u35[i] or p85.custom[i]) and v.IsPlaying then
                    v97 = v97 + v.WeightCurrent;
                end;
            end;

            p85.baseGrip = p85.motor.Transform;
            p85.motor.Transform = p85.baseGrip:Lerp(p85.idle, 1 - math.clamp(v97, 0, 1));
        end;

        local DaggerDive = p85.tracks.DaggerDive;
        local v98 = DaggerDive and DaggerDive.IsPlaying and DaggerDive.Length > 0;
        ScythePose.apply(p85.scythe, v98 and (DaggerDive.TimePosition / DaggerDive.Length or 0) or 0, v98 and DaggerDive.WeightCurrent or 0);
    end;

    if p86 then
        for i, v in stage.cues or {} do
            if p85.elapsed >= v[1] and not p85.cueFired[i] then
                p85.cueFired[i] = true;

                if p88 and p89 then
                    p89(v[2]);
                end;
            end;
        end;

        if stage.steps and p85.elapsed >= p85.nextStep then
            p85.nextStep = p85.elapsed + stage.steps;

            if p88 and p89 then
                p89("FootstepGrass");
            end;
        end;
    end;
end;

function u1.destroy(p99) -- Line: 579
    for _, v in p99.tracks do
        v:Stop(0);
        v:Destroy();
    end;

    for _, v in p99.assets do
        v:Destroy();
    end;

    p99.model:Destroy();
end;

return u1;