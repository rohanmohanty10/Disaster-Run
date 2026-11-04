 

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
        ["heal"] = false,
        ["freeze"] = false
    }
    return v9
end
function u6.SweetTreat(p10, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.Cooldowns
    local v12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11.heal == false and _G.check:inspect(v12) == true then
        local v13 = u3.GetM("Sweet Treat")
        local v14 = v13.cd
        if _G.StamCheck("Sweet Treat") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        _G.canuse = false
        v11.heal = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Sweet Treat")
        _G.canuse = true
        _G.keysetup:cooldown("Sweet Treat", v14)
        _G.fw(v14)
        v11.heal = false
    end
end
function u6.FlashFreeze(p15, p16) --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v17 = p15.Cooldowns
    local u18 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v17.freeze == false and _G.check:inspect(u18) == true then
        local v19 = u3.GetM("Flash Freeze")
        local v20 = v19.cd
        if _G.StamCheck("Flash Freeze") == false then
            return
        end
        if v19.statreq and _G.MeetReq(v19.statreq) == false then
            return
        end
        _G.canuse = false
        local u21 = u18.Humanoid.Animator:LoadAnimation(script.freeze)
        u21:Play()
        u21:AdjustWeight(2)
        u18.Humanoid.WalkSpeed = 4
        _G.PauseAnim(u21, 0.4, 1)
        v17.freeze = true
        p15:ChargeSkill(p16, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 76 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u21
                --]]
                if _G.check:inspect(u18) == false then
                    u21:Stop()
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 83 ]]
                --[[
                Upvalues:
                    [1] = u18
                --]]
                if u18:FindFirstChild(script.Name) == nil then
                    return true
                end
            end
        })
        u21:AdjustSpeed(1)
        task.wait(0.2)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Flash Freeze")
        task.wait(0.2)
        u18.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Flash Freeze", v20)
        _G.fw(v20)
        v17.freeze = false
    end
end
return u6