 

local u1 = game.Players.LocalPlayer
local u2 = game:GetService("RunService")
local u3 = game:GetService("ReplicatedStorage")
local u4 = require(game.ReplicatedStorage.Modules.Skills)
local u5 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
game:GetService("UserInputService")
u1:GetMouse()
local u6 = setmetatable({}, u5)
u6.__index = u6
function u6.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u1
    --]]
    local v7 = u5.new(script.Name)
    local v8 = u6
    local u9 = setmetatable(v7, v8)
    u9.Cooldowns = {
        ["transform"] = false,
        ["plamStrike"] = false,
        ["heavShock"] = false,
        ["risingFist"] = false,
        ["impactLeap"] = false,
        ["impactFloor"] = false,
        ["light"] = false,
        ["ult"] = false,
        ["spineBreaker"] = false,
        ["fullGrab"] = false
    }
    u9.InFormBool = false
    u9.fullFormMode = false
    local u10 = u1.Character
    u9.Anims = {
        ["Walk"] = u10.Humanoid.Animator:LoadAnimation(script.Walk),
        ["Idle"] = u10.Humanoid.Animator:LoadAnimation(script.Idle)
    }
    local u11 = u9.Anims.Idle
    local u12 = u9.Anims.Walk
    u11.Priority = Enum.AnimationPriority.Action
    u12.Priority = Enum.AnimationPriority.Action
    u12.KeyframeReached:Connect(function(p13) --[[ Line: 40 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u9
        --]]
        local v14 = u10.RightFoot
        if p13 == "buddhaStompLeft" then
            v14 = u10.LeftFoot
        end
        if _G.canuse ~= false and (_G.check:inspect(u10) ~= false and (_G.blocking ~= true and _G.instantDash ~= false)) then
            u9.Tool.stomp:FireServer(v14.CFrame)
        end
    end)
    u9.HeartbeatConnection = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 51 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u10
            [3] = u12
            [4] = u11
        --]]
        u9.fullFormMode = u10:GetAttribute("BeastType") == "Full"
        local v15 = u9.InFormBool
        local v16 = u9.fullFormMode
        if v15 == true and v16 == true then
            _G.toolLocked = u9.Tool
            local v17 = u10:FindFirstChildWhichIsA("Tool")
            if v17 and v17 ~= u9.Tool then
                task.defer(function() --[[ Line: 60 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                    --]]
                    u10.Humanoid:UnequipTools()
                end)
            end
        elseif _G.toolLocked == u9.Tool then
            _G.toolLocked = nil
        end
        if v16 == true and v15 == true then
            if u10.Humanoid.MoveDirection == Vector3.new() or u10.Humanoid.FloorMaterial == Enum.Material.Air then
                if u10.Humanoid.FloorMaterial == Enum.Material.Air then
                    if u12.IsPlaying == true then
                        u12:Stop()
                    end
                    if u11.IsPlaying == true then
                        u11:Stop()
                        return
                    end
                else
                    if u12.IsPlaying == true then
                        u12:Stop()
                    end
                    if u11.IsPlaying == false then
                        u11:Play()
                        return
                    end
                end
            else
                if u12.IsPlaying == false then
                    u12:Play()
                end
                if u11.IsPlaying == true then
                    u11:Stop()
                    return
                end
            end
        else
            if u12.IsPlaying == true then
                u12:Stop()
            end
            if u11.IsPlaying == true then
                u11:Stop()
            end
        end
    end)
    u10:GetAttributeChangedSignal("InForm"):Connect(function() --[[ Line: 104 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u10
        --]]
        u9.InFormBool = u10:GetAttribute("InForm")
    end)
    return u9
