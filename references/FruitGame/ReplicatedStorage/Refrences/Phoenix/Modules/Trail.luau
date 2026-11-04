 

local v1 = game:GetService("RunService")
local u2 = game.ReplicatedStorage.Refrences.Phoenix
local u3 = workspace:WaitForChild("Effects")
local u4 = require(game.ReplicatedStorage.Util.Misc)
local u5 = {}
v1:BindToRenderStep(script.Parent.Name .. "-" .. script.Name, Enum.RenderPriority.Last.Value - 1000, function(p6) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    tick()
    for _, v7 in next, u5 do
        v7:Update(p6)
    end
end)
local u42 = {
    ["new"] = function(p8) --[[ Name: new, Line 18 ]]
        --[[
        Upvalues:
            [1] = u42
        --]]
        local v9 = {
            ["Anchor"] = p8.Anchor,
            ["Scale"] = p8.Scale or 10,
            ["Lifetime"] = p8.Lifetime or 1
        }
        local v10 = {
            ["__index"] = u42
        }
        return setmetatable(v9, v10):__init()
    end,
    ["__init"] = function(p11) --[[ Name: __init, Line 26 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        if p11.Reference then
            return p11
        end
        p11.Reference = u2.Assets.Trail:Clone()
        p11.Particles = {}
        local v12 = next
        local v13, v14 = p11.Reference:GetChildren()
        for _, v15 in v12, v13, v14 do
            local v16 = v15:FindFirstChildOfClass("ParticleEmitter")
            if v16 then
                v16.ZOffset = p11.Scale * 0.1
                local v17 = p11.Particles
                table.insert(v17, v16)
            end
        end
        p11.Top2 = p11.Reference.Top2
        p11.Top22 = p11.Reference.Top22
        p11.Bottom2 = p11.Reference.Bottom2
        p11.Bottom22 = p11.Reference.Bottom22
        p11.Reference.CFrame = p11.Anchor.CFrame
        p11.lastPos = p11.Reference.CFrame.p
        p11.Reference.Parent = u3
        p11.Angle = 0
        return p11
    end,
    ["Emit"] = function(p18) --[[ Name: Emit, Line 55 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u5
        --]]
        for _, v19 in next, p18.Particles do
            v19.Size = u4.ScaleParticleSize(v19.Size.Keypoints, p18.Scale * 0.25)
            v19.Lifetime = NumberRange.new(p18.Lifetime * 0.5, p18.Lifetime)
            v19.Enabled = true
        end
        p18.Sound = u4.PlaySound(p18.Reference, u2.Sounds.Burning, {
            ["PlaybackSpeed"] = 1
        })
        u5[p18] = p18
    end,
    ["Destroy"] = function(u20) --[[ Name: Destroy, Line 68 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
        --]]
        if not u20.Destroying then
            u20.Destroying = true
            u5[u20] = nil
            u4.DestroySound(u20.Sound, 0.25)
            for _, v21 in next, u20.Particles do
                v21.Enabled = false
            end
            coroutine.resume(coroutine.create(function() --[[ Line: 81 ]]
                --[[
                Upvalues:
                    [1] = u20
                --]]
                task.wait(1 + u20.Particles[1].Lifetime.Max)
                u20.Reference:Destroy()
            end))
        end
    end,
    ["Update"] = function(p22, p23) --[[ Name: Update, Line 87 ]]
        local v24 = tick()
        if not p22.Start then
            p22.Start = v24
        end
        local v25 = (v24 - p22.Start) / p22.Lifetime
        local v26 = math.min(1, v25)
        local v27 = p22.Scale
        p22.Angle = p22.Angle + 25.132741228718345 * p23
        local v28 = p22.Angle
        local v29 = math.cos(v28)
        local v30 = math.sin(v28)
        local v31 = Vector3.new(v29, v30)
        local v32 = 3.141592653589793 + v28
        local v33 = math.cos(v32)
        local v34 = 3.141592653589793 + v28
        local v35 = math.sin(v34)
        local v36 = Vector3.new(v33, v35)
        local v37 = CFrame.new(v27 * 0.5 * v31) * CFrame.new(0, v27 / 4, 0)
        local v38 = CFrame.new(v27 * 0.5 * v36) * CFrame.new(0, -v27 / 4, 0)
        p22.Top2.CFrame = v37 + v37.UpVector * v27 * 0.5
        p22.Top22.CFrame = v37 - v37.UpVector * v27 * 0.5
        p22.Bottom2.CFrame = v38 + v38.UpVector * v27 * 0.5
        p22.Bottom22.CFrame = v38 - v38.UpVector * v27 * 0.5
        local v39 = p22.Anchor.Position
        p22.lastPos = p22.lastPos:Lerp(v39, p23 * 8)
        local v40 = CFrame.new(v39, p22.lastPos)
        p22.Reference.CFrame = v40
        if v26 == 1 or not p22.Anchor.Parent then
            p22:Destroy()
        elseif v26 > 0.75 then
            for _, v41 in next, p22.Particles do
                v41.Enabled = false
            end
        end
    end
}
return u42