 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("UserInputService")
local u4 = require(game.ReplicatedStorage.Modules.Skills)
local u5 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u6 = setmetatable({}, u5)
u6.__index = u6
function u6.new(_) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
    --]]
    local v7 = u5.new(script.Name)
    local v8 = u6
    local v9 = setmetatable(v7, v8)
    v9.Cooldowns = {
        ["meator"] = false,
        ["fly"] = false,
        ["fury"] = false,
        ["dom"] = false,
        ["push"] = false,
        ["pull"] = false
    }
    return v9
end
function u6.GravityFly(p10, p11) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
        [4] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local u14 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (v12.fly == false and (_G.check:inspect(u13) == true and _G.StamCheck("Gravity Fly") == true)) then
        local v15 = u4.GetM("Gravity Fly")
        local v16 = v15.cd
        if _G.StamCheck("Gravity Fly") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        v12.fly = true
        local v17 = u13.Humanoid:LoadAnimation(script.summon)
        v17:Play()
        _G.canGlide = false
        _G.canuse = false
        task.wait(0.5)
        local u18 = tick()
        local u19 = game.ReplicatedStorage.Events.Skill:InvokeServer("Gravity Fly", {
            ["cf"] = p10:GetMouseCFrame()
        })
        _G.canuse = true
        v17:Stop()
        local u20 = u13.Humanoid:LoadAnimation(script.fly)
        local u21 = u13.Humanoid:LoadAnimation(script.foward)
        u20:Play()
        local u22 = Instance.new("BodyVelocity", u13.LowerTorso)
        u22.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
        u22.Velocity = Vector3.new(0, 10, 0)
        u22.Name = "flightBV"
        local _ = workspace.CurrentCamera
        local _ = u13.Humanoid.HipHeight
        local u23 = false
        local u24 = nil
        u3.JumpRequest:Connect(function() --[[ Line: 81 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u24
            --]]
            u23 = true
            if u24 and coroutine.status(u24) ~= "dead" then
                task.cancel(u24)
            end
            u24 = task.delay(0.25, function() --[[ Line: 88 ]]
                --[[
                Upvalues:
                    [1] = u23
                --]]
                u23 = false
            end)
        end)
        local u25 = false
        p10:DoubleCastSkill(p11, {
            ["ToolName"] = script.Name,
            ["Button"] = p11,
            ["Key"] = Enum.KeyCode.T,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 98 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u13
                    [3] = u22
                    [4] = u21
                    [5] = u20
                    [6] = u18
                    [7] = u19
                    [8] = u14
                --]]
                local v26 = u23 and 20 or -10
                local v27 = CFrame.new(u13.HumanoidRootPart.Position)
                local v28 = Ray.new(v27.Position, v27.UpVector * -9)
                local v29, v30 = _G.raycastWhitelist(v28, { workspace.Islands, workspace.Ships, workspace.Env })
                local v31 = v29 and v26 < 0 and 5 or (v30.Y < workspace.Env.WaterStuff.Falls.Position.Y and v30.Y > workspace.Env.WaterStuff.Sand.Position.Y and 5 or v26)
                local v32 = u13.Humanoid.MoveDirection
                local v33
                if _G.FaceMouse == false and _G.canuse == true then
                    if v32.Magnitude > 0 then
                        v33 = u13.Humanoid.MoveDirection * 35 + Vector3.new(0, v31, 0)
                    else
                        v33 = Vector3.new(0, v31, 0)
                    end
                else
                    v33 = Vector3.new()
                end
                u22.Velocity = u22.Velocity:Lerp(v33, 0.1)
                if v32.Magnitude == 0 then
                    if u21.IsPlaying == true then
                        u21:Stop()
                    end
                    if u20.IsPlaying == false then
                        u20:Play()
                    end
                else
                    if u20.IsPlaying == true then
                        u20:Stop()
                    end
                    if u21.IsPlaying == false then
                        u21:Play()
                    end
                end
                if u13:FindFirstChild("inCombat") then
                    if tick() - u18 >= 30 then
                        return true
                    end
                    if u13:FindFirstChild("PB") then
                        return true
                    end
                end
                local v34 = u13.Parent ~= nil and u19 ~= nil and ((u13.Parent == workspace.PlayerCharacters and (u14.Stamina.Value > 0 and not _G.grounded) and true or false) and (not u13:FindFirstChild("Stun") and u19))
                if v34 then
                    v34 = u19:IsDescendantOf(game) == false
                end
                return v34
            end,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 155 ]]
                --[[
                Upvalues:
                    [1] = u25
                --]]
                u25 = true
            end,
            ["SkipTap"] = true
        })
        repeat
            task.wait()
        until u25 == true
        u22:Destroy()
        u20:Stop()
        u21:Stop()
        _G.canGlide = true
        if u19 then
            u19:FireServer()
        end
        v17:Stop()
        _G.keysetup:cooldown("Gravity Fly", v16)
        _G.fw(v16)
        v12.fly = false
    end
