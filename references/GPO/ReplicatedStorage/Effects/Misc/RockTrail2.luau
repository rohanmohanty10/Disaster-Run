 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local u3 = workspace.Effects
local u4 = Random.new()
local v5 = {}
local function u9(p6, p7) --[[ Line: 7 ]]
    local v8 = RaycastParams.new()
    v8.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
    v8.FilterType = Enum.RaycastFilterType.Include
    return workspace:Raycast(p6, p7, v8)
end
local function u20(p10) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v11 = p10.Raycast
    local _ = p10.Size
    local v12 = p10.FadeDuration
    local _ = p10.Direction
    local u13 = Instance.new("Part")
    u13.Anchored = true
    u13.CanCollide = false
    u13.Color = v11.Instance.Color
    u13.CFrame = p10.Angle
    u13.Size = p10.Size
    _G.matchMaterial(u13, v11.Instance)
    u13.Parent = u3
    task.delay(v12, function() --[[ Line: 31 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u13
        --]]
        local v14 = u2
        local v15 = u13
        local v16 = TweenInfo.new(1)
        local v17 = {}
        local v18 = u13.Position
        local v19 = u13.Size.Magnitude / 1.25
        v17.Position = v18 - Vector3.new(0, v19, 0)
        v14:Create(v15, v16, v17):Play()
        _G.destroy(u13, 1)
    end)
    return u13
