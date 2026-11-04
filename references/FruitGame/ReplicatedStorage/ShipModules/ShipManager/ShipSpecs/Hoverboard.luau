 

local u1 = {}
u1.__index = u1
function u1.Start(_, p2, p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = {}
    local v5 = u1
    setmetatable(v4, v5)
    repeat
        task.wait()
    until p2.Humanoid.SeatPart ~= nil
    p2.Humanoid.SeatPart:WaitForChild("SeatWeld", 2)
    local v6 = p2.Humanoid:LoadAnimation(script.sit)
    local v7 = p2.Humanoid:LoadAnimation(script.sit2)
    v7:Play()
    v4.RegY = p3.m.Position.Y
    v4.anims = { v6, v7 }
    v4.ship = p3
    return v4
end
function u1.int(_, p8, p9) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v10 = {}
    local v11 = u1
    setmetatable(v10, v11)
    repeat
        task.wait()
    until p8.Humanoid.SeatPart ~= nil
    local v12 = p8.Humanoid:LoadAnimation(script.sit)
    local v13 = p8.Humanoid:LoadAnimation(script.sit2)
    v13:Play()
    v10.anims = { v12, v13 }
    v10.ship = p9
    return v10
end
function u1.disableEngine(_, p14) --[[ Line: 39 ]]
    if p14:FindFirstChild("Back") then
        p14.Back.Attachment.ParticleEmitter.Enabled = false
        p14.Back.Glare.ParticleEmitter.Enabled = false
        p14.Back.Glare.SurfaceLight.Enabled = false
    end
end
function u1.Foward(p15, p16) --[[ Line: 49 ]]
    if p15.anims[2].IsPlaying == true then
        p15.anims[2]:Stop()
    end
    if p15.anims[1].IsPlaying == false then
        p15.anims[1]:Play()
    end
    p16.Back.Attachment.ParticleEmitter.Enabled = true
    p16.Back.Glare.ParticleEmitter.Enabled = true
    p16.Back.Glare.SurfaceLight.Enabled = true
    if p16.Hover.drive.IsPlaying == false or p16.Hover.drive.Volume == 0 then
        if p16.Hover.drive.Volume == 0 then
            _G.tween(p16.Hover.drive, {
                0.25,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0.6
            })
        end
        if p16.Hover.drive.IsPlaying == false then
            p16.Hover.drive:Play()
        end
    end
end
function u1.looped(_, p17) --[[ Line: 82 ]]
    local v18 = CFrame.new(p17.PrimaryPart.Position)
    local v19 = Ray.new(v18.Position, v18.UpVector * -4)
    local v20, v21 = _G.raycastWhitelist(v19, { workspace.Islands, workspace.Env })
    local v22 = v21 and v21.Y < workspace.Env.WaterStuff.Falls.Position.Y and 0.5 or (v20 and 1 or -1)
    local v23 = p17.m.BodyPosition
    v23.Position = v23.Position:Lerp(v23.Position + Vector3.new(0, v22, 0), 0.4)
end
function u1.Backward(_, p24) --[[ Line: 101 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local _ = p24.VehicleSeat.Occupant.Parent
    u1:disableEngine(p24)
    if p24.Hover.drive.IsPlaying == true then
        _G.tween(p24.Hover.drive, {
            0.25,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
    end
end
function u1.Idle(p25, p26) --[[ Line: 110 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p25.anims[1].IsPlaying == true then
        p25.anims[1]:Stop()
    end
    if p25.anims[2].IsPlaying == false then
        p25.anims[2]:Play()
    end
    u1:Backward(p26)
end
function u1.End(p27) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v28 = p27.ship
    if p27.anims then
        for v29 = 1, #p27.anims do
            p27.anims[v29]:Stop()
        end
    end
    u1:disableEngine(v28)
    return true
end
return u1