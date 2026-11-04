 

local v1 = {}
local function u7(p2, p3) --[[ Line: 3 ]]
    local v4 = p2.PrimaryPart
    local v5 = v4.CFrame
    for _, v6 in p2:GetChildren() do
        if v6:IsA("BasePart") then
            v6.Size = v6.Size * p3
            if v6 ~= v4 then
                v6.CFrame = v5 + v5:inverse() * v6.Position * p3
            end
        end
    end
    return p2
end
local function u26(p8) --[[ Line: 16 ]]
    local v9 = p8.initialpos
    local v10 = v9.Position
    local v11 = p8.endingpos
    local v12 = p8.segments
    local v13 = p8.offsetmultiplier
    local v14 = p8.color
    local v15 = p8.size
    local v16 = p8.mat
    local v17 = (v10 - v11).Magnitude
    local v18 = {}
    for v19 = 1, v12 do
        local v20 = script.Part:Clone()
        v20.Color = v14
        v20.Material = v16
        local v21 = v20.Mesh
        local v22 = v17 / v12
        v21.Scale = Vector3.new(v15, v15, v22)
        _G.destroy(v20, 5)
        local v23 = v9.RightVector * math.random(-(2 * v13), 2 * v13)
        local v24 = CFrame.new(v10, v11) * CFrame.new(0, 0, v17 / v12).Position + v23
        if v12 == v19 then
            local v25 = (v10 - v11).Magnitude
            v20.Mesh.Scale = Vector3.new(v15, v15, v25)
            v20.CFrame = CFrame.new(v10, v11) * CFrame.new(0, 0, -v25 / 2)
        else
            v20.CFrame = CFrame.new(v10, v24) * CFrame.new(0, 0, v17 / v12 / 2)
        end
        v10 = v20.CFrame * CFrame.new(0, 0, v17 / v12 / 2).Position
        table.insert(v18, v20)
    end
    return v18
