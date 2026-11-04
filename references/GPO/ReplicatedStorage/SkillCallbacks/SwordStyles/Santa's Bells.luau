 

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
        ["jug"] = false
    }
    return v9
end
function u6.HealingRhyme(p10, _) --[[ Line: 28 ]]
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
        local v13 = u3.GetM("Healing Rhyme")
        local v14 = v13.cd
        if _G.StamCheck("Healing Rhyme") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        local v15 = v12.Humanoid.Animator:LoadAnimation(script.heal)
        v15:Play()
        v15:AdjustWeight(2)
        v11.heal = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Healing Rhyme")
        _G.canuse = true
        _G.keysetup:cooldown("Healing Rhyme", v14)
        _G.fw(v14)
        v11.heal = false
    end
end
return u6