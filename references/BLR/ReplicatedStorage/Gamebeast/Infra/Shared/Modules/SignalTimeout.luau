  

local u1 = {};
u1.__index = u1;
local RunService = game:GetService("RunService");
local Signal = require(script.Parent.Signal);
local Cleaner = require(script.Parent.Cleaner);

function u1.new(p2: number, p3: userdata, p4: function?) -- Line: 38
    -- upvalues: u1 (copy), Cleaner (copy), Signal (copy), RunService (copy)
    local u5 = setmetatable({}, u1);
    u5._cleaner = Cleaner.new();
    u5._timeoutSeconds = p2;
    u5._validator = p4;
    u5._startTick = tick();
    u5._timedOutSignal = Signal.new();
    u5._targetSignal = p3;
    u5._cleaner:Add(u5._timedOutSignal);
    u5._cleaner:Add(RunService.Heartbeat:Connect(function() -- Line: 49
        -- upvalues: u5 (copy)
        if tick() - u5._startTick >= u5._timeoutSeconds then
            u5._timedOutSignal:Fire(true);
            u5:Destroy();
        end;
    end));
    u5._cleaner:Add(u5._targetSignal:Connect(function(...) -- Line: 56
        -- upvalues: u5 (copy)
        if u5._validator and not u5._validator(...) then
            return;
        end;

        u5._timedOutSignal:Fire(false, ...);
        u5:Destroy();
    end));

    return u5;
end;

function u1.Wait(p6) -- Line: 70
    return p6._timedOutSignal:Wait();
end;

function u1.Once(p7: table, p8: function) -- Line: 74
    return p7._timedOutSignal:Connect(p8);
end;

function u1.Destroy(p9) -- Line: 78
    p9._cleaner:Destroy();
end;

return u1;