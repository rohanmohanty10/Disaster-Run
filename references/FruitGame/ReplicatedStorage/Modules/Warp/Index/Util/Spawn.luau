 

local u1 = nil
local function u4(p2, ...) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = u1
    u1 = nil
    p2(...)
    u1 = v3
end
local function u5() --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
    --]]
    u1 = coroutine.running()
    while true do
        u4(coroutine.yield())
    end
end
return function(p6, ...) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u5
    --]]
    if not u1 then
        task.spawn(u5)
    end
    task.spawn(u1, p6, ...)
end