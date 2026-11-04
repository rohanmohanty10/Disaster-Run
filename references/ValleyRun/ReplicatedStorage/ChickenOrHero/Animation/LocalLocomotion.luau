 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Animation = ChickenOrHero:WaitForChild("Animation");
local AnimationConfig = require(Animation.AnimationConfig);
local AnimationPolicy = require(Animation.AnimationPolicy);
local StopAnimationPolicy = require(Animation.StopAnimationPolicy);
local DashAnimation = require(Animation.DashAnimation);
local DashAnimationPolicy = require(Animation.DashAnimationPolicy);
local LocomotionTracks = require(Animation.LocomotionTracks);
local AnimationLibrary = require(Animation.AnimationLibrary);
local MovementProfiles = require(ChickenOrHero.Movement.MovementProfiles);
local u1 = {};
local v2;

if require(game.ReplicatedFirst:WaitForChild("FFlags")).LocalLocomotion == true and AnimationConfig.Enabled == true then
    v2 = RunService:IsClient();
else
    v2 = false;
end;

u1.enabled = v2;
local LocalPlayer = Players.LocalPlayer;
local u3 = {};
local u4 = {
    Ball = "HumanoidRootPart",
    Handle = "Right Arm"
};
local u5 = { "HumanoidRootPart", "Torso", "Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };
local u6 = {
    Stop = true,
    Land = true
};
local u7 = -1;
local u8 = nil;
local u9 = {};
local u10 = 0;

for _, v in { "Idle", "Walk", "Run", "Left", "Right", "Back", "Fall", "Stop", "Land", "CaughtIdle" } do
    local v11 = AnimationConfig.PublishedIds[v];

    if v11 then
        u3[v11] = true;
    end;
end;

local function isAction(p12) -- Line: 48
    -- upvalues: u3 (copy)
    local v13;

    if p12.Priority == Enum.AnimationPriority.Core or p12.Priority == Enum.AnimationPriority.Idle then
        v13 = false;
    else
        v13 = not (p12.Animation and u3[p12.Animation.AnimationId]);
    end;

    return v13;
end;

local function rigFolder() -- Line: 54
    -- upvalues: u8 (ref)
    if not (u8 and u8.Parent) then
        u8 = Instance.new("Folder");
        u8.Name = "LocalLocomotionRigs";
        u8.Parent = workspace;
    end;

    return u8;
end;

local function buildProxy(p14) -- Line: 64
    -- upvalues: u5 (copy), u8 (ref)
    local Model = Instance.new("Model");
    Model.Name = "Proxy";
    local v15 = {};

    for _, v in u5 do
        local v16 = p14:FindFirstChild(v);

        if not (v16 and v16:IsA("BasePart")) then
            Model:Destroy();

            return nil;
        end;

        local Part = Instance.new("Part");
        Part.Name = v;
        Part.Size = v16.Size;
        Part.Transparency = 1;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Massless = true;
        Part.Anchored = v == "HumanoidRootPart";
        Part.CFrame = v16.CFrame;
        Part.Parent = Model;
        v15[v] = Part;
    end;

    local v17 = {};

    for _, v in { p14.HumanoidRootPart, p14.Torso } do
        for _, child in v:GetChildren() do
            if child:IsA("Motor6D") and (child.Part0 and (child.Part1 and (v15[child.Part0.Name] and v15[child.Part1.Name]))) then
                local Motor6D = Instance.new("Motor6D");
                Motor6D.Name = child.Name;
                Motor6D.C0 = child.C0;
                Motor6D.C1 = child.C1;
                Motor6D.Part0 = v15[child.Part0.Name];
                Motor6D.Part1 = v15[child.Part1.Name];
                Motor6D.Parent = v15[child.Part0.Name];
                table.insert(v17, {
                    real = child,
                    fake = Motor6D
                });
            end;
        end;
    end;

    local AnimationController = Instance.new("AnimationController");
    AnimationController.Parent = Model;
    local Animator = Instance.new("Animator");
    Animator.Parent = AnimationController;
    Model.PrimaryPart = v15.HumanoidRootPart;

    if not (u8 and u8.Parent) then
        u8 = Instance.new("Folder");
        u8.Name = "LocalLocomotionRigs";
        u8.Parent = workspace;
    end;

    Model.Parent = u8;

    return Model, Animator, v17, v15.HumanoidRootPart;
end;

local function setSlide(u18, p19) -- Line: 113
    local slide = u18.slide;
    u18.slide = nil;
    u18.slideUntil = nil;

    if slide then
        slide.intro:Destroy();
        slide.loop:Destroy();
    end;

    local u20;

    if type(p19) == "string" then
        u20 = string.match(p19, "^([^|]+)|([^|]+)$");
    else
        u20 = nil;
    end;

    if not u20 then
        return;
    end;

    local v21, v22, v23 = pcall(function() -- Line: 125
        -- upvalues: u20 (copy), u18 (copy)
        local Animation2 = Instance.new("Animation");
        local Animation3 = Instance.new("Animation");
        Animation2.AnimationId = u20;
        Animation3.AnimationId = nil;

        return u18.animator:LoadAnimation(Animation2), u18.animator:LoadAnimation(Animation3);
    end);

    if not v21 then
        return;
    end;

    local Action = Enum.AnimationPriority.Action;
    v22.Looped = false;
    v22.Priority = Action;
    local Action2 = Enum.AnimationPriority.Action;
    v23.Looped = true;
    v23.Priority = Action2;
    u18.slide = {
        serial = 0,
        intro = v22,
        loop = v23
    };
end;

local function stopSlide(p24, p25) -- Line: 137
    -- upvalues: AnimationConfig (copy)
    local slide = p24.slide;

    if slide and p24.slideUntil then
        slide.serial = slide.serial + 1;
        slide.intro:Stop(p25 or AnimationConfig.Dash.FadeOut);
        slide.loop:Stop(p25 or AnimationConfig.Dash.FadeOut);
    end;

    p24.slideUntil = nil;
end;

local function playSlide(u26, p27, p28) -- Line: 147
    -- upvalues: DashAnimation (copy), AnimationConfig (copy)
    local slide = u26.slide;

    if not (slide and (slide.intro.Length > 0 and slide.loop.Length > 0)) then
        return false;
    end;

    local slide2 = u26.slide;

    if slide2 and u26.slideUntil then
        slide2.serial = slide2.serial + 1;
        slide2.intro:Stop(0);
        slide2.loop:Stop(0);
    end;

    u26.slideUntil = nil;
    DashAnimation.stop(u26.character);
    local v29 = p27.Duration + math.min(p27.RecoveryDuration or 0, AnimationConfig.Dash.RecoveryTail);
    local math_max_ret = math.max(0.3, v29);
    local math_clamp_ret = math.clamp(slide.intro.Length / (math_max_ret * 0.5), 1, 3);
    local v30 = slide.intro.Length / math_clamp_ret;
    slide.serial = slide.serial + 1;
    local serial = slide.serial;
    u26.slideUntil = p28 + math_max_ret;
    slide.intro:Play(AnimationConfig.Dash.FadeIn, 1, math_clamp_ret);
    slide.intro.TimePosition = 0;
    task.delay(v30 * 0.9, function() -- Line: 162
        -- upvalues: u26 (copy), slide (copy), serial (copy)
        if u26.slide == slide and slide.serial == serial then
            slide.loop:Play(0.08);
            slide.intro:Stop(0.1);
        end;
    end);
    task.delay(math_max_ret, function() -- Line: 168
        -- upvalues: u26 (copy), slide (copy), serial (copy), AnimationConfig (ref)
        if u26.slide == slide and slide.serial == serial then
            local v31 = u26;
            local slide3 = v31.slide;

            if slide3 and v31.slideUntil then
                slide3.serial = slide3.serial + 1;
                slide3.intro:Stop(AnimationConfig.Dash.FadeOut);
                slide3.loop:Stop(AnimationConfig.Dash.FadeOut);
            end;

            v31.slideUntil = nil;
        end;
    end);

    return true;
end;

local function remove(p32) -- Line: 176
    -- upvalues: u9 (copy), DashAnimation (copy)
    local v33 = u9[p32];

    if not v33 then
        return;
    end;

    u9[p32] = nil;
    local slide = v33.slide;
    v33.slide = nil;
    v33.slideUntil = nil;

    if slide then
        slide.intro:Destroy();
        slide.loop:Destroy();
    end;

    if v33.played then
        v33.played:Disconnect();
    end;

    table.clear(v33.actions);
    DashAnimation.release(p32);
    v33.loader:destroy();
    v33.proxy:Destroy();

    if v33.own and p32.Parent then
        p32:SetAttribute("AnimationPackActive", nil);
        p32:SetAttribute("AnimationPackLoading", nil);
        p32:SetAttribute("AnimationAction", nil);
    end;
end;

local function add(p34, p35) -- Line: 197
    -- upvalues: buildProxy (copy), LocalPlayer (copy), LocomotionTracks (copy), AnimationLibrary (copy), StopAnimationPolicy (copy), u9 (copy)
    local v36 = p35:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p35:FindFirstChild("HumanoidRootPart");
    local Torso = p35:FindFirstChild("Torso");

    if not (v36 and (v36.RigType == Enum.HumanoidRigType.R6 and (v36.Health > 0 and (HumanoidRootPart and Torso)))) then
        return;
    end;

    for _, v in { "Neck", "Left Shoulder", "Right Shoulder", "Left Hip", "Right Hip" } do
        if not Torso:FindFirstChild(v) then
            return;
        end;
    end;

    if not HumanoidRootPart:FindFirstChild("RootJoint") then
        return;
    end;

    local v37, v38, v39, v40 = buildProxy(p35);

    if not v37 then
        return;
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { p35 };
    RaycastParams_new_ret.RespectCanCollide = true;
    local v41 = {
        cyclePhase = 0,
        airTime = 0,
        wasGrounded = true,
        actionEnd = 0,
        player = p34,
        character = p35,
        humanoid = v36,
        root = HumanoidRootPart,
        own = p34 == LocalPlayer,
        proxy = v37,
        proxyRoot = v40,
        animator = v38,
        joints = v39,
        loader = LocomotionTracks.new(v38, AnimationLibrary.prepare()),
        sent = {},
        actions = {},
        params = RaycastParams_new_ret,
        stopState = StopAnimationPolicy.new(),
        version = p35:GetAttribute("MovementReset"),
        extras = {}
    };
    local v42;

    if v41.own then
        v42 = p35:GetAttribute("DashAnimationSequence") or 0;
    else
        v42 = p35:GetAttribute("BoostEffectAt");
    end;

    v41.dashSignal = v42;
    u9[p35] = v41;
    v41.loader:refresh(os.clock());
end;

local function watchActions(u43) -- Line: 249
    -- upvalues: u3 (copy)
    local v44 = u43.humanoid:FindFirstChildOfClass("Animator");

    if not v44 then
        return;
    end;

    u43.realAnimator = v44;
    u43.played = v44.AnimationPlayed:Connect(function(p45) -- Line: 255
        -- upvalues: u3 (ref), u43 (copy)
        local v46;

        if p45.Priority == Enum.AnimationPriority.Core or p45.Priority == Enum.AnimationPriority.Idle then
            v46 = false;
        else
            v46 = not (p45.Animation and u3[p45.Animation.AnimationId]);
        end;

        if v46 then
            u43.actions[p45] = true;
        end;
    end);

    for _, v in v44:GetPlayingAnimationTracks() do
        local v47;

        if v.Priority == Enum.AnimationPriority.Core or v.Priority == Enum.AnimationPriority.Idle then
            v47 = false;
        else
            v47 = not (v.Animation and u3[v.Animation.AnimationId]);
        end;

        if v47 then
            u43.actions[v] = true;
        end;
    end;
end;

local function endAction(p48) -- Line: 267
    -- upvalues: AnimationConfig (copy)
    local actionName = p48.actionName;
    local v49;

    if actionName then
        v49 = p48.loader.tracks[actionName];
    else
        v49 = actionName;
    end;

    if v49 then
        v49:Stop(actionName == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
    end;

    p48.actionName = nil;

    if p48.own then
        p48.character:SetAttribute("AnimationAction", nil);
    end;
end;

local function startAction(p50, p51, p52, p53, p54) -- Line: 278
    -- upvalues: LocomotionTracks (copy), AnimationConfig (copy)
    local v55 = p50.loader.tracks[p51];

    if not LocomotionTracks.ready(v55) then
        return;
    end;

    local actionName = p50.actionName;
    local v56;

    if actionName then
        v56 = p50.loader.tracks[actionName];
    else
        v56 = actionName;
    end;

    if v56 then
        v56:Stop(actionName == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
    end;

    p50.actionName = nil;

    if p50.own then
        p50.character:SetAttribute("AnimationAction", nil);
    end;

    p50.actionName = p51;
    p50.actionEnd = os.clock() + p52;

    if p50.own then
        p50.character:SetAttribute("AnimationAction", p51);
    end;

    v55:Play(p51 == "Stop" and (AnimationConfig.Stop.FadeIn or 0.07) or 0.07, p54 or 1, (p53 or v55.Length) / math.max(p52, 0.05));
    v55.TimePosition = 0;
end;

local function remoteMode(p57, p58, p59, p60) -- Line: 294
    local v61 = p57.smoothSpeed or p58;
    local v62 = v61 + (p58 - v61) * (1 - math.exp(-15 * p59));
    local v63 = (v62 - v61) / math.max(p59, 0.001);
    p57.smoothSpeed = v62;

    if v62 < 0.5 then
        p57.brakeFrames = 0;
        p57.mode = "Idle";
    elseif v63 < -(p60.Deceleration or 60) * 0.4 then
        p57.brakeFrames = (p57.brakeFrames or 0) + 1;

        if p57.brakeFrames >= 3 and p57.mode ~= "Braking" then
            p57.entrySpeed = p57.peakSpeed or v62;
            p57.mode = "Braking";
        end;
    else
        p57.brakeFrames = 0;

        if p57.mode ~= "Braking" or v63 > -1 then
            p57.mode = p60.MaxSpeed * 0.97 <= v62 and "Running" or "Accelerating";
        end;
    end;

    if p57.mode ~= "Braking" then
        p57.peakSpeed = v62;
    end;

    return p57.mode;
end;

local function remoteVelocity(p64, p65) -- Line: 323
    local Position = p64.root.Position;
    local lastPosition = p64.lastPosition;
    p64.lastPosition = Position;

    if not lastPosition or p65 <= 0 then
        return p64.velocity or Vector3.new(0, 0, 0);
    end;

    local v66 = (Position - lastPosition) / p65;

    if v66.Magnitude > 150 then
        p64.velocity = Vector3.new(0, 0, 0);

        return p64.velocity;
    end;

    p64.velocity = (p64.velocity or v66):Lerp(v66, 1 - math.exp(-20 * p65));

    return p64.velocity;
end;

local function remoteGrounded(p67) -- Line: 340
    local v68 = workspace:Raycast(p67.root.Position, Vector3.new(0, -5, 0), p67.params);
    local v69;

    if v68 == nil then
        v69 = false;
    else
        v69 = p67.root.Position.Y - v68.Position.Y <= 4;
    end;

    return v69;
end;

local function syncExtras(p70) -- Line: 346
    -- upvalues: u4 (copy)
    local character = p70.character;

    for i, v in u4 do
        local v71 = character:FindFirstChild(v);
        local v72;

        if v71 then
            v72 = v71:FindFirstChild(i);
        else
            v72 = v71;
        end;

        if not (v72 and (v72:IsA("Motor6D") and (v72.Part0 == v71 and (v72.Part1 and (i ~= "Handle" or p70.knifeRun))))) then
            v72 = nil;
        end;

        local v73 = p70.extras[i];

        if v73 and v73.real ~= v72 then
            p70.extras[i] = nil;
            local table_find_ret = table.find(p70.joints, v73);

            if table_find_ret then
                table.remove(p70.joints, table_find_ret);
            end;

            v73.fake.Part1:Destroy();
            v73.fake:Destroy();
            v73 = nil;
        end;

        local v74;

        if v72 then
            v74 = p70.proxy:FindFirstChild(v);
        else
            v74 = v72;
        end;

        if v74 and not v73 then
            local Part = Instance.new("Part");
            Part.Name = v72.Part1.Name;
            Part.Size = v72.Part1.Size;
            Part.Transparency = 1;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Massless = true;
            Part.Parent = p70.proxy;
            local Motor6D = Instance.new("Motor6D");
            Motor6D.Name = v72.Name;
            Motor6D.C0 = v72.C0;
            Motor6D.C1 = v72.C1;
            Motor6D.Part0 = v74;
            Motor6D.Part1 = Part;
            Motor6D.Parent = v74;
            local Attribute = v72:GetAttribute("Rest");
            local v75 = {
                real = v72,
                fake = Motor6D,
                rest = typeof(Attribute) == "CFrame" and Attribute and Attribute or nil
            };
            p70.extras[i] = v75;
            table.insert(p70.joints, v75);
        end;
    end;
end;

local function step(p76, p77, p78) -- Line: 399
    -- upvalues: setSlide (copy), syncExtras (copy), MovementProfiles (copy), remoteVelocity (copy), remoteMode (copy), AnimationConfig (copy), DashAnimation (copy), StopAnimationPolicy (copy), playSlide (copy), DashAnimationPolicy (copy), AnimationPolicy (copy), startAction (copy), LocomotionTracks (copy), u6 (copy)
    local character = p76.character;
    local humanoid = p76.humanoid;
    local root = p76.root;
    local player = p76.player;
    local loader = p76.loader;
    local tracks = loader.tracks;
    local Attribute = character:GetAttribute("KnifeRun");

    if Attribute ~= p76.knifeRun then
        p76.knifeRun = Attribute;

        if type(Attribute) ~= "string" then
            Attribute = nil;
        end;

        loader:setRun(Attribute);
    end;

    local Attribute2 = character:GetAttribute("KnifeDash");

    if Attribute2 ~= p76.knifeDash then
        p76.knifeDash = Attribute2;
        setSlide(p76, Attribute2);
    end;

    syncExtras(p76);
    loader:refresh(p78);
    local v79 = loader:coreReady();

    if p76.own then
        if character:GetAttribute("AnimationPackActive") ~= v79 then
            character:SetAttribute("AnimationPackActive", v79);
        end;

        if character:GetAttribute("AnimationPackLoading") == v79 then
            character:SetAttribute("AnimationPackLoading", not v79);
        end;
    end;

    p76.proxyRoot.CFrame = root.CFrame;
    local v80 = MovementProfiles.get(player:GetAttribute("GameRole"), player);
    local v81;

    if p76.own then
        v81 = root.AssemblyLinearVelocity;
    else
        v81 = remoteVelocity(p76, p77);
    end;

    local v82 = v81 * Vector3.new(1, 0, 1);
    local Magnitude = v82.Magnitude;
    local v83;

    if p76.own then
        v83 = humanoid.FloorMaterial ~= Enum.Material.Air;
    else
        local v84 = workspace:Raycast(p76.root.Position, Vector3.new(0, -5, 0), p76.params);

        if v84 == nil then
            v83 = false;
        else
            v83 = p76.root.Position.Y - v84.Position.Y <= 4;
        end;
    end;

    local v85 = root.Anchored or character:GetAttribute("MovementLocked") == true;
    local v86 = character:GetAttribute("TackleActive") == true;
    local v87;

    if player:GetAttribute("GameRole") == "Runner" then
        v87 = player:GetAttribute("RunState") == "Caught";
    else
        v87 = false;
    end;

    local v88;

    if p76.own then
        v88 = character:GetAttribute("MovementState") or "Idle";
    else
        v88 = remoteMode(p76, Magnitude, p77, v80);
    end;

    local Attribute3 = character:GetAttribute("MovementReset");

    if Attribute3 ~= p76.version then
        p76.version = Attribute3;
        local actionName = p76.actionName;
        local v89;

        if actionName then
            v89 = p76.loader.tracks[actionName];
        else
            v89 = actionName;
        end;

        if v89 then
            v89:Stop(actionName == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        p76.actionName = nil;

        if p76.own then
            p76.character:SetAttribute("AnimationAction", nil);
        end;

        DashAnimation.stop(character);
        local slide = p76.slide;

        if slide and p76.slideUntil then
            slide.serial = slide.serial + 1;
            slide.intro:Stop(AnimationConfig.Dash.FadeOut);
            slide.loop:Stop(AnimationConfig.Dash.FadeOut);
        end;

        p76.slideUntil = nil;
        p76.stopState = StopAnimationPolicy.new();
        p76.airTime = 0;
        p76.wasGrounded = v83;
    end;

    local v90 = v83 and not v85 and not (v86 or v87 or (humanoid.Sit or humanoid.PlatformStand)) and v80.Dash.Enabled;

    if not v90 then
        DashAnimation.stop(character);
        local slide = p76.slide;

        if slide and p76.slideUntil then
            slide.serial = slide.serial + 1;
            slide.intro:Stop(AnimationConfig.Dash.FadeOut);
            slide.loop:Stop(AnimationConfig.Dash.FadeOut);
        end;

        p76.slideUntil = nil;
    end;

    local v91;

    if p76.own then
        v91 = character:GetAttribute("DashAnimationSequence") or 0;
    else
        v91 = character:GetAttribute("BoostEffectAt");
    end;

    if v91 ~= p76.dashSignal then
        p76.dashSignal = v91;

        if v90 and not (p76.own and (v88 ~= "Boosting" and v88 ~= "Dashing")) then
            local actionName = p76.actionName;
            local v92;

            if actionName then
                v92 = p76.loader.tracks[actionName];
            else
                v92 = actionName;
            end;

            if v92 then
                v92:Stop(actionName == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
            end;

            p76.actionName = nil;

            if p76.own then
                p76.character:SetAttribute("AnimationAction", nil);
            end;

            if not playSlide(p76, v80.Dash, p78) then
                if p76.own then
                    DashAnimation.play(character, character:GetAttribute("DashFromDirection"), character:GetAttribute("DashToDirection"), v80.Dash, p76.animator);
                else
                    local Attribute4 = character:GetAttribute("BoostDashName");

                    if DashAnimationPolicy.isName(Attribute4) then
                        DashAnimation.playNamed(character, Attribute4, character:GetAttribute("DashVisualFacing"), v80.Dash, p76.animator);
                    end;
                end;
            end;
        end;
    end;

    local v93 = DashAnimation.isActive(character);

    if not v93 then
        if p76.slideUntil == nil then
            v93 = false;
        else
            v93 = p78 < p76.slideUntil;
        end;
    end;

    local v94 = v93 and not p76.own and "Dashing" or v88;
    local v95 = AnimationPolicy.angle(v82, root.CFrame.LookVector * Vector3.new(1, 0, 1));
    local step = StopAnimationPolicy.step;
    local stopState = p76.stopState;
    local v96 = {
        mode = v94,
        speed = Magnitude
    };
    local v97;

    if p76.own then
        v97 = character:GetAttribute("MovementStopEntrySpeed");
    else
        v97 = p76.entrySpeed;
    end;

    v96.entrySpeed = v97;
    v96.angle = v95;
    v96.allowed = v79 and not v93 and (v83 and not (v85 or v86 or (v87 or humanoid.Sit))) and not humanoid.PlatformStand;
    v96.clipLength = tracks.Stop and (tracks.Stop.Length or 0) or 0;
    v96.now = p78;
    local v98 = step(stopState, v96, p77, AnimationConfig.Stop, v80);
    local v99;

    if character:GetAttribute("Ragdolled") or not v79 then
        v99 = {};
        local actionName = p76.actionName;
        local v100;

        if actionName then
            v100 = p76.loader.tracks[actionName];
        else
            v100 = actionName;
        end;

        if v100 then
            v100:Stop(actionName == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        p76.actionName = nil;

        if p76.own then
            p76.character:SetAttribute("AnimationAction", nil);
        end;
    elseif v86 or (v85 or (humanoid.Sit or humanoid.PlatformStand)) then
        v99 = {
            Idle = 1
        };
        local actionName = p76.actionName;
        local v101;

        if actionName then
            v101 = p76.loader.tracks[actionName];
        else
            v101 = actionName;
        end;

        if v101 then
            v101:Stop(actionName == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        p76.actionName = nil;

        if p76.own then
            p76.character:SetAttribute("AnimationAction", nil);
        end;
    elseif v87 then
        v99 = tracks.CaughtIdle and tracks.CaughtIdle.Length > 0 and ({
            CaughtIdle = 1
        } or {
            Idle = 1
        }) or {
            Idle = 1
        };
        local actionName = p76.actionName;
        local v102;

        if actionName then
            v102 = p76.loader.tracks[actionName];
        else
            v102 = actionName;
        end;

        if v102 then
            v102:Stop(actionName == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        p76.actionName = nil;

        if p76.own then
            p76.character:SetAttribute("AnimationAction", nil);
        end;

        p76.airTime = 0;
    elseif v83 then
        v99 = AnimationPolicy.weights(Magnitude, v95, v80.MaxSpeed, AnimationConfig);

        if v93 then
            local actionName = p76.actionName;
            local v103;

            if actionName then
                v103 = p76.loader.tracks[actionName];
            else
                v103 = actionName;
            end;

            if v103 then
                v103:Stop(actionName == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
            end;

            p76.actionName = nil;

            if p76.own then
                p76.character:SetAttribute("AnimationAction", nil);
            end;
        elseif p76.wasGrounded or (p76.airTime <= 0.15 or v86) then
            if v98 then
                startAction(p76, "Stop", v98.duration, v98.clipEnd, v98.weight);
            end;
        else
            startAction(p76, "Land", 0.25);
        end;

        p76.airTime = 0;
    else
        p76.airTime = p76.airTime + p77;
        v99 = {
            Fall = 1
        };
        local actionName = p76.actionName;
        local v104;

        if actionName then
            v104 = p76.loader.tracks[actionName];
        else
            v104 = actionName;
        end;

        if v104 then
            v104:Stop(actionName == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        p76.actionName = nil;

        if p76.own then
            p76.character:SetAttribute("AnimationAction", nil);
        end;
    end;

    local actionName = p76.actionName;

    if actionName and (p76.actionEnd <= p78 or (v86 or actionName == "Stop" and (v94 ~= "Braking" and v94 ~= "Idle"))) then
        local actionName2 = p76.actionName;
        local v105;

        if actionName2 then
            v105 = p76.loader.tracks[actionName2];
        else
            v105 = actionName2;
        end;

        if v105 then
            v105:Stop(actionName2 == "Stop" and (AnimationConfig.Stop.FadeOut or 0.08) or 0.08);
        end;

        p76.actionName = nil;

        if p76.own then
            p76.character:SetAttribute("AnimationAction", nil);
        end;
    end;

    local v106 = loader:weights(v99);
    local v107 = p76.knifeRun and tracks.KnifeRun;
    local v108 = LocomotionTracks.ready(v107);

    if v108 and v106.Run then
        v106.KnifeRun = v106.Run;
        v106.Run = nil;
    end;

    local math_clamp_ret = math.clamp((Magnitude / v80.MaxSpeed - AnimationConfig.RunBlendStart) / (AnimationConfig.RunBlendEnd - AnimationConfig.RunBlendStart), 0, 1);
    local assets = loader.assets;
    local v109;

    if v108 then
        v109 = v107.Length;
    else
        v109 = assets.Run.length;
    end;

    local v110 = Magnitude / math.max(AnimationConfig.WalkReferenceSpeed * (1 - math_clamp_ret) + AnimationConfig.RunReferenceSpeed * v109 * math_clamp_ret, 1);
    local math_clamp_ret2 = math.clamp(v110, 0.25, 3);
    p76.cyclePhase = (p76.cyclePhase + math_clamp_ret2 * p77) % 1;

    for i, v in tracks do
        if not u6[i] and LocomotionTracks.ready(v) then
            local v111 = v106[i] or 0;
            local v112 = i == "CaughtIdle" and AnimationConfig.CaughtIdle.FadeTime or AnimationConfig.FadeTime;
            local v113;

            if i == "CaughtIdle" then
                v113 = AnimationConfig.CaughtIdle.PlaybackRate;
            elseif i == "Idle" or i == "Fall" then
                v113 = 1;
            elseif i == "Walk" or (i == "Run" or i == "KnifeRun") then
                v113 = math_clamp_ret2 * math.max(v.Length, 0.1);
            else
                v113 = math.clamp(Magnitude / AnimationConfig.DirectionalReferenceSpeed, 0.5, 2.2);
            end;

            local v114 = p76.sent[i];

            if v111 > 0.001 then
                if v.IsPlaying and (v114 and v114.weight > 0.001) then
                    if math.abs(v114.weight - v111) > 0.02 then
                        v:AdjustWeight(v111, v112);
                        v114.weight = v111;
                    end;

                    if math.abs(v114.rate - v113) > v113 * 0.02 then
                        v:AdjustSpeed(v113);
                        v114.rate = v113;
                    end;
                else
                    v:Play(v112, v111, v113);

                    if i ~= "Idle" and (i ~= "Fall" and i ~= "CaughtIdle") then
                        v.TimePosition = p76.cyclePhase * v.Length;
                    end;

                    if v114 then
                        v114.weight = v111;
                        v114.rate = v113;
                    else
                        p76.sent[i] = {
                            weight = v111,
                            rate = v113
                        };
                    end;
                end;
            elseif v114 and v114.weight > 0.001 then
                v:Stop(v112);
                v114.weight = 0;
            end;
        end;
    end;

    p76.wasGrounded = v83;
end;

function u1.step(p115) -- Line: 596
    -- upvalues: u10 (ref), u9 (copy), remove (copy), watchActions (copy), step (copy), u1 (copy)
    u10 = u10 + 1;
    local math_min_ret = math.min(p115, 0.1);
    local os_clock_ret = os.clock();

    for i, v in u9 do
        if i:IsDescendantOf(workspace) and (v.root.Parent == i and v.humanoid.Health > 0) then
            if not v.realAnimator then
                watchActions(v);
            end;

            local success, result = pcall(step, v, math_min_ret, os_clock_ret);

            if not success and os.clock() >= (u1.warnAt or 0) then
                u1.warnAt = os.clock() + 10;
                warn("LocalLocomotion:", result);
            end;
        else
            remove(i);
        end;
    end;
end;

local function isRest(p116) -- Line: 616
    if p116.Position.Magnitude > 0.0001 then
        return false;
    end;

    local _, v117 = p116:ToAxisAngle();

    return math.abs(v117) < 0.001;
end;

local function restPose(p118, p119, p120) -- Line: 625
    local KnifeRun = p118.loader.tracks.KnifeRun;
    local v121 = not (KnifeRun and KnifeRun.IsPlaying) and 0 or math.min(KnifeRun.WeightCurrent, 1);

    if v121 >= 0.02 then
        local v122;

        if p120.Position.Magnitude > 0.0001 then
            v122 = false;
        else
            local _, v123 = p120:ToAxisAngle();
            v122 = math.abs(v123) < 0.001;
        end;

        if not v122 then
            if v121 < 0.98 then
                return p119.rest:Lerp(CFrame.identity:Lerp(p120, 1 / v121), v121);
            end;

            return p120;
        end;
    end;

    return p119.rest;
end;

function u1.copy() -- Line: 637
    -- upvalues: u7 (ref), u10 (ref), u9 (copy), restPose (copy)
    if u7 == u10 then
        return;
    end;

    u7 = u10;

    for _, v in u9 do
        local v124 = v;
        local v125 = 0;

        for i in v.actions do
            if i.IsPlaying then
                v125 = math.max(v125, i.WeightCurrent);
            else
                v124.actions[i] = nil;
            end;
        end;

        local math_min_ret = math.min(v125, 1);

        for _, v3 in v124.joints do
            local real = v3.real;

            if real.Parent then
                local Transform = v3.fake.Transform;

                if v3.rest then
                    Transform = restPose(v124, v3, Transform);
                end;

                if math_min_ret < 0.02 then
                    real.Transform = Transform;
                else
                    local Transform2 = real.Transform;
                    local v126;

                    if Transform2.Position.Magnitude > 0.0001 then
                        v126 = false;
                    else
                        local _, v127 = Transform2:ToAxisAngle();
                        v126 = math.abs(v127) < 0.001;
                    end;

                    if v126 then
                        real.Transform = Transform;
                    elseif math_min_ret < 0.98 then
                        real.Transform = Transform:Lerp(CFrame.identity:Lerp(Transform2, 1 / math_min_ret), math_min_ret);
                    end;
                end;
            end;
        end;
    end;
end;

function u1.animatorFor(p128) -- Line: 677
    -- upvalues: u9 (copy)
    local v129 = u9[p128];

    if v129 then
        v129 = v129.animator;
    end;

    return v129;
end;

function u1.velocityFor(p130) -- Line: 684
    -- upvalues: u9 (copy)
    local v131 = u9[p130];
    local v132;

    if v131 then
        v132 = not v131.own and v131.velocity or nil;
    else
        v132 = nil;
    end;

    return v132;
end;

function u1.start() -- Line: 689
    -- upvalues: u1 (copy), RunService (copy), Players (copy), u9 (copy), add (copy), remove (copy)
    if not u1.enabled or u1.started then
        return;
    end;

    u1.started = true;
    local u133 = 1;
    RunService.PreAnimation:Connect(function(p134) -- Line: 695
        -- upvalues: u133 (ref), Players (ref), u9 (ref), add (ref), u1 (ref)
        u133 = u133 + p134;

        if u133 >= 0.5 then
            u133 = 0;

            for _, v in Players:GetPlayers() do
                local Character = v.Character;

                if Character and (not u9[Character] and Character:IsDescendantOf(workspace)) then
                    add(v, Character);
                end;
            end;
        end;

        u1.step(p134);
    end);
    RunService.PreSimulation:Connect(u1.copy);
    Players.PlayerRemoving:Connect(function(p135) -- Line: 710
        -- upvalues: u9 (ref), remove (ref)
        for i, v in u9 do
            if v.player == p135 then
                remove(i);
            end;
        end;
    end);
end;

return u1;