 

local v1 = {}
local _ = game:GetService("RunService").Heartbeat
function v1.start(_, p2, p3, p4) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p2.Position) then
        for _ = 1, 6 do
            local v5 = script.s:Clone()
            local v6 = CFrame.Angles
            local v7 = math.random(-360, 360)
            local v8 = math.rad(v7)
            local v9 = math.random(-360, 360)
            local v10 = math.rad(v9)
            local v11 = math.random(-360, 360)
            v5.CFrame = p2 * v6(v8, v10, (math.rad(v11)))
            local v12 = math.random(p3 * 0.75, p3 * 1.25)
            v5.Size = Vector3.new(v12, 1, v12) / 2
            v5.Parent = workspace.Effects
            _G.tween(v5, {
                p4,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = v5.Size * 2,
                ["Transparency"] = 1
            })
            _G.destroy(v5, p4)
        end
    end
end
return v1