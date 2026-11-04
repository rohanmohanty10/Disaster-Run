 

local u1 = game:GetService("RunService")
local v2 = game:GetService("GuiService")
local u3 = game:GetService("ReplicatedStorage")
local v4 = script.Parent.Parent
local v5 = v4.Components
local v6 = v4.Modules
local v7 = require(v6.Packages)
local u8 = require(v7.Directory.Roact)
local u9 = require(v7.Directory.PacketSizeCounter)
local u10 = require(v5.StudioTheme)
local u11 = require(v6.CircularBuffer)
local u12 = require(v5.PacketFrame)
local u13 = v2:GetGuiInset()
local u14 = u8.Component:extend("PacketFrames")
local u15 = not u1:IsRunning()
local u16 = u1:IsClient() and "OnClientEvent" or "OnServerEvent"
local u17 = u3:FindFirstChild("RemoteFunctionEvent.profiler", true)
function u14.init(u18) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u15
        [3] = u11
        [4] = u14
        [5] = u1
        [6] = u9
        [7] = u13
    --]]
    u18.Cleanup = {}
    u18.ProfilerBackgroundRef = u8.createRef()
    u18.Enabled = not u15
    u18.PacketFrames = u11.new(256)
    u18:setState({
        ["PacketFrames"] = u14
    })
    local v19, v20 = u8.createBinding(u18.PacketFrames)
    u18.PacketsChanged = v19
    u18.SetPacketsChanged = v20
    function u18.RemoteCallback(p21, p22, ...) --[[ Line: 43 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u1
            [3] = u9
        --]]
        if u18.Enabled then
            local v23
            if u1:IsClient() then
                v23 = u9.GetPacketSize({
                    ["RunContext"] = "Client",
                    ["RemoteType"] = p21.ClassName,
                    ["PacketData"] = { p22, ... }
                })
            else
                v23 = u9.GetPacketSize({
                    ["RunContext"] = "Server",
                    ["RemoteType"] = p21.ClassName,
                    ["PacketData"] = { ... }
                })
            end
            local v24 = u18.CurrentFrame
            v24.TotalSize = v24.TotalSize + v23
            local v25 = u18.CurrentFrame.Packets
            local v26 = {
                ["Remote"] = p21,
                ["Data"] = u1:IsClient() and ({ p22, ... } or { ... }) or { ... },
                ["RawData"] = { p22, ... },
                ["Size"] = v23,
                ["RunContext"] = u1:IsClient() and "Client" or "Server"
            }
            table.insert(v25, v26)
        end
    end
    function u18.InputBegan(_, p27) --[[ Line: 73 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u13
        --]]
        if p27.UserInputType == Enum.UserInputType.MouseButton1 then
            local v28 = u18.UpdateMouseData(p27.Position.X, p27.Position.Y + u13.Y, true)
            if v28 then
                u18.props.Signals.ProfilerFrameSelected:Fire(v28)
            end
            u18.props.OnPacketProfilerPaused:Fire(true)
        end
    end
    local v29, v30 = u8.createBinding(Vector2.new(0, 0))
    u18.MousePosition = v29
    u18.SetMousePosition = v30
    local v31, v32 = u8.createBinding(false)
    u18.MouseOver = v31
    u18.SetMouseOver = v32
    local u33 = {
        ["Selected"] = false,
        ["Index"] = 0,
        ["TotalSize"] = 0,
        ["Packets"] = {}
    }
    local v34, v35 = u8.createBinding(u33)
    u18.SelectedFrameData = v34
    u18.SetSelectedFrameData = v35
    local v36, v37 = u8.createBinding(u33)
    u18.MouseFrameData = v36
    u18.SetMouseFrameData = v37
    function u18.UpdateMouseData(p38, p39, p40) --[[ Line: 96 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u33
        --]]
        u18.SetMousePosition(Vector2.new(p38, p39))
        local v41 = p38 / (u18.ProfilerBackgroundRef:getValue().AbsoluteSize.X * 0.00390625)
        local v42 = 256 - math.floor(v41)
        local v43
        if p38 > 0 then
            v43 = u18.PacketFrames[v42] or nil
        else
            v43 = nil
        end
        if not v43 then
            u18.SetMouseFrameData(u33)
            return v43
        end
        local v44 = {
            ["Selected"] = p40,
            ["Index"] = v42,
            ["TotalSize"] = v43.TotalSize,
            ["Packets"] = v43.Packets
        }
        if p40 then
            u18.SetSelectedFrameData(v44)
        end
        u18.SetMouseFrameData(v44)
        return v43
    end
    function u18.MouseEnter(_, p45, p46) --[[ Line: 126 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u18
        --]]
        if not u15 then
            u18.UpdateMouseData(p45, p46, false)
            u18.SetMouseOver(true)
        end
    end
    function u18.MouseMoved(_, p47, p48) --[[ Line: 134 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u18
        --]]
        if not u15 then
            u18.UpdateMouseData(p47, p48, false)
        end
    end
    function u18.MouseLeave(_) --[[ Line: 141 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u18
        --]]
        if not u15 then
            u18.UpdateMouseData(-1, -1, false)
            u18.SetMouseOver(false)
        end
    end
    local v49, v50 = u8.createBinding(Vector2.zero)
    u18.TooltipSize = v49
    u18.SetTooltipSize = v50
