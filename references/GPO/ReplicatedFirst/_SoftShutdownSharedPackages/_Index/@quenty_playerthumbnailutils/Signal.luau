 

local u1 = game:GetService("HttpService")
local u2 = {}
u2.__index = u2
u2.ClassName = "Signal"
function u2.isSignal(p3) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4
    if type(p3) == "table" then
        v4 = getmetatable(p3) == u2
    else
        v4 = false
    end
    return v4
end
function u2.new() --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = u2
    local u6 = setmetatable({}, v5)
    u6._bindableEvent = Instance.new("BindableEvent")
    u6._argMap = {}
    u6._source = ""
    u6._bindableEvent.Event:Connect(function(p7) --[[ Line: 64 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        u6._argMap[p7] = nil
        if not (u6._bindableEvent or next(u6._argMap)) then
            u6._argMap = nil
        end
    end)
    return u6
end
function u2.Fire(p8, ...) --[[ Line: 82 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p8._bindableEvent then
        local v9 = table.pack(...)
        local v10 = u1:GenerateGUID(false)
        p8._argMap[v10] = v9
        p8._bindableEvent:Fire(v10)
    else
        warn(("Signal is already destroyed. %s"):format(p8._source))
    end
end
function u2.Connect(u11, u12) --[[ Line: 103 ]]
    if type(u12) ~= "function" then
        error(("connect(%s)"):format((typeof(u12))), 2)
    end
    return u11._bindableEvent.Event:Connect(function(p13) --[[ Line: 108 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u12
        --]]
        local v14 = u11._argMap[p13]
        if v14 then
            local v15 = u12
            local v16 = v14.n
            v15(table.unpack(v14, 1, v16))
        else
            error("Missing arg data, probably due to reentrance.")
        end
    end)
end
function u2.Wait(p17) --[[ Line: 126 ]]
    local v18 = p17._bindableEvent.Event:Wait()
    local v19 = p17._argMap[v18]
    if v19 then
        local v20 = v19.n
        return table.unpack(v19, 1, v20)
    else
        error("Missing arg data, probably due to reentrance.")
        return nil
    end
end
function u2.Destroy(p21) --[[ Line: 141 ]]
    if p21._bindableEvent then
        p21._bindableEvent:Destroy()
        p21._bindableEvent = nil
    end
    setmetatable(p21, nil)
end
return u2