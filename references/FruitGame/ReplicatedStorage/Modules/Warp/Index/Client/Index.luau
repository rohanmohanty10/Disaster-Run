 

local u1 = {}
u1.__index = u1
game:GetService("Players")
local v2 = script.Parent.Parent.Util
require(script.Parent.Parent.Type)
local u3 = require(script.Parent.ClientProcess)
local u4 = require(v2.Assert)
local u5 = require(v2.Key)
local u6 = require(v2.Serdes)
local u7 = require(v2.Buffer)
function u1.new(p8, p9) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u7
        [3] = u6
        [4] = u3
    --]]
    local v10 = u1
    local v11 = setmetatable({}, v10)
    v11._buffer = u7.new()
    local v12 = v11._buffer
    local v13 = u6.increment
    local v14
    if p9 then
        v14 = p9.yieldWait
    else
        v14 = p9
    end
    v12:wu8(v13(p8, v14))
    v11.id = u7.convert(v11._buffer:build())
    v11.fn = {}
    v11._conf = table.freeze(p9 or {})
    v11.IsConnected = false
    u3.add(v11.id, p8, p9 or {
        ["yieldWait"] = 10
    })
    v11._buffer:remove()
    return v11
end
function u1.Fire(p15, p16, ...) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    u3.insertQueue(p15.id, p16, ...)
end
function u1.Invoke(p17, p18, ...) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3.insertRequest(p17.id, p18, ...)
end
function u1.Connect(p19, p20) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u3
    --]]
    local v21 = u5
    local v22 = tostring(v21())
    local v23 = p19.fn
    table.insert(v23, v22)
    p19.IsConnected = #p19.fn > 0
    u3.addCallback(p19.id, v22, p20)
    return v22
end
function u1.Once(u24, u25) --[[ Line: 49 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u3
    --]]
    local v26 = u5
    local u27 = tostring(v26())
    local v28 = u24.fn
    table.insert(v28, u27)
    u24.IsConnected = #u24.fn > 0
    u3.addCallback(u24.id, u27, function(...) --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u27
            [3] = u25
        --]]
        u24:Disconnect(u27)
        task.spawn(u25, ...)
    end)
    return u27
end
function u1.Wait(p29) --[[ Line: 60 ]]
    local u30 = coroutine.running()
    local u31 = os.clock()
    p29:Once(function() --[[ Line: 62 ]]
        --[[
        Upvalues:
            [1] = u30
            [2] = u31
        --]]
        task.spawn(u30, os.clock() - u31)
    end)
    return coroutine.yield()
end
function u1.DisconnectAll(p32) --[[ Line: 68 ]]
    for _, v33 in p32.fn do
        p32:Disconnect(v33)
    end
end
function u1.Disconnect(p34, p35) --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    u4(typeof(p35) == "string", "Key must be a string type.")
    u3.removeCallback(p34.id, p35)
    table.remove(p34.fn, table.find(p34.fn, p35))
    p34.IsConnected = #p34.fn > 0
end
function u1.Destroy(p36) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u6
    --]]
    p36:DisconnectAll()
    p36._buffer:remove()
    u3.remove(p36.id)
    u6.decrement()
    table.clear(p36)
    setmetatable(p36, nil)
end
return u1.new