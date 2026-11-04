 

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
        ["frenzy"] = false
    }
    return v9
end
function u6.GravityField(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.spin == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Gravity Field")
        local v15 = v14.cd
        if _G.StamCheck("Gravity Field") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v12.spin = true
        _G.canuse = false
        _G.FaceMouse = true
        local v16 = u13.Humanoid.Animator:LoadAnimation(script.field)
        v16:Play()
        v16:AdjustWeight(4)
        _G.PauseAnim(v16, 0.4, 1)
        local u17 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 53 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 57 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u17
                --]]
                if u13:FindFirstChild(script.Name) == nil or tick() - u17 >= 3 then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        u13.HumanoidRootPart.Anchored = true
        v16:AdjustSpeed(1)
        task.wait(0.1)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Gravity Field", {
            ["cf"] = p10:GetMouseCFrame()
        })
        task.wait(0.2)
        u13.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Gravity Field", v15)
        _G.fw(v15)
        v12.spin = false
    end
end
function u6.GravityFrenzy(p18, p19) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v20 = p18.Cooldowns
    local u21 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v20.frenzy == false and _G.check:inspect(u21) == true then
        local v22 = u3.GetM("Gravity Frenzy")
        local v23 = v22.cd
        if _G.StamCheck("Gravity Frenzy") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        local v24 = u21.Humanoid.Animator:LoadAnimation(script.windup)
        v24:Play()
        v24:AdjustSpeed(0.75)
        u21.Humanoid.WalkSpeed = 4
        v20.frenzy = true
        _G.canuse = false
        task.wait(0.75)
        v24:Stop()
        local u25 = u21.Humanoid.Animator:LoadAnimation(script.loop)
        u25:Play()
        u25:AdjustWeight(2)
        local v26 = game.ReplicatedStorage.Events.Skill:InvokeServer("Gravity Frenzy", {
            ["cf"] = p18:GetMouseCFrame()
        })
        local u27 = tick()
        p18:ChargeSkill(p19, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 115 ]]
                --[[
                Upvalues:
                    [1] = u21
                --]]
                u21.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 121 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u27
                    [3] = u25
                --]]
                if u21:FindFirstChild(script.Name) == nil or tick() - u27 >= 4 then
                    return true
                end
                if _G.check:inspect(u21) == false then
                    u25:Stop()
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u25:Stop()
        if v26 then
            v26:InvokeServer()
        end
        task.wait(0.2)
        u21.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Gravity Frenzy", v23)
        _G.fw(v23)
        v20.frenzy = false
    end
end
return u6