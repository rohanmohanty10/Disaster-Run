 

local u1 = script:WaitForChild("Character").Value
if u1 then
    local v2 = workspace
    local u3 = u1:WaitForChild("Humanoid", 5)
    if u3:IsA("Humanoid") == false then
        script:Destroy()
        return
    elseif u3 and u3.Health > 0 then
        local u4 = u3:WaitForChild("Animator", 3) or u3
        if u3.Parent and (u3:IsDescendantOf(v2) and (u4.Parent and u4:IsDescendantOf(v2))) then
            local u5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("Perona")
            local u6 = script:WaitForChild("Walkspeed").Value
            local v7 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
            local u8 = {
                ["Idle"] = u4:LoadAnimation(u5.Idle),
                ["Walk"] = u4:LoadAnimation(u5.Walk),
                ["Run"] = u4:LoadAnimation(u5.Run),
                ["Fall"] = u4:LoadAnimation(u5.Fall),
                ["Jump"] = u4:LoadAnimation(u5.Jump)
            }
            local u9 = 2
            if u1.Info:FindFirstChild("Weapon") then
                local u10 = u1.Info:FindFirstChild("Weapon").Value
                local u11 = game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(u10)
                if u11 and u11:FindFirstChild("runAnim") then
                    u9 = v7[u10].runSpeed or 2
                else
                    u8.Run.Priority = Enum.AnimationPriority.Idle
                end
                if u11 then
                    local function u15(p12, p13) --[[ Line: 49 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                            [2] = u4
                        --]]
                        if u8[p12] and u8[p12].Animation.AnimationId ~= p13.AnimationId then
                            local v14 = u8[p12].IsPlaying
                            u8[p12]:Stop()
                            u8[p12]:Destroy()
                            u8[p12] = u4:LoadAnimation(p13)
                            if v14 then
                                u8[p12]:Play()
                            end
                        end
                    end
                    local function u19(p16) --[[ Line: 61 ]]
                        --[[
                        Upvalues:
                            [1] = u11
                            [2] = u8
                            [3] = u15
                            [4] = u5
                        --]]
                        if u11:FindFirstChild("runAnim") == nil then
                            return
                        else
                            local v17 = u8.Run.IsPlaying
                            if p16 == nil then
                                u15("Run", u5.Run)
                            else
                                u15("Run", u11:FindFirstChild("runAnim"))
                                u8.Run.Priority = Enum.AnimationPriority.Movement
                            end
                            if v17 == true then
                                u8.Run:Play()
                            end
                            if u11:FindFirstChild("walkAnim") ~= nil then
                                local v18 = u8.Walk.IsPlaying
                                if p16 == nil then
                                    u15("Walk", u5.Walk)
                                else
                                    u15("Walk", u11.walkAnim)
                                end
                                u8.Walk.Priority = Enum.AnimationPriority.Idle
                                if v18 == true then
                                    u8.Walk:Play()
                                end
                            end
                        end
                    end
                    local function v22() --[[ Line: 96 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u10
                            [3] = u8
                            [4] = u15
                            [5] = u5
                            [6] = u11
                            [7] = u19
                        --]]
                        local v20 = u1:FindFirstChild(u10 .. "Sword")
                        local v21 = u8.Idle.IsPlaying
                        if v20 == nil then
                            u15("Idle", u5.Idle)
                        else
                            u15("Idle", u11.Idle)
                        end
                        u8.Idle.Priority = Enum.AnimationPriority.Idle
                        if v21 == true then
                            u8.Idle:Play()
                        end
                        u19(v20)
                    end
                    v22()
                    u1.ChildRemoved:Connect(v22)
                    u1.ChildAdded:Connect(v22)
                end
            else
                u8.Run.Priority = Enum.AnimationPriority.Idle
            end
            u8.Walk.Priority = Enum.AnimationPriority.Idle
            u8.Jump.Priority = Enum.AnimationPriority.Movement
            u8.Fall.Priority = Enum.AnimationPriority.Movement
            local function u24(p23) --[[ Line: 123 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                if p23:match("step") and (p23 ~= "step" and (_G.footstep and (u1.PrimaryPart.Position - workspace.CurrentCamera.CFrame.p).magnitude <= 150)) then
                    _G.footstep(p23, nil, u1)
                end
            end
            u8.Walk.KeyframeReached:Connect(function(p25) --[[ Line: 128 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                u24(p25)
            end)
            if u8.Run ~= nil then
                u8.Run.KeyframeReached:Connect(function(p26) --[[ Line: 132 ]]
                    --[[
                    Upvalues:
                        [1] = u24
                    --]]
                    u24(p26)
                end)
            end
            local u27 = {}
            local u28 = "Idle"
            u3.Running:Connect(function(p29) --[[ Line: 161 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u28
                    [3] = u8
                    [4] = u27
                    [5] = u9
                --]]
                if u6 + 5 < p29 then
                    if u28 ~= "Running" or u8.Run.IsPlaying == false then
                        u28 = "Running"
                        for v30, _ in u8 do
                            if u8[v30].IsPlaying ~= false then
                                u27[v30] = u8[v30].TimePosition
                                u8[v30]:Stop()
                            end
                        end
                        if u27.Run == nil then
                            u27.Run = 0
                        end
                        u8.Run:Play()
                        u8.Run.TimePosition = u27.Run
                        u8.Run:AdjustSpeed(u9)
                        return
                    end
                elseif p29 > 0.749 then
                    if u28 ~= "Walking" or u8.Walk.IsPlaying == false then
                        u28 = "Walking"
                        for v31, _ in u8 do
                            if u8[v31].IsPlaying ~= false then
                                u27[v31] = u8[v31].TimePosition
                                u8[v31]:Stop()
                            end
                        end
                        if u27.Walk == nil then
                            u27.Walk = 0
                        end
                        u8.Walk:Play()
                        u8.Walk.TimePosition = u27.Walk
                        return
                    end
                elseif u28 ~= "Idle" then
                    u28 = "Idle"
                    for v32, _ in u8 do
                        if u8[v32].IsPlaying ~= false then
                            u27[v32] = u8[v32].TimePosition
                            u8[v32]:Stop()
                        end
                    end
                    u8.Idle:Play()
                end
            end)
            u3.Jumping:Connect(function() --[[ Line: 186 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u8
                    [3] = u27
                --]]
                if u28 ~= "Jump" then
                    u28 = "Jump"
                    for v33, _ in u8 do
                        if u8[v33].IsPlaying ~= false then
                            u27[v33] = u8[v33].TimePosition
                            u8[v33]:Stop()
                        end
                    end
                    u8.Jump:Play()
                end
            end)
            u3.FreeFalling:Connect(function(p34) --[[ Line: 193 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u1
                    [3] = u28
                    [4] = u8
                    [5] = u27
                --]]
                if p34 and (u3.FloorMaterial == Enum.Material.Air and (u1.PrimaryPart.Anchored == false and u28 ~= "Fall")) then
                    u28 = "Fall"
                    for v35, _ in u8 do
                        if u8[v35].IsPlaying ~= false then
                            u27[v35] = u8[v35].TimePosition
                            u8[v35]:Stop()
                        end
                    end
                    u8.Fall:Play()
                end
            end)
            u3.FallingDown:Connect(function(p36) --[[ Line: 202 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u1
                    [3] = u28
                    [4] = u8
                    [5] = u27
                --]]
                if p36 and (u3.FloorMaterial == Enum.Material.Air and (u1.PrimaryPart.Anchored == false and u28 ~= "Fall")) then
                    u28 = "Fall"
                    for v37, _ in u8 do
                        if u8[v37].IsPlaying ~= false then
                            u27[v37] = u8[v37].TimePosition
                            u8[v37]:Stop()
                        end
                    end
                    u8.Fall:Play()
                end
            end)
            u3:GetPropertyChangedSignal("FloorMaterial"):Connect(function() --[[ Line: 212 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u28
                    [3] = u8
                    [4] = u27
                --]]
                if u3.FloorMaterial == Enum.Material.Air and u28 ~= "Fall" then
                    u28 = "Fall"
                    for v38, _ in u8 do
                        if u8[v38].IsPlaying ~= false then
                            u27[v38] = u8[v38].TimePosition
                            u8[v38]:Stop()
                        end
                    end
                    u8.Fall:Play()
                elseif u3.FloorMaterial ~= Enum.Material.Air and u28 == "Fall" then
                    u28 = "Idle"
                    for v39, _ in u8 do
                        if u8[v39].IsPlaying ~= false then
                            u27[v39] = u8[v39].TimePosition
                            u8[v39]:Stop()
                        end
                    end
                    u8.Idle:Play()
                end
            end)
            u3.GettingUp:Connect(function() --[[ Line: 224 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u8
                    [3] = u27
                --]]
                u28 = "Idle"
                for v40, _ in u8 do
                    if u8[v40].IsPlaying ~= false then
                        u27[v40] = u8[v40].TimePosition
                        u8[v40]:Stop()
                    end
                end
                u8.Idle:Play()
            end)
            task.defer(function() --[[ Line: 230 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                u8.Idle:Play()
            end)
        end
    else
        script:Destroy()
        return
    end
else
    script:Destroy()
    return
end