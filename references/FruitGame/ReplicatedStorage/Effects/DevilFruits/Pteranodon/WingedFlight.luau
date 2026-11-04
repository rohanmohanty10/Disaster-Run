 

local u1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = workspace.CurrentCamera
local v5 = game.Players.LocalPlayer
local u6 = require(v5:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"))
local u7 = require(u1.Modules.Shared.Maids.Maid)
return {
    ["start"] = function(_, u8, p9, u10) --[[ Name: start, Line 12 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u1
            [3] = u2
            [4] = u3
            [5] = u6
            [6] = u4
        --]]
        local u11 = u8.HumanoidRootPart
        local u12 = u8.Humanoid
        local u13 = u7.new()
        local u14 = u8:GetAttribute("FormType")
        local u15 = u1["Stats" .. p9.Name]
        local v16 = u8:FindFirstChild("WingController", true)
        local u17 = {
            [u14] = {},
            ["Wings"] = {}
        }
        local u18 = false
        for _, v19 in script.Anims.Wings:GetChildren() do
            u17.Wings[v19.Name] = v16:LoadAnimation(v19)
            local u20 = true
            u17.Wings[v19.Name]:GetMarkerReachedSignal("Flap"):Connect(function() --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u20
                    [3] = u10
                --]]
                if u8:GetAttribute("FormType") == "Hybrid" == u20 then
                    if _G.canuse ~= false and _G.blocking ~= true then
                        u10:FireServer()
                    end
                else
                    return
                end
            end)
        end
        for _, v21 in script.Anims[u14]:GetChildren() do
            u17[u14][v21.Name] = (u14 == "Hybrid" and u12.Animator or u8:FindFirstChild("FormAnimator", true)):LoadAnimation(v21)
            u17[u14][v21.Name].Priority = Enum.AnimationPriority.Action
            local u22 = false
            u17[u14][v21.Name]:GetMarkerReachedSignal("Flap"):Connect(function() --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u22
                    [3] = u10
                --]]
                if u8:GetAttribute("FormType") == "Hybrid" == u22 then
                    if _G.canuse ~= false and _G.blocking ~= true then
                        u10:FireServer()
                    end
                else
                    return
                end
            end)
        end
        local function u23() --[[ Line: 64 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u14
                [3] = u18
                [4] = u13
                [5] = u10
                [6] = u12
            --]]
            u17[u14].Flight:Stop()
            u17.Wings.Flight:Stop()
            u17[u14].Idle:Stop()
            u17.Wings.Idle:Stop()
            u18 = true
            u13:Destroy()
            warn("stopped flying")
            if u10 then
                u10:FireServer("end")
            end
            u12.PlatformStand = false
            u12.AutoRotate = true
            u12:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            u12.Sit = true
            task.delay(0.1, function() --[[ Line: 80 ]]
                --[[
                Upvalues:
                    [1] = u12
                --]]
                u12.Sit = false
            end)
        end
        local u24 = script.VectorForce:Clone()
        u24.Attachment0 = u11:FindFirstChild("RootRigAttachment")
        local v25 = u11.AssemblyLinearVelocity.Y * game.Workspace.Gravity
        local v26 = math.abs(v25) + 7000
        u24.Force = Vector3.new(0, v26, 0)
        u24.Parent = u11
        u13:AddTask(u24)
        local u27 = script.AlignOrientation:Clone()
        u27.Enabled = true
        u27.Attachment0 = u24.Attachment0
        u27.CFrame = u11.CFrame
        u27.Parent = u11
        u13:AddTask(u27)
        local v28 = game.Workspace.Gravity
        local v29 = Vector3.new(0, v28, 0) * u11.AssemblyMass
        if v29 ~= v29 then
            local v30 = game.Workspace.Gravity
            v29 = Vector3.new(0, v30, 0) * 20
        end
        u2:Create(u24, TweenInfo.new(0.25), {
            ["Force"] = v29
        }):Play()
        u13:AddTask(u8:GetAttributeChangedSignal("PetraFlying"):Connect(function() --[[ Line: 111 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u23
            --]]
            local v31 = u8:GetAttribute("PetraFlying")
            if v31 == nil or v31 == false then
                warn("peta false stop flying")
                u23()
            end
        end))
        task.wait(0.25)
        if u18 then
            warn("already ended")
        else
            u17[u14].Idle:Play()
            u17.Wings.Idle:Play()
            local u32 = 0
            local u33 = false
            u12.AutoRotate = false
            u12.PlatformStand = true
            u12.Sit = false
            u12:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            u13:AddTask(u3.RenderStepped:Connect(function(p34) --[[ Line: 144 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u6
                    [3] = u8
                    [4] = u23
                    [5] = u33
                    [6] = u17
                    [7] = u14
                    [8] = u12
                    [9] = u32
                    [10] = u4
                    [11] = u27
                    [12] = u15
                    [13] = u24
                --]]
                if u11.Anchored then
                    return
                else
                    local v35 = u6:GetMoveVector()
                    local v36 = game.Workspace.Gravity
                    local v37 = Vector3.new(0, v36, 0) * u11.AssemblyMass
                    local v38 = u8:GetAttribute("PetraFlying")
                    if v38 == nil or v38 == false then
                        warn("client perta flying", v38)
                        u23()
                    else
                        if v35.Magnitude > 0 then
                            if not u33 then
                                u33 = true
                                u17[u14].Flight:Play()
                                u17.Wings.Flight:Play()
                                u17[u14].Idle:Stop()
                                u17.Wings.Idle:Stop()
                            end
                        elseif u33 then
                            u33 = false
                            u17[u14].Flight:Stop()
                            u17.Wings.Flight:Stop()
                            u17[u14].Idle:Play()
                            u17.Wings.Idle:Play()
                        end
                        u12.AutoRotate = false
                        u12.PlatformStand = true
                        u12.Sit = false
                        u12:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                        u32 = u32 + p34
                        local v39 = u8:GetAttribute("FormType") == "Hybrid"
                        local v40 = u32 * (v39 and 2 or 4) * 3.141592653589793 / 1.827
                        local v41 = Vector3.new(0, 500, 0) * math.sin(v40)
                        local v42 = -(u11.AssemblyLinearVelocity.Magnitude > 0 and u11.AssemblyLinearVelocity.Unit or Vector3.new(0, 0, 0)) * 1.9 * u11.AssemblyMass
                        local v43 = u11.AssemblyLinearVelocity.Magnitude
                        local v44 = u11.AssemblyLinearVelocity.Magnitude + 1
                        local v45 = v42 * math.clamp(v43, 1, v44) ^ 1.2 + v37
                        local v46 = u8:FindFirstChild("inCombat") and 0.5 or 1
                        local v47 = v35 == Vector3.new(0, 0, 0) and Vector3.new(0, 0, 0) or CFrame.new(u4.CFrame.Position, u4.CFrame * CFrame.new(v35).Position).LookVector * _G.ScaleWithHP(6000) * v46
                        local v48 = v47:Dot(v47) ~= v47:Dot(v47) and Vector3.new(0, 0, 0) or v47
                        local v49 = _G.FaceMouse == true and true or (u8:FindFirstChild("Stun") or _G.canuse == false)
                        u27.Enabled = not _G.FaceMouse
                        local v50 = u8:FindFirstChild("Blocking")
                        local v51 = nil
                        local v52
                        if v49 or v50 ~= nil then
                            v52 = v45 + v41
                            if v50 ~= nil then
                                v51 = u4.CFrame
                            end
                        else
                            v52 = v45 + v48 + v41
                            v51 = v48 ~= Vector3.new(0, 0, 0) and CFrame.new(Vector3.new(0, 0, 0), v48) or u4.CFrame
                        end
                        if v39 == false then
                            local v53 = u8:FindFirstChildWhichIsA("Tool")
                            if v53 and v53.Name ~= "Pteranodon-Pteranodon" then
                                task.defer(function() --[[ Line: 222 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u12
                                    --]]
                                    u12:UnequipTools()
                                end)
                            end
                        elseif u15.Stamina.Value <= 0 then
                            warn("no stamina peta stop")
                            u23()
                            return
                        end
                        if v52 == v52 and v51 == v51 then
                            u24.Force = v52
                            if v51 ~= nil then
                                u27.CFrame = v51
                                return
                            end
                        else
                            local v54 = v45 == v45 and (v48 == v48 and (v41 == v41 and "add together" or "flap") or "move dir") or "float"
                            warn("NAN MOVEMENT", v54)
                            if v54 ~= "float" then
                                return
                            end
                            local _ = u12.SeatPart
                            if u12.SeatPart then
                                u12.Sit = false
                                return
                            end
                        end
                    end
                end
            end))
            u13:AttachToInstance(u8)
        end
    end
}