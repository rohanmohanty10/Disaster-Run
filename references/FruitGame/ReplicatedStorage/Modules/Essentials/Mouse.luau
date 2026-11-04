 

game:GetService("RunService")
local u1 = game:GetService("UserInputService")
local u2 = workspace.CurrentCamera
local u3 = {}
local u4 = Instance.new("BindableEvent")
local u5 = Instance.new("BindableEvent")
u3.LeftClick = u4.Event
u3.RightClick = u5.Event
function u3.GetUnitRay() --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    return u2:ViewportPointToRay(u1:GetMouseLocation().X, u1:GetMouseLocation().Y)
end
function u3.Raycast(p6) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v7 = u3.GetUnitRay()
    return workspace:Raycast(v7.Origin, v7.Direction * 500, p6), v7
end
function u3.GetPosition(p8, p9) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v10, v11 = u3.Raycast(p8)
    if v10 then
        return v10.Position
    end
    if v11 then
        return v11.Origin + v11.Direction * (p9 or 500)
    end
end
function u3.GetTarget(p12) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v13, _ = u3.Raycast(p12)
    if v13 then
        v13 = v13.Instance
    end
    return v13
end
function u3._OnInput(p14) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    if p14.UserInputType == Enum.UserInputType.MouseButton1 then
        u4:Fire(p14.UserInputState)
    elseif p14.UserInputType == Enum.UserInputType.MouseButton2 then
        u5:Fire(p14.UserInputState)
    end
end
u1.InputBegan:Connect(u3._OnInput)
u1.InputEnded:Connect(u3._OnInput)
return u3