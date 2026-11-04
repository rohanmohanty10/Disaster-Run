 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local HttpService = game:GetService("HttpService");
local Types = require(script.Parent.Parent.Shared.Types);
local EventSchema = require(script.Parent.Parent.Shared.EventSchema);
local Config = require(script.Parent.Parent.Shared.Config);
local Signal = require(script.Parent.Parent.Shared.Signal);
local BatchQueue = require(script.Parent.BatchQueue);
local DeviceBuffer = require(script.Parent.DeviceBuffer);
local PlayerTracker = require(script.Parent.PlayerTracker);
local EconomyTracker = require(script.Parent.EconomyTracker);
local ReplayRecorder = require(script.Parent.ReplayRecorder);
local u1 = nil;

local function getRemoteConfig() -- Line: 61
    -- upvalues: u1 (ref)
    if u1 == nil then
        local success, result = pcall(require, script.Parent.RemoteConfig);

        if not success then
            result = false;
        end;

        u1 = result;
    end;

    return u1 or nil;
end;

local u2 = {};
u2.__index = u2;
local u3 = false;
local u4 = "";
local u5 = "";
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = Signal.new();
local u10 = nil;
local u11 = {};
local u12 = {};
local u13 = 0;
local u14 = nil;
local u15 = {};
local u16 = {};
local u17 = {};
local u18 = {
    Mobile = true,
    Desktop = true,
    Console = true,
    VR = true,
    Unknown = true
};
local u19 = {};
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = {};
local u24 = {};

local function trouble(p25: string, p26: string) -- Line: 123
    -- upvalues: u24 (copy), u23 (copy)
    u24[p25] = (u24[p25] or 0) + 1;
    local os_clock_ret = os.clock();

    if u23[p25] and os_clock_ret - u23[p25] < 60 then
        return;
    end;

    local v27 = u24[p25];
    u23[p25] = os_clock_ret;
    u24[p25] = 0;
    warn("[GA] " .. p26 .. (v27 <= 1 and "" or ` ({v27}x since the last warning)`));
end;

local function hookFailed(p28: string, p29: any) -- Line: 133
    -- upvalues: trouble (copy)
    trouble(p28, (`{p28} failed: {p29}`));
end;

local function getSessionId(p30: number) -- Line: 138
    -- upvalues: u15 (copy), HttpService (copy)
    if not u15[p30] then
        u15[p30] = HttpService:GenerateGUID(false);
    end;

    return u15[p30];
end;

local function stampExperiments(p31: number?, p32: table) -- Line: 151
    -- upvalues: u1 (ref)
    if p32.experiments ~= nil or not p31 then
        return;
    end;

    if u1 == nil then
        local success, result = pcall(require, script.Parent.RemoteConfig);

        if not success then
            result = false;
        end;

        u1 = result;
    end;

    local v33 = u1 or nil;

    if v33 and type(v33.peekAssignmentsByUserId) == "function" then
        local success, result = pcall(v33.peekAssignmentsByUserId, v33, p31);

        if success and type(result) == "table" then
            local v34 = nil;

            for i, v in result do
                if type(v) == "table" and (v.enrolled == true and type(v.group) == "string") then
                    v34 = v34 or {};
                    v34[i] = v.group;
                end;
            end;

            if v34 then
                p32.experiments = v34;
            end;
        end;
    end;
end;

local function enqueueEvent(p35: number, p36: string, p37: table) -- Line: 174
    -- upvalues: u6 (ref), u15 (copy), Players (copy), HttpService (copy), u20 (ref), trouble (copy), stampExperiments (copy), u16 (copy), u7 (ref)
    if not u6 then
        return false;
    end;

    if not (u15[p35] or Players:GetPlayerByUserId(p35)) then
        return false;
    end;

    local table_clone_ret = table.clone(p37);

    if not u15[p35] then
        u15[p35] = HttpService:GenerateGUID(false);
    end;

    local v38 = u15[p35];

    if u20 then
        local success, result = pcall(u20, p36, p35);

        if success then
            if type(result) == "table" then
                for i, v in result do
                    if table_clone_ret[i] == nil then
                        table_clone_ret[i] = v;
                    end;
                end;
            end;
        else
            trouble("Event enricher", (`Event enricher failed: {result}`));
        end;
    end;

    local v39;

    if game.JobId == "" then
        v39 = nil;
    else
        v39 = game.JobId;
    end;

    table_clone_ret.job_id = v39;
    stampExperiments(p35, table_clone_ret);
    local v40 = {
        eventType = p36,
        eventId = HttpService:GenerateGUID(false),
        timestamp = DateTime.now().UnixTimestampMillis,
        properties = table_clone_ret,
        userId = tostring(p35),
        sessionId = v38
    };

    if Players:GetPlayerByUserId(p35) then
        return u7:add(p35, v40);
    end;

    if table_clone_ret.device == nil then
        table_clone_ret.device = u16[p35] or "Unknown";
    end;

    return u6:add(v40);
