 

local v1 = {}
local function u6(p2, u3) --[[ Line: 4 ]]
    local u4 = p2:GetChildren()
    for u5 = 1, #u4 do
        pcall(function() --[[ Line: 7 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u5
                [3] = u3
            --]]
            u4[u5].Enabled = u3
        end)
    end
end
local function u40(p7, p8, p9, p10) --[[ Line: 13 ]]
    local v11 = CFrame.new(p7.Position)
    local v12 = Ray.new
    local v13 = v11.Position
    local v14 = p9.Y
    local v15 = v12(v13 + Vector3.new(0, v14, 0), CFrame.new(v11.Position).UpVector * -(p9.Y * 2))
    local v16, v17, v18 = _G.raycastWhitelist(v15, { workspace.Islands, workspace.Ships, workspace.Env })
    if v16 and v16.CanCollide == true then
        local u19 = script.Part:Clone()
        _G.matchMaterial(u19, v16)
        local v20 = CFrame.new(v17, v17 + v18)
        local v21 = CFrame.Angles
        local v22 = math.random(-360, 360)
        local v23 = math.rad(v22)
        local v24 = math.random(-360, 360)
        local v25 = math.rad(v24)
        local v26 = math.random(-360, 360)
        local u27 = v20 * v21(v23, v25, (math.rad(v26)))
        local v28 = Vector3.new(p8, p8, p8) * math.random(90, 110) / 100
        u19.Size = v28 / 4
        u19.CFrame = u27
        u19.Name = "test"
        u19.Parent = workspace.Effects
        _G.destroy(u19, 10)
        if p10 == nil then
            _G.tween(u19, {
                0.25,
                Enum.EasingStyle.Cubic,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = v28
            })
        else
            u19.Size = v28
        end
        spawn(function() --[[ Line: 34 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u27
            --]]
            task.wait(4)
            if u19.Parent ~= nil then
                local v29 = _G.tween
                local v30 = u19
                local v31 = {
                    0.5,
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v32 = {}
                local v33 = CFrame.new(u27.Position) * CFrame.new(0, -u19.Size.X, 0)
                local v34 = CFrame.Angles
                local v35 = math.random(-360, 360)
                local v36 = math.rad(v35)
                local v37 = math.random(-360, 360)
                local v38 = math.rad(v37)
                local v39 = math.random(-360, 360)
                v32.CFrame = v33 * v34(v36, v38, (math.rad(v39)))
                v29(v30, v31, v32)
            end
        end)
        _G.destroy(u19, 4.5)
        return u19, u27
    end
end
local u41 = require(game.ReplicatedStorage.Modules.sBeat)
function v1.start(_, u42, _) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u40
        [2] = u6
        [3] = u41
    --]]
    if _G.checkRenderDistance(u42.Position) ~= false then
        _G.PlaySound(u42, script.start)
        task.spawn(function() --[[ Line: 73 ]]
            --[[
            Upvalues:
                [1] = u42
                [2] = u40
                [3] = u6
                [4] = u41
            --]]
            local v43 = { workspace.Islands, workspace.Env, workspace.Ships }
            local v44 = Ray.new(u42.Position, CFrame.new(u42.Position).upVector * -10)
            local _, v45, _ = _G.raycastWhitelist(v44, v43)
            local v46, _, v47, v48, v49, v50, v51, v52, v53, v54, v55, v56 = u42:components()
            u42 = CFrame.new(v46, v45.Y, v47, v48, v49, v50, v51, v52, v53, v54, v55, v56)
            local v57 = script.stab:Clone()
            v57.CFrame = u42 * CFrame.new(0, 0, -2.5)
            v57.Parent = workspace.Effects
            _G.customEmit(v57.Attachment)
            _G.PlayEffect("GroundRocks2", nil, v57.CFrame, 10, 4, 1, 0.1, 3)
            _G.destroy(v57, 3)
            local v58 = v57.CFrame
            u42 = v57.CFrame
            tick()
            local u59 = false
            local v60 = {}
            for v61 = 1, 50 do
                local v62 = u42 * CFrame.new(0, 0, (v61 - 1) / 3.3333333333333335 * -15) * CFrame.new(0, 50, 0)
                local v63 = Ray.new(v62.Position, v62.upVector * -100)
                local u64, v65 = _G.raycastWhitelist(v63, v43)
                if u64 then
                    if (v58.Position - v65).Magnitude > 5 then
                        local v66 = CFrame.new(v65)
                        local u67 = script.trail:Clone()
                        local u68 = (v58.Position - v66.Position).Magnitude
                        u67.CFrame = CFrame.new(v58.Position, v66.Position) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -u68 / 2, 0)
                        local _ = v61 / 50
                        local v69 = v61 / 50 * 2
                        Vector3.new(v69, u68, 0.1)
                        u67.Mesh.Scale = Vector3.new(1, 1, 1)
                        u67.Size = Vector3.new(1, u68, 0.05)
                        u67.Parent = workspace.Effects
                        _G.customEmit(u67.GroundDust)
                        local u70 = u67.CFrame * CFrame.new(0, u68 / 2, 0)
                        local u71 = 5
                        local u72 = 1
                        local u73 = 1.5
                        spawn(function() --[[ Line: 47 ]]
                            --[[
                            Upvalues:
                                [1] = u70
                                [2] = u71
                                [3] = u40
                                [4] = u72
                                [5] = u73
                                [6] = u68
                            --]]
                            local v74 = u70
                            for _ = 1, u71 do
                                local v75 = 1
                                for _ = 1, 2 do
                                    u40(v74 * CFrame.new(u72 * v75, 0, 0), u73, Vector3.new(0, 5, 0))
                                    v75 = v75 * -1
                                end
                                v74 = v74 * CFrame.new(0, -(u68 / u71), 0)
                            end
                        end)
                        v58 = CFrame.new(v65)
                        task.spawn(function() --[[ Line: 123 ]]
                            --[[
                            Upvalues:
                                [1] = u59
                                [2] = u67
                                [3] = u64
                                [4] = u6
                            --]]
                            repeat
                                game["Run Service"].Heartbeat:Wait()
                            until u59 == true
                            u67.WindupLines.Enabled = false
                            u67.WindupEndEmit:Emit(5)
                            task.wait(0.25)
                            u67.Rocks.Color = ColorSequence.new(u64.Color)
                            u67.Rocks:Emit(5)
                            _G.customEmit(u67.Wisps)
                            _G.customEmit(u67.Wisps2)
                            u67.Sand.Enabled = true
                            u67.SandBurst.Enabled = true
                            u67.BurstLines.Enabled = true
                            _G.shakenear(u67.Position, 75, 120, 50, -0.8)
                            task.wait(0.5)
                            u6(u67, false)
                        end)
                        table.insert(v60, u67)
                        goto l4
                    end
                else
                    ::l4::
                    u41()
                end
            end
            task.wait(0.25)
            task.spawn(function() --[[ Line: 155 ]]
                --[[
                Upvalues:
                    [1] = u42
                --]]
                task.wait(0.25)
                _G.PlaySound(u42, script.booms)
            end)
            task.wait(2)
            for v76 = 1, #v60 do
                _G.destroy(v60[v76], 5)
            end
        end)
    end
end
return v1