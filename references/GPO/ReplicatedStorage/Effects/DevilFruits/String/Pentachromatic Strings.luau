 

local v1 = {}
game:GetService("TweenService")
local u2 = game:GetService("RunService")
function v1.start(_, u3) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u3.PrimaryPart.Position) ~= false then
        _G.PlaySound(u3.HumanoidRootPart, script.RainbowStringWhoosh)
        local u4 = u3.HumanoidRootPart
        local u5 = script.Effect:Clone()
        u5.Parent = workspace.Effects
        local u6 = u2.RenderStepped:Connect(function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u4
            --]]
            u5:PivotTo(u4.CFrame * CFrame.new(0, -0.5, 0) * CFrame.Angles(0, 0, -0.3490658503988659))
        end)
        for _, v7 in u5:GetChildren() do
            if v7.Name ~= "Root" then
                v7.Weld.C0 = v7.Weld.C0 * CFrame.Angles(-3.490658503988659, 0, 0)
                if v7.Name ~= "Wind" then
                    _G.tween(v7.Weld, { 0.3, "Quint", Enum.EasingDirection.Out }, {
                        ["C0"] = v7.Weld.C0 * CFrame.Angles(2.792526803190927, 0, 0)
                    })
                    _G.tween(v7.Mesh, { 0.6, "Quad", Enum.EasingDirection.Out }, {
                        ["Scale"] = v7.Mesh.Scale * 1
                    })
                    _G.tween(v7.Decal2, { 0.2, "Linear", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                    _G.tween(v7.Decal1, { 0.3, "Linear", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                    _G.tween(v7.Decal0, { 0.4, "Quad", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                end
            end
        end
        task.delay(0.08333333333333333, function() --[[ Line: 51 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u5
            --]]
            _G.PlaySound(u3.HumanoidRootPart, script.RainbowStringGroundHit)
            for _, v8 in u5:GetChildren() do
                if v8.Name ~= "Root" and v8.Name ~= "Wind" then
                    v8.Attachment.Orientation = Vector3.new(0, 0, 0)
                    v8.Attachment.Position = Vector3.new(0, 0, 0)
                    v8.Attachment.CFrame = CFrame.Angles(0, -2.6179938779914944, 0) * CFrame.new(0, 0, v8.Mesh.Scale.X * 1) * CFrame.Angles(0, 1.5707963267948966, 0)
                    _G.customEmit(v8.Attachment)
                end
            end
        end)
        task.delay(0.8, function() --[[ Line: 65 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u5
            --]]
            u6:Disconnect()
            u5:Destroy()
        end)
        _G.tween(u5.Wind.Mesh, { 0.4, "Quad", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(10, 175, 10)
        })
        _G.tween(u5.Wind.Weld, { 0.4, "Quad", Enum.EasingDirection.Out }, {
            ["C0"] = u5.Wind.Weld.C0 * CFrame.Angles(2.0943951023931953, 0, 0)
        })
        _G.tween(u5.Wind.Decal, { 0.4, "Quad", Enum.EasingDirection.Out }, {
            ["Transparency"] = 1
        })
    end
end
return v1