 

local u1 = require(script.Connection)
local u2 = require(script.CoroutineManager)
local u3 = {}
u3.__index = u3
function u3.new() --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v4 = u3
    local v5 = setmetatable({}, v4)
    v5._head = nil
    return v5
end
function u3.Fire(p6, ...) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v7 = p6._head
    while v7 do
        if v7.Connected then
            u2.InitializeRunnerThread()
            task.spawn(u2.FreeRunnerThread, v7.Callback, ...)
        end
        v7 = v7.Next
    end
end
function u3.Connect(p8, p9) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v10 = u1.new(p8, p9)
    if p8._head then
        p8._head.Previous = v10
    end
    v10.Next = p8._head
    p8._head = v10
    return v10
end
function u3.Wait(p11) --[[ Line: 41 ]]
    local u12 = coroutine.running()
    p11:Once(function(...) --[[ Line: 44 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        task.spawn(u12, ...)
    end)
    return coroutine.yield()
end
function u3.Once(p13, u14) --[[ Line: 51 ]]
    local u15 = nil
    u15 = p13:Connect(function(...) --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u14
        --]]
        u15:Disconnect()
        u15 = nil
        u14(...)
    end)
    return u15
end
function u3.DisconnectAll(p16) --[[ Line: 62 ]]
    p16._head = nil
end
return u3