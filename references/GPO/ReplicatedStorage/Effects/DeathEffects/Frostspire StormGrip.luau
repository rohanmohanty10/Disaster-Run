 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2, p3) --[[ Line: 5 ]]
    local v4, v5, v6 = _G.getRayFloor(p2, 8)
    local v7
    if v4 then
        local v8 = v5 + Vector3.new(0, 0.2, 0)
        local v9 = CFrame.new(v8, v8 + v6)
        local v10 = CFrame.Angles
        local v11 = math.random(0, 360)
        v7 = v9 * v10(-1.5707963267948966, math.rad(v11), 0)
    else
        v7 = nil
    end
    local v12 = script.Tornado:Clone()
    v12:SetPrimaryPartCFrame(p2)
    if v7 then
        v12:SetPrimaryPartCFrame(v7)
    end
    v12.Parent = workspace.Effects
    _G.PlaySound(v12, script.IceTornadoGrip)
    task.wait(p3)
    _G.particleEnabled(v12, false)
    _G.destroy(v12, 5)
    local v13 = script.Explosion:Clone()
    v13:SetPrimaryPartCFrame(p2)
    v13.Parent = workspace.Effects
    _G.customEmit(v13)
    _G.destroy(v13, 5)
end
return v1