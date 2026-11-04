 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
local u2 = game:GetService("RunService")
local _ = game:GetService("Players").LocalPlayer
local u3 = Random.new()
return {
    ["start"] = function(_, u4, u5, u6, u7, u8) --[[ Name: start, Line 9 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
            [3] = u2
        --]]
        if u5 ~= nil then
            local u9
            if u8 == nil then
                u9 = script.Orb:Clone()
            else
                u9 = script.SoulOrb:Clone()
            end
            u9.CFrame = CFrame.new(u4, u5.Position)
            u9.Parent = workspace.Effects
            local u10 = u5.Size.Magnitude / 2
            local u11 = 0
            local v12 = (u5.Position - u4).Magnitude
            u3:NextNumber(6, 8)
            u3:NextNumber(2, 4)
            local u13 = u3:NextNumber(5, 8)
            local u14 = u3:NextNumber(2, 5)
            local u15 = u3:NextNumber(2, 4)
            local u16 = u3:NextNumber(3, 5)
            local u17 = u3:NextNumber(0, 6.283185307179586)
            local _ = v12 * u3:NextNumber(0.1, 0.15)
            u3:NextNumber(0.5, 2)
            local u18 = u3:NextNumber(4, 7)
            local u19 = u3:NextNumber(0.8, 2)
            local u20 = {}
            local u21 = nil
            local function u23() --[[ Line: 50 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u1
                    [3] = u21
                --]]
                _G.particleEnabled(u9, false, true)
                local v22 = u9:FindFirstChild("PointLight")
                if v22 then
                    u1:Create(v22, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Brightness"] = 0
                    }):Play()
                end
                _G.destroy(u9, 4)
                if u21 then
                    u21:Disconnect()
                    u21 = nil
                end
            end
            u21 = u2.Heartbeat:Connect(function(p24) --[[ Line: 68 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u23
                    [3] = u5
                    [4] = u11
                    [5] = u6
                    [6] = u10
                    [7] = u8
                    [8] = u1
                    [9] = u7
                    [10] = u4
                    [11] = u13
                    [12] = u18
                    [13] = u14
                    [14] = u17
                    [15] = u16
                    [16] = u15
                    [17] = u19
                    [18] = u20
                --]]
                if u9 and u9.Parent then
                    if u5 and u5.Parent then
                        u11 = u11 + p24
                        local v25 = u6 and u11 / u6 or u11 / 2
                        local v26 = math.min(v25, 1)
                        local v27 = 1 - v26
                        local _ = 1 - math.pow(v27, 3)
                        local v28 = v26 * v26 * (3 - 2 * v26)
                        local v29 = u5.Position
                        if (v29 - u9.Position).Magnitude <= u10 then
                            local v30
                            if u8 == nil then
                                v30 = script.Attachment:Clone()
                            else
                                v30 = script.SoulOrbHit:Clone()
                            end
                            v30.WorldCFrame = CFrame.new(u5.Position)
                            v30.Parent = workspace.Terrain
                            _G.customEmit(v30)
                            _G.destroy(v30, 4)
                            u1:Create(v30.PointLight, TweenInfo.new(1), {
                                ["Range"] = 25,
                                ["Brightness"] = 0
                            }):Play()
                            local v31 = Color3.fromRGB(66, 255, 56)
                            if u8 == true then
                                v31 = Color3.fromRGB(255, 255, 255)
                            end
                            local u32 = Instance.new("Highlight")
                            u32.FillTransparency = 1
                            u32.FillColor = v31
                            u32.OutlineColor = v31
                            u32.DepthMode = Enum.HighlightDepthMode.Occluded
                            u32.OutlineTransparency = 0.5
                            u32.Parent = u7
                            if u8 == nil then
                                _G.PlaySound(u7.PrimaryPart, script.SoulMiniHomiesTreeBranchHeal, {
                                    ["RandomPitch"] = true
                                }).Parent = u7.PrimaryPart
                            else
                                _G.PlaySound(u7.PrimaryPart, script.SoulOrbSFX:GetChildren()[math.random(1, 3)], {
                                    ["RandomPitch"] = true
                                }).Parent = u7.PrimaryPart
                            end
                            local v33 = u9.Attachment:GetChildren()
                            for _, v34 in pairs(v33) do
                                v34:Clear()
                            end
                            task.delay(0.2, function() --[[ Line: 134 ]]
                                --[[
                                Upvalues:
                                    [1] = u1
                                    [2] = u32
                                --]]
                                u1:Create(u32, TweenInfo.new(1), {
                                    ["OutlineTransparency"] = 1,
                                    ["FillTransparency"] = 1
                                }):Play()
                                _G.destroy(u32, 1)
                            end)
                            u23()
                        else
                            Vector3.new()
                            local v35 = u4:Lerp(v29, v28)
                            local v36 = u13
                            local v37 = v26 * 3.141592653589793
                            local v38 = v36 * math.sin(v37)
                            local v39 = u11 * u18
                            local v40 = v38 * (math.sin(v39) * 0.2 + 1)
                            local v41 = u11 * u14 + u17
                            local v42 = (v29 - u4).Unit
                            local v43 = v42:Cross(Vector3.new(0, 1, 0)).Unit
                            if v43.Magnitude < 0.1 then
                                v43 = v42:Cross(Vector3.new(1, 0, 0)).Unit
                            end
                            local _ = v43:Cross(v42).Unit
                            local v44 = math.sin(v41)
                            local v45 = math.abs(v44) * v40
                            local v46 = v43 * (math.cos(v41) * v40) + Vector3.new(0, v45, 0)
                            local v47 = u11 * u16
                            local v48 = v46 + Vector3.new(0, 1, 0) * (math.sin(v47) * u15 * (1 - v26))
                            local v49 = u11 * 13.7
                            local v50 = math.sin(v49) * 0.5
                            local v51 = u11 * 17.3
                            local v52 = math.cos(v51) * 0.5
                            local v53 = u11 * 11.1
                            local v54 = math.sin(v53) * 0.5
                            local v55 = Vector3.new(v50, v52, v54) * (1 - v26) * u19
                            local v56 = v35 + v48 + v55
                            local v57 = u20
                            table.insert(v57, 1, v56)
                            if #u20 > 8 then
                                table.remove(u20)
                            end
                            local v58
                            if #u20 > 2 then
                                v58 = (u20[1] - u20[2]).Unit
                            else
                                v58 = (v29 - v56).Unit
                            end
                            local v59 = CFrame.Angles
                            local v60 = u11 * 7
                            local v61 = math.sin(v60) * 0.1 * (1 - v26)
                            local v62 = u11 * 360
                            local v63 = v59(v61, 0, (math.rad(v62)))
                            u9.CFrame = CFrame.lookAt(v56, v56 + v58) * v63
                        end
                    else
                        u23()
                        return
                    end
                else
                    u23()
                    return
                end
            end)
            local v64 = u6 or 2
            task.delay(v64 + 2, function() --[[ Line: 201 ]]
                --[[
                Upvalues:
                    [1] = u23
                --]]
                u23()
            end)
            return u9
        end
    end
}