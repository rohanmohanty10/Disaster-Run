 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Parent = script.Parent.Parent;
local BotDirectory = require(script.Parent.BotDirectory);
local BotFrameCodec = require(script.Parent.BotFrameCodec);
local ClientBotAnimator = require(script.Parent.ClientBotAnimator);
local ClientBotKnife = require(script.Parent.ClientBotKnife);
local ClientBotOutline = require(script.Parent.ClientBotOutline);
local ClientBotKnockdown = require(script.Parent.ClientBotKnockdown);
local MovementProfiles = require(Parent.Movement.MovementProfiles);
local TackleAnimation = require(Parent.Animation.TackleAnimation);
local PumpkinSmoke = require(Parent.Gear.PumpkinSmoke);
local u1 = {};
u1.__index = u1;
local Flags = BotFrameCodec.Flags;
local Locked = Flags.Locked;
local Ragdolled = Flags.Ragdolled;
local u2 = Flags.Boosting + Flags.Dashing;
local u3 = {
    DashVisualFacing = true,
    DashAnimationActive = true,
    LastDashAnimation = true,
    DaggerAnimationsReady = true,
    ClientBot = true,
    BotUserId = true
};
local u4 = {
    GameRole = true,
    GearSlow = true,
    GearBoost = true,
    FartBoost = true,
    EquippedKnife = true,
    TrollSpeed = true
};
local u5 = {
    GameRole = true,
    RunState = true,
    HeroActive = true,
    FFAInvincible = true,
    GearBoost = true,
    FartBoost = true,
    GearSlow = true,
    GearTrip = true,
    IsInflatableDecoy = true,
    DaggerEquipped = true,
    DaggerState = true,
    DaggerSkin = true,
    TackleActive = true,
    DashAnimationSequence = true,
    MovementReset = true,
    TrollScale = true,
    Smoked = true
};
local u6 = { "Neck", "Left Shoulder", "Right Shoulder", "Left Hip", "Right Hip" };
local u7 = {
    RigidConstraint = true,
    NoCollisionConstraint = true
};
local u8 = {
    {
        "RootJoint",
        "HumanoidRootPart",
        "HumanoidRootPart",
        "Torso",
        CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0),
        CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
    },
    {
        "Neck",
        "Torso",
        "Torso",
        "Head",
        CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0),
        CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
    },
    {
        "Right Shoulder",
        "Torso",
        "Torso",
        "Right Arm",
        CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),
        CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
    },
    {
        "Left Shoulder",
        "Torso",
        "Torso",
        "Left Arm",
        CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
        CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    },
    {
        "Right Hip",
        "Torso",
        "Torso",
        "Right Leg",
        CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),
        CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
    },
    {
        "Left Hip",
        "Torso",
        "Torso",
        "Left Leg",
        CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
        CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    }
};
local u9 = game.PlaceId == 130574217370467;
local u10 = {
    [Enum.HumanoidRigType.R6] = { "HumanoidRootPart", "Torso", "Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg" },
    [Enum.HumanoidRigType.R15] = { "HumanoidRootPart", "UpperTorso", "LowerTorso", "Head", "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot" }
};

local function profiled(p11) -- Line: 90
    -- upvalues: u4 (copy)
    return u4[p11] == true and true or string.find(p11, "^Crossing") ~= nil;
end;

local function strip(p12) -- Line: 95
    -- upvalues: u7 (copy)
    local EquippedDagger = p12:FindFirstChild("EquippedDagger");

    for _, descendant in p12:GetDescendants() do
        if descendant.Parent ~= nil then
            if descendant:IsA("LuaSourceContainer") or (descendant:IsA("LayerCollector") or (descendant:IsA("Highlight") or (descendant:IsA("Tool") or (descendant:IsA("ForceField") or (descendant:IsA("Sound") or (descendant:IsA("BodyMover") or descendant:IsA("Constraint") and not u7[descendant.ClassName])))))) or (descendant.Name == "CaughtRagdoll" or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or (descendant:IsA("Fire") or (descendant:IsA("Smoke") or (descendant:IsA("Sparkles") or descendant:IsA("Light"))))))) and not (EquippedDagger and descendant:IsDescendantOf(EquippedDagger))) then
                descendant:Destroy();
            elseif descendant:IsA("Motor6D") then
                descendant.Enabled = true;
            end;
        end;
    end;
end;

