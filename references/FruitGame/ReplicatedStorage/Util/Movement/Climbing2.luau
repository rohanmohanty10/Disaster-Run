 

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
local u16 = {
    ["diameter"] = 120,
    ["padding"] = 4,
    ["count"] = 64,
    ["size"] = 1024
}
local u17 = false
local u18 = nil
local u19 = false
local u20 = 0
local u21 = true
local u22 = true
local u23 = 0
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
local u39 = require(script.ConfigReader)
local u40 = script.BillboardGui:Clone()
u40.ImageLabel.ImageLabel.ImageRectSize = Vector2.new(u39.GetSize(u16))
local function u113(_) --[[ Line: 143 ]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u18
        [3] = u30
        [4] = u13
        [5] = u31
        [6] = u25
        [7] = u20
        [8] = u1
        [9] = u15
        [10] = u17
        [11] = u10
        [12] = u2
        [13] = u3
        [14] = u4
        [15] = u5
        [16] = u40
        [17] = u39
        [18] = u16
        [19] = u12
        [20] = u29
        [21] = u28
        [22] = u14
        [23] = u24
        [24] = u32
        [25] = u26
    --]]
    local v41 = 0
    if u19 == false then
        return u18:Disconnect()
    elseif u30.Parent == u13 then
        if u31.Parent == u13 then
            if tick() - u25 >= 1 then
                u20 = u20 - 1
                u25 = tick()
            end
            if u20 <= 0 then
                return u1:DeActivateClimb()
            end
            local v42 = u15.MoveDirection
            local v43 = u13.CFrame.LookVector
            local v44 = u13.CFrame.RightVector
            local v45 = v43:Dot(v42)
            local v46 = math.round(v45)
            local v47 = v44:Dot(v42)
            local v48 = math.round(v47)
            if not u17 then
                v46 = u10:IsKeyDown(u2) and 1 or (u10:IsKeyDown(u3) and -1 or 0)
                v48 = u10:IsKeyDown(u4) and 1 or (u10:IsKeyDown(u5) and -1 or 0)
            end
            local v49 = u13.CFrame.UpVector * v46
            local v50 = u13.CFrame.RightVector * v48
            local v51 = v50 + v49
            u30.VectorVelocity = v51 * 6
            local v52 = false
            local v53 = u20 / 10
            local v54 = Vector2.new
            local v55 = u40.ImageLabel.ImageLabel
            v55.ImageRectSize = v54(u39.GetSize(u16))
            local v56 = v53 * 64
            v55.ImageRectOffset = v54(u39.GetOffset(u16, v56))
            v55.ImageColor3 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(85, 255, 127), v53)
            u40.Parent = u13
            if math.abs(v46) > 0 or math.abs(v48) > 0 then
                local v57 = u13.Position
                local v58 = v51 * u12:GetExtentsSize().X / 2
                local v59 = workspace:Raycast(v57, v58, u29)
                if v59 and (v59.Instance and v59.Normal) then
                    local v60 = v59.Instance
                    local v61
                    if v60 == nil or v60.CanCollide == false then
                        v61 = false
                    else
                        v61 = v60.Transparency <= 1
                    end
                    if v61 then
                        local v62 = v59.Normal
                        local v63
                        if v62 == nil then
                            v63 = false
                        else
                            local v64 = (Vector3.new(0, 1, 0)):Dot(v62)
                            v63 = math.abs(v64) <= 0.2617993877991494
                        end
                        if v63 and (u28 ~= v59.Normal and (v59.Instance.Size.X > 3 and (v59.Instance.Size.Y > 3 and v59.Instance.Size.Z > 3))) then
                            u28 = v59.Normal
                            local v65 = CFrame.new(v59.Position + v59.Normal, v59.Position)
                            if u31.Parent ~= u13 then
                                u31.Parent = u13
                            end
                            u31.Attachment0 = u14
                            if v65 then
                                u31.CFrame = v65
                            end
                        end
                    end
                elseif math.abs(v46) > 0 or math.abs(v48) > 0 then
                    local v66 = u13.Position
                    local v67 = v43 * 5 * 3
                    local v68 = workspace:Raycast(v66, v67, u29)
                    if v68 and (v68.Instance and v68.Normal) then
                        local v69 = (u13.Position + v43 * -u12:GetExtentsSize().Z / 2 - v68.Position).Magnitude
                        if u12:GetExtentsSize().Z / 2 + 0.2 < v69 then
                            u30.VectorVelocity = u30.VectorVelocity + v43 * (v69 - u12:GetExtentsSize().Z / 2 - 1.5)
                        elseif v69 < u12:GetExtentsSize().Z / 2 + 0.2 then
                            u30.VectorVelocity = u30.VectorVelocity - v43 * (v69 + u12:GetExtentsSize().Z / 2 + 1.5)
                        end
                        local v70 = v68.Instance
                        local v71
                        if v70 == nil or v70.CanCollide == false then
                            v71 = false
                        else
                            v71 = v70.Transparency <= 1
                        end
                        if v71 then
                            local v72 = v68.Normal
                            local v73
                            if v72 == nil then
                                v73 = false
                            else
                                local v74 = (Vector3.new(0, 1, 0)):Dot(v72)
                                v73 = math.abs(v74) <= 0.2617993877991494
                            end
                            if v73 and (u28 ~= v68.Normal and (v68.Instance.Size.X > 3 and (v68.Instance.Size.Y > 3 and v68.Instance.Size.Z > 3))) then
                                u28 = v68.Normal
                                local v75 = CFrame.new(v68.Position + v68.Normal, v68.Position)
                                if u31.Parent ~= u13 then
                                    u31.Parent = u13
                                end
                                u31.Attachment0 = u14
                                if v75 then
                                    u31.CFrame = v75
                                end
                            end
                        end
                    end
                end
            end
            if (math.abs(v46) > 0 or math.abs(v48) > 0) and (v52 == false and tick() - u24 > 0.2) then
                local v76 = u13.Position + v50 * u12:GetExtentsSize().X / 15 + v43 * u12:GetExtentsSize().X
                local v77 = (u13.Position + v50 * u12:GetExtentsSize().X / 16 - v76).Unit * u12:GetExtentsSize().X
                local v78 = workspace:Raycast(v76, v77, u29)
                if v78 and (v78.Instance and v78.Normal) then
                    local v79 = v78.Instance
                    local v80
                    if v79 == nil or v79.CanCollide == false then
                        v80 = false
                    else
                        v80 = v79.Transparency <= 1
                    end
                    if v80 then
                        local v81 = v78.Normal
                        local v82
                        if v81 == nil then
                            v82 = false
                        else
                            local v83 = (Vector3.new(0, 1, 0)):Dot(v81)
                            v82 = math.abs(v83) <= 0.2617993877991494
                        end
                        if v82 and (u28 ~= v78.Normal and (v78.Instance.Size.X > 3 and (v78.Instance.Size.Y > 3 and v78.Instance.Size.Z > 3))) then
                            v52 = true
                            u24 = tick()
                            u28 = v78.Normal
                            local v84 = CFrame.new(v78.Position + v78.Normal, v78.Position)
                            if u31.Parent ~= u13 then
                                u31.Parent = u13
                            end
                            u31.Attachment0 = u14
                            if v84 then
                                u31.CFrame = v84
                            end
                        end
                    end
                end
            end
            if (math.abs(v46) > 0 or math.abs(v48) > 0) and (v52 == false and tick() - u24 > 0.2) then
                local v85 = u13.Position + v50 * u12:GetExtentsSize().X / 15
                local v86 = (u13.Position - v50 * u12:GetExtentsSize().X / 16 + v43 * u12:GetExtentsSize().X - v85).Unit * u12:GetExtentsSize().X
                local v87 = workspace:Raycast(v85, v86, u29)
                if v87 and (v87.Instance and v87.Normal) then
                    local v88 = v87.Instance
                    local v89
                    if v88 == nil or v88.CanCollide == false then
                        v89 = false
                    else
                        v89 = v88.Transparency <= 1
                    end
                    if v89 then
                        local v90 = v87.Normal
                        local v91
                        if v90 == nil then
                            v91 = false
                        else
                            local v92 = (Vector3.new(0, 1, 0)):Dot(v90)
                            v91 = math.abs(v92) <= 0.2617993877991494
                        end
                        if v91 and (u28 ~= v87.Normal and (v87.Instance.Size.X > 3 and (v87.Instance.Size.Y > 3 and v87.Instance.Size.Z > 3))) then
                            u24 = tick()
                            u28 = v87.Normal
                            local v93 = CFrame.new(v87.Position + v87.Normal, v87.Position)
                            if u31.Parent ~= u13 then
                                u31.Parent = u13
                            end
                            u31.Attachment0 = u14
                            if v93 then
                                u31.CFrame = v93
                            end
                        end
                    end
                end
            end
            local v94 = u13.Position
            local v95 = v43 * 5 * 3
            local v96 = workspace:Raycast(v94, v95, u29)
            if v96 and (v96.Instance and v96.Normal) then
                local v97 = (u13.Position + v43 * -u12:GetExtentsSize().Z / 2 - v96.Position).Magnitude
                if u12:GetExtentsSize().Z / 2 + 0.2 < v97 then
                    u30.VectorVelocity = u30.VectorVelocity + v43 * (v97 - u12:GetExtentsSize().Z / 2 - 1.5)
                elseif v97 < u12:GetExtentsSize().Z / 2 + 0.2 then
                    u30.VectorVelocity = u30.VectorVelocity - v43 * (v97 + u12:GetExtentsSize().Z / 2 + 1.5)
                end
            end
            if v46 == -1 then
                local v98 = u13.Position
                local v99 = v49 * u12:GetExtentsSize().Y / 2
                local v100 = workspace:Raycast(v98, v99, u29)
                if v100 and (v100.Instance and v100.Normal) then
                    u1:DeActivateClimb()
                end
            end
            local v101 = u13.Position - v43 * 5 - v49 * u12:GetExtentsSize().Y / 3
            local v102 = v43 * 5 * 4
            local v103 = workspace:Raycast(v101, v102, u29)
            if not (v103 and (v103.Instance and v103.Normal)) then
                u1:DeActivateClimb()
            end
            local v104 = false
            if v46 == 1 then
                local v105 = u13.Position - v43 * 5 + v49 * u12:GetExtentsSize().Y / 3.5
                local v106 = 2 * v43 * 5
                local v107 = workspace:Raycast(v105, v106, u29)
                if not (v107 and (v107.Instance and v107.Normal)) then
                    u30.VectorVelocity = u30.VectorVelocity + v43 * 6
                    v104 = true
                end
            end
            u32.Value = v104 == true and u19 and 1 or (u19 and (v46 == 1 and 2 or (v46 == -1 and 3 or (v48 == 1 and 4 or (v48 == -1 and 5 or 6)))) or v41)
            if u19 and tick() - u26 > 1 then
                u26 = tick()
                if u13 then
                    local v108 = u13.Position
                    local v109 = v43 * 5
                    local v110 = workspace:Raycast(v108, v109, u29)
                    if v110 and (v110.Instance and v110.Normal) then
                        local v111 = v110.Instance
                        local v112
                        if v111 == nil or v111.CanCollide == false then
                            v112 = false
                        else
                            v112 = v111.Transparency <= 1
                        end
                        if v112 == false then
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
function u1.IsClimbing(_) --[[ Line: 322 ]]
    --[[
    Upvalues:
        [1] = u19
    --]]
    return u19
