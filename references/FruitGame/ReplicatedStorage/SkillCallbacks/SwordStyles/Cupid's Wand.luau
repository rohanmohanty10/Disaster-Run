 

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
        ["blessing"] = false
    }
    return v9
end
u6["Cupid\'sWrath"] = function(p10, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.Cooldowns
    local v12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11.spin == false and _G.check:inspect(v12) == true then
        local v13 = u3.GetM("Cupid\'s Wrath")
        local v14 = v13.cd
        if _G.StamCheck("Cupid\'s Wrath") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v11.spin = true
        _G.canuse = false
        local v15 = v12.Humanoid.Animator:LoadAnimation(script.cloudSummon)
        v15:Play()
        v15:AdjustWeight(2)
        v12.Humanoid.WalkSpeed = 4
        task.wait(0.5)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Cupid\'s Wrath", {
            ["cf"] = p10:GetMouseCFrame()
        })
        task.wait(0.4)
        v12.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Cupid\'s Wrath", v14)
        _G.fw(v14)
        v11.spin = false
    end
end
u6["Cupid\'sBlessing"] = function(p16, _) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v17 = p16.Cooldowns
    local v18 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v17.blessing == false and _G.check:inspect(v18) == true then
        local v19 = u3.GetM("Cupid\'s Blessing")
        local v20 = v19.cd
        if _G.StamCheck("Cupid\'s Blessing") == false then
            return
        end
        if v19.statreq and _G.MeetReq(v19.statreq) == false then
            return
        end
        _G.canuse = false
        v17.blessing = true
        local v21 = v18.Humanoid.Animator:LoadAnimation(script.heal)
        v21:Play()
        v21:AdjustWeight(2)
        v18.Humanoid.WalkSpeed = 4
        local v22 = game.ReplicatedStorage.Events.Skill:InvokeServer("Cupid\'s Blessing")
        task.wait(0.4)
        if v22 then
            v22:FireServer()
        end
        task.wait(0.25)
        v18.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Cupid\'s Blessing", v20)
        _G.fw(v20)
        v17.blessing = false
    end
end
return u6