 

local v1 = {}
require(game.ReplicatedStorage.Modules.FastWait)
function v1.start(_, p2, p3, p4, p5, p6, p7) --[[ Line: 3 ]]
    if _G.checkRenderDistance(p3.Position) ~= false then
        local v8 = p4 == nil and 1 or p4
        local u9 = script.Parent.Parent.Parent.Parent.DevilFruits.Magu.MaguBalls["Ball" .. math.random(1, 4)]:Clone()
        local _ = p2.Size.X / 4
        local v10 = p2.Size.Y / 4
        local v11 = p2.Size.Z / 4
        local v12 = p3 * CFrame.new(0, math.random(-v10, v10), math.random(-v11, v11))
        local v13 = CFrame.Angles
        local v14 = math.random(-360, 360)
        local v15 = math.rad(v14)
        local v16 = math.random(-360, 360)
        local v17 = math.rad(v16)
        local v18 = math.random(-360, 360)
        u9.CFrame = v12 * v13(v15, v17, (math.rad(v18)))
        u9.Name = "trailMagu"
        u9.Parent = workspace.Effects
        local v19 = _G.tween
        local v20 = {
            5,
            Enum.EasingStyle.Circular,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v21 = {}
        local v22 = u9.CFrame
        local v23 = CFrame.Angles
        local v24 = math.random(-360, 360)
        local v25 = math.rad(v24)
        local v26 = math.random(-360, 360)
        local v27 = math.rad(v26)
        local v28 = math.random(-360, 360)
        v21.CFrame = v22 * v23(v25, v27, (math.rad(v28)))
        v19(u9, v20, v21)
        _G.tween(u9, {
            0.5,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = u9.Size * (2 * v8)
        })
        if math.random(1, 4) == 1 then
            local v29 = p2.Size.X / 2
            local v30 = p2.Size.Y / 2
            local v31 = p2.Size.Z / 2
            local _ = v29 * 200
            local _ = v30 * 100
            local _ = v31 * 200
            _G.PlayEffect("Drip", nil, p2, { 800 * v8, 1500 * v8 }, { 100 * v8, 300 * v8 }, 20)
        end
        local v32 = p5 == nil and 0.25 or p5
        local u33 = p6 == nil and 0.5 or p6
        task.delay(v32, function() --[[ Line: 34 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u33
            --]]
            _G.tween(u9, {
                u33,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.In,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(0, 0, 0)
            })
            _G.destroy(u9, u33)
            u9 = nil
        end)
        if p7 == nil and p2:FindFirstChild("Shockwave") ~= nil then
            local v34 = p2.Shockwave:Clone()
            local v35 = v34.Size
            v34.Size = Vector3.new(0, 0, 0)
            local v36 = math.random(100, 500)
            local v37 = CFrame.new(-15, math.random(-v36, v36) / 100, math.random(-v36, v36) / 100)
            local v38 = CFrame.Angles
            local v39 = math.random(-360, 360)
            local v40 = v37 * v38(math.rad(v39), 0, 0)
            v34.CFrame = v34.CFrame * v40
            local v41 = Color3.fromRGB(0, 0, 0)
            v34.Transparency = -1
            v34.Anchored = true
            v34:ClearAllChildren()
            v34.Parent = workspace.Effects
            local v42 = _G.tween
            local v43 = {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v44 = {
                ["Transparency"] = 1
            }
            local v45 = v35 * 2
            local v46 = 10 * v8
            v44.Size = v45 - Vector3.new(v46, 0, 0)
            v44.Color = v41
            v42(v34, v43, v44)
            _G.destroy(v34, 0.25)
        end
    end
end
return v1