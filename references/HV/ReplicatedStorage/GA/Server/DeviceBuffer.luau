 

 

local u1 = {};
u1.__index = u1;
local u2 = {
    Mobile = true,
    Desktop = true,
    Console = true,
    VR = true
};

function u1.new(p3, p4, p5) -- Line: 9
    -- upvalues: u1 (copy)
    return setmetatable({
        _count = 0,
        _closed = false,
        _timeouts = 0,
        _capacityFlushes = 0,
        _waitSeconds = p3.waitSeconds or 10,
        _maxPerPlayer = p3.maxPerPlayer or 64,
        _maxTotal = p3.maxTotal or 2048,
        _emit = p4,
        _deviceForUser = p5,
        _readyForUser = p3.readyForUser,
        _pending = {},
        _resolved = {}
    }, u1);
end;

function u1._send(p6, p7, p8) -- Line: 26
    -- upvalues: u2 (copy)
    local device = p7.properties.device;

    if not u2[p8] then
        p8 = not u2[device] and "Unknown" or device;
    end;

    p7.properties.device = p8;

    return p6._emit(p7);
end;

function u1._ready(p9, p10) -- Line: 36
    if not p9._readyForUser then
        return true;
    end;

    local success, result = pcall(p9._readyForUser, p10);

    return not success or result == true;
end;

function u1.release(p11, p12) -- Line: 45
    -- upvalues: u2 (copy)
    if not p11._pending[p12] then
        return;
    end;

    local v13 = p11._deviceForUser(p12);

    if u2[v13] and p11:_ready(p12) then
        p11:flushUser(p12, v13);
    end;
end;

function u1.flushUser(p14, p15, p16) -- Line: 55
    local v17 = p14._pending[p15];

    if not v17 then
        return;
    end;

    p14._pending[p15] = nil;
    p14._resolved[p15] = v17.sessionId;
    p14._count = p14._count - #v17.events;
    local v18 = p16 or p14._deviceForUser(p15);

    for _, v in v17.events do
        p14:_send(v, v18);
    end;
end;

function u1.add(u19, u20, p21) -- Line: 69
    -- upvalues: u2 (copy)
    if u19._closed then
        return false;
    end;

    local u22 = u19._pending[u20];

    if u22 and u22.sessionId ~= p21.sessionId then
        u19:flushUser(u20, "Unknown");
        u22 = nil;
    end;

    local v23 = u19._deviceForUser(u20);
    local v24 = u2[v23];

    if v24 and u19:_ready(u20) then
        u19:flushUser(u20, v23);

        return u19:_send(p21, v23);
    end;

    if u19._resolved[u20] == p21.sessionId then
        return u19:_send(p21, not v24 and "Unknown" or v23);
    end;

    if u19._count >= u19._maxTotal or u22 and #u22.events >= u19._maxPerPlayer then
        u19._capacityFlushes = u19._capacityFlushes + 1;
        u19:flushUser(u20, "Unknown");
        u19._resolved[u20] = p21.sessionId;

        return u19:_send(p21, "Unknown");
    end;

    if not u22 then
        u22 = {
            sessionId = p21.sessionId,
            events = {}
        };
        u19._pending[u20] = u22;
        task.delay(u19._waitSeconds, function() -- Line: 100
            -- upvalues: u19 (copy), u20 (copy), u22 (copy), u2 (ref)
            if u19._pending[u20] ~= u22 then
                return;
            end;

            local v25 = u19._deviceForUser(u20);

            if not u2[v25] then
                local v26 = u19;
                v26._timeouts = v26._timeouts + 1;
            end;

            u19:flushUser(u20, v25);
        end);
    end;

    table.insert(u22.events, p21);
    u19._count = u19._count + 1;

    return true;
end;

function u1.forgetUser(p27, p28) -- Line: 116
    p27:flushUser(p28);
    p27._resolved[p28] = nil;
end;

function u1.getStatus(p29) -- Line: 122
    local v30 = 0;

    for _ in p29._pending do
        v30 = v30 + 1;
    end;

    return {
        DevicePendingEvents = p29._count,
        DevicePendingPlayers = v30,
        DeviceTimeouts = p29._timeouts,
        DeviceCapacityFlushes = p29._capacityFlushes
    };
end;

function u1.close(p31) -- Line: 135
    p31._closed = true;

    while next(p31._pending) ~= nil do
        p31:flushUser((next(p31._pending)));
    end;

    table.clear(p31._resolved);
end;

return u1;