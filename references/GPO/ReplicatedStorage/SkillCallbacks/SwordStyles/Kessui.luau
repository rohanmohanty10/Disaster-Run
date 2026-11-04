 

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
        ["sweep"] = false
    }
    return v9
end
function u6.KessuiBarrage(p10, p11) --[[ Line: 28 ]]
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
        local v14 = u3.GetM("Kessui Barrage")
        local v15 = v14.cd
        if _G.StamCheck("Kessui Barrage") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local v16 = u13.Humanoid.Animator:LoadAnimation(script.Anims.Startup)
        v16:Play()
        v12.spin = true
        _G.canuse = false
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Kessui Barrage")
        _G.PauseAnim(v16, 0.8, 1)
        v16:Stop()
        local v18 = u13.Humanoid.Animator:LoadAnimation(script.Anims.Loop)
        v18:Play()
        v18:AdjustWeight(2)
        v18.Priority = Enum.AnimationPriority.Action4
        local u19 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 58 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 63 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u19
                --]]
                if u13:FindFirstChild(script.Name) == nil or tick() - u19 >= 2 then
                    return true
                end
                if _G.check:inspect(u13) == false then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if v17 then
            v17:FireServer(u13.PrimaryPart.CFrame)
        end
        v18:Stop()
        local v20 = u13.Humanoid.Animator:LoadAnimation(script.Anims.Dash)
        v20:Play()
        v20:AdjustWeight(2)
        v20.Priority = Enum.AnimationPriority.Action2
        task.wait(0.4)
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Kessui Barrage", v15)
        _G.fw(v15)
        v12.spin = false
    end
end
function u6.KessuiIgnite(p21, _) --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v22 = p21.Cooldowns
    local v23 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v22.sweep == false and _G.check:inspect(v23) == true then
        local v24 = u3.GetM("Kessui Ignite")
        local v25 = v24.cd
        if _G.StamCheck("Kessui Ignite") == false then
            return
        end
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        local v26 = v23.Humanoid.Animator:LoadAnimation(script.windup)
        v26:Play()
        v26:AdjustWeight(2)
        v26:AdjustSpeed(0.75)
        v22.sweep = true
        _G.canuse = false
        v23.Humanoid.WalkSpeed = 4
        game.ReplicatedStorage.Events.Skill:InvokeServer("Kessui Ignite")
        task.wait(0.4)
        v23.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Kessui Ignite", v25)
        _G.fw(v25)
        v22.sweep = false
    end
end
return u6