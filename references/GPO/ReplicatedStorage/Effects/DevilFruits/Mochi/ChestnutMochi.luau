 

local v1 = _G.Ess
Emit = _G.Emit
DestInt = v1.Destroy
TweenCreate = v1.Tween
Spawner = task.spawn
RaycastParameters = v1.RaycastParams
local function u7(p2, p3) --[[ Line: 18 ]]
    if typeof(p2) == "Vector3" then
        p2 = CFrame.new(p2) or p2
    end
    local v4 = 6.283185307179586 * Random.new():NextNumber(-1, 1)
    local v5 = p3 * math.cos(v4)
    local v6 = p3 * math.sin(v4)
    return p2:ToWorldSpace(CFrame.new(v5, 0, v6))
end
return {
    ["start"] = function(_, p8, p9, u10, p11) --[[ Name: start, Line 32 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        if _G.checkRenderDistance(p8.HumanoidRootPart.Position) then
            local u12 = game.Players.LocalPlayer == p11
            local _ = p8.PrimaryPart
            local u13 = Random.new()
            local v14 = p9[1]
            local v15 = p9[2]
            local v16 = CFrame.new(v14, v15)
            local _ = (v15 - v14).Unit
            local _ = (v15 - v14).Magnitude / 80
            local v17 = TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false)
            TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            local u18 = TweenInfo.new(0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.In, 0, false, 0)
            local u19 = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true)
            script.Sounds.HitPlayer:GetChildren()
            script.Sounds.HitGround:GetChildren()
            script.Sounds.Shoot:GetChildren()
            local v20 = script.Sounds.Start
            local u21 = script.MochiPivotRig:Clone()
            local v22 = u21["Cube.002"]
            local v23 = u21.RootPart
            u21:PivotTo(v16 * CFrame.new(2.1, 5, -1))
            v23.CFrame = v23.CFrame * CFrame.new(0, -40, 0)
            u21.Parent = workspace.Effects
            _G.PlaySound(v22, v20["Audio/MochiSpikesStart"], nil, true)
            TweenCreate(v22, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Transparency"] = 0
            })
            TweenCreate(v23, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["CFrame"] = v23.CFrame * CFrame.new(0, 40, 0)
            })
            local v24 = u21.AnimationController.Animator:LoadAnimation(u21.AnimationController.Animation)
            v24:Play(0.1, 1, 1.25)
            tick()
            task.wait(0.72)
            v24:AdjustSpeed(1)
            TweenCreate(v22, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Transparency"] = 1
            })
            task.delay(0.45, function() --[[ Line: 112 ]]
                --[[
                Upvalues:
                    [1] = u21
                --]]
                u21:Destroy()
            end)
            local u25 = Instance.new("Attachment")
            u25.WorldCFrame = v16 * CFrame.Angles(0, 3.141592653589793, 0)
            u25.Parent = workspace.Terrain
            local u26 = script.Dough:Clone()
            u26.CFrame = v16
            u26.Size = Vector3.new(0, 0, 0)
            u26.Parent = workspace.Effects
            local u27 = script.MochiballSpike:Clone()
            local u28 = u27.Torus
            u27:PivotTo(u26.CFrame)
            u28.Transparency = 1
            u28.AlignOrientation.Attachment1 = u25
            u28.AlignPosition.Position = u26.Position
            u27.Parent = u26
            local _ = u28.Size
            Emit(u26, true)
            TweenCreate(u26, v17, {
                ["Size"] = script.Dough.Size,
                ["CFrame"] = u26.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
            })
            task.delay(v17.Time, function() --[[ Line: 149 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u18
                    [3] = u28
                    [4] = u27
                    [5] = u19
                    [6] = u7
                    [7] = u13
                    [8] = u25
                    [9] = u10
                    [10] = u12
                --]]
                local u29 = nil
                TweenCreate(u26, u18, {
                    ["Size"] = u26.Size * 2,
                    ["Color"] = Color3.new(0.987655, 0.273167, 0.0296941)
                })
                task.delay(u18.Time - 0.15, function() --[[ Line: 157 ]]
                    --[[
                    Upvalues:
                        [1] = u26
                    --]]
                    u26.Material = Enum.Material.Neon
                end)
                task.wait(u18.Time)
                u26.Transparency = 1
                Emit(u28.haki, true)
                u28.Transparency = 0
                u28.Material = Enum.Material.Neon
                u28.Anchored = false
                u27.AnimationController.Animator:LoadAnimation(u27.AnimationController.Animation):Play(0.1, 1, 2)
                TweenCreate(u28, u19, {
                    ["Size"] = u28.Size * 1.05,
                    ["Color"] = Color3.new(0.987655, 0.274708, 0.0353094)
                })
                task.delay(u19.Time * 2, function() --[[ Line: 177 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                        [2] = u29
                        [3] = u27
                    --]]
                    u28.Material = Enum.Material.Plastic
                    u29 = u27.AnimationController.Animator:LoadAnimation(u27.AnimationController.Fire)
                    u29:Play(0.1, 1, 2)
                end)
                local v30 = tick()
                local v31 = tick() - v30
                local u32 = 0.07
                local v33 = tick()
                local u34 = math.sin(v33)
                local function u40(p35, p36) --[[ Line: 196 ]]
                    --[[
                    Upvalues:
                        [1] = u7
                        [2] = u28
                        [3] = u13
                        [4] = u25
                        [5] = u32
                        [6] = u26
                        [7] = u34
                        [8] = u10
                        [9] = u12
                    --]]
                    if typeof(p36) == "Vector3" then
                        p36 = CFrame.new(p36)
                    end
                    local v37 = p36.Position
                    if p35 == nil then
                        p35 = u7(u28.CFrame * CFrame.Angles(1.5707963267948966, 0, 0), u28.Size.X / u13:NextNumber(2, 5)).Position
                    end
                    local v38 = u32
                    u25.WorldCFrame = CFrame.new(u28.Position, v37) * CFrame.Angles(0, 3.141592653589793, (math.rad(v38)))
                    local v39 = u34
                    u28.AlignPosition.Position = u26.Position + Vector3.new(0, v39, 0)
                    if u10 and u12 == true then
                        u10:FireServer(p35, v37)
                    end
                end
                local v41
                if u10 then
                    u10.OnClientEvent:Connect(function(p42, p43) --[[ Line: 264 ]]
                        --[[
                        Upvalues:
                            [1] = u12
                            [2] = u40
                        --]]
                        if u12 ~= true then
                            u40(p42, p43)
                        end
                    end)
                    v41 = u29
                else
                    v41 = u29
                end
                while u10 ~= nil and u10:IsDescendantOf(game) ~= false do
                    if v31 > 6 and u28.haki.steam.Enabled == false then
                        Emit({ u28.haki.steam, u28.haki.steam2 }, false)
                    end
                    if u12 == true then
                        task.spawn(function() --[[ Line: 304 ]]
                            --[[
                            Upvalues:
                                [1] = u40
                            --]]
                            u40(nil, _G.MouseCF)
                        end)
                    end
                    local v44 = tick() * 8
                    u34 = math.sin(v44) * 2
                    v31 = tick() - v30
                    u32 = v31 / 1 * 180 * 2
                    task.wait(0.07)
                end
                u25:Destroy()
                TweenCreate(u28, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    ["CFrame"] = u28.CFrame * CFrame.Angles(0, 0, -3.141592653589793)
                })
                TweenCreate(u28, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
                    ["Size"] = u28.Size / 2,
                    ["Transparency"] = 1
                })
                task.delay(1.25, function() --[[ Line: 285 ]]
                    --[[
                    Upvalues:
                        [1] = u26
                    --]]
                    u26:Destroy()
                end)
                if v41 then
                    v41:Stop()
                end
                if v31 > 6 then
                    Emit({ u28.haki.steam, u28.haki.steam2 }, false)
                end
            end)
        end
    end
}