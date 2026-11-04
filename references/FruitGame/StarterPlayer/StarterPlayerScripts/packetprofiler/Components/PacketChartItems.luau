 

local u1 = game:GetService("TweenService")
local v2 = script.Parent.Parent
local v3 = v2.Components
local v4 = v2.Modules
local v5 = require(v4.Packages)
local u6 = require(v5.Directory.Roact)
local u7 = require(v3.StudioTheme)
local function u9(p8) --[[ Line: 12 ]]
    if p8 < 1000 then
        return p8, "bytes"
    elseif p8 < 1000000 then
        return p8 / 1000, "kilobytes"
    else
        return p8 / 1000000, "megabytes"
    end
end
local u10 = u6.Component:extend("DataChartItem")
function u10.init(p11) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v12, v13 = u6.createBinding(false)
    p11.RemoteData = v12
    p11.ShowRemoteData = v13
    local v14, v15 = u6.createBinding(Vector2.zero)
    p11.Size = v14
    p11.SetSize = v15
    local v16, v17 = u6.createBinding(1)
    p11.HighlightTransparency = v16
    p11.SetHighlightTransparency = v17
    p11.HighlightFrame = u6.createRef()
    p11.FadeInTween = nil
    p11.FadeOutTween = nil
    p11.HighlightTask = nil
end
function u10.didMount(u18) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if u18.props.OnArcClicked then
        u18.ArcClickConnection = u18.props.OnArcClicked:Connect(function(p19) --[[ Line: 37 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u1
            --]]
            if p19 == u18.props.Arc.Name then
                u18.ShowRemoteData(true)
                if u18.FadeInTween then
                    u18.FadeInTween:Cancel()
                end
                if u18.FadeOutTween then
                    u18.FadeOutTween:Cancel()
                end
                if u18.HighlightTask then
                    task.cancel(u18.HighlightTask)
                end
                local u20 = u18.HighlightFrame:getValue()
                if u20 then
                    u20.BackgroundTransparency = 1
                    u18.FadeInTween = u1:Create(u20, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["BackgroundTransparency"] = 0.7
                    })
                    u18.FadeInTween:Play()
                    u18.HighlightTask = task.delay(0.25, function() --[[ Line: 62 ]]
                        --[[
                        Upvalues:
                            [1] = u18
                            [2] = u1
                            [3] = u20
                        --]]
                        u18.FadeOutTween = u1:Create(u20, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            ["BackgroundTransparency"] = 1
                        })
                        u18.FadeOutTween:Play()
                    end)
                end
            end
        end)
    end
end
function u10.willUnmount(p21) --[[ Line: 76 ]]
    if p21.ArcClickConnection then
        p21.ArcClickConnection:Disconnect()
    end
    if p21.FadeInTween then
        p21.FadeInTween:Cancel()
    end
    if p21.FadeOutTween then
        p21.FadeOutTween:Cancel()
    end
    if p21.HighlightTask then
        task.cancel(p21.HighlightTask)
    end
