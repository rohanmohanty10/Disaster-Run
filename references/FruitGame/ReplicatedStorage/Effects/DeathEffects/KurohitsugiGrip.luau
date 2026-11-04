 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = Random.new()
local u4 = {}
local v5 = {}
local v6 = {
    ["Size"] = Vector3.new(0.1, 0.1, 0),
    ["CFrameEdit"] = CFrame.new(-7.5, 42, -7.5),
    ["Goal"] = {
        ["CFrameEdit"] = CFrame.new(0, 0, 3.75),
        ["Size"] = Vector3.new(0, 0, 7.5)
    }
}
v5[1] = v6
local v7 = {
    ["Size"] = Vector3.new(0, 0.1, 0.1),
    ["CFrameEdit"] = CFrame.new(-7.5, 42, -7.5),
    ["Goal"] = {
        ["CFrameEdit"] = CFrame.new(3.75, 0, 0),
        ["Size"] = Vector3.new(7.5, 0, 0)
    }
}
v5[2] = v7
local v8 = {
    ["Size"] = Vector3.new(0.1, 0.1, 0),
    ["CFrameEdit"] = CFrame.new(7.5, 42, -7.5),
    ["Goal"] = {
        ["CFrameEdit"] = CFrame.new(0, 0, 3.75),
        ["Size"] = Vector3.new(0, 0, 7.5)
    }
}
v5[3] = v8
local v9 = {
    ["Size"] = Vector3.new(0, 0.1, 0.1),
    ["CFrameEdit"] = CFrame.new(7.5, 42, -7.5),
    ["Goal"] = {
        ["CFrameEdit"] = CFrame.new(-3.75, 0, 0),
        ["Size"] = Vector3.new(7.5, 0, 0)
    }
}
v5[4] = v9
local v10 = {
    ["Size"] = Vector3.new(0.1, 0.1, 0),
    ["CFrameEdit"] = CFrame.new(7.5, 42, 7.5),
    ["Goal"] = {
        ["CFrameEdit"] = CFrame.new(0, 0, -3.75),
        ["Size"] = Vector3.new(0, 0, 7.5)
    }
}
v5[5] = v10
local v11 = {
    ["Size"] = Vector3.new(0, 0.1, 0.1),
    ["CFrameEdit"] = CFrame.new(7.5, 42, 7.5),
    ["Goal"] = {
        ["CFrameEdit"] = CFrame.new(-3.75, 0, 0),
        ["Size"] = Vector3.new(7.5, 0, 0)
    }
}
v5[6] = v11
local v12 = {
    ["Size"] = Vector3.new(0.1, 0.1, 0),
    ["CFrameEdit"] = CFrame.new(-7.5, 42, 7.5),
    ["Goal"] = {
        ["CFrameEdit"] = CFrame.new(0, 0, -3.75),
        ["Size"] = Vector3.new(0, 0, 7.5)
    }
}
v5[7] = v12
local v13 = {
    ["Size"] = Vector3.new(0, 0.1, 0.1),
    ["CFrameEdit"] = CFrame.new(-7.5, 42, 7.5),
    ["Goal"] = {
        ["CFrameEdit"] = CFrame.new(3.75, 0, 0),
        ["Size"] = Vector3.new(7.5, 0, 0)
    }
}
v5[8] = v13
u4.TopLines = v5
u4.WallOffsets = {
    CFrame.new(7.5, -3, 0) * CFrame.Angles(3.141592653589793, 1.5707963267948966, 0),
    CFrame.new(-7.5, -3, 0) * CFrame.Angles(3.141592653589793, 1.5707963267948966, 0),
    CFrame.new(0, -3, 7.5) * CFrame.Angles(3.141592653589793, 0, 0),
    CFrame.new(0, -3, -7.5) * CFrame.Angles(3.141592653589793, 0, 0)
}
u4.Outlines = {
    CFrame.new(7.5, 0, 7.5),
    CFrame.new(-7.5, 0, 7.5),
    CFrame.new(7.5, 0, -7.5),
    CFrame.new(-7.5, 0, -7.5)
}
function GenerateWall()
    local v14 = Instance.new("Model")
    v14.Parent = workspace.Effects
    local v15 = math.random(6, 22)
    local v16 = 15 / v15
    for v17 = 1, v15 do
        local v18 = script.Wall:Clone()
        v18.Size = Vector3.new(v16, 0, 0)
        local v19 = v16 * v17
        v18.Position = Vector3.new(0, 0, v19)
        v18.Parent = v14
    end
    return v14
