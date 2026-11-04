  

local u1 = {};
u1.__index = u1;
local Signal = require(script.Parent.Signal);
local Cleaner = require(script.Parent.Cleaner);

function u1.new(p2: number) -- Line: 36
    -- upvalues: u1 (copy), Cleaner (copy), Signal (copy)
    local u3 = setmetatable({}, u1);
    u3._cleaner = Cleaner.new();
    u3._timedOutSignal = Signal.new();
    u3._cleaner:Add(u3._timedOutSignal);
    local task_delay_ret = task.delay(p2, function() -- Line: 45
        -- upvalues: u3 (copy)
        u3._timedOutSignal:Fire(true);
        u3:Destroy();
    end);
    u3._cleaner:Add({
        Destroy = function() -- Line: 50, Name: Destroy
            -- upvalues: task_delay_ret (copy)
            if coroutine.status(task_delay_ret) == "suspended" then
                task.cancel(task_delay_ret);
            end;
        end
    });

    return u3;
end;

function u1.OnEnd(p4: table, u5: function) -- Line: 63
    return p4._timedOutSignal:Once(function(p6, ...) -- Line: 64
        -- upvalues: u5 (copy)
        if p6 then
            u5(...);
        end;
    end);
end;

function u1.Destroy(p7) -- Line: 71
    p7._cleaner:Destroy();
end;

return u1;