 

local u1 = _G.Ess.Tween
local function u21(p2, p3, p4, p5) --[[ Line: 3 ]]
    local _ = p4.Material
    local v6 = p4.Instance.Color
    local v7 = script:FindFirstChild("Rock" .. p5):Clone()
    v7:ScaleTo(p3)
    local v8, v9, _ = _G.getRayFloor(CFrame.new(p2.Position + Vector3.new(0, 15, 0)), 75)
    if v8 then
        local _, _, _, v10, v11, v12, v13, v14, v15, v16, v17, v18 = p2:components()
        p2 = CFrame.new(v9.X, v9.Y, v9.Z, v10, v11, v12, v13, v14, v15, v16, v17, v18)
    end
    v7:PivotTo(p2)
    for _, v19 in v7:GetChildren() do
        if v19:IsA("BasePart") then
            local v20, _, _ = _G.getRayFloor(CFrame.new(v19.Position), 75)
            if v19.Name == "Color" then
                v19.Material = p4.Material
                v19.Color = v6:Lerp(Color3.new(0, 0, 0), 0.15)
                if v20 then
                    _G.matchMaterial(v19, v20)
                end
            else
                v19.Color = v6
                if v20 then
                    _G.matchMaterial(v19, v20)
                end
            end
            if p4.Instance.MaterialVariant then
                v19.MaterialVariant = p4.Instance.MaterialVariant
            end
        end
    end
    v7.Parent = workspace.Effects
    return v7
end
return function(p22, p23, p24, p25) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u1
    --]]
    local v26 = Random.new(7271925)
    local v27 = {}
    for v28 = 1, p25 do
        local v29 = v26:NextInteger(p23.Min, p23.Max)
        local v30 = p23.Max - v29
        local v31 = v28 * 360 / p25 + v26:NextInteger(-1, 1)
        local v32 = math.sin(v31) * v29
        local v33 = math.cos(v31) * v29
        local v34 = v28 % 2 == 0 and 1 or 2
        local v35 = Vector3.new(v32, 0, v33)
        local v36 = v26:NextNumber(p24.Min, p24.Max) / 2 * (2 - v30 / p23.Max)
        local v37 = workspace:Raycast(p22.Position + Vector3.new(0, 10, 0), Vector3.new(0, -40, 0), _G.RaycastParams)
        local v38 = CFrame.new(p22.Position + v35, p22.Position + v26:NextUnitVector() * 10)
        if v37 then
            local v39 = v30 * 2
            local v40 = math.sin(v39) / 4 + 0.15
            local v41 = CFrame.Angles
            local v42 = v37.Normal.Y
            local v43 = v38 * v41(-math.acos(v42) + v40, 0, 0)
            local v44 = (v30 / 4) ^ 1.5 / 3 - 5
            local v45 = v43 + Vector3.new(0, v44, 0)
            v27[#v27 + 1] = u21(v45, v36, v37, v34)
        end
    end
    for _, v46 in v27 do
        local v47 = (v46:GetPivot().Position - p22.Position).Magnitude / 500
        v46:PivotTo(v46:GetPivot() + Vector3.new(0, -20, 0))
        u1(v46.PrimaryPart, TweenInfo.new(0.5 * v47, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["CFrame"] = v46.PrimaryPart.CFrame + Vector3.new(0, 20, 0)
        })
        task.delay(20 * v47, u1, v46.PrimaryPart, TweenInfo.new(12 * v47, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ["CFrame"] = v46.PrimaryPart.CFrame - Vector3.new(0, 40, 0)
        })
        task.delay(33 * v47, v46.Destroy, v46)
    end
end