end
local u27 = {}
function v1.start(_, p28, p29, p30) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u26
        [2] = u27
        [3] = u7
    --]]
    if _G.checkRenderDistance(p28.Position) ~= false then
        local u31 = p29 or 15
        local v32 = script.Rings:Clone()
        v32.CFrame = p28 * CFrame.Angles(3.141592653589793, 0, 0)
        local v33 = u31 / 4
        local v34 = u31 / 4
        v32.Size = Vector3.new(v33, 1, v34)
        v32.Parent = workspace.Effects
        local v35 = _G.tween
        local v36 = {
            0.2,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v37 = {}
        local v38 = u31 * 2.25
        local v39 = v32.Size.Y
        local v40 = u31 * 2.25
        v37.Size = Vector3.new(v38, v39, v40)
        v37.Transparency = 1
        v35(v32, v36, v37)
        _G.destroy(v32, 0.2)
        _G.PlayEffect("Spheres", nil, {
            ["xrange"] = u31 / 1.5,
            ["yrange"] = u31 / 1.25,
            ["zrange"] = u31 / 1.5,
            ["cf"] = p28,
            ["ti"] = 0.2,
            ["ti2"] = 0.1,
            ["range"] = 0,
            ["minThick"] = 0.2,
            ["maxThick"] = 5,
            ["part"] = nil,
            ["color"] = Color3.fromRGB(255, 255, 255),
            ["am"] = 10
        })
        _G.PlayEffect("Spheres", nil, {
            ["xrange"] = u31 / 2,
            ["yrange"] = u31,
            ["zrange"] = u31 / 2,
            ["cf"] = p28,
            ["ti"] = 0.3,
            ["ti2"] = 0.1,
            ["range"] = 0,
            ["minThick"] = 0.2,
            ["maxThick"] = 5,
            ["part"] = nil,
            ["color"] = Color3.fromRGB(102, 207, 255),
            ["am"] = 10
        })
        local u41 = p30 or 6
        for _ = 1, 10 do
            local u42 = p28 * CFrame.Angles(0, 0.6283185307179586, 0)
            task.spawn(function() --[[ Line: 68 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u42
                    [3] = u31
                    [4] = u41
                --]]
                local v43 = u26({
                    ["initialpos"] = u42,
                    ["endingpos"] = u42.Position + u42.LookVector * math.random(u31, u31 * 1.25),
                    ["segments"] = u41,
                    ["offsetmultiplier"] = math.random(1, 9) / 10 + 1,
                    ["color"] = Color3.fromRGB(102, 207, 255),
                    ["size"] = 0.05,
                    ["mat"] = Enum.Material.Neon
                })
                if v43 ~= nil then
                    for v44, v45 in v43 do
                        v45.Parent = workspace.Effects
                        local v46 = _G.tween
                        local v47 = v45.Mesh
                        local v48 = { 0.3, "EntranceProductive", Enum.EasingDirection.Out }
                        local v49 = {}
                        local v50 = v45.Mesh.Scale.X * (#v43 - v44 * 0.85)
                        local v51 = v45.Mesh.Scale.Y * (#v43 - v44 * 0.85)
                        local v52 = v45.Mesh.Scale.Z
                        v49.Scale = Vector3.new(v50, v51, v52)
                        v46(v47, v48, v49)
                        _G.tween(v45, { 0.3, "EntranceProductive", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 0.05
                        })
                        task.wait(0.05)
                    end
                    for _, u53 in v43 do
                        task.spawn(function() --[[ Line: 85 ]]
                            --[[
                            Upvalues:
                                [1] = u53
                            --]]
                            task.wait(0.3)
                            if u53 and u53:FindFirstChild("Mesh") then
                                local v54 = _G.tween
                                local v55 = u53.Mesh
                                local v56 = {
                                    0.3,
                                    Enum.EasingStyle.Cubic,
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0.5
                                }
                                local v57 = {}
                                local v58 = u53.Mesh.Scale.Z
                                v57.Scale = Vector3.new(0, 0, v58)
                                v54(v55, v56, v57)
                                _G.tween(u53, {
                                    0.3,
                                    Enum.EasingStyle.Cubic,
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0.5
                                }, {
                                    ["Transparency"] = 1
                                })
                                _G.destroy(u53, 0.3)
                            end
                        end)
                    end
                end
            end)
            p28 = u42
        end
        if u27[u31 / script.Cracks.PrimaryPart.Size.X * 1.25] == nil then
            local v59 = script.Cracks:Clone()
            u7(v59, u31 / v59.PrimaryPart.Size.X * 1.25)
            u27[u31 / script.Cracks.PrimaryPart.Size.X * 1.25] = v59
        else
            warn("uisng cached")
        end
        local v60 = u27[u31 / script.Cracks.PrimaryPart.Size.X * 1.25]:Clone()
        local v61 = CFrame.Angles
        local v62 = math.random(-360, 360)
        v60:SetPrimaryPartCFrame(p28 * v61(1.5707963267948966, 0, (math.rad(v62))))
        v60.Parent = workspace.Effects
        _G.customEmit(v60.PrimaryPart.Attachment.ParticleEmitter)
        local u63 = v60:GetChildren()
        for u64 = 1, #u63 do
            u63[u64].Anchored = true
            task.spawn(function() --[[ Line: 118 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u64
                --]]
                local v65 = _G.tween
                local v66 = u63[u64]
                local v67 = {
                    math.random(500, 1000) / 1000,
                    "EntranceExpressive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v68 = {
                    ["Transparency"] = 1,
                    ["Size"] = Vector3.new(0, 0, 0)
                }
                local v69 = u63[u64].CFrame * CFrame.new(math.random(-15, 15), math.random(-15, 15), -math.random(5, 20))
                local v70 = CFrame.Angles
                local v71 = math.random(-360, 360)
                local v72 = math.rad(v71)
                local v73 = math.random(-360, 360)
                local v74 = math.rad(v73)
                local v75 = math.random(-360, 360)
                v68.CFrame = v69 * v70(v72, v74, (math.rad(v75)))
                v65(v66, v67, v68)
            end)
        end
        _G.destroy(v60, 3)
    end
end
return v1