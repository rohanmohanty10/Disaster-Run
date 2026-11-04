 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
function u5.new(_) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["aoeHeal"] = false,
        ["support"] = false,
        ["orb"] = false
    }
    return v8
end
function u5.HealingField(p9, _) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v10 = p9.Cooldowns
    local v11 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v10.aoeHeal == false and (_G.check:inspect(v11) == true and _G.StamCheck("Healing Field") == true) then
        local v12 = u3.GetM("Healing Field")
        local v13 = v12.cd
        if _G.StamCheck("Healing Field") == false then
            return
        end
        if v12.statreq and _G.MeetReq(v12.statreq) == false then
            return
        end
        v10.aoeHeal = true
        _G.canuse = false
        local v14 = v11.Humanoid:LoadAnimation(script.ult)
        v14:Play()
        v14:AdjustWeight(2)
        task.wait(0.4)
        if game.ReplicatedStorage.Events.Skill:InvokeServer("Healing Field", v11.PrimaryPart.CFrame) then
            task.wait(2.25)
        end
        _G.canuse = true
        _G.keysetup:cooldown("Healing Field", v13)
        _G.fw(v13)
        v10.aoeHeal = false
    end
end
function u5.HealingSupport(p15, _) --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v16 = p15.Cooldowns
    local v17 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v16.support == false and (_G.check:inspect(v17) == true and _G.StamCheck("Healing Support") == true) then
        local v18 = u3.GetM("Healing Support")
        local v19 = v18.cd
        if _G.StamCheck("Healing Support") == false then
            return
        end
        if v18.statreq and _G.MeetReq(v18.statreq) == false then
            return
        end
        v16.support = true
        _G.canuse = false
        local v20 = v17.Humanoid:LoadAnimation(script.orbHeal)
        v20:Play()
        v20:AdjustWeight(2)
        if game.ReplicatedStorage.Events.Skill:InvokeServer("Healing Support", v17.PrimaryPart.CFrame) then
            task.wait(2.25)
        end
        _G.canuse = true
        _G.keysetup:cooldown("Healing Support", v19)
        _G.fw(v19)
        v16.support = false
    end
end
function u5.HealingOrb(p21, _) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v22 = p21.Cooldowns
    local v23 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v22.orb == false and (_G.check:inspect(v23) == true and _G.StamCheck("Healing Orb") == true) then
        local v24 = u3.GetM("Healing Orb")
        local v25 = v24.cd
        if _G.StamCheck("Healing Orb") == false then
            return
        end
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        v22.orb = true
        _G.canuse = false
        local v26 = v23.Humanoid:LoadAnimation(script.orb)
        v26:Play()
        v26:AdjustSpeed(1.5)
        v26:AdjustWeight(2)
        task.wait(0.2)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Healing Orb", p21:GetMouseCFrame())
        _G.canuse = true
        _G.keysetup:cooldown("Healing Orb", v25)
        _G.fw(v25)
        v22.orb = false
    end
end
return u5