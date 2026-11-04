 

local u1 = {}
u1.__index = u1
function u1.new(_, p2, p3, _) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = {
        ["mount"] = p2,
        ["maxSpeed"] = 75,
        ["acceleration"] = 0.5,
        ["Owner"] = p3
    }
    local v5 = u1
    setmetatable(v4, v5)
    return v4
end
function u1.Turn(p6, p7) --[[ Line: 15 ]]
    local v8 = p6.mount.HumanoidRootPart
    v8.CFrame = v8.CFrame * CFrame.Angles(0, math.rad(p7), 0)
end
function u1.IncreaseSpeed(u9) --[[ Line: 20 ]]
    local v10 = u9.acceleration
    local u11 = u9.Owner
    local u12 = u9.mount.Humanoid
    local v13 = u12.WalkSpeed + v10
    local v14 = u9.maxSpeed
    u12.WalkSpeed = math.clamp(v13, 0, v14)
    coroutine.wrap(function() --[[ Line: 26 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u12
            [3] = u9
        --]]
        while u11.Character.Humanoid.MoveDirection ~= Vector3.new() and u12.WalkSpeed > 0 do
            u12:Move(u9.mount.HumanoidRootPart.CFrame.LookVector * 10)
            game["Run Service"].Heartbeat:Wait()
        end
    end)()
end
function u1.DecreaseSpeed(p15) --[[ Line: 37 ]]
    local v16 = p15.acceleration / 2
    local v17 = p15.mount.Humanoid
    local v18 = v17.WalkSpeed - v16
    local v19 = p15.maxSpeed
    v17.WalkSpeed = math.clamp(v18, 0, v19)
end
return u1