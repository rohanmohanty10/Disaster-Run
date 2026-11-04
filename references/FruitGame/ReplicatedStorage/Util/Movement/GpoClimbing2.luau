 

local u1 = {}
u1.__index = u1
local u2 = Enum.KeyCode.W
local u3 = Enum.KeyCode.S
local u4 = Enum.KeyCode.D
local u5 = Enum.KeyCode.A
local v6 = Enum.RaycastFilterType.Whitelist
local v7 = { workspace.Env, workspace.Ships, workspace.Islands }
local v8 = game:GetService("Players")
local u9 = game:GetService("RunService")
game:GetService("CollectionService")
local u10 = game:GetService("UserInputService")
local u11 = v8.LocalPlayer
local u12 = u11.Character or u11.CharacterAdded:Wait()
local u13 = u12:WaitForChild("HumanoidRootPart")
local u14 = u13:WaitForChild("RootRigAttachment")
local u15 = u12:WaitForChild("Humanoid")
local u16 = u12:WaitForChild("Head")
local u17 = u12:WaitForChild("RightUpperArm")
local u18 = false
local u19 = nil
local u20 = false
local u21 = 0
local u22 = true
local u23 = true
local u24 = 0
local u25 = 0
local u26 = 0
local u27 = nil
local u28 = Vector3.new()
local u29 = RaycastParams.new()
u29.FilterType = v6
u29.FilterDescendantsInstances = v7
local u30 = Instance.new("LinearVelocity")
u30.Name = "climbLevitationForce"
u30.MaxForce = 100000000000
u30.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
u30.VectorVelocity = Vector3.new(0, 0, 0)
local u31 = Instance.new("AlignOrientation")
u31.Name = "climbOrientationForce"
u31.MaxTorque = 40000
u31.MaxAngularVelocity = 3000
u31.Responsiveness = 30
u31.Mode = Enum.OrientationAlignmentMode.OneAttachment
local u32 = Instance.new("IntValue", script)
local u33 = u15:LoadAnimation(script:WaitForChild("LedgeClimb"))
local u34 = u15:LoadAnimation(script:WaitForChild("ClimbUp"))
local u35 = u15:LoadAnimation(script:WaitForChild("ClimbDown"))
local u36 = u15:LoadAnimation(script:WaitForChild("ClimbLeft"))
local u37 = u15:LoadAnimation(script:WaitForChild("ClimbRight"))
local u38 = u15:LoadAnimation(script:WaitForChild("ClimbIdle"))
require(script.ConfigReader)
local u39 = script.BillboardGui:Clone()
local function u110(p40) --[[ Line: 148 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u19
        [3] = u30
        [4] = u13
        [5] = u31
        [6] = u21
        [7] = u1
        [8] = u15
        [9] = u18
        [10] = u10
        [11] = u2
        [12] = u3
        [13] = u4
        [14] = u5
        [15] = u39
        [16] = u17
        [17] = u29
        [18] = u28
        [19] = u14
        [20] = u25
        [21] = u16
        [22] = u32
        [23] = u26
    --]]
    local v41 = 0
    if u20 == false then
        return u19:Disconnect()
    elseif u30.Parent == u13 then
        if u31.Parent == u13 then
            u21 = u21 - p40
            if u21 <= 0 then
                return u1:DeActivateClimb()
            end
            local v42 = u15.MoveDirection
            local v43 = u13.CFrame.LookVector
            local v44 = u13.CFrame.RightVector
            local v45 = v43:Dot(v42)
            local v46 = math.round(v45)
            local v47 = v44:Dot(v42)
            local v48 = math.round(v47)
            if not u18 then
                v46 = u10:IsKeyDown(u2) and 1 or (u10:IsKeyDown(u3) and -1 or 0)
                v48 = u10:IsKeyDown(u4) and 1 or (u10:IsKeyDown(u5) and -1 or 0)
            end
            local v49 = u13.CFrame.UpVector * v46
            local v50 = u13.CFrame.RightVector * v48
            local v51 = v50 + v49
            u30.VectorVelocity = v51 * 6
            local v52 = false
            local v53 = u21 / 10
            u39.Progress.Percentage.Value = v53 * 100
            u39.Parent = u13
            if math.abs(v46) > 0 or math.abs(v48) > 0 then
                local v54 = u13.Position
                local v55 = v51 * (u13.Size.X / 2 + u17.Size.X + 2)
                local v56 = workspace:Raycast(v54, v55, u29)
                if v56 and (v56.Instance and v56.Normal) then
                    local v57 = v56.Instance
                    local v58
                    if v57 == nil or v57.CanCollide == false then
                        v58 = false
                    else
                        v58 = v57.Transparency <= 1
                    end
                    if v58 then
                        local v59 = v56.Normal
                        local v60
                        if v59 == nil then
                            v60 = false
                        else
                            local v61 = (Vector3.new(0, 1, 0)):Dot(v59)
                            v60 = math.abs(v61) <= 0.2617993877991494
                        end
                        if v60 and (u28 ~= v56.Normal and (v56.Instance.Size.X > 3 and (v56.Instance.Size.Y > 3 and v56.Instance.Size.Z > 3))) then
                            u28 = v56.Normal
                            local v62 = CFrame.new(v56.Position + v56.Normal, v56.Position)
                            if u31.Parent ~= u13 then
                                u31.Parent = u13
                            end
                            u31.Attachment0 = u14
                            if v62 then
                                u31.CFrame = v62
                            end
                        end
                    end
                elseif math.abs(v46) > 0 or math.abs(v48) > 0 then
                    local v63 = u13.Position
                    local v64 = v43 * 5 * 3
                    local v65 = workspace:Raycast(v63, v64, u29)
                    if v65 and (v65.Instance and v65.Normal) then
                        local v66 = (u13.Position + v43 * -u13.Size.Z / 2 - v65.Position).Magnitude
                        if u13.Size.Z / 2 + 0.2 < v66 then
                            u30.VectorVelocity = u30.VectorVelocity + v43 * (v66 - u13.Size.Z / 2 - 1.5)
                        elseif v66 < u13.Size.Z / 2 + 0.2 then
                            u30.VectorVelocity = u30.VectorVelocity - v43 * (v66 + u13.Size.Z / 2 + 1.5)
                        end
                        local v67 = v65.Instance
                        local v68
                        if v67 == nil or v67.CanCollide == false then
                            v68 = false
                        else
                            v68 = v67.Transparency <= 1
                        end
                        if v68 then
                            local v69 = v65.Normal
                            local v70
                            if v69 == nil then
                                v70 = false
                            else
                                local v71 = (Vector3.new(0, 1, 0)):Dot(v69)
                                v70 = math.abs(v71) <= 0.2617993877991494
                            end
                            if v70 and (u28 ~= v65.Normal and (v65.Instance.Size.X > 3 and (v65.Instance.Size.Y > 3 and v65.Instance.Size.Z > 3))) then
                                u28 = v65.Normal
                                local v72 = CFrame.new(v65.Position + v65.Normal, v65.Position)
                                if u31.Parent ~= u13 then
                                    u31.Parent = u13
                                end
                                u31.Attachment0 = u14
                                if v72 then
                                    u31.CFrame = v72
                                end
                            end
                        end
                    end
                end
            end
            if (math.abs(v46) > 0 or math.abs(v48) > 0) and (v52 == false and tick() - u25 > 0.2) then
                local v73 = u13.Position + v50 * (u13.Size.X + 2 * u17.Size.X + 2) / 15 + v43 * (u13.Size.X + 2 * u17.Size.X + 2)
                local v74 = (u13.Position + v50 * (u13.Size.X + 2 * u17.Size.X + 2) / 16 - v73).Unit * (u13.Size.X + 2 * u17.Size.X + 2)
                local v75 = workspace:Raycast(v73, v74, u29)
                if v75 and (v75.Instance and v75.Normal) then
                    local v76 = v75.Instance
                    local v77
                    if v76 == nil or v76.CanCollide == false then
                        v77 = false
                    else
                        v77 = v76.Transparency <= 1
                    end
                    if v77 then
                        local v78 = v75.Normal
                        local v79
                        if v78 == nil then
                            v79 = false
                        else
                            local v80 = (Vector3.new(0, 1, 0)):Dot(v78)
                            v79 = math.abs(v80) <= 0.2617993877991494
                        end
                        if v79 and (u28 ~= v75.Normal and (v75.Instance.Size.X > 3 and (v75.Instance.Size.Y > 3 and v75.Instance.Size.Z > 3))) then
                            v52 = true
                            u25 = tick()
                            u28 = v75.Normal
                            local v81 = CFrame.new(v75.Position + v75.Normal, v75.Position)
                            if u31.Parent ~= u13 then
                                u31.Parent = u13
                            end
                            u31.Attachment0 = u14
                            if v81 then
                                u31.CFrame = v81
                            end
                        end
                    end
                end
            end
            if (math.abs(v46) > 0 or math.abs(v48) > 0) and (v52 == false and tick() - u25 > 0.2) then
                local v82 = u13.Position + v50 * (u13.Size.X + 2 * u17.Size.X + 2) / 15
                local v83 = (u13.Position - v50 * (u13.Size.X + 2 * u17.Size.X + 2) / 16 + v43 * (u13.Size.X + 2 * u17.Size.X + 2) - v82).Unit * (u13.Size.X + 2 * u17.Size.X + 2)
                local v84 = workspace:Raycast(v82, v83, u29)
                if v84 and (v84.Instance and v84.Normal) then
                    local v85 = v84.Instance
                    local v86
                    if v85 == nil or v85.CanCollide == false then
                        v86 = false
                    else
                        v86 = v85.Transparency <= 1
                    end
                    if v86 then
                        local v87 = v84.Normal
                        local v88
                        if v87 == nil then
                            v88 = false
                        else
                            local v89 = (Vector3.new(0, 1, 0)):Dot(v87)
                            v88 = math.abs(v89) <= 0.2617993877991494
                        end
                        if v88 and (u28 ~= v84.Normal and (v84.Instance.Size.X > 3 and (v84.Instance.Size.Y > 3 and v84.Instance.Size.Z > 3))) then
                            u25 = tick()
                            u28 = v84.Normal
                            local v90 = CFrame.new(v84.Position + v84.Normal, v84.Position)
                            if u31.Parent ~= u13 then
                                u31.Parent = u13
                            end
                            u31.Attachment0 = u14
                            if v90 then
                                u31.CFrame = v90
                            end
                        end
                    end
                end
            end
            local v91 = u13.Position
            local v92 = v43 * 5 * 3
            local v93 = workspace:Raycast(v91, v92, u29)
            if v93 and (v93.Instance and v93.Normal) then
                local v94 = (u13.Position + v43 * -u13.Size.Z / 2 - v93.Position).Magnitude
                if u13.Size.Z / 2 + 0.2 < v94 then
                    u30.VectorVelocity = u30.VectorVelocity + v43 * (v94 - u13.Size.Z / 2 - 1.5)
                elseif v94 < u13.Size.Z / 2 + 0.2 then
                    u30.VectorVelocity = u30.VectorVelocity - v43 * (v94 + u13.Size.Z / 2 + 1.5)
                end
            end
            if v46 == -1 then
                local v95 = u13.Position
                local v96 = v49 * (u16.Position.Y - u13.Position.Y)
                local v97 = workspace:Raycast(v95, v96, u29)
                if v97 and (v97.Instance and v97.Normal) then
                    u1:DeActivateClimb()
                end
            end
            local v98 = u13.Position - v43 * 5 - v49 * (u16.Position.Y - u13.Position.Y)
            local v99 = v43 * 5 * 4
            local v100 = workspace:Raycast(v98, v99, u29)
            if not (v100 and (v100.Instance and v100.Normal)) then
                u1:DeActivateClimb()
            end
            local v101 = false
            if v46 == 1 then
                local v102 = u13.Position - v43 * 5 + v49 * (u16.Position.Y - u13.Position.Y)
                local v103 = 2 * v43 * 5
                local v104 = workspace:Raycast(v102, v103, u29)
                if not (v104 and (v104.Instance and v104.Normal)) then
                    u30.VectorVelocity = u30.VectorVelocity + v43 * 6
                    v101 = true
                end
            end
            u32.Value = v101 == true and u20 and 1 or (u20 and (v46 == 1 and 2 or (v46 == -1 and 3 or (v48 == 1 and 4 or (v48 == -1 and 5 or 6)))) or v41)
            if u20 and tick() - u26 > 1 then
                u26 = tick()
                if u13 then
                    local v105 = u13.Position
                    local v106 = v43 * 5
                    local v107 = workspace:Raycast(v105, v106, u29)
                    if v107 and (v107.Instance and v107.Normal) then
                        local v108 = v107.Instance
                        local v109
                        if v108 == nil or v108.CanCollide == false then
                            v109 = false
                        else
                            v109 = v108.Transparency <= 1
                        end
                        if v109 == false then
                            u1:DeActivateClimb()
                        end
                    end
                end
            end
        end
    else
        return
    end
