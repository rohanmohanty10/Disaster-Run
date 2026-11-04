 

local v1 = {}
local u2 = {}
require(game.ReplicatedStorage.Modules.ModelResize)
local u3 = require(script.Parent.MagmaTrail)
function v1.impact(p4, p5, p6, _) --[[ Line: 29 ]]
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
        p4.sfx:Stop()
        p4.sm2.Enabled = false
        p4.Transparency = 1
        local v7 = p4:GetDescendants()
        for v8 = 1, #v7 do
            if v7[v8]:IsA("BasePart") then
                v7[v8].Transparency = 1
            end
        end
        _G.PlaySound(p4, script.explode)
        local u9 = CFrame.new(p6)
        local v10 = script.dust:Clone()
        v10.Parent = workspace.Effects
        v10.CFrame = CFrame.new(p6)
        v10.Attachment.sm2.Color = ColorSequence.new(p5.Color)
        v10.Attachment.sm2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 5, 0), NumberSequenceKeypoint.new(0.5, 45, 0), NumberSequenceKeypoint.new(1, 45, 0) })
        v10.Attachment.sm2:Emit(25)
        _G.destroy(v10, 2)
        local v11 = script.sphere:Clone()
        v11.Parent = workspace.Effects
        v11.CFrame = u9
        _G.tween(v11.Mesh, {
            0.5,
            Enum.EasingStyle.Circular,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(75, 75, 75)
        })
        _G.tween(v11, {
            0.5,
            Enum.EasingStyle.Cubic,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v11, 1)
        if _G.fastmode == true or _G.omegabooster == true then
            return
        end
        for _ = 1, 5 do
            local u12 = script.Parent.Parent.Parent.Parent.DevilFruits.Magu.MaguBalls["Ball" .. math.random(1, 4)]:Clone()
            u12.Anchored = true
            u12.Size = u12.Size * math.random(125, 160) / 100
            u12.CFrame = u9
            u12.Parent = workspace.Effects
            _G.tween(u12, {
                1,
                "Smoother",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = u12.Size * 2
            })
            local v13 = CFrame.new(p6) * CFrame.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))
            local v14 = CFrame.Angles
            local v15 = math.random(-360, 360)
            local v16 = math.rad(v15)
            local v17 = math.random(-360, 360)
            local v18 = math.rad(v17)
            local v19 = math.random(-360, 360)
            local u20 = v13 * v14(v16, v18, (math.rad(v19)))
            _G.tween(u12, {
                4,
                Enum.EasingStyle.Circular,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u20
            })
            task.spawn(function() --[[ Line: 76 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u9
                    [3] = u12
                --]]
                task.wait(4)
                local _, _, _, v21, v22, v23, v24, v25, v26, v27, v28, v29 = u20:components()
                local v30 = {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["CFrame"] = CFrame.new(u9.X, u9.Y, u9.Z, v21, v22, v23, v24, v25, v26, v27, v28, v29)
                }
                _G.tween(u12, {
                    1,
                    Enum.EasingStyle.Circular,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, v30)
                _G.destroy(u12, 1)
            end)
        end
        for _ = 1, 10 do
            local u31 = script.Parent.Parent.Parent.Parent.DevilFruits.Magu.MaguBalls["Ball" .. math.random(1, 4)]:Clone()
            u31.Anchored = false
            u31.Size = u31.Size * math.random(10, 125) / 1000
            local v32 = CFrame.new(p6)
            local v33 = CFrame.Angles
            local v34 = math.random(-360, 360)
            local v35 = math.rad(v34)
            local v36 = math.random(-360, 360)
            local v37 = math.rad(v36)
            local v38 = math.random(-360, 360)
            u31.CFrame = v32 * v33(v35, v37, (math.rad(v38)))
            u31.Parent = workspace.Effects
            _G.tween(u31, {
                0.5,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = u31.Size * 10
            })
            local v39 = math.random(-65, 65)
            local v40 = math.random(75, 150)
            local v41 = math.random
            u31.Velocity = Vector3.new(v39, v40, v41(-65, 65))
            local v42 = math.random(-5, 5)
            local v43 = math.random(-5, 5)
            local v44 = math.random
            u31.RotVelocity = Vector3.new(v42, v43, v44(-5, 5))
            _G.destroy(u31, 5)
            task.spawn(function() --[[ Line: 97 ]]
                --[[
                Upvalues:
                    [1] = u31
                --]]
                task.wait(0.5)
                task.wait(math.random(100, 500) / 1000)
                _G.tween(u31, {
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
function v1.move(p45, p46) --[[ Line: 135 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if _G.checkRenderDistance(p46.Position) == false then
        return
    else
        if u2[p45] == nil then
            u2[p45] = CFrame.new(0, 0, 0)
        end
        if (u2[p45].Position - p46.p).magnitude >= 6 then
            u2[p45] = p46
            u3:start(p45, p46)
        end
    end
end
function v1.Fire(_, _, p47) --[[ Line: 151 ]]
    p47.sfx:Play()
    p47.sfx2:Play()
end
return v1