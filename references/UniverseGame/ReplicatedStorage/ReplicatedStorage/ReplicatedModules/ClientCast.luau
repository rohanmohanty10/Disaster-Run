  

 

local u1 = {};
local u2 = {
    AttachmentName = "DmgPoint",
    DebugAttachmentName = "ClientCast-Debug",
    FunctionDebug = false,
    DebugMode = false,
    DebugLifetime = 1,
    AutoSetup = true,
    DebugColor = Color3.new(1, 0, 0)
};

if u2.AutoSetup then
    require(script.ClientConnection)();
end;

u1.Settings = u2;
u1.InitiatedCasters = {};
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u3 = ReplicatedStorage:FindFirstChild("ClientCast-Replication");
local u4 = ReplicatedStorage:FindFirstChild("ClientCast-Ping");
local Signal = require(script.Signal);

local function SafeRemoteInvoke(u5, u6, u7) -- Line: 28
    local u8 = false;
    local u9 = coroutine.running();
    task.spawn(function() -- Line: 32
        -- upvalues: u5 (copy), u6 (copy), u8 (ref), u9 (copy), u7 (copy)
        local v10 = time();
        u5:InvokeClient(u6);
        local v11 = time();
        u8 = true;
        task.spawn(u9, (math.min(v11 - v10, u7)));
    end);
    task.delay(u7, function() -- Line: 41
        -- upvalues: u8 (ref), u9 (copy), u7 (copy)
        if not u8 then
            u8 = true;
            task.spawn(u9, u7);
        end;
    end);

    return coroutine.yield();
end;

local function SerializeParams(p12) -- Line: 51
    return {
        FilterDescendantsInstances = p12.FilterDescendantsInstances,
        FilterType = p12.FilterType.Name,
        IgnoreWater = p12.IgnoreWater,
        CollisionGroup = p12.CollisionGroup
    };
end;

local function IsA(p13, p14) -- Line: 59
    return typeof(p13) == p14;
end;

local function AssertType(p15, p16, p17) -- Line: 62
    if typeof(p15) ~= p16 then
        error(string.format(p17, p16, (typeof(p15))), 4);
    end;
end;

local function AssertClass(p18, p19, p20) -- Line: 67
    if typeof(p18) ~= "Instance" then
        error(string.format(p20, "Instance", (typeof(p18))), 4);
    end;

    if not p18:IsA(p19) then
        error(string.format(p20, p19, p18.Class), 4);
    end;
end;

local function AssertNaN(p21, p22) -- Line: 73
    if p21 ~= p21 then
        error(string.format(p22, "number", (typeof(p21))), 4);
    end;
end;

local function IsValidOwner(p23) -- Line: 78
    local v24 = typeof(p23) == "Instance";

    if v24 or p23 == nil then
        if v24 and not p23:IsA("Player") then
            error("SetOwner only takes player or \'nil\' instance as an argument.", 4);
        end;

        return;
    end;

    error("Unable to cast value to Object", 4);
end;

local function IsValid(p25) -- Line: 86
    if typeof(p25) ~= "table" then
        return false;
    end;

    local v26;

    if p25.Instance == nil then
        v26 = false;
    else
        v26 = (p25.Instance:IsA("BasePart") or p25.Instance:IsA("Terrain")) and (typeof(p25.Position) == "Vector3" and typeof(p25.Material) == "EnumItem") and typeof(p25.Normal) == "Vector3";
    end;

    return v26;
end;

local u27 = {};
local u28 = {};
u28.__index = u28;

