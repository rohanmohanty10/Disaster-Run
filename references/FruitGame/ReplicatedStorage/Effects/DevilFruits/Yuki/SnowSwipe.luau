 

game:GetService("RunService")
local u1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = workspace.Effects
local u4 = require(v2.Modules.Utility)
return {
    ["start"] = function(_, p5) --[[ Name: start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u1
        --]]
        if _G.checkRenderDistance(p5.Position) ~= false then
            local v6 = script.CharSpiral:Clone()
            v6.CFrame = p5 * CFrame.new(0, -2.5, 0)
            v6.Parent = u3
            u4:AddItem(v6, 1)
            local v7 = TweenInfo.new(0.75, Enum.EasingStyle.Exponential)
            u1:Create(v6.Texture, v7, {
                ["Transparency"] = 1
            }):Play()
            u1:Create(v6.Mesh, v7, {
                ["Scale"] = Vector3.new(8, 1, 8)
            }):Play()
            local v8 = u1
            local v9 = {}
            local v10 = v6.Orientation
            local v11 = v6.Orientation.Y - 700
            v9.Orientation = v10 + Vector3.new(0, v11, 0)
            v8:Create(v6, v7, v9):Play()
            local v12 = RaycastParams.new()
            v12.FilterType = Enum.RaycastFilterType.Whitelist
            v12.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
            local v13 = workspace:Raycast(p5.Position, CFrame.new(0, -3, 0).Position, v12)
            if v13 then
                local v14 = CFrame.lookAt(v13.Position, v13.Position + p5.LookVector, v13.Normal)
                local v15 = script.Ground:Clone()
                v15.CFrame = v14
                v15.Parent = u3
                u4:Emit(v15)
                u4:AddItem(v15, 1)
            end
            local u16 = script.Tornado:Clone()
            u16.CFrame = p5 * CFrame.new(0, -2, -5)
            u16.Parent = u3
            _G.PlaySound(u16, script.YukiFrostWind).Parent = u16
            u1:Create(u16, TweenInfo.new(1.2, Enum.EasingStyle.Sine), {
                ["CFrame"] = u16.CFrame * CFrame.new(0, 0, -45)
            }):Play()
            task.delay(0.1, function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u16
                --]]
                u4:Emit(u16.ToEmit)
                task.wait(1)
                u4:AddItem(u16, 1)
                u4:ToggleEnabled(u16.Continuous, false)
            end)
            task.spawn(function() --[[ Line: 54 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u3
                    [3] = u4
                    [4] = u1
                --]]
                for _ = 1, 27 do
                    local v17 = script.TornadoSwirl:Clone()
                    v17.CFrame = u16.CFrame
                    v17.Parent = u3
                    u4:AddItem(v17, 0.75)
                    local v18 = math.random(1, 4)
                    local v19 = TweenInfo.new(0.75, Enum.EasingStyle.Quint)
                    u1:Create(v17.Texture, v19, {
                        ["Transparency"] = 1
                    }):Play()
                    local v20 = u1
                    local v21 = v17.Mesh
                    local v22 = {}
                    local v23 = math.random(2, 5)
                    v22.Scale = Vector3.new(v18, v23, v18) * 1.5
                    v20:Create(v21, v19, v22):Play()
                    local v24 = u1
                    local v25 = {}
                    local v26 = v17.Orientation
                    local v27 = v17.Orientation.Z + math.random(600, 1200)
                    v25.Orientation = v26 + Vector3.new(0, v27, 0)
                    v24:Create(v17, v19, v25):Play()
                    task.wait(0.025)
                end
            end)
        end
    end
}