 

 

local Warn = require(script.Parent.Parent.Shared.Warn);
local Config = require(script.Parent.Parent.Shared.Config);
require(script.Parent.Parent.Shared.Types);
local u1 = nil;
local u2 = nil;
Config._WaitForLock(function() -- Line: 9
    -- upvalues: u1 (ref), Config (copy), u2 (ref)
    u1 = Config._GetConfig("MIN_BUFFER");
    u2 = Config._GetConfig("MAX_BUFFER");
end);

return {
    new = function(p3) -- Line: 15, Name: new
        return {
            init = false,
            averageLatency = 0,
            deviation = 0,
            lastLatency = 0,
            clientClock = p3
        };
    end,

    Register = function(p4: any, p5: number) -- Line: 26, Name: Register
        -- upvalues: Warn (copy)
        local clientClock = p4.clientClock;
        local v6 = clientClock:GetEstimatedServerTime() - p5;

        if math.abs(v6) > 1 then
            clientClock:Clear();
            Warn.low(p4.clientClock.name, (` latency too high, cleared cache to repredict in case of error:! {v6}`));
        end;

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

    GetBuffer = function(p7: any, p8: number) -- Line: 57, Name: GetBuffer
        -- upvalues: u1 (ref), u2 (ref), Warn (copy)
        if not p7 then
            return u1;
        end;

        local v9 = p8 + p7.deviation * 2;

        if v9 < u1 then
            v9 = u1 + (u1 - v9) * 0.2;
        end;

        if u2 < v9 then
            Warn.low(`Interpolation buffer exceeded max! Was {v9}, clamped to {u2} for`, p7.clientClock.name);
            v9 = u2;
        end;

        return v9;
    end
};