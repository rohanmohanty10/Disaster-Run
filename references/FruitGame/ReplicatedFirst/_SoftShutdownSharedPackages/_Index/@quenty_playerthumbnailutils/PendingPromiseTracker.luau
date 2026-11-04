 

local u1 = {
    ["ClassName"] = "PendingPromiseTracker"
}
u1.__index = u1
function u1.new() --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v2 = u1
    local v3 = setmetatable({}, v2)
    v3._pendingPromises = {}
    return v3
end
function u1.Add(u4, u5) --[[ Line: 18 ]]
    if u5:IsPending() then
        u4._pendingPromises[u5] = true
        u5:Finally(function() --[[ Line: 21 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u5
            --]]
            u4._pendingPromises[u5] = nil
        end)
    end
end
function u1.GetAll(p6) --[[ Line: 27 ]]
    local v7 = {}
    for v8, _ in pairs(p6._pendingPromises) do
        table.insert(v7, v8)
    end
    return v7
end
return u1