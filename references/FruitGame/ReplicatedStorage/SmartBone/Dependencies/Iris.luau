 

require(script.Types)
local u1 = {}
local u2 = require(script.Internal)(u1)
u1.Disabled = false
u1.Args = {}
u1.Events = {}
function u1.HasInit() --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return u2._started
end
function u1.Init(p3, u4) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    if p3 == nil then
        p3 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    if u4 == nil then
        u4 = game:GetService("RunService").Heartbeat
    end
    u2.parentInstance = p3
    local v5 = u2._started == false
    assert(v5, "Iris.Init can only be called once.")
    u2._started = true
    u2._generateRootInstance()
    u2._generateSelectionImageObject()
    task.spawn(function() --[[ Line: 33 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
        --]]
        local v6 = u4
        if typeof(v6) == "function" then
            while true do
                u4()
                u2._cycle()
            end
        else
            if u4 ~= nil then
                u4:Connect(function() --[[ Line: 40 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                    --]]
                    u2._cycle()
                end)
            end
            return
        end
    end)
    return u1
end
function u1.Connect(_, p7) --[[ Line: 49 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2._started == false then
        warn("Iris:Connect() was called before calling Iris.Init(), the connected function will never run")
    end
    local v8 = u2._connectedFunctions
    table.insert(v8, p7)
end
function u1.Append(p9) --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v10 = u2._GetParentWidget()
    local v11
    if u2._config.Parent then
        v11 = u2._config.Parent
    else
        v11 = u2._widgets[v10.type].ChildAdded(v10, {
            ["type"] = "userInstance"
        })
    end
    p9.Parent = v11
end
function u1.End() --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2._stackIndex == 1 then
        error("Callback has too many calls to Iris.End()", 2)
    end
    u2._IDStack[u2._stackIndex] = nil
    local v12 = u2
    v12._stackIndex = v12._stackIndex - 1
end
function u1.ForceRefresh() --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2._globalRefreshRequested = true
end
function u1.UpdateGlobalConfig(p13) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    for v14, v15 in p13 do
        u2._rootConfig[v14] = v15
    end
    u1.ForceRefresh()
end
function u1.PushConfig(p16) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v17 = u1.State(-1)
    if v17.value == -1 then
        v17:set(p16)
    elseif u2._deepCompare(v17:get(), p16) == false then
        u2._localRefreshActive = true
        v17:set(p16)
    end
    local v18 = u2
    local v19 = {
        ["__index"] = u2._config
    }
    v18._config = setmetatable(p16, v19)
end
function u1.PopConfig() --[[ Line: 110 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2._localRefreshActive = false
    local v20 = u2
    local v21 = u2._config
    v20._config = getmetatable(v21).__index
end
u1.TemplateConfig = require(script.config)
u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark)
u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault)
u1.UpdateGlobalConfig(u1.TemplateConfig.utilityDefault)
u2._globalRefreshRequested = false
function u1.PushId(p22) --[[ Line: 127 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v23 = typeof(p22) == "string"
    assert(v23, "Iris expected Iris.PushId id to PushId to be a string.")
    u2._pushedId = tostring(p22)
end
function u1.PopId() --[[ Line: 133 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2._pushedId = nil
end
function u1.SetNextWidgetID(p24) --[[ Line: 137 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2._nextWidgetId = p24
end
function u1.State(p25) --[[ Line: 147 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v26 = u2._getID(2)
    if u2._states[v26] then
        return u2._states[v26]
    end
    u2._states[v26] = {
        ["value"] = p25,
        ["ConnectedWidgets"] = {},
        ["ConnectedFunctions"] = {}
    }
    local v27 = u2._states[v26]
    local v28 = u2.StateClass
    setmetatable(v27, v28)
    return u2._states[v26]
end
function u1.WeakState(p29) --[[ Line: 161 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v30 = u2._getID(2)
    if u2._states[v30] then
        if #u2._states[v30].ConnectedWidgets ~= 0 then
            return u2._states[v30]
        end
        u2._states[v30] = nil
    end
    u2._states[v30] = {
        ["value"] = p29,
        ["ConnectedWidgets"] = {},
        ["ConnectedFunctions"] = {}
    }
    local v31 = u2._states[v30]
    local v32 = u2.StateClass
    setmetatable(v31, v32)
    return u2._states[v30]
end
function u1.ComputedState(p33, u34) --[[ Line: 179 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u35 = u2._getID(2)
    if u2._states[u35] then
        return u2._states[u35]
    end
    u2._states[u35] = {
        ["value"] = u34(p33.value),
        ["ConnectedWidgets"] = {},
        ["ConnectedFunctions"] = {}
    }
    p33:onChange(function(p36) --[[ Line: 190 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u35
            [3] = u34
        --]]
        u2._states[u35]:set(u34(p36))
    end)
    local v37 = u2._states[u35]
    local v38 = u2.StateClass
    setmetatable(v37, v38)
    return u2._states[u35]
end
u1.ShowDemoWindow = require(script.demoWindow)(u1)
require(script.widgets)(u2)
require(script.API)(u1)
return u1