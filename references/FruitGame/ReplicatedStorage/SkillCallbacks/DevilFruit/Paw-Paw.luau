 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
function u5.new(_) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["cannon"] = false,
        ["repel"] = false,
        ["teleport"] = false,
        ["bomb"] = false,
        ["barrage"] = false,
        ["shock"] = false
    }
    return v8
end
function u5.PawCannon(p9, p10) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p9.Cooldowns
    local u12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11.cannon == false and (_G.check:inspect(u12) == true and _G.StamCheck("Paw Cannon") == true) then
        local v13 = u3.GetM("Paw Cannon")
        local v14 = v13.cd
        if _G.StamCheck("Paw Cannon") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v11.cannon = true
        _G.canuse = false
        local u15 = tick()
        local v16 = u12.Humanoid:LoadAnimation(script.cannon)
        v16:Play()
        v16:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(v16, 0.28, 1)
        local u17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Paw Cannon", u12.PrimaryPart.CFrame)
        p9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 63 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u15
                    [3] = u17
                --]]
                return not u12:FindFirstChild("Paw-Paw") or (tick() - u15 >= 5 and true or u17 == nil)
            end
        })
        u12.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        v16:AdjustSpeed(1)
        task.wait(0.13999999999999996)
        if u17 then
            u17:FireServer(u12.PrimaryPart.CFrame)
        end
        task.wait(0.3)
        u12.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Paw Cannon", v14)
        _G.fw(v14)
        v11.cannon = false
    end
end
function u5.ShockRepel(p18, _) --[[ Line: 84 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v19 = p18.Cooldowns
    local v20 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v19.repel == false and (_G.check:inspect(v20) == true and _G.StamCheck("Shock Repel") == true) then
        local v21 = u3.GetM("Shock Repel")
        local v22 = v21.cd
        if _G.StamCheck("Shock Repel") == false then
            return
        end
        if v21.statreq and _G.MeetReq(v21.statreq) == false then
            return
        end
        v19.repel = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Shock Repel", p18:GetMouseCFrame())
        _G.canuse = true
        _G.keysetup:cooldown("Shock Repel", v22)
        _G.fw(v22)
        v19.repel = false
    end
end
function u5.Rendezvous(p23, p24) --[[ Line: 111 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v25 = p23.Cooldowns
    local u26 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v25.teleport == false and (_G.check:inspect(u26) == true and _G.StamCheck("Rendezvous") == true) then
        local v27 = u3.GetM("Rendezvous")
        local v28 = v27.cd
        if _G.StamCheck("Rendezvous") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        local v29, v30, _ = _G.getRayFloor(u26.PrimaryPart.CFrame, 10)
        if v30 and v30.Y <= _G.SeaLevel then
            _G.displayMessage("<Color=Red>Cannot place paw under water!")
            return
        end
        if v29 == nil then
            return
        end
        v25.teleport = true
        _G.canuse = false
        local v31 = u26.Humanoid:LoadAnimation(script.mark)
        v31:Play()
        v31:AdjustWeight(2)
        v31:AdjustSpeed(2)
        local v32 = Instance.new("BodyVelocity", u26.HumanoidRootPart)
        v32.MaxForce = Vector3.new(inf, 0, inf)
        v32.Velocity = Vector3.new()
        _G.destroy(v32, 0.4)
        task.wait(0.2)
        local v33 = game.ReplicatedStorage.Events.Skill:InvokeServer("Rendezvous", { u26.LeftHand.CFrame, u26.PrimaryPart.CFrame })
        task.wait(0.25)
        _G.canuse = true
        local u34 = false
        p23:DoubleCastSkill(p24, {
            ["Key"] = Enum.KeyCode.T,
            ["SkipTap"] = true,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 168 ]]
                --[[
                Upvalues:
                    [1] = u34
                --]]
                u34 = true
            end,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 171 ]]
                --[[
                Upvalues:
                    [1] = u26
                --]]
                local v35 = u26:FindFirstChild(script.Name)
                if v35 then
                    if _G.check:inspect(u26) == true then
                        v35 = _G.canuse == true
                    else
                        v35 = false
                    end
                end
                return v35
            end
        })
        repeat
            task.wait()
        until u34 == true
        if v33 then
            v33:FireServer()
        end
        local v36 = u26.Humanoid:LoadAnimation(script.snap)
        v36:Play()
        v36:AdjustWeight(2)
        v36:AdjustSpeed(2)
        task.wait(0.25)
        _G.keysetup:cooldown("Rendezvous", v28)
        _G.fw(v28)
        v25.teleport = false
    end
