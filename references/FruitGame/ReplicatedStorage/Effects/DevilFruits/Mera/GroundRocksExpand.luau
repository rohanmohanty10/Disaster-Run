 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2, p3, p4, p5, u6, p7, p8, p9, p10) --[[ Line: 4 ]]
    local v11 = CFrame.new(p2.Position)
    if _G.checkRenderDistance(v11.Position) == false then
        return
    else
        local v12 = p8 == nil and 1.25 or p8
        local v13 = p9 == nil and 4 or p9
        local v14 = p10 == nil and 2.25 or p10
        local u15 = {}
        for v16 = 1, p5 do
            local u17 = script.Part:Clone()
            local v18 = CFrame.Angles
            local v19 = 360 / p5 * v16
            u17.CFrame = v11 * v18(0, math.rad(v19), 0)
            u17.CFrame = u17.CFrame * CFrame.new(0, -p4 / 2, 0)
            local _ = u17.CFrame * CFrame.new(0, 2, -10)
            local v20 = u17.CFrame * CFrame.new(0, 2, -p3)
            local v21 = CFrame.Angles
            local v22 = math.random(-360, 360)
            local v23 = math.rad(v22)
            local v24 = math.random(-360, 360)
            local v25 = math.rad(v24)
            local v26 = math.random(-360, 360)
            local v27 = v20 * v21(v23, v25, (math.rad(v26)))
            _G.destroy(u17, u6 + 1)
            local v28 = {
                0.25,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v29 = Ray.new(v27.Position + Vector3.new(0, 10, 0), CFrame.new(v27.Position).UpVector * -100)
            local v30, v31, _ = _G.raycastWhitelist(v29, { workspace.Islands, workspace.Ships, workspace.Env })
            if v30 then
                _G.matchMaterial(u17, v30)
                local v32 = CFrame.new(v31)
                local v33 = CFrame.Angles
                local v34 = math.random(-360, 360)
                local v35 = math.rad(v34)
                local v36 = math.random(-360, 360)
                local v37 = math.rad(v36)
                local v38 = math.random(-360, 360)
                local v39 = v32 * v33(v35, v37, (math.rad(v38)))
                u17.CFrame = v39
                u17.Parent = workspace.Effects
                _G.tween(u17.Mesh, v28, {
                    ["Scale"] = Vector3.new(p4, p4, p4) * (math.random(50, 100) / 100)
                })
                local v40, v41, v42, v43, v44, v45, v46, v47, v48, v49, v50, v51 = v39:components()
                table.insert(u15, {
                    u17,
                    v39,
                    v40,
                    v41,
                    v42,
                    v43,
                    v44,
                    v45,
                    v46,
                    v47,
                    v48,
                    v49,
                    v50,
                    v51
                })
                task.spawn(function() --[[ Line: 46 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                        [2] = u17
                    --]]
                    task.wait(0.25)
                    task.spawn(function() --[[ Line: 49 ]]
                        --[[
                        Upvalues:
                            [1] = u6
                            [2] = u17
                        --]]
                        task.wait(u6)
                        if u17 and u17:FindFirstChild("Mesh") == nil then
                            u17:Destroy()
                        else
                            _G.tween(u17.Mesh, {
                                0.5,
                                Enum.EasingStyle.Quad,
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Scale"] = Vector3.new(0, 0, 0)
                            })
                            _G.tween(u17, {
                                0.5,
                                Enum.EasingStyle.Quad,
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["CFrame"] = CFrame.new(u17.CFrame.Position) * CFrame.new(0, -u17.Size.X, 0)
                            })
                            _G.destroy(u17, 1)
                        end
                    end)
                end)
            else
                u17:Destroy()
            end
        end
        task.spawn(function() --[[ Line: 65 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u15
            --]]
            task.wait(u6)
            u15 = {}
        end)
        local v52 = p7.Size.X
        while true do
            local v53 = (p7.Size.X - v52) * v12
            p3 = p3 + v53
            for v54 = 1, #u15 do
                if u15[v54] then
                    local v55 = u15[v54]
                    local v56, v57, _, _, _, v58, v59, v60, v61, v62, v63, v64, v65, v66 = unpack(v55)
                    local v67 = CFrame.new(v57.Position)
                    local v68 = CFrame.Angles
                    local v69 = 360 / p5 * v54
                    v56.CFrame = v67 * v68(0, math.rad(v69), 0)
                    v56.CFrame = v56.CFrame * CFrame.new(0, -p4 / 2, 0)
                    local v70 = v56.CFrame * CFrame.new(0, 2, -p3)
                    local v71 = Ray.new(v70.Position + Vector3.new(0, 10, 0), CFrame.new(v70.Position).upVector * -100)
                    local v72, v73, _ = _G.raycastWhitelist(v71, { workspace.Islands, workspace.Ships, workspace.Env })
                    if v72 then
                        _G.matchMaterial(v56, v72)
                        local v74 = CFrame.new(v73)
                        v56.CFrame = CFrame.new(v74.X, v74.Y, v74.Z, v58, v59, v60, v61, v62, v63, v64, v65, v66)
                        v56.Size = v56.Size + Vector3.new(v53, v53, v53) / v13
                        local v75 = v56.Size.X
                        local v76 = math.clamp(v75, 0, v14)
                        v56.Size = Vector3.new(v76, v76, v76)
                        v56.Parent = workspace.Effects
                    else
                        v56.Parent = game.ReplicatedStorage
                    end
                end
            end
            v52 = p7.Size.X
            game["Run Service"].Heartbeat:Wait()
            if p7:IsDescendantOf(game) == false then
                return
            end
        end
    end
end
return v1