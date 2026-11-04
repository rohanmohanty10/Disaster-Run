 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 15 ]]
        if p3 and game.Players.LocalPlayer == p3 then
            return
        elseif _G.checkRenderDistance(p1.Position) ~= false then
            for v4 = 1, 5 do
                local v5 = p1 * CFrame.new(math.random(-200, 200) / 100, math.random(-200, 200) / 200, math.random(-200, 200) / 100)
                local v6 = script.Part:Clone()
                if v4 == 1 then
                    _G.tween(v6.PointLight, {
                        0.25,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Range"] = 15,
                        ["Brightness"] = 0
                    })
                    v5 = p1
                end
                v6.CFrame = v5
                if v4 % 2 == 1 then
                    v6.Color = Color3.fromRGB(255, 255, 255)
                else
                    v6.Color = script.exploson.Color
                end
                v6.Parent = workspace.Effects
                _G.tween(v6.Mesh, {
                    0.25,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["Scale"] = Vector3.new(10, 10, 10) * math.random(70, 110) / 100
                })
                _G.tween(v6, {
                    0.25,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v6, 0.25)
                local v7 = script.exploson:Clone()
                v7.CFrame = v5
                local v8 = v7.Color
                local v9, v10
                if v4 % 2 == 1 then
                    v8 = BrickColor.new("Black").Color
                    v9 = 1
                    v10 = 1
                else
                    v9 = 0.75
                    v10 = 1.15
                end
                v7.Parent = workspace.Effects
                local v11 = _G.tween
                local v12 = {
                    v9 * 1,
                    "EntranceExpressive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v13 = {}
                local v14 = v7.CFrame
                local v15 = CFrame.Angles
                local v16 = math.random(-360, 900)
                local v17 = math.rad(v16)
                local v18 = math.random(-360, 900)
                local v19 = math.rad(v18)
                local v20 = math.random(-360, 900)
                v13.CFrame = v14 * v15(v17, v19, (math.rad(v20)))
                v11(v7, v12, v13)
                _G.tween(v7, {
                    v9 * 0.5,
                    "Smoother",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Color"] = v8
                })
                _G.tween(v7, {
                    v9 * 0.35,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["Size"] = Vector3.new(6, 6, 6) * v10
                })
                _G.destroy(v7, v9 * 0.35 * 2)
            end
            local u21 = script.Trail:Clone()
            u21.Parent = p2.LeftHand
            u21.Attachment0 = p2.LeftHand.LeftGripAttachment
            u21.Attachment1 = p2.LeftHand.LeftWristRigAttachment
            task.spawn(function() --[[ Line: 8 ]]
                --[[
                Upvalues:
                    [1] = u21
                --]]
                task.wait(0.25)
                u21.Enabled = false
                _G.destroy(u21, 1)
            end)
            local u22 = script.Trail:Clone()
            u22.Parent = p2.RightHand
            u22.Attachment0 = p2.RightHand.RightGripAttachment
            u22.Attachment1 = p2.RightHand.RightWristRigAttachment
            task.spawn(function() --[[ Line: 8 ]]
                --[[
                Upvalues:
                    [1] = u22
                --]]
                task.wait(0.25)
                u22.Enabled = false
                _G.destroy(u22, 1)
            end)
            _G.PlaySound(p2.HumanoidRootPart, script.sfx, {
                ["Pitch"] = math.random(90, 100) / 100
            })
        end
    end
}