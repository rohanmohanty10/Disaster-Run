 

local u1 = {}
u1.__index = u1
function u1.Start(_, p2, _) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = {}
    local v4 = u1
    setmetatable(v3, v4)
    repeat
        task.wait()
    until p2.Humanoid.SeatPart ~= nil
    local v5 = p2.Humanoid.SeatPart:WaitForChild("SeatWeld", 2)
    if v5 then
        v5.C0 = v5.C0 * CFrame.new(0, 0, 1.1 * p2.Humanoid.BodyHeightScale.Value)
    end
    local v6 = p2.Humanoid:LoadAnimation(script.sit)
    v6:Play()
    v3.anim = v6
    return v3
end
function u1.End(p7) --[[ Line: 18 ]]
    if p7.anim then
        p7.anim:Stop()
        p7.anim = nil
    end
    return true
end
return u1