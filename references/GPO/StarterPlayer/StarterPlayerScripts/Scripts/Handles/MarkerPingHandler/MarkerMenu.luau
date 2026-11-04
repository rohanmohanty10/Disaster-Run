 

local v1 = game:GetService("Players").LocalPlayer
local u2 = v1:GetMouse()
local v3 = v1.PlayerGui
if v3:FindFirstChild("MarkerMenu") == nil then
    script.MarkerMenu:Clone().Parent = v3
    script.IndicatorGui:Clone().Parent = v3
end
local u4 = v3:WaitForChild("MarkerMenu")
local u5 = u4:WaitForChild("MouseFollower")
local u6 = {}
u6.__index = u6
function u6.new() --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v7 = u6
    local v8 = setmetatable({}, v7)
    v8.Radius = 75
    v8.Options = v8:_createOptions()
    return v8
end
function u6._scaleUI(_, u9) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local u10 = u4.Main
    local function v16() --[[ Line: 32 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u9
        --]]
        local v11 = u10.AbsoluteSize.X / 2
        for _, v12 in u9 do
            local v13 = v12:GetAttribute("Angle")
            if v12.Name == "Divider" then
                local v14 = v11 / 2
                v12.Size = UDim2.fromOffset(1, v14 * 2)
                v12.Position = UDim2.new(0.5, math.cos(v13) * v14, 0.5, math.sin(v13) * v14)
            else
                local v15 = v11 * 0.75
                v12.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromOffset(math.cos(v13) * v15, math.sin(v13) * v15)
            end
        end
    end
    v16()
    u10:GetPropertyChangedSignal("AbsoluteSize"):Connect(v16)
end
function u6._createOptions(p17) --[[ Line: 55 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v18 = {
        "On my way!",
        "Help",
        "Question",
        "Danger"
    }
    local v19 = {}
    for v20, v21 in v18 do
        local v22 = (v20 - 1) / #v18 * 6.283185307179586 + 3.141592653589793 / #v18
        local v23 = script[v21]:Clone()
        v23.AnchorPoint = Vector2.new(0.5, 0.5)
        v23:SetAttribute("Angle", v22)
        v23.Parent = u4.Main
        local v24 = script.Divider:Clone()
        local v25 = v22 - 3.141592653589793 / #v18
        local v26 = v25 + 1.5707963267948966
        v24.Rotation = math.deg(v26)
        v24:SetAttribute("Angle", v25)
        v24.Parent = u4.Main
        table.insert(v19, v24)
        table.insert(v19, v23)
    end
    p17:_scaleUI(v19)
    return v18
end
function u6._updateSelection(p27, p28) --[[ Line: 82 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if p27.Options[p28] then
        p27.Selected = p27.Options[p28]
    else
        p27.Selected = "Ping"
    end
    u4.Main.Center.TextLabel.Text = p27.Selected
end
function u6._updateMouseFollower(_, p29, p30) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u4
    --]]
    Vector2.new(u2.X, u2.Y)
    local v31 = p30.Magnitude / 2
    u5.Size = UDim2.fromOffset(1, p30.Magnitude)
    u5.Position = u4.Main.Position + UDim2.fromOffset(math.cos(p29) * v31, math.sin(p29) * v31)
    local v32 = u5
    local v33 = p29 + 1.5707963267948966
    v32.Rotation = math.deg(v33)
end
function u6.Choose(u34) --[[ Line: 101 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    u4.Enabled = true
    local u35 = Vector2.new(u2.X, u2.Y)
    u34.MousePosition = u35
    u4.Main.Position = UDim2.fromOffset(u35.X, u35.Y)
    u34.Selecting = task.spawn(function() --[[ Line: 109 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u35
            [3] = u34
            [4] = u4
        --]]
        while true do
            local v36 = u35 - Vector2.new(u2.X, u2.Y)
            local v37 = v36.Y
            local v38 = v36.X
            local v39 = math.atan2(v37, v38) + 3.141592653589793
            local v40 = v39 / (6.283185307179586 / #u34.Options)
            local v41 = math.ceil(v40)
            u34:_updateMouseFollower(v39, v36)
            if v36.Magnitude >= u4.Main.Center.AbsoluteSize.X / 2 then
                u34:_updateSelection(v41)
            else
                u34:_updateSelection(5)
            end
            task.wait()
        end
    end)
end
function u6.Select(p42) --[[ Line: 128 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    u4.Enabled = false
    if p42.Selecting then
        task.cancel(p42.Selecting)
        p42.Selecting = nil
    end
end
return u6