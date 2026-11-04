 
 

local RunService = game:GetService("RunService");
local Warn = require(script.Parent.Parent.Shared.Warn);
local Config = require(script.Parent.Parent.Shared.Config);
require(script.Parent.Parent.Shared.Types);
local InterpolationBuffer = require(script.Parent.InterpolationBuffer);
local u1 = {};
local u2 = {};

local function TrackOffset(p3: any, p4: number) -- Line: 20
    local os_clock_ret = os.clock();
    local v5 = os_clock_ret - p4;
    local offset = p3.offset;

    if offset then
        v5 = math.min(offset + 0.02 * (os_clock_ret - (p3.offsetAt or os_clock_ret)), v5);
    end;

    p3.offset = v5;
    p3.offsetAt = os_clock_ret;
end;

local function Clear(p6) -- Line: 28
    p6.lastClockAt = nil;
    p6.lastClockDuration = 0;
    p6.renderAt = nil;
    p6.offset = nil;
    p6.offsetAt = nil;

    if p6.buffer then
        p6.buffer.init = false;
    end;
end;

local function GetEstimatedServerTime(p7) -- Line: 40
    -- upvalues: Warn (copy)
    local offset = p7.offset;

    if offset then
        return os.clock() - offset;
    end;

    Warn.low("ClientClock: Estimated server time not yet established for", p7.name);

    return 0;
end;

local function GetTargetRenderTime(p8) -- Line: 50
    -- upvalues: Warn (copy), InterpolationBuffer (copy)
    if p8.renderAt then
        return p8.renderAt;
    end;

    if not p8.offset then
        Warn.low("ClientClock: Render time not yet established for", p8.name);

        return 0;
    end;

    local offset = p8.offset;
    local v9;

    if offset then
        v9 = os.clock() - offset;
    else
        Warn.low("ClientClock: Estimated server time not yet established for", p8.name);
        v9 = 0;
    end;

    local v10;

    if p8.buffer then
        v10 = InterpolationBuffer.GetBuffer(p8.buffer, p8.tickRate);
    else
        v10 = p8.bufferConst or 0;
    end;

    return v9 - v10;
end;

local function CheckHasLastClockAt(p11: any, p12: number) -- Line: 62
    if not p11.lastClockAt then
        p11.lastClockAt = p12;
        p11.lastClockDuration = os.clock();
        p11.renderAt = nil;
        local os_clock_ret = os.clock();
        local v13 = os_clock_ret - p12;
        local offset = p11.offset;

        if offset then
            v13 = math.min(offset + 0.02 * (os_clock_ret - (p11.offsetAt or os_clock_ret)), v13);
        end;

        p11.offset = v13;
        p11.offsetAt = os_clock_ret;
    end;
end;

local function Refresh(p14: any, p15: number) -- Line: 71
    if not p14.lastClockAt then
        if not p14.lastClockAt then
            p14.lastClockAt = p15;
            p14.lastClockDuration = os.clock();
            p14.renderAt = nil;
            local os_clock_ret = os.clock();
            local v16 = os_clock_ret - p15;
            local offset = p14.offset;

            if offset then
                v16 = math.min(offset + 0.02 * (os_clock_ret - (p14.offsetAt or os_clock_ret)), v16);
            end;

            p14.offset = v16;
            p14.offsetAt = os_clock_ret;
        end;

        return false;
    end;

    local os_clock_ret = os.clock();
    local v17 = os_clock_ret - p15;
    local offset = p14.offset;

    if offset then
        v17 = math.min(offset + 0.02 * (os_clock_ret - (p14.offsetAt or os_clock_ret)), v17);
    end;

    p14.offset = v17;
    p14.offsetAt = os_clock_ret;

    if p14.lastClockAt >= p15 then
        return false;
    end;

    p14.lastClockAt = p15;
    p14.lastClockDuration = os.clock();

    return true;
end;

local function OnSnapShot(p18: any, p19: number) -- Line: 87
    -- upvalues: InterpolationBuffer (copy)
    if not p18.lastClockAt then
        if not p18.lastClockAt then
            p18.lastClockAt = p19;
            p18.lastClockDuration = os.clock();
            p18.renderAt = nil;
            local os_clock_ret = os.clock();
            local v20 = os_clock_ret - p19;
            local offset = p18.offset;

            if offset then
                v20 = math.min(offset + 0.02 * (os_clock_ret - (p18.offsetAt or os_clock_ret)), v20);
            end;

            p18.offset = v20;
            p18.offsetAt = os_clock_ret;
        end;

        return;
    end;

    if p18.buffer then
        InterpolationBuffer.Register(p18.buffer, p19);
    end;

    local v21;

    if p18.lastClockAt then
        local os_clock_ret = os.clock();
        local v22 = os_clock_ret - p19;
        local offset = p18.offset;

        if offset then
            v22 = math.min(offset + 0.02 * (os_clock_ret - (p18.offsetAt or os_clock_ret)), v22);
        end;

        p18.offset = v22;
        p18.offsetAt = os_clock_ret;

        if p18.lastClockAt < p19 then
            p18.lastClockAt = p19;
            p18.lastClockDuration = os.clock();
            v21 = true;
        else
            v21 = false;
        end;
    elseif p18.lastClockAt then
        v21 = false;
    else
        p18.lastClockAt = p19;
        p18.lastClockDuration = os.clock();
        p18.renderAt = nil;
        local os_clock_ret = os.clock();
        local v23 = os_clock_ret - p19;
        local offset = p18.offset;

        if offset then
            v23 = math.min(offset + 0.02 * (os_clock_ret - (p18.offsetAt or os_clock_ret)), v23);
        end;

        p18.offset = v23;
        p18.offsetAt = os_clock_ret;
        v21 = false;
    end;

    if v21 and not p18.renderAt then
        local v24;

        if p18.buffer then
            v24 = InterpolationBuffer.GetBuffer(p18.buffer, p18.tickRate);
        else
            v24 = p18.bufferConst or 0;
        end;

        p18.renderAt = p19 - v24;
    end;