end
function u14.didMount(u51) --[[ Line: 153 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u1
        [3] = u16
        [4] = u17
        [5] = u3
    --]]
    if not u15 then
        local v52 = u51.Cleanup
        local v53 = u51.props.OnPacketProfilerPaused
        table.insert(v52, v53:Connect(function(p54) --[[ Line: 155 ]]
            --[[
            Upvalues:
                [1] = u51
            --]]
            u51.Enabled = not p54
        end))
        u51.CurrentFrame = {
            ["Time"] = os.clock(),
            ["TotalSize"] = 0,
            ["Packets"] = {}
        }
        task.spawn(function() --[[ Line: 165 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u51
                [3] = u16
                [4] = u17
                [5] = u3
            --]]
            local v55 = {}
            local v56 = game:GetService("ReplicatedStorage")
            local v57 = game:GetService("ReplicatedFirst")
            local v58 = game:GetService("StarterPlayer")
            local v59 = game:GetService("Workspace")
            local v60 = game:GetService("StarterGui")
            local v61 = game:GetService("Players")
            local v62
            if u1:IsServer() then
                v62 = game:GetService("ServerScriptService")
            else
                v62 = nil
            end
            local v63
            if u1:IsServer() then
                v63 = game:GetService("ServerStorage")
            else
                v63 = nil
            end
            __set_list(v55, 1, {v56, v57, v58, v59, v60, v61, v62, v63})
            for _, v64 in v55 do
                for _, u65 in v64:GetDescendants() do
                    if u65:IsA("RemoteEvent") or u65:IsA("UnreliableRemoteEvent") then
                        local v66 = u51.Cleanup
                        local v67 = u65[u16]
                        local function v68(...) --[[ Line: 181 ]]
                            --[[
                            Upvalues:
                                [1] = u51
                                [2] = u65
                            --]]
                            u51.RemoteCallback(u65, ...)
                        end
                        table.insert(v66, v67:Connect(v68))
                    end
                end
                local v69 = u51.Cleanup
                local v70 = v64.DescendantAdded
                local function v75(u71) --[[ Line: 187 ]]
                    --[[
                    Upvalues:
                        [1] = u51
                        [2] = u16
                    --]]
                    if u71:IsA("RemoteEvent") or u71:IsA("UnreliableRemoteEvent") then
                        local v72 = u51.Cleanup
                        local v73 = u71[u16]
                        local function v74(...) --[[ Line: 189 ]]
                            --[[
                            Upvalues:
                                [1] = u51
                                [2] = u71
                            --]]
                            u51.RemoteCallback(u71, ...)
                        end
                        table.insert(v72, v73:Connect(v74))
                    end
                end
                table.insert(v69, v70:Connect(v75))
            end
            if u17 == nil then
                local u76 = nil
                u76 = u3.DescendantAdded:Connect(function(p77) --[[ Line: 197 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                        [2] = u51
                        [3] = u76
                    --]]
                    if p77:IsA("BindableEvent") and p77.Name == "RemoteFunctionEvent.profiler" then
                        u17 = p77
                        local v78 = u51.Cleanup
                        local v79 = u17.Event
                        local v80 = u51.RemoteCallback
                        table.insert(v78, v79:Connect(v80))
                        u76:Disconnect()
                    end
                end)
            else
                local v81 = u51.Cleanup
                local v82 = u17.Event
                local v83 = u51.RemoteCallback
                table.insert(v81, v82:Connect(v83))
            end
            local v84 = u51.Cleanup
            local v85 = u1.RenderStepped
            local function v87() --[[ Line: 208 ]]
                --[[
                Upvalues:
                    [1] = u51
                --]]
                if u51.Enabled then
                    u51.PacketFrames:push(u51.CurrentFrame)
                    u51.SetPacketsChanged(u51.PacketFrames)
                    u51.CurrentFrame = {
                        ["Time"] = os.clock(),
                        ["TotalSize"] = 0,
                        ["Packets"] = {}
                    }
                    if u51.MouseOver:getValue() then
                        local v86 = u51.MousePosition:getValue()
                        u51.UpdateMouseData(v86.X, v86.Y, u51.SelectedFrameData:getValue().Selected)
                    end
                end
            end
            table.insert(v84, v85:Connect(v87))
        end)
    end
