 

local u1 = workspace.CurrentCamera
return function(p2, p3) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4
    if typeof(p2) == "Instance" then
        v4 = p2.ClassName
    else
        v4 = false
    end
    local v5 = v4 == "UIGridLayout" and true or v4 == "UIListLayout"
    assert(v5, ("bad argument #%d to \'LayoutUtil\' (%s expected, got %s)"):format(1, "UIGridLayout or UIListLayout", v4))
    local v6 = p3 or p2.Parent
    if v6:IsA("GuiObject") then
        p3 = v6.AbsoluteSize
    elseif typeof(p3) ~= "Vector2" then
        p3 = u1.ViewportSize
    end
    if p2.ClassName == "UIGridLayout" then
        local v7 = p2.CellSize
        local v8 = Vector2.new
        local v9 = v7.X
        local v10 = p3.X
        local v11 = v9.Scale * v10 + v9.Offset
        local v12 = v7.Y
        local v13 = p3.Y
        local v14 = v8(v11, v12.Scale * v13 + v12.Offset)
        local v15 = p2:FindFirstChildOfClass("UIAspectRatioConstraint") or Instance.new("UIAspectRatioConstraint")
        v15.AspectRatio = v14.X / v14.Y
        v15.Parent = p2
    else
        for _, v16 in v6:GetChildren() do
            if v16:IsA("GuiObject") then
                local v17 = v16.Size
                local v18 = Vector2.new
                local v19 = v17.X
                local v20 = p3.X
                local v21 = v19.Scale * v20 + v19.Offset
                local v22 = v17.Y
                local v23 = p3.Y
                local v24 = v18(v21, v22.Scale * v23 + v22.Offset)
                local v25 = v16:FindFirstChildOfClass("UIAspectRatioConstraint") or Instance.new("UIAspectRatioConstraint")
                v25.AspectRatio = v24.X / v24.Y
                v25.Parent = v16
            end
        end
    end
end