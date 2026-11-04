 

local v1 = {}
local u2 = {}
function v1.Add(_, p3) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = 0
    for _, v5 in u2 do
        if v5 then
            v4 = v4 + 1
        end
    end
    if v4 < 1 then
        u2[p3] = true
    end
end
function v1.Remove(_, u6) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[u6] then
        task.spawn(function() --[[ Line: 23 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u6
            --]]
            task.wait(5)
            u2[u6] = nil
        end)
    end
end
function v1.Check(_, p7) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return u2[p7] and true or false
end
function v1.AtMax(_) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v8 = 0
    for _, v9 in u2 do
        if v9 then
            v8 = v8 + 1
        end
    end
    return v8 >= 1
end
return v1