local function repose(p13, p14) -- Line: 131
    local v15 = {};

    for _, descendant in p13:GetDescendants() do
        if descendant:IsA("JointInstance") and (descendant.Part0 and (descendant.Part1 and descendant.Enabled)) then
            table.insert(v15, descendant);
        elseif descendant:IsA("RigidConstraint") and (descendant.Enabled and (descendant.Attachment0 and descendant.Attachment1)) then
            table.insert(v15, descendant);
        end;
    end;

    local v16 = true;
    local v17 = {
        [p14] = true
    };

    while v16 and #v15 > 0 do
        v16 = false;

        for i = #v15, 1, -1 do
            local v18 = v15[i];
            local v19, v20, v21, v22;

            if v18:IsA("RigidConstraint") then
                v19 = v18.Attachment0.Parent;
                v20 = v18.Attachment1.Parent;
                v21 = v18.Attachment0.CFrame;
                v22 = v18.Attachment1.CFrame;
            else
                v19 = v18.Part0;
                v20 = v18.Part1;
                v21 = v18.C0;
                v22 = v18.C1;
            end;

            local v23 = v19 and v19:IsA("BasePart") and v19:IsDescendantOf(p13);
            local v24 = v20 and v20:IsA("BasePart") and v20:IsDescendantOf(p13);
            local v25;

            if v23 and (v24 and not (v17[v19] and v17[v20])) then
                if v17[v19] then
                    v20.CFrame = v19.CFrame * v21 * v22:Inverse();
                    v17[v20] = true;
                    table.remove(v15, i);
                    v25 = i;
                    v16 = true;
                elseif v17[v20] then
                    v19.CFrame = v20.CFrame * v22 * v21:Inverse();
                    v17[v19] = true;
                    table.remove(v15, i);
                    v25 = i;
                    v16 = true;
                else
                    v25 = i;
                end;
            else
                table.remove(v15, i);
                v25 = i;
            end;
        end;
    end;
end;

local function joints(p26) -- Line: 173
    -- upvalues: u8 (copy)
    local v27 = {};

    for _, descendant in p26:GetDescendants() do
        if descendant:IsA("JointInstance") and (descendant.Enabled and (descendant.Part0 and descendant.Part1)) then
            v27[descendant.Part0.Name .. "|" .. descendant.Part1.Name] = true;
            v27[descendant.Part1.Name .. "|" .. descendant.Part0.Name] = true;
        end;
    end;

    local v28 = nil;

    for _, v in u8 do
        local v29 = p26:FindFirstChild(v[2]);
        local v30 = p26:FindFirstChild(v[3]);
        local v31 = p26:FindFirstChild(v[4]);

        if v29 and (v30 and (v31 and (v30:IsA("BasePart") and (v31:IsA("BasePart") and not v27[v[3] .. "|" .. v[4]])))) then
            local Motor6D = Instance.new("Motor6D");
            Motor6D.Name = v[1];
            local v32 = v[5];
            local v33 = v[6];
            Motor6D.Part0 = v30;
            Motor6D.Part1 = v31;
            Motor6D.C0 = v32;
            Motor6D.C1 = v33;
            Motor6D.Parent = v29;
            v28 = v28 or {};
            table.insert(v28, v[1]);
        end;
    end;

    return v28;
end;

local function dormant(p34) -- Line: 203
    p34.EvaluateStateMachine = false;
    p34.PlatformStand = true;
    p34.AutoRotate = false;
    p34.BreakJointsOnDeath = false;
    p34.RequiresNeck = false;
    p34.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    p34.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
    p34.NameDisplayDistance = 0;
    p34.HealthDisplayDistance = 0;
    p34.WalkSpeed = 0;
    p34.Health = p34.MaxHealth > 0 and (p34.MaxHealth or 100) or 100;
end;

function u1.new(p35) -- Line: 218
    -- upvalues: BotDirectory (copy), u1 (copy), ClientBotOutline (copy)
    local v36 = p35 or {};
    local v37 = v36.folder or workspace:FindFirstChild("ClientBots");

    if not v37 then
        v37 = Instance.new("Folder");
        v37.Name = "ClientBots";
        v37.Parent = workspace;
    end;

    local v38 = setmetatable({
        folder = v37,
        directory = v36.directory or BotDirectory,
        clock = v36.clock or os.clock,
        move = v36.move,
        rigs = {},
        active = {},
        parts = {},
        frames = {},
        connections = {}
    }, u1);
    v38.outline = ClientBotOutline.new(v37);

    return v38;
end;

function u1.start(u39) -- Line: 243
    -- upvalues: RunService (copy)
    local directory = u39.directory;
    directory.start();
    table.insert(u39.connections, directory.Added:Connect(function(p40) -- Line: 248
        -- upvalues: u39 (copy)
        u39:add(p40);
    end));
    table.insert(u39.connections, directory.Removed:Connect(function(p41) -- Line: 254
        -- upvalues: u39 (copy)
        u39:remove(p41);
    end));

    for _, v in directory.list() do
        u39:add(v);
    end;

    RunService:BindToRenderStep("ClientBotRigs", Enum.RenderPriority.Input.Value + 11, function() -- Line: 261
        -- upvalues: u39 (copy)
        u39:frame();
    end);
    u39.bound = true;
end;

function u1.stop(p42) -- Line: 266
    -- upvalues: RunService (copy)
    if p42.bound then
        p42.bound = false;
        RunService:UnbindFromRenderStep("ClientBotRigs");
    end;

    for _, v in p42.connections do
        v:Disconnect();
    end;

    table.clear(p42.connections);

    for _, v in table.clone(p42.active) do
        p42:remove(v.actor);
    end;

    p42.outline:destroy();
    table.clear(p42.parts);
    table.clear(p42.frames);
end;

