 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
function u5.new(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["hole"] = false,
        ["burst"] = false,
        ["pull"] = false,
        ["lib"] = false,
        ["blackstar"] = false,
        ["fly"] = false
    }
    v8.CurrentSwipe = 1
    return v8
end
function u5.BlackHole(p9, p10) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if v11.hole == false and (_G.check:inspect(u12) == true and _G.StamCheck("Black Hole") == true) then
        local v14 = u3.GetM("Black Hole")
        local v15 = v14.cd
        if _G.StamCheck("Black Hole") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local v16, _, _ = _G.getRayFloor(u12.PrimaryPart.CFrame, 5)
        if v16 == nil then
            _G.displayMessage("<Color=Red>I have to touch the ground")
            return nil
        end
        v11.hole = true
        _G.canuse = false
        _G.mouseLevel = true
        _G.FaceMouse = true
        local v17 = u12.Humanoid:LoadAnimation(script.blackhole)
        v17:Play()
        v17:AdjustWeight(2)
        v17:AdjustSpeed(1)
        _G.PauseAnim(v17, 0.6, 1.2)
        local u18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Black Hole", u12.PrimaryPart.CFrame)
        local u19 = tick()
        p9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 65 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u12
                --]]
                if u18 == nil or _G.check:inspect(u12) == false then
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 71 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u19
                    [3] = u13
                --]]
                if not u12:FindFirstChild(script.Name) or (tick() - u19 >= 3 or (u12.Parent == nil or (u12.Parent ~= workspace.PlayerCharacters or (u13.Stamina.Value <= 0 or u12:FindFirstChild("PB") ~= nil)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        _G.FaceMouse = false
        v17:Stop()
        if u18 then
            u18:FireServer(u12.PrimaryPart.CFrame)
        end
        _G.mouseLevel = false
        _G.keysetup:cooldown("Black Hole", v15)
        _G.canuse = true
        _G.fw(v15)
        v11.hole = false
    end
end
function u5.CruelBurst(p20, p21) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v22 = p20.Cooldowns
    local u23 = u1.Character
    local u24 = u2["Stats" .. u1.Name]
    if v22.burst == false and (_G.check:inspect(u23) == true and _G.StamCheck("Cruel Burst") == true) then
        local v25 = u3.GetM("Cruel Burst")
        local v26 = v25.cd
        if _G.StamCheck("Cruel Burst") == false then
            return
        end
        if v25.statreq and _G.MeetReq(v25.statreq) == false then
            return
        end
        v22.burst = true
        _G.canuse = false
        _G.mouseLevel = true
        _G.FaceMouse = true
        u23.HumanoidRootPart.Anchored = true
        local v27 = u23.Humanoid:LoadAnimation(script.summonburst)
        v27:Play()
        v27:AdjustSpeed(2)
        task.wait(0.25)
        local u28 = game.ReplicatedStorage.Events.Skill:InvokeServer("Cruel Burst", u23.PrimaryPart.CFrame)
        v27:Stop()
        local v29 = u23.Humanoid:LoadAnimation(script.burstloop)
        v29:Play()
        local u30 = tick()
        p20:ChargeSkill(p21, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 134 ]]
                --[[
                Upvalues:
                    [1] = u28
                --]]
                if u28 == nil then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 140 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u30
                    [3] = u24
                --]]
                if not u23:FindFirstChild(script.Name) or (tick() - u30 >= 4 or (u23.Parent == nil or (u23.Parent ~= workspace.PlayerCharacters or (u24.Stamina.Value <= 0 or _G.check:inspect(u23) == false)))) then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        _G.mouseLevel = false
        v29:Stop()
        local v31 = u23.Humanoid:LoadAnimation(script.burstexplode)
        v31:Play()
        v31:AdjustWeight(2)
        v31:AdjustSpeed(2)
        if u28 then
            u28:FireServer(u23.PrimaryPart.CFrame)
        end
        task.wait(0.5)
        u23.HumanoidRootPart.Anchored = false
        _G.keysetup:cooldown("Cruel Burst", v26)
        _G.canuse = true
        _G.fw(v26)
        v22.burst = false
    end
