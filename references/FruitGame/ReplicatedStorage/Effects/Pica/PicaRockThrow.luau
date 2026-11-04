 

return {
    ["start"] = function(_, p1, p2, p3, p4, p5) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.Position) == false then
            return
        elseif p4 ~= nil then
            local v6 = script.Rockk:Clone()
            v6.CFrame = p2
            v6.Color = p3
            v6.Material = p4
            v6.Size = v6.Size * math.random(90, 110) / 100
            v6.Parent = workspace.Effects
            _G.tween(v6, {
                p5,
                "Back",
                Enum.EasingDirection.In,
                0,
                false,
                0
            }, {
                ["CFrame"] = CFrame.new(p1.Position, p2.Position) * CFrame.Angles(math.random(), math.random(), math.random())
            })
            _G.PlaySound(v6, script.PicaRockSummonFallingRock, {
                ["Pitch"] = math.random(90, 110) / 100
            }).Parent = v6
            _G.destroy(v6, 20)
            task.wait(p5)
            local v7, v8, v9 = _G.getRayFloor(p1, 25)
            if v7 then
                local v10 = script.crash:Clone()
                v10.CFrame = CFrame.new(v8, v9) * CFrame.Angles(0, 1.5707963267948966, 0)
                v10.Attachment.Smoke.Color = ColorSequence.new(p3)
                v10.Attachment.rocks.Color = ColorSequence.new(p3)
                v10.Parent = workspace.Effects
                _G.customEmit(v10)
                _G.destroy(v10, 6)
                _G.PlayEffect("GroundRocks2", nil, CFrame.new(v10.Position) * CFrame.new(0, 5, 0), 15, 25, 6, 0, 5)
                _G.shakenear(v8, 125, 75, 75, -0.4)
                task.wait(2)
                local v11 = _G.tween
                local v12 = {
                    1,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v13 = {}
                local v14 = CFrame.new
                local v15 = v6.Position
                local v16 = v6.Size.Y
                v13.CFrame = v14(v15 - Vector3.new(0, v16, 0))
                v11(v6, v12, v13)
                _G.destroy(v6, 1)
            end
        end
    end
}