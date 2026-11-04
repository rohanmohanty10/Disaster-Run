 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v5:GetControls()
local u6 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
local u7 = setmetatable({}, u4)
u7.__index = u7
function u7.new(_) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u7
        [3] = u1
        [4] = u3
        [5] = u6
    --]]
    local v8 = u4.new(script.Name)
    local v9 = u7
    local u10 = setmetatable(v8, v9)
    local u11 = game.ReplicatedStorage:FindFirstChild("Stats" .. u1.Name)
    function u10.getTools() --[[ Line: 26 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v12 = u1.Backpack:GetChildren()
        local v13 = nil
        for v14 = 1, #v12 do
            if v12[v14]:IsA("Tool") and (v12[v14]:FindFirstChild("SwordEquip") and v12[v14].Name ~= "3SS") then
                return v12[v14].Name
            end
        end
        return v13
    end
    local u15 = 0
    local u16 = {}
    local u17 = u3.GetM("Billion-Fold World")
    u10.excuteVFX = {}
    u10.HeartbeatConnection = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 56 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u1
            [3] = u17
            [4] = u11
            [5] = u16
            [6] = u10
        --]]
        if tick() - u15 >= 0.1 then
            u15 = tick()
            local v18 = {}
            local v19 = u1.Character:GetAttribute("3SSExcuteDMG")
            if _G.MeetReq(u17, nil, true) == true and v19 then
                local v20 = _G.getTargets(u1.Character)
                local v21 = u11.Stats.SwordMastery.Value / 100 / 100
                local v22 = math.clamp(v21, 0, 0.1) + 0.02
                for v23 = 1, #v20 do
                    local v24 = v20[v23].Parent
                    if v24 ~= nil and (v24.Parent ~= nil and (v24.Parent:IsA("Model") ~= false and (v24.Parent ~= workspace.NPCs and (v24.Parent ~= workspace.Ragdolls and (v24:IsA("Model") ~= false and (v24.PrimaryPart ~= nil and (v24.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 600)))))) then
                        local v25 = v24:FindFirstChild("Humanoid")
                        if v25 and (v25.Health - v19) / v25.MaxHealth <= v22 then
                            if u16[v24] then
                                v18[v24] = true
                            else
                                local v26 = script.excuVFX.vfx:Clone()
                                v26.Parent = v24.UpperTorso
                                local v27 = u10.excuteVFX
                                table.insert(v27, v26)
                                u16[v24] = v26
                                v18[v24] = true
                            end
                        end
                    end
                end
            end
            for v28, v29 in pairs(u16) do
                if v18[v28] == nil then
                    _G.PlayEffect("TweenParticles", nil, v29, NumberSequence.new(0), 0.25)
                    _G.particleEnabled(v29, false)
                    _G.destroy(v29, 3)
                    u16[v28] = nil
                    for v30 = 1, #u10.excuteVFX do
                        if u10.excuteVFX[v30] == v29 then
                            table.remove(u10.excuteVFX, v30)
                        end
                    end
                end
            end
        end
    end)
    local v31 = {}
    local v32 = u6[script.Name]
    local v33
    if v32 == nil then
        v33 = u6.Katana.keys
    else
        v33 = v32.keys
    end
    for v34 = 1, #v33 do
        v31[v33[v34][1]] = false
    end
    u10.Cooldowns = v31
    return u10
