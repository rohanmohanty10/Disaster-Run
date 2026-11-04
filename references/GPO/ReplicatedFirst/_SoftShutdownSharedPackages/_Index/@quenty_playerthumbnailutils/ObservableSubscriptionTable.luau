 

local u1 = require(script.Parent.loader).load(script)("Observable")
local u2 = {
    ["ClassName"] = "ObservableSubscriptionTable"
}
u2.__index = u2
function u2.new() --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v3 = u2
    local v4 = setmetatable({}, v3)
    v4._subMap = {}
    return v4
end
function u2.Fire(p5, p6, ...) --[[ Line: 28 ]]
    local v7 = p6 ~= nil
    assert(v7, "Bad key")
    local v8 = p5._subMap[p6]
    if v8 then
        for _, v9 in pairs(table.clone(v8)) do
            task.spawn(v9.Fire, v9, ...)
        end
    end
end
function u2.Complete(p10, p11, ...) --[[ Line: 42 ]]
    local v12 = p10._subMap[p11]
    if v12 then
        local v13 = table.clone(v12)
        p10._subMap[p11] = nil
        for _, v14 in pairs(v13) do
            task.spawn(v14.Complete, v14, ...)
        end
    end
end
function u2.Observe(u15, u16) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v17 = u16 ~= nil
    assert(v17, "Bad key")
    return u1.new(function(u18) --[[ Line: 64 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u16
        --]]
        if u15._subMap[u16] then
            local v19 = u15._subMap[u16]
            table.insert(v19, u18)
        else
            u15._subMap[u16] = { u18 }
        end
        return function() --[[ Line: 71 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u16
                [3] = u18
            --]]
            if u15._subMap[u16] then
                local v20 = u15._subMap[u16]
                local v21 = table.find(v20, u18)
                if v21 then
                    table.remove(v20, v21)
                    if #v20 == 0 then
                        u15._subMap[u16] = nil
                    end
                    if u18:IsPending() then
                        task.spawn(function() --[[ Line: 89 ]]
                            --[[
                            Upvalues:
                                [1] = u18
                            --]]
                            u18:Complete()
                        end)
                    end
                end
            else
                return
            end
        end
    end)
end
function u2.Destroy(p22) --[[ Line: 100 ]]
    while next(p22._subMap) do
        local v23, v24 = next(p22._subMap)
        p22._subMap[v23] = nil
        for _, u25 in pairs(v24) do
            if u25:IsPending() then
                task.spawn(function() --[[ Line: 107 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                    --]]
                    u25:Complete()
                end)
            end
        end
    end
end
return u2