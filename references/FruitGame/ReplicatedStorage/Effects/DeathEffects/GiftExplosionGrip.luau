 

local v1 = {}
local _ = _G.tween
local u2 = RaycastParams.new()
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
u2.FilterType = Enum.RaycastFilterType.Include
function v1.start(_, p3) --[[ Line: 66 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = workspace:Raycast(p3.Position, Vector3.new(0, -100, 0), u2)
    local u5 = v4 and CFrame.new(v4.Position) or p3
    local v6 = script.Gift:Clone()
    v6:PivotTo(u5 * CFrame.new(0, 14, 0))
    v6.Parent = workspace.Effects
    v6.PrimaryPart.Anchored = true
    _G.customEmit(v6.PrimaryPart)
    _G.PlaySound(u5, script.GiftGrip)
    for _, v7 in v6:GetChildren() do
        local v8 = v7.Size
        v7.Size = v7.Size * 0.1
        game.TweenService:Create(v7, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.2), {
            ["Size"] = v8,
            ["CFrame"] = v7.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
        }):Play()
    end
    task.wait(0.5)
    v6.PrimaryPart.Anchored = false
    local v9 = game.TweenService:Create(v6.PrimaryPart, TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        ["CFrame"] = u5 * CFrame.new(0, 0, 0)
    })
    local u10 = game.TweenService:Create(v6.PrimaryPart, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["CFrame"] = u5 * CFrame.new(0, 5, 0)
    })
    for _, v11 in v6:GetChildren() do
        v11.CollisionGroup = "Players"
    end
    v9:Play()
    v9.Completed:Connect(function() --[[ Line: 96 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        task.wait(0.05)
        u10:Play()
    end)
    task.delay(0.2, function() --[[ Line: 101 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        local v12 = script.Wind
        local v13 = u5 * CFrame.new(0, 3.5, 0)
        local v14 = v12:Clone()
        v14.Parent = workspace.Effects
        v14.CFrame = v13
        _G.customEmit(v14)
        _G.destroy(v14, 3)
        task.wait(0.1)
        local v15 = script.Crash
        local v16 = u5 * CFrame.new(0, 0.05, 0)
        local v17 = v15:Clone()
        v17.Parent = workspace.Effects
        v17.CFrame = v16
        _G.customEmit(v17)
        _G.destroy(v17, 3)
        local v18 = script.Glow
        local v19 = u5 * CFrame.new(0, 2.5, 0)
        local v20 = v18:Clone()
        v20.Parent = workspace.Effects
        v20.CFrame = v19
        _G.customEmit(v20)
        _G.destroy(v20, 3)
    end)
    task.wait(1.1)
    v6.PrimaryPart.Anchored = true
    for _, v21 in v6:GetChildren() do
        v21.CanCollide = false
        game.TweenService:Create(v21, TweenInfo.new(0.2), {
            ["Size"] = v21.Size * 1.45
        }):Play()
    end
    game.TweenService:Create(v6.Top, TweenInfo.new(0.2), {
        ["Position"] = v6.Top.Position + Vector3.new(0, 1, 0)
    }):Play()
    game.TweenService:Create(v6.ActualRibbon, TweenInfo.new(0.2), {
        ["Position"] = v6.ActualRibbon.Position + Vector3.new(0, 2, 0)
    }):Play()
    task.wait(0.13)
    for _, v22 in v6:GetDescendants() do
        if v22:IsA("MeshPart") or v22:IsA("Texture") then
            v22.Transparency = 1
        end
    end
    _G.destroy(v6, 4)
    local v23 = script.Explode
    local v24 = u5 * CFrame.new(0, 2.3, 0)
    local v25 = v23:Clone()
    v25.Parent = workspace.Effects
    v25.CFrame = v24
    _G.customEmit(v25)
    _G.destroy(v25, 3)
end
return v1