end
function u1.IsClimbing(_) --[[ Line: 315 ]]
    --[[
    Upvalues:
        [1] = u20
    --]]
    return u20
end
function u1.ActivateClimb(_) --[[ Line: 318 ]]
    --[[
    Upvalues:
        [1] = u22
        [2] = u24
        [3] = u11
        [4] = u29
        [5] = u23
        [6] = u21
        [7] = u20
        [8] = u28
        [9] = u30
        [10] = u13
        [11] = u14
        [12] = u31
        [13] = u27
        [14] = u19
        [15] = u9
        [16] = u110
    --]]
    if u22 == false then
        return false
    elseif tick() - u24 < 0.5 then
        return false
    else
        local v111 = u11.Character or u11.CharacterAdded:Wait()
        local v112 = v111:WaitForChild("HumanoidRootPart")
        v112:WaitForChild("RootRigAttachment")
        local v113 = v111:WaitForChild("Humanoid")
        local v114 = v112.CFrame
        local v115 = workspace:Raycast(v114.Position, v114.LookVector * 5, u29)
        if v115 == nil then
            return false
        elseif v115.Instance == nil then
            return false
        else
            local v116 = v115.Instance
            local v117
            if v116 == nil or v116.CanCollide == false then
                v117 = false
            else
                v117 = v116.Transparency <= 1
            end
            if v117 == false then
                return false
            elseif v115.Normal == nil then
                return false
            else
                local v118 = v115.Normal
                local v119
                if v118 == nil then
                    v119 = false
                else
                    local v120 = (Vector3.new(0, 1, 0)):Dot(v118)
                    v119 = math.abs(v120) <= 0.2617993877991494
                end
                if v119 == false then
                    return false
                elseif v115.Position == nil then
                    return false
                else
                    if u23 then
                        local v121 = u21 + tick() - u24
                        u21 = math.clamp(v121, 0, 10)
                    end
                    if u21 > 0 then
                        u20 = true
                        u28 = v115.Normal
                        local v122 = CFrame.new(v115.Position + v115.Normal, v115.Position)
                        v111:PivotTo(v122)
                        if u30.Parent ~= u13 then
                            u30.Parent = u13
                            u30.Attachment0 = u14
                            u30.VectorVelocity = Vector3.new(0, 0, 0)
                        end
                        if u31.Parent ~= u13 then
                            u31.Parent = u13
                        end
                        u31.Attachment0 = u14
                        if v122 then
                            u31.CFrame = v122
                        end
                        u27 = v113.AutoRotate
                        v113.AutoRotate = false
                        if u19 then
                            u19:Disconnect()
                        end
                        u19 = u9.Heartbeat:Connect(u110)
                    end
                end
            end
        end
    end
