 

local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Include
u1.FilterDescendantsInstances = workspace.Env:GetDescendants()
local u2 = script
local v3 = {}
local u4 = game:GetService("TweenService")
local u5 = Random.new()
function v3.start(_, p6, u7) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u5
        [4] = u1
    --]]
    if _G.checkRenderDistance(u7.Position) == false then
        return
    elseif p6 == "Counter" then
        local v8 = u2.Hit1:Clone()
        v8.CFrame = u7 * CFrame.new(0, 1, -5)
        v8.Parent = workspace.Effects
        _G.customEmit(v8)
        local v9 = u2.Hit2:Clone()
        v9.CFrame = v8.CFrame
        v9.Parent = workspace.Effects
        _G.customEmit(v9)
        local v10 = u2.HitFloorWind:Clone()
        v10.CFrame = u7 * CFrame.new(0, -3, -4)
        v10.Parent = workspace.Effects
        _G.customEmit(v10)
        local v11 = u2.MeshWind:Clone()
        v11.CFrame = v8.CFrame * CFrame.new(2, 0, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
        v11.Parent = workspace.Effects
        _G.destroy({ v11, v8, v9 }, 5)
        local v12 = u4:Create(v11.Decal, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            ["Transparency"] = 1
        })
        v12:Play()
        local v13 = u4:Create(v11.Mesh, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            ["Scale"] = Vector3.new(1, 1, 35)
        })
        v13:Play()
        u4:Create(v11, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            ["CFrame"] = v8.CFrame * CFrame.new(15, 0, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
        }):Play()
        task.wait(0.5)
        v13:Destroy()
        v12:Destroy()
    else
        task.spawn(function() --[[ Line: 61 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u7
                [3] = u5
                [4] = u4
            --]]
            for _ = 1, 5 do
                task.spawn(function() --[[ Line: 63 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u7
                        [3] = u5
                        [4] = u4
                    --]]
                    local v14 = u2.Wind:Clone()
                    v14.CFrame = u7 * CFrame.Angles(0, u5:NextNumber(0, 6.283185307179586), 0)
                    v14.Parent = workspace.Effects
                    _G.destroy(v14, 4)
                    local v15 = u5:NextNumber(15, 25)
                    local v16 = u4
                    local v17 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local v18 = {}
                    local v19 = u5:NextNumber(7, 12)
                    v18.Size = Vector3.new(v15, v19, v15)
                    v18.Position = (u7 * CFrame.new(0, -4, 0)).Position
                    v16:Create(v14, v17, v18):Play()
                    u4:Create(v14, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Orientation"] = v14.Orientation + Vector3.new(0, -360, 0)
                    }):Play()
                    u4:Create(v14, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Transparency"] = 0.9
                    }):Play()
                    task.wait(0.15)
                    u4:Create(v14, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Transparency"] = 1
                    }):Play()
                end)
                task.wait()
            end
        end)
        local v20 = u2.SpinParticles:Clone()
        v20.CFrame = u7
        v20.Parent = workspace.Effects
        _G.destroy(v20, 4)
        _G.customEmit(v20)
        local v21 = workspace:Raycast(u7.Position, Vector3.new(0, -5, 0), u1)
        if v21 then
            local v22 = u2.FloorWind:Clone()
            v22.CFrame = CFrame.lookAt(v21.Position, v21.Position + v21.Normal)
            v22.Parent = workspace.Effects
            _G.customEmit(v22)
            _G.destroy(v22, 4)
        end
    end
end
return v3