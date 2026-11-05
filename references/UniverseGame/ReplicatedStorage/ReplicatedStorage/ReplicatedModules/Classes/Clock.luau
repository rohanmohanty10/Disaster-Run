  

 

local u1 = {};
u1.__index = u1;
local RunService = game:GetService("RunService");

function u1.new() -- Line: 20
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.Timescale = 1;
    v2.RawTime = os.clock();
    v2.ScaledTime = v2.RawTime;

    return v2;
end;

function u1.Time(p3) -- Line: 31
    local v4 = os.clock() - p3.RawTime;
    p3.ScaledTime = p3.ScaledTime + v4 * p3.Timescale;
    p3.RawTime = os.clock();

    return p3.ScaledTime;
end;

function u1.Wait(p5, p6) -- Line: 39
    -- upvalues: RunService (copy)
    local v7 = os.clock();
    local v8 = v7;
    local v9 = v8;
    local v10 = v8;
    v8 = v9;
    v10 = v9;

    while v7 < v7 + (p6 or 0.016666666666666666) do
        local v11;

        if p5.Timescale > 0 then
            v11 = os.clock();
            v7 = v7 + (v11 - v9) * p5.Timescale;
        else
            v11 = v9;
        end;

        if not p5.Timescale then
            return;
        end;

        RunService.Heartbeat:Wait();
        v9 = v11;
    end;

    local v12 = os.clock() - v8;

    return math.abs(v12);
end;

function u1.Destroy(p13) -- Line: 65
    setmetatable(p13, nil);
end;

return u1;