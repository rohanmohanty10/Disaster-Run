 

local v1 = {}
function ConnectPoints(p2, p3, p4, p5)
    local v6 = Instance.new("Part")
    local v7 = (p3 - p2).magnitude
    v6.Anchored = true
    v6.CanCollide = false
    v6.TopSurface = "Smooth"
    v6.BottomSurface = "Smooth"
    v6.Material = Enum.Material.Neon
    v6.Color = p5
    v6.Size = Vector3.new(p4, v7, p4)
    v6.CFrame = CFrame.new(p2, p3) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -v7 / 2, 0)
    return v6
end
function TraceLine(p8, p9, p10, p11)
    local v12 = { p8 }
    local v13 = (p9 - p8).magnitude
    local v14 = math.random(4, 8)
    local v15 = p10.X
    local v16 = math.modf(v15)
    local v17 = p10.Y
    local v18 = math.modf(v17)
    local v19 = p10.Z
    local v20 = math.modf
    local v21 = Vector3.new(v16, v18, v20(v19))
    local v22 = p11.X
    local v23 = math.modf(v22)
    local v24 = p11.Y
    local v25 = math.modf(v24)
    local v26 = p11.Z
    local v27 = math.modf
    local v28 = Vector3.new(v23, v25, v27(v26))
    local v29, v30
    if v13 < v28.Z or (v13 < v21.Z or (v21.Z <= 0 or v28.Z <= 0)) then
        v29 = v13
        v30 = false
    else
        v29 = v13
        v30 = true
    end
    while v13 > 0 do
        local v31 = math.random(v21.X, v28.X)
        local v32 = math.random(v21.Y, v28.Y)
        local v33
        if v30 then
            local v34 = math.random(v21.Z, v28.Z)
            v33 = v13 - v34 > 0 and v34 and v34 or (p9 - v12[#v12]).magnitude
        else
            v33 = v29 / v14
        end
        v13 = v13 - v33
        if v13 <= 0 then
            break
        end
        local v35 = (CFrame.new(v12[#v12], p9) * CFrame.new(v31, v32, -v33)).p
        table.insert(v12, v35)
    end
    table.insert(v12, p9)
    return v12
end
function v1.Fire(_, p36, p37, p38, p39, p40, p41, u42, p43, p44, u45) --[[ Line: 63 ]]
    local v46 = TraceLine(p37, p38, p39, p40)
    local u47 = Instance.new("Model", p36)
    u47.Name = "Strike"
    if p43 == 2 then
        local v48 = {}
        for v49 = 1, #v46 do
            local v50 = Instance.new("Part", u47)
            v50.Anchored = true
            v50.Size = Vector3.new(1, 1, 1)
            v50.CFrame = CFrame.new(v46[v49])
            v50.Transparency = 1
            v50.Parent = u47
            table.insert(v48, v50)
            Instance.new("Attachment", v50)
        end
        for v51 = 1, #v48 - 1 do
            local v52 = script.Beam:Clone()
            v52.Attachment0 = v48[v51].Attachment
            v52.Attachment1 = v48[v51 + 1].Attachment
            v52.FaceCamera = true
            v52.Color = ColorSequence.new(u42)
            v52.Parent = v48[v51]
            _G.tween(v52, {
                u45,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Width0"] = 0,
                ["Width1"] = 0
            })
        end
        return u47
    else
        for v53 = 2, #v46 do
            local v54 = ConnectPoints(v46[v53 - 1], v46[v53], p41, u42)
            v54.Parent = u47
            if p43 == -1 or p43 == -2 then
                Instance.new("CylinderMesh", v54).Name = "Mesh"
            end
            if (p43 == 1 or p43 == -2) and v46[v53] ~= v46[#v46] then
                local v55 = Instance.new("Part", u47)
                v55.Name = "Joint" .. v53 - 1
                v55.Anchored = true
                v55.Shape = "Ball"
                v55.CanCollide = false
                v55.TopSurface = "Smooth"
                v55.BottomSurface = "Smooth"
                v55.Material = Enum.Material.Neon
                v55.Color = u42
                script.Mesh:Clone().Parent = v55
                if p43 == -2 then
                    v55.Size = Vector3.new(p41, p41, p41)
                else
                    local v56 = p41 * 1.5
                    local v57 = p41 * 1.5
                    local v58 = p41 * 1.5
                    v55.Size = Vector3.new(v56, v57, v58)
                end
                v55.CFrame = CFrame.new(v46[v53])
            end
        end
        if p44 ~= nil then
            u42 = p44
        end
        spawn(function() --[[ Line: 134 ]]
            --[[
            Upvalues:
                [1] = u47
                [2] = u45
                [3] = u42
            --]]
            local u59 = u47:GetChildren()
            for u60 = 1, #u59 do
                if u59[u60]:FindFirstChild("Mesh") then
                    spawn(function() --[[ Line: 139 ]]
                        --[[
                        Upvalues:
                            [1] = u59
                            [2] = u60
                            [3] = u45
                            [4] = u42
                        --]]
                        local v61 = u59[u60]
                        if u59[u60].Mesh.ClassName == "CylinderMesh" then
                            local v62 = _G.tween
                            local v63 = v61.Mesh
                            local v64 = {
                                u45,
                                Enum.EasingStyle.Sine,
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }
                            local v65 = {}
                            local v66 = u59[u60].Mesh.Scale.Y
                            local v67 = u59[u60].Mesh.Scale.Y
                            v65.Scale = Vector3.new(0, v66, v67)
                            v62(v63, v64, v65)
                            local v68 = {
                                ["Color"] = u42
                            }
                            _G.tween(v61, {
                                u45,
                                Enum.EasingStyle.Sine,
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, v68)
                        else
                            _G.tween(v61.Mesh, {
                                u45,
                                Enum.EasingStyle.Sine,
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Scale"] = Vector3.new(0, 0, 0)
                            })
                        end
                    end)
                end
            end
        end)
        return u47
    end
end
return v1