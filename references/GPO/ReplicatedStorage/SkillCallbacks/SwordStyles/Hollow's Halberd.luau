 

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
        ["crash"] = false,
        ["sweep"] = false
    }
    return v9
end
function u6.HollowImpale(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.crash == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Hollow Impale")
        local v15 = v14.cd
        if _G.StamCheck("Hollow Impale") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local u16 = u13.Humanoid.Animator:LoadAnimation(script.smash)
        u16:Play()
        u16:AdjustSpeed(1)
        u16:AdjustWeight(2)
        v12.crash = true
        _G.canuse = false
        u13.Humanoid.WalkSpeed = 4
        _G.PauseAnim(u16, 0, 1)
        local u17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Hollow Impale")
        local u18 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 57 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u16
                --]]
                if _G.check:inspect(u13) == false then
                    u16:Stop()
                    return true
                end
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 66 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u18
                --]]
                if u13:FindFirstChild(script.Name) == nil or tick() - u18 >= 6 then
                    return true
                end
            end
        })
        u16:AdjustSpeed(2)
        local u19 = Instance.new("BodyVelocity", u13.HumanoidRootPart)
        u19.MaxForce = Vector3.new(100000, 0, 100000)
        u19.Velocity = u13.HumanoidRootPart.CFrame.LookVector * 100
        _G.destroy(u19, 0.15)
        if u17 then
            u17:FireServer("sfx")
        end
        local u20 = false
        local function v21() --[[ Line: 94 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u20
                [3] = u16
            --]]
            u19:Destroy()
            u20 = true
            u16:Stop()
        end
        _G.hitbox:start(u13, Vector3.new(8, 5, 12), 0.3, CFrame.new(0, 0, -3), function(p22) --[[ Name: hitfound, Line 87 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u13
                [3] = u17
            --]]
            u19:Destroy()
            u13.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            if u17 then
                u17:FireServer({
                    ["cf"] = u13.PrimaryPart.CFrame,
                    ["Target"] = p22.Parent
                })
            end
        end, v21)
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Hollow Impale", v15)
        _G.fw(v15)
        v12.crash = false
    end
end
function u6.HollowSweep(p23, p24) --[[ Line: 109 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v25 = p23.Cooldowns
    local u26 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v25.sweep == false and _G.check:inspect(u26) == true then
        local v27 = u3.GetM("Hollow Sweep")
        local v28 = v27.cd
        if _G.StamCheck("Hollow Sweep") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        local v29 = u26.Humanoid.Animator:LoadAnimation(script.windup)
        v29:Play()
        v29:AdjustWeight(2)
        v29:AdjustSpeed(0.75)
        v25.sweep = true
        _G.canuse = false
        u26.Humanoid.WalkSpeed = 4
        local v30 = game.ReplicatedStorage.Events.Skill:InvokeServer("Hollow Sweep")
        _G.PauseAnim(v29, 0.39, 0.667)
        v29:Stop()
        local u31 = u26.Humanoid.Animator:LoadAnimation(script.loop)
        u31:Play()
        u31:AdjustSpeed(2)
        local u32 = tick()
        p23:ChargeSkill(p24, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 142 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u31
                --]]
                if _G.check:inspect(u26) == false then
                    u31:Stop()
                    return true
                end
                u26.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 150 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u32
                --]]
                if u26:FindFirstChild(script.Name) == nil or (tick() - u32 >= 3 or _G.check:inspect(u26) == false) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u31:Stop()
        if v30 then
            v30:FireServer()
        end
        task.wait(0.4)
        u26.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Hollow Sweep", v28)
        _G.fw(v28)
        v25.sweep = false
    end
end
return u6