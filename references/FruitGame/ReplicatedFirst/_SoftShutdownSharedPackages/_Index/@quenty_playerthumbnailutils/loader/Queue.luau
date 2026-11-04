 

local u1 = {
    ["ClassName"] = "Queue"
}
u1.__index = u1
function u1.new() --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v2 = u1
    return setmetatable({
        ["_first"] = 0,
        ["_last"] = -1
    }, v2)
end
function u1.PushLeft(p3, p4) --[[ Line: 27 ]]
    p3._first = p3._first - 1
    p3[p3._first] = p4
end
function u1.PushRight(p5, p6) --[[ Line: 36 ]]
    p5._last = p5._last + 1
    p5[p5._last] = p6
end
function u1.PopLeft(p7) --[[ Line: 45 ]]
    if p7._first > p7._last then
        error("Queue is empty")
    end
    local v8 = p7[p7._first]
    p7[p7._first] = nil
    p7._first = p7._first + 1
    return v8
end
function u1.PopRight(p9) --[[ Line: 61 ]]
    if p9._first > p9._last then
        error("Queue is empty")
    end
    local v10 = p9[p9._last]
    p9[p9._last] = nil
    p9._last = p9._last - 1
    return v10
end
function u1.IsEmpty(p11) --[[ Line: 77 ]]
    return p11._first > p11._last
end
return u1