end
function u1.DeActivateClimb(_) --[[ Line: 348 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u30
        [3] = u13
        [4] = u31
        [5] = u24
        [6] = u15
        [7] = u27
        [8] = u32
        [9] = u19
        [10] = u9
        [11] = u21
        [12] = u39
    --]]
    u20 = false
    if u30.Parent == u13 then
        u30.Parent = nil
        u30.Attachment0 = nil
    end
    if u31.Parent == u13 then
        u31.Parent = nil
        u31.Attachment0 = nil
    end
    u24 = tick()
    u15.AutoRotate = u27
    u32.Value = 0
    if u19 then
        u19:Disconnect()
    end
    u19 = u9.Heartbeat:Connect(function(p123) --[[ Line: 356 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u39
            [3] = u19
            [4] = u20
        --]]
        u21 = u21 + p123
        u39.Progress.Percentage.Value = u21 / 10 * 100
        if u21 >= 10 then
            u19:Disconnect()
            u21 = 10
        end
        if u39.Progress.Percentage.Value >= 100 and u20 == false then
            u39.Parent = nil
        end
    end)
end
function u1.CanClimb(_) --[[ Line: 372 ]]
    --[[
    Upvalues:
        [1] = u22
    --]]
    return u22
end
function u1.EnableClimb(_) --[[ Line: 375 ]]
    --[[
    Upvalues:
        [1] = u22
    --]]
    u22 = true
