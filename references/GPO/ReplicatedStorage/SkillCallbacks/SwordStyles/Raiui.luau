 

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
        ["slash"] = false,
        ["flash"] = false
    }
    return v9
end
function u6.RuthlessBlade(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.slash == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Ruthless Blade")
        local v15 = v14.cd
        if _G.StamCheck("Ruthless Blade") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local v16 = u13.Humanoid.Animator:LoadAnimation(script.slash)
        v16:Play()
        v16:AdjustWeight(2)
        v16.Priority = Enum.AnimationPriority.Action4
        v12.slash = true
        _G.FaceMouse = true
        _G.canuse = false
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Ruthless Blade")
        task.wait(0.5)
        local v18 = u13.Humanoid.Animator:LoadAnimation(script.loop)
        v18:Play()
        v18:AdjustWeight(2)
        v18.Priority = Enum.AnimationPriority.Action4
        local u19 = tick()
        local function v20() --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u19
            --]]
            if u13:FindFirstChild(script.Name) == nil or tick() - u19 >= 10 then
                return true
            end
        end
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 61 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13.Humanoid.AutoRotate = false
            end,
            ["EndFunction"] = v20
        })
        v18:Stop()
        local v21 = u13.Humanoid.Animator:LoadAnimation(script.slashEnd)
        v21:Play(0)
        v21.Priority = Enum.AnimationPriority.Action4
        v21:AdjustSpeed(1)
        _G.FaceMouse = false
        u13.HumanoidRootPart.Anchored = true
        u13.Humanoid.AutoRotate = false
        if v17 then
            v17:InvokeServer(u13.PrimaryPart.CFrame)
        end
        u19 = tick()
        repeat
            u13.Humanoid.AutoRotate = false
            task.wait()
        until tick() - u19 >= 0.4
        u13.Humanoid.AutoRotate = true
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Ruthless Blade", v15)
        _G.fw(v15)
        v12.slash = false
    end
end
function u6.DragonFlash(p22, p23) --[[ Line: 111 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v24 = p22.Cooldowns
    local u25 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v24.flash == false and _G.check:inspect(u25) == true then
        local v26 = u3.GetM("Dragon Flash")
        local v27 = v26.cd
        if _G.StamCheck("Dragon Flash") == false then
            return
        end
        if v26.statreq and _G.MeetReq(v26.statreq) == false then
            return
        end
        v24.flash = true
        _G.FaceMouse = true
        _G.canuse = false
        tick()
        local v28 = u25.Humanoid.Animator:LoadAnimation(script.dragonWindup)
        v28:Play()
        v28:AdjustWeight(2)
        v28.Priority = Enum.AnimationPriority.Action4
        local v29 = game.ReplicatedStorage.Events.Skill:InvokeServer("Dragon Flash")
        task.wait(0.5)
        v28:Stop()
        local v30 = u25.Humanoid.Animator:LoadAnimation(script.dragonCharge)
        v30:Play()
        v30:AdjustWeight(2)
        v30.Priority = Enum.AnimationPriority.Action4
        local u31 = tick()
        p22:ChargeSkill(p23, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 151 ]]
                --[[
                Upvalues:
                    [1] = u25
                --]]
                u25.Humanoid.AutoRotate = false
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 156 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u31
                --]]
                if u25:FindFirstChild(script.Name) == nil or tick() - u31 >= 10 then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        u25.HumanoidRootPart.Anchored = true
        u25.Humanoid.AutoRotate = false
        v30:Stop()
        local v32 = u25.Humanoid.Animator:LoadAnimation(script.dragonFlash)
        v32:Play()
        v32:AdjustWeight(2)
        if v29 then
            v29:InvokeServer(u25.PrimaryPart.CFrame)
        end
        task.wait(0.65)
        u25.Humanoid.AutoRotate = true
        u25.HumanoidRootPart.Anchored = false
        u25.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Dragon Flash", v27)
        _G.fw(v27)
        v24.flash = false
    end
end
return u6