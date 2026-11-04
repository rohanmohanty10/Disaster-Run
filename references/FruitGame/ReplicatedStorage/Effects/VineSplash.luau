 

local v1 = {}
game:GetService("TweenService")
local u2 = game:GetService("RunService")
function v1.start(_, u3) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u4 = script.MainTrail:Clone()
    u4.Anchored = true
    u4.CanCollide = false
    u4.Size = Vector3.new(1, 1, 1)
    u4.Position = u3.StartPosition
    u4.Transparency = 1
    u4.Parent = workspace.Effects
    local u5 = script.MiniSlashTrail:Clone()
    u5.Anchored = false
    u5.CanCollide = false
    u5.Size = Vector3.new(1, 1, 1)
    u5.Position = u3.StartPosition
    u5.Parent = workspace.Effects
    local v6 = u4.CFrame * CFrame.new(0, 0, 0)
    local u7 = Instance.new("Weld")
    u7.Part0 = u4
    u7.Part1 = u5
    u7.C0 = (v6 * CFrame.Angles(1.5707963267948966, 0, 0)):Inverse() * u5.CFrame
    u7.Parent = u5
    local u8 = script.MiniSlashTrail:Clone()
    u8.Anchored = false
    u8.CanCollide = false
    u8.Size = Vector3.new(1, 1, 1)
    u8.Position = u3.StartPosition
    u8.Parent = workspace.Effects
    local u9 = Instance.new("Weld")
    u9.Part0 = u4
    u9.Part1 = u8
    u9.C0 = (v6 * CFrame.Angles(1.5707963267948966, 0, 0)):Inverse() * u8.CFrame
    u9.Parent = u4
    local u10 = u3.StartPosition
    local u11 = u3.EndPosition
    local v12 = (CFrame.new(u10, u11) * CFrame.new(0, 0, -(u10 - u11).Magnitude / 2)).Position
    local v13 = math.random(25, 50) * 2
    local u14 = v12 + Vector3.new(0, v13, 0)
    local u15 = tick()
    local u16 = nil
    u16 = u2.Heartbeat:Connect(function() --[[ Line: 59 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u3
            [3] = u10
            [4] = u14
            [5] = u11
            [6] = u4
            [7] = u9
            [8] = u7
            [9] = u16
            [10] = u5
            [11] = u8
        --]]
        local v17 = tick() - u15
        local v18 = u3.Duration
        local v19 = math.clamp(v17, 0, v18)
        local v20 = v19 / u3.Duration
        local v21 = math.clamp(v20, 0, 1)
        local v22 = u10
        local v23 = v22 + (u14 - v22) * v21
        local v24 = u14
        local v25 = v23 + (v24 + (u11 - v24) * v21 - v23) * v21
        local v26 = v21 + 0.1
        local v27 = math.clamp(v26, 0, 1)
        local v28 = u10
        local v29 = v28 + (u14 - v28) * v27
        local v30 = u14
        local v31 = v29 + (v30 + (u11 - v30) * v27 - v29) * v27
        local v32 = v19 * 3.141592653589793 * 2
        u4.CFrame = CFrame.new(v25, v31)
        u9.C1 = CFrame.new(math.sin(v32) * 5, 0, math.cos(v32) * 5)
        u7.C1 = CFrame.new(math.sin(v32) * -5, 0, math.cos(v32) * -5)
        if v21 >= 1 then
            u16:Disconnect()
            _G.destroy(u5, 2)
            _G.destroy(u8, 2)
            _G.destroy(u4, 2)
        end
    end)
end
return v1