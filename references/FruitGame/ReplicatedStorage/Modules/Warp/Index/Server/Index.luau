 

local u1 = {}
u1.__index = u1
local u2 = game:GetService("Players")
local v3 = script.Parent.Parent.Util
require(script.Parent.Parent.Type)
local u4 = require(script.Parent.ServerProcess)
local u5 = require(v3.Assert)
local u6 = require(v3.Key)
local u7 = require(v3.Serdes)
local u8 = require(v3.Buffer)
function u1.new(p9, p10) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u8
        [3] = u7
        [4] = u4
    --]]
    local v11 = u1
    local v12 = setmetatable({}, v11)
    v12._buffer = u8.new()
    v12._buffer:wu8(u7.increment(p9))
    v12.id = u8.convert(v12._buffer:build())
    v12.fn = {}
    v12._conf = table.freeze(p10 or {})
    v12.IsConnected = false
    u4.add(v12.id, p9, p10 or {
        ["rateLimit"] = {
            ["maxEntrance"] = 200,
            ["interval"] = 2
        }
    })
    v12._buffer:remove()
    return v12
end
function u1.Fire(p13, p14, p15, ...) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    u4.insertQueue(p13.id, p14, p15, ...)
end
function u1.Fires(p16, p17, ...) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    for _, v18 in ipairs(u2:GetPlayers()) do
        u4.insertQueue(p16.id, p17, v18, ...)
    end
end
function u1.FireExcept(p19, p20, p21, ...) --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    for _, v22 in ipairs(u2:GetPlayers()) do
        if not table.find(p21, v22) then
            u4.insertQueue(p19.id, p20, v22, ...)
        end
    end
end
function u1.FireIn(p23, p24, p25, p26, p27, p28) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    for _, v29 in ipairs(u2:GetPlayers()) do
        if not (p28 and table.find(p28, v29)) and (v29.Character and (v29.Character.PrimaryPart and (v29.Character.PrimaryPart.Position - p26).Magnitude >= p25)) then
            u4.insertQueue(p23.id, p24, v29, table.unpack(p27))
        end
    end
end
function u1.Invoke(p30, p31, p32, ...) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    return u4.insertRequest(p30.id, p31, p32, ...)
end
function u1.Connect(p33, p34) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
    --]]
    local v35 = u6
    local v36 = tostring(v35())
    local v37 = p33.fn
    table.insert(v37, v36)
    u4.addCallback(p33.id, v36, p34)
    p33.IsConnected = #p33.fn > 0
    return v36
end
function u1.Once(u38, u39) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
    --]]
    local v40 = u6
    local u41 = tostring(v40())
    local v42 = u38.fn
    table.insert(v42, u41)
    u38.IsConnected = #u38.fn > 0
    u4.addCallback(u38.id, u41, function(p43, ...) --[[ Line: 73 ]]
        --[[
        Upvalues:
            [1] = u38
            [2] = u41
            [3] = u39
        --]]
        u38:Disconnect(u41)
        task.spawn(u39, p43, ...)
    end)
    return u41
end
function u1.Wait(p44) --[[ Line: 80 ]]
    local u45 = coroutine.running()
    local u46 = os.clock()
    p44:Once(function() --[[ Line: 82 ]]
        --[[
        Upvalues:
            [1] = u45
            [2] = u46
        --]]
        task.spawn(u45, os.clock() - u46)
    end)
    return coroutine.yield()
end
function u1.DisconnectAll(p47) --[[ Line: 88 ]]
    for _, v48 in p47.fn do
        p47:Disconnect(v48)
    end
end
function u1.Disconnect(p49, p50) --[[ Line: 94 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
    --]]
    u5(typeof(p50) == "string", "Key must be a string type.")
    u4.removeCallback(p49.id, p50)
    table.remove(p49.fn, table.find(p49.fn, p50))
    p49.IsConnected = #p49.fn > 0
    return table.find(p49.fn, p50) == nil
end
function u1.Destroy(p51) --[[ Line: 102 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u7
    --]]
    p51:DisconnectAll()
    p51._buffer:remove()
    u4.remove(p51.id)
    u7.decrement()
    table.clear(p51)
    setmetatable(p51, nil)
end
return u1.new