end
function u1.ActivateClimb(_) --[[ Line: 325 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u23
        [3] = u11
        [4] = u29
        [5] = u22
        [6] = u20
        [7] = u19
        [8] = u28
        [9] = u30
        [10] = u13
        [11] = u14
        [12] = u31
        [13] = u27
        [14] = u18
        [15] = u9
        [16] = u113
    --]]
    if u21 == false then
        return false
    elseif tick() - u23 < 0.5 then
        return false
    else
        local v114 = u11.Character or u11.CharacterAdded:Wait()
        local v115 = v114:WaitForChild("HumanoidRootPart")
        v115:WaitForChild("RootRigAttachment")
        local v116 = v114:WaitForChild("Humanoid")
        local v117 = v115.CFrame
        local v118 = workspace:Raycast(v117.Position, v117.LookVector * 5, u29)
        if v118 == nil then
            return false
        elseif v118.Instance == nil then
            return false
        else
            local v119 = v118.Instance
            local v120
            if v119 == nil or v119.CanCollide == false then
                v120 = false
            else
                v120 = v119.Transparency <= 1
            end
            if v120 == false then
                return false
            elseif v118.Normal == nil then
                return false
            else
                local v121 = v118.Normal
                local v122
                if v121 == nil then
                    v122 = false
                else
                    local v123 = (Vector3.new(0, 1, 0)):Dot(v121)
                    v122 = math.abs(v123) <= 0.2617993877991494
                end
                if v122 == false then
                    return false
                elseif v118.Position == nil then
                    return false
                else
                    if u22 then
                        local v124 = u20
                        local v125 = tick() - u23
                        local v126 = v124 + math.floor(v125)
                        u20 = math.clamp(v126, 0, 10)
                    end
                    if u20 > 0 then
                        u19 = true
                        u28 = v118.Normal
                        local v127 = CFrame.new(v118.Position + v118.Normal, v118.Position)
                        v114:PivotTo(v127)
                        if u30.Parent ~= u13 then
                            u30.Parent = u13
                            u30.Attachment0 = u14
                            u30.VectorVelocity = Vector3.new(0, 0, 0)
                        end
                        if u31.Parent ~= u13 then
                            u31.Parent = u13
                        end
                        u31.Attachment0 = u14
                        if v127 then
                            u31.CFrame = v127
                        end
                        u27 = v116.AutoRotate
                        v116.AutoRotate = false
                        u18 = u9.Heartbeat:Connect(u113)
                    end
                end
            end
        end
    end
