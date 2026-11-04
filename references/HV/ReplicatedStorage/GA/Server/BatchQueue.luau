 

 

local HttpService = game:GetService("HttpService");
local Config = require(script.Parent.Parent.Shared.Config);
local u1 = {};
u1.__index = u1;

function u1.new(p2: table) -- Line: 46
    -- upvalues: u1 (copy), Config (copy)
    local v3 = setmetatable({}, u1);
    v3._appId = p2.appId;
    v3._apiKey = p2.apiKey;
    v3._endpoint = p2.endpoint or Config.DEFAULT.API_ENDPOINT;
    v3._batchSize = p2.batchSize or Config.DEFAULT.BATCH_SIZE;
    v3._flushInterval = p2.flushInterval or Config.DEFAULT.FLUSH_INTERVAL;
    v3._maxQueueSize = p2.maxQueueSize or Config.DEFAULT.MAX_QUEUE_SIZE;
    v3._queue = {};
    v3._flushing = false;
    v3._flushScheduled = false;
    v3._running = false;
    v3._closed = false;
    v3._stats = {
        Accepted = 0,
        Sent = 0,
        Failed = 0,
        Dropped = 0
    };
    v3._warnedAt = {};
    v3._unwarned = {};
    v3._pausedUntil = 0;
    v3._pauseSeconds = 60;

    return v3;
end;

function u1._trouble(p4: table, p5: string, p6: string) -- Line: 68
    p4._unwarned[p5] = (p4._unwarned[p5] or 0) + 1;
    local os_clock_ret = os.clock();
    local v7 = p4._warnedAt[p5];

    if v7 and os_clock_ret - v7 < 60 then
        return;
    end;

    local v8 = p4._unwarned[p5];
    local _unwarned = p4._unwarned;
    p4._warnedAt[p5] = os_clock_ret;
    _unwarned[p5] = 0;
    warn("[GA] " .. p6 .. (v8 <= 1 and "" or ` ({v8}x since the last warning)`));
end;