end
function u6.BuddhaTransformation(u18, p19) --[[ Line: 115 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
        [4] = u2
    --]]
    local v20 = u18.Cooldowns
    local u21 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if v20.transform == false and (_G.check:inspect(u21) == true and _G.StamCheck("Buddha Transformation") == true) then
        local v22 = u4.GetM("Buddha Transformation")
        local v23 = v22.cd
        if _G.StamCheck("Buddha Transformation") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        local v24
        if u21:GetAttribute("buddhaDamage") then
            local v25 = u21:GetAttribute("buddhaDamage")
            v24 = math.ceil(v25)
        else
            v24 = 0
        end
        if u21:FindFirstChild("Aura") == nil and v24 < require(game.ReplicatedStorage.Modules.Skills.Modes.Buddha)(u1) * 0.2 then
            _G.displayMessage("<Color=/>I need <Color=Yellow>20%<Color=/> Karma for half mode.")
            return
        end
        v20.transform = true
        _G.canuse = false
        local u26 = tick()
        local u27 = tick()
        u18:ChargeSkill(p19, {
            ["Key"] = Enum.KeyCode.T,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 158 ]]
                --[[
                Upvalues:
                    [1] = u27
                    [2] = u26
                --]]
                u27 = tick() - u26
                return u27 > 1
            end
        })
        local v28 = u27 > 1
        local v29 = true
        if v28 == true then
            if v24 < require(game.ReplicatedStorage.Modules.Skills.Modes.Buddha)(u1) * u18.Tool:GetAttribute("modePercent") then
                _G.displayMessage((("<Color=/>I need <Color=Yellow>%*%%<Color=/> Karma for full mode."):format(u18.Tool:GetAttribute("modePercent") * 100)))
                v29 = false
                v28 = false
            else
                local v30, _, _ = _G.getRayFloor(u21.PrimaryPart.CFrame, -75)
                if v30 then
                    _G.displayMessage("I cant transform here, ceiling is too low!")
                    v29 = false
                end
            end
        end
        if v29 == true then
            game.ReplicatedStorage.Events.Skill:InvokeServer("Buddha Transformation", { v28, u21.PrimaryPart.CFrame })
            if u21:GetAttribute("customM1") == "BuddhaHybird" then
                local u31 = u21.Humanoid:LoadAnimation(script.Half.Idle)
                local u32 = u21.Humanoid
                u18.BuddhaHybirdCNT = u2.Heartbeat:Connect(function() --[[ Line: 189 ]]
                    --[[
                    Upvalues:
                        [1] = u21
                        [2] = u18
                        [3] = u32
                        [4] = u31
                    --]]
                    if u21:GetAttribute("customM1") == "BuddhaHybird" or not u18.BuddhaHybirdCNT then
                        if u32.FloorMaterial == Enum.Material.Air or (u32.MoveDirection ~= Vector3.new() or _G.canuse ~= true) then
                            if u31.IsPlaying == true then
                                u31:Stop()
                            end
                        elseif u31.IsPlaying == false then
                            u31:Play()
                            return
                        end
                    else
                        u18.BuddhaHybirdCNT:Disconnect()
                        u18.BuddhaHybirdCNT = nil
                    end
                end)
            end
        end
        task.wait(0.5)
        _G.canuse = true
        _G.keysetup:cooldown("Buddha Transformation", v23)
        _G.fw(v23)
        v20.transform = false
    end
