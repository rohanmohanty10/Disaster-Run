 

local v1 = {}
local u2 = 0
function v1.start(_, p3, p4, p5, p6, p7) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if (workspace.CurrentCamera.CFrame.Position - p3).Magnitude > 60 then
        return
    elseif u2 < 50 then
        u2 = u2 + 1
        local v8 = script.DMGIND:Clone()
        if p7 == nil then
            local v9 = math.random(1, 3)
            p3 = p3 + Vector3.new(0, v9, 0)
        end
        v8.CFrame = CFrame.new(p3)
        local v10 = v8.Bill.Frame
        local _ = v8.Bill.Frame.Position
        local _ = v10.Size
        v8.Bill.Frame.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        v8.Bill.Frame.TextLabel.Text = p4
        v8.Bill.Frame.TextLabel.TextLabel.Text = p4
        v8.Bill.Frame.TextLabel.TextColor3 = p5
        v8.Parent = workspace.Effects
        local v11 = p6 == nil and "Elastic" or p6
        if p7 == nil then
            v8.Anchored = false
        end
        local v12 = math.random(-15, 15)
        local v13 = math.random(25, 45)
        local v14 = math.random
        v8.Velocity = Vector3.new(v12, v13, v14(-15, 15))
        local v15 = Instance.new("BodyVelocity")
        v15.maxForce = Vector3.new(0, inf, 0)
        v15.velocity = Vector3.new(0, 5, 0)
        v15.Parent = v8
        _G.destroy(v15, 0.2)
        task.wait(0.25)
        local v16 = math.random(20, 45) / 100
        _G.tween(v8.Bill.Frame.TextLabel, {
            v16,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["TextColor3"] = Color3.fromRGB(0, 0, 0)
        })
        v10:TweenSizeAndPosition(UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 0.5, 0), "In", v11, v16)
        _G.destroy(v8, 0.25)
        task.delay(0.25, function() --[[ Line: 54 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            u2 = u2 - 1
        end)
    end
end
return v1