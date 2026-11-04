 

local u1 = {}
u1.__index = u1
local u2 = game.Players.LocalPlayer
local u3 = game:GetService("UserInputService")
local u4 = u2.Character or u2.CharacterAdded:Wait()
local u5 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
game:GetService("ReplicatedStorage")
game.ReplicatedStorage:WaitForChild("CombatAnimations", 1)
local u6 = game:GetService("HttpService")
local u7 = game:GetService("RunService")
local _ = u4.Humanoid.Animator
local u8 = nil
local u9 = nil
local u10 = nil
local u11 = nil
local u12 = tick()
local u13 = 0
function u1.new(p14) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v15 = u1
    local v16 = setmetatable({}, v15)
    v16.Handler = p14
    v16.Utils = p14.Utils
    p14.PunchCooldown = false
    p14.PreCombo = 0
    p14.PunchCombo = 0
    p14.prehit = false
    p14.extendedcombo = 5
    p14.maxcombo = 3
    p14.precombotype = nil
    p14.lastpunch = nil
    p14.resetid = nil
    p14.preAnim = nil
    p14.precombo = 0
    return v16
end
function u1.stopM1Anims(_) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u4
    --]]
    if u11 ~= nil then
        warn("m1 anims stopping")
        local v17 = u4.Humanoid:GetPlayingAnimationTracks()
        for v18 = 1, #v17 do
            if v17[v18].Animation.AnimationId == u11.Animation.AnimationId then
                v17[v18].Priority = Enum.AnimationPriority.Action
                v17[v18]:Stop(0)
            end
        end
    end
