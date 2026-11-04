 
 

local Warn = require(script.Parent.Parent.Shared.Warn);
local Config = require(script.Parent.Parent.Shared.Config);
require(script.Parent.Parent.Shared.Types);
local u1 = nil;
local u2 = nil;
Config._WaitForLock(function() -- Line: 12
    -- upvalues: u1 (ref), Config (copy), u2 (ref)
    u1 = Config._GetConfig("MIN_BUFFER");
    u2 = Config._GetConfig("MAX_BUFFER");
end);

return {
    new = function(p3) -- Line: 18, Name: new
        return {
            init = false,
            averageLatency = 0,
            deviation = 0,
            lastLatency = 0,
            averageInterval = 0,
            lastTime = nil,
            peak = 0,
            peakAt = nil,
            clientClock = p3
        };
    end,

    Register = function(p4: any, p5: number) -- Line: 33, Name: Register
        -- upvalues: Warn (copy)
        local clientClock = p4.clientClock;
        local v6 = clientClock:GetEstimatedServerTime() - p5;
        local lastTime = p4.lastTime;
        p4.lastTime = p5;

        if lastTime then
            local v7 = p5 - lastTime;

            if v7 > 0 and v7 < 0.25 then
                if p4.averageInterval > 0 then
                    v7 = p4.averageInterval + (v7 - p4.averageInterval) * 0.1;
                end;

                p4.averageInterval = v7;
            end;
        end;

        if math.abs(v6) > 1 then
            clientClock:Clear();
            p4.peak = 0;
            p4.peakAt = nil;
            Warn.low(p4.clientClock.name, (` latency too high, cleared cache to repredict in case of error:! {v6}`));

            return;
        end;

        local os_clock_ret = os.clock();
        local math_max_ret = math.max(v6, 0);
        p4.peak = math.max(math_max_ret, (p4.peak or 0) - 0.05 * (os_clock_ret - (p4.peakAt or os_clock_ret)));
        p4.peakAt = os_clock_ret;

        if p4.init then
            if p4.lastLatency then
                local math_abs_ret = math.abs(v6 - p4.lastLatency);
                p4.deviation = p4.deviation + (math_abs_ret - p4.deviation) * 0.1;
            end;

            p4.averageLatency = p4.averageLatency + (v6 - p4.averageLatency) * 0.1;
            p4.lastLatency = v6;

            return;
        end;

        p4.averageLatency = v6;
        p4.deviation = 0;
        p4.lastLatency = v6;
        p4.init = true;
    end,

    GetBuffer = function(p8: any, p9: number) -- Line: 80, Name: GetBuffer
        -- upvalues: u1 (ref), u2 (ref), Warn (copy)
        if not p8 then
            return u1;
        end;

        local v10 = math.max(p9, p8.averageInterval or 0) * 1.5 + (p8.peak or 0);

        if v10 < u1 then
            v10 = u1 + (u1 - v10) * 0.2;
        end;

        if u2 < v10 then
            Warn.low(`Interpolation buffer exceeded max! Was {v10}, clamped to {u2} for`, p8.clientClock.name);
            v10 = u2;
        end;

        return v10;
    end
};