 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 2 ]]
        local v2 = p1.obj
        local v3 = p1.Strength
        local v4 = p1.Size
        local v5 = p1.CFrame
        local v6 = p1.PSize
        if v5 == nil then
            v5 = v2.CFrame
        end
        if _G.checkRenderDistance(v5.p) == false then
            return
        else
            local v7 = _G.awaitObject(v2)
            if v7 ~= "INVALID" then
                local v8 = workspace.Env.WaterStuff.Ocean.Position.Y
                local v9 = script.Water:Clone()
                v9.Parent = workspace.Effects
                v9.CFrame = CFrame.new(v7.CFrame.X, v8, v7.CFrame.Z)
                if v3 then
                    v9.Splash.Speed = NumberRange.new(v3 / 2, v3)
                else
                    v3 = 0
                end
                local v10 = v4 == nil and 5 or v4
                if v6 then
                    v9.Splash.Size = v6
                end
                v9.Splash:Emit(25)
                v9.sfx.EmitterSize = 50 + v3 / 2
                v9.sfx.MaxDistance = v9.sfx.MaxDistance + v3 * 4
                v9.sfx:Play()
                _G.destroy(v9, 3)
                local v11 = script.Rings:Clone()
                v11.Parent = workspace.Effects
                v11.CFrame = CFrame.new(v7.Position.X, v8 + 0.25, v7.Position.Z)
                v11.Size = Vector3.new(0, 1, 0)
                local v12 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                local v13 = {
                    ["Size"] = Vector3.new(v10, 1, v10),
                    ["Transparency"] = 1
                }
                game:GetService("TweenService"):Create(v11, v12, v13):Play()
                _G.destroy(v11, 1)
                if v7:FindFirstChildOfClass("BodyVelocity") then
                    v7:FindFirstChildOfClass("BodyVelocity").Velocity = v7:FindFirstChildOfClass("BodyVelocity").Velocity * 0.25
                end
            end
        end
    end
}