end
function u5.PawBomb(p37, p38) --[[ Line: 199 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v39 = p37.Cooldowns
    local u40 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v39.bomb == false and (_G.check:inspect(u40) == true and _G.StamCheck("Paw Bomb") == true) then
        local v41 = u3.GetM("Paw Bomb")
        local v42 = v41.cd
        if _G.StamCheck("Paw Bomb") == false then
            return
        end
        if v41.statreq and _G.MeetReq(v41.statreq) == false then
            return
        end
        v39.bomb = true
        _G.canuse = false
        local v43 = u40.Humanoid:LoadAnimation(script.pawBomb)
        v43:Play()
        v43:AdjustWeight(2)
        _G.FaceMouse = true
        local u44 = tick()
        _G.PauseAnim(v43, 0.28, 1)
        local u45 = game.ReplicatedStorage.Events.Skill:InvokeServer("Paw Bomb", p37:GetMouseCFrame())
        task.wait(0.2)
        p37:ChargeSkill(p38, {
            ["Key"] = Enum.KeyCode.Z,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 229 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u44
                    [3] = u45
                --]]
                return not u40:FindFirstChild("Paw-Paw") or (tick() - u44 >= 4 and true or not u45)
            end
        })
        u40.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        v43:AdjustSpeed(2)
        task.wait(0.06999999999999998)
        if u45 then
            u45:FireServer(u40.PrimaryPart.CFrame)
        end
        task.wait(0.3)
        u40.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Paw Bomb", v42)
        _G.fw(v42)
        v39.bomb = false
    end
end
function u5.PawBarrage(p46, p47) --[[ Line: 252 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v48 = p46.Cooldowns
    local u49 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v48.barrage == false and (_G.check:inspect(u49) == true and _G.StamCheck("Paw Barrage") == true) then
        local v50 = u3.GetM("Paw Barrage")
        local v51 = v50.cd
        if _G.StamCheck("Paw Barrage") == false then
            return
        end
        if v50.statreq and _G.MeetReq(v50.statreq) == false then
            return
        end
        v48.barrage = true
        _G.canuse = false
        local v52 = u49.Humanoid:LoadAnimation(script.barrageWind)
        v52:Play()
        v52:AdjustWeight(2)
        v52.Priority = Enum.AnimationPriority.Action4
        _G.FaceMouse = true
        _G.PauseAnim(v52, 0.55, 1)
        v52:Stop()
        local u53 = tick()
        local u54 = game.ReplicatedStorage.Events.Skill:InvokeServer("Paw Barrage", p46:GetMouseCFrame())
        local v55 = u49.Humanoid:LoadAnimation(script.barrageLoop)
        v55:Play()
        v55:AdjustWeight(2)
        v55:AdjustSpeed(2)
        v55.Priority = Enum.AnimationPriority.Action4
        p46:ChargeSkill(p47, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 292 ]]
                --[[
                Upvalues:
                    [1] = u49
                    [2] = u53
                    [3] = u54
                --]]
                return u49:FindFirstChild("PB") and true or (not u49:FindFirstChild("Paw-Paw") or (tick() - u53 >= 3 and true or not u54))
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v55:Stop()
        if u54 then
            u54:FireServer()
        end
        _G.canuse = true
        _G.FaceMouse = false
        _G.keysetup:cooldown("Paw Barrage", v51)
        _G.fw(v51)
        v48.barrage = false
    end
end
function u5.UrsusShock(p56, p57) --[[ Line: 315 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v58 = p56.Cooldowns
    local u59 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v58.shock == false and (_G.check:inspect(u59) == true and _G.StamCheck("Ursus Shock") == true) then
        local v60 = u3.GetM("Ursus Shock")
        local v61 = v60.cd
        if _G.StamCheck("Ursus Shock") == false then
            return
        end
        if v60.statreq and _G.MeetReq(v60.statreq) == false then
            return
        end
        v58.shock = true
        _G.canuse = false
        local u62 = tick()
        _G.FaceMouse = true
        local u63 = game.ReplicatedStorage.Events.Skill:InvokeServer("Ursus Shock", p56:GetMouseCFrame())
        p56:ChargeSkill(p57, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 342 ]]
                --[[
                Upvalues:
                    [1] = u63
                --]]
                if not u63 then
                    return true
                end
                if u63:GetAttribute("done") == true then
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 351 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u59
                    [3] = u62
                --]]
                return u63 and u63:GetAttribute("done") == true and true or (not u59:FindFirstChild("Paw-Paw") or (tick() - u62 >= 25 and true or u59.Parent ~= workspace.PlayerCharacters))
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u59.HumanoidRootPart.CFrame = CFrame.new(u59.PrimaryPart.Position, p56:GetMouseCFrame().Position)
        _G.FaceMouse = false
        if u63 and u59.Parent == workspace.PlayerCharacters then
            u59.PrimaryPart.Anchored = true
            u63:FireServer(u59.PrimaryPart.CFrame)
            task.wait(2.4)
            u59.PrimaryPart.Anchored = false
        end
        _G.canuse = true
        _G.keysetup:cooldown("Ursus Shock", v61)
        _G.fw(v61)
        v58.shock = false
    end
end
return u5