 

local u1 = game:GetService("UserInputService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
game:GetService("RunService")
local u4 = v3.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("BackpackGui", 360):WaitForChild("Backpack")
local u5 = false
local v6 = v2:WaitForChild("Modules")
local u7 = require(v6.Maid)
local u8 = {}
u8.__index = u8
function u8.new(p9) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u7
    --]]
    local v10 = u8
    local v11 = setmetatable({}, v10)
    v11.Object = p9
    v11.DragStarted = nil
    v11.DragEnded = nil
    v11.Dragged = nil
    v11.ObjectPressed = nil
    v11.Dragging = false
    v11.Maid = u7.new()
    return v11
end
function u8.Enable(u12) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u5
        [3] = u4
    --]]
    local u13 = u12.Object
    local u14 = nil
    local u15 = nil
    local u16 = nil
    local u17 = nil
    local u18 = false
    local u19 = false
    local u20 = nil
    local u21 = false
    local u22 = nil
    local u23 = nil
    local function u33(p24) --[[ Line: 52 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u1
            [3] = u13
            [4] = u16
            [5] = u17
            [6] = u22
            [7] = u23
        --]]
        local _ = p24.Position - u15
        local v25 = u1:GetMouseLocation()
        if u15.X == 0 and u15.Y == 0 then
            local v26 = v25.X
            local v27 = v25.Y
            u15 = Vector3.new(v26, v27, 0)
            local v28 = u13.AbsoluteSize / 2
            local _ = v28.X
            local v29 = v28.Y
            u13.Position = UDim2.fromOffset(v25.X, v25.Y + v29)
            u16 = u13.Position
        end
        local v30 = u17 - v25
        u13.Position = UDim2.new(0, u17.X - v30.X, 0, u17.Y - v30.Y)
        if u22 == nil then
            u22 = u13.AbsolutePosition
        end
        local v31 = u23 - u22
        local v32 = UDim2.new(0, u17.X - v30.X + v31.X, 0, u17.Y - v30.Y + v31.Y)
        u13.Position = v32
        return v32
    end
    u12.Maid:AddTask(u13.InputBegan:Connect(function(u34) --[[ Line: 84 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u18
            [4] = u17
            [5] = u1
            [6] = u23
            [7] = u13
            [8] = u20
            [9] = u19
            [10] = u12
            [11] = u21
            [12] = u15
            [13] = u16
            [14] = u22
        --]]
        if (u34.UserInputType == Enum.UserInputType.MouseButton1 or u34.UserInputType == Enum.UserInputType.Touch) and not u5 then
            if u4.Visible == true then
                u5 = true
                u18 = true
            end
            u17 = u1:GetMouseLocation()
            u23 = u13.AbsolutePosition
            u20 = u34
            u19 = true
            local u35 = nil
            u35 = u34.Changed:Connect(function() --[[ Line: 100 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u35
                    [3] = u1
                    [4] = u17
                    [5] = u19
                    [6] = u12
                    [7] = u18
                    [8] = u5
                    [9] = u21
                    [10] = u15
                    [11] = u16
                    [12] = u20
                    [13] = u23
                    [14] = u22
                --]]
                if u34.UserInputState == Enum.UserInputState.End then
                    if u35 then
                        u35:Disconnect()
                        u35 = nil
                    end
                    if u17 and u17 == u1:GetMouseLocation() then
                        u19 = false
                        if u12.ObjectPressed then
                            u12.ObjectPressed()
                        end
                    end
                    if u12.Dragging then
                        u12.Dragging = false
                        if u12.DragEnded and not u18 then
                            u12.DragEnded(u34)
                        end
                        u18 = false
                    elseif u19 == true then
                        u12.Dragging = false
                        if u12.ObjectPressed then
                            u12.ObjectPressed()
                        end
                        u19 = false
                    end
                    u12.Dragging = false
                    u5 = false
                    u18 = false
                    u21 = false
                    u17 = nil
                    u15 = nil
                    u16 = nil
                    u20 = nil
                    u23 = nil
                    u22 = nil
                end
            end)
        end
    end))
    u12.Maid:AddTask(u13.InputChanged:Connect(function(p36) --[[ Line: 156 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        if p36.UserInputType == Enum.UserInputType.MouseMovement or p36.UserInputType == Enum.UserInputType.Touch then
            u14 = p36
        end
    end))
    u12.Maid:AddTask(u13:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 162 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u1
            [3] = u15
            [4] = u16
        --]]
        if u13.Parent ~= nil and u13.Parent.Name == "BackpackGui" then
            local v37 = u1:GetMouseLocation()
            local v38 = v37.X
            local v39 = v37.Y
            u15 = Vector3.new(v38, v39, 0)
            u13.Position = UDim2.fromOffset(v37.X, v37.Y)
            u16 = u13.Position
        end
    end))
    u12.Maid:AddTask(u1.InputChanged:Connect(function(p40) --[[ Line: 172 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u12
            [3] = u18
            [4] = u15
            [5] = u16
            [6] = u14
            [7] = u1
            [8] = u17
            [9] = u21
            [10] = u19
            [11] = u33
        --]]
        if u13.Parent == nil then
            u12:Disable()
        else
            if u18 then
                u18 = false
                u15 = p40.Position
                u16 = u13.Position
                u12.Dragging = true
            end
            if p40 == u14 and u12.Dragging then
                if (u17 - u1:GetMouseLocation()).Magnitude > 0.2 then
                    u21 = true
                end
                if u21 then
                    if u19 == true then
                        if u12.DragStarted then
                            u12.DragStarted()
                        end
                        u15 = p40.Position
                        u16 = u13.Position
                    end
                    local v41 = u33(p40)
                    u19 = false
                    if u12.Dragged then
                        u12.Dragged(v41)
                    end
                end
            end
        end
    end))
end
function u8.Disable(p42) --[[ Line: 221 ]]
    p42.Maid:Clean()
    if p42.Dragging then
        p42.Dragging = false
        if p42.DragEnded then
            p42.DragEnded()
        end
    end
end
function u8.Destroy(p43) --[[ Line: 234 ]]
    p43:Disable()
    setmetatable(p43, nil)
end
return u8