 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local u3 = game:GetService("Players")
local v4 = script.Parent.Parent.Modules
local u5 = require(v4.Packages)
local u6 = require(u5.Directory.Roact)
local v7 = u6.Component:extend("PacketCircleArcs")
local function u23(u8) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local u9 = u8.Data.EndPercent
    local u10 = u8.Data.StartPercent
    local u11 = u8.Data.VisiblePercent
    local v12 = u6.createElement
    local v14 = {
        ["BackgroundTransparency"] = 1,
        ["Image"] = "rbxassetid://3587367081",
        ["ImageColor3"] = u8.Highlighted:map(function(p13) --[[ Line: 25 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u9
                [3] = u8
            --]]
            if u10 <= p13 and p13 < u9 then
                return u8.Data.Color:Lerp(Color3.new(1, 1, 1), 0.5)
            else
                return u8.Data.Color
            end
        end),
        ["Size"] = UDim2.fromScale(2, 1),
        ["Position"] = UDim2.fromScale(u8.Side == "Left" and 0 or -1, 0),
        ["ZIndex"] = u8.ZIndex
    }
    local v22 = {
        ["UIGradient"] = u6.createElement("UIGradient", {
            ["Rotation"] = u8.AnimationAlpha:map(function(p15) --[[ Line: 37 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u11
                --]]
                if u8.Side == "Left" then
                    local v16 = u11
                    local v17 = p15 * 2
                    local v18 = math.clamp(v17, 0, 1)
                    return -3.6 * (0 + (v16 - 0) * v18) + 180
                else
                    local v19 = u11 - 50
                    local v20 = p15 * 2 - 1
                    local v21 = math.clamp(v20, 0, 1)
                    return (0 + -180 * ((0 + (v19 - 0) * v21) / 100)) * 2
                end
            end),
            ["Transparency"] = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(u8.Side == "Left" and 0.498 or 0.5, 0),
                NumberSequenceKeypoint.new(u8.Side == "Left" and 0.499 or 0.501, 1),
                NumberSequenceKeypoint.new(1, 1)
            })
        })
    }
    return v12("ImageLabel", v14, v22)
