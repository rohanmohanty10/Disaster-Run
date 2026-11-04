 

local v1 = game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = script.Parent.Parent
local u4 = v3.Components
local v5 = v3.Modules
local u6 = require(v5.Packages)
local u7 = require(u6.Directory.Roact)
local u8 = require(u6.Directory.Signal)
local u9 = require(u6.Directory.PacketSizeCounter)
local u10 = require(u4.StudioTheme)
local u11 = require(u4.PacketCircleArcs)
local u12 = require(u4.PacketChartItems)
local u13 = require(u4.ChartResize)
local u14 = require(v5.TableToSyntaxString)
local u15 = not v1:IsRunning()
local u16 = 0
local v17 = v2:FindFirstChild("RemoteName.profiler", true)
local u18 = nil
if v17 == nil then
    local u19 = nil
    u19 = v2.DescendantAdded:Connect(function(p20) --[[ Line: 41 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u19
        --]]
        if p20.Name == "RemoteName.profiler" then
            local v21 = require
            local v22 = typeof(v21(p20)) == "function"
            assert(v22, "Return of RemoteName.profiler must be a function")
            u18 = require(p20)
            u19:Disconnect()
        end
    end)
else
    local v23 = require
    local v24 = typeof(v23(v17)) == "function"
    assert(v24, "Return of RemoteName.profiler must be a function")
    u18 = require(v17)
end
local function u28(p25, ...) --[[ Line: 53 ]]
    --[[
    Upvalues:
        [1] = u18
    --]]
    local v26 = u18
    if v26 then
        v26 = u18(p25, ...)
    end
    if v26 then
        return v26
    end
    local v27 = p25.Name
    return ("%*.%*"):format(p25.Parent, v27)
end
local v29 = u7.Component:extend("PacketChart")
function v29.init(p30) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u7
    --]]
    p30.ArcsUpdated = u8.new()
    p30.OnArcClicked = u8.new()
    local v31, v32 = u7.createBinding(false)
    p30.ChartEnabled = v31
    p30.SetChartEnabled = v32
    local v33, v34 = u7.createBinding({
        ["Size"] = 0,
        ["Visible"] = false
    })
    p30.ScrollBarChanged = v33
    p30.SetScrollBarChanged = v34
    p30.OpenRemoteData = u8.new()
    p30:setState({
        ["Arcs"] = {}
    })
end
function v29.didMount(u35) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u28
        [2] = u14
        [3] = u9
        [4] = u16
    --]]
    u35.props.Signals.ProfilerFrameSelected:Connect(function(p36) --[[ Line: 82 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u14
            [3] = u9
            [4] = u16
            [5] = u35
        --]]
        local v37 = {}
        for _, v38 in p36.Packets do
            local v39 = u28
            local v40 = v38.Remote
            local v41 = v38.RawData
            local v42 = v39(v40, unpack(v41))
            local v43 = v38.Size
            if typeof(v42) == "string" then
                if not v37[v42] then
                    v37[v42] = {
                        ["Size"] = 0,
                        ["Data"] = {}
                    }
                end
                local v44 = v37[v42]
                v44.Size = v44.Size + v43
                local v45 = #v37[v42].Data + 1
                v37[v42].Data[v45] = {
                    ["Name"] = ("Remote call %*:"):format(v45),
                    ["Packet"] = ("%*"):format(v38.Data and u14(v38.Data) or "[None]")
                }
            else
                local v46 = {}
                local v47 = 0
                for v48, v49 in v42 do
                    local v50 = u9.GetPacketSize({
                        ["RunContext"] = v38.RunContext,
                        ["RemoteType"] = "RemoteEvent",
                        ["PacketData"] = v49.Arguments
                    }) - u9.BaseRemoteOverhead
                    if v38.RunContext == "Client" then
                        v50 = v50 - u9.ClientToServerOverhead
                    end
                    v46[v48] = v50
                    v47 = v47 + v50
                end
                for v51, v52 in v42 do
                    local v53 = v52.Name
                    if not v37[v53] then
                        v37[v53] = {
                            ["Size"] = 0,
                            ["Data"] = {}
                        }
                    end
                    local v54 = v37[v53]
                    v54.Size = v54.Size + v46[v51] / v47 * v43
                    local v55 = #v37[v53].Data + 1
                    v37[v53].Data[v55] = {
                        ["Name"] = v52.Name,
                        ["Packet"] = u14(v52.Arguments, true)
                    }
                end
            end
        end
        local v56 = p36.TotalSize
        local v57 = {}
        for v58, v59 in v37 do
            local v60 = v59.Size / v56
            u16 = (u16 + 0.6180339887498949) % 1
            local v61 = Color3.fromHSV(u16, 0.5, 0.95)
            local v62 = {
                ["Name"] = v58,
                ["DataSize"] = v59.Size,
                ["Percent"] = v60 * 100,
                ["Color"] = v61,
                ["RemoteData"] = v59.Data
            }
            table.insert(v57, v62)
        end
        table.sort(v57, function(p63, p64) --[[ Line: 159 ]]
            return p63.Percent > p64.Percent
        end)
        u35:setState({
            ["Arcs"] = v57
        })
    end)
    u35.props.Signals.ProfilerPaused:Connect(function(p65) --[[ Line: 167 ]]
        --[[
        Upvalues:
            [1] = u35
        --]]
        u35.SetChartEnabled(p65)
    end)
    u35.props.OnEnabled:Connect(function(p66) --[[ Line: 170 ]]
        --[[
        Upvalues:
            [1] = u35
        --]]
        u35.SetChartEnabled(p66)
    end)
