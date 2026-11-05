  

 

local u1 = {};
u1.__index = u1;
local wait = task.wait;
local _ = task.spawn;
local clear = table.clear;
local v2 = script:FindFirstAncestor("ReplicatedModules");
local Signal = require(v2.Signal);

function u1.new() -- Line: 10
    -- upvalues: Signal (copy), u1 (copy)
    local v3 = Signal.new();
    local v4 = {
        Time = 0,
        TimeCollected = 0,
        Signal = v3,
        TimeEnded = v3
    };
    setmetatable(v4, u1);

    return v4;
end;

function u1.AddTime(p5, p6) -- Line: 22
    p5.Time = p5.Time + p6;
end;

function u1.RemoveTime(p7, p8) -- Line: 26
    p7.Time = p7.Time - p8;
end;

function u1.GetTime(p9) -- Line: 30
    return p9.Time;
end;

function u1.Init(u10, p11) -- Line: 34
    -- upvalues: wait (copy)
    if u10.Started then
        warn("Thread already running");

        return;
    end;

    if p11 then
        u10:AddTime(p11);
    end;

    u10.Started = true;
    task.spawn(function() -- Line: 40
        -- upvalues: wait (ref), u10 (copy)
        while true do
            local v12 = wait();

            if not u10.Time then
                break;
            end;

            local v13 = u10;
            v13.Time = v13.Time - v12;
            local v14 = u10;
            v14.TimeCollected = v14.TimeCollected + v12;

            if u10.Time <= 0 then
                u10.Signal:Fire(u10.Time, u10.TimeCollected);
                u10.Started = nil;

                return;
            end;
        end;
    end);
end;

function u1.Destroy(p15) -- Line: 52
    -- upvalues: clear (copy)
    p15.Signal:Destroy();
    setmetatable(p15, nil);
    clear(p15);
end;

return u1;