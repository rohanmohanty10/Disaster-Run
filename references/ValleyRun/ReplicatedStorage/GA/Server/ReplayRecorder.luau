 

 

local Players = game:GetService("Players");
game:GetService("RunService");
local Config = require(script.Parent.Parent.Shared.Config);
local ReplayCodec = require(script.Parent.Parent.Shared.ReplayCodec);
local ReplayUploader = require(script.Parent.ReplayUploader);
local u1 = {};
u1.__index = u1;

function u1.new(p2: table) -- Line: 70
    -- upvalues: u1 (copy), Config (copy), ReplayUploader (copy)
    local v3 = setmetatable({}, u1);
    v3._appId = p2.appId;
    v3._adapter = p2.adapter;
    v3._realLeaveSignal = p2.realLeaveSignal;
    v3._sessionIdFn = p2.sessionIdFn;
    v3._deviceFn = p2.deviceFn;
    v3._window = p2.window or Config.DEFAULT.REPLAY_WINDOW_SECONDS;
    v3._rate = p2.rate or Config.DEFAULT.REPLAY_RATE_HZ;
    v3._byteBudget = p2.byteBudget or Config.DEFAULT.REPLAY_BYTE_BUDGET;
    v3._formatVersion = p2.formatVersion or Config.DEFAULT.REPLAY_FORMAT_VERSION;
    v3._sampleRate = p2.sampleRate or Config.DEFAULT.REPLAY_SAMPLE_RATE;
    v3._maxUploadsPerMinute = p2.maxUploadsPerMinute or 2;
    v3._uploadTimes = {};
    v3._uploadsInFlight = 0;
    v3._configVersion = p2.configVersion;
    v3._gameVersion = p2.gameVersion;
    v3._schema = type(p2.adapter) == "table" and (p2.adapter.schema or "raw") or "raw";
    v3._maxEvents = p2.maxEvents or 600;
    local math_floor_ret = math.floor(v3._window * v3._rate);
    v3._maxFrames = math.max(1, math_floor_ret);
    v3._frameInterval = 1 / v3._rate;
    v3._maxUncompressedBytes = v3._byteBudget * 4;
    v3._uploader = ReplayUploader.new({
        appId = p2.appId,
        apiKey = p2.apiKey,
        endpoint = p2.endpoint or Config.DEFAULT.REPLAY_ENDPOINT
    });
    v3._buffers = {};
    v3._running = false;
    v3._connections = {};

    return v3;
end;

function u1._open(p4: table, p5: number) -- Line: 116
    p4._buffers[p5] = {
        flagged = false,
        reason = nil,
        frames = {},
        events = {},
        startClock = os.clock()
    };
end;

function u1.start(u6) -- Line: 130
    -- upvalues: Players (copy)
    if u6._running then
        return;
    end;

    u6._running = true;
    table.insert(u6._connections, Players.PlayerAdded:Connect(function(p7) -- Line: 140
        -- upvalues: u6 (copy)
        u6:_open(p7.UserId);
    end));

    for _, v in Players:GetPlayers() do
        if not u6._buffers[v.UserId] then
            u6:_open(v.UserId);
        end;
    end;

    u6._realLeaveConn = u6._realLeaveSignal:Connect(function(p8, p9) -- Line: 154
        -- upvalues: u6 (copy)
        u6:_onRealLeave(p8, p9);
    end);
    table.insert(u6._connections, Players.PlayerRemoving:Connect(function(p10) -- Line: 164
        -- upvalues: Players (ref), u6 (copy)
        local UserId = p10.UserId;
        task.delay(5, function() -- Line: 166
            -- upvalues: Players (ref), UserId (copy), u6 (ref)
            if not Players:GetPlayerByUserId(UserId) then
                u6._buffers[UserId] = nil;
            end;
        end);
    end));
    task.spawn(function() -- Line: 176
        -- upvalues: u6 (copy), Players (ref)
        while u6._running do
            local os_clock_ret = os.clock();

            for i, v in u6._buffers do
                local PlayerByUserId = Players:GetPlayerByUserId(i);

                if PlayerByUserId then
                    local success, result = pcall(u6._adapter.captureFrame, PlayerByUserId);

                    if success and type(result) == "table" then
                        result.t = math.floor((os_clock_ret - v.startClock) * 1000);
                        table.insert(v.frames, result);
                        local v11 = v;

                        while #v11.frames > u6._maxFrames do
                            table.remove(v11.frames, 1);
                        end;
                    elseif not success then
                        warn((`[GA:Replay] captureFrame errored: {tostring(result)}`));
                    end;
                end;
            end;

            task.wait(u6._frameInterval);
        end;
    end);
end;

function u1.flag(p12: table, p13: userdata, p14: string?) -- Line: 206
    local v15 = p12._buffers[p13.UserId];

    if v15 then
        v15.flagged = true;

        if p14 and not v15.reason then
            v15.reason = p14;
        end;
    end;
end;

