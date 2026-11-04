 

local v1 = {}
require(game.ReplicatedStorage.Modules.sBeat)
function v1.start(_, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11) --[[ Line: 4 ]]
    local v12 = _G.awaitObject(p2)
    if v12 == nil then
        return
    end
    if _G.checkRenderDistance(v12.Position) == false then
        return
    end
    local v13 = p6 == nil and 0.5 or p6
    local v14 = p7 == nil and 2 or p7
    local v15 = p8 == nil and 0 or p8
    local _ = p10 == nil
    if p9 == nil then
        p9 = CFrame.new(0, 0, 0)
    end
    local v16 = tick()
    local v17 = script.trail:Clone()
    v17.Transparency = 1
    v17.CanCollide = false
    v17.Anchored = true
    v17.Size = Vector3.new(0.1, 0.1, 0.1)
    v17.Parent = workspace.Effects
    if v17:FindFirstChild("Mesh") then
        v17.Mesh:Destroy()
    end
    local v18 = Instance.new("Attachment")
    local v19 = -v14 / 2
    v18.Position = Vector3.new(v19, 0, 0)
    v18.Parent = v17
    local v20 = Instance.new("Attachment")
    local v21 = v14 / 2
    v20.Position = Vector3.new(v21, 0, 0)
    v20.Parent = v17
    local u22 = script.TrailInstance:Clone()
    u22.Attachment0 = v18
    u22.Attachment1 = v20
    u22.Color = ColorSequence.new(p4)
    u22.Lifetime = v13
    u22.FaceCamera = true
    u22.Parent = v17
    local v23 = v12.CFrame * p9
    local v24 = CFrame.new(v23.Position + Vector3.new(0, 1, 0)) * CFrame.new(0, v12.Size.Y / 2, 0)
    local v25 = Ray.new(v24.Position, v24.upVector * -(v12.Size.Y * 2 + v15))
    local _, v26 = _G.raycastWhitelist(v25, { workspace.Islands, workspace.Env, workspace.Ships })
    v17.CFrame = CFrame.new(v26)
    local _ = v23.Position
    local u27 = Instance.new("Color3Value")
    u27.Value = p4
    u27.Parent = v17
    _G.tween(u27, {
        v13,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Value"] = p5
    })
    u27:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 77 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u27
        --]]
        u22.Color = ColorSequence.new(u27.Value)
    end)
    local v28 = v12
    while true do
        local _ = (v28.CFrame * p9).Position
        local v29 = v28.CFrame * p9
        local v30 = CFrame.new(v29.Position + Vector3.new(0, 1, 0)) * CFrame.new(0, v28.Size.Y / 2, 0)
        local v31 = Ray.new(v30.Position, v30.upVector * -(v28.Size.Y * 2 + v15))
        local v32, v33 = _G.raycastWhitelist(v31, { workspace.Islands, workspace.Env, workspace.Ships })
        if v32 then
            local v34 = v33 - v26
            if v34.Magnitude > 0.01 then
                local v35 = CFrame.new
                local v36 = v34.X
                local v37 = v34.Z
                v17.CFrame = v35(v33, v33 + Vector3.new(v36, 0, v37))
            else
                v17.CFrame = CFrame.new(v33)
            end
        else
            v33 = v26
        end
        task.wait()
        if p3 and p3 <= tick() - v16 or v12:IsDescendantOf(workspace) == false then
            u22.Enabled = false
            if p11 and p11.fadeTime then
                v13 = p11.fadeTime
            end
            _G.destroy(v17, v13)
            return
        end
        v26 = v33
    end
end
return v1