function u1.fadeChanged(p43, p44) -- Line: 283
    local record = p44.record;
    local Attribute = record:GetAttribute("FadeOutAt");
    local Attribute2 = record:GetAttribute("FadeSeconds");
    p44.fadeAt = type(Attribute) == "number" and Attribute and Attribute or nil;
    p44.fadeSeconds = (type(Attribute2) ~= "number" or (Attribute2 <= 0 or not Attribute2)) and 0.3 or Attribute2;
end;

function u1.mirror(p45, p46) -- Line: 289
    -- upvalues: u3 (copy)
    local model = p46.model;
    local body = p46.body;

    if body then
        for i, v in body:GetAttributes() do
            if not u3[i] then
                model:SetAttribute(i, v);
            end;
        end;
    end;

    model:SetAttribute("ClientBot", true);
    model:SetAttribute("BotUserId", p46.actor.UserId);

    if model:GetAttribute("IsBot") == nil then
        model:SetAttribute("IsBot", true);
    end;
end;

function u1.bindBody(p47, u48, u49) -- Line: 304
    -- upvalues: u3 (copy), u4 (copy), u5 (copy)
    if u48.body == u49 then
        return;
    end;

    if u48.bodyChanged then
        u48.bodyChanged:Disconnect();
        u48.bodyChanged = nil;
    end;

    u48.body = u49;

    if u49 then
        u48.bodyChanged = u49.AttributeChanged:Connect(function(p50) -- Line: 315
            -- upvalues: u48 (copy), u3 (ref), u49 (copy), u4 (ref), u5 (ref)
            local model = u48.model;

            if model and not u3[p50] then
                model:SetAttribute(p50, u49:GetAttribute(p50));
            end;

            if u4[p50] == true and true or string.find(p50, "^Crossing") ~= nil then
                u48.profileDirty = true;
            end;

            if u5[p50] then
                u48.dirty = true;
            end;
        end);

        if u48.model then
            p47:mirror(u48);
        end;
    end;

    u48.profileDirty = true;
    u48.dirty = true;
end;

function u1.add(u51, p52) -- Line: 334
    -- upvalues: u4 (copy), u5 (copy)
    if u51.rigs[p52] or p52._removed then
        return;
    end;

    local record = p52.record;
    local v53 = u51.clock();
    local u54 = {
        nextUpdate = 0,
        dirty = true,
        profileDirty = true,
        actor = p52,
        record = record,
        connections = {},
        knock = {
            down = false
        },
        since = v53,
        retryAt = v53,
        lastUpdate = v53,
        hidden = record:GetAttribute("Hidden") == true and true or record:GetAttribute("LocalHidden") == true
    };
    u51:fadeChanged(u54);
    local Look = record:FindFirstChild("Look");

    if not (Look and (Look:IsA("Model") and Look)) then
        Look = nil;
    end;

    u54.look = Look;
    u51.rigs[p52] = u54;
    table.insert(u51.active, u54);
    table.insert(u54.connections, record.AttributeChanged:Connect(function(p55) -- Line: 362
        -- upvalues: u54 (copy), record (copy), u51 (copy), u4 (ref), u5 (ref)
        if p55 == "Hidden" or p55 == "LocalHidden" then
            u54.hidden = record:GetAttribute("Hidden") == true and true or record:GetAttribute("LocalHidden") == true;
        elseif p55 == "FadeOutAt" or p55 == "FadeSeconds" then
            u51:fadeChanged(u54);
        elseif p55 == "LookUserId" and (u54.model and u54.source ~= "Look") then
            u54.rebuild = true;
        end;

        if u4[p55] == true and true or string.find(p55, "^Crossing") ~= nil then
            u54.profileDirty = true;
        end;

        if u5[p55] then
            u54.dirty = true;
        end;
    end));
    table.insert(u54.connections, record.ChildAdded:Connect(function(p56) -- Line: 380
        -- upvalues: u54 (copy), u51 (copy)
        if p56.Name == "Look" and p56:IsA("Model") then
            u54.look = p56;

            if u54.model and u54.source ~= "Owner" then
                u54.rebuild = true;

                return;
            end;

            if not u54.model then
                u54.retryAt = 0;
            end;
        elseif p56.Name == "Body" and p56:IsA("Folder") then
            u51:bindBody(u54, p56);
        end;
    end));
    table.insert(u54.connections, record.ChildRemoved:Connect(function(p57) -- Line: 396
        -- upvalues: u54 (copy), record (copy), u51 (copy)
        if p57 ~= u54.body then
            if p57 == u54.look then
                local Look2 = record:FindFirstChild("Look");

                if not (Look2 and (Look2:IsA("Model") and Look2)) then
                    Look2 = nil;
                end;

                u54.look = Look2;
            end;

            return;
        end;

        local Body = record:FindFirstChild("Body");

        if not (Body and (Body:IsA("Folder") and Body)) then
            Body = nil;
        end;

        u51:bindBody(u54, Body);
    end));
    local Body = record:FindFirstChild("Body");

    if not (Body and (Body:IsA("Folder") and Body)) then
        Body = nil;
    end;

    u51:bindBody(u54, Body);
end;

