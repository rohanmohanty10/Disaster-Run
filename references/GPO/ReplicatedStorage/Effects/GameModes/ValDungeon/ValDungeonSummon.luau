 

local u1 = game:GetService("RunService")
local u2 = workspace.Effects
local u3 = Random.new()
return {
    ["start"] = function(_, p4) --[[ Name: start, Line 22 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
            [3] = u3
        --]]
        local v5 = p4.StartCFrame
        local v6 = p4.GoalCFrame
        local u7 = p4.Duration
        local v8 = p4.ArcHeight or 50
        local u9 = p4.SpinSpeed or 5
        local v10 = p4.EndSizeScale or 0.2
        local u11 = script.Heart:Clone()
        u11.Anchored = true
        u11.CFrame = v5
        u11.CanCollide = false
        u11.Parent = u2
        if p4.IsStage2 == true then
            _G.PlaySound(u11, script.StartStage2).Parent = u11
        end
        local u12 = v5.Position
        local u13 = v6.Position
        local v14 = (u12 + u13) / 2
        local v15 = u12.Y
        local v16 = u13.Y
        local v17 = math.max(v15, v16)
        local v18 = v14.X
        local v19 = v17 + v8
        local v20 = v14.Z
        local u21 = Vector3.new(v18, v19, v20)
        local u22 = u11.Size
        local u23 = u22 * v10
        local u24 = 0
        local u25 = 0
        local u26 = nil
        u26 = u1.PostSimulation:Connect(function(p27) --[[ Line: 51 ]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u25
                [3] = u9
                [4] = u7
                [5] = u12
                [6] = u21
                [7] = u13
                [8] = u11
                [9] = u22
                [10] = u23
                [11] = u26
                [12] = u3
            --]]
            u24 = u24 + p27
            u25 = u25 + p27 * u9 * 3.141592653589793 * 2
            local v28 = u24 / u7
            local v29 = math.min(v28, 1)
            local v30 = u12
            local v31 = u21
            local v32 = u13
            local v33 = 1 - v29
            local v34 = v33 * v33 * v30 + v33 * 2 * v29 * v31 + v29 * v29 * v32
            u11.Size = u22:Lerp(u23, v29)
            u11.CFrame = CFrame.new(v34) * CFrame.Angles(0, u25, 0)
            if v29 >= 1 then
                u26:Disconnect()
                u11.Transparency = 1
                _G.customEmit(u11)
                _G.PlaySound(u11, script.Mero2MeroBombBoom, {
                    ["Pitch"] = u3:NextNumber(1.4, 1.6)
                })
                task.delay(4, u11.Destroy, u11)
            end
        end)
        task.wait(u7 + 1)
    end
}