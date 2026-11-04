 

 

local RunService = game:GetService("RunService");
local Warn = require(script.Parent.Parent.Shared.Warn);
local Config = require(script.Parent.Parent.Shared.Config);
require(script.Parent.Parent.Shared.Types);
local InterpolationBuffer = require(script.Parent.InterpolationBuffer);
local u1 = {};
local u2 = {};

local function Clear(p3) -- Line: 19
    p3.lastClockAt = nil;
    p3.lastClockDuration = 0;
    p3.renderAt = nil;

    if p3.buffer then
        p3.buffer.init = false;
    end;
end;

local function GetTargetRenderTime(p4) -- Line: 29
    -- upvalues: Warn (copy)
    if p4.renderAt then
        return p4.renderAt;
    end;

    Warn.low("ClientClock: Render time not yet established for", p4.name);

    return 0;
end;

local function GetEstimatedServerTime(p5) -- Line: 38
    -- upvalues: Warn (copy)
    if p5.lastClockAt then
        return p5.lastClockAt + (os.clock() - p5.lastClockDuration);
    end;

    Warn.low("ClientClock: Estimated server time not yet established for", p5.name);

    return 0;
end;

local function CheckHasLastClockAt(p6: any, p7: number) -- Line: 47
    if not p6.lastClockAt then
        p6.lastClockAt = p7;
        p6.lastClockDuration = os.clock();
        p6.renderAt = nil;
    end;
end;

local function Refresh(p8: any, p9: number) -- Line: 55
    if not p8.lastClockAt then
        if not p8.lastClockAt then
            p8.lastClockAt = p9;
            p8.lastClockDuration = os.clock();
            p8.renderAt = nil;
        end;

        return false;
    end;

    if p8.lastClockAt >= p9 then
        return false;
    end;

    p8.lastClockAt = p9;
    p8.lastClockDuration = os.clock();

    return true;
end;

local function OnSnapShot(p10: any, p11: number) -- Line: 70
    -- upvalues: InterpolationBuffer (copy)
    if not p10.lastClockAt then
        if not p10.lastClockAt then
            p10.lastClockAt = p11;
            p10.lastClockDuration = os.clock();
            p10.renderAt = nil;
        end;

        return;
    end;

    if p10.buffer then
        InterpolationBuffer.Register(p10.buffer, p11);
    end;

    local v12;

    if p10.lastClockAt then
        if p10.lastClockAt < p11 then
            p10.lastClockAt = p11;
            p10.lastClockDuration = os.clock();
            v12 = true;
        else
            v12 = false;
        end;
    elseif p10.lastClockAt then
        v12 = false;
    else
        p10.lastClockAt = p11;
        p10.lastClockDuration = os.clock();
        p10.renderAt = nil;
        v12 = false;
    end;

    if v12 and not p10.renderAt then
        local v13;

        if p10.buffer then
            v13 = InterpolationBuffer.GetBuffer(p10.buffer, p10.tickRate);
        else
            v13 = p10.bufferConst or 0;
        end;

        p10.renderAt = p11 - v13;
    end;
end;

local function SetTickRate(p14: any, p15: number) -- Line: 85
    if p14.tickRate == p15 then
        return;
    end;

    p14.tickRate = p15;
end;

local function Destroy(p16) -- Line: 93
    -- upvalues: u1 (copy), u2 (copy)
    u1[p16] = nil;

    if u2[p16] then
        u2[p16] = nil;
    end;
end;

local function Update(p17: any, p18: number) -- Line: 100
    -- upvalues: InterpolationBuffer (copy)
    local os_clock_ret = os.clock();
    local v19;

    if p17.buffer then
        v19 = InterpolationBuffer.GetBuffer(p17.buffer, p17.tickRate);
    else
        v19 = p17.bufferConst or 0;
    end;

    if not p17.lastClockAt then
        return;
    end;

    local v20 = p17.lastClockAt + (os_clock_ret - p17.lastClockDuration);
    local v21 = (p17.renderAt or v20 - v19) + p18;
    local v22 = v19 - (v20 - v21);

    if math.abs(v22) > 0.1 then
        v21 = v20 - v19;
    elseif v22 > 0.01 then
        v21 = math.max(v20 - v19, v21 - p18 * 0.1);
    elseif v22 < -0.01 then
        v21 = math.min(v20 - v19, v21 + p18 * 0.1);
    end;

    p17.renderAt = v21;
end;

local function UpdateBuffer(p23: any, p24: number?) -- Line: 122
    -- upvalues: InterpolationBuffer (copy)
    if p24 and p24 <= 0 then
        p24 = nil;
    end;

    if p23.bufferConst == p24 then
        return;
    end;

    if p24 then
        p23.buffer = nil;
    elseif not p23.buffer then
        p23.buffer = InterpolationBuffer.new(p23);
    end;

    p23.bufferConst = p24;
    p23.renderAt = nil;
end;

local function new(p25: number, p26: string, p27: number?, p28: userdata?) -- Line: 139
    -- upvalues: OnSnapShot (copy), Refresh (copy), GetEstimatedServerTime (copy), GetTargetRenderTime (copy), Clear (copy), SetTickRate (copy), UpdateBuffer (copy), Destroy (copy), InterpolationBuffer (copy), u2 (copy), u1 (copy)
    if p27 and p27 <= 0 then
        p27 = nil;
    end;

    local v29 = {
        lastClockAt = nil,
        lastClockDuration = 0,
        renderAt = nil,
        buffer = nil,
        name = p26,
        tickRate = p25,
        _baseTickRate = p25,
        _owner = p28,
        bufferConst = p27,
        OnSnapShot = OnSnapShot,
        Refresh = Refresh,
        GetEstimatedServerTime = GetEstimatedServerTime,
        GetTargetRenderTime = GetTargetRenderTime,
        Clear = Clear,
        SetTickRate = SetTickRate,
        UpdateBuffer = UpdateBuffer,
        Destroy = Destroy
    };

    if not p27 then
        v29.buffer = InterpolationBuffer.new(v29);
    end;

    if not p28 then
        u2[v29] = true;
    end;

    u1[v29] = true;

    return v29;
end;

Config._WaitForLock(function() -- Line: 179
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
    _getBuffer = function(p30) -- Line: 11, Name: GetBuffer
        -- upvalues: InterpolationBuffer (copy)
        return not p30.buffer and (p30.bufferConst or 0) or InterpolationBuffer.GetBuffer(p30.buffer, p30.tickRate);
    end,

    new = new,
    clientClocks = u1,
    serverOwnedClocks = u2,

    UpdateAll = function(p31: number) -- Line: 173, Name: UpdateAll
        -- upvalues: u1 (copy), Update (copy)
        for i, _ in u1 do
            Update(i, p31);
        end;
    end
};