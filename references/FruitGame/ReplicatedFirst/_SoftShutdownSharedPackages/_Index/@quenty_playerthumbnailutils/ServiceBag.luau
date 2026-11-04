 

local u1 = require(script.Parent.loader).load(script)
local u2 = u1("Signal")
local u3 = u1("BaseObject")
local u4 = setmetatable({}, u3)
u4.ClassName = "ServiceBag"
u4.__index = u4
function u4.new(p5) --[[ Line: 53 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u2
    --]]
    local v6 = u3.new()
    local v7 = u4
    local v8 = setmetatable(v6, v7)
    v8._services = {}
    v8._parentProvider = p5
    v8._serviceTypesToInitializeSet = {}
    v8._initializedServiceTypeSet = {}
    v8._initializing = false
    v8._serviceTypesToStart = {}
    v8._destroying = u2.new()
    v8._maid:GiveTask(v8._destroying)
    return v8
end
function u4.isServiceBag(p9) --[[ Line: 77 ]]
    local v10
    if type(p9) == "table" then
        v10 = p9.ClassName == "ServiceBag"
    else
        v10 = false
    end
    return v10
end
function u4.GetService(p11, p12) --[[ Line: 89 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if typeof(p12) == "Instance" then
        p12 = u1(p12)
    end
    local v13 = type(p12) == "table"
    assert(v13, "Bad serviceType definition")
    if p11._services[p12] then
        p11:_ensureInitialization(p12)
        return p11._services[p12]
    end
    if p11._parentProvider then
        return p11._parentProvider:GetService(p12)
    end
    p11:_addServiceType(p12)
    p11:_ensureInitialization(p12)
    return p11._services[p12]
end
function u4.HasService(p14, p15) --[[ Line: 117 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if typeof(p15) == "Instance" then
        p15 = u1(p15)
    end
    return p14._services[p15] and true or false
end
function u4.Init(p16) --[[ Line: 133 ]]
    local v17 = not p16._initializing
    assert(v17, "Already initializing")
    local v18 = p16._serviceTypesToInitializeSet
    assert(v18, "Already initialized")
    p16._initializing = true
    while next(p16._serviceTypesToInitializeSet) do
        local v19 = next(p16._serviceTypesToInitializeSet)
        p16._serviceTypesToInitializeSet[v19] = nil
        p16:_ensureInitialization(v19)
    end
    p16._serviceTypesToInitializeSet = nil
    p16._initializing = false
end
function u4.Start(p20) --[[ Line: 152 ]]
    local v21 = p20._serviceTypesToStart
    assert(v21, "Already started")
    local v22 = not p20._initializing
    assert(v22, "Still initializing")
    while next(p20._serviceTypesToStart) do
        local v23 = table.remove(p20._serviceTypesToStart)
        local v24 = p20._services[v23]
        local u25 = assert(v24, "No service")
        if u25.Start then
            local u26 = nil
            task.spawn(function() --[[ Line: 162 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u25
                --]]
                u26 = coroutine.running()
                u25:Start()
            end)
            local v27 = coroutine.status(u26) == "dead"
            assert(v27, "Starting service yielded")
        end
    end
    p20._serviceTypesToStart = nil
end
function u4.IsStarted(p28) --[[ Line: 178 ]]
    return p28._serviceTypesToStart == nil
end
function u4.CreateScope(u29) --[[ Line: 188 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local u30 = u4.new(u29)
    u29:_addServiceType(u30)
    u29._maid[u30] = u30._destroying:Connect(function() --[[ Line: 194 ]]
        --[[
        Upvalues:
            [1] = u29
            [2] = u30
        --]]
        u29._maid[u30] = nil
        u29._services[u30] = nil
    end)
    return u30
end
function u4._addServiceType(p31, p32) --[[ Line: 203 ]]
    if p31._serviceTypesToInitializeSet then
        if not p31._services[p32] then
            local v33 = setmetatable({}, {
                ["__index"] = p32
            })
            p31._services[p32] = v33
            p31:_ensureInitialization(p32)
        end
    else
        error(("Already finished initializing, cannot add %q"):format((tostring(p32))))
        return
    end
end
function u4._ensureInitialization(p34, p35) --[[ Line: 221 ]]
    if p34._initializedServiceTypeSet[p35] then
        return
    elseif p34._initializing then
        p34._serviceTypesToInitializeSet[p35] = nil
        p34._initializedServiceTypeSet[p35] = true
        p34:_initService(p35)
        return
    elseif p34._serviceTypesToInitializeSet then
        p34._serviceTypesToInitializeSet[p35] = true
    else
        error("[ServiceBag._ensureInitialization] - Cannot initialize past initializing phase ")
    end
end
function u4._initService(u36, p37) --[[ Line: 237 ]]
    local v38 = u36._services[p37]
    local u39 = assert(v38, "No service")
    if u39.Init then
        local u40 = nil
        task.spawn(function() --[[ Line: 242 ]]
            --[[
            Upvalues:
                [1] = u40
                [2] = u39
                [3] = u36
            --]]
            u40 = coroutine.running()
            u39:Init(u36)
        end)
        local v41 = coroutine.status(u40) == "dead"
        assert(v41, "Initializing service yielded")
    end
    local v42 = u36._serviceTypesToStart
    table.insert(v42, p37)
end
function u4.Destroy(p43) --[[ Line: 257 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v44 = u4
    local v45 = getmetatable(v44)
    p43._destroying:Fire()
    local v46 = p43._services
    local v47, v48 = next(v46)
    while v48 ~= nil do
        v46[v47] = nil
        if v48.Destroy then
            v48:Destroy()
        end
        v47, v48 = next(v46)
    end
    v45.Destroy(p43)
end
return u4