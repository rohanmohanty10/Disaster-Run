 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = Random.new()
local function u22(p4, p5, p6, p7, p8) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v9 = math.random(5, 10)
    local v10 = {}
    for v11 = 1, v9 do
        v10[v11] = CFrame.new(p6, p7) * CFrame.new(u3:NextNumber(-0.5, 0.5), u3:NextNumber(-0.5, 0.5), (p6 - p7).Magnitude * v11 / v9).Position
    end
    for v12 = 1, #v10 - 1 do
        local v13 = Instance.new("Part")
        local v14 = (v10[v12] - v10[v12 + 1]).Magnitude
        v13.Size = Vector3.new(0, 0, v14)
        v13.CFrame = CFrame.new(v10[v12], v10[v12 + 1]) * CFrame.new(0, 0, -(v10[v12] - v10[v12 + 1]).Magnitude / 2)
        v13.Anchored = true
        v13.Color = p8
        v13.Material = Enum.Material.Neon
        v13.CanCollide = false
        v13.Parent = p4
        _G.destroy(v13, 0.075)
        local v15 = (#v10 - v12) / #v10 * 1
        local v16 = u2
        local v17 = TweenInfo.new(0.0375, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, true, 0)
        local v18 = {}
        local v19 = p5 * v15
        local v20 = p5 * v15
        local v21 = v13.Size.Z
        v18.Size = Vector3.new(v19, v20, v21)
        v16:Create(v13, v17, v18):Play()
        task.wait()
    end
end
function v1.start(_, p23) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u22
    --]]
    local v24 = p23.Start
    local v25 = p23.End
    local v26 = CFrame.new(v24, v25) * CFrame.new(0, 0, -(v24 - v25).Magnitude / 2)
    local v27 = math.random(10, 15)
    local v28 = (v26 + Vector3.new(0, v27, 0)).Position
    local v29 = Instance.new("Model")
    local v30 = Instance.new("Highlight")
    v30.FillColor = Color3.new(0, 0, 0)
    v30.FillTransparency = 0
    v30.OutlineTransparency = 1
    v30.DepthMode = Enum.HighlightDepthMode.Occluded
    v30.Parent = v29
    v29.Parent = workspace.Effects
    local v31 = u3:NextNumber(0.15, 0.75)
    if p23.Size then
        v31 = p23.Size
    end
    for _ = 1, math.random(3, 5) do
        local v32 = {}
        for v33 = 1, 15 do
            local v34 = v33 / 15
            local v35 = v24 + (v28 - v24) * v34
            local v36 = v33 / 15
            local v37 = v28 + (v25 - v28) * v36
            if p23.Linear then
                local v38 = v33 / 15
                local v39 = v24 + (v25 - v24) * v38
                local v40 = u3:NextNumber(-1, 1)
                local v41 = u3:NextNumber(-1, 1)
                local v42 = u3
                v32[v33] = v39 + Vector3.new(v40, v41, v42:NextNumber(-1, 1))
            else
                local v43 = v33 / 15
                local v44 = v35 + (v37 - v35) * v43
                local v45 = u3:NextNumber(-1, 1)
                local v46 = u3:NextNumber(-1, 1)
                local v47 = u3
                v32[v33] = v44 + Vector3.new(v45, v46, v47:NextNumber(-1, 1))
            end
        end
        for v48 = 1, #v32 - 1 do
            local v49 = v48 / #v32 * v31
            local v50 = Instance.new("Part")
            local v51 = (v32[v48] - v32[v48 + 1]).Magnitude
            v50.Size = Vector3.new(v49, v49, v51)
            v50.CFrame = CFrame.new(v32[v48], v32[v48 + 1]) * CFrame.new(0, 0, -(v32[v48] - v32[v48 + 1]).Magnitude / 2)
            v50.Anchored = true
            v50.Color = p23.Colour
            v50.Material = Enum.Material.Neon
            v50.CanCollide = false
            if math.random(3) == 1 then
                local v52 = v50.CFrame * CFrame.new(0, 0, -v50.Size.Z / 2)
                local v53 = CFrame.Angles
                local v54 = u3:NextNumber(-15, 15)
                local v55 = math.rad(v54)
                local v56 = u3:NextNumber(-15, 15)
                local v57 = v52 * v53(v55, math.rad(v56), 0) * CFrame.new(0, 0, math.random(3))
                local v58 = task.spawn
                local v59 = u22
                local v60 = v50.Size.X
                v58(v59, v29, math.min(v60, 0.25), v52.Position, v57.Position, p23.Colour)
            end
            v50.Parent = v29
            _G.destroy(v50, 0.05)
        end
        task.wait(0.05)
    end
    task.wait(1)
    v29:Destroy()
end
return v1