 

local u1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = require(v2.Modules.ObjectCache)
local u4 = v3.new(script.Part, 200, workspace.Effects)
local u5 = v3.new(script.DustShockwave2, 50, workspace.Effects)
local function u9(p6, p7, _) --[[ Line: 8 ]]
    local v8 = RaycastParams.new()
    v8.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
    v8.FilterType = Enum.RaycastFilterType.Include
    return workspace:Raycast(p6, p7, v8)
end
return {
    ["start"] = function(_, p10) --[[ Name: start, Line 17 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u5
            [3] = u4
            [4] = u1
        --]]
        if _G.checkRenderDistance(p10.Position) == false then
            return
        else
            local v11 = Random.new()
            local v12 = p10.Position
            local v13 = p10.Direction
            local v14 = p10.DistanceRandomness or 1
            local v15 = p10.Duration
            local v16 = p10.Segments
            local v17 = p10.Radius
            local u18 = p10.TweenDuration
            local v19 = p10.IgnoreList or {}
            local v20 = p10.Angle or -0.8726646259971648
            local v21 = u9(v12, v13, v19)
            if v21 then
                if p10.Smoke ~= nil and v21.Instance ~= nil then
                    local u22 = u5:GetPart(CFrame.new(v21.Position, v21.Position + v21.Normal) * CFrame.Angles(1.5707963267948966, 0, 0))
                    u22.Transparency = 1
                    u22.CanCollide = false
                    u22.Anchored = true
                    u22.Smoke2.Color = ColorSequence.new(v21.Instance.Color)
                    u22.Smoke2.Size = NumberSequence.new(v17 * 0.6, v17)
                    u22.Size = Vector3.new(v17, 1, v17)
                    _G.customEmit(u22)
                    task.delay(5, function() --[[ Line: 49 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u22
                        --]]
                        u5:ReturnPart(u22)
                    end)
                end
                for v23 = 1, v16 do
                    local v24 = v17 * v11:NextNumber(v14.X, v14.Y)
                    local v25 = CFrame.new(v21.Position, v21.Position + v21.Normal)
                    local v26 = CFrame.new
                    local v27 = 6.283185307179586 * v23 / v16
                    local v28 = math.sin(v27) * v24
                    local v29 = 6.283185307179586 * v23 / v16
                    local v30 = u9(v25 * v26(v28, math.cos(v29) * v24, -5).Position, v21.Normal * -(6 + v17), v19)
                    if v30 then
                        local v31 = 2 * v11:NextNumber(0.5, 1)
                        local v32 = 1 / v16 * 2 * 3.141592653589793
                        local v33 = v31 * math.sin(v32) * v24
                        local v34 = 0.5 * v24 * v11:NextNumber(0.75, 1.5)
                        local v35 = Vector3.new(v33, 5, v34)
                        local v36 = CFrame.lookAt(v30.Position, v21.Position, v30.Normal) * CFrame.Angles(v20 * v24 / v17, 0, 0) - v21.Normal * v35.Y / 2
                        local u37 = u4:GetPart(v36)
                        u37.Transparency = 0
                        u37.CanCollide = false
                        u37.Anchored = true
                        u37.Size = v35
                        _G.matchMaterial(u37, v30.Instance)
                        local u38 = v36.Position + v21.Normal * -(v35.Magnitude / 2)
                        task.delay(v15 * v11:NextNumber(0.65, 1.25), function() --[[ Line: 76 ]]
                            --[[
                            Upvalues:
                                [1] = u1
                                [2] = u37
                                [3] = u18
                                [4] = u38
                                [5] = u4
                            --]]
                            local v39 = {
                                ["Position"] = u38
                            }
                            u1:Create(u37, TweenInfo.new(u18, Enum.EasingStyle.Linear), v39):Play()
                            task.delay(u18 + 0.05, function() --[[ Line: 85 ]]
                                --[[
                                Upvalues:
                                    [1] = u4
                                    [2] = u37
                                --]]
                                u4:ReturnPart(u37)
                            end)
                        end)
                    end
                end
            end
        end
    end
}