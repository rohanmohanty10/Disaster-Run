 

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
            local u5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("Human")
            local u6 = script:WaitForChild("Walkspeed").Value
            local u7 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
            local u8 = {
                ["Idle"] = u4:LoadAnimation(u5.Idle),
                ["Walk"] = u4:LoadAnimation(u5.Walk),
                ["Run"] = u4:LoadAnimation(u5.Run),
                ["Fall"] = u4:LoadAnimation(u5.Fall),
                ["Jump"] = u4:LoadAnimation(u5.Jump)
            }
            local u9 = 2
            local u10 = "Idle"
            local u11 = {}
            local function u15(p12, p13) --[[ Line: 44 ]]
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
            local function u31() --[[ Line: 56 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u1
                    [3] = u9
                    [4] = u8
                    [5] = u7
                    [6] = u15
                    [7] = u5
                    [8] = u10
                --]]
                for _, v16 in u11 do
                    v16:Disconnect()
                end
                table.clear(u11)
                local v17 = u1.Info:FindFirstChild("Weapon")
                if v17 then
                    local u18 = v17.Value
                    local u19 = game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(u18)
                    if u19 and u19:FindFirstChild("runAnim") then
                        u9 = u7[u18].runSpeed or 2
                    else
                        u9 = 2
                        u8.Run.Priority = Enum.AnimationPriority.Idle
                    end
                    if u19 then
                        local function u23(p20) --[[ Line: 77 ]]
                            --[[
                            Upvalues:
                                [1] = u19
                                [2] = u8
                                [3] = u15
                                [4] = u5
                                [5] = u9
                            --]]
                            if u19:FindFirstChild("runAnim") == nil then
                                return
                            else
                                local v21 = u8.Run.IsPlaying
                                if p20 == nil then
                                    u15("Run", u5.Run)
                                else
                                    u15("Run", u19:FindFirstChild("runAnim"))
                                    u8.Run.Priority = Enum.AnimationPriority.Movement
                                end
                                if v21 == true then
                                    u8.Run:Play()
                                    u8.Run:AdjustSpeed(u9)
                                end
                                if u19:FindFirstChild("walkAnim") ~= nil then
                                    local v22 = u8.Walk.IsPlaying
                                    if p20 == nil then
                                        u15("Walk", u5.Walk)
                                    else
                                        u15("Walk", u19.walkAnim)
                                    end
                                    u8.Walk.Priority = Enum.AnimationPriority.Idle
                                    if v22 == true then
                                        u8.Walk:Play()
                                    end
                                end
                            end
                        end
                        local function v26() --[[ Line: 113 ]]
                            --[[
                            Upvalues:
                                [1] = u1
                                [2] = u18
                                [3] = u8
                                [4] = u15
                                [5] = u5
                                [6] = u19
                                [7] = u23
                            --]]
                            local v24 = u1:FindFirstChild(u18 .. "Sword")
                            local v25 = u8.Idle.IsPlaying
                            if v24 == nil then
                                u15("Idle", u5.Idle)
                            else
                                u15("Idle", u19.Idle)
                            end
                            u8.Idle.Priority = Enum.AnimationPriority.Idle
                            if v25 == true then
                                u8.Idle:Play()
                            end
                            u23(v24)
                        end
                        v26()
                        local v27 = u11
                        local v28 = u1.ChildRemoved
                        table.insert(v27, v28:Connect(v26))
                        local v29 = u11
                        local v30 = u1.ChildAdded
                        table.insert(v29, v30:Connect(v26))
                    end
                    if u10 == "Running" and u8.Run.IsPlaying then
                        u8.Run:AdjustSpeed(u9)
                    end
                else
                    u9 = 2
                    u8.Run.Priority = Enum.AnimationPriority.Idle
                end
            end
            u31()
            local v32 = u1.Info:FindFirstChild("Weapon")
            if v32 then
                v32.Changed:Connect(function() --[[ Line: 145 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                    --]]
                    u31()
                end)
            end
            u8.Walk.Priority = Enum.AnimationPriority.Idle
            u8.Jump.Priority = Enum.AnimationPriority.Movement
            u8.Fall.Priority = Enum.AnimationPriority.Movement
            local function u34(p33) --[[ Line: 154 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                if p33:match("step") and (p33 ~= "step" and (_G.footstep and (u1.PrimaryPart.Position - workspace.CurrentCamera.CFrame.p).magnitude <= 150)) then
                    _G.footstep(p33, nil, u1)
                end
            end
            u8.Walk.KeyframeReached:Connect(function(p35) --[[ Line: 160 ]]
                --[[
                Upvalues:
                    [1] = u34
                --]]
                u34(p35)
            end)
            if u8.Run ~= nil then
                u8.Run.KeyframeReached:Connect(function(p36) --[[ Line: 165 ]]
                    --[[
                    Upvalues:
                        [1] = u34
                    --]]
                    u34(p36)
                end)
            end
            local u37 = {}
            u3.Running:Connect(function(p38) --[[ Line: 194 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u10
                    [3] = u8
                    [4] = u37
                    [5] = u9
                --]]
                if u6 < p38 then
                    if u10 ~= "Running" or u8.Run.IsPlaying == false then
                        u10 = "Running"
                        for v39, _ in u8 do
                            if u8[v39].IsPlaying ~= false then
                                u37[v39] = u8[v39].TimePosition
                                u8[v39]:Stop()
                            end
                        end
                        if u37.Run == nil then
                            u37.Run = 0
                        end
                        u8.Run:Play()
                        u8.Run.TimePosition = u37.Run
                        u8.Run:AdjustSpeed(u9)
                        return
                    end
                elseif p38 > 0.749 then
                    if u10 ~= "Walking" or u8.Walk.IsPlaying == false then
                        u10 = "Walking"
                        for v40, _ in u8 do
                            if u8[v40].IsPlaying ~= false then
                                u37[v40] = u8[v40].TimePosition
                                u8[v40]:Stop()
                            end
                        end
                        if u37.Walk == nil then
                            u37.Walk = 0
                        end
                        u8.Walk:Play()
                        u8.Walk.TimePosition = u37.Walk
                        return
                    end
                elseif u10 ~= "Idle" then
                    u10 = "Idle"
                    for v41, _ in u8 do
                        if u8[v41].IsPlaying ~= false then
                            u37[v41] = u8[v41].TimePosition
                            u8[v41]:Stop()
                        end
                    end
                    u8.Idle:Play()
                end
            end)
            u3.Jumping:Connect(function() --[[ Line: 220 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u8
                    [3] = u37
                --]]
                if u10 ~= "Jump" then
                    u10 = "Jump"
                    for v42, _ in u8 do
                        if u8[v42].IsPlaying ~= false then
                            u37[v42] = u8[v42].TimePosition
                            u8[v42]:Stop()
                        end
                    end
                    u8.Jump:Play()
                end
            end)
            u3.FreeFalling:Connect(function(p43) --[[ Line: 228 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u1
                    [3] = u10
                    [4] = u8
                    [5] = u37
                --]]
                if p43 and (u3.FloorMaterial == Enum.Material.Air and (u1.PrimaryPart.Anchored == false and u10 ~= "Fall")) then
                    u10 = "Fall"
                    for v44, _ in u8 do
                        if u8[v44].IsPlaying ~= false then
                            u37[v44] = u8[v44].TimePosition
                            u8[v44]:Stop()
                        end
                    end
                    u8.Fall:Play()
                end
            end)
            u3.FallingDown:Connect(function(p45) --[[ Line: 238 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u1
                    [3] = u10
                    [4] = u8
                    [5] = u37
                --]]
                if p45 and (u3.FloorMaterial == Enum.Material.Air and (u1.PrimaryPart.Anchored == false and u10 ~= "Fall")) then
                    u10 = "Fall"
                    for v46, _ in u8 do
                        if u8[v46].IsPlaying ~= false then
                            u37[v46] = u8[v46].TimePosition
                            u8[v46]:Stop()
                        end
                    end
                    u8.Fall:Play()
                end
            end)
            u3:GetPropertyChangedSignal("FloorMaterial"):Connect(function() --[[ Line: 247 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u10
                    [3] = u8
                    [4] = u37
                --]]
                if u3.FloorMaterial == Enum.Material.Air and u10 ~= "Fall" then
                    u10 = "Fall"
                    for v47, _ in u8 do
                        if u8[v47].IsPlaying ~= false then
                            u37[v47] = u8[v47].TimePosition
                            u8[v47]:Stop()
                        end
                    end
                    u8.Fall:Play()
                elseif u3.FloorMaterial ~= Enum.Material.Air and u10 == "Fall" then
                    u10 = "Idle"
                    for v48, _ in u8 do
                        if u8[v48].IsPlaying ~= false then
                            u37[v48] = u8[v48].TimePosition
                            u8[v48]:Stop()
                        end
                    end
                    u8.Idle:Play()
                end
            end)
            u3.GettingUp:Connect(function() --[[ Line: 259 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u8
                    [3] = u37
                --]]
                u10 = "Idle"
                for v49, _ in u8 do
                    if u8[v49].IsPlaying ~= false then
                        u37[v49] = u8[v49].TimePosition
                        u8[v49]:Stop()
                    end
                end
                u8.Idle:Play()
            end)
            task.defer(function() --[[ Line: 265 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                u8.Idle:Play()
            end)
            while true do
                task.wait(math.random(10, 15))
                _G.PlaySound(u1.Head, script["Audio/CupidLaugh" .. math.random(1, 7)]).Parent = u1.Head
            end
        else
            return
        end
    else
        script:Destroy()
        return
    end
else
    script:Destroy()
    return
end