end
function u14.willUnmount(p88) --[[ Line: 230 ]]
    for _, v89 in p88.Cleanup do
        v89:Disconnect()
    end
end
function u14.render(u90) --[[ Line: 236 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u12
        [3] = u10
        [4] = u15
    --]]
    local v91 = {}
    for v92 = 1, 256 do
        v91[v92] = u8.createElement(u12, {
            ["Index"] = v92,
            ["PacketsChanged"] = u90.PacketsChanged,
            ["MaxFrameSize"] = u90.props.MaxFrameSize,
            ["MaxFrames"] = 256
        })
    end
    local v93 = u8.createElement
    local v94 = {
        ["Size"] = UDim2.fromScale(1, 1),
        ["BackgroundTransparency"] = 1,
        ["BorderSizePixel"] = 0,
        [u8.Event.InputBegan] = u90.InputBegan,
        [u8.Event.MouseEnter] = u90.MouseEnter,
        [u8.Event.MouseMoved] = u90.MouseMoved,
        [u8.Event.MouseLeave] = u90.MouseLeave,
        [u8.Ref] = u90.ProfilerBackgroundRef
    }
    local v118 = {
        ["Frames"] = u8.createFragment(v91),
        ["SelectedHighlight"] = u8.createElement("Frame", {
            ["Size"] = UDim2.fromScale(0.00390625, 1),
            ["BackgroundTransparency"] = 0.5,
            ["Position"] = u90.SelectedFrameData:map(function(p95) --[[ Line: 263 ]]
                return UDim2.fromScale(1 - p95.Index / 256, 0)
            end),
            ["BorderSizePixel"] = 0,
            ["Visible"] = u90.SelectedFrameData:map(function(p96) --[[ Line: 267 ]]
                if p96 then
                    p96 = p96.Selected
                end
                return p96
            end),
            ["ZIndex"] = 2,
            ["BackgroundColor3"] = Color3.fromHex("#34ff30")
        }),
        ["FrameHighlight"] = u8.createElement("Frame", {
            ["Size"] = u90.MouseFrameData:map(function(p97) --[[ Line: 274 ]]
                --[[
                Upvalues:
                    [1] = u90
                --]]
                local v98 = p97.TotalSize / u90.props.MaxFrameSize
                local v99 = math.min(v98, 1)
                return UDim2.fromScale(0.00390625, v99)
            end),
            ["AnchorPoint"] = Vector2.new(0, 1),
            ["BackgroundTransparency"] = 0.25,
            ["Position"] = u90.MouseFrameData:map(function(p100) --[[ Line: 280 ]]
                return UDim2.fromScale(1 - p100.Index / 256, 1)
            end),
            ["ZIndex"] = 2,
            ["BorderSizePixel"] = 0,
            ["Visible"] = u90.MouseFrameData:map(function(p101) --[[ Line: 285 ]]
                return p101.Index ~= 0
            end),
            ["BackgroundColor3"] = Color3.fromHex("#e8e8e8")
        }),
        ["FrameTooltip"] = u10(function(p102) --[[ Line: 290 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u90
            --]]
            local v103 = u8.createElement
            local v113 = {
                ["AutomaticSize"] = Enum.AutomaticSize.XY,
                ["BackgroundColor3"] = p102:GetColor("Dropdown"),
                ["BorderColor3"] = p102:GetColor("Border"),
                ["Position"] = u90.MousePosition:map(function(p104) --[[ Line: 295 ]]
                    --[[
                    Upvalues:
                        [1] = u90
                    --]]
                    local v105 = workspace.CurrentCamera
                    local v106 = v105 and v105.ViewportSize or Vector2.new(0, 0)
                    local v107 = u90.TooltipSize:getValue()
                    local v108 = UDim2.fromOffset
                    local v109 = p104.X
                    local v110 = v106.X - v107.X
                    return v108(math.min(v109, v110), p104.Y + 12)
                end),
                ["Visible"] = u90.MouseOver,
                ["ZIndex"] = 2,
                [u8.Change.AbsoluteSize] = function(p111) --[[ Line: 307 ]]
                    --[[
                    Upvalues:
                        [1] = u90
                    --]]
                    u90.SetTooltipSize(p111.AbsoluteSize)
                end,
                [u8.Ref] = function(p112) --[[ Line: 310 ]]
                    --[[
                    Upvalues:
                        [1] = u90
                    --]]
                    if p112 then
                        u90.SetTooltipSize(p112.AbsoluteSize)
                    end
                end
            }
            local v116 = {
                ["UIListLayout"] = u8.createElement("UIListLayout", {}),
                ["FrameLabel"] = u8.createElement("TextLabel", {
                    ["AutoLocalize"] = false,
                    ["Text"] = u90.MouseFrameData:map(function(p114) --[[ Line: 319 ]]
                        return string.format("%d packets, %d bytes", #p114.Packets, p114.TotalSize)
                    end),
                    ["TextColor3"] = p102:GetColor("BrightText"),
                    ["TextXAlignment"] = Enum.TextXAlignment.Left,
                    ["TextYAlignment"] = Enum.TextYAlignment.Center,
                    ["Font"] = Enum.Font.SourceSans,
                    ["TextSize"] = 16,
                    ["Size"] = UDim2.fromOffset(200, 16),
                    ["BackgroundTransparency"] = 1
                }),
                ["KBSent"] = u8.createElement("TextLabel", {
                    ["AutoLocalize"] = false,
                    ["Text"] = u90.MouseFrameData:map(function(p115) --[[ Line: 332 ]]
                        return string.format("%.3f KB sent", p115.TotalSize / 1000)
                    end),
                    ["TextColor3"] = p102:GetColor("BrightText"),
                    ["TextXAlignment"] = Enum.TextXAlignment.Left,
                    ["TextYAlignment"] = Enum.TextYAlignment.Center,
                    ["Font"] = Enum.Font.SourceSans,
                    ["TextSize"] = 16,
                    ["Size"] = UDim2.fromOffset(200, 16),
                    ["BackgroundTransparency"] = 1
                })
            }
            return v103("Frame", v113, v116)
        end),
        ["EditModeNotifier"] = u10(function(p117) --[[ Line: 345 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u15
            --]]
            return u8.createElement("TextLabel", {
                ["AutoLocalize"] = false,
                ["Size"] = UDim2.fromScale(1, 1),
                ["Position"] = UDim2.fromScale(0.5, 0.5),
                ["AnchorPoint"] = Vector2.new(0.5, 0.5),
                ["BackgroundTransparency"] = 1,
                ["Text"] = "Start session to begin",
                ["TextColor3"] = p117:GetColor("WarningText"),
                ["TextSize"] = 20,
                ["Font"] = Enum.Font.SourceSans,
                ["TextXAlignment"] = Enum.TextXAlignment.Center,
                ["TextYAlignment"] = Enum.TextYAlignment.Center,
                ["Visible"] = u15
            })
        end)
    }
    return v93("Frame", v94, v118)
end
return u14