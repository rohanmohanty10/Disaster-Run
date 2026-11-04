 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v5:GetControls()
local u6 = setmetatable({}, u4)
u6.__index = u6
function u6.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
    --]]
    local v7 = u4.new(script.Name)
    local v8 = u6
    local v9 = setmetatable(v7, v8)
    v9.Cooldowns = {
        ["spin"] = false,
        ["sweep"] = false,
        ["counter"] = false,
        ["trans"] = false
    }
    return v9
end
function u6.RapidThrust(p10, p11) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local u14 = u2["Stats" .. u1.Name]
    if v12.spin == false and _G.check:inspect(u13) == true then
        local v15 = u3.GetM("Rapid Thrust")
        local v16 = v15.cd
        if _G.StamCheck("Rapid Thrust") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        local v17 = u13.Humanoid.Animator:LoadAnimation(script.windup)
        v17:Play()
        v17:AdjustWeight(2)
        v12.spin = true
        _G.canuse = false
        u13.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v17, 0.5, 1.5)
        v17:Stop()
        local u18 = u13.Humanoid.Animator:LoadAnimation(script.loop)
        u18:Play()
        u18:AdjustSpeed(1)
        local v19 = game.ReplicatedStorage.Events.Skill:InvokeServer("Rapid Thrust")
        local u20 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 64 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u18
                --]]
                if _G.check:inspect(u13) == false then
                    u18:Stop()
                    return true
                end
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 73 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u20
                    [3] = u14
                --]]
                if not u13:FindFirstChild("Golden Staff") or (tick() - u20 >= 1 or (u13:FindFirstChild("Stun") or u14.Stamina.Value <= 0)) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u13.Humanoid.WalkSpeed = 16
        if v19 then
            v19:FireServer()
        end
        u18:Stop()
        _G.keysetup:cooldown("Rapid Thrust", v16)
        task.wait(0.5)
        _G.canuse = true
        _G.fw(v16)
        v12.spin = false
    end
end
function u6.GoldenSweep(p21, p22) --[[ Line: 101 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v23 = p21.Cooldowns
    local u24 = u1.Character
    local u25 = u2["Stats" .. u1.Name]
    if v23.sweep == false and _G.check:inspect(u24) == true then
        local v26 = u3.GetM("Golden Sweep")
        local v27 = v26.cd
        if _G.StamCheck("Golden Sweep") == false then
            return
        end
        if v26.statreq and _G.MeetReq(v26.statreq) == false then
            return
        end
        local v28 = u24.Humanoid.Animator:LoadAnimation(script.sweepwind)
        v28:Play()
        v28:AdjustWeight(2)
        v23.sweep = true
        _G.canuse = false
        u24.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v28, 0.6, 1.2)
        v28:Stop()
        local u29 = u24.Humanoid.Animator:LoadAnimation(script.sweeploop)
        u29:Play()
        u29:AdjustSpeed(1)
        local v30 = game.ReplicatedStorage.Events.Skill:InvokeServer("Golden Sweep")
        local u31 = tick()
        p21:ChargeSkill(p22, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 132 ]]
                --[[
                Upvalues:
                    [1] = u24
                    [2] = u29
                --]]
                if _G.check:inspect(u24) == false then
                    u29:Stop()
                    return true
                end
                u24.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 141 ]]
                --[[
                Upvalues:
                    [1] = u24
                    [2] = u31
                    [3] = u25
                --]]
                if not u24:FindFirstChild("Golden Staff") or (tick() - u31 >= 4 or (u24:FindFirstChild("Stun") or u25.Stamina.Value <= 0)) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u24.Humanoid.WalkSpeed = 16
        if v30 then
            v30:FireServer()
        end
        _G.keysetup:cooldown("Golden Sweep", v27)
        u29:Stop()
        task.wait(0.5)
        _G.canuse = true
        _G.fw(v27)
        v23.sweep = false
    end
end
function u6.PoleCounter(p32) --[[ Line: 178 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v33 = p32.Cooldowns
    local v34 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v33.counter == false and _G.check:inspect(v34) == true then
        local v35 = u3.GetM("Pole Counter")
        local v36 = v35.cd
        if _G.StamCheck("Pole Counter") == false then
            return
        end
        if v35.statreq and _G.MeetReq(v35.statreq) == false then
            return
        end
        v33.counter = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Pole Counter")
        local v37 = tick()
        local v38 = false
        while true do
            v34.Humanoid.WalkSpeed = 0
            v34.Humanoid.Jump = false
            if v34:FindFirstChild("counter") then
                v38 = true
                break
            end
            game["Run Service"].RenderStepped:Wait()
            if tick() - v37 >= 2 then
                break
            end
        end
        if v38 == true then
            task.wait(0.7)
        end
        v34.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Pole Counter", v36)
        _G.fw(v36)
        v33.counter = false
    end
end
function u6.GoldenStaffTransform(p39) --[[ Line: 221 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v40 = p39.Cooldowns
    local v41 = u1.Character
    local v42 = u2["Stats" .. u1.Name]
    if v40.trans == false and _G.check:inspect(v41) == true then
        local v43 = u3.GetM("Golden Staff Transform")
        local v44 = v43.cd
        if _G.StamCheck("Golden Staff Transform") == false then
            return
        end
        if v43.statreq and _G.MeetReq(v43.statreq) == false then
            return
        end
        if v42.Stats.DF.Value ~= "Goro-Goro" and (v42.Stats.DF.Value ~= "Goru-Goru" and v42.Customization.Race.Value:match("mink") == nil) then
            return
        end
        v40.trans = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Golden Staff Transform")
        v41:FindFirstChild("Golden StaffSword")
        v41.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Golden Staff Transform", v44)
        _G.fw(v44)
        v40.trans = false
    end
end
return u6