end
function u6.BuddhaESkill(u33, p34) --[[ Line: 216 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v35 = u33.Cooldowns
    local u36 = u1.Character
    local u37 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u36) == true then
        u33.InFormBool = u36:GetAttribute("InForm")
        local v38, v39
        if u33.InFormBool == true then
            v38 = "heavShock"
            v39 = "Heavenly Shockwave"
        else
            v38 = "plamStrike"
            v39 = "Palm Strike"
        end
        if v35[v38] == true then
            return
        end
        local v40 = u4.GetM(v39)
        local v41 = v40.cd
        if _G.StamCheck(v39) == false then
            return
        end
        if v40.statreq and _G.MeetReq(v40.statreq) == false then
            return
        end
        _G.canuse = false
        local v42 = game.ReplicatedStorage.Events.Skill:InvokeServer(v39, {
            ["cf"] = u33:GetMouseCFrame()
        })
        if v42 == nil then
            _G.canuse = true
            return
        end
        v35[v38] = true
        _G.canuse = false
        _G.FaceMouse = true
        local v43 = u36.Humanoid:LoadAnimation(script.Base.strike)
        v43:Play()
        v43:AdjustWeight(2)
        v43.Priority = Enum.AnimationPriority.Action4
        _G.PauseAnim(v43, 0.4, 1)
        local u44 = tick()
        u33:ChargeSkill(p34, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 274 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u33
                    [3] = u36
                    [4] = u37
                --]]
                if tick() - u44 >= 10 or (u33.Tool.Parent ~= u36 or (u36.Parent == nil or (u36.Parent ~= workspace.PlayerCharacters or u37.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u36.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        if v43 then
            v43:AdjustSpeed(1)
        end
        u36.Humanoid.AutoRotate = false
        u36.HumanoidRootPart.Anchored = true
        task.wait(0.1)
        if v42 then
            v42:FireServer(u36.HumanoidRootPart.CFrame)
        end
        task.wait(0.7)
        u36.Humanoid.AutoRotate = true
        u36.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown(v39, v41)
        _G.fw(v41)
        v35[v38] = false
    end
end
function u6.JudgementImpact(u45, p46) --[[ Line: 307 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v47 = u45.Cooldowns
    local u48 = u1.Character
    local u49 = u3["Stats" .. u1.Name]
    if u45.InFormBool == false and (v47.risingFist == false and (_G.check:inspect(u48) == true and _G.StamCheck("Judgement Impact") == true)) then
        local v50 = u4.GetM("Judgement Impact")
        local v51 = v50.cd
        if _G.StamCheck("Judgement Impact") == false then
            return
        end
        if v50.statreq and _G.MeetReq(v50.statreq) == false then
            return
        end
        _G.canuse = false
        v47.risingFist = true
        local v52 = game.ReplicatedStorage.Events.Skill:InvokeServer("Judgement Impact", {
            ["cf"] = u45:GetMouseCFrame()
        })
        local u53 = tick()
        u45:ChargeSkill(p46, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 332 ]]
                --[[
                Upvalues:
                    [1] = u48
                --]]
                u48.Humanoid.WalkSpeed = 50
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 336 ]]
                --[[
                Upvalues:
                    [1] = u53
                    [2] = u45
                    [3] = u48
                    [4] = u49
                --]]
                if tick() - u53 >= 1 or (u45.Tool.Parent ~= u48 or (u48.Parent == nil or (u48.Parent ~= workspace.PlayerCharacters or (u49.Stamina.Value <= 0 or _G.check:inspect(u48) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u48.Humanoid.WalkSpeed = 16
        if v52 then
            v52:FireServer(u48.HumanoidRootPart.CFrame)
        end
        task.wait(0.5)
        _G.canuse = true
        _G.keysetup:cooldown("Judgement Impact", v51)
        _G.fw(v51)
        v47.risingFist = false
    end
end
function u6.BuddhaRSkill(u54, p55) --[[ Line: 363 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v56 = u54.Cooldowns
    local u57 = u1.Character
    local u58 = u3["Stats" .. u1.Name]
    if u54.InFormBool == true then
        u54.InFormBool = u57:GetAttribute("InForm")
        local v59, v60
        if u54.fullFormMode == true then
            v59 = "impactFloor"
            v60 = "Heaven-sent Impact"
        else
            v59 = "impactLeap"
            v60 = "Heaven-sent Impact Leap"
        end
        if v56[v59] == true then
            return
        elseif _G.check:inspect(u57) == false then
            return
        else
            local v61 = u4.GetM(v60)
            local v62 = v61.cd
            if _G.StamCheck(v60) == false then
                return
            elseif v61.statreq and _G.MeetReq(v61.statreq) == false then
                return
            else
                _G.canuse = false
                local v63 = game.ReplicatedStorage.Events.Skill:InvokeServer(v60, {
                    ["cf"] = u54:GetMouseCFrame()
                })
                if v63 == nil then
                    _G.canuse = true
                else
                    v56[v59] = true
                    _G.canuse = false
                    _G.FaceMouse = true
                    local u64
                    if u54.fullFormMode == false then
                        u64 = u57.Humanoid:LoadAnimation(script.Half.leapCharge)
                        u64:Play()
                        u64.Priority = Enum.AnimationPriority.Action4
                    else
                        u64 = u57.Humanoid:LoadAnimation(script.Full.shockwave)
                        u64:Play()
                        u64.Priority = Enum.AnimationPriority.Action4
                        _G.mouseLevel = true
                        _G.PauseAnim(u64, 0.1, 1)
                    end
                    local u65 = tick()
                    u54:ChargeSkill(p55, {
                        ["Key"] = Enum.KeyCode.R,
                        ["EndFunction"] = function() --[[ Name: endFunction, Line 427 ]]
                            --[[
                            Upvalues:
                                [1] = u65
                                [2] = u54
                                [3] = u57
                                [4] = u58
                            --]]
                            if tick() - u65 >= 10 or (u54.Tool.Parent ~= u57 or (u57.Parent == nil or (u57.Parent ~= workspace.PlayerCharacters or u58.Stamina.Value <= 0))) then
                                return true
                            end
                        end
                    })
                    _G.FaceMouse = false
                    if v63 then
                        if u54.fullFormMode == false then
                            u64:Stop()
                            local u66 = false
                            local v67 = u57.Humanoid:LoadAnimation(script.Half.leapLoop)
                            v67:Play()
                            v67.Priority = Enum.AnimationPriority.Action4
                            task.delay(1, function() --[[ Line: 452 ]]
                                --[[
                                Upvalues:
                                    [1] = u66
                                    [2] = u64
                                --]]
                                if u66 == false then
                                    u64:AdjustSpeed(0)
                                end
                            end)
                            u57:SetAttribute("impactLeapLand", nil)
                            u57.PrimaryPart.Anchored = true
                            u57:PivotTo(CFrame.new(u57.PrimaryPart.Position, u54:GetMouseCFrame().Position))
                            v63:FireServer(u57.HumanoidRootPart.CFrame, u54:GetMouseCFrame())
                            u57.HumanoidRootPart.Anchored = false
                            repeat
                                task.wait()
                            until u57:GetAttribute("impactLeapLand") ~= nil
                            u66 = true
                            v67:Stop()
                            task.wait(0.9)
                            u57.HumanoidRootPart.Anchored = false
                        else
                            u64:AdjustSpeed(1)
                            _G.mouseLevel = nil
                            u57.PrimaryPart.Anchored = true
                            v63:FireServer(u57.HumanoidRootPart.CFrame, u54:GetMouseCFrame())
                            task.wait(2.1)
                            u57.PrimaryPart.Anchored = false
                        end
                    else
                        u64:AdjustSpeed(1)
                    end
                    _G.canuse = true
                    _G.keysetup:cooldown(v60, v62)
                    _G.fw(v62)
                    v56[v59] = false
                end
            end
        end
    else
        u54:JudgementImpact(p55)
        return
    end
end
function u6.Enlightenment(u68, p69) --[[ Line: 493 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v70 = u68.Cooldowns
    local u71 = u1.Character
    local u72 = u3["Stats" .. u1.Name]
    if u68.InFormBool == true and (v70.light == false and (_G.check:inspect(u71) == true and _G.StamCheck("Enlightenment") == true)) then
        local v73 = u4.GetM("Enlightenment")
        local v74 = v73.cd
        if _G.StamCheck("Enlightenment") == false then
            return
        end
        if v73.statreq and _G.MeetReq(v73.statreq) == false then
            return
        end
        local v75 = game.ReplicatedStorage.Events.Skill:InvokeServer("Enlightenment", {
            ["cf"] = u68:GetMouseCFrame()
        })
        _G.canuse = false
        v70.light = true
        _G.FaceMouse = true
        _G.mouseLevel = true
        local u76 = tick()
        u68:ChargeSkill(p69, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 520 ]]
                --[[
                Upvalues:
                    [1] = u76
                    [2] = u68
                    [3] = u71
                    [4] = u72
                --]]
                if tick() - u76 >= 3 or (u68.Tool.Parent ~= u71 or (u71.Parent == nil or (u71.Parent ~= workspace.PlayerCharacters or (u72.Stamina.Value <= 0 or _G.check:inspect(u71) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u71.Humanoid.WalkSpeed = 16
        _G.FaceMouse = false
        _G.mouseLevel = nil
        u71.PrimaryPart.Anchored = true
        if v75 then
            v75:FireServer(u71.HumanoidRootPart.CFrame)
        end
        task.wait(1)
        _G.canuse = true
        _G.keysetup:cooldown("Enlightenment", v74)
        _G.fw(v74)
        v70.light = false
    end
end
function u6.DivineRetribution(u77, p78) --[[ Line: 547 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v79 = u77.Cooldowns
    local u80 = u1.Character
    local u81 = u3["Stats" .. u1.Name]
    if v79.ult == false and (_G.check:inspect(u80) == true and _G.StamCheck("Divine Retribution") == true) then
        local v82 = u4.GetM("Divine Retribution")
        local v83 = v82.cd
        if u77.fullFormMode == false then
            _G.displayMessage("<Color=Red>I need to be in full form to use this.")
            return
        end
        if _G.StamCheck("Divine Retribution") == false then
            return
        end
        if v82.statreq and _G.MeetReq(v82.statreq) == false then
            return
        end
        _G.canuse = false
        v79.ult = true
        u80.PrimaryPart.Anchored = true
        local v84 = game.ReplicatedStorage.Events.Skill:InvokeServer("Divine Retribution", {
            ["cf"] = u77:GetMouseCFrame()
        })
        local u85 = tick()
        task.wait(1.26)
        _G.FaceMouse = true
        u80.PrimaryPart.Anchored = false
        u77:ChargeSkill(p78, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 579 ]]
                --[[
                Upvalues:
                    [1] = u85
                    [2] = u77
                    [3] = u80
                    [4] = u81
                --]]
                if tick() - u85 >= 10 or (u77.Tool.Parent ~= u80 or (u80.Parent == nil or (u80.Parent ~= workspace.PlayerCharacters or u81.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        _G.FaceMouse = false
        u80.PrimaryPart.Anchored = true
        u80.Humanoid.WalkSpeed = 16
        if v84 then
            v84:FireServer(u80.HumanoidRootPart.CFrame, u77:GetMouseCFrame())
        end
        task.wait(1.25)
        u80.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Divine Retribution", v83)
        _G.fw(v83)
        v79.ult = false
    end
end
function u6.BuddhaZSkill(u86, p87) --[[ Line: 614 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v88 = u86.Cooldowns
    local u89 = u1.Character
    local u90 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u89) == true then
        local v91, v92
        if u86.fullFormMode == true then
            v91 = "fullGrab"
            v92 = "Heaven Fall"
        else
            v91 = "spineBreaker"
            v92 = "Spine Breaker"
        end
        if v88[v91] == true then
            return
        end
        local v93 = u4.GetM(v92)
        local v94 = v93.cd
        if _G.StamCheck(v92) == false then
            return
        end
        if v93.statreq and _G.MeetReq(v93.statreq) == false then
            return
        end
        _G.canuse = false
        v88[v91] = true
        local v95
        if u86.fullFormMode == false then
            v95 = u89.Humanoid:LoadAnimation(script.grab)
            v95:Play()
            v95:AdjustWeight(2)
        else
            v95 = u89.Humanoid:LoadAnimation(script.grabFull)
            v95:Play()
            v95:AdjustWeight(2)
        end
        _G.canuse = false
        u89.Humanoid.WalkSpeed = 4
        local v96 = nil
        if u86.fullFormMode == false then
            _G.PauseAnim(v95, 0.1, 1.2)
        else
            v96 = game.ReplicatedStorage.Events.Skill:InvokeServer(v92, {
                ["cf"] = u89.HumanoidRootPart.CFrame
            })
            _G.PauseAnim(v95, 0.18, 1.2)
        end
        local u97 = tick()
        u86:ChargeSkill(p87, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 667 ]]
                --[[
                Upvalues:
                    [1] = u89
                --]]
                u89.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 671 ]]
                --[[
                Upvalues:
                    [1] = u97
                    [2] = u86
                    [3] = u89
                    [4] = u90
                --]]
                if tick() - u97 >= 10 or (u86.Tool.Parent ~= u89 or (u89.Parent == nil or (u89.Parent ~= workspace.PlayerCharacters or u90.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        if v96 then
            v96:FireServer(u89.PrimaryPart.CFrame)
            v95:AdjustSpeed(1)
        elseif u86.fullFormMode == false then
            v95:AdjustSpeed(1)
            game.ReplicatedStorage.Events.Skill:InvokeServer(v92, {
                ["cf"] = u89.HumanoidRootPart.CFrame
            })
        end
        u89.Humanoid.WalkSpeed = 16
        task.wait(0.36)
        _G.canuse = true
        _G.keysetup:cooldown(v92, v94)
        _G.fw(v94)
        v88[v91] = false
    end
end
u6.PalmStrike = u6.BuddhaESkill
u6.HeavenlyShockwave = u6.BuddhaESkill
u6["Heaven-sentImpactLeap"] = u6.BuddhaRSkill
u6["Heaven-sentImpact"] = u6.BuddhaRSkill
u6.SpineBreaker = u6.BuddhaZSkill
u6.HeavenFall = u6.BuddhaZSkill
return u6