function u28.Start(u29) -- Line: 101
    -- upvalues: u3 (copy), IsValid (copy)
    local Owner = u29.Owner;

    if typeof(Owner) ~= "Instance" then
        error(string.format(nil, "Instance", (typeof(Owner))), 4);
    end;

    if not Owner:IsA("Player") then
        error(string.format(nil, "Player", Owner.Class), 4);
    end;

    local v30 = {
        Owner = Owner,
        Object = u29.Object,
        Debug = u29.Caster._Debug
    };
    local RaycastParams = u29.RaycastParams;
    v30.RaycastParams = {
        FilterDescendantsInstances = RaycastParams.FilterDescendantsInstances,
        FilterType = RaycastParams.FilterType.Name,
        IgnoreWater = RaycastParams.IgnoreWater,
        CollisionGroup = RaycastParams.CollisionGroup
    };
    v30.Id = u29.Caster._UniqueId;
    u3:FireClient(Owner, "Start", v30);
    u29.Connection = u3.OnServerEvent:Connect(function(p31, p32, p33) -- Line: 113
        -- upvalues: Owner (copy), IsValid (ref), u29 (copy)
        if p31 == Owner and (IsValid(p33) and (p32 == "Any" or p32 == "Humanoid")) then
            local v34;

            if p32 == "Humanoid" then
                v34 = p33.Instance:FindFirstAncestorOfClass("Model");

                if v34 then
                    v34 = v34:FindFirstChildOfClass("Humanoid");
                end;
            else
                v34 = nil;
            end;

            if p32 == "Humanoid" and v34 == nil then
                return;
            end;

            for i in next, u29.Caster._CollidedEvents[p32] do
                i:Invoke(p33, v34);
            end;
        end;
    end);
end;

function u28.Update(p35, p36) -- Line: 131
    -- upvalues: u3 (copy)
    local v37 = {
        Owner = p35.Owner,
        Object = p35.Object,
        Debug = p35.Caster._Debug
    };
    local RaycastParams = p35.RaycastParams;
    v37.RaycastParams = {
        FilterDescendantsInstances = RaycastParams.FilterDescendantsInstances,
        FilterType = RaycastParams.FilterType.Name,
        IgnoreWater = RaycastParams.IgnoreWater,
        CollisionGroup = RaycastParams.CollisionGroup
    };
    v37.Id = p35.Caster._UniqueId;
    u3:FireClient(p35.Owner, "Update", v37, p36);
end;

function u28.Stop(p38, p39) -- Line: 141
    -- upvalues: u3 (copy)
    local Owner = p38.Owner;
    u3:FireClient(Owner, p39 and "Destroy" or "Stop", {
        Owner = Owner,
        Object = p38.Object,
        Id = p38.Caster._UniqueId
    });
    local Connection = p38.Connection;

    if Connection then
        Connection:Disconnect();
    end;

    if p39 then
        table.clear(p38);
        setmetatable(p38, nil);
    end;
end;

function u28.Destroy(p40) -- Line: 161
    p40:Stop(true);
end;

function u27.new(p41, p42, p43, p44) -- Line: 165
    -- upvalues: u28 (copy)
    if typeof(p41) ~= "Instance" then
        error(string.format("Unexpected owner in \'ReplicationBase.Stop\' (%s expected, got %s)", "Instance", (typeof(p41))), 4);
    end;

    if not p41:IsA("Player") then
        error(string.format("Unexpected owner in \'ReplicationBase.Stop\' (%s expected, got %s)", "Player", p41.Class), 4);
    end;

    local v45;

    if type(p44) == "table" then
        v45 = p44._Class == "Caster";
    else
        v45 = false;
    end;

    assert(v45, "Unexpect argument #4 - Caster expected");

    return setmetatable({
        Owner = p41,
        Object = p42,
        RaycastParams = p43,
        Caster = p44
    }, u28);
end;

local u46 = {};
local u47 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) });

function u46.DisableDebug(p48) -- Line: 186
    local _ReplicationConnection = p48._ReplicationConnection;

    if _ReplicationConnection then
        _ReplicationConnection:Update({
            Debug = false
        });
    end;

    p48._Debug = false;

    for i in next, p48._DebugTrails do
        i.Enabled = false;
    end;
end;

function u46.StartDebug(p49) -- Line: 200
    local _ReplicationConnection = p49._ReplicationConnection;

    if _ReplicationConnection then
        _ReplicationConnection:Update({
            Debug = true
        });
    end;

    p49._Debug = true;

    for i in next, p49._DebugTrails do
        i.Enabled = true;
    end;
end;

local u50 = {
    Collided = "Any",
    HumanoidCollided = "Humanoid"
};

