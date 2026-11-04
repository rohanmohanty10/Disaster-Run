 

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
        ["pull"] = false,
        ["impale"] = false
    }
    return v9
end
function u6.PitchforkImpale(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.pull == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Pitchfork Impale")
        local v15 = v14.cd
        if _G.StamCheck("Pitchfork Impale") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local v16 = u13.Humanoid.Animator:LoadAnimation(script.pull)
        v16:Play()
        v16:AdjustWeight(2)
        v12.pull = true
        _G.canuse = false
        u13.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v16, 0.12, 0.75)
        local u17 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 55 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                if _G.check:inspect(u13) == false then
                    return true
                end
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 62 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u13
                --]]
                if tick() - u17 >= 6 or u13:FindFirstChild("Stun") then
                    return true
                end
            end
        })
        v16:AdjustSpeed(1)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Pitchfork Impale", u13.PrimaryPart.CFrame)
        u13.Humanoid.WalkSpeed = 16
        task.wait(0.2)
        _G.canuse = true
        _G.keysetup:cooldown("Pitchfork Impale", v15)
        _G.fw(v15)
        v12.pull = false
    end
end
function u6.PitchforkDance(p18, p19) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v20 = p18.Cooldowns
    local u21 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v20.impale == false and _G.check:inspect(u21) == true then
        local v22 = u3.GetM("Pitchfork Dance")
        local v23 = v22.cd
        if _G.StamCheck("Pitchfork Dance") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        local v24 = u21.Humanoid.Animator:LoadAnimation(script.windup)
        v24:Play()
        v24:AdjustWeight(2)
        v20.impale = true
        _G.canuse = false
        u21.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v24, 0.25, 0.75)
        v24:Stop()
        local u25 = game.ReplicatedStorage.Events.Skill:InvokeServer("Pitchfork Dance", {
            ["cf"] = u21.HumanoidRootPart.CFrame
        })
        local v26 = u21.Humanoid.Animator:LoadAnimation(script.loop)
        v26:Play()
        v26:AdjustWeight(2)
        v26:AdjustSpeed(2)
        local u27 = tick()
        p18:ChargeSkill(p19, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 117 ]]
                --[[
                Upvalues:
                    [1] = u21
                --]]
                if _G.check:inspect(u21) == false then
                    return true
                end
                u21.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 124 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u21
                    [3] = u27
                --]]
                if u25 == nil or (u21:FindFirstChild(script.Name) == nil or (tick() - u27 >= 2 or u21:FindFirstChild("Stun"))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v26:Stop()
        if u25 then
            u25:FireServer()
        end
        task.wait(0.45)
        u21.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Pitchfork Dance", v23)
        _G.fw(v23)
        v20.impale = false
    end
end
return u6