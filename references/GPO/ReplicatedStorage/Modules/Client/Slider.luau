 

local u1 = {
    ["Sliders"] = {}
}
local v2 = game:GetService("RunService"):IsClient()
assert(v2, "Slider module can only be used on the Client!")
local u3 = game:GetService("SoundService")
local u4 = game:GetService("UserInputService")
local u5 = game:GetService("TweenService")
local u6 = math.clamp
local _ = math.floor
local u7 = math.min
local u8 = math.max
local u9 = math.round
local u10 = math.abs
local u11 = string.lower
local u12 = string.upper
local u13 = string.sub
local u14 = string.format
local v15 = script.Utils
local u16 = require(v15.Signal)
local u17 = require(v15.Switch)
local u18 = require(v15.VectorFuncs)
function u1.__index(p19, p20) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u14
        [3] = u1
    --]]
    local v21 = {
        { ".OnChange", ".Changed", (rawget(p19, "Changed")) }
    }
    for _, v22 in ipairs(v21) do
        if u13(v22[1], 2) == p20 then
            warn(u14("%s is deprecated, please use %s instead", v22[1], v22[2]))
            return v22[3]
        end
    end
    return u1[p20]
end
function snapToScale(p23, p24)
    --[[
    Upvalues:
        [1] = u9
        [2] = u6
    --]]
    return u6(u9(p23 / p24) * p24, 0, 1)
end
function lerp(p25, p26, p27)
    return (1 - p27) * p25 + p27 * p26
end
function map(p28, p29, p30, p31, p32, p33)
    --[[
    Upvalues:
        [1] = u7
        [2] = u8
    --]]
    local v34 = lerp(p31, p32, getAlphaBetween(p29, p30, p28))
    if not p33 then
        return v34
    end
    if p31 >= p32 then
        local v35 = p31
        p31 = p32
        p32 = v35
    end
    return u8(u7(v34, p32), p31)
end
function getNewPosition(p36)
    --[[
    Upvalues:
        [1] = u17
    --]]
    local v37 = p36._button.AbsoluteSize[p36._axis]
    local v38 = p36._holder.AbsoluteSize[p36._axis]
    local v39 = p36._button.AnchorPoint[p36._axis]
    local v40 = p36._padding / v38
    local v41 = v37 / v38
    local v42 = v40 + v39 * v41
    local v43 = 1 - v40 - (1 - v39) * v41
    local v44 = map(p36._percent, 0, 1, v42, v43, true)
    return u17(p36._axis)({
        ["X"] = UDim2.fromScale(v44, p36._button.Position.Y.Scale),
        ["Y"] = UDim2.fromScale(p36._button.Position.X.Scale, v44)
    })
end
function getScaleIncrement(p45)
    return 1 / ((p45._config.End - p45._config.Start) / p45._config.Increment)
end
function getAlphaBetween(p46, p47, p48)
    return (p48 - p46) / (p47 - p46)
end
function getNewValue(p49)
    local v50 = lerp(p49._config.Start, p49._config.End, p49._percent)
    local v51 = 1 / p49._config.Increment
    local v52 = v50 * v51
    return math.round(v52) / v51
