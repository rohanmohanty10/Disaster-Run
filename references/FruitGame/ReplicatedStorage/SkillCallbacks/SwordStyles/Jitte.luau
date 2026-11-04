 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
game:GetService("ReplicatedStorage")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
local v4 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v4:GetControls()
local u5 = setmetatable({}, u3)
u5.__index = u5
function u5.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
    --]]
    local v6 = u3.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["JitteStrike"] = false,
        ["jitteLeap"] = false
    }
    return v8
end
function u5.JitteStrike(p9, p10) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v11 = p9.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u12 = u1.Character
    if v11.JitteStrike == false and _G.check:inspect(u12) == true then
        local v13 = u2.GetM("Jitte Strike")
        local v14 = v13.cd
        if _G.StamCheck("Jitte Strike") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v11.JitteStrike = true
        _G.canuse = false
        u12.Humanoid.WalkSpeed = 4
        local v15 = u12.Humanoid.Animator:LoadAnimation(script.strikeWindup)
        v15:Play(0)
        v15:AdjustWeight(2)
        _G.PauseAnim(v15, 0.3, 1.3)
        p9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction2, Line 56 ]]
                --[[
                Upvalues:
                    [1] = u12
                --]]
                u12.Humanoid.WalkSpeed = 4
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v15:AdjustSpeed(1.3)
        task.wait(0.11538461538461538)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Jitte Strike", {
            ["cf"] = u12.HumanoidRootPart.CFrame
        })
        u12.Humanoid.WalkSpeed = 16
        u12.Humanoid.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("Jitte Strike", v14)
        _G.fw(v14)
        v11.JitteStrike = false
    end
end
function u5.JitteLeap(p16, p17) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v18 = p16.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u19 = u1.Character
    if v18.jitteLeap == false and _G.check:inspect(u19) == true then
        local v20 = u2.GetM("Jitte Leap")
        local v21 = v20.cd
        if _G.StamCheck("Jitte Leap") == false then
            return
        end
        if v20.statreq and _G.MeetReq(v20.statreq) == false then
            return
        end
        v18.jitteLeap = true
        _G.canuse = false
        u19.Humanoid.WalkSpeed = 4
        local v22 = u19.Humanoid.Animator:LoadAnimation(script.strikeWindup)
        v22:Play(0)
        v22:AdjustWeight(2)
        _G.PauseAnim(v22, 0.3, 1)
        p16:ChargeSkill(p17, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction2, Line 109 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                u19.Humanoid.WalkSpeed = 4
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v22:AdjustSpeed(1)
        if game.ReplicatedStorage:FindFirstChild("Stats" .. u1.Name).Stats.DF.Value == "Smoke-Smoke" then
            u19.Humanoid.WalkSpeed = 45
        else
            u19.Humanoid.WalkSpeed = 30
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Jitte Leap", {
            ["cf"] = u19.HumanoidRootPart.CFrame
        })
        v22:Stop(0)
        u19.Humanoid.WalkSpeed = 16
        u19.Humanoid.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("Jitte Leap", v21)
        _G.fw(v21)
        v18.jitteLeap = false
    end
end
return u5