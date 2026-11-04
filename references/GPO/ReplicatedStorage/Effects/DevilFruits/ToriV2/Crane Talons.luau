 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
return {
    ["start"] = function(_, p3, _, _) --[[ Name: start, Line 23 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        if _G.checkRenderDistance(p3.PrimaryPart.Position) ~= false then
            Random.new()
            local u4 = p3.PrimaryPart
            p3:FindFirstChild("Humanoid")
            local v5, _, _ = _G.getRayFloor(u4.CFrame, 10)
            _G.PlaySound(u4, script.CraneTalonA)
            task.wait(0.485)
            local u6 = p3.PrimaryPart.CFrame * CFrame.new(0, 5.5, -4)
            local u7 = script["High Kick"]:Clone()
            u7:PivotTo(u6)
            u7.Parent = workspace.Effects
            local u8 = tick()
            Emit(u7.Main:GetDescendants(), false, 0.35)
            Emit(u7.Emit:GetDescendants(), true)
            Ess.Destroy(u1.RenderStepped:Connect(function() --[[ Line: 56 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u2
                    [3] = u7
                    [4] = u6
                --]]
                local v9 = u2:GetValue((tick() - u8) / 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v10 = u7
                local v11 = u6 * CFrame.Angles(0, -1.5707963267948966 * v9 * 0, 0)
                local v12 = 20 * v9
                v10:PivotTo(v11 + Vector3.new(0, v12, 0))
            end), 0.35)
            for _, v13 in pairs(u7:GetChildren()) do
                if v13:IsA("BasePart") and v13.Name:match("Swirl") then
                    TweenCreate(v13.Mesh, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["Scale"] = v13.Mesh.Scale * Vector3.new(1.45, 1.8, 1.8)
                    })
                    TweenCreate(v13.Decal, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        ["Color3"] = v13.Decal.Color3:Lerp(Color3.new(0, 0.112947, 0.643259), 0.25),
                        ["Transparency"] = 1
                    })
                end
            end
            Ess.Destroy(u7, 1.2)
            _G.PlaySound(u4, script.CraneTalonB)
            task.wait(0.33)
            local u14 = CFrame.Angles(0, 0, 0.20943951023931956)
            local u15 = tick()
            local u16 = tick()
            local u17 = p3.PrimaryPart.CFrame
            local u18 = script["Crane Talons"]:Clone()
            u18.CFrame = u17 * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966) * u14
            u18.Parent = workspace.Effects
            Emit(u18.Attachment:GetChildren(), false, 0.19999999999999998)
            Emit(u18:GetChildren(), false, 0.09999999999999998)
            local u19 = script.Swirls:Clone()
            u19:PivotTo(u17 * CFrame.Angles(0, -0.7853981633974483, 0) * u14)
            u19.Parent = workspace.Effects
            Ess.Destroy(u1.RenderStepped:Connect(function() --[[ Line: 124 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u2
                    [3] = u19
                    [4] = u17
                    [5] = u14
                    [6] = u18
                    [7] = u16
                --]]
                local v20 = tick() - u15
                local v21 = tick()
                u2:GetValue(v20 / 0.35, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
                local v22 = u19
                local v23 = u17 * u14
                local v24 = CFrame.Angles
                local v25 = v20 * 100 % 360
                local v26 = math.ceil(v25)
                v22:PivotTo(v23 * v24(0, -math.abs(v26), 0))
                local v27 = u18
                local v28 = u17 * u14
                local v29 = CFrame.fromOrientation
                local v30 = v20 * 200 % 360
                local v31 = math.ceil(v30)
                v27.CFrame = v28 * v29(0, -math.abs(v31), 1.5707963267948966)
                if v21 - u16 > 0.05 and v20 < 0.19999999999999998 then
                    u16 = tick()
                end
            end), 0.35)
            for _, v32 in pairs(u19:GetChildren()) do
                TweenCreate(v32.Mesh, TweenInfo.new(0.24999999999999997, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Scale"] = Vector3.new(4, 1.5, 4)
                })
                TweenCreate(v32.Decal, TweenInfo.new(0.24999999999999997, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    ["Color3"] = Color3.new(0.040589, 0.335668, 0.597101),
                    ["Transparency"] = 1
                })
            end
            task.delay(0.85, function() --[[ Line: 155 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u18
                --]]
                u19:Destroy()
                task.wait(0.45)
                u18:Destroy()
            end)
            task.delay(0.2, function() --[[ Line: 165 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                _G.PlaySound(u4, script.CraneTalonC)
            end)
            task.wait(0.575)
            local v33 = p3.PrimaryPart.CFrame * CFrame.new(0, -1, -3)
            local v34 = script.ForwardKick:Clone()
            v34:PivotTo(v33)
            v34.Parent = workspace.Effects
            if v5 then
                v34.Dust.Attachment["Ground Shards"].Color = ColorSequence.new(v5.Color)
                v34.Dust.Smoke.Color = ColorSequence.new(v5.Color)
            else
                v34.Dust:Destroy()
            end
            Emit(v34:GetDescendants(), true)
            local u35 = v33 * CFrame.Angles(0, -1.5707963267948966, 0)
            local u36 = v34.Model
            u36:PivotTo(u35)
            local u37 = tick()
            Ess.Destroy(u1.RenderStepped:Connect(function() --[[ Line: 200 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u2
                    [3] = u36
                    [4] = u35
                --]]
                local v38 = u2:GetValue((tick() - u37) / 0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
                u36:PivotTo(u35 * CFrame.Angles(-3.141592653589793 * v38, 0, 0) * CFrame.new(-20 * v38, 0, 0))
            end), 0.6)
            for _, v39 in pairs(u36:GetChildren()) do
                TweenCreate(v39, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Size"] = v39.Size * Vector3.new(0.5, 0.25, 0.25)
                })
                TweenCreate(v39, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Transparency"] = 1
                })
            end
            Ess.Destroy(v34, 1.25)
        end
    end
}