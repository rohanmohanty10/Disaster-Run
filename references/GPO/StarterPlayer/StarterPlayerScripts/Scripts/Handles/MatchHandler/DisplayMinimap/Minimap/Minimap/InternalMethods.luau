 

local v1 = {}
local u2 = require(script.Parent:WaitForChild("Events"))
local u3 = script.Parent:WaitForChild("Configuration")
local u4 = {}
function v1.Initialise(p5, p6, p7, p8, p9, p10, p11, p12, p13) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if not p6 then
        UDim2.fromOffset(200, 200)
    end
    if not p7 then
        UDim2.new(0, 5, 1, -5)
    end
    local v14 = p8 or Vector2.new(0.5, 0.5)
    if not p9 then
        warn("MapCenterPoint not passed through, setting MapCenterPoint to 0, 0")
        p9 = Vector2.new(0, 0)
    end
    if not p11 then
        warn("OriginalSize not passed through, Map.AbsoluteSize will be used instead")
    end
    if not p10 then
        warn("PixelsPerStud not passed through, setting PixelsPerStud to 0.5")
        p10 = 0.5
    end
    local v15 = p12 or false
    local v16 = UDim2.new(0.5, 150, 0.5, 150)
    local v17 = UDim2.new(0.5, 0, 0.5, 0)
    local v18 = Instance.new("ScreenGui")
    local v19 = Instance.new("Frame")
    v18.ResetOnSpawn = false
    v18.ZIndexBehavior = Enum.ZIndexBehavior.Global
    v18.IgnoreGuiInset = true
    v19.Size = v16
    v19.Position = v17
    v19.AnchorPoint = v14
    v19.ClipsDescendants = true
    v19.BackgroundTransparency = 1
    v19.SizeConstraint = Enum.SizeConstraint.RelativeYY
    if p13 then
        for v20, v21 in pairs(p13) do
            v19[tostring(v20)] = v21
        end
    end
    v18.Enabled = v15
    v18.Name = "Map"
    v18.Parent = game.Players.LocalPlayer.PlayerGui
    v19.Parent = v18
    p5.MapCenterPoint = p9
    p5.OriginalSizeX = p11[1] or false
    p5.OriginalSizeY = p11[2] or false
    if type(p10) == "table" then
        p5.PixelsPerStudX = p10[1]
        p5.PixelsPerStudY = p10[2]
    else
        p5.PixelsPerStudX = p10
        p5.PixelsPerStudY = p10
    end
    p5.ScreenGui = v18
    p5.Frame = v19
    p5.CurrentFrame = v19
    p5.Blips = {}
    p5.ActiveBlips = {}
    p5.ActiveOrientationBlips = {}
    p5.MainPartChanged = newproxy(false)
    p5.MainBlipChanged = newproxy(false)
    p5.CameraFrameChanged = newproxy(false)
    p5.RatiosChanged = newproxy(false)
    p5.MapChanged = newproxy(false)
    p5.CenterPointChanged = newproxy(false)
    u2.CreateBindableEvent(p5.ActiveBlips)
    u2.CreateBindableEvent(p5.ActiveOrientationBlips)
    u2.CreateBindableEvent(p5.MapChanged)
    u2.CreateBindableEvent(p5.CenterPointChanged)
    if u3.DontClipBlips.Value then
        local v22 = Instance.new("Frame")
        v22.Size = v16
        v22.SizeConstraint = v19.SizeConstraint
        v22.Position = v17
        v22.AnchorPoint = v14
        v22.ClipsDescendants = true
        v22.BackgroundTransparency = 1
        v22.Parent = v18
        v22.Name = "Overlay"
        script.UIStroke:Clone().Parent = v22
        p5.CurrentFrame = v22
    end
    local v23 = Instance.new("Folder", p5.CurrentFrame)
    v23.Name = "Blips"
    p5.BlipsFolder = v23
end
function v1.CreateMap(_, p24, p25) --[[ Line: 108 ]]
    local v26
    if type(p24) == "string" then
        v26 = Instance.new("ImageLabel")
        v26.Image = p24
        v26.ResampleMode = Enum.ResamplerMode.Default
        if not p25 then
            warn("Map Size not passed through, setting map size to 1024x1024")
            p25 = UDim2.new(0, 1024, 0, 1024)
        end
        v26.Size = p25
    else
        v26 = p24
    end
    v26.AnchorPoint = Vector2.new(0.5, 0.5)
    v26.Position = UDim2.new(0.5, 0, 0.5, 0)
    return v26