end
function u7.TigerHunt(p35, _) --[[ Line: 143 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v36 = p35.Cooldowns
    local v37 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v36["Tiger Hunt"] == false and _G.check:inspect(v37) == true then
        local v38 = u3.GetM("Tiger Hunt")
        local v39 = v38.cd
        if _G.StamCheck("Tiger Hunt") == false then
            return
        end
        if v38.statreq and _G.MeetReq(v38.statreq) == false then
            return
        end
        v36["Tiger Hunt"] = true
        _G.canuse = false
        local v40 = game.ReplicatedStorage.Events.Skill:InvokeServer("Tiger Hunt")
        local v41 = v37.Humanoid:LoadAnimation(script.tigerHunt)
        v41:Play()
        v41:AdjustWeight(2)
        v41:AdjustSpeed(1.25)
        v37.Humanoid.WalkSpeed = 6
        if v40 and _G.castingSkill(v37, 0.6264000000000001, true) == true then
            v40:InvokeServer(v37.PrimaryPart.CFrame)
        elseif v40 then
            v40:InvokeServer(nil)
        end
        v41:Stop()
        v37.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Tiger Hunt", v39)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v36)
        _G.fw(v39)
        v36["Tiger Hunt"] = false
    end
end
function u7.Onigiri(u42, p43) --[[ Line: 190 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v44 = u42.Cooldowns
    local u45 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v44.Onigiri == false and _G.check:inspect(u45) == true then
        local v46 = u3.GetM("Onigiri")
        local v47 = v46.cd
        if _G.StamCheck("Onigiri") == false then
            return
        end
        if v46.statreq and _G.MeetReq(v46.statreq) == false then
            return
        end
        v44.Onigiri = true
        _G.canuse = false
        _G.FaceMouse = true
        local u48 = game.ReplicatedStorage.Events.Skill:InvokeServer("Onigiri", u45.PrimaryPart.CFrame)
        local v49 = u45.Humanoid:LoadAnimation(script.onigiri)
        v49:Play()
        v49:AdjustWeight(2)
        local u50 = tick()
        u42:ChargeSkill(p43, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 219 ]]
                --[[
                Upvalues:
                    [1] = u42
                    [2] = u45
                    [3] = u50
                    [4] = u48
                --]]
                if u42.Tool.Parent ~= u45 or (tick() - u50 >= 0.5 or u48 == nil) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.5
        })
        u45.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        u45.Humanoid.AutoRotate = false
        v49:AdjustSpeed(0)
        v49.TimePosition = 0.5
        if u48 then
            u48:InvokeServer(u45.PrimaryPart.CFrame)
        end
        v49:AdjustSpeed(1)
        task.wait(0.75)
        u45.PrimaryPart.Anchored = false
        u45.Humanoid.AutoRotate = true
        u45.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Onigiri", v47)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v44)
        _G.fw(v47)
        v44.Onigiri = false
    end
end
u7["1080PoundPhoenix"] = function(u51, p52) --[[ Line: 257 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v53 = u51.Cooldowns
    local u54 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v53["1080 Pound Phoenix"] == false and _G.check:inspect(u54) == true then
        local v55 = u3.GetM("1080 Pound Phoenix")
        local v56 = v55.cd
        if _G.StamCheck("1080 Pound Phoenix") == false then
            return
        end
        if v55.statreq and _G.MeetReq(v55.statreq) == false then
            return
        end
        v53["1080 Pound Phoenix"] = true
        _G.canuse = false
        _G.FaceMouse = true
        local u57 = game.ReplicatedStorage.Events.Skill:InvokeServer("1080 Pound Phoenix")
        local v58 = u54.Humanoid:LoadAnimation(script.poundPhoenix)
        v58:Play()
        v58:AdjustWeight(2)
        _G.PauseAnim(v58, 0.517, 1.75)
        local u59 = tick()
        u51:ChargeSkill(p52, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 287 ]]
                --[[
                Upvalues:
                    [1] = u51
                    [2] = u54
                    [3] = u59
                    [4] = u57
                --]]
                if u51.Tool.Parent ~= u54 or (tick() - u59 >= 3 or (u57 == nil or _G.check:inspect(u54) == false)) then
                    return true
                end
            end
        })
        v58:AdjustSpeed(1.75)
        u54.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        u54.Humanoid.AutoRotate = false
        task.wait(0.104)
        if u57 then
            u57:InvokeServer(u54.PrimaryPart.CFrame)
        end
        v58:Stop()
        u54.PrimaryPart.Anchored = false
        u54.Humanoid.AutoRotate = true
        u54.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("1080 Pound Phoenix", v56)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v53)
        _G.fw(v56)
        v53["1080 Pound Phoenix"] = false
    end