function u46.Start(p51) -- Line: 220
    -- upvalues: u1 (copy)
    p51.Disabled = false;
    local _ReplicationConnection = p51._ReplicationConnection;

    if _ReplicationConnection then
        _ReplicationConnection:Start();
    end;

    u1.InitiatedCasters[p51] = {};

    if p51._Debug then
        p51:StartDebug();
    end;
end;

function u46.Destroy(p52) -- Line: 233
    -- upvalues: u1 (copy)
    local _ReplicationConnection = p52._ReplicationConnection;

    if _ReplicationConnection then
        p52._ReplicationConnection = nil;
        _ReplicationConnection:Destroy();
    end;

    p52._DescendantConnection:Disconnect();

    for _, v in next, p52._DebugTrails do
        v:Destroy();
    end;

    for _, v in next, p52._CollidedEvents do
        for i in next, v do
            i:Destroy();
        end;
    end;

    u1.InitiatedCasters[p52] = nil;
    p52.RaycastParams = nil;
    p52.Object = nil;
    p52.Owner = nil;
    p52.Disabled = true;

    for i, v in next, p52 do
        if type(v) == "function" then
            p52[i] = function() -- Line: 259
            end;
        end;
    end;
end;

function u46.Stop(p53) -- Line: 263
    -- upvalues: u1 (copy)
    local _ReplicationConnection = p53._ReplicationConnection;

    if _ReplicationConnection then
        _ReplicationConnection:Stop();
    end;

    u1.InitiatedCasters[p53] = nil;
    p53.Disabled = true;
    local _Debug = p53._Debug;
    p53:DisableDebug();
    p53._Debug = _Debug;
end;

function u46.SetOwner(u54, u55) -- Line: 276
    -- upvalues: IsValidOwner (copy), u27 (copy), u1 (copy)
    local u56 = time() - u54._Created;
    task.spawn(function() -- Line: 278
        -- upvalues: u56 (copy), IsValidOwner (ref), u55 (copy), u54 (copy), u27 (ref), u1 (ref)
        if u56 < 0.1 then
            task.wait(0.1 - u56);
        end;

        IsValidOwner(u55);
        local _ReplicationConnection = u54._ReplicationConnection;
        local v57;

        if u55 == nil then
            v57 = false;
        else
            v57 = u27.new(u55, u54.Object, u54.RaycastParams, u54);
        end;

        u54._ReplicationConnection = v57;

        if _ReplicationConnection then
            _ReplicationConnection:Destroy();
        end;

        u54.Owner = u55;

        if u1.InitiatedCasters[u54] and (u55 ~= nil and v57) then
            v57:Start();
        end;
    end);
end;

function u46.GetOwner(p58) -- Line: 300
    return p58.Owner;
end;

function u46.SetMaxPingExhaustion(p59, p60) -- Line: 303
    if typeof(p60) ~= "number" then
        error(string.format("Unexpected argument #1 to \'ClientCaster.SetMaxPingExhaustion\' (%s expected, got %s)", "number", (typeof(p60))), 4);
    end;

    if p60 ~= p60 then
        error(string.format("Unexpected argument #1 to \'ClientCaster.SetMaxPingExhaustion\' (%s expected, got NaN)", "number", (typeof(p60))), 4);
    end;

    if p60 < 0.1 then
        error(
            "The max ping exhaustion time passed to \'ClientCaster.SetMaxPingExhaustion\' must be longer than 0.1",
            3
        );

        return;
    end;

    p59._ExhaustionTime = p60;
end;

function u46.GetMaxPingExhaustion(p61) -- Line: 313
    return p61._ExhaustionTime;
end;

function u46.GetPing(p62) -- Line: 316
    -- upvalues: SafeRemoteInvoke (copy), u4 (copy)
    return p62.Owner == nil and 0 or SafeRemoteInvoke(u4, p62.Owner, p62._ExhaustionTime);
end;