end
local u19 = false
function u1.PC_Activate(p20) --[[ Line: 75 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u13
        [3] = u2
        [4] = u3
        [5] = u19
        [6] = u8
        [7] = u12
        [8] = u5
        [9] = u6
        [10] = u10
        [11] = u9
        [12] = u11
        [13] = u7
    --]]
    if _G.blocking == true and _G.mobile == true then
        _G.HoldingBlockKey = false
        while true do
            local v21 = u4:FindFirstChild("Blocking")
            if v21 then
                v21:Destroy()
            end
            task.wait()
            if _G.blocking == false then
                goto l2
            end
        end
    else
        ::l2::
        if _G.canM1 ~= false then
            if _G.blocking == false and (p20.Handler.PunchCooldown == false and (_G.canuse == true and _G.check:inspect(u4) == true)) then
                u13 = tick()
                local u22 = p20.Handler
                local v23 = u4:FindFirstChildWhichIsA("Tool")
                local v24 = false
                local v25 = u22.Utils.getAnimSpeed() or 1
                local u26 = "Ground"
                local v27 = false
                u22.PreCombo = u22.PunchCombo
                u22.PunchCombo = u22.PunchCombo + 1
                local v28 = 5
                local v29 = u4:GetAttribute("customM1Model")
                local v30 = u4:GetAttribute("customM1")
                local u31 = game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
                if _G.isFruitSupressed(u2) and (v23 and (u31 and v23.Name == u31.Stats.DF.Value)) then
                    v30 = nil
                    v29 = nil
                end
                local v32 = v30 and v30 == "LeopardHybird" and 4 or v28
                if v32 < u22.PunchCombo then
                    u22.PunchCombo = 1
                    u22.prehit = false
                end
                if u22.PunchCombo >= 3 and (u3:IsKeyDown(Enum.KeyCode.Space) == true or _G.mobileUpTilt == true) and u19 == true then
                    v24 = true
                    u26 = "Air"
                elseif u22.PunchCombo >= 3 and u22.prehit == true then
                    v24 = true
                    u26 = "Ground"
                end
                if u22.PunchCombo > 3 and v24 == false then
                    u22.PunchCombo = 1
                end
                if u22.PunchCombo > 3 then
                    v24 = true
                elseif u22.PunchCombo < 3 then
                    v24 = false
                end
                if u8 == "air" and u22.PunchCombo < 3 then
                    return
                end
                local u33 = _G.running == true and (u22.PunchCombo == 1 and v29 == nil) and true or v27
                u22.prehit = true
                u19 = false
                if v24 == true then
                    if u8 == "" then
                        u8 = u26
                    else
                        u26 = u8
                    end
                else
                    u26 = "Ground"
                    u8 = ""
                end
                u12 = tick()
                local u34, u35, v36 = p20.Utils.getAnimation(u26, u33, 3)
                if u34 == nil then
                    warn("punch anim is NIL")
                    return
                end
                p20.Handler.PunchCooldown = true
                _G.canuse = false
                local u37, u38, u39, v40 = u22.Utils.getHitBox()
                local v41 = not (u5[v23.Name] and u5[v23.Name].AnimationWeight) and 1.5 or u5[v23.Name].AnimationWeight
                local v42 = u5[v23.Name]
                local u43 = u6:GenerateGUID(true)
                u10 = u43
                u9 = tick()
                u34:Play()
                if u34.Length > 0 and v40 ~= "BuddhaMode" then
                    v25 = u34.Length / u39
                end
                if v42 == nil or v42 and v42.customM1AnimSpeed == nil then
                    u34:AdjustSpeed(v25)
                elseif v42 and v42.customM1AnimSpeed then
                    u34:AdjustSpeed(v42.customM1AnimSpeed)
                end
                if v29 == nil then
                    u34:AdjustWeight(v41)
                elseif v42 and v42.customM1AnimWeight then
                    u34:AdjustWeight(v42.customM1AnimWeight)
                else
                    u34:AdjustWeight(3)
                end
                u34.Priority = Enum.AnimationPriority.Action3
                if u4:GetAttribute("springMode") then
                    local v44 = u4:GetDescendants()
                    for v45 = 1, #v44 do
                        if v44[v45]:IsA("AnimationController") and v44[v45].Parent.Name:match("Spring") then
                            local v46 = v44[v45]:LoadAnimation(u34.Animation)
                            v46:Play()
                            v46:AdjustWeight(u34.WeightTarget)
                            v46:AdjustSpeed(u34.Speed)
                            v46.Priority = Enum.AnimationPriority.Action4
                        end
                    end
                elseif v40 == "DragonHybird" then
                    local v47 = u4:FindFirstChild("DragonTailController", true)
                    if v47 then
                        local v48 = v47:LoadAnimation(u34.Animation)
                        v48:Play()
                        v48:AdjustWeight(u34.WeightTarget)
                        v48:AdjustSpeed(u34.Speed)
                        v48.Priority = Enum.AnimationPriority.Action4
                    end
                end
                if u11 and (u34.Animation ~= u11.Animation and v29 == nil) then
                    local v49 = u4.Humanoid:GetPlayingAnimationTracks()
                    for v50 = 1, #v49 do
                        if v49[v50].Animation.AnimationId == u11.Animation.AnimationId then
                            v49[v50].Priority = Enum.AnimationPriority.Action
                            v49[v50]:Stop()
                        end
                    end
                    u11 = nil
                end
                u11 = u34
                local u51 = u4:FindFirstChildWhichIsA("Tool")
                local v52
                if u51 then
                    v52 = u4:FindFirstChild(u51.Name .. "Sword")
                else
                    v52 = nil
                end
                local v53
                if v52 then
                    v53 = v52:FindFirstChildWhichIsA("AnimationController")
                else
                    v53 = nil
                end
                if v52 and v53 then
                    local v54 = v53:LoadAnimation(v36)
                    v54:Play()
                    v54.Priority = Enum.AnimationPriority.Action2
                    v54:AdjustSpeed(v25)
                    v54:AdjustWeight(5)
                end
                local u55 = nil
                if u33 then
                    local v56 = Instance.new("BodyVelocity")
                    v56.MaxForce = Vector3.new(10000000, 0, 10000000)
                    v56.P = 500000
                    v56.Parent = u4.HumanoidRootPart
                    v56.Velocity = u4.HumanoidRootPart.CFrame.lookVector * 25
                    _G.destroy(v56, 0.25)
                end
                if u51.Name:match("Kraken Blade") or u51.Name:match("World Ender") ~= nil then
                    u55 = Instance.new("BodyVelocity")
                    u55.MaxForce = Vector3.new(1000000, 0, 1000000)
                    u55.P = 500000
                    u55.Parent = u4.HumanoidRootPart
                    u55.Velocity = u4.HumanoidRootPart.CFrame.lookVector * 10
                    _G.destroy(u55, 0.25)
                end
                local u57 = nil
                local u58 = false
                local function u60(p59) --[[ Line: 308 ]]
                    --[[
                    Upvalues:
                        [1] = u57
                        [2] = u55
                        [3] = u19
                        [4] = u35
                        [5] = u22
                        [6] = u26
                        [7] = u4
                    --]]
                    u57 = true
                    if u55 then
                        u55:Destroy()
                    end
                    u19 = true
                    game.ReplicatedStorage.Events.CombatRegister:InvokeServer({
                        "damage",
                        p59,
                        u35,
                        { u22.PunchCombo, u26, u35 },
                        true,
                        ["aircombo"] = u26,
                        u4.PrimaryPart.CFrame
                    })
                end
                local function u63() --[[ Line: 341 ]]
                    --[[
                    Upvalues:
                        [1] = u58
                        [2] = u55
                        [3] = u4
                        [4] = u34
                    --]]
                    u58 = true
                    if u55 then
                        u55.Velocity = Vector3.new()
                        u55:Destroy()
                    end
                    if u4:GetAttribute("customM1") == nil then
                        u34:Stop()
                        local v61 = u4.Humanoid:GetPlayingAnimationTracks()
                        for v62 = 1, #v61 do
                            if v61[v62].Animation.AnimationId == u34.Animation.AnimationId then
                                v61[v62]:Stop()
                            end
                        end
                    end
                    _G.midM1 = false
                    game.ReplicatedStorage.Events.CombatRegister:InvokeServer({ "cancelSwing" })
                end
                local u64 = _G.m1HitDelay
                local v65 = u4:GetAttribute("customM1")
                if _G.isFruitSupressed(u2) and (u51 and (u31 and u51.Name == u31.Stats.DF.Value)) then
                    v65 = nil
                end
                if v65 == nil or v65 and (v65 == "DragonHybird" or v65 == "BuddhaHybird") then
                    local v66 = u2:GetAttribute("Ping")
                    task.delay(u39 * u64 - v66, function() --[[ Line: 369 ]]
                        --[[
                        Upvalues:
                            [1] = u4
                            [2] = u63
                            [3] = u37
                            [4] = u39
                            [5] = u64
                            [6] = u38
                            [7] = u60
                        --]]
                        if _G.check:inspect(u4) == false then
                            u63()
                        else
                            _G.hitbox:start(u4, u37, u39 * (1 - u64), u38, u60, u63, nil, nil, true, function() --[[ Line: 377 ]]
                                --[[
                                Upvalues:
                                    [1] = u63
                                --]]
                                if _G.blocking == true then
                                    u63()
                                    return true
                                end
                            end, true)
                        end
                    end)
                end
                task.spawn(function() --[[ Line: 386 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                        [2] = u22
                        [3] = u26
                        [4] = u33
                        [5] = u34
                    --]]
                    game.ReplicatedStorage.Events.CombatRegister:InvokeServer({
                        "swingsfx",
                        u35,
                        u22.PunchCombo,
                        u26,
                        u33,
                        u34.Animation,
                        u34.Speed,
                        u34.WeightTarget,
                        faceCFrame
                    })
                end)
                task.spawn(function() --[[ Line: 390 ]]
                    --[[
                    Upvalues:
                        [1] = u51
                        [2] = u2
                        [3] = u31
                        [4] = u4
                        [5] = u22
                        [6] = u26
                        [7] = u33
                    --]]
                    local v67 = u51.Name
                    local v68 = _G.isFruitSupressed(u2) and (u31 and u51.Name == u31.Stats.DF.Value) and "Melee" or v67
                    _G.PlayEffect("CustomSwing", nil, {
                        u4,
                        u22.PunchCombo,
                        v68,
                        u26,
                        u33
                    })
                    local _ = u4.PrimaryPart.CFrame
                    local u69 = require(u2.PlayerScripts.PlayerModule)
                    local u70 = false
                    pcall(function() --[[ Line: 65 ]]
                        --[[
                        Upvalues:
                            [1] = u70
                            [2] = u69
                        --]]
                        u70 = u69.cameras.CameraModule.activeMouseLockController:GetIsMouseLocked()
                    end)
                    if u70 == true then
                        CFrame.new(u4.PrimaryPart.Position, (workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -1000)).Position)
                        if u4.Humanoid.FloorMaterial ~= Enum.Material.Air and _G.MouseCF.Position.Y < u4.PrimaryPart.Position.Y then
                            local v71, v72, _ = _G.getRayFloor(u4.PrimaryPart.CFrame, u4.PrimaryPart.Size.Y / 2 + u4.Humanoid.HipHeight)
                            local v73 = true
                            if v71 then
                                local v74 = _G.MouseCF.Y - v72.Y
                                if math.abs(v74) > 1 then
                                    v73 = false
                                end
                            end
                            if v73 == true then
                                local _ = u4.PrimaryPart.CFrame
                            end
                        end
                    end
                end)
                _G.canJump = false
                u4.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
                _G.midM1 = true
                local v75 = u26 .. u22.PunchCombo
                if u22.PunchCombo < 4 then
                    v75 = "Ground" .. u22.PunchCombo
                end
                if v42 and v42.endlagAnimTimes then
                    local v76 = v42.endlagAnimTimes[v75]
                    local _ = u22.PunchCombo
                    if v76 then
                        local v77 = u34.Speed
                        task.delay(v76 / v77, function() --[[ Line: 444 ]]
                            --[[
                            Upvalues:
                                [1] = u10
                                [2] = u43
                                [3] = u4
                                [4] = u34
                                [5] = u7
                                [6] = u26
                                [7] = u51
                            --]]
                            if u10 == u43 then
                                local u78 = u4.Humanoid
                                local u79 = nil
                                u79 = u7.Heartbeat:Connect(function() --[[ Line: 460 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u26
                                        [2] = u78
                                        [3] = u51
                                        [4] = u4
                                        [5] = u79
                                        [6] = u34
                                        [7] = u10
                                        [8] = u43
                                    --]]
                                    if (u26 == "Air" or u78.FloorMaterial ~= Enum.Material.Air) and (u78.MoveDirection == Vector3.new() and (not u51 or u51.Parent == u4) and _G.check:inspect(u4) ~= false) then
                                        if u10 ~= u43 then
                                            u79:Disconnect()
                                            u79 = nil
                                            u34:AdjustWeight(0, 0.35)
                                            task.delay(0.35, function() --[[ Line: 454 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u34
                                                --]]
                                                u34:Stop()
                                            end)
                                        end
                                    else
                                        u79:Disconnect()
                                        u79 = nil
                                        u34:AdjustWeight(0, 0.35)
                                        task.delay(0.35, function() --[[ Line: 454 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u34
                                            --]]
                                            u34:Stop()
                                        end)
                                        return
                                    end
                                end)
                                u34:AdjustWeight(0, 1)
                            end
                        end)
                    end
                end
                task.wait(u39)
                _G.midM1 = false
                if v32 <= u22.PunchCombo then
                    task.wait(0.15)
                end
                _G.canuse = true
                _G.instantDash = false
                task.delay(0.5, function() --[[ Line: 488 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u43
                    --]]
                    if u10 == u43 then
                        _G.instantDash = true
                    end
                end)
                task.delay(0.25, function() --[[ Line: 494 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u43
                        [3] = u4
                    --]]
                    if u10 == u43 then
                        u4.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                    end
                end)
                if v32 <= u22.PunchCombo then
                    u8 = ""
                    if u4:FindFirstChild("VenomDemonModel") then
                        task.wait(2)
                    end
                    task.wait(1.5)
                elseif u22.PunchCombo >= 3 and v24 == false then
                    task.wait(0.65)
                end
                if u10 == u43 then
                    p20.Handler.PunchCooldown = false
                end
                task.delay(1 + u39, function() --[[ Line: 514 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u43
                        [3] = u9
                        [4] = u22
                        [5] = u11
                    --]]
                    if u10 == u43 and tick() - u9 >= 1 then
                        u22.PunchCombo = 0
                        u11 = nil
                    end
                end)
            end
        end
    end
end
function u1.ResetM1(p80) --[[ Line: 525 ]]
    p80.Handler.resetid = ""
    p80.Handler.PunchCooldown = false
end
function u1.M1Endlag(p81) --[[ Line: 530 ]]
    script.M1EndLag:Play()
    p81.Handler.PunchCooldown = true
    task.wait(1.5)
    p81.Handler.PunchCooldown = false
end
u1.Mobile_Activate = u1.PC_Activate
return u1