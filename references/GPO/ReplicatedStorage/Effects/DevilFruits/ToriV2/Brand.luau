 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
local u3 = require(script.ModuleScript)
local v4 = {}
local u5 = {}
function v4.start(_, p6, u7, p8) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u1
        [3] = u2
        [4] = u3
    --]]
    if _G.checkRenderDistance(p6.PrimaryPart.Position) == false then
        return
    else
        Random.new()
        local u9 = p6.PrimaryPart
        local v10 = p6:FindFirstChild("Humanoid")
        local v11 = p6:FindFirstChild("PhoenixFullForm")
        v10.Animator:LoadAnimation(script.Parent.Anims.Hybrid.BrandKick)
        local v12 = p6.PhoenixFullForm.Body.Transparency == 0
        if p8 == nil then
            if v11.Body.Transparency == 1 then
                v10.Animator:LoadAnimation(script.Parent.Anims.Hybrid.BrandDash)
            else
                v11.AnimationController.Animator:LoadAnimation(script.Parent.Anims.Full.BrandDash)
            end
            local v13 = p6:FindFirstChild("CharacterEffects")
            local v14 = script.Dash:Clone()
            local v15 = script.Brand:Clone()
            local v16 = script.Startup:Clone()
            v16.Part.RigidConstraint.Attachment1 = u9:FindFirstChild("RootRigAttachment")
            v16:PivotTo(u9.CFrame)
            v16.Parent = v13
            if v12 == false then
                v15:Destroy()
                v15 = script.Brand2:Clone()
                _G.scaleParticle(v14.Part, 0.75, true)
            else
                _G.scaleParticle(v16, 1.25, true)
                _G.scaleParticle(v14, 1.25, true)
            end
            u5[p6] = { v14, v15, v16 }
            _G.PlaySound(u9, script.BrandSFX.PhoenixBrandStart).Parent = u9
            _G.PlaySound(u9, script.BrandSFX.PhoenixBrandLoop).Parent = u9
            Emit(v16:GetDescendants(), false)
            _G.destroy(v16, 60)
            return
        else
            local v17 = u5[p6]
            local u18, v19, v20 = unpack(v17)
            if u18 ~= nil then
                u5[p6] = nil
                for _, v21 in u9:GetChildren() do
                    if v21:IsA("Sound") and v21.Name:match("PhoenixBrandLoop") then
                        v21:Stop()
                        v21:Destroy()
                    end
                end
                Emit(v20:GetDescendants(), false)
                Ess.Destroy(v20, 0.35)
                task.wait(0.43)
                _G.PlaySound(u9, script.BrandSFX.PhoenixBrandWhoosh).Parent = u9
                local v22 = u9.CFrame
                local u23 = CFrame.new(v22.Position, p8)
                local v24 = v12 == true and 2 or 1
                local v25 = (u23.Position - p8).Magnitude
                local v26 = v24 * 150
                local v27 = math.clamp(v25, 0, v26) - 3
                local v28 = v24 * 150
                local u29 = math.clamp(v27, -3, v28)
                local u30 = u29 / (v24 * 300)
                u18:PivotTo(u23)
                u18.Parent = workspace.Effects
                Emit(u18.Part:GetDescendants(), true)
                Emit(u18.RootPart:GetDescendants(), false, u30)
                local u31 = tick()
                Ess.Destroy(u1.Stepped:Connect(function() --[[ Line: 123 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                        [2] = u7
                        [3] = u9
                        [4] = u23
                        [5] = u29
                        [6] = u30
                        [7] = u18
                    --]]
                    local v32 = tick() - u31
                    if u7 == game.Players.LocalPlayer then
                        local v33 = u9
                        local v34 = u23
                        local v35 = CFrame.new
                        local v36 = -u29
                        local v37 = v32 / u30
                        v33.CFrame = v34 * v35(0, 0, v36 * math.clamp(v37, 0, 1))
                    end
                    u18.RootPart.CFrame = u9.CFrame
                end), u30)
                task.delay(u30 * 0.9, function() --[[ Line: 132 ]] end)
                local u38 = u18.Model
                local v39 = u30 / 1.65
                local u40 = u29
                for _, v41 in u38:GetChildren() do
                    TweenCreate(v41, TweenInfo.new(v39, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Size"] = v41.Size * Vector3.new(2.35, 1.5, 2.35)
                    })
                    TweenCreate(v41, TweenInfo.new(v39, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                        ["Transparency"] = 1
                    })
                end
                for _, v42 in u18.RootPart:GetChildren() do
                    if v42.Name:match("Trail") and v42:IsA("Attachment") then
                        TweenCreate(v42, TweenInfo.new(u30, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
                            ["Position"] = v42.Position * Vector3.new(0.25, 1, 1)
                        })
                    end
                end
                local u43 = u38:GetPivot()
                local u44 = tick()
                tick()
                Ess.Destroy(u1.RenderStepped:Connect(function() --[[ Line: 197 ]]
                    --[[
                    Upvalues:
                        [1] = u44
                        [2] = u2
                        [3] = u30
                        [4] = u38
                        [5] = u43
                        [6] = u40
                        [7] = u9
                        [8] = u3
                        [9] = u18
                    --]]
                    local v45 = tick() - u44
                    local v46 = u2:GetValue(v45 / u30, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local v47 = u38
                    local v48 = u43:Lerp(u43 * CFrame.new(0, 0, -u40 / 2), v46)
                    local v49 = CFrame.Angles
                    local v50 = v45 * 400 % 360
                    local v51 = math.ceil(v50)
                    local v52 = math.abs(v51)
                    v47:PivotTo(v48 * v49(0, 0, -math.rad(v52)))
                    local v53 = workspace:Raycast(u9.Position, Vector3.new(0, -5, 0), Ess.RaycastParams)
                    if v53 then
                        u3.CreateSideRocks(u9.CFrame * CFrame.new(0, -3, 0), -(12 * (v45 / u30 + 0.5)), v53)
                    end
                    u18.RootPart["Ground Trail"].Debris.Enabled = v53 ~= nil
                    u18.RootPart["Ground Trail"].Dust.Enabled = v53 ~= nil
                end), u30)
                task.wait(u30)
                if not workspace:Raycast(u9.Position, Vector3.new(0, -5, 0), Ess.RaycastParams) then
                    u18.RootPart["Ground Trail"].Debris.Enabled = false
                    u18.RootPart["Ground Trail"].Dust.Enabled = false
                end
                Ess.Destroy({ v20, u18 }, 0.7)
                v19:PivotTo(u18.RootPart.CFrame * CFrame.new(0, 0, 15))
                v19.Parent = workspace.Effects
                _G.PlaySound(u9, script.BrandSFX.PhoenixBrandBoom).Parent = u9
                local u54 = v19.PrimaryPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
                local u55 = script.BeanWind:Clone()
                u55.CFrame = v19.PrimaryPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
                u55.Parent = workspace.Effects
                if v12 == false then
                    local v56 = u55.Mesh
                    v56.Scale = v56.Scale / 2
                end
                local u57 = tick()
                TweenCreate(u55.Decal, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
                    ["Transparency"] = 1
                })
                TweenCreate(u55.Mesh, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
                    ["Scale"] = u55.Mesh.Scale * 3
                })
                Ess.Destroy(u1.RenderStepped:Connect(function() --[[ Line: 274 ]]
                    --[[
                    Upvalues:
                        [1] = u57
                        [2] = u2
                        [3] = u55
                        [4] = u54
                    --]]
                    local v58 = tick() - u57
                    local v59 = u2:GetValue(v58 / 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
                    local v60 = u55
                    local v61 = u54 * CFrame.new(0, -50 * v59, 0)
                    local v62 = CFrame.Angles
                    local v63 = v58 * 1000 % 360
                    local v64 = math.ceil(v63)
                    local v65 = math.abs(v64)
                    v60.CFrame = v61 * v62(0, -math.rad(v65), 0)
                end), 0.45)
                Ess.Destroy({ v19, u55 }, 3.45)
                Emit(v19.Dust:GetDescendants(), false, 0.05)
                Emit(v19.RootPart:GetDescendants(), false, 0.05)
            end
        end
    end
end
return v4