end
function v7.init(u24) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u5
        [3] = u3
        [4] = u1
        [5] = u2
    --]]
    local v25, v26 = u6.createBinding(0)
    u24.AnimationAlpha = v25
    u24.SetAnimationAlpha = v26
    local v27, v28 = u6.createBinding(0)
    u24.ActualAlpha = v27
    u24.SetActualAlpha = v28
    local v29, v30 = u6.createBinding(Vector2.zero)
    u24.MousePosition = v29
    u24.SetMousePosition = v30
    local v31, v32 = u6.createBinding(-1)
    u24.HighlightedPercent = v31
    u24.SetHighlightedPercent = v32
    local v33, v34 = u6.createBinding(UDim2.fromOffset(0, 0))
    u24.DebugMousePos = v33
    u24.SetDebugMousePos = v34
    local v35, v36 = u6.createBinding(false)
    u24.ShowDebug = v35
    u24.SetShowDebug = v36
    local u37 = u5.IsPlugin and u24.props.PluginMouse or u3.LocalPlayer:GetMouse()
    u1.RenderStepped:Connect(function(p38) --[[ Line: 68 ]]
        --[[
        Upvalues:
            [1] = u37
            [2] = u24
            [3] = u2
        --]]
        local v39 = Vector2.new(u37.X, u37.Y)
        u24.SetMousePosition(v39)
        local v40 = u24.ActualAlpha:getValue()
        u24.SetAnimationAlpha(u2:GetValue(v40, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
        local v41 = u24.SetActualAlpha
        local v42 = v40 + p38 * 2
        v41((math.clamp(v42, 0, 1)))
    end)
end
function v7.render(u43) --[[ Line: 79 ]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u6
    --]]
    u43.SetActualAlpha(0)
    local v44 = #u43.props.Arcs
    local v45 = 0
    local u46 = {}
    local v47 = {
        ["Left"] = {},
        ["Right"] = {}
    }
    for v48, v49 in u43.props.Arcs do
        local v50 = v44 - v48 + 2
        local v51 = v45 + v49.Percent
        local v52 = math.min(v51, 100)
        if v45 > 100 then
            break
        end
        u46[v48] = {
            ["StartPercent"] = v45,
            ["EndPercent"] = v52,
            ["Color"] = v49.Color,
            ["Name"] = v49.Name
        }
        if v52 > 50 and v45 <= 50 then
            v47.Left[v48] = u23({
                ["ZIndex"] = v50,
                ["Data"] = {
                    ["StartPercent"] = v45,
                    ["EndPercent"] = v52,
                    ["VisiblePercent"] = 50,
                    ["Color"] = v49.Color
                },
                ["Side"] = "Left",
                ["AnimationAlpha"] = u43.AnimationAlpha,
                ["Highlighted"] = u43.HighlightedPercent
            })
        end
        local v53 = v52 > 50 and "Right" or "Left"
        v47[v53][v48] = u23({
            ["ZIndex"] = v50,
            ["Data"] = {
                ["StartPercent"] = v45,
                ["EndPercent"] = v52,
                ["VisiblePercent"] = v52,
                ["Color"] = v49.Color
            },
            ["Side"] = v53,
            ["AnimationAlpha"] = u43.AnimationAlpha,
            ["Highlighted"] = u43.HighlightedPercent
        })
        v45 = v45 + v49.Percent
    end
    return u6.createElement("Frame", {
        ["BackgroundTransparency"] = 1,
        ["Size"] = UDim2.new(1, -8, 1, -8),
        ["Position"] = UDim2.fromScale(0.5, 0.5),
        ["AnchorPoint"] = Vector2.new(0.5, 0.5),
        [u6.Event.MouseEnter] = function(_, _, _) --[[ Line: 143 ]]
            --[[
            Upvalues:
                [1] = u43
            --]]
            u43.MouseOver = true
            u43.SetShowDebug(true)
        end,
        [u6.Event.MouseLeave] = function() --[[ Line: 147 ]]
            --[[
            Upvalues:
                [1] = u43
            --]]
            u43.MouseOver = false
            u43.SetHighlightedPercent(-1)
            u43.SetShowDebug(false)
        end,
        [u6.Event.MouseMoved] = function(p54, p55, p56) --[[ Line: 152 ]]
            --[[
            Upvalues:
                [1] = u43
            --]]
            if u43.MouseOver then
                local v57 = Vector2.new(p55, p56)
                local v58 = p54.AbsolutePosition + p54.AbsoluteSize / 2
                u43.SetDebugMousePos(UDim2.fromOffset(p55 - 1, p56 - 1))
                local v59 = v57.Y - v58.Y
                local v60 = -(v57.X - v58.X)
                local v61 = math.atan2(v59, v60)
                local v62 = math.deg(v61) + 90
                if v62 < 0 then
                    v62 = v62 + 360
                end
                local v63 = v62 / 360 * 100
                u43.SetHighlightedPercent(v63)
            end
        end,
        [u6.Event.InputEnded] = function(_, p64) --[[ Line: 168 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u46
            --]]
            if p64.UserInputType ~= Enum.UserInputType.MouseButton1 then
                return
            end
            local v65 = u43.HighlightedPercent:getValue()
            if v65 == -1 then
                return
            end
            for _, v66 in u46 do
                if v66.StartPercent <= v65 and v65 < v66.EndPercent then
                    if u43.props.OnArcClicked then
                        u43.props.OnArcClicked(v66.Name)
                    end
                    break
                end
            end
            u43.SetHighlightedPercent(-1)
        end
    }, {
        ["Left"] = u6.createElement("Frame", {
            ["BackgroundTransparency"] = 1,
            ["ClipsDescendants"] = true,
            ["Size"] = UDim2.fromScale(0.5, 1)
        }, {
            ["Arcs"] = u6.createFragment(v47.Left)
        }),
        ["Right"] = u6.createElement("Frame", {
            ["AnchorPoint"] = Vector2.new(1, 0),
            ["BackgroundTransparency"] = 1,
            ["ClipsDescendants"] = true,
            ["Position"] = UDim2.fromScale(1, 0),
            ["Size"] = UDim2.fromScale(0.5, 1)
        }, {
            ["Arcs"] = u6.createFragment(v47.Right)
        })
    })
end
return v7