end
function u6.MeteorStrike(p35, p36) --[[ Line: 180 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v37 = p35.Cooldowns
    local u38 = u1.Character
    local u39 = u2["Stats" .. u1.Name]
    if v37.meator == false and (_G.check:inspect(u38) == true and _G.StamCheck("Meteor Strike") == true) then
        local v40 = u4.GetM("Meteor Strike")
        local v41 = v40.cd
        if _G.StamCheck("Meteor Strike") == false then
            return
        end
        if v40.statreq and _G.MeetReq(v40.statreq) == false then
            return
        end
        v37.meator = true
        _G.canuse = false
        local u42 = u38.Humanoid:LoadAnimation(script.rock)
        u42:Play()
        u42:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(u42, 0.3, 0.8)
        local u43 = tick()
        local u44 = 0
        p35:ChargeSkill(p36, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 209 ]]
                --[[
                Upvalues:
                    [1] = u44
                --]]
                if tick() - u44 >= 0.2 then
                    u44 = tick()
                end
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 214 ]]
                --[[
                Upvalues:
                    [1] = u38
                    [2] = u43
                    [3] = u39
                --]]
                return not u38:FindFirstChild(script.Name) or ((tick() - u43 >= 10 or (u38.Parent == nil or u38.Parent ~= workspace.PlayerCharacters)) and true or u39.Stamina.Value <= 0)
            end
        })
        u38.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        _G.mouseLevel = nil
        task.delay(0.5, function() --[[ Line: 223 ]]
            --[[
            Upvalues:
                [1] = u42
            --]]
            u42:AdjustSpeed(1.5)
        end)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Meteor Strike", {
            ["cf"] = p35:GetMouseCFrame()
        })
        u38.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Meteor Strike", v41)
        _G.fw(v41)
        v37.meator = false
    end
end
function u6.MeteorFury(u45, p46) --[[ Line: 237 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v47 = u45.Cooldowns
    local u48 = u1.Character
    local u49 = u2["Stats" .. u1.Name]
    if v47.fury == false and (_G.check:inspect(u48) == true and _G.StamCheck("Meteor Fury") == true) then
        local v50 = u4.GetM("Meteor Fury")
        local v51 = v50.cd
        if _G.StamCheck("Meteor Fury") == false then
            return
        end
        if v50.statreq and _G.MeetReq(v50.statreq) == false then
            return
        end
        v47.fury = true
        _G.canuse = false
        local v52 = u48.Humanoid:LoadAnimation(script.fury)
        v52:Play()
        v52:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(v52, 0.55, 1)
        local u53 = tick()
        local u54 = game.ReplicatedStorage.Events.Skill:InvokeServer("Meteor Fury", {
            ["cf"] = u45:GetMouseCFrame()
        })
        u45:ChargeSkill(p46, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 267 ]]
                --[[
                Upvalues:
                    [1] = u54
                    [2] = u45
                    [3] = u48
                    [4] = u53
                    [5] = u49
                --]]
                if not u54 then
                    return true
                end
                u54:FireServer(u45:GetMouseCFrame())
                return not u48:FindFirstChild(script.Name) or ((tick() - u53 >= 5.6000000000000005 or (u48.Parent == nil or u48.Parent ~= workspace.PlayerCharacters)) and true or u49.Stamina.Value <= 0)
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        task.wait(0.4)
        u48.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        v52:Stop()
        u48.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Meteor Fury", v51)
        _G.fw(v51)
        v47.fury = false
    end
end
function u6.GravityDominance(p55, p56) --[[ Line: 290 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v57 = p55.Cooldowns
    local u58 = u1.Character
    local u59 = u2["Stats" .. u1.Name]
    if v57.dom == false and (_G.check:inspect(u58) == true and _G.StamCheck("Gravity Dominance") == true) then
        local v60 = u4.GetM("Gravity Dominance")
        local v61 = v60.cd
        if _G.StamCheck("Gravity Dominance") == false then
            return
        end
        if v60.statreq and _G.MeetReq(v60.statreq) == false then
            return
        end
        local v62 = u58.PrimaryPart.CFrame
        local v63 = CFrame.new(v62.Position)
        local v64, _, _ = _G.raycastWithLand(v63.Position, v63.UpVector * -8)
        if v64 == nil then
            return
        end
        v57.dom = true
        _G.canuse = false
        local u65 = tick()
        u58.HumanoidRootPart.Anchored = true
        local v66 = u58.Humanoid:LoadAnimation(script.force)
        v66:Play()
        v66:AdjustWeight(2)
        _G.PauseAnim(v66, 0.6, 1.02)
        local u67 = game.ReplicatedStorage.Events.Skill:InvokeServer("Gravity Dominance", {
            ["cf"] = u58.HumanoidRootPart.CFrame
        })
        p55:ChargeSkill(p56, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 326 ]]
                --[[
                Upvalues:
                    [1] = u58
                --]]
                u58.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 330 ]]
                --[[
                Upvalues:
                    [1] = u67
                    [2] = u58
                    [3] = u65
                    [4] = u59
                --]]
                return u67 == nil and true or (not u58:FindFirstChild(script.Name) or ((tick() - u65 >= 3 or (u58.Parent == nil or u58.Parent ~= workspace.PlayerCharacters)) and true or u59.Stamina.Value <= 0))
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if u67 then
            u67:FireServer(p55:GetMouseCFrame())
        end
        v66:Stop()
        u58.HumanoidRootPart.Anchored = false
        u58.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Gravity Dominance", v61)
        _G.fw(v61)
        v57.dom = false
    end
