 

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
                local u10 = u1.Info:FindFirstChild("Weapon")
                local u11 = u1.Info:FindFirstChild("Weapon").Value
                local u12 = game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(u11)
                if u12 and u12:FindFirstChild("runAnim") then
                    u9 = v7[u11].runSpeed or 2
                else
                    u8.Run.Priority = Enum.AnimationPriority.Idle
                end
                if u12 then
                    local function u16(p13, p14) --[[ Line: 48 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                            [2] = u4
                        --]]
                        if u8[p13] and u8[p13].Animation.AnimationId ~= p14.AnimationId then
                            local v15 = u8[p13].IsPlaying
                            u8[p13]:Stop()
                            u8[p13]:Destroy()
                            u8[p13] = u4:LoadAnimation(p14)
                            if v15 then
                                u8[p13]:Play()
                            end
                        end
                    end
                    local function u20(p17) --[[ Line: 60 ]]
                        --[[
                        Upvalues:
                            [1] = u12
                            [2] = u8
                            [3] = u16
                            [4] = u5
                        --]]
                        if u12:FindFirstChild("runAnim") == nil then
                            return
                        else
                            local v18 = u8.Run.IsPlaying
                            if p17 == nil then
                                u16("Run", u5.Run)
                            else
                                u16("Run", u12:FindFirstChild("runAnim"))
                                u8.Run.Priority = Enum.AnimationPriority.Movement
                            end
                            if v18 == true then
                                u8.Run:Play()
                            end
                            if u12:FindFirstChild("walkAnim") ~= nil then
                                local v19 = u8.Walk.IsPlaying
                                if p17 == nil then
                                    u16("Walk", u5.Walk)
                                else
                                    u16("Walk", u12.walkAnim)
                                end
                                u8.Walk.Priority = Enum.AnimationPriority.Idle
                                if v19 == true then
                                    u8.Walk:Play()
                                end
                            end
                        end
                    end
                    local function v23() --[[ Line: 95 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u11
                            [3] = u8
                            [4] = u16
                            [5] = u5
                            [6] = u12
                            [7] = u20
                        --]]
                        local v21 = u1:FindFirstChild(u11 .. "Sword")
                        local v22 = u8.Idle.IsPlaying
                        if v21 == nil then
                            u16("Idle", u5.Idle)
                        else
                            u16("Idle", u12.Idle)
                        end
                        u8.Idle.Priority = Enum.AnimationPriority.Idle
                        if v22 == true then
                            u8.Idle:Play()
                        end
                        u20(v21)
                    end
                    v23()
                    u1.ChildRemoved:Connect(v23)
                    u1.ChildAdded:Connect(v23)
                end
                if u10 then
                    u10.Changed:Connect(function() --[[ Line: 116 ]]
                        --[[
                        Upvalues:
                            [1] = u11
                            [2] = u10
                            [3] = u12
                        --]]
                        if u11 ~= u10.Value then
                            u11 = u10.Value
                            u12 = game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(u11)
                        end
                    end)
                end
            else
                u8.Run.Priority = Enum.AnimationPriority.Idle
            end
            u8.Walk.Priority = Enum.AnimationPriority.Idle
            u8.Jump.Priority = Enum.AnimationPriority.Movement
            u8.Fall.Priority = Enum.AnimationPriority.Movement
            local function u25(p24) --[[ Line: 130 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                if p24:match("step") and (p24 ~= "step" and (_G.footstep and (u1.PrimaryPart.Position - workspace.CurrentCamera.CFrame.p).magnitude <= 150)) then
                    _G.footstep(p24, nil, u1)
                end
            end
            u8.Walk.KeyframeReached:Connect(function(p26) --[[ Line: 135 ]]
                --[[
                Upvalues:
                    [1] = u25
                --]]
                u25(p26)
            end)
            if u8.Run ~= nil then
                u8.Run.KeyframeReached:Connect(function(p27) --[[ Line: 139 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                    --]]
                    u25(p27)
                end)
            end
            local u28 = {}
            local u29 = "Idle"
            u3.Running:Connect(function(p30) --[[ Line: 168 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u29
                    [3] = u8
                    [4] = u28
                    [5] = u9
                --]]
                if u6 < p30 then
                    if u29 ~= "Running" or u8.Run.IsPlaying == false then
                        u29 = "Running"
                        for v31, _ in u8 do
                            if u8[v31].IsPlaying ~= false then
                                u28[v31] = u8[v31].TimePosition
                                u8[v31]:Stop()
                            end
                        end
                        if u28.Run == nil then
                            u28.Run = 0
                        end
                        u8.Run:Play()
                        u8.Run.TimePosition = u28.Run
                        u8.Run:AdjustSpeed(u9)
                        return
                    end
                elseif p30 > 0.749 then
                    if u29 ~= "Walking" or u8.Walk.IsPlaying == false then
                        u29 = "Walking"
                        for v32, _ in u8 do
                            if u8[v32].IsPlaying ~= false then
                                u28[v32] = u8[v32].TimePosition
                                u8[v32]:Stop()
                            end
                        end
                        if u28.Walk == nil then
                            u28.Walk = 0
                        end
                        u8.Walk:Play()
                        u8.Walk.TimePosition = u28.Walk
                        return
                    end
                elseif u29 ~= "Idle" then
                    u29 = "Idle"
                    for v33, _ in u8 do
                        if u8[v33].IsPlaying ~= false then
                            u28[v33] = u8[v33].TimePosition
                            u8[v33]:Stop()
                        end
                    end
                    u8.Idle:Play()
                end
            end)
            u3.Jumping:Connect(function() --[[ Line: 193 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u8
                    [3] = u28
                --]]
                if u29 ~= "Jump" then
                    u29 = "Jump"
                    for v34, _ in u8 do
                        if u8[v34].IsPlaying ~= false then
                            u28[v34] = u8[v34].TimePosition
                            u8[v34]:Stop()
                        end
                    end
                    u8.Jump:Play()
                end
            end)
            u3.FreeFalling:Connect(function(p35) --[[ Line: 200 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u1
                    [3] = u29
                    [4] = u8
                    [5] = u28
                --]]
                if p35 and (u3.FloorMaterial == Enum.Material.Air and (u1.PrimaryPart.Anchored == false and u29 ~= "Fall")) then
                    u29 = "Fall"
                    for v36, _ in u8 do
                        if u8[v36].IsPlaying ~= false then
                            u28[v36] = u8[v36].TimePosition
                            u8[v36]:Stop()
                        end
                    end
                    u8.Fall:Play()
                end
            end)
            u3.FallingDown:Connect(function(p37) --[[ Line: 209 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u1
                    [3] = u29
                    [4] = u8
                    [5] = u28
                --]]
                if p37 and (u3.FloorMaterial == Enum.Material.Air and (u1.PrimaryPart.Anchored == false and u29 ~= "Fall")) then
                    u29 = "Fall"
                    for v38, _ in u8 do
                        if u8[v38].IsPlaying ~= false then
                            u28[v38] = u8[v38].TimePosition
                            u8[v38]:Stop()
                        end
                    end
                    u8.Fall:Play()
                end
            end)
            u3:GetPropertyChangedSignal("FloorMaterial"):Connect(function() --[[ Line: 218 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u29
                    [3] = u8
                    [4] = u28
                --]]
                if u3.FloorMaterial == Enum.Material.Air and u29 ~= "Fall" then
                    u29 = "Fall"
                    for v39, _ in u8 do
                        if u8[v39].IsPlaying ~= false then
                            u28[v39] = u8[v39].TimePosition
                            u8[v39]:Stop()
                        end
                    end
                    u8.Fall:Play()
                elseif u3.FloorMaterial ~= Enum.Material.Air and u29 == "Fall" then
                    u29 = "Idle"
                    for v40, _ in u8 do
                        if u8[v40].IsPlaying ~= false then
                            u28[v40] = u8[v40].TimePosition
                            u8[v40]:Stop()
                        end
                    end
                    u8.Idle:Play()
                end
            end)
            u3.GettingUp:Connect(function() --[[ Line: 230 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u8
                    [3] = u28
                --]]
                u29 = "Idle"
                for v41, _ in u8 do
                    if u8[v41].IsPlaying ~= false then
                        u28[v41] = u8[v41].TimePosition
                        u8[v41]:Stop()
                    end
                end
                u8.Idle:Play()
            end)
            task.defer(function() --[[ Line: 236 ]]
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