end;

local u41 = {
    _sdk_heartbeat = true,
    _sdk_afk_start = true,
    _sdk_afk_return = true
};

local function onClientEvent(p42: userdata, p43: any) -- Line: 235
    -- upvalues: u3 (ref), u18 (copy), u13 (ref), trouble (copy), u17 (copy), u16 (copy), u7 (ref), u8 (ref), u12 (copy), u41 (copy), EventSchema (copy), enqueueEvent (copy)
    if not u3 or type(p43) ~= "table" then
        return;
    end;

    if p43.__goatDevice ~= nil then
        local __goatDevice = p43.__goatDevice;

        if type(__goatDevice) ~= "string" or not u18[__goatDevice] then
            u13 = u13 + 1;
            trouble("client", (`A client's device report was invalid and was ignored: {tostring(__goatDevice)}`));

            return;
        end;

        local os_clock_ret = os.clock();
        local v44 = u17[p42.UserId];

        if v44 and os_clock_ret - v44 < 0.5 then
            return;
        end;

        u17[p42.UserId] = os_clock_ret;
        local v45 = u16[p42.UserId];

        if not v45 or v45 == "Unknown" then
            u16[p42.UserId] = __goatDevice;
        end;

        local v46 = u16[p42.UserId];

        if v46 ~= "Unknown" and u7 then
            u7:release(p42.UserId);
        end;

        if u8 then
            u8:FireClient(p42, {
                __goatDeviceAck = v46
            });
        end;

        return;
    end;

    local os_clock_ret = os.clock();
    local v47 = u12[p42.UserId];

    if not v47 or os_clock_ret - v47.start >= 5 then
        v47 = {
            count = 0,
            start = os_clock_ret
        };
        u12[p42.UserId] = v47;
    end;

    v47.count = v47.count + 1;

    if v47.count > 10 then
        u13 = u13 + 1;
        trouble(
            "client rate",
            "A client sent more than 10 analytics events in 5 seconds; the extra ones were dropped"
        );

        return;
    end;

    local eventType = p43.eventType;
    local properties = p43.properties;

    if type(properties) ~= "table" then
        u13 = u13 + 1;
        trouble("client", (`A client event without properties was dropped: {tostring(eventType)}`));

        return;
    end;

    local v48;

    if eventType == "interaction_event" then
        v48 = {
            action = properties.action,
            target = properties.target,
            value = properties.value
        };
    else
        if eventType ~= "custom_event" or (type(properties.eventName) ~= "string" or not u41[properties.eventName]) then
            u13 = u13 + 1;
            trouble("client", (`A client sent an event clients may not send, so it was dropped: {tostring(eventType)}`));

            return;
        end;

        v48 = {
            eventName = properties.eventName,
            isAFK = properties.isAFK == true
        };
    end;

    local v49, v50 = EventSchema.validate(eventType, v48);

    if v49 then
        v48.eventSource = "client";
        enqueueEvent(p42.UserId, eventType, v48);

        return;
    end;

    u13 = u13 + 1;
    trouble("client", (`A client {eventType} was rejected: {v50}`));
end;

local function installDeviceBootstrap() -- Line: 317
    -- upvalues: ReplicatedFirst (copy)
    local Parent = script.Parent.Parent;

    for _, child in ReplicatedFirst:GetChildren() do
        local GoatSdk = child:FindFirstChild("GoatSdk");

        if child:IsA("LocalScript") and (GoatSdk and (GoatSdk:IsA("ObjectValue") and GoatSdk.Value == Parent)) then
            return;
        end;
    end;

    local DeviceBootstrap = script.Parent:FindFirstChild("DeviceBootstrap");

    if not (DeviceBootstrap and DeviceBootstrap:IsA("LocalScript")) then
        warn("[GA] DeviceBootstrap template is missing; require the SDK from an early LocalScript.");

        return;
    end;

    local v51 = DeviceBootstrap:Clone();
    v51.Name = "GAClient";
    local ObjectValue = Instance.new("ObjectValue");
    ObjectValue.Name = "GoatSdk";
    ObjectValue.Value = Parent;
    ObjectValue.Parent = v51;
    v51.Enabled = true;
    v51.Parent = ReplicatedFirst;
