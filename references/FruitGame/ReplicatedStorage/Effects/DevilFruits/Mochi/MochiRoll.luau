 

local u1 = game:GetService("RunService")
local _ = workspace.CurrentCamera
local u2 = require(script.crater)
Emit = _G.Emit
local function u8(p3, p4, p5, p6) --[[ Line: 10 ]]
    for _, v7 in p3 do
        if v7:IsA("ParticleEmitter") and (p6 and not p6[table.find(p6, v7.Name)]) then
            v7.Speed = NumberRange.new(p4, p5)
        end
    end
end
return {
    ["start"] = function(_, u9, u10, p11) --[[ Name: start, Line 20 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u8
        --]]
        if _G.checkRenderDistance(u9.HumanoidRootPart.Position) then
            local u12 = Random.new()
            local u13 = u9:FindFirstChildWhichIsA("Humanoid")
            u13.PlatformStand = true
            local u14 = u13.RootPart
            local u15 = Instance.new("BodyPosition")
            local u16 = Instance.new("BodyGyro")
            u15.MaxForce = Vector3.new(600000, 6000, 600000)
            u15.P = 1000
            u15.D = 100
            u15.Position = u14.Position
            u15.Parent = u14
            u16.MaxTorque = Vector3.new(100000, 100000, 100000)
            u16.P = 3000
            u16.D = 450
            u16.Parent = u14
            local u17 = script.DriftSounds:GetChildren()
            local v18 = script.MochiWheelStart:Clone()
            v18:Play()
            local u19 = v18.MochiWheelLOOP
            u19:Play()
            local u20 = u19.MochiWheelHit
            local u21 = nil
            local u22 = script.Wheel:Clone()
            u22.CFrame = u14.CFrame
            u22.Parent = workspace.Effects
            v18.Parent = u22
            u19.Parent = u22
            u20.Parent = u22
            local u23 = script.Part:Clone()
            u23.CFrame = u14.CFrame
            u23.Parent = workspace.Effects
            local u24 = u23.Attachment
            local u25 = u23.Attachment1
            local u26 = RaycastParams.new()
            u26.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
            u26.FilterType = Enum.RaycastFilterType.Whitelist
            local u27 = RaycastParams.new()
            u27.FilterType = Enum.RaycastFilterType.Whitelist
            local u28 = {
                ["Falling"] = "Falling",
                ["Moving"] = "Moving",
                ["Crash"] = "Crash",
                ["Climbing"] = "Climbing"
            }
            local u29 = u28.Moving
            local u30 = nil
            local u31 = nil
            local u32 = 0
            local v33 = 1500
            local u34 = 15
            local u35 = NumberRange.new(2, 15)
            local u36 = NumberRange.new(500, v33)
            local u37 = NumberRange.new(20, 35)
            local _ = u37.Min
            local _ = u37.Max
            local u38 = 0
            local u39 = tick()
            local u40 = tick()
            local u41 = tick() - u39
            local u42 = u41 * v33
            local u43 = u42 % 360
            local u44 = math.rad(u43)
            local u45 = nil
            local u46 = 0
            local u47 = 0
            local u48 = 0.25
            local u49
            if p11 and game.Players.LocalPlayer ~= p11 then
                u22.CFrame = u9.PrimaryPart.CFrame
                u49 = true
            else
                u49 = false
            end
            game.ReplicatedStorage:FindFirstChild(u9.Name .. "MochiRoll")
            local _ = u1.Heartbeat:Connect(function(_) --[[ Line: 126 ]]
                --[[
                Upvalues:
                    [1] = u41
                    [2] = u10
                    [3] = u9
                    [4] = u22
                    [5] = u45
                    [6] = u15
                    [7] = u16
                    [8] = u23
                    [9] = u49
                    [10] = u13
                    [11] = u48
                    [12] = u29
                    [13] = u28
                    [14] = u19
                    [15] = u46
                    [16] = u27
                    [17] = u14
                    [18] = u38
                    [19] = u47
                    [20] = u35
                    [21] = u36
                    [22] = u34
                    [23] = u26
                    [24] = u40
                    [25] = u30
                    [26] = u32
                    [27] = u21
                    [28] = u17
                    [29] = u12
                    [30] = u39
                    [31] = u42
                    [32] = u43
                    [33] = u44
                    [34] = u31
                    [35] = u20
                    [36] = u2
                    [37] = u8
                    [38] = u24
                    [39] = u37
                    [40] = u25
                --]]
                if u10 < u41 or (not u9:IsDescendantOf(workspace) or (not u22:IsDescendantOf(workspace) or u9:GetAttribute("inWheel") == false)) then
                    u45:Disconnect()
                    u45 = nil
                    u15:Destroy()
                    u16:Destroy()
                    u23:Destroy()
                    u22:Destroy()
                    if u49 == false then
                        u13.PlatformStand = false
                    end
                else
                    u48 = u29 == u28.Falling and 0.5 or 0.25
                    local v50 = u19
                    local v51 = u46 / 15
                    v50.Pitch = math.clamp(v51, 0.2, 2)
                    local v52
                    if u49 == false then
                        v52 = _G.MouseOld.GetPosition(u27)
                    elseif u9 and u9.PrimaryPart ~= nil then
                        v52 = u9.PrimaryPart.CFrame.LookVector * 100
                    else
                        v52 = Vector3.new()
                    end
                    local v53 = u14.CFrame:VectorToObjectSpace(u14.AssemblyLinearVelocity).Unit
                    local v54 = u14.AssemblyLinearVelocity.Magnitude
                    local u55 = tick()
                    local v56 = u14.Position
                    local v57 = v52.X
                    local v58 = u14.Position.y
                    local v59 = v52.Z
                    local v60 = (Vector3.new(v57, v58, v59) - v56).Unit
                    local v61 = (u16.P / u16.D / u46) ^ 0.5 + 0.25
                    local v62 = v53.X * 45
                    local v63 = math.clamp(v62, -55, 55)
                    local v64 = math.floor(v63) / v61
                    local v65 = v64 * 2
                    local v66 = v64 + u38 >= 12 and true or v64 + u38 <= -12
                    local v67 = u9:GetAttribute("drift") == true and 5 or 1
                    if v66 then
                        local v68 = u46
                        local v69 = v64 / 2
                        u46 = v68 - math.abs(v69) * 0.0025 * v67
                        u47 = u47 - math.abs(v64) * 1
                    elseif not v66 and u9:GetAttribute("drift") ~= true then
                        u46 = u46 + 0.15
                        u47 = u47 + 15
                    end
                    local v70 = u9.Humanoid.Health / u9.Humanoid.MaxHealth
                    local v71 = u46
                    local v72 = u35.Min * v70
                    local v73 = u35.Max * v70
                    u46 = math.clamp(v71, v72, v73)
                    local v74 = u47
                    local v75 = u36.Min
                    local v76 = u36.Max
                    local v77 = math.clamp(v74, v75, v76)
                    u47 = math.floor(v77)
                    local v78 = u34
                    u34 = math.clamp(v78, -12, 15)
                    local v79 = u29 == u28.Climbing and 1.5 or 1
                    local u80 = workspace:Raycast(v56 + Vector3.new(0, 3, 0), u14.CFrame.LookVector * (v79 + 2) + Vector3.new(0, 1, 0) * -(v79 * 9), u26)
                    local v81 = workspace:Raycast(v56, Vector3.new(0, -9, 0), u26)
                    local v82 = workspace:Raycast((u14.CFrame * CFrame.new(0, -0.5, 2)).Position, u14.CFrame.LookVector * 8, u26)
                    if v82 and v82.Normal.Y <= 0 then
                        u46 = 0
                        if u40 and (u34 <= -11 and u55 - u40 >= 2) then
                            u40 = nil
                            task.delay(1.25, function() --[[ Line: 203 ]]
                                --[[
                                Upvalues:
                                    [1] = u40
                                    [2] = u55
                                    [3] = u34
                                --]]
                                u40 = u55
                                u34 = 15
                            end)
                        end
                        if u29 == u28.Climbing and (u40 and u34 >= -11) then
                            u34 = u34 - (u55 - u40 + 1) / 10
                        end
                        if u29 ~= u28.Climbing and u40 then
                            u40 = u55
                        end
                        if u29 and (u29 ~= u28.Climbing and u34 > 0) then
                            u30 = u29
                            u29 = u28.Climbing
                        end
                    else
                        if not v82 and (u80 and (v81 and u29 ~= u28.Moving)) then
                            u30 = u29
                            u29 = u28.Moving
                            u34 = 15
                        end
                        if u29 == u28.Moving and u30 == u28.Falling then
                            u29 = u28.Crash
                        end
                    end
                    local v83 = nil
                    if v82 and (v82.Normal.Y == 0 and u29 == u28.Climbing) then
                        local v84 = u34
                        v83 = u14.Position + Vector3.new(0, v84, 0)
                    else
                        if u80 or v81 and u29 ~= u28.Climbing then
                            if v82 and v82.Normal.Y == 0 then
                                v83 = v56 - Vector3.new(0, 5, 0)
                            elseif (not v82 or v82.Normal.Y ~= 0) and u29 ~= u28.Climbing then
                                if u80 then
                                    v83 = u80.Position
                                else
                                    v83 = v81.Position
                                end
                            end
                        end
                        if u80 == nil and v81 == nil then
                            local v85 = u14.Position
                            local v86 = workspace.Gravity
                            v83 = v85 - Vector3.new(0, v86, 0)
                        end
                    end
                    if v83 == nil then
                        v83 = u14.Position
                    end
                    local v87 = not v81 and Vector3.new(0, 1, 0) or v81.Normal
                    local v88
                    if v81 then
                        v88 = v81.Position
                    else
                        v88 = v83
                    end
                    local v89 = 6 - (v81 and (v81.Distance or 6) or 6) + 6
                    local v90
                    if v81 and v87.Y >= 0.7 then
                        if v87.Y == 1 then
                            u32 = v88.Y
                            v90 = 0
                        else
                            local v91 = (Vector3.new(0, 1, 0)):Dot(v81.Normal)
                            local v92 = math.clamp(v91, -1, 1)
                            local v93 = math.acos(v92)
                            local v94 = math.deg(v93)
                            v90 = math.clamp(v94, 0, 45)
                            if u32 <= v81.Position.Y then
                                v90 = -v90
                            end
                        end
                    else
                        v90 = 0
                    end
                    local v95 = v56 + u14.CFrame.LookVector
                    local v96 = u14.CFrame:ToObjectSpace(CFrame.new(v56 + v60))
                    local v97 = v56 - (v56 + v96.Position)
                    local v98 = v56 - v95
                    local v99 = (v56 + u14.CFrame.LookVector - (v56 + v60)).Magnitude / (v97.Magnitude ^ 2 + v98.Magnitude ^ 2) ^ 0.5
                    local v100 = math.deg(v99)
                    local v101 = v96.X
                    local _ = v100 * -math.sign(v101) + u14.Orientation.Y
                    local v102 = CFrame.new
                    local v103 = v60.X
                    local v104 = v60.Z
                    local v105 = v102(v83, v83 + Vector3.new(v103, 0, v104)) * CFrame.Angles(0, 0, 0) * CFrame.new(0, v89, 0)
                    if u9:GetAttribute("drift") == true and (v65 > 15 or v65 < -15) and (v54 > 45 and u29 == u28.Moving) then
                        if u49 == false then
                            local v106 = u16
                            local v107 = CFrame.Angles
                            local v108 = -v64 * 2
                            v106.CFrame = v105 * v107(0, math.rad(v108), 0)
                            u16.P = 10000
                        end
                        local v109 = u38
                        local v110 = v64 / 15
                        u38 = v109 + math.abs(v110)
                        if not u21 then
                            u21 = u17[u12:NextInteger(1, #u17)]:Clone()
                            u21:Play()
                            u21.Parent = u22
                        end
                        Emit(u23.drift, true)
                        u23.drift.rocks:SetAttribute("EmitCount", u12:NextInteger(0, 2))
                    else
                        if u21 and u21:IsA("Sound") then
                            u21.Volume = u21.Volume - 0.05
                            if u21.Volume <= 0 then
                                u21:Destroy()
                                u21 = nil
                            end
                        end
                        if u49 == false then
                            local v111 = u16
                            local v112 = u16.CFrame
                            local v113 = CFrame.Angles
                            local v114 = -v90
                            v111.CFrame = v112:Lerp(v105 * v113(math.rad(v114), 0, 0), u48)
                            u16.P = 3000
                        end
                        u38 = u38 - 2
                    end
                    local v115 = u38
                    u38 = math.clamp(v115, 0, 40)
                    if u49 == false then
                        local v116 = u15
                        local v117 = CFrame.Angles
                        local v118 = -v90
                        v116.Position = (v105 * v117(math.rad(v118), 0, 0) * CFrame.new(0, 0, -u46)).Position
                        local v119 = u15
                        local v120 = u15.D
                        v119.D = math.clamp(v120, 100, 2000)
                    end
                    u41 = tick() - u39
                    u42 = u41 * u47
                    local v121 = u42 % 360
                    u43 = math.ceil(v121)
                    local v122 = u43
                    local v123 = math.abs(v122)
                    u44 = math.rad(v123)
                    local v124 = v64 / 10
                    local v125 = math.clamp(v124, -2.5, 2.5)
                    local v126 = u22
                    local v127 = u22.CFrame
                    local v128 = u14.CFrame
                    local v129 = CFrame.Angles
                    local v130 = (math.abs(v65) + u38) * -math.sign(v65)
                    local v131 = math.rad(v130)
                    local v132 = -v64
                    v126.CFrame = v127:Lerp(v128 * v129(0, v131, (math.rad(v132))) * CFrame.new(v125, 0, 0) * CFrame.Angles(-u44, 0, 0), u48 * 2)
                    local v133 = u23
                    local v134 = u23.CFrame
                    local v135 = u14.CFrame * CFrame.new(0, -(v81 and v81.Distance or v89 + 1.15), 0)
                    local v136 = CFrame.Angles
                    local v137 = (math.abs(v65) + u38) * -math.sign(v65)
                    v133.CFrame = v134:Lerp(v135 * v136(0, math.rad(v137), 0), u48)
                    if v81 == nil or (u80 == nil or not u22:IsDescendantOf(workspace)) then
                        if u49 == false then
                            local v138 = u15
                            local v139 = u15.MaxForce.X
                            local v140 = u15.MaxForce.X
                            v138.MaxForce = Vector3.new(v139, 6000, v140)
                            u16.P = 800
                        end
                        if u29 ~= u28.Falling and (u29 ~= u28.Climbing and (v81 == nil and u80 == nil)) then
                            if v82 then
                                v82 = v82.Normal.Y > 0
                            end
                            if v82 == nil then
                                u31 = u14.Position.Y
                                u30 = u29
                                u29 = u28.Falling
                            end
                        end
                    else
                        if u49 == false then
                            local v141 = u15
                            local v142 = u15.MaxForce.X
                            local v143 = u15.MaxForce.X
                            v141.MaxForce = Vector3.new(v142, 14000, v143)
                            u16.P = 3000
                        end
                        if u31 and (u30 == u28.Falling and u29 == u28.Crash) then
                            local v144 = u31 - u14.Position.Y
                            if v144 > 0 then
                                if v144 >= 15 then
                                    u20:Play()
                                    local v145 = (v144 / 10) ^ 0.5
                                    local v146 = math.clamp(v145, 2, 4.5) / 2
                                    for _, u147 in u23["22"]:GetChildren() do
                                        local u148 = u147:GetAttribute("EmitCount")
                                        local u149 = u147.Size
                                        local v150 = {}
                                        for _, v151 in u149.Keypoints do
                                            v150[#v150 + 1] = NumberSequenceKeypoint.new(v151.Time, v151.Value * v146, v151.Envelope)
                                        end
                                        u147.Size = NumberSequence.new(v150)
                                        u147:SetAttribute("EmitCount", u148 + v144 / 5)
                                        task.delay((u147.Lifetime.Min + u147.Lifetime.Max) / 2, function() --[[ Line: 382 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u147
                                                [2] = u149
                                                [3] = u148
                                            --]]
                                            u147.Size = u149
                                            u147:SetAttribute("EmitCount", u148)
                                        end)
                                    end
                                    Emit(u23["22"], true)
                                    if v144 > 45 then
                                        u2:start(CFrame.new(v83), 1.25)
                                    end
                                end
                                local v152 = u46
                                local v153 = v144 / 10
                                u46 = v152 / math.clamp(v153, 2.5, 8)
                            end
                            u31 = 0
                        end
                        local v154 = math.abs(v65)
                        local v155 = v65 > 0 and 2 or 0.5
                        local v156 = v65 < 0 and 2 or 0.5
                        if v65 >= 15 or v65 <= -15 then
                            local v157 = u8
                            local v158 = u24:GetChildren()
                            local v159 = u37.Min
                            local v160 = u46
                            local v161 = -v64
                            local v162 = (v159 * v156 - v154) / 10 * (v160 / 1.5) + v161 / 2
                            local v163 = v162 < 0 and 0 or v162
                            local v164 = u37.Max
                            local v165 = u46
                            local v166 = -v64
                            local v167 = (v164 * v156 - v154) / 10 * (v165 / 1.5) + v166 / 2
                            v157(v158, v163, v167 < 0 and 0 or v167, { "drift" })
                            local v168 = u8
                            local v169 = u25:GetChildren()
                            local v170 = u46
                            local v171 = (u37.Min * v155 - v154) / 10 * (v170 / 1.5) + v64 / 2
                            local v172 = v171 < 0 and 0 or v171
                            local v173 = u46
                            local v174 = (u37.Max * v155 - v154) / 10 * (v173 / 1.5) + v64 / 2
                            v168(v169, v172, v174 < 0 and 0 or v174, { "drift" })
                        elseif v65 < 12 and v65 > -12 then
                            u8(u25:GetChildren(), u37.Min, u37.Max, { "drift" })
                            u8(u24:GetChildren(), u37.Min, u37.Max, { "drift" })
                        end
                        task.spawn(function() --[[ Line: 432 ]]
                            --[[
                            Upvalues:
                                [1] = u23
                                [2] = u80
                            --]]
                            for _, v175 in u23:GetDescendants() do
                                if v175:IsA("ParticleEmitter") and (not v175.Parent.Name:match("22") and v175.Name ~= "drift") then
                                    if v175.Color.Keypoints[1].Value == u80.Instance.Color then
                                        return
                                    end
                                    local v176
                                    if v175.Name:match("rocks") then
                                        v176 = Color3.new(0.81828, 0.81825, 0.818265)
                                    else
                                        v176 = Color3.new(0.64828, 0.648249, 0.648264)
                                    end
                                    v175.Color = ColorSequence.new(u80.Instance.Color:Lerp(v176, 0.7), u80.Instance.Color:Lerp(Color3.new(0.559792, 0.559777, 0.559792), 0.4))
                                end
                            end
                        end)
                        if not u25.ParticleEmitter.Enabled then
                            Emit(u25, false)
                            Emit(u24, false)
                        end
                    end
                    if u9:GetAttribute("drift") == true and u38 ~= 0 or u29 == u28.Climbing and u25.ParticleEmitter.Enabled then
                        Emit(u25, false)
                        Emit(u24, false)
                    end
                end
            end)
        end
    end
}