end
function u7.DragonTwister(u60, p61) --[[ Line: 319 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v62 = u60.Cooldowns
    local u63 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v62["Dragon Twister"] == false and _G.check:inspect(u63) == true then
        local v64 = u3.GetM("Dragon Twister")
        local v65 = v64.cd
        if _G.StamCheck("Dragon Twister") == false then
            return
        end
        if v64.statreq and _G.MeetReq(v64.statreq) == false then
            return
        end
        v62["Dragon Twister"] = true
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v62)
        _G.canuse = false
        u63.Humanoid.WalkSpeed = 4
        local u66 = game.ReplicatedStorage.Events.Skill:InvokeServer("Dragon Twister")
        local v67 = u63.Humanoid:LoadAnimation(script.twisterStartup)
        v67:Play()
        v67:AdjustWeight(2)
        v67:AdjustSpeed(1.5)
        task.wait(0.7446666666666667)
        local v68 = u63.Humanoid:LoadAnimation(script.twisterLoop)
        v68:Play()
        v68:AdjustWeight(2)
        local u69 = tick()
        u60:ChargeSkill(p61, {
            ["Key"] = Enum.KeyCode.T,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 356 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u60
                    [3] = u69
                    [4] = u66
                --]]
                u63.Humanoid.WalkSpeed = 35
                if u60.Tool.Parent ~= u63 or (tick() - u69 >= 3 or (u66 == nil or _G.check:inspect(u63) == false)) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.25,
            ["IgnoreInstantCastSetting"] = true
        })
        v68:Stop(0)
        local v70 = u63.Humanoid:LoadAnimation(script.twisterEnd)
        v70:Play(0)
        v70:AdjustSpeed(2)
        v70:AdjustWeight(2)
        u63.Humanoid.WalkSpeed = 4
        if u66 then
            u66:InvokeServer(u63.PrimaryPart.CFrame)
        end
        task.wait(0.3)
        u63.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Dragon Twister", v65)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v62)
        _G.fw(v65)
        v62["Dragon Twister"] = false
    end
end
function u7.CrossingSixPaths(p71, p72) --[[ Line: 394 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v73 = p71.Cooldowns
    local u74 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v73["Crossing Six Paths"] == false and _G.check:inspect(u74) == true then
        local v75 = u3.GetM("Crossing Six Paths")
        local v76 = v75.cd
        if _G.StamCheck("Crossing Six Paths") == false then
            return
        end
        if v75.statreq and _G.MeetReq(v75.statreq) == false then
            return
        end
        v73["Crossing Six Paths"] = true
        _G.canuse = false
        _G.FaceMouse = true
        task.delay(1.01, function() --[[ Line: 413 ]]
            _G.FaceMouse = false
        end)
        local u77 = game.ReplicatedStorage.Events.Skill:InvokeServer("Crossing Six Paths", u74.PrimaryPart.CFrame)
        if u77 then
            p71:DoubleCastSkill(p72, {
                ["Key"] = Enum.KeyCode.X,
                ["SkipTap"] = true,
                ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 422 ]]
                    --[[
                    Upvalues:
                        [1] = u77
                        [2] = u74
                    --]]
                    if u77 and u74:FindFirstChild("GrabTag") == nil then
                        u77:FireServer("forceCancel")
                    end
                end,
                ["PassFunction"] = function() --[[ Name: PassFunction, Line 427 ]]
                    --[[
                    Upvalues:
                        [1] = u74
                    --]]
                    local v78 = u74:FindFirstChild(script.Name)
                    if v78 then
                        v78 = u74:GetAttribute("crossingsixStarted") == true
                    end
                    return v78
                end
            })
            repeat
                task.wait()
            until u77:IsDescendantOf(game) == false
        end
        _G.FaceMouse = false
        _G.canuse = true
        _G.keysetup:cooldown("Crossing Six Paths", v76)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v73)
        _G.fw(v76)
        v73["Crossing Six Paths"] = false
    end
end
u7["Billion-FoldWorld"] = function(p79, _) --[[ Line: 446 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v80 = p79.Cooldowns
    local v81 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v80["Billion-Fold World"] == false and _G.check:inspect(v81) == true then
        local v82 = u3.GetM("Billion-Fold World")
        local v83 = v82.cd
        if _G.StamCheck("Billion-Fold World") == false then
            return
        end
        if v82.statreq and _G.MeetReq(v82.statreq) == false then
            return
        end
        v80["Billion-Fold World"] = true
        _G.canuse = false
        local v84 = game.ReplicatedStorage.Events.Skill:InvokeServer("Billion-Fold World")
        if v84 then
            repeat
                task.wait()
            until v84:IsDescendantOf(game) == false
        end
        _G.canuse = true
        _G.keysetup:cooldown("Billion-Fold World", v83)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v80)
        _G.fw(v83)
        v80["Billion-Fold World"] = false
    end
end
function u7.SwordStyleSwap(p85, _) --[[ Line: 485 ]]
    require(script.Parent.SwordStyleSwapping):swap(p85)
end
return u7