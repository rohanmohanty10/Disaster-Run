 

local v1 = game:GetService("Players")
local u2 = game:GetService("RunService")
local v3 = v1.LocalPlayer
local u4 = nil
local u5 = false
local u6 = nil
local function v45(u7) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
        [3] = u2
        [4] = u5
    --]]
    if u6 then
        u6:Disconnect()
        u6 = nil
    end
    local u8 = u7:WaitForChild("Humanoid")
    local u9 = u7:WaitForChild("HumanoidRootPart")
    local v10 = u8:WaitForChild("Animator")
    local u11 = {}
    for _, v12 in script.Anims:GetChildren() do
        table.insert(u11, v10:LoadAnimation(v12))
    end
    u4 = RaycastParams.new()
    u4.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
    u4.RespectCanCollide = true
    u4.FilterType = Enum.RaycastFilterType.Include
    local u13 = 1
    local u14 = 0
    u8:GetPropertyChangedSignal("MoveDirection"):Connect(function() --[[ Line: 61 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u9
            [3] = u14
            [4] = u6
            [5] = u2
            [6] = u5
            [7] = u7
            [8] = u4
            [9] = u13
            [10] = u11
        --]]
        local v15 = u8.MoveDirection
        local v16 = u9.CFrame:VectorToObjectSpace(v15)
        if v15 == Vector3.new() then
            u14 = 0
        end
        if v16.Z < -0.3 then
            if not u6 then
                u6 = u2.Heartbeat:Connect(function(p17) --[[ Line: 69 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                        [2] = u14
                        [3] = u9
                        [4] = u5
                        [5] = u7
                        [6] = u4
                        [7] = u13
                        [8] = u11
                    --]]
                    if u8.MoveDirection ~= Vector3.new() then
                        u14 = u14 + p17
                    end
                    if u14 < 0.6 then
                        return
                    elseif u9.Anchored == true then
                        return
                    elseif u5 then
                        return
                    elseif u8:GetState() == Enum.HumanoidStateType.Running or (u8:GetState() == Enum.HumanoidStateType.Freefall or u8:GetState() == Enum.HumanoidStateType.Jumping) then
                        if u9:FindFirstChildWhichIsA("BodyVelocity") or u7.LowerTorso:FindFirstChildWhichIsA("BodyVelocity") then
                            return
                        else
                            local v18 = u7
                            if _G.canuse ~= false and (_G.check:inspect(v18) ~= false and v18.Parent == workspace.PlayerCharacters) then
                                local _ = u8.WalkSpeed > 20
                                local v19 = u9.Position
                                local v20 = u7.Head.Position.X
                                local v21 = u9.Position.Y
                                local v22 = u7.Head.Position.Z
                                local v23 = 2 + (v19 - Vector3.new(v20, v21, v22)).Magnitude * 1.5
                                local v24 = u9.Position - u9.CFrame.UpVector * u9.Size.Y * 0.5
                                local v25 = u8.MoveDirection * v23
                                local v26 = workspace:Raycast(v24, v25, u4)
                                if v26 then
                                    local v27 = v26.Normal
                                    local v28 = vector.dot(v27, Vector3.new(0, 1, 0))
                                    if math.abs(v28) > 0.5 then
                                        return
                                    else
                                        local v29 = u8.HipHeight + u9.Size.Y * 0.5
                                        local v30 = v26.Position + v26.Normal * 0.5
                                        local v31 = u9.CFrame.RightVector
                                        local v32 = -v26.Normal
                                        local v33 = vector.cross(v31, v32) * v29
                                        local v34 = v26.Position + v26.Normal
                                        local v35 = Vector3.new(0, 1, 0) * -v29 / 2
                                        if workspace:Raycast(v34, v35, u4) then
                                            return
                                        elseif workspace:Raycast(v30, v33, u4) then
                                            return
                                        else
                                            local v36 = v30 + v33
                                            local v37 = -v26.Normal
                                            if workspace:Raycast(v36, v37, u4) then
                                                return
                                            else
                                                local v38 = v36 + v37
                                                local v39 = u9.CFrame.RightVector
                                                local v40 = v26.Normal
                                                local v41 = vector.cross(v39, v40) * v29
                                                local v42 = workspace:Raycast(v38, v41, u4)
                                                if v42 then
                                                    u5 = true
                                                    u13 = u13 + 1
                                                    if u13 > 3 then
                                                        u13 = 1
                                                    end
                                                    local v43 = u11[u13]
                                                    v43:Play()
                                                    v43.Priority = Enum.AnimationPriority.Action
                                                    if v43.Length ~= 0 then
                                                        v43:AdjustSpeed(v43.Length / 0.4)
                                                    end
                                                    local v44 = Instance.new("BodyVelocity")
                                                    v44.MaxForce = Vector3.new(100000, 100000, 100000)
                                                    v44.Velocity = (v42.Position + v42.Normal * v29 * 1.5 - u9.Position) * 5 + u8.MoveDirection * 3
                                                    v44.Parent = u9
                                                    _G.PlaySound(u7.PrimaryPart, script.VaultingSFX["VaultJump" .. math.random(1, 4)]).Parent = u7.PrimaryPart
                                                    task.delay(0.1, v44.Destroy, v44)
                                                    v43.Stopped:Connect(function() --[[ Line: 156 ]]
                                                        --[[
                                                        Upvalues:
                                                            [1] = u5
                                                        --]]
                                                        u5 = false
                                                    end)
                                                end
                                            end
                                        end
                                    end
                                else
                                    return
                                end
                            else
                                return
                            end
                        end
                    else
                        return
                    end
                end)
            end
        else
            if u6 then
                u6:Disconnect()
                u6 = nil
            end
            return
        end
    end)
end
v45(v3.Character or v3.CharacterAdded:Wait())
v3.CharacterAdded:Connect(v45)