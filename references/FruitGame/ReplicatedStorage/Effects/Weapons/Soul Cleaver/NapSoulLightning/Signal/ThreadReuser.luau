 

local u1 = {}
u1.__index = u1
function u1.new() --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v2 = u1
    local v3 = setmetatable({}, v2)
    v3._freeThread = nil
    return v3
end
local function u7(p4, p5, ...) --[[ Line: 10 ]]
    local v6 = p4._freeThread
    p4._freeThread = nil
    p5(...)
    p4._freeThread = p4._freeThread or v6
end
function u1.Run(u8, p9, ...) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if not u8._freeThread then
        u8._freeThread = coroutine.create(function() --[[ Line: 25 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u7
            --]]
            local v10 = u8
            while true do
                u7(v10, coroutine.yield())
            end
        end)
        coroutine.resume(u8._freeThread)
    end
    task.spawn(u8._freeThread, p9, ...)
end
return u1