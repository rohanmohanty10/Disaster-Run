 

local u1 = {}
u1.__index = u1
function u1.new(p2, p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = u1
    local v5 = setmetatable({}, v4)
    v5.Connected = true
    v5.Signal = p2
    v5.Callback = p3
    v5.Next = nil
    v5.Previous = nil
    return v5
end
function u1.Disconnect(p6) --[[ Line: 17 ]]
    p6.Connected = false
    if p6.Signal.Head == p6 then
        p6.Signal.Head = p6.Previous
    end
    if p6.Signal.Tail == p6 then
        p6.Signal.Tail = p6.Next
    end
    if p6.Previous then
        p6.Previous.Next = p6.Next
    end
    if p6.Next then
        p6.Next.Previous = p6.Previous
    end
    p6.Next = nil
    p6.Previous = nil
    local v7 = p6.Signal.OnConnectionRemovedCallback
    if v7 then
        task.spawn(v7)
    end
    setmetatable(p6, nil)
end
u1.Destroy = u1.Disconnect
return u1