end
function u5.BlackVortex(p32, p33) --[[ Line: 176 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v34 = p32.Cooldowns
    local u35 = u1.Character
    local u36 = u2["Stats" .. u1.Name]
    if v34.pull == false and (_G.check:inspect(u35) == true and _G.StamCheck("Black Vortex") == true) then
        local v37 = u3.GetM("Black Vortex")
        local v38 = v37.cd
        if _G.StamCheck("Black Vortex") == false then
            return
        end
        if v37.statreq and _G.MeetReq(v37.statreq) == false then
            return
        end
        v34.pull = true
        _G.canuse = false
        u35.PrimaryPart.Anchored = true
        u35.Humanoid.AutoRotate = false
        u35:PivotTo(CFrame.new(u35.PrimaryPart.Position, p32:GetMouseCFrame().Position))
        local v39 = u35.Humanoid:LoadAnimation(script.kurowindup)
        v39:Play()
        v39:AdjustSpeed(2)
        task.wait(0.2)
        local u40 = game.ReplicatedStorage.Events.Skill:InvokeServer("Black Vortex", u35.PrimaryPart.CFrame)
        v39:Stop()
        local v41 = u35.Humanoid:LoadAnimation(script.kuroloop)
        v41:Play()
        local u42 = tick()
        p32:ChargeSkill(p33, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 207 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u35
                --]]
                if u40 == nil then
                    return true
                end
                u35.Humanoid.AutoRotate = false
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 215 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u42
                    [3] = u36
                --]]
                if not u35:FindFirstChild(script.Name) or (tick() - u42 >= 2 or (u35.Parent == nil or (u35.Parent ~= workspace.PlayerCharacters or (u36.Stamina.Value <= 0 or u35:FindFirstChild("PB") ~= nil)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        _G.FaceMouse = false
        v41:Stop()
        if u40 then
            u40:FireServer(u35.PrimaryPart.CFrame)
        end
        task.wait(0.25)
        u35.Humanoid.AutoRotate = true
        u35.PrimaryPart.Anchored = false
        _G.keysetup:cooldown("Black Vortex", v38)
        _G.canuse = true
        _G.fw(v38)
        v34.pull = false
    end
end
function u5.DarkLiberation(u43, p44) --[[ Line: 246 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v45 = u43.Cooldowns
    local u46 = u1.Character
    local u47 = u2["Stats" .. u1.Name]
    if v45.lib == false and (_G.check:inspect(u46) == true and _G.StamCheck("Dark Liberation") == true) then
        local v48 = u3.GetM("Dark Liberation")
        local v49 = v48.cd
        if _G.StamCheck("Dark Liberation") == false then
            return
        end
        if v48.statreq and _G.MeetReq(v48.statreq) == false then
            return
        end
        local v50, _, _ = _G.getRayFloor(u46.PrimaryPart.CFrame, 5)
        if v50 == nil then
            return nil
        end
        v45.lib = true
        _G.canuse = false
        _G.mouseLevel = true
        _G.FaceMouse = true
        local v51 = u46.Humanoid:LoadAnimation(script.liberation)
        v51:Play()
        v51:AdjustWeight(2)
        v51:AdjustSpeed(1)
        _G.PauseAnim(v51, 0.75, 2)
        local u52 = game.ReplicatedStorage.Events.Skill:InvokeServer("Dark Liberation", u46.PrimaryPart.CFrame)
        local u53 = tick()
        u43:ChargeSkill(p44, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 280 ]]
                --[[
                Upvalues:
                    [1] = u52
                --]]
                if u52 == nil then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 286 ]]
                --[[
                Upvalues:
                    [1] = u46
                    [2] = u53
                    [3] = u47
                --]]
                if not u46:FindFirstChild(script.Name) or (tick() - u53 >= 10 or (u46.Parent == nil or (u46.Parent ~= workspace.PlayerCharacters or u47.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v51:Stop()
        local u54 = false
        if u52 then
            task.spawn(function() --[[ Line: 303 ]]
                --[[
                Upvalues:
                    [1] = u46
                    [2] = u52
                    [3] = u43
                    [4] = u54
                --]]
                local v55 = u46.Humanoid:LoadAnimation(script.liberationshopot)
                v55:Play()
                v55:AdjustWeight(2)
                v55:AdjustSpeed(1)
                while u52 do
                    u52:InvokeServer(u43:GetMouseCFrame().Position)
                    task.wait()
                    if u54 == true then
                        break
                    end
                end
                v55:Stop()
            end)
            local v56 = u46.Humanoid:LoadAnimation(script.liberationwindup)
            v56:Play()
            v56:AdjustWeight(2)
            v56:AdjustSpeed(1)
            u52:InvokeServer(u46.PrimaryPart.CFrame)
        end
        local _ = true
        _G.FaceMouse = false
        _G.mouseLevel = false
        _G.keysetup:cooldown("Dark Liberation", v49)
        _G.canuse = true
        _G.fw(v49)
        v45.lib = false
    end
end
function u5.BlackStar(p57, p58) --[[ Line: 337 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v59 = p57.Cooldowns
    local u60 = u1.Character
    local u61 = u2["Stats" .. u1.Name]
    if v59.blackstar == false and (_G.check:inspect(u60) == true and _G.StamCheck("Black Star") == true) then
        local v62 = u3.GetM("Black Star")
        local v63 = v62.cd
        if _G.StamCheck("Black Star") == false then
            return
        end
        if v62.statreq and _G.MeetReq(v62.statreq) == false then
            return
        end
        v59.blackstar = true
        _G.canuse = false
        _G.mouseLevel = true
        _G.FaceMouse = true
        local u64 = u60.Humanoid:LoadAnimation(script.blacksummon)
        u64:Play()
        u64:AdjustWeight(2)
        u64:AdjustSpeed(1)
        task.spawn(function() --[[ Line: 361 ]]
            --[[
            Upvalues:
                [1] = u64
                [2] = u60
            --]]
            task.wait(0.55)
            u64 = u60.Humanoid:LoadAnimation(script.blackcharge)
            u64:Play()
            u64:AdjustWeight(2)
            u64:AdjustSpeed(1)
        end)
        local u65 = game.ReplicatedStorage.Events.Skill:InvokeServer("Black Star", u60.PrimaryPart.CFrame)
        local u66 = tick()
        p57:ChargeSkill(p58, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 372 ]]
                --[[
                Upvalues:
                    [1] = u65
                --]]
                if u65 == nil then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 378 ]]
                --[[
                Upvalues:
                    [1] = u60
                    [2] = u66
                    [3] = u61
                --]]
                if not u60:FindFirstChild(script.Name) or (tick() - u66 >= 10 or (u60.Parent == nil or (u60.Parent ~= workspace.PlayerCharacters or u61.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        if u65 then
            u65:FireServer(p57:GetMouseCFrame())
            task.wait(0.8)
            u64:Stop()
            local v67 = u60.Humanoid:LoadAnimation(script.blackthrow)
            v67:Play()
            v67:AdjustWeight(2)
            v67:AdjustSpeed(1)
        else
            u64:Stop()
        end
        task.wait(1)
        _G.FaceMouse = false
        _G.mouseLevel = false
        _G.keysetup:cooldown("Black Star", v63)
        _G.canuse = true
        _G.fw(v63)
        v59.blackstar = false
    end
end
function u5.AbyssalForm(u68, p69) --[[ Line: 419 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v70 = u68.Cooldowns
    local u71 = u1.Character
    local u72 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (v70.fly == false and (_G.check:inspect(u71) == true and _G.StamCheck("Abyssal Form") == true)) then
        local v73 = u3.GetM("Abyssal Form")
        local v74 = v73.cd
        if _G.StamCheck("Abyssal Form") == false then
            return
        end
        if v73.statreq and _G.MeetReq(v73.statreq) == false then
            return
        end
        v70.fly = true
        _G.canuse = false
        local u75 = tick()
        u71.PrimaryPart.Anchored = true
        local v76 = u71.Humanoid:LoadAnimation(script.fly)
        v76:Play()
        v76:AdjustSpeed(0.9)
        local v77 = game.ReplicatedStorage.Events.Skill:InvokeServer("Abyssal Form")
        local u78 = Instance.new("BodyVelocity", u71.PrimaryPart)
        u78.MaxForce = Vector3.new(inf, inf, inf)
        u78.Name = "geppo"
        u78.Velocity = Vector3.new()
        local u79 = Instance.new("BodyGyro", u71.PrimaryPart)
        u79.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
        u79.P = 4000000
        u79.D = 10000
        local _ = u71.PrimaryPart.CFrame
        u71.PrimaryPart.Anchored = false
        u68:ToggleSkill(p69, {
            ["Key"] = Enum.KeyCode.T,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 457 ]]
                --[[
                Upvalues:
                    [1] = u71
                    [2] = u78
                    [3] = u79
                    [4] = u68
                --]]
                _G.canuse = false
                local v80 = u71:FindFirstChild("inCombat") == nil and 1.5 or 1
                u78.Velocity = u71.PrimaryPart.CFrame.LookVector * (v80 * 50)
                u79.CFrame = CFrame.new(u71.PrimaryPart.Position, u68:GetMouseCFrame().Position)
                u71.PrimaryPart.Velocity = Vector3.new()
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 468 ]]
                --[[
                Upvalues:
                    [1] = u71
                    [2] = u72
                    [3] = u75
                --]]
                if not u71:FindFirstChild(script.Name) or (u71.Parent == nil or (u71.Parent ~= workspace.PlayerCharacters or (u72.Stamina.Value <= 0 or tick() - u75 >= 10))) then
                    return true
                end
                if _G.grounded == true then
                    return true
                end
            end
        })
        if v77 then
            v77:FireServer()
        end
        u79:Destroy()
        u78:Destroy()
        u71:SetPrimaryPartCFrame(CFrame.new(u71.PrimaryPart.Position, u68:GetMouseCFrame().Position))
        _G.canuse = true
        _G.keysetup:cooldown("Abyssal Form", v74)
        _G.fw(v74)
        v70.fly = false
    end
end
return u5