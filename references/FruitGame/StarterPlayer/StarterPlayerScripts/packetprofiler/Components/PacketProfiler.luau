 

local v1 = game:GetService("Players")
local v2 = script.Parent.Parent
local v3 = v2.Components
local v4 = v2.Modules
local u5 = require(v4.Packages)
local u6 = require(u5.Directory.Roact)
local u7 = require(u5.Directory.Signal)
local u8 = require(v3.StudioTheme)
local u9 = require(v3.PacketFrames)
local u10 = require(v3.TopbarButtonsGroup)
local u11 = require(v3.TopbarButton)
local u12 = u5.IsPlugin and game:GetService("CoreGui") or v1.LocalPlayer.PlayerGui
local v13 = u6.Component:extend("PacketProfiler")
function v13.init(u14) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
    --]]
    u14:setState({
        ["MaxFrameSize"] = 1000
    })
    u14.Cleanup = {}
    local v15, v16 = u6.createBinding(false)
    u14.PacketProfilerPaused = v15
    u14.SetPacketProfilerPaused = v16
    u14.OnPacketProfilerPaused = u7.new()
    local v17 = u14.Cleanup
    local v18 = u14.OnPacketProfilerPaused
    table.insert(v17, v18:Connect(function(p19) --[[ Line: 32 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        u14.SetPacketProfilerPaused(p19)
    end))
    function u14.Pause(p20) --[[ Line: 36 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        u14.OnPacketProfilerPaused:Fire(p20)
    end
end
function v13.didMount(u21) --[[ Line: 41 ]]
    local v22 = u21.Cleanup
    local v23 = u21.props.Signals.ProfilerPaused
    table.insert(v22, v23:Connect(function(p24) --[[ Line: 42 ]]
        --[[
        Upvalues:
            [1] = u21
        --]]
        u21.Pause(p24)
    end))
end
function v13.willUnmount(p25) --[[ Line: 46 ]]
    for _, v26 in p25.Cleanup do
        v26:Disconnect()
    end
end
function v13.render(u27) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u12
        [4] = u8
        [5] = u9
        [6] = u11
        [7] = u10
    --]]
    local u28 = u5.IsPlugin and "Left" or "Right"
    local u29 = u5.IsPlugin and -1 or 1
    return u6.createElement(u6.Portal, {
        ["target"] = u12
    }, {
        ["PacketProfiler"] = u6.createElement("ScreenGui", {
            ["DisplayOrder"] = 10,
            ["IgnoreGuiInset"] = true,
            ["ResetOnSpawn"] = false,
            ["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
        }, {
            ["Background"] = u8(function(p30) --[[ Line: 65 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u9
                    [3] = u27
                --]]
                local v31 = u6.createElement
                local v32 = {
                    ["BackgroundColor3"] = p30:GetColor("Light"),
                    ["BorderSizePixel"] = 1,
                    ["BorderColor3"] = p30:GetColor("Border"),
                    ["Size"] = UDim2.new(1, 0, 0, 50),
                    ["Position"] = UDim2.fromOffset(0, 10)
                }
                local v33 = {
                    ["PacketFrames"] = u6.createElement(u9, {
                        ["Enabled"] = u27.props.Enabled,
                        ["MaxFrameSize"] = u27.state.MaxFrameSize,
                        ["OnPacketProfilerPaused"] = u27.OnPacketProfilerPaused,
                        ["OnPacketProfilerEnabled"] = u27.props.OnEnabled,
                        ["Signals"] = u27.props.Signals
                    })
                }
                return v31("Frame", v32, v33)
            end),
            ["Topbar"] = u8(function(p34) --[[ Line: 82 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u28
                    [3] = u11
                    [4] = u29
                    [5] = u10
                    [6] = u27
                --]]
                local v35 = u6.createElement
                local v36 = {
                    ["BackgroundColor3"] = p34:GetColor("Item"),
                    ["BorderSizePixel"] = 0,
                    ["ZIndex"] = 2,
                    ["Size"] = UDim2.new(1, 0, 0, 10)
                }
                local v37 = {
                    ["UIListLayout"] = u6.createElement("UIListLayout", {
                        ["FillDirection"] = Enum.FillDirection.Horizontal,
                        ["HorizontalAlignment"] = u28 == "Left" and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Right,
                        ["VerticalAlignment"] = Enum.VerticalAlignment.Center,
                        ["SortOrder"] = Enum.SortOrder.LayoutOrder,
                        ["Padding"] = UDim.new(0, 5)
                    })
                }
                local v38 = {
                    ["Text"] = "PacketProfiler",
                    ["Theme"] = p34,
                    ["LayoutOrder"] = u29
                }
                v37.Title = u6.createElement(u11, v38)
                v37.MaxKBScale = u6.createElement(u10, {
                    ["Theme"] = p34,
                    ["Text"] = "Max KB scale",
                    ["Options"] = {
                        {
                            ["Name"] = "10 B",
                            ["Callback"] = function() --[[ Name: Callback, Line 107 ]]
                                --[[
                                Upvalues:
                                    [1] = u27
                                --]]
                                u27:setState({
                                    ["MaxFrameSize"] = 10
                                })
                            end
                        },
                        {
                            ["Name"] = "100 B",
                            ["Callback"] = function() --[[ Name: Callback, Line 115 ]]
                                --[[
                                Upvalues:
                                    [1] = u27
                                --]]
                                u27:setState({
                                    ["MaxFrameSize"] = 100
                                })
                            end
                        },
                        {
                            ["Name"] = "1 KB",
                            ["Callback"] = function() --[[ Name: Callback, Line 123 ]]
                                --[[
                                Upvalues:
                                    [1] = u27
                                --]]
                                u27:setState({
                                    ["MaxFrameSize"] = 1000
                                })
                            end
                        },
                        {
                            ["Name"] = "10 KB",
                            ["Callback"] = function() --[[ Name: Callback, Line 131 ]]
                                --[[
                                Upvalues:
                                    [1] = u27
                                --]]
                                u27:setState({
                                    ["MaxFrameSize"] = 10000
                                })
                            end
                        },
                        {
                            ["Name"] = "50 KB",
                            ["Callback"] = function() --[[ Name: Callback, Line 139 ]]
                                --[[
                                Upvalues:
                                    [1] = u27
                                --]]
                                u27:setState({
                                    ["MaxFrameSize"] = 50000
                                })
                            end
                        },
                        {
                            ["Name"] = "100 KB",
                            ["Callback"] = function() --[[ Name: Callback, Line 147 ]]
                                --[[
                                Upvalues:
                                    [1] = u27
                                --]]
                                u27:setState({
                                    ["MaxFrameSize"] = 100000
                                })
                            end
                        }
                    },
                    ["LayoutOrder"] = u29 * 2
                })
                v37.PausedLabel = u6.createElement(u11, {
                    ["Text"] = u27.PacketProfilerPaused:map(function(p39) --[[ Line: 157 ]]
                        return p39 and "[Paused]" or "[Running]"
                    end),
                    ["Theme"] = p34,
                    ["OnClick"] = function() --[[ Name: OnClick, Line 161 ]]
                        --[[
                        Upvalues:
                            [1] = u27
                        --]]
                        u27.props.Signals.ProfilerPaused:Fire(not u27.PacketProfilerPaused:getValue())
                    end,
                    ["LayoutIndex"] = u29 * 3
                })
                return v35("Frame", v36, v37)
            end)
        })
    })
end
return v13