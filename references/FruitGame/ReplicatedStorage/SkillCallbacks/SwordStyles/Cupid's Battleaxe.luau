 

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
u6["Getoverhere!"] = function(p10, _) --[[ Line: 28 ]]
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
        local v13 = u3.GetM("Get over here!")
        local v14 = v13.cd
        if _G.StamCheck("Get over here!") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v11.spin = true
        _G.canuse = false
        local v15 = v12.Humanoid.Animator:LoadAnimation(script.grab)
        v15:Play()
        v15:AdjustSpeed(1.4)
        v15:AdjustWeight(2)
        v12.Humanoid.WalkSpeed = 4
        local v16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Get over here!", {
            ["cf"] = p10:GetMouseCFrame()
        })
        task.wait(0.28571428571428575)
        if v16 then
            v16:FireServer()
        end
        task.wait(0.2)
        v12.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Get over here!", v14)
        _G.fw(v14)
        v11.spin = false
    end
end
function u6.Decimation(p17, _) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v18 = p17.Cooldowns
    local v19 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v18.blessing == false and _G.check:inspect(v19) == true then
        local v20 = u3.GetM("Decimation")
        local v21 = v20.cd
        if _G.StamCheck("Decimation") == false then
            return
        end
        if v20.statreq and _G.MeetReq(v20.statreq) == false then
            return
        end
        _G.canuse = false
        v18.blessing = true
        local v22 = v19.Humanoid.Animator:LoadAnimation(script.spin)
        v22:Play()
        v22:AdjustWeight(2)
        v22:AdjustSpeed(1.25)
        v19.Humanoid.WalkSpeed = 4
        local v23 = game.ReplicatedStorage.Events.Skill:InvokeServer("Decimation")
        task.wait(0.4)
        if v23 then
            v23:FireServer()
        end
        task.wait(0.75)
        v19.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Decimation", v21)
        _G.fw(v21)
        v18.blessing = false
    end
end
return u6