 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.Position) then
            local v2 = script.MochiStick:Clone()
            local u3 = v2:WaitForChild("Cube.001")
            v2:PivotTo(p1)
            v2.Parent = workspace.Effects
            local u4 = v2.AnimationController:LoadAnimation(v2.Animation)
            spawn(function() --[[ Line: 15 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u3
                --]]
                local v5 = tick()
                while u4.Length == 0 do
                    task.wait()
                end
                local v6 = 1 - (tick() - v5)
                print(v6)
                u3.Transparency = -1
                u4:Play(0)
                _G.tween(u3, {
                    v6,
                    "Exponential",
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
            end)
            _G.destroy(v2, 3)
        end
    end
}