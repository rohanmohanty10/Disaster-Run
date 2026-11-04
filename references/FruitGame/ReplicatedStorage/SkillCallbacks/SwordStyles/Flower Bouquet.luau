 

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
        ["Smell"] = false,
        ["Wave"] = false
    }
    return v9
end
function u6.FlowerSmell(p10, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.Cooldowns
    local v12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11.Smell == false and _G.check:inspect(v12) == true then
        local v13 = u3.GetM("Flower Smell")
        local v14 = v13.cd
        if _G.StamCheck("Flower Smell") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        _G.canuse = false
        v11.Smell = true
        local v15 = v12.Humanoid.Animator:LoadAnimation(script.smell)
        v15:Play()
        v15:AdjustWeight(2)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Flower Smell")
        _G.canuse = true
        _G.keysetup:cooldown("Flower Smell", v14)
        _G.fw(v14)
        v11.Smell = false
    end
end
function u6.FlowerCharm(p16, _) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v17 = p16.Cooldowns
    local v18 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v17.Wave == false and _G.check:inspect(v18) == true then
        local v19 = u3.GetM("Flower Charm")
        local v20 = v19.cd
        if _G.StamCheck("Flower Charm") == false then
            return
        end
        if v19.statreq and _G.MeetReq(v19.statreq) == false then
            return
        end
        _G.canuse = false
        v17.Wave = true
        local v21 = v18.Humanoid.Animator:LoadAnimation(script.wave)
        v21:Play()
        v21:AdjustWeight(2)
        v18.Humanoid.WalkSpeed = 4
        local v22 = tick()
        game.ReplicatedStorage.Events.Skill:InvokeServer("Flower Charm")
        repeat
            game["Run Service"].Heartbeat:Wait()
            v18.Humanoid.WalkSpeed = 4
        until tick() - v22 >= 2.75
        v18.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Flower Charm", v20)
        _G.fw(v20)
        v17.Wave = false
    end
end
return u6