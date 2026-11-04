 

return {
    ["start"] = function(_, u1, p2) --[[ Name: start, Line 12 ]]
        u1.Archivable = true
        if game.Players.LocalPlayer.Character == u1 == true then
            local u3 = script.GoldenUI:Clone()
            u3.ImageLabel.ImageTransparency = 1
            u3.Parent = game.Players.LocalPlayer.PlayerGui
            _G.tween(u3.ImageLabel, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                ["ImageTransparency"] = script.GoldenUI.ImageLabel.ImageTransparency
            })
            task.delay(p2, function() --[[ Line: 28 ]]
                --[[
                Upvalues:
                    [1] = u3
                --]]
                _G.tween(u3.ImageLabel, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                    ["ImageTransparency"] = 1
                })
                _G.destroy(u3, 0.25)
            end)
        end
        for _, u10 in u1:GetDescendants() do
            if u10:IsA("BasePart") and u10.Transparency ~= 1 then
                local v5 = u10
                local u6 = u10.Parent:FindFirstChild("Humanoid") ~= nil
                local _ = u10.Color
                if u10:IsA("MeshPart") or u10.Name == "Head" then
                    if u10.Name == "Head" and u10:IsA("MeshPart") == false then
                        local v7 = script.Head:Clone()
                        v7.CFrame = u10.CFrame
                        v7.Color = u10.Color
                        v7.Material = u10.Material
                        local v8 = u10.Size.Y
                        if u10:FindFirstChild("Mesh") then
                            v8 = u10.Mesh.Scale.Y
                        end
                        v7.Size = Vector3.new(v8, v8, v8)
                        v7.Name = "fakeHead"
                        v7.Parent = u1
                        local v9 = Instance.new("Weld")
                        v9.Part0 = v7
                        v9.Part1 = v5
                        v9.Parent = v7
                        local u10 = v7
                        _G.destroy(u10, p2)
                    end
                    local v11 = script.SurfaceAppearance:Clone()
                    v11.Parent = u10
                    _G.destroy(v11, p2)
                end
                task.delay(p2, function() --[[ Line: 69 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u6
                    --]]
                    local v12 = u10.CFrame
                    local v13 = Random.new()
                    if u6 == true then
                        local v14 = _G.PlayEffect
                        local v15 = {
                            ["Position"] = v12.Position
                        }
                        local v16 = v13:NextNumber(-20, 20)
                        local v17 = v13:NextNumber(6, 15)
                        v15.Velocity = Vector3.new(v16, v17, v13:NextNumber(-20, 20))
                        v15.AngularVelocity = Random.new():NextUnitVector() * 3
                        local v18 = v13:NextNumber(0.5, 1)
                        v15.Size = Vector3.new(v18, 0.08, v13:NextNumber(0.5, 1))
                        v15.Duration = v13:NextInteger(2, 4)
                        v15.Color = Color3.fromRGB(239, 184, 56)
                        v15.Material = Enum.Material.Metal
                        v15.customModel = script.Parent.Gold_shatter:GetChildren()[math.random(1, #script.Parent.Gold_shatter:GetChildren())]
                        local v19 = v14("CreateRock", "skipThread", v15)
                        script.SurfaceAppearance:Clone().Parent = v19
                    end
                end)
            end
        end
        task.delay(p2, function() --[[ Line: 93 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            _G.PlaySound(u1.PrimaryPart, script.GoldBreakFullBody, {
                ["RandomPitch"] = true
            })
        end)
        local v20 = Instance.new("Highlight")
        v20.OutlineTransparency = 1
        v20.DepthMode = Enum.HighlightDepthMode.Occluded
        v20.FillTransparency = 0
        v20.OutlineColor = Color3.fromRGB(48, 48, 48)
        v20.FillColor = Color3.fromRGB(207, 153, 67)
        v20.Parent = u1
        _G.tween(v20, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["FillTransparency"] = 1
        })
        _G.destroy(v20, 0.25)
    end
}