end
function v1.start(_, p20, _) --[[ Line: 118 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u3
    --]]
    local v21 = CFrame.new(p20.PrimaryPart.Position)
    _G.PlaySound(v21, script.BlackCoffinGrip)
    local u22 = Instance.new("Model")
    u22.Name = "Kuro"
    u22.Parent = workspace.Effects
    local v23 = Instance.new("Highlight")
    v23.FillTransparency = 1
    v23.DepthMode = Enum.HighlightDepthMode.Occluded
    v23.OutlineTransparency = 0
    v23.OutlineColor = Color3.fromRGB(227, 70, 255)
    v23.Parent = u22
    local v24 = script.Wall:Clone()
    v24.Size = Vector3.new(15, 0, 15)
    v24.CFrame = v21 * CFrame.new(0, -3, 0)
    v24.Transparency = 1
    u2:Create(v24, TweenInfo.new(0.5), {
        ["Transparency"] = 0
    }):Play()
    v24.Name = "Floor"
    v24.Parent = workspace.Effects
    for v25 = 1, 4 do
        local v26 = GenerateWall()
        local _, _ = v26:GetBoundingBox()
        v26:PivotTo(v21 * u4.WallOffsets[v25])
        v26.Parent = u22
    end
    local v27 = next
    local v28, v29 = u22:GetDescendants()
    for _, v30 in v27, v28, v29 do
        if v30:IsA("BasePart") then
            u2:Create(v30, TweenInfo.new(u3:NextNumber(0.6, 1.5), Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                ["Size"] = v30.Size + Vector3.new(0, 45, 0),
                ["Position"] = v30.Position + Vector3.new(0, 22.5, 0)
            }):Play()
        end
    end
    for v31 = 1, 4 do
        local v32 = script.Outline:Clone()
        v32.Size = Vector3.new(0.1, 0, 0.1)
        v32.CFrame = v21 * u4.Outlines[v31]
        u2:Create(v32, TweenInfo.new(1), {
            ["Position"] = v32.Position + Vector3.new(0, 19.5, 0),
            ["Size"] = v32.Size + Vector3.new(0, 45, 0)
        }):Play()
        v32.Parent = u22
    end
    u2:Create(v23, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        ["OutlineTransparency"] = 1
    }):Play()
    task.wait(1)
    for v33 = 1, 8 do
        if u4.TopLines[v33] then
            local v34 = u4.TopLines[v33]
            local v35 = script.Outline:Clone()
            v35.Size = v34.Size
            v35.CFrame = v21 * v34.CFrameEdit
            local v36 = {
                ["CFrame"] = v35.CFrame * v34.Goal.CFrameEdit,
                ["Size"] = v35.Size + v34.Goal.Size
            }
            u2:Create(v35, TweenInfo.new(1), v36):Play()
            v35.Parent = u22
        end
    end
    local v37 = script.Wall:Clone()
    v37.Size = Vector3.new(15, 0, 15)
    v37.CFrame = v21 * CFrame.new(0, 42, 0)
    v37.Transparency = 1
    u2:Create(v37, TweenInfo.new(1), {
        ["Transparency"] = 0
    }):Play()
    v37.Name = "Roof"
    v37.Parent = workspace.Effects
    task.wait(1)
    for _ = 1, math.random(19, 35) do
        local u38 = script.Star:Clone()
        local v39 = u3:NextNumber(-4, 4)
        u38.Size = u38.Size + Vector3.new(v39, v39, 0)
        local v40 = CFrame.new
        local v41 = (v21 * CFrame.new(u3:NextNumber(-0.75, 0.75) * 22, u3:NextNumber(30, 40), u3:NextNumber(-0.75, 0.75) * 22)).Position
        local v42 = p20.PrimaryPart.Position
        local v43 = u3:NextNumber(30, 40)
        local v44 = v40(v41, v42 + Vector3.new(0, v43, 0))
        local v45 = CFrame.Angles
        local v46 = u3:NextNumber(-45, 45)
        local v47 = math.rad(v46)
        local v48 = u3:NextNumber(-5, 5)
        u38.CFrame = v44 * v45(1.5707963267948966, v47, (math.rad(v48)))
        u38.Transparency = 1
        u38.Parent = workspace.Effects
        u2:Create(u38, TweenInfo.new(u3:NextNumber(0.5, 0.8)), {
            ["Transparency"] = 0
        }):Play()
        task.delay(1, function() --[[ Line: 221 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u38
                [3] = u2
            --]]
            local v49 = RaycastParams.new()
            v49.FilterType = Enum.RaycastFilterType.Include
            v49.FilterDescendantsInstances = { u22 }
            local v50 = workspace:Raycast(u38.Position, u38.CFrame.UpVector * -50, v49)
            local v51
            if v50 then
                local v52 = v50.Distance
                v51 = math.clamp(v52, 0, 5)
            else
                v51 = 5
            end
            u2:Create(u38, TweenInfo.new(0.1), {
                ["CFrame"] = u38.CFrame * CFrame.new(0, -v51, 0)
            }):Play()
            task.wait(0.4)
            u2:Create(u38, TweenInfo.new(1), {
                ["Transparency"] = 1
            }):Play()
            task.wait(1)
            u38:Destroy()
        end)
    end
    task.wait(1.05)
    for _ = 1, math.random(50, 111) do
        local u53 = u3:NextNumber(0.25, 1)
        local v54 = u3:NextNumber(22.5, 37.5)
        local u55 = script.Spike:Clone()
        u55.Size = Vector3.new(u53, u53, 0)
        local v56 = p20.PrimaryPart.Position
        local v57 = u3:NextNumber(-7.5, 7.5)
        local v58 = u3:NextNumber(-3, 42)
        local v59 = u3
        u55.Position = v56 + Vector3.new(v57, v58, v59:NextNumber(-7.5, 7.5))
        local v60 = p20.PrimaryPart.Orientation.Y + math.random(-4, 4) * 90
        u55.Orientation = Vector3.new(0, v60, 0)
        u55.Parent = workspace.Effects
        local v61 = u3:NextNumber(0.1, 0.45)
        u2:Create(u55, TweenInfo.new(v61, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ["Size"] = Vector3.new(u53, u53, v54)
        }):Play()
        task.delay(v61 + 0.75, function() --[[ Line: 263 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u55
                [3] = u53
            --]]
            local v62 = u2
            local v63 = u55
            local v64 = TweenInfo.new(0.75)
            local v65 = {}
            local v66 = u53
            local v67 = u53
            v65.Size = Vector3.new(v66, v67, 0)
            v62:Create(v63, v64, v65):Play()
            task.wait(0.75)
            u55:Destroy()
        end)
    end
    for v68 = 1, 4 do
        local v69 = script.Particles:Clone()
        v69.Size = Vector3.new(15, 0, 45)
        local v70 = CFrame.new(7.5, 19.5, 0) * CFrame.Angles(1.5707963267948966, 3.141592653589793, 1.5707963267948966)
        if v68 == 2 then
            v70 = CFrame.new(-7.5, 19.5, 0) * CFrame.Angles(1.5707963267948966, 3.141592653589793, -1.5707963267948966)
        elseif v68 == 3 then
            v70 = CFrame.new(0, 19.5, 7.5) * CFrame.Angles(1.5707963267948966, 0, 0)
        elseif v68 == 4 then
            v70 = CFrame.new(0, 19.5, -7.5) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
        end
        v69.CFrame = v21 * v70
        v69.Parent = u22
        _G.customEmit(v69)
    end
    task.wait(3)
    local v71 = next
    local v72, v73 = u22:GetDescendants()
    for _, v74 in v71, v72, v73 do
        if v74:IsA("BasePart") then
            u2:Create(v74, TweenInfo.new(1), {
                ["Transparency"] = 1
            }):Play()
        end
    end
    u2:Create(v37, TweenInfo.new(1), {
        ["Transparency"] = 1
    }):Play()
    u2:Create(v24, TweenInfo.new(1), {
        ["Transparency"] = 1
    }):Play()
    task.wait(1)
    u22:Destroy()
    v24:Destroy()
    v37:Destroy()
end
return v1