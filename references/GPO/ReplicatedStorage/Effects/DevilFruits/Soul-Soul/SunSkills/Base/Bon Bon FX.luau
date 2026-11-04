 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
Random.new()
require(script.Parent.Shared)
local u2 = script.VFX
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 10 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local _ = p3.Gravity
        local _ = p3.Velocity
        local v4 = p3.Character
        local _ = p3.CloudModel
        local v5 = p3.Duration
        local v6 = p3.serverStartTime
        local v7 = p3.Velocity
        local v8 = p3.StartCFrame.Position
        local v9 = p3.Gravity
        local v10 = script.VFX.Projectile:Clone()
        v10.CFrame = p3.StartCFrame
        v10.Parent = workspace.Effects
        local v11 = u2.Fire_From_Mouth:Clone()
        v11.CFrame = v10.CFrame * CFrame.new(0, 0, -2)
        v11.Parent = workspace.Effects
        task.delay(3, v11.Destroy, v11)
        _G.PlaySound(v11, script.PrometheusShoot1).Parent = v10
        _G.customEmit(v11)
        local v12 = RaycastParams.new()
        v12.FilterDescendantsInstances = _G.getTargetsWithENV(v4)
        v12.FilterType = Enum.RaycastFilterType.Include
        local v13 = v8
        local v14 = nil
        while true do
            local v15 = workspace:GetServerTimeNow() - v6
            if v5 <= v15 then
                break
            end
            local v16 = v8 + v7 * v15 + 0.5 * v9 * v15 * v15
            local _ = v7 + v9 * v15
            v14 = workspace:Raycast(v13, v16 - v13, v12)
            if v14 and v14.Instance then
                break
            end
            v10.CFrame = CFrame.new(v16) * p3.StartCFrame.Rotation
            task.wait()
            v13 = v16
        end
        _G.particleEnabled(v10, false)
        v10.Attachment.PointLight.Enabled = false
        _G.destroy(v10, 5)
        if v14 and v14.Instance then
            local v17 = {
                ["Position"] = v14.Position,
                ["Normal"] = v14.Normal,
                ["Instance"] = v14.Instance
            }
            if _G.getTargetByPart(v17.Instance) then
                local v18, v19, v20 = _G.getRayFloor(CFrame.new(v17.Position), 15)
                v17 = v18 and {
                    ["Position"] = v19,
                    ["Normal"] = v20,
                    ["Instance"] = v18
                } or v17
            end
            local v21 = u2.Explosion:Clone()
            v21.CFrame = v17 and CFrame.new(v17.Position, v17.Position + v17.Normal) * CFrame.Angles(-1.5707963267948966, 0.00017453292519943296, 0.00017453292519943296) * CFrame.new(0, 0.01, 0) or CFrame.new(v10.Position)
            v21.CFrame = v21.CFrame * CFrame.Angles(0, math.random(-360, 360), 0)
            _G.recolorParticles(v21, ColorSequence.new(v17.Instance.Color))
            v21.Parent = workspace.Effects
            _G.PlaySound(v21, script.PrometheusCloseExplosion, {
                ["RandomPitch"] = true
            })
            u1:Create(v21.PointLight, TweenInfo.new(0.25), {
                ["Brightness"] = 0,
                ["Range"] = v21.PointLight.Range * 1.5
            }):Play()
            _G.customEmit(v21)
            _G.destroy(v21, 4)
        end
    end
}