function u46.SetObject(u63, u64) -- Line: 323
    u63.Object = u64;

    for _, v in next, u63._DebugTrails do
        v:Destroy();
    end;

    table.clear(u63._DebugTrails);
    table.clear(u63._DamagePoints);
    local _DescendantConnection = u63._DescendantConnection;

    if _DescendantConnection then
        _DescendantConnection:Disconnect();
        u63._DescendantConnection = nil;
    end;

    if u63.Owner == nil then
        local v65 = next;
        local v66, v67 = u64:GetDescendants();

        for _, v in v65, v66, v67 do
            u63._OnDamagePointAdded(v);
        end;
    end;

    local v68;

    if u63.Owner == nil then
        v68 = u64.DescendantAdded:Connect(u63._OnDamagePointAdded) or nil;
    else
        v68 = nil;
    end;

    u63._DescendantConnection = v68;
    local _ReplicationConnection = u63._ReplicationConnection;
    task.spawn(function() -- Line: 346
        -- upvalues: _ReplicationConnection (copy), u63 (copy), u64 (copy)
        if _ReplicationConnection then
            local v69 = time() - u63._Created;

            if v69 < 1 then
                task.wait(1 - v69);
            end;

            _ReplicationConnection:Update({
                Object = u64
            });
        end;
    end);
end;

function u46.GetObject(p70) -- Line: 359
    return p70.Object;
end;

function u46.EditRaycastParams(p71, u72) -- Line: 362
    p71.RaycastParams = u72;
    local _ReplicationConnection = p71._ReplicationConnection;

    if _ReplicationConnection then
        local u73 = time() - p71._Created;
        task.spawn(function() -- Line: 368
            -- upvalues: u73 (copy), _ReplicationConnection (copy), u72 (copy)
            if u73 < 1 then
                task.wait(1 - u73);
            end;

            _ReplicationConnection:Update({
                RaycastParams = u72
            });
        end);
    end;
end;

function u46.SetRecursive(u74, u75) -- Line: 378
    if typeof(u75) ~= "boolean" then
        error(string.format("Unexpected argument #1 to \'ClientCaster.SetRecursive\' (%s expected, got %s)", "boolean", (typeof(u75))), 4);
    end;

    u74.Recursive = u75;
    local u76 = time() - u74._Created;
    task.spawn(function() -- Line: 383
        -- upvalues: u76 (copy), u74 (copy), u75 (copy)
        if u76 < 0.1 then
            task.wait(0.1 - u76);
        end;

        local _ReplicationConnection = u74._ReplicationConnection;

        if _ReplicationConnection then
            _ReplicationConnection:Update({
                Recursive = u75
            });
        end;
    end);
end;

function u46.__index(p77, p78) -- Line: 396
    -- upvalues: u50 (copy), Signal (copy), u46 (copy)
    local v79 = u50[p78];

    if not v79 then
        return rawget(u46, p78);
    end;

    local v80 = Signal.new();
    p77._CollidedEvents[v79][v80] = true;

    return v80.Invoked;
end;

local u81 = 0;

local function GenerateId() -- Line: 409
    -- upvalues: u81 (ref)
    u81 = u81 + 1;

    return u81;
end;

