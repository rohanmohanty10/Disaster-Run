 

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
function u6.BoneFrenzy(p10, p11) --[[ Line: 28 ]]
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
        local v15 = u3.GetM("Bone Frenzy")
        local v16 = v15.cd
        if _G.StamCheck("Bone Frenzy") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        v12.spin = true
        _G.canuse = false
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Bone Frenzy")
        local v18 = u13.Humanoid.Animator:LoadAnimation(script.windup)
        v18:Play()
        _G.PauseAnim(v18, 0.5, 1.5)
        v18:Stop()
        local u19 = u13.Humanoid.Animator:LoadAnimation(script.loop)
        u19:Play(0)
        u19:AdjustSpeed(2)
        local u20 = tick()
        local u21 = Instance.new("BodyVelocity", u13.HumanoidRootPart)
        u21.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 63 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u14
                    [3] = u19
                    [4] = u21
                --]]
                if _G.check:inspect(u13) == false or u14.Stamina.Value <= 0 then
                    u19:Stop()
                    return true
                end
                u21.Velocity = u13.HumanoidRootPart.CFrame.LookVector * 35
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 72 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u20
                --]]
                if u13:FindFirstChild(script.Name) == nil or (tick() - u20 >= 3 or u13:FindFirstChild("Stun")) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u21:Destroy()
        u19:Stop()
        if v17 then
            v17:FireServer()
        end
        task.wait(0.3)
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Bone Frenzy", v16)
        _G.fw(v16)
        v12.spin = false
    end
end
function u6.RibSmash(p22, p23) --[[ Line: 100 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v24 = p22.Cooldowns
    local u25 = u1.Character
    local u26 = u2["Stats" .. u1.Name]
    if v24.smash == false and _G.check:inspect(u25) == true then
        local v27 = u3.GetM("Rib Smash")
        local v28 = v27.cd
        if _G.StamCheck("Rib Smash") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        local u29 = u25.Humanoid.Animator:LoadAnimation(script.smashStart)
        u29:Play()
        u29:AdjustWeight(2)
        v24.smash = true
        _G.canuse = false
        u25.Humanoid.WalkSpeed = 4
        local v30 = game.ReplicatedStorage.Events.Skill:InvokeServer("Rib Smash")
        _G.PauseAnim(u29, 0.325, 1)
        local u31 = tick()
        p22:ChargeSkill(p23, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 127 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u26
                    [3] = u29
                --]]
                u25.Humanoid.WalkSpeed = 4
                if _G.check:inspect(u25) == false or u26.Stamina.Value <= 0 then
                    u29:Stop()
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 136 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u31
                --]]
                if u25:FindFirstChild(script.Name) == nil or (tick() - u31 >= 3 or u25:FindFirstChild("Stun")) then
                    return true
                end
            end
        })
        u29:AdjustSpeed(1)
        if v30 then
            v30:FireServer(u25.PrimaryPart.CFrame)
        end
        task.wait(0.85)
        _G.canuse = true
        _G.keysetup:cooldown("Rib Smash", v28)
        u25.Humanoid.WalkSpeed = 16
        _G.fw(v28)
        v24.smash = false
    end
end
return u6