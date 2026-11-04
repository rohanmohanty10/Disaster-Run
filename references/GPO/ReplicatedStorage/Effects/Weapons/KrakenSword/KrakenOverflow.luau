 

local v1 = {}
function recu(p2, p3)
    local v4 = p2:GetChildren()
    if #v4 ~= 0 then
        v4[1].CFrame = p3
        recu(v4[1], p3)
    end
end
require(game:GetService("ReplicatedStorage").Modules.sBeat)
require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
function v1.start(_, u5, u6, u7) --[[ Line: 24 ]]
    if _G.checkRenderDistance(u5.HumanoidRootPart.Position) then
        task.wait(0.1)
        _G.PlaySound(u5.Head, script.smash)
        task.wait(0.3)
        _G.PlayEffect("GroundRocks2", nil, u5.HumanoidRootPart.CFrame * CFrame.new(0, -2.2, -2.2), 10, 3, 1, 0.1, 3)
        local v8 = ColorSequence.new(u7)
        local u9 = script.AbyssParticles:Clone()
        u9.CFrame = u5.HumanoidRootPart.CFrame * CFrame.new(0, -2.2, -2.2)
        local v10 = 3
        u9.Flare.Color = v8
        u9.Shine1.Color = v8
        u9.Shine2.Color = v8
        u9.Sparkles.Color = v8
        u9.Wave2.Color = v8
        u9.YellowSpinny.Color = v8
        u9.Burn.Color = v8
        u9.Sparkles:Emit(4)
        u9.Burn:Emit(4)
        u9.PointLight.Color = u7
        u9.Parent = workspace.Effects
        u9.Sound:Play()
        _G.tween(u9.PointLight, {
            0.3,
            "Cubic",
            Enum.EasingDirection.Out,
            -1,
            true,
            0
        }, {
            ["Range"] = 16
        })
        local u11 = tick()
        local u12 = u5.HumanoidRootPart.CFrame * CFrame.new(0, -2.2, -2.2)
        task.spawn(function() --[[ Line: 59 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u12
                [3] = u7
                [4] = u6
                [5] = u11
            --]]
            local v13 = tick()
            while true do
                local v14 = 35 * ((5 - (tick() - v13)) / 5)
                local v15 = math.clamp(v14, 1, 100)
                local v16 = u5.HumanoidRootPart.CFrame * CFrame.new(0, -2.2, -2.2)
                local v17 = Ray.new(v16.Position + Vector3.new(0, 3, 0), v16.upVector * -10)
                local _, v18, v19 = _G.raycastIgnoreList(v17, {
                    workspace.Effects,
                    workspace.Projectiles,
                    workspace.PlayerCharacters,
                    workspace.NPCs,
                    workspace.Ragdolls
                })
                u12 = CFrame.new(v18, v18 + v19) * CFrame.Angles(-1.5707963267948966, 0, 0)
                local v20 = u12
                local v21 = script.cyn:Clone()
                v21.CFrame = v20 * CFrame.new(math.random(-v15, v15), math.random(-v15, v15), math.random(-v15, v15))
                v21.CFrame = CFrame.new(v21.Position, v20.Position) * CFrame.Angles(-1.5707963267948966, 0, 0)
                local v22 = (v21.Position - v20.Position).Magnitude
                local v23 = math.random(25, 75) / 100
                v21.Mesh.Scale = Vector3.new(v23, v22, v23)
                if math.random(1, 2) == 1 then
                    v21.Color = Color3.fromRGB(0, 0, 0)
                else
                    v21.Color = u7
                end
                v21.Parent = workspace.Effects
                local v24 = math.random(100, 350) / 1000
                _G.tween(v21.Mesh, {
                    v24,
                    "Cubic",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(0, 0, 0),
                    ["Offset"] = Vector3.new(0, v22, 0)
                })
                _G.destroy(v21, v24)
                game["Run Service"].Heartbeat:Wait()
                if u6:IsDescendantOf(game) == false or tick() - u11 >= 6 then
                    return
                end
            end
        end)
        local v25 = u12
        while u6:IsDescendantOf(game) and tick() - u11 < 6 do
            local _ = u5.HumanoidRootPart.CFrame * CFrame.new(0, -2.2, -2.2)
            u9.CFrame = v25
            v10 = v10 + task.wait(0.1) * 2
            _G.customEmit(u9.YellowSpinny)
            _G.customEmit(u9.Wave)
            _G.customEmit(u9.Burn)
            _G.customEmit(u9.Shine2)
            _G.customEmit(u9.Shine1)
            _G.customEmit(u9.GroundRings)
            _G.customEmit(u9.GroundDust)
            _G.customEmit(u9.FloatingRocks)
            _G.customEmit(u9.Flare)
            _G.customEmit(u9.BlackWisps)
            task.spawn(function() --[[ Line: 108 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                _G.shakenear(u9.CFrame.Position, 75, 35, 45, -2)
            end)
        end
        _G.tween(u9.Sound, {
            0.6,
            "Cubic",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        _G.tween(u9.PointLight, {
            0.3,
            "Cubic",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0
        })
        _G.destroy(u9, 3)
    end
end
return v1