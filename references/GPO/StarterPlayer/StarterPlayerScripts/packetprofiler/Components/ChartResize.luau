 

local u1 = game:GetService("RunService")
local u2 = game:GetService("UserInputService")
local u3 = game:GetService("GuiService")
local v4 = script.Parent.Parent.Modules
local u5 = require(v4.Packages)
local u6 = require(u5.Directory.Roact)
local u7 = u6.Component:extend("ChartResize")
function u7.init(u8) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u5
        [3] = u2
        [4] = u1
        [5] = u3
    --]]
    local v9, v10 = u6.createBinding(UDim2.fromOffset(650, 290))
    u8.Size = v9
    u8.SetSize = v10
    if not u5.IsPlugin then
        u8.Connections = {}
        local u11 = u2.MouseIcon
        local u12 = nil
        local u13 = false
        local u14 = false
        local u15 = {
            ["SizeWE"] = "rbxassetid://18699453492",
            ["SizeNS"] = "rbxassetid://18700045701",
            ["SizeAll"] = "rbxassetid://18700129047"
        }
        function u8.AddIcon(p16) --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u13
                [3] = u11
                [4] = u2
                [5] = u15
            --]]
            if not u14 and u13 ~= p16 then
                if u13 == false then
                    u11 = u2.MouseIcon
                end
                u13 = p16
                u2.MouseIcon = u15[p16]
            end
        end
        function u8.RemoveIcon() --[[ Line: 40 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u13
                [3] = u2
                [4] = u11
            --]]
            if not u14 and u13 then
                u13 = false
                u2.MouseIcon = u11
            end
        end
        function u8.SetSizeTarget(u17) --[[ Line: 50 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u1
                [3] = u3
                [4] = u2
                [5] = u13
            --]]
            if u17 then
                for _, v18 in u8.Connections do
                    v18:Disconnect()
                end
                table.clear(u8.Connections)
                local v19 = u8.Connections
                local v20 = u1.RenderStepped
                local function v29() --[[ Line: 60 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                        [2] = u2
                        [3] = u17
                        [4] = u8
                    --]]
                    local v21 = u3:GetGuiInset()
                    local v22 = u2:GetMouseLocation()
                    local v23 = u17.AbsolutePosition + v21
                    local v24 = u17.AbsoluteSize
                    local v25 = v23.Y + v24.Y + 8
                    local v26 = v23.X + v24.X
                    if (v22.X < v23.X - 8 or (v26 < v22.X or v22.Y < v23.Y)) and true or v25 < v22.Y then
                        u8.RemoveIcon()
                        return
                    else
                        local v27
                        if v22.Y > v25 - 8 then
                            v27 = v22.Y < v25 + 8
                        else
                            v27 = false
                        end
                        local v28
                        if v22.X < v23.X + 8 then
                            v28 = v22.X > v23.X - 8
                        else
                            v28 = false
                        end
                        if v27 or v28 then
                            u8.AddIcon(v27 and (v28 and "SizeAll" or "SizeNS") or "SizeWE")
                        else
                            u8.RemoveIcon()
                        end
                    end
                end
                table.insert(v19, v20:Connect(v29))
                local v30 = u8.Connections
                local v31 = u2.InputBegan
                local function v33(p32) --[[ Line: 87 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                        [2] = u8
                    --]]
                    if p32.UserInputType == Enum.UserInputType.MouseButton1 and u13 then
                        u8.StartResizing()
                    end
                end
                table.insert(v30, v31:Connect(v33))
                local v34 = u8.Connections
                local v35 = u2.InputEnded
                local function v37(p36) --[[ Line: 92 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                    --]]
                    if p36.UserInputType == Enum.UserInputType.MouseButton1 then
                        u8.StopResizing()
                    end
                end
                table.insert(v34, v35:Connect(v37))
            end
        end
        function u8.StartResizing() --[[ Line: 99 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u8
                [3] = u2
                [4] = u12
                [5] = u1
                [6] = u13
            --]]
            if not u14 then
                u14 = true
                local u38 = u8.Size:getValue()
                local v39 = u2:GetMouseLocation()
                local u40 = Vector2.new(v39.X, v39.Y)
                u12 = u1.RenderStepped:Connect(function() --[[ Line: 110 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u40
                        [3] = u13
                        [4] = u38
                        [5] = u8
                    --]]
                    local v41 = u2:GetMouseLocation() - u40
                    if u13 == "SizeNS" then
                        v41 = v41 * Vector2.new(0, 1)
                    elseif u13 == "SizeWE" then
                        v41 = v41 * Vector2.new(1, 0)
                    end
                    local v42 = UDim2.fromOffset
                    local v43 = u38.X.Offset - v41.X
                    local v44 = math.max(v43, 300)
                    local v45 = u38.Y.Offset + v41.Y
                    local v46 = v42(v44, (math.max(v45, 100)))
                    u8.SetSize(v46)
                end)
            end
        end
        function u8.StopResizing() --[[ Line: 126 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u8
                [3] = u12
            --]]
            if u14 then
                u14 = false
                u8.RemoveIcon()
                u12:Disconnect()
                u12 = nil
            end
        end
    end
end
function u7.render(p47) --[[ Line: 140 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    return u6.oneChild(p47.props[u6.Children])({
        ["UISize"] = p47.Size,
        ["StartResizing"] = p47.StartResizing,
        ["StopResizing"] = p47.StopResizing,
        ["AddIcon"] = p47.AddIcon,
        ["RemoveIcon"] = p47.RemoveIcon,
        ["SetSizeTarget"] = p47.SetSizeTarget
    })
end
function u7.willUnmount(p48) --[[ Line: 152 ]]
    if p48.StopResizing then
        p48.StopResizing()
    end
    if p48.Connections then
        for _, v49 in p48.Connections do
            v49:Disconnect()
        end
        table.clear(p48.Connections)
    end
end
return function(p50) --[[ Name: ChartResizeInit, Line 166 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
    --]]
    return u6.createElement(u7, {}, {
        ["PacketChart"] = p50
    })
end