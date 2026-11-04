 

local v1 = {}
local function u15(p2) --[[ Line: 4 ]]
    local v3 = p2:GetDescendants()
    for v4 = 1, #v3 do
        if v3[v4]:IsA("Bone") and v3[v4].Name ~= "A1" then
            local v5 = v3[v4].Position
            local v6 = v3[v4].Orientation
            local v7 = v3[v4]
            local v8 = math.random(-100, 100) / 1000
            local v9 = math.random(-100, 100) / 1000
            local v10 = math.random(-100, 100) / 1000
            v7.Position = Vector3.new(v8, v9, v10)
            local v11 = v3[v4]
            local v12 = math.random(-25, 25)
            local v13 = math.random(-25, 25)
            local v14 = math.random
            v11.Orientation = Vector3.new(v12, v13, v14(-25, 25))
            _G.tween(v3[v4], {
                0.4,
                "Smooth",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Position"] = v5,
                ["Orientation"] = v6
            })
        end
    end
end
function v1.start(_, u16, p17, p18, p19) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u15
    --]]
    if _G.checkRenderDistance(u16.PrimaryPart.Position) ~= false then
        if p19 == nil then
            task.wait(0.6)
        else
            task.wait(p19)
        end
        _G.PlaySound(u16, script["Audio/Mero2ArrowsStart"])
        _G.tween(u16.Heart.A1, {
            0.4,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Position"] = p17
        })
        _G.tween(u16.Heart, {
            0.4,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = p18,
            ["Transparency"] = 0
        })
        u15(u16)
        task.delay(0.1, function() --[[ Line: 31 ]]
            --[[
            Upvalues:
                [1] = u16
            --]]
            _G.customEmit(u16)
        end)
    end
end
return v1