function u1.unflag(p16: table, p17: userdata) -- Line: 231
    local v18 = p16._buffers[p17.UserId];

    if v18 then
        v18.flagged = false;
        v18.reason = nil;
    end;
end;

function u1.logEvent(p19: table, p20: userdata, p21: table) -- Line: 243
    local v22 = p19._buffers[p20.UserId];

    if not v22 or type(p21) ~= "table" then
        return;
    end;

    local v23 = (os.clock() - v22.startClock) * 1000;
    p21.t = math.floor(v23);
    table.insert(v22.events, p21);

    while #v22.events > p19._maxEvents do
        table.remove(v22.events, 1);
    end;
end;

function u1._onRealLeave(u24: table, p25: userdata, p26: number) -- Line: 258
    -- upvalues: ReplayCodec (copy)
    local UserId = p25.UserId;
    local v27 = u24._buffers[UserId];
    u24._buffers[UserId] = nil;

    if not v27 then
        return;
    end;

    if type(u24._adapter.flagReason) == "function" then
        local success, result = pcall(u24._adapter.flagReason, p25);

        if success and type(result) == "string" then
            v27.flagged = true;
            v27.reason = result;
        end;
    end;

    if type(u24._adapter.sampleRate) == "function" then
        local success, result = pcall(u24._adapter.sampleRate);

        if success and (type(result) == "number" and result == result) then
            u24._sampleRate = math.clamp(result, 0, 1);
        end;
    end;

    local flagged = v27.flagged;

    if not flagged then
        if u24._sampleRate > 0 then
            flagged = math.random() < u24._sampleRate;
        else
            flagged = false;
        end;
    end;

    if not flagged or #v27.frames == 0 then
        return;
    end;

    local os_clock_ret = os.clock();

    while #u24._uploadTimes > 0 and u24._uploadTimes[1] <= os_clock_ret - 60 do
        table.remove(u24._uploadTimes, 1);
    end;

    if #u24._uploadTimes >= u24._maxUploadsPerMinute then
        return;
    end;

    table.insert(u24._uploadTimes, os_clock_ret);
    local v28 = nil;
    local v29;

    if type(u24._adapter.captureHeader) == "function" then
        local v30;
        v30, v29 = pcall(u24._adapter.captureHeader, p25);

        if v30 then
            if type(v29) ~= "table" then
                v29 = v28;
            end;
        else
            v29 = v28;
        end;
    else
        v29 = v28;
    end;

    local v31 = u24._sessionIdFn and (u24._sessionIdFn(p25) or "") or "";
    local u32 = v27.reason or "session_end";
    local v33 = u24._deviceFn and (u24._deviceFn(p25) or "") or "";
    local v34, u35, u36 = pcall(ReplayCodec.encode, {
        v = u24._formatVersion,
        schema = u24._schema,
        header = v29,
        frames = v27.frames,
        events = v27.events
    }, {
        maxBytes = u24._maxUncompressedBytes
    });

    if not v34 then
        warn("[GA:Replay] Replay rejected by encoder: " .. tostring(u35));

        return;
    end;

    if u36.frameCount == 0 then
        return;
    end;

    if u36.droppedFrames > 0 then
        warn((`[GA:Replay] Trimmed {u36.droppedFrames} oldest frame(s) to fit byte budget (user {UserId})`));
    end;

    local u37 = {
        sessionId = v31,
        userId = UserId,
        serverId = game.JobId,
        reason = u32,
        capturedAtMs = os.time() * 1000,
        device = v33,
        durationMs = u36.durationMs
    };
    local v38 = math.max(0, p26) * 1000;
    u37.sessionDurationMs = math.floor(v38);
    u37.formatVersion = u24._formatVersion;
    u37.configVersion = u24._configVersion;
    u37.gameVersion = u24._gameVersion;
    u24._uploadsInFlight = u24._uploadsInFlight + 1;
    task.spawn(function() -- Line: 349
        -- upvalues: u24 (copy), u35 (copy), u37 (copy), UserId (copy), u36 (copy), u32 (copy)
        local v39, v40, v41 = pcall(u24._uploader.upload, u24._uploader, u35, u37);
        local v42 = u24;
        v42._uploadsInFlight = v42._uploadsInFlight - 1;

        if v39 and v40 then
            print(`[GA:Replay] Uploaded replay {tostring(v41)} ` .. `(user {UserId}, {u36.frameCount} frames, reason "{u32}")`);
        end;
    end);
end;

function u1.stop(p43) -- Line: 367
    p43._running = false;

    if p43._realLeaveConn then
        p43._realLeaveConn:Disconnect();
        p43._realLeaveConn = nil;
    end;

    for _, v in p43._connections do
        v:Disconnect();
    end;

    table.clear(p43._connections);
    table.clear(p43._buffers);
    local v44 = os.clock() + 5;

    while p43._uploadsInFlight > 0 and os.clock() < v44 do
        task.wait();
    end;
end;

return u1;