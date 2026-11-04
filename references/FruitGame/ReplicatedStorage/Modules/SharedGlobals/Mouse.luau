 

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
function u3.GetPosition(p8) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v9, v10 = u3.Raycast(p8)
    if v9 then
        return v9.Position
    end
    if v10 then
        return v10.Origin + v10.Direction * 500
    end
end
function u3.GetTarget(p11) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v12, _ = u3.Raycast(p11)
    if v12 then
        v12 = v12.Instance
    end
    return v12
end
function u3._OnInput(p13) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    if p13.UserInputType == Enum.UserInputType.MouseButton1 then
        u4:Fire(p13.UserInputState)
    elseif p13.UserInputType == Enum.UserInputType.MouseButton2 then
        u5:Fire(p13.UserInputState)
    end
end
u1.InputBegan:Connect(u3._OnInput)
u1.InputEnded:Connect(u3._OnInput)
return u3