end;

local function SetTickRate(p25: any, p26: number) -- Line: 102
    if p25.tickRate == p26 then
        return;
    end;

    p25.tickRate = p26;
end;

local function Destroy(p27) -- Line: 109
    -- upvalues: u1 (copy), u2 (copy)
    u1[p27] = nil;

    if u2[p27] then
        u2[p27] = nil;
    end;
end;

local function Update(p28: any, p29: number) -- Line: 116
    -- upvalues: InterpolationBuffer (copy)
    local os_clock_ret = os.clock();
    local v30;

    if p28.buffer then
        v30 = InterpolationBuffer.GetBuffer(p28.buffer, p28.tickRate);
    else
        v30 = p28.bufferConst or 0;
    end;

    local offset = p28.offset;

    if not (p28.lastClockAt and offset) then
        return;
    end;

    local v31 = os_clock_ret - offset;
    local v32 = (p28.renderAt or v31 - v30) + p29;
    local v33 = v30 - (v31 - v32);

    if math.abs(v33) > 0.1 then
        v32 = v31 - v30;
    elseif v33 > 0.01 then
        v32 = math.max(v31 - v30, v32 - p29 * 0.1);
    elseif v33 < -0.01 then
        v32 = math.min(v31 - v30, v32 + p29 * 0.1);
    end;

    p28.renderAt = v32;
end;

local function UpdateBuffer(p34: any, p35: number?) -- Line: 139
    -- upvalues: InterpolationBuffer (copy)
    if p35 and p35 <= 0 then
        p35 = nil;
    end;

    if p34.bufferConst == p35 then
        return;
    end;

    if p35 then
        p34.buffer = nil;
    elseif not p34.buffer then
        p34.buffer = InterpolationBuffer.new(p34);
    end;

    p34.bufferConst = p35;
    p34.renderAt = nil;
end;

local function new(p36: number, p37: string, p38: number?, p39: userdata?) -- Line: 156
    -- upvalues: OnSnapShot (copy), Refresh (copy), GetEstimatedServerTime (copy), GetTargetRenderTime (copy), Clear (copy), SetTickRate (copy), UpdateBuffer (copy), Destroy (copy), InterpolationBuffer (copy), u2 (copy), u1 (copy)
    if p38 and p38 <= 0 then
        p38 = nil;
    end;

    local v40 = {
        lastClockAt = nil,
        lastClockDuration = 0,
        renderAt = nil,
        offset = nil,
        offsetAt = nil,
        buffer = nil,
        name = p37,
        tickRate = p36,
        _baseTickRate = p36,
        _owner = p39,
        bufferConst = p38,
        OnSnapShot = OnSnapShot,
        Refresh = Refresh,
        GetEstimatedServerTime = GetEstimatedServerTime,
        GetTargetRenderTime = GetTargetRenderTime,
        Clear = Clear,
        SetTickRate = SetTickRate,
        UpdateBuffer = UpdateBuffer,
        Destroy = Destroy
    };

    if not p38 then
        v40.buffer = InterpolationBuffer.new(v40);
    end;

    if not p39 then
        u2[v40] = true;
    end;

    u1[v40] = true;

    return v40;
end;

Config._WaitForLock(function() -- Line: 198
    -- upvalues: RunService (copy), Config (copy), Warn (copy), new (copy)
    if RunService:IsServer() then
        return;
    end;

    for i, v in Config._EntityConfigs do
        local CLIENT_CLOCK = v.CLIENT_CLOCK;

        if not CLIENT_CLOCK then
            Warn.high("Entity Config", i, "is missing client clocks");

            return;
        end;

        CLIENT_CLOCK.NORMAL = new(v.TICK_RATE, i .. "_NORMAL", v.BUFFER);

        if v.HALF_TICK_DISTANCE < (1 / 0) then
            CLIENT_CLOCK.HALF = new(v.TICK_RATE * 2, i .. "_HALF", v.BUFFER);
        end;
    end;
end);

return {
    _getBuffer = function(p41) -- Line: 12, Name: GetBuffer
        -- upvalues: InterpolationBuffer (copy)
        return not p41.buffer and (p41.bufferConst or 0) or InterpolationBuffer.GetBuffer(p41.buffer, p41.tickRate);
    end,

    new = new,
    clientClocks = u1,
    serverOwnedClocks = u2,

    UpdateAll = function(p42: number) -- Line: 192, Name: UpdateAll
        -- upvalues: u1 (copy), Update (copy)
        for i, _ in u1 do
            Update(i, p42);
        end;
    end
};