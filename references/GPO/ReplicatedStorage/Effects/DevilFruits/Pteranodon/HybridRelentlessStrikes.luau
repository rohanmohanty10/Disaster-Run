 

local u1 = game:GetService("TweenService")
local u2 = game:GetService("RunService")
local u3 = RaycastParams.new()
u3.FilterType = Enum.RaycastFilterType.Include
u3.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
return {
    ["start"] = function(_, p4) --[[ Name: start, Line 12 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u3
        --]]
        local v5 = p4.Character
        if v5 == nil then
            return
        elseif _G.checkRenderDistance(v5.PrimaryPart.Position) ~= false then
            local u6 = v5.HumanoidRootPart
            local u7 = tick()
            local v8 = p4.inFlame ~= nil and script.Flame or script.Base
            local _ = p4.inFlame
            tick()
            local u9 = v8.Enable_Rotate:Clone()
            u9:PivotTo(u6.CFrame * CFrame.new(0, 1, 0))
            _G.destroy(u9, 4)
            local u10 = 0
            local u11 = {}
            for _, v12 in u9:GetDescendants() do
                if v12:IsA("PointLight") then
                    local v13 = v12.Brightness
                    v12.Brightness = 0
                    u1:Create(v12, TweenInfo.new(0.5), {
                        ["Brightness"] = v13
                    }):Play()
                end
            end
            local v14 = Instance.new("Weld")
            v14.Part0 = u6
            v14.Part1 = u9
            v14.C0 = v14.Part0.CFrame:Inverse() * v14.Part1.CFrame
            v14.Parent = u9
            u9.Parent = workspace.Effects
            _G.PlaySound(v5.PrimaryPart, v8.spin).Parent = v5.PrimaryPart
            u1:Create(v14, TweenInfo.new(0.7), {
                ["C0"] = v14.C0 * CFrame.new(0, 9, 0)
            }):Play()
            if v8.Name == "Flame" then
                for _ = 1, 2 do
                    local v15 = v8.Trail:Clone()
                    v15.Parent = workspace.Effects
                    table.insert(u11, v15)
                    _G.destroy(v15, 4)
                end
            end
            local v16 = Instance.new("BodyVelocity")
            v16.MaxForce = Vector3.new(0, 25000, 0)
            v16.Velocity = u6.CFrame.LookVector * 3 + Vector3.new(0, 7, 0)
            v16.Parent = u6
            _G.destroy(v16, 0.805)
            local v27 = u2.Heartbeat:Connect(function(p17) --[[ Line: 75 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u7
                    [3] = u11
                    [4] = u6
                --]]
                u10 = u10 + 1 * p17
                local v18 = tick() - u7
                for v19, v20 in u11 do
                    local v21 = u6.CFrame * CFrame.new(0, 3 + 9 * v18, 0)
                    local v22 = CFrame.Angles
                    local v23 = v19 * 180 + u10 * 1000
                    local v24 = v21 * v22(0, math.rad(v23), 0)
                    local v25 = CFrame.new
                    local v26 = tick() * 16
                    v20.CFrame = v24 * v25(0, math.cos(v26) * 2, 8 + 8 * v18)
                end
            end)
            local u29 = u2.Heartbeat:Connect(function(_) --[[ Line: 84 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u3
                    [3] = u9
                --]]
                local v28 = workspace:Raycast(u6.Position, Vector3.new(0, -10, 0), u3)
                if v28 then
                    _G.recolorParticles(u9.Dust, v28.Instance.Color)
                    _G.particleEnabled(u9.Dust, true)
                    u9.Dust.WorldCFrame = CFrame.new(v28.Position, v28.Position + v28.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
                else
                    _G.particleEnabled(u9.Dust, false)
                end
            end)
            task.delay(0.5, function() --[[ Line: 97 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u9
                --]]
                u29:Disconnect()
                u29 = nil
                _G.particleEnabled(u9.Dust, false)
            end)
            task.wait(0.8)
            v27:Disconnect()
            for _, v30 in u11 do
                for _, v31 in v30:GetDescendants() do
                    if v31:IsA("ParticleEmitter") or v31:IsA("Trail") then
                        v31.Enabled = false
                    end
                end
            end
            for _, v32 in u9.Enable:GetDescendants() do
                if v32:IsA("ParticleEmitter") then
                    v32.LockedToPart = false
                end
            end
            task.wait(0.2)
            local v33 = Instance.new("BodyVelocity")
            v33.MaxForce = Vector3.new(0, 25000, 0)
            v33.Velocity = Vector3.new(0, 32, 0)
            v33.Parent = u6
            _G.destroy(v33, 0.3)
            task.wait(0.1)
            u9.Hit.WorldPosition = v5.LowerTorso.Position + Vector3.new(0, 6, 0)
            _G.PlaySound(v5.PrimaryPart, v8.boom)
            _G.customEmit(u9.Hit)
            for _, v34 in v8.Swirl:GetChildren() do
                local v35 = v34:Clone()
                local v36 = u6.CFrame * CFrame.new(0, 24, 0)
                local v37 = CFrame.Angles
                local v38 = v34.Name == "SwirlA" and 90 or -90
                v35.CFrame = v36 * v37(math.rad(v38), 0, math.random(-100, 100))
                v35.Parent = workspace.Effects
                _G.destroy(v35, 0.35)
                u1:Create(v35, TweenInfo.new(0.35), {
                    ["CFrame"] = v35.CFrame * CFrame.new(0, 0, v34.Name == "SwirlA" and 12 or -12) * CFrame.Angles(0, 0, -3.141592653589793),
                    ["Size"] = v35.Size * 1.3,
                    ["Transparency"] = 1
                }):Play()
            end
            u11 = {}
            u7 = tick()
            for _ = 1, 3 do
                local v39 = v8.Trail:Clone()
                v39.Parent = workspace.Effects
                table.insert(u11, v39)
                _G.destroy(v39, 4)
            end
            local v50 = u2.Heartbeat:Connect(function(p40) --[[ Line: 161 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u7
                    [3] = u11
                    [4] = u6
                --]]
                u10 = u10 + 1 * p40
                local v41 = (tick() - u7) * 2
                for v42, v43 in u11 do
                    local v44 = u6.CFrame * CFrame.new(0, 14 + 39 * v41, 0)
                    local v45 = CFrame.Angles
                    local v46 = v42 * 120 + u10 * 1000
                    local v47 = v44 * v45(0, math.rad(v46), 0)
                    local v48 = CFrame.new
                    local v49 = tick() * 16
                    v43.CFrame = v47 * v48(0, math.cos(v49) * 2, 42 - 25 * v41)
                end
            end)
            task.wait(0.5)
            for _, v51 in u9:GetDescendants() do
                if v51:IsA("ParticleEmitter") or v51:IsA("Trail") then
                    v51.Enabled = false
                elseif v51:IsA("PointLight") then
                    u1:Create(v51, TweenInfo.new(1), {
                        ["Brightness"] = 0
                    }):Play()
                end
            end
            for _, v52 in u11 do
                for _, v53 in v52:GetDescendants() do
                    if v53:IsA("ParticleEmitter") or v53:IsA("Trail") then
                        v53.Enabled = false
                    end
                end
            end
            v50:Disconnect()
            u11 = nil
        end
    end
}