end
function v5.start(_, u21) --[[ Line: 44 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u9
        [3] = u4
        [4] = u20
    --]]
    local u22 = u21.Part
    if _G.checkRenderDistance(u22.Position) ~= false then
        local v23 = u21.Direction or u22.CFrame.LookVector
        local u24 = CFrame.new(u22.Position, u22.Position + v23 * Vector3.new(1, 0, 1)).LookVector
        local u25 = u21.DownVector or 20
        local u26 = tick()
        local u27 = u21.Radius
        local u28 = u21.Size
        local u29 = u21.FadeDuration
        local u30 = u21.Angle
        local u31 = {}
        local u32 = {}
        local u33 = u22.Position
        local u34 = nil
        u34 = u1.Heartbeat:Connect(function(_) --[[ Line: 69 ]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u25
                [3] = u22
                [4] = u9
                [5] = u27
                [6] = u31
                [7] = u30
                [8] = u33
                [9] = u32
                [10] = u28
                [11] = u26
                [12] = u34
                [13] = u21
                [14] = u4
                [15] = u20
                [16] = u29
            --]]
            local v35 = u24:Cross(Vector3.new(0, 1, 0))
            local v36 = -u25
            local v37 = Vector3.new(0, v36, 0)
            local v38 = u22.CFrame * CFrame.new(0, u22.Size.Y / 2, -u22.Size.Z / 2).Position
            local v39 = u9(v38, v37)
            local v40 = {
                ["Right"] = u9(v38 + v35 * u27, v37),
                ["Left"] = u9(v38 - v35 * u27, v37)
            }
            if v39 then
                for _, v41 in pairs(u31) do
                    local v42 = 3.141592653589793 * v41:GetAttribute("Percent") - 1.5707963267948966
                    local v43 = u9(v38 + v35 * math.sin(v42) * u27 + u24 * math.cos(v42) * u27, v37)
                    if v43 then
                        v41.Color = v43.Instance.Color
                        v41.Material = v43.Material
                        local v44 = CFrame.lookAt
                        local v45 = v43.Position
                        local v46 = v38.X
                        local v47 = v43.Position.Y
                        local v48 = v38.Z
                        v41.CFrame = v44(v45, Vector3.new(v46, v47, v48), v43.Normal) * CFrame.Angles(u30, 0, 0)
                    end
                end
                local _ = (u33 - v38).Magnitude
                local v49 = false
                for v50, v51 in pairs(v40) do
                    if v51 and (u32[v50] and u32[v50]:GetAttribute("OriginalPosition")) then
                        if u32[v50]:GetAttribute("Material") == v51.Instance.Material then
                            local v52 = u32[v50]:GetAttribute("OriginalPosition")
                            local v53 = u32[v50]:GetAttribute("Angle")
                            local v54 = (v51.Position - v52).Magnitude
                            u32[v50].CFrame = CFrame.new(v52, v51.Position) * CFrame.new(0, 0, -v54 / 2) * CFrame.Angles(0, 0, v53)
                            local v55 = u32[v50]
                            local v56 = u28.X
                            local v57 = u28.Y
                            v55.Size = Vector3.new(v56, v57, v54)
                        else
                            v49 = true
                        end
                    end
                end
                if tick() - u26 <= 0.05 and not v49 then
                    return
                elseif u22.Parent then
                    u26 = tick()
                    u30 = u21.Angle * u4:NextNumber(0.75, 1.25)
                    u28 = u21.Size * u4:NextNumber(0.75, 1.25)
                    for v58, v59 in pairs(v40) do
                        if v59 then
                            local v60 = u32[v58]
                            local v61 = u20
                            local v62 = {
                                ["Direction"] = u24,
                                ["Raycast"] = v59
                            }
                            local v63 = u28.X
                            local v64 = u28.Y
                            local v65 = u32[v58] and ((u32[v58].Position - v59.Position).Magnitude or 0) or 0
                            v62.Size = Vector3.new(v63, v64, v65)
                            v62.FadeDuration = u29
                            v62.Angle = CFrame.lookAt(v59.Position, v59.Position + u24 * Vector3.new(1, 0, 1), v59.Normal) * CFrame.Angles(0, 0, v58 == "Left" and u30 or -u30)
                            local v66 = v61(v62)
                            u32[v58] = v66
                            v66.Transparency = 1
                            if v60 then
                                v66.Transparency = 0
                                u32[v58]:SetAttribute("Material", v66.Material)
                                u32[v58]:SetAttribute("OriginalPosition", v60.CFrame * CFrame.new(0, 0, -v60.Size.Z / 2).Position)
                                u32[v58]:SetAttribute("Angle", v58 == "Left" and u30 or -u30)
                            end
                        end
                    end
                    for v67 = 0, 10 do
                        local v68 = 3.141592653589793 * v67 / 10 - 1.5707963267948966
                        local v69 = u9(v38 + v35 * math.sin(v68) * u27 + u24 * math.cos(v68) * u27, v37)
                        if v69 then
                            local v70 = u31[v67]
                            local v71 = CFrame.lookAt
                            local v72 = v69.Position
                            local v73 = v38.X
                            local v74 = v69.Position.Y
                            local v75 = v38.Z
                            local v76 = v71(v72, Vector3.new(v73, v74, v75), v69.Normal) * CFrame.Angles(u30, 0, 0)
                            if v70 == nil then
                                local v77 = u20
                                local v78 = {
                                    ["Direction"] = u24,
                                    ["Raycast"] = v69
                                }
                                local v79 = 0.9510565162951535 * u27 / 2
                                local v80 = u28.Y
                                local v81 = u28.X
                                v78.Size = Vector3.new(v79, v80, v81)
                                v78.FadeDuration = u29
                                v78.Angle = v76
                                v70 = v77(v78)
                                u31[v67] = v70
                            else
                                v70.CFrame = v76
                            end
                            v70:SetAttribute("Percent", v67 / 10)
                            v70:SetAttribute("Angle", u30)
                            local v82 = v70.CFrame
                            local v83 = CFrame.Angles
                            local v84 = math.random(0, 180)
                            v70.CFrame = v82 * v83(math.rad(v84), 0, 0)
                        end
                    end
                    u33 = v38
                else
                    u34:Disconnect()
                end
            else
                return
            end
        end)
        u22.Destroying:Connect(function() --[[ Line: 176 ]]
            --[[
            Upvalues:
                [1] = u34
            --]]
            if u34 then
                u34:Disconnect()
                u34 = nil
            end
        end)
    end
end
return v5