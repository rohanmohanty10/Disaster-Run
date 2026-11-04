 

local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Include
u1.FilterDescendantsInstances = { workspace.Ships, workspace.Env, workspace.Islands }
local u2 = script
local v3 = {}
local u4 = game:GetService("TweenService")
local u5 = Random.new()
function v3.start(_, u6, p7, p8) --[[ Line: 76 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u1
        [4] = u5
    --]]
    if u6 == nil then
        return
    elseif _G.checkRenderDistance(u6.PrimaryPart.Position) ~= false then
        local u9 = Instance.new("Folder")
        u9.Name = "EffectsFolder"
        u9.Parent = workspace.Effects
        local _ = u6.PrimaryPart.CFrame
        local v10 = u2.Dash:Clone()
        v10.Weld.Part0 = u6.PrimaryPart
        local v11, _, _ = _G.getRayFloor(u6.PrimaryPart.CFrame, 5)
        if v11 then
            _G.recolorParticles(v10, v11.Color)
        end
        v10.Parent = u9
        local v12 = Instance.new("Highlight")
        v12.OutlineTransparency = 1
        v12.FillTransparency = 0
        v12.FillColor = Color3.fromRGB(255, 255, 255)
        v12.Parent = u6
        local v13 = u4:Create(v12, TweenInfo.new(p8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ["FillTransparency"] = 1
        })
        v13:Play()
        local v14 = workspace:Raycast(u6.PrimaryPart.Position, Vector3.new(0, -4, 0), u1)
        local v15
        if v14 == nil then
            v15 = false
        else
            v15 = v14.Instance ~= nil
        end
        if v14 then
            if v15 == true then
                local v16 = v10.Dirt
                for _, v17 in pairs(v16:GetDescendants()) do
                    if v17:IsA("ParticleEmitter") then
                        v17.Enabled = true
                    end
                end
                local v18 = v10.Attachment
                for _, v19 in pairs(v18:GetDescendants()) do
                    if v19:IsA("ParticleEmitter") then
                        v19.Enabled = true
                    end
                end
                v15 = false
            end
        elseif v15 == false then
            local v20 = v10.Dirt
            for _, v21 in pairs(v20:GetDescendants()) do
                if v21:IsA("ParticleEmitter") then
                    v21.Enabled = false
                end
            end
            local v22 = v10.Attachment
            for _, v23 in pairs(v22:GetDescendants()) do
                if v23:IsA("ParticleEmitter") then
                    v23.Enabled = false
                end
            end
            v15 = true
        end
        local v24 = os.clock()
        local v25 = os.clock()
        while os.clock() - v25 <= p8 do
            if workspace:Raycast(u6.PrimaryPart.Position, Vector3.new(0, -7, 0), u1) then
                if v15 == true then
                    local v26 = v10.Dirt
                    for _, v27 in pairs(v26:GetDescendants()) do
                        if v27:IsA("ParticleEmitter") then
                            v27.Enabled = true
                        end
                    end
                    local v28 = v10.Attachment
                    for _, v29 in pairs(v28:GetDescendants()) do
                        if v29:IsA("ParticleEmitter") then
                            v29.Enabled = true
                        end
                    end
                    v15 = false
                end
            elseif v15 == false then
                local v30 = v10.Dirt
                for _, v31 in pairs(v30:GetDescendants()) do
                    if v31:IsA("ParticleEmitter") then
                        v31.Enabled = false
                    end
                end
                local v32 = v10.Attachment
                for _, v33 in pairs(v32:GetDescendants()) do
                    if v33:IsA("ParticleEmitter") then
                        v33.Enabled = false
                    end
                end
                v15 = true
            end
            if os.clock() - v24 >= 0.04 then
                v24 = os.clock()
                task.spawn(function() --[[ Line: 149 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u6
                        [3] = u5
                        [4] = u9
                        [5] = u4
                    --]]
                    local v34 = u2.Shockwave:Clone()
                    v34.Weld.Part0 = u6.PrimaryPart
                    v34.Weld.C0 = v34.Weld.C0 * CFrame.Angles(0, 0, u5:NextNumber(0, 6.283185307179586))
                    v34.Parent = u9
                    local v35 = u4:Create(v34.Mesh, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["Scale"] = Vector3.new(0, 0, 15)
                    })
                    v35:Play()
                    local v36 = u4:Create(v34.Weld, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["C0"] = v34.Weld.C0 * CFrame.new(0, 0, 8)
                    })
                    v36:Play()
                    u4:Create(v34.Decal, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["Transparency"] = 0.9
                    }):Play()
                    task.wait(0.15)
                    local v37 = u4:Create(v34.Decal, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["Transparency"] = 1
                    })
                    v37:Play()
                    _G.destroy({
                        v36,
                        v37,
                        v35,
                        v34
                    }, 0.4)
                end)
            end
            local v38 = u2.Wind:Clone()
            local v39 = u6.PrimaryPart.CFrame
            local v40 = CFrame.Angles
            local v41 = math.random(0, 360)
            v38.CFrame = v39 * v40(1.5707963267948966, math.rad(v41), 0)
            v38.Parent = u9
            u4:Create(v38, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["CFrame"] = v38.CFrame * CFrame.new(0, 3, 0) * CFrame.Angles(0, -3.141592653589793, 0),
                ["Size"] = Vector3.new(25, 10, 25)
            }):Play()
            u4:Create(v38, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Transparency"] = 1
            }):Play()
            task.wait(u5:NextNumber(0.015, 0.025))
        end
        v12:Destroy()
        v13:Destroy()
        for _, v42 in pairs(v10:GetDescendants()) do
            if v42:IsA("ParticleEmitter") then
                v42.Enabled = false
            end
        end
        if p7 then
            local v43 = u2.WallHit:Clone()
            v43.CFrame = CFrame.lookAt(p7.Position, p7.Position + p7.Normal)
            v43.Parent = u9
            _G.customEmit(v43)
        end
        _G.destroy(u9, 5)
    end
end
return v3