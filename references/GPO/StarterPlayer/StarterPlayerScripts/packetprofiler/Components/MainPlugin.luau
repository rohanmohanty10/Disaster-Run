 

local u1 = game:GetService("UserInputService")
local v2 = script.Parent.Parent
local u3 = v2:FindFirstAncestorOfClass("Plugin")
local u4 = v2.Components
local v5 = v2.Modules
local u6 = require(v5.Packages)
local u7 = require(u6.Directory.Roact)
local u8 = require(u6.Directory.Signal)
u7.setGlobalConfig({
    ["elementTracing"] = true
})
local v9 = u7.Component:extend("MainPlugin")
function v9.init(u10) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u3
        [3] = u6
    --]]
    u10.OnPacketProfilerEnabled = u8.new()
    local v11
    if u3 then
        v11 = u3:GetSetting("PacketChartEnabled") == true
    else
        v11 = false
    end
    u10.IsPacketChartEnabled = v11
    u10.OnPacketChartEnabled = u8.new()
    local v12 = {}
    local v13
    if u3 then
        v13 = u3:GetSetting("PacketProfilerEnabled") == true
    else
        v13 = false
    end
    v12.PacketProfilerEnabled = v13
    u10:setState(v12)
    if u6.IsPlugin then
        u10.props.PacketProfiler:SetActive(u10.state.PacketProfilerEnabled)
        u10.props.PacketChart:SetActive(u10.IsPacketChartEnabled)
    end
    u10.Connections = {}
    u10.Signals = {
        ["ProfilerFrameSelected"] = u8.new(),
        ["ProfilerPaused"] = u8.new()
    }
    function u10.OnPacketProfilerClicked() --[[ Line: 38 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u3
        --]]
        local v14 = not u10.state.PacketProfilerEnabled
        u10.OnPacketProfilerEnabled:Fire(v14)
        u10:setState({
            ["PacketProfilerEnabled"] = v14
        })
        if u3 then
            u3:SetSetting("PacketProfilerEnabled", v14)
        end
    end
    function u10.OnPacketChartClicked(p15) --[[ Line: 49 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u3
        --]]
        local v16 = p15 or not u10.IsPacketChartEnabled
        u10.IsPacketChartEnabled = v16
        u10.OnPacketChartEnabled:Fire(v16)
        if u3 then
            u3:SetSetting("PacketChartEnabled", v16)
        end
    end
end
function v9.didMount(u17) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    if u6.IsPlugin then
        local v18 = u17.Connections
        local v19 = u17.props.PacketProfiler.Click
        local v20 = u17.OnPacketProfilerClicked
        table.insert(v18, v19:Connect(v20))
        local v21 = u17.Connections
        local v22 = u17.props.PacketChart.Click
        local v23 = u17.OnPacketChartClicked
        table.insert(v21, v22:Connect(v23))
    else
        local v24 = u17.Connections
        local v25 = u1.InputBegan
        local function v27(p26) --[[ Line: 65 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u17
            --]]
            if u1:IsKeyDown(Enum.KeyCode.LeftControl) then
                if p26.KeyCode == Enum.KeyCode.F5 then
                    u17.OnPacketProfilerClicked()
                elseif p26.KeyCode == Enum.KeyCode.P then
                    u17.ProfilerPaused = not u17.ProfilerPaused
                    u17.Signals.ProfilerPaused:Fire(u17.ProfilerPaused)
                end
            else
                return
            end
        end
        table.insert(v24, v25:Connect(v27))
        local v28 = u17.Connections
        local v29 = u17.Signals.ProfilerFrameSelected
        table.insert(v28, v29:Connect(function(p30) --[[ Line: 78 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            if #p30.Packets == 0 then
                u17.OnPacketChartClicked(false)
            else
                u17.OnPacketChartClicked(true)
            end
        end))
    end
end
function v9.render(p31) --[[ Line: 88 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u4
        [3] = u3
    --]]
    local v32 = u7.createFragment
    local v33 = {}
    local v34
    if p31.state.PacketProfilerEnabled then
        v34 = u7.createElement(require(u4.PacketProfiler), {
            ["Enabled"] = true,
            ["OnEnabled"] = p31.OnPacketProfilerEnabled,
            ["Signals"] = p31.Signals
        }) or nil
    else
        v34 = nil
    end
    v33.PacketProfiler = v34
    v33.PacketChart = u7.createElement(require(u4.PacketChart), {
        ["Enabled"] = p31.IsPacketChartEnabled,
        ["OnEnabled"] = p31.OnPacketChartEnabled,
        ["Signals"] = p31.Signals,
        ["PluginMouse"] = u3 and u3:GetMouse() or nil
    })
    return v32(v33)
end
function v9.willUnmount(p35) --[[ Line: 104 ]]
    for _, v36 in p35.Connections do
        v36:Disconnect()
    end
    table.clear(p35.Connections)
end
return v9