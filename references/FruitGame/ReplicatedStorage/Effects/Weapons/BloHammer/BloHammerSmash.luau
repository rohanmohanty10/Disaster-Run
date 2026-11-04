 

local v1 = {}
local u2 = RaycastParams.new()
u2.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
u2.FilterType = Enum.RaycastFilterType.Include
local _ = _G.tween
function v1.start(_, p3, p4, p5, p6) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p4:FindFirstChild("HumanoidRootPart") then
        local v7 = script.Red
        if p6 then
            v7 = script[p6]
        end
        if p3 == "startAttack" then
            local v8 = p5.rootCFrame
            local v9 = p5.travelTime
            local v10 = p5.targetPosition
            local v11 = workspace:GetServerTimeNow() - p5.ServerTime
            local v12 = v7.Indicator:Clone()
            v12.CFrame = v8
            v12.Parent = workspace.Effects
            _G.customEmit(v12)
            _G.destroy(v12, 5)
            task.wait(0.2 - v11)
            local v13 = v8 * CFrame.new(0, -2.5, -5)
            local v14 = workspace:Raycast(v13.Position, Vector3.new(0, -50, 0), u2)
            if v14 then
                local v15 = v14.Position
                local v16 = v14.Normal
                local v17 = v7.smash:Clone()
                v17.CFrame = CFrame.new(v15, v15 + v16) * CFrame.Angles(-1.5716689914208937, 0, 0) * CFrame.new(0, 0.25, 0)
                _G.recolorParticles(v17, v14.Instance.Color)
                v17.Parent = workspace.Effects
                _G.customEmit(v17)
                _G.destroy(v17, 5)
                _G.PlaySound(v17, v7.EasterHammerEggSmashGroundHit)
                local v18 = v14.Instance.Color
                for _, v19 in v17:GetDescendants() do
                    if v19.Name == "Smoke" then
                        v19.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v18), ColorSequenceKeypoint.new(1, v18) })
                    end
                end
            end
            task.wait(0.15 - v11)
            local v20 = v7.projectile:Clone()
            v20.CFrame = v8 * CFrame.new(0, -2.5, -5)
            v20.Parent = workspace.Effects
            _G.destroy(v20, 5)
            game.TweenService:Create(v20, TweenInfo.new(v9, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["CFrame"] = CFrame.new(v10)
            }):Play()
            task.wait(v9 - v11)
            _G.particleEnabled(v20, false)
            local v21 = v7.burst:Clone()
            v21.Position = v10
            local v22, _, _ = _G.getRayFloor(v20.CFrame, 5)
            if v22 then
                _G.recolorParticles(v21, v22.Color)
            end
            v21.Parent = workspace.Effects
            _G.customEmit(v21)
            _G.destroy(v21, 5)
            _G.PlaySound(v21, v7["EasterHammerEggSmashEggPortalOpen "])
            task.wait(1 - v11)
            _G.particleEnabled(v21, false)
            return
        else
            local v23 = p5.egg
            if v23 then
                local v24 = v7.Bomb:Clone()
                v24:SetPrimaryPartCFrame(v23.PrimaryPart.CFrame)
                v24.Parent = workspace.Effects
                v24.Egg:BreakJoints()
                local u25 = v24.Cracks:GetChildren()
                for u26 = 1, #u25 do
                    local v27 = u25[u26]
                    local v28 = math.random(-35, 35)
                    local v29 = math.random(25, 45)
                    local v30 = math.random
                    v27.Velocity = Vector3.new(v28, v29, v30(-35, 35))
                    local v31 = u25[u26]
                    local v32 = math.random(-5, 5)
                    local v33 = math.random(-5, 5)
                    local v34 = math.random
                    v31.RotVelocity = Vector3.new(v32, v33, v34(-35, 35))
                    task.delay(1, function() --[[ Line: 106 ]]
                        --[[
                        Upvalues:
                            [1] = u25
                            [2] = u26
                        --]]
                        game.TweenService:Create(u25[u26], TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
                            ["Size"] = Vector3.new()
                        }):Play()
                    end)
                end
                _G.destroy(v24, 3)
            end
        end
    else
        return
    end
end
return v1