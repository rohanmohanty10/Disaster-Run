 

local v1 = {}
local u2 = {}
require(game.ReplicatedStorage.Modules.ModelResize)
require(script.Parent.MagmaTrail)
function v1.impact(p3, p4, p5, _) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[p3] then
        u2[p3] = nil
    end
    if p4 and p3:FindFirstChild("Shockwave") then
        p3.sfx:Stop()
        _G.PlaySound(p3, script["NewMaguUltBoom" .. math.random(1, 3)])
        local u6 = CFrame.new(p5)
        local v7 = script.sphere:Clone()
        v7.CFrame = u6
        v7.Parent = workspace.Effects
        _G.tween(v7.Mesh, {
            0.5,
            Enum.EasingStyle.Circular,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(40, 40, 40)
        })
        _G.tween(v7, {
            0.5,
            Enum.EasingStyle.Cubic,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v7, 1)
        p3.Parent:Destroy()
        if _G.fastmode == true or _G.omegabooster == true then
            return
        end
        for _ = 1, 2 do
            local u8 = script.Parent.Parent.Parent.Parent.DevilFruits.Magu.MaguBalls["Ball" .. math.random(1, 4)]:Clone()
            u8.Anchored = true
            u8.Size = u8.Size * math.random(85, 100) / 100
            local v9 = CFrame.new(p5) * CFrame.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5))
            local v10 = CFrame.Angles
            local v11 = math.random(-360, 360)
            local v12 = math.rad(v11)
            local v13 = math.random(-360, 360)
            local v14 = math.rad(v13)
            local v15 = math.random(-360, 360)
            local u16 = v9 * v10(v12, v14, (math.rad(v15)))
            u8.CFrame = u6
            u8.Parent = workspace.Effects
            _G.tween(u8, {
                0.5,
                "Smoother",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = u8.Size * 2
            })
            _G.tween(u8, {
                3,
                Enum.EasingStyle.Circular,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u16
            })
            task.spawn(function() --[[ Line: 44 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u6
                    [3] = u8
                --]]
                task.wait(3)
                local _, _, _, v17, v18, v19, v20, v21, v22, v23, v24, v25 = u16:components()
                local v26 = {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["CFrame"] = CFrame.new(u6.X, u6.Y, u6.Z, v17, v18, v19, v20, v21, v22, v23, v24, v25)
                }
                _G.tween(u8, {
                    1,
                    "Smoother",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, v26)
                _G.destroy(u8, 1)
            end)
        end
    end
end
function v1.move(p27, p28) --[[ Line: 102 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p28.Position) == false then
        return
    else
        if u2[p27] == nil then
            u2[p27] = CFrame.new(0, 0, 0)
        end
        if (u2[p27].Position - p28.p).magnitude < 10 then
            return
        else
            u2[p27] = p28
            if p27:FindFirstChild("Shockwave") ~= nil then
                local v29 = p27.Shockwave:Clone()
                local v30 = v29.Size
                local v31 = math.random(50, 200)
                local v32 = p27.CFrame * CFrame.new(-5, math.random(-v31, v31) / 100, math.random(-v31, v31) / 100)
                local v33 = CFrame.Angles
                local v34 = math.random(-360, 360)
                v29.CFrame = v32 * v33(math.rad(v34), 0, 0)
                local v35 = Color3.fromRGB(0, 0, 0)
                v29.Transparency = -1
                v29.Anchored = true
                v29.Parent = workspace.Effects
                local _ = math.random(1, 2) == 1
                _G.tween(v29, {
                    0.2,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v29.CFrame,
                    ["Transparency"] = 1,
                    ["Size"] = v30 * 1.35 + Vector3.new(20, 0, 0),
                    ["Color"] = v35
                })
                _G.destroy(v29, 0.2)
            end
        end
    end
end
function v1.Fire(_, _, p36) --[[ Line: 135 ]]
    local v37 = script["NewMaguUltShoot" .. math.random(1, 3)]:Clone()
    v37.Parent = p36
    v37:Play()
    v37.Name = "sfx"
end
return v1