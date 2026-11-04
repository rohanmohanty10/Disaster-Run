 

return {
    ["start"] = function(_, p1, p2, p3, _) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) == false then
            return
        end
        local v4 = p1 * CFrame.Angles(0, 1.5707963267948966, 0)
        local v5 = script.effect:Clone()
        v5.Trail.Enabled = true
        v5.Parent = workspace.Effects
        _G.customEmit(v5.sm3)
        _G.customEmit(v5.sm2)
        local v6 = 0
        local v7 = math.random(45, 90) * p3
        if _G.FPS > 61 then
            v7 = math.random(150, 190) * (p3 * _G.FPS / 60)
        end
        for v8 = 1, 25 * _G.FPS / 60 do
            if v7 <= v6 then
                break
            end
            local v9 = v5.CFrame
            local v10 = CFrame.Angles
            local v11 = v8 * p3 * p2
            v5.CFrame = v9:Lerp(v4 * v10(0, math.rad(v11) * 60 / _G.FPS, 0) * CFrame.new(0, 0, 10), 1)
            v6 = v6 + v8 * p3 * _G.FPS / 60
            game["Run Service"].RenderStepped:Wait()
        end
        v5.sm2.Enabled = false
        _G.customEmit(v5.sm3)
        _G.customEmit(v5.sm2)
        v5.cn.ParticleEmitter:Emit(1)
        v5.Trail.Enabled = false
        _G.destroy(v5, 3)
    end
}