function u1.start(u9) -- Line: 81
    if u9._running then
        return;
    end;

    u9._running = true;
    task.spawn(function() -- Line: 88
        -- upvalues: u9 (copy)
        while u9._running do
            task.wait(u9._flushInterval);

            if u9._running and (#u9._queue > 0 and not u9._flushing) then
                u9:flush();
            end;
        end;
    end);
end;

function u1.stop(p10: table, p11: number?) -- Line: 99
    p10._running = false;
    p10._closed = true;
    p10._deadline = os.clock() + (p11 or 12);

    while p10._flushing and os.clock() < p10._deadline do
        task.wait();
    end;

    if not p10._flushing then
        p10:flush();
    end;

    if #p10._queue > 0 then
        local _stats = p10._stats;
        _stats.Dropped = _stats.Dropped + #p10._queue;
        p10:_trouble("unsent", (`{#p10._queue} events were still unsent when the server closed`));
    end;

    table.clear(p10._queue);
end;

function u1.add(u12: table, p13: table) -- Line: 118
    if u12._closed or #u12._queue >= u12._maxQueueSize then
        local _stats = u12._stats;
        _stats.Dropped = _stats.Dropped + 1;
        u12:_trouble("dropped", u12._closed and "An event came after the server started closing and was dropped" or `An event was dropped: {u12._maxQueueSize} are already waiting (the ingest is slow or unreachable)`);

        return false;
    end;

    table.insert(u12._queue, p13);
    local _stats = u12._stats;
    _stats.Accepted = _stats.Accepted + 1;

    if #u12._queue >= u12._batchSize and not (u12._flushing or u12._flushScheduled) then
        u12._flushScheduled = true;
        task.defer(function() -- Line: 134
            -- upvalues: u12 (copy)
            u12._flushScheduled = false;
            u12:flush();
        end);
    end;

    return true;
end;

function u1.getStatus(p14) -- Line: 143
    local table_clone_ret = table.clone(p14._stats);
    table_clone_ret.Queued = #p14._queue;
    table_clone_ret.Flushing = p14._flushing;

    return table_clone_ret;
end;

local function groupEvents(p15: table) -- Line: 151
    local v16 = {};
    local v17 = {};

    for _, v in p15 do
        local v18 = v.userId .. ":" .. v.sessionId;

        if not v16[v18] then
            v16[v18] = {
                userId = v.userId,
                sessionId = v.sessionId,
                events = {}
            };
            table.insert(v17, v18);
        end;

        local properties = v.properties;

        if properties == nil or type(properties) == "table" and next(properties) == nil then
            properties = nil;
        end;

        table.insert(v16[v18].events, {
            eventType = v.eventType,
            eventId = v.eventId,
            timestamp = v.timestamp,
            properties = properties
        });
    end;

    local v19 = {};

    for _, v in v17 do
        table.insert(v19, v16[v]);
    end;

    return v19;
end;

local function describe(p20: boolean, p21: any) -- Line: 189
    if not p20 then
        return tostring(p21);
    end;

    local v22 = type(p21.Body) ~= "string" and "" or string.sub(p21.Body, 1, 200);

    return `HTTP {p21.StatusCode} {p21.StatusMessage} {v22}`;
end;

function u1._sendBatch(u23: table, p24: table) -- Line: 198
    -- upvalues: HttpService (copy), Config (copy)
    local JSONEncode = HttpService.JSONEncode;
    local v25 = {
        appId = u23._appId,
        userId = p24.userId,
        sessionId = p24.sessionId,
        timestamp = os.time() * 1000,
        events = p24.events,
        sdkVersion = Config.DEFAULT.SDK_VERSION,
        clientVersion = Config.DEFAULT.SDK_VERSION
    };
    local success, result = pcall(JSONEncode, HttpService, v25);

    if success then
        for i = 1, 3 do
            if u23._deadline and os.clock() >= u23._deadline then
                return false;
            end;

            local success2, result2 = pcall(function() -- Line: 221
                -- upvalues: HttpService (ref), u23 (copy), Config (ref), result (copy)
                return HttpService:RequestAsync({
                    Method = "POST",
                    Url = u23._endpoint,
                    Headers = {
                        Authorization = Config.authorizationHeader(u23._apiKey),
                        ["Content-Type"] = "application/json"
                    },
                    Body = result
                });
            end);

            if success2 and result2.Success then
                u23._pauseSeconds = 60;

                return true;
            end;

            local v26;

            if success2 then
                v26 = result2.StatusCode;
            else
                v26 = nil;
            end;

            if v26 == 401 or v26 == 403 then
                u23._pausedUntil = os.clock() + u23._pauseSeconds;
                local _pauseSeconds = u23._pauseSeconds;
                local v27;

                if success2 then
                    local v28 = type(result2.Body) ~= "string" and "" or string.sub(result2.Body, 1, 200);
                    v27 = `HTTP {result2.StatusCode} {result2.StatusMessage} {v28}`;
                else
                    v27 = tostring(result2);
                end;

                u23:_trouble("auth", (`The ingest refused the API key, so sending pauses {_pauseSeconds}s: {v27}`));
                u23._pauseSeconds = math.min(u23._pauseSeconds * 2, 1800);

                return false;
            end;

            if v26 ~= nil and v26 ~= 429 and v26 < 500 or i == 3 then
                local v29 = #p24.events;
                local v30;

                if success2 then
                    local v31 = type(result2.Body) ~= "string" and "" or string.sub(result2.Body, 1, 200);
                    v30 = `HTTP {result2.StatusCode} {result2.StatusMessage} {v31}`;
                else
                    v30 = tostring(result2);
                end;

                u23:_trouble("send", (`A batch of {v29} event(s) was dropped after {i} attempt(s): {v30}`));

                return false;
            end;

            local v32 = 2 ^ (i - 1) * 2;

            if u23._deadline then
                local v33 = u23._deadline - os.clock();
                local math_max_ret = math.max(0, v33);
                v32 = math.min(v32, math_max_ret);
            end;

            task.wait(v32);
            local _ = i;
        end;

        return false;
    end;

    u23:_trouble("encode", (`A batch of {#p24.events} event(s) could not be encoded and was dropped: {result}`));

    return false;
end;

function u1.flush(u34) -- Line: 273
    -- upvalues: groupEvents (copy)
    if u34._flushing or #u34._queue == 0 then
        return;
    end;

    if os.clock() < u34._pausedUntil and not u34._closed then
        return;
    end;

    u34._flushing = true;
    local _queue = u34._queue;
    u34._queue = {};
    local v35 = u34._deadline or (1 / 0);
    local u36 = 0;

    local function send(p37) -- Line: 292
        -- upvalues: u34 (copy), u36 (ref)
        local success, result = pcall(u34._sendBatch, u34, p37);

        if not success then
            u34:_trouble("error", (`Sending a batch failed: {result}`));
        end;

        if success and result then
            local _stats = u34._stats;
            _stats.Sent = _stats.Sent + #p37.events;
        else
            local _stats = u34._stats;
            _stats.Failed = _stats.Failed + #p37.events;
        end;

        u36 = u36 - 1;
    end;

    for _, v in groupEvents(_queue) do
        local v38 = v;

        for i = 1, #v.events, u34._batchSize do
            local v39 = {
                userId = v38.userId,
                sessionId = v38.sessionId,
                events = {}
            };
            local _ = i;

            for i2 = i, math.min(i + u34._batchSize - 1, #v38.events) do
                table.insert(v39.events, v38.events[i2]);
                local _ = i2;
            end;

            while u36 >= 10 and os.clock() < v35 do
                task.wait();
            end;

            u36 = u36 + 1;
            task.spawn(send, v39);
        end;
    end;

    while u36 > 0 and os.clock() < v35 do
        task.wait();
    end;

    u34._flushing = false;
end;

return u1;