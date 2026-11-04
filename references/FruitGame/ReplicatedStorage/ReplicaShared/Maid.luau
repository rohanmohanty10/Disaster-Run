 

local u1 = nil
local function u4(p2, ...) --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = u1
    u1 = nil
    p2(...)
    u1 = v3
end
local function u5(...) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    u4(...)
    while true do
        u4(coroutine.yield())
    end
end
local function u10(p6, ...) --[[ Line: 58 ]]
    local v7 = typeof(p6)
    if v7 == "function" then
        p6(...)
        return
    elseif v7 == "RBXScriptConnection" then
        p6:Disconnect()
        return
    elseif v7 == "Instance" then
        p6:Destroy()
    elseif v7 == "table" then
        local v8 = p6.Destroy
        if type(v8) == "function" then
            p6:Destroy()
            return
        end
        local v9 = p6.Disconnect
        if type(v9) == "function" then
            p6:Disconnect()
        end
    end
end
local function u12(...) --[[ Line: 78 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u5
        [3] = u10
    --]]
    if not u1 then
        u1 = coroutine.create(u5)
    end
    local v11 = u1
    task.spawn(assert(v11), u10, ...)
end
local u13 = {}
u13.__index = u13
function u13.New(p14, p15) --[[ Line: 103 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    local v16 = {
        ["maid"] = p14,
        ["object"] = p15
    }
    local v17 = u13
    setmetatable(v16, v17)
    return v16
end
function u13.Destroy(p18) --[[ Line: 116 ]]
    p18.maid.tokens[p18] = nil
end
function u13.Cleanup(p19, ...) --[[ Line: 120 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    if p19.object ~= nil then
        p19.maid.tokens[p19] = nil
        u12(p19.object, ...)
        p19.object = nil
    end
end
local u20 = {}
u20.__index = u20
function u20.New(p21) --[[ Line: 135 ]]
    --[[
    Upvalues:
        [1] = u20
    --]]
    local v22 = {
        ["tokens"] = {},
        ["is_cleaned"] = false,
        ["key"] = p21
    }
    local v23 = u20
    setmetatable(v22, v23)
    return v22
end
function u20.IsActive(p24) --[[ Line: 149 ]]
    return not p24.is_cleaned
end
function u20.Add(p25, p26) --[[ Line: 153 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u13
    --]]
    if p25.is_cleaned == true then
        u12(p26)
    end
    local v27 = typeof(p26)
    if v27 == "table" then
        local v28 = p26.Destroy
        if type(v28) ~= "function" then
            local v29 = p26.Disconnect
            if type(v29) ~= "function" then
                error((("[%*]: Received table as cleanup object, but couldn\'t detect a :Destroy() or :Disconnect() method"):format(script.Name)))
            end
        end
    elseif v27 ~= "function" and (v27 ~= "RBXScriptConnection" and v27 ~= "Instance") then
        error((("[%*]: Cleanup of type \"%*\" not supported"):format(script.Name, v27)))
    end
    local v30 = u13.New(p25, p26)
    p25.tokens[v30] = true
    return v30
end
function u20.Cleanup(p31, ...) --[[ Line: 176 ]]
    if p31.key ~= nil then
        error((("[%*]: \"Cleanup()\" is locked for this Maid"):format(script.Name)))
    end
    p31.is_cleaned = true
    for v32 in pairs(p31.tokens) do
        v32:Cleanup(...)
    end
end
function u20.Unlock(p33, p34) --[[ Line: 190 ]]
    if p33.key ~= nil and p33.key ~= p34 then
        error((("[%*]: Invalid lock key"):format(script.Name)))
    end
    p33.key = nil
end
return u20