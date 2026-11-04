 

local u1 = game:GetService("RunService")
game:GetService("TweenService")
local u2 = game:GetService("UserInputService")
local u3 = workspace.CurrentCamera
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
Mouse = Ess.Mouse
local u4 = {
    "A",
    "W",
    "S",
    "D"
}
local u5 = { "R", "Z" }
local function u7() --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    for _, v6 in u2:GetKeysPressed() do
        if table.find(u4, v6.KeyCode.Name) then
            return true
        end
    end
    return false
end
local function u9() --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
    --]]
    for _, v8 in u2:GetKeysPressed() do
        if table.find(u5, v8.KeyCode.Name) then
            return true
        end
    end
end
return {
    ["start"] = function(_, u10, p11) --[[ Name: start, Line 42 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u9
            [3] = u1
            [4] = u3
        --]]
        if _G.checkRenderDistance(u10.PrimaryPart.Position) == false then
            return
        else
            Random.new()
            u10:GetAttribute("Transformed")
            u10:GetAttribute("InFlight")
            if p11 and game.Players.LocalPlayer == p11 then
                return
            else
                local u12 = u10:FindFirstChild("PhoenixFullForm")
                local u13 = u10.PrimaryPart
                u10:FindFirstChild("UpperTorso")
                local u14 = u10:FindFirstChild("Humanoid")
                local u15 = u14.Animator
                local u16 = u12:FindFirstChild("AnimationController").Animator
                u10:FindFirstChild("CharacterEffects"):FindFirstChild("Transformation")
                local v17 = u13.CFrame
                local u18 = {}
                for _, v19 in script.Parent.Anims.Hybrid.Movement:GetChildren() do
                    u18["Hybrid" .. v19.Name] = u15:LoadAnimation(v19)
                end
                for _, v20 in script.Parent.Anims.Full.Movement:GetChildren() do
                    u18["Full" .. v20.Name] = u16:LoadAnimation(v20)
                end
                local u21 = {}
                local v22 = Instance.new("Attachment") or workspace.Terrain:FindFirstChild(u10.Name)
                table.insert(u21, v22)
                local u23 = script.AlignOrientation:Clone() or u13:FindFirstChild("RootRigAttachment").AlignOrientation
                table.insert(u21, u23)
                local u24 = script.VectorForce:Clone() or u13:FindFirstChild("RootRigAttachment").VectorForce
                table.insert(u21, u24)
                v22.Name = u10.Name
                v22.WorldCFrame = u13.CFrame * CFrame.new(0, 0, -2)
                u23.CFrame = v17
                u23.Attachment0 = u13:FindFirstChild("RootRigAttachment")
                u23.Attachment1 = v22
                u24.Attachment0 = u13:FindFirstChild("RootRigAttachment")
                local v25 = u13.AssemblyLinearVelocity.Y * game.Workspace.Gravity
                local v26 = math.abs(v25) + 7000
                u24.Force = Vector3.new(0, v26, 0)
                v22.Parent = workspace.Terrain
                u23.Parent = u13
                u24.Parent = u13
                local v27 = TweenCreate
                local v28 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                local v29 = {}
                local v30 = game.Workspace.Gravity
                v29.Force = Vector3.new(0, v30, 0) * u13.AssemblyMass
                v27(u24, v28, v29)
                u21[#u21 + 1] = u10:GetAttributeChangedSignal("Transformed"):Connect(function() --[[ Line: 111 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u14
                        [3] = u21
                        [4] = u15
                        [5] = u16
                        [6] = u18
                        [7] = u13
                        [8] = u24
                        [9] = u23
                    --]]
                    if u10:GetAttribute("Transformed") == false then
                        u14.PlatformStand = false
                        Ess.Destroy(u21, 0)
                        local v31 = u15:GetPlayingAnimationTracks()
                        local v32 = u16:GetPlayingAnimationTracks()
                        for _, v33 in u18 do
                            for _, v34 in v31 do
                                if v34.Name:match(v33.Name) then
                                    v34:Stop()
                                    v34:Destroy()
                                end
                            end
                            for _, v35 in v32 do
                                if v35.Name:match(v33.Name) then
                                    v35:Stop()
                                    v35:Destroy()
                                end
                            end
                        end
                        for _, v36 in u13:GetChildren() do
                            if v36.Name:match(u24.Name) or v36.Name:match(u23.Name) then
                                v36:Destroy()
                            end
                        end
                    end
                end)
                task.wait(0.8)
                if u10:GetAttribute("Transformed") then
                    u18.HybridIdle:Play()
                    u18.FullIdle:Play()
                    u23.Enabled = true
                    u14.PlatformStand = true
                    local u37 = tick()
                    for v38, v39 in u18 do
                        if v38:match("Full") then
                            local u40 = v38:match("Flight") and true or false
                            local u41 = #u21 + 1
                            u21[u41] = v39:GetMarkerReachedSignal("Flap"):Connect(function() --[[ Line: 178 ]]
                                --[[
                                Upvalues:
                                    [1] = u10
                                    [2] = u21
                                    [3] = u41
                                    [4] = u40
                                    [5] = u7
                                    [6] = u9
                                    [7] = u12
                                    [8] = u13
                                --]]
                                if u10:GetAttribute("Transformed") then
                                    if (u40 or u7() ~= true) and u10:GetAttribute("Blocking") ~= true then
                                        if u9() ~= true then
                                            local v42 = u12:FindFirstChild("Body").Transparency == 0
                                            _G.PlaySound(u13:FindFirstChild("RootRigAttachment"), _G.SoundsFolder.WingFlap[(v42 and "FullForm" or "HalfForm") .. "WingFlap"], {
                                                ["PlaybackSpeed"] = u40 and 1.4 or 1
                                            }, true)
                                        end
                                    else
                                        return
                                    end
                                else
                                    u21[u41]:Disconnect()
                                    return
                                end
                            end)
                        end
                    end
                    local u43 = #u21 + 1
                    u21[u43] = u1.RenderStepped:Connect(function() --[[ Line: 193 ]]
                        --[[
                        Upvalues:
                            [1] = u10
                            [2] = u21
                            [3] = u43
                            [4] = u9
                            [5] = u7
                            [6] = u37
                            [7] = u14
                            [8] = u13
                            [9] = u3
                            [10] = u24
                            [11] = u18
                            [12] = u23
                        --]]
                        if u10:GetAttribute("Transformed") then
                            local v44 = u10:GetAttribute("Boost")
                            local v45 = u10:GetAttribute("Blocking")
                            local v46 = u9()
                            local v47 = u7()
                            local _ = tick() - u37
                            tick()
                            local v48 = u14.MoveDirection
                            local v49 = v48.X
                            local v50 = -u13.CFrame.LookVector:Dot(u3.CFrame.UpVector * 3) * 2
                            local v51 = v48.Z
                            local v52 = Vector3.new(v49, v50, v51)
                            local v53 = -u13.AssemblyLinearVelocity.Unit * 1.9 * u13.AssemblyMass * u13.AssemblyLinearVelocity.Magnitude ^ 1.2
                            local v54 = u24
                            local v55 = game.Workspace.Gravity
                            v54.Force = Vector3.new(0, v55, 0) * u13.AssemblyMass
                            if v47 and not (v46 or (v45 or v44)) then
                                if not (u18.HybridFlight.IsPlaying or u18.FullFlight.IsPlaying) then
                                    u18.HybridFlight:Play(0.2)
                                    u18.FullFlight:Play(0.3, 1, 1)
                                end
                                local v56 = u24
                                v56.Force = v56.Force + v52.Unit * 4500
                                u23.CFrame = CFrame.new(Vector3.new(0, 0, 0), v52.Unit)
                            elseif v46 or (v45 or v44) then
                                u23.CFrame = CFrame.new(Vector3.new(0, 0, 0), CFrame.new(u3.CFrame.Position, Mouse.GetPosition(Ess.RaycastParams)).LookVector)
                                if v44 then
                                    local v57 = u24
                                    v57.Force = v57.Force + u23.CFrame.LookVector * 13500
                                end
                            elseif not v47 and (not v44 and (u18.HybridFlight.IsPlaying or u18.FullFlight.IsPlaying)) then
                                u18.HybridFlight:Stop(0.4)
                                u18.FullFlight:Stop(0.4)
                            end
                            local v58 = u24
                            v58.Force = v58.Force + v53
                        else
                            u21[u43]:Disconnect()
                        end
                    end)
                end
            end
        end
    end
}