function u1.new(p82, p83, p84) -- Line: 413
    -- upvalues: IsValidOwner (copy), u2 (copy), u47 (copy), u81 (ref), u46 (copy), u27 (copy)
    IsValidOwner(p84);

    if typeof(p82) ~= "Instance" then
        error(string.format("Unexpected argument #2 to \'CastObject.new\' (%s expected, got %s)", "Instance", (typeof(p82))), 4);
    end;

    if typeof(p83) ~= "RaycastParams" then
        error(string.format("Unexpected argument #3 to \'CastObject.new\' (%s expected, got %s)", "RaycastParams", (typeof(p83))), 4);
    end;

    local u85 = nil;
    local u86 = {};
    local u87 = {};

    local function OnDamagePointAdded(u88) -- Line: 422
        -- upvalues: u2 (ref), u87 (copy), u85 (ref), u47 (ref), u86 (copy)
        if u88.ClassName == "Attachment" and (u88.Name == u2.AttachmentName and not u87[u88]) then
            local v89 = u88.Parent == u85.Object;
            u87[u88] = v89;

            if u85.Owner == nil then
                local Trail = Instance.new("Trail");
                local Attachment = Instance.new("Attachment");
                Attachment.Name = u2.DebugAttachmentName;
                Attachment.Position = u88.Position - Vector3.new(0, 0, 0.1);
                Trail.Color = ColorSequence.new(u2.DebugColor);
                Trail.Enabled = u85._Debug and (v89 or u85.Recursive);
                Trail.LightEmission = 1;
                Trail.Transparency = u47;
                Trail.FaceCamera = true;
                Trail.Lifetime = u2.DebugLifetime;
                Trail.Attachment0 = u88;
                Trail.Attachment1 = Attachment;
                Trail.Parent = Attachment;
                Attachment.Parent = u88.Parent;
                task.spawn(function() -- Line: 447
                    -- upvalues: u88 (copy), u85 (ref), Attachment (copy), u86 (ref), Trail (copy), u87 (ref)
                    repeat
                        u88.AncestryChanged:Wait();
                    until not u88:IsDescendantOf(u85.Object);

                    Attachment:Destroy();
                    u86[Trail] = nil;
                    u87[u88] = nil;
                end);
                u86[Trail] = Attachment;
            end;
        end;
    end;

    local v90 = {
        Disabled = true,
        Recursive = false,
        _ReplicationConnection = false,
        _ExhaustionTime = 1,
        _Class = "Caster",
        RaycastParams = p83,
        Object = p82,
        Owner = p84,
        _CollidedEvents = {
            Humanoid = {},
            Any = {}
        },
        _ToClean = {},
        _Created = time(),
        _Debug = u2.DebugMode
    };
    u81 = u81 + 1;
    v90._UniqueId = u81;
    v90._DamagePoints = u87;
    v90._DebugTrails = u86;
    v90._OnDamagePointAdded = OnDamagePointAdded;
    u85 = setmetatable(v90, u46);
    local v91 = next;
    local v92, v93 = p82:GetDescendants();

    for _, v in v91, v92, v93 do
        OnDamagePointAdded(v);
    end;

    u85._DescendantConnection = p82.DescendantAdded:Connect(OnDamagePointAdded);
    local v94;

    if p84 == nil then
        v94 = false;
    else
        v94 = u27.new(p84, p82, p83, u85);
    end;

    u85._ReplicationConnection = v94;

    return u85;
end;

local function UpdateCasterEvents(p95, p96) -- Line: 492
    if p96 then
        for i in next, p95._CollidedEvents.Any do
            i:Invoke(p96);
        end;

        local v97 = p96.Instance:FindFirstAncestorOfClass("Model");

        if v97 then
            v97 = v97:FindFirstChildOfClass("Humanoid");
        end;

        if v97 then
            for i in next, p95._CollidedEvents.Humanoid do
                i:Invoke(p96, v97);
            end;
        end;
    end;
end;

local function UpdateAttachment(p98, p99, p100) -- Line: 507
    -- upvalues: UpdateCasterEvents (copy)
    local WorldPosition = p98.WorldPosition;
    local v101 = p100[p98] or WorldPosition;

    if WorldPosition ~= v101 then
        UpdateCasterEvents(p99, (workspace:Raycast(WorldPosition, v101 - WorldPosition, p99.RaycastParams)));
    end;

    p100[p98] = WorldPosition;
end;

RunService.Heartbeat:Connect(function() -- Line: 519
    -- upvalues: u1 (copy), UpdateCasterEvents (copy)
    for i, v in next, u1.InitiatedCasters do
        if i.Owner == nil and i.Object then
            local Recursive = i.Recursive;

            for i2, v2 in next, i._DamagePoints do
                if v2 or Recursive then
                    local WorldPosition = i2.WorldPosition;
                    local v102 = v[i2] or WorldPosition;

                    if WorldPosition ~= v102 then
                        UpdateCasterEvents(i, (workspace:Raycast(WorldPosition, v102 - WorldPosition, i.RaycastParams)));
                    end;

                    v[i2] = WorldPosition;
                end;
            end;
        end;
    end;
end);

return u1;