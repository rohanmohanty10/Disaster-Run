 

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
    local v6 = p2.Humanoid.SeatPart:WaitForChild("SeatWeld", 2)
    if v6 then
        v6.C0 = v6.C0 * CFrame.new(0, 0, 1.1 * p2.Humanoid.BodyHeightScale.Value - 0.1)
    end
    local v7 = p2.Humanoid:LoadAnimation(script.sit)
    local v8 = p2.Humanoid:LoadAnimation(script.sit2)
    v8:Play()
    v4.anims = { v7, v8 }
    v4.ship = p3
    p3.FlamePart.Burn.Enabled = true
    return v4
end
function u1.int(_, p9, p10) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v11 = {}
    local v12 = u1
    setmetatable(v11, v12)
    repeat
        task.wait()
    until p9.Humanoid.SeatPart ~= nil
    local v13 = p9.Humanoid:LoadAnimation(script.sit)
    local v14 = p9.Humanoid:LoadAnimation(script.sit2)
    v14:Play()
    v11.anims = { v13, v14 }
    v11.ship = p10
    p10.FlamePart.foot:Play()
    return v11
end
function u1.Foward(p15, p16) --[[ Line: 39 ]]
    if p15.anims[2].IsPlaying == true then
        p15.anims[2]:Stop()
    end
    if p15.anims[1].IsPlaying == false then
        p15.anims[1]:Play()
    end
    if p16.Back.sfx.IsPlaying == false then
        p16.Back.sfx:Play()
    end
    if p16.Backglow:FindFirstChild("glow") == nil then
        local v17 = Instance.new("BoolValue", p16.Backglow)
        v17.Name = "glow"
        _G.destroy(v17, 0.35)
        _G.tween(p16.Backglow, {
            0.25,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Color"] = Color3.fromRGB(255, 98, 7)
        })
        _G.tween(p16.Back.PointLight, {
            0.25,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 8
        })
    end
    local _ = p16.VehicleSeat.Occupant.Parent
    p16.Back.Attachment.Burn.Enabled = true
    p16.Steam.Attachment.ParticleEmitter.Enabled = true
    p16.Steam.Attachment2.ParticleEmitter.Enabled = true
end
function u1.Backward(_, p18) --[[ Line: 63 ]]
    local _ = p18.VehicleSeat.Occupant.Parent
    p18.Back.sfx:Stop()
    p18.Back.Attachment.Burn.Enabled = false
    if p18.Backglow:FindFirstChild("glow2") == nil and p18.Backglow.Color ~= Color3.fromRGB(0, 0, 0) then
        local v19 = Instance.new("BoolValue", p18.Backglow)
        v19.Name = "glow2"
        _G.destroy(v19, 0.35)
        _G.tween(p18.Backglow, {
            0.25,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Color"] = Color3.fromRGB(0, 0, 0)
        })
        _G.tween(p18.Back.PointLight, {
            0.25,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 0
        })
    end
    p18.Steam.Attachment.ParticleEmitter.Enabled = false
    p18.Steam.Attachment2.ParticleEmitter.Enabled = false
end
function u1.Idle(p20, p21) --[[ Line: 79 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p20.anims[1].IsPlaying == true then
        p20.anims[1]:Stop()
    end
    if p20.anims[2].IsPlaying == false then
        p20.anims[2]:Play()
    end
    u1:Backward(p21)
end
function u1.End(p22) --[[ Line: 89 ]]
    local v23 = p22.ship
    if p22.anims then
        for v24 = 1, #p22.anims do
            p22.anims[v24]:Stop()
        end
    end
    v23.FlamePart.Burn.Enabled = false
    v23.FlamePart.foot:Stop()
    return true
end
return u1