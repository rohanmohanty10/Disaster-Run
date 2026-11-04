 

local u1 = require(script.Parent.Binding)
local u2 = require(script.Parent.PropMarkers.Children)
local u3 = require(script.Parent.ElementKind)
local u4 = require(script.Parent.SingleEventManager)
local u5 = require(script.Parent.getDefaultInstanceProperty)
local u6 = require(script.Parent.PropMarkers.Ref)
local u7 = require(script.Parent.PropMarkers.Constant)
local u8 = require(script.Parent.Type)
local u9 = require(script.Parent.internalAssert)
local u10 = require(script.Parent.GlobalConfig).get()
local function u11(...) --[[ Line: 33 ]]
    return ...
end
local function u14(p12, p13) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u1
    --]]
    if p12 == nil then
        return
    elseif typeof(p12) == "function" then
        p12(p13)
        return
    elseif u8.of(p12) == u8.Binding then
        u1.update(p12, p13)
    else
        error(("Invalid ref: Expected type Binding but got %s"):format((typeof(p12))))
    end
end
local function u28(u15, u16, p17) --[[ Line: 71 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u5
        [3] = u11
        [4] = u1
    --]]
    local function v27(u18) --[[ Line: 72 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u15
            [3] = u16
            [4] = u5
            [5] = u11
        --]]
        if u18 ~= u7.SkipBindingUpdate then
            local v23, v24 = xpcall(function() --[[ Line: 77 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u16
                    [3] = u18
                    [4] = u5
                --]]
                local v19 = u15.hostObject
                local v20 = u16
                local v21 = u18
                if v21 == nil then
                    local v22
                    v22, v21 = u5(v19.ClassName, v20)
                end
                v19[v20] = v21
            end, u11)
            if not v23 then
                local v25 = u15.currentElement.source
                local v26 = ("Error updating props:\n\t%s\nIn element:\n%s\n"):format(v24, v25 == nil and "<enable element tracebacks>" or v25)
                error(v26, 0)
            end
        end
    end
    if u15.bindings == nil then
        u15.bindings = {}
    end
    u15.bindings[u16] = u1.subscribe(p17, v27)
    v27(p17:getValue())
end
local function u38(p29, p30, p31, p32) --[[ Line: 111 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u8
        [4] = u4
        [5] = u28
        [6] = u5
    --]]
    if p31 == p32 then
        return
    elseif p30 == u6 or p30 == u2 then
        return
    else
        local v33 = u8.of(p30)
        if v33 == u8.HostEvent or v33 == u8.HostChangeEvent then
            if p29.eventManager == nil then
                p29.eventManager = u4.new(p29.hostObject)
            end
            local v34 = p30.name
            if v33 == u8.HostChangeEvent then
                p29.eventManager:connectPropertyChange(v34, p31)
            else
                p29.eventManager:connectEvent(v34, p31)
            end
        else
            local v35 = u8.of(p31) == u8.Binding
            if u8.of(p32) == u8.Binding then
                p29.bindings[p30]()
                p29.bindings[p30] = nil
            end
            if v35 then
                u28(p29, p30, p31)
            else
                local v36 = p29.hostObject
                if p31 == nil then
                    local v37
                    v37, p31 = u5(v36.ClassName, p30)
                end
                v36[p30] = p31
            end
        end
    end
end
local function u43(p39, p40) --[[ Line: 153 ]]
    --[[
    Upvalues:
        [1] = u38
    --]]
    for v41, v42 in pairs(p40) do
        u38(p39, v41, v42, nil)
    end
end
local function u51(p44, p45, p46) --[[ Line: 159 ]]
    --[[
    Upvalues:
        [1] = u38
    --]]
    for v47, v48 in pairs(p46) do
        u38(p44, v47, v48, p45[v47])
    end
    for v49, v50 in pairs(p45) do
        if p46[v49] == nil then
            u38(p44, v49, nil, v50)
        end
    end
end
return {
    ["isHostObject"] = function(p52) --[[ Name: isHostObject, Line 179 ]]
        return typeof(p52) == "Instance"
    end,
    ["mountHostNode"] = function(p53, u54) --[[ Name: mountHostNode, Line 183 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u9
            [3] = u3
            [4] = u43
            [5] = u11
            [6] = u2
            [7] = u14
            [8] = u6
        --]]
        local u55 = u54.currentElement
        local v56 = u54.hostParent
        local v57 = u54.hostKey
        if u10.internalTypeChecks then
            u9(u3.of(u55) == u3.Host, "Element at given node is not a host Element")
        end
        if u10.typeChecks then
            local v58 = u55.props.Name == nil
            assert(v58, "Name can not be specified as a prop to a host component in Roact.")
            local v59 = u55.props.Parent == nil
            assert(v59, "Parent can not be specified as a prop to a host component in Roact.")
        end
        local v60 = Instance.new(u55.component)
        u54.hostObject = v60
        local v61, v62 = xpcall(function() --[[ Line: 199 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u54
                [3] = u55
            --]]
            u43(u54, u55.props)
        end, u11)
        if not v61 then
            local v63 = u55.source
            local v64 = ("Error applying props:\n\t%s\nIn element:\n%s\n"):format(v62, v63 == nil and "<enable element tracebacks>" or v63)
            error(v64, 0)
        end
        v60.Name = tostring(v57)
        local v65 = u55.props[u2]
        if v65 ~= nil then
            p53.updateVirtualNodeWithChildren(u54, u54.hostObject, v65)
        end
        v60.Parent = v56
        u54.hostObject = v60
        u14(u55.props[u6], v60)
        if u54.eventManager ~= nil then
            u54.eventManager:resume()
        end
    end,
    ["unmountHostNode"] = function(p66, p67) --[[ Name: unmountHostNode, Line 232 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u6
        --]]
        u14(p67.currentElement.props[u6], nil)
        for _, v68 in pairs(p67.children) do
            p66.unmountVirtualNode(v68)
        end
        if p67.bindings ~= nil then
            for _, v69 in pairs(p67.bindings) do
                v69()
            end
            p67.bindings = nil
        end
        p67.hostObject:Destroy()
    end,
    ["updateHostNode"] = function(p70, u71, p72) --[[ Name: updateHostNode, Line 246 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u14
            [3] = u51
            [4] = u11
            [5] = u2
        --]]
        local u73 = u71.currentElement.props
        local u74 = p72.props
        if u71.eventManager ~= nil then
            u71.eventManager:suspend()
        end
        if u73[u6] ~= u74[u6] then
            u14(u73[u6], nil)
            u14(u74[u6], u71.hostObject)
        end
        local v75, v76 = xpcall(function() --[[ Line: 260 ]]
            --[[
            Upvalues:
                [1] = u51
                [2] = u71
                [3] = u73
                [4] = u74
            --]]
            u51(u71, u73, u74)
        end, u11)
        if not v75 then
            local v77 = p72.source
            local v78 = ("Error updating props:\n\t%s\nIn element:\n%s\n"):format(v76, v77 == nil and "<enable element tracebacks>" or v77)
            error(v78, 0)
        end
        local v79 = p72.props[u2]
        if v79 ~= nil or u73[u2] ~= nil then
            p70.updateVirtualNodeWithChildren(u71, u71.hostObject, v79)
        end
        if u71.eventManager ~= nil then
            u71.eventManager:resume()
        end
        return u71
    end
}