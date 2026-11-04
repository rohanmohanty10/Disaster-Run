 

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
        ["smash"] = false
    }
    return v9
end
function u6.KiribachiFrenzy(p10, p11) --[[ Line: 31 ]]
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
        local v15 = u3.GetM("Kiribachi Frenzy")
        local v16 = v15.cd
        if _G.StamCheck("Kiribachi Frenzy") == false then
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
        _G.PauseAnim(v17, 0.4, 1)
        v17:Stop()
        local u18 = u13.Humanoid.Animator:LoadAnimation(script.loop)
        u18:Play()
        u18:AdjustSpeed(1)
        local v19 = game.ReplicatedStorage.Events.Skill:InvokeServer("Kiribachi Frenzy")
        local u20 = tick()
        local u21 = Instance.new("BodyVelocity", u13.HumanoidRootPart)
        u21.MaxForce = Vector3.new(1000000, 0, 1000000)
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 63 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u18
                    [3] = u21
                --]]
                if _G.check:inspect(u13) == false then
                    u18:Stop()
                    return true
                end
                u21.Velocity = u13.HumanoidRootPart.CFrame.LookVector * 30
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 72 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u20
                    [3] = u14
                --]]
                if not u13:FindFirstChild("Kiribachi") or (tick() - u20 >= 3 or (u13:FindFirstChild("Stun") or u14.Stamina.Value <= 0)) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u21:Destroy()
        u18:Stop()
        if v19 then
            v19:FireServer()
        end
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Kiribachi Frenzy", v16)
        _G.fw(v16)
        v12.spin = false
    end
end
function u6.KiribachiSmash(p22, p23) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v24 = p22.Cooldowns
    local u25 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v24.smash == false and _G.check:inspect(u25) == true then
        local v26 = u3.GetM("Kiribachi Smash")
        local v27 = v26.cd
        if _G.StamCheck("Kiribachi Smash") == false then
            return
        end
        if v26.statreq and _G.MeetReq(v26.statreq) == false then
            return
        end
        local u28 = u25.Humanoid.Animator:LoadAnimation(script.smash)
        u28:Play()
        u28:AdjustWeight(2)
        u25.Humanoid.WalkSpeed = 4
        v24.smash = true
        _G.canuse = false
        local v29 = game.ReplicatedStorage.Events.Skill:InvokeServer("Kiribachi Smash")
        _G.PauseAnim(u28, 0.5, 1)
        p22:ChargeSkill(p23, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 125 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u28
                --]]
                if _G.check:inspect(u25) == false then
                    u28:Stop()
                    return true
                end
                u25.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 133 ]]
                --[[
                Upvalues:
                    [1] = u25
                --]]
                if not u25:FindFirstChild("Kiribachi") then
                    return true
                end
            end
        })
        u28:AdjustSpeed(1)
        if v29 then
            v29:FireServer()
        end
        task.wait(0.15)
        u25.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Kiribachi Smash", v27)
        _G.fw(v27)
        v24.smash = false
    end
end
return u6