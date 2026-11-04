 

local v1 = {}
local function u11(p2, p3, p4, p5, p6) --[[ Line: 6 ]]
    local v7 = p3 + (p4 - p3) * p2
    local v8 = p4 + (p5 - p4) * p2
    local v9 = p5 + (p6 - p5) * p2
    local v10 = v7 + (v8 - v7) * p2
    return v10 + (v8 + (v9 - v8) * p2 - v10) * p2
end
function v1.start(_, u12, u13, u14, u15, u16, u17, u18) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    if _G.checkRenderDistance(u12.Position) ~= false then
        local u19 = 0
        local v20 = CFrame.Angles
        local v21 = math.random(-360, 360)
        local v22 = math.rad(v21)
        local v23 = math.random(-360, 360)
        local v24 = math.rad(v23)
        local v25 = math.random(-360, 360)
        local u26 = v20(v22, v24, (math.rad(v25)))
        local u27 = nil
        u27 = game:GetService("RunService").Stepped:Connect(function(_, p28) --[[ Line: 25 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u13
                [3] = u17
                [4] = u27
                [5] = u11
                [6] = u14
                [7] = u15
                [8] = u16
                [9] = u12
                [10] = u26
            --]]
            u19 = u19 + p28
            local v29 = u19 / u13
            local v30
            if v29 > 1 then
                v30 = u17
                u27:Disconnect()
                u27 = nil
            else
                v30 = u11(v29, u14, u15, u16, u17)
            end
            u12.CFrame = CFrame.new(v30) * u26
        end)
        task.delay(u13, function() --[[ Line: 43 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u12
            --]]
            _G.PlayEffect("LiberationHit", nil, u18.hitCFrame, u18.Color, u18.Size)
            task.wait(2)
            _G.tween(u12, {
                1,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
        end)
    end
end
return v1