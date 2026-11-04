 

local u1 = Random.new()
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
local u3 = game:GetService("TweenService")
local u4 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
return {
    ["start"] = function(_, u5, u6, p7) --[[ Name: start, Line 37 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
            [4] = u1
        --]]
        local u8 = p7 or game.Players.LocalPlayer.Character
        if _G.checkRenderDistance(u5.Position) ~= false then
            local u9 = 60 / _G.FPS
            local v10 = script.StartUpEffect:Clone()
            u4.apply(v10, u8)
            v10.CFrame = u5
            v10.Parent = workspace.Effects
            local v11 = next
            local v12, v13 = v10:GetDescendants()
            for _, v14 in v11, v12, v13 do
                if v14:IsA("ParticleEmitter") then
                    _G.customEmit(v14)
                end
            end
            task.delay(2, v10.Destroy, v10)
            local u15 = script.Centre:Clone()
            u4.apply(u15, u8)
            u15.Position = u5.Position
            task.spawn(function() --[[ Line: 61 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u3
                --]]
                local v16 = u15.LightAttachment.PointLight
                local v17 = v16.Range
                v16.Range = 0
                u3:Create(v16, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    ["Range"] = v17
                }):Play()
                task.wait(0.5)
                u3:Create(v16, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    ["Brightness"] = 0
                }):Play()
            end)
            u15.Parent = workspace.Effects
            task.delay(0.5, function() --[[ Line: 80 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                local v18 = next
                local v19, v20 = u15:GetDescendants()
                for _, v21 in v18, v19, v20 do
                    if v21:IsA("ParticleEmitter") then
                        v21.Enabled = false
                    end
                end
                task.wait(2)
                u15:Destroy()
            end)
            for u22 = 1, #u6 do
                task.spawn(function() --[[ Line: 93 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                        [2] = u22
                        [3] = u2
                        [4] = u4
                        [5] = u8
                        [6] = u5
                        [7] = u1
                        [8] = u9
                        [9] = u3
                    --]]
                    repeat
                        task.wait()
                    until u6[u22].PrimaryPart ~= nil and u6[u22]:GetAttribute("ready") == true
                    local v23 = u6[u22].PrimaryPart.Position
                    local v24 = workspace:Raycast(v23 + Vector3.new(0, 30, 0), Vector3.new(0, -60, 0), u2)
                    if v24 then
                        local u25 = script.EarthEmerge:Clone()
                        u4.apply(u25, u8)
                        u25.CFrame = CFrame.lookAt(v24.Position, v24.Position + v24.Normal)
                        local u26 = u25.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
                        task.delay(2.5, u25.Destroy, u25)
                        for _ = 1, 4 do
                            task.spawn(function() --[[ Line: 116 ]]
                                --[[
                                Upvalues:
                                    [1] = u4
                                    [2] = u8
                                    [3] = u5
                                    [4] = u26
                                    [5] = u1
                                    [6] = u9
                                --]]
                                local v27 = script.Bezier:Clone()
                                u4.apply(v27, u8)
                                local v28 = u5.Position
                                local v29 = (u26 * CFrame.new(u1:NextNumber(-15, 15), u1:NextNumber(6, 10), u1:NextNumber(-15, 15))).Position
                                local v30 = (u26 * CFrame.new(u1:NextNumber(-15, 15), u1:NextNumber(2, 6), u1:NextNumber(-15, 15))).Position
                                local v31 = u26.Position
                                v27.Position = v28
                                v27.Parent = workspace.Effects
                                for v32 = 0, 1, 0.075 * u9 do
                                    local v33 = v28 + (v29 - v28) * v32
                                    local v34 = v29 + (v30 - v29) * v32
                                    local v35 = v30 + (v31 - v30) * v32
                                    local v36 = v33 + (v34 - v33) * v32
                                    v27.Position = v36 + (v34 + (v35 - v34) * v32 - v36) * v32
                                    task.wait()
                                end
                                v27.Position = v31
                                local v37 = next
                                local v38, v39 = v27:GetDescendants()
                                for _, v40 in v37, v38, v39 do
                                    if v40:IsA("ParticleEmitter") then
                                        v40.Enabled = false
                                    end
                                end
                                task.wait(2)
                                v27:Destroy()
                            end)
                            task.wait(0.01)
                        end
                        task.wait(0.2)
                        task.spawn(function() --[[ Line: 158 ]]
                            --[[
                            Upvalues:
                                [1] = u25
                                [2] = u3
                            --]]
                            local v41 = u25.LightAttachment.PointLight
                            local v42 = v41.Range
                            v41.Range = 0
                            u3:Create(v41, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true), {
                                ["Range"] = v42
                            }):Play()
                        end)
                        u25.Parent = workspace.Effects
                        local v43 = next
                        local v44, v45 = u25:GetDescendants()
                        for _, v46 in v43, v44, v45 do
                            if v46:IsA("ParticleEmitter") then
                                _G.customEmit(v46)
                            end
                        end
                        local u47 = u6[u22]
                        local u48 = script.Darkness:Clone()
                        u4.apply(u48, u8)
                        u48.Parent = workspace.Effects
                        _G.customWeld(u48, u47.PrimaryPart, CFrame.new(), u48)
                        task.delay(0.5, function() --[[ Line: 191 ]]
                            --[[
                            Upvalues:
                                [1] = u48
                                [2] = u25
                            --]]
                            for _, v49 in u48:GetDescendants() do
                                if v49:IsA("ParticleEmitter") then
                                    v49.Enabled = false
                                end
                            end
                            for _, v50 in u25:GetDescendants() do
                                if v50:IsA("ParticleEmitter") then
                                    v50.Enabled = false
                                end
                            end
                            task.wait(3)
                            u48:Destroy()
                        end)
                        local u51 = 10 * u9
                        for _ = 1, 5 do
                            task.spawn(function() --[[ Line: 211 ]]
                                --[[
                                Upvalues:
                                    [1] = u4
                                    [2] = u8
                                    [3] = u47
                                    [4] = u1
                                    [5] = u9
                                    [6] = u51
                                --]]
                                local v52 = script.CirclingTrail:Clone()
                                u4.apply(v52, u8)
                                local v53 = u47.PrimaryPart.Position
                                local v54 = u1:NextNumber(0, 360)
                                local v55 = u1:NextNumber(0.27, 0.31) * u9
                                local v56 = u1:NextNumber(0.002, 0.1) * u9
                                local v57 = 0
                                local v58 = u1:NextNumber(0.4, 0.8)
                                local v59 = math.rad(v54)
                                local v60 = math.sin(v59)
                                local v61 = math.rad(v54)
                                local v62 = math.cos(v61)
                                v52.Position = v53 + Vector3.new(v60, v57, v62)
                                v52.Parent = workspace.Effects
                                local v63 = tick()
                                local v64 = 1
                                while tick() - v63 <= v58 do
                                    local v65 = math.rad(v54)
                                    local v66 = math.sin(v65) * v64
                                    local v67 = math.rad(v54)
                                    local v68 = math.cos(v67) * v64
                                    v52.Position = v53 + Vector3.new(v66, v57, v68)
                                    v54 = v54 + u51
                                    v64 = v64 + v56
                                    v57 = v57 + v55
                                    task.wait()
                                end
                                for _, v69 in v52:GetDescendants() do
                                    if v69:IsA("ParticleEmitter") then
                                        v69.Enabled = false
                                        _G.customEmit(v69)
                                    end
                                end
                                task.wait(1.5)
                                _G.destroy(v52, 1.5)
                            end)
                        end
                    end
                end)
            end
        end
    end
}