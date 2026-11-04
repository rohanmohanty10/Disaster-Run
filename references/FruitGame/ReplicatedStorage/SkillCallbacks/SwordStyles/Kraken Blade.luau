 

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
function u6.new(_, p7) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
    --]]
    local v8 = u4.new()
    local v9 = u6
    local v10 = setmetatable(v8, v9)
    v10.Tool = p7
    v10.Cooldowns = {
        ["throw"] = false,
        ["ground"] = false
    }
    return v10
end
function u6.SlayerCrossSlash(u11, p12) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v13 = u11.Cooldowns
    local u14 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v13.throw == false and _G.check:inspect(u14) == true then
        local v15 = u3.GetM("Slayer Cross Slash")
        local v16 = v15.cd
        if _G.StamCheck("Slayer Cross Slash") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        local v17 = u14.Humanoid.Animator:LoadAnimation(script.throw)
        v17:Play()
        v17:AdjustWeight(2)
        v13.throw = true
        _G.canuse = false
        u14.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v17, 0.25, 2)
        local v18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Slayer Cross Slash")
        local u19 = tick()
        u11:ChargeSkill(p12, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 55 ]]
                --[[
                Upvalues:
                    [1] = u14
                --]]
                u14.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 60 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u14
                    [3] = u19
                --]]
                if u11.Tool.Parent ~= u14 or tick() - u19 >= 10 then
                    return true
                end
            end
        })
        v17:AdjustSpeed(1)
        task.wait(0.245)
        if v18 then
            if _G.check:inspect(u14) == true then
                v18:FireServer()
            else
                v18:FireServer("cancel")
            end
        end
        u14.Humanoid.WalkSpeed = 4
        task.wait(1.25)
        u14.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Slayer Cross Slash", v16)
        _G.fw(v16)
        v13.throw = false
    end
end
function u6.EternalFlow(u20, p21) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v22 = u20.Cooldowns
    local u23 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v22.ground == false and _G.check:inspect(u23) == true then
        local v24 = u3.GetM("Eternal Flow")
        local v25 = v24.cd
        if _G.StamCheck("Eternal Flow") == false then
            return
        end
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        local u26 = u23.Humanoid.Animator:LoadAnimation(script.ground)
        u26:Play()
        u26:AdjustWeight(2)
        v22.ground = true
        _G.canuse = false
        u23.Humanoid.WalkSpeed = 4
        local v27 = game.ReplicatedStorage.Events.Skill:InvokeServer("Eternal Flow")
        _G.PauseAnim(u26, 0.7, 1)
        local u28 = tick()
        u20:ChargeSkill(p21, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 123 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u26
                --]]
                if _G.check:inspect(u23) == false then
                    u26:Stop()
                    return true
                end
                u23.Humanoid.WalkSpeed = 0
                u23.Humanoid.Jump = false
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 132 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u23
                    [3] = u28
                --]]
                if u20.Tool.Parent ~= u23 or (tick() - u28 >= 5 or _G.check:inspect(u23) == false) then
                    return true
                end
            end
        })
        u26:Stop(0.25)
        if v27 then
            v27:FireServer()
        end
        task.wait(0.4)
        u23.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Eternal Flow", v25)
        _G.fw(v25)
        v22.ground = false
    end
end
return u6