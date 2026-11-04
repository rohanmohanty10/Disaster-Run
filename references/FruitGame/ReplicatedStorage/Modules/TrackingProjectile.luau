 

local u1 = game:GetService("RunService")
game:GetService("TweenService")
game:GetService("ReplicatedStorage")
local u2 = {}
u2.__index = u2
function u2.new(p3) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = u2
    local v5 = setmetatable({}, v4)
    v5.Projectile = p3.Part or p3.Model
    v5.IsModel = v5.Projectile:IsA("Model")
    v5.Velocity = p3.Velocity
    v5.Target = p3.Target
    v5.ExplosionRange = p3.ExplosionRange or 5
    v5.ProjectileSpeed = p3.Speed or 25
    v5.ExplodeFunction = p3.ExplodeFunction or nil
    v5.SnakeAmplitude = p3.SnakeAmplitude or 30
    v5.SnakeFrequency = p3.SnakeFrequency or 15
    v5.Time = 0
    v5.Lifetime = p3.Lifetime or 5
    v5.TravelFunction = p3.TravelFunction
    v5:_main()
    return v5
end
function u2._clampVelocity(_, p6, p7) --[[ Line: 26 ]]
    if p7 < p6.Magnitude then
        return p6.Unit * p7
    else
        return p6
    end
end
function u2._Explode(p8, p9) --[[ Line: 33 ]]
    if p8.ExplodeFunction then
        p8.ExplodeFunction(p9)
    end
end
function u2._getPosition(p10) --[[ Line: 39 ]]
    if p10.IsModel then
        return p10.Projectile:GetPivot().Position
    else
        return p10.Projectile.Position
    end
end
function u2._setPosition(p11, p12) --[[ Line: 47 ]]
    if p11.IsModel then
        local v13 = p11.Projectile:GetPivot()
        p11.Projectile:PivotTo(CFrame.new(p12) * v13.Rotation)
    else
        p11.Projectile.Position = p12
    end
end
function u2._setCFrame(p14, p15) --[[ Line: 56 ]]
    if p14.IsModel then
        p14.Projectile:PivotTo(p15)
    else
        p14.Projectile.CFrame = p15
    end
end
function u2._main(u16) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u17 = nil
    u17 = u1.Heartbeat:Connect(function(p18) --[[ Line: 66 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u17
        --]]
        local v19 = u16
        v19.Time = v19.Time + p18
        local v20 = false
        if u16.TravelFunction then
            u16.TravelFunction()
        end
        local v21 = u16.FunctionCheck and u16.FunctionCheck() == true and true or v20
        local v22
        if u16.Target and u16.Target:IsDescendantOf(game) then
            local v23 = u16:_getPosition()
            local v24 = u16.Target:IsA("Model") and u16.Target:GetPivot().Position or u16.Target.Position
            local v25 = v24 - v23
            local v26 = v25.Unit:Cross(Vector3.new(0, 1, 0)).Unit
            local v27 = u16.Time * u16.SnakeFrequency
            u16.Velocity = (v25 + v26 * math.sin(v27) * u16.SnakeAmplitude).Unit * p18 * u16.ProjectileSpeed
            local v28 = v23 + u16.Velocity
            u16:_setPosition(v28)
            local v29 = CFrame.new(v28, v24)
            if v29 == v29 then
                u16:_setCFrame(v29)
            end
            v22 = v25.Magnitude <= u16.ExplosionRange and true or v21
        else
            v22 = true
        end
        if v22 == true or (u16.Time >= u16.Lifetime or u16.Cancel ~= nil) then
            u17:Disconnect()
            u17 = nil
            u16:_Explode(u16.Time > u16.Lifetime)
        end
    end)
end
return function(p30) --[[ Line: 111 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return u2.new(p30)
end