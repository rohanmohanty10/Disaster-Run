  

local React = require(script.Parent.Parent.Parent.Shared.React);

return function(u1: number, u2: function, p3: table?) -- Line: 7, Name: useClock
    -- upvalues: React (copy)
    if p3 then
        table.insert(p3, u1);
    end;

    React.useEffect(function() -- Line: 12
        -- upvalues: u1 (copy), u2 (copy)
        local u4 = 1 / u1;
        local u5 = os.clock() - u4;
        local task_spawn_ret = task.spawn(function() -- Line: 16
            -- upvalues: u5 (ref), u2 (ref), u4 (copy)
            while true do
                local os_clock_ret = os.clock();
                u2(os_clock_ret - u5);
                u5 = os_clock_ret;
                task.wait(u4);
            end;
        end);

        return function() -- Line: 28
            -- upvalues: task_spawn_ret (copy)
            task.cancel(task_spawn_ret);
        end;
    end, p3);
end;