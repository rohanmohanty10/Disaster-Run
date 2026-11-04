 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u4 = setmetatable({}, u3)
u4.__index = u4
function u4.new(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v5 = u3.new(script.Name)
    local v6 = u4
    local v7 = setmetatable(v5, v6)
    v7.Cooldowns = {
        ["jesterbox"] = false
    }
    return v7
end
function u4.JackintheBox(p8, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v9 = p8.Cooldowns
    local v10 = u1.Character
    if v9.jesterbox == false and (_G.check:inspect(v10) == true and _G.StamCheck("Jack in the Box") == true) then
        local v11 = u2.GetM("Jack in the Box")
        local v12 = v11.cd
        if _G.StamCheck("Jack in the Box") == false then
            return
        end
        if v11.statreq and _G.MeetReq(v11.statreq) == false then
            return
        end
        v9.jesterbox = true
        _G.canuse = false
        local v13 = v10.Humanoid:LoadAnimation(script.PLACE)
        v13:Play()
        v13:AdjustWeight(2)
        v10.Humanoid.WalkSpeed = 2
        task.wait(0.4)
        local v14 = v10.PrimaryPart.CFrame
        if p8.Tool then
            v14 = p8.Tool.JesterBox.PrimaryPart.CFrame
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Jack in the Box", v14)
        task.wait(0.25)
        v10.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Jack in the Box", v12)
        _G.fw(v12)
        v9.jesterbox = false
    end
end
return u4