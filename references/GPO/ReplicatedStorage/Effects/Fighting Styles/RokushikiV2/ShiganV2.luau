 

local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Include
u1.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
local u2 = game:GetService("RunService")
local u3 = script.Model
local v4 = {}
local u5 = game:GetService("TweenService")
local u6 = Random.new()
local function u11(p7, p8, p9) --[[ Line: 22 ]]
    for _, v10 in pairs(p7:GetDescendants()) do
        if v10:IsA("ParticleEmitter") then
            if p9 then
                v10.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, p9), ColorSequenceKeypoint.new(1, p9) })
            end
            if p8 == nil then
                _G.customEmit(v10)
            else
                v10.Enabled = p8
            end
        end
    end
end
local u12 = {}
local u13 = script.Model:GetScale()
function v4.start(_, p14, p15, p16) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u3
        [3] = u13
        [4] = u1
        [5] = u11
        [6] = u6
        [7] = u5
        [8] = u2
    --]]
    if p16 == nil then
        return
    elseif _G.checkRenderDistance(p16.PrimaryPart.Position) == false then
        return
    else
        if not u12[p16] then
            u12[p16] = {}
        end
        if p14 == "Start" then
            local v17 = Instance.new("Folder")
            v17.Name = "EffectsFolder"
            v17.Parent = workspace.Effects
            local v18 = p16.PrimaryPart.CFrame
            local v19 = u3.FingerPistols:Clone()
            v19.CFrame = v18 * CFrame.new(0, 0, -5 * u13)
            v19.Parent = v17
            local v20 = workspace:Raycast(v18.Position, Vector3.new(0, -4, 0), u1)
            local v21
            if v20 then
                v21 = u3.FloorWind:Clone()
                v21.Position = v20.Position
                v21.Orientation = p16.PrimaryPart.Orientation
                u11(v21, true, v20.Instance.Color)
                v21.Parent = v17
            else
                v21 = nil
            end
            os.clock()
            while p16:GetAttribute("ShiganV2Hold") ~= nil do
                local v22 = p16.PrimaryPart.CFrame
                v19.CFrame = v22 * CFrame.new(0, 0, -5 * u13)
                local v23 = workspace:Raycast(v22.Position, Vector3.new(0, -4, 0), u1)
                if v23 and v21 then
                    v21.Position = v23.Position
                    v21.Orientation = p16.PrimaryPart.Orientation
                end
                local u24 = u3.Cone:Clone()
                u24.CFrame = v22 * CFrame.new(u6:NextNumber(-5, 5) * u13, u6:NextNumber(-2, 6) * u13, -u6:NextNumber(1, 7) * u13) * CFrame.Angles(0, 0, u6:NextNumber(0, 3.2))
                u24.Decal.Transparency = 1
                u24.Parent = v17
                local u25 = u5:Create(u24.Decal, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Transparency"] = 0.7
                })
                u25:Play()
                local v26 = u6:NextNumber(0.05, 0.3)
                local v27 = u5
                local v28 = u24.Mesh
                local v29 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v30 = {}
                local v31 = u6:NextNumber(2, 4) * u13
                v30.Scale = Vector3.new(v26, v26, v31)
                local u32 = v27:Create(v28, v29, v30)
                u32:Play()
                local u33 = u5:Create(u24, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Position"] = (u24.CFrame * CFrame.new(0, 0, -u6:NextNumber(4, 16) * u13)).Position
                })
                u33:Play()
                task.delay(0.1, function() --[[ Line: 106 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                        [2] = u24
                        [3] = u33
                        [4] = u32
                        [5] = u25
                    --]]
                    local v34 = u5:Create(u24.Decal, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Transparency"] = 1
                    })
                    v34:Play()
                    task.wait(0.3)
                    v34:Destroy()
                    u33:Destroy()
                    u32:Destroy()
                    u25:Destroy()
                end)
                task.wait(u6:NextNumber(0.02, 0.05))
            end
            for _, v35 in pairs(v19:GetDescendants()) do
                if v35:IsA("ParticleEmitter") then
                    v35.Enabled = false
                end
            end
            if v21 then
                for _, v36 in pairs(v21:GetDescendants()) do
                    if v36:IsA("ParticleEmitter") then
                        v36.Enabled = false
                    end
                end
            end
            task.wait(3.5)
            v17:Destroy()
        elseif p15 == "Projectile" then
            u12[p15] = true
            local v37 = p16.PrimaryPart.CFrame
            local u38 = Instance.new("Folder")
            u38.Name = "EffectsFolder"
            u38.Parent = workspace
            local u39 = u3.Projectile:Clone()
            u39.CFrame = v37
            u39.Parent = u38
            local v40 = u3.FireProj:Clone()
            v40.CFrame = v37 * CFrame.new(0, 0, -3 * u13)
            v40.Parent = u38
            for _, v41 in pairs(v40:GetDescendants()) do
                if v41:IsA("ParticleEmitter") then
                    _G.customEmit(v41)
                end
            end
            local v42 = workspace:Raycast(v37.Position, Vector3.new(0, -5, 0), u1)
            if v42 then
                local v43 = u3.ProjFloorWind:Clone()
                v43.CFrame = CFrame.lookAt(v42.Position, v42.Position + v42.Normal)
                v43.Parent = u38
                u11(v43, nil, v42.Instance.Color)
            end
            local u44 = os.clock()
            local u45 = os.clock()
            local u46 = nil
            u46 = u2.Heartbeat:Connect(function(p47) --[[ Line: 166 ]]
                --[[
                Upvalues:
                    [1] = u39
                    [2] = u44
                    [3] = u3
                    [4] = u38
                    [5] = u5
                    [6] = u6
                    [7] = u45
                    [8] = u46
                --]]
                u39.CFrame = u39.CFrame * CFrame.new(0, 0, -400 * p47)
                if os.clock() - u44 >= 0.04 then
                    u44 = os.clock()
                    local u48 = u3.Cone:Clone()
                    u48.CFrame = u39.CFrame
                    u48.Parent = u38
                    local u49 = u5:Create(u48.Decal, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Transparency"] = 0.7
                    })
                    u49:Play()
                    local v50 = u6:NextNumber(0.05, 0.3)
                    local v51 = u5
                    local v52 = u48.Mesh
                    local v53 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local v54 = {}
                    local v55 = u6
                    v54.Scale = Vector3.new(v50, v50, v55:NextNumber(13, 16))
                    local u56 = v51:Create(v52, v53, v54)
                    u56:Play()
                    local u57 = u5:Create(u48, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Position"] = (u48.CFrame * CFrame.new(0, 0, u6:NextNumber(3, 7))).Position
                    })
                    u57:Play()
                    task.delay(0.1, function() --[[ Line: 190 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u48
                            [3] = u57
                            [4] = u56
                            [5] = u49
                        --]]
                        local v58 = u5:Create(u48.Decal, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Transparency"] = 1
                        })
                        v58:Play()
                        task.wait(0.3)
                        v58:Destroy()
                        u57:Destroy()
                        u56:Destroy()
                        u49:Destroy()
                    end)
                end
                if os.clock() - u45 >= 0.4 then
                    local v59 = u39
                    for _, v60 in pairs(v59:GetDescendants()) do
                        if v60:IsA("ParticleEmitter") then
                            v60.Enabled = false
                        end
                    end
                    u46:Disconnect()
                    task.wait(3.5)
                    u38:Destroy()
                end
            end)
        end
    end
end
return v4