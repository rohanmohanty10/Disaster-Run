 

local u1 = game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
local u2 = game:GetService("TweenService")
local _ = workspace.CurrentCamera
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
Mouse = Ess.Mouse
local v3 = RaycastParams.new()
v3.FilterType = Enum.RaycastFilterType.Include
v3.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
return {
    ["start"] = function(_, u4, p5, p6, p7) --[[ Name: start, Line 22 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        if u4 == nil then
            return
        elseif _G.checkRenderDistance(u4.PrimaryPart.Position) == false then
            return
        else
            local v8 = u4.HumanoidRootPart
            local u9 = script.Flame
            local u10 = u4.PteraFullForm.RootPart:FindFirstChild("Neck_2", true)
            if p5 == "StartEmit" then
                local v11 = u9.Dive_Part:Clone()
                v11.CFrame = v8.CFrame * CFrame.new(0, 5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
                v11.Anchored = true
                v11.Parent = workspace.Effects
                _G.destroy(v11, 3)
                for _, v12 in v11:GetDescendants() do
                    if v12:IsA("ParticleEmitter") or v12:IsA("Trail") then
                        v12.Enabled = false
                        _G.customEmit(v12)
                    end
                end
                return
            elseif p5 == "Hit" then
                if u9:FindFirstChild("Hit") then
                    local v13 = u9.Hit:Clone()
                    v13.CFrame = CFrame.new(p6.Position, p6.Position + p6.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.06, 0)
                    v13.Parent = workspace.Effects
                    _G.destroy(v13, 5)
                    for _, v14 in v13:GetDescendants() do
                        if v14:IsA("ParticleEmitter") or v14:IsA("Trail") then
                            v14.Enabled = false
                            _G.customEmit(v14)
                        end
                    end
                    if p7 ~= nil and (game.Players.LocalPlayer.Character:GetPivot().Position - u4:GetPivot().Position).Magnitude <= 25 then
                        _G.PlayEffect("GroundRocks4", nil, {
                            ["Segments"] = 20,
                            ["Position"] = v13.Position + Vector3.new(0, 1, 0),
                            ["DistanceRandomness"] = Vector2.new(0.5, 1),
                            ["Duration"] = 2,
                            ["TweenDuration"] = 0.5,
                            ["Radius"] = 27,
                            ["Direction"] = v13.CFrame.UpVector * -25
                        })
                        _G.PlayEffect("RockDebris", nil, {
                            ["PartCount"] = 25,
                            ["RandomVelocityMagnitude"] = Vector2.new(-75, 75),
                            ["Position"] = v13.Position + Vector3.new(0, 1, 0),
                            ["Direction"] = v13.CFrame.UpVector * 125,
                            ["RaycastDirection"] = v13.CFrame.UpVector * -25,
                            ["Size"] = Vector3.new(1.2, 1.2, 1.2),
                            ["TrailEnabled"] = true
                        }, true)
                        local v15 = script.Impact_CC:Clone()
                        local v16 = script.impact:Clone()
                        v16.Parent = game.Lighting
                        v15.Parent = game.Lighting
                        game.Lighting.ColorCorrection.Enabled = false
                        v15.Enabled = true
                        task.wait(0.06)
                        v15.Enabled = false
                        v16.Enabled = true
                        task.wait(0.05)
                        v16.Enabled = false
                        game.Lighting.ColorCorrection.Enabled = true
                        v15:Destroy()
                        v16:Destroy()
                    end
                end
            else
                local _ = u4.PteraFullForm.PrimaryPart
                local u17 = 0
                local u18 = tick()
                local u19 = {}
                local u20 = p5 == "Ult"
                local u21
                if u20 then
                    u21 = u9.Charge:Clone()
                    local _, _, _, v22, v23, v24, v25, v26, v27, v28, v29, v30 = u4.PteraFullForm.PrimaryPart.CFrame:components()
                    local v31 = u10.TransformedWorldCFrame.Position
                    u21.CFrame = CFrame.new(v31.X, v31.Y, v31.Z, v22, v23, v24, v25, v26, v27, v28, v29, v30)
                    u21.Anchored = true
                    u21.Parent = workspace.Effects
                    _G.customWeld(u21, u10, CFrame.new(0, 5, 0), u21)
                else
                    u21 = nil
                end
                local u32 = u9.Soar:Clone()
                local _, _, _, v33, v34, v35, v36, v37, v38, v39, v40, v41 = u4.PteraFullForm.PrimaryPart.CFrame:components()
                local v42 = u10.TransformedWorldCFrame.Position
                u32.CFrame = CFrame.new(v42.X, v42.Y, v42.Z, v33, v34, v35, v36, v37, v38, v39, v40, v41) * CFrame.Angles(-1.5707963267948966, 0, 0)
                u32.Anchored = true
                u32.Parent = workspace.Effects
                if u20 then
                    local v43 = u9.Dive_Part:Clone()
                    local _, _, _, v44, v45, v46, v47, v48, v49, v50, v51, v52 = u4.PteraFullForm.PrimaryPart.CFrame:components()
                    local v53 = u10.TransformedWorldCFrame.Position
                    v43.CFrame = CFrame.new(v53.X, v53.Y, v53.Z, v44, v45, v46, v47, v48, v49, v50, v51, v52)
                    v43.Anchored = true
                    v43.Parent = workspace.Effects
                    _G.destroy(v43, 3)
                    for _, v54 in v43:GetDescendants() do
                        if v54:IsA("ParticleEmitter") or v54:IsA("Trail") then
                            v54.Enabled = false
                            _G.customEmit(v54)
                        end
                    end
                    task.delay(0.4, function() --[[ Line: 168 ]]
                        --[[
                        Upvalues:
                            [1] = u21
                        --]]
                        if u21 then
                            for _, v55 in u21:GetDescendants() do
                                if v55:IsA("ParticleEmitter") or v55:IsA("Trail") then
                                    v55.Enabled = false
                                end
                            end
                        end
                    end)
                end
                task.delay(0.9, function() --[[ Line: 180 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u4
                        [3] = u32
                        [4] = u9
                        [5] = u10
                    --]]
                    if u20 then
                        if u4:GetAttribute("PteraUltStart") ~= nil then
                            for _, v56 in u32:GetDescendants() do
                                if v56:IsA("ParticleEmitter") or v56:IsA("Trail") then
                                    v56.Enabled = true
                                end
                            end
                            local v57 = u9.Dive_Part:Clone()
                            local _, _, _, v58, v59, v60, v61, v62, v63, v64, v65, v66 = u4.PteraFullForm.PrimaryPart.CFrame:components()
                            local v67 = u10.TransformedWorldCFrame.Position
                            v57.CFrame = CFrame.new(v67.X, v67.Y, v67.Z, v58, v59, v60, v61, v62, v63, v64, v65, v66) * CFrame.Angles(-1.5707963267948966, 0, 0)
                            v57.Anchored = true
                            v57.Parent = workspace.Effects
                            _G.destroy(v57, 3)
                            for _, v68 in v57:GetDescendants() do
                                if v68:IsA("ParticleEmitter") or v68:IsA("Trail") then
                                    v68.Enabled = false
                                    _G.customEmit(v68)
                                end
                            end
                            _G.PlaySound(u4.PrimaryPart, script["Audio/PteraFlameSlam"]).Parent = u4.PrimaryPart
                            task.wait(1.5)
                            for _, v69 in v57:GetDescendants() do
                                if v69:IsA("ParticleEmitter") or v69:IsA("Trail") then
                                    v69.Enabled = false
                                end
                            end
                        end
                    else
                        return
                    end
                end)
                local _, _, _, v70, v71, v72, v73, v74, v75, v76, v77, v78 = u4.PteraFullForm.PrimaryPart.CFrame:components()
                local v79 = u10.TransformedWorldCFrame.Position
                local v80 = CFrame.new(v79.X, v79.Y, v79.Z, v70, v71, v72, v73, v74, v75, v76, v77, v78)
                for v81 = 1, 3 do
                    local v82 = tick() - u18
                    local v83 = u9.Trail:Clone()
                    local v84 = CFrame.Angles
                    local v85 = v81 * 120 + u17 * 500
                    local v86 = v80 * v84(1.5707963267948966, -math.rad(v85), 0)
                    local v87 = CFrame.new
                    local v88 = tick() * 16
                    v83.CFrame = v86 * v87(0, math.cos(v88) * 2, 8 + 8 * v82)
                    v83.Parent = workspace.Effects
                    table.insert(u19, v83)
                end
                local v109 = u1.RenderStepped:Connect(function(p89) --[[ Line: 229 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                        [2] = u18
                        [3] = u4
                        [4] = u10
                        [5] = u19
                        [6] = u32
                    --]]
                    u17 = u17 + 1 * p89
                    local v90 = tick() - u18
                    local _, _, _, v91, v92, v93, v94, v95, v96, v97, v98, v99 = u4.PteraFullForm.PrimaryPart.CFrame:components()
                    local v100 = u10.TransformedWorldCFrame.Position
                    local v101 = CFrame.new(v100.X, v100.Y, v100.Z, v91, v92, v93, v94, v95, v96, v97, v98, v99)
                    for v102, v103 in u19 do
                        local v104 = CFrame.Angles
                        local v105 = v102 * 120 + u17 * 800
                        local v106 = v101 * v104(1.5707963267948966, math.rad(v105), 0)
                        local v107 = CFrame.new
                        local v108 = tick() * 16
                        v103.CFrame = v106 * v107(0, math.cos(v108) * 2, 8 + 8 * v90)
                    end
                    u32.CFrame = v101 * CFrame.Angles(-1.5707963267948966, 0, 0)
                end)
                if u4:GetAttribute("PteraUltStart") then
                    repeat
                        task.wait()
                    until u4:GetAttribute("PteraUltStart") == nil
                end
                v109:Disconnect()
                for _, v110 in u32:GetDescendants() do
                    if v110:IsA("ParticleEmitter") or v110:IsA("Trail") then
                        v110.Enabled = false
                    elseif v110:IsA("PointLight") then
                        u2:Create(v110, TweenInfo.new(1), {
                            ["Brightness"] = 0,
                            ["Range"] = v110.Range * 1.25
                        }):Play()
                    end
                end
                for _, v111 in u19 do
                    _G.destroy(v111, 2)
                    for _, v112 in v111:GetDescendants() do
                        if v112:IsA("ParticleEmitter") or v112:IsA("Trail") then
                            v112.Enabled = false
                        end
                    end
                end
                _G.destroy(u32, 4)
                if u21 then
                    _G.destroy(u21, 4)
                    for _, v113 in u21:GetDescendants() do
                        if v113:IsA("ParticleEmitter") or v113:IsA("Trail") then
                            v113.Enabled = false
                        end
                    end
                end
                return
            end
        end
    end
}