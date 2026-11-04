 

local u1 = {}
local u2 = game:GetService("RunService"):IsServer()
local v3 = script.Util
local u4 = script.Server
local u5 = script.Client
require(script.Type)
local u6 = require(v3.Assert)
local u7 = require(script.Signal)
local u8 = require(v3.Buffer)
local v9 = u7("Warp_OnSpamSignal")
if u2 then
    require(u4.ServerProcess).start()
else
    require(u5.ClientProcess).start()
end
u1.OnSpamSignal = v9
function u1.Server(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u4
    --]]
    u6(u2, (("[Warp]: Calling .Server(%*) on client side (expected server side)"):format(p10)))
    u6(typeof(p10) == "string", (("[Warp]: Identifier must be a string type, got %*"):format((typeof(p10)))))
    return require(u4.Index)(p10, p11)
end
function u1.Client(p12, p13) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u5
    --]]
    u6(not u2, (("[Warp]: Calling .Client(%*) on server side (expected client side)"):format(p12)))
    u6(typeof(p12) == "string", (("[Warp]: Identifier must be a string type, got %*"):format((typeof(p12)))))
    return require(u5.Index)(p12, p13)
end
function u1.fromServerArray(p14) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u1
    --]]
    u6(u2, (("[Warp]: Calling .fromServerArray(%*) on client side (expected server side)"):format(p14)))
    u6(typeof(p14) == "table", "[Warp]: Array must be a table type, got {typeof(arrays)}")
    local v15 = {}
    for v16, v17 in p14 do
        if typeof(v17) == "table" then
            v15[v16] = u1.Server(v16, v17)
        else
            v15[v17] = u1.Server(v17)
        end
    end
    return v15
end
function u1.fromClientArray(p18) --[[ Line: 53 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u1
    --]]
    u6(not u2, (("[Warp]: Calling .fromClientArray(%*) on server side (expected client side)"):format(p18)))
    u6(typeof(p18) == "table", (("[Warp]: Array must be a table type, got %*"):format((typeof(p18)))))
    local v19 = {}
    for v20, v21 in p18 do
        if typeof(v21) == "table" then
            v19[v20] = u1.Client(v20, v21)
        else
            v19[v21] = u1.Client(v21)
        end
    end
    return v19
end
function u1.Signal(p22) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    return u7(p22)
end
function u1.fromSignalArray(p23) --[[ Line: 71 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    u6(typeof(p23) == "table", (("[Warp]: Array must be a table type, got %*"):format((typeof(p23)))))
    local v24 = {}
    for _, v25 in p23 do
        v24[v25] = u1.Signal(v25)
    end
    return v24
end
function u1.buffer() --[[ Line: 80 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    return u8.new()
end
return table.freeze(u1)