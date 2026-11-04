 

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
        ["smash"] = false,
        ["pound"] = false
    }
    return v9
end
function u6.EloSmash(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.smash == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Elo Smash")
        local v15 = v14.cd
        if _G.StamCheck("Elo Smash") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local u16 = u13.Humanoid.Animator:LoadAnimation(script.smash)
        u16:Play()
        u16:AdjustWeight(2)
        u13.Humanoid.WalkSpeed = 4
        v12.smash = true
        _G.canuse = false
        _G.PauseAnim(u16, 0.35, 1)
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 52 ]]
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
            ["EndFunction"] = function() --[[ Name: endFunction, Line 61 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                if u13:FindFirstChild(script.Name) == nil then
                    return true
                end
            end
        })
        u16:AdjustSpeed(1)
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Elo Smash")
        task.wait(0.15)
        if v17 then
            if u13:FindFirstChild("Elo\'s SledgehammerSword") then
                local _ = u13:FindFirstChild("Elo\'s SledgehammerSword").Blade.CFrame
            else
                local _ = u13.HumanoidRootPart.CFrame
            end
            v17:FireServer({
                ["cf"] = u13.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7)
            })
        end
        task.wait(0.15)
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Elo Smash", v15)
        _G.fw(v15)
        v12.smash = false
    end
end
function u6.PoundingFestival(p18, p19) --[[ Line: 96 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v20 = p18.Cooldowns
    local u21 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v20.pound == false and _G.check:inspect(u21) == true then
        local v22 = u3.GetM("Pounding Festival")
        local v23 = v22.cd
        if _G.StamCheck("Pounding Festival") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        local u24 = u21.Humanoid.Animator:LoadAnimation(script.pound)
        u24:Play()
        u24:AdjustWeight(2)
        u21.Humanoid.WalkSpeed = 4
        v20.pound = true
        _G.canuse = false
        _G.PauseAnim(u24, 0.25, 1)
        p18:ChargeSkill(p19, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 120 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u24
                --]]
                if _G.check:inspect(u21) == false then
                    u24:Stop()
                    return true
                end
                u21.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 129 ]]
                --[[
                Upvalues:
                    [1] = u21
                --]]
                if u21:FindFirstChild(script.Name) == nil then
                    return true
                end
            end
        })
        u24:AdjustSpeed(1)
        local v25 = Instance.new("BodyVelocity")
        v25.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        v25.Velocity = u21.HumanoidRootPart.CFrame.LookVector * 25
        v25.Parent = u21.HumanoidRootPart
        _G.destroy(v25, 0.25)
        task.wait(0.22499999999999998)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Pounding Festival", {
            ["cf"] = u21.HumanoidRootPart.CFrame
        })
        task.wait(0.15)
        u21.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Pounding Festival", v23)
        _G.fw(v23)
        v20.pound = false
    end
end
return u6