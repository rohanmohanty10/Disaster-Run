 

local u1 = game:GetService("TweenService")
local u2 = require(game.ReplicatedStorage.Modules.Trove)
local u3 = RaycastParams.new()
u3.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u3.FilterType = Enum.RaycastFilterType.Include
local u4 = OverlapParams.new()
u4.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u4.FilterType = Enum.RaycastFilterType.Include
function createRock(p5, p6)
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    local v7 = p5.CFrame
    local v8 = p5.Size
    local v9 = p5.Duration
    if p6 == nil then
        p6 = workspace:Raycast(v7.Position + Vector3.new(0, 1, 0), Vector3.new(-0, -8, -0), u3)
    end
    if not p6 then
        return nil
    end
    local u10 = p5.Fling
    if u10 then
        local v11 = script.DustShockwave:Clone()
        v11.Smoke2.Color = ColorSequence.new(p6.Instance.Color)
        v11.CFrame = CFrame.new(p6.Position, p6.Position + p6.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)
        v11.Parent = workspace.Effects
        v11.Smoke2:Emit(1)
        _G.destroy(v11, 4)
        if math.random(1, 2) == 1 then
            return true
        end
    end
    local u12 = script.Part:Clone()
    u12.Size = v8 + Vector3.new(1, 1, 1) * math.random()
    u12.CFrame = CFrame.new(Vector3.new(0, 0, 0), Random.new():NextUnitVector()) + p6.Position
    _G.matchMaterial(u12, p6.Instance)
    u12.Parent = workspace.Effects
    if u10 then
        local v13 = p5.Part
        u12.Anchored = false
        u12.CanCollide = true
        local v14 = v13.AssemblyLinearVelocity.Magnitude * 10
        u12.Size = u12.Size * 0.7
        local v15 = math.random(-v14, v14) / 100
        local v16 = math.random(2000, 4000) / 100
        local v17 = math.random(-v14, v14) / 100
        u12.AssemblyLinearVelocity = Vector3.new(v15, v16, v17)
        local v18 = math.random(-5, 5)
        local v19 = math.random(-5, 5)
        local v20 = math.random
        u12.AssemblyAngularVelocity = Vector3.new(v18, v19, v20(-5, 5))
        v9 = v9 * (math.random(100, 130) / 100)
    end
    task.delay(v9, function() --[[ Line: 58 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u1
            [3] = u12
        --]]
        if u10 then
            u1:Create(u12, TweenInfo.new(1), {
                ["Size"] = Vector3.new()
            }):Play()
        else
            u1:Create(u12, TweenInfo.new(1), {
                ["Position"] = u12.Position - Vector3.new(0, 1, 0) * u12.Size.Magnitude
            }):Play()
        end
        task.wait(1)
        u12:Destroy()
    end)
    return true
