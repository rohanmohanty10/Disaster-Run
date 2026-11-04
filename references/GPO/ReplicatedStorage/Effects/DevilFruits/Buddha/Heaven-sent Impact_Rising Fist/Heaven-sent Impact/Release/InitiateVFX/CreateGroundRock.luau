 

local u1 = _G.Ess.Tween
local function u10(p2, p3, p4, p5, p6) --[[ Line: 3 ]]
    local _ = p4.Material
    local v7 = p4.Instance.Color
    local v8 = script:FindFirstChild("Rock" .. p5):Clone()
    v8:ScaleTo(p3)
    for _, v9 in v8:GetChildren() do
        if v9:IsA("BasePart") then
            if v9.Name == "Color" then
                v9.Material = p4.Material
                v9.Color = v7:Lerp(Color3.new(0, 0, 0), 0.15)
            else
                v9.Color = v7
            end
            if p4.Instance.MaterialVariant then
                v9.MaterialVariant = p4.Instance.MaterialVariant
            end
        end
    end
    v8:PivotTo(p2)
    v8:SetAttribute("Index", p6)
    v8.Parent = workspace.Effects
    return v8
end
return function(p11, p12, p13, p14) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u1
    --]]
    local v15 = Random.new()
    local v16 = {}
    for v17 = 1, p14 do
        local v18 = v15:NextInteger(p12.Min, p12.Max)
        local v19 = p12.Max - v18
        local v20 = v17 * 360 / p14 + v15:NextInteger(-1, 1)
        local v21 = math.sin(v20) * v18
        local v22 = math.cos(v20) * v18
        local v23 = v17 % 2 == 0 and 1 or 2
        local v24 = Vector3.new(v21, 0, v22)
        local v25 = v15:NextNumber(p13.Min, p13.Max) / 2 * (2 - v19 / p12.Max)
        local v26 = workspace:Raycast(p11.Position + v24 + Vector3.new(0, 2, 0), Vector3.new(0, -45, 0), _G.RaycastParams)
        local v27 = CFrame.new(p11.Position + v24, p11.Position + v15:NextUnitVector() * 10)
        if v26 then
            local v28 = v19 / 4
            local v29 = math.sin(v28) / 4 + 0.25
            local v30 = CFrame.Angles
            local v31 = v26.Normal.Y
            local v32 = v27 * v30(-math.acos(v31) + v29, 0, 0)
            local v33 = v19 / 4 / 3 - 5
            local v34 = v32 + Vector3.new(0, v33, 0)
            v16[#v16 + 1] = u10(v34, v25, v26, v23, v17)
        end
    end
    for _, v35 in v16 do
        local v36 = (v35:GetPivot().Position - p11.Position).Magnitude / 8 / (1 + p13.Max) ^ 1.5
        v35:PivotTo(v35:GetPivot() + Vector3.new(0, -10, 0))
        local v37 = 0.15 * v36
        u1(v35.PrimaryPart, TweenInfo.new(v37, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["CFrame"] = v35.PrimaryPart.CFrame + Vector3.new(0, 10, 0)
        })
        task.delay(v37 * 1.15, u1, v35.PrimaryPart, TweenInfo.new(0.4 * v36, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ["CFrame"] = v35.PrimaryPart.CFrame - Vector3.new(0, 40, 0)
        })
        task.delay(2 * v36, v35.Destroy, v35)
    end
end