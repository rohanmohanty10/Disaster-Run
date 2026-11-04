 

local v1 = nil
if game.Players.LocalPlayer then
    v1 = game.Players.LocalPlayer:WaitForChild("PlayerGui")
elseif pcall(function() --[[ Line: 44 ]]
    PluginManager():CreatePlugin()
end) then
    v1 = game.CoreGui
end
local u2 = {}
local u3 = CFrame.new
local u4 = CFrame.Angles
local u5 = Ray.new
local v6 = Instance.new
local u7 = UDim2.new
local u8 = Enum.NormalId
local u9 = Enum.UserInputType
local u10 = true
local u11, u12
if v1 then
    u11 = v6("ScreenGui")
    u11.Name = "MouseModuleIconFrameHolder"
    u11.Parent = v1
    local u13 = v6("ImageLabel")
    u13.Name = "MouseModuleIcon"
    u13.Size = u7(0, 100, 0, 100)
    u13.BackgroundTransparency = 1
    u13.Image = ""
    u13.Parent = u11
    spawn(function() --[[ Line: 69 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u13
            [3] = u2
        --]]
        while u10 == true do
            u13.Image = u2.Icon or ""
            task.wait()
        end
    end)
    u12 = u13
else
    u11 = nil
    u12 = nil
end
local u14 = v6("BindableEvent")
local u15 = v6("BindableEvent")
local u16 = v6("BindableEvent")
local u17 = v6("BindableEvent")
local u18 = v6("BindableEvent")
local u19 = v6("BindableEvent")
local u20 = v6("BindableEvent")
local u21 = v6("BindableEvent")
u2.X = 0
u2.Y = 0
u2.Hit = u3()
u2.Icon = ""
u2.Button1Down = u14.Event
u2.Button1Up = u15.Event
u2.Button2Down = u16.Event
u2.Button2Up = u17.Event
u2.WheelForward = u18.Event
u2.WheelBackward = u19.Event
u2.Idle = u20.Event
u2.Move = u21.Event
local u22 = game.Workspace.CurrentCamera
while not u22 do
    task.wait()
    u22 = game.Workspace.CurrentCamera
end
local v23 = game:GetService("UserInputService")
local function u38(p24, p25) --[[ Line: 101 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local _, _, _, v26, v27, v28, v29, v30, v31, v32, v33, v34 = p24:components()
    local v35 = p25.X
    local v36 = p25.Y
    local v37 = p25.Z
    if v35 == v27 and (v36 == v30 and v37 == v33) then
        return u8.Top
    end
    if v35 == v26 and (v36 == v29 and v37 == v32) then
        return u8.Right
    end
    if v35 == v28 and (v36 == v31 and v37 == v34) then
        return u8.Back
    end
    if v35 == -v27 and (v36 == -v30 and v37 == -v33) then
        return u8.Bottom
    end
    if v35 == -v26 and (v36 == -v29 and v37 == -v32) then
        return u8.Left
    end
    if v35 == -v28 and (v36 == -v31 and v37 == -v34) then
        return u8.Front
    end
end
local function u50() --[[ Line: 125 ]]
    --[[
    Upvalues:
        [1] = u22
        [2] = u2
        [3] = u5
        [4] = u38
        [5] = u3
        [6] = u4
    --]]
    local v39 = u22:ScreenPointToRay(u2.X, u2.Y, 999)
    local v40 = v39.Origin + v39.Direction
    local v41 = u5(u22.CoordinateFrame.p, v40 - u22.CoordinateFrame.p)
    local v42 = u2.TargetFilter
    local v43, v44, v45
    if type(v42) == "table" then
        v43, v44, v45 = _G.raycastIgnoreList(v41, u2.TargetFilter)
    else
        v43, v44, v45 = game.Workspace:FindPartOnRay(v41, u2.TargetFilter)
    end
    u2.Target = v43
    if v43 then
        u2.TargetSurface = u38(v43.CFrame, v45)
    else
        u2.TargetSurface = nil
    end
    local v46 = u22.CoordinateFrame.p
    u2.Origin = CFrame.new(v46, v41.Origin + v41.Direction)
    u2.Hit = u3(v44, v46) * u4(0, 3.141592653589793, 0)
    local v47 = u2
    local v48 = u22:ScreenPointToRay(u2.X, u2.Y, 1)
    local v49 = v48.Origin + v48.Direction
    v47.UnitRay = u5(u22.CoordinateFrame.p, v49 - u22.CoordinateFrame.p)
    u2.ViewSizeX = u22.ViewportSize.X
    u2.ViewSizeY = u22.ViewportSize.Y
end
local function u56(p51) --[[ Line: 147 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u12
        [3] = u7
        [4] = u9
        [5] = u18
        [6] = u19
        [7] = u50
    --]]
    local v52 = u2
    local v53 = u2
    local v54 = p51.Position.X
    local v55 = p51.Position.Y
    v52.X = v54
    v53.Y = v55
    u12.Position = u7(0, u2.X - 50, 0, u2.Y - 50)
    if p51.UserInputType == u9.MouseWheel then
        if p51.Position.Z == 1 then
            u18:Fire()
        elseif p51.Position.Z == -1 then
            u19:Fire()
        end
    end
    u50()
end
local u58 = v23.InputBegan:Connect(function(p57) --[[ Name: OnKeyBegin, Line 161 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u14
        [3] = u16
        [4] = u21
        [5] = u56
    --]]
    if p57.UserInputType == u9.MouseButton1 then
        u14:Fire()
    elseif p57.UserInputType == u9.MouseButton2 then
        u16:Fire()
    elseif p57.UserInputType == Enum.UserInputType.MouseMovement then
        u21:Fire()
    elseif p57.UserInputType == Enum.UserInputType.Touch then
        u14:Fire()
    end
    u56(p57)
end)
local u59 = v23.InputChanged:Connect(u56)
local u61 = v23.InputEnded:Connect(function(p60) --[[ Name: OnKeyEnd, Line 174 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u15
        [3] = u17
        [4] = u20
        [5] = u56
    --]]
    if p60.UserInputType == u9.MouseButton1 then
        u15:Fire()
    elseif p60.UserInputType == u9.MouseButton2 then
        u17:Fire()
    elseif p60.UserInputType == Enum.UserInputType.MouseMovement then
        u20:Fire()
    elseif p60.UserInputType == Enum.UserInputType.Touch then
        u15:Fire()
    end
    u56(p60)
end)
function u2.Disconnect(_) --[[ Line: 191 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u58
        [3] = u59
        [4] = u61
        [5] = u11
    --]]
    u10 = false
    if u58 then
        u58:disconnect()
    end
    if u59 then
        u59:disconnect()
    end
    if u61 then
        u61:disconnect()
    end
    if u11 then
        u11:Destroy()
    end
end
return u2