end
function v29.render(u67) --[[ Line: 175 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u6
        [3] = u4
        [4] = u10
        [5] = u13
        [6] = u15
        [7] = u11
        [8] = u12
    --]]
    return u7.createElement(u6.IsPlugin and require(u4.StudioWidget) or "ScreenGui", ({
        ["Plugin"] = {
            ["WidgetId"] = "PacketChart",
            ["WidgetTitle"] = "Packet Chart",
            ["InitialDockState"] = Enum.InitialDockState.Float,
            ["Enabled"] = u67.props.Enabled,
            ["OnEnabled"] = u67.props.OnEnabled,
            ["DefaultSize"] = Vector2.new(350, 200),
            ["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
            ["MinimumSize"] = Vector2.new(300, 100)
        },
        ["Client"] = {
            ["IgnoreGuiInset"] = true,
            ["ResetOnSpawn"] = false,
            ["Enabled"] = u67.ChartEnabled,
            ["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
        }
    })[u6.IsPlugin and "Plugin" or "Client"], {
        ["Holder"] = u10(function(u68) --[[ Line: 194 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u7
                [3] = u6
                [4] = u15
                [5] = u67
                [6] = u11
                [7] = u12
            --]]
            return u13(function(p69) --[[ Line: 195 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u6
                    [3] = u68
                    [4] = u15
                    [5] = u67
                    [6] = u11
                    [7] = u12
                --]]
                local v70 = u7.createElement
                local v71 = "Frame"
                local v72 = {
                    ["BackgroundTransparency"] = 1,
                    ["AnchorPoint"] = u6.IsPlugin and Vector2.new() or Vector2.new(1, 0),
                    ["Position"] = u6.IsPlugin and UDim2.new() or UDim2.new(1, 0, 0, 61),
                    ["Size"] = u6.IsPlugin and UDim2.fromScale(1, 1) or p69.UISize
                }
                local v73 = u7.Ref
                local v74
                if u6.IsPlugin then
                    v74 = nil
                else
                    v74 = p69.SetSizeTarget or nil
                end
                v72[v73] = v74
                local v81 = {
                    ["Background"] = u7.createElement("Frame", {
                        ["BackgroundColor3"] = u68:GetColor("MainBackground"),
                        ["BorderSizePixel"] = 0,
                        ["ZIndex"] = 0,
                        ["Size"] = UDim2.fromScale(1, 1)
                    }, {
                        ["Notches"] = u7.createElement("ImageLabel", {
                            ["AnchorPoint"] = Vector2.new(0, 1),
                            ["BackgroundTransparency"] = 1,
                            ["Image"] = "rbxassetid://18701486909",
                            ["ImageColor3"] = u68:GetColor("BrightText"),
                            ["ImageTransparency"] = 0.5,
                            ["Position"] = UDim2.fromScale(0, 1),
                            ["Size"] = UDim2.fromOffset(16, 16)
                        })
                    }),
                    ["UIStroke"] = u7.createElement("UIStroke", {
                        ["Color"] = u68:GetColor("DropShadow"),
                        ["Thickness"] = 1
                    }),
                    ["BackgroundCircle"] = u7.createElement("Frame", {
                        ["BackgroundTransparency"] = 1,
                        ["Size"] = UDim2.fromOffset(100, 100),
                        ["Visible"] = not u15,
                        ["Position"] = UDim2.fromOffset(8, 8)
                    }, {
                        ["BackgroundUI"] = u7.createElement("Frame", {
                            ["BackgroundColor3"] = u68:GetColor("ScrollBarBackground"),
                            ["Size"] = UDim2.fromScale(1, 1),
                            ["Visible"] = #u67.state.Arcs > 0
                        }, {
                            ["UIStroke"] = u7.createElement("UIStroke", {
                                ["Color"] = u68:GetColor("DropShadow"),
                                ["LineJoinMode"] = Enum.LineJoinMode.Round,
                                ["Transparency"] = 0.5
                            }),
                            ["UICorner"] = u7.createElement("UICorner", {
                                ["CornerRadius"] = UDim.new(0, 4)
                            })
                        }),
                        ["PacketCircle"] = u7.createElement(u11, {
                            ["Arcs"] = u67.state.Arcs,
                            ["PluginMouse"] = u67.props.PluginMouse,
                            ["OnArcClicked"] = function(p75) --[[ Name: OnArcClicked, Line 247 ]]
                                --[[
                                Upvalues:
                                    [1] = u67
                                --]]
                                u67.OnArcClicked:Fire(p75)
                            end
                        })
                    }),
                    ["DataList"] = u7.createElement("ScrollingFrame", {
                        ["BackgroundColor3"] = u68:GetColor("MainBackground"),
                        ["Size"] = UDim2.new(1, -121, 1, -1),
                        ["Position"] = UDim2.new(1, -1, 0, 0),
                        ["AnchorPoint"] = Vector2.new(1, 0),
                        ["AutomaticCanvasSize"] = Enum.AutomaticSize.Y,
                        ["CanvasSize"] = UDim2.new(),
                        ["BorderSizePixel"] = 0,
                        ["BackgroundTransparency"] = 1,
                        ["Visible"] = not u15,
                        ["ZIndex"] = 2,
                        ["BottomImage"] = "rbxassetid://5234388158",
                        ["MidImage"] = "rbxassetid://5234388158",
                        ["TopImage"] = "rbxassetid://5234388158",
                        ["ScrollBarImageColor3"] = u68:GetColor("Light"),
                        ["ScrollBarThickness"] = 10,
                        [u7.Change.AbsoluteCanvasSize] = function(p76) --[[ Line: 269 ]]
                            --[[
                            Upvalues:
                                [1] = u67
                            --]]
                            u67.SetScrollBarChanged({
                                ["Size"] = p76.AbsoluteSize.Y,
                                ["Visible"] = p76.AbsoluteSize.Y < p76.AbsoluteCanvasSize.Y
                            })
                        end,
                        [u7.Change.AbsoluteSize] = function(p77) --[[ Line: 275 ]]
                            --[[
                            Upvalues:
                                [1] = u67
                            --]]
                            u67.SetScrollBarChanged({
                                ["Size"] = p77.AbsoluteSize.Y,
                                ["Visible"] = p77.AbsoluteSize.Y < p77.AbsoluteCanvasSize.Y
                            })
                        end
                    }, {
                        ["UIListLayout"] = u7.createElement("UIListLayout", {
                            ["SortOrder"] = Enum.SortOrder.LayoutOrder,
                            ["FillDirection"] = Enum.FillDirection.Vertical,
                            ["HorizontalAlignment"] = Enum.HorizontalAlignment.Left,
                            ["VerticalAlignment"] = Enum.VerticalAlignment.Top,
                            [u7.Change.AbsoluteContentSize] = function(p78) --[[ Line: 287 ]]
                                p78.Parent.CanvasSize = UDim2.fromOffset(0, p78.AbsoluteContentSize.Y)
                            end
                        }),
                        ["Items"] = u7.createElement(u12, {
                            ["Arcs"] = u67.state.Arcs,
                            ["ScrollBarChanged"] = u67.ScrollBarChanged,
                            ["OnArcClicked"] = u67.OnArcClicked
                        }),
                        ["UIPadding"] = u7.createElement("UIPadding", {
                            ["PaddingTop"] = UDim.new(0, 8),
                            ["PaddingBottom"] = UDim.new(0, 8)
                        })
                    }),
                    ["EditModeNotifier"] = u7.createElement("TextLabel", {
                        ["AutoLocalize"] = false,
                        ["Size"] = UDim2.fromScale(1, 1),
                        ["Position"] = UDim2.fromScale(0.5, 0.5),
                        ["AnchorPoint"] = Vector2.new(0.5, 0.5),
                        ["BackgroundTransparency"] = 1,
                        ["Text"] = "Start session to begin",
                        ["TextColor3"] = u68:GetColor("WarningText"),
                        ["TextSize"] = 20,
                        ["Font"] = Enum.Font.SourceSans,
                        ["TextXAlignment"] = Enum.TextXAlignment.Center,
                        ["TextYAlignment"] = Enum.TextYAlignment.Center,
                        ["Visible"] = u15
                    }),
                    ["ScrollBarOutline"] = u7.createElement("Frame", {
                        ["BackgroundColor3"] = u68:GetColor("ScrollBarBackground"),
                        ["BorderSizePixel"] = 0,
                        ["Size"] = u67.ScrollBarChanged:map(function(p79) --[[ Line: 318 ]]
                            return UDim2.fromOffset(12, p79.Size)
                        end),
                        ["Position"] = UDim2.new(1, 0, 0, 0),
                        ["AnchorPoint"] = Vector2.new(1, 0),
                        ["Visible"] = u67.ScrollBarChanged:map(function(p80) --[[ Line: 323 ]]
                            return p80.Visible
                        end)
                    })
                }
                return v70(v71, v72, v81)
            end)
        end)
    })
end
return v29