 

return {
    ["start"] = function(_, _, _, _) --[[ Name: start, Line 12 ]]
        local v1 = workspace.Effects:WaitForChild("MoriaCamera", 10)
        if v1 ~= nil then
            local v2 = game.Players.LocalPlayer.PlayerGui:GetChildren()
            local v3 = {}
            for v4 = 1, #v2 do
                if v2[v4]:IsA("ScreenGui") and v2[v4].Enabled == true then
                    v2[v4].Enabled = false
                    local v5 = v2[v4]
                    table.insert(v3, v5)
                end
            end
            local v6 = script.ScreenGui:Clone()
            v6.Frame.BackgroundTransparency = 1
            v6.Parent = game.Players.LocalPlayer.PlayerGui
            _G.tween(v6.Frame, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }, {
                ["BackgroundTransparency"] = 0
            })
            _G.destroy(v6, 0.5)
            local _ = workspace.CurrentCamera.CFrame
            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
            v1.Humanoid:LoadAnimation(script.akshanAwaken):Play()
            script.MoriaCutscene:Play()
            local v7 = tick()
            local v8 = workspace.CurrentCamera
            v1:WaitForChild("Morio Camra", 10)
            repeat
                v8.CameraType = Enum.CameraType.Scriptable
                v8.CFrame = v1["Morio Camra"].CFrame
                game["Run Service"].RenderStepped:Wait()
            until tick() - v7 >= 3.2
            local v9 = script.ScreenGui:Clone()
            v9.Frame.BackgroundTransparency = 1
            v9.Parent = game.Players.LocalPlayer.PlayerGui
            _G.tween(v9.Frame, {
                0.5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }, {
                ["BackgroundTransparency"] = 0
            })
            _G.destroy(v9, 1)
            task.wait(0.5)
            v1:Destroy()
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
            task.wait(0.5)
            for v10 = 1, #v3 do
                if v3[v10] then
                    v3[v10].Enabled = true
                end
            end
        end
    end
}