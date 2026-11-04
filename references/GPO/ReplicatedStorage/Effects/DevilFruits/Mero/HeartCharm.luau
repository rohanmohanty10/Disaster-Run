 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) == false and p2 ~= "follow" then
            return
        elseif p2 == "follow" then
            local v4 = tick()
            local v5 = game.Players.LocalPlayer.Character
            repeat
                local v6 = CFrame.lookAt(v5.PrimaryPart.Position, p1.Position)
                v5.Humanoid:Move(v6.LookVector)
                v5.Humanoid.Jump = false
                game["Run Service"].RenderStepped:Wait()
            until v5:GetAttribute("evading") ~= nil or p3 <= tick() - v4
            v5.Humanoid:Move(Vector3.new(0, 0, 0), false)
        else
            local v7 = tick()
            repeat
                local v8 = script.Heart:Clone()
                local v9 = CFrame.new((p1.CFrame * CFrame.new(math.random(-1, 1), math.random(-1, 2), math.random(-1, 1))).Position)
                local v10 = CFrame.Angles
                local v11 = math.random(-360, 360)
                v8.CFrame = v9 * v10(0, math.rad(v11), 0)
                v8.Size = v8.Size / (math.random(300, 400) / 100)
                v8.Parent = workspace.Effects
                local v12 = _G.tween
                local v13 = {
                    1,
                    "EntranceExpressive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v14 = {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["Transparency"] = 1
                }
                local v15 = v8.CFrame * CFrame.new(math.random(-5, 5), math.random(5, 15), math.random(-5, 5))
                local v16 = CFrame.Angles
                local v17 = math.random(-360, 360)
                v14.CFrame = v15 * v16(0, math.rad(v17), 0)
                v12(v8, v13, v14)
                _G.destroy(v8, 1)
                _G.PlayEffect("Spheres", nil, {
                    ["cf"] = p1.CFrame,
                    ["ti"] = 0.25,
                    ["ti2"] = 0.4,
                    ["range"] = 4,
                    ["minThick"] = 0.1,
                    ["maxThick"] = 3,
                    ["part"] = p1,
                    ["color"] = Color3.fromRGB(255, 102, 204),
                    ["am"] = 1
                })
                _G.fw(0.05)
            until p2 <= tick() - v7
        end
    end
}