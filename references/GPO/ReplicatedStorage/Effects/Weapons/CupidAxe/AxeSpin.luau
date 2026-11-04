 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local v3 = {}
function TweenRotation(u4, p5, p6)
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local u7 = Instance.new("NumberValue")
    local v8 = u2:Create(u7, p6, {
        ["Value"] = p5
    })
    v8:Play()
    local u9 = 0
    local u14 = u1.RenderStepped:Connect(function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u7
            [3] = u9
        --]]
        local v10 = u4
        local v11 = u4.CFrame
        local v12 = CFrame.Angles
        local v13 = u7.Value - u9
        v10.CFrame = v11 * v12(0, math.rad(v13), 0)
        u9 = u7.Value
    end)
    local u15 = nil
    u15 = v8.Completed:Connect(function() --[[ Line: 16 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u15
            [3] = u7
        --]]
        u14:Disconnect()
        u15:Disconnect()
        u7:Destroy()
    end)
end
function v3.start(_, p16) --[[ Line: 23 ]]
    if _G.checkRenderDistance(p16.PrimaryPart.Position) ~= false then
        local u17 = {}
        for _, v18 in script.meshes:GetChildren() do
            local v19 = v18:Clone()
            u17[v19.Name] = v19
            v19.CFrame = p16.HumanoidRootPart.CFrame
            v19.Parent = workspace.Effects
            v19.Decal.Transparency = 1
            v19.Mesh.Scale = v19.Mesh.Scale * 0.9
            _G.destroy(v19, 5)
        end
        local v20 = script.particles:Clone()
        v20.Parent = workspace.Effects
        u17.Main.CFrame = u17.Main.CFrame * CFrame.Angles(0, 0, 3.141592653589793) * CFrame.Angles(0, 0.6981317007977318, 0)
        TweenRotation(u17.Main, 700, TweenInfo.new(0.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
        _G.tween(u17.Main.Decal, { 0.2, "Sine", Enum.EasingDirection.In }, {
            ["Transparency"] = 0
        })
        _G.tween(u17.Main.Mesh, { 0.8, "Quad", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(4.5, 4, 4.5)
        })
        TweenRotation(u17.Detail, -460, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
        _G.tween(u17.Detail.Decal, { 0.2, "Sine", Enum.EasingDirection.In }, {
            ["Transparency"] = 0
        })
        _G.tween(u17.Detail.Mesh, { 0.8, "Quad", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(4.25, 1, 4.25)
        })
        u17.Wind1.Mesh.Scale = u17.Wind1.Mesh.Scale * 0.6
        TweenRotation(u17.Wind1, -250, TweenInfo.new(0.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
        _G.tween(u17.Wind1.Decal, { 0.3, "Sine", Enum.EasingDirection.In }, {
            ["Transparency"] = 0.9
        })
        _G.tween(u17.Wind1.Mesh, { 1, "Quint", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(4.93, 2, 4.93)
        })
        u17.Wind2.Mesh.Scale = u17.Wind2.Mesh.Scale * 0.6
        TweenRotation(u17.Wind2, -100, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
        _G.tween(u17.Wind2.Decal, { 0.3, "Sine", Enum.EasingDirection.In }, {
            ["Transparency"] = 0.9
        })
        _G.tween(u17.Wind2.Mesh, { 1, "Quint", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(4.25, 1.5, 4.25)
        })
        v20.CFrame = p16.HumanoidRootPart.CFrame
        _G.tween(v20.Attachment.PointLight, { 1, "Quad", Enum.EasingDirection.Out }, {
            ["Brightness"] = 0
        })
        for _, v21 in v20.Attachment:GetChildren() do
            if v21:IsA("ParticleEmitter") then
                _G.customEmit(v21)
            end
        end
        task.spawn(function() --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            task.wait(0.2)
            _G.tween(u17.Main.Decal, { 0.4, "Sine", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            _G.tween(u17.Detail.Decal, { 0.2, "Sine", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            _G.tween(u17.Wind1.Decal, { 0.5, "Quad", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            _G.tween(u17.Wind2.Decal, { 0.5, "Quad", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
        end)
        _G.destroy(v20, 4)
        local v22 = Ray.new(p16.PrimaryPart.Position, p16.PrimaryPart.CFrame.upVector * -10)
        local v23, v24, v25 = _G.raycastWhitelist(v22, { workspace.Islands, workspace.Ships, workspace.Env })
        if v23 then
            local v26 = script.Impact:Clone()
            v26.CFrame = CFrame.new(v24, v24 + v25) * CFrame.Angles(1.5707963267948966, 0, 0)
            v26.Attachment.sm2.Color = ColorSequence.new(v23.Color)
            v26.Parent = workspace.Effects
            _G.customEmit(v26)
            _G.destroy(v26, 3)
        end
    end
end
return v3