 

local v1 = {}
game:GetService("TweenService")
local u2 = game:GetService("RunService")
Random.new()
local u3 = RaycastParams.new()
u3.FilterType = Enum.RaycastFilterType.Include
u3.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
function v1.start(_, u4, p5, u6) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if typeof(u4) == "CFrame" then
        local v7 = script.Explosion:Clone()
        v7.CFrame = u4
        v7.Parent = workspace.Effects
        _G.destroy(v7, 2)
        _G.customEmit(v7)
        _G.PlaySound(v7, script.Skill2Explosion)
        local v8 = script.Shockwave:Clone()
        v8.CFrame = u4
        v8.Parent = workspace.Effects
        _G.destroy(v8, 0.5)
        _G.tween(v8, {
            0.5,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Position"] = v8.Position + Vector3.new(0, 3, 0),
            ["Size"] = v8.Size * 3,
            ["Orientation"] = v8.Orientation + Vector3.new(0, 150, 0),
            ["Transparency"] = 1
        })
        local v9 = script.Pull:Clone()
        v9.CFrame = u4 * CFrame.new(0, 0, 5)
        v9.Parent = workspace.Effects
        _G.destroy(v9, 2)
        _G.customEmit(v9)
        local v10 = Random.new()
        for _ = 1, 8 do
            local v11 = _G.PlayEffect
            local v12 = {
                ["origin"] = v7.CFrame,
                ["Amount"] = 1,
                ["Velocity"] = 45,
                ["TimeUntilDelete"] = 2
            }
            local v13 = v10:NextNumber(-25, 25)
            local v14 = v10:NextNumber(55, 75)
            v12.CustomVelocity = Vector3.new(v13, v14, v10:NextNumber(-25, 25)) * 0.5
            v12.Projectile = script.Parent.DropletAssets.Droplet
            local v15 = -workspace.Gravity * 2
            v12.CustomGravity = Vector3.new(0, v15, 0)
            v12.UseRaycast = true
            function v12.CustomHitFunction(p16) --[[ Line: 52 ]]
                local v17 = script.Parent.DropletAssets.DropletHit:Clone()
                v17.WorldCFrame = p16 * CFrame.new(0, 0.1, 0)
                v17.Parent = workspace.Terrain
                _G.customEmit(v17)
                _G.destroy(v17, 3)
                _G.PlaySound(v17, script.Parent.DropletAssets.SFX, {
                    ["RandomSound"] = true,
                    ["RandomPitch"] = true
                })
            end
            v11("CustomImpactDroplet", nil, v12)
        end
        return
    else
        local v18 = workspace:GetServerTimeNow() - p5
        local u19 = u2:IsServer() ~= false and true or u4 == game.Players.LocalPlayer.Character
        local u20 = false
        local u21 = u4.Humanoid:LoadAnimation(script.Release)
        u21.Priority = Enum.AnimationPriority.Action4
        u21:Play()
        u21:AdjustSpeed(0.5)
        local u22 = nil
        u22 = u4.ChildAdded:Connect(function(p23) --[[ Line: 91 ]]
            --[[
            Upvalues:
                [1] = u20
                [2] = u21
                [3] = u22
            --]]
            if p23.Name == "PB" then
                u20 = true
                u21:Stop()
                if u22 then
                    u22:Disconnect()
                    u22 = nil
                end
            end
        end)
        local function u26(u24, u25) --[[ Line: 103 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u20
                [3] = u2
                [4] = u6
                [5] = u4
            --]]
            if u19 and u20 == false then
                if u2:IsServer() == false then
                    u6:FireServer(u24, u25)
                    return
                end
                task.spawn(function() --[[ Line: 108 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                        [2] = u4
                        [3] = u24
                        [4] = u25
                    --]]
                    u6(u4, u24, u25)
                end)
            end
        end
        _G.PlaySound(u4.PrimaryPart, script.Skill2Jump).Parent = u4.PrimaryPart
        tick()
        task.wait(0.65 - v18)
        if u20 == true then
            if u22 then
                u22:Disconnect()
                u22 = nil
            end
            return
        else
            local _ = u4.PrimaryPart.CFrame
            local v27 = u4.Humanoid
            local u28 = u19
            local u29 = u22
            local u30 = u20
            local v31 = 0
            local u32 = nil
            local u33 = nil
            for _, v34 in pairs(u4:GetDescendants()) do
                if v34:IsA("BasePart") and not v34.Massless then
                    v31 = v31 + v34:GetMass()
                end
            end
            local function u47(p35) --[[ Line: 141 ]]
                --[[
                Upvalues:
                    [1] = u32
                    [2] = u33
                    [3] = u4
                    [4] = u2
                    [5] = u30
                    [6] = u29
                --]]
                if u32 then
                    u32:Destroy()
                end
                if u33 then
                    u33:Disconnect()
                end
                local u36 = p35.Duration
                local v37 = p35.Speed
                local u38 = os.clock()
                local _ = u4.HumanoidRootPart
                local u39 = Instance.new("BodyVelocity")
                u39.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
                u39.Velocity = Vector3.new()
                u39.Parent = u4.PrimaryPart
                local u40 = u4.PrimaryPart
                local u41 = v37 * 0.7
                u33 = u2.Heartbeat:Connect(function() --[[ Line: 157 ]]
                    --[[
                    Upvalues:
                        [1] = u38
                        [2] = u36
                        [3] = u30
                        [4] = u39
                        [5] = u33
                        [6] = u29
                        [7] = u40
                        [8] = u41
                    --]]
                    local v42 = (os.clock() - u38) / u36
                    if v42 >= 1 or u30 == true then
                        u39:Destroy()
                        u39 = nil
                        u33:Disconnect()
                        u33 = nil
                        if u29 then
                            u29:Disconnect()
                            u29 = nil
                        end
                    else
                        u40.AssemblyAngularVelocity = Vector3.new()
                        local v43 = 1 - v42
                        local v44 = u40.CFrame.LookVector
                        local v45 = v44.X
                        local v46 = v44.Z
                        u39.Velocity = Vector3.new(v45, 0, v46).Unit * u41 * v43
                    end
                end)
                u32 = u39
            end
            local u48 = u4.PrimaryPart.Size.Y + 1
            local u49 = script.Hit:Clone()
            u49.CFrame = u4.PrimaryPart.CFrame * CFrame.new(-1, 0, -u48)
            u49.Parent = workspace.Effects
            _G.destroy(u49, 5)
            _G.PlaySound(u4.PrimaryPart, script["Skill2Swing1-V2"]).Parent = u4.PrimaryPart
            _G.customEmit(u49)
            u47({
                ["Duration"] = 0.2,
                ["Speed"] = 35
            })
            if u28 then
                u26(u4.PrimaryPart.CFrame, "Kick1")
            end
            task.delay(0.2, function() --[[ Line: 199 ]]
                --[[
                Upvalues:
                    [1] = u30
                    [2] = u29
                    [3] = u49
                    [4] = u4
                    [5] = u48
                    [6] = u47
                    [7] = u28
                    [8] = u26
                --]]
                if u30 == true then
                    if u29 then
                        u29:Disconnect()
                        u29 = nil
                    end
                    return
                else
                    u49.CFrame = u4.PrimaryPart.CFrame * CFrame.new(0, 0, -u48)
                    _G.PlaySound(u4.PrimaryPart, script["Skill2Swing2-V2"]).Parent = u4.PrimaryPart
                    _G.customEmit(u49)
                    u47({
                        ["Duration"] = 0.4,
                        ["Speed"] = 35
                    })
                    if u28 then
                        u26(u4.PrimaryPart.CFrame, "Kick2")
                    end
                    task.wait(0.4)
                    if u30 == true then
                        if u29 then
                            u29:Disconnect()
                            u29 = nil
                        end
                    else
                        u49.CFrame = u4.PrimaryPart.CFrame * CFrame.new(1, 0, -u48)
                        _G.PlaySound(u4.PrimaryPart, script["Skill2Swing3-V2"]).Parent = u4.PrimaryPart
                        _G.customEmit(u49)
                        if u28 and u30 == false then
                            u26(u4.PrimaryPart.CFrame, "Kick3")
                        end
                        u47({
                            ["Duration"] = 0.4,
                            ["Speed"] = 35
                        })
                    end
                end
            end)
            _G.destroy(u49, 5)
            if u30 == true then
                if u29 then
                    u29:Disconnect()
                    u22 = nil
                end
                return
            else
                _G.PlayEffect("DrillSwordCoating", nil, u4, true)
                task.wait(1.15)
                if u30 == true then
                    _G.PlayEffect("DrillSwordCoating", nil, u4, false)
                    if u29 then
                        u29:Disconnect()
                        u22 = nil
                    end
                else
                    task.delay(0.1, function() --[[ Line: 248 ]]
                        --[[
                        Upvalues:
                            [1] = u4
                        --]]
                        _G.PlaySound(u4.PrimaryPart, script.Stab).Parent = u4.PrimaryPart
                    end)
                    u47({
                        ["Duration"] = 1.2,
                        ["Speed"] = 0
                    })
                    v27.AutoRotate = false
                    local v50 = Instance.new("Model")
                    v50.Parent = workspace.Effects
                    local v51 = Instance.new("Highlight")
                    v51.Enabled = false
                    v51.Parent = v50
                    local v52 = u4.PrimaryPart.CFrame
                    local v53 = v52 * CFrame.new(0, 2, -10)
                    local v54 = v52.Position
                    local v55 = v53.Position - v52.Position
                    local v56 = v55.Magnitude
                    local v57 = v55.Unit
                    local v58 = workspace:Raycast(v54, v57 * v56, u3)
                    if v58 then
                        local v59 = v58.Normal
                        local v60 = v58.Position + v59 * 2
                        v53 = CFrame.new(v60)
                    end
                    local v61 = script.WaterBall:Clone()
                    v61.CFrame = v53
                    v61.Parent = workspace.Effects
                    if u28 then
                        u26(u4.PrimaryPart.CFrame, "WaterBubble")
                    end
                    local v62 = script.Bubble:Clone()
                    v62.CFrame = v61.CFrame
                    v62.Size = Vector3.new(30, 30, 30)
                    v62.Parent = v50
                    _G.tween(v62, {
                        0.25,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Size"] = Vector3.new(8, 8, 8),
                        ["Transparency"] = 1
                    })
                    _G.destroy(v50, 0.25)
                    _G.PlaySound(v61, script.Skill2Pull)
                    task.wait(0.7)
                    _G.particleEnabled(v61, false)
                    _G.destroy(v61, 1)
                    _G.PlayEffect("DrillCombo", nil, v61.CFrame)
                    task.wait(0.75)
                    _G.PlayEffect("DrillSwordCoating", nil, u4, false)
                    v27.AutoRotate = true
                end
            end
        end
    end
end
return v1