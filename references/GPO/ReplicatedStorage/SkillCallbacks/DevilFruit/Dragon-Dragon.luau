 

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
        [4] = u2
    --]]
    local v7 = u5.new(script.Name)
    local v8 = u6
    local v9 = setmetatable(v7, v8)
    v9.Cooldowns = {
        ["Hellfire Ring"] = false
    }
    local u10 = u1.Character
    function v9.PlayAnim(_, p11, p12, u13) --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u2
        --]]
        local u14 = u10.Humanoid:LoadAnimation(p11)
        local v15 = u10:FindFirstChild("DragonTailController", true)
        local u16
        if v15 == nil then
            u16 = nil
        else
            u16 = v15:LoadAnimation(p11)
        end
        u14:Play()
        local u17 = nil
        if u16 then
            u16:Play()
            if p12 == nil then
                local u18 = u2.Heartbeat:Connect(function() --[[ Line: 45 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u16
                        [3] = u13
                        [4] = u17
                    --]]
                    if u14.IsPlaying == true and u16.IsPlaying == false then
                        u16:Play()
                        u16.TimePosition = u14.TimePosition
                    elseif u14.IsPlaying == false and u16.IsPlaying == true then
                        u16:Stop()
                        if u13 == nil and u17 then
                            u17:Disconnect()
                            u17 = nil
                        end
                        return
                    end
                    u16.TimePosition = u14.TimePosition
                    u16:AdjustSpeed(u14.Speed)
                end)
                u14.Stopped:Connect(function() --[[ Line: 65 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                        [2] = u13
                        [3] = u18
                    --]]
                    u16:Stop()
                    if u13 == nil and u18 then
                        u18:Disconnect()
                        u18 = nil
                    end
                end)
                if u13 == nil then
                    task.delay(15, function() --[[ Line: 76 ]]
                        --[[
                        Upvalues:
                            [1] = u18
                        --]]
                        if u18 then
                            u18:Disconnect()
                            u18 = nil
                        end
                    end)
                    u17 = u18
                else
                    u17 = u18
                end
            end
            u14.Destroying:Connect(function() --[[ Line: 85 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u16
                --]]
                if u17 then
                    u17:Disconnect()
                    u17 = nil
                end
                u16:Stop()
                u16:Destroy()
            end)
        end
        return u14
    end
    return v9
