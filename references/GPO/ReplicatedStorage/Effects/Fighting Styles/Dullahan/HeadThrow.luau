 

local u1 = Random.new()
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v3 = {}
local u4 = game:GetService("TweenService")
function v3.start(_, p5, p6, p7, p8) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u1
    --]]
    local u9 = p7 or game.Players.LocalPlayer.Character
    if _G.checkRenderDistance(p5.Position) ~= false then
        local v10 = OverlapParams.new()
        v10.FilterType = Enum.RaycastFilterType.Include
        local v11 = RaycastParams.new()
        v11.FilterType = Enum.RaycastFilterType.Include
        v10.FilterDescendantsInstances = p8
        v11.FilterDescendantsInstances = p8
        local v12 = p7:WaitForChild("Head")
        local u13 = script.FlameHeadBurst:Clone()
        u2.apply(u13, u9)
        u13.Position = v12.Position
        u13.Parent = workspace.Effects
        _G.customEmit(u13)
        task.spawn(function() --[[ Line: 61 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u4
            --]]
            local v14 = u13.LightAttachment.PointLight
            local v15 = v14.Range
            v14.Range = 0
            u4:Create(v14, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, true), {
                ["Range"] = v15
            }):Play()
        end)
        task.delay(3, u13.Destroy, u13)
        local u16 = v12:Clone()
        local v17 = next
        local v18, v19 = u16:GetDescendants()
        for _, v20 in v17, v18, v19 do
            if v20:IsA("Attachment") or v20:IsA("Motor6D") then
                v20:Destroy()
            end
        end
        local _ = p6.Position
        u16.CFrame = p5
        u16.CanCollide = false
        u16.Anchored = true
        u16.Transparency = 1
        u16:ClearAllChildren()
        u16.Size = Vector3.new(2, 2, 2)
        u16.Parent = workspace.Effects
        _G.PlaySound(v12, script.HeadThrowStart).Parent = u16
        local v21 = script.HeadParticles:Clone()
        u2.apply(v21, u9)
        for _, v22 in v21:GetDescendants() do
            v22:Clone().Parent = u16
        end
        u16.Velocity = Vector3.new(0, 0, 0)
        local v23 = tick()
        local u24 = workspace:GetPartsInPart(u16, v10)
        u16.CFrame = CFrame.lookAt(u16.Position, p6.Position)
        local v25 = u16.Orientation
        local v26 = 0
        while tick() - v23 <= 3 and #u24 == 0 do
            local v27 = task.wait()
            u16.CFrame = u16.CFrame * CFrame.new(0, -0 * v27, -150 * v27)
            u16.Orientation = v25
            if tick() - v26 >= 0.07 then
                v26 = tick()
                task.spawn(function() --[[ Line: 122 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u9
                        [3] = u1
                        [4] = u24
                        [5] = u16
                    --]]
                    local v28 = script.TrailPart:Clone()
                    u2.apply(v28, u9)
                    local v29 = u1:NextNumber(0, 360)
                    local v30 = u1:NextNumber(0.5, 3)
                    local v31 = u1:NextNumber(0.5, 3)
                    local v32 = u1:NextNumber(0.5, 3)
                    v28.Parent = workspace.Effects
                    local v33 = tick()
                    while tick() - v33 <= u1:NextNumber(0.2, 0.5) and #u24 == 0 do
                        local v34 = game["Run Service"].Heartbeat:Wait()
                        local v35 = u16.CFrame
                        local v36 = CFrame.new
                        local v37 = math.rad(v29)
                        local v38 = math.sin(v37) * v30
                        local v39 = math.rad(v29)
                        local v40 = math.cos(v39) * v31
                        local v41 = math.rad(v29)
                        v28.CFrame = v35 * v36(v38, v40, math.sin(v41) * v32)
                        v29 = v29 + 1350 * v34
                    end
                    _G.particleEnabled(v28, false)
                    _G.destroy(v28, 1)
                end)
            end
            local v42 = workspace:GetPartsInPart(u16, v10)
            u24 = v42
        end
        local v43 = u16.Position
        u16:Destroy()
        local v44 = workspace:Raycast(v43 + Vector3.new(0, 10, 0), Vector3.new(0, -15, 0), v11)
        if v44 then
            v43 = v44.Position
            local u45 = script.Crack:Clone()
            u2.apply(u45, u9)
            u45.Position = v43
            u45.CFrame = CFrame.lookAt(u45.Position, u45.Position + v44.Normal) * CFrame.Angles(0, 0, u1:NextNumber(0, 6.283185307179586))
            u45.Parent = workspace.Effects
            task.delay(1.2, function() --[[ Line: 174 ]]
                --[[
                Upvalues:
                    [1] = u45
                    [2] = u4
                --]]
                local v46 = next
                local v47, v48 = u45:GetChildren()
                for _, v49 in v46, v47, v48 do
                    u4:Create(v49, TweenInfo.new(0.5), {
                        ["Transparency"] = 1
                    }):Play()
                end
                task.wait(1.2)
                u45:Destroy()
            end)
        end
        local u50 = script.HeadExplosion:Clone()
        u2.apply(u50, u9)
        u50.Position = v43
        task.spawn(function() --[[ Line: 195 ]]
            --[[
            Upvalues:
                [1] = u50
                [2] = u4
            --]]
            local v51 = u50.LightAttachment.PointLight
            local v52 = v51.Range
            v51.Range = 0
            u4:Create(v51, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true), {
                ["Range"] = v52
            }):Play()
        end)
        _G.customEmit(u50)
        u50.Parent = workspace.Effects
        task.delay(2, u50.Destroy, u50)
        _G.PlaySound(u50, script.HeadThrowBoom)
        for _ = 1, 15 do
            task.delay(0, function() --[[ Line: 216 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u9
                    [3] = u50
                    [4] = u1
                --]]
                local v53 = script.Bezier:Clone()
                u2.apply(v53, u9)
                v53.Position = u50.Position
                v53.Parent = workspace.Effects
                local v54 = v53.Position
                local v55 = (v53.CFrame * CFrame.new(u1:NextNumber(-35, 35), u1:NextNumber(-15, 25), u1:NextNumber(-35, 35))).Position
                local v56 = (v53.CFrame * CFrame.new(0, u1:NextNumber(10, 30), 0)).Position
                for v57 = 0, 1, math.random(400, 600) / 10000 * 1 do
                    local v58 = v54 + (v56 - v54) * v57
                    v53.Position = v58 + (v56 + (v55 - v56) * v57 - v58) * v57
                    game["Run Service"].RenderStepped:Wait()
                end
                _G.particleEnabled(v53, false)
                _G.destroy(v53, 2)
            end)
        end
        if v44 then
            local v59 = script.RotatingParticles:Clone()
            u2.apply(v59, u9)
            v59.CFrame = CFrame.lookAt(v44.Position, v44.Position + v44.Normal)
            v59.Parent = workspace.Effects
            u4:Create(v59, TweenInfo.new(1.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["Orientation"] = v59.Orientation + Vector3.new(0, 0, 150)
            }):Play()
            u50.CFrame = CFrame.lookAt(v43, u50.Position + v44.Normal)
            v59.CFrame = CFrame.lookAt(v43, v59.Position + v44.Normal)
            task.wait(0.5)
            _G.particleEnabled(v59, false)
            task.delay(0.5, v59.Destroy, v59)
        end
        task.wait(3)
        v21:Destroy()
    end
end
return v3