
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
function u6.new(_) --[[ Line: 21 ]]
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
        ["sweep"] = false
    }
    return v9
end
function u6.ShockwaveSlash(p10, p11) --[[ Line: 29 ]]
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
        local v15 = u3.GetM("Shockwave Slash")
        local v16 = v15.cd
        if _G.StamCheck("Shockwave Slash") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        local v17 = u13.Humanoid.Animator:LoadAnimation(script.smash)
        v17:Play()
        v17:AdjustWeight(2)
        v12.spin = true
        _G.canuse = false
        _G.FaceMouse = true
        local u18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Shockwave Slash")
        _G.PauseAnim(v17, 0.4, 0.30250000000000005)
        local u19 = tick()
        local u20 = false
        local function v21() --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u19
                [3] = u18
                [4] = u20
                [5] = u14
            --]]
            if u13:FindFirstChild(script.Name) == nil or tick() - u19 >= 10 then
                return true
            end
            if u18 and (u20 == false and (u14.Stats.DF.Value == "Gura-Gura" and tick() - u19 >= 1.5)) then
                u20 = true
                u18:FireServer("charged")
            end
        end
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 55 ]] end,
            ["EndFunction"] = v21,
            ["IgnoreInstantCastSetting"] = true
        })
        _G.FaceMouse = false
        v17:AdjustSpeed(1)
        u13.HumanoidRootPart.Anchored = true
        task.wait(0.25)
        if u18 then
            u18:FireServer(u13.HumanoidRootPart.CFrame, u13:FindFirstChild("BisentoSword") and u13:FindFirstChild("BisentoSword").Blade.CFrame or u13.HumanoidRootPart.CFrame)
        end
        task.wait(0.4)
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Shockwave Slash", v16)
        _G.fw(v16)
        v12.spin = false
    end
end
function u6.HeavySweep(p22, p23) --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v24 = p22.Cooldowns
    local u25 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v24.sweep == false and _G.check:inspect(u25) == true then
        local v26 = u3.GetM("Heavy Sweep")
        local v27 = v26.cd
        if _G.StamCheck("Heavy Sweep") == false then
            return
        end
        if v26.statreq and _G.MeetReq(v26.statreq) == false then
            return
        end
        local v28 = u25.Humanoid.Animator:LoadAnimation(script.windup)
        v28:Play()
        v28:AdjustWeight(2)
        v28:AdjustSpeed(1)
        v24.sweep = true
        _G.canuse = false
        u25.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v28, 0.65, 1.38)
        v28:Stop()
        local u29 = u25.Humanoid.Animator:LoadAnimation(script.loop)
        u29:Play()
        u29:AdjustSpeed(2)
        local u30 = game.ReplicatedStorage.Events.Skill:InvokeServer("Heavy Sweep")
        local u31 = tick()
        p22:ChargeSkill(p23, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 129 ]]
                --[[
                Upvalues:
                    [1] = u25
                --]]
                u25.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 133 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u31
                    [3] = u29
                    [4] = u30
                --]]
                if u25:FindFirstChild(script.Name) == nil or tick() - u31 >= 3 then
                    return true
                end
                if u25:FindFirstChild("PB") then
                    u29:Stop()
                    if u30 then
                        u30:FireServer()
                    end
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u29:Stop()
        if u30 then
            u30:FireServer()
        end
        task.wait(0.4)
        u25.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Heavy Sweep", v27)
        _G.fw(v27)
        v24.sweep = false
    end
end
return u6