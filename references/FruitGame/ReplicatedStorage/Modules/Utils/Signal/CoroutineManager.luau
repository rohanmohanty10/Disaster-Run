 

local u3 = {
    ["FreeRunnerThread"] = nil,
    ["_acquireAndRun"] = function(p1, ...) --[[ Name: _acquireAndRun, Line 12 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v2 = u3.FreeRunnerThread
        u3.FreeRunnerThread = nil
        p1(...)
        u3.FreeRunnerThread = u3.FreeRunnerThread or v2
    end,
    ["_runHandlerInThread"] = function() --[[ Name: _runHandlerInThread, Line 19 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        while true do
            u3._acquireAndRun(coroutine.yield())
        end
    end,
    ["InitializeRunnerThread"] = function() --[[ Name: InitializeRunnerThread, Line 25 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        if not u3.FreeRunnerThread then
            u3.FreeRunnerThread = coroutine.create(u3._runHandlerInThread)
            task.spawn(u3.FreeRunnerThread)
        end
    end
}
return u3