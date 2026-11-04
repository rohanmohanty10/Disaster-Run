 

local v1 = game:GetService("RunService")
local u2 = game:GetService("UserInputService")
local v3 = game:GetService("ContextActionService")
if not v1:IsClient() then
    error("SmoothScroll can only be used on the client")
end
local u4 = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local u5 = game.Players.LocalPlayer:GetMouse()
local _ = ipairs
local _ = pairs
task.wait()
local u6 = u5.ViewSizeY / 27
local u7 = {}
local u8 = false
local u9
if u2.TouchEnabled then
    u9 = nil
else
    u9 = Instance.new("ScreenGui")
    u9.Name = "SmoothScroll"
    u9.Parent = u4
    v1.Heartbeat:Connect(function() --[[ Line: 33 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        for v10, v11 in u7 do
            if v11.Velocity > 0.05 or v11.Velocity < -0.05 then
                v11.Velocity = v11.Velocity * v11.Frict
                if v11.Axis == "X" then
                    v10.CanvasPosition = Vector2.new(v10.CanvasPosition.X + v11.Velocity, v10.CanvasPosition.Y)
                    local v12 = v11.LastPos - v10.CanvasPosition.X
                    if math.abs(v12) == 0 then
                        v11.Velocity = 0
                    end
                    v11.LastPos = v10.CanvasPosition.X
                else
                    v10.CanvasPosition = Vector2.new(v10.CanvasPosition.X, v10.CanvasPosition.Y + v11.Velocity)
                    local v13 = v11.LastPos - v10.CanvasPosition.Y
                    if math.abs(v13) == 0 then
                        v11.Velocity = 0
                    end
                    v11.LastPos = v10.CanvasPosition.Y
                end
            end
        end
    end)
    u2.PointerAction:Connect(function(_, p14, _, _) --[[ Line: 59 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u4
            [3] = u5
            [4] = u7
        --]]
        if not u8 then
            for _, v15 in u4:GetGuiObjectsAtPosition(u5.X, u5.Y) do
                local v16 = u7[v15]
                if v16 and v16.Visibility.Visible == true then
                    v16.Velocity = v16.Velocity - v16.Sens * p14.Y * (v16.Inverted and -1 or 1)
                    return
                end
            end
        end
    end)
    v3:BindActionAtPriority("SmoothScroll", function(_, _, p17) --[[ Line: 74 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u4
            [3] = u5
            [4] = u7
        --]]
        if u8 then
            return Enum.ContextActionResult.Pass
        end
        local v18 = false
        for _, v19 in u4:GetGuiObjectsAtPosition(u5.X, u5.Y) do
            local v20 = u7[v19]
            if v20 and v20.Visibility.Visible == true then
                v20.Velocity = v20.Velocity - v20.Sens * p17.Position.Z * (v20.Inverted and -1 or 1)
                v18 = true
                break
            end
        end
        return v18 and Enum.ContextActionResult.Sink or Enum.ContextActionResult.Pass
    end, false, 8000, Enum.UserInputType.MouseWheel)
end
local u21 = {}
u21.__index = u21
function u21.new(u22) --[[ Line: 102 ]]
    --[[
    Upvalues:
        [1] = u21
    --]]
    local v23
    if typeof(u22) == "Instance" then
        v23 = u22:IsA("GuiObject")
    else
        v23 = false
    end
    assert(v23, "Argument #1 expected GuiObject")
    local u24 = Instance.new("BindableEvent")
    local v25 = {
        ["GuiObject"] = u22,
        ["Visible"] = nil,
        ["Changed"] = u24.Event,
        ["_path"] = {},
        ["_conn"] = {},
        ["_root"] = nil,
        ["_visibleChanged"] = u24
    }
    local v26 = u21
    local u27 = setmetatable(v25, v26)
    local function u30() --[[ Line: 117 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u24
        --]]
        local v28 = u27._root and u27._root.Enabled or false
        if v28 then
            for _, v29 in u27._path do
                if not v29.Visible then
                    v28 = false
                    break
                end
            end
        end
        if v28 ~= u27.Visible then
            u27.Visible = v28
            u24:Fire(v28)
        end
    end
    local function u36() --[[ Line: 134 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u22
            [3] = u30
        --]]
        for _, v31 in u27._conn do
            v31:Disconnect()
        end
        local v32 = u22
        local v33 = {}
        local v34 = {}
        local v35 = nil
        while v32 and (v32:IsA("GuiObject") or v32:IsA("Folder")) do
            if v32:IsA("GuiObject") then
                v33[#v33 + 1] = v32:GetPropertyChangedSignal("Visible"):Connect(u30)
                v34[#v34 + 1] = v32
            end
            v32 = v32.Parent
        end
        if v32 and v32:IsA("LayerCollector") then
            v33[#v33 + 1] = v32:GetPropertyChangedSignal("Enabled"):Connect(u30)
        else
            v32 = v35
        end
        u27._path = v34
        u27._conn = v33
        u27._root = v32
        u30()
    end
    u27._ancestry = u22.AncestryChanged:Connect(function(_, _) --[[ Line: 157 ]]
        --[[
        Upvalues:
            [1] = u36
        --]]
        u36()
    end)
    u36()
    return u27
end
function u21.Destroy(p37) --[[ Line: 166 ]]
    p37._visibleChanged:Fire(false)
    p37._visibleChanged:Destroy()
    p37._ancestry:Disconnect()
    for _, v38 in p37._conn do
        v38:Disconnect()
    end
end
local function u62(u39, p40) --[[ Line: 174 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u8
        [3] = u5
        [4] = u2
        [5] = u9
    --]]
    local u41 = p40 or "Y"
    if u39 and (typeof(u39) == "Instance" and u39.ClassName == "ScrollingFrame") then
        local u42 = Instance.new("TextButton")
        u42.Name = u39.Name .. "_Scroller_" .. u41
        u42.Text = ""
        u42.BackgroundTransparency = 1
        u42.Visible = u7[u39].Visibility.Visible
        local u43 = u39.AbsoluteSize
        local u44 = u39.AbsolutePosition
        local u45 = u39.ScrollBarThickness
        local u46 = nil
        u42.MouseButton1Click:Connect(function() --[[ Line: 194 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u46
                [3] = u5
                [4] = u2
                [5] = u41
                [6] = u39
            --]]
            if not (u8 or u46) then
                u8 = true
                local u47 = Vector2.new(u5.X, u5.Y)
                u46 = u2.InputChanged:Connect(function(p48) --[[ Line: 199 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u41
                        [3] = u39
                    --]]
                    if p48.UserInputType == Enum.UserInputType.MouseMovement then
                        local v49 = Vector2.new(p48.Position.X, p48.Position.Y)
                        local v50 = v49 - u47
                        local v51 = (u41 == "Y" and v50.Y or v50.X) / (u41 == "Y" and u39.AbsoluteWindowSize.Y or u39.AbsoluteWindowSize.X)
                        local v52 = u39:FindFirstAncestorWhichIsA("GuiBase2d")
                        local v53 = Vector2.new(u39.CanvasSize.X.Scale * v52.AbsoluteSize.X + u39.CanvasSize.X.Offset, u39.CanvasSize.Y.Scale * v52.AbsoluteSize.Y + u39.CanvasSize.Y.Offset)
                        u39.CanvasPosition = Vector2.new(u39.CanvasPosition.X + (u41 == "X" and (v53.X * v51 or 0) or 0), u39.CanvasPosition.Y + (u41 == "Y" and (v53.Y * v51 or 0) or 0))
                        u47 = v49
                    end
                end)
            end
        end)
        local u55 = u2.InputEnded:Connect(function(p54) --[[ Line: 220 ]]
            --[[
            Upvalues:
                [1] = u46
                [2] = u8
            --]]
            if p54.UserInputType == Enum.UserInputType.MouseButton1 and u46 then
                u8 = false
                u46:Disconnect()
                u46 = nil
            end
        end)
        u7[u39].Visibility.Changed:Connect(function(p56) --[[ Line: 228 ]]
            --[[
            Upvalues:
                [1] = u42
                [2] = u46
                [3] = u8
            --]]
            u42.Visible = p56
            if not p56 and u46 then
                u8 = false
                u46:Disconnect()
                u46 = nil
            end
        end)
        if u41 == "X" then
            u42.Size = UDim2.new(0, u43.X, 0, u45)
            u42.Position = UDim2.new(0, u44.X, 0, u44.Y + u43.Y - u45)
        else
            u42.Size = UDim2.new(0, u45, 0, u43.Y)
            u42.Position = UDim2.new(0, u39.VerticalScrollBarPosition == Enum.VerticalScrollBarPosition.Right and u44.X + u43.X - u45 or u44.X, 0, u44.Y)
        end
        local u57 = nil
        u57 = u39.Changed:Connect(function(p58) --[[ Line: 255 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u39
                [3] = u43
                [4] = u44
                [5] = u45
                [6] = u41
                [7] = u42
                [8] = u57
                [9] = u55
                [10] = u46
            --]]
            if u7[u39] then
                if u39:FindFirstAncestorWhichIsA("GuiBase2d") and (p58 == "AbsoluteSize" or (p58 == "AbsolutePosition" or (p58 == "AbsolutePosition" or (p58 == "CanvasSize" or p58 == "ScrollBarThickness")))) then
                    local v59 = u39.AbsoluteSize
                    local v60 = u39.AbsolutePosition
                    local v61 = u39.ScrollBarThickness
                    u43 = v59
                    u44 = v60
                    u45 = v61
                    if u41 == "X" then
                        u42.Size = UDim2.new(0, u43.X, 0, u45)
                        u42.Position = UDim2.new(0, u44.X, 0, u44.Y + u43.Y - u45)
                    else
                        u42.Size = UDim2.new(0, u45, 0, u43.Y)
                        u42.Position = UDim2.new(0, u39.VerticalScrollBarPosition == Enum.VerticalScrollBarPosition.Right and u44.X + u43.X - u45 or u44.X, 0, u44.Y)
                    end
                end
            else
                u42:Destroy()
                u57:Disconnect()
                u55:Disconnect()
                if u46 then
                    u46:Disconnect()
                    u46 = nil
                end
            end
        end)
        u42.Parent = u9
    else
        warn("Invalid frame to create custom bar")
    end
end
return {
    ["Enable"] = function(u63, p64, p65, p66, p67) --[[ Name: Enable, Line 309 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u7
            [3] = u21
            [4] = u6
            [5] = u62
        --]]
        if u2.TouchEnabled then
            warn("SmoothScroll only works for PC")
            return
        elseif u63 and (typeof(u63) == "Instance" and u63.ClassName == "ScrollingFrame") then
            if u7[u63] then
                local v68 = u7[u63]
                local v69 = type(p64) == "number" and p64 or u6
                v68.Sens = math.clamp(v69, 0.01, 1e17)
                local v70 = u7[u63]
                local v71 = type(p65) == "number" and (p65 or 0.78) or 0.78
                v70.Frict = math.clamp(v71, 0.2, 0.99)
                u7[u63].Inverted = p66
            else
                u63.ScrollingEnabled = false
                local v72 = {}
                local v73 = {}
                for _, u74 in u63:GetDescendants() do
                    if u74:IsA("GuiObject") then
                        v72[u74] = u74.Active
                        u74.Active = false
                        v73[#v73 + 1] = u74:GetPropertyChangedSignal("Active"):Connect(function() --[[ Line: 327 ]]
                            --[[
                            Upvalues:
                                [1] = u74
                            --]]
                            u74.Active = false
                        end)
                    end
                end
                local u75 = u63
                while u63 and (u63:IsA("GuiObject") or u63:IsA("Folder")) do
                    if u63:IsA("GuiObject") then
                        v72[u63] = u63.Active
                        u63.Active = false
                        v73[#v73 + 1] = u63:GetPropertyChangedSignal("Active"):Connect(function() --[[ Line: 338 ]]
                            --[[
                            Upvalues:
                                [1] = u63
                            --]]
                            u63.Active = false
                        end)
                    end
                    local v76 = u63.Parent
                    u63 = v76
                end
                v73[#v73 + 1] = u75.DescendantAdded:Connect(function(u77) --[[ Line: 345 ]]
                    --[[
                    Upvalues:
                        [1] = u7
                        [2] = u75
                    --]]
                    if u77:IsA("GuiObject") then
                        u7[u75].Actives[u77] = u77.Active
                        u77.Active = false
                        u7[u75].Connections[#u7[u75].Connections + 1] = u77:GetPropertyChangedSignal("Active"):Connect(function() --[[ Line: 349 ]]
                            --[[
                            Upvalues:
                                [1] = u77
                            --]]
                            u77.Active = false
                        end)
                    end
                end)
                local v78 = (not p67 or p67 ~= "X" and p67 ~= "Y") and ((u75.CanvasSize.Y.Offset > 0 or u75.CanvasSize.Y.Scale > 0) and "Y" or ((u75.CanvasSize.X.Offset > 0 or u75.CanvasSize.X.Scale > 0) and "X" or "Y")) or p67
                local v79 = u7
                local v80 = {
                    ["Connections"] = v73,
                    ["Actives"] = v72,
                    ["Velocity"] = 0,
                    ["LastPos"] = 0,
                    ["Visibility"] = u21.new(u75),
                    ["Inverted"] = p66,
                    ["Axis"] = v78
                }
                local v81 = type(p65) == "number" and p65 and p65 or 0.78
                v80.Frict = math.clamp(v81, 0.2, 0.99)
                local v82 = type(p64) == "number" and p64 and p64 or u6
                v80.Sens = math.clamp(v82, 0.01, 1e17)
                v79[u75] = v80
                u62(u75, "X")
                u62(u75, "Y")
            end
        else
            warn("Invalid frame to smooth")
            return
        end
    end,
    ["Disable"] = function(p83) --[[ Name: Disable, Line 402 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        if u7[p83] then
            p83.ScrollingEnabled = true
            for _, v84 in u7[p83].Connections do
                v84:Disconnect()
            end
            u7[p83].Visibility:Destroy()
            for v85, v86 in u7[p83].Actives do
                v85.Active = v86
            end
            u7[p83] = nil
        end
    end
}