 

local u1 = {}
u1.__index = u1
function u1.new(p2, p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = u1
    local v5 = setmetatable({}, v4)
    v5.Signal = p2
    v5.Callback = p3
    v5.Connected = true
    return v5
end
function u1.Disconnect(p6) --[[ Line: 12 ]]
    p6.Connected = false
    if p6.Signal and p6.Signal._head == p6 then
        p6.Signal._head = p6.Next
    end
    if p6.Previous then
        p6.Previous.Next = p6.Next
    end
    if p6.Next then
        p6.Next.Previous = p6.Previous
    end
    p6.Signal = nil
end
return u1