end
function u1.new(u53, p54, p55, p56, p57) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u11
        [3] = u12
        [4] = u17
        [5] = u6
        [6] = u16
    --]]
    local v58 = pcall(function() --[[ Line: 122 ]]
        --[[
        Upvalues:
            [1] = u53
        --]]
        return u53.AbsoluteSize, u53.AbsolutePosition
    end)
    assert(v58, "Holder argument does not have an AbsoluteSize/AbsolutePosition")
    local v59 = u53:FindFirstChild("Slider")
    local v60 = v59 ~= nil
    assert(v60, "Failed to find slider button.")
    local v61 = v59:IsA("GuiButton")
    assert(v61, "Slider is not a GuiButton")
    local v62 = false
    for _, v63 in ipairs(u1.Sliders) do
        if v63._holder == u53 then
            v62 = true
            break
        end
    end
    assert(not v62, "Cannot set two sliders with same frame!")
    local v64 = p54.Increment ~= nil
    assert(v64, "Failed to find Increment in configuration table")
    local v65 = p54.Start ~= nil
    assert(v65, "Failed to find Start in configuration table")
    local v66 = p54.End ~= nil
    assert(v66, "Failed to find End in configuration table")
    local v67 = p54.Increment > 0
    assert(v67, "Increment must be greater than 0")
    local v68 = p54.End > p54.Start
    local v69 = "Config.End must be greater than Config.Start (" .. p54.End .. " <= " .. p54.Start .. ")"
    assert(v68, v69)
    local v70 = u11(p56 or "x")
    local v71 = v70 == "x" and true or v70 == "y"
    assert(v71, "Axis must be X or Y!")
    local v72 = typeof(p55) == "TweenInfo"
    assert(v72, "MoveTweenInfo must be a TweenInfo object!")
    local v73 = p57 or 5
    local v74 = typeof(v73) == "number"
    assert(v74, "Padding variable must be a number!")
    local v75 = u1
    local v76 = setmetatable({}, v75)
    v76._holder = u53
    v76._button = v59
    v76._config = p54
    v76._axis = u12(v70)
    v76._padding = v73
    v76.UI_TYPE = u53:FindFirstAncestorOfClass("ScreenGui") and "ScreenGui" or (u53:FindFirstAncestorOfClass("SurfaceGui") and "SurfaceGui" or nil)
    v76._holderPart = u17(v76.UI_TYPE)({
        ["SurfaceGui"] = u53:FindFirstAncestorWhichIsA("BasePart"),
        ["ScreenGui"] = nil
    })
    v76._surfaceUi = u17(v76.UI_TYPE)({
        ["SurfaceGui"] = u53:FindFirstAncestorWhichIsA("SurfaceGui"),
        ["ScreenGui"] = nil
    })
    v76.IsHeld = false
    v76._CLICKED_OVERRIDE = false
    v76._mainConnection = nil
    v76._miscConnections = {}
    v76._inputPos = nil
    v76._percent = 0
    if p54.DefaultValue then
        p54.DefaultValue = u6(p54.DefaultValue, p54.Start, p54.End)
        v76._percent = getAlphaBetween(p54.Start, p54.End, p54.DefaultValue)
    end
    v76._percent = u6(v76._percent, 0, 1)
    v76._value = getNewValue(v76)
    v76._scaleIncrement = getScaleIncrement(v76)
    v76._currentTween = nil
    v76._tweenInfo = p55 or TweenInfo.new(1)
    v76.Changed = u16.new()
    v76.Dragged = u16.new()
    v76.Released = u16.new()
    v76.OnClick = u16.new()
    local v77 = Instance.new("TextButton")
    v77.BackgroundTransparency = 1
    v77.Text = ""
    v77.Name = "HolderClickButton"
    v77.Size = UDim2.fromScale(1, 1)
    v77.ZIndex = -1
    v77.Parent = v76._holder
    v76._holderClickButton = v77
    v76._initialized = false
    v76:Move()
    v76._initialized = true
    local v78 = u1.Sliders
    table.insert(v78, v76)
    return v76
