 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 12 ]]
        if p1 then
            _G.PlaySound(p1, script.pumpawake)
            return
        else
            local v2 = game.Players.LocalPlayer.PlayerGui:GetChildren()
            local v3 = {}
            for v4 = 1, #v2 do
                if v2[v4]:IsA("ScreenGui") and v2[v4].Enabled == true then
                    v2[v4].Enabled = false
                    local v5 = v2[v4]
                    table.insert(v3, v5)
                end
            end
            local u6 = script.ScreenGui:Clone()
            u6.Frame.BackgroundTransparency = 1
            u6.Parent = game.Players.LocalPlayer.PlayerGui
            _G.tween(u6.Frame, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["BackgroundTransparency"] = 0
            })
            _G.destroy(u6, 1)
            local v7 = workspace.NPCs:WaitForChild("Resurrected Ba\'al", 10)
            if v7 == nil then
                u6:Destroy()
                return
            else
                v7:WaitForChild("camra", 3)
                if v7:WaitForChild("UpperTorso", 3) then
                    pcall(function() --[[ Line: 44 ]]
                        --[[
                        Upvalues:
                            [1] = u6
                        --]]
                        _G.tween(u6.Frame, {
                            0.25,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["BackgroundTransparency"] = 1
                        })
                    end)
                    local _ = workspace.CurrentCamera.CFrame
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                    _G.PlaySound(v7.PrimaryPart, script.pumpawake)
                    local v8 = v7.Humanoid:LoadAnimation(script.awaken)
                    v8:Play(0)
                    v8:AdjustWeight(2)
                    local v9 = script.Folder:GetChildren()
                    local v10 = {}
                    for v11 = 1, #v9 do
                        local v12 = v9[v11]:Clone()
                        v12.Parent = v7.UpperTorso
                        table.insert(v10, v12)
                    end
                    local v13 = tick()
                    local v14 = workspace.CurrentCamera
                    repeat
                        v14.CameraType = Enum.CameraType.Scriptable
                        v14.CFrame = v7.camra.CFrame
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
                    for v17 = 1, #v3 do
                        if v3[v17] then
                            v3[v17].Enabled = true
                        end
                    end
                end
            end
        end
    end
}