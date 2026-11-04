 

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
    warn("sitting")
    repeat
        task.wait()
    until p2.Humanoid.SeatPart ~= nil
    p2.Humanoid.SeatPart:WaitForChild("SeatWeld", 2)
    local v6 = p2.Humanoid:LoadAnimation(script.sit)
    v6:Play()
    v4.RegY = p3.m.Position.Y
    v4.anims = { v6 }
    v4.ship = p3
    return v4
end
function u1.int(_, p7, p8) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v9 = {}
    local v10 = u1
    setmetatable(v9, v10)
    repeat
        task.wait()
    until p7.Humanoid.SeatPart ~= nil
    local v11 = p7.Humanoid:LoadAnimation(script.sit)
    v11:Play()
    v9.anims = { v11 }
    v9.ship = p8
    warn("sitting")
    return v9
end
function u1.End(p12) --[[ Line: 34 ]]
    local _ = p12.ship
    if p12.anims then
        for v13 = 1, #p12.anims do
            p12.anims[v13]:Stop()
        end
    end
    return true
end
return u1