end
return {
    ["start"] = function(_, u21) --[[ Name: start, Line 83 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u4
        --]]
        local u22 = tick()
        local u23 = u21.Part
        local u24 = u21.Size
        local u25 = u21.RockDuration
        local u26 = u21.Width or 1
        local u27 = u21.NoSound
        if u23 == nil then
            return
        elseif _G.checkRenderDistance(u23.Position) == false then
            return
        elseif not u23:GetAttribute("RockVelocityTrail") then
            local u28 = u23.Position
            u23:SetAttribute("RockVelocityTrail", true)
            local u29 = script.scrape:Clone()
            u29.Pitch = math.random(90, 110) / 100
            u29.Parent = u23
            local u30 = false
            local u31 = false
            local u32 = 0
            local u33 = u23.Parent:FindFirstChildWhichIsA("Humanoid")
            local u34 = u23.Size
            if u23.Parent:IsA("Model") then
                u34 = u23.Parent:GetExtentsSize()
                local v35 = u23.Size.Magnitude
                if v35 <= u34.Magnitude and (u23:IsDescendantOf(workspace.NPCs) or u23:IsDescendantOf(workspace.PlayerCharacters)) then
                    u34 = Vector3.new(v35, v35, v35)
                end
            end
            local u36 = false
            local u37 = u2.new()
            u37:AttachToInstance(u23)
            local u38 = tick()
            local u39 = 0
            local v40 = u23.Parent == game.Players.LocalPlayer.Character
            local u41 = u24.X * 4
            if v40 == false then
                u41 = u24.X * 6
            end
            local u42 = Vector3.new()
            u37:Connect(game["Run Service"].Stepped, function(_, p43) --[[ Line: 148 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u22
                    [3] = u21
                    [4] = u38
                    [5] = u33
                    [6] = u37
                    [7] = u29
                    [8] = u28
                    [9] = u3
                    [10] = u34
                    [11] = u4
                    [12] = u31
                    [13] = u39
                    [14] = u36
                    [15] = u41
                    [16] = u42
                    [17] = u26
                    [18] = u24
                    [19] = u25
                    [20] = u32
                    [21] = u27
                    [22] = u30
                --]]
                local v44 = u23.AssemblyLinearVelocity
                if v44.Magnitude <= 1 then
                    if u23.Velocity.Magnitude > 1 then
                        v44 = u23.Velocity
                    else
                        v44 = u23.CFrame.LookVector * -25
                    end
                end
                local v45 = u23.Position + Vector3.new(0, 2, 0)
                if v44.Magnitude < 15 and tick() - u22 >= u21.Duration or (tick() - u38 >= 10 or u33:GetAttribute("isRagdolled") == nil and (u33:GetState() ~= Enum.HumanoidStateType.Physics and tick() - u38 >= 0.1)) then
                    u37:Destroy()
                    if u29.Name ~= "ended" then
                        _G.tween(u29, {
                            0.25,
                            Enum.EasingStyle.Linear,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Volume"] = 0
                        })
                    end
                    _G.destroy(u29, 0.25)
                    u23:SetAttribute("RockVelocityTrail", nil)
                    return
                else
                    local v46 = (v45 - u28).Magnitude
                    local v47 = v44.Magnitude
                    local v48 = math.clamp(v47, 1, 100000000000) * p43
                    local v49
                    if v44.Magnitude > 0 then
                        v49 = workspace:Blockcast(u23.CFrame, u23.Size + Vector3.new(1, 1, 1), v44.Unit * v48, u3)
                    else
                        v49 = nil
                    end
                    if #workspace:GetPartBoundsInBox(u23.CFrame, u34, u4) <= 0 then
                        u31 = false
                    end
                    if v49 and (v49.Instance and (tick() - u39 >= 0.1 and u31 == false)) then
                        if u36 == false then
                            u36 = true
                            _G.PlaySound(CFrame.new(v49.Position), script.firstHit, {
                                ["Pitch"] = math.random(90, 110) / 100
                            })
                        else
                            _G.PlaySound(CFrame.new(v49.Position), script.hitGround, {
                                ["Pitch"] = math.random(90, 110) / 100
                            })
                        end
                        local v50 = (v49.Position - u23.Position).Magnitude
                        local v51 = v49.Position:Lerp(u23.Position, 0.5)
                        local v52 = CFrame.new(v51, v51 + v49.Normal)
                        local v53 = v44.Magnitude / 4
                        local v54 = -v52.LookVector * v50
                        _G.PlayEffect("GroundRocks4", nil, {
                            ["Segments"] = 20,
                            ["Position"] = v52.Position,
                            ["DistanceRandomness"] = Vector2.new(0.5, 1),
                            ["Duration"] = 4,
                            ["TweenDuration"] = 1,
                            ["Radius"] = 8,
                            ["Direction"] = v54,
                            ["Smoke"] = true
                        })
                        _G.PlayEffect("RockDebris", nil, {
                            ["PartCount"] = 5,
                            ["RandomVelocityMagnitude"] = Vector2.new(-v53, v53),
                            ["Position"] = v52.Position,
                            ["Direction"] = v44.Unit * -v53,
                            ["RaycastDirection"] = v54,
                            ["Size"] = Vector3.new(0.7, 0.7, 0.7)
                        }, true)
                        u31 = true
                        u39 = tick()
                    end
                    if v46 <= u41 then
                        return
                    else
                        local v55 = (CFrame.new(Vector3.new(0, 0, 0), v44) + v45).Position
                        if (u42 - v55).Magnitude <= u41 then
                            return
                        else
                            u42 = v55
                            u28 = v45
                            createRock({
                                ["CFrame"] = CFrame.new(Vector3.new(0, 0, 0), v44) * CFrame.new(u26, 0, 0) + v45,
                                ["Size"] = u24,
                                ["Duration"] = u25
                            })
                            createRock({
                                ["CFrame"] = CFrame.new(Vector3.new(0, 0, 0), v44) * CFrame.new(-u26, 0, 0) + v45,
                                ["Size"] = u24,
                                ["Duration"] = u25
                            })
                            local v56 = createRock({
                                ["CFrame"] = CFrame.new(Vector3.new(0, 0, 0), v44) + v45,
                                ["Size"] = u24,
                                ["Duration"] = u25,
                                ["Part"] = u23,
                                ["Fling"] = true
                            }, nil)
                            if v56 == nil then
                                u32 = 0
                            end
                            if v56 then
                                if (u29.IsPlaying == false or u29:GetAttribute("tweeningOut")) and u27 == nil then
                                    u29:SetAttribute("tweeningOut", nil)
                                    u29.Volume = 0
                                    u29:Play()
                                    _G.tween(u29, {
                                        0.25,
                                        Enum.EasingStyle.Quad,
                                        Enum.EasingDirection.Out,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Volume"] = script.scrape.Volume
                                    })
                                end
                                u32 = u32 + p43
                                u30 = false
                            elseif v56 == nil then
                                if u29.IsPlaying and (u29:GetAttribute("tweeningOut") == nil and u27 == nil) then
                                    u29:SetAttribute("tweeningOut", true)
                                    _G.tween(u29, {
                                        0.25,
                                        Enum.EasingStyle.Quad,
                                        Enum.EasingDirection.Out,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Volume"] = 0
                                    })
                                end
                                u31 = false
                                u30 = true
                                u32 = 0
                            end
                        end
                    end
                end
            end)
        end
    end
}