end
function u1.DisableClimb(_) --[[ Line: 378 ]]
    --[[
    Upvalues:
        [1] = u22
    --]]
    u22 = false
end
function u1.CanClimbStaminaRegen(_) --[[ Line: 382 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    return u23
end
function u1.EnableClimbStaminaRegen(_) --[[ Line: 385 ]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u24
    --]]
    u23 = true
    u24 = tick()
end
function u1.DisableClimbStaminaRegen(_) --[[ Line: 389 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    u23 = false
end
function u1.GetClimbMaxStamina(_) --[[ Line: 393 ]]
    return 10
end
function u1.GetClimbCurrentStamina(_) --[[ Line: 396 ]]
    --[[
    Upvalues:
        [1] = u21
    --]]
    return u21
end
function u1.EnableMobile(_) --[[ Line: 400 ]]
    --[[
    Upvalues:
        [1] = u18
    --]]
    u18 = true
end
function u1.DisableMobile(_) --[[ Line: 404 ]]
    --[[
    Upvalues:
        [1] = u18
    --]]
    u18 = false
end
u32.Changed:Connect(function() --[[ Line: 408 ]]
    --[[
    Upvalues:
        [1] = u32
        [2] = u33
        [3] = u34
        [4] = u35
        [5] = u37
        [6] = u36
        [7] = u38
    --]]
    if u32 ~= nil then
        if u32.Value == 1 then
            u33:Play()
        else
            u33:Stop()
        end
        if u32.Value == 2 then
            u34:Play()
        else
            u34:Stop()
        end
        if u32.Value == 3 then
            u35:Play(0.100000001, 1, -1)
        else
            u35:Stop()
        end
        if u32.Value == 4 then
            u37:Play()
        else
            u37:Stop()
        end
        if u32.Value == 5 then
            u36:Play()
        else
            u36:Stop()
        end
        if u32.Value == 6 then
            u38:Play()
            return
        end
        u38:Stop()
    end
end)
u11.CharacterAdded:Connect(function(p124) --[[ Line: 444 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u13
        [3] = u14
        [4] = u15
        [5] = u16
    --]]
    u12 = p124
    u13 = u12:WaitForChild("HumanoidRootPart")
    u14 = u13:WaitForChild("RootRigAttachment")
    u15 = u12:WaitForChild("Humanoid")
    u16 = u12:WaitForChild("Head")
end)
return u1