end
function u1.DeActivateClimb(_) --[[ Line: 354 ]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u30
        [3] = u13
        [4] = u31
        [5] = u23
        [6] = u15
        [7] = u27
        [8] = u32
        [9] = u40
    --]]
    u19 = false
    if u30.Parent == u13 then
        u30.Parent = nil
        u30.Attachment0 = nil
    end
    if u31.Parent == u13 then
        u31.Parent = nil
        u31.Attachment0 = nil
    end
    u23 = tick()
    u15.AutoRotate = u27
    u32.Value = 0
    u40.Parent = nil
end
function u1.CanClimb(_) --[[ Line: 365 ]]
    --[[
    Upvalues:
        [1] = u21
    --]]
    return u21
end
function u1.EnableClimb(_) --[[ Line: 368 ]]
    --[[
    Upvalues:
        [1] = u21
    --]]
    u21 = true
end
function u1.DisableClimb(_) --[[ Line: 371 ]]
    --[[
    Upvalues:
        [1] = u21
    --]]
    u21 = false
end
function u1.CanClimbStaminaRegen(_) --[[ Line: 375 ]]
    --[[
    Upvalues:
        [1] = u22
    --]]
    return u22
end
function u1.EnableClimbStaminaRegen(_) --[[ Line: 378 ]]
    --[[
    Upvalues:
        [1] = u22
        [2] = u23
    --]]
    u22 = true
    u23 = tick()
end
function u1.DisableClimbStaminaRegen(_) --[[ Line: 382 ]]
    --[[
    Upvalues:
        [1] = u22
    --]]
    u22 = false
end
function u1.GetClimbMaxStamina(_) --[[ Line: 386 ]]
    return 10
end
function u1.GetClimbCurrentStamina(_) --[[ Line: 389 ]]
    --[[
    Upvalues:
        [1] = u20
    --]]
    return u20
end
function u1.EnableMobile(_) --[[ Line: 393 ]]
    --[[
    Upvalues:
        [1] = u17
    --]]
    u17 = true
end
function u1.DisableMobile(_) --[[ Line: 397 ]]
    --[[
    Upvalues:
        [1] = u17
    --]]
    u17 = false
end
u32.Changed:Connect(function() --[[ Line: 401 ]]
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
return u1