 

local v1 = {}
game:GetService("RunService")
require(game.ReplicatedStorage.Modules.ModelResize)
require(game.ReplicatedStorage.Modules.FastWait)
function v1.start(_, u2, u3, u4, u5) --[[ Line: 7 ]]
    if _G.checkRenderDistance(u2.Position, 300) ~= false then
        task.spawn(function() --[[ Line: 11 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
                [3] = u4
                [4] = u5
            --]]
            local v6 = u2.Size.X / 2
            local v7 = u2.Size.Y / 2
            local v8 = u2.Size.Z / 2
            local v9 = v6 * 200
            local v10 = v7 * 100
            local _ = v8 * 200
            local v11 = u3
            local v12, v13 = unpack(v11)
            local v14 = u4
            local v15, v16 = unpack(v14)
            local v17 = script.Parent.MaguBalls["Ball" .. math.random(1, 4)]:Clone()
            v17.CFrame = u2.CFrame * CFrame.new(math.random(-v9, v9) / 100, 0, math.random(-v10, v10) / 100)
            v17.Name = "dripper"
            local v18 = math.random(v15, v16) / 90
            local v19 = CFrame.new(v17.Position)
            local v20 = Ray.new(v19.Position, v19.UpVector * -1000)
            local v21, v22, v23 = _G.raycastWhitelist(v20, { workspace.Islands, workspace.Ships, workspace.Env })
            local v24 = (v19.Position - v22).Magnitude
            local v25 = v19 * CFrame.new(0, -v24, 0)
            if v22.Y <= workspace.Env.WaterStuff.Falls.Position.Y and v22.Y > workspace.Env.WaterStuff.Sand.Position.Y then
                v25 = CFrame.new(v25.X, workspace.Env.WaterStuff.Falls.Position.Y, v25.Z)
            end
            local v26 = 0.25 * ((v19.Position - v25.Position).Magnitude / u5)
            local v27 = v18 / 4
            local v28 = v18 / 4
            v17.Size = Vector3.new(v27, v18, v28)
            v17.CFrame = CFrame.new(v17.Position, v22) * CFrame.Angles(1.5707963267948966, 0, 0)
            v17.Parent = workspace.Effects
            local u29 = _G.tween(v17, {
                v26,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(v18, v18, v18)
            })
            local u30 = _G.tween(v17, {
                v26,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v25
            })
            task.wait(v26)
            pcall(function() --[[ Line: 40 ]]
                --[[
                Upvalues:
                    [1] = u30
                    [2] = u29
                --]]
                if u30 then
                    u30:Stop()
                    u30:Destroy()
                    u30 = nil
                end
                if u29 then
                    u29:Stop()
                    u29:Destroy()
                    u29 = nil
                end
            end)
            v17.Size = Vector3.new(0.9, 0.09, 0.9)
            local v31 = CFrame.new(v22, v22 + v23) * CFrame.Angles(1.5707963267948966, 0, 0)
            local v32
            if v22.Y <= workspace.Env.WaterStuff.Falls.Position.Y and v22.Y > workspace.Env.WaterStuff.Sand.Position.Y then
                v31 = CFrame.new(v22.X, workspace.Env.WaterStuff.Falls.Position.Y + 0.05, v22.Z)
                v32 = true
            else
                v32 = false
            end
            local v33 = CFrame.Angles
            local v34 = math.random(-360, 360)
            v17.CFrame = v31 * v33(0, math.rad(v34), 0)
            v17.Size = v17.Size * math.random(50, 150) / 100
            local v35 = math.random(v12, v13) / 100
            v17.Parent = workspace.Effects
            _G.tween(v17, {
                1,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = v17.Size * v35
            })
            _G.tween(v17.PointLight, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 5
            })
            if v32 == true then
                local v36 = v17.Size.Magnitude / 2
                v17.sm2.Size = NumberSequence.new(v36 * v35)
                v17.sm2:Emit(5)
                v17.bubbling:Play()
                v17.CanCollide = true
            end
            if v21 ~= nil and v32 == false then
                if v22.Y > workspace.Env.WaterStuff.Sand.Position.Y then
                    v17.Anchored = false
                    local v37 = Instance.new("WeldConstraint")
                    v37.Part0 = v21
                    v37.Part1 = v17
                    v37.Parent = v17
                else
                    v17.Anchored = true
                end
                _G.PlaySound(v17, script.Splats:GetChildren()[math.random(1, #script.Splats:GetChildren())], {
                    ["Pitch"] = math.random(90, 110) / 100
                })
            end
            task.wait(5)
            _G.tween(v17, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(0, 0, 0),
                ["Color"] = Color3.fromRGB(0, 0, 0)
            })
            if v17:FindFirstChild("PointLight") then
                _G.tween(v17.PointLight, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Range"] = 0
                })
            end
            _G.destroy(v17, 1)
        end)
    end
end
return v1