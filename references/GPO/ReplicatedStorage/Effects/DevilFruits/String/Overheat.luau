 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
local u2 = {}
function v1.start(_, p3, p4) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.PrimaryPart.Position) == false then
        return
    elseif p4 == true then
        local v5 = u2[p3]
        if v5 ~= nil then
            local v6 = v5[1]
            local v7 = v5[2]
            v7:AdjustSpeed(2)
            v7:AdjustWeight(4)
            _G.destroy(v6, 0.3)
            _G.PlaySound(p3.PrimaryPart, script.OverheatWhooshShoot)
            v6.PrimaryPart.OverheatHoldLoop:Stop()
        end
    else
        _G.PlaySound(p3.HumanoidRootPart, script.OverheatWhoosh)
        local _ = p3.HumanoidRootPart
        local v8 = p3.RightHand
        local u9 = script.Whip:Clone()
        u9.Parent = workspace.Effects
        u9.Name = "HeatWhip" .. p3.Name
        u9.Motor6D.Part0 = v8
        u9.Part.Transparency = 1
        if u9:FindFirstChild("OverheatHoldLoop") then
            u9.PrimaryPart.OverheatHoldLoop:Play()
        end
        local u10 = u9.AnimationController.Animator:LoadAnimation(script.overheat)
        u10:Play(0)
        u10:AdjustWeight(2)
        u10.TimePosition = 0.2833333333333333
        u2[p3] = { u9, u10 }
        _G.tween(u9.Part, { 0.25, "Quad", Enum.EasingDirection.Out }, {
            ["Transparency"] = 0
        })
        task.spawn(function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u10
            --]]
            task.wait(0.4)
            u10:AdjustSpeed(0)
        end)
        task.spawn(function() --[[ Line: 49 ]]
            --[[
            Upvalues:
                [1] = u9
            --]]
            task.wait(0.2)
            local v11 = 0.1
            local v12 = v11 == nil and 0.1 or v11
            local v13 = u9
            local v14 = v13.PrimaryPart:GetDescendants()
            local v15 = {}
            local v16 = {}
            local v17 = {}
            for v18 = 1, #v14 do
                if v14[v18]:IsA("Bone") then
                    local v19, _ = string.gsub(v14[v18].Name, "attach", "")
                    v13.PrimaryPart:FindFirstChild(v19, true)
                    local v20 = Instance.new("Attachment")
                    v20.WorldCFrame = v14[v18].TransformedWorldCFrame
                    v20.Parent = workspace.Terrain
                    script.fire:Clone().Parent = v20
                    script.fire2:Clone().Parent = v20
                    script.PointLight:Clone().Parent = v20
                    v15[v20] = v14[v18]
                    v16[v20] = v20.WorldCFrame
                    table.insert(v17, v20)
                end
            end
            local v21 = 10 / UserSettings().GameSettings.SavedQualityLevel.Value
            local v22 = 0
            while true do
                game["Run Service"].RenderStepped:Wait()
                if v13:IsDescendantOf(workspace) == false then
                    break
                end
                local v23 = false
                for v24, v25 in v15 do
                    v24.fire2.Acceleration = v24.WorldCFrame.RightVector * -5
                    if tick() - v22 >= 0.1 * v21 then
                        v24.fire:Emit(1)
                        v23 = true
                    elseif v12 < (v16[v24].Position - v24.WorldPosition).Magnitude then
                        v24.fire2:Emit(1)
                        v16[v24] = v24.WorldCFrame
                    end
                    v24.WorldCFrame = v25.TransformedWorldCFrame
                end
                if v23 == true then
                    v22 = tick()
                end
                if v13:IsDescendantOf(workspace) == false or v13.Name == "tet" then
                    break
                end
            end
            for v26 = 1, #v17 do
                v17[v26].fire.Enabled = false
                v17[v26].fire2.Enabled = false
                _G.tween(v17[v26].PointLight, { 0.1, "Quad", Enum.EasingDirection.Out }, {
                    ["Brightness"] = 0,
                    ["Range"] = 35
                })
                _G.destroy(v17[v26], 4)
            end
            table.clear(v17)
        end)
        return
    end
end
return v1