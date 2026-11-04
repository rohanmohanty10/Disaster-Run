 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 12 ]]
        if p1 then
            _G.PlaySound(p1, script.pumpawake)
            return
        else
            local v2 = workspace.NPCs:WaitForChild("Ba\'al", 10)
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
                local v9 = script.Folder:GetChildren()
                local v10 = {}
                for v11 = 1, #v9 do
                    local v12 = v9[v11]:Clone()
                    v12.Parent = v2.UpperTorso
                    table.insert(v10, v12)
                end
                local v13 = tick()
                local v14 = workspace.CurrentCamera
                repeat
                    v14.CameraType = Enum.CameraType.Scriptable
                    v14.CFrame = v2.camra.CFrame
                    game["Run Service"].RenderStepped:Wait()
                until tick() - v13 >= 5.2
                local v15 = script.ScreenGui:Clone()
                v15.Frame.BackgroundTransparency = 1
                v15.Parent = game.Players.LocalPlayer.PlayerGui
                _G.tween(v15.Frame, {
                    0.5,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["BackgroundTransparency"] = 0
                })
                _G.destroy(v15, 1)
                for v16 = 1, #v10 do
                    v10[v16].Enabled = false
                end
                _G.destroy(v10, 4)
                task.wait(0.5)
                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                task.wait(0.5)
                for v17 = 1, #v4 do
                    if v4[v17] then
                        v4[v17].Enabled = true
                    end
                end
            end
        end
    end
}