end
function u6.HellfireRing(p19, _) --[[ Line: 101 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v20 = p19.Cooldowns
    local v21 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v21) == true then
        if v20["Hellfire Ring"] == true then
            return
        end
        local v22 = u4.GetM("Hellfire Ring")
        local v23 = v22.cd
        if _G.StamCheck("Hellfire Ring") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        _G.canuse = false
        v20["Hellfire Ring"] = true
        v21.Humanoid.WalkSpeed = 4
        game.ReplicatedStorage.Events.Skill:InvokeServer("Hellfire Ring", {
            ["cf"] = p19:GetMouseCFrame()
        })
        v21.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Hellfire Ring", v23)
        _G.fw(v23)
        v20["Hellfire Ring"] = false
    end
end
function u6.DraconicWarcry(p24, _) --[[ Line: 136 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v25 = p24.Cooldowns
    local v26 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v26) == true then
        if v25["Draconic Warcry"] == true then
            return
        end
        local v27 = u4.GetM("Draconic Warcry")
        local v28 = v27.cd
        if _G.StamCheck("Draconic Warcry") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        _G.canuse = false
        v25["Draconic Warcry"] = true
        v26.Humanoid.WalkSpeed = 4
        game.ReplicatedStorage.Events.Skill:InvokeServer("Draconic Warcry", v26.PrimaryPart.CFrame)
        v26.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Draconic Warcry", v28)
        _G.fw(v28)
        v25["Draconic Warcry"] = false
    end
end
function u6.DraconicCataclysm(p29, _) --[[ Line: 171 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v30 = p29.Cooldowns
    local v31 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v31) == true then
        if v30["Draconic Cataclysm"] == true then
            return
        end
        local v32 = u4.GetM("Draconic Cataclysm")
        local v33 = v32.cd
        if _G.StamCheck("Draconic Cataclysm") == false then
            return
        end
        if v32.statreq and _G.MeetReq(v32.statreq) == false then
            return
        end
        v30["Draconic Cataclysm"] = true
        v31.Humanoid.WalkSpeed = 4
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Draconic Cataclysm")
        v31.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Draconic Cataclysm", v33)
        _G.fw(v33)
        v30["Draconic Cataclysm"] = false
    end
end
function u6.DraconicThunderfall(u34, p35) --[[ Line: 206 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v36 = u34.Cooldowns
    local u37 = u1.Character
    local u38 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u37) == true then
        if v36["Draconic Thunderfall"] == true then
            return
        end
        local v39 = u4.GetM("Draconic Thunderfall")
        local v40 = v39.cd
        if _G.StamCheck("Draconic Thunderfall") == false then
            return
        end
        if v39.statreq and _G.MeetReq(v39.statreq) == false then
            return
        end
        _G.canuse = false
        v36["Draconic Thunderfall"] = true
        u37.Humanoid.WalkSpeed = 4
        local v41 = game.ReplicatedStorage.Events.Skill:InvokeServer("Draconic Thunderfall")
        local u42 = u34:PlayAnim(script.thunderFall)
        task.spawn(function() --[[ Line: 238 ]]
            --[[
            Upvalues:
                [1] = u42
            --]]
            _G.PauseAnim(u42, 0.4, 2)
        end)
        local u43 = _G.castingSkill(u37, 0.2, true)
        local u44 = tick()
        u34:ChargeSkill(p35, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 246 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u43
                    [3] = u44
                    [4] = u34
                    [5] = u38
                --]]
                u37.Humanoid.WalkSpeed = 4
                if u43 == false then
                    return true
                end
                if tick() - u44 >= 1.5 or (u34.Tool.Parent ~= u37 or (u37.Parent == nil or (u37.Parent ~= workspace.PlayerCharacters or u38.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if u43 == true then
            u42:AdjustSpeed(1)
        else
            u42:Stop()
        end
        if v41 then
            v41:FireServer(u43)
        end
        task.wait(1.3)
        u37.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Draconic Thunderfall", v40)
        _G.fw(v40)
        v36["Draconic Thunderfall"] = false
    end
end
function u6.HellfireRay(u45, p46) --[[ Line: 282 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v47 = u45.Cooldowns
    local u48 = u1.Character
    local u49 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u48) == true then
        if v47["Hellfire Ray"] == true then
            return
        end
        local v50 = u4.GetM("Hellfire Ray")
        local v51 = v50.cd
        if _G.StamCheck("Hellfire Ray") == false then
            return
        end
        if v50.statreq and _G.MeetReq(v50.statreq) == false then
            return
        end
        _G.FaceMouse = true
        v47["Hellfire Ray"] = true
        local u52 = tick()
        local v53 = game.ReplicatedStorage.Events.Skill:InvokeServer("Hellfire Ray")
        u45:ChargeSkill(p46, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 314 ]]
                --[[
                Upvalues:
                    [1] = u52
                    [2] = u45
                    [3] = u48
                    [4] = u49
                --]]
                if tick() - u52 >= 4 or (u45.Tool.Parent ~= u48 or (_G.check:inspect(u48) == false or (u48.Parent == nil or (u48.Parent ~= workspace.PlayerCharacters or (u49.Stamina.Value <= 0 or u48:FindFirstChild("PB")))))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if v53 == nil then
            _G.FaceMouse = false
        else
            v53:FireServer("release")
            _G.FaceMouse = false
            u48.PrimaryPart.Anchored = true
            task.wait(0.75)
            u48.PrimaryPart.Anchored = false
        end
        _G.canuse = true
        _G.keysetup:cooldown("Hellfire Ray", v51)
        _G.fw(v51)
        v47["Hellfire Ray"] = false
    end
end
function u6.ThunderclawRush(p54, _) --[[ Line: 344 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v55 = p54.Cooldowns
    local v56 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v56) == true then
        if v55["Thunderclaw Rush"] == true then
            return
        end
        local v57 = u4.GetM("Thunderclaw Rush")
        local v58 = v57.cd
        if _G.StamCheck("Thunderclaw Rush") == false then
            return
        end
        if v57.statreq and _G.MeetReq(v57.statreq) == false then
            return
        end
        _G.canuse = false
        v55["Thunderclaw Rush"] = true
        v56.Humanoid.WalkSpeed = 4
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Thunderclaw Rush")
        v56.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Thunderclaw Rush", v58)
        _G.fw(v58)
        v55["Thunderclaw Rush"] = false
    end
end
function u6.DraconicAscension(u59, p60) --[[ Line: 381 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
        [4] = u2
    --]]
    local v61 = u59.Cooldowns
    local u62 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(u62) == true then
        if v61["Draconic Ascension"] == true then
            return
        end
        local v63 = u4.GetM("Draconic Ascension")
        local v64 = v63.cd
        if _G.StamCheck("Draconic Ascension") == false then
            return
        end
        if v63.statreq and _G.MeetReq(v63.statreq) == false then
            return
        end
        local v65 = u62:GetAttribute("BeastType")
        local v66 = u59.Tool:GetAttribute("halfModePercent")
        local v67 = u59.Tool:GetAttribute("modePercent")
        local v68 = require(game.ReplicatedStorage.Modules.Skills.Modes.Dragon)(u1)
        local v69 = true
        local v70
        if u62:GetAttribute("dragonDamage") then
            local v71 = u62:GetAttribute("dragonDamage")
            v70 = math.ceil(v71)
        else
            v70 = 0
        end
        v61["Draconic Ascension"] = true
        _G.canuse = false
        local v72
        if v65 == "Human" or v65 == "Hybird" then
            local u73 = tick()
            local u74 = tick()
            u59:ChargeSkill(p60, {
                ["Key"] = Enum.KeyCode.T,
                ["IgnoreInstantCastSetting"] = true,
                ["EndFunction"] = function() --[[ Name: EndFunction, Line 425 ]]
                    --[[
                    Upvalues:
                        [1] = u74
                        [2] = u73
                    --]]
                    u74 = tick() - u73
                    return u74 > 0.25
                end
            })
            v72 = u74 > 0.25 == true and "Full" or (v65 == "Human" and "Hybird" or "Human")
        elseif v65 == "Full" then
            local u75 = tick()
            local u76 = tick()
            u59:ChargeSkill(p60, {
                ["Key"] = Enum.KeyCode.T,
                ["IgnoreInstantCastSetting"] = true,
                ["EndFunction"] = function() --[[ Name: EndFunction, Line 448 ]]
                    --[[
                    Upvalues:
                        [1] = u76
                        [2] = u75
                    --]]
                    u76 = tick() - u75
                    return u76 > 0.25
                end
            })
            v72 = u76 > 0.25 == true and "Hybird" or "Human"
        else
            v72 = "Human"
        end
        if v72 == "Hybird" then
            if v70 < v68 * v66 then
                _G.displayMessage((("<Color=/>I need <Color=Orange>%*%%<Color=/> Rage for Hybrid mode."):format(v66 * 100)))
                v69 = false
            end
        elseif v72 == "Full" and v70 < v68 * v67 then
            _G.displayMessage((("<Color=/>I need <Color=Orange>%*%%<Color=/> Rage for Full mode."):format(v67 * 100)))
            v69 = false
        end
        if v69 == false then
            script.DragonNotCharged:Play()
            _G.canuse = true
            _G.keysetup:cooldown("Draconic Ascension", v64)
            _G.fw(v64)
            v61["Draconic Ascension"] = false
            return
        end
        local function u77() --[[ Line: 485 ]]
            --[[
            Upvalues:
                [1] = u59
                [2] = u62
            --]]
            if u59.hybirdIdle then
                u59.hybirdIdle:Disconnect()
            end
            u62:SetAttribute("CustomRunSpeed", nil)
            u59.Tool:SetAttribute("customRun", nil)
            if u59.hybirdIdleAnim then
                task.delay(0.1, function() --[[ Line: 494 ]]
                    --[[
                    Upvalues:
                        [1] = u59
                    --]]
                    if u59.hybirdIdleAnim then
                        u59.hybirdIdleAnim:Stop()
                        u59.hybirdIdleAnim:Destroy()
                        u59.hybirdIdleAnim = nil
                    end
                    if u59.hybirdRunAnim then
                        u59.hybirdRunAnim:Stop()
                        u59.hybirdRunAnim:Destroy()
                        u59.hybirdRunAnim = nil
                    end
                end)
            end
        end
        u77()
        if v72 == "Hybird" and v69 == true then
            _G.toolLocked = u59.Tool
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Draconic Ascension", v72)
        local u78 = u62.Humanoid
        _G.toolLocked = nil
        if v72 == "Hybird" and u62:GetAttribute("BeastType") == "Hybird" then
            u59.hybirdIdle = u2.Heartbeat:Connect(function() --[[ Line: 522 ]]
                --[[
                Upvalues:
                    [1] = u62
                    [2] = u59
                    [3] = u78
                    [4] = u77
                --]]
                if u62:GetAttribute("BeastType") == "Hybird" then
                    if u59.hybirdIdleAnim == nil then
                        u59.hybirdIdleAnim = u59:PlayAnim(script.hybirdIdle, true, true)
                    end
                    if u59.hybirdRunAnim == nil then
                        u59.hybirdRunAnim = u59:PlayAnim(script.hybirdRun, nil, true)
                        u59.hybirdRunAnim.KeyframeReached:Connect(function(p79) --[[ Line: 532 ]]
                            --[[
                            Upvalues:
                                [1] = u62
                            --]]
                            if u62.PrimaryPart.Anchored ~= true then
                                if p79:match("step") and (p79 ~= "step" and _G.footstep) then
                                    _G.footstep(p79)
                                end
                            end
                        end)
                    end
                    u59.Tool:SetAttribute("customRun", true)
                    u62:SetAttribute("CustomRunSpeed", 35)
                    local v80 = u59.hybirdIdleAnim
                    local v81 = u59.hybirdRunAnim
                    local v82 = _G.check:inspect(u62) == false
                    local v83 = u78.FloorMaterial ~= Enum.Material.Air
                    if u59.Tool.Parent == u62 == false then
                        if v80.IsPlaying == true then
                            v80:Stop()
                        end
                        if v81.IsPlaying == true then
                            v81:Stop()
                        end
                        return
                    end
                    if u78.MoveDirection == Vector3.new() and (v83 and v82 == false) then
                        if v80.IsPlaying == false then
                            v80:Play()
                        end
                        if v81.IsPlaying == true then
                            v81:Stop()
                            return
                        end
                    elseif u78.MoveDirection == Vector3.new() or (not v83 or v82 ~= false) then
                        if v80.IsPlaying == true then
                            v80:Stop()
                        end
                        if v81.IsPlaying == true then
                            v81:Stop()
                            return
                        end
                    else
                        if v80.IsPlaying == true then
                            v80:Stop()
                        end
                        if u78.WalkSpeed >= 25 then
                            if v81.IsPlaying == false then
                                v81:Play()
                                v81:AdjustSpeed(1.5)
                                return
                            end
                        elseif v81.IsPlaying == true then
                            v81:Stop()
                            return
                        end
                    end
                else
                    u77()
                end
            end)
        elseif u62:GetAttribute("BeastType") == "Full" then
            _G.toolLocked = u59.Tool
            local u84 = nil
            u84 = u62:GetAttributeChangedSignal("BeastType"):Connect(function() --[[ Line: 602 ]]
                --[[
                Upvalues:
                    [1] = u62
                    [2] = u84
                --]]
                if u62:GetAttribute("BeastType") ~= "Full" then
                    _G.toolLocked = nil
                    u84:Disconnect()
                    u84 = nil
                end
            end)
        end
        task.wait(0.5)
        _G.canuse = true
        _G.keysetup:cooldown("Draconic Ascension", v64)
        _G.fw(v64)
        v61["Draconic Ascension"] = false
    end
end
function u6.HellfireBlastBreath(p85, _) --[[ Line: 619 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v86 = p85.Cooldowns
    local v87 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v87) == true then
        if v86["Hellfire Blast Breath"] == true then
            return
        end
        local v88 = u4.GetM("Hellfire Blast Breath")
        local v89 = v88.cd
        if _G.StamCheck("Hellfire Blast Breath") == false then
            return
        end
        if v88.statreq and _G.MeetReq(v88.statreq) == false then
            return
        end
        v86["Hellfire Blast Breath"] = true
        _G.FaceMouse = true
        local v90 = game.ReplicatedStorage.Events.Skill:InvokeServer("Hellfire Blast Breath", p85:GetMouseCFrame().Position)
        if v90 then
            repeat
                v90:FireServer(p85:GetMouseCFrame().Position)
                task.wait()
            until v90:IsDescendantOf(game) == false or v90:GetAttribute("GoalPosition") ~= nil
            v87.PrimaryPart.Anchored = true
            _G.moveFaceMouse = nil
            task.wait(1)
            v87.PrimaryPart.Anchored = false
        end
        _G.FaceMouse = false
        _G.canuse = true
        _G.keysetup:cooldown("Hellfire Blast Breath", v89)
        _G.fw(v89)
        v86["Hellfire Blast Breath"] = false
    end
end
function u6.DraconicTailSlam(u91, p92) --[[ Line: 668 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v93 = u91.Cooldowns
    local u94 = u1.Character
    local u95 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u94) == true then
        if v93["Draconic Tail Slam"] == true then
            return
        end
        local v96 = u4.GetM("Draconic Tail Slam")
        local v97 = v96.cd
        if _G.StamCheck("Draconic Tail Slam") == false then
            return
        end
        if v96.statreq and _G.MeetReq(v96.statreq) == false then
            return
        end
        _G.FaceMouse = true
        _G.MouseLevel = true
        v93["Draconic Tail Slam"] = true
        local u98 = tick()
        local v99 = u91:PlayAnim(script.TailSlam.leapCharge)
        local u100 = false
        local v101 = game.ReplicatedStorage.Events.Skill:InvokeServer("Draconic Tail Slam")
        local function v102() --[[ Line: 703 ]]
            --[[
            Upvalues:
                [1] = u98
                [2] = u91
                [3] = u94
                [4] = u95
                [5] = u100
            --]]
            if tick() - u98 >= 3 or (u91.Tool.Parent ~= u94 or (u94.Parent == nil or (u94.Parent ~= workspace.PlayerCharacters or u95.Stamina.Value <= 0))) then
                return true
            end
            if _G.check:inspect(u94) == false then
                u100 = true
                return true
            end
        end
        u91:ChargeSkill(p92, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = v102,
            ["HoldDuration"] = 0.1
        })
        v99:Stop()
        local v103 = u91:PlayAnim(script.TailSlam.leap)
        _G.MouseLevel = nil
        _G.FaceMouse = false
        local v104 = u91:GetMouseCFrame()
        local v105 = Instance.new("BodyVelocity")
        v105.MaxForce = Vector3.new(inf, inf, inf)
        v105.Velocity = Vector3.new()
        v105.Parent = u94.PrimaryPart
        if u100 == false then
            if v101 then
                v101:FireServer("Jump", u94.PrimaryPart.CFrame, {
                    ["goalCFrame"] = v104
                })
            end
        elseif v101 then
            v101:FireServer("cancel")
        end
        task.wait(0.1)
        local v106 = u91:PlayAnim(script.TailSlam.leapLoop)
        if v101 == nil or u100 ~= false then
            if v106 then
                v106:Stop()
            end
            v105:Destroy()
        else
            local v107 = os.clock()
            repeat
                task.wait()
            until v101:GetAttribute("clientSmashed") or os.clock() - v107 > 5
            if v101:GetAttribute("clientSmashed") then
                if v106 then
                    v106:Stop()
                end
                u91:PlayAnim(script.TailSlam.leapSlam)
                task.wait(0.3)
                v105:Destroy()
                u94.Humanoid.AutoRotate = true
                u94.PrimaryPart.Anchored = false
            else
                warn("TIMEOUT: DraconicTailSlam clientSmashed yield expired")
                v106:Stop()
                v103:Stop()
                if v105 and v105.Parent then
                    v105:Destroy()
                end
                u94.Humanoid.AutoRotate = true
                if u94.PrimaryPart then
                    u94.PrimaryPart.Anchored = false
                end
                v93["Draconic Tail Slam"] = false
            end
        end
        _G.canuse = true
        _G.keysetup:cooldown("Draconic Tail Slam", v97)
        _G.fw(v97)
        v93["Draconic Tail Slam"] = false
    end
end
function u6.DraconicCyclone(u108, p109) --[[ Line: 786 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
        [4] = u2
    --]]
    local v110 = u108.Cooldowns
    local u111 = u1.Character
    local u112 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u111) == true then
        if v110["Draconic Cyclone"] == true then
            return
        end
        local v113 = u4.GetM("Draconic Cyclone")
        local v114 = v113.cd
        if _G.StamCheck("Draconic Cyclone") == false then
            return
        end
        if v113.statreq and _G.MeetReq(v113.statreq) == false then
            return
        end
        v110["Draconic Cyclone"] = true
        local u115 = tick()
        local u116 = u111.PrimaryPart
        local u117 = u116.Position
        local u118 = 0
        local u119 = 0
        _G.canuse = false
        local v120 = game.ReplicatedStorage.Events.Skill:InvokeServer("Draconic Cyclone", u117)
        local v121 = Instance.new("Part")
        v121.Position = u117
        v121.Anchored = true
        v121.CanCollide = false
        v121.Transparency = 1
        v121.CanQuery = false
        v121.Parent = workspace.Effects
        workspace.CurrentCamera.CameraSubject = v121
        u111:SetAttribute("DragonFaceRoot", true)
        local u122 = RaycastParams.new()
        u122.FilterType = Enum.RaycastFilterType.Include
        u122.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
        local u123 = u117
        local v142 = u2.Heartbeat:Connect(function(p124) --[[ Line: 851 ]]
            --[[
            Upvalues:
                [1] = u119
                [2] = u118
                [3] = u117
                [4] = u123
                [5] = u122
                [6] = u116
            --]]
            u119 = u119 + p124
            local v125 = u119 / 1
            u118 = 1 - (1 - math.min(1, v125)) ^ 3
            local v126 = Vector3.new(0, 1, 0) * math.noise(u119 * 2) * 15
            local v127 = (50 + math.noise(u119) * 25) * u118
            local v128 = u119 * 2 * 3.141592653589793 / 1 * 2
            local v129 = math.sin(v128)
            local v130 = -math.cos(v128)
            local v131 = u117 + Vector3.new(v129, 0, v130) * v127 + v126
            local v132 = v131 - u123
            if v132.Magnitude > 0.01 then
                local v133 = workspace:Spherecast(u123, 5, v132, u122)
                if v133 then
                    local v134 = v133.Distance - 0.1
                    local v135 = math.max(0, v134)
                    v131 = u123 + v132.Unit * v135 + v133.Normal * 5
                end
            end
            local v136 = v131 - u117
            local v137 = v136.Magnitude
            if v137 > 0.01 then
                local v138 = workspace:Raycast(u117, v136.Unit * (v137 + 5), u122)
                if v138 then
                    local v139 = (v138.Position - u117).Magnitude
                    if v139 < v137 + 5 then
                        local v140 = v139 - 5
                        local v141 = math.max(0, v140)
                        v131 = u117 + v136.Unit * v141 + v138.Normal * 5
                    end
                end
            end
            u123 = v131
            u116.CFrame = CFrame.new(v131) * CFrame.Angles(0, -v128 - 1.5707963267948966, 0)
        end)
        u108:ChargeSkill(p109, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 897 ]]
                --[[
                Upvalues:
                    [1] = u115
                    [2] = u108
                    [3] = u111
                    [4] = u112
                --]]
                if tick() - u115 >= 6 or (u108.Tool.Parent ~= u111 or (u111.Parent == nil or (u111.Parent ~= workspace.PlayerCharacters or u112.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.5,
            ["IgnoreInstantCastSetting"] = true
        })
        _G.canuse = true
        v142:Disconnect()
        u111:SetAttribute("DragonFaceRoot", nil)
        if v120 ~= nil then
            v120:FireServer("release")
        end
        workspace.CurrentCamera.CameraSubject = u111.Humanoid
        v121:Destroy()
        _G.canuse = true
        _G.keysetup:cooldown("Draconic Cyclone", v114)
        _G.fw(v114)
        v110["Draconic Cyclone"] = false
    end
end
function u6.HellfireMode(p143, _) --[[ Line: 929 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v144 = p143.Cooldowns
    local v145 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v145) == true then
        if v144["Hellfire Mode"] == true then
            return
        end
        local v146 = u4.GetM("Hellfire Mode")
        local v147 = v146.cd
        if _G.StamCheck("Hellfire Mode") == false then
            return
        end
        if v146.statreq and _G.MeetReq(v146.statreq) == false then
            return
        end
        v144["Hellfire Mode"] = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Hellfire Mode", p143:GetMouseCFrame().Position)
        _G.keysetup:cooldown("Hellfire Mode", v147)
        _G.fw(v147)
        v144["Hellfire Mode"] = false
    end
end
function u6.DraconicTempestSpiral(p148, _) --[[ Line: 962 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v149 = p148.Cooldowns
    local v150 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v150) == true then
        if v149["Draconic Tempest Spiral"] == true then
            return
        end
        local v151 = u4.GetM("Draconic Tempest Spiral")
        local v152 = v151.cd
        if _G.StamCheck("Draconic Tempest Spiral") == false then
            return
        end
        if v151.statreq and _G.MeetReq(v151.statreq) == false then
            return
        end
        v149["Draconic Tempest Spiral"] = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Draconic Tempest Spiral", p148:GetMouseCFrame().Position)
        _G.customDragonFlightForce = v150.PrimaryPart.CFrame.LookVector * 5000
        task.wait(0.5)
        _G.customDragonFlightForce = nil
        _G.canuse = true
        _G.keysetup:cooldown("Draconic Tempest Spiral", v152)
        _G.fw(v152)
        v149["Draconic Tempest Spiral"] = false
    end
end
function u6.DraconicThundercry(p153, _) --[[ Line: 1002 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v154 = p153.Cooldowns
    local v155 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v155) == true then
        if v154["Draconic Thundercry"] == true then
            return
        end
        local v156 = u4.GetM("Draconic Thundercry")
        local v157 = v156.cd
        if _G.StamCheck("Draconic Thundercry") == false then
            return
        end
        if v156.statreq and _G.MeetReq(v156.statreq) == false then
            return
        end
        v154["Draconic Thundercry"] = true
        _G.canuse = false
        _G.customDragonFlightMult = 0.3
        game.ReplicatedStorage.Events.Skill:InvokeServer("Draconic Thundercry", p153:GetMouseCFrame().Position)
        _G.canuse = true
        _G.customDragonFlightMult = 1
        _G.keysetup:cooldown("Draconic Thundercry", v157)
        _G.fw(v157)
        v154["Draconic Thundercry"] = false
    end
end
function u6.ThundercladVeil(p158, _) --[[ Line: 1038 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v159 = p158.Cooldowns
    local v160 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v160) == true then
        if v159["Thunderclad Veil"] == true then
            return
        end
        local v161 = u4.GetM("Thunderclad Veil")
        local v162 = v161.cd
        if _G.StamCheck("Thunderclad Veil") == false then
            return
        end
        if v161.statreq and _G.MeetReq(v161.statreq) == false then
            return
        end
        if v160:FindFirstChild("DragonDefenseBind") then
            return
        end
        v159["Thunderclad Veil"] = true
        _G.canuse = false
        v160.Humanoid.WalkSpeed = 0
        game.ReplicatedStorage.Events.Skill:InvokeServer("Thunderclad Veil", p158:GetMouseCFrame().Position)
        _G.canuse = true
        v160.Humanoid.WalkSpeed = 16
        repeat
            task.wait()
        until v160:FindFirstChild("DragonDefenseBind") == nil
        _G.keysetup:cooldown("Thunderclad Veil", v162)
        _G.fw(v162)
        v159["Thunderclad Veil"] = false
    end
end
return u6