end
function u10.render(u22) --[[ Line: 91 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u6
        [3] = u9
    --]]
    local u23 = u22.props.Arc
    local u24 = {}
    for u25, u26 in u22.props.RemoteData do
        local u27 = u26.Packet
        u24[u25] = u7(function(p28) --[[ Line: 97 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u6
                [3] = u26
                [4] = u22
                [5] = u27
            --]]
            local v29 = u25 * 2
            local v30 = u25 * 2 + 1
            local v31 = u6.createElement
            local v32 = {
                ["AutoLocalize"] = false,
                ["LayoutOrder"] = v29,
                ["Font"] = Enum.Font.SourceSans,
                ["Text"] = u26.Name,
                ["RichText"] = true,
                ["TextColor3"] = p28:GetColor("BrightText"),
                ["TextSize"] = 14,
                ["TextXAlignment"] = Enum.TextXAlignment.Left,
                ["BackgroundTransparency"] = 1,
                ["Size"] = UDim2.new(1, 0, 0, 20),
                ["Visible"] = u22.RemoteData,
                ["Selectable"] = false
            }
            local v33 = {
                ["Padding"] = u6.createElement("UIPadding", {
                    ["PaddingBottom"] = UDim.new(0, 4)
                })
            }
            local v34 = v31("TextButton", v32, v33)
            local v35 = u6.createElement
            local v38 = {
                ["AutomaticSize"] = Enum.AutomaticSize.Y,
                ["AutomaticCanvasSize"] = Enum.AutomaticSize.X,
                ["LayoutOrder"] = v30,
                ["BackgroundColor3"] = p28:GetColor("ScrollBarBackground"),
                ["Position"] = UDim2.fromOffset(0, 20),
                ["Size"] = UDim2.new(1, -12, 0, 0),
                ["ClipsDescendants"] = true,
                ["BorderSizePixel"] = 0,
                ["ScrollBarImageColor3"] = p28:GetColor("ScrollBar"),
                ["ScrollBarThickness"] = 4,
                ["ScrollingDirection"] = Enum.ScrollingDirection.X,
                ["Visible"] = u22.RemoteData,
                [u6.Ref] = function(u36) --[[ Line: 132 ]]
                    if u36 ~= nil then
                        task.delay(0.1, function() --[[ Line: 137 ]]
                            --[[
                            Upvalues:
                                [1] = u36
                            --]]
                            local v37 = Instance.new("UICorner")
                            v37.CornerRadius = UDim.new(0, 4)
                            v37.Parent = u36
                        end)
                    end
                end
            }
            local v39 = {
                ["UIStroke"] = u6.createElement("UIStroke", {
                    ["Color"] = p28:GetColor("DropShadow"),
                    ["LineJoinMode"] = Enum.LineJoinMode.Round,
                    ["Transparency"] = 0.5
                })
            }
            local v40 = u6.createElement
            local v41 = {
                ["AutoLocalize"] = false,
                ["Font"] = Enum.Font.Code,
                ["RichText"] = true,
                ["Text"] = u27,
                ["TextColor3"] = p28:GetColor("BrightText"),
                ["TextSize"] = 12,
                ["TextXAlignment"] = Enum.TextXAlignment.Left,
                ["TextYAlignment"] = Enum.TextYAlignment.Top,
                ["AutomaticSize"] = Enum.AutomaticSize.XY,
                ["BackgroundTransparency"] = 1,
                ["Size"] = UDim2.fromScale(1, 1),
                ["ClipsDescendants"] = true
            }
            local v42 = {
                ["Padding"] = u6.createElement("UIPadding", {
                    ["PaddingBottom"] = UDim.new(0, 8),
                    ["PaddingRight"] = UDim.new(0, 8),
                    ["PaddingLeft"] = UDim.new(0, 4),
                    ["PaddingTop"] = UDim.new(0, 4)
                })
            }
            v39.Text = v40("TextLabel", v41, v42)
            local v43 = { v34, (v35("ScrollingFrame", v38, v39)) }
            return u6.createFragment(v43)
        end)
    end
    return u7(function(p44) --[[ Line: 177 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u23
            [3] = u22
            [4] = u9
            [5] = u24
        --]]
        local v45 = u6.createElement
        local v46 = {
            ["BackgroundTransparency"] = 1,
            ["Size"] = UDim2.new(1, 0, 0, 22),
            ["AutomaticSize"] = Enum.AutomaticSize.Y
        }
        local v47 = {
            ["HighlightEffect"] = u6.createElement("Frame", {
                ["BackgroundColor3"] = u23.Color,
                ["BackgroundTransparency"] = 1,
                ["Size"] = UDim2.fromScale(1, 1),
                ["Position"] = UDim2.fromScale(0, 0),
                ["ZIndex"] = 1,
                ["BorderSizePixel"] = 0,
                [u6.Ref] = u22.HighlightFrame
            })
        }
        local v48 = u6.createElement
        local v49 = {
            ["AutoLocalize"] = false,
            ["Font"] = Enum.Font.SourceSans,
            ["Text"] = string.format("<font color=\"#%s\"><b>%s</b></font>: %.1f%%, %d %s", u23.Color:ToHex(), u23.Name, u23.Percent, u9(u23.DataSize)),
            ["RichText"] = true,
            ["TextColor3"] = p44:GetColor("BrightText"),
            ["TextSize"] = 14,
            ["TextXAlignment"] = Enum.TextXAlignment.Left,
            ["BackgroundTransparency"] = 1,
            ["Size"] = UDim2.new(1, -18, 0, 20),
            ["Position"] = UDim2.fromOffset(18, 0),
            ["ZIndex"] = 3,
            [u6.Event.Activated] = function() --[[ Line: 204 ]]
                --[[
                Upvalues:
                    [1] = u22
                --]]
                u22.ShowRemoteData(not u22.RemoteData:getValue())
            end
        }
        local v50 = {
            ["Padding"] = u6.createElement("UIPadding", {
                ["PaddingBottom"] = UDim.new(0, 4)
            })
        }
        v47.Information = v48("TextButton", v49, v50)
        v47.Chevron = u6.createElement("ImageLabel", {
            ["BackgroundTransparency"] = 1,
            ["Image"] = u22.RemoteData:map(function(p51) --[[ Line: 214 ]]
                return p51 and "rbxassetid://18699144520" or "rbxassetid://18699113012"
            end),
            ["ImageColor3"] = p44:GetColor("BrightText"),
            ["Size"] = UDim2.fromOffset(16, 16),
            ["Position"] = UDim2.fromOffset(0, 2),
            ["ZIndex"] = 3
        })
        local v52 = u6.createElement
        local v55 = {
            ["AutomaticSize"] = Enum.AutomaticSize.Y,
            ["Size"] = u22.props.ScrollBarChanged:map(function(p53) --[[ Line: 224 ]]
                return UDim2.new(1, p53.Visible and -12 or 0, 0, 0)
            end),
            ["Position"] = UDim2.fromOffset(8, 24),
            ["Transparency"] = 1,
            [u6.Change.AbsoluteSize] = function(p54) --[[ Line: 229 ]]
                --[[
                Upvalues:
                    [1] = u22
                --]]
                u22.SetSize(p54.AbsoluteSize)
            end
        }
        local v56 = {
            ["RemoteData"] = u6.createFragment(u24),
            ["UIListLayout"] = u6.createElement("UIListLayout", {
                ["SortOrder"] = Enum.SortOrder.LayoutOrder,
                ["FillDirection"] = Enum.FillDirection.Vertical,
                ["HorizontalAlignment"] = Enum.HorizontalAlignment.Left,
                ["VerticalAlignment"] = Enum.VerticalAlignment.Top,
                ["Padding"] = UDim.new(0, 0)
            })
        }
        v47.Container = v52("Frame", v55, v56)
        v47.Divider = u6.createElement("Frame", {
            ["BackgroundColor3"] = p44:GetColor("DropShadow"),
            ["Transparency"] = 0.5,
            ["BorderSizePixel"] = 0,
            ["Size"] = u22.Size:map(function(p57) --[[ Line: 246 ]]
                return UDim2.new(0, 1, 0, p57.Y)
            end),
            ["Position"] = UDim2.fromOffset(0, 26),
            ["ZIndex"] = 2
        })
        return v45("Frame", v46, v47)
    end)
end
return function(p58) --[[ Name: DataChartItems, Line 256 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u10
    --]]
    local v59 = 0
    local v60 = {}
    for _, v61 in p58.Arcs do
        v59 = v59 - v61.Percent
        v60[v59] = u6.createElement(u10, {
            ["Arc"] = v61,
            ["RemoteData"] = v61.RemoteData,
            ["ScrollBarChanged"] = p58.ScrollBarChanged,
            ["OnArcClicked"] = p58.OnArcClicked
        })
    end
    return u6.createFragment(v60)
end