end
function v1.CalculateRatios(p27, p28) --[[ Line: 126 ]]
    local v29 = p28.AbsoluteSize.X
    local v30 = p28.AbsoluteSize.Y
    local v31 = p27.OriginalSizeX or v29
    local v32 = p27.OriginalSizeY or v30
    local v33 = v29 / v31
    local v34 = v30 / v32
    local v35 = p27.PixelsPerStudX * v33
    local v36 = p27.PixelsPerStudY * v34
    p27.TruePixelsPerStudX = v35
    p27.TruePixelsPerStudY = v36
    p27.MaximumMapOffsetX = p28.AbsoluteSize.X / 2 - p27.Frame.AbsoluteSize.X / 2
    p27.MaximumMapOffsetY = p28.AbsoluteSize.Y / 2 - p27.Frame.AbsoluteSize.Y / 2
    p27.MaximumMainBlipOffsetX = p28.AbsoluteSize.X / 2
    p27.MaximumMainBlipOffsetY = p28.AbsoluteSize.Y / 2
    p27.MaximumBlipOffsetX = p27.Frame.AbsoluteSize.X / 2
    p27.MaximumBlipOffsetY = p27.Frame.AbsoluteSize.Y / 2
    p27.MaximumOffsetX = v29 / 2
    p27.MaximumOffsetY = v30 / 2
end
function v1.CreateMapConnections(u37, u38) --[[ Line: 147 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    if not u2.ReturnBindableEvent(u37.RatiosChanged) then
        u2.CreateBindableEvent(u37.RatiosChanged)
    end
    u4[u38] = u38:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 151 ]]
        --[[
        Upvalues:
            [1] = u37
            [2] = u38
            [3] = u2
        --]]
        u37:CalculateRatios(u38)
        u2.ReturnBindableEvent(u37.RatiosChanged):Fire()
    end)
    u4[u37.Frame] = u37.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 155 ]]
        --[[
        Upvalues:
            [1] = u37
            [2] = u2
        --]]
        u37:CalculateRatios(u37.Map)
        u2.ReturnBindableEvent(u37.RatiosChanged):Fire()
    end)
end
function v1.RemoveMapConnection(p39, p40) --[[ Line: 161 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    u4[p40]:Disconnect()
    u4[p39.Frame]:Disconnect()
    u4[p40] = nil
    u4[p39.Frame] = nil
end
function v1.AddBlip(p41, p42, p43, p44, p45) --[[ Line: 168 ]]
    p42.Parent = p41.BlipsFolder
    p42.AnchorPoint = Vector2.new(0.5, 0.5)
    p41.Blips[p43] = {
        ["Blip"] = p42,
        ["Orientation"] = p44
    }
    if p45 then
        p41:EnableBlip(p43, p42)
        return p42
    else
        p42.Visible = false
        return p42
    end
end
function v1.AddNewMap(u46, u47, p48, p49, p50) --[[ Line: 180 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    u47.AnchorPoint = Vector2.new(0.5, 0.5)
    u46.MapCenterPoint = p48
    if type(p49) == "table" then
        u46.PixelsPerStudX = p49[1]
        u46.PixelsPerStudY = p49[2]
    else
        u46.PixelsPerStudX = p49
        u46.PixelsPerStudY = p49
    end
    u46.OriginalSizeX = p50[1] or false
    u46.OriginalSizeY = p50[2] or false
    u46:CalculateRatios(u47)
    u4[u46.Map]:Disconnect()
    u4[u46.Map] = nil
    u4[u47] = u47:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 195 ]]
        --[[
        Upvalues:
            [1] = u46
            [2] = u47
            [3] = u2
        --]]
        u46:CalculateRatios(u47)
        u2.ReturnBindableEvent(u46.RatiosChanged):Fire()
    end)
    u46.MainBlip.Parent = u47
    u46.Map:Destroy()
    u47.Parent = u46.Frame
    u46.Map = u47
    u2.ReturnBindableEvent(u46.MapChanged):Fire()
    u2.ReturnBindableEvent(u46.RatiosChanged):Fire()
    u2.ReturnBindableEvent(u46.CenterPointChanged):Fire()
end
return v1