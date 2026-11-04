 

require(script.Parent.Types)
return function(u1) --[[ Line: 3 ]]
    local u2 = {
        ["_started"] = false,
        ["_cycleTick"] = 0,
        ["_globalRefreshRequested"] = false,
        ["_localRefreshActive"] = false,
        ["_widgets"] = {},
        ["_widgetCount"] = 0,
        ["_stackIndex"] = 1,
        ["_rootInstance"] = nil
    }
    u2._rootWidget = {
        ["ID"] = "R",
        ["type"] = "Root",
        ["Instance"] = u2._rootInstance,
        ["ZIndex"] = 0
    }
    u2._lastWidget = u2._rootWidget
    u2._rootConfig = {}
    u2._config = u2._rootConfig
    u2._IDStack = { "R" }
    u2._usedIDs = {}
    u2._pushedId = nil
    u2._nextWidgetId = nil
    u2._states = {}
    u2._postCycleCallbacks = {}
    u2._connectedFunctions = {}
    u2._cycleCoroutine = coroutine.create(function() --[[ Line: 49 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        while true do
            for _, v3 in u2._connectedFunctions do
                local v4, v5 = pcall(v3)
                if not v4 then
                    u2._stackIndex = 1
                    coroutine.yield(false, v5)
                end
                if u2._stackIndex ~= 1 then
                    u2._stackIndex = 1
                    error("Callback has too few calls to Iris.End()", 0)
                end
            end
            coroutine.yield(true)
        end
    end)
    local v6 = {}
    v6.__index = v6
    function v6.get(p7) --[[ Line: 80 ]]
        return p7.value
    end
    function v6.set(p8, p9) --[[ Line: 84 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if p9 == p8.value then
            return p8.value
        end
        p8.value = p9
        for _, v10 in p8.ConnectedWidgets do
            u2._widgets[v10.type].UpdateState(v10)
        end
        for _, v11 in p8.ConnectedFunctions do
            v11(p9)
        end
        return p8.value
    end
    function v6.onChange(p12, p13) --[[ Line: 99 ]]
        local v14 = p12.ConnectedFunctions
        table.insert(v14, p13)
    end
    u2.StateClass = v6
    function u2._cycle() --[[ Line: 111 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        if u1.Disabled then
            return
        else
            u2._rootWidget.lastCycleTick = u2._cycleTick
            if u2._rootInstance == nil or u2._rootInstance.Parent == nil then
                u1.ForceRefresh()
            end
            for _, v15 in u2._lastVDOM do
                if v15.lastCycleTick ~= u2._cycleTick then
                    u2._DiscardWidget(v15)
                end
            end
            u2._lastVDOM = u2._VDOM
            u2._VDOM = u2._generateEmptyVDOM()
            task.spawn(function() --[[ Line: 135 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                for _, v16 in u2._postCycleCallbacks do
                    v16()
                end
            end)
            if u2._globalRefreshRequested then
                u2._generateSelectionImageObject()
                u2._globalRefreshRequested = false
                for _, v17 in u2._lastVDOM do
                    u2._DiscardWidget(v17)
                end
                u2._generateRootInstance()
                u2._lastVDOM = u2._generateEmptyVDOM()
            end
            local v18 = u2
            v18._cycleTick = v18._cycleTick + 1
            u2._widgetCount = 0
            table.clear(u2._usedIDs)
            if u2.parentInstance:IsA("GuiBase2d") then
                local v19 = u2.parentInstance.AbsoluteSize.X
                local v20 = u2.parentInstance.AbsoluteSize.Y
                if math.min(v19, v20) < 100 then
                    error("Iris Parent Instance is too small")
                end
            end
            if (u2.parentInstance:IsA("GuiBase2d") or u2.parentInstance:IsA("CoreGui") or (u2.parentInstance:IsA("PluginGui") or u2.parentInstance:IsA("PlayerGui"))) == false then
                error("Iris Parent Instance cant contain GUI")
            end
            if game:GetService("RunService"):IsStudio() then
                for _, v21 in u2._connectedFunctions do
                    v21()
                end
            else
                local v22 = coroutine.status(u2._cycleCoroutine)
                if v22 == "suspended" then
                    local _, v23, v24 = coroutine.resume(u2._cycleCoroutine)
                    if v23 == false then
                        error(v24, 0)
                        return
                    end
                else
                    if v22 == "running" then
                        error("Iris cycleCoroutine took to long to yield. Connected functions should not yield.")
                        return
                    end
                    error("unrecoverable state")
                end
            end
        end
    end
    function u2._NoOp() --[[ Line: 206 ]] end
    function u2.WidgetConstructor(p25, p26) --[[ Line: 210 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v27 = {
            ["All"] = {
                ["Required"] = {
                    "Generate",
                    "Discard",
                    "Update",
                    "Args",
                    "Events",
                    "hasChildren",
                    "hasState"
                },
                ["Optional"] = {}
            },
            ["IfState"] = {
                ["Required"] = { "GenerateState", "UpdateState" },
                ["Optional"] = {}
            },
            ["IfChildren"] = {
                ["Required"] = { "ChildAdded" },
                ["Optional"] = { "ChildDiscarded" }
            }
        }
        local v28 = {}
        for _, v29 in v27.All.Required do
            local v30 = p26[v29] ~= nil
            local v31 = ("field %* is missing from widget %*, it is required for all widgets"):format(v29, p25)
            assert(v30, v31)
            v28[v29] = p26[v29]
        end
        for _, v32 in v27.All.Optional do
            if p26[v32] == nil then
                v28[v32] = u2._NoOp
            else
                v28[v32] = p26[v32]
            end
        end
        if p26.hasState then
            for _, v33 in v27.IfState.Required do
                local v34 = p26[v33] ~= nil
                local v35 = ("field %* is missing from widget %*, it is required for all widgets with state"):format(v33, p25)
                assert(v34, v35)
                v28[v33] = p26[v33]
            end
            for _, v36 in v27.IfState.Optional do
                if p26[v36] == nil then
                    v28[v36] = u2._NoOp
                else
                    v28[v36] = p26[v36]
                end
            end
        end
        if p26.hasChildren then
            for _, v37 in v27.IfChildren.Required do
                local v38 = p26[v37] ~= nil
                local v39 = ("field %* is missing from widget %*, it is required for all widgets with children"):format(v37, p25)
                assert(v38, v39)
                v28[v37] = p26[v37]
            end
            for _, v40 in v27.IfChildren.Optional do
                if p26[v40] == nil then
                    v28[v40] = u2._NoOp
                else
                    v28[v40] = p26[v40]
                end
            end
        end
        u2._widgets[p25] = v28
        u1.Args[p25] = v28.Args
        local v41 = {}
        for v42, v43 in v28.Args do
            v41[v43] = v42
        end
        v28.ArgNames = v41
        for u44, _ in v28.Events do
            if u1.Events[u44] == nil then
                u1.Events[u44] = function() --[[ Line: 301 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u44
                    --]]
                    return u2._EventCall(u2._lastWidget, u44)
                end
            end
        end
    end
    function u2._Insert(p45, p46, p47) --[[ Line: 308 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v48 = nil
        local v49 = u2._getID(3)
        local v50 = u2._widgets[p45]
        local v51 = u2
        v51._widgetCount = v51._widgetCount + 1
        if u2._VDOM[v49] then
            return u2._ContinueWidget(v49, p45)
        end
        local v52 = {}
        if p46 ~= nil then
            for v53, v54 in type(p46) ~= "table" and { p46 } or p46 do
                v52[v50.ArgNames[v53]] = v54
            end
        end
        table.freeze(v52)
        if u2._lastVDOM[v49] and p45 == u2._lastVDOM[v49].type then
            if u2._localRefreshActive then
                u2._DiscardWidget(u2._lastVDOM[v49])
            else
                v48 = u2._lastVDOM[v49]
            end
        end
        if v48 == nil then
            v48 = u2._GenNewWidget(p45, v52, p47, v49)
        end
        if u2._deepCompare(v48.providedArguments, v52) == false then
            v48.arguments = u2._deepCopy(v52)
            v48.providedArguments = v52
            v50.Update(v48)
        end
        v48.lastCycleTick = u2._cycleTick
        if v50.hasChildren then
            local v55 = u2
            v55._stackIndex = v55._stackIndex + 1
            u2._IDStack[u2._stackIndex] = v48.ID
        end
        u2._VDOM[v49] = v48
        u2._lastWidget = v48
        return v48
    end
    function u2._GenNewWidget(p56, p57, p58, p59) --[[ Line: 375 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v60 = u2._IDStack[u2._stackIndex]
        local v61 = u2._widgets[p56]
        local u62 = {}
        setmetatable(u62, u62)
        u62.ID = p59
        u62.type = p56
        u62.parentWidget = u2._VDOM[v60]
        u62.trackedEvents = {}
        u62.ZIndex = u62.parentWidget.ZIndex + u2._widgetCount * 64 + u2._config.ZIndexOffset
        u62.Instance = v61.Generate(u62)
        local v63 = u62.Instance
        local v64
        if u2._config.Parent then
            v64 = u2._config.Parent
        else
            v64 = u2._widgets[u62.parentWidget.type].ChildAdded(u62.parentWidget, u62)
        end
        v63.Parent = v64
        u62.providedArguments = p57
        u62.arguments = u2._deepCopy(p57)
        v61.Update(u62)
        local v65
        if v61.hasState then
            if p58 then
                for v66, v67 in p58 do
                    if type(v67) ~= "table" or getmetatable(v67) ~= u2.StateClass then
                        p58[v66] = u2._widgetState(u62, v66, v67)
                    end
                end
                u62.state = p58
                for _, v68 in p58 do
                    v68.ConnectedWidgets[u62.ID] = u62
                end
            else
                u62.state = {}
            end
            v61.GenerateState(u62)
            v61.UpdateState(u62)
            u62.stateMT = {}
            local v69 = u62.state
            local v70 = u62.stateMT
            setmetatable(v69, v70)
            u62.__index = u62.state
            v65 = u62.stateMT
        else
            v65 = u62
        end
        function v65.__index(_, u71) --[[ Line: 432 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u62
            --]]
            return function() --[[ Line: 433 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u62
                    [3] = u71
                --]]
                return u2._EventCall(u62, u71)
            end
        end
        return u62
    end
    function u2._ContinueWidget(p72, p73) --[[ Line: 440 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v74 = u2._widgets[p73]
        local v75 = u2._VDOM[p72]
        if v74.hasChildren then
            local v76 = u2
            v76._stackIndex = v76._stackIndex + 1
            u2._IDStack[u2._stackIndex] = v75.ID
        end
        u2._lastWidget = v75
        return v75
    end
    function u2._DiscardWidget(p77) --[[ Line: 454 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v78 = p77.parentWidget
        if v78 then
            u2._widgets[v78.type].ChildDiscarded(v78, p77)
        end
        u2._widgets[p77.type].Discard(p77)
    end
    function u2._widgetState(p79, p80, p81) --[[ Line: 465 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v82 = p79.ID .. p80
        if u2._states[v82] then
            u2._states[v82].ConnectedWidgets[p79.ID] = p79
            return u2._states[v82]
        end
        local v83 = u2._states
        local v84 = {
            ["value"] = p81,
            ["ConnectedWidgets"] = {
                [p79.ID] = p79
            },
            ["ConnectedFunctions"] = {}
        }
        v83[v82] = v84
        local v85 = u2._states[v82]
        local v86 = u2.StateClass
        setmetatable(v85, v86)
        return u2._states[v82]
    end
    function u2._EventCall(p87, p88) --[[ Line: 481 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v89 = u2._widgets[p87.type].Events[p88]
        local v90 = v89 ~= nil
        local v91 = ("widget %* has no event of name %*"):format(p87.type, p88)
        assert(v90, v91)
        if p87.trackedEvents[p88] == nil then
            v89.Init(p87)
            p87.trackedEvents[p88] = true
        end
        return v89.Get(p87)
    end
    function u2._GetParentWidget() --[[ Line: 493 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        return u2._VDOM[u2._IDStack[u2._stackIndex]]
    end
    function u2._generateEmptyVDOM() --[[ Line: 499 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        return {
            ["R"] = u2._rootWidget
        }
    end
    function u2._generateRootInstance() --[[ Line: 505 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        u2._rootInstance = u2._widgets.Root.Generate(u2._widgets.Root)
        u2._rootInstance.Parent = u2.parentInstance
        u2._rootWidget.Instance = u2._rootInstance
    end
    function u2._generateSelectionImageObject() --[[ Line: 512 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if u2.SelectionImageObject then
            u2.SelectionImageObject:Destroy()
        end
        local v92 = Instance.new("Frame")
        v92.Position = UDim2.fromOffset(-1, -1)
        v92.Size = UDim2.new(1, 2, 1, 2)
        v92.BackgroundColor3 = u2._config.SelectionImageObjectColor
        v92.BackgroundTransparency = u2._config.SelectionImageObjectTransparency
        v92.BorderSizePixel = 0
        local v93 = Instance.new("UIStroke")
        v93.Thickness = 1
        v93.Color = u2._config.SelectionImageObjectBorderColor
        v93.Transparency = u2._config.SelectionImageObjectBorderTransparency
        v93.LineJoinMode = Enum.LineJoinMode.Round
        v93.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        v93.Parent = v92
        local v94 = Instance.new("UICorner")
        v94.CornerRadius = UDim.new(0, 2)
        v94.Parent = v92
        u2.SelectionImageObject = v92
    end
    function u2._getID(p95) --[[ Line: 543 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if u2._nextWidgetId then
            local v96 = u2._nextWidgetId
            u2._nextWidgetId = nil
            return v96
        end
        local v97 = 1 + (p95 or 1)
        local v98 = debug.info(v97, "l")
        local v99 = ""
        while v98 ~= -1 and v98 ~= nil do
            v99 = v99 .. "+" .. v98
            v97 = v97 + 1
            v98 = debug.info(v97, "l")
        end
        if u2._usedIDs[v99] then
            local v100 = u2._usedIDs
            v100[v99] = v100[v99] + 1
        else
            u2._usedIDs[v99] = 1
        end
        local v101
        if u2._pushedId then
            v101 = u2._pushedId
        else
            v101 = u2._usedIDs[v99]
        end
        return v99 .. ":" .. v101
    end
    function u2._deepCompare(p102, p103) --[[ Line: 570 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        for v104, v105 in p102 do
            local v106 = p103[v104]
            if type(v105) == "table" then
                if not v106 or type(v106) ~= "table" then
                    return false
                end
                if u2._deepCompare(v105, v106) == false then
                    return false
                end
            elseif type(v105) ~= type(v106) or v105 ~= v106 then
                return false
            end
        end
        return true
    end
    function u2._deepCopy(p107) --[[ Line: 592 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v108 = {}
        for v109, v111 in pairs(p107) do
            if type(v111) == "table" then
                local v111 = u2._deepCopy(v111)
            end
            v108[v109] = v111
        end
        return v108
    end
    u2._lastVDOM = u2._generateEmptyVDOM()
    u2._VDOM = u2._generateEmptyVDOM()
    u1.Internal = u2
    u1._config = u2._config
    return u2
end