end
function u6.GravityPush(p68, p69) --[[ Line: 353 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v70 = p68.Cooldowns
    local u71 = u1.Character
    local u72 = u2["Stats" .. u1.Name]
    if v70.push == false and (_G.check:inspect(u71) == true and _G.StamCheck("Gravity Push") == true) then
        local v73 = u4.GetM("Gravity Push")
        local v74 = v73.cd
        if _G.StamCheck("Gravity Push") == false then
            return
        end
        if v73.statreq and _G.MeetReq(v73.statreq) == false then
            return
        end
        v70.push = true
        _G.canuse = false
        local u75 = tick()
        _G.FaceMouse = true
        local v76 = u71.Humanoid:LoadAnimation(script.push)
        v76:Play()
        v76:AdjustWeight(2)
        _G.PauseAnim(v76, 0.4, 1)
        p68:ChargeSkill(p69, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 381 ]]
                --[[
                Upvalues:
                    [1] = u71
                    [2] = u75
                    [3] = u72
                --]]
                return not u71:FindFirstChild(script.Name) or ((tick() - u75 >= 10 or (u71.Parent == nil or u71.Parent ~= workspace.PlayerCharacters)) and true or u72.Stamina.Value <= 0)
            end
        })
        v76:AdjustSpeed(1)
        _G.FaceMouse = false
        u71.HumanoidRootPart.Anchored = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Gravity Push", {
            ["cf"] = u71.HumanoidRootPart.CFrame
        })
        task.wait(0.5)
        u71.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Gravity Push", v74)
        _G.fw(v74)
        v70.push = false
    end
end
function u6.GravityPull(p77, p78) --[[ Line: 401 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v79 = p77.Cooldowns
    local u80 = u1.Character
    local u81 = u2["Stats" .. u1.Name]
    if v79.pull == false and (_G.check:inspect(u80) == true and _G.StamCheck("Gravity Pull") == true) then
        local v82 = u4.GetM("Gravity Pull")
        local v83 = v82.cd
        if _G.StamCheck("Gravity Pull") == false then
            return
        end
        if v82.statreq and _G.MeetReq(v82.statreq) == false then
            return
        end
        v79.pull = true
        _G.canuse = false
        local u84 = tick()
        _G.FaceMouse = true
        local v85 = u80.Humanoid:LoadAnimation(script.pull)
        v85:Play()
        v85:AdjustWeight(2)
        _G.PauseAnim(v85, 0.42, 1)
        p77:ChargeSkill(p78, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 429 ]]
                --[[
                Upvalues:
                    [1] = u80
                    [2] = u84
                    [3] = u81
                --]]
                return not u80:FindFirstChild(script.Name) or ((tick() - u84 >= 10 or (u80.Parent == nil or u80.Parent ~= workspace.PlayerCharacters)) and true or u81.Stamina.Value <= 0)
            end
        })
        v85:AdjustSpeed(1)
        _G.FaceMouse = false
        u80.HumanoidRootPart.Anchored = true
        task.wait(0.1)
        pcall(function() --[[ Line: 439 ]]
            --[[
            Upvalues:
                [1] = u80
            --]]
            game.ReplicatedStorage.Events.Skill:InvokeServer("Gravity Pull", {
                ["cf"] = u80.HumanoidRootPart.CFrame
            })
        end)
        task.wait(0.4)
        u80.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Gravity Pull", v83)
        _G.fw(v83)
        v79.pull = false
    end
end
return u6