end
function u1.Track(u79) --[[ Line: 219 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    for _, v80 in ipairs(u79._miscConnections) do
        v80:Disconnect()
    end
    local v81 = u79._miscConnections
    local v82 = u79._button.MouseButton1Down
    table.insert(v81, v82:Connect(function() --[[ Line: 224 ]]
        --[[
        Upvalues:
            [1] = u79
        --]]
        u79.IsHeld = true
    end))
    local v83 = u79._miscConnections
    local v84 = u79._button.MouseButton1Up
    table.insert(v83, v84:Connect(function() --[[ Line: 228 ]]
        --[[
        Upvalues:
            [1] = u79
        --]]
        if u79.IsHeld then
            u79.Released:Fire(u79._value)
        end
        u79.IsHeld = false
    end))
    local v85 = u79._miscConnections
    local v86 = u79._holderClickButton.MouseButton1Down
    local function v88() --[[ Line: 235 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u79
        --]]
        local v87 = u4:GetMouseLocation()
        u79._inputPos = Vector2.new(v87.X, v87.Y)
        u79.IsHeld = true
        u79._CLICKED_OVERRIDE = true
        u79:Update()
        u79._CLICKED_OVERRIDE = false
        u79.OnClick:Fire(u79._value)
    end
    table.insert(v85, v86:Connect(v88))
    if u79.Changed then
        u79.Changed:Fire(u79._value)
    end
    if u79._mainConnection then
        u79._mainConnection:Disconnect()
    end
    u79._mainConnection = u4.InputChanged:Connect(function(p89, _) --[[ Line: 253 ]]
        --[[
        Upvalues:
            [1] = u79
        --]]
        if p89.UserInputType == Enum.UserInputType.MouseMovement or p89.UserInputType == Enum.UserInputType.Touch then
            u79._inputPos = p89.Position
            u79:Update()
        end
    end)
end
function u1.Update(u90) --[[ Line: 261 ]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u18
        [3] = u10
        [4] = u6
        [5] = u3
    --]]
    local v100 = (u90.IsHeld or u90._CLICKED_OVERRIDE) and (u90._inputPos and u17(u90.UI_TYPE)({
        ["ScreenGui"] = u90._inputPos[u90._axis],
        ["SurfaceGui"] = function() --[[ Line: 266 ]]
            --[[
            Upvalues:
                [1] = u90
                [2] = u18
                [3] = u10
            --]]
            local v91 = RaycastParams.new()
            v91.FilterType = Enum.RaycastFilterType.Include
            v91.FilterDescendantsInstances = { u90._holderPart }
            local v92 = workspace.CurrentCamera:ScreenPointToRay(u90._inputPos.X, u90._inputPos.Y)
            local v93 = workspace:Raycast(v92.Origin, v92.Direction * 500, v91)
            if v93 then
                local v94 = v93.Instance
                local v95 = v93.Position
                local v96 = v93.Normal
                if u18.normalVectorToFace(v94, v96) == u90._surfaceUi.Face then
                    local v97 = CFrame.new(v95, v95 + v96)
                    local v98 = u18.getTopLeftCorners(v94)[u90._surfaceUi.Face]:ToObjectSpace(v97)
                    local v99 = u18.mapOffsetToFace(v98, u90._axis, u90._surfaceUi.Face)
                    return Vector2.new(u10(v99.X) * u90._surfaceUi.PixelsPerStud, u10(v99.Y) * u90._surfaceUi.PixelsPerStud)[u90._axis]
                end
            end
        end
    }))
    if v100 then
        local v101 = u90._holder.AbsoluteSize[u90._axis]
        local v102 = u90._holder.AbsolutePosition[u90._axis]
        local v103 = u90._button.AbsoluteSize[u90._axis]
        local v104 = v102 + u90._padding + v103 * u90._button.AnchorPoint[u90._axis]
        local v105 = v102 + v101 - u90._padding - v103 * (1 - u90._button.AnchorPoint[u90._axis])
        local v106 = (u6(v100, v104, v105) - v104) / (v105 - v104)
        local v107 = u6(snapToScale(v106, u90._scaleIncrement), 0, 1)
        local v108 = u90._value
        u90._percent = v107
        local v109 = getNewValue(u90)
        if u90._initialized and (v108 ~= v109 and script.ButtonClick) then
            u3:PlayLocalSound(script.ButtonClick)
        end
        u90.Dragged:Fire(u90._value)
        u90:Move()
    end
end
function u1.Untrack(p110) --[[ Line: 331 ]]
    for _, v111 in ipairs(p110._miscConnections) do
        v111:Disconnect()
    end
    if p110._mainConnection then
        p110._mainConnection:Disconnect()
    end
    p110.IsHeld = false
end
function u1.Reset(p112) --[[ Line: 341 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    for _, v113 in ipairs(p112._miscConnections) do
        v113:Disconnect()
    end
    if p112._mainConnection then
        p112._mainConnection:Disconnect()
    end
    p112.IsHeld = false
    p112._percent = 0
    if p112._config.DefaultValue then
        p112._percent = getAlphaBetween(p112._config.Start, p112._config.End, p112._config.DefaultValue)
    end
    p112._percent = u6(p112._percent, 0, 1)
    p112:Move()
end
function u1.OverrideValue(p114, p115) --[[ Line: 359 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    p114.IsHeld = false
    p114._percent = getAlphaBetween(p114._config.Start, p114._config.End, p115)
    p114._percent = u6(p114._percent, 0, 1)
    p114._percent = snapToScale(p114._percent, p114._scaleIncrement)
    p114:Move()
end
function u1.Move(p116) --[[ Line: 367 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    p116._value = getNewValue(p116)
    if p116._currentTween then
        p116._currentTween:Cancel()
    end
    p116._currentTween = u5:Create(p116._button, p116._tweenInfo, {
        ["Position"] = getNewPosition(p116)
    })
    p116._currentTween:Play()
    p116.Changed:Fire(p116._value)
end
function u1.OverrideIncrement(p117, p118) --[[ Line: 380 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    p117._config.Increment = p118
    p117._scaleIncrement = getScaleIncrement(p117)
    p117._percent = u6(p117._percent, 0, 1)
    p117._percent = snapToScale(p117._percent, p117._scaleIncrement)
    p117:Move()
end
function u1.GetValue(p119) --[[ Line: 388 ]]
    return p119._value
end
function u1.GetIncrement(p120) --[[ Line: 392 ]]
    return p120._increment
end
function u1.Destroy(p121) --[[ Line: 396 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    for _, v122 in ipairs(p121._miscConnections) do
        v122:Disconnect()
    end
    if p121._mainConnection then
        p121._mainConnection:Disconnect()
    end
    p121.Changed:Destroy()
    p121.Dragged:Destroy()
    p121.Released:Destroy()
    for v123 = 1, #u1.Sliders do
        if u1.Sliders[v123] == p121 then
            table.remove(u1.Sliders, v123)
        end
    end
    setmetatable(p121, nil)
end
u4.InputEnded:Connect(function(p124, _) --[[ Line: 419 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p124.UserInputType == Enum.UserInputType.MouseButton1 or p124.UserInputType == Enum.UserInputType.Touch then
        for _, v125 in ipairs(u1.Sliders) do
            if v125.IsHeld then
                v125.Released:Fire(v125._value)
            end
            v125.IsHeld = false
        end
    end
end)
return u1