function u1.remove(p58, p59) -- Line: 409
    local v60 = p58.rigs[p59];

    if not v60 then
        return;
    end;

    p58.rigs[p59] = nil;
    local active = p58.active;
    local table_find_ret = table.find(active, v60);

    if table_find_ret then
        active[table_find_ret] = active[#active];
        active[#active] = nil;
    end;

    for _, v in v60.connections do
        v:Disconnect();
    end;

    table.clear(v60.connections);

    if v60.bodyChanged then
        v60.bodyChanged:Disconnect();
        v60.bodyChanged = nil;
    end;

    p58:teardown(v60);
    v60.gone = true;
    p58.directory._setRig(p59, nil);
end;

function u1.whole(p61, p62, p63) -- Line: 435
    -- upvalues: u10 (copy), u9 (copy)
    local v64 = p63:FindFirstChildOfClass("Humanoid");
    local v65 = not v64 and "Humanoid" or nil;

    if v64 then
        for _, v in u10[v64.RigType] or u10[Enum.HumanoidRigType.R6] do
            local v66 = p63:FindFirstChild(v);

            if not (v66 and v66:IsA("BasePart")) then
                v65 = v;
                break;
            end;
        end;
    end;

    if v65 and (u9 and (not p62.partialWarned and p61.clock() - p62.since >= 1)) then
        p62.partialWarned = true;
        print(("[BotLook] %s: its outfit has not fully arrived (no %s yet); not drawn from it until it has"):format(p62.record.Name, v65));
    end;

    return v65 == nil;
end;

function u1.source(p67, p68) -- Line: 454
    -- upvalues: Players (copy)
    local actor = p68.actor;
    local record = p68.record;
    local Attribute = record:GetAttribute("LookUserId");

    if type(Attribute) ~= "number" and actor.Kind ~= "Clone" then
        local look = p68.look;

        if look and (look.Parent == record and p67:whole(p68, look)) then
            return look, "Look";
        end;

        return nil;
    end;

    local v69 = type(Attribute) == "number" and Attribute and Attribute or actor.OwnerUserId;
    local v70;

    if type(v69) == "number" then
        v70 = Players:GetPlayerByUserId(v69) or nil;
    else
        v70 = nil;
    end;

    local v71;

    if v70 then
        v71 = v70.Character;
    else
        v71 = v70;
    end;

    if v71 and (v71:IsDescendantOf(workspace) and p67:whole(p68, v71)) then
        return v71, "Owner", v70;
    end;

    return nil;
end;

function u1.build(p72, p73) -- Line: 472
    local v74, v75, v76 = p72:source(p73);

    if not v74 then
        return false;
    end;

    local Archivable = v74.Archivable;
    v74.Archivable = true;
    local success, result = pcall(v74.Clone, v74);
    v74.Archivable = Archivable;

    if not (success and result) then
        return false;
    end;

    result.Name = v76 and v76.Name or p73.record.Name;

    return p72:install(p73, result, v75, v75 == "Owner" and v74 and v74 or nil);
end;

function u1.fallback(u77, u78) -- Line: 489
    -- upvalues: Players (copy)
    if u78.fallingBack then
        return;
    end;

    u78.fallingBack = true;
    local actor = u78.actor;
    task.spawn(function() -- Line: 495
        -- upvalues: actor (copy), Players (ref), u78 (copy), u77 (copy)
        local v79 = nil;
        local AvatarUserId = actor.AvatarUserId;
        local v80;

        if type(AvatarUserId) == "number" and AvatarUserId > 0 then
            local v81;
            v81, v80 = pcall(Players.GetHumanoidDescriptionFromUserIdAsync, Players, AvatarUserId);

            if not v81 then
                v80 = v79;
            end;
        else
            v80 = v79;
        end;

        local v82 = v80 or Instance.new("HumanoidDescription");
        local success, result = pcall(Players.CreateHumanoidModelFromDescriptionAsync, Players, v82, Enum.HumanoidRigType.R6);
        v82:Destroy();
        u78.fallingBack = false;

        if not (success and result) then
            return;
        end;

        if u77.rigs[actor] ~= u78 or (u78.model or u78.gone) then
            result:Destroy();

            return;
        end;

        result.Name = u78.record.Name;
        u77:install(u78, result, "Fallback");
    end);
end;

function u1.install(p83, u84, u85, p86, p87) -- Line: 519
    -- upvalues: strip (copy), joints (copy), u9 (copy), repose (copy), u6 (copy), ClientBotAnimator (copy), ClientBotKnife (copy)
    local v88 = u85:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = u85:FindFirstChild("HumanoidRootPart");

    if not (v88 and (HumanoidRootPart and HumanoidRootPart:IsA("BasePart"))) then
        u85:Destroy();

        return false;
    end;

    strip(u85);

    if p86 ~= "Look" then
        for _, child in v88:GetChildren() do
            if child:IsA("Animator") then
                child:Destroy();
            end;
        end;
    end;

    if not v88:FindFirstChildOfClass("Animator") then
        Instance.new("Animator").Parent = v88;
    end;

    for i in u85:GetAttributes() do
        u85:SetAttribute(i, nil);
    end;

    HumanoidRootPart.Anchored = true;
    local v89 = joints(u85);

    if v89 and u9 then
        print(("[BotLook] %s (%s): rebuilt missing joints %s"):format(u84.record.Name, p86, table.concat(v89, ", ")));
    end;

    repose(u85, HumanoidRootPart);
    local Head = u85:FindFirstChild("Head");

    for _, child in u85:GetChildren() do
        if child:IsA("BasePart") and child ~= HumanoidRootPart then
            child.Transparency = 0;
        end;
    end;

    if Head then
        for _, child in Head:GetChildren() do
            if child:IsA("Decal") then
                child.Transparency = 0;
            end;
        end;
    end;

    if not u84.actor:GetAttribute("IsInflatableDecoy") then
        local record = u84.record;

        for _, child in u85:GetChildren() do
            if child:IsA("BasePart") and child ~= HumanoidRootPart then
                local u90 = child;

                for _, v in { "Transparency", "LocalTransparencyModifier" } do
                    u90:GetPropertyChangedSignal(v):Connect(function() -- Line: 571
                        -- upvalues: u90 (copy), v (copy), u85 (copy), u9 (ref), u84 (copy), record (copy)
                        if u90[v] ~= 0 and (v ~= "LocalTransparencyModifier" or u85:GetAttribute("KillEffectHidden") ~= true) then
                            if u9 and not u84.lookWarned then
                                u84.lookWarned = true;
                                print(("[BotLook] %s: something set %s.%s to %s; held at 0"):format(record.Name, u90.Name, v, (tostring(u90[v]))));
                            end;

                            u90[v] = 0;
                        end;
                    end);
                end;
            end;
        end;
    end;

    for _, descendant in u85:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = descendant == HumanoidRootPart;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Massless = true;
            descendant.LocalTransparencyModifier = 0;
            descendant.CollisionGroup = "CoHInactive";
        end;
    end;

    v88.EvaluateStateMachine = false;
    v88.PlatformStand = true;
    v88.AutoRotate = false;
    v88.BreakJointsOnDeath = false;
    v88.RequiresNeck = false;
    v88.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v88.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
    v88.NameDisplayDistance = 0;
    v88.HealthDisplayDistance = 0;
    v88.WalkSpeed = 0;
    v88.Health = v88.MaxHealth > 0 and (v88.MaxHealth or 100) or 100;
    u85.PrimaryPart = HumanoidRootPart;
    local Torso = u85:FindFirstChild("Torso");
    u84.model = u85;
    u84.root = HumanoidRootPart;
    u84.humanoid = v88;
    u84.head = u85:FindFirstChild("Head");
    u84.torso = Torso;
    u84.source = p86;
    u84.motors = {};

    for _, v in u6 do
        local v91;

        if Torso then
            v91 = Torso:FindFirstChild(v);
        else
            v91 = Torso;
        end;

        if v91 and v91:IsA("Motor6D") then
            u84.motors[v] = v91;
        end;
    end;

    p83:mirror(u84);
    local EquippedDagger = u85:FindFirstChild("EquippedDagger");
    u84.animator = ClientBotAnimator.new(u85);
    local new = ClientBotKnife.new;

    if not (EquippedDagger and (EquippedDagger:IsA("Model") and EquippedDagger)) then
        EquippedDagger = nil;
    end;

    local v92;

    if p87 then
        v92 = p87:GetAttribute("DaggerSkin");
    else
        v92 = p87;
    end;

    u84.knife = new(u85, EquippedDagger, v92);
    u84.inherit = p87;
    u84.started = false;
    u84.dashSequence = u85:GetAttribute("DashAnimationSequence");
    u84.dashPending = nil;
    u84.tackleAt = nil;
    u84.tackleEnds = nil;
    u84.reset = u85:GetAttribute("MovementReset");
    u84.style = nil;
    u84.group = nil;
    u84.joined = nil;
    u84.role = nil;
    u84.marker = nil;
    u84.markerStyle = nil;
    u84.gear = nil;
    u84.position = nil;
    u84.yaw = nil;
    u84.velocity = nil;
    u84.lastFrame = nil;
    u84.scale = u85:GetScale();
    u84.lift = 0;
    u84.fadeParts = nil;
    u84.fadeSizes = nil;
    u84.fadeAlpha = nil;
    u84.knock.down = false;
    u84.rebuild = nil;
    u84.dirty = true;
    u84.profileDirty = true;
    u84.nextUpdate = 0;

    return true;
end;

function u1.teardown(p93, p94) -- Line: 635
    if not p94.model then
        return;
    end;

    if p94.shown then
        p93:hide(p94);
    end;

    p93.outline:cancel(p94);

    if p94.knife then
        p94.knife:destroy();
        p94.knife = nil;
    end;

    if p94.animator then
        p94.animator:destroy();
        p94.animator = nil;
    end;

    p94.model:Destroy();
    p94.model = nil;
    p94.root = nil;
    p94.humanoid = nil;
    p94.head = nil;
    p94.torso = nil;
    p94.motors = nil;
    p94.marker = nil;
    p94.markerStyle = nil;
    p94.style = nil;
    p94.group = nil;
    p94.inherit = nil;
    p94.fadeParts = nil;
    p94.fadeSizes = nil;
    p94.started = false;
end;

function u1.show(p95, p96) -- Line: 657
    p96.shown = true;
    p95.outline:sync(p96);

    if not p96.started then
        p96.started = true;

        if not p96.decoy then
            p96.animator:start(p95.clock());

            if p96.inherit then
                p96.animator:inherit(p96.inherit);
            end;
        end;

        p96.inherit = nil;
    end;

    p95.directory._setRig(p96.actor, p96.model);
end;

function u1.hide(p97, p98) -- Line: 673
    p98.shown = false;
    p97.outline:settle(p98);
    p97.outline:sync(p98);
    p98.model.Parent = nil;
    p97.directory._setRig(p98.actor, nil);
end;

function u1.style(p99, p100) -- Line: 683
    -- upvalues: PumpkinSmoke (copy)
    local actor = p100.actor;
    local model = p100.model;
    local Attribute = actor:GetAttribute("GameRole");
    local Attribute2 = actor:GetAttribute("RunState");
    p100.decoy = actor:GetAttribute("IsInflatableDecoy") == true;
    local v101;

    if type(Attribute) == "string" and Attribute ~= "Lobby" then
        local v102;

        if Attribute == "Runner" and Attribute2 == "Caught" then
            v102 = true;
        elseif Attribute2 == "Active" then
            v102 = model:GetAttribute("GearTrip") == true;
        else
            v102 = false;
        end;

        local v103 = not v102 and actor:GetAttribute("HeroActive") == true;
        local v104;

        if Attribute == "Runner" then
            v104 = Attribute2 == "Safe" and true or Attribute2 == "Caught";
        else
            v104 = false;
        end;

        v101 = v104 and Attribute2 and Attribute2 or (Attribute == "Catcher" and "Catcher" or (v103 and "Hero" or "Runner"));
    else
        v101 = nil;
    end;

    local v105 = actor:GetAttribute("GearBoost") == true;
    local v106 = actor:GetAttribute("GearSlow") == true;

    if v105 or v106 then
        if not p100.gear then
            p100.gear = v105 and not v106 and (Attribute == "Catcher" and "GearBoostCatcher" or "GearBoost") or "GearSlow";
        end;
    else
        p100.gear = nil;
    end;

    local v107 = actor:GetAttribute("FFAInvincible") == true and "Shield" or (p100.gear or v101);
    local v108;

    if v101 == p100.role or v101 ~= "Safe" and v101 ~= "Caught" then
        v108 = false;
    else
        v108 = p100.role ~= nil;
    end;

    p100.role = v101;
    p100.smokeHidden = PumpkinSmoke.hidden(model, Attribute);

    if p100.smokeHidden then
        p99.outline:apply(p100, nil, nil, false);

        return;
    end;

    p99.outline:apply(p100, v101, v107, v108);
end;

function u1.fade(p109, p110, p111) -- Line: 714
    if not p110.decoy then
        return;
    end;

    local math_clamp_ret = math.clamp((p111 - p110.fadeAt) / p110.fadeSeconds, 0, 1);

    if math_clamp_ret == p110.fadeAlpha then
        return;
    end;

    p110.fadeAlpha = math_clamp_ret;
    local decoy = p110.decoy;

    if not p110.fadeParts then
        p110.fadeParts = {};

        for _, descendant in p110.model:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                table.insert(p110.fadeParts, descendant);
            end;
        end;

        if decoy then
            p110.fadeSizes = {};

            for _, v in p110.fadeParts do
                if v:IsA("BasePart") then
                    p110.fadeSizes[v] = v.Size;
                end;
            end;
        end;
    end;

    local v112 = decoy and math_clamp_ret * math_clamp_ret or 1 - (1 - math_clamp_ret) * (1 - math_clamp_ret);

    for _, v in p110.fadeParts do
        if v.Parent then
            v.LocalTransparencyModifier = v112;
        end;
    end;

    if p110.fadeSizes then
        for i, v in p110.fadeSizes do
            if i.Parent then
                local v113 = v.Y + (math.max(0.05, v.Y * 0.12) - v.Y) * v112;
                local v114 = 1 + 0.18 * v112;
                i.Size = Vector3.new(v.X * v114, v113, v.Z * v114);
            end;
        end;
    end;
end;

function u1.dash(p115, p116, p117) -- Line: 759
    -- upvalues: u2 (copy)
    local model = p116.model;
    local Attribute = model:GetAttribute("DashAnimationSequence");

    if Attribute ~= p116.dashSequence then
        p116.dashSequence = Attribute;
        p116.dashPending = p117;
    end;

    local dashPending = p116.dashPending;

    if not dashPending then
        return;
    end;

    if p117 - dashPending > 0.5 then
        p116.dashPending = nil;

        return;
    end;

    if bit32.band(p116.actor._flags, u2) == 0 then
        return;
    end;

    p116.dashPending = nil;
    local actor = p116.actor;

    if actor:GetAttribute("GameRole") == "Catcher" or actor:GetAttribute("RunState") == "Caught" then
        return;
    end;

    p116.animator:dash(model:GetAttribute("DashFromDirection"), model:GetAttribute("DashToDirection"), p116.profile.Dash);
end;

function u1.tackle(p118, p119, p120) -- Line: 784
    -- upvalues: TackleAnimation (copy)
    local model = p119.model;
    local v121 = model:GetAttribute("TackleActive") == true;
    local Attribute = model:GetAttribute("TackleStartedAt");

    if v121 and (type(Attribute) == "number" and Attribute ~= p119.tackleAt) then
        if p120 < Attribute then
            return;
        end;

        p119.tackleAt = Attribute;
        local Attribute2 = model:GetAttribute("TackleDuration");
        local Attribute3 = model:GetAttribute("TackleRecovery");
        local v122 = (type(Attribute2) == "number" and Attribute2 and Attribute2 or 0) + (type(Attribute3) == "number" and Attribute3 and Attribute3 or 0);
        local v123 = p120 - Attribute;

        if v122 > 0 and v123 < v122 then
            local Attribute4 = model:GetAttribute("TackleAnimation");
            TackleAnimation.play(model, type(Attribute4) == "string" and Attribute4 and Attribute4 or nil, v122, v123);
            p119.tackleEnds = Attribute + v122;
        end;
    elseif not v121 and p119.tackleEnds then
        if p120 < p119.tackleEnds - p118.directory.Delay - 0.05 then
            TackleAnimation.stop(model);
        end;

        p119.tackleEnds = nil;
    end;
end;

function u1.update(p124, p125, p126, p127, p128) -- Line: 811
    -- upvalues: MovementProfiles (copy), Locked (copy)
    local actor = p125.actor;
    local model = p125.model;

    if p125.profileDirty or not p125.profile then
        p125.profileDirty = false;
        p125.profile = MovementProfiles.get(actor:GetAttribute("GameRole"), model);
    end;

    local Attribute = model:GetAttribute("TrollScale");
    local v129 = type(Attribute) == "number" and Attribute == Attribute and (math.clamp(Attribute, 0.2, 4) or 1) or 1;

    if v129 ~= p125.scale and pcall(model.ScaleTo, model, v129) then
        p125.scale = v129;
        p125.lift = 3 * (v129 - 1);
        p125.position = nil;
    end;

    p124:style(p125);
    local Attribute2 = model:GetAttribute("MovementReset");

    if Attribute2 ~= p125.reset then
        p125.reset = Attribute2;

        if not (p125.knock.down or p125.decoy) then
            p125.animator:reset();
        end;
    end;

    p125.knife:update(p126, true);

    if p125.knock.down then
        return;
    end;

    if p125.decoy then
        p125.animator:decoy();

        return;
    end;

    p124:dash(p125, p128);
    p124:tackle(p125, p126);
    local v130 = (bit32.band(actor._flags, Locked) ~= 0 or model:GetAttribute("MovementLocked") == true) and true or model:GetAttribute("TackleActive") == true;
    local _velocity = actor._velocity;
    local _look = actor._look;
    p125.animator:update(p128, p127, actor._speed, _velocity.X, _velocity.Z, _look.X, _look.Z, actor:GetAttribute("GameRole"), actor:GetAttribute("RunState") == "Caught", v130, p125.profile.MaxSpeed);
end;

function u1.problem(p131, p132, p133, p134) -- Line: 862
    if (p132.warnAt or 0) <= p133 then
        p132.warnAt = p133 + 10;
        warn("Client bot " .. p132.record.Name .. " failed: " .. tostring(p134));
    end;
end;

function u1.frame(p135) -- Line: 868
    -- upvalues: PumpkinSmoke (copy), Ragdolled (copy), ClientBotKnockdown (copy)
    local directory = p135.directory;
    local renderAt = directory.renderAt;
    local v136 = p135.clock();
    local v137 = directory.focus();
    local parts = p135.parts;
    local frames = p135.frames;
    table.clear(parts);
    table.clear(frames);
    local v138 = 3;

    for _, v in p135.active do
        if not v.gone then
            local actor = v.actor;

            if v.fadeAt and (v.model and v.fadeAt + v.fadeSeconds <= renderAt) then
                p135:teardown(v);
                v.gone = true;
            else
                local v138;
                local v139 = 0;

                while true do
                    if v139 == 0 then
                        v139 = -1;

                        if v.rebuild then
                            if v.model then
                                if (v.rebuildAt or 0) <= v136 then
                                    if p135:source(v) then
                                        p135:teardown(v);
                                        v.rebuild = nil;
                                    else
                                        v.rebuildAt = v136 + 0.1;
                                    end;
                                end;
                            else
                                v.rebuild = nil;
                            end;
                        end;

                        if v.model then
                            if v.source == "Fallback" and v.retryAt <= v136 then
                                v.retryAt = v136 + 0.5;

                                if p135:source(v) then
                                    v.rebuild = true;
                                end;
                            end;

                            v139 = 2;
                            continue;
                        end;

                        if v138 > 0 and v136 >= v.retryAt then
                            v139 = 1;
                            continue;
                        end;

                        v139 = 3;
                        continue;
                    elseif v139 == 1 then
                        v139 = -1;
                        v138 = v138 - 1;
                        local success, result = pcall(p135.build, p135, v);

                        if not success then
                            p135:problem(v, v136, result);
                        end;

                        if success and result then
                            v139 = 2;
                            continue;
                        end;

                        v.retryAt = v136 + 0.5;

                        if v136 - v.since >= 4 then
                            p135:fallback(v);
                        end;

                        v139 = 3;
                        continue;
                    elseif v139 == 2 then
                        v139 = -1;

                        if v.hidden or not actor._posed then
                            if v.shown then
                                p135:hide(v);
                            end;
                        else
                            if not v.shown then
                                p135:style(v);
                                p135:show(v);
                            end;

                            local model = v.model;
                            local root = v.root;

                            if v.fadeAt then
                                p135:fade(v, renderAt);
                            end;

                            if (v.smokeHidden or PumpkinSmoke.active()) and PumpkinSmoke.hidden(model, actor:GetAttribute("GameRole")) ~= (v.smokeHidden == true) then
                                v.dirty = true;
                            end;

                            local _position = actor._position;
                            local knock = v.knock;
                            local v140 = bit32.band(actor._flags, Ragdolled) ~= 0;

                            if v140 and not knock.down then
                                ClientBotKnockdown.begin(knock, renderAt, _position, actor._yaw, model:GetAttribute("CaughtImpulseDirection"));
                                v.animator:down();
                                v.dirty = true;
                            elseif not v140 and knock.down then
                                ClientBotKnockdown.finish(knock, renderAt);
                            end;

                            local v141;

                            if knock.down then
                                local Attribute = model:GetAttribute("KnockLiftAt");

                                if Attribute ~= nil and Attribute ~= knock.liftAt then
                                    ClientBotKnockdown.lift(knock, Attribute, model:GetAttribute("KnockLiftHeight"), model:GetAttribute("KnockLiftTime"));
                                end;

                                local v142;
                                v141, v142 = ClientBotKnockdown.frame(knock, renderAt, _position, actor._yaw);

                                if v141 then
                                    ClientBotKnockdown.limbs(v.motors, v142);
                                else
                                    ClientBotKnockdown.limbs(v.motors, 0);
                                    v.dirty = true;

                                    if Attribute ~= nil then
                                        model:SetAttribute("KnockLiftAt", nil);
                                    end;
                                end;
                            else
                                v141 = nil;
                            end;

                            if v141 then
                                if v141 ~= v.lastFrame then
                                    v.lastFrame = v141;
                                    v.position = nil;
                                    table.insert(parts, root);
                                    table.insert(frames, v141);
                                end;
                            else
                                local _yaw = actor._yaw;

                                if _position ~= v.position or _yaw ~= v.yaw then
                                    v.position = _position;
                                    v.yaw = _yaw;
                                    v.lastFrame = nil;
                                    local math_cos_ret = math.cos(_yaw);
                                    local math_sin_ret = math.sin(_yaw);
                                    table.insert(parts, root);
                                    table.insert(frames, CFrame.new(_position.X, _position.Y + v.lift, _position.Z, math_cos_ret, 0, math_sin_ret, 0, 1, 0, -math_sin_ret, 0, math_cos_ret));
                                end;
                            end;

                            local _velocity = actor._velocity;

                            if _velocity ~= v.velocity then
                                v.velocity = _velocity;
                                root.AssemblyLinearVelocity = _velocity;
                            end;

                            if v.dirty or v.nextUpdate <= v136 then
                                local Magnitude = (_position - v137).Magnitude;
                                v.nextUpdate = v136 + (Magnitude <= 60 and 0.03333333333333333 or (Magnitude <= 160 and 0.1 or 0.25));
                                local math_min_ret = math.min(v136 - v.lastUpdate, 0.25);
                                v.lastUpdate = v136;
                                v.dirty = false;
                                local success, result = pcall(p135.update, p135, v, renderAt, math_min_ret, v136);

                                if not success then
                                    p135:problem(v, v136, result);
                                end;
                            end;
                        end;

                        v139 = 3;
                        continue;
                    elseif v139 == 3 then
                        v139 = -1;
                        break;
                    else
                        break;
                    end;
                end;
            end;
        end;
    end;

    if #parts > 0 then
        if p135.move then
            p135.move(parts, frames);

            return;
        end;

        workspace:BulkMoveTo(parts, frames, Enum.BulkMoveMode.FireCFrameChanged);
    end;
end;

function u1.counts(p143) -- Line: 1010
    local v144 = #p143.connections;
    local v145 = 0;
    local v146 = 0;
    local v147 = 0;

    for _, v in p143.rigs do
        v145 = v145 + 1;

        if v.model then
            v146 = v146 + 1;
        end;

        if v.shown then
            v147 = v147 + 1;
        end;

        v144 = v144 + (#v.connections + (v.bodyChanged and 1 or 0));
    end;

    local v148, v149 = p143.outline:counts();

    return {
        rigs = v145,
        models = v146,
        shown = v147,
        connections = v144,
        active = #p143.active,
        groups = v148,
        highlights = v149
    };
end;

return u1;