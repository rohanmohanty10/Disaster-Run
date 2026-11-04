 

local v1 = {}
local u2 = game:GetService("TweenService")
game:GetService("RunService")
function v1.start(_, p3, p4, u5, p6) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p3 == "clean" then
        for _, v7 in workspace.Effects:GetChildren() do
            if v7.Name == "Swing" .. p4 then
                v7:Destroy()
            end
        end
        return
    elseif p3.PrimaryPart == nil then
        return
    elseif _G.checkRenderDistance(p3.PrimaryPart.Position) ~= false then
        _G.PlaySound(p3.HumanoidRootPart.CFrame, script.StringFlyShoot)
        for _ = 1, 4 do
            local v8 = script.Swing:Clone()
            v8.CFrame = p3[p6 .. "Hand"].CFrame
            v8.Name = "Swing" .. p3.Name
            v8.Parent = workspace.Effects
            local v9 = _G.tween
            local v10 = { p4, "Quad", Enum.EasingDirection.Out }
            local v11 = {}
            local v12 = CFrame.new(u5)
            local v13 = CFrame.Angles
            local v14 = math.random(0, 360)
            local v15 = math.rad(v14)
            local v16 = math.random(0, 360)
            local v17 = math.rad(v16)
            local v18 = math.random(0, 360)
            v11.CFrame = v12 * v13(v15, v17, (math.rad(v18)))
            v9(v8, v10, v11)
            task.delay(p4, function() --[[ Line: 31 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                _G.PlaySound(CFrame.new(u5), script.StringFlyGrabSurface)
            end)
            local v19 = v8.Beam
            v19.Attachment0 = p3[p6 .. "Hand"][p6 .. "GripAttachment"]
            local v20 = math.random(-100, 100)
            v19.CurveSize0 = math.sign(v20) * math.random(10, 15)
            v19.CurveSize1 = v19.CurveSize0
            u2:Create(v19, TweenInfo.new(p4 + math.random(0, 20) / 10, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                ["CurveSize0"] = 0,
                ["CurveSize1"] = 0
            }):Play()
            _G.destroy(v8, 20)
            task.wait(0.05)
        end
        local v21 = _G.PlaySound(p3.HumanoidRootPart, script.StringFlyPull)
        v21.Parent = p3.PrimaryPart
        _G.tween(v21, { 0.5, "Quad", Enum.EasingDirection.Out }, {
            ["Volume"] = 0
        })
    end
end
return v1