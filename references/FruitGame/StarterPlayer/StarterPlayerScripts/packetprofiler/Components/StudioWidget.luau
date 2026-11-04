 

local u1 = script:FindFirstAncestorOfClass("Plugin")
local v2 = u1:FindFirstChildOfClass("Script").Modules
local v3 = require(v2.Packages)
local u4 = require(v3.Directory.Roact)
local v5 = u4.Component:extend("StudioWidget")
function v5.init(p6) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v7 = DockWidgetPluginGuiInfo.new(p6.props.InitialDockState, p6.props.Enabled, false, p6.props.DefaultSize.X, p6.props.DefaultSize.Y, p6.props.MinimumSize.X, p6.props.MinimumSize.Y)
    local v8 = u1:CreateDockWidgetPluginGui(p6.props.WidgetId, v7)
    v8.Title = p6.props.WidgetTitle
    v8.Name = p6.props.WidgetId
    v8.ZIndexBehavior = p6.props.ZIndexBehavior or Enum.ZIndexBehavior.Global
    p6.Widget = v8
end
function v5.didMount(u9) --[[ Line: 29 ]]
    u9.OnEnabled = u9.props.OnEnabled:Connect(function(p10) --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        u9.Widget.Enabled = p10
    end)
    u9.Widget:BindToClose(function() --[[ Line: 33 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        u9.Widget.Enabled = false
    end)
end
function v5.render(p11) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    return u4.createElement(u4.Portal, {
        ["target"] = p11.Widget
    }, p11.props[u4.Children])
end
function v5.didUpdate(p12, p13) --[[ Line: 44 ]]
    if p12.props.Enabled ~= p13.Enabled then
        p12.Widget.Enabled = p12.props.Enabled
    end
end
function v5.willUnmount(p14) --[[ Line: 50 ]]
    p14.OnEnabled:Disconnect()
end
return v5