 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 12 ]]
        if p1 then
            _G.PlaySound(p1, script.pumpawake)
            return
        else
            local v2 = workspace.NPCs:WaitForChild("Demon Jester", 10)
            if v2 ~= nil then
                local v3 = game.Players.LocalPlayer.PlayerGui:GetChildren()
                local v4 = {}
                for v5 = 1, #v3 do
                    if v3[v5]:IsA("ScreenGui") and v3[v5].Enabled == true then
                        v3[v5].Enabled = false
                        local v6 = v3[v5]
                        table.insert(v4, v6)
                    end
                end
                local v7 = script.ScreenGui:Clone()
                v7.Frame.BackgroundTransparency = 1
                v7.Parent = game.Players.LocalPlayer.PlayerGui
                _G.tween(v7.Frame, {
                    0.25,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["BackgroundTransparency"] = 0
                })
                _G.destroy(v7, 0.5)
                local _ = workspace.CurrentCamera.CFrame
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                _G.PlaySound(v2.PrimaryPart, script.pumpawake)
                local v8 = v2.Humanoid:LoadAnimation(script.awaken)
                v8:Play(0)
                v8:AdjustWeight(2)
                local v9 = tick()
                local v10 = workspace.CurrentCamera
                repeat
                    v10.CameraType = Enum.CameraType.Scriptable
                    v10.CFrame = v2.camra.CFrame
                    game["Run Service"].RenderStepped:Wait()
                until tick() - v9 >= 4.2
                local v11 = script.ScreenGui:Clone()
                v11.Frame.BackgroundTransparency = 1
                v11.Parent = game.Players.LocalPlayer.PlayerGui
                _G.tween(v11.Frame, {
                    0.5,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["BackgroundTransparency"] = 0
                })
                _G.destroy(v11, 1)
                task.wait(0.5)
                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                task.wait(0.5)
                for v12 = 1, #v4 do
                    if v4[v12] then
                        v4[v12].Enabled = true
                    end
                end
            end
        end
    end
}