end;

function u2.init(p52: table, p53: table) -- Line: 344
    -- upvalues: u3 (ref), Config (copy), u4 (ref), u5 (ref), u8 (ref), ReplicatedStorage (copy), u6 (ref), BatchQueue (copy), u7 (ref), DeviceBuffer (copy), u22 (ref), trouble (copy), u21 (ref), stampExperiments (copy), u16 (copy), u14 (ref), onClientEvent (copy), PlayerTracker (copy), u2 (copy), EconomyTracker (copy), installDeviceBootstrap (copy)
    if u3 then
        warn("[GA] Already initialized");

        return;
    end;

    assert(p53.appId and #p53.appId > 0, "[GA] appId is required");
    local v54 = Config.isApiKey(p53.apiKey);
    assert(v54, "[GA] apiKey is required");
    u4 = p53.appId;
    u5 = p53.apiKey;
    local v55 = p53.options or {};
    u8 = Instance.new("RemoteEvent");
    u8.Name = "GAEvent";
    u8.Parent = ReplicatedStorage;
    u6 = BatchQueue.new({
        appId = u4,
        apiKey = p53.apiKey,
        endpoint = v55.endpoint,
        batchSize = v55.batchSize,
        flushInterval = v55.flushInterval,
        maxQueueSize = v55.maxQueueSize
    });
    u7 = DeviceBuffer.new({
        waitSeconds = 10,
        maxPerPlayer = 64,
        maxTotal = 2048,

        readyForUser = function(p56) -- Line: 376, Name: readyForUser
            -- upvalues: u22 (ref), trouble (ref)
            if u22 == nil then
                return true;
            end;

            local success, result = pcall(u22, p56);

            if success then
                return result == true;
            end;

            trouble("Metadata gate", (`Metadata gate failed: {result}`));

            return true;
        end
    }, function(p57) -- Line: 387
        -- upvalues: u21 (ref), trouble (ref), stampExperiments (ref), u6 (ref)
        local v58 = tonumber(p57.userId);

        if u21 then
            local success, result = pcall(u21, p57.eventType, v58, p57.properties);

            if not success then
                trouble("Late enricher", (`Late enricher failed: {result}`));
            end;
        end;

        stampExperiments(v58, p57.properties);

        return u6:add(p57);
    end, function(p59) -- Line: 399
        -- upvalues: u16 (ref)
        return u16[p59];
    end);
    u6:start();
    u14 = u8.OnServerEvent:Connect(onClientEvent);
    u3 = true;
    PlayerTracker._init(u2);
    EconomyTracker._init(u2);
    installDeviceBootstrap();
    u3 = true;
    print((`[GA] SDK initialized (appId: {u4}, v{Config.DEFAULT.SDK_VERSION})`));
end;

function u2.setEventEnricher(p60: table, p61: function?) -- Line: 424
    -- upvalues: u20 (ref)
    u20 = p61;
end;

function u2.setLateEnricher(p62: table, p63: function?) -- Line: 433
    -- upvalues: u21 (ref)
    u21 = p63;
end;

function u2.setMetadataGate(p64: table, p65: function?) -- Line: 442
    -- upvalues: u22 (ref)
    u22 = p65;
end;

function u2.track(p66: table, p67: userdata, p68: string, p69: table?) -- Line: 452
    -- upvalues: u3 (ref), u13 (ref), trouble (copy), EventSchema (copy), enqueueEvent (copy)
    if u3 and (typeof(p67) == "Instance" and p67:IsA("Player")) then
        local v70 = p69 or {};
        local v71, v72 = EventSchema.validate(p68, v70);

        if v71 then
            return enqueueEvent(p67.UserId, p68, v70) == true;
        end;

        u13 = u13 + 1;
        trouble("rejected", (`A {p68}{(type(v70) ~= "table" or type(v70.eventName) ~= "string") and "" or " " .. v70.eventName} was rejected: {v72}`));

        return false;
    end;

    u13 = u13 + 1;
    local v73;

    if u3 then
        v73 = `A {p68} without a player was dropped`;
    else
        v73 = `A {p68} came while the SDK was not running and was dropped`;
    end;

    trouble("untracked", v73);

    return false;
end;

function u2.getStatus(p74) -- Line: 476
    -- upvalues: u6 (ref), u13 (ref), u7 (ref)
    local v75 = not u6 and {} or u6:getStatus();
    v75.Rejected = u13;

    if u7 then
        for i, v in u7:getStatus() do
            v75[i] = v;
        end;
    end;

    return v75;
end;

function u2._beginSession(p76: table, p77: userdata) -- Line: 488
    -- upvalues: u15 (copy), u11 (copy), u18 (copy), u16 (copy), HttpService (copy)
    local UserId = p77.UserId;
    local v78 = false;
    local success, result = pcall(p77.GetJoinData, p77);
    local v79;

    if success and (type(result) == "table" and (result.SourceGameId == game.GameId and type(result.TeleportData) == "table")) then
        v79 = result.TeleportData._goatSessions;
    else
        v79 = nil;
    end;

    local v80;

    if type(v79) == "table" then
        v80 = v79[tostring(UserId)];
    else
        v80 = nil;
    end;

    if type(v80) ~= "table" or (type(v80.id) ~= "string" or (#v80.id ~= 36 or not (v80.id:match("^[%x%-]+$") and (type(v80.startedAt) == "number" and (v80.startedAt == v80.startedAt and (v80.startedAt <= os.time() and v80.startedAt >= os.time() - 604800)))))) then
        u15[UserId] = HttpService:GenerateGUID(false);
        u11[UserId] = os.time();

        return v78;
    end;

    u15[UserId] = v80.id;
    u11[UserId] = v80.startedAt;

    if type(v80.device) == "string" and (u18[v80.device] and (v80.device ~= "Unknown" and (not u16[UserId] or u16[UserId] == "Unknown"))) then
        u16[UserId] = v80.device;
    end;

    return true;
end;

function u2.getSessionStartedAt(p81: table, p82: userdata) -- Line: 526
    -- upvalues: u11 (copy)
    return u11[p82.UserId] or os.time();
end;

function u2.prepareTeleport(p83: table, p84: table, p85: table?) -- Line: 530
    -- upvalues: u16 (copy)
    local table_clone_ret = table.clone(p85 or {});
    local v86 = {};

    for _, v in p84 do
        if v:IsA("Player") then
            v86[tostring(v.UserId)] = {
                id = p83:getSessionId(v),
                startedAt = p83:getSessionStartedAt(v),
                device = u16[v.UserId]
            };
            p83:markTeleporting(v);
        end;
    end;

    table_clone_ret._goatSessions = v86;

    return table_clone_ret;
end;

function u2.clearTeleporting(p87: table, p88: userdata) -- Line: 550
    -- upvalues: u19 (copy)
    u19[p88.UserId] = nil;
end;

function u2.trackEconomy(p89: table, p90: userdata, p91: string, p92: string, p93: number, p94: string?, p95: string?) -- Line: 565
    -- upvalues: Types (copy)
    p89:track(p90, Types.EventType.ECONOMY, {
        flow = p91,
        currency = p92,
        amount = p93,
        source = p94,
        itemId = p95
    });
end;

function u2.trackProgression(p96: table, p97: userdata, p98: string, p99: string, p100: number?) -- Line: 589
    -- upvalues: Types (copy)
    p96:track(p97, Types.EventType.PROGRESSION, {
        status = p98,
        level = p99,
        score = p100
    });
end;

function u2.trackBusiness(p101: table, p102: userdata, p103: string, p104: string, p105: number, p106: string?) -- Line: 607
    -- upvalues: Types (copy)
    p101:track(p102, Types.EventType.BUSINESS, {
        businessType = p103,
        productId = p104,
        amount = p105,
        receiptId = p106
    });
end;

function u2.markTeleporting(p107: table, p108: userdata) -- Line: 635
    -- upvalues: u19 (copy)
    if not (p108 and p108:IsA("Player")) then
        return;
    end;

    u19[p108.UserId] = os.clock() + 30;
end;

function u2._consumeTeleportFlag(p109: table, p110: number) -- Line: 646
    -- upvalues: u19 (copy)
    local v111 = u19[p110];
    u19[p110] = nil;
    local v112;

    if v111 == nil then
        v112 = false;
    else
        v112 = os.clock() < v111;
    end;

    return v112;
end;

function u2.getSessionId(p113: table, p114: userdata) -- Line: 653
    -- upvalues: u15 (copy), HttpService (copy)
    local UserId = p114.UserId;

    if not u15[UserId] then
        u15[UserId] = HttpService:GenerateGUID(false);
    end;

    return u15[UserId];
end;

function u2.enableReplay(p115: table, p116: any, p117: table?) -- Line: 676
    -- upvalues: u3 (ref), u10 (ref), ReplayRecorder (copy), u4 (ref), u5 (ref), u9 (copy), u15 (copy), HttpService (copy), u16 (copy)
    if not u3 then
        warn("[GA] enableReplay called before init — ignored");

        return;
    end;

    if u10 then
        warn("[GA] Replay already enabled");

        return;
    end;

    local v118;

    if type(p116) == "table" then
        v118 = type(p116.captureFrame) == "function";
    else
        v118 = false;
    end;

    assert(v118, "[GA] enableReplay requires an adapter with a captureFrame(player) function");
    local v119 = p117 or {};
    u10 = ReplayRecorder.new({
        appId = u4,
        apiKey = u5,
        adapter = p116,
        realLeaveSignal = u9,

        sessionIdFn = function(p120: userdata) -- Line: 698, Name: sessionIdFn
            -- upvalues: u15 (ref), HttpService (ref)
            local UserId = p120.UserId;

            if not u15[UserId] then
                u15[UserId] = HttpService:GenerateGUID(false);
            end;

            return u15[UserId];
        end,

        deviceFn = function(p121: userdata) -- Line: 701, Name: deviceFn
            -- upvalues: u16 (ref)
            return u16[p121.UserId];
        end,

        endpoint = v119.endpoint,
        window = v119.window,
        rate = v119.rate,
        byteBudget = v119.byteBudget,
        sampleRate = v119.sampleRate,
        maxUploadsPerMinute = v119.maxUploadsPerMinute,
        maxEvents = v119.maxEvents,
        formatVersion = v119.formatVersion,
        configVersion = v119.configVersion,
        gameVersion = v119.gameVersion
    });
    u10:start();
    print("[GA] Replay enabled");
end;

function u2.flagReplay(p122: table, p123: userdata, p124: string?) -- Line: 727
    -- upvalues: u10 (ref)
    if u10 then
        u10:flag(p123, p124);
    end;
end;

function u2.unflagReplay(p125: table, p126: userdata) -- Line: 740
    -- upvalues: u10 (ref)
    if u10 then
        u10:unflag(p126);
    end;
end;

function u2.logReplayEvent(p127: table, p128: userdata, p129: table) -- Line: 751
    -- upvalues: u10 (ref)
    if u10 then
        u10:logEvent(p128, p129);
    end;
end;

function u2._fireRealLeave(p130: table, p131: userdata, p132: number) -- Line: 760
    -- upvalues: u9 (copy)
    u9:Fire(p131, p132);
end;

function u2._onPlayerLeaving(p133: table, u134: number) -- Line: 768
    -- upvalues: u7 (ref), Players (copy), u11 (copy), u12 (copy), u19 (copy), u15 (copy), u16 (copy), u17 (copy)
    if u7 then
        u7:forgetUser(u134);
    end;

    task.delay(30, function() -- Line: 772
        -- upvalues: Players (ref), u134 (copy), u7 (ref), u11 (ref), u12 (ref), u19 (ref), u15 (ref), u16 (ref), u17 (ref)
        if Players:GetPlayerByUserId(u134) then
            return;
        end;

        if u7 then
            u7:forgetUser(u134);
        end;

        u11[u134] = nil;
        u12[u134] = nil;
        u19[u134] = nil;
        u15[u134] = nil;
        u16[u134] = nil;
        u17[u134] = nil;
    end);
end;

function u2.shutdown(p135) -- Line: 790
    -- upvalues: u3 (ref), PlayerTracker (copy), u14 (ref), u10 (ref), u7 (ref), u6 (ref)
    u3 = false;
    PlayerTracker:shutdown();

    if u14 then
        u14:Disconnect();
    end;

    if u10 then
        u10:stop();
    end;

    if u7 then
        u7:close();
    end;

    if u6 then
        u6:stop();
    end;

    u3 = false;
end;

return u2;