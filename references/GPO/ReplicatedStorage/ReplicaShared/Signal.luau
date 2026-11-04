 

local u1 = nil
local function u4(p2, ...) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = u1
    u1 = nil
    p2(...)
    u1 = v3
end
local function u5(...) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    u4(...)
    while true do
        u4(coroutine.yield())
    end
end
local u6 = {}
u6.__index = u6
local u7 = {}
u7.__index = u7
function u6.Disconnect(p8) --[[ Line: 77 ]]
    if p8.IsConnected == false then
        return
    else
        local v9 = p8.signal
        p8.IsConnected = false
        if v9.head == p8 then
            v9.head = p8.next
        else
            local v10 = v9.head
            while v10 ~= nil and v10.next ~= p8 do
                v10 = v10.next
            end
            if v10 ~= nil then
                v10.next = p8.next
            end
        end
    end
end
function u7.New() --[[ Line: 100 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local v11 = {
        ["head"] = nil
    }
    local v12 = u7
    setmetatable(v11, v12)
    return v11
end
function u7.Connect(p13, p14) --[[ Line: 111 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if type(p14) ~= "function" then
        error((("[%*]: \"listener\" must be a function; Received %*"):format(script.Name, (typeof(p14)))))
    end
    local v15 = {
        ["listener"] = p14,
        ["signal"] = p13,
        ["next"] = p13.head,
        ["IsConnected"] = true
    }
    local v16 = u6
    setmetatable(v15, v16)
    p13.head = v15
    return v15
end
function u7.Fire(p17, ...) --[[ Line: 131 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u5
    --]]
    local v18 = p17.head
    while v18 ~= nil do
        if v18.IsConnected == true then
            if not u1 then
                u1 = coroutine.create(u5)
            end
            task.spawn(u1, v18.listener, ...)
        end
        v18 = v18.next
    end
end
function u7.Wait(p19) --[[ Line: 144 ]]
    local u20 = coroutine.running()
    local u21 = nil
    u21 = p19:Connect(function(...) --[[ Line: 147 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u20
        --]]
        u21:Disconnect()
        task.spawn(u20, ...)
    end)
    return coroutine.yield()
end
function u7.FireUntil(p22, u23, ...) --[[ Line: 154 ]]
    if type(u23) ~= "function" then
        error((("[%*]: \"continue_callback\" must be a function; Received %*"):format(script.Name, (typeof(u23)))))
    end
    local u24 = table.pack(...)
    local v25 = p22.head
    local u26 = {}
    while v25 ~= nil do
        table.insert(u26, v25)
        v25 = v25.next
    end
    task.spawn(function() --[[ Line: 169 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u24
            [3] = u23
        --]]
        for _, v27 in ipairs(u26) do
            if v27.IsConnected == true then
                local v28 = u24
                v27.listener(table.unpack(v28))
                if u23() ~= true then
                    return
                end
            end
        end
    end)
end
return table.freeze({
    ["New"] = u7.New
})