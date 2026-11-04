 

local v1 = {}
local u2 = game:GetService("TweenService")
function PlayAnim(p3, p4)
    local v5 = (p3:FindFirstChild("Humanoid") or p3:FindFirstChild("AnimationController")).Animator:LoadAnimation(Animations[p4])
    v5:Play()
    return v5
end
function CreateMesh(p6, p7)
    local v8 = script:WaitForChild("MeshImage"):Clone()
    v8.CFrame = p7 * CFrame.Angles(0, -1.5707963267948966, 0)
    v8.Parent = workspace.Effects
    v8.Decal.Texture = "rbxassetid://" .. p6
    return v8
end
function Hitbox(p9)
    local v10 = OverlapParams.new()
    local v11 = Enum.RaycastFilterType.Blacklist
    v10.FilterDescendantsInstances = { p9 }
    v10.FilterType = v11
    local v12 = workspace:GetPartBoundsInBox(p9.PrimaryPart.CFrame * CFrame.new(0, 0, -3), Vector3.new(4, 4, 6), v10)
    for _, v13 in next, v12 do
        local v14 = v13.Parent:FindFirstChild("Humanoid") or v13.Parent.Parent:FindFirstChild("Humanoid")
        if v14 then
            return v14
        end
    end
end
function v1.start(_, p15, p16) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p15.PrimaryPart.Position) then
        local v17 = script:WaitForChild("Impale").Attachment:Clone()
        v17.Parent = p15.UpperTorso
        _G.customEmit(v17)
        _G.destroy(v17, 1.5)
        local v18 = CreateMesh("9622414579", p16 * CFrame.new(0, 0, -2.5))
        v18.Mesh.Scale = Vector3.new(0, 0, 0)
        u2:Create(v18.Mesh, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Scale"] = Vector3.new(0.438, 0.333, 0.3225)
        }):Play()
        _G.tween(v18, { 0.6, "Quint", Enum.EasingDirection.Out }, {
            ["CFrame"] = v18.CFrame * CFrame.new(5, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
        })
        _G.tween(v18.Decal, { 0.6, "Quart", Enum.EasingDirection.Out }, {
            ["Transparency"] = 1
        })
        _G.destroy(v18, 0.6)
        task.wait(0.71)
        local v19 = script:WaitForChild("Raw").Attachment:Clone()
        v19.Parent = p15.UpperTorso
        _G.customEmit(v19)
        _G.destroy(v19, 1)
        task.wait(0.5)
        local v20 = script:WaitForChild("Emitter").Attachment:Clone()
        v20.Parent = p15.PrimaryPart
        _G.customEmit(v20)
        _G.destroy(v20, 1.5)
        local v21 = CreateMesh("9572542664", p16 * CFrame.new(0, 0, 3))
        v21.Mesh.Scale = Vector3.new(0, 0.7, 0.7)
        v21.Decal.Transparency = 0.45
        u2:Create(v21.Mesh, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Scale"] = Vector3.new(1, 0, 0)
        }):Play()
        _G.tween(v21, { 0.6, "Quint", Enum.EasingDirection.Out }, {
            ["CFrame"] = v21.CFrame * CFrame.new(20, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
        })
        _G.tween(v21.Decal, { 0.6, "Quart", Enum.EasingDirection.Out }, {
            ["Transparency"] = 1
        })
        _G.destroy(v21, 0.6)
        local v22 = { 9632554664, 9622414579 }
        for v23 = 1, 2 do
            local v24 = CreateMesh(v22[v23], p16 * CFrame.new(0, 0, -4.5))
            v24.Mesh.Scale = Vector3.new(0, 0, 0)
            v24.Decal.Transparency = 0.8 / v23
            local v25 = u2
            local v26 = v24.Mesh
            local v27 = TweenInfo.new(0.45 / v23, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            local v28 = {}
            local v29 = v23 * 0.292
            v28.Scale = Vector3.new(v29, 0.222, 0.215) * (v23 / 4 + 1)
            v25:Create(v26, v27, v28):Play()
            _G.tween(v24, { 0.6 / v23, "Quint", Enum.EasingDirection.Out }, {
                ["CFrame"] = v24.CFrame * CFrame.new(v23 * 5, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
            })
            _G.tween(v24.Decal, { 0.6 / v23, "Quart", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            _G.destroy(v24, 0.6 / v23)
        end
    end
end
return v1