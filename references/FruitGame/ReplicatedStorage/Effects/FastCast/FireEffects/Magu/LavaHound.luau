 

local v1 = {}
local u2 = {}
require(game.ReplicatedStorage.Modules.ModelResize)
local u3 = require(script.Parent.MagmaTrail)
_G.getEffect("Shockwave")
function v1.impact(p4, p5, p6, _) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    _G.destroy(p4.Parent, 2)
    if u2[p4] then
        u2[p4] = nil
    end
    if p5 then
        _G.tween(p4.PointLight, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 60,
            ["Brightness"] = 0
        })
        _G.PlaySound(CFrame.new(p6), script.explode)
        p4.sm2.Enabled = false
        p4.Transparency = 1
        local u7 = CFrame.new(p6)
        local v8 = script.dust:Clone()
        v8.CFrame = CFrame.new(p6)
        v8.Attachment.sm2.Color = ColorSequence.new(p5.Color)
        v8.Attachment.sm2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 5, 0), NumberSequenceKeypoint.new(0.5, 45, 0), NumberSequenceKeypoint.new(1, 45, 0) })
        v8.Parent = workspace.Effects
        v8.Attachment.sm2:Emit(25)
        _G.destroy(v8, 2)
        local v9 = script.sphere:Clone()
        v9.Parent = workspace.Effects
        v9.CFrame = u7
        _G.tween(v9.Mesh, {
            0.5,
            Enum.EasingStyle.Circular,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(75, 75, 75)
        })
        _G.tween(v9, {
            0.5,
            Enum.EasingStyle.Cubic,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v9, 1)
        if _G.fastmode == true or _G.omegabooster == true then
            return
        end
        for _ = 1, 5 do
            local u10 = script.Parent.Parent.Parent.Parent.DevilFruits.Magu.MaguBalls["Ball" .. math.random(1, 4)]:Clone()
            u10.Anchored = true
            u10.Size = u10.Size * math.random(125, 160) / 100
            u10.CFrame = u7
            u10.Parent = workspace.Effects
            local v11 = CFrame.new(p6) * CFrame.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))
            local v12 = CFrame.Angles
            local v13 = math.random(-360, 360)
            local v14 = math.rad(v13)
            local v15 = math.random(-360, 360)
            local v16 = math.rad(v15)
            local v17 = math.random(-360, 360)
            local u18 = v11 * v12(v14, v16, (math.rad(v17)))
            _G.tween(u10, {
                1,
                "Smoother",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = u10.Size * 2
            })
            _G.tween(u10, {
                4,
                Enum.EasingStyle.Circular,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u18
            })
            task.spawn(function() --[[ Line: 60 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u7
                    [3] = u10
                --]]
                task.wait(4)
                local _, _, _, v19, v20, v21, v22, v23, v24, v25, v26, v27 = u18:components()
                local v28 = {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["CFrame"] = CFrame.new(u7.X, u7.Y, u7.Z, v19, v20, v21, v22, v23, v24, v25, v26, v27)
                }
                _G.tween(u10, {
                    1,
                    Enum.EasingStyle.Circular,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, v28)
                _G.destroy(u10, 1)
            end)
        end
        for _ = 1, 10 do
            local u29 = script.Parent.Parent.Parent.Parent.DevilFruits.Magu.MaguBalls["Ball" .. math.random(1, 4)]:Clone()
            u29.Anchored = false
            u29.Size = u29.Size * math.random(10, 125) / 1000
            local v30 = CFrame.new(p6)
            local v31 = CFrame.Angles
            local v32 = math.random(-360, 360)
            local v33 = math.rad(v32)
            local v34 = math.random(-360, 360)
            local v35 = math.rad(v34)
            local v36 = math.random(-360, 360)
            u29.CFrame = v30 * v31(v33, v35, (math.rad(v36)))
            u29.Parent = workspace.Effects
            _G.tween(u29, {
                0.5,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = u29.Size * 10
            })
            local v37 = math.random(-65, 65)
            local v38 = math.random(75, 150)
            local v39 = math.random
            u29.Velocity = Vector3.new(v37, v38, v39(-65, 65))
            local v40 = math.random(-5, 5)
            local v41 = math.random(-5, 5)
            local v42 = math.random
            u29.RotVelocity = Vector3.new(v40, v41, v42(-5, 5))
            _G.destroy(u29, 5)
            task.spawn(function() --[[ Line: 82 ]]
                --[[
                Upvalues:
                    [1] = u29
                --]]
                task.wait(0.5)
                task.wait(math.random(100, 500) / 1000)
                _G.tween(u29, {
                    0.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 0, 0)
                })
            end)
        end
    end
end
function v1.move(p43, p44) --[[ Line: 117 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if _G.checkRenderDistance(p44.Position) == false then
        return
    else
        if u2[p43] == nil then
            u2[p43] = { CFrame.new(0, 0, 0), 0, tick() }
        end
        u2[p43][2] = u2[p43][2] + (tick() - u2[p43][3])
        u2[p43][3] = tick()
        local v45 = u2[p43][2] / 0.25
        math.clamp(v45, 0, 1)
        if (u2[p43][1].Position - p44.p).magnitude >= 6 then
            u2[p43][1] = p44
            u3:start(p43, p44, 1, 0.15, 0.25, true)
            if math.random(1, 3) == 1 then
                local v46 = script.Color1:Clone()
                local _ = v46.Size
                v46.Size = Vector3.new(0, 0, 0)
                local v47 = math.random(100, 500)
                local v48 = CFrame.new(math.random(-v47, v47) / 100, -30, math.random(-v47, v47) / 100)
                local v49 = CFrame.Angles
                local v50 = math.random(-360, 360)
                local v51 = v48 * v49(0, math.rad(v50), 0)
                v46.CFrame = p43.CFrame * CFrame.Angles(0, 0, 1.5707963267948966) * v51
                v46.Transparency = -10
                v46.Anchored = true
                v46.Parent = workspace.Effects
                if math.random(1, 2) == 1 then
                    v46.Color = Color3.fromRGB(0, 0, 0)
                end
                local v52 = math.random(10, 35)
                _G.tween(v46, {
                    0.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["Size"] = Vector3.new(v52, 3, v52)
                })
                _G.PlayEffect("Rotate", nil, v46, CFrame.Angles(0, 0.08726646259971647, 0))
                _G.destroy(v46, 0.5)
                local v53 = script.Color2:Clone()
                local _ = v53.Size
                local v54 = math.random(100, 500)
                local v55 = CFrame.new(math.random(-v54, v54) / 100, -30, math.random(-v54, v54) / 100)
                local v56 = CFrame.Angles
                local v57 = math.random(-360, 360)
                local v58 = v55 * v56(0, math.rad(v57), 0)
                v53.Size = Vector3.new(0, 0, 0)
                v53.CFrame = p43.CFrame * CFrame.Angles(0, 0, 1.5707963267948966) * v58
                Color3.fromRGB(170, 85, 0)
                v53.Transparency = -10
                v53.Anchored = true
                v53.Parent = workspace.Effects
                local v59 = math.random(10, 25)
                _G.tween(v53, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["Size"] = Vector3.new(v59, 3, v59)
                })
                _G.PlayEffect("Rotate", nil, v53, CFrame.Angles(0, 0.08726646259971647, 0))
                _G.destroy(v53, 0.25)
            end
        end
    end
end
function v1.Fire(_, _, p60) --[[ Line: 176 ]]
    p60.sfx:Play()
    p60.sfx2:Play()
    p60.Parent.AnimationController:LoadAnimation(script.Animation):Play()
end
return v1